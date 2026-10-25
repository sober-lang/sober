# Security guide

English | [日本語](security.ja.md)

This guide goes threat by threat through what Sober programs are protected from, and what they are not. Each section runs "threat → Sober's answer → example". The examples are the real files in `examples/`: the verification net checks every one of them on each run (and builds and runs the ones with output), and compares the outputs and rejection diagnostics shown here.

Please read the last section, "[What Sober does not protect](#12-what-sober-does-not-protect)", too. A language can remove only some kinds of accidents, and knowing what remains is part of being safe.

## 0. How to read this — two layers and two checks

Sober answers each kind of accident in one of two layers.

- **Removed by structure**: the shape that causes the accident cannot be written in the language. Memory corruption, data races, resource leaks and path traversal are here. Write the shape and both `sober build` and `sober check` reject it.
- **Removed by declarations and analysis**: properties that structure cannot express are derived by the analyzer from the call graph and the flow of values, and compared with declarations. Unhandled errors, branches on secrets, storing authenticated responses in shared caches, and function effects are here.

**The analyzer's rules are applied only by `sober check`.** `sober build` does not run the analyzer and does not change what it accepts (the analyzer only narrows what is accepted; it never changes a program's meaning). To make the rules marked "rejected by check" in this guide take effect, run `sober check <file.sober>` in CI or before you commit. The rules that build rejects (the structural layer) stop the program either way.

The sections that follow go threat by threat, but as a quick reference, three classes cover most of them.

| Class | Meaning | Sections |
|---|---|---|
| Cannot happen | The language's structure makes the shape unwritable | 1, 2 |
| Becomes a defined death | Not undefined behavior but a labeled panic — the death is contained to the task (the connection), and the process stays alive | 1, 4, 9 |
| Remains — the user's design work | Authorization, business logic, input meaning, algorithmic-complexity DoS, etc. | 12 |

This table is a quick reference; the detail for each threat is in its own section, and the honest account of what "remains" is gathered in section 12.

## 1. Memory corruption

Threat: references to freed memory (use after free, dangling pointers), double frees, reads and writes out of an array's bounds, null dereferences.

Sober's answer: there is no GC and no borrow checker, but every value's lifetime matches the nesting of scopes. Every block is a region (an area for allocation), and leaving the block frees everything made in it at once. Values that leave the scope (return values, assignments to outer bindings) are copied into the outer region. An outer region never points into an inner one, so dangling references cannot be made. Freeing happens per region, so there are no double frees either.

- Indexes and subslices are bounds-checked. An out-of-range index stops with a panic (exit code 101) instead of reading or writing the neighbouring memory.
- Values are non-null by default. `nil` lives only in `T?` types, and a `T?` value cannot be used as a `T` until it has been checked against `nil`.

```sober
// examples/security_memory.sober
package main

// Security: memory — values outlive their scope by being copied out, never by dangling (docs/guide/security.md)

// the string is made in this function's region; return copies it out to the caller's region
func greeting(name string) string {
    msg := "hello, ${name}"
    return msg
}

// an index can fail, so the lookup says so in its type: int? must be checked before use
func at(xs []int, i int) int? {
    return if i >= 0 && i < len(xs) { xs[i] } else { nil }
}

func main() int {
    people := []string{"ada", "bob"}
    mut names := mut []string{}
    for n <- people {
        names = append(names, greeting(n))   // the loop body's region is freed each iteration; the kept value is copied out
    }
    println(names[0], "/", names[1])
    xs := []int{10, 20, 30}
    probes := []int{1, 5}
    for i <- probes {
        v := at(xs, i)
        println(if v != nil { "xs[${i}] = ${v}" } else { "xs[${i}]: out of range" })
    }
    return 0
}
```

Output:

```
hello, ada / hello, bob
xs[1] = 20
xs[5]: out of range
```

Because `at` returns `int?`, the caller cannot use the value without writing the out-of-range case. Writing `xs[5]` directly stops at the out-of-range access with a panic.

