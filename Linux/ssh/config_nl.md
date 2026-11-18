---
title: "Het SSH-configuratiebestand"
date: 2025-11-18
description: "Voorbeelden van het SSH-clientconfiguratiebestand: gebruikers, sleutels, agent forwarding en jumphosts."
translated_by_ai: true
translated_from: "en"
original: "config.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](config.md).*

### Het configuratiebestand van de SSH-client

#### Het bestand staat in
```bash
~/.ssh/config
```

#### Voorbeeld 1
Een gewone configuratie:
```bash
Host server.tld
     User username
     IdentityFile /home/username/.ssh/id_rsa
     ForwardAgent yes
```
Met de optie `ForwardAgent` kun je je lokale SSH-sleutel op de externe server gebruiken (bijvoorbeeld om daar een `git pull` te doen) zonder je privésleutel naar die server te kopiëren. Het zit standaard in SSH en is makkelijk in te stellen. Zet het alleen aan voor servers die je vertrouwt: iedereen met root-toegang op die server kan je doorgestuurde agent gebruiken zolang je verbonden bent.

#### Voorbeeld 2
Hier heb ik een `Hostname` toegevoegd, zodat je verbinding kunt maken met de korte naam `server01`. Je kunt als hostnaam ook een IP-adres gebruiken.
```bash
Host server01
     User root
     Hostname server01.sub.tld 
     IdentityFile /root/.ssh/id_rsa
     ForwardAgent yes
```

#### Meer opties
```bash
ProxyJump jump.server.tld
```
Hiermee maak je verbinding met de externe host via een jumphost (bastion).
