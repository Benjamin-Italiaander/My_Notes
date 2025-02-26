## Regular ssl checks
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

## Check if certificates are a pair
You can check if a crt and a key file are a match with a md5 check, if the output of de md5 is the same you have a matching ssl-pair
```bash
openssl rsa -modulus -noout -in ./certificate.key | openssl md5
openssl x509 -modulus -noout -in ./certificate.crt | openssl md5
```

Here is a small script that you may use to check if the pairs are matching
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
