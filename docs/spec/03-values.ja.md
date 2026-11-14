# 3. 値と束縛

日本語

[目次](README.ja.md)

束縛は既定で不変。可変にするものは `mut` と書き、呼び手の可変の場所を書き換える関数は仮引数と呼び出し点の両方に `mut` を書く。可変のコンテナは `freeze` で一方通行に不変へ渡す。

```sober
// examples/tour_06_mut.sober
package main

// Tour 6: mut arguments and freeze (docs/guide/tour.md)

// A function that rewrites the caller's mut local says mut on the parameter and at the call site
func push3(xs mut []int, v int) {
    xs = append(xs, v)
    xs = append(xs, v)
    xs = append(xs, v)
}

type Counter struct {
    n int
}

func bump(c mut Counter) {
    c.n += 1
}

func main() int {
    mut xs := mut []int{}
    push3(mut xs, 7)
    println(len(xs))
    mut c := Counter{n: 0}
    bump(mut c)
    bump(mut c)
    println(c.n)
    // freeze when done building — from then on it can be shared as immutable
    ys := freeze(xs)
    println(ys[0] + ys[1] + ys[2])
    return 0
}
```

出力:

```
3
2
21
```

## 3.1 束縛

V-1. `x := e` は不変の束縛で、再代入できない。再代入する束縛は `mut x := e` で宣言する。`:=` は左辺の名前を全部新しく宣言する（宣言と再代入の混在は無い）。
例: [`examples/tour_01_values.sober`](../../examples/tour_01_values.sober)
拒否: [`examples/bind_neg_assign.sober`](../../examples/bind_neg_assign.sober)
決定: [language.md 6節](../language.md)・[syntax.md決定13](../syntax.md)

V-2. シャドーイングは無い。ローカルの束縛（`:=`・仮引数・ラムダの仮引数・forの束縛・型パターンの束縛）は、外側のローカルの束縛・同じpackageのトップレベルの名前（const・func・型・variant）・importの参照名と同じ名前にできない。型パラメータはトップレベルの型名と同じ名前にできない。兄弟のスコープで同じ名前を使うのはシャドーイングでない。
例: [`examples/shadow_ok.sober`](../../examples/shadow_ok.sober)
拒否: [`examples/shadow_block.sober`](../../examples/shadow_block.sober)・[`examples/shadow_lambda.sober`](../../examples/shadow_lambda.sober)・[`examples/shadow_pattern.sober`](../../examples/shadow_pattern.sober)・[`examples/localname_const.sober`](../../examples/localname_const.sober)・[`examples/localname_import.sober`](../../examples/localname_import.sober)・[`examples/localname_named.sober`](../../examples/localname_named.sober)・[`examples/localname_tparam.sober`](../../examples/localname_tparam.sober)
決定: [syntax.md決定13](../syntax.md)

V-3. トップレベルの束縛はconst式だけ — 関数を呼べず、実行時の初期化（`init()`）も無い。constは2種類: **intのconst** はintのリテラル・算術・ビット演算・intのconstの参照でできた式で、ビルドの時点で値に畳む。**組み立てのconst** はstring / floatのリテラル（負のfloatのリテラルを含む）・`true` / `false`・structのリテラル（部分リテラル可）・immのsliceのリテラルと、その入れ子でできた式で、葉にはintのconst式・閉じたラムダ・名前つき関数の参照（5章F-8）・他のconstの参照・フィールドの値の位置の `nil` を置ける。組み立てのconstは参照する点で組み立てる（5章F-8）。floatのconst式（floatのリテラル・floatのconstの参照と、それらの `+` `-` `*` `/`・単項の `-`）も組み立てのconstで、参照する点の式として実行時と同じIEEEの丸めで計算する（intのリテラルは混ぜられない — 2章T-10）。それ以外の演算（stringの `+`・補間・比較・`!` 等）を使えるのはintのconstだけで、関数の呼び出し・`mut` のリテラル・mapのリテラル（`@embed` を除く — 12章A-3）・トップレベルの `nil` は置けない。トップレベルの名前はpackageの中で一意（種類が違っても重ならない）。
例: [`examples/constdict.sober`](../../examples/constdict.sober)・[`examples/const_lit.sober`](../../examples/const_lit.sober)・[`examples/const_table.sober`](../../examples/const_table.sober)・[`examples/const_float.sober`](../../examples/const_float.sober)
拒否: [`examples/const_neg_call.sober`](../../examples/const_neg_call.sober)・[`examples/const_neg_strop.sober`](../../examples/const_neg_strop.sober)・[`examples/const_neg_floatint.sober`](../../examples/const_neg_floatint.sober)・[`examples/const_neg_mutslice.sober`](../../examples/const_neg_mutslice.sober)・[`examples/const_neg_map.sober`](../../examples/const_neg_map.sober)・[`examples/const_neg_nil.sober`](../../examples/const_neg_nil.sober)・[`examples/top_dup.sober`](../../examples/top_dup.sober)・[`examples/top_dup_kinds.sober`](../../examples/top_dup_kinds.sober)
決定: [syntax.md決定14](../syntax.md)・[language.md 13節・25節・37節](../language.md)

## 3.2 mut引数

