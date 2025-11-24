Hier is een **duidelijke en complete handleiding** om **op Ubuntu in te loggen met je YubiKey** (PAM + FIDO2 / WebAuthn).
Dit werkt voor:

* **Ubuntu desktop login (GDM)**
* **sudo**
* **su**
* **TTY login**

Ik geef zowel de **snelle versie** als de **uitgebreide versie**.

---

# ✅ **Korte versie (TL;DR)**

1. Installeer FIDO2-tools:

```bash
sudo apt install libpam-u2f pamu2fcfg
```

2. Maak de config-map aan:

```bash
mkdir -p ~/.config/Yubico
```

3. Registreer je YubiKey:

```bash
pamu2fcfg > ~/.config/Yubico/u2f_keys
```

(raak de YubiKey aan)

4. Activeer YubiKey login voor sudo:

```bash
sudo nano /etc/pam.d/sudo
```

Voeg **bovenaan** toe:

```
auth       required   pam_u2f.so
```

5. (Optioneel) Activeren voor desktop login:

```bash
sudo nano /etc/pam.d/gdm-password
```

Bovenaan toevoegen:

```
auth       required   pam_u2f.so
```

Herstart → klaar.

---

# 🧩 **Uitgebreide handleiding: Ubuntu inloggen met YubiKey (PAM + U2F/FIDO2)**

## **1. Installeer benodigde software**

Ubuntu heeft deze pakketten in de repo:

```bash
sudo apt install libpam-u2f pamu2fcfg
```

---

## **2. Configuratiemap maken**

```bash
mkdir -p ~/.config/Yubico
```

---

## **3. YubiKey registreren voor PAM**

Dit koppelt jouw Linux-account aan de YubiKey:

```bash
pamu2fcfg > ~/.config/Yubico/u2f_keys
```

Je YubiKey begint te knipperen → raak hem aan.

Wil je meerdere YubiKeys toevoegen (bijv. backup)?

```bash
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
```

---

## **4. Sudo beveiligen met YubiKey**

**Best practice**: eerst sudo beveiligen.
Open PAM-config:

```bash
sudo nano /etc/pam.d/sudo
```

Voeg **helemaal bovenaan** toe:

```
auth required pam_u2f.so
```

Test in een andere terminal met:

```bash
sudo ls
```

Je moet nu je YubiKey aanraken.

---

## **5. Desktop login (GDM) beveiligen**

Voor Ubuntu GNOME:

```bash
sudo nano /etc/pam.d/gdm-password
```

Bovenaan:

```
auth required pam_u2f.so
```

---

## **6. Terminal / TTY login**

```bash
sudo nano /etc/pam.d/login
```

Bovenaan:

```
auth required pam_u2f.so
```

---

## **7. Opties (aanbevolen)**

Je kunt de login alleen YubiKey laten vereisen, of YubiKey **of** wachtwoord.

### 🔐 “Hard” (YubiKey verplicht)

```
auth required pam_u2f.so
```

### 🛡 “Soft” (YubiKey of wachtwoord)

```
auth sufficient pam_u2f.so
auth include system-auth
```

---

## **8. Test, voordat je login breekt**

BELANGRIJK:
Open **een tweede terminal of TTY (Ctrl+Alt+F3)** voordat je uitlogt.

Test:

```bash
sudo ls
```

Als het werkt → je bent klaar.

Als niet → verwijder de rule uit PAM.

---
