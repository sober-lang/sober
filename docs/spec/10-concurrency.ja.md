# 10. 並行

日本語

[目次](README.ja.md)

並行は std/task の関数で書く（新しい構文は無い）。task の寿命はレキシカルなスコープに閉じ（structured concurrency）、子は scope の出口までに必ず終わる。データ競合は形で書けない — 子へ渡せるのは不変の値とチャネルの端点だけ。io の入力を固定すれば、結果と標準出力はスケジュールにもワーカー数にも依らない。

```sober
// examples/tour_07_parallel.sober
package main

import "std/iter"
import "std/task"

// Tour 7: parallelism — structured concurrency, channels (docs/guide/tour.md)

func fib(n int) int {
    return if n < 2 { n } else { fib(n - 1) + fib(n - 2) }
}

func main() int {
    // task.Map: one task per element — results come back in input order
    mut ns := mut []int{}
    for i <- iter.Range(20, 26) {
        ns = append(ns, i)
    }
    fs, err := task.Map(ns, (n) => fib(n))
    if err != nil {
        return 1
    }
    for f <- fs {
        println(f)
    }
    // task.Run: child tasks always join before the scope ends
    r, e := task.Run((s task.Scope) => {
        a := task.Spawn(s, () => fib(24))
        b := task.Spawn(s, () => fib(25))
        task.Join(a) + task.Join(b)
    })
    if e == nil {
        println(r)
    }
    // channels
    r2, e2 := task.Run((s task.Scope) => {
        tx, rx := task.NewChannel[int](cap: 4)
        h := task.Spawn(s, (out) => {
            for i <- iter.Range(1, 4) {
                task.Send(out, i * 10)
            }
            task.Close(out)
            0
        }, give: tx)
        // for-Recv: receive until the channel is closed
        mut got := 0
        for v <- task.Recv(rx) {
            got += v
        }
        task.Join(h) + got
    })
    if e2 == nil {
        println(r2)
    }
    return 0
}
```

出力:

```
6765
10946
17711
28657
46368
75025
121393
60
```

## 10.1 scope と task

C-1. `task.Run((s task.Scope) => 本体)` は scope を開いて本体の値を `(T, error?)` で返す。本体の中の `task.Spawn(s, g)` は子の task を生み、handle `task.Handle[T]` を返す。scope は出口で子を全部待つ（子は scope より長く生きない）。`task.Run` は普通の関数の本体の中でも開ける。
例: [`examples/tour_07_parallel.sober`](../../examples/tour_07_parallel.sober)・[`examples/task_capture.sober`](../../examples/task_capture.sober)・[`examples/task_def.sober`](../../examples/task_def.sober)
決定: [language.md 11 節](../language.md)

C-2. `task.Spawn`（と `task.SpawnIn`）の g は字面のラムダ。g が捕獲できるのは imm のデータだけ — mut の束縛（とその imm の別名）・札 `Scope`・handle・チャネルの端点（渡すのは C-11 の `give:`）・展開される関数型の仮引数は捕獲できない（struct の欄に包んでも同じ）。札と handle は関数の実引数にも scope の値にもできない。
例: [`examples/task_capture.sober`](../../examples/task_capture.sober)
拒否: [`examples/task_neg_lambda.sober`](../../examples/task_neg_lambda.sober)・[`examples/task_neg_mut.sober`](../../examples/task_neg_mut.sober)・[`examples/task_neg_mutalias.sober`](../../examples/task_neg_mutalias.sober)・[`examples/task_neg_token.sober`](../../examples/task_neg_token.sober)・[`examples/task_neg_handle.sober`](../../examples/task_neg_handle.sober)・[`examples/task_neg_fnparam.sober`](../../examples/task_neg_fnparam.sober)・[`examples/task_neg_wrap_token.sober`](../../examples/task_neg_wrap_token.sober)・[`examples/task_neg_wrap_handle.sober`](../../examples/task_neg_wrap_handle.sober)・[`examples/task_neg_cross.sober`](../../examples/task_neg_cross.sober)・[`examples/task_neg_scope_result.sober`](../../examples/task_neg_scope_result.sober)・[`examples/task_neg_spawnin.sober`](../../examples/task_neg_spawnin.sober)
決定: [language.md 11 節](../language.md)

