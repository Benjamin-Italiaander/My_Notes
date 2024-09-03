### ssh config client config file

#### File is located at
```bash
~/.ssh/config
```

#### Example 1
This is a regular config
```bash
Host server.tld
     User root
     IdentityFile /root/.ssh/id_rsa
     ForwardAgent yes
```

#### Example 2
Here i added a hostname, you can also replace hostname with a ip
```bash
Host server01
     User root
     Hostname server01.sub.tld 
     IdentityFile /root/.ssh/id_rsa
     ForwardAgent yes
```
