# Read from every line a specific tab in linux cli
Sometimes you need to read a specific tab from a file. for exampple

i made a file with this content:
A  B  C
D  E  F
G  H  I


This gives the first word from the line
```bash
cat file | awk '{print $1}'
A
D
G
```

This shows the second tab from the line
```bash
cat file | awk '{print $2}'
B
E
H
```
