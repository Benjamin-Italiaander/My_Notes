# YubiKey bare minimum
#### A short Getting Started Using the Linux CLI

Step 1 till step 8 are the absolute bare minimum you should complete before you start using your YubiKey.
If you skip these steps, there is nothing truly secure about using your YubiKey.

Hardware tokens are a powerful tool and can raise your security to a very high level—but only when used correctly.
Be aware that using hardware tokens incorrectly will not result in a more secure user environment.


This instruction is a modified document based on the YubiKey guide found here **[Securing SSH with FIDO2](https://developers.yubico.com/SSH/Securing_SSH_with_FIDO2.html)**


> **Never use SSH agent forwarding with your YubiKey — or use of ssh -a — in fact, it’s best not to use agent forwarding at all.**


---

1. Install the Necessary Software

In my case (debian based) I added the needed packages:

```bash
sudo apt-add-repository ppa:yubico/stable
sudo apt update
sudo apt install yubikey-manager yubikey-personalization-gui
sudo apt install yubikey-personalization-gui sudo libpam-yubico
sudo apt install libpam-yubico
sudo apt install yubikey-manager-qt
```

---

2. Verify the YubiKey

Run the `ykman info` command and check if your device is detected:

```bash
ykman info
Device type: YubiKey 5C NFC
Serial number: 34397537
Firmware version: 5.7.4
Form factor: Keychain (USB-C)
Enabled USB interfaces: OTP, FIDO, CCID
NFC transport is enabled
Configured capabilities are protected by a lock code

Applications   USB      NFC
Yubico OTP     Enabled  Enabled
FIDO U2F       Enabled  Enabled
FIDO2          Enabled  Enabled
OATH           Enabled  Enabled
PIV            Enabled  Enabled
OpenPGP        Enabled  Enabled
YubiHSM Auth   Enabled  Enabled
```

---

3. FIDO2

## Change Default FIDO2 PIN

For stronger security, set a FIDO2 PIN on your YubiKey:

```bash
ykman fido access change-pin
```

You will be prompted for:

- current PIN (or empty if default)
  
- new PIN
  
- confirmation
  

4. Verify the PIN

```bash
ykman fido access verify-pin
Enter your PIN:
PIN verified.
```

---

# PIV (Smartcard)

## Default Values

To change PIV access, you need the default credentials:

- **Default PIN:** `123456`
  
- **Default PUK:** `12345678`
  
- **Default management key:** (Yubico default 24-byte key unless changed)
  

---

5. Change PIN

```bash
ykman piv access change-pin
```

6. Change PUK

```bash
ykman piv access change-puk
```

7. Change the Management Key

I recommend generating a new management key automatically:

```bash
ykman piv access change-management-key --protect --generate
```

> **SAVE your management key and PUK somewhere safe.**  
> I made a QR code from it and stored it offline.

---

8. Check FIDO Credentials

Now check if the PIN works — this command should ask for it:

```bash
ykman fido credentials list
Enter your PIN:
Credential ID  RP ID  Username  Display name
```

---

# SSH with YubiKey (FIDO2)

It is **not** possible to copy an SSH private key *into* a YubiKey.  
Instead, your YubiKey can **generate and store** the private key internally.

You **cannot extract** the private key later — which is the point.

---

## Generate an SSH Key on the YubiKey

Generate a key **without passphrase** so just press Enter twice when asked.

Use the serial number in your comment:

```bash
ssh-keygen -t ed25519-sk -O resident -O verify-required \
  -f ~/.ssh/yubikey \
  -C "Benjamin Yubikey 12345678"
```

Example output:

```
You may need to touch your authenticator to authorize key generation.
Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/benjamin/.ssh/yubikey
Your public key has been saved in /home/benjamin/.ssh/yubikey.pub
The key fingerprint is:
SHA256:hdfjfhsdjfhdjfhdjfhdjfhdjfhdjfhdjfhdjfhdj Benjamin Yubikey 12345678
```

---

# Key Generation Options Explained

| Option | Meaning |
| --- | --- |
| **`-t ed25519-sk`** | FIDO2 security key-backed Ed25519 key. |
| **`-O resident`** | Stores the private key **inside** the YubiKey (resident credential). |
| **`-O verify-required`** | Requires **PIN + touch** on every authentication. |
| **`-O application=ssh:<name>`** | Optional label for multiple credentials. |
| **`-C "comment"`** | Adds a comment to the public key. |

### Notes

- Without `-O resident`, only a *key handle* is stored on disk — not the private key.
  
- Resident keys require a FIDO2 PIN.
  
- Public keys (`*.pub`) are used for your servers or GitHub.
  

---

# FIDO2 SSH Workflow

The key generation process consists of:

1. **Touch YubiKey** to confirm key creation.
  
2. **Enter FIDO2 PIN** for resident keys.
  
3. **Save location** for the key handle.
  
4. Optional: **add a passphrase** for the handle file (not needed if using PIN+touch).
  

The `.pub` file is the only part you share.
