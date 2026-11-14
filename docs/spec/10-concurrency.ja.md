# 10. 並行

日本語

[目次](README.ja.md)

並行はstd/taskの関数で書く（新しい構文は無い）。taskの寿命はレキシカルなスコープに閉じ（structured concurrency）、子はscopeの出口までに必ず終わる。データ競合は形で書けない — 子へ渡せるのは不変の値とチャネルの端点だけ。ioの入力を固定すれば、結果と標準出力はスケジュールにもワーカー数にも依らない。

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

## 10.1 scopeとtask

C-1. `task.Run((s task.Scope) => 本体)` はscopeを開いて本体の値を `(T, error?)` で返す。本体の中の `task.Spawn(s, g)` は子のtaskを生み、handle `task.Handle[T]` を返す。scopeは出口で子を全部待つ（子はscopeより長く生きない）。`task.Run` は普通の関数の本体の中でも開ける。
例: [`examples/tour_07_parallel.sober`](../../examples/tour_07_parallel.sober)・[`examples/task_capture.sober`](../../examples/task_capture.sober)・[`examples/task_def.sober`](../../examples/task_def.sober)
決定: [language.md 11節](../language.md)

C-2. `task.Spawn`（と `task.SpawnIn`）のgは字面のラムダ。gが捕獲できるのはimmのデータだけ — mutの束縛（とそのimmの別名）・札 `Scope`・handle・チャネルの端点（渡すのはC-11の `give:`）・展開される関数型の仮引数は捕獲できない（structのフィールドに包んでも同じ）。札とhandleは関数の実引数にもscopeの値にもできない。
例: [`examples/task_capture.sober`](../../examples/task_capture.sober)
拒否: [`examples/task_neg_lambda.sober`](../../examples/task_neg_lambda.sober)・[`examples/task_neg_mut.sober`](../../examples/task_neg_mut.sober)・[`examples/task_neg_mutalias.sober`](../../examples/task_neg_mutalias.sober)・[`examples/task_neg_token.sober`](../../examples/task_neg_token.sober)・[`examples/task_neg_handle.sober`](../../examples/task_neg_handle.sober)・[`examples/task_neg_fnparam.sober`](../../examples/task_neg_fnparam.sober)・[`examples/task_neg_wrap_token.sober`](../../examples/task_neg_wrap_token.sober)・[`examples/task_neg_wrap_handle.sober`](../../examples/task_neg_wrap_handle.sober)・[`examples/task_neg_cross.sober`](../../examples/task_neg_cross.sober)・[`examples/task_neg_scope_result.sober`](../../examples/task_neg_scope_result.sober)・[`examples/task_neg_spawnin.sober`](../../examples/task_neg_spawnin.sober)
決定: [language.md 11節](../language.md)

C-3. taskの結果はimmのデータなら何でもよい（string・slice・map・error・それらのstruct）— 子のregionからscopeのregionへコピーされる。関数値・札・handle・端点は結果にできない。scopeの値も出口で外へコピーされる。
例: [`examples/task_result_string.sober`](../../examples/task_result_string.sober)・[`examples/task_scope_value.sober`](../../examples/task_scope_value.sober)
拒否: [`examples/task_neg_result.sober`](../../examples/task_neg_result.sober)
決定: [language.md 11節](../language.md)

## 10.2 Join・Try・失敗と死

C-4. `task.Join(h)` は子の値を待って読む（終わっていれば即返す・何度読んでもよい）。errorを返すtask（gの結果が `(T, error?)`）のJoinは2値で、束縛か `catch` で受ける — 値1つの束縛は拒否、errorを返さないtaskのJoinへのcatchも拒否。JoinもTryもしなかった子の失敗はscopeのerrに集まる。意図して捨てるときは `_ = task.Join(h)`。
例: [`examples/task_handle_err.sober`](../../examples/task_handle_err.sober)・[`examples/task_join_catch.sober`](../../examples/task_join_catch.sober)
拒否: [`examples/task_join_multibind.sober`](../../examples/task_join_multibind.sober)・[`examples/task_join_catch_infallible.sober`](../../examples/task_join_catch_infallible.sober)
決定: [language.md 11節](../language.md)

