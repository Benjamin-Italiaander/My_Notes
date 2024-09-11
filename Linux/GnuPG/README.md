# The GNU Privacy Guard

How to encrypt and decrypt a file

```bash
#encrypt a file
gpg -e -r someone@domain.tld file-to-encrypt.txt

#decrypt a file
gpg -d -o secrets.txt file-to-encrypt.txt.gpg
```

