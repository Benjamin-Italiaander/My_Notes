---
title: "Benchmark write speed"
date: 2023-02-27T14:12:45+01:00
description: "Benchmark how fast a (network) disk handles large files and many small files with dd, split and rsync."
draft: false
---

*🇳🇱 [Lees deze pagina in het Nederlands](benchmark_writespeed_nl.md)*

# 💾 Benchmark Write Speed to a Disk

Sometimes you need to test how fast a (network) disk can handle writes.

A common method is:

1. Write **one large file**
2. Split it into **many small files**
3. Benchmark copying them using `rsync` or `cp`

Why?
Some storage systems handle large sequential writes very well, but struggle with many small files (metadata overhead, IOPS limits, etc.).

---

## 1️⃣ Create a Large Random File

Generate a large file locally:

```bash
# Create a ~1GB file
dd if=/dev/urandom of=random_file bs=1G count=1
```

Measure how long it takes:

```bash
time dd if=/dev/urandom of=random_file bs=1G count=1
```

> 💡 Increase `count=10` for ~10GB, etc.

Alternative example (slightly smaller blocks):

```bash
dd if=/dev/urandom of=random_file bs=128K count=10000
```

---

## 2️⃣ Split Into Many Small Files

Create a directory and split the large file into 1MB chunks:

```bash
mkdir random_dir
split -b 1M -a 3 random_file random_dir/file_
```

This creates many small files like:

```
file_aaa
file_aab
file_aac
...
```

---

## 3️⃣ Benchmark with rsync

### Copy Single Large File

```bash
rsync --info=progress2 random_file /target/path/
```

### Copy Many Small Files

```bash
rsync --info=progress2 -r random_dir/ /target/path/
```

Example targets:

```bash
rsync --info=progress2 -r random_dir/ /mnt/storage1/test/
rsync --info=progress2 -r random_dir/ /mnt/storage2/test/
rsync --info=progress2 -r random_dir/ /mnt/bigstorage/test/
```

---

## 4️⃣ Local Copy Benchmark

You can also benchmark locally:

```bash
rsync --info=progress2 -r random_dir/ random_dir2/
```

Or using `cp`:

```bash
time cp -r random_dir random_dir2
```

---

## 5️⃣ Metadata / IOPS Test (Many Small Files)

To stress metadata performance:

```bash
time bash -c 'for i in $(seq 1 1000); do touch random_dir/$i; done'
```

This tests how fast the filesystem can create many small files.

---

# 🧪 What This Tests

| Test Type           | What It Measures                 |
| ------------------- | -------------------------------- |
| `dd` large file     | Sequential write throughput      |
| `rsync` large file  | Network + sequential performance |
| `rsync` small files | Metadata + IOPS + network        |
| `touch` loop        | Pure metadata performance        |

---
