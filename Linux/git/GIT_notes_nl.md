---
title: "Git-notities"
date: 2025-11-18
description: "Basisconfiguratie van Git en hoe je een remote naar SSH omzet."
translated_by_ai: true
translated_from: "en"
original: "GIT_notes.MD"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](GIT_notes.MD).*

# Git

## Git instellen

```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

## Een SSH-sleutel gebruiken voor een bepaalde remote

```bash
git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
```

## De ingestelde remotes tonen

```bash
git remote -v
```
