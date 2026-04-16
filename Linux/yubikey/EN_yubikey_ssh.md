---

title: "YubiKey SSH Guide"
draft: false
date: 2020
description: "This guide explains how use SSH with your YubiKey."

---


# SSH with YubiKey (FIDO2)
**Make sure you do the [first steps](https://github.com/Benjamin-Italiaander/My_Notes/blob/main/Linux/yubikey/README.md) of initiating your YubiKey before you will start using the SSH functionality on your yubikey.**

I assume you do know how ssh-keys work, that you do know the difference betweer private and public keys. 

For the use of SSH in a more advanced way i would recomend to youse the openPGP solution, but since openPGP is a bit more complex this is a really good alternative. 
The thing is, your yubikey generates two privated keys, the real private key is inside your yubikey and you cant get it out, the second part is on your desktop in you ~/.ssh folder, the second part you can only use in combination with the part on your yubikey. This makes ssh really safe (as long as you turn of password authentication on you servers but thats a other story)


First check if your pin is enabled for the FIDO function 'ykman fido info'
```bash
# ykman fido info

AAGUID:                       abcder-abc-abc-abc
PIN:                          Not set
Minimum PIN length:           4
Always Require UV:            Off
Credential storage remaining: 100
```
If you see at PIN not set, creat a passowrd for the FIDO function

```bash
# ykman fido access change-pin
Enter your new PIN: 
Repeat for confirmation: 
FIDO PIN updated.
```

There are still two keys generated: your private key and your public key.
The private key remains important when using your YubiKey. In fact, the private key functions as a challenge key and works together with your YubiKey.

You should never share your private key with anyone.
Your public key, on the other hand, can be shared.


REMEMBER! **Never use SSH agent forwarding with your YubiKey or ssh -a — or better, don’t use it at all.**


It is **not** possible to copy an SSH private key *into* a YubiKey.  
Instead, your YubiKey can **generate and store** the private key internally.

You **cannot extract** the private key later — which is the point.

---

## Generate an SSH Key on the YubiKey

Generate a key **without passphrase** so just press Enter twice when asked.

Use the serial number in your comment:

```bash
ssh-keygen -t ed25519-sk -O resident -O verify-required \
  -f ~/.ssh/yubikey \
  -C "Benjamin Yubikey 12345678"
```

Example output:

```
You may need to touch your authenticator to authorize key generation.
Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/benjamin/.ssh/yubikey
Your public key has been saved in /home/benjamin/.ssh/yubikey.pub
The key fingerprint is:
SHA256:hdfjfhsdjfhdjfhdjfhdjfhdjfhdjfhdjfhdjfhdj Benjamin Yubikey 12345678
```

---

# Key Generation Options Explained

| Option | Meaning |
| --- | --- |
| **`-t ed25519-sk`** | FIDO2 security key-backed Ed25519 key. |
| **`-O resident`** | Stores the private key **inside** the YubiKey (resident credential). |
| **`-O verify-required`** | Requires **PIN + touch** on every authentication. |
| **`-O application=ssh:<name>`** | Optional label for multiple credentials. |
| **`-C "comment"`** | Adds a comment to the public key. |

### Notes

- Without `-O resident`, only a *key handle* is stored on disk — not the private key.
  
- Resident keys require a FIDO2 PIN.
  
- Public keys (`*.pub`) are used for your servers or GitHub.
  

---

# FIDO2 SSH Workflow

The key generation process consists of:

1. **Touch YubiKey** to confirm key creation.
  
2. **Enter FIDO2 PIN** for resident keys.
  
3. **Save location** for the key handle.
  
4. Optional: **add a passphrase** for the handle file (not needed if using PIN+touch).
  

The `.pub` file is the only part you share.
