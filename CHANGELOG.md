# Changelog

This file records user-facing changes per public release. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versions follow [Semantic Versioning](https://semver.org/) (no backward-compatibility promise while on 0.x).

## v0.6.3 — 2026-10-25

A performance release. Servers with many connections now take io_uring completions in small steps, which removes the many-connection cliff, and a task that becomes runnable under saturated load now waits at most a bounded time. Memory per request and per connection is lower, and TLS sends and compression encoding are faster. Public std functions now carry `@effects` declarations, and the runtime's depth invariant is always checked.

### Performance

- HTTP — measured on bench/httparena, our own harness rather than an official HttpArena result. It uses the HttpArena load generators and request files on a 64-vCPU GitHub Actions runner, with 32 server cores, and compares against Go's net/http. Sober / Go ratios, against the v0.6.1 run:

  | Test | v0.6.1 | v0.6.3 |
  |---|---|---|
  | baseline | 3.0× | 3.2× |
  | pipelined | 16× | 15.9× |
  | limited-conn | 7.2× | 9.2× |
  | json | 3.1× | 3.4× |
  | json-tls | 2.3× | 2.8× |
  | json-comp | 1.3× | 1.8× |
  | async | 1.9× | 2.4× |

  - latency-500k-8cpu and latency-1m hold their target rates (p99 0.37 ms / 0.21 ms).
  - No non-2xx responses in any test.
- Taking completions (the net ring): the runtime used to enter io_uring only when it ran out of runnable tasks, and then took all completions at once. With many connections each batch grew deep and the working set spilled out of the cache. Now, once 8 SQEs are waiting to be submitted, a worker submits, takes completions and fires expired timers without sleeping, and runs the woken tasks first while they are hot. On its own that would let old wake-ups sink under saturated load, leaving some connections unserved for seconds, so **a task that becomes runnable now runs within a wait bound D even under saturation** (default 100 ms — `maxWait:` below), picked one at a time from the bottom. Locally with 12 workers, with every connection served within D:
  - keep-alive at 4096 connections: 2.3× fewer cycles per request (the 2.5× cliff against 256 connections is gone), and 17% more requests per second than the fair variant without hot-first completions
  - async at 24k connections: 7–9% less CPU per request
  - Under saturation, p99 ≈ D (100 ms by default) is by design: every connection runs within D (recently active connections run while hot, and connections whose wait reaches D are picked up). Without saturation, the bookkeeping for the bound costs about 3% CPU per request.
- Memory:
  - A function whose region allocations all flow into its return value no longer enters a region of its own; it allocates straight into the caller's. This removes region depths per request, including std/http's Dispatch. async at 24k connections: VmHWM −21 MB (−5%).
  - The per-worker cap on spare small slots and the slot count of the receive buffer ring (PBUF_RING) are now divided by the number of workers, so spares no longer grow with the worker count. async at 24k connections: VmHWM about −20 MB with 12 workers, about −44 MB with 24. The smaller ring also stays hot: 64 KiB POST echo uses 11% fewer cycles.
  - A task that parks now releases its unused deeper region slots and takes them back when it wakes, so a connection waiting on a send no longer holds empty slots. async at 24k connections: 11% fewer cycles per request and 19% less RSS; json-tls at 4096 connections: 4% fewer cycles per request.
- TLS:
  - Sending now has two steps: `tls.Put` encrypts into a record batch and `tls.Flush` sends it (`tls.Send` is still Put + Flush). The receive side of `tls.Recv` flushes after handing out each received chunk. A connection waiting on a send no longer holds its response's working memory: json-tls at 4096 connections uses 23% less memory per active connection, 9% fewer cycles per request, and serves 7% more requests per second.
  - The sending key schedule is expanded once per connection instead of being copied per record, and AES-GCM keeps one working area per record (the tag is computed inside the AES block). About 4% fewer cycles per request on json-tls.
- Compression (flate / gzip):
  - At levels 4–6 (including level 6, the default of `http.Gzip{}`), positions inside long matches are no longer added to the hash chains. Level 6 encodes JSON bodies 24–29% faster, and a json-comp-style server answers 23% more requests locally. In exchange the output is slightly larger (about +1% on JSON bodies, about +10% on inputs made mostly of short matches). Pick level 7 or higher to keep the previous search and ratio.
  - Match lengths are compared 16 bytes at a time (SSE2). Encoding JSON bodies is 6–9% faster (levels 3–9), and the json-comp server uses 5.9% fewer cycles per request.
  - Fixed costs per encode and per block are lower: the code tables are no longer rebuilt each time, and the sort that assigns code lengths counts frequencies instead of inserting. 8–13% fewer instructions per encode and 7.5–8.4% fewer cycles per request on the json-comp server. The output bytes are unchanged.
- x86 optimizing backend: `/` and `%` by a non-power-of-two constant become a multiplication, and short memory copies (32 bytes or less) use two overlapping loads and stores. Writing JSON numbers and building responses get faster: 4–5% fewer cycles per request on json / json-tls at 256 connections.
- `net.Listen` sets TCP_NODELAY on the listener, and accepted connections inherit it, so small responses are not held back by Nagle's algorithm.

### Standard library

- Every public std function with a body now has an `@effects` declaration (also shown in `docs/std`). The declarations are checked against the derivation when stage2 is built.
- `net.Serve(…, maxWait:)` / `tls.Serve(…, maxWait:)` declare the wait bound D under saturation (default 100 ms). A connection's task and its children run within D of becoming runnable. When tasks with different D share a worker, the bound is the largest among them. It has no effect without saturation.
- `task.Ledger()` gains `maxWait` (the longest wait from becoming runnable to running, in ns; reading resets it to 0) and `aged` (how many times the bound kicked in — a sign of saturation). In operation: a growing `aged` means saturation; a `maxWait` far above D means something is wrong.
- `http.ServeFlushed`: ServeWith with two-step sending — the responses for one received chunk are queued with put and sent together (meant for TLS connections). See `tls.Put` / `tls.Flush` above.
- `binary.MatchLen(b, i, j, n)`: the length of the common prefix of b[i:i+n] and b[j:j+n]. The analyzer rejects secret values as arguments (the comparison takes variable time).
- `builder.PushWord(b, w, k)`: appends the low k bytes of w, lowest first (the same result as `Push` and `w >>= 8` repeated k times).

### Tools

- `sober fix --effects --std <dir>` reads the embedded std and writes the derived `@effects` onto the public functions that need one (for std maintenance).

### Runtime

- The runtime's depth invariant (a task never skips a depth when it enters a region) is now always checked. A hole of the kind fixed in v0.6.2 becomes a defined death — `panic: RegionDepthSkipped{} (runtime invariant broken in rt.slot_new — please report)` with exit code 81 — instead of silently wrong values. The cost is within measurement noise.

### Documentation

- Security guide (`docs/guide/security.md`, Japanese original `security.ja.md`): what the language and std prevent, what they don't, and what is left to you, in 12 sections. It opens with a quick table of three outcomes (cannot happen / becomes a defined death / remains) and a real-world vulnerability (an out-of-bounds write in Node.js's Brotli decompression) worked through in Sober. Code examples are the real files under `examples/security_*`.
- The benchmark numbers and charts in the public README were re-measured on a 16-vCPU GitHub Actions runner (AMD EPYC 9V45). The measure changed from local cycles to CPU time (task-clock — the median of per-round paired ratios). Across two runs of the same tree, 21 of the 26 ratios stayed within ±3% and every win / tie / loss call matched. 1BRC, binary-trees and logagg move by up to ±10% from day to day, and external sort and k-nucleotide against Rust by ±3–4%; `bench/README.md` notes this.

