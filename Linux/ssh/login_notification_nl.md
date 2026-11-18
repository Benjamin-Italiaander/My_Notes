---
title: "E-mailmeldingen bij inloggen met PAM"
date: 2025-11-18
description: "Krijg een e-mail telkens als iemand via SSH of op de console inlogt, met PAM en een klein script."
translated_by_ai: true
translated_from: "en"
original: "login_notification.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](login_notification.md).* Het script zelf is niet vertaald.

# E-mailmeldingen bij inloggen op Linux met PAM

Deze opzet stuurt een e-mail zodra iemand via SSH of op een lokale console inlogt op het Linux-systeem.

Handig voor:

* Onverwachte toegang opmerken
* Servers op afstand in de gaten houden
* Beveiligingsaudits
* Meldingen in je homelab

---

# Het benodigde mailprogramma installeren

Installeer een eenvoudige mailclient:

```bash
apt update
apt install bsd-mailx
```

---

# Het meldingsscript maken

Maak het script:

```bash
nano /usr/local/bin/login-notify.sh
```

Inhoud:

```bash
#!/bin/bash

## DON'T FORGET TO CHANGE YOUR EMAIL ADDRESS!
TO="admin@example.com"
HOST="$(hostname -f 2>/dev/null || hostname)"

case "$PAM_TYPE" in
auth)
DESCRIPTION="Authentication attempt (password, SSH key, MFA or other authentication mechanism)"
;;
account)
DESCRIPTION="Account validation (access rules, expiration checks, login restrictions)"
;;
open_session)
DESCRIPTION="User session opened successfully (login)"
;;
close_session)
DESCRIPTION="User session closed (logout or disconnect)"
;;
password)
DESCRIPTION="Password change operation"
;;
*)
DESCRIPTION="Unknown PAM event"
;;
esac

SUBJECT="PAM Event [$PAM_TYPE] on $HOST"

MESSAGE="
PAM Event Notification

Event Type : $PAM_TYPE
Description: $DESCRIPTION

Hostname   : $HOST
Date       : $(date)

User       : ${PAM_USER:-N/A}
Remote User: ${PAM_RUSER:-N/A}
Remote Host: ${PAM_RHOST:-N/A}
TTY        : ${PAM_TTY:-N/A}
Service    : ${PAM_SERVICE:-N/A}

## Process Information

PID        : $$
Parent PID : $PPID
Script User: $(id -un)
Script UID : $(id -u)

## Environment

SSH_CLIENT : ${SSH_CLIENT:-N/A}
SSH_CONNECTION : ${SSH_CONNECTION:-N/A}
SSH_TTY    : ${SSH_TTY:-N/A}
"

echo "$MESSAGE" | mail -s "$SUBJECT" "$TO"

exit 0
```

---

# Het script uitvoerbaar maken

```bash
chmod +x /usr/local/bin/login-notify.sh
```

---

# Meldingen aanzetten voor SSH-logins

Bewerk de PAM-configuratie van SSH:

```bash
nano /etc/pam.d/sshd
```

Voeg deze regel onderaan toe:

```text
session optional pam_exec.so seteuid /usr/local/bin/login-notify.sh
```

---

# Meldingen aanzetten voor logins op de lokale console (optioneel)

Bewerk:

```bash
nano /etc/pam.d/login
```

Voeg toe:

```text
session optional pam_exec.so seteuid /usr/local/bin/login-notify.sh
```

---

# De configuratie testen

Test met:

```bash
ssh localhost
```

Je zou een e-mail moeten krijgen met:

* Gebruikersnaam
* IP-adres van de bron
* TTY
* Dienst
* Datum/tijd
* Hostnaam

---

# Voorbeeldmail

Onderwerp:

```text
PAM Event [open_session] on server01
```

Inhoud (ingekort):

```text
PAM Event Notification

Event Type : open_session
Description: User session opened successfully (login)

Hostname   : server01
Date       : Mon Jun 1 16:00:00 UTC 2026

User       : alice
Remote Host: 192.0.2.10
TTY        : ssh
Service    : sshd
```

---

# De maillogs volgen

```bash
tail -f /var/log/mail.log
```

---

# Opmerkingen

* `$PAM_RHOST` kan leeg zijn bij lokale logins.
* Je hebt een werkend lokaal mailsysteem nodig (Postfix, Exim, enzovoort).
* Met de `session`-regels hierboven draait het script zowel bij het openen als bij het sluiten van een sessie (`open_session` / `close_session`).
* Werkt op de meeste Linux-distributies die PAM gebruiken.

---


