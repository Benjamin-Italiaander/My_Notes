# Linux Login Email Notifications using PAM

This setup sends an email notification whenever someone logs into the Linux system over SSH or via a local console login.

Useful for:

* Detecting unexpected access
* Monitoring servers remotely
* Security auditing
* Home lab notifications

---

# Install Required Mail Utility

Install a simple mail client:

```bash
apt update
apt install bsd-mailx
```

---

# Create Login Notification Script

Create the script:

```bash
nano /usr/local/bin/login-notify.sh
```

Contents:

```bash
#!/bin/bash

SUBJECT="Login on $(hostname)"
TO="benjamin@tlnd.org"

MESSAGE="
User: $PAM_USER
Remote Host: $PAM_RHOST
TTY: $PAM_TTY
Service: $PAM_SERVICE
Date: $(date)
Hostname: $(hostname)
"

echo "$MESSAGE" | mail -s "$SUBJECT" "$TO"
```

---

# Make Script Executable

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
Login on helsinki
```

Body:

```text
User: benjamin
Remote Host: 192.168.1.10
TTY: pts/0
Service: sshd
Date: Mon Jun 1 16:00:00 UTC 2026
Hostname: helsinki
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
* The script runs on every successful login session.
* Works on most Linux distributions using PAM.

---