## v0.6.2 — 2026-10-23

A hotfix for v0.6.1, together with the first part of function effects in the analyzer.

### Language

- Function effects `@effects` (checked by `sober check` — build acceptance is unchanged):
  - The analyzer derives each function's effects from what it calls: `block` (may wait — task waits, channel operations), `io` (talks to the outside of the process), `panic` (an explicit `panic(…)`) and `nondet` (values that vary even with fixed input — time, timing).
  - A declaration is a claim about the derivation: prefix a function with `@effects(io)` / `@effects(!block)`, or suffix a named function type with `type F func(…) R @effects(…)`. A list is either all positive or all negated; `@effects()` means no effects.
  - A derived effect outside the declaration is rejected at the declaration, naming the first call that brings it in. Values of a named function type are checked against its contract.
  - Declarations are optional for now.
- `sober check <entry> --effects-dump` prints the derived effects.

### Tools

- `sober fix [--effects] [--errors] <entry>` writes the derived `@effects` / `@errors` declarations onto public functions that have none, and narrows word-only lists that are wider than the derivation. Negated lists, lists naming function types, internal functions and declarations that the derivation exceeds are left alone.

### Analyzer

- The lease-window performance lint now uses the derived effects (`block`) instead of its own check. It also sees waits through function values, so the set of warnings can change.

