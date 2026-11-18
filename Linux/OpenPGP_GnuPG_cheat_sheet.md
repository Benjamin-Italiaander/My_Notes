---
title: "OpenPGP / GnuPG Cheat Sheet"
date: 2016-03-14
description: "The GnuPG commands I use most with a YubiKey: the card menu, key status and editing the card."
---

*🇳🇱 [Lees deze pagina in het Nederlands](OpenPGP_GnuPG_cheat_sheet_nl.md)*

# A short list of important commands I use with GnuPG

## YubiKey and GnuPG (OpenPGP / gpg)
Start with:
```
# open the card menu for your YubiKey
gpg --card-edit

# Now enter the admin command
gpg/card> admin

# Now enter help to see all available commands
gpg/card> help
quit           quit this menu
admin          show admin commands
help           show this help
list           list all available data
name           change card holder's name
url            change URL to retrieve key
fetch          fetch the key specified in the card URL
login          change the login name
lang           change the language preferences
salutation     change card holder's salutation
cafpr          change a CA fingerprint
forcesig       toggle the signature force PIN flag
generate       generate new keys
passwd         menu to change or unblock the PIN
verify         verify the PIN and list all data
unblock        unblock the PIN using a Reset Code
factory-reset  destroy all keys and data
kdf-setup      setup KDF for PIN authentication
key-attr       change the key attribute

```



List all keys on a YubiKey, including their keygrips:
```
gpg --card-status --with-keygrip
```


Edit the YubiKey with gpg:
```
gpg --expert --edit-card
```
