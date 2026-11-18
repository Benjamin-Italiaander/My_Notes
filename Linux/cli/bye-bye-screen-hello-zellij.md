---
title: "Bye Bye Screen, Hello Zellij"
date: 2016-03-28
description: "Zellij, a modern terminal multiplexer that replaces screen and tmux, plus a fix for copy-paste."
---

*🇳🇱 [Lees deze pagina in het Nederlands](bye-bye-screen-hello-zellij_nl.md)*

# [Zellij](https://zellij.dev/) is a great alternative to screen!

I recently came across Zellij, a really nice replacement for terminal multiplexers like tmux and screen. I instantly became a fan!

[Zellij can be found here](https://zellij.dev/). It isn't in every distribution's repositories yet, but it is easy to build from source, or you can download the binary and copy it to a folder in your `PATH`, such as `/usr/local/bin`.

If you have copy-paste problems in Zellij, add the line `mouse_mode false` to `config.kdl`. After adding it, kill all running Zellij sessions and start Zellij again.

```bash
echo "mouse_mode false" >> ~/.config/zellij/config.kdl
```
