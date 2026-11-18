---

date: 2025-10-01T12:30:21+01:00
title: "YubiKey 5 — OpenPGP: GPG and SSH"
draft: false
description: "Create GPG keys, move the subkeys to your YubiKey and use them for signing, encryption and SSH"

---

# 5. OpenPGP — GPG + SSH

[← 4. SSH with FIDO2](04_ssh_fido2.md) · [Overview](README.md) · Next: [6. age encryption →](06_age_piv.md)

**Goal:**
- a GPG **master key** that is kept offline,
- three **subkeys** (Sign, Encrypt, Authenticate) on the YubiKey,
- SSH logins through `gpg-agent` with the Authentication subkey,
- multi-hop SSH with `ProxyJump` (without agent forwarding).

**Before you start:** [chapter 1](01_installation.md) (incl. Fedora step 5 for the shell settings).

---

## 5.1 The idea in one picture

```
Master key [C]  ──►  offline backup (USB in a safe)  — only for creating/renewing subkeys
  ├─ Subkey [S] Sign          ──►  YubiKey slot 1
  ├─ Subkey [E] Encrypt       ──►  YubiKey slot 2
  └─ Subkey [A] Authenticate  ──►  YubiKey slot 3  ──►  used for SSH
```

In the commands below, replace `<KEYID>` with your key ID or email address.

---

## 5.2 KDF setup (do this first, on a fresh key)

KDF makes the YubiKey store a *hash* of your PIN instead of the PIN itself. **Enable it while the PINs are still the defaults** and before you move keys to the card.

```bash
gpg --card-edit
```

```
gpg/card> admin
gpg/card> kdf-setup          # asks for the Admin PIN (default 12345678)
gpg/card> passwd             # now change the PIN (1) and Admin PIN (3)
gpg/card> quit
```

> Already changed your PINs or have keys on the card? Skip this step — or reset the OpenPGP app with `ykman openpgp reset` (⚠️ wipes all OpenPGP keys on the YubiKey) and start over.

---

## 5.3 Create the master key

**Recommended:** do this on an offline (air-gapped) machine or a temporary live system.

```bash
gpg --expert --full-generate-key
```

Choose:
- **Type:** ECC (set your own capabilities) → only **Certify** — or RSA 4096
- **Curve:** Curve 25519 (Ed25519)
- **Expiry:** e.g. 1–2 years (you can extend it later)
- **User ID:** your name and email

---

## 5.4 Add three subkeys

```bash
gpg --expert --edit-key <KEYID>
```

```
gpg> addkey      # ECC (sign only)       → Curve 25519   → [S]
gpg> addkey      # ECC (encrypt only)    → Curve 25519   → [E]
gpg> addkey      # ECC (set your own)    → only Authenticate → Curve 25519 → [A]
gpg> save
```

Check:

```bash
gpg -K --with-keygrip
```

```
sec   ed25519 ... [C]
ssb   ed25519 ... [S]
ssb   cv25519 ... [E]
ssb   ed25519 ... [A]
```

| Symbol | Meaning |
|--------|---------|
| `[C]` `[S]` `[E]` `[A]` | Certify, Sign, Encrypt, Authenticate |
| `sec` / `ssb` | Private (sub)key is **on this computer** |
| `sec#` | Master key is **not** on this computer (good, on your daily machine) |
| `ssb>` | Subkey is **on the YubiKey** |

---

## 5.5 Back up — BEFORE moving keys to the YubiKey ⚠️

`keytocard` **moves** a key: after `save` the local private subkey is gone. So back up first:

```bash
gpg --armor --export-secret-keys    <KEYID> > master-private.asc
gpg --armor --export-secret-subkeys <KEYID> > subkeys-private.asc
gpg --armor --export                <KEYID> > public.asc
chmod 600 *-private.asc
```

A revocation certificate is created automatically in `~/.gnupg/openpgp-revocs.d/`. Or make one yourself:

```bash
gpg --gen-revoke <KEYID> > revoke-cert.asc
```

💾 Store these files **offline** (encrypted USB in a safe). Never leave them on your daily computer.

