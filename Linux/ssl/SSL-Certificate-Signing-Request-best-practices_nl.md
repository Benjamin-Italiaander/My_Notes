---
title: "Best practices voor een Certificate Signing Request"
date: 2025-11-18
description: "Maak met OpenSSL een privésleutel en CSR met een configuratiebestand met SAN's."
translated_by_ai: true
translated_from: "en"
original: "SSL-Certificate-Signing-Request-best-practices.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](SSL-Certificate-Signing-Request-best-practices.md).*

# Best practices voor een Certificate Signing Request met OpenSSL

Een Certificate Signing Request (CSR) kun je maken met OpenSSL. Daarbij ontstaan twee bestanden: een privésleutel (`.key`-bestand) en een certificaataanvraag (`.csr`-bestand).

De beste manier om een CSR te maken is met een configuratiebestand waarin alle gegevens van het certificaat staan. Hier noem ik dat bestand `request.cnf`.

```bash
[ req ]
default_bits        = 4096
attributes          = req_attributes
distinguished_name  = req_distinguished_name
prompt		    = no
x509_extensions     = v3_ca
req_extensions      = v3_req


[ req_distinguished_name ]
countryName                = NL
stateOrProvinceName        = Noord-Holland
localityName               = Amsterdam
organizationName           = My company Name
organizationalUnitName     = IT
commonName		   = *.domain.tld
emailAddress		   = admin@domain.tld

[v3_ca]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer:always
basicConstraints = critical, CA:true, pathlen:0
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[v3_req]
subjectKeyIdentifier = hash
basicConstraints = critical, CA:false
nsCertType = server
keyUsage = digitalSignature, nonRepudiation, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names


[ req_attributes ]

[ req_ext ]
subjectAltName = @alt_names

[alt_names]
DNS.1   = domain.tld
DNS.2   = *.domain.tld


```



Met dit configuratiebestand kun je de sleutel en de CSR maken. Deel het `.key`-bestand nooit: dat is je privésleutel.

```bash
openssl req -out domain_tld.csr -newkey rsa:4096 -nodes -keyout ./domain_tld.key -config ./request.cnf
```

Met het `.csr`-bestand vraag je een SSL-certificaat aan bij je certificaatautoriteit. 
