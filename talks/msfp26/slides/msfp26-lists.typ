#import "@preview/touying:0.7.4": *
#import themes.university: *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#import "@preview/theorion:0.6.0": *
#show: show-theorion
#import "@preview/pinit:0.2.2": *
#import "@preview/xarrow:0.4.0": *

#let todo(t) = text(fill: red.darken(20%))[TODO: #t]

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// disable heading numbers
#set heading(numbering: none)

// theorems configuration for theorion
#let thmbox-render(
  fill: red,
  prefix: none,
  title: "",
  full-title: "",
  body,
) = block(
  stroke: (left: 0.25em + fill),
  inset: (left: 1em, y: .75em),
  width: 100%,
  breakable: true,
  [
    #if full-title != "" { block(sticky: true, strong(text(fill: fill, full-title))) }
    #body
  ],
)

#let (theorem-counter, theorem-box, theorem, show-theorem) = make-frame(
  "theorem",
  "Theorem",
  inherited-levels: 2,
  render: thmbox-render.with(fill: red.darken(20%)),
)
#let (lemma-counter, lemma-box, lemma, show-lemma) = make-frame(
  "lemma",
  "Lemma",
  counter: theorem-counter,
  render: thmbox-render.with(fill: teal.darken(10%)),
)
#let (corollary-counter, corollary-box, corollary, show-corollary) = make-frame(
  "corollary",
  "Corollary",
  inherited-from: theorem-counter,
  render: thmbox-render.with(fill: fuchsia.darken(10%)),
)
#let (definition-counter, definition-box, definition, show-definition) = make-frame(
  "definition",
  "Definition",
  counter: theorem-counter,
  render: thmbox-render.with(fill: orange),
)
#let (example-counter, example-box, example, show-example) = make-frame(
  "example",
  "Example",
  counter: theorem-counter,
  render: thmbox-render.with(fill: olive),
)
#let example = example.with(numbering: none)
#let proofsketch = proof.with(title: "Proof sketch")

#let show-theorion = body => {
  show: show-theorem
  show: show-lemma
  show: show-corollary
  show: show-definition
  show: show-example
  body
}

// theme configuration
#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  config-common(
    show-bibliography-as-footnote: bibliography(title: none, "lists.bib"),
    // show-notes-on-second-screen: bottom,
    // freeze-slide-counter: true,
    frozen-counters: (theorem-counter,),
    default-frozen-states: (),
    enable-mark-warning: false,
  ),
  config-info(
    title: [Symmetric List Objects],
    author: [
      Fiona Blackett,
      Vikraman Choudhury,
      #underline[Rin Liu]
    ],
    date: "July 18, 2026",
    // datetime.today().display("[month repr:short] [day], [year]"),

    institution: [MSP, University of Strathclyde, Glasgow, UK],
    logo: box[#image("term-left.svg", width: 1em)],
    // logo: [🏴󠁧󠁢󠁳󠁣󠁴󠁿],
    // logo: [#image("msp-logo.png")],
    // logo: [#image("strathclyde-logo.png")],
  ),
)

// font configuration
#let scriptsize = 12pt
#let normalsize = 20pt
#let smallsize = 16pt
#set text(font: "Gentium Book Plus", weight: "regular", size: normalsize)
#show math.equation: set text(font: "New Computer Modern Math")

#show raw: set text(font: ("Iosevka Comfy", "Iosevka", "DejaVu Sans Mono"), size: smallsize)
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

// math macros
#let rec = math.op("rec")
#let nil = math.op("nil")
#let cons = math.op("cons")
#let it = math.op("it")
#let app = {
  math.plus
  h(-0.35em)
  math.plus
}

#let Mon = math.sans("Mon")
#let CMon = math.sans("CMon")

#let zero = math.op("zero")
#let succ = math.op("succ")

#let qed() = [#h(1fr)$square$]

#let cat(c) = math.cal(c)

// syntax rules
#show raw.where(lang: "haskell"): it => [
  #show regex("nil"): keyword => [\[\]]
  #show regex("cons"): keyword => [∷]
  #show regex("append"): keyword => $app$
  #show regex("\bList\b"): keyword => $cal(L)sans("ist")$
  #show regex("\bIlst\b"): keyword => $cal(I)sans("lst")$
  #it
]

