# Value orientation: the idea at the center of Sober

Sober is a value-oriented programming language. All a program names, by name, are values and the mutable bindings it rewrites. The language has no way to carry an address or a reference around as a value.

This document explains value orientation in one piece. It covers the following, in order.

1. The definition
2. How it differs from existing paradigms
3. What `mut` and `@effects` mean
4. The mechanisms that make value orientation hold
5. The design decisions it explains
6. Where it stands next to earlier ideas
7. Answers to "surely you can't write that"

The exact rules are in the [language specification](spec/README.ja.md) (in Japanese), the design pillars are in [DESIGN](../DESIGN.md), and the "why" behind individual decisions is in the [design notes](design-notes/README.md) (in Japanese).

## Definition

This document uses value orientation in the following sense.

- A program names values. There is no way to take out, store, or pass a place (an address, a reference, object identity) as a value. The specification's list of types has no pointer or reference type ([chapter 2](spec/02-types.ja.md), in Japanese)
- An immutable value cannot be observed by the program to have been copied or shared. This is not an optimization convenience; it is a promise of the language ([language.md, section 21](language.md), in Japanese; [section 31](language.md), in Japanese)
- Changes can be written. The place being rewritten is written as the name of a `mut`-marked binding, and the fields reached from it

Because of the second property, the implementation is free to choose how to pass a value and which region to place it in. Changing that choice does not change what the program means.

A mutable container (`mut []T`, `mut map[K]V`) has identity ([chapter 9, M-3](spec/09-memory.ja.md), in Japanese). This identity can be freely copied through bindings, struct fields, array elements and maps, and writing through any of the copies writes the same contents (an alias). The promise that holds for immutable values — that you cannot observe whether something was copied or shared — does not yet extend to mutable containers. Aliases can be written. This is where the design falls short of the definition of value orientation, and it is being pushed toward removal (a task left before 1.0). Some forms that would carry a write permission out across a call boundary are rejected by the checker: a form that returns the contents of a `mut` parameter, and a form where a value-becoming lambda captures a `mut` binding. These are covered in the next section. Not every such form is rejected — for example, passing two bindings that are aliases of each other as the `mut` arguments of the same call is accepted.

## How it differs from existing paradigms

The names functional, procedural, object-oriented and data-oriented do not capture what is central to Sober. This document looks at the difference along one axis: whether what the program names, by name, is a place or a value.

| | What is named | Change |
|---|---|---|
| Procedural (C) | A place. Addresses and the layout of memory are visible to the language | Writing to a place |
| Object-oriented (Java) | A place. Object identity and monitors are visible to the language | Rewriting an object's state |
| Functional | A value | Giving up change, or pushing it to the edge of the language |
| Sober | A value | What can be written through a `mut` binding, and inside a call passed with `mut` |

The history of languages reads as a history of widening what a program is allowed to observe. Once an observation has been shown and someone starts relying on it, the promise cannot be taken back ("How to read it" in the [related work note](design-notes/related-work.md), in Japanese). Sober does not put places on the observable surface; it shows only values and changes.

This is not opposed to data orientation. Building data out of tables and indices is just as natural to write in Sober (see "surely you can't write a graph or a data structure with cycles" below).

## `mut` and `@effects` write permissions

### `mut` is not a reference value

The `mut` at the head of a parameter's type is permission to rewrite the caller's mutable place, for the duration of that one call. The call site also writes `mut` ([chapter 3, V-4](spec/03-values.ja.md), in Japanese).

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

The specification describes the meaning of a `mut` parameter as "receives a reference to the caller's mutable place" (V-4). But this reference never becomes a value. The following rules exist precisely so that there is no way to carry the write permission out past the call.

- The contents of a `mut` parameter cannot be placed in a return value, assigned elsewhere, put in a field, or appended as an element ([chapter 3, V-6](spec/03-values.ja.md), in Japanese)
- A lambda used as a value cannot capture a `mut` binding ([chapter 5, F-10 and F-16](spec/05-functions.ja.md), in Japanese). Only a lambda that is inlined at its call site can capture one
- The only functions that can return a `mut` value are ones whose parameter is itself a `mut` parameter or a function-typed parameter ([language.md, section 26](language.md), in Japanese)
- Two `mut` arguments of the same call never overlap. If a `mut` and an immutable argument overlap, the immutable side sees the value from before the call ([chapter 3, V-5](spec/03-values.ja.md), in Japanese)

### How this differs from Rust's `&mut`

