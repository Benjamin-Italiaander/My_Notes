---
title: "Linux CLI Cheatsheet (Daily Use)"
date: 2016-08-07
description: "Daily-use shortcuts for the Linux command line: history search, cursor movement, editing and job control."
---

*🇳🇱 [Lees deze pagina in het Nederlands](cheatsheet_bash_nl.md)*

# 🧠 Linux CLI Cheatsheet (Daily Use)

## 🔎 Search in History
```bash
Ctrl + r        # Reverse search (type to search, keep pressing for older matches)
Ctrl + s        # Forward search (often disabled by default)

history         # Show command history
history | grep ssh   # Search history with grep

!123            # Run command number 123 from history
!!              # Run last command
!ssh            # Run last command starting with "ssh"
```

---

## ✏️ Cursor Movement (SUPER useful)

```bash
Ctrl + a        # Go to beginning of line
Ctrl + e        # Go to end of line
Alt + b         # Move back one word
Alt + f         # Move forward one word
Ctrl + x x      # Jump between start of line and cursor
```

---

## ✂️ Editing & Deleting

```bash
Ctrl + u        # Delete from cursor → start
Ctrl + k        # Delete from cursor → end
Ctrl + w        # Delete previous word
Ctrl + d        # Delete character under cursor
Ctrl + h        # Delete character before cursor (backspace)

Ctrl + y        # Paste last deleted text (yank)
```

---

## 🧹 Clear Screen / Reset

```bash
Ctrl + l        # Clear screen (same as 'clear')
clear           # Clear screen
reset           # Full terminal reset (fix broken terminal)
```

---

## ⏸️ Process Control

```bash
Ctrl + c        # Stop current command
Ctrl + z        # Suspend (background)

fg              # Bring back to foreground
bg              # Resume in background
jobs            # List background jobs
```

---

## 📁 Navigation & Basics

```bash
cd -            # Go to previous directory
pwd             # Show current directory
ls -lah         # List files (detailed + human readable)

tree            # Show directory structure (if installed)
```

---

## ⚡ Handy Shortcuts

```bash
Tab             # Auto-complete files/commands
Tab Tab         # Show all possibilities

Ctrl + p        # Previous command (like ↑)
Ctrl + n        # Next command (like ↓)
```

---

## 🧠 Pro Tips

```bash
sudo !!         # Rerun last command with sudo

!$              # Last argument of previous command
# example:
mkdir test
cd !$           # goes into test

^old^new        # Replace text in last command
# example:
ls /var/logg
^logg^log       # fixes typo
```

---

## 🧼 Clear History (careful 😄)

```bash
history -c      # Clear current session history
history -w      # Write changes to ~/.bash_history
```

---

## 🔧 Bonus (zsh / oh-my-zsh)

```bash
Ctrl + r        # History search

# Install fzf for an even better search:
# Ctrl + r becomes an interactive fuzzy search
```
