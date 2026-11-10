# 並行 — task・チャネル・domain

[English](concurrency.md) | 日本語

Sober の並行は `std/task` の関数で書きます。新しい構文はありません。このページは並行のプログラムをどう書くか、そして言語が何を約束するかを短くまとめた案内です。規則の正確な定義は [言語仕様 10 章](../spec/10-concurrency.ja.md) にあります。

| やりたいこと | Sober の形 | 節 |
| --- | --- | --- |
| 仕事を分けて並列に走らせる | `task.Run` の scope + `task.Spawn` / `task.Map` | 1 |
| 子に値を渡す | 捕獲（不変の値だけ）・`freeze` | 2 |
| task の間で値を流す | チャネル（送り手 1・受け手 1） | 3 |
| 子の失敗と死を受ける | `task.Join` / `task.Try` / scope の err | 4 |
| 多くの task から 1 つの状態を更新する | domain | 5 |

前提: [言語ツアー](tour.ja.md) の 6 節（mut と freeze）と 7 節（並列）。

## 1. task と scope — 並列でも逐次と同じ結果

`task.Run((s task.Scope) => 本体)` が scope を開き、本体の中の `task.Spawn(s, g)` が子の task を生みます。子は scope の出口までに必ず終わります。scope より長く生きる task はありません。

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

親の `parent` は 2 つの子の出力の後に出ます。`println` の出力の順は spawn の木の先行順で、子の出力全体が親の spawn の位置に入ります。ワーカー 1 本で子を先に走らせたときと同じ順です。ワーカーの数（`SOBER_WORKERS`）を変えても、標準出力は同じバイトになります。

結果の値も同じです。io の入力を固定すれば、scope の値は実行のスケジュールにもワーカーの数にも依りません。並列に走らせた結果は逐次に走らせた結果と一致します。

要素ごとに task を生むなら `task.Map(xs, f)` です。結果は添字の順に並びます（[言語ツアー 7 節](tour.ja.md#7-並列--structured-concurrencyチャネル)）。

## 2. 値を渡す — 共有して書くのでなく、不変の値を渡す

子の本体（`task.Spawn` に渡すラムダ）が捕まえられるのは不変の値だけです。mut の束縛を捕まえる形は検査が拒否します。

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

だから、2 つの task が同じ値を同時に書く形（データ競合）は書けません。lock も要りません。

mut で組み立てた値を子に読ませるなら、`freeze` で不変にしてから渡します。

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

子の結果も不変のデータです。string・slice・map・それらの struct を返せて、値は子から scope へ写ります。

## 3. チャネル — 送り手 1・受け手 1

`task.NewChannel[T](cap: n)` は送り端と受け端の組を作ります。端はどちらも 1 つの task だけが持ちます。子へは `give:` でちょうど 1 つ渡します（捕獲では渡せません）。

1 本のチャネルの送り手は 1 つなので、「どの送り手の値が先に着いたか」という順はそもそもありません。`select`（どのチャネルに届いているかを見る構文）もありません。複数の生産者から受けるときは、決まった順に待って受けます。

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

出力:

```
242966
```

3 本の生産者がそれぞれのチャネルで送り、親は `ra`・`rb`・`rc` の順に受けます。どの生産者が先に走っても、親が受ける順はこのコードの順です。

送った値は受け手の側へ写ります。送り手の region が先に閉じても、受け手は読めます。全部の task が互いを待って止まったら、`Deadlock{}` で panic します（終了コード 101）。デッドロックが起きるかどうかも、スケジュールに依りません。

## 4. 失敗と死

子の結果を受ける形は、呼び手が字面で選びます。

- `task.Join(h)` — 子の値を待って読む。子が死ねば（panic・資源の上限）、呼び手も死ぬ
- `task.Try(h)` — 子の結末を `task.Ok{v}` / `task.Failed{e}` / `task.Died{cause}` の値として見る
- どちらもしなかった子の失敗と死は、scope の err に集まる

scope の err がどれになるかは、子の終わった順ではなく生んだ順で決まります。死は失敗より優先され、同じ種類なら先に生んだ子のものです。だから失敗したときの観測もスケジュールによって変わりません。規則の全文は [言語仕様 10.2 節](../spec/10-concurrency.ja.md#102-jointry失敗と死) にあります。

## 5. domain — 多くの task から 1 つの状態へ

チャネルは送り手 1・受け手 1 なので、多くの task が 1 つの状態（接続のプール・カウンタなど）を更新する形は書けません。この合流に使うのが domain です。

domain は状態を 1 つ持ち、その状態への更新を 1 つずつ（直列に）当てます。

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

- `task.NewDomain(s, init)` が、scope `s` の中に状態の初期値 `init` を持つ domain を作ります。domain は scope の出口で状態ごと消えます
- `task.Update(d, (st mut S) => 本体)` は本体を状態に当て、本体の値を返します。`task.Read(d, (st S) => 本体)` は状態を変えずに読みます
- `task.Await(d, 本体, when: 条件)` は条件が真になるまで待ってから本体を当てます。待つ呼び出しは来た順に入り、待ちが上限（`wait:`）を越えたら `io.Expired` を返します

lock は見えません。本体は待たず、io も別の domain の呼び出しも書けません。lock を持ったまま待つ形が無いので、lock の順序で起きるデッドロックは書けません。

どの task の更新が先に走るかはスケジュールで決まります。その順はファイルやネットワークの入力と同じ「録られる入力」として扱います。順を固定すれば、scope の値はスケジュールに依りません。上の例で印字する値（札の和と量の和）は、どちらの子が先に入っても同じです。

状態は mut の slice や map（`mut []T` / `mut map` — 入れ子も）を持て、本体はその要素をその場で書けます（`examples/domain_slots.sober`）。初期値は domain へ写して入れ、本体の値も呼び手へ写して返すので、状態の slice や map が domain の外から書かれることはありません。

本体には書けない形が 2 つあり、どちらも検査が名指しで拒み、書き換えの形を提示します。

- 本体は region を持つ値を状態に足せません（append 等。状態の別名〔`mut v := st.items`〕を経た書きも同じ）
- 状態を mut の実引数に渡せるのは、呼び先がそれを本体と同じ規則で書くと呼び先の本体から分かるときだけです（`examples/domain_mutarg.sober` — 分からなければ、値を返して本体で代入します）

毒（本体が死んだ domain は以後 `Poisoned`）と満了の実例は `examples/domain_poison.sober`・`examples/domain_handoff.sober` にあります。

## 6. 言語が約束する範囲

io の入力を固定したとき、次はスケジュールにもワーカーの数にも依りません。

- scope の値（成功の値と、失敗のときの err）
- `println` の標準出力（spawn の木の先行順）
- デッドロックが起きるかどうか

次は「入力」として扱います。同じ値を与えれば同じ結果になりますが、値そのものは実行ごとに変わりえます。

- ファイル・ネットワーク・時計（期限 `deadline:` を含む）
- `task.SpawnIn` が受けられずに返す `task.Shed{}`
- domain の呼び出しが走った順

言語が約束しないもの:

- `io.WriteStdout` で直に書いた出力の順
- 死ぬ実行の標準出力の途中まで（ワーカー 2 本以上のとき）

入口ごとの一覧は [決定の記録](../language.md) の 11 節「決定性の約束の範囲」に、規則は [言語仕様 10.5 節](../spec/10-concurrency.ja.md#105-決定性とキャンセル) にあります。予算・プール・期限（`budget:` / `task.NewPool` / `deadline:`）は [言語仕様 10.6 節](../spec/10-concurrency.ja.md#106-予算プール期限) にあります。
