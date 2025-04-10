# Here i have some notes about bareos

Bareos is made up of the following major components or services: 
- [Bareos Director Service](#Bareos-Director-Service)
- Console service 
- [Bareos File deamon](Bareos-File-Daemon)
- Storage service
- Monitor service

[An Internal Link to a Section Heading](#Bareos-Director)

## Bareos Director Service
The Director is the central control program for all the other daemons. It schedules and supervises all the backup, restore, verify and archive operations. The system administrator uses the Bareos Director to schedule backups and to recover files. The Director runs as a daemon (or service) in the background.

## Bareos File Daemon
The Bareos File Daemon is a program that must be installed on each (Client) machine that should be backed up. At the request of the Bareos Director, it finds the files to be backed up and sends them (their data) to the Bareos Storage Daemon.
