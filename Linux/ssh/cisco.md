---
title: "Connect to cisco switch with SSH"
author:
  - Benjamin Italiaander
date: 2020-04-20
keywords:
    - ssh
    - cisco
 
    - ssh-keygen
    - ED25519
    
---

### Introduction 
I got this error message when i try to login with SSH to my cisco switch. 

::: { .Alert #custom-id .other-class } ::::::
**CISCO**  --- SSH fails to connect

```markdown
Unable to negotiate with [hostname or ip]  port 22: no matching key exchange method found. Their offer: diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1,diffie-hellman-group14-sha1
```

::::::::::::::::::


You can solve this by using
```bash
ssh -o KexAlgorithms=diffie-hellman-group1-sha1 [hostname or ip]
```



