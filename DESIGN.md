# The design of Sober

English | [日本語](DESIGN.ja.md)

This document gathers Sober's main design decisions into five pillars. Each pillar is written in the order "what was chosen, what was rejected, what it gives the user". The finer "why Y rather than X" decisions are in the [design notes](docs/design-notes/), the exact definition of the language is in the [language specification](docs/language.md), and the record in the order the decisions were made is in the [design record](docs/design-dev.md) (for developers). All three are in Japanese.

There is one criterion for review: what a program does is what it says. A feature that cannot be written straightforwardly does not go into the language; it is handed to the analyzer or dropped.

## 1. Regions — lifetimes match the nesting of scopes

Chosen: every block is a region (an allocation area). A value lives exactly as long as the scope that created it. Values that leave a scope (return values, assignments to outer bindings) are copied into the outer region. Only immutable values and channels can be passed into a parallel scope.

Rejected: GC (tracing at run time) and borrow checking (typing lifetimes). One hides the details of memory and the other makes the writer prove them; Sober takes neither, and instead derives lifetimes from structure and declarations.

What it gives the user: memory safety and freedom from data races, with no lifetime annotations and no borrowing rules (proved for a model formalized in Lean — `lean/`). Allocations are freed together at the scope exit in O(1). There are no GC pauses and no headroom.

→ Design notes: [safe](docs/design-notes/safe.md)

## 2. Expression-oriented — values flow, syntax does not branch

Chosen: if, switch, blocks and for have values. Bindings are immutable by default, and `mut` is confined to stateful loops (`while`) and to arguments marked at the call (`f(mut x)`). Multiple results flow to the point where they are taken apart, and `|>` with the hole `_` connects functions into a single line. There are no methods, type classes, macros or comptime — behavior is expressed with functions and with structs whose fields are function values (dictionaries), and dictionaries are passed explicitly.

Rejected: the implicit self of methods, implicit satisfaction of interfaces, type-class resolution, and compile-time computation. All of them are mechanisms where something that is not written carries meaning.

What it gives the user: code stays ordinary procedural code that anyone who reads Go can read, while temporary `mut`s and guessing "which implementation is called" disappear. Everything that carries meaning is written in the source.

→ Design notes: [plain](docs/design-notes/plain.md)

## 3. A closed world and unobservability — the world closes at link time

Chosen: the whole program (including std) is closed at link time. There is no dynamic loading. Because it is closed, error labels, effects (whether something blocks, whether it touches io) and stack bounds can be derived from the call graph, and public boundaries must declare them. Optimizations are only transformations that do not change observations (standard output, exit code, panic location), so the meaning does not depend on the optimizer. The order of parallel output is fixed as well and does not change with the number of workers.

Rejected: an open world (plugins, dlopen, JIT) and observable nondeterminism (select, output that depends on the outcome of a race).

What it gives the user: rejection of unhandled errors, deterministic parallelism, and the same meaning in debug builds. In exchange, software where dynamism is the point is a non-goal.

→ Design notes: [minimal](docs/design-notes/minimal.md), [safe](docs/design-notes/safe.md)

## 4. The verification net — the density of oracles sets the pace of development

Chosen: a change to the compiler goes in only after passing all of the following: the self-compilation fixed point, golden tests, agreement of observations with and without optimization, comparison against the frozen Zig version, independent oracles (Go, GNU as), and comparison against the formal model in Lean (`scripts/gates.sh --full` — 54 checks). The bootstrap has no seed binary and is built from Zig and source alone.

Rejected: an ad hoc net of "write as many tests as you can". Each kind of check in the net has its own independent oracle, and any one of them going off stops the change.

What it gives the user: a compiler kept small (the core is under 100,000 lines) that can be boldly reworked without breaking. The net itself is public, and anyone can run the same checks.

→ Design notes: [minimal](docs/design-notes/minimal.md)

## 5. Fast when written straightforwardly — the mechanisms for speed live only in the compiler and the runtime

Chosen: the mechanisms for speed (optimization, data representation, the scheduler) live only inside the compiler and the runtime. Neither the std API nor user code asks for a special way of writing to be fast. The Sober side of the benchmarks is limited to the straightforward form, and if an etiquette of "write it this way and it is faster" ever appears, it is treated as a defect in the language.

Rejected: annotations for speed, tuning knobs visible to the user, and collections of "fast idioms".

What it gives the user: straightforward code is the fastest form, and there is no performance folklore to memorize. Comparisons against straightforward Go / Rust with the same algorithms are published in cycles, instructions and peak RSS.

→ Design notes: [fast](docs/design-notes/fast.md)

## The pillars and the four in the README

| README pillar | Main design pillars | Design notes |
|---|---|---|
| Minimal | 4 verification net, 3 closed world | [minimal.md](docs/design-notes/minimal.md) |
| Fast | 5 fast when written straightforwardly | [fast.md](docs/design-notes/fast.md) |
| Safe | 1 regions, 3 closed world | [safe.md](docs/design-notes/safe.md) |
| Plain | 2 expression-oriented | [plain.md](docs/design-notes/plain.md) |

## Non-goals

As the flip side of the same constraints that make the strengths, the following are not targeted:
software where dynamism is the point (plugins, JIT, REPL-style exploration — the flip side of the closed world), long-lived mutable object graphs whose lifetimes do not follow the syntax (such as a GUI's retained tree — the flip side of regions), numerical computing / HPC / ML (the flip side of not opening operators and not promising monomorphization), and the extremes of allocator craftsmanship (the flip side of regions being the default semantics).
