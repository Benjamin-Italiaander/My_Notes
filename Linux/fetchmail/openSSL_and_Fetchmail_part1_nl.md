---
title: "Fetchmail OpenSSL-fout"
date: 2025-11-18
description: "Los OpenSSL-fouten in fetchmail op door de vingerafdruk van het servercertificaat aan .fetchmailrc toe te voegen."
translated_by_ai: true
translated_from: "en"
original: "openSSL_and_Fetchmail_part1.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](openSSL_and_Fetchmail_part1.md).*

# Fetchmail meldt een OpenSSL-fout

Krijg je een OpenSSL-fout met fetchmail, maak dan een MD5-vingerafdruk van het servercertificaat om de OpenSSL-verbinding te valideren, en zet die in je bestand `~/.fetchmailrc`. Zorg ook dat je een actuele versie van OpenSSL hebt.

```bash
# Generate the MD5 fingerprint
openssl s_client -connect imap.example.com:993 </dev/null 2>/dev/null | openssl x509 -fingerprint -noout -md5 -in /dev/stdin
```

```bash
# Add these lines, with your generated fingerprint, to your ~/.fetchmailrc file
ssl
sslfingerprint "01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:FF" 
```


Je configuratie ziet er uiteindelijk ongeveer zo uit:

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

Nieuwere versies van fetchmail hebben in plaats daarvan het volledige certificaat nodig, zie [deel 2](openSSL_and_Fetchmail_part2_nl.md).

