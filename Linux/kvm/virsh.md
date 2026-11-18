---
title: "Virsh: find the display port of a VM"
date: 2016-09-13
description: "Find the local SPICE/VNC display port of a running KVM virtual machine with virsh."
---

*🇳🇱 [Lees deze pagina in het Nederlands](virsh_nl.md)*

# Get the local display port of a VM

List all running VMs:
```bash
# virsh list
 Id   Name       State
--------------------------
 1    debian12   running
 4    AGENDA     running
```

Find the local display port:
```bash
# virsh domdisplay --domain debian12
spice://127.0.0.1:5900
```
