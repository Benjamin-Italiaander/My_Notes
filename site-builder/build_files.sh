#!/usr/bin/env bash
set -euo pipefail

OUT_ROOT=./
VARS_ROOT=./_vars

TEMPLATE='./template.html'
STYLE='./style.css'

BUILD_SCRIPT=./build_md2html.sh

# Source roots (real md lives here)
SEARCH_DIRS=( ./../Linux ./../math ./../slices_of_life ./../Misc )

is_filled_vars_file() {
  grep -qE '^[[:space:]]*[A-Za-z0-9_]+[[:space:]]*=[[:space:]]*[^[:space:]#]' "$1"
}

get_var_description() {
  local v
  v="$(grep -E '^[[:space:]]*VAR_description[[:space:]]*=' "$1" | head -n 1 | sed -E 's/^[[:space:]]*VAR_description[[:space:]]*=[[:space:]]*//')"
  v="$(printf '%s' "$v" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
  [[ -n "$v" ]] && printf '%s' "$v"
}

# Convert ./_vars/... to ./../... as requested
vars_arg_path() {
  local vf="$1"
  # normalize leading ./
  vf="${vf/#.\//./}"
  # ./_vars/... -> ./../...
  printf '%s' "${vf/#.\/_vars\//.\/..\/}"
}

# Extract KEY names from vars file
extract_keys() {
  grep -E '^[[:space:]]*[A-Za-z0-9_]+[[:space:]]*=' "$1" \
    | sed -E 's/^[[:space:]]*([A-Za-z0-9_]+)[[:space:]]*=.*/\1/' \
    | sort -u
}

: > "$BUILD_SCRIPT"
chmod +x "$BUILD_SCRIPT"
{
  echo '# Builded from here'
  echo
} >> "$BUILD_SCRIPT"

filled=0
generated=0
skipped_not_found=0
skipped_no_desc=0

while IFS= read -r -d '' vf; do
  is_filled_vars_file "$vf" || continue
  ((filled++)) || true

  desc="$(get_var_description "$vf" || true)"
  if [[ -z "${desc:-}" ]]; then
    echo "SKIP (no VAR_description filled): $vf" >&2
    ((skipped_no_desc++)) || true
    continue
  fi

  # Relative path under _vars, without extension
  rel="${vf#"$VARS_ROOT"/}"            # e.g. Linux/yubikey/EN_yubikey_ssh.vars
  rel="${rel#./}"                      # safety
  rel_noext="${rel%.vars}"
  rel_noext="${rel_noext%.var}"

  # Candidate md path by mirroring: ../ + rel_noext + .md
  md_candidate="./../$rel_noext.md"

  md=""
  if [[ -f "$md_candidate" ]]; then
    md="$md_candidate"
  else
    # Fallback: search by filename in source dirs
    name="$(basename "$rel_noext").md"
    matches=()
    for d in "${SEARCH_DIRS[@]}"; do
      [[ -d "$d" ]] || continue
      while IFS= read -r -d '' m; do matches+=("$m"); done < <(find "$d" -type f -name "$name" -print0)
    done

    if (( ${#matches[@]} == 1 )); then
      md="${matches[0]}"
    else
      echo "SKIP (md not found for vars file): $vf" >&2
      [[ ${#matches[@]} -gt 1 ]] && printf '  multiple matches:\n  %s\n' "${matches[@]}" >&2
      ((skipped_not_found++)) || true
      continue
    fi
  fi

  # Output dir mirrors md path but under _site and WITHOUT ../
  md_clean="${md#./../}"               # strip leading ../
  md_clean="${md_clean#../}"           # strip leading ../ if present
  echo $md_clean
  out_dir="$OUT_ROOT/${md_clean%.md}"
  echo $out_dir
  out_html="$out_dir/index.html"

  mkdir -p "$out_dir"

  # variable names (some md2html want these; keep them)
  mapfile -t keys < <(extract_keys "$vf")
  var_arg="${keys[*]}"

  vf_arg="$(vars_arg_path "$vf")"
  {
    echo "mkdir -p $out_dir"
    echo "md2html   $md \\"
    echo "        $out_html \\"
    echo '        "'$desc'"'"  \\"
    echo "        $TEMPLATE \\"
    echo "        $STYLE \\"
    echo "        . "
    echo "          "
  } >> "$BUILD_SCRIPT"

  ((generated++)) || true
done < <(find "$VARS_ROOT" -type f \( -name '*.vars' -o -name '*.var' \) -print0)

echo "Filled vars files:     $filled"
echo "Commands generated:    $generated"
echo "Skipped (md not found):$skipped_not_found"
echo "Skipped (no desc):     $skipped_no_desc"
echo "Build script:          $BUILD_SCRIPT"



# Build main page including the site index
echo 'cp ./../slices_of_life/README.md ./index.md' >> ./build_md2html.sh 
echo './site-index.sh' >> ./build_md2html.sh
echo 'md2html  ./index.md ./index.html  "Benjamin Italiaander" ./template.html ./style.css . ' >> ./build_md2html.sh

cat  build-site.sh_cat > ./build-site.sh
cat build_md2html.sh >> ./build-site.sh
chmod +x ./build-site.sh
./build-site.sh



