---
title: "Schrijfsnelheid benchmarken"
date: 2025-11-18
description: "Test hoe snel een (netwerk)schijf grote bestanden en veel kleine bestanden verwerkt, met dd, split en rsync."
translated_by_ai: true
translated_from: "en"
original: "benchmark_writespeed.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](benchmark_writespeed.md).*

# 💾 De schrijfsnelheid van een schijf benchmarken

Soms wil je testen hoe snel een (netwerk)schijf schrijfacties aankan.

Een gebruikelijke methode:

1. Schrijf **één groot bestand**
2. Splits het in **veel kleine bestanden**
3. Meet hoe snel je ze kopieert met `rsync` of `cp`

Waarom?
Sommige opslagsystemen kunnen grote opeenvolgende schrijfacties prima aan, maar hebben moeite met veel kleine bestanden (metadata-overhead, IOPS-limieten, enzovoort).

---

## 1️⃣ Een groot willekeurig bestand maken

Maak lokaal een groot bestand:

```bash
# Create a ~1GB file
dd if=/dev/urandom of=random_file bs=1G count=1
```

Meet hoe lang het duurt:

```bash
time dd if=/dev/urandom of=random_file bs=1G count=1
```

> 💡 Gebruik `count=10` voor ~10 GB, enzovoort.

Alternatief voorbeeld (iets kleinere blokken):

```bash
dd if=/dev/urandom of=random_file bs=128K count=10000
```

---

## 2️⃣ Splitsen in veel kleine bestanden

Maak een map en splits het grote bestand in stukken van 1 MB:

```bash
mkdir random_dir
split -b 1M -a 3 random_file random_dir/file_
```

Dat geeft veel kleine bestanden, zoals:

```
file_aaa
file_aab
file_aac
...
```

---

## 3️⃣ Benchmarken met rsync

### Eén groot bestand kopiëren

```bash
rsync --info=progress2 random_file /target/path/
```

### Veel kleine bestanden kopiëren

```bash
rsync --info=progress2 -r random_dir/ /target/path/
```

Voorbeelden van doelen:

```bash
rsync --info=progress2 -r random_dir/ /mnt/storage1/test/
rsync --info=progress2 -r random_dir/ /mnt/storage2/test/
rsync --info=progress2 -r random_dir/ /mnt/bigstorage/test/
```

---

## 4️⃣ Lokaal kopiëren benchmarken

Je kunt ook lokaal meten:

```bash
rsync --info=progress2 -r random_dir/ random_dir2/
```

Of met `cp`:

```bash
time cp -r random_dir random_dir2
```

---

## 5️⃣ Metadata/IOPS-test (veel kleine bestanden)

Om de metadataprestaties zwaar te belasten:

```bash
time bash -c 'for i in $(seq 1 1000); do touch random_dir/$i; done'
```

Dit test hoe snel het bestandssysteem veel kleine bestanden kan aanmaken.

---

# 🧪 Wat dit test

| Soort test | Wat het meet |
| --- | --- |
| `dd` groot bestand | Doorvoer bij opeenvolgend schrijven |
| `rsync` groot bestand | Netwerk + opeenvolgende prestaties |
| `rsync` kleine bestanden | Metadata + IOPS + netwerk |
| `touch`-lus | Pure metadataprestaties |

---
