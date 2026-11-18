---
title: "SSL-rehash en bestandsrechten"
date: 2025-11-18
description: "Een script dat certificaatbundels maakt, OpenSSL-hashlinks aanmaakt en veilige rechten instelt."
translated_by_ai: true
translated_from: "en"
original: "ssl-rehash-and-filepermissions.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](ssl-rehash-and-filepermissions.md).*

# Certificaten rehashen en bestandsrechten instellen

Een script dat ik in een map met certificaten gebruik. Het:

1. maakt de OpenSSL-hashlinks (`<hash>.0`) voor de CA-bundel en de certificaatbundels,
2. bouwt `ssl-bundle.crt` (certificaat + CA-bundel),
3. maakt certificaten alleen-lezen (`0444`) en sleutels alleen leesbaar voor de eigenaar (`0400`),
4. geeft de bestanden aan de webservergebruiker (standaard `nginx`, of de gebruiker/groep die je als argumenten meegeeft).

Voer het uit in de map met certificaten: `./rehash.sh [user] [group]`

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
