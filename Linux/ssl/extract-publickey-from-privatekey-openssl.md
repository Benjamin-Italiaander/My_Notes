# Optionally, the rsa public key can be extracted from the private key


```bash
openssl rsa -in domain.tld.key -pubout -out doamin.tld.pubkey
openssl rsa -in domain.tld.pubkey -pubin -noout -text
```
