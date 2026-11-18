---
title: "Extract the Public Key from a Private Key with OpenSSL"
date: 2016-04-15
description: "Extract and inspect the RSA public key that belongs to a private key with OpenSSL."
---

*🇳🇱 [Lees deze pagina in het Nederlands](extract-publickey-from-privatekey-openssl_nl.md)*

# Extract the RSA public key from a private key

```bash
# write the public key to a file
openssl rsa -in domain.tld.key -pubout -out domain.tld.pubkey

# show the public key
openssl rsa -in domain.tld.pubkey -pubin -noout -text
```
