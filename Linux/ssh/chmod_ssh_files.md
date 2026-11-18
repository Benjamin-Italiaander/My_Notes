---
title: "Permissions for SSH Files"
date: 2016-12-09
description: "The correct permissions for ~/.ssh, your keys, authorized_keys and config."
---

*🇳🇱 [Lees deze pagina in het Nederlands](chmod_ssh_files_nl.md)*

# Permissions for SSH files

| What | Path | chmod | Result |
|---|---|---|---|
| SSH folder | `~/.ssh` | 700 | `drwx------` |
| Public key | `~/.ssh/id_rsa.pub` | 644 | `-rw-r--r--` |
| Private key | `~/.ssh/id_rsa` | 600 | `-rw-------` |
| Authorized keys | `~/.ssh/authorized_keys` | 600 | `-rw-------` |
| Config | `~/.ssh/config` | 600 | `-rw-------` |

## Home folder

Your home folder must not be writable by others, or SSH will refuse your keys. 755 (`drwxr-xr-x`) is the most it may be:

```bash
chmod g-w,o-w ~
```