Real-world contrast: in its October 2026 security release, Node.js fixed a vulnerability in its bundled Brotli (a C implementation) — an out-of-bounds write during decompression that could lead to remote code execution (CVE-2026-111497). Writing the same shape in Sober, the decompressor's output writes are bounds-checked on the slice, so crafted compressed data can at most trigger "decompression failed — a labeled panic (only that connection's task dies)" — it cannot become memory corruption or RCE. What still remains: sending input that triggers a panic can still get a connection cut (see admission in [section 9](#9-resource-exhaustion-denial-of-service)).

More: [language spec 9 Memory](../spec/09-memory.ja.md) (Japanese) · [Design note: safe](../design-notes/safe.md) (Japanese)

## 2. Data races

Threat: several threads read and write the same mutable value at the same time, producing broken values or results that depend on timing.

Sober's answer: only immutable values (frozen with `freeze`, or immutable bindings) and channels can be passed into a parallel scope (the children of `task.Spawn`, the element tasks of `task.Map`). A `mut` value never crosses a task boundary. The send end and the receive end of a channel are each owned by a single task. Shared mutable state cannot be written, so data races cannot be written. This rule applies in both build and check.

```sober
// examples/security_race_neg.sober
package main

// Security: data races — a spawned task cannot capture a mut binding (rejected by check and build) (docs/guide/security.md)

import "std/task"

func main() {
    mut hits := 0
    r, _ := task.Run((s task.Scope) => task.Join(task.Spawn(s, () => hits + 1)))
    hits += 1
    println(r)
}
```

Rejected:

```
sober: load error at examples/security_race_neg.sober:9:70: a spawned task cannot capture a mut binding (the child sees only imm values — pass a copy: v := x before the Spawn)
```

How to write parallel code is in [Tour section 7](tour.md#7-parallelism--structured-concurrency-channels).

More: [language spec 10 Concurrency](../spec/10-concurrency.ja.md) (Japanese)

## 3. Unhandled errors

Threat: carrying on without checking that an operation failed (letting a failed authentication through, for example). Not being able to see from the source which functions can fail, and how.

Sober's answer: errors are labels (`type Expired error`), and a function that can fail returns `(T, error?)`. The analyzer derives, from the call graph, the set of labels each function can return.

- A `switch err` must cover every label the value can carry (an arm it does not cover is written explicitly as `default`).
- A public function (one whose name starts with an upper-case letter) that returns an error declares the labels it can return with `@errors(…)`. The declaration is compared with the derivation: if a label outside the declaration can be returned, the function is rejected (for public functions a declaration wider than the derivation is rejected too, so stale declarations do not linger). A call across packages reads the callee's declaration, so when a dependency starts returning a new failure, it shows up in the diff as a changed declaration. `sober fix --errors` can write the declarations from the derivation.
- A switch in a function marked `@exhaustive` must name every member of a closed set (all variants of a union, all error labels of the package). When you later add a variant or a label, the switches that forgot to handle it stop.

```sober
// examples/security_errors_neg.sober
package main

// Security: unhandled errors — a switch over an error must cover every label it may carry (rejected by check) (docs/guide/security.md)

type Expired error

type Revoked error {
    by string
}

func session(token string) (string, error?) {
    if token == "" {
        return "", Expired{}
    }
    if token == "old" {
        return "", Revoked{by: "admin"}
    }
    return "user-1", nil
}

func main() {
    who, err := session("old")
    if err != nil {
        switch err {
        case Expired{}: println("please sign in again")
        }
        return
    }
    println(who)
}
```

Rejected:

```
examples/security_errors_neg.sober:24:9: error: switch does not cover Revoked (error labels the subject may carry): add cases or a default (Analyzer)
```

Forgetting `Revoked` and slipping past the `err != nil` check is stopped by check (build does not run the analyzer, so it accepts the program, and the label it does not cover stops it with a panic when it actually arrives).

More: [Tour section 5](tour.md#5-errors--labels--catch-switch) · [language spec 7 Errors](../spec/07-errors.ja.md) (Japanese) · [12 A-8 (@exhaustive)](../spec/12-annotations.ja.md) (Japanese)

## 4. panic — when it stops, it says why and where

Threat: a program keeps running in a broken state. Or it stops, but you cannot tell why.

Sober's answer: there are only two kinds of panic. Those where carrying on would break safety (writing to a frozen value, going over a region's limit, and so on), and those a correct program never reaches (an index out of range, an explicit `panic(L{…})`). Ordinary failures — a file that is not there, broken input — are returned as error labels, not panics.

An explicit panic needs a reason label (`Unreachable`, `InvariantBroken`, or one you declare as `type L panic{…}`). On death the program writes one line with the label's fields and the position (file:line:column) to standard error and ends with exit code 101 (102 when the region's resources run out).

