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
## Now script it a bit together
If you like to make a fancy script out of it here is a small example that gives you the OTP token or inmideatly copy it to clipboard

```bash
#!/bin/bash

gentoken()
{
# Generate a OTP token from a pgp-encrypted file
	secret="$(gpg -d ./otp_secret_example.gpg 2>/dev/null)"
	token="$(/usr/bin/oathtool -b  --totp $secret)"
}

Help()
{
# A bit of a Help menu here
   echo 
   echo "OTP token for user John in office365."
   echo
   echo "Syntax: [-h|c|p]"
   echo "options:"
   echo "h     Print this Help."
   echo "c     Copy token to clipboard."
   echo "p     Print token to display."
   echo
}

prtoken()
{
# Print token to screen
	gentoken
	echo $token
}

cptoken()
{
# Copy token to clipboard using xclip
	gentoken
	echo $token | xclip -selection c 
}


# Menu Items -- Just a example change as you please
while getopts ":hpc" option; do
   case $option in
	   h) # display Help
		   Help
		   exit;;
	   p) # print token
		   prtoken
		   exit;;
	   c) # copy token
		   cptoken
		   exit;;
	   \?) # incorrect option
		   echo "Error: Invalid option use -h argument for help"
		   exit;;
   esac
done

```
