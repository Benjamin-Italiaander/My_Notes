---
title: "Key Derivation Function"
date: 2016-10-28
description: "Key Derivation Function uitgelegd in het nederlands"
math: true
---

# Key Derivation Function (KDF)

## Sleutelafleidingsfunctie

> **Cryptografie | Sleutelbeheer | Wachtwoordbeveiliging**

Een **sleutelafleidingsfunctie** (*Key Derivation Function*, afgekort **KDF**) is een cryptografisch algoritme waarmee één of meerdere geheime sleutels worden afgeleid uit een bestaande geheime waarde.

Deze oorspronkelijke waarde kan bijvoorbeeld bestaan uit een hoofdsleutel (*master key*), een wachtwoord of een wachtwoordzin (*passphrase*).

KDF's vormen een belangrijk onderdeel van moderne cryptografische systemen en worden onder andere gebruikt voor encryptie, authenticatie, wachtwoordbeveiliging en veilig sleutelbeheer.

---

## 1. Werking van een sleutelafleidingsfunctie

Een KDF gebruikt doorgaans een pseudowillekeurige functie, gebaseerd op een cryptografische hashfunctie of een blokversleutelingsalgoritme.

Het doel is om uit bestaand geheim materiaal nieuwe cryptografische sleutels te genereren.

### Belangrijkste toepassingen

- **Sleutelafleiding:** meerdere cryptografische sleutels genereren uit één hoofdsleutel.
- **Sleutelscheiding:** voorkomen dat verschillende toepassingen dezelfde cryptografische sleutel gebruiken.
- **Wachtwoordbeveiliging:** wachtwoorden omzetten naar waarden die geschikt zijn voor veilige opslag of sleutelgebruik.
- **Key stretching:** het berekenen van sleutels bewust vertragen om brute-forceaanvallen te bemoeilijken.
- **Sleuteluitwisseling:** gedeelde geheimen omzetten naar cryptografische sleutels.
- **Sleutelbeheer:** cryptografische sleutels voor verschillende doeleinden onafhankelijk afleiden.

### Vereenvoudigde werking

```text
                  +------------------+
                  |   Master Secret  |
                  |   of Password    |
                  +---------+--------+
                            |
                            v
                  +------------------+
                  |       KDF        |
                  |                  |
                  |  Salt / Context  |
                  |  Parameters      |
                  +---------+--------+
                            |
              +-------------+-------------+
              |             |             |
              v             v             v
         +---------+   +---------+   +---------+
         | Key A   |   | Key B   |   | Key C   |
         +---------+   +---------+   +---------+
```

Bij een correct ontworpen sleutelafleidingsfunctie mag het achterhalen van één afgeleide sleutel niet leiden tot het achterhalen van de oorspronkelijke geheime waarde of andere afgeleide sleutels.

---

## 2. Sleutelafleiding en sleuteldiversificatie

Een belangrijk toepassingsgebied van KDF's is **key diversification**.

Hierbij worden meerdere cryptografische sleutels afgeleid uit één gemeenschappelijk geheim.

Dit voorkomt dat dezelfde sleutel voor verschillende cryptografische doeleinden wordt gebruikt.

### Voorbeeld

Stel dat een systeem beschikt over één hoofdsleutel:

```text
Master Key
    |
    +----> KDF(context="encryption") ---> Encryption Key
    |
    +----> KDF(context="authentication") -> Authentication Key
    |
    +----> KDF(context="session") ------> Session Key
```

Elke afgeleide sleutel heeft een specifiek doel.

Dit principe wordt **cryptografische domeinscheiding** (*domain separation*) genoemd.

Door verschillende contextwaarden te gebruiken, kunnen sleutels onafhankelijk van elkaar worden afgeleid.

### Voordelen

1. Eén hoofdsleutel kan meerdere cryptografische toepassingen ondersteunen.
2. Verschillende toepassingen hoeven niet dezelfde sleutel te delen.
3. Het risico van ongewenst sleutelhergebruik wordt beperkt.
4. Sleutelbeheer wordt eenvoudiger.
5. Cryptografische protocollen kunnen verschillende sleutels voor verschillende functies gebruiken.

---

## 3. Key Stretching en Key Strengthening

Menselijke wachtwoorden bevatten doorgaans onvoldoende entropie om rechtstreeks als sterke cryptografische sleutel te dienen.

Een wachtwoord zoals:

```text
MijnWachtwoord123
```

kan relatief eenvoudig worden geraden wanneer een aanvaller voldoende rekenkracht beschikbaar heeft.

Een techniek om dit probleem te beperken is **key stretching**.

### Wat is key stretching?

