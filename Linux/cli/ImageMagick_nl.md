---
title: "ImageMagick"
date: 2025-11-18
description: "Afbeeldingen en pdf's omzetten, verkleinen en in bulk bewerken met convert en mogrify van ImageMagick."
translated_by_ai: true
translated_from: "en"
original: "ImageMagick.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](ImageMagick.md).*

# ImageMagick gebruiken

Moet je snel een afbeelding of document omzetten? ImageMagick is een commandoregeltool die je daarbij heel veel tijd kan besparen. Hier een korte handleiding om het te installeren en te gebruiken om afbeeldingen, pdf's en meer om te zetten. Ideaal om herhalend werk te automatiseren.

> 💡 In ImageMagick 7 heet het commando `convert` voortaan `magick` (bijvoorbeeld `magick input.psd output.jpg`). `convert` werkt nog wel, maar is verouderd.

## ImageMagick installeren 🪄

Op Linux gebruik je je pakketbeheerder:

```bash
sudo apt install imagemagick     # Debian/Ubuntu
sudo dnf install ImageMagick     # Fedora
```

Op macOS gebruik je Homebrew 🍺:

```bash
brew install imagemagick
```

## Eenvoudig omzetten met `convert`

Zodra het geïnstalleerd is, kun je meteen aan de slag. Een heel eenvoudig voorbeeld: een `.psd`-bestand omzetten naar `.jpg`:

```bash
convert input.psd output.jpg
```

En zo wordt `input.psd` dus `output.jpg`.

## Opties toevoegen aan `convert` (pdf naar jpg)

Wil je meer controle over het resultaat? Geen probleem. Met een paar extra opties stel je de kwaliteit en resolutie in. Zo zet je een pdf om naar een jpg van hoge kwaliteit:

```bash
convert -density 150 input.pdf -quality 90 output.jpg
```

### Wat doen deze opties?

- **`-density 150`**: stelt de DPI (punten per inch) in en bepaalt daarmee de resolutie van het resultaat.
- **`-quality 90`**: stelt de compressiekwaliteit van de jpg in, een afweging tussen bestandsgrootte en beeldkwaliteit.

## Afbeeldingen verkleinen met `convert`

Wil je de afbeelding meteen verkleinen tijdens het omzetten? Dat kan ook. Zo maak je een afbeelding 800x600 pixels:

```bash
convert input.psd -resize 800x600 output.jpg
```

Dit maakt de `.psd` 800x600 en slaat hem op als `.jpg`.

## Veel bestanden tegelijk omzetten met `mogrify` (psd naar jpg)

Moet je een hele stapel bestanden tegelijk omzetten, dan is `mogrify` de beste keuze. Het hoort bij ImageMagick en is ideaal voor bulkbewerking. Anders dan `convert` past `mogrify` bestanden direct aan, of maakt het nieuwe bestanden als je het formaat verandert.

Om alle `.psd`-bestanden in een map om te zetten naar `.jpg`:

```bash
mogrify -format jpg *.psd
```

### Let op

Als je `.psd`-bestanden meerdere lagen hebben, kan `mogrify` voor elke laag een apart bestand maken (`-0`, `-1`, enzovoort).

## `mogrify` met extra opties

Wil je per bestand maar één resultaat en maken de lagen je niet uit, voeg dan de optie `-flatten` toe om alles samen te voegen:

```bash
mogrify -flatten -format jpg *.psd
```

- **`-flatten`**: voegt alle lagen samen, zodat je per `.psd` precies één `.jpg` krijgt.

## Afbeeldingen verkleinen met `mogrify`

Je kunt ook veel afbeeldingen tegelijk verkleinen. Zo maak je alle `.psd`-bestanden 800x600 en zet je ze om naar `.jpg`:

```bash
mogrify -resize 800x600 -format jpg *.psd
```

Dit verkleint elk `.psd`-bestand en slaat het op als `.jpg` in dezelfde map.

ImageMagick is een geweldige tool om bestanden in bulk te bewerken, formaten om te zetten of gewoon afbeeldingen te verkleinen. 👍
