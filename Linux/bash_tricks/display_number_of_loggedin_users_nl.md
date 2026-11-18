---
title: "Ingelogde gebruikers tellen"
date: 2025-11-18
description: "Tel het aantal ingelogde gebruikers."
translated_by_ai: true
translated_from: "en"
original: "display_number_of_loggedin_users.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](display_number_of_loggedin_users.md).*

# Het aantal ingelogde gebruikers tonen met het who-commando

Bijhouden hoeveel gebruikers op een systeem zijn ingelogd kan heel handig zijn. Dit korte Bash-commando toont het precieze aantal actieve gebruikers:

```bash
who -q | grep "users=" | sed 's/# users=//g'
```

Wil je het aantal doorlopend en live zien, stuur het dan door `watch`:

```bash
watch "who -q | grep 'users=' | sed 's/# users=//g'"
```
