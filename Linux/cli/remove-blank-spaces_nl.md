---
title: "Elk woord op een eigen regel"
date: 2025-11-18
description: "Splits tekst in één woord per regel met xargs."
translated_by_ai: true
translated_from: "en"
original: "remove-blank-spaces.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](remove-blank-spaces.md).*

# Elk woord op een eigen regel zetten

Heb je een bestand met tekst zoals dit:

```text
abcd efdg ijklm sfgsdf
sdgf gfgf gdfg dgdffdg
```

en wil je elk woord op een aparte regel, dan is `xargs` het makkelijkst:

```bash
xargs -n 1 < ./somefile.txt
```
