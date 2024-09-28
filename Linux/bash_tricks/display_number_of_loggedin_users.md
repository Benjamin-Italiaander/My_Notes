---
section: Linux
title: 'Some tricks in bash'
description: 'Count loggedin users'
author: 'benjamin-italiaander'
date: 2021
---

# Display the number of logged in users using the who command


Keeping track of the number of users logged into a system can be incredibly useful. Here's a concise Bash command that displays the exact 
count of active users

```bash 
who -q | grep "users=" | sed 's/# users=//g'
```

For a continuous, real-time update of the user count, try piping the command to `watch` - it's as easy as

```bash
watch "who -q | grep "users=" | sed 's/# users=//g'"
```

