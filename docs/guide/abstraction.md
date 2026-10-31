# Abstraction — instead of interfaces

English | [日本語](abstraction.ja.md)

Sober has no interfaces, classes or methods. Swapping behavior means swapping functions, and there is no machinery beyond that.

This page shows how to write in Sober what you wrote with interfaces (or traits, type classes, abstract classes) in other languages. There are only three shapes.

| What you want | The shape in Sober | Section |
| --- | --- | --- |
| swap one function | a named function type and closures | 1 |
| swap a group of functions | a struct with function fields (a dictionary) | 2 |
| branch on one of a fixed set of kinds | a union and a type-pattern switch | 3 |

Before this page: sections 2 (lambdas) and 4 (structs, unions, dictionaries) of the [Language tour](tour.md).

## 1. One function — a named function type and closures

A std/http handler is not an interface but a named function type:

```sober
type Handler func(r Request) Response
```

To swap a handler, pass another function. When it needs state, a closure captures that state, and what it captures is written on the line that builds the closure.

```sober
// examples/abstraction_handler.sober
package main

// Abstraction 1 and 2: a named function type (http.Handler) built by closures, and a struct of
// function fields (http.Middleware) (docs/guide/abstraction.md). The requests are fed from a string
// instead of the network, and each response is printed (the form of examples/http_router)

import "std/http"

func or(s string?) string {
    return if s != nil { s } else { "-" }
}

// stops a request without X-Token (only `before` is given; `after` is left out)
const Auth = http.Middleware{before: (r) => if http.Header(r, "x-token") == nil { http.Status(401) } else { nil }}

// a Handler that answers with `word`: the closure captures `word` on this line
func greeter(word string) http.Handler {
    return (r) => http.Text("${word}, ${or(http.Param(r, "name"))}\n")
}

func routes() []http.Route {
    return http.Mount("", []http.Route{
        http.Route{method: "GET", path: "/hello/:name", handler: greeter("hello")},
        http.Route{method: "GET", path: "/bye/:name", handler: greeter("see you")}}, []http.Middleware{Auth})
}

func main() {
    reqs := "GET /hello/ann HTTP/1.1\r\nX-Token: t\r\n\r\n" +
        "GET /bye/bob HTTP/1.1\r\nX-Token: t\r\n\r\n" +
        "GET /hello/eve HTTP/1.1\r\nConnection: close\r\n\r\n"
    rs := routes()
    e := http.ServeWith((k) => feed(reqs, k), (b) => show(b), (r) => http.Dispatch(rs, r))
    println(e == nil)
}

func feed(s string, k func([]byte)) error? {
    k(bytes(s))
    return nil
}

// prints a response without the CR at the end of each line
func show(b []byte) error? {
    mut out := mut []byte{}
    for x <- b {
        if x != '\r' {
            out = append(out, x)
        }
    }
    println(string(freeze(out)) catch "?")
    return nil
}
```

Output:

```
HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 11

hello, ann
HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 13

see you, bob
HTTP/1.1 401 Unauthorized
Cache-Control: private
Content-Length: 0
Connection: close


true
```

- `greeter` is a function that returns an `http.Handler`. The closure it returns captures `word`, and the `return` line shows what it captured. `greeter("hello")` and `greeter("see you")` are two handlers of the same shape.
- `Auth` is the shape of section 2 (a struct with function fields): it gives `before` only and leaves `after` out.
- To print the responses, the requests come from a string instead of the network (`feed` / `show`). A real server passes the same `Dispatch` to `http.Serve`.

## 2. A group of functions — a struct with function fields (a dictionary)

Instead of an interface with several methods, pass a struct whose fields are functions, as a value. Such a struct is called a dictionary (`Ord[T]` in section 4 of the [Language tour](tour.md) has the same shape).

```sober
// examples/abstraction_dict.sober
package main

// Abstraction 2: a struct of function fields (a dictionary) in place of an interface with several
// methods. Each implementation is a value; state is captured by the closures on the line that
// builds them, and a field that an implementation may leave out is optional (docs/guide/abstraction.md)

type Note func(qty int) string

type Pricing struct {
    name string
    price func(unit int, qty int) int
    // optional: an implementation without a note leaves it out
    note Note?
}

// an implementation with no state, written as a const
const Flat = Pricing{name: "flat", price: (unit, qty) => unit * qty}

// an implementation with state: `over` and `off` are captured here, in plain sight
func bulk(over int, off int) Pricing {
    return Pricing{
        name: "bulk",
        price: (unit, qty) => if qty > over { unit * qty * (100 - off) / 100 } else { unit * qty },
        note: (qty) => if qty > over { "${off}% off over ${over}" } else { "no discount" }}
}

// takes any implementation: which one is used is written at each call
func quote(p Pricing, unit int, qty int) {
    n := p.note
    extra := if n != nil { " (${n(qty)})" } else { "" }
    println("${p.name}: ${p.price(unit, qty)}${extra}")
}

func main() {
    quote(Flat, 120, 10)
    b := bulk(5, 20)
    quote(b, 120, 10)
    quote(b, 120, 3)
}
```

