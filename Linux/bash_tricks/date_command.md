# Just a small example of the date command

Show the weekday in number, always handy to know, small examples of the date command

```bash
# Display weekday
date +%u
```

```bash
# Display quater of the year
date +%q

```

```bash
#!/bin/bash
todayWeekday=$(date +%u)
todayQuater=$(date +%q)
echo -e 'The command "date +%u" gives the weekday in numbers output is:' $todayWeekday
```
