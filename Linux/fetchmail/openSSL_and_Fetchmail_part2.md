---
title: Fetchmail OpenSSL error, part 2
date: 2022-08-24
description: "Make fetchmail verify certificates on Fedora 36: save the certificate chain and create c_rehash links."
author: Benjamin Italiaander
keywords: OPENSSL
---

*🇳🇱 [Lees deze pagina in het Nederlands](openSSL_and_Fetchmail_part2_nl.md)*

# Fetchmail OpenSSL error, part 2

In the past, fetchmail only required the MD5 fingerprint of an SSL certificate for validation. Since Fedora 36, fetchmail requires the complete certificate chain and `c_rehash` links of the certificates.

You can set this up with the following steps.

## Get the domain certificate

Save the domain certificate somewhere. In this example we create a folder inside the home folder and save it there.

(Replace `sub.domain.tld:993` with your own server address, and `sub_domain_tld.cert` with a filename that works for you.)

```bash
mkdir -p ~/.fetchmail/ssl
openssl s_client -connect sub.domain.tld:993 </dev/null 2>/dev/null | openssl x509 > ~/.fetchmail/ssl/sub_domain_tld.cert
```

## Add the sslcertpath to your config

Fetchmail does not understand `~/` (home directory expansion), so you have to write out the full path to your home folder.

Add the following lines to your `~/.fetchmailrc` file:

```bash
ssl
sslcertck
sslcertpath /home/USERNAME/.fetchmail/ssl
```

## Generate the c_rehash symbolic links

There are a few ways to create the rehash symbolic links.

### Option 1: generate them with c_rehash

The easiest way is `c_rehash`, but it isn't installed by default on Fedora 36. You can install it with:

```bash
# c_rehash comes with openssl-perl
sudo dnf install openssl-perl
```

Run `c_rehash`:

```bash
c_rehash ~/.fetchmail/ssl
```

### Option 2: generate them with OpenSSL

You can also create the links yourself by passing each file to OpenSSL:

```bash
# replace file.cert with the name of your certificate file
cd ~/.fetchmail/ssl
ln -s file.cert "$(openssl x509 -hash -noout -in file.cert)".0
```

# Test fetchmail

Your `~/.fetchmailrc` file should look something like this:

```bash
poll sub.domain.tld
protocol imap
port 993
user "username"
pass "pass"   # I do not recommend storing your password here
ssl
sslcertck
sslcertpath /home/USERNAME/.fetchmail/ssl
mda "/your/mda"
```

Now test fetchmail.

In my case I got this SSL error message, because a root certificate was needed:

```bash
fetchmail: Server certificate verification error: self-signed certificate in certificate chain
fetchmail: Missing trust anchor certificate: /C=US/O=Internet Security Research Group/CN=ISRG Root X1
fetchmail: This could mean that the root CA's signing certificate is not in the trusted CA certificate location, or that c_rehash needs to be run on the certificate directory. For details, please see the documentation of --sslcertpath and --sslcertfile in the manual page. See README.SSL for details.
fetchmail: OpenSSL reported: error:0A000086:SSL routines::certificate verify failed
```

So this turned out to be a Let's Encrypt issue. You can solve it by saving the root certificate in the new fetchmail SSL folder:

```bash
cd ~/.fetchmail/ssl
wget https://letsencrypt.org/certs/isrgrootx1.pem
```

Now create a rehash symbolic link for this file (option 1 or 2 above) and test again.