Rust's `&mut T` is a value with a type. It can be put in a variable, stored in a struct, and returned from a function (storing it in a struct needs a lifetime annotation `'a`). A reference has to carry its validity period in its type, and storing it in a struct needs an annotation ([The Rust Book, chapter 4](https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html)).

Sober's `mut` has no entity you can carry around. The permission is granted at the call site and disappears when the call returns. That is why no lifetime annotation is needed.

### A real case: changing how a large argument is passed did not change what it meant

The way a large immutable struct is passed was once changed, from copying the value to passing an address. This applies to immutable structs, unions and `T?` over 8 words that do not contain a map ([ir.md, section 6](ir.md), in Japanese). Not one line of the language's rules changed. The rule that an immutable argument sees the value as of the call site (V-5) holds the same way whether the value arrives as a copy or as an address ([language.md, section 22](language.md), in Japanese).

That changing how a value is passed did not change what it means is a consequence of the second property in the definition.

### `@effects` has the same shape

What a function can do to the outside world (`block`, `io`, `panic`, `nondet`) is derived by the analyzer from the call graph ([chapter 12, A-15](spec/12-annotations.ja.md), in Japanese). `@effects(…)` declares an upper bound on that, and `sober check` confirms the derived result fits inside the declaration (A-16).

```sober
// examples/effects_annot.sober（抜粋）
// Step の値は io をしない約束（このラムダたちはこの契約と照合される）
type Step func(x int) int @effects(!io)

// 否定形: 純さの主張（将来 io や panic が入ったら止まる）
@effects(!io, !block, !panic, !nondet)
func double(x int) int {
    return x * 2
}
```

`mut` writes the range of what can be rewritten in values; `@effects` writes the range of what can act on the outside world. Both are written in a function's signature as "what it is allowed to do" — never as something that points at a place.

## The mechanisms that make value orientation hold

### Region: a lifetime is decided by its block

Every block is a region (an allocation area). The body of a function, an expression block, each branch of an `if` / `switch`, and the body of a loop (a new region per iteration) each have their own region. A value lives in whatever region it is currently in, and when a block is left, its whole region returns at once ([chapter 9, M-1](spec/09-memory.ja.md), in Japanese).

Because a lifetime is decided by syntax, the user never writes ownership or borrowing. There is no GC either.

### Copying at a boundary

A value that leaves a region's boundary (`return`, an early return, `break`, the exit of an expression block) is copied, contents and all, into the region that remains ([chapter 9, M-2](spec/09-memory.ja.md), in Japanese). An assignment to an outer mutable place also copies into that place's region (M-3). Because an outer region never points into an inner one, there is no way to build a form that points at freed memory (the [safety note](design-notes/safe.md), in Japanese).

```sober
// examples/block_escape.sober
package main

// 式ブロックの中で作った string / slice を末尾値で外へ返す例。
// ブロックの出口は暗黙のラベルへの脱出で、jumpと同じ境界コピー（ブロックのregionの中身を親の最内regionへコピーしてからpop）。
// コピーが消えるのは再標的の最適化（最初から親のregionに作る）の仕事で、意味論は常にコピーする

import "std/convert"

func noise() int {
    t := "zzzzzzzzzzzzzzzz" + "yyyyyyyyyyyyyyyy"
    return len(bytes(t))
}

func label(n int) string {
    s := {
        t := "n=" + convert.FormatInt(n)
        t + "!"
    }
    k := noise()
    return s
}

func squares(n int) []int {
    xs := {
        mut out := mut []int{}
        mut i := 0
        while i < n {
            out = append(out, i * i)
            i += 1
        }
        freeze(out)
    }
    k := noise()
    return xs
}

