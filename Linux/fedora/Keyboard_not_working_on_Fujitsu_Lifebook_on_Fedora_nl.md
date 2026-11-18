---
title: "Toetsenbord werkt niet op een Fujitsu Lifebook met Fedora 36"
date: 2025-11-18
description: "Los een dood toetsenbord op een Fujitsu Lifebook U7410 na het installeren van Fedora 36 op met GRUB-kernelopties."
translated_by_ai: true
translated_from: "en"
original: "Keyboard_not_working_on_Fujitsu_Lifebook_on_Fedora.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](Keyboard_not_working_on_Fujitsu_Lifebook_on_Fedora.md).*

Na het installeren van Fedora Linux 36 op mijn Fujitsu Lifebook U7410 werkte het toetsenbord niet meer. Ik heb het opgelost door de GRUB-configuratie aan te passen.

Zet deze regel onderaan `/etc/default/grub`:

```sh
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i8042.reset i8042.nomux i8042.nopnp i8042.noloop"
```

Maak na het aanpassen de GRUB-configuratie opnieuw aan:

```sh
grub2-mkconfig -o "$(readlink -e /etc/grub2.cfg)"
```

Start daarna opnieuw op.
