---
title: "YubiKey 4 — SSH met FIDO2"
date: 2025-11-18
description: "Maak met FIDO2 een SSH-sleutel die op je YubiKey staat (ed25519-sk) en gebruik hem op elke computer."
translated_by_ai: true
translated_from: "en"
original: "04_ssh_fido2.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](04_ssh_fido2.md).* De commando's zijn niet vertaald.

# 4. SSH met FIDO2

[← 3. TOTP-codes](03_totp_oath_nl.md) · [Overzicht](nl.md) · Volgende: [5. OpenPGP →](05_openpgp_gpg_ssh_nl.md)

**Doel:** een SSH-sleutel waarvan het privédeel de YubiKey nooit verlaat. Dit is de **eenvoudigste** veilige manier om SSH met een YubiKey te gebruiken. (OpenPGP, hoofdstuk 5, is flexibeler maar ingewikkelder.)

**Voordat je begint:** rond [hoofdstuk 2](02_first_time_setup_nl.md) af — in elk geval de FIDO2-PIN. Je moet het verschil tussen een privésleutel en een publieke sleutel kennen.

---

## 4.1 Hoe het werkt

- De **echte privésleutel** wordt **in de YubiKey** gemaakt en bewaard — hij kan er nooit uit worden gehaald of erin worden gezet.
- In `~/.ssh` komt een klein bestand met een **key handle** (verwijzing naar de sleutel).
- Om in te loggen heb je de **YubiKey + aanraken (+ PIN)** nodig.

| Nooit delen | Veilig om te delen |
|-------------|---------------|
| `~/.ssh/yubikey` (key handle) | `~/.ssh/yubikey.pub` (publieke sleutel) |
| je YubiKey | |

> 💡 Zet inloggen met een wachtwoord uit op je servers (`PasswordAuthentication no`) om er het meeste uit te halen.

---

## 4.2 De FIDO2-PIN controleren

```bash
ykman fido info
```

```
PIN:                          Not set     ← must be set!
Minimum PIN length:           4
Always Require UV:            Off
```

Nog niet ingesteld? → `ykman fido access change-pin` (zie [2.2](02_first_time_setup_nl.md)).

---

## 4.3 De sleutel maken

```bash
ssh-keygen -t ed25519-sk -O resident -O verify-required \
  -f ~/.ssh/yubikey \
  -C "your-name yubikey"
```

- Druk twee keer op **Enter** voor geen wachtzin (de PIN + aanraking beschermen hem al).
- **Raak** de YubiKey aan als hij knippert.

```
You may need to touch your authenticator to authorize key generation.
Your identification has been saved in /home/user/.ssh/yubikey
Your public key has been saved in /home/user/.ssh/yubikey.pub
```

| Optie | Betekenis |
|--------|---------|
| `-t ed25519-sk` | SSH-sleutel op basis van FIDO2 |
| `-O resident` | Bewaar de gegevens op de YubiKey (op een andere pc terug te halen, zie 4.5) |
| `-O verify-required` | Vraag bij elke login om **PIN + aanraken** |
| `-O application=ssh:<name>` | Optioneel label — handig als je meerdere sleutels hebt |
| `-C "comment"` | Opmerking in de publieke sleutel |

👉 Herhaal dit met je **reserve-YubiKey** (bijvoorbeeld `-f ~/.ssh/yubikey-backup`) en zet beide publieke sleutels op je servers.

---

## 4.4 De publieke sleutel op een server zetten

```bash
ssh-copy-id -i ~/.ssh/yubikey.pub user@server
```

Log daarna in:

```bash
ssh -i ~/.ssh/yubikey user@server
```

1. Start de verbinding → 2. Typ de FIDO2-PIN → 3. Raak de YubiKey aan.

Leg het vast in `~/.ssh/config`:

```sshconfig
Host myserver
    HostName server.example.com
    User user
    IdentityFile ~/.ssh/yubikey
```

---

## 4.5 De sleutel op een nieuwe computer gebruiken

Omdat de sleutel *resident* is, kun je de key handle terughalen van de YubiKey:

```bash
cd ~/.ssh
ssh-keygen -K        # writes id_ed25519_sk_rk* files to the current directory
```

---

[← 3. TOTP-codes](03_totp_oath_nl.md) · [Overzicht](nl.md) · Volgende: [5. OpenPGP →](05_openpgp_gpg_ssh_nl.md)
