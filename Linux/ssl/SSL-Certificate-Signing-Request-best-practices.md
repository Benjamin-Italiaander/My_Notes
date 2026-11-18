---
title: "SSL Certificate Signing Request Best Practices"
date: 2016-05-04
description: "Create a private key and CSR with OpenSSL using a request configuration file with SANs."
---

*🇳🇱 [Lees deze pagina in het Nederlands](SSL-Certificate-Signing-Request-best-practices_nl.md)*

# Certificate Signing Request Best Practices Using OpenSSL

A Certificate Signing Request (CSR) can be generated with OpenSSL. When you create a CSR, you generate two files: a private key (`.key` file) and a certificate signing request (`.csr` file).

The best way to generate a CSR is to create a request configuration file that contains all the certificate details. In this case I call the config file `request.cnf`.

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



After creating this config file, you can generate the key and the CSR. Make sure you never share the `.key` file: it is your private key.

```bash
openssl req -out domain_tld.csr -newkey rsa:4096 -nodes -keyout ./domain_tld.key -config ./request.cnf
```

With the `.csr` file you can request an SSL certificate from your certificate authority. 