C-5. 子の死（panic・資源の上限）の受け方は呼び手が字面で選ぶ3通り: `task.Join(h)` = 子の死は自分の死（mainなら終了コード101と `ChildDied`）・`task.Try(h)` = `task.Outcome[T]`（`Ok{v}` / `Failed{e}` / `Died{cause}`）の値として見て本体は続く・どちらもしなければscopeのerrに `task.ChildDied{cause}`。Tryは死を吸収しない — Tryで見た死もscopeの出口でChildDiedになる。死ぬtaskのdeferは走らない。
例: [`examples/task_die.sober`](../../examples/task_die.sober)・[`examples/task_try.sober`](../../examples/task_try.sober)・[`examples/task_die_label.sober`](../../examples/task_die_label.sober)
決定: [language.md 11節](../language.md)

C-6. scopeのerrの優先は、死（ChildDied）> 生んだ順で最初の未回収の失敗 > 本体の結果。選ぶのは生んだ順（正準順）で、終わった順ではない。
例: [`examples/task_fail_order.sober`](../../examples/task_fail_order.sober)・[`examples/task_handle_err.sober`](../../examples/task_handle_err.sober)
決定: [language.md 11節](../language.md)

C-7. scopeの本体（とその中の展開されるラムダ）の `?` は、囲む関数でなく本体を抜ける — 子を全部待ってからscopeは `(ゼロ値, err)` を返す。兄弟の子は切らない。本体のラベルはscopeのerrに行き、囲む関数の `@errors` には流れない。gの中の `?` と、本体から外へのreturn / break / continueは拒否する（子の失敗はgの結果 `(T, error?)` で書く）。
例: [`examples/task_scope_try.sober`](../../examples/task_scope_try.sober)・[`examples/task_scope_try_errors.sober`](../../examples/task_scope_try_errors.sober)
拒否: [`examples/task_spawn_try.sober`](../../examples/task_spawn_try.sober)・[`examples/task_neg_escape.sober`](../../examples/task_neg_escape.sober)
決定: [language.md 11節](../language.md)

## 10.3 handleの列とMap

C-8. handleはmutのsliceに積む（`mut hs := mut []task.Handle[T]{}`）。`task.Gather(hs)` は生んだ順に全部を待って `[]T` を返す（死んだ子を待てば呼び手も死ぬ）。errorを返すtaskのhandleの要素の型は `task.Handle[(T, error?)]` で、Gatherは `([]T, error?)`（errは生んだ順で最初の失敗）。多値の型 `(T, error?)` はHandleの型引数にだけ書ける。immのsliceに積む・errorを返すtaskを `Handle[T]` の列に積むのは拒否。
例: [`examples/task_gather.sober`](../../examples/task_gather.sober)・[`examples/task_gather_err.sober`](../../examples/task_gather_err.sober)・[`examples/task_gather_die.sober`](../../examples/task_gather_die.sober)
拒否: [`examples/task_neg_handles.sober`](../../examples/task_neg_handles.sober)・[`examples/task_neg_handles_err.sober`](../../examples/task_neg_handles_err.sober)・[`examples/task_neg_tuple.sober`](../../examples/task_neg_tuple.sober)・[`examples/task_neg_tuple_shape.sober`](../../examples/task_neg_tuple_shape.sober)
決定: [language.md 11節](../language.md)

C-9. `task.Map(xs, f)`（`xs |> task.Map(f)`）は要素ごとに1 taskを生み、添字の順の `([]U, error?)` を返す。fが `(U, error?)` を返せば、全部を待ってerrは添字が最小の失敗。子が死ねばerrはChildDiedで結果は空。
例: [`examples/task_map.sober`](../../examples/task_map.sober)・[`examples/task_cancel_map.sober`](../../examples/task_cancel_map.sober)
決定: [language.md 11節](../language.md)

