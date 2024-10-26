#How to filter out outgoing connections on the linux cli 
This is a small example how 

Filter outoutgoing TCP connections
```bash
# Show ougoing TCP connections
netstat -atn | tr -s ' '| cut -f5 -d ' ' | grep -v '127.0.0.1'
```

Filter out going UDP connections
```bash
# Show outgoing UDP connections
netstat -aun | tr -s ' '| cut -f5 -d ' ' | grep -v '127.0.0.1'
```
