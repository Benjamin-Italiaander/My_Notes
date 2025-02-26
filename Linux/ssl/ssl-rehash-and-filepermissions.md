# 




```bash
#!/bin/bash -

uid=$1
gid=$2
uid=${uid:="nginx"}
gid=${gid:=$uid}

/bin/rm *.0

ln -s ca-bundle.crt `openssl x509 -hash -noout -in ca-bundle.crt`.0

cat asterisk_cwi_nl.crt > ssl-bundle.crt
echo >> ssl-bundle.crt
cat ca-bundle.crt >> ssl-bundle.crt
ln -s ssl-bundle.crt `openssl x509 -hash -noout -in ssl-bundle.crt`.0

if [ -f asterisk_project_cwi_nl.crt ]; then
    cat asterisk_project_cwi_nl.crt > project-bundle.crt
    echo >> project-bundle.crt
    cat ca-bundle.crt >> project-bundle.crt
    ln -s project-bundle.crt `openssl x509 -hash -noout -in project-bundle.crt`.0
fi

chmod 0444 *.crt
chmod 0400 *.key
chown $uid:$gid *.{crt,key}
```
