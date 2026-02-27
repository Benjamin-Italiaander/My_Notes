---

title: "Date command in bash"
draft: false
date: 2023-02-27T14:12:45+01:00

---



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
