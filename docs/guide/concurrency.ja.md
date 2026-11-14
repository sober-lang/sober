# 並行 — task・チャネル・domain

[English](concurrency.md) | 日本語

Soberの並行は `std/task` の関数で書きます。新しい構文はありません。このページは並行のプログラムをどう書くか、そして言語が何を約束するかを短くまとめた案内です。規則の正確な定義は [言語仕様10章](../spec/10-concurrency.ja.md) にあります。

| やりたいこと | Soberの形 | 節 |
| --- | --- | --- |
| 仕事を分けて並列に走らせる | `task.Run` のscope + `task.Spawn` / `task.Map` | 1 |
| 子に値を渡す | 捕獲（不変の値だけ）・`freeze` | 2 |
| taskの間で値を流す | チャネル（送り手1・受け手1） | 3 |
| 子の失敗と死を受ける | `task.Join` / `task.Try` / scopeのerr | 4 |
| 多くのtaskから1つの状態を更新する | domain | 5 |

前提: [言語ツアー](tour.ja.md) の6節（mutとfreeze）と7節（並列）。

## 1. taskとscope — 並列でも逐次と同じ結果

`task.Run((s task.Scope) => 本体)` がscopeを開き、本体の中の `task.Spawn(s, g)` が子のtaskを生みます。子はscopeの出口までに必ず終わります。scopeより長く生きるtaskはありません。

子と親の両方が標準出力に書く例です。

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

出力:

```
start
a 0
a 1
b 0
b 1
parent
2
```

親の `parent` は2つの子の出力の後に出ます。`println` の出力の順はspawnの木の先行順で、子の出力全体が親のspawnの位置に入ります。ワーカー1本で子を先に走らせたときと同じ順です。ワーカーの数（`SOBER_WORKERS`）を変えても、標準出力は同じバイトになります。

結果の値も同じです。ioの入力を固定すれば、scopeの値は実行のスケジュールにもワーカーの数にも依りません。並列に走らせた結果は逐次に走らせた結果と一致します。

