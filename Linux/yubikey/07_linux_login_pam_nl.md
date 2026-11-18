---
title: "YubiKey 7 — Inloggen op Linux met PAM (sudo, bureaublad, TTY)"
date: 2025-11-18
description: "Gebruik je YubiKey voor sudo, het bureaublad (GDM) en inloggen op een TTY met pam_u2f, op Debian/Ubuntu en Fedora."
translated_by_ai: true
translated_from: "en"
original: "07_linux_login_pam.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](07_linux_login_pam.md).* De commando's zijn niet vertaald.

# 7. Inloggen op Linux met PAM (sudo, bureaublad, TTY)

[← 6. Versleutelen met age](06_age_piv_nl.md) · [Overzicht](nl.md) · Volgende: [8. Problemen oplossen →](08_troubleshooting_nl.md)

**Doel:** je YubiKey (aanraken) verplicht maken voor `sudo`, `su`, het inloggen op het bureaublad (GDM) en op een TTY, met `pam_u2f` (FIDO2/U2F).

> 🚨 **Je kunt jezelf buitensluiten.** Houd een **root-shell open in een tweede terminal** (`sudo -i`) terwijl je PAM-bestanden aanpast, en test voordat je uitlogt. Gaat er iets mis, verwijder dan de regel die je hebt toegevoegd.

---

## 7.1 Installeren

```bash
sudo apt install libpam-u2f pamu2fcfg     # Debian/Ubuntu
sudo dnf install pam-u2f pamu2fcfg        # Fedora
```

---

## 7.2 Je YubiKey(s) registreren

```bash
mkdir -p ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys      # touch the key when it blinks
```

Voeg een **reserve-YubiKey** toe (steek hem erin, en dan):

```bash
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
```

> `-n` laat de gebruikersnaam weg, zodat de tweede sleutel aan **dezelfde regel** wordt toegevoegd. Het bestand moet één regel bevatten: `username:key1...:key2...`

---

## 7.3 Twee modi

| Modus | PAM-regel | Effect |
|------|----------|--------|
| 🔐 **2FA** | `auth required pam_u2f.so` | Wachtwoord **én** YubiKey aanraken |
| 🛡 **Zonder wachtwoord** | `auth sufficient pam_u2f.so` | YubiKey aanraken **of** wachtwoord |

Zet de regel **bovenaan** het PAM-bestand (vóór de andere `auth`-regels).

---

## 7.4 Ubuntu / Debian — de PAM-bestanden aanpassen

Begin met `sudo` — dat is het makkelijkst te testen.

| Wat | Bestand |
|------|------|
| sudo | `/etc/pam.d/sudo` |
| su | `/etc/pam.d/su` |
| Inloggen op het bureaublad (GNOME) | `/etc/pam.d/gdm-password` |
| Inloggen op een TTY | `/etc/pam.d/login` |

```bash
sudo nano /etc/pam.d/sudo
```

Voeg bovenaan toe:

```
auth       sufficient   pam_u2f.so cue
```

(`cue` toont "Please touch the device.", zodat je weet dat hij wacht.)

Test in een **nieuwe** terminal:

```bash
sudo -k && sudo ls
```

Werkt het? Herhaal dit voor de andere bestanden.

---

## 7.5 Fedora — gebruik authselect

Fedora beheert PAM via `authselect`; pas `/etc/pam.d/system-auth` niet met de hand aan (dat wordt overschreven).

```bash
authselect current                                # show current profile + features

# Passwordless: YubiKey OR password (sufficient)
sudo authselect enable-feature with-pam-u2f

# — or — 2FA: password AND YubiKey (required)
sudo authselect enable-feature with-pam-u2f-2fa

sudo authselect apply-changes
```

Dit zet de YubiKey aan voor alles wat `system-auth` gebruikt (sudo, su, GDM, TTY).

Wil je het alleen voor `sudo`? Voeg dan bovenaan `/etc/pam.d/sudo` toe:

```
auth       sufficient   pam_u2f.so cue
```

Ongedaan maken:

```bash
sudo authselect disable-feature with-pam-u2f       # or with-pam-u2f-2fa
sudo authselect apply-changes
```

---

## 7.6 Testen voordat je uitlogt

1. Houd een root-shell open: `sudo -i` in een tweede terminal.
2. Test `sudo -k && sudo ls` in een nieuwe terminal.
3. Test het inloggen op een TTY: **Ctrl+Alt+F3**, log in, en ga terug met **Ctrl+Alt+F1/F2**.
4. Log pas daarna uit en test het inloggen op het bureaublad.

Werkt het niet? Verwijder vanuit je open root-shell de regel / zet de authselect-functie uit.

---

[← 6. Versleutelen met age](06_age_piv_nl.md) · [Overzicht](nl.md) · Volgende: [8. Problemen oplossen →](08_troubleshooting_nl.md)
