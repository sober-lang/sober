# 4. 式

日本語

[目次](README.ja.md)

if・switch・ブロックは値を持つ式。多値は分解する点まで流れる。パイプ `|>` は左の値を右の呼び出しの実引数へ流す。

## 4.1 if・switch・ブロック

X-1. `if c { a } else { b }` は値を持つ式。ブロック `{ … }` は最後の式が値。else の無い if は文の位置だけに書け、値にはできない（`T?` を暗黙に作らない）。
例: [`examples/tour_01_values.sober`](../../examples/tour_01_values.sober)・[`examples/block_escape.sober`](../../examples/block_escape.sober)
拒否: [`examples/if_neg_noelse_value.sober`](../../examples/if_neg_noelse_value.sober)
決定: [language.md 1 節](../language.md)

X-2. 値の位置の if / switch の腕の型は、期待型があればそれで、無ければ腕どうしで合わせる（双方向の型検査）。腕は脱出（`return` / `break` / `continue` / `panic(…)`）で終わってよく、その腕は相手の腕の型に合う。
例: [`examples/exit_arms.sober`](../../examples/exit_arms.sober)・[`examples/if_region_join.sober`](../../examples/if_region_join.sober)・[`examples/switch_region_join.sober`](../../examples/switch_region_join.sober)
決定: [language.md 1 節・5 節](../language.md)

X-3. 文の位置（func の本体・while の本体・文の位置の腕・値の位置のブロックの末尾以外）の式文は呼び出し（`f(x)`・`x |> f()`・`f()?`）か、腕がまた文の位置になる if / switch / ブロックだけ。呼び出しの結果は捨ててよい。純粋な式（名前・演算・リテラル・添字）の値を捨てる文は拒否する。
例: [`examples/stmt_tail_call.sober`](../../examples/stmt_tail_call.sober)・[`examples/switch_stmt_exit.sober`](../../examples/switch_stmt_exit.sober)
拒否: [`examples/exprstmt_pure.sober`](../../examples/exprstmt_pure.sober)
決定: [language.md 1 節](../language.md)

X-4. switch は 3 つの形を持つ — subject の無い形（`case 条件:` の並び）・単値の subject・多値の subject（`switch a, b { case 1, 2: … }`）。腕のパターンは定数（`case 1 | 2:` で選択）・`_`・裸の名前（束縛。ただし同じ名前の const があればその値との比較）・型パターン（`case Rect{w, h}:`・欄の名前 `case L{n: v}`・入れ子・値全体の束縛 `case e L{}:`）。腕の値は上から順に最初に一致した腕。
例: [`examples/switch.sober`](../../examples/switch.sober)・[`examples/switch_const.sober`](../../examples/switch_const.sober)・[`examples/pattern_bind.sober`](../../examples/pattern_bind.sober)・[`examples/pattern_nested.sober`](../../examples/pattern_nested.sober)・[`examples/switch_multi.sober`](../../examples/switch_multi.sober)
決定: [language.md 1 節](../language.md)・[syntax.md 決定 3](../syntax.md)

X-5. switch の中の `break` / `continue` は、switch を囲むループ（while・文形 for）に掛かる — switch を抜ける `break` は無い（fallthrough も無い）。文の位置の switch の腕は脱出で終わってよい。
例: [`examples/switch_stmt_exit.sober`](../../examples/switch_stmt_exit.sober)・[`examples/switch_stmt_allret.sober`](../../examples/switch_stmt_allret.sober)
決定: [language.md 13 節](../language.md)

## 4.2 多値

X-6. 関数は複数の結果を返せる（`func divmod(a, b int) (int, int)`）。多値は分解する点までしか生きない — `a, b := f()` の束縛・`return f()`・switch の subject・パイプの穴。丸ごと 1 つの名前に保存すること・`.0` で取り出すこと・`f(g())` と実引数へ流すこと・既存の名前へ代入すること（`a, b = f()` — 代入で受けるのは X-7 の全部 `_` の捨てだけ）はできない。名前を持つべき組は struct で書く。
例: [`examples/multi.sober`](../../examples/multi.sober)・[`examples/switch_multi.sober`](../../examples/switch_multi.sober)
拒否: [`examples/multibind.sober`](../../examples/multibind.sober)・[`examples/multi_assign.sober`](../../examples/multi_assign.sober)
決定: [language.md 2 節](../language.md)

X-7. 値を明示して捨てるときは `_ = e` と書く（捨てた事実が字面に残る）。多値は結果の数だけ `_` を並べる（`_, _ = f()`）。
例: [`examples/discard.sober`](../../examples/discard.sober)
決定: [language.md 11 節](../language.md)

## 4.3 パイプ

X-8. `x |> f(a)` は `f(x, a)` — 左の値は既定で右の呼び出しの第 1 引数になる。位置を選ぶときは穴 `_` を書く（`x |> f(a, _)` は `f(a, x)`）。`x |> f` は `f(x)`。穴は右の呼び出しの直下の実引数の位置だけで、入れ子の呼び出しの中（`x |> f(g(_))`）には置けない。
例: [`examples/pipe_basic.sober`](../../examples/pipe_basic.sober)
拒否: [`examples/pipe_neg_nested_hole.sober`](../../examples/pipe_neg_nested_hole.sober)
決定: [language.md 4 節](../language.md)

```sober
// examples/pipe_basic.sober
package main

// パイプ `|>`（language.md 4 節）: 左辺は既定で第 1 引数へ。穴 `_` で位置を選ぶ（直下の実引数だけ）

func add(a int, b int) int {
    return a + b
}

func sub(a int, b int) int {
    return a - b
}

func dbl(x int) int {
    return x * 2
}

func main() {
    println(4 |> dbl, 10 |> sub(3), 3 |> sub(10, _), 5 |> add(1) |> dbl)
}
```

出力:

```
8 7 7 12
```

## 4.4 型推論・評価の順・defer

X-9. 型推論は関数の中だけ。関数の署名（仮引数と結果の型）は明示し、本体の束縛とラムダの仮引数の型は推論する（ラムダの仮引数の型は期待型から決まる）。
例: [`examples/inline.sober`](../../examples/inline.sober)・[`examples/generic_infer_lambda.sober`](../../examples/generic_infer_lambda.sober)
決定: [language.md 5 節](../language.md)

X-10. 評価の順は書いた順（左から右）— 呼び出しの実引数・二項演算の左右・`println` の実引数・composite リテラルの欄の値（欄の宣言の順と違う順に書いても書いた順）。
例: [`examples/composite_order.sober`](../../examples/composite_order.sober)
決定: [language.md 27 節](../language.md)

X-11. `defer e` はブロックの出口で式全体を評価する（実引数も出口の時点の値）。出口は普通の終わりと、return・break・continue・`?` による脱出のどれも含む。ループの本体の defer は周回ごとに走る。
例: [`examples/defer.sober`](../../examples/defer.sober)・[`examples/early_return.sober`](../../examples/early_return.sober)
決定: [syntax.md 決定 17](../syntax.md)
