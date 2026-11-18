---
title: "Dag screen, hallo Zellij"
date: 2025-11-18
description: "Zellij, een moderne terminal-multiplexer die screen en tmux vervangt, plus een oplossing voor kopiëren en plakken."
translated_by_ai: true
translated_from: "en"
original: "bye-bye-screen-hello-zellij.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](bye-bye-screen-hello-zellij.md).*

# [Zellij](https://zellij.dev/) is een prima alternatief voor screen!

Ik kwam onlangs Zellij tegen, een hele fijne vervanger voor terminal-multiplexers zoals tmux en screen. Ik was meteen fan!

[Zellij vind je hier](https://zellij.dev/). Het zit nog niet in de pakketbronnen van elke distributie, maar je kunt het makkelijk vanuit de broncode bouwen, of de binary downloaden en naar een map in je `PATH` kopiëren, zoals `/usr/local/bin`.

Heb je problemen met kopiëren en plakken in Zellij? Zet dan de regel `mouse_mode false` in `config.kdl`. Sluit daarna alle draaiende Zellij-sessies af en start Zellij opnieuw.

```bash
echo "mouse_mode false" >> ~/.config/zellij/config.kdl
```
