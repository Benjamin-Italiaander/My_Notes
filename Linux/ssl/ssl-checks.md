---
title: "SSL Checks"
date: 2016-02-08
description: "OpenSSL commands to check CSRs, keys, certificates and PKCS#12 files, and whether a key and certificate match."
---

*🇳🇱 [Lees deze pagina in het Nederlands](ssl-checks_nl.md)*

## Regular SSL checks
Check a Certificate Signing Request (CSR)
```bash
openssl req -text -noout -verify -in CSR.csr
```

Check a private key
```bash
openssl rsa -in privateKey.key -check
```
Check a certificate
```bash
openssl x509 -in certificate.crt -text -noout
```

Check a PKCS#12 file (.pfx or .p12)
```bash
openssl pkcs12 -info -in keyStore.p12
```

## Check whether a certificate and key are a pair
You can check whether a `.crt` and a `.key` file match by comparing an MD5 hash of their modulus. If both outputs are the same, you have a matching pair.
```bash
openssl rsa -modulus -noout -in ./certificate.key | openssl md5
openssl x509 -modulus -noout -in ./certificate.crt | openssl md5
```

Here is a small script to check whether the files match:
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
