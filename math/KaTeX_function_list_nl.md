---
title: "Ondersteunde functies (KaTeX)"
date: 2025-11-18
description: "De volledige lijst met TeX-functies die KaTeX ondersteunt, ingedeeld in logische groepen."
math: true
translated_by_ai: true
translated_from: "en"
original: "KaTeX_function_list.md"
---

> 🤖 *Deze pagina is met AI vertaald uit het Engels. [Lees het origineel in het Engels](KaTeX_function_list.md).* De commando's en voorbeelden zijn niet vertaald. Bron: de officiële [KaTeX-documentatie](https://katex.org/docs/supported.html).

Dit is een lijst met TeX-functies die KaTeX ondersteunt, ingedeeld in logische groepen.

Er is ook een vergelijkbare [ondersteuningstabel](https://katex.org/docs/support_table.html), alfabetisch gesorteerd, met zowel ondersteunde als niet-ondersteunde functies.

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css" integrity="sha384-nB0miv6/jRmo5UMMR1wu3Gz6NLsoTkbqJghGIsx//Rlm+ZU03BU6SQNC66uf4l5+" crossorigin="anonymous">
<style>
p {overflow-wrap: break-word;}
table tr,
table td {
    vertical-align: middle;
    overflow-wrap: break-word;
}
</style>

<div class="katex-hopscotch">

## Accenten {#accents}

||||
|:----------------------------|:----------------------------------------------------|:------
|$a'$ `a'`  |$\tilde{a}$ `\tilde{a}`|$\mathring{g}$ `\mathring{g}`
|$a''$ `a''`|$\widetilde{ac}$ `\widetilde{ac}`  |$\overgroup{AB}$ `\overgroup{AB}`
|$a^{\prime}$ `a^{\prime}` |$\utilde{AB}$ `\utilde{AB}`  |$\undergroup{AB}$ `\undergroup{AB}`
|$\acute{a}$ `\acute{a}`|$\vec{F}$ `\vec{F}` |$\Overrightarrow{AB}$ `\Overrightarrow{AB}`
|$\bar{y}$ `\bar{y}` |$\overleftarrow{AB}$ `\overleftarrow{AB}`|$\overrightarrow{AB}$ `\overrightarrow{AB}`
|$\breve{a}$ `\breve{a}`|$\underleftarrow{AB}$ `\underleftarrow{AB}` |$\underrightarrow{AB}$ `\underrightarrow{AB}`
|$\check{a}$ `\check{a}`|$\overleftharpoon{ac}$ `\overleftharpoon{ac}`  |$\overrightharpoon{ac}$ `\overrightharpoon{ac}`
|$\dot{a}$ `\dot{a}` |$\overleftrightarrow{AB}$ `\overleftrightarrow{AB}`  |$\overbrace{AB}$ `\overbrace{AB}`
|$\ddot{a}$ `\ddot{a}`  |$\underleftrightarrow{AB}$ `\underleftrightarrow{AB}`|$\underbrace{AB}$ `\underbrace{AB}`
|$\grave{a}$ `\grave{a}`|$\overline{AB}$ `\overline{AB}` |$\overlinesegment{AB}$ `\overlinesegment{AB}`
|$\hat{\theta}$ `\hat{\theta}`|$\underline{AB}$ `\underline{AB}`  |$\underlinesegment{AB}$ `\underlinesegment{AB}`
|$\widehat{ac}$ `\widehat{ac}`|$\widecheck{ac}$ `\widecheck{ac}`  |$\underbar{X}$ `\underbar{X}`

***Accentfuncties binnen \\text{…}***

|||||
|:---------------------|:---------------------|:---------------------|:-----
|$\text{\'{a}}$ `\'{a}`|$\text{\~{a}}$ `\~{a}`|$\text{\.{a}}$ `\.{a}`|$\text{\H{a}}$ `\H{a}`
|$\text{\`{a}}$ <code>\\`{a}</code>|$\text{\={a}}$ `\={a}`|$\text{\"{a}}$ `\"{a}`|$\text{\v{a}}$ `\v{a}`
|$\text{\^{a}}$ `\^{a}`|$\text{\u{a}}$ `\u{a}`|$\text{\r{a}}$ `\r{a}`|

Zie ook [letters en Unicode](#letters-and-unicode).

## Scheidingstekens {#delimiters}

||||||
|:-----------------------------------|:---------------------------------------|:----------|:-------------------------------------------------------|:-----
|$(~)$ `( )` |$\lparen~\rparen$ `\lparen`<br>$~~~~$`\rparen`|$⌈~⌉$ `⌈ ⌉`|$\lceil~\rceil$ `\lceil`<br>$~~~~~$`\rceil`  |$\uparrow$ `\uparrow`
|$[~]$ `[ ]` |$\lbrack~\rbrack$ `\lbrack`<br>$~~~~$`\rbrack`|$⌊~⌋$ `⌊ ⌋`|$\lfloor~\rfloor$ `\lfloor`<br>$~~~~~$`\rfloor` |$\downarrow$ `\downarrow`
|$\{ \}$ `\{ \}`|$\lbrace \rbrace$ `\lbrace`<br>$~~~~$`\rbrace`|$⎰⎱$ `⎰⎱`  |$\lmoustache \rmoustache$ `\lmoustache`<br>$~~~~$`\rmoustache`|$\updownarrow$ `\updownarrow`
|$⟨~⟩$ `⟨ ⟩` |$\langle~\rangle$ `\langle`<br>$~~~~$`\rangle`|$⟮~⟯$ `⟮ ⟯`|$\lgroup~\rgroup$ `\lgroup`<br>$~~~~~$`\rgroup` |$\Uparrow$ `\Uparrow`
|$\vert$ <code>&#124;</code> |$\vert$ `\vert` |$┌ ┐$ `┌ ┐`|$\ulcorner \urcorner$ `\ulcorner`<br>$~~~~$`\urcorner`  |$\Downarrow$ `\Downarrow`
|$\Vert$ <code>&#92;&#124;</code> |$\Vert$ `\Vert` |$└ ┘$ `└ ┘`|$\llcorner \lrcorner$ `\llcorner`<br>$~~~~$`\lrcorner`  |$\Updownarrow$ `\Updownarrow`
|$\lvert~\rvert$ `\lvert`<br>$~~~~$`\rvert`|$\lVert~\rVert$ `\lVert`<br>$~~~~~$`\rVert` |`\left.`|  `\right.` |$\backslash$ `\backslash`
|$\lang~\rang$ `\lang`<br>$~~~~$`\rang`|$\lt~\gt$ `\lt \gt`|$⟦~⟧$ `⟦ ⟧`|$\llbracket~\rrbracket$ `\llbracket`<br>$~~~~$`\rrbracket`|$\lBrace~\rBrace$ `\lBrace \rBrace`

**Grootte van scheidingstekens**

$\left(\LARGE{AB}\right)$ `\left(\LARGE{AB}\right)`

$( \big( \Big( \bigg( \Bigg($ `( \big( \Big( \bigg( \Bigg(`

||||||
|:--------|:------|:--------|:-------|:------|
|`\left`  |`\big` |`\bigl`  |`\bigm` |`\bigr`
|`\middle`|`\Big` |`\Bigl`  |`\Bigm` | `\Bigr`
|`\right` |`\bigg`|`\biggl` |`\biggm`|`\biggr`
|         |`\Bigg`|`\Biggl` |`\Biggm`|`\Biggr`

</div>

## Omgevingen {#environments}

<div class="katex-cards" id="environments">

|||||
|:---------------------|:---------------------|:---------------------|:--------
|$\begin{matrix} a & b \\ c & d \end{matrix}$ | `\begin{matrix}`<br>&nbsp;&nbsp;&nbsp;`a & b \\`<br>&nbsp;&nbsp;&nbsp;`c & d`<br>`\end{matrix}` |$\begin{array}{cc}a & b\\c & d\end{array}$ | `\begin{array}{cc}`<br>&nbsp;&nbsp;&nbsp;`a & b \\`<br>&nbsp;&nbsp;&nbsp;`c & d`<br>`\end{array}`
|$\begin{pmatrix} a & b \\ c & d \end{pmatrix}$ |`\begin{pmatrix}`<br>&nbsp;&nbsp;&nbsp;`a & b \\`<br>&nbsp;&nbsp;&nbsp;`c & d`<br>`\end{pmatrix}` |$\begin{bmatrix} a & b \\ c & d \end{bmatrix}$ | `\begin{bmatrix}`<br>&nbsp;&nbsp;&nbsp;`a & b \\`<br>&nbsp;&nbsp;&nbsp;`c & d`<br>`\end{bmatrix}`
|$\begin{vmatrix} a & b \\ c & d \end{vmatrix}$ |`\begin{vmatrix}`<br>&nbsp;&nbsp;&nbsp;`a & b \\`<br>&nbsp;&nbsp;&nbsp;`c & d`<br>`\end{vmatrix}` |$\begin{Vmatrix} a & b \\ c & d \end{Vmatrix}$ |`\begin{Vmatrix}`<br>&nbsp;&nbsp;&nbsp;`a & b \\`<br>&nbsp;&nbsp;&nbsp;`c & d`<br>`\end{Vmatrix}`
|$\begin{Bmatrix} a & b \\ c & d \end{Bmatrix}$ |`\begin{Bmatrix}`<br>&nbsp;&nbsp;&nbsp;`a & b \\`<br>&nbsp;&nbsp;&nbsp;`c & d`<br>`\end{Bmatrix}`|$\def\arraystretch{1.5}\begin{array}{c:c:c} a & b & c \\ \hline d & e & f \\ \hdashline g & h & i \end{array}$|`\def\arraystretch{1.5}`<br>&nbsp;&nbsp;&nbsp;`\begin{array}{c:c:c}`<br>&nbsp;&nbsp;&nbsp;`a & b & c \\ \hline`<br>&nbsp;&nbsp;&nbsp;`d & e & f \\`<br>&nbsp;&nbsp;&nbsp;`\hdashline`<br>&nbsp;&nbsp;&nbsp;`g & h & i`<br>`\end{array}`
|$x = \begin{cases} a &\text{if } b \\ c &\text{if } d \end{cases}$ |`x = \begin{cases}`<br>&nbsp;&nbsp;&nbsp;`a &\text{if } b  \\`<br>&nbsp;&nbsp;&nbsp;`c &\text{if } d`<br>`\end{cases}`|$\begin{rcases} a &\text{if } b \\ c &\text{if } d \end{rcases}⇒…$ |`\begin{rcases}`<br>&nbsp;&nbsp;&nbsp;`a &\text{if } b  \\`<br>&nbsp;&nbsp;&nbsp;`c &\text{if } d`<br>`\end{rcases}⇒…`|
|$\begin{smallmatrix} a & b \\ c & d \end{smallmatrix}$ | `\begin{smallmatrix}`<br>&nbsp;&nbsp;&nbsp;`a & b \\`<br>&nbsp;&nbsp;&nbsp;`c & d`<br>`\end{smallmatrix}` |$$\sum_{\begin{subarray}{l} i\in\Lambda\\  0<j<n\end{subarray}}$$ | `\sum_{`<br>`\begin{subarray}{l}`<br>&nbsp;&nbsp;&nbsp;`i\in\Lambda\\`<br>&nbsp;&nbsp;&nbsp;`0<j<n`<br>`\end{subarray}}`|

De auto-render-extensie geeft de volgende omgevingen weer, ook als ze niet tussen wiskundescheidingstekens zoals `$$…$$` staan. Ze werken alleen in display-modus.

<style>
  #env + table tr td:nth-child(1) { min-width: 11em }
  #env + table tr td:nth-child(3) { min-width: 13em }
</style>
<div id="env"></div>

|||||
|:---------------------|:---------------------|:---------------------|:--------
|$$\begin{equation}\begin{split}a &=b+c\\&=e+f\end{split}\end{equation}$$ |`\begin{equation}`<br>`\begin{split}`&nbsp;&nbsp;&nbsp;`a &=b+c\\`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`&=e+f`<br>`\end{split}`<br>`\end{equation}` |$$\begin{align} a&=b+c \\ d+e&=f \end{align}$$ |`\begin{align}`<br>&nbsp;&nbsp;&nbsp;`a&=b+c \\`<br>&nbsp;&nbsp;&nbsp;`d+e&=f`<br>`\end{align}` |
|$$\begin{gather} a=b \\ e=b+c \end{gather}$$ |`\begin{gather}`<br>&nbsp;&nbsp;&nbsp;`a=b \\ `<br>&nbsp;&nbsp;&nbsp;`e=b+c`<br>`\end{gather}`|$$\begin{alignat}{2}10&x+&3&y=2\\3&x+&13&y=4\end{alignat}$$ | `\begin{alignat}{2}`<br>&nbsp;&nbsp;&nbsp;`10&x+&3&y=2\\`<br>&nbsp;&nbsp;&nbsp;`3&x+&13&y=4`<br>`\end{alignat}`
|$$\begin{CD}A @>a>> B \\@VbVV @AAcA\\C @= D\end{CD}$$ | `\begin{CD}`<br>&nbsp;&nbsp;&nbsp;`A  @>a>>  B  \\`<br>`@VbVV    @AAcA \\`<br>&nbsp;&nbsp;&nbsp;`C  @=   D`<br>`\end{CD}`

#### Andere KaTeX-omgevingen

| Environments | How they differ from those shown above |
|:-----------------------------------------------|:------------------|
| `darray`, `dcases`, `drcases`                  | … apply `displaystyle` |
| `matrix*`, `pmatrix*`, `bmatrix*`<br>`Bmatrix*`, `vmatrix*`, `Vmatrix*` | … take an optional argument to set column<br>alignment, as in `\begin{matrix*}[r]`
| `equation*`, `gather*`<br>`align*`, `alignat*` | … have no automatic numbering. Alternatively, you can use `\nonumber` or `\notag` to omit the numbering for a specific row of the equation. |
| `gathered`, `aligned`, `alignedat`             | … do not need to be in display mode.<br> … have no automatic numbering.<br> … must be inside math delimiters in<br>order to be rendered by the auto-render<br>extension. |

</div>

Geldige regelscheidingen zijn onder andere: `\\`, `\cr`, `\\[distance]` en `\cr[distance]`. *Distance* (afstand) kan in elk van de [KaTeX-eenheden](#units) worden geschreven.

De `{array}`-omgeving ondersteunt `|` en `:` als verticale scheidingslijnen.

De `{array}`-omgeving ondersteunt `\cline` en `\multicolumn` nog niet.

`\tag` kan worden toegepast op afzonderlijke rijen van omgevingen op het hoogste niveau
(`align`, `align*`, `alignat`, `alignat*`, `gather`, `gather*`).

<div class="katex-hopscotch">

## HTML {#html}

De volgende “ruwe HTML”-functies zijn mogelijk gevaarlijk bij niet-vertrouwde
invoer. Daarom staan ze standaard uit, en als je ze toch gebruikt, verschijnen
de commandonamen in het rood (dit kun je instellen met de `errorColor`-
[optie](https://katex.org/docs/options.html)). Om je LaTeX-invoer volledig te vertrouwen, geef je
de optie `trust: true` mee; je kunt ook alleen een deel van de commando's toestaan,
of alleen voor bepaalde URL's, met de `trust`-[optie](https://katex.org/docs/options.html).

|||
|:----------------|:-------------------|
| $\href{https://katex.org/}{\KaTeX}$ | `\href{https://katex.org/}{\KaTeX}` |
| $\url{https://katex.org/}$ | `\url{https://katex.org/}` |
| $\includegraphics[height=0.8em, totalheight=0.9em, width=0.9em, alt=KA logo]{https://katex.org/img/khan-academy.png}$ | `\includegraphics[height=0.8em, totalheight=0.9em, width=0.9em, alt=KA logo]{https://katex.org/img/khan-academy.png}` |
| $\htmlId{bar}{x}$ <code>…&lt;span id="bar" class="enclosing"&gt;…x…&lt;/span&gt;…</code> | `\htmlId{bar}{x}` |
| $\htmlClass{foo}{x}$ <code>…&lt;span class="enclosing foo"&gt;…x…&lt;/span&gt;…</code> | `\htmlClass{foo}{x}` |
| $\htmlStyle{color: red;}{x}$ <code>…&lt;span style="color: red;" class="enclosing"&gt;…x…&lt;/span&gt;…</code> | `\htmlStyle{color: red;}{x}` |
| $\htmlData{foo=a, bar=b}{x}$ <code>…&lt;span data-foo="a" data-bar="b" class="enclosing"&gt;…x…&lt;/span&gt;…</code> | `\htmlData{foo=a, bar=b}{x}` |

`\includegraphics` ondersteunt `height`, `width`, `totalheight` en `alt` in het eerste argument. `height` is verplicht.

HTML-extensiecommando's (beginnend met `\html`) zijn niet standaard; daarvoor moet je de `strict`-optie voor `htmlExtension` versoepelen.


## Letters en Unicode {#letters-and-unicode}

**Griekse letters**

Direct Input: $Α Β Γ Δ Ε Ζ Η Θ Ι \allowbreak Κ Λ Μ Ν Ξ Ο Π Ρ Σ Τ Υ Φ Χ Ψ Ω$
$\allowbreak α β γ δ ϵ ζ η θ ι κ λ μ ν ξ o π \allowbreak ρ σ τ υ ϕ χ ψ ω ε ϑ ϖ ϱ ς φ ϝ$

|||||
|---------------|-------------|-------------|---------------|
| $\Alpha$ `\Alpha` | $\Beta$ `\Beta` | $\Gamma$ `\Gamma`| $\Delta$ `\Delta`
| $\Epsilon$ `\Epsilon` | $\Zeta$ `\Zeta` | $\Eta$ `\Eta` | $\Theta$ `\Theta`
| $\Iota$ `\Iota` | $\Kappa$ `\Kappa` | $\Lambda$ `\Lambda` | $\Mu$ `\Mu`
| $\Nu$ `\Nu` | $\Xi$ `\Xi` | $\Omicron$ `\Omicron` | $\Pi$ `\Pi`
| $\Rho$ `\Rho` | $\Sigma$ `\Sigma` | $\Tau$ `\Tau` | $\Upsilon$ `\Upsilon`
| $\Phi$ `\Phi` | $\Chi$ `\Chi` | $\Psi$ `\Psi` | $\Omega$ `\Omega`
| $\varGamma$ `\varGamma`| $\varDelta$ `\varDelta` | $\varTheta$ `\varTheta` | $\varLambda$ `\varLambda`  |
| $\varXi$ `\varXi`| $\varPi$ `\varPi` | $\varSigma$ `\varSigma` | $\varUpsilon$ `\varUpsilon` |
| $\varPhi$ `\varPhi`  | $\varPsi$ `\varPsi`| $\varOmega$ `\varOmega` ||
| $\alpha$ `\alpha`| $\beta$ `\beta`  | $\gamma$ `\gamma` | $\delta$ `\delta`|
| $\epsilon$ `\epsilon` | $\zeta$ `\zeta`  | $\eta$ `\eta`| $\theta$ `\theta`|
| $\iota$ `\iota` | $\kappa$ `\kappa` | $\lambda$ `\lambda`| $\mu$ `\mu`|
| $\nu$ `\nu`| $\xi$ `\xi` | $\omicron$ `\omicron`  | $\pi$ `\pi`|
| $\rho$ `\rho`  | $\sigma$ `\sigma` | $\tau$ `\tau`| $\upsilon$ `\upsilon` |
| $\phi$ `\phi`  | $\chi$ `\chi`| $\psi$ `\psi`| $\omega$ `\omega`|
| $\varepsilon$ `\varepsilon` | $\varkappa$ `\varkappa` | $\vartheta$ `\vartheta` | $\thetasym$ `\thetasym`
| $\varpi$ `\varpi`| $\varrho$ `\varrho`  | $\varsigma$ `\varsigma` | $\varphi$ `\varphi`
| $\digamma $ `\digamma`

**Andere letters**

||||||
|:----------|:----------|:----------|:----------|:----------|
|$\imath$ `\imath`|$\nabla$ `\nabla`|$\Im$ `\Im`|$\Reals$ `\Reals`|$\text{\OE}$ `\text{\OE}`
|$\jmath$ `\jmath`|$\partial$ `\partial`|$\image$ `\image`|$\wp$ `\wp`|$\text{\o}$ `\text{\o}`
|$\aleph$ `\aleph`|$\Game$ `\Game`|$\Bbbk$ `\Bbbk`|$\weierp$ `\weierp`|$\text{\O}$ `\text{\O}`
|$\alef$ `\alef`|$\Finv$ `\Finv`|$\N$ `\N`|$\Z$ `\Z`|$\text{\ss}$ `\text{\ss}`
|$\alefsym$ `\alefsym`|$\cnums$ `\cnums`|$\natnums$ `\natnums`|$\text{\aa}$ `\text{\aa}`|$\text{\i}$ `\text{\i}`
|$\beth$ `\beth`|$\Complex$ `\Complex`|$\R$ `\R`|$\text{\AA}$ `\text{\AA}`|$\text{\j}$ `\text{\j}`
|$\gimel$ `\gimel`|$\ell$ `\ell`|$\Re$ `\Re`|$\text{\ae}$ `\text{\ae}`
|$\daleth$ `\daleth`|$\hbar$ `\hbar`|$\real$ `\real`|$\text{\AE}$ `\text{\AE}`
|$\eth$ `\eth`|$\hslash$ `\hslash`|$\reals$ `\reals`|$\text{\oe}$ `\text{\oe}`

Direct Input: $∂ ∇ ℑ Ⅎ ℵ ℶ ℷ ℸ ⅁ ℏ ð − ∗$
ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖÙÚÛÜÝÞßàáâãäåçèéêëìíîïðñòóôöùúûüýþÿ
₊₋₌₍₎₀₁₂₃₄₅₆₇₈₉ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓᵦᵧᵨᵩᵪ⁺⁻⁼⁽⁾⁰¹²³⁴⁵⁶⁷⁸⁹ᵃᵇᶜᵈᵉᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘʷˣʸᶻᵛᵝᵞᵟᵠᵡ

Unicode-tekens voor sub- en superscript in wiskundemodus worden weergegeven alsof je gewone tekens in een sub- of superscript had geschreven. `A²⁺³` wordt bijvoorbeeld hetzelfde weergegeven als `A^{2+3}`.

</div>
<div class="katex-cards" id="math-alpha">

**Unicode wiskundige alfanumerieke symbolen**

| Item        |  Range              |  Item             |  Range  |
|-------------|---------------------|-------------------|---------------|
| Bold        | $\text{𝐀-𝐙 𝐚-𝐳 𝟎-𝟗}$  | Double-struck     | $\text{𝔸-}ℤ\ 𝕜$
| Italic      | $\text{𝐴-𝑍 𝑎-𝑧}$      | Sans serif        | $\text{𝖠-𝖹 𝖺-𝗓 𝟢-𝟫}$
| Bold Italic | $\text{𝑨-𝒁 𝒂-𝒛}$      | Sans serif bold   | $\text{𝗔-𝗭 𝗮-𝘇 𝟬-𝟵}$
| Script      | $\text{𝒜-𝒵}$         | Sans serif italic | $\text{𝘈-𝘡 𝘢-𝘻}$
| Fraktur     | $\text{$𝔄$-$ℨ$}\text{ $𝔞$-$𝔷$}$| Monospace        | $\text{𝙰-𝚉 𝚊-𝚣 𝟶-𝟿}$
| Bold Fraktur | $\text{𝕬-𝖅 𝖆-𝖟}$ | |

</div>
<div class="katex-hopscotch">

**Unicode**

De letters hierboven worden in elke KaTeX-weergavemodus goed weergegeven.

Daarnaast worden Armeense, Brahmi-, Georgische, Chinese, Japanse en Koreaanse tekens altijd geaccepteerd in tekstmodus. Ze worden wel weergegeven met systeemlettertypen (niet met de lettertypen van KaTeX), dus de typografie kan afwijken.
Met regels voor de CSS-klassen `.latin_fallback`, `.cyrillic_fallback`, `.brahmic_fallback`, `.georgian_fallback`, `.cjk_fallback` en `.hangul_fallback` kun je reservelettertypen voor deze talen instellen.
Deze tekens kunnen kleine problemen met de verticale uitlijning geven: KaTeX heeft gedetailleerde maten voor de genoemde symbolen en de meeste Latijnse, Griekse en Cyrillische letters, maar andere geaccepteerde tekens worden behandeld alsof ze even hoog zijn als de letter M in het huidige KaTeX-lettertype.

Als de KaTeX-weergavemodus op `strict: false` of `strict: "warn"` (standaard) staat, accepteert KaTeX alle Unicode-letters in zowel tekst- als wiskundemodus.
Alle onbekende tekens worden behandeld alsof ze in tekstmodus staan, met dezelfde nadelen: systeemlettertypen en mogelijk een onjuiste verticale uitlijning.

Voor Perzische samengestelde tekens wordt een [plug-in](https://github.com/HosseinAgha/persian-katex-plugin) door gebruikers ontwikkeld.

Elk teken kun je schrijven met de functie `\char` en de Unicode-code in hexadecimaal. `\char"263a` wordt bijvoorbeeld weergegeven als $\char"263a$.

## Opmaak {#layout}

### Annotatie {#annotation}

|||
|:------------------------------|:-----
|$\cancel{5}$ `\cancel{5}`|$\overbrace{a+b+c}^{\text{note}}$ `\overbrace{a+b+c}^{\text{note}}`
|$\bcancel{5}$ `\bcancel{5}` |$\underbrace{a+b+c}_{\text{note}}$ `\underbrace{a+b+c}_{\text{note}}`
|$\xcancel{ABC}$ `\xcancel{ABC}`|$\not =$ `\not =`
|$\sout{abc}$ `\sout{abc}`|$\boxed{\pi=\frac c d}$ `\boxed{\pi=\frac c d}`
|$a_{\angl n}$ `$a_{\angl n}`|$a_\angln$ `a_\angln`
|$\phase{-78^\circ}$`\phase{-78^\circ}` |

`\tag{hi} x+y^{2x}`
$$\tag{hi} x+y^{2x}$$

`\tag*{hi} x+y^{2x}`
$$\tag*{hi} x+y^{2x}$$

### Regeleinden {#line-breaks}

KaTeX 0.10.0+ voegt in inline wiskunde automatisch regeleinden in na relaties of binaire operatoren zoals “=” of “+”. Dat kun je voorkomen met `\nobreak` of door de formule tussen accolades te zetten, zoals `{F=ma}`. Met `\allowbreak` sta je automatische regeleinden toe op andere plekken dan na relaties of operatoren.

Harde regeleinden zijn `\\` en `\newline`.

In display-wiskunde voegt KaTeX geen automatische regeleinden in. Harde regeleinden in display-wiskunde worden genegeerd bij de weergaveoptie `strict: true`.

### Verticale opmaak {#vertical-layout}

||||
|:--------------|:----------------------------------------|:-----
|$x_n$ `x_n` |$\stackrel{!}{=}$ `\stackrel{!}{=}`| $a \atop b$ `a \atop b`
|$e^x$ `e^x` |$\overset{!}{=}$ `\overset{!}{=}`  | $a\raisebox{0.25em}{$b$}c$ `a\raisebox{0.25em}{$b$}c`
|$_u^o $ `_u^o `| $\underset{!}{=}$ `\underset{!}{=}` | $a+\left(\vcenter{\frac{\frac a b}c}\right)$ `a+\left(\vcenter{\hbox{$\frac{\frac a b}c$}}\right)`
||| $$\sum_{\substack{0<i<m\\0<j<n}}$$ `\sum_{\substack{0<i<m\\0<j<n}}`

`\raisebox` en `\hbox` zetten hun argument in tekstmodus. Om wiskunde te verhogen, zet je `$…$` binnen het argument, zoals hierboven.

`\vcenter` kun je zonder `\hbox` schrijven als de weergaveoptie `strict` op *false* staat. Laat in dat geval de geneste `$…$` weg.

### Overlap en witruimte {#overlap-and-spacing}

|||
|:-------|:-------|
|${=}\mathllap{/\,}$ `{=}\mathllap{/\,}` | $\left(x^{\smash{2}}\right)$ `\left(x^{\smash{2}}\right)`
|$\mathrlap{\,/}{=}$ `\mathrlap{\,/}{=}` | $\sqrt{\smash[b]{y}}$ `\sqrt{\smash[b]{y}} `

$\displaystyle\sum_{\mathclap{1\le i\le j\le n}} x_{ij}$ `\sum_{\mathclap{1\le i\le j\le n}} x_{ij}`

KaTeX ondersteunt ook `\llap`, `\rlap` en `\clap`, maar die accepteren alleen tekst als argument, geen wiskunde.

</div>
<div class="katex-cards" id="spacing-tbl">

**Witruimte**

| Function        | Produces           | Function             | Produces|
|:----------------|:-------------------|:---------------------|:--------------------------------------|
| `\,`            | ³∕₁₈ em space      | `\kern{distance}`    | space, width = *distance*
| `\thinspace`    | ³∕₁₈ em space      | `\mkern{distance}`   | space, width = *distance*
| `\>`            | ⁴∕₁₈ em space      | `\mskip{distance}`   | space, width = *distance*
| `\:`            | ⁴∕₁₈ em space      | `\hskip{distance}`   | space, width = *distance*
| `\medspace`     | ⁴∕₁₈ em space      | `\hspace{distance}`  | space, width = *distance*
| `\;`            | ⁵∕₁₈ em space      | `\hspace*{distance}` | space, width = *distance*
| `\thickspace`   | ⁵∕₁₈ em space      | `\phantom{content}`  | space the width and height of content
| `\enspace`      | ½ em space         | `\hphantom{content}` | space the width of content
| `\quad`         | 1 em space         | `\vphantom{content}` | a strut the height of content
| `\qquad`        | 2 em space         | `\!`                 | – ³∕₁₈ em space
| `~`             | non-breaking space | `\negthinspace`      | – ³∕₁₈ em space
| `\<space>`      | space              | `\negmedspace`       | – ⁴∕₁₈ em space
| `\nobreakspace` | non-breaking space | `\negthickspace`     | – ⁵∕₁₈ em space
| `\space`        | space              | `\mathstrut`         | `\vphantom{(}`

</div>

**Opmerkingen:**

`distance` accepteert elk van de [KaTeX-eenheden](#units).

`\kern`, `\mkern`, `\mskip` en `\hspace` accepteren afstanden zonder accolades, zoals in: `\kern1em`.

`\mkern` en `\mskip` werken niet in tekstmodus, en geven allebei een consolewaarschuwing bij elke eenheid behalve `mu`.

<div class="katex-hopscotch">

## Logica en verzamelingenleer {#logic-and-set-theory}

$\gdef\VERT{|}$

|||||
|:--------------------|:--------------------------|:----------------------------|:-----
|$\forall$ `\forall`  |$\complement$ `\complement`|$\therefore$ `\therefore`    |$\emptyset$ `\emptyset`
|$\exists$ `\exists`  |$\subset$ `\subset`  |$\because$ `\because`              |$\empty$ `\empty`
|$\exist$ `\exist`    |$\supset$ `\supset`  |$\mapsto$ `\mapsto`                |$\varnothing$ `\varnothing`
|$\nexists$ `\nexists`|$\mid$ `\mid`        |$\to$ `\to`                        |$\implies$ `\implies`
|$\in$ `\in`          |$\land$ `\land`      |$\gets$ `\gets`                    |$\impliedby$ `\impliedby`
|$\isin$ `\isin`      |$\lor$ `\lor`        |$\leftrightarrow$ `\leftrightarrow`|$\iff$ `\iff`
|$\notin$ `\notin`    |$\ni$ `\ni`          |$\notni$ `\notni`                  |$\neg$ `\neg` or `\lnot`
|   | $\Set{ x \VERT x<\frac 1 2 }$<br><code>\Set{ x &#124; x<\frac 1 2 }</code>  | $\set{x\VERT x<5}$<br><code>\set{x&#124;x<5}</code> ||

Direct Input: $∀ ∴ ∁ ∵ ∃ ∣ ∈ ∉ ∋ ⊂ ⊃ ∧ ∨ ↦ → ← ↔ ¬$ ℂ ℍ ℕ ℙ ℚ ℝ

## Macro's {#macros}

|||
|:-------------------------------------|:------
|$\def\foo{x^2} \foo + \foo$           | `\def\foo{x^2} \foo + \foo`
|$\gdef\foo#1{#1^2} \foo{y} + \foo{y}$ | `\gdef\foo#1{#1^2} \foo{y} + \foo{y}`
|                                      | `\edef\macroname#1#2…{definition to be expanded}`
|                                      | `\xdef\macroname#1#2…{definition to be expanded}`
|                                      | `\let\foo=\bar`
|                                      | `\futurelet\foo\bar x`
|                                      | `\global\def\macroname#1#2…{definition}`
|                                      | `\newcommand\macroname[numargs]{definition}`
|                                      | `\renewcommand\macroname[numargs]{definition}`
|                                      | `\providecommand\macroname[numargs]{definition}`

Macro's kun je ook definiëren in de KaTeX-[weergaveopties](https://katex.org/docs/options.html).

Macro's accepteren maximaal negen argumenten: #1, #2, enzovoort.

</div>

<div id="gdef">

Macro's die zijn gedefinieerd met `\gdef`, `\xdef`, `\global\def`, `\global\edef`, `\global\let` en `\global\futurelet` blijven bestaan tussen formules. (Uitzondering: dit kan worden uitgeschakeld, en daar zijn goede veiligheidsredenen voor.)

KaTeX heeft geen `\par`, dus alle macro's zijn standaard ‘long’ en `\long` wordt genegeerd.

Beschikbare functies zijn onder andere:

`\char` `\mathchoice` `\TextOrMath` `\@ifstar` `\@ifnextchar` `\@firstoftwo` `\@secondoftwo` `\relax` `\expandafter` `\noexpand`

@ is een geldig teken in commando's, alsof `\makeatletter` actief is.

## Operatoren {#operators}

### Grote operatoren {#big-operators}

|||||
|------------------|-------------------------|--------------------------|--------------|
| $\sum$ `\sum`    | $\prod$ `\prod`         | $\bigotimes$ `\bigotimes`| $\bigvee$ `\bigvee`
| $\int$ `\int`    | $\coprod$ `\coprod`     | $\bigoplus$ `\bigoplus`  | $\bigwedge$ `\bigwedge`
| $\iint$ `\iint`  | $\intop$ `\intop`       | $\bigodot$ `\bigodot`    | $\bigcap$ `\bigcap`
| $\iiint$ `\iiint`| $\smallint$ `\smallint` | $\biguplus$ `\biguplus`  | $\bigcup$ `\bigcup`
| $\oint$ `\oint`  | $\oiint$ `\oiint`       | $\oiiint$ `\oiiint`      | $\bigsqcup$ `\bigsqcup`

Direct Input: $∫ ∬ ∭ ∮ ∏ ∐ ∑ ⋀ ⋁ ⋂ ⋃ ⨀ ⨁ ⨂ ⨄ ⨆$ ∯ ∰

### Binaire operatoren {#binary-operators}

|||||
|-------------|-------------------|-------------------|--------------------|
| $+$ `+`| $\cdot$ `\cdot`  | $\gtrdot$ `\gtrdot`| $x \pmod a$ `x \pmod a`|
| $-$ `-`| $\cdotp$ `\cdotp` | $\intercal$ `\intercal` | $x \pod a$ `x \pod a` |
| $/$ `/`| $\centerdot$ `\centerdot`| $\land$ `\land`  | $\rhd$ `\rhd` |
| $*$ `*`| $\circ$ `\circ`  | $\leftthreetimes$ `\leftthreetimes` | $\rightthreetimes$ `\rightthreetimes` |
| $\amalg$ `\amalg` | $\circledast$ `\circledast`  | $\ldotp$ `\ldotp` | $\rtimes$ `\rtimes` |
| $\And$ `\And`| $\circledcirc$ `\circledcirc` | $\lor$ `\lor`| $\setminus$ `\setminus`  |
| $\ast$ `\ast`| $\circleddash$ `\circleddash` | $\lessdot$ `\lessdot`  | $\smallsetminus$ `\smallsetminus`|
| $\barwedge$ `\barwedge` | $\Cup$ `\Cup`| $\lhd$ `\lhd`| $\sqcap$ `\sqcap`  |
| $\bigcirc$ `\bigcirc`  | $\cup$ `\cup`| $\ltimes$ `\ltimes`| $\sqcup$ `\sqcup`  |
| $\bmod$ `\bmod`  | $\curlyvee$ `\curlyvee` | $x \mod a$ `x\mod a`| $\times$ `\times`  |
| $\boxdot$ `\boxdot`| $\curlywedge$ `\curlywedge`  | $\mp$ `\mp` | $\unlhd$ `\unlhd`  |
| $\boxminus$ `\boxminus` | $\div$ `\div`| $\odot$ `\odot`  | $\unrhd$ `\unrhd`  |
| $\boxplus$ `\boxplus`  | $\divideontimes$ `\divideontimes`  | $\ominus$ `\ominus`| $\uplus$ `\uplus`  |
| $\boxtimes$ `\boxtimes` | $\dotplus$ `\dotplus`  | $\oplus$ `\oplus` | $\vee$ `\vee` |
| $\bullet$ `\bullet`| $\doublebarwedge$ `\doublebarwedge` | $\otimes$ `\otimes`| $\veebar$ `\veebar` |
| $\Cap$ `\Cap`| $\doublecap$ `\doublecap`| $\oslash$ `\oslash`| $\wedge$ `\wedge`  |
| $\cap$ `\cap`| $\doublecup$ `\doublecup`| $\pm$ `\pm` or `\plusmn` | $\wr$ `\wr`  |

Direct Input: $+ - / * ⋅ ∘ ∙ ± × ÷ ∓ ∔ ∧ ∨ ∩ ∪ ≀ ⊎ ⊓ ⊔ ⊕ ⊖ ⊗ ⊘ ⊙ ⊚ ⊛ ⊝ ◯ ∖ {}$

### Breuken en binomiaalcoëfficiënten {#fractions-and-binomials}

||||
|:--------------------------|:----------------------------|:-----
|$\frac{a}{b}$ `\frac{a}{b}`|$\tfrac{a}{b}$ `\tfrac{a}{b}`|$\genfrac ( ] {2pt}{1}a{a+1}$ `\genfrac ( ] {2pt}{1}a{a+1}`
|${a \over b}$ `{a \over b}`|$\dfrac{a}{b}$ `\dfrac{a}{b}`|${a \above{2pt} b+1}$ `{a \above{2pt} b+1}`
|$a/b$ `a/b`                |  |$\cfrac{a}{1 + \cfrac{1}{b}}$ `\cfrac{a}{1 + \cfrac{1}{b}}`

||||
|:------------------------------|:------------------------------|:--------
|$\binom{n}{k}$ `\binom{n}{k}`  |$\dbinom{n}{k}$ `\dbinom{n}{k}`|${n\brace k}$ `{n\brace k}`
|${n \choose k}$ `{n \choose k}`|$\tbinom{n}{k}$ `\tbinom{n}{k}`|${n\brack k}$ `{n\brack k}`

### Wiskundige operatoren {#math-operators}

|||||
|:--------------------|:--------------------|:----------------|:--------------|
| $\arcsin$ `\arcsin` | $\cosec$ `\cosec`   | $\deg$ `\deg`   | $\sec$ `\sec` |
| $\arccos$ `\arccos` | $\cosh$ `\cosh`     | $\dim$ `\dim`   | $\sin$ `\sin` |
| $\arctan$ `\arctan` | $\cot$ `\cot`       | $\exp$ `\exp`   | $\sinh$ `\sinh` |
| $\arctg$ `\arctg`   | $\cotg$ `\cotg`     | $\hom$ `\hom`   | $\sh$ `\sh` |
| $\arcctg$ `\arcctg` | $\coth$ `\coth`     | $\ker$ `\ker`   | $\tan$ `\tan` |
| $\arg$ `\arg`       | $\csc$ `\csc`       | $\lg$ `\lg`     | $\tanh$ `\tanh` |
| $\ch$ `\ch`         | $\ctg$ `\ctg`       | $\ln$ `\ln`     | $\tg$ `\tg` |
| $\cos$ `\cos`       | $\cth$ `\cth`       | $\log$ `\log`   | $\th$ `\th` |
| $\operatorname{f}$ `\operatorname{f}`     | |||
| $\argmax$ `\argmax` | $\injlim$ `\injlim` | $\min$ `\min`   | $\varinjlim$ `\varinjlim` |
| $\argmin$ `\argmin` | $\lim$ `\lim`       | $\plim$ `\plim` | $\varliminf$ `\varliminf` |
| $\det$ `\det`       | $\liminf$ `\liminf` | $\Pr$ `\Pr`     | $\varlimsup$ `\varlimsup` |
| $\gcd$ `\gcd`       | $\limsup$ `\limsup` | $\projlim$ `\projlim` | $\varprojlim$ `\varprojlim` |
| $\inf$ `\inf`       | $\max$ `\max`       | $\sup$ `\sup`   ||
| $\operatorname*{f}$ `\operatorname*{f}` | $\operatornamewithlimits{f}$ `\operatornamewithlimits{f}` |||

De functies in de onderste zes rijen van deze tabel kunnen `\limits` gebruiken.

### \sqrt

$\sqrt{x}$ `\sqrt{x}`

$\sqrt[3]{x}$ `\sqrt[3]{x}`

## Relaties {#relations}

$\stackrel{!}{=}$ `\stackrel{!}{=}`

|||||
|:--------|:------------------------|:----------------------------|:------------------|
| $=$ `=` | $\doteqdot$ `\doteqdot` | $\lessapprox$ `\lessapprox` | $\smile$ `\smile` |
| $<$ `<` | $\eqcirc$ `\eqcirc` | $\lesseqgtr$ `\lesseqgtr` | $\sqsubset$ `\sqsubset` |
| $>$ `>` | $\eqcolon$ `\eqcolon` or<br>    `\minuscolon` | $\lesseqqgtr$ `\lesseqqgtr` | $\sqsubseteq$ `\sqsubseteq` |
| $:$ `:` | $\Eqcolon$ `\Eqcolon` or<br>    `\minuscoloncolon` | $\lessgtr$ `\lessgtr` | $\sqsupset$ `\sqsupset` |
| $\approx$ `\approx` | $\eqqcolon$ `\eqqcolon` or<br>    `\equalscolon` | $\lesssim$ `\lesssim` | $\sqsupseteq$ `\sqsupseteq` |
| $\approxcolon$ `\approxcolon` | $\Eqqcolon$ `\Eqqcolon` or<br>    `\equalscoloncolon` | $\ll$ `\ll` | $\Subset$ `\Subset` |
| $\approxcoloncolon$ `\approxcoloncolon` | $\eqsim$ `\eqsim` | $\lll$ `\lll` | $\subset$ `\subset` or `\sub` |
| $\approxeq$ `\approxeq` | $\eqslantgtr$ `\eqslantgtr` | $\llless$ `\llless` | $\subseteq$ `\subseteq` or `\sube` |
| $\asymp$ `\asymp` | $\eqslantless$ `\eqslantless` | $\lt$ `\lt` | $\subseteqq$ `\subseteqq` |
| $\backepsilon$ `\backepsilon` | $\equiv$ `\equiv` | $\mid$ `\mid` | $\succ$ `\succ` |
| $\backsim$ `\backsim` | $\fallingdotseq$ `\fallingdotseq` | $\models$ `\models` | $\succapprox$ `\succapprox` |
| $\backsimeq$ `\backsimeq` | $\frown$ `\frown` | $\multimap$ `\multimap` | $\succcurlyeq$ `\succcurlyeq` |
| $\between$ `\between` | $\ge$ `\ge` | $\origof$ `\origof` | $\succeq$ `\succeq` |
| $\bowtie$ `\bowtie` | $\geq$ `\geq` | $\owns$ `\owns` | $\succsim$ `\succsim` |
| $\bumpeq$ `\bumpeq` | $\geqq$ `\geqq` | $\parallel$ `\parallel` | $\Supset$ `\Supset` |
| $\Bumpeq$ `\Bumpeq` | $\geqslant$ `\geqslant` | $\perp$ `\perp` | $\supset$ `\supset` |
| $\circeq$ `\circeq` | $\gg$ `\gg` | $\pitchfork$ `\pitchfork` | $\supseteq$ `\supseteq` or `\supe` |
| $\colonapprox$ `\colonapprox` | $\ggg$ `\ggg` | $\prec$ `\prec` | $\supseteqq$ `\supseteqq` |
| $\Colonapprox$ `\Colonapprox` or<br>    `\coloncolonapprox` | $\gggtr$ `\gggtr` | $\precapprox$ `\precapprox` | $\thickapprox$ `\thickapprox` |
| $\coloneq$ `\coloneq` or<br>    `\colonminus` | $\gt$ `\gt` | $\preccurlyeq$ `\preccurlyeq` | $\thicksim$ `\thicksim` |
| $\Coloneq$ `\Coloneq` or<br>    `\coloncolonminus` | $\gtrapprox$ `\gtrapprox` | $\preceq$ `\preceq` | $\trianglelefteq$ `\trianglelefteq` |
| $\coloneqq$ `\coloneqq` or<br>   `\colonequals` | $\gtreqless$ `\gtreqless` | $\precsim$ `\precsim` | $\triangleq$ `\triangleq` |
| $\Coloneqq$ `\Coloneqq` or<br>    `\coloncolonequals` | $\gtreqqless$ `\gtreqqless` | $\propto$ `\propto` | $\trianglerighteq$ `\trianglerighteq` |
| $\colonsim$ `\colonsim` | $\gtrless$ `\gtrless` | $\risingdotseq$ `\risingdotseq` | $\varpropto$ `\varpropto` |
| $\Colonsim$ `\Colonsim` or<br>    `\coloncolonsim` | $\gtrsim$ `\gtrsim` | $\shortmid$ `\shortmid` | $\vartriangle$ `\vartriangle` |
| $\cong$ `\cong` | $\imageof$ `\imageof` | $\shortparallel$ `\shortparallel` | $\vartriangleleft$ `\vartriangleleft` |
| $\curlyeqprec$ `\curlyeqprec` | $\in$ `\in` or `\isin` | $\sim$ `\sim` | $\vartriangleright$ `\vartriangleright` |
| $\curlyeqsucc$ `\curlyeqsucc` | $\Join$ `\Join` | $\simcolon$ `\simcolon` | $\vcentcolon$ `\vcentcolon` or<br>   `\ratio` |
| $\dashv$ `\dashv` | $\le$ `\le` | $\simcoloncolon$ `\simcoloncolon` | $\vdash$ `\vdash` |
| $\dblcolon$ `\dblcolon` or<br>   `\coloncolon` | $\leq$ `\leq` | $\simeq$ `\simeq` | $\vDash$ `\vDash` |
| $\doteq$ `\doteq` | $\leqq$ `\leqq` | $\smallfrown$ `\smallfrown` | $\Vdash$ `\Vdash` |
| $\Doteq$ `\Doteq` | $\leqslant$ `\leqslant` | $\smallsmile$ `\smallsmile` | $\Vvdash$ `\Vvdash` |

Direct Input: $= < > : ∈ ∋ ∝ ∼ ∽ ≂ ≃ ≅ ≈ ≊ ≍ ≎ ≏ ≐ ≑ ≒ ≓ ≖ ≗ ≜ ≡ ≤ ≥ ≦ ≧ ≫ ≬ ≳ ≷ ≺ ≻ ≼ ≽ ≾ ≿ ⊂ ⊃ ⊆ ⊇ ⊏ ⊐ ⊑ ⊒ ⊢ ⊣ ⊩ ⊪ ⊸ ⋈ ⋍ ⋐ ⋑ ⋔ ⋙ ⋛ ⋞ ⋟ ⌢ ⌣ ⩾ ⪆ ⪌ ⪕ ⪖ ⪯ ⪰ ⪷ ⪸ ⫅ ⫆ ≲ ⩽ ⪅ ≶ ⋚ ⪋ ⟂ ⊨ ⊶ ⊷$ `≔ ≕ ⩴`

### Ontkende relaties {#negated-relations}

$\not =$ `\not =`

|||||
|--------------|-------------------|---------------------|------------------|
| $\gnapprox$ `\gnapprox`  | $\ngeqslant$ `\ngeqslant`| $\nsubseteq$ `\nsubseteq`  | $\precneqq$ `\precneqq`|
| $\gneq$ `\gneq`| $\ngtr$ `\ngtr`  | $\nsubseteqq$ `\nsubseteqq` | $\precnsim$ `\precnsim`|
| $\gneqq$ `\gneqq`  | $\nleq$ `\nleq`  | $\nsucc$ `\nsucc`| $\subsetneq$ `\subsetneq`  |
| $\gnsim$ `\gnsim`  | $\nleqq$ `\nleqq` | $\nsucceq$ `\nsucceq` | $\subsetneqq$ `\subsetneqq` |
| $\gvertneqq$ `\gvertneqq` | $\nleqslant$ `\nleqslant`| $\nsupseteq$ `\nsupseteq`  | $\succnapprox$ `\succnapprox`|
| $\lnapprox$ `\lnapprox`  | $\nless$ `\nless` | $\nsupseteqq$ `\nsupseteqq` | $\succneqq$ `\succneqq`|
| $\lneq$ `\lneq`| $\nmid$ `\nmid`  | $\ntriangleleft$ `\ntriangleleft` | $\succnsim$ `\succnsim`|
| $\lneqq$ `\lneqq`  | $\notin$ `\notin` | $\ntrianglelefteq$ `\ntrianglelefteq`  | $\supsetneq$ `\supsetneq`  |
| $\lnsim$ `\lnsim`  | $\notni$ `\notni` | $\ntriangleright$ `\ntriangleright`| $\supsetneqq$ `\supsetneqq` |
| $\lvertneqq$ `\lvertneqq` | $\nparallel$ `\nparallel`| $\ntrianglerighteq$ `\ntrianglerighteq` | $\varsubsetneq$ `\varsubsetneq`  |
| $\ncong$ `\ncong`  | $\nprec$ `\nprec` | $\nvdash$ `\nvdash`  | $\varsubsetneqq$ `\varsubsetneqq` |
| $\ne$ `\ne`  | $\npreceq$ `\npreceq`  | $\nvDash$ `\nvDash`  | $\varsupsetneq$ `\varsupsetneq`  |
| $\neq$ `\neq` | $\nshortmid$ `\nshortmid`| $\nVDash$ `\nVDash`  | $\varsupsetneqq$ `\varsupsetneqq` |
| $\ngeq$ `\ngeq`| $\nshortparallel$ `\nshortparallel` | $\nVdash$ `\nVdash`  |
| $\ngeqq$ `\ngeqq`  | $\nsim$ `\nsim`  | $\precnapprox$ `\precnapprox`|

Direct Input: $∉ ∌ ∤ ∦ ≁ ≆ ≠ ≨ ≩ ≮ ≯ ≰ ≱ ⊀ ⊁ ⊈ ⊉ ⊊ ⊋ ⊬ ⊭ ⊮ ⊯ ⋠ ⋡ ⋦ ⋧ ⋨ ⋩ ⋬ ⋭ ⪇ ⪈ ⪉ ⪊ ⪵ ⪶ ⪹ ⪺ ⫋ ⫌$

### Pijlen {#arrows}

||||
|:----------|:----------|:----------|
|$\circlearrowleft$ `\circlearrowleft`|$\leftharpoonup$ `\leftharpoonup`|$\rArr$ `\rArr`
|$\circlearrowright$ `\circlearrowright`|$\leftleftarrows$ `\leftleftarrows`|$\rarr$ `\rarr`
|$\curvearrowleft$ `\curvearrowleft`|$\leftrightarrow$ `\leftrightarrow`|$\restriction$ `\restriction`
|$\curvearrowright$ `\curvearrowright`|$\Leftrightarrow$ `\Leftrightarrow`|$\rightarrow$ `\rightarrow`
|$\Darr$ `\Darr`|$\leftrightarrows$ `\leftrightarrows`|$\Rightarrow$ `\Rightarrow`
|$\dArr$ `\dArr`|$\leftrightharpoons$ `\leftrightharpoons`|$\rightarrowtail$ `\rightarrowtail`
|$\darr$ `\darr`|$\leftrightsquigarrow$ `\leftrightsquigarrow`|$\rightharpoondown$ `\rightharpoondown`
|$\dashleftarrow$ `\dashleftarrow`|$\Lleftarrow$ `\Lleftarrow`|$\rightharpoonup$ `\rightharpoonup`
|$\dashrightarrow$ `\dashrightarrow`|$\longleftarrow$ `\longleftarrow`|$\rightleftarrows$ `\rightleftarrows`
|$\downarrow$ `\downarrow`|$\Longleftarrow$ `\Longleftarrow`|$\rightleftharpoons$ `\rightleftharpoons`
|$\Downarrow$ `\Downarrow`|$\longleftrightarrow$ `\longleftrightarrow`|$\rightrightarrows$ `\rightrightarrows`
|$\downdownarrows$ `\downdownarrows`|$\Longleftrightarrow$ `\Longleftrightarrow`|$\rightsquigarrow$ `\rightsquigarrow`
|$\downharpoonleft$ `\downharpoonleft`|$\longmapsto$ `\longmapsto`|$\Rrightarrow$ `\Rrightarrow`
|$\downharpoonright$ `\downharpoonright`|$\longrightarrow$ `\longrightarrow`|$\Rsh$ `\Rsh`
|$\gets$ `\gets`|$\Longrightarrow$ `\Longrightarrow`|$\searrow$ `\searrow`
|$\Harr$ `\Harr`|$\looparrowleft$ `\looparrowleft`|$\swarrow$ `\swarrow`
|$\hArr$ `\hArr`|$\looparrowright$ `\looparrowright`|$\to$ `\to`
|$\harr$ `\harr`|$\Lrarr$ `\Lrarr`|$\twoheadleftarrow$ `\twoheadleftarrow`
|$\hookleftarrow$ `\hookleftarrow`|$\lrArr$ `\lrArr`|$\twoheadrightarrow$ `\twoheadrightarrow`
|$\hookrightarrow$ `\hookrightarrow`|$\lrarr$ `\lrarr`|$\Uarr$ `\Uarr`
|$\iff$ `\iff`|$\Lsh$ `\Lsh`|$\uArr$ `\uArr`
|$\impliedby$ `\impliedby`|$\mapsto$ `\mapsto`|$\uarr$ `\uarr`
|$\implies$ `\implies`|$\nearrow$ `\nearrow`|$\uparrow$ `\uparrow`
|$\Larr$ `\Larr`|$\nleftarrow$ `\nleftarrow`|$\Uparrow$ `\Uparrow`
|$\lArr$ `\lArr`|$\nLeftarrow$ `\nLeftarrow`|$\updownarrow$ `\updownarrow`
|$\larr$ `\larr`|$\nleftrightarrow$ `\nleftrightarrow`|$\Updownarrow$ `\Updownarrow`
|$\leadsto$ `\leadsto`|$\nLeftrightarrow$ `\nLeftrightarrow`|$\upharpoonleft$ `\upharpoonleft`
|$\leftarrow$ `\leftarrow`|$\nrightarrow$ `\nrightarrow`|$\upharpoonright$ `\upharpoonright`
|$\Leftarrow$ `\Leftarrow`|$\nRightarrow$ `\nRightarrow`|$\upuparrows$ `\upuparrows`
|$\leftarrowtail$ `\leftarrowtail`|$\nwarrow$ `\nwarrow`
|$\leftharpoondown$ `\leftharpoondown`|$\Rarr$ `\Rarr`

Direct Input: $← ↑ → ↓ ↔ ↕ ↖ ↗ ↘ ↙ ↚ ↛ ↞ ↠ ↢ ↣ ↦ ↩ ↪ ↫ ↬ ↭ ↮ ↰ ↱↶ ↷ ↺ ↻ ↼ ↽ ↾ ↾ ↿ ⇀ ⇁ ⇂ ⇃ ⇄ ⇆ ⇇ ⇈ ⇉ ⇊ ⇋ ⇌⇍ ⇎ ⇏ ⇐ ⇑ ⇒ ⇓ ⇔ ⇕ ⇚ ⇛ ⇝ ⇠ ⇢ ⟵ ⟶ ⟷ ⟸ ⟹ ⟺ ⟼$ ↽

**Uitrekbare pijlen**

|||
|:----------------------------------------------------|:-----
|$\xleftarrow{abc}$ `\xleftarrow{abc}`                |$\xrightarrow[under]{over}$ `\xrightarrow[under]{over}`
|$\xLeftarrow{abc}$ `\xLeftarrow{abc}`                |$\xRightarrow{abc}$ `\xRightarrow{abc}`
|$\xleftrightarrow{abc}$ `\xleftrightarrow{abc}`      |$\xLeftrightarrow{abc}$ `\xLeftrightarrow{abc}`
|$\xhookleftarrow{abc}$ `\xhookleftarrow{abc}`        |$\xhookrightarrow{abc}$ `\xhookrightarrow{abc}`
|$\xtwoheadleftarrow{abc}$ `\xtwoheadleftarrow{abc}`  |$\xtwoheadrightarrow{abc}$ `\xtwoheadrightarrow{abc}`
|$\xleftharpoonup{abc}$ `\xleftharpoonup{abc}`        |$\xrightharpoonup{abc}$ `\xrightharpoonup{abc}`
|$\xleftharpoondown{abc}$ `\xleftharpoondown{abc}`    |$\xrightharpoondown{abc}$ `\xrightharpoondown{abc}`
|$\xleftrightharpoons{abc}$ `\xleftrightharpoons{abc}`|$\xrightleftharpoons{abc}$ `\xrightleftharpoons{abc}`
|$\xtofrom{abc}$ `\xtofrom{abc}`                      |$\xmapsto{abc}$ `\xmapsto{abc}`
|$\xlongequal{abc}$ `\xlongequal{abc}`

Uitrekbare pijlen accepteren allemaal een optioneel argument, op dezelfde manier<br>als `\xrightarrow[under]{over}`.

## Speciale notatie {#special-notation}

**Bra-ket-notatie**

||||
|:----------|:----------|:----------|
|$\bra{\phi}$ `\bra{\phi}` |$\ket{\psi}$ `\ket{\psi}` |$\braket{\phi\VERT\psi}$ <code>\braket{\phi&#124;\psi}</code> |
|$\Bra{\phi}$ `\Bra{\phi}` |$\Ket{\psi}$ `\Ket{\psi}` |$\Braket{ ϕ \VERT \frac{∂^2}{∂ t^2} \VERT ψ }$ <code>\Braket{ ϕ &#124; \frac{∂^2}{∂ t^2} &#124; ψ }</code>|

## Stijl, kleur, grootte en lettertype {#style-color-size-and-font}

**Klassetoewijzing**

`\mathbin` `\mathclose` `\mathinner` `\mathop`<br>
`\mathopen` `\mathord` `\mathpunct` `\mathrel`

**Kleur**

$\color{blue} F=ma$  `\color{blue} F=ma`

Let op: `\color` werkt als een schakelaar. Andere kleurfuncties verwachten de inhoud als functieargument:

$\textcolor{blue}{F=ma}$ `\textcolor{blue}{F=ma}`<br>
$\textcolor{#228B22}{F=ma}$ `\textcolor{#228B22}{F=ma}`<br>
$\colorbox{aqua}{$F=ma$}$ `\colorbox{aqua}{$F=ma$}`<br>
$\fcolorbox{red}{aqua}{$F=ma$}$ `\fcolorbox{red}{aqua}{$F=ma$}`

Net als in LaTeX geven `\colorbox` en `\fcolorbox` hun laatste argument weer als tekst; je wilt dus misschien met `$` terug naar wiskundemodus, zoals in de voorbeelden hierboven.

Voor kleuren accepteren de KaTeX-kleurfuncties de standaard [HTML-kleurnamen](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value#Color_keywords). Ze accepteren ook een RGB-waarde in hexadecimale CSS-notatie. De “#” is optioneel voor een zescijferige waarde.

**Lettertype**

||||
|:------------------------------|:------------------------------|:-----
|$\mathrm{Ab0}$ `\mathrm{Ab0}`  |$\mathbf{Ab0}$ `\mathbf{Ab0}`  |$\mathsf{Ab0}$ `\mathsf{Ab0}`
|$\mathnormal{Ab0}$ `\mathnormal{Ab0}`|$\textbf{Ab0}$ `\textbf{Ab0}`  |$\textsf{Ab0}$ `\textsf{Ab0}`
|$\textrm{Ab0}$ `\textrm{Ab0}`  |$\bf Ab0$ `\bf Ab0`            |$\sf Ab0$ `\sf Ab0`
|$\rm Ab0$ `\rm Ab0`            |$\bold{Ab0}$ `\bold{Ab0}`      |$\Bbb{AB}$ `\Bbb{AB}`
|$\textnormal{Ab0}$ `\textnormal{Ab0}`|$\boldsymbol{Ab0}$ `\boldsymbol{Ab}`|$\mathbb{AB}$ `\mathbb{AB}`
|$\text{Ab0}$ `\text{Ab0}`      |$\bm{Ab0}$ `\bm{Ab0}`          |$\frak{Ab0}$ `\frak{Ab0}`
|$\textup{Ab0}$ `\textup{Ab0}`  |$\textmd{Ab0}$ `\textmd{Ab0}`  |$\mathfrak{Ab0}$ `\mathfrak{Ab0}`
|$\mathit{Ab0}$ `\mathit{Ab0}`  |$\mathtt{Ab0}$ `\mathtt{Ab0}`  |$\mathcal{AB0}$ `\mathcal{AB0}`
|$\textit{Ab0}$ `\textit{Ab0}`  |$\texttt{Ab0}$ `\texttt{Ab0}`  |$\cal AB0$ `\cal AB0`
|$\it Ab0$ `\it Ab0`            |$\tt Ab0$ `\tt Ab0`            |$\mathscr{AB}$ `\mathscr{AB}`
|$\emph{Ab0}$ `\emph{Ab0}`      |                               ||

Lettertypefamilie, -dikte en -stijl kun je combineren met de `\textXX`-versies van de lettertypefuncties. `\textsf{\textbf{H}}` geeft dus $\textsf{\textbf{H}}$. De andere versies zijn niet te combineren: `\mathsf{\mathbf{H}}` geeft bijvoorbeeld $\mathsf{\mathbf{H}}$.

Als een KaTeX-lettertype geen vette variant van een teken heeft, kan `\pmb` die nabootsen. `\pmb{\mu}` wordt bijvoorbeeld: $\pmb{\mu}$

**Grootte**

|||
|:----------------------|:-----
|$\Huge AB$ `\Huge AB`  |$\normalsize AB$ `\normalsize AB`
|$\huge AB$ `\huge AB`  |$\small AB$ `\small AB`
|$\LARGE AB$ `\LARGE AB`|$\footnotesize AB$ `\footnotesize AB`
|$\Large AB$ `\Large AB`|$\scriptsize AB$ `\scriptsize AB`
|$\large AB$ `\large AB`|$\tiny AB$ `\tiny AB`


**Stijl**

||
|:-------------------------------------------------------|
|$\displaystyle\sum_{i=1}^n$ `\displaystyle\sum_{i=1}^n`
|$\textstyle\sum_{i=1}^n$ `\textstyle\sum_{i=1}^n`
|$\scriptstyle x$ `\scriptstyle x` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(De grootte van een eerste sub-/superscript)
|$\scriptscriptstyle x$ `\scriptscriptstyle x` (De grootte van volgende sub-/superscripts)
|$\lim\limits_x$ `\lim\limits_x`
|$\lim\nolimits_x$ `\lim\nolimits_x`
|$\verb!x^2!$ `\verb!x^2!`

`\text{…}` accepteert geneste `$…$`-fragmenten en geeft die weer in wiskundemodus.

## Symbolen en leestekens {#symbols-and-punctuation}

||||
|:----------|:----------|:----------|
|`% comment`|$\dots$ `\dots`|$\KaTeX$ `\KaTeX`
|$\%$ `\%`|$\cdots$ `\cdots`|$\LaTeX$ `\LaTeX`
|$\#$ `\#`|$\ddots$ `\ddots`|$\TeX$ `\TeX`
|$\&$ `\&`|$\ldots$ `\ldots`|$\nabla$ `\nabla`
|$\_$ `\_`|$\vdots$ `\vdots`|$\infty$ `\infty`
|$\text{\textunderscore}$ `\text{\textunderscore}`|$\dotsb$ `\dotsb`|$\infin$ `\infin`
|$\text{--}$ `\text{--}`|$\dotsc$ `\dotsc`|$\checkmark$ `\checkmark`
|$\text{\textendash}$ `\text{\textendash}`|$\dotsi$ `\dotsi`|$\dag$ `\dag`
|$\text{---}$ `\text{---}`|$\dotsm$ `\dotsm`|$\dagger$ `\dagger`
|$\text{\textemdash}$ `\text{\textemdash}`|$\dotso$ `\dotso`|$\text{\textdagger}$ `\text{\textdagger}`
|$\text{\textasciitilde}$ `\text{\textasciitilde}`|$\sdot$ `\sdot`|$\ddag$ `\ddag`
|$\text{\textasciicircum}$ `\text{\textasciicircum}`|$\mathellipsis$ `\mathellipsis`|$\ddagger$ `\ddagger`
|$`$ <code>`</code>|$\text{\textellipsis}$ `\text{\textellipsis}`|$\text{\textdaggerdbl}$ `\text{\textdaggerdbl}`
|$\text{\textquoteleft}$ `text{\textquoteleft}`|$\Box$ `\Box`|$\Dagger$ `\Dagger`
|$\lq$ `\lq`|$\square$ `\square`|$\angle$ `\angle`
|$\text{\textquoteright}$ `\text{\textquoteright}`|$\blacksquare$ `\blacksquare`|$\measuredangle$ `\measuredangle`
|$\rq$ `\rq`|$\triangle$ `\triangle`|$\sphericalangle$ `\sphericalangle`
|$\text{\textquotedblleft}$ `\text{\textquotedblleft}`|$\triangledown$ `\triangledown`|$\top$ `\top`
|$"$ `"`|$\triangleleft$ `\triangleleft`|$\bot$ `\bot`
|$\text{\textquotedblright}$ `\text{\textquotedblright}`|$\triangleright$ `\triangleright`|$\$$ `\$`
|$\colon$ `\colon`|$\bigtriangledown$ `\bigtriangledown`|$\text{\textdollar}$ `\text{\textdollar}`
|$\backprime$ `\backprime`|$\bigtriangleup$ `\bigtriangleup`|$\pounds$ `\pounds`
|$\prime$ `\prime`|$\blacktriangle$ `\blacktriangle`|$\mathsterling$ `\mathsterling`
|$\text{\textless}$ `\text{\textless}`|$\blacktriangledown$ `\blacktriangledown`|$\text{\textsterling}$ `\text{\textsterling}`
|$\text{\textgreater}$ `\text{\textgreater}`|$\blacktriangleleft$ `\blacktriangleleft`|$\yen$ `\yen`
|$\text{\textbar}$ `\text{\textbar}`|$\blacktriangleright$ `\blacktriangleright`|$\surd$ `\surd`
|$\text{\textbardbl}$ `\text{\textbardbl}`|$\diamond$ `\diamond`|$\degree$ `\degree`
|$\text{\textbraceleft}$ `\text{\textbraceleft}`|$\Diamond$ `\Diamond`|$\text{\textdegree}$ `\text{\textdegree}`
|$\text{\textbraceright}$ `\text{\textbraceright}`|$\lozenge$ `\lozenge`|$\mho$ `\mho`
|$\text{\textbackslash}$ `\text{\textbackslash}`|$\blacklozenge$ `\blacklozenge`|$\diagdown$ `\diagdown`
|$\text{\P}$ `\text{\P}` or `\P`|$\star$ `\star`|$\diagup$ `\diagup`
|$\text{\S}$ `\text{\S}` or `\S`|$\bigstar$ `\bigstar`|$\flat$ `\flat`
|$\text{\sect}$ `\text{\sect}`|$\clubsuit$ `\clubsuit`|$\natural$ `\natural`
|$\copyright$ `\copyright`|$\clubs$ `\clubs`|$\sharp$ `\sharp`
|$\circledR$ `\circledR`|$\diamondsuit$ `\diamondsuit`|$\heartsuit$ `\heartsuit`
|$\text{\textregistered}$ `\text{\textregistered}`|$\diamonds$ `\diamonds`|$\hearts$ `\hearts`
|$\circledS$ `\circledS`|$\spadesuit$ `\spadesuit`|$\spades$ `\spades`
|$\text{\textcircled a}$ `\text{\textcircled a}`|$\maltese$ `\maltese`|$\minuso$ `\minuso`|

Direct Input: § ¶ $ £ ¥ ∇ ∞ · ∠ ∡ ∢ ♠ ♡ ♢ ♣ ♭ ♮ ♯ ✓ …  ⋮  ⋯  ⋱  !$ ‼ ⦵

## Eenheden {#units}

In KaTeX hebben eenheden dezelfde verhoudingen als in TeX.<br>
KaTeX-eenheden zijn anders dan CSS-eenheden.

</div>
<div class="katex-cards" id="unit-tbl">

|  KaTeX Unit | Value       | KaTeX Unit  | Value  |
|:---|:---------------------|:---|:----------------|
| em | CSS em               | bp | 1/72​ inch × F × G|
| ex | CSS ex               | pc | 12 KaTeX pt|
| mu | 1/18 CSS em          | dd | 1238/1157​ KaTeX pt  |
| pt | 1/72.27 inch × F × G | cc | 14856/1157 KaTeX pt |
| mm | 1 mm × F × G         | nd | 685/642 KaTeX pt |
| cm | 1 cm × F × G         | nc | 1370/107​ KaTeX pt|
| in | 1 inch × F × G       | sp | 1/65536 KaTeX pt |

</div>

waarbij:

<div style="margin-left: 1.5em;">

F = (lettergrootte van de omringende HTML-tekst)/(10 pt)

G = standaard 1,21, omdat de lettergrootte van KaTeX normaal 1,21 × de omringende lettergrootte is. Deze waarde [kan worden aangepast](https://katex.org/docs/font.html#font-size-and-lengths) met de CSS van een HTML-pagina.

</div>

Het effect van stijl en grootte:

<div class="katex-cards" id="unit-blocks">

|  Unit  |     textstyle     | scriptscript |  huge  |
|:------:|:-----------------:|:------------:|:------:|
|em or ex|$\rule{1em}{1em}$  |$\scriptscriptstyle\rule{1em}{1em}$  |$\huge\rule{1em}{1em}$
| mu     |$\rule{18mu}{18mu}$|$\scriptscriptstyle\rule{18mu}{18mu}$|$\huge\rule{18mu}{18mu}$
| others |$\rule{10pt}{10pt}$|$\scriptscriptstyle\rule{10pt}{10pt}$|$\huge\rule{10pt}{10pt}$

</div>

