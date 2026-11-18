---

date: 2025-10-01T12:30:21+01:00
title: "YubiKey 3 — TOTP codes (OATH)"
draft: false
description: "Store authenticator (TOTP) codes on your YubiKey and get them from the CLI or a rofi menu"

---

# 3. TOTP Codes (OATH)

[← 2. First-time setup](02_first_time_setup.md) · [Overview](README.md) · Next: [4. SSH with FIDO2 →](04_ssh_fido2.md)

**Goal:** store your authenticator codes (GitHub, Google, …) on the YubiKey instead of (or next to) your phone.

### Why copy an existing TOTP secret?

When a website shows you a QR code, it also shows a text secret (Base32, e.g. `JBSWY3DPEHPK3PXP`). If you add **that same secret** to several YubiKeys (and/or an authenticator app), they all produce the same codes — so you have a backup.

> ⚠️ A TOTP secret is as sensitive as a password: **anyone with the secret can generate your codes.**
> Only do this if you understand that, and never store the secret in plain text.

---

## 3.1 Protect OATH with a password

```bash
ykman oath info
```

```
OATH version:        5.7.4
Password protection: disabled
```

Enable password protection:

```bash
ykman oath access change
ykman oath info               # should now say: Password protection: enabled
```

---

## 3.2 Add a TOTP account

**Recommended:** leave out the secret — `ykman` will then ask for it, so it does not end up in your shell history:

```bash
ykman oath accounts add --touch "GitHub:myusername"
# Enter a secret key (base32): ****************
```

Or with the secret on the command line (ends up in history!):

```bash
ykman oath accounts add --touch --digits 6 --period 30 "GitHub:myusername" JBSWY3DPEHPK3PXP
```

| Option | Meaning |
|--------|---------|
| `--touch` | Code only appears after touching the key |
| `--digits 6` | Code length (6 is standard) |
| `--period 30` | New code every 30 seconds (standard) |
| `"Issuer:name"` | Name shown in the list |

> 🧹 Used the secret on the command line? Clean up afterwards:
> bash: `history -c` · zsh: delete the line from `~/.zsh_history` · and `clear` the terminal.

👉 Repeat for your backup YubiKey.

---

## 3.3 Get codes

```bash
ykman oath accounts list               # all accounts
ykman oath accounts code               # all codes
ykman oath accounts code github        # matching accounts (partial name is fine)
```

---

## 3.4 Handy shortcuts

### Copy a code to the clipboard

```bash
ykman oath accounts code "GitHub:myusername" | awk '{print $NF}' | xclip -selection c
```

> Wayland? Use `wl-copy` instead of `xclip -selection c`.

### Shell function (`~/.bashrc` or `~/.zshrc`)

```bash
totp() {
    ykman oath accounts code "$1" | awk '{print $NF}' | xclip -selection c
    echo "Copied TOTP for $1 to clipboard."
}
```

Usage: `totp github`

### rofi menu

Pick an account in rofi; the code is copied to the clipboard.
Needs: `ykman`, `rofi`, `xclip`, optionally `notify-send` (`libnotify-bin` on Debian, `libnotify` on Fedora).

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

[← 2. First-time setup](02_first_time_setup.md) · [Overview](README.md) · Next: [4. SSH with FIDO2 →](04_ssh_fido2.md)