func main() {
    println(label(42))
    ys := squares(4)
    println("${len(ys)} ${ys[3]}")
}
```

Output:

```
n=42!
4 9
```

The copy happens at the level of meaning. Making a value, whose destination is already known, directly in that destination so the copy is elided is an optimization performed by the implementation ([language.md, section 21](language.md), in Japanese). Because an immutable value cannot be observed to have been copied or shared, this optimization never changes what the program means.

### `freeze`: build it mutable, share it immutable

`freeze(x)` turns a mutable container immutable. Nothing is copied. Only a value with no other alias at that point can be frozen, and after `freeze` the same path can no longer be written to ([chapter 3, V-8 and V-9](spec/03-values.ja.md), in Japanese). The checker confirms the mutable identity is unique at that point, and only then does it become an immutable value.

### Task: a mutable value never crosses a task boundary

Only immutable values and channel endpoints can be passed to a child task. A `mut` binding cannot be captured ([chapter 10, C-2](spec/10-concurrency.ja.md), in Japanese). A task's result, and the values sent over a channel, are also immutable data, and a value that owns a region is copied (C-3, C-13). Because there is no shared mutable state, a data race cannot be written.

This safety property, and the determinism of parallel output, have proofs in Lean 4 against a model that formalizes the core of the language. The proofs are properties of the model, not directly of the compiler's implementation (the [safety note](design-notes/safe.md), in Japanese).

### Where identity matters, it is made explicit in the type

Things whose identity itself carries meaning are set apart as identity types: a task's `Scope`, `Handle`, channel endpoints, an open file, a connection ([chapter 2, T-23](spec/02-types.ja.md), in Japanese; [chapter 11, I-5](spec/11-io.ja.md), in Japanese). An identity type cannot be copied into a binding, returned, or stored.

A structure that lives long and keeps being updated is placed in std/pool's `Pool[T]`. A `Handle` is a value made of "a slot number plus a generation", and it can be copied into any region. Looking something up with a stale `Handle`, after it has been returned or reused, gives `nil` ([chapter 9, M-7](spec/09-memory.ja.md), in Japanese). A type forces a branch, in place of a dangling reference.

Where several tasks need to converge on one mutable state, that is written with a domain. A domain holds one piece of state and applies the bodies of `task.Update(d, (st mut S) => …)` one at a time ([chapter 10, C-21 through C-24](spec/10-concurrency.ja.md), in Japanese). A reference to the state never leaves. The body's value is copied back into the caller's region on return. The body neither waits nor does io.

## Design decisions that value orientation explains

Some design decisions can be explained, besides their own individual reasons, by this same view: "do not make a place a value" and "write the permission to change something at the call site". Only decisions whose reasoning could be confirmed in the design record are listed here.

### Why there are no methods

The [plain note](design-notes/plain.md) (in Japanese) answers this by pointing out that the job a method does — namespacing, encapsulation, the readability of dot notation — is covered by packages and `|>`, and that the rules a receiver would still need only make the language bigger. Seen from value orientation, the reason those "rules a receiver would still need" never arise can be explained.

- Go's methods distinguish value receivers from pointer receivers, and that brings with it the rules for the method sets of `T` and `*T` and for addressability ([language.md, section 3](language.md), in Japanese). This distinction arises because a receiver can point at a place. Sober has no pointer type, so the distinction itself never arises
- A call of the form `buf.append(y)` does not show, in the notation at the call site, whether `buf` gets rewritten. Sober requires the permission to rewrite to be written at the call site, as `f(mut buf, y)`. The unmarked form is rejected as going against the review criterion "what it does is written as it is, plainly" ([language.md, section 26](language.md), in Japanese)

### Why a closure cannot capture a `mut` binding

A lambda used as a value (a closure) cannot capture a `mut` binding ([chapter 5, F-10 and F-16](spec/05-functions.ja.md), in Japanese). The design record gives two reasons ([language.md, section 25, "A function-typed `mut` parameter"](language.md), in Japanese; section 26).

- Allowing capture would let a closure carry a write permission and outlive the binding's region
- An alias formed through the capture would not be visible in the notation at the call site

A captured `mut` would work exactly like a persisted write permission — that is, like a reference value. The state stays with the caller, and is passed through a function-typed `mut` parameter instead ([chapter 3, V-7](spec/03-values.ja.md), in Japanese).

A lambda that is inlined at its call site is different. A lambda passed to the anonymous function-typed parameter of a function that inlines it, and a lambda bound to a local name ([chapter 5, F-23](spec/05-functions.ja.md), in Japanese), can capture a `mut` binding. These never become values. Binding them to another name, storing them in a field, or returning them is rejected. What the body writes is the same as if that same code had been written in place. Since it is never a way to carry a write permission around, there is no reason to forbid it.

### Why a `mut` slice cannot be sliced into a subrange

A subrange `xs[a:b]` can only be taken from an immutable slice ([chapter 9, M-5](spec/09-memory.ja.md), in Japanese). If it could be taken from a `mut` slice, there would be two `mut` headers pointing at the same cells, and Go's slice accident — where a write through one becomes visible through the other — would come back ([language.md, section 21](language.md), in Japanese). This is the same policy: never widen the range over which mutable identity is visible.

## Where this stands next to earlier ideas

Putting values at the center is not new. The main differences from two prior ideas are below. The earlier research behind individual mechanisms (region inference, Cyclone, monitors, actors, Kahn process networks and so on) is gathered in the [related work note](design-notes/related-work.md) (in Japanese) and is not repeated here.

- Rich Hickey's talk "The Value of Values" names programming in which new information replaces old information in place "Place-Oriented Programming", and criticizes it ("anytime new information replaces old information, you're doing Place-Oriented Programming"). The talk makes immutability a condition of being a value ("values are immutable and values are semantically transparent"). Sober does not make immutability a condition. Changes can be written, and their range is closed off with `mut`
- Mutable value semantics (Hylo, Swift's `inout`) is a discipline that lets you write changes while keeping a value's independence. A reference never becomes a first-class value ("references become second-class citizens"), and bindings never share mutable state ("variables can never share mutable state"). Part-wise in-place mutation is allowed ("part-wise in-place mutation". Source: Racordon et al., "Implementation Strategies for Mutable Value Semantics", Journal of Object Technology, 2022). Swift's `inout` parameter is also a mechanism that rewrites the caller's variable only for the duration of the call, cannot be carried out past the function, and needs no lifetime annotation ([The Swift Programming Language, "Functions"](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/)). Sober's `mut` parameter is close to this lineage. Sober extends this principle to the lifetime of memory (regions), to parallelism (a task's boundary), and to action on the outside world (`@effects`)

## "Surely you can't write that"

### Won't memory keep growing in a long-running server?

Answer: no, because a region closes per connection and per iteration.

`net.Serve` runs one task per connection. A connection's task region has an upper bound, declared with `region:`. The default is 128 MiB ([chapter 11, I-11](spec/11-io.ja.md), in Japanese). A loop's body is a region per iteration, so nothing piles up across iterations except what is explicitly kept ([chapter 9, M-1](spec/09-memory.ja.md), in Japanese). A child task whose handle has been dropped returns its storage at the end of that child, so a scope that keeps accepting connections does not grow either ([chapter 10, C-10](spec/10-concurrency.ja.md), in Japanese).

Examples: [`examples/net_serve.sober`](../examples/net_serve.sober), [`examples/iter_region_inner.sober`](../examples/iter_region_inner.sober)

### Isn't it impossible to hold data that outlives a single request (a cache, a session, a connection pool)?

Answer: it can be held. There are three places to put it: serializing the receiving side, a domain, or an outside store. There are limits today as well.

- To serialize the receiving side, receive connections one at a time and pass a `mut` table into each request's handling with `mut` ([Web server guide, section 3](guide/web-server.md#3-where-state-lives--serial-or-an-outside-store), [`examples/web_login.sober`](../examples/web_login.sober))
- To receive in parallel, put it in a domain. A connection pool takes this form ([`examples/pg_pool.sober`](../examples/pg_pool.sober))
- A login session is represented by a signed token from std/session together with a generation in a table of users ([Web server guide, section 7](guide/web-server.md#7-login-and-sessions--stdsession))

Limit: a domain's body can only write to the state in two ways — a region-free value (int, bool, byte, float, and structs of them) or a write into an element of a `mut` slice in the state. The state cannot be grown by appending or by writing a string ([chapter 10, C-24](spec/10-concurrency.ja.md), in Japanese), because the state lives exactly as long as the domain, so anything grown would never be freed even when overwritten ([language.md, section 11, "domain"](language.md), in Japanese). A cache of variable-length data shared across concurrent requests is, for now, placed in an outside store.

### Doesn't returning a value out of a region cause a copy every time, and isn't that slow?

Answer: at the level of meaning, yes, it is a copy, and the cost is proportional to the amount copied ([chapter 9, M-2](spec/09-memory.ja.md), in Japanese). When the destination is already known, the implementation builds the value there from the start and elides the copy ([language.md, section 21](language.md), in Japanese).

Whether the copy is elided never changes what the program means, because an immutable value cannot be observed to have been copied or shared. Changing how a large immutable argument is passed to use an address, without changing meaning, worked for the same reason (see "A real case" above).

### Isn't memory allocated inside a loop held until the whole loop ends?

Answer: no. A loop's body is a region per iteration. A value made inside an iteration is copied out only if it is kept past that iteration, so nothing piles up in proportion to the number of iterations ([chapter 9, M-1](spec/09-memory.ja.md), in Japanese).

Examples: [`examples/iter_region_inner.sober`](../examples/iter_region_inner.sober), [`examples/iter_region_outer_assign.sober`](../examples/iter_region_outer_assign.sober)

### Won't a growing collection (append, map) turn into a pile of garbage?

Answer: growing at the tip the whole way produces no garbage. But there are rules to follow.

`append` grows a `mut` slice in place only when its tail coincides with the tip of the region ([chapter 9, M-4](spec/09-memory.ja.md), in Japanese). Growing several sequences in one region by turns makes the tip stop coinciding, which causes copies and piles up garbage. In a measurement with a small parser, growing in turns produced 85% garbage and O(n²) usage, while keeping one sequence growing per region produced zero garbage and O(n) ([language.md, section 21](language.md), in Japanese).

The rule is: keep one growing structure per region, and copy only the finished value across the boundary to the parent. When you need to grow several things in turns, use std/builder (a sequence grown by chaining chunks) and std/table (a large table read and written by index). Neither one moves its chunks, so neither produces garbage even mixed in with other allocations.

Examples: [`examples/builder_string.sober`](../examples/builder_string.sober), [`examples/table_std.sober`](../examples/table_std.sober)

### Surely you can't write a graph or a data structure with cycles?

Answer: trees can be written directly with recursive types. Structures whose edges go backward are built with a table and indices.

A type declaration can contain itself through `[]T`, `map[K]V` or `T?` ([chapter 2, T-33](spec/02-types.ja.md), in Japanese). Structures such as expression trees, JSON values and directory trees are written as recursive types.

What cannot be written is a value that leads back to itself. Since there are no references, a value is a tree built from the bottom up. A structure whose edges go backward, such as a doubly linked list, a tree with parent pointers or an LRU, is written by placing elements in a `mut` slice and representing edges as indices. `xs[i].f = v` writes a field of an element ([chapter 3, V-10](spec/03-values.ja.md), in Japanese).

```sober
// examples/elem_field_assign.sober（抜粋）
// 番兵 0 番の直後に h を差し込む
func pushFront(es mut []Ent, h int) {
    first := es[0].next
    es[h].prev = 0
    es[h].next = first
    es[first].prev = h
    es[0].next = h
}