```sober
// examples/security_panic_neg.sober
package main

// Security: panic needs a reason — a bare panic() is rejected (docs/guide/security.md)

func main() {
    panic()
}
```

Rejected:

```
sober: load error at examples/security_panic_neg.sober:6:10: panic needs a reason: panic(L{…}) with a panic label (Unreachable, InvariantBroken, or one declared as type L panic{…})
```

When a child task dies, the death reaches the parent through structure, not as a value (the scope fails at its exit). So that user code never runs on the broken, half-done state of a dead task, the dead task's `defer`s do not run — but its open files and connections are still closed at the task's exit (next section).

More: [Design note: safe — when does a panic happen](../design-notes/safe.md) (Japanese)

## 5. Resource leaks

Threat: forgetting to close an open file or connection (running out of descriptors), closing it twice, using it after it is closed.

Sober's answer: open resources (`io.File`, `io.Root`, `net.Conn` and so on) are types with identity: they cannot be copied, cannot leave the block that opened them, and cannot be stored in structs or channels. The statement right after an `io.Open` must be `defer io.Close(f)`, and `io.Close` cannot be written outside that form. So forgetting to close, closing too early and closing twice cannot be written. Even if a task dies and its defers do not run, its open descriptors are closed at the task's exit. Connections (`net.Listen`, `net.Dial`, `net.Accept`) are for generators, and std closes them when the body is left.

```sober
// examples/security_file_neg.sober
package main

// Security: leaked files — the statement right after an Open must be its defer io.Close (docs/guide/security.md)

import "std/io"

func main() {
    f := io.Open("testdata/io/hello.txt") catch return
    b := io.ReadAll(f) catch return
    println(len(b))
}
```

Rejected:

```
sober: load error at examples/security_file_neg.sober:8:17: the file opened here must be closed by the next statement: insert `defer io.Close(f)` (with the name bound here — `defer io.CloseRoot(r)` for io.OpenRoot) right after this line
```

The diagnostic shows the line to insert (`defer io.Close(f)`) as it is.

More: [language spec 11 io](../spec/11-io.ja.md) (Japanese)

## 6. Path traversal

Threat: a path sent by a user (`../../etc/passwd`, an absolute path, a symlink pointing outside) reads files outside the directory you meant to publish.

Sober's answer: open untrusted paths only under a root directory, an `io.Root`. `io.OpenUnder(r, rel)` opens rel only under r: leaving with `..`, absolute paths and symlinks pointing outside are refused during resolution and give `io.Denied`. The kernel holds the guarantee (Linux's openat2 with `RESOLVE_BENEATH`); std does not inspect rel as a string — there is no room for the loopholes of string checks (different encodings, a symlink swapped in). On a kernel without openat2 it does not open the file and returns `io.Other` (it never falls back to opening).

