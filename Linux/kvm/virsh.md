# Get local port for display 

List all running VMS
```bash
# virsh list
 Id   Name       State
--------------------------
 1    debian12   running
 4    AGENDA     running
```

Find local port
```bash
# virsh domdisplay  --domain debian12 
spice://127.0.0.1:5900


```
