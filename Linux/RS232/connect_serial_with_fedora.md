---
title: "Connect S4048 with console in Linux"
author:
  - Benjamin Italiaander
date: 2022-09-7
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





# Connect serial console in Linux

I needed to connect my Dell S4048 and my Dell Z9100-ON over a serial port in linux.

So i was trying to connect over my rs232 cable to my Dell switch. But somehow i got weird characters after connecting.

specifiations on the DELL site said

- 115200 baud rate—set the MicroUSB console port to 9600 baud rate.
- No parity.
- 8 data bits.
- 1 stop bit.
- No flow control.

I did try minicom, and cu but with no working results 
Finally [kermit](http://www.columbia.edu/kermit/ck90.html) did the trick by using a config file ~/.kermrc containing

```bash
set line /dev/ttyUSB0
set speed 115200
SET CARRIER-WATCH OFF
set flow-control none
set parity none
set stop-bits 1
```

file name ~/.kermrc
in my case it was /dev/ttyUSB0 but use whatever your device is



after starting kermit just enter connect and kermit will initiate a working connection

## Backspace not working in kermit

After connecting the backspace key did not respond. Edit the  ~/.kermrc and add the line 
```bash
set key \127 \8
```

start kermit again and backspace should work


