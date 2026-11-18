---

date: 2025-10-01T12:30:21+01:00
title: "YubiKey 1 — Installation (Debian/Ubuntu and Fedora)"
draft: false
description: "Install GnuPG, pcscd and ykman, and make sure your YubiKey is detected"

---

# 1. Installation

[← Back to overview](README.md) · Next: [2. First-time setup →](02_first_time_setup.md)

**Goal:** install the software, start the smartcard daemon and see your YubiKey with `ykman info` and `gpg --card-status`.

| Package | What it is |
|---------|------------|
| GnuPG (`gnupg2`) | The universal crypto engine (OpenPGP) |
| scdaemon | Smartcard daemon for GnuPG |
| pcsc-lite / pcscd | PC/SC smartcard daemon (talks to the YubiKey) |
| yubikey-manager | `ykman`, the YubiKey CLI |
| pcsc-tools | `pcsc_scan`, handy for debugging |

---

## 1.1 Debian / Ubuntu

```bash
sudo apt update
sudo apt install gnupg2 scdaemon pcscd pcsc-tools yubikey-manager yubikey-personalization pipx
sudo systemctl enable --now pcscd.socket
```

Optional (Ubuntu only) — newer Yubico packages from the official PPA:

```bash
sudo apt-add-repository ppa:yubico/stable
sudo apt update
sudo apt install yubikey-manager
```

---

## 1.2 Fedora

### Step 1 — Install the packages

```bash
sudo dnf install gnupg2 gnupg2-scdaemon gnupg2-smime \
                 pcsc-lite pcsc-tools \
                 yubikey-manager yubikey-personalization
```

### Step 2 — Enable the smartcard daemon

`pcscd` is socket-activated: enabling the socket is enough, it starts automatically when needed.

```bash
sudo systemctl enable --now pcscd.socket
sudo systemctl status pcscd.socket
```

### Step 3 — Check that the YubiKey is seen

```bash
lsusb | grep -i yubi
gpg --card-status
```

If `gpg --card-status` works, you can skip step 4.

### Step 4 — Polkit rule (only if you get "access denied" / "No such device")

On Fedora, polkit decides who may talk to `pcscd`. In some setups (e.g. SSH sessions, or a session that polkit doesn't see as "active") your user is refused access to the card. This rule allows **your user**:

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

> `$USER` is filled in with your username when you run the command. Check the result with
> `cat /etc/polkit-1/rules.d/50-pcscd-access.rules`.
>
> ⚠️ Use `sudo tee`, not `sudo cat > file` — the `>` redirect runs as your normal user and fails with *Permission denied*.

### Step 5 — Use gpg-agent as your SSH agent (only for [chapter 5](05_openpgp_gpg_ssh.md))

Add (`>>` = append!) the agent settings to your shell config:

```bash
cat >> ~/.bashrc << 'EOF'

# YubiKey: use gpg-agent for SSH
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
EOF
```

> ⚠️ Use `>>`, **not** `>`. A single `>` overwrites your whole `~/.bashrc`.
> Using zsh? Put the same lines in `~/.zshrc`.

Stop any running `ssh-agent`, reload the shell and test:

```bash
pkill ssh-agent
source ~/.bashrc
gpg --card-status
ssh-add -L                  # should show a key ending in "cardno:XXXXXXXX"
ssh your-server
```

---

## 1.3 Verify the installation

```bash
ykman info
```

Example output:

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

Not working? See [8. Troubleshooting](08_troubleshooting.md).

---

## 1.4 (Advanced) Install the latest `ykman` from source

The distro package is fine for most people. If you need the newest version, pick one method:

| Method | Isolation | System impact | Recommended for |
|--------|-----------|---------------|-----------------|
| **pipx** | High | None | CLI users (my favourite) |
| **Virtual environment** | High | None | Testing / development |
| **System-wide pip** | Low | Can break distro packages | Experts only |

### Option A — pipx (recommended)

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

### Option B — Python virtual environment

```bash
git clone https://github.com/Yubico/yubikey-manager.git
cd yubikey-manager
python3 -m venv .venv
source .venv/bin/activate
pip install .
ykman -v
```

> To use it outside the venv, call it with its full path, e.g. `~/yubikey-manager/.venv/bin/ykman`.

### Option C — System-wide pip (⚠️ experts only)

```bash
git clone https://github.com/Yubico/yubikey-manager.git
cd yubikey-manager
pip install . --break-system-packages
```

> This can conflict with the distro's `yubikey-manager` package. Remove that one first.

---

[← Back to overview](README.md) · Next: [2. First-time setup →](02_first_time_setup.md)