C-10. handleを捨てた子（`_ = task.Spawn(…)`）の格納場所は子の寿命で、子の終わりで返る — 終わらないscope（接続を受け続けるループ）で子を生み続けてもscopeのregionは伸びない。未着手の子はワーカーあたり255本までで、越えると生んだtaskが譲って子をその場で先に走らせる（値・死因・出力は変わらない）— 生む速さが掃く速さを上回っても、未着手の子の数は有界。`task.Run(…, backlog: K)` / `net.Serve(…, backlog: K)` は書いたscopeの中の上限をK（1〜255に丸める）にし、子のtaskは継ぐ。値はbudget: と同じ形の整数式。
例: [`examples/task_spawn_discard.sober`](../../examples/task_spawn_discard.sober)・[`examples/task_spawn_discard_die.sober`](../../examples/task_spawn_discard_die.sober)・[`examples/task_backlog.sober`](../../examples/task_backlog.sober)
拒否: [`examples/task_neg_backlog.sober`](../../examples/task_neg_backlog.sober)
決定: [language.md 11節](../language.md)

## 10.4 チャネル

C-11. `tx, rx := task.NewChannel[T](cap: n)` は送り端 `task.Sender[T]` と受け端 `task.Receiver[T]` を作る（容量nは1以上の整数の字面）。端点は単一のtaskが持ち、子へは `task.Spawn(s, (out) => …, give: tx)` でちょうど1つ渡す（捕獲はできない）。渡した後に親が使うとpanic（終了コード101）。端点でない値を `give:` に渡す形は拒否する（値は捕獲で渡す）。1本のチャネルの送り手・受け手は高々1 taskずつなので、到着の順は存在しない。
例: [`examples/task_chan.sober`](../../examples/task_chan.sober)・[`examples/task_chan_def.sober`](../../examples/task_chan_def.sober)・[`examples/task_stale.sober`](../../examples/task_stale.sober)
拒否: [`examples/task_neg_cap.sober`](../../examples/task_neg_cap.sober)・[`examples/task_neg_endpoint.sober`](../../examples/task_neg_endpoint.sober)・[`examples/task_neg_wrap_endpoint.sober`](../../examples/task_neg_wrap_endpoint.sober)・[`examples/task_neg_give_struct.sober`](../../examples/task_neg_give_struct.sober)・[`examples/task_neg_give_int.sober`](../../examples/task_neg_give_int.sober)
決定: [language.md 11節・18節](../language.md)

C-12. `task.Send(tx, v)` は満杯なら待つ。`task.Recv(rx)` は `T?` — 空なら待ち、閉じて空ならnil。`task.Close(tx)` は送り端だけが閉じられ、閉じた後のSendと2度目のCloseはpanic。`for v <- task.Recv(rx) { … }` は閉じて空になるまで受ける。
例: [`examples/task_chan_close.sober`](../../examples/task_chan_close.sober)・[`examples/task_close_send.sober`](../../examples/task_close_send.sober)・[`examples/task_close_twice.sober`](../../examples/task_close_twice.sober)
決定: [language.md 11節](../language.md)

C-13. 送る値はimmのデータ。regionを持つ値（string・slice・map・それらのstruct）は送りでコピーされ、送り手のregionが先に閉じても受け手が読める。端点とhandleは送れない。
例: [`examples/task_chan_string.sober`](../../examples/task_chan_string.sober)・[`examples/task_chan_down.sober`](../../examples/task_chan_down.sober)
拒否: [`examples/task_neg_chan_endpoint.sober`](../../examples/task_neg_chan_endpoint.sober)・[`examples/task_neg_chan_handle.sober`](../../examples/task_neg_chan_handle.sober)
決定: [language.md 11節・18節](../language.md)

C-14. select（届いているかの観測）は無い。複数の生産者の受けは、決まった順に待って書く。全部のtaskが待ち合ったらpanic `Deadlock{}`（終了コード101 — 起きるかはスケジュールに依らない）。
例: [`examples/task_chan_fan.sober`](../../examples/task_chan_fan.sober)・[`examples/task_deadlock.sober`](../../examples/task_deadlock.sober)
決定: [language.md 11節](../language.md)

## 10.5 決定性とキャンセル

