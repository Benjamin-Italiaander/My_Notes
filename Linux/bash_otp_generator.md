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

## If you like to pgp encrypt your token, have a look at this example below
It's a simple but working example - you need to have gpg and oathool working first. 

```bash
# This example generates a var $token from a gpg file called example.gpg

secret="$(gpg -d ./example.gpg 2>/dev/null)"
token="$(/usr/bin/oathtool -b  --totp $secret)"
echo $token
```
