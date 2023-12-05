= CeTZ commutative diagrams

This is a project to complement to the [CeTZ package](https://github.com/johannes-wolf/cetz) of [Typst](https://typst.app/) in an attempt to align to tikz-cd format. Only for personal use currently, without any guarantee.

== Description of the DSL

> WARNING: They are all EXPERIMENTAL and MAY BE ALTERED SOON.

In order to align to tikz-cd api without losing sight of the design philosophy of Typst, we use array as parameters. For example, the main content goes like

```typst
(($...$, $C_(n + 1)$, $C_n$, $C_(n - 1)$, $...$), ($...$, $D_(n + 1)$, $D_n$, $D_(n - 1)$, $...$))
```

while tikz-cd presents as

```latex
\begin{tikzcd}
\cdots & C_{n + 1} & C_n & C_{n - 1} & \cdots \\
\cdots & D_{n + 1} & D_n & D_{n - 1} & \cdots
\end{tikzcd}
```

which is more convenient to type. The reason mainly lies in the inconvenience of math block in Typst. I haven't find a way to call the parser of math formula in Typst now.

The arrows are seperated from the text, which in my perspective is better than that of tikz-cd. Currently it's much the same as tikz-cd style:

```
"r & r, d & r, d & r, d & \\ r & r & r & r &"
```

but **it would soon be altered** to cater to the need of much complex arrow.

== TODO

[ ] Arrow styles, especially label. It calls for a complete redesign of arrow representation
[ ] Some snipets, only for my own convenience
[ ] Refactor the code

It may be rewritten completely as soon as Typst development team makes their `content` type better.