# The first basics of Bareos

## Main components of Bareos
Bareos is made up of the following major components or services: 
- [Bareos Director Service](#Bareos-Director-Service)
- [Console service](#Console-service)
- [Bareos File deamon](#Bareos-File-Daemon)
- [Bareos Storage Deamon](#Bareos-Storage-Daemon)
- Monitor service


### Bareos Director Service
The Director is the central control program for all the other daemons. It schedules and supervises all the backup, restore, verify and archive operations. The system administrator uses the Bareos Director to schedule backups and to recover files. The Director runs as a daemon (or service) in the background.

### Console service
The console service is the bconsole. The program that interfaces to the Director allowing the user or system administrator to control Bareos.

### Bareos File Daemon
The Bareos File Daemon is a program that must be installed on each (Client) machine that should be backed up. At the request of the Bareos Director, it finds the files to be backed up and sends them (their data) to the Bareos Storage Daemon.

It is specific to the operating system on which it runs and is responsible for providing the file attributes and data when requested by the Bareos Director.

The Bareos File Daemon is also responsible for the file system dependent part of restoring the file attributes and data during a recovery operation. This program runs as a daemon on the machine to be backed up.


### Bareos Storage Daemon
The Bareos Storage Daemon is responsible, at the Bareos Director request, for accepting data from a Bareos File Daemon and storing the file attributes and data to the physical backup media or volumes. In the case of a restore request, it is responsible to find the data and send it to the Bareos File Daemon.

There can be multiple Bareos Storage Daemon in your environment, all controlled by the same Bareos Director.

The Storage services runs as a daemon on the machine that has the backup device (such as a tape drive).

