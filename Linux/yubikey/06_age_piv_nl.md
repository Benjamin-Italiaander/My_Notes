---
title: "YubiKey 6 — Versleutelen met age (PIV)"
date: 2025-11-18
description: "Versleutel bestanden met age met sleutels op de PIV-toepassing van de YubiKey, en waarom dat niet post-quantumveilig is."
translated_by_ai: true
translated_from: "en"
original: "06_age_piv.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](06_age_piv.md).* De commando's zijn niet vertaald.

# 6. Versleutelen met age (PIV)

[← 5. OpenPGP](05_openpgp_gpg_ssh_nl.md) · [Overzicht](nl.md) · Volgende: [7. Inloggen op Linux →](07_linux_login_pam_nl.md)

**Doel:** bestanden versleutelen met [`age`](https://github.com/FiloSottile/age), zodat alleen je YubiKey(s) — of een offline reservesleutel — ze kunnen ontsleutelen. Een eenvoudig alternatief voor OpenPGP.

---

## 6.1 ⚠️ Opmerking over post-quantum

age met een YubiKey is **niet post-quantumveilig (PQ)**.

- Alleen software-age-sleutels met een PQ-algoritme (`age1pq1…`) zijn bestand tegen quantumcomputers.
- Je **kunt geen** bestaande age-identiteit **importeren** in een YubiKey — die kan alleen zelf sleutels maken.
- PQ- en niet-PQ-ontvangers **kun je niet mengen** in één bestand.

👉 Heb je post-quantumversleuteling nodig, dan is een YubiKey op dit moment **niet het juiste gereedschap**.

---

## 6.2 Installeren

```bash
sudo apt install age pcscd            # Debian/Ubuntu
sudo dnf install age pcsc-lite        # Fedora
sudo systemctl enable --now pcscd.socket
```

Installeer de YubiKey-plug-in (heeft Rust nodig — installeer dat via `rustup` als je geen `cargo` hebt):

```bash
cargo install age-plugin-yubikey
```

> Fedora: `cargo` heeft `pcsc-lite-devel` nodig om de plug-in te bouwen (`sudo dnf install pcsc-lite-devel`).
> Debian/Ubuntu: `libpcsclite-dev`.

**Voordat je verdergaat:** beveilig PIV zoals beschreven in [2.3](02_first_time_setup_nl.md) (PIN, PUK en managementsleutel).

---

## 6.3 Een age-identiteit maken op de YubiKey

```bash
age-plugin-yubikey
```

Volg de vragen op het scherm (slot, PIN-beleid, aanraakbeleid). Dit maakt een bestand zoals `age-yubikey-identity-XXXXXXXX.txt`.

- De regel `Recipient: age1yubikey1…` is je **publieke sleutel**.
- Het identiteitsbestand zelf is alleen een verwijzing naar de YubiKey — nodig om te ontsleutelen.

De sleutels later tonen:

```bash
age-plugin-yubikey --list            # recipients (public keys)
age-plugin-yubikey --identity        # identity lines (for decrypting)
```

👉 Herhaal dit met je **reserve-YubiKey**.

---

## 6.4 Versleutelen en ontsleutelen

Bewaar elke publieke sleutel in een eigen bestand (bijvoorbeeld `~/.config/age/yubikey1.pub`), en dan:

```bash
age \
  -R ~/.config/age/yubikey1.pub \
  -R ~/.config/age/yubikey2.pub \
  -R ~/.config/age/offline.pub \
  -o secrets.txt.age \
  secrets.txt
```

- Voeg zoveel ontvangers toe als je wilt — **elk van hen** kan ontsleutelen.
- Het invoerbestand komt altijd **als laatste**.

Ontsleutelen:

```bash
age -d -i age-yubikey-identity-XXXXXXXX.txt -o secrets.txt secrets.txt.age
```

### Eén ontvangersbestand

Nog makkelijker: zet alle publieke sleutels in één bestand. Dat kun je delen, zodat anderen in één keer bestanden kunnen versleutelen voor al je sleutels:

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

## 6.5 💡 Aanbevolen opzet

- 1× YubiKey voor dagelijks gebruik
- 1× reserve-YubiKey
- 1× offline softwaresleutel (`age-keygen -o offline.key`), veilig bewaard

Zo heb je reserve zonder afhankelijk te zijn van één hardwaretoken.

---

## 6.6 Hulpfunctie `agey`

Voeg toe aan `~/.bashrc` of `~/.zshrc`:

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

[← 5. OpenPGP](05_openpgp_gpg_ssh_nl.md) · [Overzicht](nl.md) · Volgende: [7. Inloggen op Linux →](07_linux_login_pam_nl.md)
