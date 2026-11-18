---
title: "Rechten"
date: 2025-11-18
description: "Kopieer rechten en eigenaar van het ene bestand naar het andere met chmod en chown --reference."
translated_by_ai: true
translated_from: "en"
original: "README.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](README.md).*

# Rechten en eigenaar van het ene bestand naar het andere kopiëren

## chmod

Om de rechten van het ene bestand naar het andere te kopiëren, gebruik je `chmod` met de optie `--reference`. In plaats van een modus op te geven (zoals octale rechten als `644`), wijs je een referentiebestand aan waarvan de rechten worden overgenomen:

```bash
chmod --reference=reference_file target_file
```

## chown

`chown` werkt op dezelfde manier voor eigenaar en groep:

```bash
chown --reference=reference_file target_file
```

Voeg `-R` toe om het op een hele map en alles daarin toe te passen.