V-4. 仮引数の型の先頭の `mut`（`func bump(n mut int)`）はmut引数のマークで、呼び手の可変の場所への参照を受ける — 呼び先の書きは呼び手に見える。呼び出し点にも `mut` を書く（`bump(mut k)`）。実引数は呼び手のmutの場所（mutのローカル・mut仮引数）か、そこからフィールドをたどったパス（`mut st.nodes`）に限る。マークの無い実引数・不変の束縛は拒否する。
例: [`examples/mutparam.sober`](../../examples/mutparam.sober)・[`examples/field_mutarg.sober`](../../examples/field_mutarg.sober)・[`examples/tour_06_mut.sober`](../../examples/tour_06_mut.sober)
拒否: [`examples/mutarg_neg_mark.sober`](../../examples/mutarg_neg_mark.sober)・[`examples/mutarg_neg_const.sober`](../../examples/mutarg_neg_const.sober)・[`examples/mutarg_decl_mismatch.sober`](../../examples/mutarg_decl_mismatch.sober)
決定: [language.md 26節](../language.md)

V-5. 同じ呼び出しのmut実引数どうしは重ならない — 同じパスや、一方が他方のフィールドのパス（`f(mut s, mut s)`・`f(mut t, mut t.xs)`）は拒否する。兄弟のフィールド・別の根は重ならない。mutとimmの実引数の重なり（`f(mut t, t)`）は許し、immの側は呼び出しの前の値を見る。
例: [`examples/mut_args_disjoint.sober`](../../examples/mut_args_disjoint.sober)・[`examples/ref_param.sober`](../../examples/ref_param.sober)
拒否: [`examples/mutarg_neg_alias.sober`](../../examples/mutarg_neg_alias.sober)
決定: [language.md 26節](../language.md)

V-6. mut仮引数（slice・mapとそれを含むstruct）の中身は呼び出しの外へ逃げない — 仮引数を根に持つパスをreturnの値・他への代入・フィールド・appendの要素に置けない。要素の読み（`return xs[i]`）とスカラーのフィールドの読みは書ける。
例: [`examples/hdr_mut2.sober`](../../examples/hdr_mut2.sober)
拒否: [`examples/mutarg_neg_escape.sober`](../../examples/mutarg_neg_escape.sober)
決定: [language.md 26節](../language.md)

V-7. 関数型の仮引数はmutにできる（`func(st mut S, x int)`）。mut仮引数は関数型1つに1本までで、その位置は関数型の同一性に入る。mut仮引数を持つ関数は、同じ位置にmutを持つ関数型の値になる。値の呼び出しのmut仮引数には `mut x` を渡し、他の仮引数には値を渡す。ラムダの仮引数の型を書くならmutのマークも関数型と同じ位置に書き、型を書かなければmut仮引数の位置は関数型から決まる。
例: [`examples/fn_mut_param.sober`](../../examples/fn_mut_param.sober)
拒否: [`examples/fn_mut_param_neg_two.sober`](../../examples/fn_mut_param_neg_two.sober)・[`examples/fn_mut_param_neg_eta.sober`](../../examples/fn_mut_param_neg_eta.sober)・[`examples/fnarg_mut.sober`](../../examples/fnarg_mut.sober)・[`examples/fn_mut_param_neg_lambda.sober`](../../examples/fn_mut_param_neg_lambda.sober)・[`examples/fn_mut_param_neg_arg.sober`](../../examples/fn_mut_param_neg_arg.sober)・[`examples/lease_neg_mutlam.sober`](../../examples/lease_neg_mutlam.sober)
決定: [language.md 25節・26節](../language.md)

## 3.3 freeze

V-8. `freeze(x)` は可変のコンテナ（`mut []T`・`mut map[K]V`）を不変（`[]T`・`map[K]V`）にする — 中身はコピーしない。freezeできるのは、局所の束縛を根に持つパス（`x`・`x.f`）で、その点で他に別名の無いものだけ。期待型がimmの位置にmutのコンテナを置く暗黙のfreeze（2章T-26）にも同じ規則が掛かる。
例: [`examples/freeze_unique.sober`](../../examples/freeze_unique.sober)・[`examples/implicit_freeze.sober`](../../examples/implicit_freeze.sober)
拒否: [`examples/freeze_neg_alias.sober`](../../examples/freeze_neg_alias.sober)
決定: [language.md 17節](../language.md)

V-9. freezeの後は、凍らせたパスへ添字・フィールド・mapの書き込みをすることも、mutで渡すこともできない（ループの中のfreezeなら同じループ全体が「後」）。`append` で伸ばすのは書ける（凍った範囲の外にしか書かない）。凍らせた値が変わらないことは受理の時点で決まり、実行時の検査は無い。この規則は `sober build` でも検査する。
例: [`examples/freeze_unique.sober`](../../examples/freeze_unique.sober)
拒否: [`examples/freeze_neg_write.sober`](../../examples/freeze_neg_write.sober)
決定: [language.md 17節](../language.md)

V-10. mutの列の要素のフィールドへは書ける: `xs[i].f = v`（フィールドの連鎖・入れ子の列・複合代入も）は、要素を読んでフィールドを差し替えて `xs[i]` へ書き戻すのと同じ。添字への直の複合代入 `xs[i] op= v` も同じ変換（mapの `m[k] op= v` は無い — 読みが `T?`）。添字・右辺・要素の読み・書きの順に評価し、添字は1回だけ評価する。immの列への書きは拒否する。
例: [`examples/elem_field_assign.sober`](../../examples/elem_field_assign.sober)
拒否: [`examples/elem_field_assign_neg_imm.sober`](../../examples/elem_field_assign_neg_imm.sober)
決定: [language.md 21節](../language.md)
