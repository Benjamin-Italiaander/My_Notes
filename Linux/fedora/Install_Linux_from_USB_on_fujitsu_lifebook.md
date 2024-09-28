---
section: Linux
title: 'Install linux from usb on fujitsu lifebook'
author: 'benjamin-italiaander'
description:  "Install Linux from USB on fujitsu lifebook"
author: Benjamin Italiaander
date: 2022-08-19
keywords:
    - Fujitsu U7410
    - Fedora
    - linux boot 
    - fujitsu lifebook u7410
    - lifebook
    - U7410
    - linux booting fujitsu
---


I was trying to run a USB-install with Fedora 36 on my fujitsu lifebook u7410 but it did not boot from usb.

```bash
set_second_stage() failed: invalid Parameter
Something has done seriously wrong: shim_init() failed Invalid Parameter
```


Avoid this problem by making a bootable USB with [ventoy USB tool](https://www.ventoy.net/en/index.html)