// begin presentation
#title-slide()


== Lists

#grid(
  columns: (1fr, 1fr),
  rows: (1fr, 1fr),
  [
    In scheme:
    ```lisp
    (a b c) ; a list of three elements
    (a . (b . (c . ()))) ; the same list
    () ; the empty list
    (car '(a b c)) ; a
    (cdr '(a b c)) ; (b c)
    ```
  ],
  [
    In Haskell:
    ```haskell
    data [a] = [] | a : [a]
    ```
  ],

  [
    In Agda:
    ```haskell
    data List (A : Set) : Set where
      [] : List A
      _∷_ : A → List A → List A
    ```
  ],
  [
    In Rocq:
    ```ml
    Inductive list (A : Type) : Type :=
      | nil : list A
      | cons : A -> list A -> list A.
    ```
  ],
)



== Constructions

In categories with finite products and countable coproducts, we can construct lists as:
$
  product.co_(n >= 0) A^n
$

#pause

Alternatively, if we have a natural numbers object, sigma types, and functions out of $sans("Fin")_n$, we can construct lists as:
$
  sum_(n:bb(N)) A^(sans("Fin")_n)
$

#pause

We can also construct lists as initial algebras of the following functor:
$
  F(X) = 1 + A times X
$
but this requires an initial object, and for the colimit of the following $omega$-chain to exist:
$
  0 -> F(0) -> F F(0) -> F F F(0) -> ...
$


== List Objects

Lawvere introduced#cite(<lawvereElementaryTheoryCategory1964>) natural numbers objects in his axiomatisation of set theory (ETCS):
$
  #fletcher-diagram(
    cell-size: 12mm,
    spacing: 10mm,
    node((0, 0), $1$),
    node((2, -1), $N$),
    node((4, -1), $N$),
    node((2, 1), $X$),
    node((4, 1), $X$),
    edge((0, 0), (2, -1), label: $zero$, "->"),
    edge((0, 0), (2, 1), label: $z$, "->", label-side: right),
    edge((4, -1), (2, -1), label: $succ$, "->"),
    edge((2, -1), (2, 1), label: $rec(z, s)$, "-->", label-side: left),
    edge((4, -1), (4, 1), label: $rec(z, s)$, "-->", label-side: left),
    edge((4, 1), (2, 1), label: $s$, "->", label-side: left),
  )
$
#v(-0.5em)

#pause

#speaker-note[
  This is precisely the universal property of being an initial $F$-algebra for the functor $F(X) = 1 + X$.
  Note that this definition makes sense in categories without products or coproducts.
]

We can adapt this universal property to axiomatise list objects in general monoidal categories.

#todo[cite: Joyal's arithmetic universes, Maietti, Cockett's Locoi, Pare and Roman's parametrized NNO.]

== List Objects

#definition("List objects", number: "1")[#v(-0.5em)
  $
    #fletcher-diagram(
      cell-size: 10mm,
      spacing: 10mm,
      node((0, 0), $1$),
      node((2, -1), $L(A)$),
      node((4, -1), $A times.o L(A)$),
      node((2, 1), $L$),
      node((4, 1), $A times.o L$),
      edge((0, 0), (2, -1), label: $nil$, "->"),
      edge((4, -1), (2, -1), label: $cons$, "->"),
      edge((2, -1), (2, 1), label: $it(n, c)$, "-->", label-side: left),
      edge((4, -1), (4, 1), label: $it(n, c)$, "-->", label-side: left),
      edge((0, 0), (2, 1), label: $n$, "->", label-side: right),
      edge((4, 1), (2, 1), label: $c$, "->", label-side: left),
    )
  $#v(-0.5em)
  A list object on $A$ is:#v(-0.2em)
  - an object $L(A)$ with maps $nil : 1 -> L(A)$ and $cons : A times.o L(A)$, such that;#v(-0.5em)
  - for every $L$ with maps $n:1 -> L$ and $c : A times.o L -> L$, there exists a unique _iterator_
    $
      it (n,c): L(A) -> L
    $
    such that the above diagram commutes.
]












