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
#let lemma = thmbox("theorem", "Lemma", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong,
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 0em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")
#let proofsketch = thmproof("proof", "Proof sketch")

// theme configuration
#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  config-common(
    show-bibliography-as-footnote: bibliography(title: none, "lists.bib"),
  ),
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
#let rec = math.op("rec")
#let nil = math.op("nil")
#let cons = math.op("cons")
#let it = math.op("it")
#let Mon = math.op("Mon")
#let CMon = math.op("CMon")
#let app = {
  math.plus
  h(-0.5em)
  math.plus
}

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
      nil : List A
      cons : A -> List A -> List A
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
Alternatively, if we have a natural numbers object, sigma types, and functions out of $sans("Fin")_n$, we can construct lists as:
$
  sum_(n:bb(N)) A^(sans("Fin")_n)
$
We can also construct lists as initial algebras of the following functor:
$
  F(X) = 1 + A times X
$
but this requires an initial object, and for the colimit of the following $omega$-chain to exist:
$
  0 -> F(0) -> F F(0) -> F F F(0) -> ...
$


== Natural Numbers Objects

Lawvere #cite(<lawvereElementaryTheoryCategory1964>) introduced natural numbers objects in his axiomatisation of structural set theory (ETCS).

This definition makes sense in categories without general products or coproducts

$
  #fletcher-diagram(cell-size: 12mm, spacing: 10mm, node((0, 0), $1$), node((2, -1), $N$), node((4, -1), $N$), node((2, 1), $X$), node((4, 1), $X$), edge((0, 0), (2, -1), label: $0$, "->"), edge((0, 0), (2, 1), label: $x$, "->", label-side: right), edge((4, -1), (2, -1), label: $s$, "->"), edge((2, -1), (2, 1), label: $rec(x, r)$, "-->", label-side: left), edge((4, -1), (4, 1), label: $rec(x, r)$, "-->", label-side: left), edge((4, 1), (2, 1), label: $r$, "->", label-side: left))
$

== List Objects

We can adapt this universal property to axiomatise list objects in arbitrary monoidal categories:

#v(-0.5em)

#definition[
  A _list object_ on an object $A$ is:
  - an object $L(A)$ with maps $1 ->^nil L(A) <-^cons A times.o L(A)$, such that;
  - for every $L$ with maps $1 ->^n L <-^c A times.o L$, there exists a unique _mediating map_ or _iterator_
  $
    it (n,c): L(A) times.o P -> L
  $
  such that the following diagram commutes:
  $
    #fletcher-diagram(spacing: 8mm, node((0, 0), $1$), node((2, -1), $L(A)$), node((4, -1), $A times.o L(A)$), node((2, 1), $L$), node((4, 1), $A times.o L$), edge((0, 0), (2, -1), label: $nil$, "->"), edge((4, -1), (2, -1), label: $cons$, "->"), edge((2, -1), (2, 1), label: $it(n, c)$, "-->", label-side: left), edge((4, -1), (4, 1), label: $it(n, c)$, "-->", label-side: left), edge((0, 0), (2, 1), label: $n$, "->", label-side: right), edge((4, 1), (2, 1), label: $c$, "->", label-side: left))
  $
]












== Examples of list objects in nature

- In a category of endofunctors with monoidal structure given by functor composition, list objects are free monad:
  $
    nil = ? , quad cons = ?, quad it(n, c) = ?
  $
- In the category of modules over a commutative ring $R$ under $R$-tensor products, list objects are tensor algebras:
  $
    nil = ? , quad cons = ?, quad it(n, c) = ?
  $
- In the category of pointed spaces under smash product, list objects on connected spaces corresponds to the James construction:
  $
    nil = ? , quad cons = ?, quad it(n, c) = ?
  $







== Limitations

We can only eliminate out of list objects alone.
- To define list append:
  $
    app : L(A) times.o L(A) -> L(A)
  $
  we need to curry the second argument:
  $
    app : L(A) -> L(A)^(L(A))
  $
  but this requires $L(A)$ to be exponentiable.

#v(2em)

These list objects also do not necessarily coincide with free monoids.

- For example, every object of $(sans("Set"), union.sq, emptyset)$ is the free monoid on itself, but list objects are always infinite:
  $
    mu X.emptyset union.sq A union.sq X quad=quad mu X. A union.sq X
  $



== Parametrised List Objects

To solve the first problem, we strengthen the universal property as follows:


#definition[
  A _parametrised_ list object on an object $A$ is:
  - an object $L(A)$ with maps $1 -->^(nil) L(A) <--^(cons) A times.o L(A)$, such that;
  - for any $L$ with maps $P -->^n L <--^c A times.o L$, there exists a unique map
    $
      it (n,c): L(A) times.o P-> L
    $
    such that the following diagram commutes:
    $
      #fletcher-diagram(spacing: 10mm, node((0, -1), $1 times.o P$), node((0, 1), $P$), node((2, -1), $L(A) times.o P$), node((4, -1), $A times.o L(A) times.o P$), node((2, 1), $L$), node((4, 1), $A times.o L times.o P$), edge((0, -1), (2, -1), label: $nil times.o P$, "->"), edge((2, -1), (4, -1), label: $cons times.o P$, "->"), edge((0, -1), (0, 1), "="), edge((2, -1), (2, 1), label: $it(n, c)$, "-->", label-side: left), edge((4, -1), (4, 1), label: $it(n, c)$, "-->", label-side: left), edge((0, 01), (2, 1), label: $x$, "->", label-side: right), edge((2, 1), (4, 1), label: $r$, "->", label-side: right))
    $
]

