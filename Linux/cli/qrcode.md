---
title: 'Generate a QR code from a pipe in the Linux CLI'
date: 2024-01-01
description: "Turn command output into a QR code with qrencode, and read QR codes from images with zbarimg."
section: Linux CLI
author: 'benjamin-italiaander'
---

*🇳🇱 [Lees deze pagina in het Nederlands](qrcode_nl.md)*

# Create a QR code from command output

I needed to turn the output of a command into a QR code. Here is a short guide on how to generate a QR code from a pipe in the Linux CLI:

```bash
qrencode -t ansiutf8 < ./somefile.txt
```

I manage my passwords with `pass` and wanted to get a password onto my phone with a QR code:

```bash
pass work/someaccount | head -n1 | tr -d '\n' | qrencode -t ansiutf8
```

`tr` removes the newline that is added at the end.

# The other way around: read a QR code in the Linux CLI

One option is [zbar-tools](https://github.com/mchehab/zbar). It is a great tool because you don't need to crop the QR code or anything: you just give the image to `zbarimg` and it finds the QR codes by itself.

```bash
zbarimg --raw ./file_that_contains_a_qrcode.jpg
OUTPUT STRING WILL BE DISPLAYED HERE
scanned 1 barcode symbols from 1 images in 0,07 seconds
```
