---
title: "Firefox draait al"
date: 2025-11-18
description: "Los de melding 'Firefox is al actief' op door achtergebleven lockbestanden te verwijderen."
translated_by_ai: true
translated_from: "en"
original: "firefox_already_running.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](firefox_already_running.md).*

# Firefox draait al

Krijg je bij het openen van Firefox de melding *"Firefox is al actief"* (*"Firefox is already running"*)? Sluit alle Firefox-vensters en probeer dit script. Het verwijdert de achtergebleven lockbestanden:

```bash
#!/bin/bash
find ~/.mozilla -name "*lock" -print0 |
while IFS= read -r -d '' file; do
  echo "removing $file..."
  rm "$file"
done
```
