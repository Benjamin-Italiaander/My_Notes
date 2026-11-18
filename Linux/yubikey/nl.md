---
title: "YubiKey op Linux — veilig beginnen"
date: 2025-11-18
description: "Een handleiding per hoofdstuk voor het instellen en gebruiken van een YubiKey vanaf de Linux-CLI (Debian/Ubuntu en Fedora)."
translated_by_ai: true
translated_from: "en"
original: "README.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](README.md).* De commando's zijn niet vertaald.

# 🔐 YubiKey op Linux — veilig beginnen

Een praktische handleiding voor het gebruik van een YubiKey vanaf de Linux-commandoregel.
De commando's staan erbij voor **Debian/Ubuntu** (`apt`) en **Fedora** (`dnf`).

> Hardwaretokens kunnen je beveiliging naar een heel hoog niveau tillen — **maar alleen als ze goed zijn ingesteld en goed worden gebruikt.**
> Een slecht ingesteld token geeft je *schijnveiligheid*, geen echte bescherming.

---

## 📚 Hoofdstukken

Doe eerst hoofdstuk 1 en 2. Kies daarna de hoofdstukken voor de functies die je echt gebruikt.

| #  | Hoofdstuk | Wat je krijgt | Verplicht? |
|----|---------|--------------|-----------|
| 1  | [Installatie](01_installation_nl.md) | Alle pakketten, `pcscd`, `ykman` (Debian/Ubuntu + Fedora) | ✅ Ja |
| 2  | [Eerste instelling](02_first_time_setup_nl.md) | Elke standaard-PIN, -PUK en -sleutel vervangen | ✅ Ja |
| 3  | [TOTP-codes (OATH)](03_totp_oath_nl.md) | Authenticatorcodes op de YubiKey, hulpjes voor klembord + rofi | Optioneel |
| 4  | [SSH met FIDO2](04_ssh_fido2_nl.md) | De eenvoudigste veilige SSH-sleutel — een goed begin | Optioneel |
| 5  | [OpenPGP: GPG + SSH](05_openpgp_gpg_ssh_nl.md) | GPG-subsleutels op de YubiKey, voor e-mail, Git-ondertekening en SSH | Optioneel |
| 6  | [Versleutelen met age (PIV)](06_age_piv_nl.md) | Bestanden versleutelen met `age` en meerdere YubiKeys | Optioneel |
| 7  | [Inloggen op Linux met PAM](07_linux_login_pam_nl.md) | YubiKey voor `sudo`, het bureaublad en inloggen op een TTY | Optioneel |
| 8  | [Problemen oplossen](08_troubleshooting_nl.md) | Kaart niet gevonden, verkeerde SSH-agent, PIN geblokkeerd, … | Naslag |

**Voorgestelde volgorde:** 1 → 2 → 3 → 4 → 5. SSH met FIDO2 (hoofdstuk 4) is een goede opwarmer; OpenPGP (hoofdstuk 5) is ingewikkelder maar krachtiger.

---

## 🧩 Wat kan een YubiKey?

| Categorie | Functie | Beschrijving | PIN | Aanraken | Hoofdstuk |
|----------|----------|-------------|-----|-------|---------|
| 🔑 Moderne authenticatie | **FIDO2** | WebAuthn / passkeys, SSH `-sk`-sleutels, inloggen via PAM | ✅ | ✅ | 4, 7 |
| | **U2F** | Oudere versie van FIDO (alleen als tweede factor) | ❌ | ✅ | 7 |
| 🔢 Codes | **OATH-TOTP** | Authenticatorcodes (zoals Google Authenticator) | Optioneel wachtwoord | Optioneel | 3 |
| | **Yubico OTP** | Het eigen eenmalige-wachtwoordformaat van Yubico | ❌ | ✅ | — |
| 🪪 Sleutels & certificaten | **PIV** | Smartcard: certificaten, VPN, `age` | ✅ | Optioneel | 2, 6 |
| | **OpenPGP** | GPG-sleutels voor e-mail, ondertekenen en SSH | ✅ | Optioneel | 2, 5 |
| ⚙️ Geavanceerd / verouderd | **Challenge-response** | LUKS, eigen scripts | ❌ | Optioneel | — |
| | **Statisch wachtwoord** | Typt een vast wachtwoord (niet aanbevolen) | ❌ | ✅ | — |

---

## 🚨 Gouden regels

1. **Verander alle standaardwaarden** (hoofdstuk 2) voordat je de sleutel ergens voor vertrouwt.
2. **Koop twee YubiKeys.** Registreer ze allebei overal. Eén is een reserve die op een veilige plek blijft.
3. **Bewaar je PUK, managementsleutel en GPG-back-ups offline** (papier, QR-code, versleutelde USB-stick in een kluis).
4. **Gebruik nooit SSH agent forwarding** (`ssh -A` / `ForwardAgent yes`). Gebruik in plaats daarvan `ProxyJump` (zie hoofdstuk 5).
5. **Test in een tweede terminal** voordat je uitlogt als je login/PAM-instellingen wijzigt.

---

## 📖 Bron

Deels gebaseerd op, en aangepast vanuit, de handleiding van Yubico
👉 **[Securing SSH with FIDO2](https://developers.yubico.com/SSH/Securing_SSH_with_FIDO2.html)**
