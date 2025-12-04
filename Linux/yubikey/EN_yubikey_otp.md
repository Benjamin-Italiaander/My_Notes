# YubiKey OATH / TOTP — Quick Setup Guide

Before creating TOTP codes on your YubiKey, make sure you have completed the **minimum required setup**.
(You can find that guide [**here**](https://github.com/Benjamin-Italiaander/My_Notes/blob/main/Linux/yubikey/README.md).)

---

## 1. Check Your OATH Configuration

Use the command below to inspect the status of your YubiKey’s OATH applet:

```bash
ykman oath info
```

Example output:

```
OATH version:        5.7.4
Password protection: disabled
```

If password protection is **disabled**, continue to the next step.

---

## 2. Enable OATH Password Protection

This encrypts all your TOTP secrets stored on the YubiKey.

Run:

```bash
ykman oath access change
```

You will be prompted:

```
Enter the new password:
Repeat for confirmation:
```

Check again:

```bash
ykman oath info
```

Expected result:

```
OATH version:        5.7.4
Password protection: enabled
```

---

## 3. Add a TOTP Credential

There are multiple ways to add a TOTP entry to your YubiKey.
Below are some examples using the **correct ykman 5.x syntax**.

### Example 1 — Generic TOTP Account

```bash
ykman oath accounts add --touch --digits 6 --period 30 "appName:username" ABCDAOFKRNGKALWD
```

### Example 2 — GitHub TOTP Entry

```bash
ykman oath accounts add --touch --digits 6 --period 30 "gitHub:myusername" ABCDAOFKRNGKALWD
```

> **Note:**
> The last argument (`ABCDAOFKRNGKALWD`) is your **Base32 TOTP secret**.

---

## 4. Generate TOTP Codes

To list all current codes:

```bash
ykman oath accounts code
```

To get a code for one specific account:

```bash
ykman oath accounts code "gitHub:myusername"
```

---
