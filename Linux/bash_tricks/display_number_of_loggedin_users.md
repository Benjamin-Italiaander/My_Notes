---
title: 'Count logged-in users'
date: 2021-01-01
description: 'Count logged-in users'
section: Linux
author: 'benjamin-italiaander'
---

*🇳🇱 [Lees deze pagina in het Nederlands](display_number_of_loggedin_users_nl.md)*

# Display the number of logged-in users with the who command

Keeping track of the number of users logged into a system can be very useful. This short Bash command shows the exact number of active users:

```bash
who -q | grep "users=" | sed 's/# users=//g'
```

For a continuous, real-time update of the user count, pipe it through `watch`:

```bash
watch "who -q | grep 'users=' | sed 's/# users=//g'"
```
