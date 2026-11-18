---
title: "Date command in bash"
date: 2023-02-27T14:12:45+01:00
description: "Small examples of the date command: weekday number and quarter of the year."
draft: false
---

*🇳🇱 [Lees deze pagina in het Nederlands](date_command_nl.md)*

# A few small examples of the date command

Show the day of the week as a number (1 = Monday), which is always handy to know:

```bash
date +%u
```

Show the quarter of the year:

```bash
date +%q
```

In a script:

```bash
#!/bin/bash
todayWeekday=$(date +%u)
todayQuarter=$(date +%q)
echo "Today is weekday $todayWeekday, in quarter $todayQuarter of the year."
```
