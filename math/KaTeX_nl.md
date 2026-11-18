---
title: "KaTeX"
date: 2025-11-18
description: "Geheugensteuntjes voor breuken, uitgelijnde vergelijkingen en haakjes in KaTeX."
math: true
translated_by_ai: true
translated_from: "en"
original: "KaTeX.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](KaTeX.md).*

Even een geheugensteuntje voor het schrijven van formules.

Een eenvoudige breuk:

```latex
\frac{4+b}{b-2}
```

$$\frac{4+b}{b-2}$$

Uitgelijnde regels:

```latex
\begin{aligned}
& a_{ijk} = 2 \\
& \text{omdat } \|V_1 - V_2\| = \max_{i \in [d]} |V^i_1 - V^i_2|
\end{aligned}
```

$$\begin{aligned}
& a_{ijk} = 2 \\
& \text{omdat } \|V_1 - V_2\| = \max_{i \in [d]} |V^i_1 - V^i_2|
\end{aligned}$$

Haakjes die meegroeien met de inhoud:

```latex
\left( \frac{4+b}{b-2} \right)
```

$$\left( \frac{4+b}{b-2} \right)$$

Formules in de lopende tekst zet je tussen `\\(` en `\\)`, bijvoorbeeld \\( a^2 + b^2 = c^2 \\).

Kijk ook eens naar:
- [LaTeX/Mathematics op Wikibooks](https://en.wikibooks.org/wiki/LaTeX/Mathematics) (Engels)
- [Functies die KaTeX ondersteunt](https://katex.org/docs/supported.html) (Engels)
- [Mijn KaTeX-functielijst](KaTeX_function_list_nl.md)
