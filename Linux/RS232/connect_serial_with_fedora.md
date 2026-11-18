---
title: "Connect to a Dell S4048 serial console in Linux"
date: 2022-09-07
description: "Connect to the serial console of a Dell S4048 or Z9100 switch from Linux with Kermit."
author:
  - Benjamin Italiaander
keywords:
    - Dell
    - Z9100
    - Z9100-ON
    - S4048
    - S4048-ON
    - Serial
    - Serialcable
    - RS232
    - Linux
---

*🇳🇱 [Lees deze pagina in het Nederlands](connect_serial_with_fedora_nl.md)*

# Connect to a serial console in Linux

I needed to connect to my Dell S4048 and Dell Z9100-ON switches over a serial port in Linux.

I connected my RS232 cable to the Dell switch, but somehow I got weird characters after connecting.

The specifications on the Dell site said:

- 115200 baud (set the Micro-USB console port to 9600 baud).
- No parity.
- 8 data bits.
- 1 stop bit.
- No flow control.

I tried minicom and cu, without success.
In the end [Kermit](http://www.columbia.edu/kermit/ck90.html) did the trick, with this config file `~/.kermrc`:

```bash
set line /dev/ttyUSB0
set speed 115200
SET CARRIER-WATCH OFF
set flow-control none
set parity none
set stop-bits 1
```

In my case the device was `/dev/ttyUSB0`; use whatever your device is.

After starting Kermit, type `connect` and Kermit will set up a working connection.

## Backspace not working in Kermit

After connecting, the Backspace key did not respond. Edit `~/.kermrc` and add the line:
```bash
set key \127 \8
```

Start Kermit again and Backspace should work.
