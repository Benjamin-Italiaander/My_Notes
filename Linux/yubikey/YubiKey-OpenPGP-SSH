# 🔐 YubiKey + GPG + SSH Setup Guide

## 🎯 Doel

* GPG subkeys op YubiKey zetten
* SSH authenticatie via YubiKey gebruiken
* Werken met ProxyJump / multi-hop SSH

---

# 1. 🔍 Check bestaande GPG keys

```bash
gpg -K --with-keygrip
```

Voorbeeld:

```
sec#  ed25519 ... [C]
ssb   ed25519 ... [S]
ssb   cv25519 ... [E]
ssb   ed25519 ... [A]
```

### Betekenis

| Type   | Betekenis               |
| ------ | ----------------------- |
| `[S]`  | Signing                 |
| `[E]`  | Encryption              |
| `[A]`  | Authentication          |
| `sec#` | master key niet lokaal  |
| `ssb>` | key staat al op YubiKey |
| `ssb`  | key staat lokaal        |

---

# 2. 🔐 Check YubiKey status

```bash
gpg --card-status
```

Controleer:

* serial number
* welke keys aanwezig zijn
* PIN retry counters

---

# 3. 💾 Backup (BELANGRIJK)

```bash
gpg --export-secret-subkeys benjamin.italiaander@cwi.nl > secret-subkeys-backup.asc
chmod 600 secret-subkeys-backup.asc
```

---

# 4. 🔑 Subkeys naar YubiKey kopiëren

```bash
gpg --edit-key benjamin.italiaander@cwi.nl
```

## ⚠️ Belangrijk

`key N` is een toggle — zorg dat **exact 1 key geselecteerd is**

Controleer met:

```
list
```

---

## 4.1 Signing key

```
key 1
keytocard
```

Kies:

```
1 (Signature)
```

---

## 4.2 Encryption key

```
key 1
key 2
keytocard
```

Kies:

```
2 (Encryption)
```

---

## 4.3 Authentication key (SSH)

```
key 2
key 3
keytocard
```

Kies:

```
3 (Authentication)
```

---

## 4.4 Opslaan

```
save
```

---

# 5. ✅ Controle

```bash
gpg --card-status
```

Je wilt zien:

```
Signature key ....: ...
Encryption key....: ...
Authentication key: ...
```

---

# 6. 🔑 SSH public key exporteren

```bash
gpg --export-ssh-key benjamin.italiaander@cwi.nl
```

Opslaan:

```bash
gpg --export-ssh-key benjamin.italiaander@cwi.nl > ~/.ssh/yubikey.pub
```

---

# 7. 🖥️ Public key op server zetten

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
```

Plak de key en:

```bash
chmod 600 ~/.ssh/authorized_keys
```

---

# 8. ⚙️ gpg-agent configureren

Bestand:

```bash
~/.gnupg/gpg-agent.conf
```

Inhoud:

```conf
enable-ssh-support
pinentry-program /usr/bin/pinentry-curses
```

---

# 9. 🔄 Agent herstarten

```bash
gpgconf --kill gpg-agent
```

---

# 10. 🧠 Environment variables

## Zet in `~/.bashrc`

```bash
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
```

Daarna:

```bash
source ~/.bashrc
```

---

# 11. 🔍 Check SSH agent

```bash
ssh-add -L
```

Je wilt zien:

```
ssh-ed25519 ... cardno:XXXX
```

---

# 12. 🔗 SSH config voorbeeld

```sshconfig
Host doorgang.cwi.nl
    User italiaan
    IdentityFile ~/.ssh/id_ed25519

Host turku-proxy
    HostName 192.16.191.110
    User benjamin
    ProxyJump doorgang.cwi.nl
    ForwardAgent yes

Host cwi-www-proxy
    HostName 192.168.214.4
    User root
    ProxyJump turku-proxy
    ForwardAgent yes
    IdentitiesOnly no
```

---

# 13. 🔍 Debugging

```bash
ssh -vvv cwi-www-proxy
```

Zoek naar:

```
Offering public key: cardno:...
Server accepts key: cardno:...
```

---

# 14. ⚠️ Veelvoorkomende problemen

## ❌ Verkeerde agent

```bash
echo $SSH_AUTH_SOCK
```

Moet zijn:

```
/run/user/.../gnupg/S.gpg-agent.ssh
```

Niet:

```
/run/user/.../keyring/ssh
```

---

## ❌ Signing failed / agent refused

Fix:

```bash
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye
```

---

## ❌ Verkeerde key gebruikt

Check:

```bash
ssh-add -L
```

---

## ❌ Server accepteert key niet

Vergelijk:

```bash
gpg --export-ssh-key benjamin.italiaander@cwi.nl
```

met:

```bash
~/.ssh/authorized_keys
```

---

# 15. 🧪 Snelle checks

```bash
gpg --card-status
gpg -K
ssh-add -L
echo $SSH_AUTH_SOCK
ssh -vvv host
```

---

# 🧠 Samenvatting

* 🔐 private keys → op YubiKey
* 📄 public keys → op server
* 🔗 SSH → via gpg-agent
* ⚙️ env vars → in `.bashrc`

---

* Gebruik 2 YubiKeys (backup)
* Gebruik `pinentry-curses` voor SSH
* Vermijd `IdentitiesOnly yes` tenzij nodig

