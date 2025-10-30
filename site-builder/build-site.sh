#!/usr/bin/env bash

# ---------- helpers: abspath + relpath (pure bash) ----------
abspath() {
  local p="$1"
  if [[ -d "$p" ]]; then ( cd "$p" && pwd -P )
  else ( cd "$(dirname "$p")" && printf '%s/%s\n' "$(pwd -P)" "$(basename "$p")" )
  fi
}

relpath() {
  # usage: relpath TARGET BASEDIR
  local target base common up rest
  target="$(abspath "$1")"
  base="$(abspath "$2")"
  common="$base"; up=""
  while [[ "${target#"$common"/}" == "$target" && "$common" != "/" ]]; do
    common="${common%/*}"; up="../$up"
  done
  [[ -z "$common" ]] && common="/"
  rest="${target#"$common"/}"
  printf '%s%s\n' "$up" "$rest"
}

# ---------- main: md → html with auto-breadcrumbs and Home link ----------
md2html() {
  # Usage:
  #   md2html INPUT.md OUTPUT.html "TITLE" TEMPLATE.html STYLE.css SITE_ROOT
  #
  # Example:
  #   md2html ./../slices_of_life/art_i_enjoy/README.md \
  #           ./art_i_enjoy/index.html \
  #           "Benjamin Loves Art" \
  #           template.html \
  #           ./style.css \
  #           .

  local input="$1"
  local output="$2"
  local title="$3"
  local template="$4"
  local stylesheet="$5"
  local site_root="${6:-.}"

  [[ -z "$input" || ! -f "$input" ]] && { echo "Error: input '$input' not found" >&2; return 1; }
  [[ -z "$output" ]] && { echo "Error: output path required" >&2; return 1; }
  [[ -z "$template" || ! -f "$template" ]] && { echo "Error: template '$template' not found" >&2; return 1; }

  local out_dir; out_dir="$(dirname "$output")"
  mkdir -p "$out_dir" || return 1

  local render_date; render_date="$(date '+%Y %B %d')"
  local args=(-s -o "$output" --template "$template" -M "date=$render_date")
  [[ -n "$title" ]] && args+=(-M "title=$title")

  # ---- stylesheet: compute relative path to output dir ----
  if [[ -n "$stylesheet" && -f "$stylesheet" ]]; then
    local rel_style; rel_style="$(relpath "$stylesheet" "$out_dir")"
    args+=(-c "$rel_style")
    echo " • stylesheet:  $rel_style"
  fi

  # ---- breadcrumbs: auto-generate from output path relative to site_root ----
  local root_abs; root_abs="$(abspath "$site_root")"
  local out_abs;  out_abs="$(abspath "$out_dir")"
  local rel_from_root="${out_abs#"$root_abs"/}"

  local crumbs_html=""
  if [[ -n "$rel_from_root" && "$rel_from_root" != "$out_abs" ]]; then
    IFS='/' read -r -a parts <<< "$rel_from_root"
    local acc=""
    for i in "${!parts[@]}"; do
      local name="${parts[$i]}"
      acc+="${acc:+/}${name}"
      local label="${name//[_-]/ }"
      label="$(tr '[:lower:]' '[:upper:]' <<< "${label:0:1}")${label:1}"
      local target_index="$site_root/$acc/index.html"
      local href; href="$(relpath "$target_index" "$out_dir")"

      # Link all but the last segment
      if (( i < ${#parts[@]} - 1 )); then
        crumbs_html+="${crumbs_html:+ › }<a href=\"$href\">$label</a>"
      else
        crumbs_html+="${crumbs_html:+ › }$label"
      fi
    done
  fi

  # ---- add Home link (relative to root index.html) ----
  local home_href; home_href="$(relpath "$site_root/index.html" "$out_dir")"
  local full_breadcrumbs="<a href=\"${home_href}\">Home</a>"
  [[ -n "$crumbs_html" ]] && full_breadcrumbs+=" › ${crumbs_html}"

  echo "Converting $input → $output"
  echo " • out_dir:      $out_dir"
  echo " • site_root:    $site_root"
  echo " • breadcrumbs:  $(echo "$full_breadcrumbs" | sed 's/<[^>]*>//g')"
  echo " • rendered on:  $render_date"

  pandoc <(
    # Rewrite .md links to .html (incl. README.md → index.html), don’t touch images.
    sed -E '
      s/!\[/__IMG_OPEN__\[/g;
      s@(\[[^]]*\]\()([^)#?]+)/README\.md([?#][^)]*)?\)@\1\2/index.html\3)@g;
      s/__IMG_OPEN__\[/![/g
    ' "$input"
  ) \
  --include-before-body=<(printf '%s\n' "<nav class=\"breadcrumbs\">${full_breadcrumbs}</nav>") \
  "${args[@]}"
}



mkdir ./img
cp -R ./../slices_of_life/img/ .


# Build my artsy pages
mkdir -p ./art_i_enjoy/wood_block_printing/Uchida_Wood_Block_Printing
md2html ./../slices_of_life/art_i_enjoy/wood_block_printing/Uchida_Wood_Block_Printing/README.md \
        ./art_i_enjoy/wood_block_printing/Uchida_Wood_Block_Printing/index.html \
        "Uchida Wood Block Printing" \
        ./template.html \
        ./style.css \

mkdir -p ./my_curated_booklist
md2html ./../slices_of_life/my_curated_booklist/README.md \
        ./my_curated_booklist/index.html \
        "Benjamin his curated booklist" \
        ./template.html \
        ./style.css \




mkdir -p ./art_i_enjoy/takamizawa_mokuhansha/
md2html ./../slices_of_life/art_i_enjoy/README.md \
        ./art_i_enjoy/index.html \
        "Benjamin Italiaander Loves Art" \
        ./template.html \
        ./style.css \
        .

md2html ./../slices_of_life/art_i_enjoy/takamizawa_mokuhansha/README.md \
        ./art_i_enjoy/takamizawa_mokuhansha/index.html \
        "Takamizawa Mokuhansha" \
        ./template.html \
        ./style.css \
        .

mkdir -p  ./linux/gnupg
md2html  ./../Linux/GnuPG/README.md \
        ./linux/gnupg/index.html \
        "Linux GnuPG" \
        ./template.html \
        ./style.css \
        .

mkdir -p  ./linux/otp-generator
md2html   ./../Linux/bash_otp_generator.md \
        ./linux/otp-generator/index.html \
        "Linux CLI OTP generator" \
        ./template.html \
        ./style.css \
        .


mkdir -p  ./linux/find_exclude_hidden_files
md2html   ./../Linux/find_exclude_hidden_files.md \
        ./linux/find_exclude_hidden_files/index.html \
        "Linux Find files and igonre hidden files" \
        ./template.html \
        ./style.css \
        .

mkdir -p  ./linux/OpenPGP_GnuPG_cheat_sheet
md2html   ./../Linux/OpenPGP_GnuPG_cheat_sheet.md \
        ./linux/OpenPGP_GnuPG_cheat_sheet/index.html \
        "Linux OpenPGP cheat sheet" \
        ./template.html \
        ./style.css \
        .








md2html   ./../Linux/README.md \
        ./linux/index.html \
        "Linux I use it" \
        ./template.html \
        ./style.css \
        .









# Build main page including the site index
cp ./../slices_of_life/README.md ./index.md
./site-index.sh
md2html  ./index.md ./index.html  "Benjamin Italiaander" template.html ./style.css .

