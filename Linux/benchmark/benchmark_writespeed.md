---

title: "Benchmark write speed"
draft: false
date: 2023-02-27T14:12:45+01:00
description: "test"
---

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
rsync --info=progress2 -r random_dir/ /zs3/1/test/
rsync --info=progress2 -r random_dir/ /zs3/2/test/
rsync --info=progress2 -r random_dir/ /bigstore/test/
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


# How to benchmark write speed to a disk
Sometimes you need to test how fast you can write to a (network)disk.
this can be done by creating one large file and split this in more small files. 

Sometimes it's easier for a storage to write one large file and more dificult to write small files.
So first we create a random file local and then we split this one large file into small files.

After all i always test with rsync, but you can also test with cp. 


Create a large random file and see how long it takes
```bash
# This makes a about 1GB file change the count=1 to count=10 and you get a 1GB file
dd if=/dev/urandom of=random_file bs=1G count=1

# you can add time in front and see how long it takes for each system or disk
time dd if=/dev/urandom of=random_file bs=1G count=1
```
Now you have one large file and split it in small files
```bash
mkdir random_dir
split -b 1m -a 3 random_file random_dir/
```

Test more with rsync
```bash
rsync --info=progress2 -r random_dir /machine_to_benchmark
```


```bash
rsync -v ./random_file /zs3/1/test/
split random_file -n 1000 random_dir
rsync --info=progress2 random_dir /zs3/1/test/
rsync --info=progress2 - rrandom_dir /zs3/1/test/
rsync --info=progress2 -r random_dir /zs3/1/test/
mkdir /bigstore/test
rsync --info=progress2 -r random_dir /bigstore/test/
rsync --info=progress2 -r random_dir /zs3/2/test/
time bash -c "for i in $(seq 1 1000); do touch /zs3/1/ci/skorikov/random_dir/$i done"


dd if=/dev/urandom of=random_file bs=128k count=10000
split -b 1m -a 3 random_file random_dir/
rsync --info=progress2 -r random_dir random_dir2
```
