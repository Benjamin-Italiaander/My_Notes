---
title: "YubiKey 5 — OpenPGP: GPG en SSH"
date: 2025-11-18
description: "Maak GPG-sleutels, zet de subsleutels op je YubiKey en gebruik ze voor ondertekenen, versleutelen en SSH via gpg-agent."
translated_by_ai: true
translated_from: "en"
original: "05_openpgp_gpg_ssh.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](05_openpgp_gpg_ssh.md).* De commando's zijn niet vertaald.

# 5. OpenPGP — GPG + SSH

[← 4. SSH met FIDO2](04_ssh_fido2_nl.md) · [Overzicht](nl.md) · Volgende: [6. Versleutelen met age →](06_age_piv_nl.md)

**Doel:**
- een GPG-**hoofdsleutel** die offline wordt bewaard,
- drie **subsleutels** (ondertekenen, versleutelen, authenticeren) op de YubiKey,
- SSH-logins via `gpg-agent` met de authenticatie-subsleutel,
- SSH via meerdere hops met `ProxyJump` (zonder agent forwarding).

**Voordat je begint:** [hoofdstuk 1](01_installation_nl.md) (inclusief Fedora-stap 5 voor de shellinstellingen).

---

## 5.1 Het idee in één plaatje

```
Master key [C]  ──►  offline backup (USB in a safe)  — only for creating/renewing subkeys
  ├─ Subkey [S] Sign          ──►  YubiKey slot 1
  ├─ Subkey [E] Encrypt       ──►  YubiKey slot 2
  └─ Subkey [A] Authenticate  ──►  YubiKey slot 3  ──►  used for SSH
```

Vervang in de commando's hieronder `<KEYID>` door je sleutel-ID of e-mailadres.

---

## 5.2 KDF instellen (doe dit eerst, op een nieuwe sleutel)

Met KDF bewaart de YubiKey een *hash* van je PIN in plaats van de PIN zelf. **Zet het aan zolang de PIN's nog de standaardwaarden hebben**, en voordat je sleutels naar de kaart verplaatst.

```bash
gpg --card-edit
```

```
gpg/card> admin
gpg/card> kdf-setup          # asks for the Admin PIN (default 12345678)
gpg/card> passwd             # now change the PIN (1) and Admin PIN (3)
gpg/card> quit
```

> Heb je je PIN's al veranderd of staan er al sleutels op de kaart? Sla deze stap over — of reset de OpenPGP-toepassing met `ykman openpgp reset` (⚠️ wist alle OpenPGP-sleutels op de YubiKey) en begin opnieuw.

---

## 5.3 De hoofdsleutel maken

**Aanbevolen:** doe dit op een computer zonder netwerkverbinding (air-gapped) of een tijdelijk live-systeem.

```bash
gpg --expert --full-generate-key
```

Kies:
- **Type:** ECC (eigen mogelijkheden instellen) → alleen **Certify** — of RSA 4096
- **Curve:** Curve 25519 (Ed25519)
- **Verloopdatum:** bijvoorbeeld 1–2 jaar (je kunt hem later verlengen)
- **Gebruikers-ID:** je naam en e-mailadres

---

## 5.4 Drie subsleutels toevoegen

```bash
gpg --expert --edit-key <KEYID>
```

```
gpg> addkey      # ECC (sign only)       → Curve 25519   → [S]
gpg> addkey      # ECC (encrypt only)    → Curve 25519   → [E]
gpg> addkey      # ECC (set your own)    → only Authenticate → Curve 25519 → [A]
gpg> save
```

Controleer:

```bash
gpg -K --with-keygrip
```

```
sec   ed25519 ... [C]
ssb   ed25519 ... [S]
ssb   cv25519 ... [E]
ssb   ed25519 ... [A]
```

| Symbool | Betekenis |
|--------|---------|
| `[C]` `[S]` `[E]` `[A]` | Certificeren, ondertekenen, versleutelen, authenticeren |
| `sec` / `ssb` | Privé(sub)sleutel staat **op deze computer** |
| `sec#` | Hoofdsleutel staat **niet** op deze computer (goed zo, op je dagelijkse computer) |
| `ssb>` | Subsleutel staat **op de YubiKey** |

---

## 5.5 Back-up maken — VOORDAT je sleutels naar de YubiKey verplaatst ⚠️

`keytocard` **verplaatst** een sleutel: na `save` is de lokale privé-subsleutel weg. Maak dus eerst een back-up:

```bash
gpg --armor --export-secret-keys    <KEYID> > master-private.asc
gpg --armor --export-secret-subkeys <KEYID> > subkeys-private.asc
gpg --armor --export                <KEYID> > public.asc
chmod 600 *-private.asc
```

Er wordt automatisch een intrekkingscertificaat gemaakt in `~/.gnupg/openpgp-revocs.d/`. Of maak er zelf een:

```bash
gpg --gen-revoke <KEYID> > revoke-cert.asc
```

💾 Bewaar deze bestanden **offline** (versleutelde USB-stick in een kluis). Laat ze nooit op je dagelijkse computer staan.

---

## 5.6 De subsleutels naar de YubiKey verplaatsen

```bash
gpg --edit-key <KEYID>
```

