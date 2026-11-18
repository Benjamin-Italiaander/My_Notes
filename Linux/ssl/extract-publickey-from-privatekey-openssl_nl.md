---
title: "De publieke sleutel uit een privésleutel halen met OpenSSL"
date: 2025-11-18
description: "Haal de publieke RSA-sleutel die bij een privésleutel hoort eruit en bekijk hem met OpenSSL."
translated_by_ai: true
translated_from: "en"
original: "extract-publickey-from-privatekey-openssl.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](extract-publickey-from-privatekey-openssl.md).*

# De publieke RSA-sleutel uit een privésleutel halen

```bash
# write the public key to a file
openssl rsa -in domain.tld.key -pubout -out domain.tld.pubkey

# show the public key
openssl rsa -in domain.tld.pubkey -pubin -noout -text
```
