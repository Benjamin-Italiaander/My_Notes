---
title: "Firefox Already Running"
date: 2016-09-17
description: "Fix the \"Firefox is already running\" message by removing leftover lock files."
---

*🇳🇱 [Lees deze pagina in het Nederlands](firefox_already_running_nl.md)*

# Firefox is already running

If you try to open Firefox and get the message *"Firefox is already running"*, close all Firefox windows and try this script. It removes the leftover lock files:

```bash
#!/bin/bash
find ~/.mozilla -name "*lock" -print0 |
while IFS= read -r -d '' file; do
  echo "removing $file..."
  rm "$file"
done
```
