---
title: "Login Email Notifications with PAM"
date: 2016-05-06
description: "Get an email every time someone logs in over SSH or on the console, using PAM and a small script."
---

*🇳🇱 [Lees deze pagina in het Nederlands](login_notification_nl.md)*

# Linux Login Email Notifications using PAM

This setup sends an email notification whenever someone logs into the Linux system over SSH or on a local console.

Useful for:

* Detecting unexpected access
* Monitoring servers remotely
* Security auditing
* Home lab notifications

---

# Install the Required Mail Utility

Install a simple mail client:

```bash
apt update
apt install bsd-mailx
```

---

# Create the Login Notification Script

Create the script:

```bash
nano /usr/local/bin/login-notify.sh
```

Contents:

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

# Make the Script Executable

```bash
chmod +x /usr/local/bin/login-notify.sh
```

---

# Enable Notifications for SSH Logins

Edit the SSH PAM configuration:

```bash
nano /etc/pam.d/sshd
```

Add this line near the bottom:

```text
session optional pam_exec.so seteuid /usr/local/bin/login-notify.sh
```

---

# Enable Notifications for Local Console Logins (Optional)

Edit:

```bash
nano /etc/pam.d/login
```

Add:

```text
session optional pam_exec.so seteuid /usr/local/bin/login-notify.sh
```

---

# Test the Configuration

Test with:

```bash
ssh localhost
```

You should receive an email notification containing:

* Username
* Source IP
* TTY
* Service
* Date/time
* Hostname

---

# Example Email

Subject:

```text
PAM Event [open_session] on server01
```

Body (shortened):

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

# Monitor Mail Logs

```bash
tail -f /var/log/mail.log
```

---

# Notes

* `$PAM_RHOST` may be empty for local logins.
* Requires a working local mail system (Postfix, Exim, etc.).
* With the `session` lines above, the script runs when a session opens and when it closes (`open_session` / `close_session`).
* Works on most Linux distributions using PAM.

---


