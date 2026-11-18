---
title: "Find Files, Excluding Hidden Files"
date: 2016-09-20
description: "Use find to list files while skipping hidden files and folders."
---

*🇳🇱 [Lees deze pagina in het Nederlands](find_exclude_hidden_files_nl.md)*

## Find files and ignore hidden (`.*`) files

```bash
find /home/user ! -path '*/.*' -type f
```

- Replace `/home/user` with the folder you want to search.
- Change `-type f` (files) to `-type d` to find directories instead.
