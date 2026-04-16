---

date: 2025-09-01T12:30:21+01:00
title: "YubiKey Get started the safe way"
draft: false
description: "A short Getting Started Using the Linux CLI"

---


# YubiKey Advanced quiqstart
### A Short Getting Started Guide (Linux CLI)

In the following steps, I will show you what you should **at minimum configure** seperated per by each yubikey function.

## 📦 Installation

1. [Install all dependencies to be able to install ykman](EN_Install_all_dependencies.md)  
2. [Install ykman](EN_yubikey_install_ykman.md)

---

## ⚠️ Important

My manual are the **absolute bare minimum** you should complete before using your YubiKey for each function.

If you skip some of these steps, there is nothing truly secure about using your YubiKey.

Hardware tokens are a powerful tool and can significantly improve your security—but **only when used correctly**.

> Using a hardware token incorrectly does **not** make your environment more secure.

---

## 🧠 YubiKey Built-in Functions

The YubiKey contains multiple built-in authentication functions:

| Function            | Description |
|--------------------|------------|
| **OATH-TOTP**       | Authenticator codes (like Google Authenticator) |
| **OTP**             | Yubico OTP (Yubico’s own format) |
| **FIDO2**           | WebAuthn (modern passwordless login) |
| **U2F**             | Older version of FIDO |
| **PIV**             | Smart card functionality (Windows login, VPN, certificates) |
| **OpenPGP**         | GPG keys for SSH authentication and email encryption/signing |
| **Challenge-Response** | Advanced use (e.g. LUKS disk encryption, custom scripts) |
| **Static Password** | Types a fixed password (legacy, not recommended) |

---

## 🔐 Function Overview

| Function            | Needs PIN   | Needs Touch | Typical Use              |
|--------------------|------------|------------|--------------------------|
| FIDO2              | ✅          | ✅          | Modern login             |
| U2F                | ❌          | ✅          | Older 2FA                |
| OTP (Yubico)       | ❌          | ✅          | Legacy login             |
| OATH-TOTP          | Optional   | ❌          | Authenticator codes      |
| PIV                | ✅          | ❌          | Smartcard login          |
| OpenPGP            | ✅          | ❌          | SSH, email               |
| Challenge-Response | ❌          | ❌          | Advanced setups          |
| Static Password    | ❌          | ✅          | Legacy (not recommended) |

---

## 📚 Source

This guide is based on and modified from:  
👉 **[Securing SSH with FIDO2](https://developers.yubico.com/SSH/Securing_SSH_with_FIDO2.html)**

---

## 🚨 Security Warning

> **Never use SSH agent forwarding with your YubiKey.**  
> Avoid using `ssh -A` (or `ssh -a`).  
> In general, it is best to avoid agent forwarding entirely.
