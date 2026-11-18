---
title: "Virsh: de displaypoort van een VM vinden"
date: 2025-11-18
description: "Vind met virsh de lokale SPICE/VNC-displaypoort van een draaiende KVM-VM."
translated_by_ai: true
translated_from: "en"
original: "virsh.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](virsh.md).*

# De lokale displaypoort van een VM opvragen

Toon alle draaiende VM's:
```bash
# virsh list
 Id   Name       State
--------------------------
 1    debian12   running
 4    AGENDA     running
```

Vind de lokale displaypoort:
```bash
# virsh domdisplay --domain debian12
spice://127.0.0.1:5900
```
