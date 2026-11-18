---
title: 'Install Linux on a Fujitsu Lifebook'
date: 2021-01-01
description: 'Install Linux from USB on a Fujitsu Lifebook'
section: Linux
author: 'benjamin-italiaander'
---

*🇳🇱 [Lees deze pagina in het Nederlands](Install_Linux_from_USB_on_fujitsu_lifebook_nl.md)*

I was trying to install Fedora 36 from USB on my Fujitsu Lifebook U7410, but it would not boot from the USB stick:

```text
set_second_stage() failed: invalid Parameter
Something has gone seriously wrong: shim_init() failed Invalid Parameter
```

You can avoid this problem by making the bootable USB stick with the [Ventoy USB tool](https://www.ventoy.net/en/index.html).
