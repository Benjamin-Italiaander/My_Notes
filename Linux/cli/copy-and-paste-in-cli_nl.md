---
title: "Kopiëren en plakken in de CLI"
date: 2025-11-18
description: "Kopieer de uitvoer van een commando naar het klembord met xclip, en een handige shellfunctie daarvoor."
translated_by_ai: true
translated_from: "en"
original: "copy-and-paste-in-cli.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](copy-and-paste-in-cli.md).*

# Kopiëren en plakken in de Linux-terminal is makkelijk met xclip

### Een eenvoudig commando

```bash
# Copy whatever is piped in to the clipboard
xclip -selection c
```

### Er een functie van maken

Ik vergeet het commando steeds, dus heb ik een functie aan mijn `.bashrc` toegevoegd:

```bash
# Use it by piping something into copy-to-clipboard
copy-to-clipboard() {
  xclip -selection c
}

# For example:
cat some-file.txt | copy-to-clipboard
```
