---
title: "Interesting Markdown links"
author: Benjamin Italiaander
date: "2022-10-28"
subject: "Markdown"
keywords: Markdown
lang: "nl"
colorlinks: true

header-left: "\\hspace{1cm}"
header-center: "\\leftmark"
header-right: "Pagina \\thepage"
footer-left: "\\thetitle"
footer-center: ""
footer-right: "\\theauthor"



header-includes:



- |
  ```{=latex}

  \usepackage{tcolorbox}
  \usepackage{awesomebox}
  \newtcolorbox{info-box}{colback=cyan!5!white,arc=0pt,outer arc=0pt,colframe=cyan!60!black}
  \newtcolorbox{warning-box}{colback=orange!5!white,arc=0pt,outer arc=0pt,colframe=orange!80!black}
  \newtcolorbox{error-box}{colback=red!5!white,arc=0pt,outer arc=0pt,colframe=red!75!black}




  ```


pandoc-latex-environment:
  tcolorbox: [box]
  info-box: [info]
  warning-box: [warning]
  error-box: [error]
  noteblock: [note]
  tipblock: [tip]
  warningblock: [warning]
  cautionblock: [caution]
  importantblock: [important]



...



::: box
[**Markdown Cheatsheet**](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
:::

