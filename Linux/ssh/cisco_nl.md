---
title: "Verbinden met een Cisco-switch via SSH"
date: 2025-11-18
description: "Los 'no matching key exchange method found' op bij het verbinden met een oude Cisco-switch via SSH."
translated_by_ai: true
translated_from: "en"
original: "cisco.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](cisco.md).*

### Inleiding
Ik kreeg deze foutmelding toen ik met SSH wilde inloggen op mijn Cisco-switch.

**Cisco**: SSH kan geen verbinding maken

```text
Unable to negotiate with [hostname or ip] port 22: no matching key exchange method found. Their offer: diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1,diffie-hellman-group14-sha1
```

Je lost dit op door de oude sleuteluitwisselingsmethode expliciet toe te staan:
```bash
ssh -o KexAlgorithms=+diffie-hellman-group1-sha1 [hostname or ip]
```

> ⚠️ Deze SHA-1-algoritmes zijn verouderd en onveilig. Gebruik ze alleen voor oude netwerkapparatuur, het liefst op een apart beheernetwerk.
