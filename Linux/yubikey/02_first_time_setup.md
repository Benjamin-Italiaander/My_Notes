---
title: "YubiKey 2 — First-time setup (the bare minimum)"
date: 2025-10-01T12:30:21+01:00
description: "Replace every default PIN, PUK and management key before using your YubiKey"
draft: false
---

*🇳🇱 [Lees deze pagina in het Nederlands](02_first_time_setup_nl.md)*

# 2. First-Time Setup — The Bare Minimum

[← 1. Installation](01_installation.md) · [Overview](README.md) · Next: [3. TOTP codes →](03_totp_oath.md)

Every YubiKey leaves the factory with **the same, publicly known defaults**. Until you change them, anybody who holds your key can use it.

> ✅ Do this checklist for **every** YubiKey you own, including the backup key.

| ✔ | Application | What to change | Default |
|---|-------------|----------------|---------|
| ☐ | FIDO2 | Set a PIN | *(none)* |
| ☐ | PIV | PIN | `123456` |
| ☐ | PIV | PUK | `12345678` |
| ☐ | PIV | Management key | `010203040506070801020304050607080102030405060708` |
| ☐ | OpenPGP | User PIN | `123456` |
| ☐ | OpenPGP | Admin PIN | `12345678` |
| ☐ | OATH | Password | *(none)* — see [chapter 3](03_totp_oath.md) |

> 💾 **Write down your PUK, Admin PIN and management key and store them offline** (paper, or a QR code in a safe).
> I have an instruction for making a QR code in the CLI [here](https://github.com/Benjamin-Italiaander/My_Notes/blob/main/Linux/cli/qrcode.md).

---

## 2.1 Check the key

```bash
ykman info
```

You should see your device type, serial number and enabled applications (see [chapter 1](01_installation.md#13-verify-the-installation)).

---

## 2.2 FIDO2 — set a PIN

```bash
ykman fido info                 # shows "PIN: Not set" on a new key
ykman fido access change-pin    # leave "current PIN" empty on a new key
```

Verify:

```bash
ykman fido access verify-pin
ykman fido credentials list     # must ask for your PIN
```

Optional — always require the PIN (User Verification) for FIDO2:

```bash
ykman fido config toggle-always-uv
```

---

## 2.3 PIV (smartcard) — PIN, PUK and management key

```bash
ykman piv access change-pin     # default 123456
ykman piv access change-puk     # default 12345678
```

Change the management key. **Option A (recommended):** generate a random key and protect it with your PIN, so you don't have to remember it:

```bash
ykman piv access change-management-key --generate --protect
```

**Option B:** generate a key and store it yourself (offline, printed, QR …):

```bash
ykman piv access change-management-key --generate
```

> Older firmware may need an explicit algorithm, e.g. `-a TDES`.

---

## 2.4 OpenPGP — User PIN and Admin PIN

> 💡 Planning to use OpenPGP ([chapter 5](05_openpgp_gpg_ssh.md))? Do the **KDF setup** in section 5.2 **first**, then come back here. KDF must be enabled while the PINs are still the defaults.

```bash
ykman openpgp access change-pin          # default 123456
ykman openpgp access change-admin-pin    # default 12345678
```

---

## 2.5 Done?

Run this quick check — every command should now ask for **your own** PIN, not a default one:

```bash
ykman fido credentials list
ykman piv info
ykman openpgp info
```

---

[← 1. Installation](01_installation.md) · [Overview](README.md) · Next: [3. TOTP codes →](03_totp_oath.md)