== Examples of list objects in nature

- In a category of endofunctors $[cat(C),cat(C)]$ with monoidal structure given by functor composition $(1,compose)$, list objects are free monad:
  $
    1 xarrow(#nil) frak(F)(F) xarrow(sym: <-, #cons) F compose frak(F)(F)
  $

#pause

- In the category of modules over a commutative ring $R$ under $R$-tensor products, list objects are tensor algebras:
  $
    1 xarrow(#nil) plus.o.big_n V^(times.o^n) xarrow(sym: <-, #cons) V times.o plus.o.big_n V^(times.o^n)
  $

#pause

- In the category of pointed spaces under smash product, list objects on connected spaces corresponds to the James construction:
  $
    1 xarrow(#nil) J(A) xarrow(sym: <-, #cons) A times J(A)
  $







== Limitations

1. We can only eliminate out of lone list objects.

  #pause

  - To define the list append function
    $
      app : L(A) times.o L(A) -> L(A)
    $
    we would need to curry the second argument to isolate the $L(A)$ on the left:
    $
      app : L(A) -> [L(A),L(A)]
    $
    but this requires internal homs.

#pause

#v(2em)

2. These list objects also do not necessarily coincide with free monoids.

  #pause

  - For example, every object of $(sans("Set"), union.sq, emptyset)$ is the free monoid on itself, but list objects on inhabited sets are always infinite:
    $
      mu X.emptyset union.sq A union.sq X quad=quad mu X. A union.sq X
    $



== Parametrised List Objects

To solve the first problem, we strengthen the universal property as follows:

#definition("Parametrised list objects", number: "2")[
  $
    #fletcher-diagram(
      cell-size: 30mm,
      spacing: 0mm,
      node((0, -1), $1$),
      node((2, -1), $L(A)$),
      node((4, -1), $A times.o L(A)$),
      edge((0, -1), (2, -1), label: $nil$, "->"),
      edge((4, -1), (2, -1), label: $cons$, "->"),
    )
  $
]

== Parametrised List Objects

To solve the first problem, we strengthen the universal property as follows:

#definition("Parametrised list objects", number: "2")[
  $
    #h(-2.85pt)
    #fletcher-diagram(
      cell-size: 30mm,
      spacing: 0mm,
      node((0, -1), $1$),
      node((0, 1), $P$),
      node((2, -1), $L(A)$),
      node((4, -1), $A times.o L(A)$),
      node((2, 1), $L$),
      node((4, 1), $A times.o L$),
      edge((0, -1), (2, -1), label: $nil$, "->"),
      edge((4, -1), (2, -1), label: $cons$, "->"),
      edge((0, 1), (2, 1), label: $n$, "->", label-side: right),
      edge((4, 1), (2, 1), label: $c$, "->", label-side: left),
    )
  $
]

// == Parametrised List Objects

// To solve the first problem, we strengthen the universal property as follows:

// #definition("Parametrised list objects", number:"2")[
//     $
//         #h(-2.85pt)
//         #fletcher-diagram(cell-size: 30mm, spacing: 0mm,
//         node((0, -1), $1$),
//         node((0, 1), $P$),
//         node((2, -1), $L(A)$),
//         node((4, -1), $A times.o L(A)$),
//         node((2, 1), $L$),
//         node((4, 1), $A times.o L$),

//         edge((0, -1), (2, -1), label: $nil$, "->"),
//         edge((4, -1), (2, -1), label: $cons$, "->"),

//         edge((0, 1), (2, 1), label: $n$, "->", label-side: right),
//         edge((4, 1), (2, 1), label: $c$, "->", label-side: left),


//         node((1, 0), $L(A) times.o P$),
//         node((3, 0), $L$),
//         edge((1, 0), (3, 0), label: $it(n, c)$, "-->"),
//       )
//     $
// ]

== Parametrised List Objects

To solve the first problem, we strengthen the universal property as follows:

