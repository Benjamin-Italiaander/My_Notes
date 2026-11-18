---
title: "Best practice: generate an SSH key pair"
date: 2022-04-20
description: "Best practice for generating an Ed25519 SSH key pair with ssh-keygen, and what the options mean."
author:
  - Benjamin Italiaander
keywords:
    - ssh
    - keypair
    - sshkeypair
    - ssh-keygen
    - ED25519
---

*🇳🇱 [Lees deze pagina in het Nederlands](ssh_keygen_nl.md)*

![](./ssh-150x150.png "ssh-150x150.png")

### Introduction 
A short best-practice guide on how to generate an SSH key pair on the Linux command line.

A public/private key pair is a pair of mathematically related keys used in asymmetric cryptography for authentication, digital signatures or key establishment. As the name indicates, the private key is used by the owner of the key pair, is kept secret and should be protected at all times, while the public key can be published and used by the other party to complete the protocol or to verify the operations performed with the private key.



**NEVER SHARE YOUR PRIVATE KEY!** 



#### Preferred ED25519 key type
I prefer the [Ed25519](https://ed25519.cr.yp.to/) key type. It was added to OpenSSH in 2014 and is supported by all current OpenSSH versions. Some old clients, servers and network devices don't support it yet, so check their documentation if you run into problems.

Generate a key pair by running this command in a Linux/Unix terminal. It creates two files in your `~/.ssh` folder (`id_ed25519` and `id_ed25519.pub`):

```shell
ssh-keygen -t ed25519 -a 100 -C my@email.tld
```




* -a  The number of KDF ([Key Derivation Function](https://en.wikipedia.org/wiki/Key_derivation_function)) rounds. Higher numbers make passphrase verification slower, which increases resistance to brute-force password cracking if the private key is stolen. Use at least 100 rounds.
* -t  The type of key to create, in our case Ed25519.
* -f  The filename of the generated key file. If you want SSH to find it automatically, store it in the default `.ssh` directory in your home directory.
* -C  A comment. It's purely informational and can be anything, but it's usually `<login>@<hostname>` of whoever generated the key.

[Here are IBM's ssh-keygen instructions](https://www.ibm.com/docs/en/zos/2.4.0?topic=descriptions-ssh-keygen-authentication-key-generation-management-conversion).
