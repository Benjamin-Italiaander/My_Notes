---
title: "Fetchmail OPENSSL error PART 2"
author: Benjamin Italiaander
date: "2022-08-24"
subject: "OPENSSL FETCHMAIL"
keywords: OPENSSL

...


# Fetchmail OpenSSL error PART 2

In the past fetchmail only required a md5 fingerprint of a ssl-certificate as a validation. Since ferora36 fetchmail requires a complete certificate and c\_rehash files of the certificates.

This can be accomplished by the following steps


## Get the domain certificate
Save the domain certificate to some place, in my example we create a folder inside the home folder and save it there. 

(Replace sub.domain.tlnd:993 with your own server address, and replace the sub\_domain\_tld.cert with a filename that works for you)


```bash
mkdir ~/.fetchmail/ssl -p
openssl s_client -connect sub.domain.tld:993 </dev/null 2>/dev/null | openssl x509 > ~/.fetchmail/ssl/sub_domain_tld.cert
```


## Add the sslcertpath you your config
Fetchmail does not accept the ~/ (homedir expantion) so you have to use the entire path to your home folder.

Now add the lines following lines to your ~./.fetchmailrc file

```bash
ssl
sslcertck
sslcertpath  /DIR/TO/HOMEFOLDER/.fetchmail
```

## Generate a C\_rehash symbolic link

There are a few ways to create the rehashed symbolic links. 

### OPTION 1 -- Generate with c\_rehash
The most easy is to use c\_rehash but c\_rehash is not included with Fedora36.
you can install c\_rehash with

```bash
# c_rehash comes with openssl-perl
dnf install openssl-perl
```

Run c\_rehash 

```bash

c_rehash ~\.fetchmail\ssl

```


### OPTION 2 -- Generate with OpenSSL
You can create the rehash symbolic links by pharsing the files into OpenSSL

```bash
# replace file.cert with the files in the filename
cd ~\.fetchmail\ssl
ln -s file.cert `openssl x509 -hash -noout -in file.cert`.0
```


# Test fetchmail

Your ~/.fetchmailrc file should look kind of like this

```bash
poll sub.domain.tld
protocol imap
port 993
user "username"
pass "pass"   #I do not recomend to store your password here
ssl
sslcertck
sslcertpath  /home/benjamin/.fetchmail
mda "/your/mda"
```

Now test fetchmail 


In my case i got this ssl error message, this is because there a root certificate is needed. 


```bash
fetchmail: Server certificate verification error: self-signed certificate in certificate chain
fetchmail: Missing trust anchor certificate: /C=US/O=Internet Security Research Group/CN=ISRG Root X1
fetchmail: This could mean that the root CA's signing certificate is not in the trusted CA certificate location, or that c\_rehash needs to be run on the certificate directory. For details, please see the documentation of --sslcertpath and --sslcertfile in the manual page. See README.SSL for details.
fetchmail: OpenSSL reported: error:0A000086:SSL routines::certificate verify failed
```


So this appears to be a let's encrypt issue. You can solve this by saving de root certificate in the new fetchmail ssl folder


```bash

cd ~/.fetchmail/ssl
wget https://letsencrypt.org/certs/isrgrootx1.pem
```

Now create a rehash symbolic link from this file and test again. 


