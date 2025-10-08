# Just a small date example

Show the weekday in number, always handy to know
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
