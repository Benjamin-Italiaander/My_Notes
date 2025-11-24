Hier is een **duidelijke, complete en professionele uitleg** voor het **instellen van PGP op een YubiKey**.
Ik houd het overzichtelijk maar technisch correct.

---

# 🔐 Instellen van PGP op een YubiKey (GPG + YubiKey)

Dit is de **standaard, best-practice workflow** om PGP veilig op een YubiKey te gebruiken.

---

## **1. Installeer benodigde software**

### Linux

```bash
sudo apt install gnupg2 scdaemon pcscd yubikey-manager yubikey-personalization
sudo systemctl enable --now pcscd
```

### macOS (via Homebrew)

```bash
brew install gnupg yubikey-personalization yubikey-manager
brew services start pcscd
```

---

## **2. Maak een *offline master key***

Dit is de belangrijkste stap.

De master key gebruik je alleen voor:

* Subkeys aanmaken
* Revocation certificate genereren
* Key management

**Aanbevolen:** maak deze op een air-gapped machine of in een tijdelijke VM.

```bash
gpg --full-generate-key
```

Kies:

* Type: **RSA (4096)** of **Ed25519 (modern, sneller)**
* Expiration: 1 year (te verlengen)
* User ID: jouw naam / e-mail

---

## **3. Genereer drie subkeys**

De YubiKey gebruikt **subkeys**, niet de master key zelf.

### Aanbevolen subkeys:

* **Signing** (S)
* **Encryption** (E)
* **Authentication** (A)

Start GPG edit mode:

```bash
gpg --edit-key <MASTERKEYID>
```

Voeg subkeys toe:

```
addkey
```

Kies per key:

* **S**: RSA-Sign / Ed25519
* **E**: RSA-Encrypt / Curve25519
* **A**: RSA-Auth / Ed25519

---

## **4. Exporteer back-ups (zeer belangrijk)**

```bash
gpg --export-secret-keys <MASTERKEYID> > master-private.gpg
gpg --export-secret-subkeys <MASTERKEYID> > subkeys-private.gpg
gpg --export <MASTERKEYID> > public.gpg
```

Bewaar deze offline (USB in kluis).
Genereer ook een revocation certificate:

```bash
gpg --gen-revoke <MASTERKEYID> > revoke-cert.asc
```

---

## **5. Verplaats subkeys naar de YubiKey**

Open de key:

```bash
gpg --edit-key <MASTERKEYID>
```

Selecteer de subkey:

```
key 1
keytocard
```

Kies de juiste slot:

* **Signature → Slot 1**
* **Encryption → Slot 2**
* **Authentication → Slot 3**

Herhaal voor alle drie.

De subkeys staan nu *uitsluitend* op je YubiKey.

---

## **6. Verwijder lokale private subkeys**

Om te forceren dat *alle* cryptografische operaties via je YubiKey gaan:

```bash
gpg --edit-key <MASTERKEYID>
```

Type:

```
key 1
key 2
key 3
delkey
save
```

**Alleen de master key blijft lokaal — en die bewaar je offline.**

---

## **7. Stel PIN, Admin PIN en Touch Policies in**

PIN wijzigen:

```bash
ykman openpgp access change-pin
```

Admin PIN wijzigen:

```bash
ykman openpgp access change-admin-pin
```

Touch policy instellen:

```bash
ykman openpgp keys set-touch SIG on
ykman openpgp keys set-touch ENC on
ykman openpgp keys set-touch AUT on
```

---

## **8. Test of PGP via YubiKey werkt**

Test encryptie:

```bash
echo "test123" | gpg --encrypt --armor -r <MASTERKEYID>
```

Test signing:

```bash
echo "test" | gpg --sign --armor
```

Je YubiKey moet nu:

* oplichten
* om touch vragen
* de cryptografie uitvoeren

---

## **9. Voeg je public key toe aan systemen/e-mail**

Public key export:

```bash
gpg --armor --export <MASTERKEYID>
```

Gebruik deze voor:

* E-mail versleuteling (Thunderbird, Mutt, Outlook plugin)
* Git signing (`git config --global user.signingkey`)
* SSH authenticatie via GPG-agent (`enable-ssh-support`)

---

## Wil je dat ik hier een **stap-voor-stap Markdown handleiding** van maak voor je documentatie?

Of een **kortere TL;DR versie** voor in je YubiKey setup guide?
