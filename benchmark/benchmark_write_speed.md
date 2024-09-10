# How to test for write speed to a disk

Create a large random file and see how long it takes
```bash
# This makes a about 1GB file change the count=1 to count=10 and you get a 1GB file
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
rsync -v ./random_file /mnt/storage1/test/
split random_file -n 1000 random_dir
rsync --info=progress2 random_dir /mnt/storage1/test/
rsync --info=progress2 - rrandom_dir /mnt/storage1/test/
rsync --info=progress2 -r random_dir /mnt/storage1/test/
mkdir /bigstorage/test
rsync --info=progress2 -r random_dir /bigstorage/test/
rsync --info=progress2 -r random_dir /mnt/storage2/test/
time bash -c "for i in $(seq 1 1000); do touch /mnt/storage1/user/random_dir/$i done"


dd if=/dev/urandom of=random_file bs=128k count=10000
split -b 1m -a 3 random_file random_dir/
rsync --info=progress2 -r random_dir random_dir2
```
