---
title: "Eerste tapecommando's in Linux"
date: 2025-11-18
description: "De eerste stappen met tapedrives en autoloaders op Linux: lsscsi, mt, mtx en de waarschuwing over LTO-9-kalibratie."
translated_by_ai: true
translated_from: "en"
original: "first-tape-commands-in-linux.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](first-tape-commands-in-linux.md).*

# Tape-autoloaders, -drives en -bibliotheken beheren vanuit de Unix/Linux-CLI
De eerste stap bij het beheren van tapes in Linux is het gebruik van de commando's `mt` en `mtx`.

Tools in dit artikel:
- lsscsi (toont SCSI-apparaten (of hosts) en NVMe-apparaten)
- mt (bestuurt een magnetische tapedrive, uit het pakket mt-st): bedient de tapedrive, zoals het verplaatsen en uitwerpen van de tape en de drive-instellingen.
- mtx (bestuurt SCSI-mediawisselaars): bedient tapebibliotheken (cartridges van vakken naar drives verplaatsen, enzovoort)
- tar (een archiveringstool)
- ltfs (Linear Tape File System)
- sg3-utils (het pakket sg3_utils bevat tools die SCSI-commando's naar apparaten sturen)
- dd (bestanden omzetten en kopiëren)

---  
# Let op! De eerste keer dat je een LTO-9-tape laadt, start een kalibratie die tot 2 uur kan duren
Als een LTO-9-tape voor het eerst in een LTO-9-drive wordt geladen, start de drive automatisch een tapekalibratie, waarbij de cartridge wordt geïnitialiseerd en doorgemeten.

BELANGRIJK: volgens IBM kan de LTO-9-kalibratie 20 minuten tot 2 uur duren.

Tijdens de kalibratie staat de drive op “Calibrating” en is er geen andere actie mogelijk, ook geen toegang vanaf de host. Na de kalibratie gaat de drive automatisch naar de status "Loaded" en is de tape beschikbaar voor de host. Wordt een niet-geïnitialiseerde LTO-9-tape naar een drive verplaatst voor een mediacontrole, dan mislukt elke poging om die controle tijdens “Calibrating” af te breken met “Drive is busy calibrating”.

---


#### De autoloader vinden met lsscsi: zoek het apparaat met het label mediumx
```bash
lsscsi -g
[1:0:0:0]    tape    IBM      ULT3580-HH9      Q3F5  /dev/st0   /dev/sg3 
[1:0:0:1]    mediumx IBM      3572-TL          0131  /dev/sch0  /dev/sg4 

# In this case the autoloader is /dev/sch0 / /dev/sg4, because it is marked as mediumx.
# The tape drive itself is /dev/st0.
```



# De tape-autoloader besturen in Linux
## Een tape-autoloader bestaat uit twee apparaten:
1. de autoloader (mediawisselaar)
2. de tapedrive

De loader bestuur je met het commando `mtx`, bijvoorbeeld:
```bash
# Load tape 1
sudo mtx -f /dev/sg4 load 1

# Get status from loader
sudo mtx -f /dev/sg4 status

# Unload the autoloader
sudo mtx -f /dev/sg4 unload

```

Bij LTO-tapes kun je bij het uitladen een foutmelding krijgen. Zet in dat geval eerst de tape in de drive offline:
```bash
sudo mt -f /dev/st0 offline
```

De tapedrive bestuur je met het commando `mt`, bijvoorbeeld:
```bash
sudo mt -f /dev/st0 rewind
```

Dit artikel is deels overgenomen van [deze pagina](https://blogs.intellique.com/cgi-bin/tech/2022/01/27) (Engels).
