---

date: 2025-09-01T12:30:21+01:00
title: "YubiKey Get started the safe way"
draft: false
description: "A short Getting Started Using the Linux CLI"

---



# YubiKey bare minimum
#### A short Getting Started Using the Linux CLI

In the following steps i show you what you should at least do with your YubiKey before you stert using it

[test1](NL_yubikey_gpg.md/)

[My Page]({{< ref "NL_yubikey_gpg.md" >}})


Step 1 till step 8 are the absolute bare minimum you should complete before you start using your YubiKey.
If you skip these steps, there is nothing truly secure about using your YubiKey.

Hardware tokens are a powerful tool and can raise your security to a very high level—but only when used correctly.
Be aware that using hardware tokens incorrectly will not result in a more secure user environment.


This instruction is a modified document based on the YubiKey guide found here **[Securing SSH with FIDO2](https://developers.yubico.com/SSH/Securing_SSH_with_FIDO2.html)**


> **Never use SSH agent forwarding with your YubiKey — or use of ssh -a — in fact, it’s best not to use agent forwarding at all.**


