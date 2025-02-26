# Remove blankspace from output

If you have a pattern like this in a file:
abcd efdg ijklm sfgsdf
sdgf gfgf gdfg dgdffdg

and you like to convert it in seperat the words per line
The most easiest way of removing whitespace from a pattern like 

```bash
cat ./somefile.txt |  xargs -n 1
```
