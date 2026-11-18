---
title: "Create colored alert boxes in Markdown (MD)"
date: 2022-09-09
description: "How to create coloured alert, error, warning, success and note boxes in Markdown with pandoc."
author:
  - Benjamin Italiaander
keywords:
    - pandoc
    - pandoc goodies
    - html5
    - github-style
    - markdown
---

*🇳🇱 [Lees deze pagina in het Nederlands](create_colored_alertboxes_in_markdown_nl.md)*

Alert boxes in pandoc-goodies or easy-pandoc-templates.

**UPDATE**: my [addup](addup.md) has been [committed by Ryan Rose](https://github.com/ryangrose/easy-pandoc-templates/commit/337d251bdc5c3577ebf8f128e418f6428398fb46), so the easy-pandoc-templates now support alert boxes.

My current favourite is [easy-pandoc-templates](https://github.com/ryangrose/easy-pandoc-templates).

I was struggling to make alert boxes in Markdown (MD), so here is how to create them.

It doesn't feel as easy as plain Markdown, but just copy and paste if you like this style. It's used with [pandoc-goodies](https://github.com/tajmone/pandoc-goodies).

### Alert box
**Alert!**  --- Alert box in blue

```markdown
**Alert!**  --- Alert box in blue
```

### Error box
**Error!**  --- Error box in red

```markdown
**Error!**  --- Error box in red
```

### Warning box
**Warning!**  --- Warning box in yellow

```markdown
**Warning!**  --- Warning box in yellow
```

### Success box
**Success!**  --- Success box in green

```markdown
**Success!**  --- Success box in green
```

### Note box
**Note!**  --- Note box in grey

```markdown
**Note!**  --- Note box in grey
```

## Build this page by cloning and running pandoc
To build this page, I ran pandoc on [this file](https://italiaander.net/docs/markdown/index.md):
```bash
git clone https://github.com/tajmone/pandoc-goodies
pandoc --template=/folders-to/pandoc-goodies/templates/html5/github/GitHub.html5 --self-contained ./index.md -o index.html
```
