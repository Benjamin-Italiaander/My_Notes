---
title: "First Tape Commands in Linux"
date: 2016-05-11
description: "First steps with tape drives and autoloaders on Linux: lsscsi, mt, mtx and the LTO-9 calibration warning."
---

*🇳🇱 [Lees deze pagina in het Nederlands](first-tape-commands-in-linux_nl.md)*

# Manage tape autoloaders, drives and libraries from the Unix/Linux CLI
The first step in managing tapes in Linux is using the `mt` and `mtx` commands.

Tools used in this article:
- lsscsi (list SCSI devices (or hosts), list NVMe devices)
- mt (control magnetic tape drive operation, from the mt-st package): controls the tape drive, such as tape movement, ejection and drive settings.
- mtx (control SCSI media changer devices): controls tape libraries (moving cartridges from slots to drives, etc.)
- tar (an archiving utility)
- ltfs (Linear Tape File System)
- sg3-utils (The sg3_utils package contains utilities that send SCSI commands to devices)
- dd (convert and copy a file)

---  
# Warning! The first time you load an LTO-9 tape, it starts a calibration that can take up to 2 hours
When LTO9 media is first loaded into the LTO9 drive, the drive automatically initiates tape calibration, which includes initialization and characterization of the cartridge.

IMPORTANT: IBM has stated that LTO9 calibration may require 20 minutes to 2 hours to complete.

During calibration, the drive state will indicate “Calibrating” and no other actions, including host access, can be performed on the drive. When calibration is complete, the drive will automatically transition to the "Loaded" state and the media will be available for host access. If an uninitialized LTO9 tape is moved to a drive to perform any type of media validation, any attempt to cancel the media validation while in the “Calibrating” state will fail with “Drive is busy calibrating”.

---


#### Identify the autoloader with lsscsi: look for the device marked as mediumx
```bash
lsscsi -g
[1:0:0:0]    tape    IBM      ULT3580-HH9      Q3F5  /dev/st0   /dev/sg3 
[1:0:0:1]    mediumx IBM      3572-TL          0131  /dev/sch0  /dev/sg4 

# In this case the autoloader is /dev/sch0 / /dev/sg4, because it is marked as mediumx.
# The tape drive itself is /dev/st0.
```



# How to control the tape autoloader in Linux
## A tape autoloader consists of two devices:
1. the autoloader (media changer)
2. the tape drive

The loader is controlled with the `mtx` command, for example:
```bash
# Load tape 1
sudo mtx -f /dev/sg4 load 1

# Get status from loader
sudo mtx -f /dev/sg4 status

# Unload the autoloader
sudo mtx -f /dev/sg4 unload

```

With LTO tapes you might run into an error during unload. In that case, take the tape in the drive offline first:
```bash
sudo mt -f /dev/st0 offline
```

The tape drive is controlled with the `mt` command, for example:
```bash
sudo mt -f /dev/st0 rewind
```

This article is partly copied from [here](https://blogs.intellique.com/cgi-bin/tech/2022/01/27).