#definition("Parametrised list objects", number: "2")[
  #v(-1.5pt)
  $
    #h(72.5pt)
    #fletcher-diagram(
      cell-size: (28.66mm, 30mm),
      spacing: 0mm,
      node((0, -1), $1 times.o P$),
      node((0, 1), $P$),
      node((2, -1), $L(A) times.o P$),
      node((4, -1), $A times.o L(A) times.o P$),
      node((2, 1), $L$),
      node((4, 1), $A times.o L$),
      edge((0, -1), (2, -1), label: $nil times.o P$, "->"),
      edge((4, -1), (2, -1), label: $cons times.o P$, "->"),
      edge((0, -1), (0, 1), "="),
      edge((2, -1), (2, 1), label: $it(n, c)$, "-->", label-side: left),
      edge((4, -1), (4, 1), label: $A times.o it(n, c)$, "-->", label-side: left),
      edge((0, 1), (2, 1), label: $n$, "->", label-side: right),
      edge((4, 1), (2, 1), label: $c$, "->", label-side: left),
    )
  $
]



== String Diagrams

$
  #h(72.5pt)
  #fletcher-diagram(
    cell-size: 25mm,
    spacing: 0mm,
    node((0, -1), $1 times.o P$),
    node((0, 1), $P$),
    node((2, -1), $L(A) times.o P$),
    node((4, -1), $A times.o L(A) times.o P$),
    node((2, 1), $L$),
    node((4, 1), $A times.o L$),
    edge((0, -1), (2, -1), label: $nil times.o P$, "->"),
    edge((4, -1), (2, -1), label: $cons times.o P$, "->"),
    edge((0, -1), (0, 1), "="),
    edge((2, -1), (2, 1), label: $it(n, c)$, "-->", label-side: left),
    edge((4, -1), (4, 1), label: $A times.o it(n, c)$, "-->", label-side: left),
    edge((0, 1), (2, 1), label: $n$, "->", label-side: right),
    edge((4, 1), (2, 1), label: $c$, "->", label-side: left),
  )
$

$
  #grid(
    align: (center, center),
    columns: (35%, 50%),
    gutter: 2em,
    image("diagrams/output-1.svg", width: 100%), image("diagrams/output-2.svg", width: 100%),
  )
$





== Using the iterator

We can now use this stronger universal property to define $app$ as an iterator.

#pause

$
  it(n, c) : L(A) times.o P -> L
$

- Since $app : L(A) times.o L(A) -> L(A)$, we have $L(A)$ as both the parameter $P$ and the target $L$.

- We now only need maps $n : L(A) -> L(A)$ and $c : A times.o L(A) times.o L(A)$.

  #pause



  #grid(
    align: (left, center),
    columns: (45%, 55%),
    gutter: 1em,
    [
      In Agda:

      ```haskell
      _append_ : List A -> List A -> List A
      nil append ys = ys
      (x cons xs) append ys = x cons (xs append ys)
      ```
    ],
    [
      #pause
      #align(horizon)[
        #v(1em)
        #grid(
          align: (left, right),
          columns: (35%, 50%),
          gutter: 0.5em,
          image("diagrams/output-1-1.svg", width: 100%), image("diagrams/output-2-1.svg", width: 100%),
        )
      ]
    ],
  )


  #pause

  so we pick $n = id$ and $c=cons$:
  $
    app := it(id, cons).
  $

// == Using the iterator

// Since the iterator is unique, we can also prove that two maps are equal by showing that they satisfy the two computation rules $nil$-$beta$ and $cons$-$beta$, and are hence the same iterator.

// #lemma[
//   The following maps $f,g:L(A) -> L(A)$ are equal:
//   #figure(
//     image("diagrams/output-10.svg", width: 45%),
//   )
// ]

// #pause

// _Proof_.
// We claim that both maps are the iterator $it(nil, cons)$.

// #pause

// The identity immediately satisfies both rules, so we have $g=it(nil, cons)$.

// ==

// We have $f$-$nil$-$beta$ by applying $app$-$nil$-$beta$:
// #align(center, image("diagrams/output-11.svg", width: 80%))
// #pause
// and similarly, $f$-$cons$-$beta$ from $app$-$cons$-$beta$:
// #align(center, image("diagrams/output-12.svg", width: 100%))
// #pause
// and hence $f=it(nil, cons)=g$.#qed()


