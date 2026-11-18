---
title: "SSL Rehash and File Permissions"
date: 2016-03-06
description: "A script that builds certificate bundles, creates OpenSSL hash links and sets safe permissions."
---

*🇳🇱 [Lees deze pagina in het Nederlands](ssl-rehash-and-filepermissions_nl.md)*

# Rehash certificates and set file permissions

A script I use in a certificate folder. It:

1. creates the OpenSSL hash links (`<hash>.0`) for the CA bundle and the certificate bundles,
2. builds `ssl-bundle.crt` (certificate + CA bundle),
3. makes certificates read-only (`0444`) and keys readable by the owner only (`0400`),
4. gives the files to the web server user (default `nginx`, or the user/group you pass as arguments).

Run it inside the certificate folder: `./rehash.sh [user] [group]`

```bash
#!/bin/bash -

uid=$1
gid=$2
uid=${uid:="nginx"}
gid=${gid:=$uid}

/bin/rm *.0

ln -s ca-bundle.crt `openssl x509 -hash -noout -in ca-bundle.crt`.0

cat wildcard_example_com.crt > ssl-bundle.crt
echo >> ssl-bundle.crt
cat ca-bundle.crt >> ssl-bundle.crt
ln -s ssl-bundle.crt `openssl x509 -hash -noout -in ssl-bundle.crt`.0

if [ -f wildcard_project_example_com.crt ]; then
    cat wildcard_project_example_com.crt > project-bundle.crt
    echo >> project-bundle.crt
    cat ca-bundle.crt >> project-bundle.crt
    ln -s project-bundle.crt `openssl x509 -hash -noout -in project-bundle.crt`.0
fi

chmod 0444 *.crt
chmod 0400 *.key
chown $uid:$gid *.{crt,key}
```
