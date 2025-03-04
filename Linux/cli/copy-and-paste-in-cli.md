# Copy and pasting in the linux terninal is prety easy using xclip


```bash
# This command copys
xclip -selection c
```

i added in my .bashrc file a function

```bash
copy-to-clipboard(){
  xclip -selection c
  }
```