要素ごとにtaskを生むなら `task.Map(xs, f)` です。結果は添字の順に並びます（[言語ツアー7節](tour.ja.md#7-並列--structured-concurrencyチャネル)）。

## 2. 値を渡す — 共有して書くのでなく、不変の値を渡す

子の本体（`task.Spawn` に渡すラムダ）が捕まえられるのは不変の値だけです。mutの束縛を捕まえる形は検査が拒否します。

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

拒否:

```
sober: load error at examples/task_neg_mut.sober:9:70: a spawned task cannot capture a mut binding (the child sees only imm values — pass a copy: v := x before the Spawn)
```

だから、2つのtaskが同じ値を同時に書く形（データ競合）は書けません。lockも要りません。

mutで組み立てた値を子に読ませるなら、`freeze` で不変にしてから渡します。

```sober
// examples/task_frozen_map.sober（抜粋）
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

`freeze(m0)` の後は `m0` に書けません。子は不変の `m` を読むだけです。

子の結果も不変のデータです。string・slice・map・それらのstructを返せて、値は子からscopeへコピーされます。

## 3. チャネル — 送り手1・受け手1

`task.NewChannel[T](cap: n)` は送り端と受け端の組を作ります。端はどちらも1つのtaskだけが持ちます。子へは `give:` でちょうど1つ渡します（捕獲では渡せません）。

1本のチャネルの送り手は1つなので、「どの送り手の値が先に着いたか」という順はそもそもありません。`select`（どのチャネルに届いているかを見る構文）もありません。複数の生産者から受けるときは、決まった順に待って受けます。

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

出力:

```
242966
```

3本の生産者がそれぞれのチャネルで送り、親は `ra`・`rb`・`rc` の順に受けます。どの生産者が先に走っても、親が受ける順はこのコードの順です。

送った値は受け手の側へコピーされます。送り手のregionが先に閉じても、受け手は読めます。全部のtaskが互いを待って止まったら、`Deadlock{}` でpanicします（終了コード101）。デッドロックが起きるかどうかも、スケジュールに依りません。

## 4. 失敗と死

子の結果を受ける形は、呼び手が字面で選びます。

- `task.Join(h)` — 子の値を待って読む。子が死ねば（panic・資源の上限）、呼び手も死ぬ
- `task.Try(h)` — 子の結末を `task.Ok{v}` / `task.Failed{e}` / `task.Died{cause}` の値として見る
- どちらもしなかった子の失敗と死は、scopeのerrに集まる

scopeのerrがどれになるかは、子の終わった順ではなく生んだ順で決まります。死は失敗より優先され、同じ種類なら先に生んだ子のものです。だから失敗したときの観測もスケジュールによって変わりません。規則の全文は [言語仕様10.2節](../spec/10-concurrency.ja.md#102-jointry失敗と死) にあります。

## 5. domain — 多くのtaskから1つの状態へ

domainは、多くのtaskから書き換えられる状態を1つ持ち、その状態への呼び出しを1つずつ（直列に）走らせる値です。呼び出しには、条件が成り立つまで待ってから状態に入る形（`task.Await`）もあります。lockは見えません。状態に適用する本体は待たないので、domainを持ったまま待つ形が無く、lockの順序で起きるデッドロックは書けません。

domainは `std/task` の関数4つで使います。新しい構文はありません。

| 関数 | すること |
| --- | --- |
| `task.NewDomain(s, init, wait: …)` | scope `s` の中に、初期値 `init` の状態を持つdomainを作る |
| `task.Update(d, (st mut S) => 本体)` | 本体で状態を書き、本体の値を返す |
| `task.Read(d, (st S) => 本体)` | 状態を変えずに読み、本体の値を返す |
| `task.Await(d, (st mut S) => 本体, when: (st S) => 条件)` | 条件が真になるまで待ってから本体を適用する。待ちが上限を越えたら `io.Expired` |

Goを知っている読み手へ: Goなら `sync.Mutex` と条件変数（`sync.Cond`）で書く仕事を、Soberではdomainの3つの呼び出しで書きます。domainにはlockの値が無いので、取り忘れも返し忘れも起こりません。lockを持ったまま待つ形は、検査が拒否します（5.5節）。

### 5.1 いつdomainを使うか

| 形 | 使うもの |
| --- | --- |
| 親が組み立てた値を子に読ませる | 捕獲・`freeze`（2節） |
| 1つのtaskから別の1つのtaskへ値を流す | チャネル（3節） |
| 多くのtaskが1つの状態を読み書きする（接続のプール・カウンタ・キーの表・流量の数え） | domain |
| 状態が大きい・プロセスが落ちても残したい | 外の保存先（データベースなど） |

チャネルは送り手1・受け手1なので、多くのtaskから1つの状態へ集まる形はチャネルでは書けません。子のtaskはmutの束縛を捕まえられないので（2節）、共有の変数を直に書く形もありません。この合流に使うのがdomainです。

domainの本体は短い更新のためのものです。本体の中ではioも待ちもできないので、状態を見て決めたことを、本体の外で実行します（たとえば「空いている接続の数を1減らす」は本体の中・「接続を張る」は本体の外）。

### 5.2 UpdateとRead — 1つずつ適用する

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

出力:

```
342
```

- `task.NewDomain(s, init)` が、scope `s` の中に状態の初期値 `init` を持つdomainを作ります。状態の型 `S` は `init` の型で、domainの型は `task.Domain[S]` です。domainはscopeの出口で状態ごと消えます
- `task.Update(d, (st mut S) => 本体)` は本体を状態に適用し、本体の値を返します。本体が `st` に書いた値は、次の呼び出しから見えます
- `task.Read(d, (st S) => 本体)` は状態を変えずに読みます

同じdomainの呼び出しは、どのtaskから来ても1つずつ走ります。2つの本体が同時に状態を書くことはありません。

どのtaskの呼び出しが先に走るかはスケジュールで決まります。言語はその順を、ファイルやネットワークから読む値と同じく、プログラムへの入力として扱います（6節）。同じ順を与えれば、scopeの値はスケジュールに依りません。上の例で印字する値（通し番号の和と、書いたバイト数の和）は、どちらの子が先に入っても同じです。3つの呼び出しはエフェクト `nondet`（他のtaskの更新が見える）を持ち、このエフェクトは関数の署名に出ます。

domainは捕獲でき（子のtaskへも）、関数の実引数にもできます。structのフィールドに入れて渡せるので、ハンドラを名前つきの関数のまま書けます。

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

出力:

```
demo: 5 hits, 150 bytes
```

### 5.3 Await — 条件が成り立つまで待つ

`task.Await(d, 本体, when: 条件)` は、状態について条件が真になるまで待ってから本体を適用します。値は `(R, error?)` で、待ちが上限を越えたときのerrは `io.Expired` です。

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

出力:

```
2
```

条件が初めから真なら、待たずに入ります。偽なら呼び出しはdomainの待ちの列に並んでスリープし、他の呼び出しが状態を変えて出るたびに、列の先頭からウェイクアップされて条件を見直します。

8つの消費者が `Await` で1つずつ取り、1つの生産者が `Update` で5つずつ足す例です。どのスケジュールでも、どの品物もちょうど1回取られます。

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

出力:

```
taken 200 / left 0
```

待ちについて言語が約束すること:

- **順番**: 待っている呼び出しどうしは、来た順に状態へ入ります。ウェイクアップされても条件がまだ偽なら、列の元の位置へ戻ります（`examples/domain_requeue.sober`）
- **期限**: 待ちには上限があります。`NewDomain` の `wait:` に書き（省略すると2秒）、呼び出しごとに `wait:` で上書きできます。越えた呼び出しは本体を走らせずに `io.Expired` を返し、状態は変わりません
- **観測**: `task.Ledger().domains` が、全domainをまとめた1行（今待っている数 `waiting`・到着から入るまでの待ちの最大 `maxWait`（読むと0に戻る）・満了の累計 `expired`・毒になったdomainの累計 `poisoned`）を返します

条件が真にならない `Await` は、上限で `io.Expired` を返します。domainの待ちで止まったままになるtaskはありません。

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

出力:

```
expired / passed 0
ledger: waiting 0 / expired 1 / poisoned 0
```

### 5.4 本体が死んだとき — 毒

本体（`when:` を含む）が死ぬと（境界検査・ゼロ除算・regionの上限など）、呼び手のtaskが死に、domainは毒された状態になります。以後のそのdomainの呼び出しは、呼び手を `task.Poisoned{}` で死なせます。待っている `Await` も起きて、同じく死にます。半端に書かれた状態の上で、続きの呼び出しが走ることはありません。

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

出力:

```
update: died / read: died
scope: err
poisoned domains: 1
```

### 5.5 本体に書けない形と、その理由

本体はdomainを持ったまま走ります。だから、持ったまま待つ形や、状態を際限なく伸ばす形は検査が拒否します。拒否の文面は、どれも書き換えの形を示します。

本体は待たず、ioをせず、別のdomainも呼びません（エフェクトを持たない — 明示の `panic` もなし）。

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

拒否:

```
examples/domain_neg_nested.sober:15:38: error: the body of a domain call (task.Update / task.Read / task.Await and its when:) may have the effect nondet via the call of 'std/task.Read': it runs holding the domain, so it has no effects (no waiting, no io, no other domain, no explicit panic) (Analyzer)
```

本体の中から別のdomainを呼べないので、domainを2つ持ったまま互いを待つ形はありません。lockの順序の取り決めは要りません。本体の中の `println` も同じ理由で拒否されます（`examples/domain_neg_effect.sober`）。

状態はdomainと同じだけ生き、その場で書かれます。だから本体が状態に書けるのはregionを持たない値（int・bool・byte・floatと、それらのstruct・union・option）だけです。状態のsliceへのappendは、呼び出しのたびに状態を伸ばすので拒否されます。

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

拒否:

```
sober: load error at examples/domain_neg_grow.sober:17:16: the body of a domain call writes only region-free values (int, bool, byte, float and structs of them) into the state, and not through a map index — the state lives as long as the domain and is written in place, so append, re-slicing, strings or map writes would grow it on every call. Rewrite: (1) preallocate a mut slice in init: and write its elements (st.items[i] = v), (2) keep a count or an index in the state and the growing data outside the domain, or (3) return the value from the body and store it outside
```

状態はmutのsliceやmapを持てて（入れ子も）、本体はsliceの要素をその場で書けます（`examples/domain_slots.sober`）。mapへの書きは状態を伸ばしうるので拒否されます。足りる長さを初期値で用意して要素を書くか、伸びるデータはdomainの外に置きます。

ほかに拒否される形:

- 本体が呼び手のmutの束縛を捕まえて書く（`examples/domain_neg_capture.sober`）— 本体は呼び手と別のtaskで走りうるので、捕まえられるのはimmの値だけです
- 状態のsliceをmutの束縛にしてappendする（`mut v := st.items` — `examples/domain_neg_alias.sober`）
- 状態を、状態を伸ばしうる関数へmutの実引数で渡す（`examples/domain_neg_mutarg.sober`）。呼び先が本体と同じ規則で書くと呼び先の本体から分かるなら渡せます（`examples/domain_mutarg.sober`）
- domainを作ったscopeの外へ出す — scopeの値・taskの結果・チャネルで送る値・関数の戻り値にする、scopeの外で作った場所へ入れる（`examples/domain_neg_escape.sober`・`examples/domain_neg_return.sober`・`examples/domain_neg_outlive_*.sober`）。domainはscopeの出口で状態ごと消えるからです

初期値はdomainへコピーして入れ、本体の値も呼び手へコピーして返します。だから、状態のsliceやmapがdomainの外から書かれることはありません。

### 5.6 標準ライブラリでの使われ方と費用

`std/pg` の接続のプール（`pg.OpenPool` / `pg.With` — [PostgreSQLのガイド6節](postgres.ja.md#6-接続のプール--pgopenpool-と-pgwith)）はdomainの上に書かれています。待機中の接続の数と張っている数をdomainの状態に置き、空きが無ければ `Await` で来た順に待ちます。

domainの呼び出しにかかる命令数（x86-64・callgrindで数えた、競合のない最小のプログラムの1回あたりの命令数）:

| 呼び出し | 命令/回 |
| --- | --- |
| `task.Update`（本体はカウンタを1足すだけ） | ≈ 60 |
| `task.Read`（フィールドを1つ読むだけ） | ≈ 80 |
| `task.Await`（条件が真で、待たずに入る） | ≈ 120 |

競合のない1回の出入りは、数十〜百数十命令です。待っている呼び出しが多くても、状態から出る呼び出しがウェイクアップするのは列の先頭の1つだけで、出る側の仕事は待っている数に依りません。

## 6. 言語が約束する範囲

ioの入力を固定したとき、次はスケジュールにもワーカーの数にも依りません。

- scopeの値（成功の値と、失敗のときのerr）
- `println` の標準出力（spawnの木の先行順）
- デッドロックが起きるかどうか

次は「入力」として扱います。同じ値を与えれば同じ結果になりますが、値そのものは実行ごとに変わりえます。

- ファイル・ネットワーク・時計（期限 `deadline:` を含む）
- `task.SpawnIn` が受けられずに返す `task.Shed{}`
- domainの呼び出しが走った順

言語が約束しないもの:

- `io.WriteStdout` で直に書いた出力の順
- 死ぬ実行の標準出力の途中まで（ワーカー2本以上のとき）

入口ごとの一覧は [決定の記録](../language.md) の11節「決定性の約束の範囲」に、規則は [言語仕様10.5節](../spec/10-concurrency.ja.md#105-決定性とキャンセル) にあります。予算・プール・期限（`budget:` / `task.NewPool` / `deadline:`）は [言語仕様10.6節](../spec/10-concurrency.ja.md#106-予算プール期限) にあります。