func unlink(es mut []Ent, h int) {
    p := es[h].prev
    n := es[h].next
    es[p].next = n
    es[n].prev = p
}
```

Long-lived mutable object graphs whose lifetime does not follow syntax (a GUI's retained-mode tree, for example) are a domain Sober does not target ([DESIGN, "Non-goals"](../DESIGN.md#non-goals)).

Examples: [`examples/elem_field_assign.sober`](../examples/elem_field_assign.sober), [`examples/type_recursive_tree.sober`](../examples/type_recursive_tree.sober)

### Isn't it impossible to share data between tasks?

Answer: an immutable value can be shared. The only way to share mutable state between tasks is a domain.

Data built as mutable can be handed to a child task without copying once it is made immutable with `freeze` ([chapter 3, V-8](spec/03-values.ja.md), in Japanese; [chapter 10, C-2](spec/10-concurrency.ja.md), in Japanese). Passing between tasks is written with channels, and the values sent are immutable data (C-13). Where many tasks converge on one state, that is written with a domain. The order in which a domain's calls ran is treated as recorded input, the same as io input, and fixing that order makes the result independent of the schedule (C-22).

Examples: [`examples/tour_07_parallel.sober`](../examples/tour_07_parallel.sober), [`examples/domain_counter.sober`](../examples/domain_counter.sober)

### Surely a program where data of mixed lifetimes is mixed together, like a compiler, can't be written?

Answer: Sober's own compiler is written in Sober (`src/compiler/`).

Mixed lifetimes are separated by the structure they are placed in. A large table, such as a function table or a record of desugaring and code generation, is placed in std/table, and once it is finished being built, `table.Freeze` makes it immutable without copying its contents ([language.md, section 17](language.md), in Japanese). Small sequences are built with std/builder.

There has been a case that broke this rule. The compiler's loader used to build a function table by appending to 8 separate `mut []T` slices once per pass, so the "tip coincides" property only held for one of them, and usage reached O(n²). It was moved to std/builder to fix it ([language.md, section 21](language.md), in Japanese). There is not yet an analyzer lint that flags this shape.

## Related

- [DESIGN, 1. Regions](../DESIGN.md#1-regions--lifetimes-match-the-nesting-of-scopes), [safety note](design-notes/safe.md) (in Japanese), [related work note](design-notes/related-work.md) (in Japanese)
- Specification: [chapter 3, values and bindings](spec/03-values.ja.md) (in Japanese), [chapter 9, memory](spec/09-memory.ja.md) (in Japanese), [chapter 10, concurrency](spec/10-concurrency.ja.md) (in Japanese)
- Decision record: [language.md](language.md) (in Japanese), sections 17 (freeze), 21 (slices and regions), 26 (`mut` parameters) and 11 ("domain")
- Rich Hickey, "The Value of Values" (talk); Racordon et al., "Implementation Strategies for Mutable Value Semantics" (Journal of Object Technology, 2022); [The Swift Programming Language, "Functions"](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/); [The Rust Book, chapter 4](https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html)
