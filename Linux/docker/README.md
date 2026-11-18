---
title: "Docker"
date: 2016-12-18
description: "The Docker commands I keep forgetting: build, run, list and clean up images and containers."
---

*🇳🇱 [Lees deze pagina in het Nederlands](nl.md)*

# Reminders

```bash
docker build .                  # build an image from the Dockerfile in this folder
docker run 1b2b66f83a77         # start a container from an image ID
docker images                   # list images
docker rmi <image>              # remove an image
docker container ls             # list running containers
docker container prune -f       # remove all stopped containers
docker image prune              # remove dangling images
```
