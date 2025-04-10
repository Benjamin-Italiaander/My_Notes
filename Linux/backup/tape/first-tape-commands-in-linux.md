# Manage tape autoloader drives and libraries for Unix/Linux CLI
First steps of managing tapes in linux is using the MT and MTX command.

Tools used in this article are
- lsscsi (list SCSI devices (or hosts), list NVMe devices)
- mt (control magnetic tape drive operation from mt-st package) used to control the tape drive like tape movements, ejection, and drive settings.
- mtx (control SCSI media changer devices)  used to control tape libraries (moving cartridges from slots to drives, etc)
- tar (an archiving utility)
- ltfs (Linear Tape File System)
- sg3-utils (The sg3_utils package contains utilities that send SCSI commands to devices)
- dd (convert and copy a file)

---  
# Warning! First time loading a LTO9 tape it automatically initiates tape calibration sometimes taking up to 2 hours
When LTO9 media is first loaded into the LTO9 drive, the drive automatically initiates tape calibration, which includes initialization and characterization of the cartridge.

IMPORTANT: IBM has stated that LTO9 calibration may require 20 minutes to 2 hours to complete.

During calibration, the drive state will indicate “Calibrating” and no other actions, including host access, can be performed on the drive. When calibration is complete, the drive will automatically transition to the "Loaded" state and the media will be available for host access. If an uninitialized LTO9 tape is moved to a drive to perform any type of media validation, any attempt to cancel the media validation while in the “Calibrating” state will fail with “Drive is busy calibrating.

---


#### identify the auto loader with lsscsi by searching for a device marked as mediumx
```bash
lsscsi -g
[1:0:0:0]    tape    IBM      ULT3580-HH9      Q3F5  /dev/st0   /dev/sg3 
[1:0:0:1]    mediumx IBM      3572-TL          0131  /dev/sch0  /dev/sg4 

# In this case the autoloader is /dev/sch0  /dev/sg4 because it is marked as mediumx
```



# How to controll the tape auto loader in linux
## Tape autoloader exists of two devices.
1. the autoloader
2. the tape unit

The loader can be controlled with the mtx command, for example
```bash
# Load tape 1
sudo mtx -f /dev/sg4 load 1

# Get status from loader
sudo mtx -f /dev/sg4 status

# Unload the autoloader
sudo mtx -f /dev/sg4 unload

```

With lto tapes you might run into a error during unload in that case you need to bring the tape offline first
```bash
mt -f dev/sg4 offline
```

The tape Unit can be controlled with the mt command, for example
```bash
sudo mt -f /dev/sg4 rewind

```



This article is partly copied from [here](https://blogs.intellique.com/cgi-bin/tech/2022/01/27)
