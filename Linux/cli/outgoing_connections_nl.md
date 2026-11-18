---
title: "Uitgaande verbindingen tonen"
date: 2025-11-18
description: "Toon de externe adressen van uitgaande TCP- en UDP-verbindingen met netstat of ss."
translated_by_ai: true
translated_from: "en"
original: "outgoing_connections.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](outgoing_connections.md).*

# Uitgaande verbindingen tonen in de Linux-CLI

Een klein voorbeeld om de externe adressen van je verbindingen te tonen.

Uitgaande TCP-verbindingen:

```bash
netstat -atn | tr -s ' ' | cut -f5 -d ' ' | grep -v '127.0.0.1'
```

Uitgaande UDP-verbindingen:

```bash
netstat -aun | tr -s ' ' | cut -f5 -d ' ' | grep -v '127.0.0.1'
```

Op nieuwere systemen is `netstat` misschien niet geïnstalleerd; `ss -tn` (TCP) en `ss -un` (UDP) geven vergelijkbare uitvoer.