C-15. ioの入力を固定すれば、scopeの値は実行のスケジュールとワーカー数に依らない。printlnの標準出力はspawnの木の先行順 — 子の出力全体が親のspawnの位置に入る（ワーカー1で子を先に走らせたときと同じ）。`io.WriteStdout` の直書きはこの順の対象外。死ぬ実行の標準出力の途中までの出力は、ワーカー2以上では約束しない。
例: [`examples/task_print_order.sober`](../../examples/task_print_order.sober)・[`examples/task_print_nested.sober`](../../examples/task_print_nested.sober)・[`examples/task_print_chan.sober`](../../examples/task_print_chan.sober)・[`examples/task_print_direct.sober`](../../examples/task_print_direct.sober)
決定: [language.md 11節](../language.md)

C-16. 子が死ぬと、scopeは後ろの純な子（ioもチャネルも持たない）を検査点（ループの戻り・再帰の入口）で切ることがある。切ってもscopeの値と出力は変わらない。
例: [`examples/task_cancel.sober`](../../examples/task_cancel.sober)・[`examples/task_cancel_spin.sober`](../../examples/task_cancel_spin.sober)
決定: [language.md 11節](../language.md)

## 10.6 予算・プール・期限

C-17. `budget:`（Spawn・Map・Runの末尾の名前つき引数 — `budget: 64 * task.MB`）は、そのtaskを逐次に走らせたときの使用量の上界の宣言。値は呼び出しと割り算を含まない整数式。並列度は「上限 ÷ 上界」でrtが決め、入れない子は親の上でその場に逐次に走る（値・死因・出力は変わらない）。`task.Run(…, wait: true)` の直接の子は、入れなければ逐次にせず入れるまで待つ。
例: [`examples/task_budget.sober`](../../examples/task_budget.sober)
拒否: [`examples/task_neg_budget.sober`](../../examples/task_neg_budget.sober)
決定: [language.md 11節](../language.md)

C-18. `task.NewPool(budget:, parent:)` は名前つきの上限の節。`task.SpawnIn(s, pool, g)` だけは逐次にせず、入れなければ `(nil, task.Shed{})` を返す（受けられない、という値）。`task.Ledger()` は上限・計上・逐次化・shed・失敗・死の数と、スケジューラの `maxWait`（走れるようになってから走るまでの待ちの最大 — ns・読むと0に戻る）・`aged`（待ちの上限が効いた回数）・`late`（待ちの上限Dを越えて走ったtaskの数の累計）・`maxLate`（越えた量〔待ち − D〕の最大 — ns・読むと0に戻る）・`backlog`（今の未着手の子の数）・`backlogYield`（未着手の子の上限で譲った回数）・`parkShallow` / `parkDeep` / `parkDeepWin` / `parkSwap`（接続のtaskがシャロースリープした・ワーカーのエリアを保持したままスリープした・シャロースリープできる点でウィンドウに中身があってディープスリープした・シャロースリープの前にエリアを交換した回数の累計）を読むAPIで、`task.MarkFailed(pool)` は境界の失敗を数える。
例: [`examples/task_shed.sober`](../../examples/task_shed.sober)・[`examples/task_pool_seq.sober`](../../examples/task_pool_seq.sober)
決定: [language.md 11節](../language.md)

C-19. `task.Run(body, deadline: 500 * task.MS)` はscopeの期限（相対・単調時計）。子孫のtaskも期限を継ぎ、入れ子は早い方。期限は待ちの上限であって実行時間の上限ではない — 期限の後に呼んだioの関数が `io.Expired` を返し（netの待ちは期限で切れる — 11章）、`os.Sleep` は早く返る。走っている計算は止めない。値はbudget: と同じ形の整数式。
例: [`examples/task_deadline.sober`](../../examples/task_deadline.sober)・[`examples/task_sleep_deadline.sober`](../../examples/task_sleep_deadline.sober)・[`examples/net_deadline.sober`](../../examples/net_deadline.sober)
拒否: [`examples/task_neg_deadline.sober`](../../examples/task_neg_deadline.sober)
決定: [language.md 11節・28節](../language.md)

## 10.7 ワーカー局所のlease

