---
title: "Bareos: aan de slag"
date: 2025-11-18
description: "De belangrijkste onderdelen van Bareos en de bconsole-commando's die ik gebruik om back-upjobs te starten, te bekijken en terug te zetten."
translated_by_ai: true
translated_from: "en"
original: "bearos-start-point.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](bearos-start-point.md).*

# De eerste basis van Bareos

## De belangrijkste onderdelen van Bareos
Bareos bestaat uit deze hoofdonderdelen of diensten:
- [Bareos Director Service](#bareos-director-service)
- [Console Service](#console-service)
- [Bareos File Daemon](#bareos-file-daemon)
- [Bareos Storage Daemon](#bareos-storage-daemon)
- [Bareos Monitor Service](#bareos-monitor-service)

### Bareos Director Service
De Director is het centrale besturingsprogramma voor alle andere daemons. Hij plant en bewaakt alle back-up-, herstel-, controle- en archiveringstaken. De systeembeheerder gebruikt de Bareos Director om back-ups in te plannen en bestanden terug te zetten. De Director draait als daemon (of dienst) op de achtergrond.

### Console Service
Het programma `bconsole` praat met de Director en laat de gebruiker of systeembeheerder Bareos besturen.

### Bareos File Daemon
De Bareos File Daemon is een programma dat op elke (client)machine moet staan waarvan een back-up wordt gemaakt. Op verzoek van de Bareos Director zoekt hij de bestanden voor de back-up en stuurt hij ze (hun gegevens) naar de Bareos Storage Daemon.
Hij is specifiek voor het besturingssysteem waarop hij draait en levert de bestandskenmerken en gegevens wanneer de Bareos Director daarom vraagt.
De Bareos File Daemon zorgt bij het terugzetten ook voor het bestandssysteemafhankelijke deel van het herstellen van bestandskenmerken en gegevens. Dit programma draait als daemon op de machine waarvan een back-up wordt gemaakt.

### Bareos Storage Daemon
De Storage Daemon, soms SD genoemd, is de code die de kenmerken en gegevens naar een opslagvolume schrijft (meestal een tape of schijf). Op verzoek van de Bareos Director neemt de Bareos Storage Daemon gegevens aan van een Bareos File Daemon en slaat hij de bestandskenmerken en gegevens op de fysieke back-upmedia of volumes op. Bij een herstelverzoek zoekt hij de gegevens op en stuurt hij ze naar de Bareos File Daemon.
Je kunt meerdere Bareos Storage Daemons hebben, allemaal bestuurd door dezelfde Bareos Director.
De Storage-dienst draait als daemon op de machine met het back-upapparaat (zoals een tapedrive).


### Bareos Monitor Service
Het programma dat met alle daemons praat en de gebruiker of systeembeheerder de status van Bareos laat volgen.

## Handige bconsole-commando's

```bash
# estimate shows what a job will back up
estimate job=MyFirstJob listing
```

```bash
# run job
run job=MyFirstJob yes
```

```bash
# list running jobs on the client
status client
```

```bash
list jobs
```

```bash
list joblog jobid=61
```

```bash
# list on which tape the job is stored
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
3: client01
4: client02
5: client03
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
*list jobs job=client01 
+-------+---------+-----------+---------------------+----------+------+-------+----------+------------+-----------+
| jobid | name    | client    | starttime           | duration | type | level | jobfiles | jobbytes   | jobstatus |
+-------+---------+-----------+---------------------+----------+------+-------+----------+------------+-----------+
|    50 | client01 | bareos-fd | 2025-04-07 12:00:46 | 00:00:00 | B    | F     |      338 | 36,351,640 | T         |
|    51 | client01 | bareos-fd | 2025-04-07 12:10:08 | 00:00:01 | B    | F     |      338 | 36,351,640 | T         |
|    55 | client01 | bareos-fd | 2025-04-08 15:53:15 | 00:00:10 | B    | F     |       73 |          0 | T         |
|    61 | client01 | bareos-fd | 2025-04-15 11:32:33 | 00:00:38 | B    | F     |       73 |          0 | T         |
+-------+---------+-----------+---------------------+----------+------+-------+----------+------------+-----------+
```
```bash
# grep bconsole output from the Linux CLI
root@backup01:~# bconsole <<< "list jobs" | grep client01
|    50 | client01          | bareos-fd | 2025-04-07 12:00:46 | 00:00:00 | B    | F     |      338 | 36,351,640 | T         |
|    51 | client01          | bareos-fd | 2025-04-07 12:10:08 | 00:00:01 | B    | F     |      338 | 36,351,640 | T         |
|    55 | client01          | bareos-fd | 2025-04-08 15:53:15 | 00:00:10 | B    | F     |       73 |          0 | T         |
|    61 | client01          | bareos-fd | 2025-04-15 11:32:33 | 00:00:38 | B    | F     |       73 |          0 | T         |
root@backup01:~# 
```