C-3. task の結果は imm のデータなら何でもよい（string・slice・map・error・それらの struct）— 子の region から scope の region へ写る。関数値・札・handle・端点は結果にできない。scope の値も出口で外へ写る。
例: [`examples/task_result_string.sober`](../../examples/task_result_string.sober)・[`examples/task_scope_value.sober`](../../examples/task_scope_value.sober)
拒否: [`examples/task_neg_result.sober`](../../examples/task_neg_result.sober)
決定: [language.md 11 節](../language.md)

## 10.2 Join・Try・失敗と死

C-4. `task.Join(h)` は子の値を待って読む（終わっていれば即返す・何度読んでもよい）。error を返す task（g の結果が `(T, error?)`）の Join は 2 値で、束縛か `catch` で受ける — 値 1 つの束縛は拒否、error を返さない task の Join への catch も拒否。Join も Try もしなかった子の失敗は scope の err に集まる。意図して捨てるときは `_ = task.Join(h)`。
例: [`examples/task_handle_err.sober`](../../examples/task_handle_err.sober)・[`examples/task_join_catch.sober`](../../examples/task_join_catch.sober)
拒否: [`examples/task_join_multibind.sober`](../../examples/task_join_multibind.sober)・[`examples/task_join_catch_infallible.sober`](../../examples/task_join_catch_infallible.sober)
決定: [language.md 11 節](../language.md)

C-5. 子の死（panic・資源の上限）の受け方は呼び手が字面で選ぶ 3 通り: `task.Join(h)` = 子の死は自分の死（main なら終了コード 101 と `ChildDied`）・`task.Try(h)` = `task.Outcome[T]`（`Ok{v}` / `Failed{e}` / `Died{cause}`）の値として見て本体は続く・どちらもしなければ scope の err に `task.ChildDied{cause}`。Try は死を吸収しない — Try で見た死も scope の出口で ChildDied になる。死ぬ task の defer は走らない。
例: [`examples/task_die.sober`](../../examples/task_die.sober)・[`examples/task_try.sober`](../../examples/task_try.sober)・[`examples/task_die_label.sober`](../../examples/task_die_label.sober)
決定: [language.md 11 節](../language.md)

C-6. scope の err の優先は、死（ChildDied）> 生んだ順で最初の未回収の失敗 > 本体の結果。選ぶのは生んだ順（正準順）で、終わった順ではない。
例: [`examples/task_fail_order.sober`](../../examples/task_fail_order.sober)・[`examples/task_handle_err.sober`](../../examples/task_handle_err.sober)
決定: [language.md 11 節](../language.md)

C-7. scope の本体（とその中の展開されるラムダ）の `?` は、囲む関数でなく本体を抜ける — 子を全部待ってから scope は `(ゼロ値, err)` を返す。兄弟の子は切らない。本体のラベルは scope の err に行き、囲む関数の `@errors` には流れない。g の中の `?` と、本体から外への return / break / continue は拒否する（子の失敗は g の結果 `(T, error?)` で書く）。
例: [`examples/task_scope_try.sober`](../../examples/task_scope_try.sober)・[`examples/task_scope_try_errors.sober`](../../examples/task_scope_try_errors.sober)
拒否: [`examples/task_spawn_try.sober`](../../examples/task_spawn_try.sober)・[`examples/task_neg_escape.sober`](../../examples/task_neg_escape.sober)
決定: [language.md 11 節](../language.md)

## 10.3 handle の列と Map

C-8. handle は mut の slice に積む（`mut hs := mut []task.Handle[T]{}`）。`task.Gather(hs)` は生んだ順に全部を待って `[]T` を返す（死んだ子を待てば呼び手も死ぬ）。error を返す task の handle の要素の型は `task.Handle[(T, error?)]` で、Gather は `([]T, error?)`（err は生んだ順で最初の失敗）。多値の型 `(T, error?)` は Handle の型引数にだけ書ける。imm の slice に積む・error を返す task を `Handle[T]` の列に積むのは拒否。
例: [`examples/task_gather.sober`](../../examples/task_gather.sober)・[`examples/task_gather_err.sober`](../../examples/task_gather_err.sober)・[`examples/task_gather_die.sober`](../../examples/task_gather_die.sober)
拒否: [`examples/task_neg_handles.sober`](../../examples/task_neg_handles.sober)・[`examples/task_neg_handles_err.sober`](../../examples/task_neg_handles_err.sober)・[`examples/task_neg_tuple.sober`](../../examples/task_neg_tuple.sober)・[`examples/task_neg_tuple_shape.sober`](../../examples/task_neg_tuple_shape.sober)
決定: [language.md 11 節](../language.md)

