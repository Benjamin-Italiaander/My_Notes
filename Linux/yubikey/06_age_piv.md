---
title: "YubiKey 6 — age encryption (PIV)"
date: 2025-10-01T12:30:21+01:00
description: "Encrypt files with age using keys stored in the YubiKey's PIV application"
draft: false
---

*🇳🇱 [Lees deze pagina in het Nederlands](06_age_piv_nl.md)*

# 6. age Encryption (PIV)

[← 5. OpenPGP](05_openpgp_gpg_ssh.md) · [Overview](README.md) · Next: [7. Linux login →](07_linux_login_pam.md)

**Goal:** encrypt files with [`age`](https://github.com/FiloSottile/age) so that only your YubiKey(s) — or an offline backup key — can decrypt them. A simple alternative to OpenPGP.

---

## 6.1 ⚠️ Post-quantum note

age with a YubiKey is **not post-quantum (PQ) secure**.

- Only software age keys with a PQ algorithm (`age1pq1…`) are PQ-resistant.
- You **cannot import** an existing age identity into a YubiKey — it can only generate its own.
- PQ and non-PQ recipients **cannot be mixed** in one file.

👉 If you need post-quantum encryption, a YubiKey is currently **not the right tool**.

---

## 6.2 Install

```bash
sudo apt install age pcscd            # Debian/Ubuntu
sudo dnf install age pcsc-lite        # Fedora
sudo systemctl enable --now pcscd.socket
```

Install the YubiKey plugin (needs Rust — install via `rustup` if you don't have `cargo`):

```bash
cargo install age-plugin-yubikey
```

> Fedora: `cargo` needs `pcsc-lite-devel` to build the plugin (`sudo dnf install pcsc-lite-devel`).
> Debian/Ubuntu: `libpcsclite-dev`.

**Before you continue:** secure PIV as described in [2.3](02_first_time_setup.md#23-piv-smartcard--pin-puk-and-management-key) (PIN, PUK and management key).

---

## 6.3 Create an age identity on the YubiKey

```bash
age-plugin-yubikey
```

Follow the interactive prompts (slot, PIN policy, touch policy). This creates a file like `age-yubikey-identity-XXXXXXXX.txt`.

- The line `Recipient: age1yubikey1…` is your **public key**.
- The identity file itself is only a pointer to the YubiKey — needed for decryption.

List the keys later:

```bash
age-plugin-yubikey --list            # recipients (public keys)
age-plugin-yubikey --identity        # identity lines (for decrypting)
```

👉 Repeat with your **backup YubiKey**.

---

## 6.4 Encrypt and decrypt

Save each public key in its own file (e.g. `~/.config/age/yubikey1.pub`), then:

```bash
age \
  -R ~/.config/age/yubikey1.pub \
  -R ~/.config/age/yubikey2.pub \
  -R ~/.config/age/offline.pub \
  -o secrets.txt.age \
  secrets.txt
```

- Add as many recipients as you like — **any one** of them can decrypt.
- The input file always comes **last**.

Decrypt:

```bash
age -d -i age-yubikey-identity-XXXXXXXX.txt -o secrets.txt secrets.txt.age
```

### One recipients file

Even easier: put all public keys in one file. You can share it, so other people can encrypt files for all your keys at once:

```bash
# ~/.config/age/recipients.txt
age1yubikey1qt5k5...   # YubiKey 1 (daily)
age1yubikey1ql3z7...   # YubiKey 2 (backup)
age1x9ynm5k...         # offline software key (stored safely)
```

```bash
age -R ~/.config/age/recipients.txt -o secrets.txt.age secrets.txt
```

---

## 6.5 💡 Recommended setup

- 1× YubiKey for daily use
- 1× backup YubiKey
- 1× offline software key (`age-keygen -o offline.key`), stored safely

Redundancy without depending on a single hardware token.

---

## 6.6 Helper function `agey`

Add to `~/.bashrc` or `~/.zshrc`:

```bash
agey() {
    local DEFAULT_RECIPIENTS=(
        "$HOME/.config/age/yubikey1.pub"
        "$HOME/.config/age/yubikey2.pub"
        "$HOME/.config/age/offline.pub"
    )
    local input="" output="" extra_recipients=()

    _agey_help() {
        cat << EOF
Usage: agey [options] <input-file>

Encrypt a file using predefined age recipients.

Options:
  -o <file>     Output file (default: <input>.age)
  -r <file>     Add an extra recipient file (can be repeated)
  -l            List default recipients
  -h            Show this help

Examples:
  agey secret.txt
  agey -o secret.enc secret.txt
  agey -r other.pub secret.txt
EOF
    }

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help) _agey_help; return 0 ;;
            -o) output="$2"; shift 2 ;;
            -r) extra_recipients+=("$2"); shift 2 ;;
            -l) printf 'Default recipients:\n'; printf '  %s\n' "${DEFAULT_RECIPIENTS[@]}"; return 0 ;;
            -*) echo "Unknown option: $1"; _agey_help; return 1 ;;
            *)  input="$1"; shift ;;
        esac
    done

    [[ -z "$input" ]]   && { echo "Error: no input file specified"; _agey_help; return 1; }
    [[ ! -f "$input" ]] && { echo "Error: file not found: $input"; return 1; }
    [[ -z "$output" ]]  && output="${input}.age"

    local recipient_args=() r
    for r in "${DEFAULT_RECIPIENTS[@]}"; do
        if [[ -f "$r" ]]; then
            recipient_args+=(-R "$r")
        else
            echo "Warning: recipient not found, skipping: $r"
        fi
    done
    for r in "${extra_recipients[@]}"; do
        recipient_args+=(-R "$r")
    done

    echo "Encrypting: $input -> $output"
    if age "${recipient_args[@]}" -o "$output" "$input"; then
        echo "Done."
    else
        echo "Encryption failed."
        return 1
    fi
}
```

---

[← 5. OpenPGP](05_openpgp_gpg_ssh.md) · [Overview](README.md) · Next: [7. Linux login →](07_linux_login_pam.md)
