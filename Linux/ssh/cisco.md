---
title: "Connect to a Cisco switch with SSH"
date: 2020-04-20
description: "Fix \"no matching key exchange method found\" when connecting to an old Cisco switch with SSH."
author:
  - Benjamin Italiaander
keywords:
    - ssh
    - cisco
    - ssh-keygen
    - ED25519
---

*🇳🇱 [Lees deze pagina in het Nederlands](cisco_nl.md)*

### Introduction
I got this error message when I tried to log in to my Cisco switch with SSH.

**Cisco**: SSH fails to connect

```text
Unable to negotiate with [hostname or ip] port 22: no matching key exchange method found. Their offer: diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1,diffie-hellman-group14-sha1
```



You can solve this by explicitly allowing the old key exchange method:
```bash
ssh -o KexAlgorithms=+diffie-hellman-group1-sha1 [hostname or ip]
```

> ⚠️ These SHA-1 algorithms are outdated and insecure. Only use them for old network equipment, ideally on a management network.