C-9. `task.Map(xs, f)`（`xs |> task.Map(f)`）は要素ごとに 1 task を生み、添字の順の `([]U, error?)` を返す。f が `(U, error?)` を返せば、全部を待って err は添字が最小の失敗。子が死ねば err は ChildDied で結果は空。
例: [`examples/task_map.sober`](../../examples/task_map.sober)・[`examples/task_cancel_map.sober`](../../examples/task_cancel_map.sober)
決定: [language.md 11 節](../language.md)

C-10. handle を捨てた子（`_ = task.Spawn(…)`）の置き場は子の寿命で、子の終わりで返る — 終わらない scope（接続を受け続けるループ）で子を生み続けても scope の region は伸びない。
例: [`examples/task_spawn_discard.sober`](../../examples/task_spawn_discard.sober)・[`examples/task_spawn_discard_die.sober`](../../examples/task_spawn_discard_die.sober)
決定: [language.md 11 節](../language.md)

## 10.4 チャネル

C-11. `tx, rx := task.NewChannel[T](cap: n)` は送り端 `task.Sender[T]` と受け端 `task.Receiver[T]` を作る（容量 n は 1 以上の整数の字面）。端点は単一の task が持ち、子へは `task.Spawn(s, (out) => …, give: tx)` でちょうど 1 つ渡す（捕獲はできない）。渡した後に親が使うと panic（終了コード 101）。1 本のチャネルの送り手・受け手は高々 1 task ずつなので、到着の順は存在しない。
例: [`examples/task_chan.sober`](../../examples/task_chan.sober)・[`examples/task_chan_def.sober`](../../examples/task_chan_def.sober)・[`examples/task_stale.sober`](../../examples/task_stale.sober)
拒否: [`examples/task_neg_cap.sober`](../../examples/task_neg_cap.sober)・[`examples/task_neg_endpoint.sober`](../../examples/task_neg_endpoint.sober)・[`examples/task_neg_wrap_endpoint.sober`](../../examples/task_neg_wrap_endpoint.sober)
決定: [language.md 11 節・18 節](../language.md)

C-12. `task.Send(tx, v)` は満杯なら待つ。`task.Recv(rx)` は `T?` — 空なら待ち、閉じて空なら nil。`task.Close(tx)` は送り端だけが閉じられ、閉じた後の Send と 2 度目の Close は panic。`for v <- task.Recv(rx) { … }` は閉じて空になるまで受ける。
例: [`examples/task_chan_close.sober`](../../examples/task_chan_close.sober)・[`examples/task_close_send.sober`](../../examples/task_close_send.sober)・[`examples/task_close_twice.sober`](../../examples/task_close_twice.sober)
決定: [language.md 11 節](../language.md)

C-13. 送る値は imm のデータ。region を持つ値（string・slice・map・それらの struct）は送りで写り、送り手の region が先に閉じても受け手が読める。端点と handle は送れない。
例: [`examples/task_chan_string.sober`](../../examples/task_chan_string.sober)・[`examples/task_chan_down.sober`](../../examples/task_chan_down.sober)
拒否: [`examples/task_neg_chan_endpoint.sober`](../../examples/task_neg_chan_endpoint.sober)・[`examples/task_neg_chan_handle.sober`](../../examples/task_neg_chan_handle.sober)
決定: [language.md 11 節・18 節](../language.md)

C-14. select（届いているかの観測）は無い。複数の生産者の受けは、決まった順に待って書く。全部の task が待ち合ったら panic `Deadlock{}`（終了コード 101 — 起きるかはスケジュールに依らない）。
例: [`examples/task_chan_fan.sober`](../../examples/task_chan_fan.sober)・[`examples/task_deadlock.sober`](../../examples/task_deadlock.sober)
決定: [language.md 11 節](../language.md)

## 10.5 決定性とキャンセル

C-15. io の入力を固定すれば、scope の値は実行のスケジュールとワーカー数に依らない。println の標準出力は spawn の木の先行順 — 子の出力全体が親の spawn の位置に入る（ワーカー 1 で子を先に走らせたときと同じ）。`io.WriteStdout` の直書きはこの順の対象外。死ぬ実行の標準出力の途中までの出力は、ワーカー 2 以上では約束しない。
例: [`examples/task_print_order.sober`](../../examples/task_print_order.sober)・[`examples/task_print_nested.sober`](../../examples/task_print_nested.sober)・[`examples/task_print_chan.sober`](../../examples/task_print_chan.sober)・[`examples/task_print_direct.sober`](../../examples/task_print_direct.sober)
決定: [language.md 11 節](../language.md)

