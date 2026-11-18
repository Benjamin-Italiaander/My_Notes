---
title: "SSH config file"
date: 2016-10-30
description: "Examples of the SSH client config file: users, keys, agent forwarding and jump hosts."
---

*🇳🇱 [Lees deze pagina in het Nederlands](config_nl.md)*

### The SSH client configuration file

#### The file is located at
```bash
~/.ssh/config
```

#### Example 1
A regular configuration:
```bash
Host server.tld
     User username
     IdentityFile /home/username/.ssh/id_rsa
     ForwardAgent yes
```
The `ForwardAgent` option lets you use your local SSH key on the remote server (for example to `git pull` there) without copying your private key to that server. It's built into SSH and easy to set up. Only enable it for servers you trust: anyone with root access on that server can use your forwarded agent while you are connected.

#### Example 2
Here I added a `Hostname`, so you can connect with the short name `server01`. You can also use an IP address as the hostname.
```bash
Host server01
     User root
     Hostname server01.sub.tld 
     IdentityFile /root/.ssh/id_rsa
     ForwardAgent yes
```

#### More options
```bash
ProxyJump jump.server.tld
```
This connects to the remote host through a jump host (bastion).

