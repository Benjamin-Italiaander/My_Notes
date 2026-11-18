---
title: "Diff: twee bestanden vergelijken"
date: 2025-11-18
description: "Vergelijk twee bestanden naast elkaar met diff, eventueel met alleen de regels die verschillen."
translated_by_ai: true
translated_from: "en"
original: "diff.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](diff.md).*

# De verschillen tussen twee bestanden tonen

Naast elkaar, in twee kolommen:

```bash
diff --side-by-side file_one.txt file_two.txt
```

Naast elkaar, met alleen de regels die verschillen:

```bash
diff --side-by-side --suppress-common-lines file_one.txt file_two.txt
```

`-y` is de korte vorm van `--side-by-side`.
