---

date: 2025-09-01T12:30:21+01:00
title: "YubiKey on Linux — Get started the safe way"
draft: false
description: "A chapter-by-chapter guide to setting up and using a YubiKey from the Linux CLI (Debian/Ubuntu and Fedora)"

---

# 🔐 YubiKey on Linux — Get Started the Safe Way

A practical guide to using a YubiKey from the Linux command line.
Commands are given for **Debian/Ubuntu** (`apt`) and **Fedora** (`dnf`).

> Hardware tokens can raise your security to a very high level — **but only when they are configured and used correctly.**
> A badly configured token gives you a *false sense of security*, not actual protection.

---

## 📚 Chapters

Work through chapters 1 and 2 first. After that, pick the chapters for the functions you actually use.

| #  | Chapter | What you get | Required? |
|----|---------|--------------|-----------|
| 1  | [Installation](01_installation.md) | All packages, `pcscd`, `ykman` (Debian/Ubuntu + Fedora) | ✅ Yes |
| 2  | [First-time setup](02_first_time_setup.md) | Replace every default PIN, PUK and key | ✅ Yes |
| 3  | [TOTP codes (OATH)](03_totp_oath.md) | Authenticator codes on the YubiKey, clipboard + rofi helpers | Optional |
| 4  | [SSH with FIDO2](04_ssh_fido2.md) | The simplest secure SSH key — good place to start | Optional |
| 5  | [OpenPGP: GPG + SSH](05_openpgp_gpg_ssh.md) | GPG subkeys on the YubiKey, used for email, Git signing and SSH | Optional |
| 6  | [age encryption (PIV)](06_age_piv.md) | File encryption with `age` and multiple YubiKeys | Optional |
| 7  | [Linux login with PAM](07_linux_login_pam.md) | YubiKey for `sudo`, desktop and TTY login | Optional |
| 8  | [Troubleshooting](08_troubleshooting.md) | Card not found, wrong SSH agent, PIN locked, … | Reference |

**Suggested learning path:** 1 → 2 → 3 → 4 → 5. SSH with FIDO2 (chapter 4) is a good warm-up; OpenPGP (chapter 5) is more complex but more powerful.

---

## 🧩 What can a YubiKey do?

| Category | Function | Description | PIN | Touch | Chapter |
|----------|----------|-------------|-----|-------|---------|
| 🔑 Modern auth | **FIDO2** | WebAuthn / passkeys, SSH `-sk` keys, PAM login | ✅ | ✅ | 4, 7 |
| | **U2F** | Older version of FIDO (second factor only) | ❌ | ✅ | 7 |
| 🔢 Codes | **OATH-TOTP** | Authenticator codes (like Google Authenticator) | Optional password | Optional | 3 |
| | **Yubico OTP** | Yubico's own one-time-password format | ❌ | ✅ | — |
| 🪪 Keys & certificates | **PIV** | Smartcard: certificates, VPN, `age` | ✅ | Optional | 2, 6 |
| | **OpenPGP** | GPG keys for email, signing and SSH | ✅ | Optional | 2, 5 |
| ⚙️ Advanced / legacy | **Challenge-response** | LUKS, custom scripts | ❌ | Optional | — |
| | **Static password** | Types a fixed password (not recommended) | ❌ | ✅ | — |

---

## 🚨 Golden rules

1. **Change every default** (chapter 2) before you trust the key with anything.
2. **Buy two YubiKeys.** Register both everywhere. One is a backup that stays in a safe place.
3. **Store your PUK, management key and GPG backups offline** (paper, QR code, encrypted USB in a safe).
4. **Never use SSH agent forwarding** (`ssh -A` / `ForwardAgent yes`). Use `ProxyJump` instead (see chapter 5).
5. **Test in a second terminal** before you log out when changing login/PAM settings.

---

## 📖 Source

Partly based on and modified from Yubico's guide
👉 **[Securing SSH with FIDO2](https://developers.yubico.com/SSH/Securing_SSH_with_FIDO2.html)**
