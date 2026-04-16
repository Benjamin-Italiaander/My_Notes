---

title: "YubiKey SSH Guide"
draft: false
date: 2020
description: "This guide explains how use SSH with your YubiKey."

---
# SSH with YubiKey (FIDO2)

Make sure you complete the [initial setup steps](https://github.com/Benjamin-Italiaander/My_Notes/blob/main/Linux/yubikey/README.md) before using SSH with your YubiKey.

This guide assumes you already understand:
- the difference between **private** and **public keys**
- basic SSH usage

For more advanced setups, OpenPGP can be used, but FIDO2 is a simpler and very secure alternative.

---

## How it works

When using FIDO2 with SSH:

- The **real private key** is stored securely inside the YubiKey  
- A **key handle** is stored on your system (`~/.ssh`)  
- Both are required to authenticate  

This means:
- The private key **cannot be extracted**
- Authentication requires **your YubiKey + touch (+ PIN)**

> Disable password authentication on your servers to fully benefit from this setup.

---

## Check FIDO2 PIN status

```bash
ykman fido info
````

Example output:

```
AAGUID:                       abcdef-abc-abc-abc
PIN:                          Not set
Minimum PIN length:           4
Always Require UV:            Off
Credential storage remaining: 100
```

If the PIN is not set, configure it:

```bash
ykman fido access change-pin
```

Enable UV (User Verification)
```bash
ykman fido config toggle-always-uv
```

---

## Important Notes

* You **cannot import** an existing SSH private key into a YubiKey
* The YubiKey **generates and stores** the private key internally
* The private key is **never extractable**

Never share:

* your private key file (`~/.ssh/yubikey`)
* your YubiKey

You *can* share:

* your public key (`~/.ssh/yubikey.pub`)

> Never use SSH agent forwarding (`ssh -A`) with a YubiKey.

---

## Generate an SSH Key on the YubiKey

Run:

```bash
ssh-keygen -t ed25519-sk -O resident -O verify-required \
  -f ~/.ssh/yubikey \
  -C "your-name yubikey"
```

When prompted:

* Press **Enter** twice for no passphrase (recommended when using PIN + touch)
* Touch your YubiKey when requested

Example output:

```
You may need to touch your authenticator to authorize key generation.
Generating public/private ed25519 key pair.
Your identification has been saved in /home/user/.ssh/yubikey
Your public key has been saved in /home/user/.ssh/yubikey.pub
```

---

## Key Options Explained

| Option                      | Meaning                                   |
| --------------------------- | ----------------------------------------- |
| `-t ed25519-sk`             | FIDO2-backed SSH key                      |
| `-O resident`               | Stores the credential on the YubiKey      |
| `-O verify-required`        | Requires PIN + touch for authentication   |
| `-O application=ssh:<name>` | Optional label (useful for multiple keys) |
| `-C "comment"`              | Comment added to the public key           |

---

## Notes

* Without `-O resident`, only a **key handle** is stored locally
* Resident keys require a **FIDO2 PIN**
* Public keys (`*.pub`) must be added to your server (`~/.ssh/authorized_keys`)

---

## Authentication Flow

When connecting via SSH:

1. Start SSH connection
2. Insert YubiKey (if not already inserted)
3. Touch YubiKey
4. Enter FIDO2 PIN (if required)




