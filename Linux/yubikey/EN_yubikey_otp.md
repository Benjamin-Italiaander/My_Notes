---

title: "YubiKey OATH / TOTP Guide"
draft: false
date: 2020
description: "This guide explains **how to copy your existing TOTP secrets into your YubiKey**."

---



# 🔐 YubiKey OATH / TOTP Guide

### Copying Existing TOTP Secrets into Your YubiKey

---

## ⚠️ About This Guide

This guide explains **how to copy your existing TOTP secrets into your YubiKey**.

### ⚠️ Warning 1

Use this method **only if you fully understand what you are doing**.
TOTP secrets are **extremely sensitive** — if someone obtains your secret, they can generate your codes.

### Why do this?

This method allows you to:

* create **multiple YubiKeys** containing the **same TOTP tokens**, or
* store a token on several YubiKeys *and/or* an authenticator app

Instead of generating new tokens per device, you can **duplicate** a single TOTP secret across several YubiKeys.

Use with caution.

### ⚠️ Warning 2

Before using OATH/TOTP on your YubiKey, complete the **minimum setup** guide:
👉 **[https://github.com/Benjamin-Italiaander/My_Notes/blob/main/Linux/yubikey/README.md](https://github.com/Benjamin-Italiaander/My_Notes/blob/main/Linux/yubikey/README.md)**

### ⚠️ Warning 3

After you finish all steps:
👉 **Clear your terminal and shell history!**

---

# 1. Check Your OATH Configuration

Run:

```bash
ykman oath info
```

Example output:

```
OATH version:        5.7.4
Password protection: disabled
```

If password protection is **disabled**, continue to the next step.

---

# 2. Enable OATH Password Protection

This encrypts all TOTP secrets stored on the YubiKey.

Run:

```bash
ykman oath access change
```

You will be asked:

```
Enter the new password:
Repeat for confirmation:
```

Verify:

```bash
ykman oath info
```

Expected result:

```
OATH version:        5.7.4
Password protection: enabled
```

---

# 3. Add a TOTP Credential

These examples use the **correct ykman 5.x syntax**.

### Example 1 — Generic TOTP Entry

```bash
ykman oath accounts add --touch --digits 6 --period 30 "appName:username" ABCDAOFKRNGKALWD
```

### Example 2 — GitHub TOTP Entry

```bash
ykman oath accounts add --touch --digits 6 --period 30 "gitHub:myusername" ABCDAOFKRNGKALWD
```

> The final argument (`ABCDAOFKRNGKALWD`) is the **Base32 TOTP secret**.

---

# 4. Generate TOTP Codes

List all codes:

```bash
ykman oath accounts code
```

Get one specific code:

```bash
ykman oath accounts code "gitHub:myusername"
```

Or a short version:

```bash
ykman oath accounts code github
```

---

# 5. Advanced CLI Tricks

## Copy TOTP code directly to clipboard

```bash
ykman oath accounts code zimbra:italiaan | awk '{print $2}' | xclip -selection c
```

---

## Create a custom `totp()` shell function

Add to your `.bashrc` or `.zshrc`:

```bash
# example one
totp() {
    ykman oath accounts code "$1" | awk '{print $2}' | xclip -selection c
    echo "Copied TOTP for $1 to clipboard."
}
```

### Example 2 — Specific account function

```bash
token-github() {
    ykman oath accounts code "gitHub:myusername" | awk '{print $2}' | xclip -selection c
    echo "Copied TOTP for gitHub to clipboard."
}
```

---

# 6. Create a Rofi Menu for TOTP

This script lists your YubiKey OATH accounts in **rofi**, lets you pick one, and copies the code automatically.

```bash
#!/usr/bin/env bash
set -euo pipefail

# Dependencies:
#  - ykman (YubiKey Manager CLI)
#  - rofi
#  - xclip
#  - notify-send (optional, from libnotify-bin)

# Get list of OATH accounts from the YubiKey
accounts=$(ykman oath accounts list || true)

if [ -z "$accounts" ]; then
    notify-send "YubiKey TOTP" "No OATH accounts found (or YubiKey not inserted)." || true
    exit 1
fi

# Choose account via rofi
selection=$(printf '%s\n' "$accounts" | rofi -dmenu -p "YubiKey TOTP")

# If user cancelled rofi
if [ -z "${selection:-}" ]; then
    exit 0
fi

# Generate code for selected account
code_line=$(ykman oath accounts code "$selection")

# Extract the TOTP code (second field)
code=$(printf '%s\n' "$code_line" | awk '{print $NF}')

# Copy to clipboard
printf '%s' "$code" | xclip -selection c

# Optional notification
notify-send "YubiKey TOTP" "Code for '$selection' copied to clipboard." || true
```

