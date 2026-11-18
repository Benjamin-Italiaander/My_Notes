---
title: "Diff: compare two files"
date: 2016-05-11
description: "Compare two files side by side with diff, optionally showing only the lines that differ."
---

*🇳🇱 [Lees deze pagina in het Nederlands](diff_nl.md)*

# Show the differences between two files

Side-by-side output, in two columns:

```bash
diff --side-by-side file_one.txt file_two.txt
```

Side-by-side output, showing only the lines that differ:

```bash
diff --side-by-side --suppress-common-lines file_one.txt file_two.txt
```

`-y` is the short form of `--side-by-side`.
