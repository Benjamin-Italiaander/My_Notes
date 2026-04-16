---

date: 2025-09-01T12:30:21+01:00
title: "YubiKey Get started the safe way"
draft: false
description: "A short Getting Started Using the Linux CLI"

---


# 🔐 YubiKey Advanced Quickstart
### A Short Getting Started Guide (Linux CLI)

This guide is structured **per YubiKey function**.

Each section focuses on one specific feature (e.g. FIDO2, OpenPGP, PIV) and explains the **minimum required configuration** for that function.

You can follow only the parts relevant to your use case—but make sure to fully complete the steps for any function you decide to use.

---

##  Installation

1. [Install all dependencies required for ykman](EN_Install_all_dependencies.md)  
2. [Install ykman](EN_yubikey_install_ykman.md)

---

##  Important

Each section in this guide represents the **absolute minimum setup** for a specific YubiKey function.

If you skip steps within a section, that function may **not be secure or behave as expected**.

Hardware tokens are powerful tools that can significantly improve your security—but **only when configured and used correctly**.

> Using a hardware token incorrectly can create a **false sense of security** rather than actually protecting your environment.

---
## 🔐 YubiKey Built-in Functions Overview

| Category              | Function            | Description                                              | Needs PIN   | Needs Touch | Typical Use              |
|----------------------|--------------------|----------------------------------------------------------|------------|------------|--------------------------|
| **🔑 Modern Auth**    | **FIDO2**           | WebAuthn (modern passwordless login)                    | ✅          | ✅          | Modern login             |
|                      | **U2F**             | Older version of FIDO                                   | ❌          | ✅          | Older 2FA                |
| **🔢 Auth Codes**     | **OATH-TOTP**       | Authenticator codes (like Google Authenticator)         | Optional   | ❌          | Authenticator codes      |
|                      | **OTP (Yubico)**    | Yubico OTP (Yubico’s own format)                        | ❌          | ✅          | Legacy login             |
| **🪪 Certificates & Keys** | **PIV**       | Smart card (Windows login, VPN, certificates)           | ✅          | ❌          | Smartcard login          |
|                      | **OpenPGP**         | GPG keys for SSH and email encryption/signing           | ✅          | ❌          | SSH, email               |
| **⚙️ Advanced / Legacy** | **Challenge-Response** | Advanced use (e.g. LUKS, custom scripts)        | ❌          | ❌          | Advanced setups          |
|                      | **Static Password** | Types a fixed password (legacy, not recommended)        | ❌          | ✅          | Legacy                   |

3. Lets Get started with coping your [TOTP tokens to your yubikey](https://github.com/Benjamin-Italiaander/My_Notes/blob/main/Linux/yubikey/EN_yubikey_otp.md)
4. Let's contieue with creating a SSH key, this is just to practise a bit becaus i recomend you use openPGP for this part. But since openPGP is a little bit of a complex [lets start with SSH and your yubikey](https://github.com/Benjamin-Italiaander/My_Notes/blob/main/Linux/yubikey/EN_yubikey_ssh.md)

## 📚 Source

This guide is based on and modified from:  
👉 **[Securing SSH with FIDO2](https://developers.yubico.com/SSH/Securing_SSH_with_FIDO2.html)**

---

## 🚨 Security Warning

> **Never use SSH agent forwarding with your YubiKey.**  
> Avoid using `ssh -A` (or `ssh -a`).  
> In general, it is best to avoid agent forwarding entirely.