C-20. `lp := task.NewLocal((w mut T) => 整え)` はワーカーごとの作業域の格納場所を作り、`task.Lease(lp, (w mut T) => 本体)` のウィンドウの中だけで借りる。ウィンドウのたびに新しい値 — 前のウィンドウ（同じtaskでも別のtaskでも）の書きは見えない（格納場所の使い回しは観測に出ない最適化）。Tはスカラーと `pool.Scratch` のフィールドだけのstruct。整えはScratchのフィールドごとに `pool.NewScratch(mut w.f, 定数)` を1回ずつ書くか、Tのpackageの関数1つ `F(mut w)` を呼ぶ（本体1文の転送 `G(mut w)` はTのpackageの関数に着くまで深さ4まで辿る — 別のpackageの包みからも呼べる）。ラムダのmut仮引数はこの2つのウィンドウの位置にだけ書ける。`task.Local` のゼロ値は作れない。
例: [`examples/lease.sober`](../../examples/lease.sober)・[`examples/lease_alias.sober`](../../examples/lease_alias.sober)・[`examples/lease_iter.sober`](../../examples/lease_iter.sober)・[`examples/lease_bytes.sober`](../../examples/lease_bytes.sober)・[`examples/lease_yield.sober`](../../examples/lease_yield.sober)
拒否: [`examples/lease_neg_form.sober`](../../examples/lease_neg_form.sober)・[`examples/lease_neg_mutlam.sober`](../../examples/lease_neg_mutlam.sober)・[`examples/lease_neg_shape.sober`](../../examples/lease_neg_shape.sober)・[`examples/lease_neg_prep.sober`](../../examples/lease_neg_prep.sober)・[`examples/lease_neg_zero.sober`](../../examples/lease_neg_zero.sober)・[`examples/lease_neg_reserved.sober`](../../examples/lease_neg_reserved.sober)
決定: [language.md 11節・26節・32節](../language.md)・[region-domain-pool.md 4d節](../region-domain-pool.md)

## 10.8 domain

C-21. `d := task.NewDomain(s, init)` は札sのscopeに状態の初期値initを持つdomain `task.Domain[S]` を作る（Sはinitの型）。Sはmutの器（mut slice / mut map — 要素がmutの器を持つ入れ子も）を持てる。initは作るときに深くコピーする（initに渡した器と別名にならない）。`wait:`（Awaitの待ちの上限・ナノ秒の相対時間）は省略でき、値はbudget: と同じ形の整数式。dは捕獲でき（子のtaskへも）、関数の実引数にできる（structのフィールドに入れて渡すのも）。scopeの値・taskの結果・チャネルのペイロード・関数の戻り値にはできない（札・handleと同じ側）。dはscopeの出口で状態ごと消えるので、d（とdを持つ値）はsより外で作った場所へ書けず、mut仮引数を根とする場所へも書けない（呼び先は場所のscopeを知らない）。sより外のscopeの札でSpawnしたtaskはdを捕獲できない（kind 39）。
例: [`examples/domain_counter.sober`](../../examples/domain_counter.sober)・[`examples/domain_arg.sober`](../../examples/domain_arg.sober)・[`examples/domain_scope_place.sober`](../../examples/domain_scope_place.sober)・[`examples/domain_slots.sober`](../../examples/domain_slots.sober)
拒否: [`examples/domain_neg_escape.sober`](../../examples/domain_neg_escape.sober)・[`examples/domain_neg_return.sober`](../../examples/domain_neg_return.sober)・[`examples/domain_neg_outlive_append.sober`](../../examples/domain_neg_outlive_append.sober)・[`examples/domain_neg_outlive_field.sober`](../../examples/domain_neg_outlive_field.sober)・[`examples/domain_neg_outlive_spawn.sober`](../../examples/domain_neg_outlive_spawn.sober)・[`examples/domain_neg_outlive_mutparam.sober`](../../examples/domain_neg_outlive_mutparam.sober)・[`examples/domain_neg_outlive_swap.sober`](../../examples/domain_neg_outlive_swap.sober)・[`examples/domain_neg_outlive_pool.sober`](../../examples/domain_neg_outlive_pool.sober)
決定: [language.md 11節「domain」](../language.md)