== Monoids

The stronger universal property resolves the first limitation, allowing us more flexibility when eliminating from lists.
#pause
For the second limitation:

#v(-0.5em)

#theorem[
  $(L(A), nil, app)$ is the free monoid on $A$.
]

// #proofsketch[
//   The left unit law holds immediately by $++$-$nil$-$beta$:
//   #align(center, image("diagrams/output-9.svg", width: 40%))
//   and the previous lemma shows the right unit law. Associativity and the unique extension property are proved similarly using iterators.
// ]

#v(-1em)

#lemma[
  If $cal(C)$ admits parametrised list objects for every object, then $L(-)$ is a functor.
]
$
  f : A -> B quad mapsto quad (A ->^f B ->^(eta_B) L(B))^sharp : L(A) -> L(B)
$
// The functorial action on a morphism $f : A -> B$ is given by:
// $
//   (f compose eta_B)^sharp : L(A) -> L(B)
// $
// where
// #align(center,image("eta.svg", width: 15%))



// #pause
// $
//   #fletcher-diagram(cell-size: 12mm, spacing: 30mm,
//     node((0, 0), $cal(C)$),
//     node((-0.1, -0.5), $tack.l$),
//     node((0, -1), $Mon(cal(C))$),
//     edge((0, 0), (0, -1), label: $L$, "->", label-side: left, bend: 45deg),
//     edge((0, -1), (0, 0), label: $U$, "->", label-side: left),
//   )
// $

#theorem[
  If $cal(C)$ admits parametrised list objects for every object, then $Mon(cal(C))$ is monadic over $cal(C)$ via the evident forgetful functor.
]

// #v(-1em)

// #pause

#theorem([#cite(<fioreListObjectsAlgebraic2017>, form: "author")#cite(<fioreListObjectsAlgebraic2017>)])[
  If $(cal(C),times,1)$ is cartesian monoidal, then the induced monad is strong.
]


// == The Cartesian Setting

// #theorem[
//   If $(cal(C),times,1)$ is cartesian monoidal, and $L(A)$ is a list object, then $L(A)$ satisfies the following stronger universal property:

//   For every $L$ with maps $P ->^n L <-^c A times L times P$, there exists a _doubly parametrised iterator_:
//   $
//     caron(it)(n,c) : L(A) times P -> L
//   $
//   such that the following computation rules hold:

//   $
//     #grid(
//       align: (center, center),
//       columns: (35%, 50%),
//       gutter: 2em,
//       image("diagrams/output-3.svg", width: 100%), image("diagrams/output-4.svg", width: 100%),
//     )
//   $
// ]


// #theorem[
//   If $(cal(C),times,1)$ is cartesian monoidal, then the induced monad is strong.
// ]

// A construction of the right strength $tau_(A,B):L(A) times B -> L(A times B)$ is as follows.

// We can equip $L(A times B)$ with a doubly-parametrised list algebra structure using:
// - $n := B ->^! 1 ->^nil L(A times B)$
// - $c := A times L(A times B) times B ->^tilde.equiv A times B times L(A times B) ->^cons L(A times B)$.
// From the strong universal property, we obtain a map
// $
//   tau_(A,B) := caron(it)(n,c) : L(A) times B -> L(A times B)
// $



== Symmetric Lists

Hereafter, the ambient category is symmetric strict monoidal.

#definition("Symmetric list objects", number: "3")[
  #align(center, image("diagrams/output-5.svg", width: 65%))
  A (_parametrised_) _symmetric list object_ or _ilst_ on $A$ is a list object $L(A)$ satisfying the additional axiom above, and with the corresponding universal property.
]

#speaker-note("Can only eliminate into symmetric list algebras instead of ordinary list algebras.")


== Symmetric Lists

Hereafter, the ambient category is symmetric strict monoidal.

