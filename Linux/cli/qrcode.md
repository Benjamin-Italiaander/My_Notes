---
section: Linux CLI
title: 'generate qrcode from pipe in linux cli'
author: 'benjamin-italiaander'
date: 2024
---

# Create a qrcode from command output 
I needed to pipe my cli output to a qrcode and generate a qrcode from it.
So here a short one how to generate qrcode from pipe in linux cli.

```bash
cat ./somefile.txt | qrencode -t ansiutf8
```

or i manage my passowords with pass and needed to copy a password to my phone by qr

```bash
pass work/someaccount | head -n1 | qrencode -t ansiutf8
```

# Other way around - read a qrcode from linux cli -
One option is to use [zbar-tools](https://github.com/mchehab/zbar)

```bash
zbarimg  --raw ./file_that_contains_a_qrcode.jpg 
OUTPUT STRING WILL BE DISPLAYED HERE
scanned 1 barcode symbols from 1 images in 0,07 seconds
```
