---
title: "SSL-controles"
date: 2025-11-18
description: "OpenSSL-commando's om CSR's, sleutels, certificaten en PKCS#12-bestanden te controleren, en of een sleutel en certificaat bij elkaar horen."
translated_by_ai: true
translated_from: "en"
original: "ssl-checks.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](ssl-checks.md).*

## Standaard SSL-controles
Een Certificate Signing Request (CSR) controleren
```bash
openssl req -text -noout -verify -in CSR.csr
```

Een privésleutel controleren
```bash
openssl rsa -in privateKey.key -check
```
Een certificaat controleren
```bash
openssl x509 -in certificate.crt -text -noout
```

Een PKCS#12-bestand (.pfx of .p12) controleren
```bash
openssl pkcs12 -info -in keyStore.p12
```

## Controleren of een certificaat en sleutel bij elkaar horen
Je kunt controleren of een `.crt`- en een `.key`-bestand bij elkaar horen door een MD5-hash van hun modulus te vergelijken. Zijn beide uitkomsten gelijk, dan heb je een passend paar.
```bash
openssl rsa -modulus -noout -in ./certificate.key | openssl md5
openssl x509 -modulus -noout -in ./certificate.crt | openssl md5
```

Een klein script om te controleren of de bestanden bij elkaar horen:
```bash
#!/bin/bash
if [ $# -eq 0 ]
then
    echo "usage: $(basename $0) certfile keyfile csrfile"
    exit
fi
cert=$1
key=$2
csr=$3
echo "$cert:"
openssl x509 -noout -modulus -in $cert | openssl md5
echo "$key:"
openssl rsa -noout -modulus -in $key | openssl md5
echo "$csr:"
test ! x$csr = x && openssl req -noout -modulus -in $csr | openssl md5
```
