# Concurrency — tasks, channels and domains

English | [日本語](concurrency.ja.md)

Concurrency in Sober is written with the functions of `std/task`. There is no new syntax. This page is a short guide to how to write a concurrent program and what the language promises about it. The exact rules are in [chapter 10 of the language specification](../spec/10-concurrency.ja.md) (in Japanese).

| What you want to do | The Sober form | Section |
| --- | --- | --- |
| Split work and run it in parallel | a `task.Run` scope + `task.Spawn` / `task.Map` | 1 |
| Pass values to a child | capture (immutable values only), `freeze` | 2 |
| Stream values between tasks | channels (one sender, one receiver) | 3 |
| Receive a child's failure or death | `task.Join` / `task.Try` / the scope's err | 4 |
| Update one state from many tasks | domains | 5 |

Prerequisites: sections 6 (mut and freeze) and 7 (parallelism) of the [language tour](tour.md).

## 1. Tasks and scopes — the same result in parallel as in sequence

`task.Run((s task.Scope) => body)` opens a scope, and `task.Spawn(s, g)` inside the body creates a child task. Every child finishes before the scope exits. No task outlives its scope.

An example where both the children and the parent write to standard output:

```sober
// examples/task_print_order.sober
package main

// 子と親が両方 stdout へ書く。出力の順は「spawn の木の先行順」で決まりスケジュールに依らない — 親の "parent" は 2 つの子の流れの後
// （スケジュール依存の証人の役は直書きの examples/task_print_direct へ）

import "std/task"

func work(tag string, n int) int {
    mut i := 0
    mut acc := 0
    while i < n {
        println("${tag} ${i}")
        acc += i
        i += 1
    }
    return acc
}

func main() {
    println("start")
    r, e := task.Run((s task.Scope) => {
        a := task.Spawn(s, () => work("a", 2))
        b := task.Spawn(s, () => work("b", 2))
        println("parent")
        task.Join(a) + task.Join(b)
    })
    println(r)
}
```

Output:

```
start
a 0
a 1
b 0
b 1
parent
2
```

The parent's `parent` comes after the output of both children. The order of `println` output is the preorder of the spawn tree: a child's whole output goes in at the place where the parent spawned it. This is the same order as running on one worker with each child run first. Changing the number of workers (`SOBER_WORKERS`) leaves standard output byte-for-byte the same.

The same holds for result values. With the io inputs fixed, the value of a scope depends neither on the schedule nor on the number of workers. The result of running in parallel matches the result of running in sequence.

