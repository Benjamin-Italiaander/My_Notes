# Create an OTP MFA Tool in the Bash Terminal

I was tired of using **Google Authenticator**, so I found a simple way to generate my own **OTP (One-Time Password)** codes directly in **Bash**.  
Just replace the example string below (`JHJH...`) with your own secret key.

```bash
/usr/bin/oathtool -b --totp 'JHJHJHJHJHJHJHJHJHJHJHJHJ'
```

If you want to copy the token directly to your clipboard, just use **xclip**:

```bash
/usr/bin/oathtool -b --totp 'JHJHJHJHJHJHJHJHJHJHJHJHJ' | xclip -selection c
```

This way, you can easily run your own OTP generator right in the terminal.

---

## 🔐 Encrypting Your Secret with GPG

If you want to keep your secret key secure, you can encrypt it with **GPG**.
Here’s a simple working example — make sure both **gpg** and **oathtool** are installed first.

```bash
# This example decrypts a GPG file (example.gpg) and generates an OTP token
secret="$(gpg -d ./example.gpg 2>/dev/null)"
token="$(/usr/bin/oathtool -b --totp $secret)"
echo $token
```

---

## 🧩 Turning It Into a Script

If you’d like to make this a small reusable script, here’s an example that can either print the token to the screen or copy it to your clipboard automatically.

```bash
#!/bin/bash

gentoken() {
    # Generate an OTP token from a GPG-encrypted file
    secret="$(gpg -d ./otp_secret_example.gpg 2>/dev/null)"
    token="$(/usr/bin/oathtool -b --totp $secret)"
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

## 🧠 Summary

This Bash-based OTP generator:

* Uses `oathtool` to create TOTP codes
* Can optionally decrypt your secret with `gpg`
* Lets you print or copy the token easily

It’s a lightweight and private alternative to Google Authenticator — all from your terminal! 💻✨

---

## ⚙️ Optional: Installing the Required Tools

If you don’t have the needed tools installed yet, you can install them on most Linux systems using:

```bash
sudo apt install oathtool gpg xclip
```

---

*Made with 💚 for terminal lovers who like privacy and simplicity.*
