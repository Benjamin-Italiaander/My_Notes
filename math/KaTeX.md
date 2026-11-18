---
title: "KaTeX"
date: 2016-08-28
description: "Reminders for writing fractions, aligned equations and brackets with KaTeX."
math: true
---

*🇳🇱 [Lees deze pagina in het Nederlands](KaTeX_nl.md)*

Just a reminder of how to write formulas.

A simple fraction:

```latex
\frac{4+b}{b-2}
```

$$\frac{4+b}{b-2}$$

Aligned lines:

```latex
\begin{aligned}
& a_{ijk} = 2 \\
& \text{because } \|V_1 - V_2\| = \max_{i \in [d]} |V^i_1 - V^i_2|
\end{aligned}
```

$$\begin{aligned}
& a_{ijk} = 2 \\
& \text{because } \|V_1 - V_2\| = \max_{i \in [d]} |V^i_1 - V^i_2|
\end{aligned}$$

Brackets that grow with their content:

```latex
\left( \frac{4+b}{b-2} \right)
```

$$\left( \frac{4+b}{b-2} \right)$$

Inline formulas go between `\\(` and `\\)`, for example \\( a^2 + b^2 = c^2 \\).

Also have a look at:
- [LaTeX/Mathematics on Wikibooks](https://en.wikibooks.org/wiki/LaTeX/Mathematics)
- [Functions supported by KaTeX](https://katex.org/docs/supported.html)
- [My KaTeX function list](KaTeX_function_list.md)
