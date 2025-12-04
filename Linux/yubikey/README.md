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

There are more ways of installing my advice is to follow [this](https://github.com/Benjamin-Italiaander/My_Notes/blob/main/Linux/yubikey/EN_yubikey_install_ykman.md) instruction, but in case you are in a rush or a less advanced user you can use the apt repo, in my case (debian based) I added the needed packages:

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
Serial number: 12345678
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