```sober
// examples/security_root.sober
package main

// Security: path traversal — open a path only under a root directory (docs/guide/security.md)
// run from the repository root

import "std/io"

// serve reads the file named by an untrusted path, but only under r
@errors(io.NotFound, io.Denied, io.Other, io.Timeout, io.Expired)
func serve(r io.Root, rel string) (int, error?) {
    f := io.OpenUnder(r, rel)?
    defer io.Close(f)
    b := io.ReadAll(f)?
    return len(b), nil
}

func show(r io.Root, rel string) {
    n, e := serve(r, rel)
    println(switch e {
    case nil: "${rel}: ${n} bytes"
    case io.NotFound{}: "${rel}: not found"
    case io.Denied{}: "${rel}: denied"
    default: "${rel}: other error"
    })
}

@errors(io.NotFound, io.Denied, io.Other, io.Timeout, io.Expired)
func run() error? {
    r := io.OpenRoot("testdata/io")?
    defer io.CloseRoot(r)
    paths := []string{"hello.txt", "../../README.md", "/etc/passwd", "missing.txt"}
    for rel <- paths {
        show(r, rel)
    }
    return nil
}

func main() {
    if run() != nil {
        println("cannot open the root")
    }
}
```

Output:

```
hello.txt: 17 bytes
../../README.md: denied
/etc/passwd: denied
missing.txt: not found
```

`http.Static` (serving static files) opens files through this. A request pointing outside the root gets the same 404 as a missing file (it does not reveal whether files outside exist).

