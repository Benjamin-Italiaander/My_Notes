---
title: "List outgoing connections"
date: 2016-04-02
description: "List the remote addresses of outgoing TCP and UDP connections with netstat or ss."
---

*🇳🇱 [Lees deze pagina in het Nederlands](outgoing_connections_nl.md)*

# How to list outgoing connections on the Linux CLI

A small example of how to show the remote addresses of your connections.

Outgoing TCP connections:

```bash
netstat -atn | tr -s ' ' | cut -f5 -d ' ' | grep -v '127.0.0.1'
```

Outgoing UDP connections:

```bash
netstat -aun | tr -s ' ' | cut -f5 -d ' ' | grep -v '127.0.0.1'
```

On newer systems `netstat` may not be installed; `ss -tn` (TCP) and `ss -un` (UDP) give similar output.
