# Certificate Signing Request Best Practices Using OpenSSL

A Certificate Signing Request (CSR) can be generated with OpenSSL, during the creation of a CSR you generate two files, A private key (.key file) and a certificate signing request (.csr file)

Best way of generating a CSR is by creating a request configuration file where you add all the SSL info. In this case i call the config file request.cnf.

```bash
[ req ]
default_bits        = 2048
iattributes	    = req_attributes
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
emailAddress		   = admin@domain.tlnd

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
DNS.1   = *.domain.tld


```



After building this config file, you can generate the SSL pair. Pleas make sure you never share the .key file. This is a private key.

```bash
openssl req -out domain_tld.csr -newkey rsa:4096 -nodes -keyout ./domain_tld.key -config ./request.cnf
```

with the .csr file you can request a SSL-certificate. 