#definition("Symmetric list objects", number: "2")[
  #v(19pt)
  $
    #grid(
      align: (center + horizon, center),
      columns: (1fr, 1fr),
      gutter: 1em,
      image("diagrams/output-5-1.svg", width: 100%),
      [
        ```haskell
        data Ilst (A : Set) : Set where
          [] : Ilst A
          _::_ : A → Ilst A → Ilst A
          swap : (a b : A) → (xs : Ilst A) → a :: b :: xs ≡ b :: a :: xs
        ```
      ],
    )
  $
  #v(20pt)
  A (_parametrised_) _symmetric list object_ or _ilst_ on $A$ is a list object $L(A)$ satisfying the additional axiom above, and with the corresponding universal property.
]

In Agda:
```haskell
data Ilst (A : Set) : Set where
  nil : Ilst A
  _cons_ : A -> Ilst A -> Ilst A
  swap : (a b : A) -> (xs : Ilst A) -> a cons b cons xs = b cons a cons xs
```











== Symmetric Lists

#theorem(number: "5")[
  Let $(L(A), nil, cons)$ be a list object on $A$. Then, the following are equivalent:

  1. $(L(A), nil, cons)$ is a symmetric list object;
  2. $(L(A), nil, app)$ is a commutative monoid object;
  3. $(L(A), nil, cons)$ is the free commutative monoid object on $A$.
]

== Symmetric Lists

#theorem(number: "5")[
  Let $(L(A), nil, cons)$ be a list object on $A$. Then, the following are equivalent:

  1. $(L(A), nil, cons)$ is a symmetric list object;
  2. $(L(A), nil, app)$ is a commutative monoid object;
  3. $(L(A), nil, cons)$ is the free commutative monoid object on $A$.
]

_Proof_. $(1 => 2)$ We already have that list objects are monoids, so we need only show that $app$ is commutative:
#v(-1em)
#align(center, image("diagrams/output-33.svg", width: 50%))
#v(-1em)
Call the two maps $f$ and $g$, respectively.

==

The left map $f$ is $app:=it(id, cons)$ by definition, so, by the uniqueness of the iterator, it suffices to show that the braided version satisfies the same computation rules:
#align(center, image("diagrams/output-34.svg", width: 45%))

#align(center + horizon, [
  #grid(
    align: (right, left),
    columns: (50%, 50%),
    gutter: 6em,
    image("diagrams/output-34-1.svg", width: 100%), image("diagrams/output-34-2.svg", width: 60%),
  )
  #align(bottom, qed())
])






==

#theorem[
  If $cal(C)$ admits symmetric list objects for every object, then $CMon(cal(C))$ is monadic over $cal(C)$ via the evident forgetful functor.
]

==

#theorem[
  If $(cal(C),times,1)$ is cartesian monoidal, and $L(A)$ is a list object, then $L(A)$ satisfies the following stronger universal property:

  For every $L$ with maps $P ->^n L <-^c A times L times P$, there exists a _doubly parametrised iterator_:
  $
    caron(it)(n,c) : L(A) times P -> L
  $
  such that the following computation rules hold:

  $
    #grid(
      align: (center, center),
      columns: (35%, 50%),
      gutter: 2em,
      image("diagrams/output-3.svg", width: 100%), image("diagrams/output-4.svg", width: 100%),
    )
  $
]



#theorem[
  If $(cal(C),times,1)$ is cartesian monoidal, then the induced monad is strong, and further, commutative.
]


== Further Work

#align(horizon)[
  #grid(
    columns: (4fr, 2fr),
    [
      - Symmetric trees
      - General theory of parametrised inital algebras
      - Symmetric list models of linear logic
      - Operads
    ],
    [
      #align(center + horizon, image("abstract.png", width: 80%))
      #align(center + horizon, [Extended abstract with proofs])
    ],
  )
]


== Summary

#align(horizon)[
  #grid(
    columns: (4fr, 2fr),
    [
      - List objects
      - Parametrised list objects
      - Iterator as induction
      - Strength in Cartesian setting
      - Symmetric lists
      - Strong universal property in Cartesian setting
      - Induced commutative monad
    ],
    [
      #align(center + horizon, image("abstract.png", width: 80%))
      #align(center + horizon, [Extended abstract with proofs])
    ],
  )
]








// Local Variables:
// typst-preview--master-file: t
// typst-preview-preview-mode: "slide"
// End:
