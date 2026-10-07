On Ubuntu, create the user and add them to the `dialout` group. `dialout` normally grants access to serial devices such as `/dev/ttyUSB0`, `/dev/ttyACM0`, and `/dev/ttyS0`.

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

### Check a particular `/dev/tty*`

For example:

```bash
ls -l /dev/ttyUSB0
```

Typically:

```text
crw-rw---- 1 root dialout ... /dev/ttyUSB0
```

So membership in `dialout` is sufficient.

If you're talking about **all `/dev/tty*` devices**, including physical consoles such as `/dev/tty1`, that's slightly different. Those are often owned by the `tty` group:

```bash
ls -l /dev/tty1
```

You can add the user to that too:

```bash
sudo usermod -aG tty username
```

For serial hardware, though, I'd stick with **`dialout` only** unless you specifically need console TTY access.