Key stretching maakt het berekenen van een cryptografische waarde uit een wachtwoord bewust duurder.

Dit gebeurt door extra rekenwerk, geheugenverbruik of beide te vereisen.

Een vereenvoudigde voorstelling is:

```text
DerivedKey = KDF(password, salt, parameters)
```

Waarbij:

| Parameter | Betekenis |
|---|---|
| `DerivedKey` | De afgeleide cryptografische sleutel |
| `KDF` | De gebruikte sleutelafleidingsfunctie |
| `password` | Het oorspronkelijke wachtwoord |
| `salt` | Een willekeurige waarde |
| `parameters` | Instellingen voor rekenkosten, geheugenverbruik of parallelisme |

### Waarom is dit belangrijk?

Wanneer een aanvaller een wachtwoord probeert te achterhalen, moet deze voor iedere poging opnieuw de KDF uitvoeren.

Een gewone hashfunctie kan zeer snel worden berekend.

Een speciaal ontworpen wachtwoord-KDF kan daarentegen aanzienlijk meer tijd en geheugen vereisen.

Hierdoor worden grootschalige brute-forceaanvallen duurder.

> [!IMPORTANT]
> Key stretching verhoogt niet de oorspronkelijke entropie van een wachtwoord. Het maakt het testen van wachtwoordkandidaten duurder, maar verandert een zwak wachtwoord niet in een werkelijk willekeurig geheim.

---

## 4. Het gebruik van een Salt

Een **salt** is een willekeurige waarde die wordt toegevoegd aan het proces waarmee een wachtwoord wordt verwerkt.

Het belangrijkste doel is te voorkomen dat identieke wachtwoorden automatisch dezelfde afgeleide waarde opleveren.

### Zonder salt

```text
Password: geheim123
       |
       v
      Hash
       |
       v
  7f83b165...
```

Wanneer twee gebruikers hetzelfde wachtwoord gebruiken, krijgen zij bij dezelfde hashfunctie dezelfde hashwaarde.

### Met salt

```text
Password: geheim123       Password: geheim123
Salt:     A7F2            Salt:     B9C4
       |                         |
       v                         v
      KDF                       KDF
       |                         |
       v                         v
   DerivedKey A              DerivedKey B
```

Hoewel beide gebruikers hetzelfde wachtwoord hebben, verschillen de resultaten.

### Eigenschappen van een salt

- Een salt moet voldoende willekeurig zijn.
- Voor iedere wachtwoordregistratie wordt een nieuwe salt gegenereerd.
- Een salt hoeft niet geheim te blijven.
- Een salt kan samen met de afgeleide waarde worden opgeslagen.
- Een salt beperkt de bruikbaarheid van vooraf berekende tabellen, zoals rainbow tables.

> [!NOTE]
> Een salt is geen vervanging voor een sterk wachtwoord of een veilige wachtwoordhashfunctie.

---

## 5. Sleutelafleiding uit wachtwoorden

Gewone cryptografische hashfuncties, zoals SHA-256 en SHA-512, zijn ontworpen om snel en efficiënt te werken.

Voor veel cryptografische toepassingen is dit wenselijk.

Bij wachtwoordbeveiliging vormt deze snelheid echter een nadeel.

Een aanvaller die toegang krijgt tot opgeslagen wachtwoordhashes kan met krachtige hardware zeer veel wachtwoordkandidaten proberen.

Daarom bestaan er gespecialiseerde algoritmen voor wachtwoordhashing en sleutelafleiding.

### Bekende algoritmen

| Algoritme | Eigenschappen | Toepassing |
|---|---|---|
| PBKDF2 | Instelbaar aantal iteraties | Wachtwoordafleiding |
| bcrypt | Instelbare rekenkosten | Wachtwoordhashing |
| scrypt | Geheugenintensief | Wachtwoordhashing en sleutelafleiding |
| Argon2 | Instelbare geheugen- en rekenkosten | Wachtwoordhashing |
| Argon2id | Combineert eigenschappen van Argon2i en Argon2d | Moderne wachtwoordbeveiliging |
| HKDF | Efficiënte sleutelafleiding op basis van HMAC | Cryptografisch sleutelbeheer |

### Belangrijk onderscheid

Niet iedere KDF is bedoeld voor wachtwoorden.

**HKDF** is bijvoorbeeld geschikt om cryptografische sleutels af te leiden uit geheim materiaal met voldoende entropie.

**Argon2id** is daarentegen specifiek ontworpen om het raden van wachtwoorden kostbaar te maken.

Deze algoritmen zijn daarom niet zonder meer onderling uitwisselbaar.

---

## 6. PBKDF2

