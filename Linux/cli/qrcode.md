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