To create one task per element, use `task.Map(xs, f)`. The results come back in index order ([language tour, section 7](tour.md#7-parallelism--structured-concurrency-channels)).

## 2. Passing values — pass immutable values instead of writing shared ones

A child's body (the lambda passed to `task.Spawn`) can capture only immutable values. The checker rejects capturing a mut binding.

```sober
// examples/task_neg_mut.sober
package main

// mut の束縛の捕獲（diag.Par kind 4 — check と build が同じ拒否。desugar/parcheck.sober）

import "std/task"

func main() {
    mut c := 1
    r, e := task.Run((s task.Scope) => task.Join(task.Spawn(s, () => c + 1)))
    println(r)
}
```

Rejected:

```
sober: load error at examples/task_neg_mut.sober:9:70: a spawned task cannot capture a mut binding (the child sees only imm values — pass a copy: v := x before the Spawn)
```

So two tasks writing the same value at the same time (a data race) cannot be written. No locks are needed either.

To let a child read a value you built with mut, make it immutable with `freeze` and then pass it.

```sober
// examples/task_frozen_map.sober (excerpt)
func direct(n int) int {
    mut m0 := mut map[int]int{}
    for i <- iter.Range(0, n) {
        m0[i] = i * 2
    }
    m := freeze(m0)
    r, e := task.Run((s task.Scope) => task.Join(task.Spawn(s, () => look(m, n))))
    return r
}
```

After `freeze(m0)`, `m0` can no longer be written. The child only reads the immutable `m`.

A child's result is immutable data too. It can return strings, slices, maps and structs of them, and the value is copied from the child to the scope.

## 3. Channels — one sender, one receiver

`task.NewChannel[T](cap: n)` makes a pair of a sending end and a receiving end. Each end is held by exactly one task. You hand exactly one end to a child with `give:` (ends cannot be captured).

A channel has one sender, so there is no such order as "whose value arrived first". There is no `select` (a way to see which channel has something waiting) either. To receive from several producers, wait on them in a fixed order.

```sober
// examples/task_chan_fan.sober
package main

// 3 本の生産者がそれぞれのチャネル（容量 2）で送り、親が順に受ける（fan-in を正準順で — select なし）。
// 切替点が多い形（spawnごとの子 / 親の順・走れるtaskの選び方）— schedvecが全スケジュールで同じ観測を確認する

import "std/task"

func main() {
    r, e := task.Run((s task.Scope) => {
        ta, ra := task.NewChannel[int](cap: 2)
        tb, rb := task.NewChannel[int](cap: 2)
        tc, rc := task.NewChannel[int](cap: 2)
        ha := task.Spawn(s, (o) => {
            mut i := 0
            while i < 4 {
                task.Send(o, i + 10)
                i += 1
            }
            1
        }, give: ta)
        hb := task.Spawn(s, (o) => {
            mut i := 0
            while i < 4 {
                task.Send(o, i * 100)
                i += 1
            }
            2
        }, give: tb)
        hc := task.Spawn(s, (o) => {
            mut i := 0
            while i < 4 {
                task.Send(o, i * i)
                i += 1
            }
            3
        }, give: tc)
        mut acc := 0
        mut k := 0
        while k < 4 {
            a := task.Recv(ra)
            b := task.Recv(rb)
            c := task.Recv(rc)
            if a != nil && b != nil && c != nil {
                acc = acc * 7 + a + b * 3 + c * 5
            }
            k += 1
        }
        acc * 10 + task.Join(ha) + task.Join(hb) + task.Join(hc)
    })
    println(r)
}
```

Output:

```
242966
```

Three producers each send on their own channel, and the parent receives from `ra`, `rb` and `rc` in that order. Whichever producer runs first, the parent receives in the order the code says.

A sent value is copied to the receiver's side. The receiver can read it even if the sender's region closes first. If every task stops waiting on another, the program panics with `Deadlock{}` (exit code 101). Whether a deadlock happens does not depend on the schedule either.

## 4. Failure and death

The caller chooses, in the code, how to receive a child's result.

- `task.Join(h)` — wait for the child's value and read it. If the child dies (a panic, a resource limit), the caller dies too
- `task.Try(h)` — see the child's outcome as a value: `task.Ok{v}` / `task.Failed{e}` / `task.Died{cause}`
- failures and deaths of children that were neither joined nor tried collect in the scope's err

Which one becomes the scope's err is decided by the order the children were spawned, not the order they finished. A death takes precedence over a failure, and between two of the same kind the earlier-spawned child wins. So what you observe on failure does not split by schedule either. The full rules are in [section 10.2 of the language specification](../spec/10-concurrency.ja.md#102-jointry失敗と死).

## 5. Domains — from many tasks into one state

A domain is a value that holds one state written by many tasks and runs the calls on that state one at a time (serially). A call can also wait until a condition holds and then enter the state (`task.Await`). No lock is visible. The body applied to the state never waits, so there is no way to wait while holding the domain, and deadlocks caused by lock ordering cannot be written.

A domain is used through four functions of `std/task`. There is no new syntax.

| Function | What it does |
| --- | --- |
| `task.NewDomain(s, init, wait: …)` | makes a domain in the scope `s` whose state starts as `init` |
| `task.Update(d, (st mut S) => body)` | writes the state in the body and returns the body's value |
| `task.Read(d, (st S) => body)` | reads the state without changing it and returns the body's value |
| `task.Await(d, (st mut S) => body, when: (st S) => condition)` | waits until the condition is true, then applies the body. A wait past the limit returns `io.Expired` |

For readers who know Go: the work you would write in Go with `sync.Mutex` and a condition variable (`sync.Cond`) is written in Sober with the three calls of a domain. A domain has no lock value, so a lock cannot be forgotten or left held. Waiting while holding the domain is rejected by the checker (section 5.5).

### 5.1 When to use a domain

| Shape | What to use |
| --- | --- |
| a child reads a value the parent built | capture and `freeze` (section 2) |
| one task streams values to one other task | a channel (section 3) |
| many tasks read and write one state (a connection pool, a counter, a key table, a rate count) | a domain |
| the state is large, or must survive the process | an outside store (a database and so on) |

A channel has one sender and one receiver, so many tasks merging into one state cannot be written with channels. A child task cannot capture a mut binding (section 2), so writing a shared variable directly is not possible either. A domain is the way to bring the tasks together.

A domain body is meant for a short update. A body can neither do io nor wait, so decide from the state inside the body and act outside it (for example, "take one from the count of idle connections" goes in the body; "open a connection" goes outside).

### 5.2 Update and Read — one at a time

```sober
// examples/domain_counter.sober
package main

// A domain serializes calls on one state: each child takes a sequence number and adds the bytes it wrote. Which child enters first
// is a recorded input (the order of the calls), but the printed values (the sum of the numbers and of the bytes) do not depend on it

import "std/task"

type Log struct {
    seq int
    bytes int
}

func main() {
    r, e := task.Run((s task.Scope) => {
        d := task.NewDomain(s, Log{seq: 0, bytes: 0})
        h1 := task.Spawn(s, () => task.Update(d, (st mut Log) => {
            st.seq += 1
            st.bytes += 10
            st.seq
        }))
        h2 := task.Spawn(s, () => task.Update(d, (st mut Log) => {
            st.seq += 1
            st.bytes += 32
            st.seq
        }))
        t := task.Join(h1) + task.Join(h2)
        t * 100 + task.Read(d, (st Log) => st.bytes)
    })
    if e != nil {
        println("died")
        return
    }
    println(r)
}
```

Output:

```
342
```

- `task.NewDomain(s, init)` makes a domain in the scope `s` whose state starts as `init`. The state type `S` is the type of `init`, and the domain's type is `task.Domain[S]`. The domain disappears, state and all, when the scope exits
- `task.Update(d, (st mut S) => body)` applies the body to the state and returns the body's value. What the body writes into `st` is seen by the next call
- `task.Read(d, (st S) => body)` reads without changing the state

Calls on the same domain run one at a time, whichever task they come from. Two bodies never write the state at the same time.

Which task's call runs first is decided by the schedule. The language treats that order as an input to the program, like values read from files or the network (section 6). Given the same order, the value of a scope does not depend on the schedule. In the example above, the printed values (the sum of the sequence numbers and the sum of the bytes written) are the same whichever child goes first. The three calls have the effect `nondet` (updates by other tasks are visible), and the effect shows in the function's signature.

A domain can be captured (by child tasks too) and passed as a function argument. It can also be passed in a struct field, so handlers stay named functions.

```sober
// examples/domain_arg.sober
package main

// A domain can be passed to a function (also inside a struct): the handlers are named functions that take the shared state.
// It cannot be returned from a function, put in a task result or sent on a channel — it stays inside the scope that made it

import "std/task"

type Stats struct {
    hits int
    bytes int
}

type App struct {
    stats task.Domain[Stats]
    name string
}

func record(stats task.Domain[Stats], n int) int {
    return task.Update(stats, (st mut Stats) => {
        st.hits += 1
        st.bytes += n
        st.hits
    })
}

func handle(app App, req int) int {
    _ = record(app.stats, req * 10)
    return req
}

func serve(app App, k func(a App)) {
    k(app)
}

func main() {
    out, e := task.Run((s task.Scope) => {
        app := App{stats: task.NewDomain(s, Stats{hits: 0, bytes: 0}), name: "demo"}
        _, e2 := task.Run((s2 task.Scope) => {
            mut i := 1
            while i <= 4 {
                r := i
                _ = task.Spawn(s2, () => handle(app, r))
                i += 1
            }
            0
        })
        _ = e2
        serve(app, (a) => {
            _ = handle(a, 5)
        })
        task.Read(app.stats, (st Stats) => "${app.name}: ${st.hits} hits, ${st.bytes} bytes")
    })
    println(if e == nil { out } else { "died" })
}
```

Output:

```
demo: 5 hits, 150 bytes
```

### 5.3 Await — waiting until a condition holds

`task.Await(d, body, when: condition)` waits until the condition on the state is true, then applies the body. Its value is `(R, error?)`; when the wait goes past the limit, the error is `io.Expired`.

```sober
// examples/domain_await.sober
package main

// task.Await takes one slot from a counter: it waits until when: is true, and waiting calls enter in arrival order. A wait longer
// than wait: returns io.Expired (here a slot is free, so it does not wait)

import "std/task"

type Slots struct {
    free int
}

func main() {
    r, e := task.Run((s task.Scope) => {
        d := task.NewDomain(s, Slots{free: 2}, wait: 5 * task.MS)
        h := task.Spawn(s, () => {
            v, err := task.Await(d, (st mut Slots) => {
                st.free -= 1
                st.free
            }, when: (st Slots) => st.free > 0)
            if err != nil {
                -1
            } else {
                v
            }
        })
        task.Join(h) + task.Read(d, (st Slots) => st.free)
    })
    if e != nil {
        println("died")
        return
    }
    println(r)
}
```

Output:

```
2
```

If the condition is already true, the call enters without waiting. If it is false, the call joins the domain's queue and sleeps; each time another call changes the state and leaves, waiting calls are woken from the head of the queue and check the condition again.

Here eight consumers each take one item at a time with `Await`, while one producer adds five at a time with `Update`. Whatever the schedule, every item is taken exactly once.

```sober
// examples/domain_handoff.sober
package main

// Waiting calls are handed the domain in arrival order: 8 consumers each take 25 items with task.Await (when: items are there),
// while one producer adds 5 items at a time with task.Update. Every item is taken exactly once, whatever the schedule

import "std/os"
import "std/task"

type Q struct {
    items int
    taken int
}

func main() {
    r, e := task.Run((s task.Scope) => {
        d := task.NewDomain(s, Q{items: 0, taken: 0}, wait: 5000 * task.MS)
        _, e2 := task.Run((s2 task.Scope) => {
            mut i := 0
            while i < 8 {
                h := task.Spawn(s2, () => {
                    mut k := 0
                    while k < 25 {
                        _, err := task.Await(d, (st mut Q) => {
                            st.items -= 1
                            st.taken += 1
                            0
                        }, when: (st Q) => st.items > 0)
                        _ = err
                        k += 1
                    }
                    0
                })
                _ = h
                i += 1
            }
            p := task.Spawn(s2, () => {
                mut k := 0
                while k < 40 {
                    task.Update(d, (st mut Q) => {
                        st.items += 5
                        0
                    })
                    os.Sleep(1)
                    k += 1
                }
                0
            })
            _ = p
            0
        })
        if e2 != nil {
            "died"
        } else {
            task.Read(d, (st Q) => "taken ${st.taken} / left ${st.items}")
        }
    })
    println(if e == nil { r } else { "died" })
}
```

Output:

```
taken 200 / left 0
```

What the language promises about waiting:

- **Order**: waiting calls enter the state in the order they came. A call that is woken but finds its condition still false goes back to its place in the queue (`examples/domain_requeue.sober`)
- **Limit**: every wait has a limit. Write it as `wait:` on `NewDomain` (2 seconds if omitted), and override it per call with `wait:`. A call past the limit returns `io.Expired` without running its body, and the state is unchanged
- **Observation**: `task.Ledger().domains` returns one row for all domains (the number waiting now `waiting`, the longest wait from arrival to entry `maxWait` (reset to 0 when read), the total of expiries `expired`, and the total of poisoned domains `poisoned`)

An `Await` whose condition never becomes true returns `io.Expired` at the limit. No task stays stuck waiting on a domain.

```sober
// examples/domain_expire.sober
package main

// An Await whose when: never becomes true returns io.Expired once it has waited wait: (the bound on the wait is declared,
// so a domain wait never hangs). The body does not run and the state is unchanged. task.Ledger().domains counts the expiry
// (one row for all domains — waiting / maxWait / expired / poisoned)

import "std/io"
import "std/task"

type Gate struct {
    open bool
    passed int
}

func main() {
    r, e := task.Run((s task.Scope) => {
        d := task.NewDomain(s, Gate{open: false, passed: 0}, wait: 20 * task.MS)
        v, err := task.Await(d, (st mut Gate) => {
            st.passed += 1
            st.passed
        }, when: (st Gate) => st.open)
        label := switch err {
        case nil: "entered ${v}"
        case io.Expired{}: "expired"
        }
        "${label} / passed ${task.Read(d, (st Gate) => st.passed)}"
    })
    println(if e == nil { r } else { "died" })
    dv := task.Ledger().domains
    println("ledger: waiting ${dv.waiting} / expired ${dv.expired} / poisoned ${dv.poisoned}")
}
```

Output:

```
expired / passed 0
ledger: waiting 0 / expired 1 / poisoned 0
```

### 5.4 When a body dies — poisoning

When a body (including `when:`) dies (a bounds check, division by zero, a region limit and so on), the calling task dies and the domain becomes poisoned. From then on, every call on that domain kills its caller with `task.Poisoned{}`. Waiting `Await` calls wake up and die the same way. No later call runs on a half-written state.

```sober
// examples/domain_poison.sober
package main

// A body that dies poisons its domain: the caller dies, and every later call on the domain dies with task.Poisoned{} instead of
// running on a half-written state. Here the first child's body divides by zero after writing a field; the second child's Read
// then dies too.
// task.Try shows both deaths as values

import "std/task"

type St struct {
    n int
    d int
}

func main() {
    _, e := task.Run((s task.Scope) => {
        d := task.NewDomain(s, St{n: 0, d: 0})
        h1 := task.Spawn(s, () => task.Update(d, (st mut St) => {
            st.n = 7
            st.n / st.d
        }))
        a := switch task.Try(h1) {
        case task.Ok{v}: "ok"
        case task.Failed{}: "failed"
        case task.Died{cause}: "died"
        }
        h2 := task.Spawn(s, () => task.Read(d, (st St) => st.n))
        b := switch task.Try(h2) {
        case task.Ok{v}: "ok"
        case task.Failed{}: "failed"
        case task.Died{cause}: "died"
        }
        println("update: ${a} / read: ${b}")
        0
    })
    println(if e == nil { "scope: ok" } else { "scope: err" })
    println("poisoned domains: ${task.Ledger().domains.poisoned}")
}
```

Output:

```
update: died / read: died
scope: err
poisoned domains: 1
```

### 5.5 Shapes a body cannot have, and why

A body runs while holding the domain. So the checker rejects shapes that would wait while holding it, or that would grow the state without bound. Each rejection message shows a rewrite.

A body does not wait, does no io, and calls no other domain (it has no effects — no explicit `panic` either).

```sober
// examples/domain_neg_nested.sober
package main

// domainの本体から別のdomainは呼べない（入りはnondet — 本体はエフェクトなし）: 持ったまま待つ形が書けないので、domainが原因のデッドロックは無い

import "std/task"

type Hits struct {
    n int
}

func main() {
    r, e := task.Run((s task.Scope) => {
        a := task.NewDomain(s, Hits{n: 0})
        b := task.NewDomain(s, Hits{n: 0})
        task.Update(a, (st mut Hits) => {
            st.n += task.Read(b, (o Hits) => o.n)
            st.n
        })
    })
    println(r)
}
```

Rejected:

```
examples/domain_neg_nested.sober:15:38: error: the body of a domain call (task.Update / task.Read / task.Await and its when:) may have the effect nondet via the call of 'std/task.Read': it runs holding the domain, so it has no effects (no waiting, no io, no other domain, no explicit panic) (Analyzer)
```

Because a body cannot call another domain, there is no shape where two domains are held while each waits on the other. No lock-ordering convention is needed. A `println` in a body is rejected for the same reason (`examples/domain_neg_effect.sober`).

The state lives as long as the domain and is written in place. So a body writes only region-free values into the state (int, bool, byte, float, and structs, unions and options of them). Appending to a slice of the state would grow the state on every call, so it is rejected.

```sober
// examples/domain_neg_grow.sober
package main

// A domain's state is written in place and lives as long as the domain, so the body writes only region-free values into it
// (diag.Par kind 36): appending to a slice of the state would grow the domain's region on every call. Preallocate the slice in
// init: and write its elements, or keep the growing data outside the domain

import "std/task"

type Log struct {
    lines []string
}

func main() {
    r, e := task.Run((s task.Scope) => {
        d := task.NewDomain(s, Log{lines: []string{}})
        task.Update(d, (st mut Log) => {
            st.lines = append(st.lines, "hello")
            len(st.lines)
        })
    })
    println(r)
}
```

Rejected:

```
sober: load error at examples/domain_neg_grow.sober:17:16: the body of a domain call writes only region-free values (int, bool, byte, float and structs of them) into the state, and not through a map index — the state lives as long as the domain and is written in place, so append, re-slicing, strings or map writes would grow it on every call. Rewrite: (1) preallocate a mut slice in init: and write its elements (st.items[i] = v), (2) keep a count or an index in the state and the growing data outside the domain, or (3) return the value from the body and store it outside
```

The state can hold mut slices and maps (nested ones too), and a body writes the elements of its slices in place (`examples/domain_slots.sober`). Writes into a map could grow the state, so they are rejected. Give the initial value enough length and write its elements, or keep the growing data outside the domain.

Other rejected shapes:

- a body captures and writes a mut binding of the caller (`examples/domain_neg_capture.sober`) — a body may run on another task than the caller, so it captures only imm values
- a slice of the state is bound to a mut binding and appended to (`mut v := st.items` — `examples/domain_neg_alias.sober`)
- the state is passed as a mut argument to a function that may grow it (`examples/domain_neg_mutarg.sober`). It can be passed when the callee's body shows that it writes by the same rule as the body (`examples/domain_mutarg.sober`)
- a domain leaves the scope that made it — as the scope's value, a task's result, a value sent on a channel, or a function's return value, or by being stored in a place made outside the scope (`examples/domain_neg_escape.sober`, `examples/domain_neg_return.sober`, `examples/domain_neg_outlive_*.sober`). The domain disappears, state and all, when the scope exits

The initial value is copied into the domain and a body's value is copied out to the caller. So the state's slices and maps are never written from outside the domain.

### 5.6 How the standard library uses it, and what it costs

The connection pool of `std/pg` (`pg.OpenPool` / `pg.With` — [PostgreSQL guide, section 6](postgres.md#6-connection-pooling--pgopenpool-and-pgwith)) is written on a domain. It keeps the number of idle connections and of open ones in the domain's state, and when none is free it waits in arrival order with `Await`.

The instructions a domain call takes (x86-64, instructions per call counted with callgrind on a minimal program without contention):

| Call | Instructions per call |
| --- | --- |
| `task.Update` (the body only adds 1 to a counter) | ≈ 60 |
| `task.Read` (reads one field) | ≈ 80 |
| `task.Await` (the condition is true; enters without waiting) | ≈ 120 |

One uncontended entry and exit costs tens to a little over a hundred instructions. However many calls are waiting, a call leaving the state wakes only the one at the head of the queue, so the work of leaving does not depend on the number waiting.

## 6. What is promised

With the io inputs fixed, the following depend neither on the schedule nor on the number of workers:

- the value of a scope (the success value, and the err on failure)
- standard output from `println` (the preorder of the spawn tree)
- whether a deadlock happens

The following are treated as "inputs". Given the same values you get the same result, but the values themselves can differ from run to run:

- files, the network and the clock (including the `deadline:` limit)
- `task.Shed{}`, returned when `task.SpawnIn` cannot take a task
- the order in which domain calls ran

Outside the promise:

- the order of output written directly with `io.WriteStdout`
- the partial standard output of a run that dies (with two or more workers)

The list by entry point is in section 11, "the range of the determinism promise", of the [decision record](../language.md), and the rules are in [section 10.5 of the language specification](../spec/10-concurrency.ja.md#105-決定性とキャンセル) (both in Japanese). Budgets, pools and deadlines (`budget:` / `task.NewPool` / `deadline:`) are in [section 10.6 of the language specification](../spec/10-concurrency.ja.md#106-予算プール期限).