### Fixes

- Fixed memory corruption in programs that use std/task with two or more workers and io_uring available (the default on a multi-core host, unless seccomp blocks io_uring as Docker's default profile does): when a task other than `main` called `io.ReadFile` and the read had to wait, the runtime could release regions that were still in use, and two tasks could end up sharing the same memory. The symptom was silently wrong values or unexpected panics. The bug came in with v0.6.1.

### Testing

- New gate `scripts/nextgen.sh`: builds the compiler with the current runtime (with a runtime invariant check) and runs its own parallel build and check with 1, 2 and 8 workers, so runtime changes are exercised by the compiler itself before they reach a bootstrap step.

## v0.6.1 — 2026-10-23

A follow-up to the Web release.

- The HTTP layer now covers:
  - static files and conditional GET
  - chunked responses and SSE
  - multipart forms
  - compressed streams
- std gains encoding and decoding building blocks.
- The analyzer gets the first three parts of the effect surface:
  - `@errors` on function types
  - secret-value flow (`@secret`)
  - credential-derived responses meeting shared caches
- Servers with many connections use less memory and address space; the 48k-connection death is gone.

### Language

- Type aliases `type A = B`: A is another name for B and is interchangeable with it everywhere — assignment, type arguments, closures and leases.
  - The right-hand side must be a single declared type name (`N` / `ref.N`). Builtin types, composite types and instantiated generics are not allowed.
  - An alias of a generic type takes its type arguments at the use site (`type Box = lib.Box` → `Box[int]`).
  - Package-sensitive rules (field writes, sealed types, …) follow the declaration the alias points to.
- Borrowed closures may capture mut bindings: a lambda in a borrow position of a function-value call (`st((p) => …)`) can capture a mut local or mut parameter.
  - The capture is the binding itself, not a copy, and lasts only for the duration of the call.
  - The borrowed lambdas of one call capture at most one mut binding in total.
  - Closures in value positions, which can escape, are still rejected.
- `@errors` can follow a named function type: `type Stream func(…) error? @errors(emit, io.NotFound, …)`.
  - A lambda that becomes a value of that type is rejected if it fails with a label outside the declaration.
  - Calls through such values take their failure set from the declaration.
- `@exhaustive`: a switch inside an annotated function must name every member of the subject's closed set (all variants of a union, the error labels of one package, or the typed consts of a named scalar). Missing cases are reported by name. This is a check-only rule.
- Typed constants: `const OK = Status(200)` has type `Status`.
- `@secret` (check only — what `build` accepts does not change): declare parameters, struct fields or consts as secret sources, and the analyzer rejects secret values that reach a branch condition, an index or a division.
  - The key material in std/crypto and std/tls is marked.
  - A gate (ctcheck) checks that the generated machine code has no secret-dependent branches, and statistical timing tests (dudect) also run.
- Origin check (check only): rejects code where credential-derived values (`http.Authorization` / `http.Cookie` and values built from them) meet a response that a shared cache may store.
- A function without a mut parameter that returns a mut value (a type containing a mut slice or map) is now rejected by `build` with the same message as `check`. Previously only `build` accepted it.
- Zero values of `io.Root`, `net.Listener`, `net.Conn` and `tls.Conn` (such as `io.Root{}`) are rejected. Previously they could forge a handle to fd 0.
- A leading `@errors` on a non-function declaration (type / const) is now a syntax error. It used to be silently ignored.

### Standard library

- net / tls: `net.Serve` / `tls.Serve` take `region:`, a per-region limit for connection tasks (default 128 MiB).
  - A connection task that exceeds it dies alone; Serve absorbs the death, which counts as died in `task.Ledger()`.
  - Address space reserved per connection drops to a quarter. The `RegionExceeded{cause: va_exhausted}` death at 48k concurrent connections is gone (see Fixes).
- http — static files: `http.Static(prefix, root, precompressed:, cache:)`.
  - It never leaves `root`; the kernel guarantees this (see io below).
  - `precompressed:` picks `.br` / `.gz` variants by Accept-Encoding and serves them as is.
  - Weak ETags, Last-Modified, and preconditions (If-Match / If-None-Match / If-Modified-Since / If-Unmodified-Since → 304 / 412).
- http — cache policy: `Response.cache` / `Route.cache`, of type `http.Cache` (`Revalidate` / `Fresh{maxAge, immutable}` / `Private{maxAge}` / `NoStore`). Responses without a policy get `Cache-Control: private`.
- http — response framing: a stream response of unknown length (`Response.length` is now `int?`; nil means unknown) is sent with `Transfer-Encoding: chunked` over HTTP/1.1. HTTP/1.0 responses are delimited by closing the connection (`Connection: close`).
- http — compressed streams: `Response{stream:}` is now subject to `compress:`. Clients that accept gzip get gzip chunks; others get plain chunks with `Vary`.
- http — SSE: `http.Event` / `http.FormatEvent`.
  - Newlines in data are split into separate `data:` lines.
  - Newlines in event or id panic (`BadEvent`).
  - `text/event-stream` is never compressed.
- http — also new:
  - `http.Multipart(r)` (multipart/form-data, RFC 7578)
  - `http.Authorization(r)` and `http.Cookie(r, name)`
  - the `http.StatusCode` type with typed consts (`http.OK`, …)
- io: `io.OpenRoot` / `io.CloseRoot` / `io.OpenUnder` use openat2 with RESOLVE_BENEATH, so the kernel rejects `..`, absolute paths and symlinks that point outside. Also new: `io.Stat` (size, modTime, kind).
- compress: `flate.Decode` / `gzip.Decode`, with `maxSize:` against decompression bombs.
- base64 (new): standard and URL-safe alphabets, strict decoding.
- url (new): `Escape` / `Unescape` / `ParseQuery`.
- strings: `Split` / `Fields` / `TrimSpace` / `TrimSuffix` / `ToLower` / `ToUpper` / `EqualFold` / `Replace` / `LastIndex`. Signatures match Go; whitespace and case are ASCII only.
- convert: `ParseBool` / `FormatBool`.
- crypto: `SealTo` takes a positional `tail` (plaintext = pt ‖ tail — aesgcm / chacha20poly1305), which saves one copy.
- When running as a container's init (PID 1), SIGTERM / SIGINT now stop the program with exit 143 / 130. Previously it was SIGKILLed after the `docker stop` / `podman stop` grace period. No tini / `--init` needed.

### Breaking changes

- `http.Response.status` and `http.Status(code)` are `http.StatusCode`. Integer literals still work.
- `http.Response.length` is `int?` (nil means unknown length → chunked).
- `SealTo(…)` in crypto takes a trailing `tail` (`[]byte{}` if none).
- Setting `Cache-Control`, `CDN-Cache-Control`, `Surrogate-Control`, `ETag` or `Last-Modified` as custom headers panics (`BadHeader`). Use `cache:` for the policy; `http.Static` sets ETag / Last-Modified.
- `http.Header(r, …)` returns nil for `Authorization`, `Proxy-Authorization` and `Cookie`. Use `http.Authorization` / `http.Cookie`.
- Responses without a cache policy carry `Cache-Control: private`, including 404, 405 and errors.
- 1xx, 204 and 304 responses no longer carry `Content-Length` (RFC 9110 §8.6; `Content-Length: 0` on 204 was a violation).
- The three new rejections under Language: mut-returning functions, zero values of identity types, and `@errors` on non-function declarations.
- Level-6 (default) `compress:` output bytes change: the lazy-match threshold went from 16 to 12. The compression ratio stays on par with zlib.

### Performance

- HTTP — measured on bench/httparena, our own harness rather than an official HttpArena result. It uses the HttpArena load generators and request files on a 64-vCPU GitHub Actions runner, with 32 server cores, and compares against Go's net/http. Sober / Go ratios:

  | Test | Sober / Go |
  |---|---|
  | baseline | 3.0× |
  | pipelined | 16× |
  | limited-conn | 7.2× |
  | json | 3.1× |
  | json-tls | 2.3× |
  | json-comp | 1.3× |
  | async | 1.9× |

  - latency-500k-8cpu holds the 500K req/s target at p99 0.28 ms, while Go falls behind the rate and its p99 grows to seconds.
  - latency-1m sustains 998K req/s at p99 0.13 ms.
  - No non-2xx responses in any test.
- Memory: server RSS, compared with a run earlier in this cycle (before the two fixes below):

  | Test | Before | After |
  |---|---|---|
  | baseline | 321 MB | 140 MB |
  | latency-10k | 254 MB | 89 MB |
  | json-comp | 432 MB | 191 MB |
  | json-tls | 637 MB | 388 MB |
  | async | 898 MB | 814 MB |

  Two changes account for most of this:
  - region pages are kept out of transparent huge pages on THP=always machines
  - a waiting task releases the regions of dead depths
- Connections: async at 32k connections runs five rounds with no errors or reconnects. 48k connections locally also run with no reconnects (previously a va_exhausted death).
- Timers: `os.Sleep` waits are kept in a per-worker clock table instead of one io_uring entry each. async moves from 1.7× to 1.9× of Go between the GHA runs before and after; locally, async uses 13–16% less CPU per request, and rps is up 17% at 16k connections.
- Compiler:
  - fixed a hole where calls through function values paid for extra zeroing of the result slot (HTTP keep-alive cycles −5–6% locally)
  - frame-slot and spill-slot coloring
  - calls that never return now end their block
  - deflate level-6 tuning (json-comp instructions −5%)
- HTTP: request headers are scanned once, there is a fast path for response headers, and Accept-Encoding is read only for compressible responses.

### Fixes

- `RegionExceeded{cause: va_exhausted}` at 48k concurrent connections (per-connection address space — see `region:` above).
- Not stopping on SIGTERM as a container's PID 1 (above).
- 204 responses carried `Content-Length: 0`.
- Five cases where `sober check` and `sober build` disagreed:
  - if branches in a `T?`-expected position
  - closures capturing a value narrowed by a nil check
  - a trailing nil in a block-bodied lambda
  - `g(x)?` on a closure value in a value position
  - mut-returning functions
- `sober check std/<pkg> --test` did not check test bodies.
- Three constant-time fixes in std/tls and std/crypto, all found by the `@secret` check:
  - the X25519 all-zero check now uses a constant-time compare
  - early exit on the long zero-padding path in the TLS record layer
  - RSA-PSS self-verification

### Distribution

- Each tag publishes a toolchain image to ghcr.io/sober-lang/sober (alpine + sober, byte-identical to the release tarball). `FROM ghcr.io/sober-lang/sober:0.6.1` works.

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
