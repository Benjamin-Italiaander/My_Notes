---
title: "YubiKey 2 — Eerste instelling (het absolute minimum)"
date: 2025-11-18
description: "Vervang elke standaard-PIN, -PUK en managementsleutel voordat je je YubiKey gebruikt."
translated_by_ai: true
translated_from: "en"
original: "02_first_time_setup.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](02_first_time_setup.md).* De commando's zijn niet vertaald.

# 2. Eerste instelling — het absolute minimum

[← 1. Installatie](01_installation_nl.md) · [Overzicht](nl.md) · Volgende: [3. TOTP-codes →](03_totp_oath_nl.md)

Elke YubiKey verlaat de fabriek met **dezelfde, openbaar bekende standaardwaarden**. Zolang je die niet verandert, kan iedereen die je sleutel in handen heeft hem gebruiken.

> ✅ Loop deze checklist door voor **elke** YubiKey die je hebt, ook de reservesleutel.

| ✔ | Toepassing | Wat je verandert | Standaard |
|---|-------------|----------------|---------|
| ☐ | FIDO2 | Een PIN instellen | *(geen)* |
| ☐ | PIV | PIN | `123456` |
| ☐ | PIV | PUK | `12345678` |
| ☐ | PIV | Managementsleutel | `010203040506070801020304050607080102030405060708` |
| ☐ | OpenPGP | User PIN | `123456` |
| ☐ | OpenPGP | Admin PIN | `12345678` |
| ☐ | OATH | Wachtwoord | *(geen)* — zie [hoofdstuk 3](03_totp_oath_nl.md) |

> 💾 **Schrijf je PUK, Admin-PIN en managementsleutel op en bewaar ze offline** (op papier, of als QR-code in een kluis).
> Hoe je in de CLI een QR-code maakt, lees je [hier](../cli/qrcode_nl.md).

---

## 2.1 De sleutel controleren

```bash
ykman info
```

Je ziet het type apparaat, het serienummer en de ingeschakelde toepassingen (zie [hoofdstuk 1](01_installation_nl.md#13-verify-the-installation)).

---

## 2.2 FIDO2 — een PIN instellen

```bash
ykman fido info                 # shows "PIN: Not set" on a new key
ykman fido access change-pin    # leave "current PIN" empty on a new key
```

Controleer:

```bash
ykman fido access verify-pin
ykman fido credentials list     # must ask for your PIN
```

Optioneel — altijd de PIN vragen (User Verification) voor FIDO2:

```bash
ykman fido config toggle-always-uv
```

---

## 2.3 PIV (smartcard) — PIN, PUK en managementsleutel

```bash
ykman piv access change-pin     # default 123456
ykman piv access change-puk     # default 12345678
```

Verander de managementsleutel. **Optie A (aanbevolen):** maak een willekeurige sleutel en bescherm die met je PIN, zodat je hem niet hoeft te onthouden:

```bash
ykman piv access change-management-key --generate --protect
```

**Optie B:** maak een sleutel en bewaar hem zelf (offline, uitgeprint, als QR …):

```bash
ykman piv access change-management-key --generate
```

> Oudere firmware heeft misschien een expliciet algoritme nodig, bijvoorbeeld `-a TDES`.

---

## 2.4 OpenPGP — User-PIN en Admin-PIN

> 💡 Ga je OpenPGP gebruiken ([hoofdstuk 5](05_openpgp_gpg_ssh_nl.md))? Doe dan **eerst** de **KDF-instelling** uit paragraaf 5.2 en kom daarna hier terug. KDF moet aan staan zolang de PIN's nog de standaardwaarden hebben.

```bash
ykman openpgp access change-pin          # default 123456
ykman openpgp access change-admin-pin    # default 12345678
```

---

## 2.5 Klaar?

Doe deze snelle controle — elk commando moet nu om **je eigen** PIN vragen, niet om een standaard-PIN:

```bash
ykman fido credentials list
ykman piv info
ykman openpgp info
```

---

[← 1. Installatie](01_installation_nl.md) · [Overzicht](nl.md) · Volgende: [3. TOTP-codes →](03_totp_oath_nl.md)
