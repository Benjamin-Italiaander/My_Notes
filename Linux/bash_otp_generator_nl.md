---
title: "OTP-generator in Bash"
date: 2025-11-18
description: "Maak TOTP-codes in de terminal met oathtool, met het geheim versleuteld door GPG."
translated_by_ai: true
translated_from: "en"
original: "bash_otp_generator.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](bash_otp_generator.md).*

# Een OTP/MFA-tool maken in de Bash-terminal

Ik was **Google Authenticator** zat, dus zocht ik een eenvoudige manier om zelf **OTP-codes (eenmalige wachtwoorden)** te maken, direct in **Bash**.
Vervang de voorbeeldtekst hieronder (`JHJH...`) door je eigen geheime sleutel.

```bash
/usr/bin/oathtool -b --totp 'JHJHJHJHJHJHJHJHJHJHJHJHJ'
```

Wil je de code meteen naar je klembord kopiëren, gebruik dan **xclip**:

```bash
/usr/bin/oathtool -b --totp 'JHJHJHJHJHJHJHJHJHJHJHJHJ' | xclip -selection c
```

Zo heb je eenvoudig je eigen OTP-generator in de terminal.

---

## 🔐 Je geheim versleutelen met GPG

Wil je je geheime sleutel veilig bewaren, versleutel hem dan met **GPG**.
Hier een eenvoudig werkend voorbeeld — zorg eerst dat **gpg** en **oathtool** allebei geïnstalleerd zijn.

```bash
# This example decrypts a GPG file (example.gpg) and generates an OTP token
secret="$(gpg -d ./example.gpg 2>/dev/null)"
token="$(/usr/bin/oathtool -b --totp "$secret")"
echo "$token"
```

---

## 🧩 Er een script van maken

Wil je er een klein herbruikbaar script van maken? Hier een voorbeeld dat de code op het scherm toont of automatisch naar je klembord kopieert.

```bash
#!/bin/bash

gentoken() {
    # Generate an OTP token from a GPG-encrypted file
    secret="$(gpg -d ./otp_secret_example.gpg 2>/dev/null)"
    token="$(/usr/bin/oathtool -b --totp "$secret")"
}

Help() {
    # Simple help menu
    echo 
    echo "OTP token generator for user John (Office Portal)."
    echo
    echo "Syntax: $0 [-h|c|p]"
    echo "Options:"
    echo "  -h     Show this help message"
    echo "  -c     Copy token to clipboard"
    echo "  -p     Print token to screen"
    echo
}

prtoken() {
    # Print token to screen
    gentoken
    echo "$token"
}

cptoken() {
    # Copy token to clipboard using xclip
    gentoken
    echo "$token" | xclip -selection c 
}

# Parse command-line options
while getopts ":hpc" option; do
    case $option in
        h) Help; exit;;
        p) prtoken; exit;;
        c) cptoken; exit;;
        \?) echo "Error: Invalid option. Use -h for help."; exit;;
    esac
done
```

---

## 🧠 Samenvatting

Deze OTP-generator in Bash:

* gebruikt `oathtool` om TOTP-codes te maken
* kan je geheim desgewenst ontsleutelen met `gpg`
* laat je de code makkelijk tonen of kopiëren

Een lichtgewicht en privacyvriendelijk alternatief voor Google Authenticator — helemaal vanuit je terminal! 💻✨

---

## ⚙️ Optioneel: de benodigde tools installeren

Heb je de benodigde tools nog niet, dan installeer je ze op de meeste Linux-systemen met:

```bash
sudo apt install oathtool gpg xclip
```

---

*Met 💚 gemaakt voor terminalliefhebbers die van privacy en eenvoud houden.*
