# Copy and pasting in the linux terninal is prety easy using xclip

### simple bash command
```bash
# This command copys
xclip -selection c
```

### making it in a function
I added in my .bashrc file a function because i keep forgetting it. 
```bash
# call this function by just open copy-to-clipboard

copy-to-clipboard(){
  xclip -selection c
  }

#for example:
cat some-file.txt | copy-to-clipboard
```
