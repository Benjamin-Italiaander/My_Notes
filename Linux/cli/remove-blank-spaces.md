---
title: "Put every word on its own line"
date: 2016-10-04
description: "Split text into one word per line with xargs."
---

*🇳🇱 [Lees deze pagina in het Nederlands](remove-blank-spaces_nl.md)*

# Put every word on its own line

If you have a file with text like this:

```text
abcd efdg ijklm sfgsdf
sdgf gfgf gdfg dgdffdg
```

and you want each word on a separate line, the easiest way is `xargs`:

```bash
xargs -n 1 < ./somefile.txt
```
