---
title: "YubiKey 3 — TOTP-codes (OATH)"
date: 2025-11-18
description: "Bewaar authenticatorcodes (TOTP) op je YubiKey en haal ze op in de terminal, het klembord of een rofi-menu."
translated_by_ai: true
translated_from: "en"
original: "03_totp_oath.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](03_totp_oath.md).* De commando's zijn niet vertaald.

# 3. TOTP-codes (OATH)

[← 2. Eerste instelling](02_first_time_setup_nl.md) · [Overzicht](nl.md) · Volgende: [4. SSH met FIDO2 →](04_ssh_fido2_nl.md)

**Doel:** je authenticatorcodes (GitHub, Google, …) op de YubiKey bewaren in plaats van (of naast) je telefoon.

### Waarom een bestaand TOTP-geheim kopiëren?

Als een website je een QR-code laat zien, toont hij ook een geheim als tekst (Base32, bijvoorbeeld `JBSWY3DPEHPK3PXP`). Zet je **datzelfde geheim** op meerdere YubiKeys (en/of in een authenticator-app), dan geven ze allemaal dezelfde codes — zo heb je een reserve.

> ⚠️ Een TOTP-geheim is net zo gevoelig als een wachtwoord: **iedereen met het geheim kan jouw codes maken.**
> Doe dit alleen als je dat begrijpt, en bewaar het geheim nooit als platte tekst.

---

## 3.1 OATH beveiligen met een wachtwoord

```bash
ykman oath info
```

```
OATH version:        5.7.4
Password protection: disabled
```

Zet de wachtwoordbeveiliging aan:

```bash
ykman oath access change
ykman oath info               # should now say: Password protection: enabled
```

---

## 3.2 Een TOTP-account toevoegen

**Aanbevolen:** laat het geheim weg — `ykman` vraagt er dan om, zodat het niet in je shellgeschiedenis belandt:

```bash
ykman oath accounts add --touch "GitHub:myusername"
# Enter a secret key (base32): ****************
```

Of met het geheim op de commandoregel (komt in je geschiedenis!):

```bash
ykman oath accounts add --touch --digits 6 --period 30 "GitHub:myusername" JBSWY3DPEHPK3PXP
```

| Optie | Betekenis |
|--------|---------|
| `--touch` | De code verschijnt pas na het aanraken van de sleutel |
| `--digits 6` | Lengte van de code (6 is standaard) |
| `--period 30` | Elke 30 seconden een nieuwe code (standaard) |
| `"Issuer:name"` | De naam in de lijst |

> 🧹 Het geheim op de commandoregel gebruikt? Ruim daarna op:
> bash: `history -c` · zsh: verwijder de regel uit `~/.zsh_history` · en maak de terminal leeg met `clear`.

👉 Herhaal dit voor je reserve-YubiKey.

---

## 3.3 Codes opvragen

```bash
ykman oath accounts list               # all accounts
ykman oath accounts code               # all codes
ykman oath accounts code github        # matching accounts (partial name is fine)
```

---

## 3.4 Handige snelkoppelingen

### Een code naar het klembord kopiëren

```bash
ykman oath accounts code "GitHub:myusername" | awk '{print $NF}' | xclip -selection c
```

> Wayland? Gebruik `wl-copy` in plaats van `xclip -selection c`.

### Shellfunctie (`~/.bashrc` of `~/.zshrc`)

```bash
totp() {
    ykman oath accounts code "$1" | awk '{print $NF}' | xclip -selection c
    echo "Copied TOTP for $1 to clipboard."
}
```

Gebruik: `totp github`

### rofi-menu

Kies een account in rofi; de code wordt naar het klembord gekopieerd.
Nodig: `ykman`, `rofi`, `xclip`, en eventueel `notify-send` (`libnotify-bin` op Debian, `libnotify` op Fedora).

```bash
#!/usr/bin/env bash
set -euo pipefail

accounts=$(ykman oath accounts list || true)

if [ -z "$accounts" ]; then
    notify-send "YubiKey TOTP" "No OATH accounts found (or YubiKey not inserted)." || true
    exit 1
fi

selection=$(printf '%s\n' "$accounts" | rofi -dmenu -p "YubiKey TOTP") || exit 0
[ -z "$selection" ] && exit 0

code=$(ykman oath accounts code "$selection" | awk '{print $NF}')
printf '%s' "$code" | xclip -selection c

notify-send "YubiKey TOTP" "Code for '$selection' copied to clipboard." || true
```

---

[← 2. Eerste instelling](02_first_time_setup_nl.md) · [Overzicht](nl.md) · Volgende: [4. SSH met FIDO2 →](04_ssh_fido2_nl.md)
