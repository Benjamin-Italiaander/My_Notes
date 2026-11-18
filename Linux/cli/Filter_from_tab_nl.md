---
title: "Een kolom uit een bestand halen"
date: 2025-11-18
description: "Haal met awk één kolom uit een tekstbestand."
translated_by_ai: true
translated_from: "en"
original: "Filter_from_tab.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](Filter_from_tab.md).*

# Een bepaalde kolom ophalen in de Linux-CLI

Soms wil je op de Linux-commandoregel een bepaalde kolom (of een veld gescheiden door tabs) uit een bestand halen.

### Voorbeeldbestand

Stel dat we een bestand (`file.txt`) hebben met deze inhoud:

```
A  B  C  
D  E  F  
G  H  I  
```

### De eerste kolom ophalen

Om de eerste kolom van elke regel te krijgen, gebruik je `awk`:

```bash
awk '{print $1}' file.txt
```

**Uitvoer:**
```
A  
D  
G  
```

### De tweede kolom ophalen

Voor de tweede kolom pas je het commando aan:

```bash
awk '{print $2}' file.txt
```

**Uitvoer:**
```
B  
E  
H  
```

### `cat` is niet nodig

`cat file | awk ...` is overbodig; `awk` kan het bestand zelf lezen. Gebruik dus altijd:

```bash
awk '{print $N}' file.txt
```

waarbij `N` het nummer is van de kolom die je wilt hebben.

Dit werkt voor bestanden met spaties én met tabs als scheiding. Gebruikt je bestand een ander scheidingsteken (zoals komma's), geef dat dan op met `-F`, bijvoorbeeld:

```bash
awk -F',' '{print $2}' file.txt
```
