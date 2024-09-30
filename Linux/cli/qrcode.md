# Create a qrcode from command output 
I needed to pipe my cli output to a qrcode and generate a qrcode from it

```bash
cat ./somefile.txt | qrencode -t ansiutf8
```

or i manage my passowords with pass and needed to copy a password to my phone by qr

```bash
pass work/someaccount | head -n1 | qrencode -t ansiutf8
```

