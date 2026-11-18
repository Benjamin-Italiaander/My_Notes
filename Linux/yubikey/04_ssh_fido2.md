---
title: "YubiKey 4 — SSH with FIDO2"
date: 2025-10-01T12:30:21+01:00
description: "Create an SSH key that lives on your YubiKey using FIDO2 (ed25519-sk)"
draft: false
---

*🇳🇱 [Lees deze pagina in het Nederlands](04_ssh_fido2_nl.md)*

# 4. SSH with FIDO2

[← 3. TOTP codes](03_totp_oath.md) · [Overview](README.md) · Next: [5. OpenPGP →](05_openpgp_gpg_ssh.md)

**Goal:** an SSH key whose private part never leaves the YubiKey. This is the **simplest** secure way to use SSH with a YubiKey. (OpenPGP, chapter 5, is more flexible but more complex.)

**Before you start:** complete [chapter 2](02_first_time_setup.md) — at least the FIDO2 PIN. You should know the difference between a private and a public key.

---

## 4.1 How it works

- The **real private key** is created and stored **inside the YubiKey** — it can never be extracted or imported.
- A small **key handle** file is stored in `~/.ssh`.
- To log in you need the **YubiKey + touch (+ PIN)**.

| Never share | Safe to share |
|-------------|---------------|
| `~/.ssh/yubikey` (key handle) | `~/.ssh/yubikey.pub` (public key) |
| your YubiKey | |

> 💡 Disable password logins on your servers (`PasswordAuthentication no`) to get the full benefit.

---

## 4.2 Check the FIDO2 PIN

```bash
ykman fido info
```

```
PIN:                          Not set     ← must be set!
Minimum PIN length:           4
Always Require UV:            Off
```

Not set yet? → `ykman fido access change-pin` (see [2.2](02_first_time_setup.md#22-fido2--set-a-pin)).

---

## 4.3 Generate the key

```bash
ssh-keygen -t ed25519-sk -O resident -O verify-required \
  -f ~/.ssh/yubikey \
  -C "your-name yubikey"
```

- Press **Enter** twice for no passphrase (the PIN + touch already protect it).
- **Touch** the YubiKey when it blinks.

```
You may need to touch your authenticator to authorize key generation.
Your identification has been saved in /home/user/.ssh/yubikey
Your public key has been saved in /home/user/.ssh/yubikey.pub
```

| Option | Meaning |
|--------|---------|
| `-t ed25519-sk` | FIDO2-backed SSH key |
| `-O resident` | Store the credential on the YubiKey (can be recovered on another PC, see 4.5) |
| `-O verify-required` | Require **PIN + touch** for every login |
| `-O application=ssh:<name>` | Optional label — useful when you have several keys |
| `-C "comment"` | Comment in the public key |

👉 Repeat with your **backup YubiKey** (e.g. `-f ~/.ssh/yubikey-backup`) and put both public keys on your servers.

---

## 4.4 Put the public key on a server

```bash
ssh-copy-id -i ~/.ssh/yubikey.pub user@server
```

Then log in:

```bash
ssh -i ~/.ssh/yubikey user@server
```

1. Start the connection → 2. Enter FIDO2 PIN → 3. Touch the YubiKey.

Make it permanent in `~/.ssh/config`:

```sshconfig
Host myserver
    HostName server.example.com
    User user
    IdentityFile ~/.ssh/yubikey
```

---

## 4.5 Use the key on a new computer

Because the key is *resident*, you can get the key handle back from the YubiKey:

```bash
cd ~/.ssh
ssh-keygen -K        # writes id_ed25519_sk_rk* files to the current directory
```

---

[← 3. TOTP codes](03_totp_oath.md) · [Overview](README.md) · Next: [5. OpenPGP →](05_openpgp_gpg_ssh.md)
