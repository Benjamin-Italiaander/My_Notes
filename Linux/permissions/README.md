---
title: "Permissions"
date: 2016-03-12
description: "Copy permissions and ownership from one file to another with chmod and chown --reference."
---

*🇳🇱 [Lees deze pagina in het Nederlands](nl.md)*

# Copy permissions and ownership from one file to another

## chmod

To copy the permissions of one file to another, use `chmod` with the `--reference` option. Instead of specifying a mode (such as octal permissions like `644`), you point to a reference file whose permissions are copied:

```bash
chmod --reference=reference_file target_file
```

## chown

`chown` works the same way for the owner and group:

```bash
chown --reference=reference_file target_file
```

Add `-R` to apply it recursively to a whole directory.