More: [language spec 11 I-7](../spec/11-io.ja.md) (Japanese) · [std/http Static](../std/http.ja.md#static) (Japanese)

## 7. Secrets leaking through timing

Threat: branching, indexing or dividing on a secret value such as a key or a MAC tag makes the running time depend on the secret, and an attacker who measures the time can guess the secret (the classic case: a comparison from the front that exits at the first difference).

Sober's answer: you declare that your value is secret with `@secret` — in three places: before a function, `@secret(k)` (treat the parameter k as secret); after a struct field; before a const. The analyzer follows the secret values, and the values derived from them by arithmetic, comparison, assignment and function results, and rejects the forms where one reaches a branch condition, a switch subject, the left of `&&` / `||`, an index, the ends of a slice, a map key, or `/` and `%`. If a function given a secret uses that parameter in a branch, the call that passed it is rejected too. The result of `len` is public.

Compare with std's `crypto.Equal`. It folds all the bytes and decides only once at the end, so where the inputs differ does not show in the time. Its result is treated as public (std declares it so). The key material of std/crypto and std/tls is already declared secret on std's side.

```sober
// examples/security_secret.sober
package main

// Security: timing — a MAC tag is compared with crypto.Equal, which does not branch on the bytes (docs/guide/security.md)

import "std/crypto"
import "std/crypto/hmac"

// the key is a secret: no branch, index or division may depend on it
@secret(key)
func valid(key []byte, msg []byte, tag []byte) bool {
    return crypto.Equal(hmac.Sum256(key, msg), tag)
}

func main() {
    key := bytes("k3y-0f-the-server")
    tag := hmac.Sum256(key, bytes("user=ada"))
    println(valid(key, bytes("user=ada"), tag))
    println(valid(key, bytes("user=root"), tag))
}
```

Output:

```
true
false
```

Write the same thing as a comparison from the front that exits at the first difference, and check rejects it.

```sober
// examples/security_secret_neg.sober
package main

// Security: timing — an early-exit comparison of a secret leaks where the bytes differ (rejected by check) (docs/guide/security.md)

@secret(tag)
func same(tag []byte, got []byte) bool {
    if len(tag) != len(got) {
        return false
    }
    mut i := 0
    while i < len(tag) {
        if tag[i] != got[i] {
            return false
        }
        i += 1
    }
    return true
}

func main() {
    println(same(bytes("abc"), bytes("abd")))
}
```

Rejected:

```
examples/security_secret_neg.sober:12:19: error: a value derived from the @secret parameter 'tag' of 'main.same' reaches a branch condition — its timing would reveal the secret (language.md 12 節「秘密の値の宣言」) (Analyzer)
```

The length comparison on line 7 passes (the length is public). What is rejected is line 12, which branches on the content of the secret.

More: [language spec 12 A-9 to A-11](../spec/12-annotations.ja.md) (Japanese)

## 8. Authenticated responses landing in a shared cache

Threat: the origin declares that a response whose content depends on a Cookie or Authorization (the "my account" page) may be stored by a CDN or another shared cache. The stored response is then served to the next person who requests the same URL (one form of web cache deception). The HTTP standard protects responses to requests with Authorization, but there is no such protection for Cookie.

Sober's answer: two layers.

- Structure (std/http): the storage policy is written only in typed fields (`Route.cache`, `Response.cache`, Static's `cache:`); there is no way to write Cache-Control as an arbitrary header. Dynamic responses default to `Cache-Control: private`. Credentials can be read only through the named accessors `http.Authorization` / `http.Cookie` (`http.Header` returns nil for the credential headers).
- Analysis: policies that let shared caches store the response (`http.Fresh`, `http.Shared`) can be written only on route rows. check rejects the forms where that route's handler or middleware can reach a credential accessor, and the form that mounts a route with a shared policy under an authenticating middleware.

Sharing public assets while keeping the authenticated API private is accepted.

```sober
// examples/security_cache.sober
package main

// Security: shared caches — public assets may be cached by a CDN; responses that read a cookie stay private (docs/guide/security.md)

import "std/http"

// me depends on the session cookie, so its response must not be stored by a shared cache
func me(r http.Request) http.Response {
    sid := http.Cookie(r, "sid")
    return http.Text(if sid != nil { "signed in" } else { "guest" })
}

func main() {
    auth := http.Middleware{before: (r) => if http.Cookie(r, "sid") == nil { http.Status(401) } else { nil }}
    api := http.Mount("/api", []http.Route{http.Route{method: "GET", path: "/me", handler: me, cache: http.Private{maxAge: 30}}}, []http.Middleware{auth})
    assets := http.Static("/assets", "/srv/www", cache: http.Shared{maxAge: 3600, sMaxAge: 86400})
    routes := http.Merge(api, assets)
    println(len(routes))
}
```

Output:

```
2
```

Write a shared policy on the route of a handler that reads a Cookie, and check rejects it.

```sober
// examples/security_cache_neg.sober
package main

// Security: shared caches — a route that lets a CDN store its response must not read a cookie (rejected by check) (docs/guide/security.md)

import "std/http"

func me(r http.Request) http.Response {
    sid := http.Cookie(r, "sid")
    return http.Text(if sid != nil { "signed in" } else { "guest" })
}

func main() {
    routes := []http.Route{http.Route{method: "GET", path: "/me", handler: me, cache: http.Shared{maxAge: 60}}}
    println(len(routes))
}
```

Rejected:

```
examples/security_cache_neg.sober:13:28: error: the shared cache policy 'Shared' meets a handler or middleware that reaches a credential source (http.Authorization / http.Cookie / Request.head) in one route — a response that depends on Authorization / Cookie must not be stored by a shared cache — it would be served to other users (language.md 12 節「出所の依存」); use http.Private / http.NoStore for this route, or move the credential read out of it (Analyzer)
```

More: [std/http Cache](../std/http.ja.md#cache) (Japanese) · [language spec 12 A-12, A-13](../spec/12-annotations.ja.md) (Japanese)

## 9. Resource exhaustion (denial of service)

Threat: many connections, large requests, or memory-hungry requests stop the whole server or use up its memory.

Sober's answer: the server (`net.Serve`) has ceilings on resources in three layers.

- **Admission**: `conns:` is the ceiling on simultaneous connections (default 10000). A connection over the ceiling is sent the `reject:` bytes and closed without running user code.
- **Budget (`budget:`)**: the declared upper bound of the memory one connection uses (default 64 KiB). The admission ceiling is counted in bytes, `conns × budget`. For tasks in general, writing `budget:` on `task.Spawn` and friends makes the children that do not fit under the ceiling run sequentially instead of in parallel (values and output do not change).
- **Region cap (`region:`)**: the cap on one region of a connection's task (default 128 MiB). Going over kills only that connection's task; Serve absorbs it and carries on with the other connections.

At the HTTP layer, the request head and body have limits (`http.ServeConn`'s `maxHead:`, default 8 KiB, gives 431 when exceeded; `maxBody:`, default 16 KiB, gives 413 — the handler does not run). Waits can be given a deadline (`task.Run(…, deadline:)` — io after the deadline returns `io.Expired`, and net waits are cut at the deadline).

```sober
// examples/security_limits.sober
package main

// Security: resource exhaustion — admission, a per-connection budget and a per-connection region cap (docs/guide/security.md)
// a server: check and build only (it does not stop by itself)

import "std/http"
import "std/net"
import "std/task"

func route(r http.Request) http.Response {
    return http.Text("ok")
}

// app serves one connection; oversized heads and bodies get 431 / 413 before route runs
func app(c net.Conn) error? {
    return http.ServeConn(c, route, maxHead: 8 * task.KB, maxBody: 64 * task.KB)
}

func run() error? {
    for l <- net.Listen("0.0.0.0:8080")? {
        // at most 2,000 connections at once (the 2,001st gets the reject bytes and is closed without running app);
        // each connection may use up to 256 KiB, and a connection whose region passes 32 MiB dies alone
        net.Serve(l, app, budget: 256 * task.KB, conns: 2000, reject: "HTTP/1.1 503 Service Unavailable\r\ncontent-length: 0\r\n\r\n", region: 32 * task.MB)?
    }
    return nil
}

func main() {
    if run() != nil {
        println("listen failed")
    }
}
```

This example is a server, so the net checks and builds it (it does not stop when run, so there is no output to compare).

More: [std/net Serve](../std/net.ja.md) (Japanese) · [language spec 10.6 Budgets, pools and deadlines](../spec/10-concurrency.ja.md) (Japanese) · [std/http ServeConn](../std/http.ja.md) (Japanese)

## 10. Functions doing things behind your back

Threat: a function meant to be a pure calculation starts writing logs, going to the network, reading the clock or waiting. If a function you depend on changes like that, the caller's source does not show it.

Sober's answer: the analyzer derives each function's effects. There are four words — `block` (may wait), `io` (talks to the world outside the process — `println` included), `panic` (an explicit `panic(L{…})`) and `nondet` (values that vary even with fixed input, such as reading the clock). The effects of a function you call are your effects.

`@effects(…)` claims "this function's effects stay within what is written here", and check compares the claim with the derivation.

- The negative form `@effects(!io, !block)` states a human's intent. If io later enters the function, it stops at the declaration and names the call it came in through.
- The positive list `@effects(io)` is an upper bound on the allowed effects. `sober fix --effects` can write it from the derivation.
- On a named function type, `type Rule func(…) R @effects(…)` after the type is a contract for all of its values (lambdas and functions).

Every public function of the standard library declares `@effects` (shown in each function's signature in the [std reference](../std/README.ja.md) (Japanese)). The declarations are checked to match the derivation, so when a std function starts doing io, it shows up in the diff as a changed declaration.

```sober
// examples/security_effects.sober
package main

// Security: hidden effects — @effects states what a function may do, and check compares it with what the body does (docs/guide/security.md)

// a pricing rule: the type promises its values do no I/O, never wait, and do not read the clock
type Rule func(amount int) int @effects(!io, !block, !nondet)

@effects(!io, !block, !nondet)
func fee(amount int) int {
    return amount / 100 + 30
}

// the positive list is an upper bound: this function may do io (printing) and nothing else
@effects(io)
func audit(msg string) {
    println(msg)
}

@effects(io, Rule)
func charge(rule Rule, amount int) {
    audit("charge ${amount + rule(amount)}")
}

func main() {
    charge(fee, 5000)
    charge((a) => a / 50, 5000)
}
```

Output:

```
charge 5080
charge 5100
```

A function declared to do no io stops when it starts calling the logging function.

```sober
// examples/security_effects_neg.sober
package main

// Security: hidden effects — a function declared without io starts logging (rejected by check) (docs/guide/security.md)

func audit(msg string) {
    println(msg)
}

@effects(!io, !block, !nondet)
func fee(amount int) int {
    audit("fee for ${amount}")
    return amount / 100 + 30
}

func main() {
    println(fee(5000))
}
```

Rejected:

```
examples/security_effects_neg.sober:9:1: error: 'main.fee' may have the effect io via the call of 'main.audit', which its @effects does not allow (allowed: panic) (Analyzer)
```

The same derivation also drives the warning on `task.Lease` windows, which borrow per-worker scratch space (if the window may wait, the borrow falls back to a fresh allocation and gets slower — a warning, not a rejection). Waits through function values are visible to it through this derivation.

More: [language spec 12.5 Function effects](../spec/12-annotations.ja.md) (Japanese)

## 11. Supply chain

Threat: malicious code or vulnerabilities slip in through dependency packages, build tools or runtime libraries. The runtime image carries things it does not need.

Sober's answer:

- Zero dependencies. The compiler is a single static ELF that depends on neither libc nor LLVM, and the executables it produces are static ELFs too. The standard library depends on no outside libraries. There is no package manager yet, and a program can import only std and its own source packages.
- Full bootstrap. The compiler is built from the frozen first version written in Zig, by building the source snapshots in `bootstrap/` in order. There is no seed binary ([Install](install.md)).
- The runtime environment can be empty. The output is a single static ELF, so a container image needs nothing but `FROM scratch` and that one executable — no shell, no libc, no packages. The [Dockerfile](../../bench/httparena/Dockerfile) of the HttpArena entry has this shape (the build stage is the official sober image, the run stage is scratch). It also stops on SIGTERM / SIGINT when run as PID 1, so no init tool is needed. For io_uring and resource-limit settings see [Install — running servers](install.md#running-servers).

## 12. What Sober does not protect

A language can remove only some kinds of accidents. The following stay the writer's responsibility, even with Sober.

- **Authorization and business logic**: who may do what, whether this request is allowed for this user, whether the rules about amounts or stock are right. The language does not remove these. Reading a credential and branching on it is the ordinary shape of a correct program, and whether that branch is right is not something the language can know.
- **Not running the analyzer**: the rules in sections 3, 7, 8 and 10 are applied only by `sober check`. If you only build, they do not apply.
- **Validating what input means**: beyond the type and UTF-8 checks — value ranges, formats, business validity — the writer checks.
- **SQL injection**: there is no database client in std yet. Today's Sober has no specific answer to this accident.
- **Mishandling secrets**: `@secret` looks only at timing flows in the source (branches, indexes, division). It does not stop writing a secret to a log or a response (printing is outside the check), reusing keys or nonces, or misusing randomness. For user code, it does not go as far as checking that the generated machine code has no branches.
- **What remains of caching**: a CDN configured to ignore `private`, missing Vary, tokens in the query or the body, and responses that vary by the client's IP are outside section 8's check.
- **Requests that choke on computation**: a deadline (`deadline:`) is a limit on waiting, not on running time. Computation that is running is not stopped. Where you accept heavy computation, put a limit on the size of the input yourself. There is also no graceful shutdown that drains in-flight connections yet (stopping cuts them).
- **The reach of the proofs**: memory safety and data-race freedom are proved in Lean 4 for a formal model of the language's core, but what is proved is a property of the model, not of the compiler's implementation itself ([Design note: safe](../design-notes/safe.md) (Japanese)). Bugs in the compiler, the runtime or the kernel are outside every answer in this guide.

---

This guide gains sections each time the language gets a new safety mechanism. The exact definitions of the rules are in the [language specification](../spec/README.ja.md) (Japanese), and the history of the decisions is in the [decision record](../language.md) (for developers, Japanese).