**Password-Based Key Derivation Function 2 (PBKDF2)** is een veelgebruikte standaard voor het afleiden van cryptografische sleutels uit wachtwoorden.

PBKDF2 maakt gebruik van een pseudowillekeurige functie, meestal gebaseerd op HMAC.

### Werking

PBKDF2 combineert:

1. Een wachtwoord.
2. Een salt.
3. Een instelbaar aantal iteraties.
4. Een gewenste sleutellengte.

Een voorbeeld:

```text
PBKDF2(
    password,
    salt,
    iterations,
    key_length
)
```

### Voordelen

- Breed ondersteund.
- Gestandaardiseerd.
- Geschikt voor omgevingen met specifieke compliance-eisen.
- Relatief eenvoudig te implementeren met bestaande cryptografische bibliotheken.

### Nadelen

PBKDF2 is voornamelijk rekenintensief en vereist relatief weinig geheugen.

Hierdoor kunnen gespecialiseerde GPU's en andere hardware veel berekeningen parallel uitvoeren.

Moderne geheugenintensieve algoritmen zoals Argon2id bieden doorgaans betere mogelijkheden om dergelijke aanvallen duurder te maken.

---

## 7. scrypt

**scrypt** is een sleutelafleidingsfunctie die is ontworpen om niet alleen rekentijd, maar ook geheugen te vereisen.

Het algoritme maakt gebruik van een geheugenintensieve berekening.

### Doel

Een aanvaller moet voor iedere wachtwoordpoging aanzienlijke reken- en geheugenresources inzetten.

Dit beperkt de voordelen van sterk parallelle hardware.

### Eigenschappen

- Instelbaar geheugenverbruik.
- Instelbare rekenkosten.
- Geschikt voor wachtwoordhashing.
- Geschikt voor het afleiden van sleutels uit wachtwoorden.

scrypt is een bruikbaar alternatief wanneer Argon2id niet beschikbaar is.

---

## 8. Argon2

Argon2 is een moderne familie van wachtwoordhashfuncties.

Het algoritme werd ontwikkeld als onderdeel van de **Password Hashing Competition**.

Deze competitie begon in 2013 en had als doel een moderne standaard voor veilige wachtwoordverwerking te selecteren.

Op 20 juli 2015 werd Argon2 uitgeroepen tot winnaar.

### Varianten

Argon2 kent drie belangrijke varianten.

| Variant | Eigenschappen |
|---|---|
| Argon2d | Geheugentoegang afhankelijk van de verwerkte gegevens |
| Argon2i | Geheugentoegang onafhankelijk van de verwerkte gegevens |
| Argon2id | Combineert eigenschappen van Argon2i en Argon2d |

### Argon2id

Argon2id combineert bescherming tegen verschillende aanvalstechnieken.

Het algoritme biedt instelbare parameters voor:

- **Geheugenverbruik:** hoeveel geheugen nodig is.
- **Rekentijd:** hoeveel berekeningsrondes worden uitgevoerd.
- **Parallelisme:** hoeveel parallelle verwerking wordt gebruikt.

### Voorbeeld

```text
Argon2id(
    password,
    salt,
    memory_cost,
    time_cost,
    parallelism
)
```

Door deze parameters zorgvuldig te kiezen, kan een systeem een balans vinden tussen beveiliging en prestaties.

> [!TIP]
> Voor nieuwe toepassingen waarbij wachtwoorden veilig moeten worden opgeslagen, is Argon2id doorgaans de aanbevolen keuze.

---

## 9. HKDF

**HMAC-based Key Derivation Function (HKDF)** is een sleutelafleidingsfunctie gebaseerd op HMAC.

HKDF is gestandaardiseerd in RFC 5869.

Het algoritme wordt gebruikt om cryptografisch sleutelmateriaal af te leiden uit een bestaand geheim.

### Twee fasen

HKDF bestaat uit twee belangrijke stappen:

1. **Extract:** het oorspronkelijke sleutelmateriaal verwerken tot een pseudowillekeurige sleutel.
2. **Expand:** vanuit deze sleutel één of meerdere afgeleide sleutels genereren.

### Schematische werking

```text
              Input Key Material
                      |
                      v
              +---------------+
              | HKDF-Extract  |
              +-------+-------+
                      |
                      v
             Pseudorandom Key
                      |
                      v
              +---------------+
              | HKDF-Expand   |
              +-------+-------+
                      |
                      v
                Derived Keys
```

### Toepassingen

HKDF wordt onder andere gebruikt bij:

- TLS 1.3.
- Cryptografische sleuteluitwisseling.
- Afleiding van sessiesleutels.
- Sleutelscheiding binnen cryptografische protocollen.