C-16. 子が死ぬと、scope は後ろの純な子（io もチャネルも持たない）を検査点（ループの戻り・再帰の入口）で切ることがある。切っても scope の値と出力は変わらない。
例: [`examples/task_cancel.sober`](../../examples/task_cancel.sober)・[`examples/task_cancel_spin.sober`](../../examples/task_cancel_spin.sober)
決定: [language.md 11 節](../language.md)

## 10.6 予算・プール・期限

C-17. `budget:`（Spawn・Map・Run の末尾の名前つき引数 — `budget: 64 * task.MB`）は、その task を逐次に走らせたときの使用量の上界の宣言。値は呼び出しと割り算を含まない整数式。並列度は「天井 ÷ 上界」で rt が決め、入れない子は親の上でその場に逐次に走る（値・死因・出力は変わらない）。`task.Run(…, wait: true)` の直接の子は、入れなければ逐次にせず入れるまで待つ。
例: [`examples/task_budget.sober`](../../examples/task_budget.sober)
拒否: [`examples/task_neg_budget.sober`](../../examples/task_neg_budget.sober)
決定: [language.md 11 節](../language.md)

C-18. `task.NewPool(budget:, parent:)` は名前つきの天井の節。`task.SpawnIn(s, pool, g)` だけは逐次にせず、入れなければ `(nil, task.Shed{})` を返す（受けられない、という値）。`task.Ledger()` は天井・計上・逐次化・shed・失敗・死の数の読み口で、`task.MarkFailed(pool)` は境界の失敗を数える。
例: [`examples/task_shed.sober`](../../examples/task_shed.sober)・[`examples/task_pool_seq.sober`](../../examples/task_pool_seq.sober)
決定: [language.md 11 節](../language.md)

C-19. `task.Run(body, deadline: 500 * task.MS)` は scope の期限（相対・単調時計）。子孫の task も期限を継ぎ、入れ子は早い方。期限は待ちの上限であって実行時間の上限ではない — 期限の後に開いた io の口が `io.Expired` を返し（net の待ちは期限で切れる — 11 章）、`os.Sleep` は早く返る。走っている計算は止めない。値は budget: と同じ形の整数式。
例: [`examples/task_deadline.sober`](../../examples/task_deadline.sober)・[`examples/task_sleep_deadline.sober`](../../examples/task_sleep_deadline.sober)・[`examples/net_deadline.sober`](../../examples/net_deadline.sober)
拒否: [`examples/task_neg_deadline.sober`](../../examples/task_neg_deadline.sober)
決定: [language.md 11 節・28 節](../language.md)

## 10.7 ワーカー局所の lease

C-20. `lp := task.NewLocal((w mut T) => 整え)` はワーカーごとの作業域の置き場を作り、`task.Lease(lp, (w mut T) => 本体)` の窓の中だけで借りる。窓のたびに新しい値 — 前の窓（同じ task でも別の task でも）の書きは見えない（置き場の使い回しは観測に出ない最適化）。T はスカラーと `pool.Scratch` の欄だけの struct。ラムダの mut 仮引数はこの 2 つの窓の位置にだけ書ける。`task.Local` のゼロ値は作れない。
例: [`examples/lease.sober`](../../examples/lease.sober)・[`examples/lease_iter.sober`](../../examples/lease_iter.sober)・[`examples/lease_bytes.sober`](../../examples/lease_bytes.sober)・[`examples/lease_yield.sober`](../../examples/lease_yield.sober)
拒否: [`examples/lease_neg_form.sober`](../../examples/lease_neg_form.sober)・[`examples/lease_neg_mutlam.sober`](../../examples/lease_neg_mutlam.sober)・[`examples/lease_neg_shape.sober`](../../examples/lease_neg_shape.sober)・[`examples/lease_neg_prep.sober`](../../examples/lease_neg_prep.sober)・[`examples/lease_neg_zero.sober`](../../examples/lease_neg_zero.sober)・[`examples/lease_neg_reserved.sober`](../../examples/lease_neg_reserved.sober)
決定: [language.md 11 節・26 節](../language.md)
