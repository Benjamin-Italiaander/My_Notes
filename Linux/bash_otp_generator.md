# Make a OTP MFA in the bash terminal

I was tired of using googleauthenticator so i found a way in bash to generate my onw OTP in bash. Replace the JH string with you own string.


```bash
/usr/bin/oathtool -b  --totp 'JHJHJHJHJHJHJHJHJHJHJHJHJ' 
```


If you like to copy it to clipboard, just use xclip

```bash
/usr/bin/oathtool -b  --totp 'JHJHJHJHJHJHJHJHJHJHJHJHJ' | xclip -selection c
```

This way you run your own otp tool in bash. 

TODO is to encrypt the string in GnuPGP.
