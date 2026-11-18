---
title: "YubiKey 7 — Linux login with PAM (sudo, desktop, TTY)"
date: 2025-10-01T12:30:21+01:00
description: "Use your YubiKey for sudo, desktop (GDM) and TTY login with pam_u2f on Ubuntu and Fedora"
draft: false
---

*🇳🇱 [Lees deze pagina in het Nederlands](07_linux_login_pam_nl.md)*

# 7. Linux Login with PAM (sudo, desktop, TTY)

[← 6. age encryption](06_age_piv.md) · [Overview](README.md) · Next: [8. Troubleshooting →](08_troubleshooting.md)

**Goal:** require your YubiKey (touch) for `sudo`, `su`, the desktop login (GDM) and TTY login, using `pam_u2f` (FIDO2/U2F).

> 🚨 **You can lock yourself out.** Keep a **root shell open in a second terminal** (`sudo -i`) while you change PAM files, and test before you log out. If something breaks, remove the line you added.

---

## 7.1 Install

```bash
sudo apt install libpam-u2f pamu2fcfg     # Debian/Ubuntu
sudo dnf install pam-u2f pamu2fcfg        # Fedora
```

---

## 7.2 Register your YubiKey(s)

```bash
mkdir -p ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys      # touch the key when it blinks
```

Add a **backup YubiKey** (insert it, then):

```bash
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
```

> `-n` leaves out the username so the second key is appended to the **same line**. The file should contain one line: `username:key1...:key2...`

---

## 7.3 Two modes

| Mode | PAM line | Effect |
|------|----------|--------|
| 🔐 **2FA** | `auth required pam_u2f.so` | Password **and** YubiKey touch |
| 🛡 **Passwordless** | `auth sufficient pam_u2f.so` | YubiKey touch **or** password |

Put the line **at the top** of the PAM file (before the other `auth` lines).

---

## 7.4 Ubuntu / Debian — edit the PAM files

Start with `sudo` — it's the easiest to test.

| What | File |
|------|------|
| sudo | `/etc/pam.d/sudo` |
| su | `/etc/pam.d/su` |
| Desktop login (GNOME) | `/etc/pam.d/gdm-password` |
| TTY login | `/etc/pam.d/login` |

```bash
sudo nano /etc/pam.d/sudo
```

Add at the top:

```
auth       sufficient   pam_u2f.so cue
```

(`cue` prints "Please touch the device." so you know it's waiting.)

Test in a **new** terminal:

```bash
sudo -k && sudo ls
```

Works? Repeat for the other files.

---

## 7.5 Fedora — use authselect

Fedora manages PAM through `authselect`; don't edit `/etc/pam.d/system-auth` by hand (it gets overwritten).

```bash
authselect current                                # show current profile + features

# Passwordless: YubiKey OR password (sufficient)
sudo authselect enable-feature with-pam-u2f

# — or — 2FA: password AND YubiKey (required)
sudo authselect enable-feature with-pam-u2f-2fa

sudo authselect apply-changes
```

This enables the YubiKey for everything that uses `system-auth` (sudo, su, GDM, TTY).

Just want it for `sudo` only? Add at the top of `/etc/pam.d/sudo`:

```
auth       sufficient   pam_u2f.so cue
```

Undo:

```bash
sudo authselect disable-feature with-pam-u2f       # or with-pam-u2f-2fa
sudo authselect apply-changes
```

---

## 7.6 Test before you log out

1. Keep a root shell open: `sudo -i` in a second terminal.
2. Test `sudo -k && sudo ls` in a new terminal.
3. Test a TTY login: **Ctrl+Alt+F3**, log in, then back with **Ctrl+Alt+F1/F2**.
4. Only then log out and test the desktop login.

Not working? Remove the line / disable the authselect feature from your open root shell.

---

[← 6. age encryption](06_age_piv.md) · [Overview](README.md) · Next: [8. Troubleshooting →](08_troubleshooting.md)
