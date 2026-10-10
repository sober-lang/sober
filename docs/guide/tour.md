# Language tour

English | [日本語](tour.ja.md)

A tour of the Sober language in short working examples, for people who can write Go or Rust. The example in each section is a real file in `examples/`; the verification net builds and runs it every time and checks the output (`sober build examples/<name>.sober -o a && ./a` gives the same result).

The "Differences from Go" at the end of each section covers, in a line or two, only the points where people coming from Go first stumble.

## 1. Values, bindings, expressions

```sober
// examples/tour_01_values.sober
package main

// Tour 1: values, bindings, expressions (docs/guide/tour.md)

func sign(n int) string {
    // if is an expression — it returns a value
    return if n < 0 { "negative" } else if n == 0 { "zero" } else { "positive" }
}

func size(n int) string {
    // so is switch
    return switch {
    case n < 10: "small"
    case n < 1000: "medium"
    default: "large"
    }
}

func main() int {
    x := 40                // bindings are immutable by default
    mut total := 0         // mut for a binding that changes
    total += x
    total += 2
    // a block has a value too (its last expression)
    y := {
        t := total * 2
        t + 1
    }
    println("total = ${total}, y = ${y}")
    println(sign(0 - 3), sign(0), sign(7))
    println(size(5), size(500), size(50000))
    return 0
}
```

Output:

```
total = 42, y = 85
negative zero positive
small medium large
```

- Bindings are immutable by default. Only bindings that change get `mut`. You cannot create another binding with the same name (shadowing).
- if, switch and blocks have values (the last expression is the value). No temporary `mut` is needed to choose a value.
- `switch` works both as a list of conditions (`switch { case … }`) and as a branch on a value (`switch x { … }`).

Differences from Go: where you would write `var x T; if c { x = a } else { x = b }`, you write `x := if c { a } else { b }`. There is no ternary operator (if plays that role).

## 2. Functions, multiple results, lambdas, pipes

```sober
// examples/tour_02_functions.sober
package main

// Tour 2: functions, multiple results, lambdas, pipes (docs/guide/tour.md)

// returns two results
func divmod(a int, b int) (int, int) {
    return a / b, a % b
}

func add(a int, b int) int {
    return a + b
}

func twice(f func(int) int, x int) int {
    return f(f(x))
}

func main() int {
    q, r := divmod(17, 5)
    println("17 = 5 * ${q} + ${r}")
    // multiple results flow through a pipe into the next call (_ is a hole)
    s := divmod(17, 5) |> add(_, _)
    println(s)
    // a pipe feeds the first argument by default
    n := 3 |> add(10)
    println(n)
    // a lambda
    println(twice((v) => v * 3, 2))
    return 0
}
```

Output:

```
17 = 5 * 3 + 2
5
13
18
```

- Multiple results work as in Go: a function returns several results. They are received only by destructuring (`q, r := …`) or as the arguments after a pipe (`|> add(_, _)`); they are never stored in a variable as a tuple.
- `x |> f(a)` is `f(x, a)`. To put the value in a different position, write the hole `_`.
- The lambda `(v) => v * 3` is a function value. The function type is `func(int) int`.

Differences from Go: there are no methods. Instead of `x.f(a)`, write `x |> f(a)`.

## 3. Slices, maps, for

```sober
// examples/tour_03_collections.sober
package main

import "std/iter"

// Tour 3: slices, maps, for (docs/guide/tour.md)

func main() int {
    // Build a slice with mut, then freeze it to pass it around immutably
    mut xs := mut []int{}
    for i <- iter.Range(1, 6) {
        xs = append(xs, i * i)
    }
    squares := freeze(xs)
    println(len(squares), squares[0], squares[4])

    // for ... yield is a lazy producer (Iter) — consume it through a pipe, not a variable
    println(for v <- squares if v % 2 == 0 yield v |> iter.Sum)

    // map: a lookup is T? (nil when absent)
    mut ages := mut map[string]int{}
    ages["ada"] = 36
    ages["alan"] = 41
    a := ages["ada"]
    if a != nil {
        println("ada is ${a}")
    }
    println(ages["grace"] == nil)
    return 0
}
```