== Parametrised List Objects

To solve the first problem, we strengthen the universal property as follows:


#definition[
  A _parametrised_ list object on an object $A$ is:
  - an object $L(A)$ with maps $1 -->^(nil) L(A) <--^(cons) A times.o L(A)$, such that;
  - for any $L$ with maps $P -->^n L <--^c A times.o L$, there exists a unique map
    $
      it (n,c): L(A) times.o P-> L
    $
    such that the following two computation rules hold:

  #grid(
    align: (center, center),
    columns: (35%, 50%),
    gutter: 2em,
    image("diagrams/output-1.svg", width: 100%), image("diagrams/output-2.svg", width: 100%),
  )
]






== Using the iterator

We can now use this stronger universal property to define $app$ as an iterator:

- Since $app : L(A) times.o L(A) -> L(A)$, we have $L(A)$ as both the parameter $P$ and the target $L$.
  We now only need maps $n : L(A) -> L(A)$ and $c : A times.o L(A) times.o L(A)$.

  In Agda:

  ```haskell
  _++_ : List A -> List A -> List A
  [] ++ ys          = ys
  (x :: xs) ++ ys = x :: (xs ++ ys)
  ```
  so we pick $n = id$ and $c=cons$:
  $
    app = it(id, cons).
  $



== Using the iterator

Since the iterator is unique, we can also prove that two maps are equal by showing that they satisfy the two computation rules $nil$-$beta$ and $cons$-$beta$, and are hence the same iterator.

#lemma[
  The following maps $f,g:L(A) -> L(A)$ are equal:
  #figure(
    image("diagrams/output-10.svg", width: 45%),
  )
]

#proof[
  We claim that both maps are the iterator $it(nil, cons)$.

  The identity immediately satisfies both rules, so we have $g=it(nil, cons)$.

  #v(2em)

  We have $f$-$nil$-$beta$ by applying $app$-$nil$-$beta$:
  #align(center, image("diagrams/output-11.svg", width: 80%))
  and similarly, $f$-$cons$-$beta$ from $app$-$cons$-$beta$:

  #align(center, image("diagrams/output-12.svg", width: 100%))
  and hence $f=it(nil, cons)=g$.
]

== Free monoids

The stronger univeral property resolves the first limitation, allowing us more flexibility when eliminating from lists.

For the second limitation:

#theorem[
  $(L(A), nil, app)$ is the free monoid on $A$.
]

#proofsketch[
  The left unit law holds immediately by $++$-$nil$-$beta$:
  #align(center, image("diagrams/output-9.svg", width: 40%))
  and the previous lemma shows the right unit law. Associativity and the unique extension property are proved similarly using iterators.
]

#theorem[
  If $cal(C)$ admits parametrised list objects for every object, then $Mon(cal(C))$ is monadic over $cal(C)$ via the evident forgetful functor.
]


== The Cartesian Setting

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
  If $(cal(C),times,1)$ is cartesian monoidal, then the induced monad is strong.
]

A construction of the right strength $tau_(A,B):L(A) times B -> L(A times B)$ is as follows.

We can equip $L(A times B)$ with a doubly-parametrised list algebra structure using:
- $n := B ->^! 1 ->^nil -> L(A times B)$
- $c := A times L(A times B) times B ->^tilde.equiv A times B times L(A times B) ->^cons L(A times B)$.
From the strong universal property, we obtain a map
$
  tau_(A,B) := caron(it)(n,c) : L(A) times B -> L(A times B)
$


== Symmetric Lists

Hereafter, assume the ambient category is symmetric strict monoidal.

#definition[
  A (_parametrised_) _symmetric list object_ or _ilst_ on $A$ is a list object $L(A)$ with the following additional axiom:
  #align(center, image("diagrams/output-5.svg", width: 65%))
  and satisfying the corresponding universal property.
]

== Symmetric Lists

#theorem[
  Let $(L(A), nil, cons)$ be a list object on $A$. Then, the following are equivalent:

  1. $(L(A), nil, cons)$ is a symmetric list object;
  2. $(L(A), nil, app)$ is a commutative monoid object;
  3. $(L(A), nil, cons)$ is the free commutative monoid object on $A$.
]


== Symmetric Lists

#theorem[
  If $cal(C)$ admits parametrised list objects for every object, then $CMon(cal(C))$ is monadic over $cal(C)$ via the evident forgetful functor.
]

#theorem[
  If $(cal(C),times,1)$ is cartesian monoidal, then the induced monad is strong, and further, commutative.
]


== Bilinear maps


== Counterexamples



#todo[example of category where omega chains don't exist but list objects exist]
