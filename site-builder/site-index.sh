#!/usr/bin/env bash
# generate_index_md.sh
# Creates a Markdown site index listing all index.html pages

site_root="${1:-.}"
output="${2:-$site_root/index.md}"
echo "<br><p>" >> "$output"
echo "---" >> "$output"
echo "## 🌐 Site Index" >> "$output"
echo "" >> "$output"
echo "" >> "$output"

# Find all index.html files (except the site root one)
find "$site_root" -type f -name "index.html" | sort | while read -r f; do
  rel="${f#$site_root/}"
  # Extract title from the file (first <title> tag)
  title=$(grep -m1 -oP '(?<=<title>).*?(?=</title>)' "$f")
  [[ -z "$title" ]] && title="$rel"
  depth=$(( $(grep -o "/" <<< "$rel" | wc -l) - 1 ))
  indent=$(printf '  %.0s' $(seq 1 "$depth"))
  echo "${indent}- [${title}](${rel})" >> "$output"
done

echo "✅ Markdown site index generated: $output"
