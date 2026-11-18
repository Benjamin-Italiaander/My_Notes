---
title: "Docker"
date: 2025-11-18
description: "De Docker-commando's die ik steeds vergeet: images en containers bouwen, starten, tonen en opruimen."
translated_by_ai: true
translated_from: "en"
original: "README.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](README.md).*

# Geheugensteuntjes

```bash
docker build .                  # een image bouwen van de Dockerfile in deze map
docker run 1b2b66f83a77         # een container starten vanaf een image-ID
docker images                   # images tonen
docker rmi <image>              # een image verwijderen
docker container ls             # draaiende containers tonen
docker container prune -f       # alle gestopte containers verwijderen
docker image prune              # ongebruikte (dangling) images verwijderen
```
