---
title: "Git notes"
date: 2016-11-30
description: "Basic Git configuration and how to switch a remote to SSH."
---

*🇳🇱 [Lees deze pagina in het Nederlands](GIT_notes_nl.md)*

# Git

## Configure Git

```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

## Use an SSH key for a specific remote

```bash
git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
```

## List the configured remotes

```bash
git remote -v
```
