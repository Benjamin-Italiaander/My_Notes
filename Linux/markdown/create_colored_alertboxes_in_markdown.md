---
title: "Create colored alertboxes in Markdown (MD)"
author:
  - Benjamin Italiaander
date: 2022-09-09
keywords:
    - pandoc
    - pandoc goodies
    - html5
    - github-style
    - markdown
    
---

Alert boxes in pandoc goodies or easy-pandoc-template


**UPDATE**  --- My [addup](addup.html) has been [commited by Ryan Rose](https://github.com/ryangrose/easy-pandoc-templates/commit/337d251bdc5c3577ebf8f128e418f6428398fb46) so the easy pandoc template now works with alert boxes.

My current favourite is the [easy-pandoc-templates](https://github.com/ryangrose/easy-pandoc-templates). 





I was struggeling with making alertboxes with markdown (MD) 
So here is how to create a Alertbox

It does not feel like the ease of MD but just copy and paste if you like this style. It's used with [pandoc-goodies](https://github.com/tajmone/pandoc-goodies)



### Alert box
**Alert!**  --- Alertbox with 
```markdown
**Alert!**  --- Alertbox with Blue
```




### Error box 
**Error!**  --- Errorbox with red

```markdown
**Error!**  --- Errorbox with red
```


### Warning box 
**Warning!**  --- Warningbox with red

```markdown
**Warning!**  --- Warningbox with yellow
```



### Success box 
**Success!**  --- Successbox with Green

```markdown
**Success!**  --- Successbox with Green 
```






### Note box 
**Note!**  --- Notebox Grey 

```markdown
**Note!**  --- Notebox Grey
```









## Build this page by cloning and running pandoc
In order to build this page ran pandoc using [this file](https://italiaander.net/docs/markdown/index.md)
```bash
git clone https://github.com/tajmone/pandoc-goodies
pandoc  --template=/folders-to/pandoc-goodies/templates/html5/github/GitHub.html5 --self-contained ./index.md -o index.html
```