Output:

```
5 1 25
20
ada is 36
true
```

- The basic flow is to build a slice with `mut` and make it immutable with `freeze`. A frozen value can be passed as is to parallel tasks.
- `for … yield` makes a lazy producer (`Iter`). It is consumed after a pipe (`|> iter.Sum` and so on), not stored in a variable.
- A map lookup is `T?`. It is `nil` when the key is absent; check with `!= nil` before using it as a value.

Differences from Go: a map lookup never "returns the zero value" — absence is expressed by `nil`.

## 4. Structs, unions, generics, dictionaries

```sober
// examples/tour_04_types.sober
package main

// Tour 4: structs, unions, generics, dictionaries (docs/guide/tour.md)

type Point struct {
    x, y int
}

// A union (sum type) — take it apart with an exhaustive switch
type Shape union {
    Rect { w, h int }
    Circle { r int }
}

func area(s Shape) int {
    return switch s {
    case Rect{w, h}: w * h
    case Circle{r}: 3 * r * r
    }
}

// Instead of methods: pass a struct of function values (a dictionary) explicitly
type Ord[T] struct {
    less func(T, T) bool
}

func min[T](a T, b T, ord Ord[T]) T {
    return if ord.less(b, a) { b } else { a }
}

const ByX = Ord[Point]{less: (a, b) => a.x < b.x}

func main() int {
    p := Point{x: 3, y: 4}
    q := Point{x: 1, y: 9}
    println(p.x + p.y)
    println(area(Rect{w: 2, h: 5}), area(Circle{r: 2}))
    m := min(p, q, ByX)
    println(m.x, m.y)
    return 0
}
```

Output:

```
7
10 12
1 9
```

- A union (sum type) is a collection of named variants. You take it apart with `switch`, and a missing variant is a compile error.
- The type argument of a generic like `min[T](…)` is normally inferred from the arguments.
- Instead of interfaces, you explicitly pass a struct whose fields are function values (a dictionary). There is no implicit resolution of implementations — which implementation is used is written at the call site.

Differences from Go: there is neither `interface` nor implicit satisfaction. Instead of making a type that satisfies `sort.Interface`, pass an `Ord[T]{less: …}`.

## 5. Errors — labels, `?`, `catch`, switch

```sober
// examples/tour_05_errors.sober
package main

// Tour 5: errors — labels, ?, catch, switch (docs/guide/tour.md)

type Empty error

type BadDigit error {
    at int
}

func parse(s []byte) (int, error?) {
    if len(s) == 0 {
        return 0, Empty{}
    }
    mut n := 0
    mut i := 0
    while i < len(s) {
        c := int(s[i])
        if c < 48 || c > 57 {
            return 0, BadDigit{at: i}
        }
        n = n * 10 + c - 48
        i += 1
    }
    return n, nil
}

// ? returns an error to the caller as is
func sum2(a []byte, b []byte) (int, error?) {
    x := parse(a)?
    y := parse(b)?
    return x + y, nil
}

func main() int {
    // catch supplies a default value
    println(parse(bytes("42")) catch -1)
    println(parse(bytes("4x2")) catch -1)
    // handle each label with switch (the analyzer checks exhaustiveness)
    _, err := sum2(bytes("12"), bytes(""))
    if err != nil {
        switch err {
        case Empty{}: println("empty input")
        case BadDigit{at}: println("bad digit at ${at}")
        }
    }
    return 0
}
```

Output:

```
42
-1
empty input
```

- Errors are labels (`type Empty error`, or with fields, `type BadDigit error { at int }`), and functions return them as `(T, error?)`.
- `f()?` returns an error to the caller as is. `f() catch D` turns an error into the default value `D` (you can also leave, as in `catch return 1`).
- `switch err` handles each label. The analyzer derives which labels can be returned from the call graph, and unhandled labels are rejected (public functions declare the labels they can return).

Differences from Go: most `if err != nil { return err }` become the single character `?`. Instead of `errors.Is` / `errors.As`, cover every case with `switch err`.

