
# **YubiKey basisconfiguratie**

#### Een korte introductie voor gebruik via de Linux CLI

Stap 1 t/m stap 8 zijn het **absolute minimum** dat je moet uitvoeren voordat je je YubiKey in gebruik neemt.
Als je deze stappen overslaat, is er **niets echt veilig** aan het gebruik van je YubiKey.

Hardware-tokens zijn een krachtig hulpmiddel en kunnen je beveiliging naar een zeer hoog niveau tillen — **maar alleen wanneer je ze correct gebruikt**.
Wees je ervan bewust dat hardware-tokens **verkeerd gebruiken níét** resulteert in een veiliger gebruikersomgeving.

Deze instructie is gebaseerd op de YubiKey-handleiding die hier te vinden is:
**[Securing SSH with FIDO2](https://developers.yubico.com/SSH/Securing_SSH_with_FIDO2.html)**

> **Gebruik nooit SSH agent forwarding met je YubiKey — of enige vorm van `ssh -a` — eigenlijk is het het beste om agent forwarding helemaal niet te gebruiken.**

---

## **1. Installeer de benodigde software**

In mijn geval (Debian-gebaseerde systemen) heb ik de volgende pakketten toegevoegd:

```bash
sudo apt-add-repository ppa:yubico/stable
sudo apt update
sudo apt install yubikey-manager yubikey-personalization-gui
sudo apt install yubikey-personalization-gui sudo libpam-yubico
sudo apt install libpam-yubico
sudo apt install yubikey-manager-qt
```

---

## **2. Controleer de YubiKey**

Voer het commando `ykman info` uit om te controleren of je device wordt gedetecteerd:

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

## **3. FIDO2**

### **Verander de standaard FIDO2-PIN**

Voor betere beveiliging stel je een FIDO2-PIN in voor je YubiKey:

```bash
ykman fido access change-pin
```

Je wordt gevraagd om:

* huidige PIN (of leeg laten als hij nog standaard is)
* nieuwe PIN
* bevestiging

---

## **4. Controleer de PIN**

```bash
ykman fido access verify-pin
Enter your PIN:
PIN verified.
```

---

# **PIV (Smartcard)**

## **Standaardwaarden**

Voor het aanpassen van PIV-toegang heb je de standaardwaarden nodig:

* **Standaard PIN:** `123456`
* **Standaard PUK:** `12345678`
* **Standaard management key:** (Yubico 24-byte standaard key, tenzij gewijzigd)

---

## **5. Verander de PIN**

```bash
ykman piv access change-pin
```

---

## **6. Verander de PUK**

```bash
ykman piv access change-puk
```

---

## **7. Verander de Management Key**

Ik raad aan om automatisch een nieuwe management key te genereren:

```bash
ykman piv access change-management-key --protect --generate
```

> **BEWAAR je management key en PUK op een veilige plek.**
> Ik heb er zelf een QR-code van gemaakt en deze offline opgeslagen.

---

## **8. Controleer FIDO-credentials**

Controleer of de PIN werkt — dit commando zou ernaar moeten vragen:

```bash
ykman fido credentials list
Enter your PIN:
Credential ID  RP ID  Username  Display name
```

---

Als je wilt, kan ik dit hele document:

✅ omzetten naar **Markdown met headings**
✅ omzetten naar **een PDF met nette layout**
✅ herschrijven in een **kortere quick-start versie**
✅ uitbreiden met **SSH configuratie, PIV, OpenPGP, touch policies**, etc.

Laat maar weten wat je nodig hebt!
