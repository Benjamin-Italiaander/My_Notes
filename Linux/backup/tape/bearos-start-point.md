# The first basics of Bareos

## Main components of Bareos
Bareos is made up of the following major components or services: 
- [Bareos Director Service](#Bareos-Director-Service)
- [Console service](#Console-service)
- [Bareos File deamon](#Bareos-File-Daemon)
- [Bareos Storage Deamon](#Bareos-Storage-Daemon)
- [Bareos Monitor service](#Bareos-Monitor-Service)

### Bareos Director Service
The Director is the central control program for all the other daemons. It schedules and supervises all the backup, restore, verify and archive operations. The system administrator uses the Bareos Director to schedule backups and to recover files. The Director runs as a daemon (or service) in the background.

### Console service
The "bconsole" program that interfaces to the Director allowing the user or system administrator to control Bareos.

### Bareos File Daemon
The Bareos File Daemon is a program that must be installed on each (Client) machine that should be backed up. At the request of the Bareos Director, it finds the files to be backed up and sends them (their data) to the Bareos Storage Daemon.
It is specific to the operating system on which it runs and is responsible for providing the file attributes and data when requested by the Bareos Director.
The Bareos File Daemon is also responsible for the file system dependent part of restoring the file attributes and data during a recovery operation. This program runs as a daemon on the machine to be backed up.

### Bareos Storage Daemon
The Storage daemon, sometimes referred to as the SD, is the code that writes the attributes and data to a storage Volume (usually a tape or disk). The Bareos Storage Daemon is responsible, at the Bareos Director request, for accepting data from a Bareos File Daemon and storing the file attributes and data to the physical backup media or volumes. In the case of a restore request, it is responsible to find the data and send it to the Bareos File Daemon.
There can be multiple Bareos Storage Daemon in your environment, all controlled by the same Bareos Director.
The Storage services runs as a daemon on the machine that has the backup device (such as a tape drive).


### Bareos Monitor Service
The program that interfaces to all the daemons allowing the user or system administrator to monitor Bareos status.

```bash
# estimate will give you the results of a job what will be backed up
estimate listing job=MyFirstJob
```

```bash
# run job
run job=MyFirstJob yes
```

```bash
# list running jop on client
status client
```

```bash
list jobs
```

```bash
list joblog jobid=61
```

```bash
# list on with tape the job is stored
*list volumes jobid=61
+------------+
| volumename |
+------------+
| 000011L9   |
+------------+
```

```bash
# display the files inside a job
list files jobid=61
```


```bash
# RESTORE
*restore 
Automatically selected Catalog: MyCatalog
Using Catalog "MyCatalog"

First you select one or more JobIds that contain files
to be restored. You will be presented several methods
of specifying the JobIds. Then you will be allowed to
select which files from those JobIds are to be restored.

To select the JobIds, you have the following choices:
 1: List last 20 Jobs run
 2: List Jobs where a given File is saved
 3: Enter list of comma separated JobIds to select
 4: Enter SQL list command
 5: Select the most recent backup for a client
 6: Select backup for a client before a specified time
 7: Enter a list of files to restore
 8: Enter a list of files to restore before a specified time
 9: Find the JobIds of the most recent backup for a client
10: Find the JobIds for a backup for a client before a specified time
11: Enter a list of directories to restore for found JobIds
12: Select full restore to a specified Job date
13: Cancel
Select item:  (1-13): 5
Automatically selected Client: bareos-fd
The defined FileSet resources are:
1: Catalog
2: SelfTest
3: cwi1001
4: cwi1004
5: cwi2004
Select FileSet resource (1-5): 3
+-------+-------+----------+----------+---------------------+------------+
| jobid | level | jobfiles | jobbytes | starttime           | volumename |
+-------+-------+----------+----------+---------------------+------------+
|    61 | F     |       73 |        0 | 2025-04-15 11:32:33 | 000011L9   |
+-------+-------+----------+----------+---------------------+------------+
You have selected the following JobId: 61

Building directory tree for JobId(s) 61 ...  ++++++++++++++++++++++++++++++++++++
73 files inserted into the tree.

You are now entering file selection mode where you add (mark) and
remove (unmark) files to be restored. No files are initially added, unless
you used the "all" keyword on the command line.
Enter "done" to leave this mode.

cwd is: /
$ dir
----------   0 0 (root) 0 (root)             0  1970-01-01 01:00:00   /storage/
$ cd storage/ 

```


```bash
# LIST all backups made from a job
*list jobs job=cwi1001 
+-------+---------+-----------+---------------------+----------+------+-------+----------+------------+-----------+
| jobid | name    | client    | starttime           | duration | type | level | jobfiles | jobbytes   | jobstatus |
+-------+---------+-----------+---------------------+----------+------+-------+----------+------------+-----------+
|    50 | cwi1001 | bareos-fd | 2025-04-07 12:00:46 | 00:00:00 | B    | F     |      338 | 36,351,640 | T         |
|    51 | cwi1001 | bareos-fd | 2025-04-07 12:10:08 | 00:00:01 | B    | F     |      338 | 36,351,640 | T         |
|    55 | cwi1001 | bareos-fd | 2025-04-08 15:53:15 | 00:00:10 | B    | F     |       73 |          0 | T         |
|    61 | cwi1001 | bareos-fd | 2025-04-15 11:32:33 | 00:00:38 | B    | F     |       73 |          0 | T         |
+-------+---------+-----------+---------------------+----------+------+-------+----------+------------+-----------+
```
