---
title: "YubiKey 1 — Installatie (Debian/Ubuntu en Fedora)"
date: 2025-11-18
description: "Installeer GnuPG, pcscd en ykman, en zorg dat je YubiKey wordt herkend."
translated_by_ai: true
translated_from: "en"
original: "01_installation.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](01_installation.md).* De commando's zijn niet vertaald.

# 1. Installatie

[← Terug naar het overzicht](nl.md) · Volgende: [2. Eerste instelling →](02_first_time_setup_nl.md)

**Doel:** de software installeren, de smartcard-daemon starten en je YubiKey zien met `ykman info` en `gpg --card-status`.

| Pakket | Wat het is |
|---------|------------|
| GnuPG (`gnupg2`) | De universele crypto-engine (OpenPGP) |
| scdaemon | Smartcard-daemon voor GnuPG |
| pcsc-lite / pcscd | PC/SC-smartcard-daemon (praat met de YubiKey) |
| yubikey-manager | `ykman`, de CLI voor de YubiKey |
| pcsc-tools | `pcsc_scan`, handig bij het zoeken naar fouten |

---

## 1.1 Debian / Ubuntu

```bash
sudo apt update
sudo apt install gnupg2 scdaemon pcscd pcsc-tools yubikey-manager yubikey-personalization pipx
sudo systemctl enable --now pcscd.socket
```

Optioneel (alleen Ubuntu) — nieuwere Yubico-pakketten uit de officiële PPA:

```bash
sudo apt-add-repository ppa:yubico/stable
sudo apt update
sudo apt install yubikey-manager
```

---

## 1.2 Fedora

### Stap 1 — De pakketten installeren

```bash
sudo dnf install gnupg2 gnupg2-scdaemon gnupg2-smime \
                 pcsc-lite pcsc-tools \
                 yubikey-manager yubikey-personalization
```

### Stap 2 — De smartcard-daemon aanzetten

`pcscd` wordt via een socket gestart: de socket aanzetten is genoeg, de dienst start vanzelf als hij nodig is.

```bash
sudo systemctl enable --now pcscd.socket
sudo systemctl status pcscd.socket
```

### Stap 3 — Controleren of de YubiKey wordt gezien

```bash
lsusb | grep -i yubi
gpg --card-status
```

Werkt `gpg --card-status`, dan kun je stap 4 overslaan.

### Stap 4 — Polkit-regel (alleen bij "access denied" / "No such device")

Op Fedora bepaalt polkit wie met `pcscd` mag praten. In sommige situaties (bijvoorbeeld SSH-sessies, of een sessie die polkit niet als "actief" ziet) krijgt je gebruiker geen toegang tot de kaart. Deze regel geeft **jouw gebruiker** toegang:

```bash
sudo tee /etc/polkit-1/rules.d/50-pcscd-access.rules > /dev/null << EOF
polkit.addRule(function(action, subject) {
  if ((action.id == "org.debian.pcsc-lite.access_pcsc" ||
       action.id == "org.debian.pcsc-lite.access_card") &&
      subject.user == "$USER") {
    return polkit.Result.YES;
  }
});
EOF

sudo systemctl restart polkit.service
sudo systemctl status polkit.service
```

> `$USER` wordt bij het uitvoeren ingevuld met je gebruikersnaam. Controleer het resultaat met
> `cat /etc/polkit-1/rules.d/50-pcscd-access.rules`.
>
> ⚠️ Gebruik `sudo tee`, niet `sudo cat > bestand` — de omleiding `>` draait als je gewone gebruiker en mislukt met *Permission denied*.

### Stap 5 — gpg-agent als SSH-agent gebruiken (alleen voor [hoofdstuk 5](05_openpgp_gpg_ssh_nl.md))

Voeg de agentinstellingen toe aan je shellconfiguratie (`>>` = toevoegen!):

```bash
cat >> ~/.bashrc << 'EOF'

# YubiKey: use gpg-agent for SSH
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
EOF
```

> ⚠️ Gebruik `>>`, **niet** `>`. Eén `>` overschrijft je hele `~/.bashrc`.
> Gebruik je zsh? Zet dezelfde regels dan in `~/.zshrc`.

Stop een eventueel draaiende `ssh-agent`, laad de shell opnieuw en test:

```bash
pkill ssh-agent
source ~/.bashrc
gpg --card-status
ssh-add -L                  # should show a key ending in "cardno:XXXXXXXX"
ssh your-server
```

---

## 1.3 De installatie controleren {#13-verify-the-installation}

```bash
ykman info
```

Voorbeelduitvoer:

```
Device type: YubiKey 5C NFC
Serial number: 12345678
Firmware version: 5.7.4
Form factor: Keychain (USB-C)
Enabled USB interfaces: OTP, FIDO, CCID

Applications   USB      NFC
Yubico OTP     Enabled  Enabled
FIDO U2F       Enabled  Enabled
FIDO2          Enabled  Enabled
OATH           Enabled  Enabled
PIV            Enabled  Enabled
OpenPGP        Enabled  Enabled
YubiHSM Auth   Enabled  Enabled
```

Werkt het niet? Zie [8. Problemen oplossen](08_troubleshooting_nl.md).

---

## 1.4 (Gevorderd) De nieuwste `ykman` vanuit de broncode installeren

Het pakket van je distributie is voor de meeste mensen prima. Heb je de nieuwste versie nodig, kies dan één methode:

| Methode | Isolatie | Invloed op het systeem | Aanbevolen voor |
|--------|-----------|---------------|-----------------|
| **pipx** | Hoog | Geen | CLI-gebruikers (mijn favoriet) |
| **Virtuele omgeving** | Hoog | Geen | Testen / ontwikkelen |
| **Systeembrede pip** | Laag | Kan distributiepakketten breken | Alleen experts |

### Optie A — pipx (aanbevolen)

```bash
sudo apt install pipx        # Debian/Ubuntu
sudo dnf install pipx        # Fedora
pipx ensurepath

pipx install yubikey-manager                                         # latest release
# or the development version straight from Git:
pipx install git+https://github.com/Yubico/yubikey-manager.git

ykman -v
pipx upgrade yubikey-manager                                         # update later
```

### Optie B — virtuele Python-omgeving

```bash
git clone https://github.com/Yubico/yubikey-manager.git
cd yubikey-manager
python3 -m venv .venv
source .venv/bin/activate
pip install .
ykman -v
```

> Wil je het buiten de venv gebruiken, roep het dan aan met het volledige pad, bijvoorbeeld `~/yubikey-manager/.venv/bin/ykman`.

### Optie C — systeembrede pip (⚠️ alleen voor experts)

```bash
git clone https://github.com/Yubico/yubikey-manager.git
cd yubikey-manager
pip install . --break-system-packages
```

> Dit kan botsen met het pakket `yubikey-manager` van je distributie. Verwijder dat eerst.

---

[← Terug naar het overzicht](nl.md) · Volgende: [2. Eerste instelling →](02_first_time_setup_nl.md)
