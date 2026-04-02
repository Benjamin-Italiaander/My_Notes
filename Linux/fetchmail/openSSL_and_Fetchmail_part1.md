---
author: Benjamin Italiaander
date: '2022-08-24'
keywords: OPENSSL
title: Fetchmail OPENSSL error
---


# Fetchmail OpenSSL reported error

In case you get the OpenSSL error with fetchmail you need to generate a MD5 fingerprint to validate de OpenSSL connection and add this to your ~/.fetchmailrc file. Also make sure you have a accurate version of OpenSSL installed.




```bash
#Generate MD5 
openssl s_client -connect zimap.cwi.nl:993 </dev/null 2>/dev/null | openssl x509 -fingerprint -noout -md5 -in /dev/stdin
```

```bash
#Add this line with your generated fingerprint to your ~/.fetchmailrc file
ssl
sslfingerprint "01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:FF" 
```


finally your config should be something like

```bash
poll zimap.cwi.nl
protocol imap
port 993
user "username"
pass "pass"
ssl
sslfingerprint "00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD:EE:FF"
mda "/your/mda"

```

