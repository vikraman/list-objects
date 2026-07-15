#import "@preview/touying:0.7.4": *
#import themes.university: *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/pinit:0.2.2": *

#let todo(t) = text(fill: red.darken(20%))[TODO: #t]

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong,
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

// theme configuration
#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-info(
    title: [Symmetric List Objects],
    author: [
      Fiona,
      Vikraman,
      #underline[Rin],
    ],
    date: "July 18, 2025",
    // datetime.today().display("[month repr:short] [day], [year]"),

    institution: [MSP, University of Strathclyde, Glasgow, UK],
    logo: [🏴󠁧󠁢󠁳󠁣󠁴󠁿],
  ),
)

// font configuration
#let scriptsize = 12pt
#let normalsize = 20pt
#set text(font: "Libertinus Sans", weight: "light", size: normalsize)
#show math.equation: set text(font: "Libertinus Math")
#show sym.amp.inv: set text(font: "New Computer Modern Math")

#show raw: set text(font: "Iosevka Comfy")
#set raw(lang: "sml")
#set strong(delta: 100)
#set par(justify: true)
#show list: set block(spacing: 1em)

// page configuration
#set page(
  fill: rgb("FDF6E3"),
  background: context {
    let pageNumber = counter(page).at(here()).first()
    let offset1 = calc.rem(pageNumber, 10) * 10%
    let offset2 = calc.rem(pageNumber, 5) * 20%
  },
)

// pinit configuration
#let pinit-highlight-equation-from(
  height: 2em,
  pos: bottom,
  fill: red,
  highlight-pins,
  point-pin,
  body,
) = {
  pinit-highlight(..highlight-pins, dy: -0.9em, fill: rgb(..fill.components().slice(0, -1), 40))
  pinit-point-from(
    fill: fill,
    pin-dx: 0em,
    pin-dy: if pos == bottom { 0.5em } else { -0.9em },
    body-dx: 0pt,
    body-dy: if pos == bottom { -1.7em } else { -1.6em },
    offset-dx: 0em,
    offset-dy: if pos == bottom { 0.8em + height } else { -0.6em - height },
    point-pin,
    rect(
      inset: 0.5em,
      stroke: (bottom: 0.12em + fill),
      {
        set text(fill: fill)
        body
      },
    ),
  )
}

// code configuration
#show raw: it => [
  #show regex("pin\(([[:alnum:]]+)\)\(([[:alnum:]]+)\)\((.+)\)"): it => {
    let t = it.text.match(regex("pin\(([[:alnum:]]+)\)\(([[:alnum:]]+)\)\((.+)\)"))
    let p1 = t.captures.at(0)
    let p2 = t.captures.at(1)
    let s = t.captures.at(2)
    [#pin(p1)#s#pin(p2)]
    // [pin(s + "1"), s, pin(s + "2")]
    // it.text
  }
  #it
]

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 1em,
  radius: 0.5em,
)

// lists spacing
#set list(spacing: 1.5em, tight: false)

// table configuration
#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 1.5pt + black)
  },
)

// macros...
#let nil = math.op("nil")
#let cons = math.op("cons")

// begin presentation
#title-slide()

== Background






Category of endofunctors with composition monoidal product, list objects give the free monad construction.

Modules over a commutative ring, tensor algebras are list objects with monoidal structure given by tensor product of modules.

James construction on connected spaces = list objects with monoidal structure given by smash product





Lists can be defined in any monoidal category


Lists in realisability categories can be constructed without coproducts







#theorem[
  $(L(A), nil, a)$ is the free monoid on $A$.
]



- ...
- coproduct construction
- colimit/initial algebra construction



== List objects
- Non-parametrised list objects do not coincide with free monoids
- Parametrised list objects
- Construct ++
- Example of using iter to show equality of maps
- Outline free monoid proof
- Construct strength
- Outline strength coherence proofs



== Symmetric lists
- ilst axiom
- Show free commutative monoid
- Outline triple equivalence



== Linear logic stuff



== Counterexamples for any given requirements

== Lists

Linked lists



In scheme:
```scheme
(a b c) ; a list of three elements
() ; the empty list
(car '(a b c)) ; a
(cdr '(a b c)) ; (b c)
```

In Haskell:
```haskell
data [a] = [] | a : [a]
```

In Agda:
```agda
data List (A : Set) : Set where
  nil : List A
  cons : A -> List A -> List A
```

In Rocq:
```coq
Inductive list (A : Type) : Type :=
  | nil : list A
  | cons : A -> list A -> list A.
```

#grid(
  columns: (1fr, 1fr),
  align: (right, left),
  $#nil : L(A) quad$, $quad #cons : A times L(A) -> L(A)$,
)

#align(center + horizon)[

]

== Diagram test

#fletcher-diagram(
  cell-size: 15mm,
  $
    #rect(width: 2em, height: 2em)[
      #rect(width: 2em, height: 2em)[b]
      #rect(width: 2em, height: 2em)[c]
    ]
  $,
)
