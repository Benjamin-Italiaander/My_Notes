---
title: "Gekleurde meldingsvakken maken in Markdown"
date: 2025-11-18
description: "Zo maak je gekleurde meldings-, fout-, waarschuwings-, succes- en notitievakken in Markdown met pandoc."
translated_by_ai: true
translated_from: "en"
original: "create_colored_alertboxes_in_markdown.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](create_colored_alertboxes_in_markdown.md).*

Meldingsvakken in pandoc-goodies of easy-pandoc-templates.

**UPDATE**: mijn [aanvulling](addup_nl.md) is [door Ryan Rose overgenomen](https://github.com/ryangrose/easy-pandoc-templates/commit/337d251bdc5c3577ebf8f128e418f6428398fb46), dus easy-pandoc-templates ondersteunt nu meldingsvakken.

Mijn huidige favoriet is [easy-pandoc-templates](https://github.com/ryangrose/easy-pandoc-templates).

Ik had moeite om meldingsvakken te maken in Markdown (MD), dus hier staat hoe het moet.

Het voelt niet zo eenvoudig als gewone Markdown, maar kopieer en plak het gewoon als je deze stijl mooi vindt. Het wordt gebruikt met [pandoc-goodies](https://github.com/tajmone/pandoc-goodies).

### Meldingsvak
**Alert!**  --- Meldingsvak in blauw

```markdown
**Alert!**  --- Alert box in blue
```

### Foutvak
**Error!**  --- Foutvak in rood

```markdown
**Error!**  --- Error box in red
```

### Waarschuwingsvak
**Warning!**  --- Waarschuwingsvak in geel

```markdown
**Warning!**  --- Warning box in yellow
```

### Succesvak
**Success!**  --- Succesvak in groen

```markdown
**Success!**  --- Success box in green
```

### Notitievak
**Note!**  --- Notitievak in grijs

```markdown
**Note!**  --- Note box in grey
```

## Deze pagina bouwen door te klonen en pandoc te draaien
Om deze pagina te bouwen, heb ik pandoc gedraaid op [dit bestand](https://italiaander.net/docs/markdown/index.md):
```bash
git clone https://github.com/tajmone/pandoc-goodies
pandoc --template=/folders-to/pandoc-goodies/templates/html5/github/GitHub.html5 --self-contained ./index.md -o index.html
```
