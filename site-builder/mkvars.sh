
#!/usr/bin/env bash
set -euo pipefail

VARS_ROOT="./_vars"
INDEX_FILE="$VARS_ROOT/_index.txt"

SEARCH_DIRS=( "./../Linux" "./../math" "./../slices_of_life" "./../Misc" )

# Create a vars skeleton for a given md + vars file path
create_vars_file() {
  local md="$1"
  local rel_md="$2"
  local vf="$3"

  mkdir -p "$(dirname "$vf")"

  {
    echo "# Values for: $(basename "$md")"
    echo "# Source: $rel_md"
    echo "# Fill in on the right side. Example: VAR_description=Hello"
    echo "VAR_description="
  } > "$vf"
}

mkdir -p "$VARS_ROOT"
: > "$INDEX_FILE"

# We'll record expected vars files here
tmp_expected="$(mktemp)"
trap 'rm -f "$tmp_expected"' EXIT

# ---- pass 1: ensure vars files exist for all md files ----
for root in "${SEARCH_DIRS[@]}"; do
  [[ -d "$root" ]] || continue

  while IFS= read -r -d '' md; do
    # md path relative to repo root-ish: remove leading ./../
    rel="${md#./../}"
    rel="${rel#../}"

    # vars file mirrors md path under _vars, but with .vars extension
    vf="$VARS_ROOT/${rel%.md}.vars"

    # track expected
    printf '%s\n' "$vf" >> "$tmp_expected"

    # create if missing (do not touch if exists)
    if [[ ! -f "$vf" ]]; then
      create_vars_file "$md" "$rel" "$vf"
    fi

    # index record
    printf '%s -> %s\n' "$rel" "${vf#./}" >> "$INDEX_FILE"
  done < <(find "$root" -type f -name '*.md' -print0)

done

# ---- pass 2: delete orphan vars files (md removed) ----
# Build a fast lookup set of expected vars files
sort -u "$tmp_expected" > "${tmp_expected}.sorted"

# Find all existing vars files and delete those not expected
while IFS= read -r -d '' existing; do
  # normalize existing path to match expected list format
  if ! grep -qxF "$existing" "${tmp_expected}.sorted"; then
    rm -f "$existing"
  fi
done < <(find "$VARS_ROOT" -type f -name '*.vars' -print0)

# Optional: remove empty dirs under _vars (keeps it tidy)
find "$VARS_ROOT" -type d -empty -delete

echo "Synced vars in: $VARS_ROOT"
echo "Index written:  $INDEX_FILE"

