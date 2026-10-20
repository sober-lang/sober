# Changelog

This file records user-facing changes per public release. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versions follow [Semantic Versioning](https://semver.org/) (no backward-compatibility promise while on 0.x).

## v0.6.0 — 2026-10-20

The Web release: networking, an HTTP/1.1 server, TLS 1.3 and the cryptography under it are now part of std, written in Sober. The language gains closures, and the whole std API went through a naming review (breaking — see "Renamed" below). The language specification is now written down as rules (docs/spec), and the std reference is generated from the sources.

### Language

- Closures: a lambda placed in a value position — a parameter or result of a named function type, a function-typed struct field, or its option `F?` — is a closure. It captures immutable values by copy at the point of creation and may cross function boundaries as an argument, a result or a field. Capturing a mut binding or an identity type (task scopes and handles, channel ends, `net.Conn`, …) is rejected, and `return` is not allowed in its body (it can outlive the function that made it). Anonymous function-typed parameters keep the existing expansion (no change in generated code)
- Borrowed function parameters: in a named function type such as `type Stream func(emit func([]byte) error?) error?`, the anonymous function-typed parameter (`emit`) is a borrow. It can be called, passed on to another borrow position, or captured by an inlined lambda or a for body — binding it, storing it, returning it, or capturing it in a closure or a child task is rejected. A lambda in a borrow position may capture identity types such as `net.Conn`
- Function-typed values may return `error?` (`func(net.Conn) error?`), `f(x)?` works on them, and a named function can be passed where a function type is expected
- A call of a function-typed parameter can drive a for loop: `for b <- recv(k)? { … }`
- `@errors` can name a function-typed parameter (`@errors(Bad, recv, send)`): the labels of that parameter's failures are taken from the argument at each call site
- `std/internal/…` packages can only be imported from inside std
- First analyzer warnings (they do not change what is accepted): waiting inside a lease window, and nesting two windows on the same `task.Local`
- Clearer messages for three rejections that used to be reported without a position or reason (switch on a string value, comparing `T?` with a value, wrong argument count)

### Standard library

- net (new): `Listen` / `Accept` / `Dial` / `Recv` / `Send` / `Port` as for-loop generators that close on exit, and `net.Serve(l, handle, budget:, conns:, reject:)` — one task per connection, failures and deaths of a connection are absorbed, connections over the limit get the `reject:` bytes without running user code. The runtime uses io_uring per worker (multishot accept / recv into provided buffers, kernel ≥ 6.1) and falls back to epoll automatically when io_uring is not available. Output does not depend on the backend
- http (new): an HTTP/1.1 server — `http.ServeConn(c, route, maxHead:, maxBody:, compress:, work:)` with keep-alive and pipelining, chunked request bodies, 413 / 431 limits; a router as a plain table (`[]http.Route` with `Mount` / `Merge` / `Dispatch` / `Param`, static > `:param` > `*rest` regardless of order, 405 with `Allow`) and before / after middleware; response headers, `Form`, `JsonDoc`; streamed response bodies (`Response{stream: …}` with a known length); gzip responses (`compress: http.Gzip{level: …}`, `Vary`, `Accept-Encoding`). `http.ServeWith(recv, send, …)` serves over any transport (TLS uses it)
- tls (new): a TLS 1.3 server — `tls.Serve(addr, cfg, k)` hands only completed handshakes to `k`; `tls.Load` / `tls.Parse` for PEM certificates and keys, ALPN; X25519, AES-128-GCM and ChaCha20-Poly1305, RSA-PSS certificates; `tls.Recv` / `tls.Send` look like their net counterparts; errors are `tls.HandshakeFailed` / `tls.BadRecord` / `tls.Closed`. Server side only; no resumption or 0-RTT
- crypto (new): SHA-256, HMAC-SHA256, HKDF-SHA256, ChaCha20, Poly1305, ChaCha20-Poly1305, AES-128-GCM (AES-NI + PCLMULQDQ), X25519, RSA-PSS signing and verification (MULX / ADX Montgomery multiplication), PKCS#8 DER and PEM, constant-time helpers (`crypto.Equal` / `Select` / `Wipe`) and the system random source. Checked against RFC and Wycheproof vectors; a gate checks that the secret-dependent code has no secret-dependent branches
- compress/flate, compress/gzip, hash/crc32 (new): deflate levels 0–9 (zlib-compatible settings, dynamic Huffman; compression ratio on par with zlib), gzip framing, CRC-32 with a PCLMULQDQ path
- binary (new): `binary.Load64` — an 8-byte little-endian read with a single bounds check
- pool: `pool.Scratch`, a fixed-capacity workspace with generation tags, used with worker-local leases
- io: deadline expiry is now its own label `io.Expired` (previously reported as `io.Timeout`)
- os: `os.Sleep` yields the worker in task programs and returns early at the scope deadline; `os.SleepExpired` reports whether it did

### Concurrency (std/task)

- Deadlines: `task.Run(body, deadline: 500 * task.MS)` sets a relative deadline on the scope, inherited by descendants (the earlier one wins). It bounds waiting, not computing: after the deadline, I/O calls return `io.Expired` and network waits are cut
- `task.Run(body, wait: true)`: direct children that do not fit the budget wait for room instead of running inline
- Children that run inline because they did not fit the budget are now counted in the ledger; `task.Ledger()` reports failures and deaths per pool, and `task.MarkFailed(pool)` counts a failure at a boundary
- Worker-local leases: `task.NewLocal` / `task.Lease` lend a per-worker workspace inside a window. Every window sees a fresh value, so reuse is never observable; it keeps per-connection memory independent of the number of connections (gzip workspace in http)
- When a task dies, I/O waits of its descendants are cut with `io.Expired` (a scope without a deadline could previously hang forever)
- A child whose handle is discarded (`_ = task.Spawn(…)`) no longer leaves memory behind in a scope that never returns (such as `net.Serve`'s accept loop)
- Each child task has its own region slot size: 512 MiB for a child without `budget:`, the power of two at or above the declared value otherwise (the main task keeps `SOBER_REGION_MB`). A child without `budget:` that piles more than that into one region dies with `RegionExceeded{cause: slot_capacity}` — declare `budget:` for large workspaces. Running out of address space is now reported as `RegionExceeded{cause: va_exhausted}` (it was misreported as `slot_capacity`). (this is what lets `net.Serve` hold 16k concurrent connections)

### Renamed (API review — no aliases are kept)

The 0.6.0 API review renames abbreviations and provisional names to the naming rules (language.md §34). Old names are removed, not deprecated:

| Package | Old | New |
|---|---|---|
| json | `Value` variants `Num` / `Str` / `Arr` | `Number` / `String` / `Array` |
| json | `DupKey` (`InvalidJson` kind) | `DuplicateKey` |
| json | `DecString` / `DecBool` / `DecInt` / `DecFloat` | `ParseString` / `ParseBool` / `ParseInt` / `ParseFloat` |
| json | `Object` (function) / `Value` variant `Obj` | `NeedObject` / `Object` |
| builder | `PushStr` | `PushString` |
| compress/flate | `Prep` | `Prepare` |
| http | `Request.hdrs` / `Response.hdrs` (fields) | `headers` |
| http | `Response.ctype` (field) | `contentType` |
| http | `Route.h` / `Route.mw` (fields) | `handler` / `middleware` |
| os | `SleepCut` | `SleepExpired` |
| crypto | `Eq` | `Equal` |
| crypto/pem | `Decode` | `Parse` |
| hex | `Encode` / `Decode` | `Format` / `Parse` |
| strings | `FormatInt` | `convert.FormatInt` (moved to std/convert — number/string conversion lives in convert) |
| utf8 | `Valid` / `IndexInvalid` / `InvalidUtf8` (error label) | `strings.Valid` / `strings.IndexInvalid` / `strings.InvalidUtf8` (string validity lives in strings) |
| utf8 | `Parse` | removed — write `string(b)` (its implementation moved inside std) |
| std/floatfmt (package) | `floatfmt.…` | removed — use `FormatFloat` / `FormatFixed` / `ParseFloat` in `std/convert` and `Bits` / `FromBits` in `std/math` |
| std/conv (package) | `conv.…` | `std/convert` — `convert.…` |
| std/par (package) | `par.…` | `std/task` — `task.…`. Renamed inside: `Scope` (function) → `Run`, `S` (type) → `Scope`, `Task[T]` → `Handle[T]`, `Tx` / `Rx` → `Sender` / `Receiver`, `NewChan` → `NewChannel`, `TaskDied` → `ChildDied`, `Fail` → `MarkFailed`, `LeaseBlk` → `LeaseBlock` (the rest keep their names) |

Pairs that are intentionally one-sided (for example `SealTo` without `OpenTo`) are now marked on the declaration instead of being filled in.

Packages under `std/internal/…` are implementation details of std and cannot be imported from outside std (std/floatfmt, the implementation of `string(b)` and the TLS handshake state machine std/tls/hs, now std/internal/hs, moved there). std/utf8 stays as the package of validated views (`Check` / `View` / `Str` / `Bytes`).

### Other breaking changes

- Deadline expiry is `io.Expired`, no longer `io.Timeout` (match both if you handled timeouts generically)
- `sober build -o <path>` writes `<path>.tmp` and renames it into place (like `go build -o`): the output gets a new inode each time, so hard links are not kept and the previous file's owner and mode are not inherited
- A child task without `budget:` is limited to 512 MiB per region (see above)

### Documentation

- docs/spec: the language specification as rules — 13 chapters, 165 rules, each linked to accepted and rejected examples under examples/ that a gate runs (currently in Japanese)
- docs/std: a reference for every std package, generated from the doc comments in the sources; a gate checks that it matches the sources and lints the doc comments (currently in Japanese)

### Performance

- HTTP: on the bench/httparena harness (the HttpArena load generators and request files, both servers on 32 vCPUs on GitHub Actions, compared with Go's net/http), Sober is ahead or level on every test we run — baseline 2.8×, pipelined 15×, limited-conn 7.3×, json-comp 1.3×, json-tls 1.6×, async 1.6×; 8gbit level at the rate cap with 2.6× less CPU; latency-1m holds 998K of the 1M req/s target at p99 0.16 ms (Go falls behind the rate and its p99 grows to seconds). This is our own harness, not an official HttpArena result
- Cryptography: an RSA-2048 PSS signature takes 12 M instructions (from 222 M in the first version), on par with Go's crypto/rsa; AES-128-GCM runs at about 2.6 instructions per byte in the record layer; X25519 is 7× faster than the first version
- Compiler, measured on the benchmark suite (2026-10-19 official run, see the README charts): memory — revcomp RSS 48.6 → 24.4 MB (now below Rust) and knucleotide 75.6 → 52.7 MB (within 2 MB of Rust); speed — word-sized reads and copies, more partial inlining, and lighter region handling around functions that never return. Against Rust, 7 of the 9 sequential benchmarks are at or below 1.03×, nbody is 1.17× and revcomp 1.48× (its ratio moves a lot with the measurement window); the Web-style benchmarks jsonapi / routing / logagg are at 1.22× / 1.13× / 1.16×
- Self-build: more of the per-function work runs in the parallel lowering stage, and the loader's per-file checks run in parallel

### Fixes

- Fixed a memory leak where the result of an inlined call (a function with a mut or function-typed parameter) inside a loop was built in an outer region and accumulated on every iteration; two related leaks of the same kind were found and fixed by an exhaustive check
- Fixed a miscompilation where region enter was removed for a function whose region depth is computed from its caller's depth
- Fixed the record of a channel created inside a loop being placed in the per-iteration region and overwritten
- Fixed several cases where `sober check` and `sober build` disagreed (one accepted a program the other rejected)

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