C-22. `task.Update(d, (st mut S) => 本体)` は本体をdの状態に適用し、本体の値を呼び手の最内のregionへコピーして返す。`task.Read(d, (st S) => 本体)` は状態を変えずに本体の値を返す。dの呼び出しは1つずつ走り、走った順は録られる入力（C-15の「ioの入力」に含む — 順を固定すればscopeの値はスケジュールに依らない）。3つの関数はエフェクト `nondet` を持つ。
例: [`examples/domain_counter.sober`](../../examples/domain_counter.sober)
決定: [language.md 11節「domain」・12節](../language.md)

C-23. `task.Await(d, (st mut S) => 本体, when: (st S) => 条件)` は条件が真になるまで待ってから本体を適用し、`(R, error?)` を返す。待つ呼び出しは来た順に入る。待ちがdの `wait:`（呼び出しに `wait:` を書けばその値）を越えたら `io.Expired`。
例: [`examples/domain_await.sober`](../../examples/domain_await.sober)・[`examples/domain_expire.sober`](../../examples/domain_expire.sober)・[`examples/domain_handoff.sober`](../../examples/domain_handoff.sober)・[`examples/domain_requeue.sober`](../../examples/domain_requeue.sober)
決定: [language.md 11節「domain」](../language.md)

C-24. 本体と `when:` は呼び出しに書いた字面のラムダ（仮引数1つ）。immのデータだけを捕獲し（mutの束縛・mutの中身・札・handle・端点・関数型の仮引数は捕獲できない）、return・break・continue・`?` で外へ出ない。エフェクトは持たない — 待たない・ioなし・nondetなし・明示のpanicなし。別のdomainの呼び出しはnondetなので書けない（持ったまま待つ形が無い）。本体が状態stに書けるのはregionを持たない値（int・bool・byte・floatとそれらのstruct / union・option）だけで、mapの添字を通らない場所へだけ（append・再スライス・string・mapへの書き・状態に触れるregionを持つ値のmutの束縛〔`mut v := st.items`・`w := st.items` の後の `mut v := w` — 別名を経たappendが状態を伸ばす。状態に触れるregionを持つ値の束縛・代入（代入先の根）の名前は状態と同じ規則で見る〕は拒否）。stとその部分を本体の中でmutの実引数に渡せるのは、呼び先がその仮引数を根として本体と同じ規則で書く（呼び先の本体に同じ検査を適用して確認する — 呼び先が分からない・総称・再帰・std/taskのAPIは確認できない側）ときだけ（確認できなければ拒否 — 関数は値を受けて新しい値を返し、本体で代入する）。
例: [`examples/domain_mutarg.sober`](../../examples/domain_mutarg.sober)
拒否: [`examples/domain_neg_capture.sober`](../../examples/domain_neg_capture.sober)・[`examples/domain_neg_effect.sober`](../../examples/domain_neg_effect.sober)・[`examples/domain_neg_nested.sober`](../../examples/domain_neg_nested.sober)・[`examples/domain_neg_grow.sober`](../../examples/domain_neg_grow.sober)・[`examples/domain_neg_mutarg.sober`](../../examples/domain_neg_mutarg.sober)・[`examples/domain_neg_alias.sober`](../../examples/domain_neg_alias.sober)
決定: [language.md 11節「domain」](../language.md)

C-25. 本体（`when:` を含む）が死ぬと（境界検査・ゼロ除算・RegionExceeded等）、呼び手のtaskが死に、dは毒された状態になる。以後のdの呼び出しは呼び手を `task.Poisoned{}` で死なせ、待っているAwaitも起きて同じく死ぬ（状態は半端に書かれたまま進めない）。
例: [`examples/domain_poison.sober`](../../examples/domain_poison.sober)
決定: [language.md 11節「domain」](../language.md)

C-26. `task.Ledger().domains` は全domainをまとめた1行 `task.DomainView{waiting, maxWait, expired, poisoned}`: waiting = 今Awaitで待っている呼び出しの数・maxWait = 待ったAwaitの到着から入るまでの最大（ns — 読むと0に戻るウィンドウの値。LedgerのmaxWaitと同じ流儀）・expired = 待ちの上限で `io.Expired` を返した回数の累計・poisoned = 毒になったdomainの数の累計。
例: [`examples/domain_expire.sober`](../../examples/domain_expire.sober)・[`examples/domain_poison.sober`](../../examples/domain_poison.sober)
決定: [language.md 11節「domain」](../language.md)
