---
title: "Verbinden met de seriële console van een Dell S4048 in Linux"
date: 2025-11-18
description: "Maak vanuit Linux met Kermit verbinding met de seriële console van een Dell S4048- of Z9100-switch."
translated_by_ai: true
translated_from: "en"
original: "connect_serial_with_fedora.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](connect_serial_with_fedora.md).*

# Verbinden met een seriële console in Linux

Ik moest in Linux via een seriële poort verbinding maken met mijn Dell S4048- en Dell Z9100-ON-switches.

Ik sloot mijn RS232-kabel aan op de Dell-switch, maar na het verbinden kreeg ik vreemde tekens.

De specificaties op de site van Dell waren:

- 115200 baud (zet de Micro-USB-consolepoort op 9600 baud).
- Geen pariteit.
- 8 databits.
- 1 stopbit.
- Geen flow control.

Ik probeerde minicom en cu, zonder succes.
Uiteindelijk werkte het met [Kermit](http://www.columbia.edu/kermit/ck90.html), met dit configuratiebestand `~/.kermrc`:

```bash
set line /dev/ttyUSB0
set speed 115200
SET CARRIER-WATCH OFF
set flow-control none
set parity none
set stop-bits 1
```

In mijn geval was het apparaat `/dev/ttyUSB0`; gebruik het apparaat dat jij hebt.

Typ na het starten van Kermit `connect`, dan maakt Kermit een werkende verbinding.

## Backspace werkt niet in Kermit

Na het verbinden reageerde de Backspace-toets niet. Bewerk `~/.kermrc` en voeg deze regel toe:
```bash
set key \127 \8
```

Start Kermit opnieuw, dan zou Backspace moeten werken.
