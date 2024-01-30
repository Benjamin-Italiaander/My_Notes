# A small list with som important commands i use with GnuPG

## YubiKey and gnuPG OpenPGP or gpg
Just start with
```
# open the gpg with your yubikey
gpg --card-edit

# Now enter the admin command
gpg/card> admin

# Now enter Help and you see all possible commands
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



List all keys including keygrip or keyidentity on a yubiKey
```
 gpg --card-status --with-keygrip
```


Edit yubiKey with gpg
```
gpg --expert --edit-card
```
