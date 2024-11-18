# show the difference between two files


Colomed output
```bash
diff -y --side-by-side file_one.txt file_two.txt
```

Colomed output filtered 
```bash
diff -y --side-by-side --suppress-common-lines  file_one.txt file_two.txt
```

```bash
diff --side-by-side file_one.txt file_two.txt
```


```bash
diff --side-by-side --suppress-common-lines  file_one.txt file_two.txt
```