Output:

```
flat: 1200
bulk: 960 (20% off over 5)
bulk: 360 (no discount)
```

- An implementation is a value. One without state is a `const` (`Flat`); one with state is built by a function that puts closures into the fields (`bulk`). Only the two lines inside `bulk` capture `over` and `off`.
- A field that some implementations may leave out is marked `?` (`note Note?`). Function types have no zero value, so the only way to say a field may be left out is in its type. The caller checks for `nil` before calling it.
- Which implementation is used is written at the call (`quote(Flat, …)` / `quote(b, …)`).

A real-size example (a route table, Mount / Merge, middleware before / after) is [`examples/http_router.sober`](../../examples/http_router.sober).

## 3. One of a fixed set of kinds — a union and a type-pattern switch

When the set of kinds is closed (payment methods, shapes, kinds of token…) and each kind behaves differently, make it a union and branch with a switch.

```sober
// examples/abstraction_union.sober
package main

// Abstraction 3: a closed set of kinds as a union, taken apart with a type-pattern switch
// (docs/guide/abstraction.md). Adding a variant makes every switch that misses it a compile error

type Payment union {
    Card { last4 string }
    Cash {}
    Points { n int }
}

func describe(p Payment) string {
    return switch p {
    case Card{last4}: "card ending ${last4}"
    case Cash{}: "cash"
    case Points{n}: "${n} points"
    }
}

// the fee in yen: only cards cost something
func fee(p Payment, amount int) int {
    return switch p {
    case Card{}: amount * 3 / 100
    case Cash{}: 0
    case Points{}: 0
    }
}

func main() {
    ps := []Payment{Card{last4: "4242"}, Cash{}, Points{n: 500}}
    for p <- ps {
        println("${describe(p)}: fee ${fee(p, 1000)}")
    }
}
```

Output:

```
card ending 4242: fee 30
cash: fee 0
500 points: fee 0
```

A switch that misses even one variant of the union is a compile error, so when you add a kind, the compiler names every switch you need to fix.

```sober
// examples/abstraction_union_neg.sober
package main

// Abstraction 3, rejected: a switch on a union that misses a variant (docs/guide/abstraction.md)

type Payment union {
    Card { last4 string }
    Cash {}
    Points { n int }
}

func describe(p Payment) string {
    return switch p {
    case Card{last4}: "card ending ${last4}"
    case Cash{}: "cash"
    }
}

func main() {
    println(describe(Cash{}))
}
```

Rejected:

```
sober: error at examples/abstraction_union_neg.sober:12:12 (NonExhaustive): switch does not cover every variant of the union — add the missing cases or a default (missing: Points)
```

A `default` arm turns that check off for its switch. For a switch you want to revisit when a kind is added, list every variant (like `fee`).

## 4. What you lose and what you gain

What you lose:

- **There is no `this`: these are not objects.** A struct with function fields looks like a C struct of function pointers, but nothing passes the struct itself as the first argument (`this` / `self`). State is captured by closures, explicitly, on the line that builds them
- method call syntax (`x.f()`) and growing a type by adding methods to it. There is not even Zig-style method syntax (functions in a struct's namespace, callable as `x.f()` as sugar): a call is always written one way, `f(x)`. No call gets two spellings, and the syntax never opens the door to the mental model that behavior belongs to data
- implicit satisfaction (Go interfaces, Haskell type class instance resolution): you pass the implementation as an argument every time

What you gain:

- **Which implementation is used is written at the call.** There is no implicit resolution to chase
- **What a closure captured is written on the line that builds it.** No hidden fields, no inherited state
- **No nil-interface trap.** Function types have no zero value, so "this field may be empty" shows in the type as `?`
- For a closed set of kinds, a union and a switch let the compiler find the cases you forgot

## 5. From other languages

| Language | What you wrote there | Sober |
| --- | --- | --- |
| Go | a one-method interface (`http.Handler`) | a named function type (`http.Handler` is a function type) |
| Go | an interface with several methods (`sort.Interface`) | pass a struct with function fields (`Ord[T]{less: …}`) |
| Rust | a trait with `impl Trait for T`, `dyn Trait` | pass a struct with function fields (a dictionary) as a value |
| Rust | `enum` and `match` | a union and a switch |
| TypeScript / React | passing `onClick` in props | the same shape (pass a function as a value): if you have written that, you can already write this |
| TypeScript | a discriminated union (a `kind` field) and `switch` | a union and a type-pattern switch |
| Java | passing a `Comparator` to `sort` | pass a function (or a struct with function fields): passing a `Comparator` is really passing a function |
| Java | an abstract class and subclasses | the common part as functions, the swappable part as function fields |
| Haskell | type classes (`Ord a =>`) | pass the dictionary by hand (the dictionary passing of type classes, written at the call instead of done by the compiler) |

In short, abstraction in Sober is the C struct of function pointers made type-safe, memory-safe and null-safe: function types have no zero value so a field that may be left out must be marked `?`, the region keeps whatever a closure captured alive, and the effects of a function show in its declaration.
