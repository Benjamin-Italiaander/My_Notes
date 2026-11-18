---
title: "Bestanden zoeken zonder verborgen bestanden"
date: 2025-11-18
description: "Gebruik find om bestanden te tonen en verborgen bestanden en mappen over te slaan."
translated_by_ai: true
translated_from: "en"
original: "find_exclude_hidden_files.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](find_exclude_hidden_files.md).*

## Bestanden zoeken en verborgen (`.*`) bestanden overslaan

```bash
find /home/user ! -path '*/.*' -type f
```

- Vervang `/home/user` door de map waarin je wilt zoeken.
- Verander `-type f` (bestanden) in `-type d` om mappen te zoeken.
