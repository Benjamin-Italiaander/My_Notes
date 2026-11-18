---
title: Fetchmail OpenSSL error
date: 2022-08-24
description: "Fix fetchmail OpenSSL errors by adding the server's certificate fingerprint to .fetchmailrc."
author: Benjamin Italiaander
keywords: OPENSSL
---

*🇳🇱 [Lees deze pagina in het Nederlands](openSSL_and_Fetchmail_part1_nl.md)*

# Fetchmail OpenSSL reported error

If you get an OpenSSL error with fetchmail, generate an MD5 fingerprint of the server certificate to validate the OpenSSL connection, and add it to your `~/.fetchmailrc` file. Also make sure you have an up-to-date version of OpenSSL installed.

```bash
# Generate the MD5 fingerprint
openssl s_client -connect imap.example.com:993 </dev/null 2>/dev/null | openssl x509 -fingerprint -noout -md5 -in /dev/stdin
```

```bash
# Add these lines, with your generated fingerprint, to your ~/.fetchmailrc file
ssl
sslfingerprint "01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:FF" 
```


Your config should end up looking something like this:

```bash
poll imap.example.com
protocol imap
port 993
user "username"
pass "pass"
ssl
sslfingerprint "00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD:EE:FF"
mda "/your/mda"
```

Newer versions of fetchmail need the full certificate instead, see [part 2](openSSL_and_Fetchmail_part2.md).

