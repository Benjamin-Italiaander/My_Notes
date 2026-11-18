---
title: "Het date-commando in bash"
date: 2025-11-18
description: "Kleine voorbeelden van het date-commando: het nummer van de weekdag en het kwartaal van het jaar."
translated_by_ai: true
translated_from: "en"
original: "date_command.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](date_command.md).*

# Een paar kleine voorbeelden van het date-commando

Toon de dag van de week als getal (1 = maandag), altijd handig om te weten:

```bash
date +%u
```

Toon het kwartaal van het jaar:

```bash
date +%q
```

In een script:

```bash
#!/bin/bash
todayWeekday=$(date +%u)
todayQuarter=$(date +%q)
echo "Today is weekday $todayWeekday, in quarter $todayQuarter of the year."
```
