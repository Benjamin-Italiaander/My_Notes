---
title: "Keyboard not working on Fujitsu Lifebook on Fedora 36"
date: 2022-08-19
description: "Fix a dead keyboard on a Fujitsu Lifebook U7410 after installing Fedora 36, with GRUB kernel options."
author:
  - Benjamin Italiaander
keywords:
    - Fujitsu U7410
    - Fedora
    - keyboard
    - fujitsu lifebook u7410
    - lifebook
    - U7410
---

*🇳🇱 [Lees deze pagina in het Nederlands](Keyboard_not_working_on_Fujitsu_Lifebook_on_Fedora_nl.md)*

After installing Fedora Linux 36 on my Fujitsu Lifebook U7410, the keyboard stopped working. I fixed it by editing the GRUB configuration.

Add the following line at the bottom of `/etc/default/grub`:

```sh
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i8042.reset i8042.nomux i8042.nopnp i8042.noloop"
```

After editing the file, regenerate the GRUB configuration:

```sh
grub2-mkconfig -o "$(readlink -e /etc/grub2.cfg)"
```

Now reboot.