> ⚠️ `key N` werkt als **aan/uit-schakelaar**. Zorg dat er vóór elke `keytocard` **precies één** sleutel is geselecteerd (gemarkeerd met `*`). Controleer met `list`.

```
gpg> key 1          # select [S]
gpg> keytocard      # choose (1) Signature key

gpg> key 1          # deselect [S]
gpg> key 2          # select [E]
gpg> keytocard      # choose (2) Encryption key

gpg> key 2          # deselect [E]
gpg> key 3          # select [A]
gpg> keytocard      # choose (3) Authentication key

gpg> save
```

**Tweede YubiKey (reserve)?** Importeer eerst de back-up opnieuw (`gpg --import subkeys-private.asc`), steek de andere sleutel erin en herhaal deze stap.

Controleer:

```bash
gpg --card-status
```

```
Signature key ....: XXXX ...
Encryption key....: XXXX ...
Authentication key: XXXX ...
```

En `gpg -K` toont nu `ssb>` bij alle drie de subsleutels.

### De hoofdsleutel van je dagelijkse computer verwijderen

Zoek met `gpg -K --with-keygrip` de **keygrip** van de regel `sec` op, en dan:

```bash
rm ~/.gnupg/private-keys-v1.d/<KEYGRIP-OF-MASTER>.key
gpg -K            # should now show: sec#
```

> ❌ Gebruik hiervoor **niet** `delkey` in `gpg --edit-key` — dat verwijdert de (sub)sleutel helemaal, inclusief het publieke deel.

---

## 5.7 PIN's en aanraakbeleid

Als je dit niet al in 5.2 hebt gedaan:

```bash
ykman openpgp access change-pin
ykman openpgp access change-admin-pin
```

Vraag bij elke handeling om aanraking:

```bash
ykman openpgp keys set-touch sig on
ykman openpgp keys set-touch dec on
ykman openpgp keys set-touch aut on
```

---

## 5.8 Ondertekenen en versleutelen testen

```bash
echo "test" | gpg --clearsign
echo "test123" | gpg --encrypt --armor -r <KEYID> | gpg --decrypt
```

De YubiKey vraagt om je PIN, knippert en wacht tot je hem aanraakt.

---

## 5.9 SSH via gpg-agent

### De agent instellen

`~/.gnupg/gpg-agent.conf`:

```conf
enable-ssh-support
pinentry-program /usr/bin/pinentry-curses
```

> Op een desktop kun je in plaats daarvan `/usr/bin/pinentry-gnome3` of `pinentry-qt` gebruiken.

Herstart de agent:

```bash
gpgconf --kill gpg-agent
```

### Shellinstellingen

Voeg toe aan `~/.bashrc` (of `~/.zshrc`) — zie ook [Fedora-stap 5](01_installation_nl.md):

```bash
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
```

```bash
source ~/.bashrc
ssh-add -L          # → ssh-ed25519 AAAA... cardno:XXXXXXXX
```

### De publieke SSH-sleutel exporteren

```bash
gpg --export-ssh-key <KEYID> > ~/.ssh/yubikey-gpg.pub
```

### Zet hem op de server

```bash
ssh-copy-id -f -i ~/.ssh/yubikey-gpg.pub user@server
```

Of met de hand op de server:

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys        # paste the key
chmod 600 ~/.ssh/authorized_keys
```

---

## 5.10 SSH-configuratie met ProxyJump (meerdere hops)

`~/.ssh/config`:

```sshconfig
Host jumphost
    HostName jump.example.com
    User username
    IdentityFile ~/.ssh/yubikey-gpg.pub

Host internal
    HostName 192.168.1.10
    User username
    IdentityFile ~/.ssh/yubikey-gpg.pub
    ProxyJump jumphost
```

`ssh internal` gaat nu via `jumphost`. De YubiKey ondertekent **beide** logins lokaal — **`ForwardAgent` is niet nodig**, en je moet het ook niet aanzetten.

> 💡 Wijst `IdentityFile` naar een `.pub`-bestand, dan weet SSH welke sleutel uit de agent het moet gebruiken.

---

## 5.11 De sleutel elders gebruiken

| Gebruik | Hoe |
|-----|-----|
| E-mail | Thunderbird (ingebouwde OpenPGP, externe GnuPG aanzetten), Mutt |
| Git-ondertekening | `git config --global user.signingkey <KEYID>` en `git config --global commit.gpgsign true` |
| SSH | paragraaf 5.9 en 5.10 |

---

## 5.12 Samenvatting

- 🔐 Privé-subsleutels → **op de YubiKey** (en een offline back-up)
- 👑 Hoofdsleutel → **alleen offline**
- 📄 Publieke sleutels → op servers / sleutelservers
- 🔗 SSH → via `gpg-agent`, meerdere hops via `ProxyJump`
- ⚙️ Omgevingsvariabelen → in `~/.bashrc` / `~/.zshrc`

Problemen? → [8. Problemen oplossen](08_troubleshooting_nl.md)

---

[← 4. SSH met FIDO2](04_ssh_fido2_nl.md) · [Overzicht](nl.md) · Volgende: [6. Versleutelen met age →](06_age_piv_nl.md)
