---
title: "Allow a User to Access Serial (TTY) Devices"
date: 2016-11-14
description: "Give a Linux user access to serial devices such as /dev/ttyUSB0 with the dialout group."
---

*🇳🇱 [Lees deze pagina in het Nederlands](allow_tty_nl.md)*

# Allow a user to access serial (TTY) devices

On Ubuntu, create the user and add them to the `dialout` group. `dialout` normally grants access to serial devices such as `/dev/ttyUSB0`, `/dev/ttyACM0` and `/dev/ttyS0`.

```bash
# Create the user
sudo adduser username

# Allow access to serial/TTY devices
sudo usermod -aG dialout username
```

Check:

```bash
groups username
```

You should see something like:

```text
username : username dialout
```

The user needs to **log out and back in** before the new group membership takes effect.

### Check a particular `/dev/tty*` device

For example:

```bash
ls -l /dev/ttyUSB0
```

Typically:

```text
crw-rw---- 1 root dialout ... /dev/ttyUSB0
```

So membership of `dialout` is sufficient.

If you mean **all `/dev/tty*` devices**, including physical consoles such as `/dev/tty1`, it's slightly different. Those are often owned by the `tty` group:

```bash
ls -l /dev/tty1
```

You can add the user to that group too:

```bash
sudo usermod -aG tty username
```

For serial hardware, though, I'd stick with **`dialout` only** unless you specifically need console TTY access.