---

## 5.6 Move the subkeys to the YubiKey

```bash
gpg --edit-key <KEYID>
```

> ⚠️ `key N` is a **toggle**. Make sure **exactly one** key is selected (marked with `*`) before each `keytocard`. Check with `list`.

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

**Second YubiKey (backup)?** Re-import the backup first (`gpg --import subkeys-private.asc`), insert the other key, and repeat this step.

Check:

```bash
gpg --card-status
```

```
Signature key ....: XXXX ...
Encryption key....: XXXX ...
Authentication key: XXXX ...
```

And `gpg -K` now shows `ssb>` for all three subkeys.

### Remove the master key from your daily computer

Look up the **keygrip** of the `sec` line with `gpg -K --with-keygrip`, then:

```bash
rm ~/.gnupg/private-keys-v1.d/<KEYGRIP-OF-MASTER>.key
gpg -K            # should now show: sec#
```

> ❌ Do **not** use `delkey` in `gpg --edit-key` for this — that deletes the (sub)key completely, including the public part.

---

## 5.7 PINs and touch policy

If you didn't do this in 5.2:

```bash
ykman openpgp access change-pin
ykman openpgp access change-admin-pin
```

Require a touch for every operation:

```bash
ykman openpgp keys set-touch sig on
ykman openpgp keys set-touch dec on
ykman openpgp keys set-touch aut on
```

---

## 5.8 Test signing and encryption

```bash
echo "test" | gpg --clearsign
echo "test123" | gpg --encrypt --armor -r <KEYID> | gpg --decrypt
```

The YubiKey should ask for your PIN, blink and wait for a touch.

---

## 5.9 SSH through gpg-agent

### Configure the agent

`~/.gnupg/gpg-agent.conf`:

```conf
enable-ssh-support
pinentry-program /usr/bin/pinentry-curses
```

> On a desktop you can use `/usr/bin/pinentry-gnome3` or `pinentry-qt` instead.

Restart the agent:

```bash
gpgconf --kill gpg-agent
```

### Shell settings

Add to `~/.bashrc` (or `~/.zshrc`) — see also [Fedora step 5](01_installation.md#step-5--use-gpg-agent-as-your-ssh-agent-only-for-chapter-5):

```bash
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
```

```bash
source ~/.bashrc
ssh-add -L          # → ssh-ed25519 AAAA... cardno:XXXXXXXX
```

### Export the SSH public key

```bash
gpg --export-ssh-key <KEYID> > ~/.ssh/yubikey-gpg.pub
```

### Put it on the server

```bash
ssh-copy-id -f -i ~/.ssh/yubikey-gpg.pub user@server
```

Or by hand on the server:

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys        # paste the key
chmod 600 ~/.ssh/authorized_keys
```

---

## 5.10 SSH config with ProxyJump (multi-hop)

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

`ssh internal` now goes through `jumphost`. The YubiKey signs **both** logins locally — **no `ForwardAgent` needed**, and you should not enable it.

> 💡 `IdentityFile` pointing at a `.pub` file tells SSH which agent key to use.

---

## 5.11 Use the key elsewhere

| Use | How |
|-----|-----|
| Email | Thunderbird (built-in OpenPGP, enable external GnuPG), Mutt |
| Git signing | `git config --global user.signingkey <KEYID>` and `git config --global commit.gpgsign true` |
| SSH | sections 5.9 and 5.10 |

---

## 5.12 Summary

- 🔐 Private subkeys → **on the YubiKey** (and an offline backup)
- 👑 Master key → **offline only**
- 📄 Public keys → on servers / key servers
- 🔗 SSH → through `gpg-agent`, multi-hop through `ProxyJump`
- ⚙️ Environment variables → in `~/.bashrc` / `~/.zshrc`

Problems? → [8. Troubleshooting](08_troubleshooting.md#openpgp--ssh-through-gpg-agent)

---

[← 4. SSH with FIDO2](04_ssh_fido2.md) · [Overview](README.md) · Next: [6. age encryption →](06_age_piv.md)
