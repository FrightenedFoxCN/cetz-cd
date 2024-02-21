# CeTZ commutative diagrams

This is a project to complement to the [CeTZ package](https://github.com/johannes-wolf/cetz) of [Typst](https://typst.app/) in an attempt to align to tikz-cd format. Only for personal use currently, without any guarantee.

## Description of the DSL

In order to align to tikz-cd api without losing sight of the design philosophy of Typst, we use raw text as parameters. For example, the main content goes like

```typst
#cetz-cd(```
    $...$ ar[r] & $C_(n + 1)$ ar[r] ar[d] ar[ld] & $C_n$ ar[r] ar[d] ar[ld] & $C_(n - 1)$ ar[r] ar[d] ar[ld] & $...$ ar[ld] \
    $...$ ar[r] & $D_(n + 1)$ ar[r] & $D_n$ ar[r] & $D_(n - 1)$ ar[r] & $...$
```)
```

while tikz-cd presents as

```latex
\begin{tikzcd}
\cdots \rar & C_{n + 1} \rar \dar \ar[ld] & C_n \rar \dar \ar[ld] & C_{n - 1} \rar \dar \ar[ld] & \cdots \ar[ld] \\
\cdots \rar & D_{n + 1} \rar & D_n \rar & D_{n - 1} \rar & \cdots
\end{tikzcd}
```

## TODO

- [x] Arrow styles, especially label. It calls for a complete redesign of arrow representation
- [ ] Some snipets, only for my own convenience
- [x] Refactor the code
- [ ] Rewrite the manual
- [ ] Support for better arrows, styles, bent & offset