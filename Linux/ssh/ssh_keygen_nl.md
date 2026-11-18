---
title: "Best practice: een SSH-sleutelpaar maken"
date: 2025-11-18
description: "Best practice voor het maken van een Ed25519-sleutelpaar met ssh-keygen, en wat de opties betekenen."
translated_by_ai: true
translated_from: "en"
original: "ssh_keygen.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](ssh_keygen.md).*

![](./ssh-150x150.png "ssh-150x150.png")

### Inleiding
Een korte best-practice-handleiding voor het maken van een SSH-sleutelpaar op de Linux-commandoregel.

Een publiek/privé-sleutelpaar is een paar wiskundig verwante sleutels dat in asymmetrische cryptografie wordt gebruikt voor authenticatie, digitale handtekeningen of het afspreken van sleutels. Zoals de naam al zegt, wordt de privésleutel gebruikt door de eigenaar van het sleutelpaar, blijft hij geheim en moet hij altijd beschermd worden. De publieke sleutel mag je openbaar maken; de andere partij gebruikt die om het protocol af te ronden of om te controleren wat met de privésleutel is gedaan.

**DEEL NOOIT JE PRIVÉSLEUTEL!**

#### Mijn voorkeur: het sleuteltype Ed25519
Ik gebruik het liefst het sleuteltype [Ed25519](https://ed25519.cr.yp.to/). Het is in 2014 aan OpenSSH toegevoegd en wordt door alle huidige OpenSSH-versies ondersteund. Sommige oude clients, servers en netwerkapparaten ondersteunen het nog niet; kijk in hun documentatie als je tegen problemen aanloopt.

Maak een sleutelpaar met dit commando in een Linux/Unix-terminal. Het maakt twee bestanden in je map `~/.ssh` (`id_ed25519` en `id_ed25519.pub`):

```shell
ssh-keygen -t ed25519 -a 100 -C my@email.tld
```

* -a  Het aantal rondes van de KDF ([Key Derivation Function](https://nl.wikipedia.org/wiki/Sleutelafleidingsfunctie)). Hoe hoger, hoe trager het controleren van de wachtzin, wat het lastiger maakt om het wachtwoord met brute kracht te kraken als de privésleutel wordt gestolen. Gebruik minstens 100 rondes.
* -t  Het type sleutel, in ons geval Ed25519.
* -f  De bestandsnaam van de sleutel. Wil je dat SSH hem automatisch vindt, bewaar hem dan in de standaardmap `.ssh` in je thuismap.
* -C  Een opmerking. Puur ter informatie en mag van alles zijn, maar meestal is het `<login>@<hostname>` van degene die de sleutel maakte.

[Hier vind je de ssh-keygen-instructies van IBM](https://www.ibm.com/docs/en/zos/2.4.0?topic=descriptions-ssh-keygen-authentication-key-generation-management-conversion) (Engels).
