---
title: "Rechten voor SSH-bestanden"
date: 2025-11-18
description: "De juiste rechten voor ~/.ssh, je sleutels, authorized_keys en config."
translated_by_ai: true
translated_from: "en"
original: "chmod_ssh_files.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](chmod_ssh_files.md).*

# Rechten voor SSH-bestanden

| Wat | Pad | chmod | Resultaat |
|---|---|---|---|
| SSH-map | `~/.ssh` | 700 | `drwx------` |
| Publieke sleutel | `~/.ssh/id_rsa.pub` | 644 | `-rw-r--r--` |
| Privésleutel | `~/.ssh/id_rsa` | 600 | `-rw-------` |
| Toegestane sleutels | `~/.ssh/authorized_keys` | 600 | `-rw-------` |
| Configuratie | `~/.ssh/config` | 600 | `-rw-------` |

## Thuismap

Je thuismap mag niet schrijfbaar zijn voor anderen, anders weigert SSH je sleutels. 755 (`drwxr-xr-x`) is het maximum:

```bash
chmod g-w,o-w ~
```
