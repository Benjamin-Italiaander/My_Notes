---
title: "Een gebruiker toegang geven tot seriële (TTY-)apparaten"
date: 2025-11-18
description: "Geef een Linux-gebruiker met de groep dialout toegang tot seriële apparaten zoals /dev/ttyUSB0."
translated_by_ai: true
translated_from: "en"
original: "allow_tty.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](allow_tty.md).*

# Een gebruiker toegang geven tot seriële (TTY-)apparaten

Maak op Ubuntu de gebruiker aan en voeg die toe aan de groep `dialout`. `dialout` geeft normaal toegang tot seriële apparaten zoals `/dev/ttyUSB0`, `/dev/ttyACM0` en `/dev/ttyS0`.

```bash
# Create the user
sudo adduser username

# Allow access to serial/TTY devices
sudo usermod -aG dialout username
```

Controleer:

```bash
groups username
```

Je ziet dan zoiets als:

```text
username : username dialout
```

De gebruiker moet **uit- en weer inloggen** voordat het nieuwe groepslidmaatschap werkt.

### Een bepaald `/dev/tty*`-apparaat controleren

Bijvoorbeeld:

```bash
ls -l /dev/ttyUSB0
```

Meestal:

```text
crw-rw---- 1 root dialout ... /dev/ttyUSB0
```

Lid zijn van `dialout` is dus genoeg.

Bedoel je **alle `/dev/tty*`-apparaten**, inclusief fysieke consoles zoals `/dev/tty1`, dan ligt het iets anders. Die zijn vaak van de groep `tty`:

```bash
ls -l /dev/tty1
```

Je kunt de gebruiker ook aan die groep toevoegen:

```bash
sudo usermod -aG tty username
```

Voor seriële hardware zou ik het echter bij **alleen `dialout`** houden, tenzij je echt toegang tot de console-TTY's nodig hebt.