## 6. mut arguments and freeze

```sober
// examples/tour_06_mut.sober
package main

// Tour 6: mut arguments and freeze (docs/guide/tour.md)

// A function that rewrites the caller's mut local says mut on the parameter and at the call site
func push3(xs mut []int, v int) {
    xs = append(xs, v)
    xs = append(xs, v)
    xs = append(xs, v)
}

type Counter struct {
    n int
}

func bump(c mut Counter) {
    c.n += 1
}

func main() int {
    mut xs := mut []int{}
    push3(mut xs, 7)
    println(len(xs))
    mut c := Counter{n: 0}
    bump(mut c)
    bump(mut c)
    println(c.n)
    // freeze when done building — from then on it can be shared as immutable
    ys := freeze(xs)
    println(ys[0] + ys[1] + ys[2])
    return 0
}
```

Output:

```
3
2
21
```

- A function that rewrites the caller's variable says `mut` on the parameter, and the call site says `f(mut x)` too. Where and what gets rewritten is visible in the source.
- There are no pointers. There are no lifetime annotations or borrowing rules either — rewriting happens only where `mut` is marked, and to share, you pass a frozen immutable value.

Differences from Go: use `mut` arguments instead of `*T` and `&x`. Values mean what they mean in Go: "just values".

## 7. Parallelism — structured concurrency, channels

```sober
// examples/tour_07_parallel.sober
package main

import "std/iter"
import "std/par"

// Tour 7: parallelism — structured concurrency, channels (docs/guide/tour.md)

func fib(n int) int {
    return if n < 2 { n } else { fib(n - 1) + fib(n - 2) }
}

func main() int {
    // par.Map: one task per element — results come back in input order
    mut ns := mut []int{}
    for i <- iter.Range(20, 26) {
        ns = append(ns, i)
    }
    fs, err := par.Map(freeze(ns), (n) => fib(n))
    if err != nil {
        return 1
    }
    for f <- fs {
        println(f)
    }
    // par.Scope: child tasks always join before the scope ends
    r, e := par.Scope((s par.S) => {
        a := par.Spawn(s, () => fib(24))
        b := par.Spawn(s, () => fib(25))
        par.Join(a) + par.Join(b)
    })
    if e == nil {
        println(r)
    }
    // channels
    r2, e2 := par.Scope((s par.S) => {
        tx, rx := par.NewChan[int](cap: 4)
        h := par.Spawn(s, (out) => {
            for i <- iter.Range(1, 4) {
                par.Send(out, i * 10)
            }
            par.Close(out)
            0
        }, give: tx)
        // for-Recv: receive until the channel is closed
        mut got := 0
        for v <- par.Recv(rx) {
            got += v
        }
        par.Join(h) + got
    })
    if e2 == nil {
        println(r2)
    }
    return 0
}
```

Output:

```
6765
10946
17711
28657
46368
75025
121393
60
```

- `par.Map` creates a task per element, and the results come back in input order.
- Children spawned with `par.Spawn` inside a `par.Scope` always join before the scope ends (there are no abandoned goroutines).
- Only immutable values or channels can be passed to a child. Data races cannot be written.
- The output is deterministic: changing the number of workers (`SOBER_WORKERS`) leaves standard output byte-for-byte the same.
- A channel is made with `par.NewChan`, and the sending end is handed to a child with `give:`. `for v <- par.Recv(rx)` receives until the channel is closed.

Differences from Go: use `par.Scope` + `par.Spawn` + `par.Join` instead of `go f()` and `sync.WaitGroup`. Changing `GOMAXPROCS` does not change the order of the output.

## 8. Tests

Each `func TestXxx()` in a `*_test.sober` file inside a package is a test. `sober test <package>` runs them, one process per test. See [Your first program](first-program.md#write-tests) for how to write them.

## Where next

- A map of the standard library: [Standard library guide](std.md)
- Why things are shaped this way: [design notes](../design-notes/) (in Japanese)
- Exact definitions: [language specification](../language.md), [syntax](../syntax.md) (for developers, in Japanese)
