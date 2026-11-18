---
title: "Linux CLI-spiekbriefje (dagelijks gebruik)"
date: 2025-11-18
description: "Sneltoetsen voor dagelijks gebruik op de Linux-commandoregel: zoeken in de geschiedenis, de cursor verplaatsen, bewerken en jobs beheren."
translated_by_ai: true
translated_from: "en"
original: "cheatsheet_bash.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](cheatsheet_bash.md).*

# 🧠 Linux CLI-spiekbriefje (dagelijks gebruik)

## 🔎 Zoeken in de geschiedenis
```bash
Ctrl + r        # Terugzoeken (typ om te zoeken, druk nogmaals voor oudere treffers)
Ctrl + s        # Vooruit zoeken (staat vaak standaard uit)

history         # De commandogeschiedenis tonen
history | grep ssh   # Zoeken in de geschiedenis met grep

!123            # Commando nummer 123 uit de geschiedenis uitvoeren
!!              # Het vorige commando uitvoeren
!ssh            # Het laatste commando dat met "ssh" begint uitvoeren
```

---

## ✏️ De cursor verplaatsen (SUPERhandig)

```bash
Ctrl + a        # Naar het begin van de regel
Ctrl + e        # Naar het eind van de regel
Alt + b         # Eén woord terug
Alt + f         # Eén woord vooruit
Ctrl + x x      # Wisselen tussen begin van de regel en de cursor
```

---

## ✂️ Bewerken en verwijderen

```bash
Ctrl + u        # Verwijderen van cursor → begin
Ctrl + k        # Verwijderen van cursor → eind
Ctrl + w        # Vorige woord verwijderen
Ctrl + d        # Teken onder de cursor verwijderen
Ctrl + h        # Teken vóór de cursor verwijderen (backspace)

Ctrl + y        # Laatst verwijderde tekst plakken (yank)
```

---

## 🧹 Scherm leegmaken / resetten

```bash
Ctrl + l        # Scherm leegmaken (hetzelfde als 'clear')
clear           # Scherm leegmaken
reset           # Terminal volledig resetten (voor een kapotte terminal)
```

---

## ⏸️ Processen beheren

```bash
Ctrl + c        # Huidige commando stoppen
Ctrl + z        # Pauzeren (naar de achtergrond)

fg              # Terughalen naar de voorgrond
bg              # Op de achtergrond verder laten lopen
jobs            # Achtergrondjobs tonen
```

---

## 📁 Navigeren en basis

```bash
cd -            # Naar de vorige map
pwd             # Huidige map tonen
ls -lah         # Bestanden tonen (uitgebreid + leesbare groottes)

tree            # Mappenstructuur tonen (als het geïnstalleerd is)
```

---

## ⚡ Handige sneltoetsen

```bash
Tab             # Bestanden/commando's automatisch aanvullen
Tab Tab         # Alle mogelijkheden tonen

Ctrl + p        # Vorig commando (zoals ↑)
Ctrl + n        # Volgend commando (zoals ↓)
```

---

## 🧠 Pro-tips

```bash
sudo !!         # Het vorige commando opnieuw uitvoeren met sudo

!$              # Laatste argument van het vorige commando
# voorbeeld:
mkdir test
cd !$           # gaat naar test

^oud^nieuw      # Tekst in het vorige commando vervangen
# voorbeeld:
ls /var/logg
^logg^log       # verbetert de typfout
```

---

## 🧼 Geschiedenis wissen (pas op 😄)

```bash
history -c      # Geschiedenis van de huidige sessie wissen
history -w      # Wijzigingen naar ~/.bash_history schrijven
```

---

## 🔧 Bonus (zsh / oh-my-zsh)

```bash
Ctrl + r        # Zoeken in de geschiedenis

# Installeer fzf voor nog beter zoeken:
# Ctrl + r wordt dan een interactieve fuzzy search
```
