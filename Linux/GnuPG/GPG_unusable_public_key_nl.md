---
title: "GnuPG: onbruikbare publieke sleutel"
date: 2025-11-18
description: "Los de fout 'There is no assurance this key belongs to the named user' in GnuPG op."
translated_by_ai: true
translated_from: "en"
original: "GPG_unusable_public_key.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](GPG_unusable_public_key.md).*

# Oplossing: de fout "Unusable public key" in GPG

## Foutmelding

Krijg je de volgende fout, dan betekent dat meestal dat er geen vertrouwde publieke sleutel beschikbaar is:

```bash
There is no assurance this key belongs to the named user
encryption failed: Unusable public key
```

## Oorzaak

GPG weigert te versleutelen omdat de publieke sleutel niet wordt vertrouwd.

## Oplossing

Je moet de publieke sleutel als vertrouwd markeren.

### Stap 1: de beschikbare sleutels tonen

```bash
gpg --list-keys
```

Voorbeelduitvoer:

```bash
pub   ed25519 2026-04-09 [C]
      ABCDEFGHIJKLMNOPQRSTUVWXYX1234
uid           [ultimate] John Doe <John.Doe@domain.tld>
```

### Stap 2: de sleutel bewerken

Gebruik het e-mailadres (of de sleutel-ID) uit de regel `uid`:

```bash
gpg --edit-key John.Doe@domain.tld
```

### Stap 3: het vertrouwensniveau instellen

Typ in de GPG-prompt:

```text
trust
5
y
quit
```

### Stap 4: controleren

Na het instellen van het vertrouwensniveau zou GPG zonder fouten moeten kunnen versleutelen.

---

## Opmerkingen

* Vertrouwensniveau `5` betekent "ultiem vertrouwen" en is bedoeld voor je eigen sleutels.
* Je kunt ook de vingerafdruk van de sleutel gebruiken in plaats van het e-mailadres, voor een preciezere identificatie.
* Zorg dat de sleutel een subsleutel voor versleuteling heeft (`[E]`) als je hem gebruikt met tools zoals `pass`.

