---
title: "Fetchmail OpenSSL-fout, deel 2"
date: 2025-11-18
description: "Laat fetchmail op Fedora 36 certificaten controleren: sla de certificaatketen op en maak c_rehash-links."
translated_by_ai: true
translated_from: "en"
original: "openSSL_and_Fetchmail_part2.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](openSSL_and_Fetchmail_part2.md).*

# Fetchmail OpenSSL-fout, deel 2

Vroeger had fetchmail alleen de MD5-vingerafdruk van een SSL-certificaat nodig om het te valideren. Sinds Fedora 36 wil fetchmail de volledige certificaatketen en `c_rehash`-links van de certificaten.

Dat stel je zo in.

## Het domeincertificaat ophalen

Sla het domeincertificaat ergens op. In dit voorbeeld maken we een map in de thuismap en bewaren we het daar.

(Vervang `sub.domain.tld:993` door je eigen serveradres, en `sub_domain_tld.cert` door een bestandsnaam die je handig vindt.)

```bash
mkdir -p ~/.fetchmail/ssl
openssl s_client -connect sub.domain.tld:993 </dev/null 2>/dev/null | openssl x509 > ~/.fetchmail/ssl/sub_domain_tld.cert
```

## sslcertpath aan je configuratie toevoegen

Fetchmail begrijpt `~/` (de verwijzing naar je thuismap) niet, dus je moet het volledige pad naar je thuismap uitschrijven.

Voeg deze regels toe aan je bestand `~/.fetchmailrc`:

```bash
ssl
sslcertck
sslcertpath /home/USERNAME/.fetchmail/ssl
```

## De symbolische links voor c_rehash maken

Er zijn een paar manieren om de rehash-links te maken.

### Optie 1: met c_rehash

Het makkelijkst is `c_rehash`, maar dat is op Fedora 36 niet standaard geïnstalleerd. Je installeert het met:

```bash
# c_rehash comes with openssl-perl
sudo dnf install openssl-perl
```

Voer `c_rehash` uit:

```bash
c_rehash ~/.fetchmail/ssl
```

### Optie 2: met OpenSSL

Je kunt de links ook zelf maken door elk bestand aan OpenSSL te geven:

```bash
# replace file.cert with the name of your certificate file
cd ~/.fetchmail/ssl
ln -s file.cert "$(openssl x509 -hash -noout -in file.cert)".0
```

# Fetchmail testen

Je bestand `~/.fetchmailrc` ziet er dan ongeveer zo uit:

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

Test nu fetchmail.

Ik kreeg deze SSL-foutmelding, omdat er een rootcertificaat nodig was:

```bash
fetchmail: Server certificate verification error: self-signed certificate in certificate chain
fetchmail: Missing trust anchor certificate: /C=US/O=Internet Security Research Group/CN=ISRG Root X1
fetchmail: This could mean that the root CA's signing certificate is not in the trusted CA certificate location, or that c_rehash needs to be run on the certificate directory. For details, please see the documentation of --sslcertpath and --sslcertfile in the manual page. See README.SSL for details.
fetchmail: OpenSSL reported: error:0A000086:SSL routines::certificate verify failed
```

Dit bleek dus een Let's Encrypt-kwestie te zijn. Je lost het op door het rootcertificaat in de nieuwe SSL-map van fetchmail op te slaan:

```bash
cd ~/.fetchmail/ssl
wget https://letsencrypt.org/certs/isrgrootx1.pem
```

Maak nu een rehash-link voor dit bestand (optie 1 of 2 hierboven) en test opnieuw.
