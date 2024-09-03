### ssh config client config file

#### File is located at
```bash
~/.ssh/config
```

#### Example 1
```bash
Host server.tld
     User root
     IdentityFile /root/.ssh/id_rsa
     ForwardAgent yes
```
