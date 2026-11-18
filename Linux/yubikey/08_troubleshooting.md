---

date: 2025-10-01T12:30:21+01:00
title: "YubiKey 8 — Troubleshooting"
draft: false
description: "Fixes for common YubiKey problems on Linux: card not found, wrong SSH agent, locked PIN"

---

# 8. Troubleshooting

[← 7. Linux login](07_linux_login_pam.md) · [Overview](README.md)

## 🧪 Quick checks

Run these first — they tell you where the problem is:

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

## The YubiKey is not found

### `gpg --card-status` → *No such device* / *Card not present*

1. Is `pcscd` running?
   ```bash
   sudo systemctl enable --now pcscd.socket
   ```
2. Restart scdaemon:
   ```bash
   gpgconf --kill scdaemon
   gpg --card-status
   ```
3. Let scdaemon use `pcscd` instead of its own USB driver — add to `~/.gnupg/scdaemon.conf`:
   ```conf
   disable-ccid
   ```
   then `gpgconf --kill scdaemon`.
4. **Fedora:** *access denied* from polkit → add the polkit rule from [1.2 step 4](01_installation.md#step-4--polkit-rule-only-if-you-get-access-denied--no-such-device).

### `ykman` works but `gpg` doesn't (or the other way around)

Only one program can hold the card at a time. Kill the other one:

```bash
gpgconf --kill scdaemon      # frees the card for ykman
```

---

## OpenPGP / SSH through gpg-agent

### ❌ Wrong SSH agent

```bash
echo $SSH_AUTH_SOCK
```

| ✅ Good | ❌ Wrong |
|---------|----------|
| `/run/user/1000/gnupg/S.gpg-agent.ssh` | `/run/user/1000/keyring/ssh` (GNOME Keyring) |
| | `/run/user/1000/gcr/ssh` (GNOME gcr, Fedora) |
| | `/tmp/ssh-XXXX/agent.NNNN` (ssh-agent) |

Fix:

```bash
pkill ssh-agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
```

and make sure the lines from [5.9](05_openpgp_gpg_ssh.md#shell-settings) are in your `~/.bashrc` / `~/.zshrc`.

### ❌ *sign_and_send_pubkey: signing failed* / *agent refused operation*

The agent doesn't know which terminal to show the PIN prompt in:

```bash
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye
```

### ❌ `ssh-add -L` shows no `cardno:` key

- Is `enable-ssh-support` in `~/.gnupg/gpg-agent.conf`? Then `gpgconf --kill gpg-agent`.
- Does `gpg --card-status` show an **Authentication key**? If not, see [5.6](05_openpgp_gpg_ssh.md#56-move-the-subkeys-to-the-yubikey).

### ❌ Server does not accept the key

Compare the key the agent offers with the one on the server:

```bash
gpg --export-ssh-key <KEYID>        # on your computer
cat ~/.ssh/authorized_keys          # on the server
```

In `ssh -vvv host` you want to see:

```
Offering public key: cardno:...
Server accepts key: cardno:...
```

Also check permissions on the server: `~/.ssh` = `700`, `authorized_keys` = `600`.

### ❌ SSH uses the wrong key

Point `IdentityFile` at the right public key in `~/.ssh/config` (see [5.10](05_openpgp_gpg_ssh.md#510-ssh-config-with-proxyjump-multi-hop)). Avoid `IdentitiesOnly yes` unless you need it.

---

## PIN problems

| Problem | Fix |
|---------|-----|
| PIV PIN blocked | `ykman piv access unblock-pin` (needs the PUK) |
| PIV PIN **and** PUK blocked | `ykman piv reset` — ⚠️ deletes all PIV keys |
| OpenPGP PIN blocked | `gpg --card-edit` → `admin` → `passwd` → `2` (unblock, needs Admin PIN) |
| OpenPGP Admin PIN blocked | `ykman openpgp reset` — ⚠️ deletes all OpenPGP keys |
| FIDO2 PIN blocked | `ykman fido reset` — ⚠️ deletes all FIDO2 credentials (passkeys, SSH `-sk` keys) |
| See remaining tries | `gpg --card-status` (*PIN retry counter*), `ykman piv info`, `ykman fido info` |

This is why you keep a **backup YubiKey** and your **PUK / Admin PIN offline**.

---

[← 7. Linux login](07_linux_login_pam.md) · [Overview](README.md)