HKDF is niet ontworpen om zwakke menselijke wachtwoorden te beschermen tegen brute-forceaanvallen.

---

## 10. Geschiedenis van wachtwoordhashfuncties

Een van de eerste technieken waarbij wachtwoordverwerking bewust werd vertraagd, was de Unix-functie `crypt`.

Deze werd in 1978 ontwikkeld door Robert Morris.

De oorspronkelijke implementatie maakte gebruik van een aangepaste versie van het DES-versleutelingsalgoritme.

Door meerdere berekeningen uit te voeren, werd het achterhalen van wachtwoorden duurder.

### Ontwikkeling

| Periode | Ontwikkeling |
|---|---|
| 1978 | Unix `crypt` met aangepaste DES |
| 1990s | Ontwikkeling van bcrypt |
| 2000 | Publicatie van PBKDF2 in PKCS #5 |
| 2009 | Introductie van scrypt |
| 2013 | Start van de Password Hashing Competition |
| 2015 | Argon2 wint de competitie |
| 2020s | Argon2id wordt breed aanbevolen voor nieuwe toepassingen |

Door de ontwikkeling van krachtige GPU's, FPGA's en ASIC's zijn oude wachtwoordhashmethoden steeds kwetsbaarder geworden voor grootschalige aanvallen.

Moderne algoritmen proberen deze ontwikkeling tegen te gaan door het benodigde geheugenverbruik en de rekentijd instelbaar te maken.

---

## 11. Veiligheidsaanbevelingen

De keuze voor een sleutelafleidingsfunctie hangt af van de toepassing.

### Wachtwoordhashing

Voor nieuwe toepassingen is de gebruikelijke voorkeursvolgorde:

1. **Argon2id** — aanbevolen voor moderne wachtwoordbeveiliging.
2. **scrypt** — geschikt alternatief wanneer Argon2id niet beschikbaar is.
3. **bcrypt** — voornamelijk voor bestaande systemen.
4. **PBKDF2** — onder andere geschikt wanneer specifieke FIPS-vereisten gelden.

### Cryptografische sleutelafleiding

Voor het afleiden van meerdere sleutels uit bestaand sterk geheim materiaal is HKDF vaak een geschikte keuze.

### Algemene aanbevelingen

- Gebruik bestaande, goed onderzochte cryptografische bibliotheken.
- Ontwikkel geen eigen cryptografische algoritmen.
- Gebruik voldoende willekeurige salts.
- Kies passende parameters voor geheugenverbruik en rekentijd.
- Voorkom hergebruik van cryptografische sleutels voor verschillende doeleinden.
- Gebruik domeinscheiding bij het afleiden van meerdere sleutels.
- Evalueer de gekozen beveiligingsparameters regelmatig.

---

## 12. Conclusie

Sleutelafleidingsfuncties vormen een fundamenteel onderdeel van moderne cryptografie.

Ze maken het mogelijk om veilig meerdere cryptografische sleutels af te leiden uit één geheim, wachtwoorden beter te beschermen en cryptografisch sleutelmateriaal geschikt te maken voor specifieke toepassingen.

De belangrijkste overweging is het onderscheid tussen **wachtwoordbeveiliging** en **cryptografische sleutelafleiding**.

Voor wachtwoordbeveiliging zijn geheugenintensieve algoritmen zoals Argon2id doorgaans geschikt.

Voor het afleiden van cryptografische sleutels uit bestaande sterke geheimen is HKDF vaak een goede keuze.

Een veilige implementatie vereist niet alleen het juiste algoritme, maar ook geschikte parameters, voldoende entropie en zorgvuldig sleutelbeheer.

---

## 13. Referenties

### Wikipedia

- [Key derivation function](https://en.wikipedia.org/wiki/Key_derivation_function)
- [PBKDF2](https://en.wikipedia.org/wiki/PBKDF2)
- [scrypt](https://en.wikipedia.org/wiki/Scrypt)
- [Argon2](https://en.wikipedia.org/wiki/Argon2)
- [HKDF](https://en.wikipedia.org/wiki/HKDF)

### Technische standaarden

- [RFC 5869 — HMAC-based Extract-and-Expand Key Derivation Function (HKDF)](https://www.rfc-editor.org/rfc/rfc5869)
- [RFC 8018 — PKCS #5: Password-Based Cryptography Specification](https://www.rfc-editor.org/rfc/rfc8018)
- [RFC 9106 — Argon2 Memory-Hard Function](https://www.rfc-editor.org/rfc/rfc9106)
- [RFC 7914 — The scrypt Password-Based Key Derivation Function](https://www.rfc-editor.org/rfc/rfc7914)

### Beveiligingsrichtlijnen

- [OWASP — Password Storage Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html)


