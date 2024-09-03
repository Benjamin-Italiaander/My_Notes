### ssh config client config file

#### File is located at
```bash
~/.ssh/config
```

#### Example 1
This is a regular config
```bash
Host server.tld
     User username
     IdentityFile /home/username/.ssh/id_rsa
     ForwardAgent yes
```
The ForwardAgent option allows you to use your private, local SSH key remotely without worrying about leaving confidential data on the server you're working with. It's built into ssh, and is easy to set up and use.




#### Example 2
Here i added a hostname, you can also replace hostname with a ip
```bash
Host server01
     User root
     Hostname server01.sub.tld 
     IdentityFile /root/.ssh/id_rsa
     ForwardAgent yes
```
