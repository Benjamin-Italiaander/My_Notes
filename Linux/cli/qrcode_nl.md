---
title: "Een QR-code maken vanuit een pipe in de Linux-CLI"
date: 2025-11-18
description: "Maak van de uitvoer van een commando een QR-code met qrencode, en lees QR-codes uit afbeeldingen met zbarimg."
translated_by_ai: true
translated_from: "en"
original: "qrcode.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](qrcode.md).*

# Een QR-code maken van de uitvoer van een commando

Ik wilde de uitvoer van een commando omzetten in een QR-code. Zo maak je een QR-code vanuit een pipe in de Linux-CLI:

```bash
qrencode -t ansiutf8 < ./somefile.txt
```

Ik beheer mijn wachtwoorden met `pass` en wilde een wachtwoord met een QR-code naar mijn telefoon overzetten:

```bash
pass work/someaccount | head -n1 | tr -d '\n' | qrencode -t ansiutf8
```

`tr` haalt het regeleinde aan het eind weg.

# Andersom: een QR-code lezen in de Linux-CLI

Een mogelijkheid is [zbar-tools](https://github.com/mchehab/zbar). Een handige tool, want je hoeft de QR-code niet uit te knippen of zo: je geeft de afbeelding aan `zbarimg` en die vindt de QR-codes zelf.

```bash
zbarimg --raw ./file_that_contains_a_qrcode.jpg
OUTPUT STRING WILL BE DISPLAYED HERE
scanned 1 barcode symbols from 1 images in 0,07 seconds
```
