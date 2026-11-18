---
title: 'GnuPG'
date: 2021-01-01
description: 'GnuPG is a complete and free implementation of the OpenPGP standard'
section: Linux
author: 'benjamin-italiaander'
---

*🇳🇱 [Lees deze pagina in het Nederlands](nl.md)*

# The GNU Privacy Guard

How to encrypt and decrypt a file:

```bash
# encrypt a file
gpg -e -r someone@domain.tld file-to-encrypt.txt

# decrypt a file
gpg -d -o secrets.txt file-to-encrypt.txt.gpg
```

---


## GPG Error: Unusable Public Key

If you encounter the following error:

```text
There is no assurance this key belongs to the named user
encryption failed: Unusable public key
```

You can find a step-by-step solution here:

[Fix: Unusable public key](GPG_unusable_public_key.md)
