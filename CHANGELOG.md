# Changelog

This file records user-facing changes per public release. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versions follow [Semantic Versioning](https://semver.org/) (no backward-compatibility promise while on 0.x).

## v0.5.4 — 2026-10-14

### Language

- Fallible for: a generator call that can fail may drive a for loop (`for chunk <- io.Chunks(f)? { … }`); the failure is returned by the for itself
- Scope errors: inside a par scope's body, `?` records the failure as the scope's failure; at the exit, an unclaimed child error takes precedence
- Partial literals: `T{a: 1}` writes some fields by name and fills the rest with zero values. Fields of sealed types (and identity types, transitively) are excluded so witnesses cannot be forged; `panic` labels follow the same rule
- Zero values of identity types are rejected (including transitively through fields)
- Breaking: `ReadFd` / `SetFd` are gone — the standard streams are the values `io.Stdin` / `io.Stdout` / `io.Stderr` (`io.SetFile` for redirection); `EntryKind` `File` is renamed `Regular`
- Implicit freeze now also covers for-loop generators

### Standard library

- io: open files (`Open` / `Close` / `ReadAll`) and zero-copy streaming reads — `for c <- io.Chunks(f)? { … }` lends a view per iteration (`Lines` / `Bytes` / `Raw`; `ChunksAt` reads from an offset). A 400 MB file scans in 420 KB of RSS. The runtime now submits file reads and writes through io_uring (one ring per worker; idle workers sleep on the ring)
- sort (new): `sort.Order(n, less)` returns indices in stable order; `sort.OrderUnstable` is the deterministic unstable variant (pdqsort-class, no randomness — same input, same order, checked by a gate)
- json: decode and encode sped up (below)

### Performance

Relative to v0.5.3, jsonapi cycles versus Rust improved by −15%, and memory is the headline: routing RSS 110.9 → 16.2 MB and jsonapi 33.7 → 26.2 MB (both below the Rust twins), knucleotide 88.5 → 75.6 MB, 1brc 134 → 0.6 MB (that benchmark now uses the plain `io.Chunks` loop; its cycles +5% is the honest price of the rewrite). The benchmark code is otherwise unchanged:

- Fixed a loop-body range bug in region lightening: an inner loop stopped the scan, so the outer loop's per-iteration region enter was wrongly elided and per-iteration values leaked into the function region. Restoring the promise ("a loop body is a scope") is what recovers the routing / jsonapi RSS; logagg pays +0.4% instructions for it
- Bulk-copy recognition: element-appending loops, ranged copies, ranged writes into `io.Writer`, and constant-fill loops lower to a single grow + copy / fill
- map growth rewinds the allocation point when its index is at the region tip instead of stacking dead index generations (knucleotide RSS −11 MB, logagg cycles −8%)
- json: duplicate-key check and field lookup compare bytes directly, ints format straight into the output, and Encode is specialized per type with pre-escaped constant key fragments
- New benchmark: external sort (bench/extsort) — wall 2.33× → 1.7× of Rust across the release, RSS flat at 177 MB from 256 MiB to 4 GiB inputs (Rust 180 MB, Go 500 MB)
- Benchmark numbers in the READMEs are now generated from `bench/data/official.tsv` and checked by a gate (no more drift between runs and prose)

## v0.5.3 — 2026-10-12

### Performance

Relative to v0.5.2, cycles versus Rust improved by routing −23%, knucleotide −18%, logagg −13%, jsonapi −10%, nbody −7%, 1brc −6%. The benchmark code is unchanged (all compiler improvements). Against Rust, the 9 sequential benchmarks now stand at 5 wins, 2 ties, 2 losses:

- Packed f64 and SLP vectorization: same-shaped floating-point operations on two adjacent words are combined into a single SSE2 packed instruction (the expression tree is copied as is, so the association order of the operations does not change). Together with the bounds-check work below: nbody instructions −33%, cycles −7%
- Broader bounds-check elimination: once a check for a large constant index has passed, checks for smaller constant indices are dropped. Functions with many constant-index checks are versioned by a single test at entry into a check-free copy and the original (when out of range, the original runs unchanged, so the panic site and output are the same)
- Fixed the region summary for loops: calls inside a loop were miscounted, so region enter/exit could not be elided (routing cycles −16%)
- The header (pointer and length) of a mut slice parameter is hoisted out of loops, and so is the computation of the region allocation limit (a few instructions fewer per append inside a loop)
- Copy forwarding: reads right after a copy now read from the source, and copies that become unused are removed
- Folding of constant branches after inlining
- Register allocation: live ranges of values carried around loops are split more finely, and the choice of what to evict on overflow was revised (fewer round-trip copies)
- Small instruction-selection improvements (three-operand imul for constant multiplies, operand swapping for commutative operations, eliminating reloads right after a write). The result slot of a struct-returning call is no longer shared with other calls (sharing kept it from being promoted to registers after inlining)
- Regression: mandelbrot cycles +3.6% (instructions −8%). Removing the copies on the loop back edge happens to run slower on this benchmark

## v0.5.2 — 2026-10-11

### Language

- Added builtin clone(x): returns a shallow mut copy of a slice / map (the dual of freeze — the fix for "I passed it read-only and it froze"). Ships with Lean typing rules and a soundness proof
- Field privacy (soundness fix, breaking change): fields of a struct declared in another package can no longer be written from outside (assignment, index/map stores, delete, mut passing), and fields holding mutable contents can no longer be read from outside. This closes holes where a type's invariants (the utf8.View seal, std/table internals, …) could be broken externally
- Fixed gaps in the freeze-uniqueness rules: writes after `freeze(if …)` / `freeze(append(…))`, and par children capturing a mut container through an immutable binding, are now rejected

### Performance

Relative to v0.5.1, cycles versus Rust improved by routing −48%, jsonapi −31%, knucleotide −17%, logagg −14%. The benchmark code is unchanged (all compiler improvements):

- Function-entry slot zeroing is now skipped for words that are always written before being read; small remainders become store sequences and are sunk past early-return paths (the rep stosq microcode startup disappears)
- Fixed two pass-ordering holes in the post-inline optimization pipeline (unpruned φ cycles; region elision not re-applied)
- Fixed a bug in the region-lightening analysis (misread depth operand of relocate — per-iteration region enter/exit greatly reduced)
- SROA now sees through constant geps, eliminating whole-struct copies of by-value parameters
- Spill-slot coalescing and elimination of reloads right after definition (fewer register-allocation copies)
- Self-build: ~3% faster (shared typing tables and more), compiler binary −7%

## v0.5.1 — 2026-10-11

### Language

- Implicit freeze: placing a mut container where an immutable one is expected (call arguments, return values, field assignment, composite fields, literal elements, append elements, index/map stores, assignment to an immutable location, channel sends) now freezes it implicitly. Bindings `x := m` do not freeze (they remain aliases, as before). Explicit freeze still works. See docs/language.md §17
- Freeze uniqueness is now enforced statically (soundness fix): closed a hole where a stale mut alias could write to frozen contents after a freeze. A freeze that cannot be proven unique is rejected by the checker (rules U1–U3, cross-checked against the Lean predicate uniqFreeze). The same rules apply to implicit freezes
- The contents of a mut parameter do not escape the callee (U3) — now a language promise

### Standard library

- std/strings: added Cut / CutLast / TrimPrefix. The resulting substrings are returned as string without re-validating UTF-8

### Performance

- UTF-8 boundary-check elision: boundary checks provable as ASCII are removed from the machine code (1brc instructions −3.5%)
- Calling-convention improvements (fewer spills across cold calls) and rebalanced inlining budgets (routing cycles −9%)
- Self-build: eliminated a duplicated typing pass (build ~3.6% faster, checker RSS −41 MB)

### Fixes

- Closed a hole where `sober run` / `sober test` skipped the freeze-uniqueness rules
- Closed a hole where a par child could capture a mut container through an immutable binding (freeze before Spawn)

## v0.5.0 — 2026-10-10

First public release.

- Language, compiler, standard library, benchmarks and documentation
- Bootstraps from source: Zig 0.15.2 builds stage1 (the frozen compiler), then the bootstrap/ chain builds the current compiler
- Produces static x86-64 Linux binaries (no libc dependency)
