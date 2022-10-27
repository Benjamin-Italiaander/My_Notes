---
title: "Best practice generate a ssh-keypair"
author:
  - Benjamin Italiaander
date: 2022-04-20
keywords:
    - ssh
    - keypair
    - sshkeypair
    - ssh-keygen
    - ED25519
    
---
![](./ssh-150x150.png "ssh-150x150.png")

### Introduction 
This is a short best practice how to generate a ssh-keypair at the linux commandline. 

A public/private key pair is pair of mathematically related keys used in asymmetric cryptography for authentication, digital signature, or key establishment. As the name indicates, the private key is used by the owner of the key pair, is kept secret, and should be protected at all times, while the public key can be published and used be the relying party to complete the protocol or invert the operations performed with the private key. 



::: { .Error #custom-id .other-class } ::::::
**NEVER SHARE YOUR PRIVATE KEY!** 
::::::::::::::::::



#### Preferred ED25519 key type
I prefer to use the [ED25519](https://ed25519.cr.yp.to/) key type. This is one of the new algorithms added in OpenSSH. Support for it in clients is not yet universal. You need to check the documentation of the SSH clients and servers, if they support this algorithm.

You can generate a keypair by running this command from the linux/unix terminal. This will generate two files in your ~/.ssh folder

```shell
ssh-keygen -t ed25519 -a 100 -C my@email.tld
```




* -a  It’s the numbers of KDF ([Key Derivation Function](https://en.wikipedia.org/wiki/Key_derivation_function)) rounds. Higher numbers result in slower passphrase verification, increasing the resistance to brute-force password cracking should the private-key be stolen. At least use a 100 rounds
* -t  Specifies the type of key to create, in our case the Ed25519.
* -f  Specify the filename of the generated key file. If you want it to be discovered automatically by the SSH agent, it must be stored in the default `.ssh` directory within your home directory.
* -C  An option to specify a comment. It’s purely informational and can be anything. But it’s usually filled with `<login>@<hostname>` who generated the key.

[Here is a link ](https://www.ibm.com/docs/en/zos/2.4.0?topic=descriptions-ssh-keygen-authentication-key-generation-management-conversion)to ibm.com ssh-keygen instructions.



