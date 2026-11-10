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
// 切替点が多い形（spawn ごとの子 / 親の順・走れる task の選び方）— schedvec が全スケジュールで同じ観測を確かめる

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

A channel has one sender and one receiver, so many tasks updating one state (a connection pool, a counter, and so on) cannot be written with channels. A domain is the way to bring them together.

A domain holds one state and applies updates to it one at a time (serially).

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

- `task.NewDomain(s, init)` makes a domain in the scope `s` whose state starts as `init`. The domain disappears, state and all, when the scope exits
- `task.Update(d, (st mut S) => body)` applies the body to the state and returns the body's value. `task.Read(d, (st S) => body)` reads without changing the state
- `task.Await(d, body, when: condition)` waits until the condition is true and then applies the body. Waiting calls go in the order they came, and when the wait goes past the limit (`wait:`) it returns `io.Expired`

No lock is visible. The body does not wait, and it cannot do io or call another domain. Since there is no way to wait while holding a lock, deadlocks caused by lock ordering cannot be written.

Which task's update runs first is decided by the schedule. That order is treated as a "recorded input", just like input from files or the network. With the order fixed, the value of a scope does not depend on the schedule. In the example above, the printed values (the sum of the tickets and the sum of the byte counts) are the same whichever child goes first.

The state can hold mutable containers (`mut []T` / `mut map` — nested ones too), and a body writes their elements in place (`examples/domain_slots.sober`). The initial value is copied into the domain and a body's value is copied out to the caller, so the state's containers are never written from outside the domain.

Two shapes cannot be written in a body, and the checker rejects each by name with a rewrite to use instead.

- The body cannot add region-holding values to the state (append and friends — writing through an alias of the state, `mut v := st.items`, counts too)
- The state can be passed as a mutable argument only when the callee's body shows that it writes it by the same rule as the body (`examples/domain_mutarg.sober` — otherwise return the value and assign it in the body)

Poisoning (a domain whose body died answers `Poisoned` from then on) and expiry have real examples in `examples/domain_poison.sober` and `examples/domain_handoff.sober`.

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
