---
title: "Fetchmail OPENSSL error"
author: Benjamin Italiaander
date: "2022-08-24"
subject: "OPENSSL FETCHMAIL"
keywords: OPENSSL
lang: "en"
colorlinks: true

header-left: "\\hspace{1cm}"
header-center: "\\leftmark"
header-right: "Page \\thepage"
footer-left: "\\thetitle"
footer-center: ""
footer-right: "\\theauthor"



header-includes:



- |
  ```{=latex}
  \usepackage{tcolorbox}
  \usepackage{awesomebox}
  \newtcolorbox{info-box}{colback=cyan!5!white,arc=0pt,outer arc=0pt,colframe=cyan!60!black}
  \newtcolorbox{warning-box}{colback=orange!5!white,arc=0pt,outer arc=0pt,colframe=orange!80!black}
  \newtcolorbox{error-box}{colback=red!5!white,arc=0pt,outer arc=0pt,colframe=red!75!black}

  ```


pandoc-latex-environment:
  tcolorbox: [box]
  info-box: [info]
  warning-box: [warning]
  error-box: [error]
  noteblock: [note]
  tipblock: [tip]
  warningblock: [warning]
  cautionblock: [caution]
  importantblock: [important]



...


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

