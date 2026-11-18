---
title: "YubiKey 8 — Problemen oplossen"
date: 2025-11-18
description: "Oplossingen voor veelvoorkomende YubiKey-problemen op Linux: kaart niet gevonden, verkeerde SSH-agent, geblokkeerde PIN's."
translated_by_ai: true
translated_from: "en"
original: "08_troubleshooting.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](08_troubleshooting.md).* De commando's zijn niet vertaald.

# 8. Problemen oplossen

[← 7. Inloggen op Linux](07_linux_login_pam_nl.md) · [Overzicht](nl.md)

## 🧪 Snelle controles

Doe deze eerst — ze laten zien waar het probleem zit:

```bash
lsusb | grep -i yubi                     # is the key on USB?
systemctl status pcscd.socket            # is the smartcard daemon running?
ykman info                               # can ykman talk to it?
gpg --card-status                        # can GnuPG talk to it?
gpg -K                                   # ssb> = subkey on the YubiKey
echo $SSH_AUTH_SOCK                      # which SSH agent is used?
ssh-add -L                               # which keys does the agent offer?
ssh -vvv host                            # what happens during login?
```

---

## De YubiKey wordt niet gevonden

### `gpg --card-status` → *No such device* / *Card not present*

1. Draait `pcscd`?
   ```bash
   sudo systemctl enable --now pcscd.socket
   ```
2. Herstart scdaemon:
   ```bash
   gpgconf --kill scdaemon
   gpg --card-status
   ```
3. Laat scdaemon `pcscd` gebruiken in plaats van een eigen USB-driver — voeg toe aan `~/.gnupg/scdaemon.conf`:
   ```conf
   disable-ccid
   ```
   en daarna `gpgconf --kill scdaemon`.
4. **Fedora:** *access denied* van polkit → voeg de polkit-regel uit [1.2 stap 4](01_installation_nl.md) toe.

### `ykman` werkt maar `gpg` niet (of andersom)

Maar één programma tegelijk kan de kaart gebruiken. Stop het andere:

```bash
gpgconf --kill scdaemon      # frees the card for ykman
```

---

## OpenPGP / SSH via gpg-agent

### ❌ Verkeerde SSH-agent

```bash
echo $SSH_AUTH_SOCK
```

| ✅ Goed | ❌ Fout |
|---------|----------|
| `/run/user/1000/gnupg/S.gpg-agent.ssh` | `/run/user/1000/keyring/ssh` (GNOME Keyring) |
| | `/run/user/1000/gcr/ssh` (GNOME gcr, Fedora) |
| | `/tmp/ssh-XXXX/agent.NNNN` (ssh-agent) |

Oplossing:

```bash
pkill ssh-agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
```

en zorg dat de regels uit [5.9](05_openpgp_gpg_ssh_nl.md) in je `~/.bashrc` / `~/.zshrc` staan.

### ❌ *sign_and_send_pubkey: signing failed* / *agent refused operation*

De agent weet niet in welke terminal hij om de PIN moet vragen:

```bash
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye
```

### ❌ `ssh-add -L` toont geen `cardno:`-sleutel

- Staat `enable-ssh-support` in `~/.gnupg/gpg-agent.conf`? Doe dan `gpgconf --kill gpg-agent`.
- Toont `gpg --card-status` een **Authentication key**? Zo niet, zie [5.6](05_openpgp_gpg_ssh_nl.md).

### ❌ De server accepteert de sleutel niet

Vergelijk de sleutel die de agent aanbiedt met die op de server:

```bash
gpg --export-ssh-key <KEYID>        # on your computer
cat ~/.ssh/authorized_keys          # on the server
```

In `ssh -vvv host` wil je dit zien:

```
Offering public key: cardno:...
Server accepts key: cardno:...
```

Controleer ook de rechten op de server: `~/.ssh` = `700`, `authorized_keys` = `600`.

### ❌ SSH gebruikt de verkeerde sleutel

Laat `IdentityFile` in `~/.ssh/config` naar de juiste publieke sleutel wijzen (zie [5.10](05_openpgp_gpg_ssh_nl.md)). Vermijd `IdentitiesOnly yes` tenzij je het nodig hebt.

---

## PIN-problemen

| Probleem | Oplossing |
|---------|-----|
| PIV-PIN geblokkeerd | `ykman piv access unblock-pin` (vraagt de PUK) |
| PIV-PIN **én** PUK geblokkeerd | `ykman piv reset` — ⚠️ wist alle PIV-sleutels |
| OpenPGP-PIN geblokkeerd | `gpg --card-edit` → `admin` → `passwd` → `2` (deblokkeren, vraagt de Admin-PIN) |
| OpenPGP-Admin-PIN geblokkeerd | `ykman openpgp reset` — ⚠️ wist alle OpenPGP-sleutels |
| FIDO2-PIN geblokkeerd | `ykman fido reset` — ⚠️ wist alle FIDO2-gegevens (passkeys, SSH `-sk`-sleutels) |
| Resterende pogingen zien | `gpg --card-status` (*PIN retry counter*), `ykman piv info`, `ykman fido info` |

Daarom heb je een **reserve-YubiKey** en bewaar je je **PUK / Admin-PIN offline**.

---

[← 7. Inloggen op Linux](07_linux_login_pam_nl.md) · [Overzicht](nl.md)
