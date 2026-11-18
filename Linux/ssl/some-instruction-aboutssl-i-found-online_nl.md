---
title: "Je eigen CA opzetten met OpenSSL"
date: 2025-11-18
description: "Een handleiding (van Igor Soarez) om je eigen certificaatautoriteit op te zetten met OpenSSL."
translated_by_ai: true
translated_from: "en"
original: "some-instruction-aboutssl-i-found-online.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](some-instruction-aboutssl-i-found-online.md).* Commando's, uitvoer en configuratiebestanden zijn niet vertaald. Het origineel is uit 2014; gebruik tegenwoordig SHA-256 in plaats van SHA-1.

Ik vond deze handige handleiding [hier](https://gist.github.com/soarez/9688998). Bedankt voor het delen, [Igor Soarez](https://uk.linkedin.com/in/soarez)!


# Je eigen CA opzetten met OpenSSL

Om ervan te leren heb ik besloten mijn eigen CA (certificaatautoriteit) te maken.
Dit is wat ik heb geleerd.

# Eerst de basis

Eerst wat achtergrond.

## Public-keycryptografie

Ook wel asymmetrische cryptografie genoemd. Het lost het probleem op hoe twee partijen veilig kunnen communiceren zonder ooit een gemeenschappelijke sleutel uit te wisselen, door twee bij elkaar horende sleutels te gebruiken: één privé, één publiek.

Tekst die met de publieke sleutel is versleuteld, kan alleen met de bijbehorende privésleutel worden ontsleuteld, en handtekeningen die met de publieke sleutel te controleren zijn, kunnen alleen met de privésleutel worden gemaakt.

Maar als de twee partijen elkaar nog niet kennen, hebben ze een manier nodig om zeker te weten dat een publieke sleutel echt bij de privésleutel van de ander hoort.

Met andere woorden: als Alice met Bob praat en Bob zegt tegen Alice “dit is mijn publieke sleutel K, gebruik die om met mij te communiceren”, dan moet Alice weten dat het echt de publieke sleutel van Bob is en niet die van Eve.

De gebruikelijke oplossing hiervoor is een PKI.

## Public Key Infrastructure - PKI

Een PKI is een systeem dat publieke sleutels aan identiteiten koppelt via een certificaatautoriteit (Certificate Authority, CA).

Een CA is een centrale, vertrouwde derde partij waarvan de publieke sleutel al bekend is.

Als Alice nu met Bob praat, laat Bob haar een bericht zien dat is ondertekend door Trent, die Alice kent en vertrouwt, met de inhoud “deze publieke sleutel K is van Bob”. Zo'n ondertekend bericht heet een certificaat, en het kan nog meer informatie bevatten. Alice kan de handtekening controleren met de publieke sleutel van Trent, en kan daarna met vertrouwen met Bob praten.

Vaak is er ook een vertrouwensketen. Alice praat met Bob; Trent kent Bob niet, maar kent wel Carol, die Bob kent. Bob laat Alice dan een keten van certificaten zien: één van Carol die zegt welke sleutel van Bob is, en één van Trent die zegt welke sleutel van Carol is. Ook zonder Carol te kennen kan Alice het certificaat van Trent controleren, zeker zijn van de sleutel van Carol, en als haar vertrouwen in Trent doorwerkt, kan ze Carol ook vertrouwen over wie Bob is.

**Let op**:
Een interessante oplossing voor het publiek verifiëren van publieke sleutels is het [web-of-trust][wot]-model, dat werkt met verklaringen van derden over zelfondertekende certificaten.

## X.509

X.509 is een standaard van de Internationale Telecommunicatie-unie (ITU) voor PKI.

Hij legt onder meer het formaat van certificaten voor publieke sleutels vast.

Beschreven in deze RFC's:

- Version 1 - [RFC1422][]
- Version 2 - [RFC2459][]
- Version 3 - [RFC5280][]

Een digitaal X.509 v3-certificaat heeft deze opbouw:

- Certificate
    - Version
    - Serial Number
    - Algorithm ID
    - Issuer
    - Validity
        - Not Before
        - Not After
    - Subject
    - Subject public key info
    - Issuer Unique Identifier (optional)
    - Subject Unique Identifier (optional)
    - Extensions (optional)
        - ...
- Certificate Signature Algorithm
- Certificate Signature

### Versie, serienummer, algoritme-ID en geldigheid

- **Version** - Geeft de X.509-versie aan. Moet 3 zijn (waarde 0x2).
- **Serial** - Uniek positief getal dat de CA aan elk certificaat toekent.
- **Algorithm ID** - Moet gelijk zijn aan het veld "Certificate Signature Algorithm".
- **Validity** - Twee datums die samen de periode vormen waarin het certificaat geldig is.

### Uitgever (issuer) en onderwerp (subject)

Beide zijn een Distinguished Name (DN), uniek per CA.

Een DN, beschreven in [RFC1779][], bestaat uit één regel met deze waarden, gescheiden van elkaar:

- CN - CommonName
- L - LocalityName
- ST - StateOrProvinceName
- O - OrganizationName
- OU - OrganizationalUnitName
- C - CountryName

Voorbeeld:
`C=PT, ST=Lisboa, L=Lisboa, O=Foo Org, OU=Bar Sector, CN=foo.org/emailAddress=admin@foo.org`

De ondertekenende CA heeft niet altijd alle waarden nodig.

Bij een verbinding met een HTTPS-server controleren browsers de CN-waarde, die bij het domein moet passen. Wildcardcertificaten beginnen meestal met een `*` in de CN, zodat elk subdomein wordt toegestaan, bijvoorbeeld `CN=*.example.com`.

Let op: browsers weigeren de wildcard voor het kale domein; `example.com` valt dus niet onder `*.example.com`.

Een certificaat kan wel worden gebruikt voor een HTTPS-server die op meerdere domeinen antwoordt. Extra domeinen geef je op in de extensie Subject Alternative Names.

#### Subject public key info

Bevat het algoritme van de publieke sleutel en de bijbehorende parameters, bijvoorbeeld:

- algorithm: rsa encryption
- key size: 2048
- exponent: 0x10001
- modulus: 00:ec:82:3f:78:b6...

#### Unieke identificatie van uitgever en onderwerp

Ingevoerd in versie 2 om hergebruik van namen van uitgevers en onderwerpen mogelijk te maken. Stel dat een CA failliet gaat en zijn naam uit de openbare lijst van het land wordt geschrapt: na een tijd kan een andere CA met dezelfde naam zich registreren, ook al heeft die niets met de eerste te maken.

Persoonlijk vind ik dit allemaal nogal onzinnig.
Het is dan ook niet verrassend dat de IETF aanraadt namen van uitgevers en onderwerpen niet te hergebruiken.

#### Extensies

Ingevoerd in versie 3.
Een CA kan met extensies een certificaat uitgeven voor een specifiek doel, bijvoorbeeld alleen voor webservers.

Extensies kunnen kritiek of niet-kritiek zijn. Niet-kritieke extensies mogen worden genegeerd; kritieke moeten worden toegepast, en het hele certificaat moet worden geweigerd als het systeem een kritieke extensie niet herkent.

Enkele standaardextensies:

- Subject Key Identifier
- Authority Key Identifier
- Subject Alternative Name
- Basic Constraints

##### Authority en Subject Key Identifiers

Gebruikt als een partij meerdere ondertekeningssleutels heeft.
De identiteit kan worden gecontroleerd met de naam en het serienummer, of met deze sleutel-identificatie.

Een identificatie is de 160-bits SHA-1-hash van de publieke sleutel, of alleen de laatste 60 bits, voorafgegaan door de bits 0100.


##### Subject Alternative Name

Kan extra DNS-namen of IP-adressen bevatten waarvoor het certificaat geldig is, naast de naam in de CN.

##### Basic Constraints

Of het onderwerp een CA is, en eventueel de maximale lengte van certificeringsketens.

## Een praktijkvoorbeeld

Stel dat we een ondertekend certificaat nodig hebben voor een HTTPS-server.
Dan hebben we een certificaat nodig voor het domein (of de domeinen) waarop de server bereikbaar is.

We hebben een certificaat nodig dat de browser kan controleren, zodat hij de gebruiker kan vertellen dat hij bij de juiste servers is van het domein dat hij intypte, en dat er een veilige verbinding is.

Browsers gebruiken een certificaatopslag met een lijst van CA's. Om die te bekijken ga je naar de instellingen van je browser en zoek je het onderdeel Certificaten, misschien onder Beveiliging of Geavanceerd; daar zit meestal een soort certificaatbeheer.

De certificaatopslag van de browser heeft meestal een paar onderdelen. Eén daarvan, waarschijnlijk leeg, is voor clientcertificaten: HTTPS kan namelijk ook de client met een certificaat authenticeren, al gebeurt dat bijna alleen in heel specifieke bedrijfsomgevingen.
Het onderdeel dat je wilt bekijken is 'Autoriteiten' (Authorities), waar de CA-certificaten staan. Je browser heeft vrijwel zeker certificaten van VeriSign, Comodo, GeoTrust, Microsoft enzovoort.

We hebben dus een certificaat nodig dat zegt dat onze sleutel bij ons domein hoort, uitgegeven (ondertekend) door een van deze partijen. Of het kan worden uitgegeven door een tussenpartij die door een van de CA's is gemachtigd om certificaten uit te geven.

Als je zoekt op 'SSL-certificaten', vind je veel verkopers van digitale certificaten. Je zult zien dat wildcardcertificaten meestal wat duurder zijn.

### Wildcardcertificaten

Een wildcardcertificaat is een certificaat dat je voor meerdere subdomeinen van een domein kunt gebruiken.

Browsers kijken naar de CN (Common Name) in het subject-veld, dat een domein moet zijn of een wildcard zoals `*.example.com`.

Browsers accepteren een certificaat met CN `*.example.org` voor `www.example.org`, `login.example.org` of `bo.example.org`. Maar het “kale” domein `example.org` werkt niet.

Extra domeinen (ook het kale domein) kun je toevoegen in de extensie "SubjectAltName".

Om dit te bekijken, ga je in je browser naar `https://mozilla.org` (of een andere HTTPS-server) en klik je op het slotje voor de URL; daar kun je meestal het gebruikte certificaat bekijken. Kijk naar de Common Name van het subject en naar de extensie Subject Alt Name.

## OpenSSL

OpenSSL is een gereedschapskist voor cryptografie. Het bevat veel subcommando's, elk met een eigen manpage, bijvoorbeeld `ca(1)`, `req(1)` en `x509(1)`.

De meeste OpenSSL-tools werken met de parameters `-in` en `-out`. Meestal kun je bestanden ook bekijken met `-in <bestand>` en `-noout`; je geeft dan aan in welk deel van de inhoud je geïnteresseerd bent, of `-text` om alles te zien. Hieronder staan voorbeelden.


### Sleutels en een Certificate Signing Request (CSR) maken

Maak een RSA-sleutel voor de CA:
```
$ openssl genrsa -out example.org.key 2048
Generating RSA private key, 2048 bit long modulus
.........................................+++
```

`openssl genrsa` is de tool om RSA-sleutels te maken; `2048` is de sleutelgrootte.
Dit maakt een bestand `example.org.key` met de privésleutel.

Met de tool `openssl rsa` kun je de sleutel bekijken.

```
$ openssl rsa -in example.org.key -noout -text
Private-Key: (2048 bit)
modulus:
    00:ad:d8:71:1f:ab:a7:df:a6:c3:7e:d8:1f:fd:81:
    b0:5a:a8:9d:51:2b:15:c2:98:95:9e:fe:3b:7c:bd:
    ...
publicExponent: 65537 (0x10001)
privateExponent:
    7b:a9:ba:96:b7:c9:bb:eb:69:a7:62:60:27:39:c8:
    d4:44:9b:5b:b0:d5:52:ce:ad:a8:22:da:f8:19:c2:
    ...
prime1:
    00:d3:98:05:f5:49:48:11:f1:46:71:09:6c:b4:cb:
    e6:3e:6f:a1:41:9a:36:43:c3:22:20:06:d1:aa:dd:
    ...
prime2:
    00:d2:54:5e:cc:15:72:3d:5f:b2:64:ab:4f:42:a6:
    15:79:ca:7a:e0:ef:dd:a7:f3:25:f2:f1:75:b2:33:
    ...
exponent1:
    02:bf:5f:9c:6e:c6:2b:cd:79:3f:b0:82:a3:da:5d:
    f4:03:99:11:74:02:2e:61:13:49:5d:2d:4d:cd:b1:
    ...
exponent2:
    79:6c:c1:e9:9a:3c:00:98:9d:b9:a6:78:b4:a6:83:
    61:73:76:ab:23:6f:58:c5:73:d4:24:77:e9:30:10:
    ...
coefficient:
    17:53:93:4a:48:b0:63:9a:71:0e:37:fb:18:ad:be:
    4e:d0:6e:af:6c:bc:7b:ff:44:c6:93:9a:23:03:51:
    ...
```

Desgewenst kun je de publieke RSA-sleutel uit de privésleutel halen:

```
$ openssl rsa -in example.org.key -pubout -out example.org.pubkey
$ openssl rsa -in example.org.pubkey -pubin -noout -text
Public-Key: (2048 bit)
Modulus:
    00:ad:d8:71:1f:ab:a7:df:a6:c3:7e:d8:1f:fd:81:
    b0:5a:a8:9d:51:2b:15:c2:98:95:9e:fe:3b:7c:bd:
    ...
Exponent: 65537 (0x10001)
```

Een kopie van de privésleutel mag alleen in handen zijn van de partij die gecertificeerd wordt. De sleutel mag dus nooit naar iemand anders worden gestuurd, **ook niet naar de uitgever van het certificaat**.

Nu maken we een Certificate Signing Request met een deel van de informatie die we in het certificaat willen hebben.
Om te bewijzen dat we de privésleutel bezitten, wordt de CSR ondertekend met de privésleutel van het onderwerp.

Maak een CSR:

```
$ openssl req -new -key example.org.key -out example.org.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:PT
State or Province Name (full name) [Some-State]:Lisboa
Locality Name (eg, city) []:Lisboa
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Example Org
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:*.example.org
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

Daarna kunnen we de inhoud van de CSR bekijken:

```
$ openssl req -in example.org.csr -noout -text
Certificate Request:
    Data:
        Version: 0 (0x0)
        Subject: C=PT, ST=Lisboa, L=Lisboa, O=Example Org, CN=*.example.org
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:ad:d8:71:1f:ab:a7:df:a6:c3:7e:d8:1f:fd:81:
                    b0:5a:a8:9d:51:2b:15:c2:98:95:9e:fe:3b:7c:bd:
                    ...
                Exponent: 65537 (0x10001)
        Attributes:
            a0:00
    Signature Algorithm: sha1WithRSAEncryption
         5d:f0:d4:d8:85:4c:e7:dd:6d:f2:bd:05:0f:57:8b:d8:0a:40:
         09:10:ad:ab:cc:5b:a1:92:cb:5d:56:16:7f:0b:23:91:32:06:
         ...
```

De CSR wordt dan naar de uitgever gestuurd, en als die het verzoek goedkeurt, krijg je een certificaat terug.

**Zorg ervoor** dat je ondertekeningsalgoritme niet MD5 is. Oude OpenSSL-configuraties hebben `default_md = md5` als standaard. Browsers weigeren certificaten met MD5 als ondertekeningsalgoritme, omdat dat [onveilig is gebleken][md5harmful].

Merk op dat er geen extensies zijn; daarvoor is een extra configuratiebestand nodig. Dat maakt het iets ingewikkelder, dus als je een wildcardcertificaat koopt, hoef je meestal de extensie SubjectAltName voor het kale domein niet zelf op te geven: dat doet de uitgever voor je.

Dit is een voorbeeldconfiguratie voor een CSR:

```conf
# The main section is named req because the command we are using is req
# (openssl req ...)
[ req ]
# This specifies the default key size in bits. If not specified then 512 is
# used. It is used if the -new option is used. It can be overridden by using
# the -newkey option. 
default_bits = 2048

# This is the default filename to write a private key to. If not specified the
# key is written to standard output. This can be overridden by the -keyout
# option.
default_keyfile = oats.key

# If this is set to no then if a private key is generated it is not encrypted.
# This is equivalent to the -nodes command line option. For compatibility
# encrypt_rsa_key is an equivalent option. 
encrypt_key = no

# This option specifies the digest algorithm to use. Possible values include
# md5 sha1 mdc2. If not present then MD5 is used. This option can be overridden
# on the command line.
default_md = sha1

# if set to the value no this disables prompting of certificate fields and just
# takes values from the config file directly. It also changes the expected
# format of the distinguished_name and attributes sections.
prompt = no

# if set to the value yes then field values to be interpreted as UTF8 strings,
# by default they are interpreted as ASCII. This means that the field values,
# whether prompted from a terminal or obtained from a configuration file, must
# be valid UTF8 strings.
utf8 = yes

# This specifies the section containing the distinguished name fields to
# prompt for when generating a certificate or certificate request.
distinguished_name = my_req_distinguished_name


# this specifies the configuration file section containing a list of extensions
# to add to the certificate request. It can be overridden by the -reqexts
# command line switch. See the x509v3_config(5) manual page for details of the
# extension section format.
req_extensions = my_extensions

[ my_req_distinguished_name ]
C = PT
ST = Lisboa
L = Lisboa
O  = Oats In The Water
CN = *.oats.org

[ my_extensions ]
basicConstraints=CA:FALSE
subjectAltName=@my_subject_alt_names
subjectKeyIdentifier = hash

[ my_subject_alt_names ]
DNS.1 = *.oats.org
DNS.2 = *.oats.net
DNS.3 = *.oats.in
DNS.4 = oats.org
DNS.5 = oats.net
DNS.6 = oats.in
```

Let op de verschillende DNS-namen. Omdat de configuratieparser geen meerdere waarden voor dezelfde naam toestaat, gebruiken we `@my_subject_alt_names` en `DNS.#` met verschillende nummers.

Met deze configuratie kunnen we een CSR maken met de juiste extensies:

```
$ openssl req -new -out oats.csr -config oats.conf
Generating a 2048 bit RSA private key
.............+++
....................................+++
writing new private key to 'oats.key'
-----
```

Omdat we geen sleutel hebben opgegeven, maakt OpenSSL er een op basis van onze configuratie (`default_bits` en `default_keyfile`).

Laten we het resultaat bekijken:

```
$ openssl req -in oats.csr -noout -text
Certificate Request:
    Data:
        Version: 0 (0x0)
        Subject: C=PT, ST=Lisboa, L=Lisboa, O=Oats In The Water, CN=*.oats.org
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:a2:58:fc:57:32:4d:40:aa:62:92:65:86:1d:6b:
                    4f:3e:11:a6:b5:36:f2:48:d2:23:2a:8f:bb:a0:a4:
                    ...
                Exponent: 65537 (0x10001)
        Attributes:
        Requested Extensions:
            X509v3 Basic Constraints: 
                CA:FALSE
            X509v3 Subject Alternative Name: 
                DNS:*.oats.org, DNS:*.oats.net, DNS:*.oats.in, DNS:oats.org, DNS:oats.net, DNS:oats.in
            X509v3 Subject Key Identifier: 
                C6:0E:59:B3:1A:FF:1A:A2:FF:F3:DC:76:21:F0:92:FC:57:88:05:6D
    Signature Algorithm: sha1WithRSAEncryption
         0d:45:6c:21:65:20:72:68:30:91:5f:fa:b8:c3:62:a0:66:a2:
         96:6f:76:4a:ba:ca:e3:1d:9e:eb:47:d4:93:87:88:83:a2:f5:
         ...
```

Nu zien we een sectie `Requested Extensions` met het felbegeerde veld `Subject Alternative Name`.

Een CA kan deze velden nog steeds verwijderen of overschrijven bij het uitgeven van je certificaat. Dat je ze in je CSR zet, garandeert niet dat ze in het uiteindelijke certificaat komen.

### CA-sleutel en zelfondertekend certificaat

Nu spelen we zelf de CA.

Maak een sleutel aan (voor de CA). Dat gaat op dezelfde manier als voor ons onderwerp.

```
$ openssl genrsa -out ca.key 2048
Generating RSA private key, 2048 bit long modulus
......................................................+++
.......+++
e is 65537 (0x10001)
```

Maak een zelfondertekend certificaat voor de CA:

```
$ openssl req -new -x509 -key ca.key -out ca.crt
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:PT
State or Province Name (full name) [Some-State]:Lisboa
Locality Name (eg, city) []:Lisboa
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Sz CA
Organizational Unit Name (eg, section) []:SZ CA
Common Name (e.g. server FQDN or YOUR name) []:
Email Address []:An optional company name []:
```

OpenSSL stelt een X.509-certificaat samen uit de informatie die je invult, en de publieke sleutel die uit de opgegeven privésleutel wordt gehaald; met die privésleutel wordt ook de handtekening gemaakt.

Als we extensies in het zelfondertekende certificaat willen opnemen, kunnen we een configuratiebestand gebruiken zoals bij de CSR, maar dan met `x509_extensions` in plaats van `req_extensions`.

#### Ondertekenen

Een heel eenvoudige manier om een certificaat te ondertekenen:

```
$ openssl x509 -req -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt
Signature ok
subject=/C=PT/ST=Lisboa/L=Lisboa/O=Example Org/CN=*.example.org
Getting CA Private Key
```

Elk uitgegeven certificaat moet een uniek serienummer hebben dat de CA toekent.
Het moet uniek zijn voor elk certificaat van dezelfde CA.
OpenSSL houdt de gebruikte serienummers bij in een bestand, standaard met dezelfde naam als het CA-certificaat maar met de extensie `srl`.
Er wordt dus een bestand `ca.srl` gemaakt:

```
$ cat ca.srl
ED4B4A80662B1B4C
```

Dit commando maakt het bestand `example.org.crt`, dat we kunnen bekijken:

```
$ openssl x509 -in example.org.crt -noout -text
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 17098842325572590412 (0xed4b4a80662b1b4c)
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=PT, ST=Lisboa, L=Lisboa, O=Sz CA, OU=SZ CA
        Validity
            Not Before: Mar 20 22:46:43 2014 GMT
            Not After : Apr 19 22:46:43 2014 GMT
        Subject: C=PT, ST=Lisboa, L=Lisboa, O=Example Org, CN=*.example.org
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:ad:d8:71:1f:ab:a7:df:a6:c3:7e:d8:1f:fd:81:
                    b0:5a:a8:9d:51:2b:15:c2:98:95:9e:fe:3b:7c:bd:
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha1WithRSAEncryption
         05:21:5c:0f:4c:3c:9a:76:7f:3f:fb:fa:e0:09:03:05:c5:16:
         bf:4b:ac:60:d8:86:fc:b2:42:3e:5e:19:45:2a:e2:01:83:67:

```

Let op het serienummer: in hexadecimaal is het precies de inhoud van het aangemaakte bestand `ca.srl`.

Daarna heb ik met het certificaat en de sleutel een HTTPS-server op poort 1443 opgezet met [bud][]. Bud is een TLS-terminator: het pakt inkomende HTTPS-verbindingen uit en stuurt ze als gewone HTTP door naar een backendserver. Ik stuurde de verbindingen van bud door naar een statische HTTP-server met een heel eenvoudige `index.html`.

Ook voegde ik de regel `127.0.0.1 www.example.org` toe aan mijn `/etc/hosts`, zodat mijn computer het domein naar het loopbackadres vertaalt.

Toen ging ik in mijn browser naar `https://www.example.org:1443/`. De browser klaagde meteen dat het certificaat ongeldig was, omdat de ondertekeningsketen ontbrak. Dat betekent: het certificaat zegt dat de partij `C=PT, ST=Lisboa, L=Lisboa, O=Example Org, CN=*.example.org` gecertificeerd is door de partij `C=PT, ST=Lisboa, L=Lisboa, O=Sz CA, OU=SZ CA`, maar er staat nergens wie die tweede partij certificeert, en omdat de browser die partij niet kent, wordt het certificaat ongeldig verklaard.

Wat we kunnen doen, is een extra bestand maken met het certificaat van example.org én het CA-certificaat.

```
$ cat example.org.crt ca.crt > example.org.bundle.crt
```

Dat deed ik, en toen weigerde mijn browser, Firefox, het certificaat nog steeds, maar met een andere melding: nu klaagde hij dat SZ CA geen vertrouwde partij was.

Dus opende ik de instellingen van mijn browser en voegde het CA-certificaat toe aan het onderdeel Autoriteiten in de certificaatopslag. En nu werkt het!

![](https://i.cloudup.com/OhL6UKbvkM.png)

Nou ja... De browser geeft geen waarschuwing meer. Maar hij toont niet het groene icoontje dat je waarschijnlijk gewend bent

![](https://i.cloudup.com/tpp1u2bPAr.png)

Dat komt door [extended validation][], een extensie die we niet in het certificaat hebben opgenomen en waarvoor de CA meestal de wettelijke identiteit van het onderwerp moet controleren. Om dat te controleren, kunnen we de browser het certificaat laten exporteren naar een bestand dat we met openssl kunnen bekijken:

```
$ openssl x509 -in github.com.crt -noout -text
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            04:7f:be:2e:4b:de:00:84:d2:ca:f8:e3:ec:fe:70:58
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=US, O=DigiCert Inc, OU=www.digicert.com, CN=DigiCert High Assurance EV CA-1
        Validity
            Not Before: Jun 10 00:00:00 2013 GMT
            Not After : Sep  2 12:00:00 2015 GMT
        Subject: businessCategory=Private Organization/1.3.6.1.4.1.311.60.2.1.3=US/1.3.6.1.4.1.311.60.2.1.2=Delaware/serialNumber=5157550/street=548 4th Street/postalCode=94107, C=US, ST=California, L=San Francisco, O=GitHub, Inc., CN=github.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:ed:d3:89:c3:5d:70:72:09:f3:33:4f:1a:72:74:
                    d9:b6:5a:95:50:bb:68:61:9f:f7:fb:1f:19:e1:da:
                    ...
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Authority Key Identifier: 
                keyid:4C:58:CB:25:F0:41:4F:52:F4:28:C8:81:43:9B:A6:A8:A0:E6:92:E5

            X509v3 Subject Key Identifier: 
                87:D1:8F:19:6E:E4:87:6F:53:8C:77:91:07:50:DF:A3:BF:55:47:20
            X509v3 Subject Alternative Name: 
                DNS:github.com, DNS:www.github.com
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 CRL Distribution Points: 

                Full Name:
                  URI:http://crl3.digicert.com/evca1-g2.crl

                Full Name:
                  URI:http://crl4.digicert.com/evca1-g2.crl

            X509v3 Certificate Policies: 
                Policy: 2.16.840.1.114412.2.1
                  CPS: http://www.digicert.com/ssl-cps-repository.htm
                  User Notice:
                    Explicit Text: 

            Authority Information Access: 
                OCSP - URI:http://ocsp.digicert.com
                CA Issuers - URI:http://cacerts.digicert.com/DigiCertHighAssuranceEVCA-1.crt

            X509v3 Basic Constraints: critical
                CA:FALSE
    Signature Algorithm: sha1WithRSAEncryption
         5f:15:6d:67:c3:3a:d5:a3:de:16:9c:45:33:26:d5:3d:c9:16:
         74:34:ca:87:48:1b:14:90:6d:f5:ab:47:86:b9:f5:b8:e3:01:
         ...
```

De relevante extensie voor Extended Validation (EV) is `Certificate Policies`.

Verkopers van certificaten weigeren wildcardcertificaten met EV uit te geven, omdat cabforum.org, de organisatie die de regels voor EV-SSL-certificaten bepaalt, heeft besloten dat dit absoluut niet mag. EV-certificaten kunnen wel zoveel SubjectAltNames hebben als je wilt.

#### `openssl ca`

Je kunt CSR's ook ondertekenen met `ca(1)`.

Eerst hebben we een configuratiebestand `ca.conf` nodig:

```
# we use 'ca' as the default section because we're usign the ca command
# we use 'ca' as the default section because we're usign the ca command
[ ca ]
default_ca = my_ca

[ my_ca ]
#  a text file containing the next serial number to use in hex. Mandatory.
#  This file must be present and contain a valid serial number.
serial = ./serial

# the text database file to use. Mandatory. This file must be present though
# initially it will be empty.
database = ./index.txt

# specifies the directory where new certificates will be placed. Mandatory.
new_certs_dir = ./newcerts

# the file containing the CA certificate. Mandatory
certificate = ./ca.crt

# the file contaning the CA private key. Mandatory
private_key = ./ca.key

# the message digest algorithm. Remember to not use MD5
default_md = sha1

# for how many days will the signed certificate be valid
default_days = 365

# a section with a set of variables corresponding to DN fields
policy = my_policy

[ my_policy ]
# if the value is "match" then the field value must match the same field in the
# CA certificate. If the value is "supplied" then it must be present.
# Optional means it may be present. Any fields not mentioned are silently
# deleted.
countryName = match
stateOrProvinceName = supplied
organizationName = supplied
commonName = supplied
organizationalUnitName = optional
commonName = supplied

[ ca ]
default_ca = my_ca

[ my_ca ]
#  a text file containing the next serial number to use in hex. Mandatory.
#  This file must be present and contain a valid serial number.
serial = ./serial

# the text database file to use. Mandatory. This file must be present though
# initially it will be empty.
database = ./index.txt

# specifies the directory where new certificates will be placed. Mandatory.
new_certs_dir = ./newcerts

# the file containing the CA certificate. Mandatory
certificate = ./ca.crt

# the file contaning the CA private key. Mandatory
private_key = ./ca.key

# the message digest algorithm. Remember to not use MD5
default_md = sha1

# for how many days will the signed certificate be valid
default_days = 365

# a section with a set of variables corresponding to DN fields
policy = my_policy

[ my_policy ]
# if the value is "match" then the field value must match the same field in the
# CA certificate. If the value is "supplied" then it must be present.
# Optional means it may be present. Any fields not mentioned are silently
# deleted.
countryName = match
stateOrProvinceName = supplied
organizationName = supplied
commonName = supplied
organizationalUnitName = optional
commonName = supplied

```

Vergeet niet: met `man ca` zie je niet alleen details over opties en gebruik van het commando, maar ook over de bijbehorende configuratiesecties en -instellingen.

We moeten eerst wat structuur aanmaken. Het configuratiebestand verwacht een map `newcerts` en de bestanden `index.txt` en `serial`:

```
$ mkdir newcerts
$ touch index.txt
$ echo '01' > serial
```

En nu kunnen we eindelijk het certificaat ondertekenen:

```
$ openssl ca -config ca.cnf -out example.org.crt -infiles example.org.csr
Using configuration from ca.cnf
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
countryName           :PRINTABLE:'PT'
stateOrProvinceName   :ASN.1 12:'Lisboa'
localityName          :ASN.1 12:'Lisboa'
organizationName      :ASN.1 12:'Example Org'
commonName            :ASN.1 12:'*.example.org'
Certificate is to be certified until Mar 21 01:13:36 2015 GMT (365 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
```

Als we extensies willen toevoegen, of de extensies uit een CSR willen behouden (openssl verwijdert ze bij het ondertekenen), dan moeten we die configuratie ook meegeven.

Dit is een extra configuratiebestand `oats.extensions.cnf`:

```
basicConstraints=CA:FALSE
subjectAltName=@my_subject_alt_names
subjectKeyIdentifier = hash

[ my_subject_alt_names ]
DNS.1 = *.oats.org
DNS.2 = *.oats.net
DNS.3 = *.oats.in
DNS.4 = oats.org
DNS.5 = oats.net
DNS.6 = oats.in
```

En nu:

```
$ openssl ca -config ca.cnf -out oats.crt -extfile oats.extensions.cnf -in oats.csr
Using configuration from ca.cnf
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
countryName           :PRINTABLE:'PT'
stateOrProvinceName   :PRINTABLE:'Lisboa'
localityName          :PRINTABLE:'Lisboa'
organizationName      :PRINTABLE:'Oats In The Water'
commonName            :T61STRING:'*.oats.org'
Certificate is to be certified until Mar 21 01:43:11 2015 GMT (365 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
```

We hebben een certificaat met de SubjectAltNames die we wilden:

```
$ openssl x509 -in oats.crt -noout -text

Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 2 (0x2)
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=PT, ST=Lisboa, L=Lisboa, O=Sz CA, OU=SZ CA
        Validity
            Not Before: Mar 21 01:43:11 2014 GMT
            Not After : Mar 21 01:43:11 2015 GMT
        Subject: C=PT, ST=Lisboa, O=Oats In The Water, CN=*.oats.org
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:a2:58:fc:57:32:4d:40:aa:62:92:65:86:1d:6b:
                    4f:3e:11:a6:b5:36:f2:48:d2:23:2a:8f:bb:a0:a4:
                    ...
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: 
                CA:FALSE
            X509v3 Subject Alternative Name: 
                DNS:*.oats.org, DNS:*.oats.net, DNS:*.oats.in, DNS:oats.org, DNS:oats.net, DNS:oats.in
            X509v3 Subject Key Identifier: 
                C6:0E:59:B3:1A:FF:1A:A2:FF:F3:DC:76:21:F0:92:FC:57:88:05:6D
    Signature Algorithm: sha1WithRSAEncryption
         89:7e:7d:67:1e:98:85:78:a1:f2:81:4c:b4:8c:f9:80:cd:47:
         a9:94:94:a3:f0:dd:36:d3:e3:48:93:77:4a:31:16:03:79:9c:
         ...
```

We kunnen controleren of het certificaat klopt:

```
$ openssl verify -CAfile ca.crt oats.crt
oats.crt: OK
```

# Dat was het

Ik weet dat ik heel veel niet heb behandeld, belangrijke dingen zoals CRL's (intrekkingslijsten). Sorry daarvoor. Het hele systeem ziet er nogal rommelig uit, en ik hoop dat we het in de toekomst kunnen vervangen door iets beters.

[RFC1422]: https://tools.ietf.org/html/rfc1422
[RFC1779]: https://tools.ietf.org/html/rfc1779
[RFC2459]: https://tools.ietf.org/html/rfc2459
[RFC5280]: https://tools.ietf.org/html/rfc5280
[wot]: https://en.wikipedia.org/wiki/Web_of_trust
[md5harmful]: http://www.win.tue.nl/hashclash/rogue-ca/
[bud]: https://github.com/indutny/bud
[extended validation]: https://en.wikipedia.org/wiki/Extended_Validation_Certificate
