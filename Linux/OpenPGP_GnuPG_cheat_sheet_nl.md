---
title: "OpenPGP / GnuPG-spiekbriefje"
date: 2025-11-18
description: "De GnuPG-commando's die ik het meest gebruik met een YubiKey: het kaartmenu, de sleutelstatus en het bewerken van de kaart."
translated_by_ai: true
translated_from: "en"
original: "OpenPGP_GnuPG_cheat_sheet.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](OpenPGP_GnuPG_cheat_sheet.md).*

# Een korte lijst met belangrijke commando's die ik met GnuPG gebruik

## YubiKey en GnuPG (OpenPGP / gpg)
Begin met:
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



Toon alle sleutels op een YubiKey, inclusief hun keygrips:
```
gpg --card-status --with-keygrip
```


De YubiKey bewerken met gpg:
```
gpg --expert --edit-card
```
