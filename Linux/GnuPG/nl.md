---
title: "GnuPG"
date: 2025-11-18
description: "GnuPG is een complete en vrije implementatie van de OpenPGP-standaard."
translated_by_ai: true
translated_from: "en"
original: "README.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](README.md).*

# The GNU Privacy Guard

Zo versleutel en ontsleutel je een bestand:

```bash
# encrypt a file
gpg -e -r someone@domain.tld file-to-encrypt.txt

# decrypt a file
gpg -d -o secrets.txt file-to-encrypt.txt.gpg
```

---


## GPG-fout: onbruikbare publieke sleutel

Krijg je de volgende fout:

```text
There is no assurance this key belongs to the named user
encryption failed: Unusable public key
```

Een stapsgewijze oplossing vind je hier:

[Oplossing: onbruikbare publieke sleutel](GPG_unusable_public_key_nl.md)
