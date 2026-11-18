---
title: "Copy and Paste in the CLI"
date: 2016-11-03
description: "Copy command output to the clipboard with xclip, and a handy shell function for it."
---

*🇳🇱 [Lees deze pagina in het Nederlands](copy-and-paste-in-cli_nl.md)*

# Copying and pasting in the Linux terminal is easy with xclip

### A simple command

```bash
# Copy whatever is piped in to the clipboard
xclip -selection c
```

### Making it a function

I keep forgetting the command, so I added a function to my `.bashrc`:

```bash
# Use it by piping something into copy-to-clipboard
copy-to-clipboard() {
  xclip -selection c
}

# For example:
cat some-file.txt | copy-to-clipboard
```
