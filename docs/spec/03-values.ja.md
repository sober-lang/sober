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
決定: [language.md 6 節](../language.md)・[syntax.md 決定 13](../syntax.md)

V-2. シャドーイングは無い。ローカルの束縛（`:=`・仮引数・ラムダの仮引数・for の束縛・型パターンの束縛）は、外側のローカルの束縛・同じ package のトップレベルの名前（const・func・型・variant）・import の参照名と同じ名前にできない。型パラメータはトップレベルの型名と同じ名前にできない。兄弟のスコープで同じ名前を使うのはシャドーイングでない。
例: [`examples/shadow_ok.sober`](../../examples/shadow_ok.sober)
拒否: [`examples/shadow_block.sober`](../../examples/shadow_block.sober)・[`examples/shadow_lambda.sober`](../../examples/shadow_lambda.sober)・[`examples/shadow_pattern.sober`](../../examples/shadow_pattern.sober)・[`examples/localname_const.sober`](../../examples/localname_const.sober)・[`examples/localname_import.sober`](../../examples/localname_import.sober)・[`examples/localname_named.sober`](../../examples/localname_named.sober)・[`examples/localname_tparam.sober`](../../examples/localname_tparam.sober)
決定: [syntax.md 決定 13](../syntax.md)

V-3. トップレベルの束縛は const 式だけ — 関数を呼べず、実行時の初期化（`init()`）も無い。const 式に置けるのは定数・演算・struct のリテラル（欄に閉じたラムダや名前つき関数の参照を持つ辞書を含む — 5 章 F-8）。トップレベルの名前は package の中で一意（種類が違っても重ならない）。
例: [`examples/constdict.sober`](../../examples/constdict.sober)
拒否: [`examples/const_neg_call.sober`](../../examples/const_neg_call.sober)・[`examples/top_dup.sober`](../../examples/top_dup.sober)・[`examples/top_dup_kinds.sober`](../../examples/top_dup_kinds.sober)
決定: [syntax.md 決定 14](../syntax.md)・[language.md 13 節・25 節](../language.md)

## 3.2 mut 引数

V-4. 仮引数の型の先頭の `mut`（`func bump(n mut int)`）は mut 引数の印で、呼び手の可変の場所への参照を受ける — 呼び先の書きは呼び手に見える。呼び出し点にも `mut` を書く（`bump(mut k)`）。実引数は呼び手の mut の場所（mut のローカル・mut 仮引数）か、そこから欄をたどった道（`mut st.nodes`）に限る。印の無い実引数・不変の束縛は拒否する。
例: [`examples/mutparam.sober`](../../examples/mutparam.sober)・[`examples/field_mutarg.sober`](../../examples/field_mutarg.sober)・[`examples/tour_06_mut.sober`](../../examples/tour_06_mut.sober)
拒否: [`examples/mutarg_neg_mark.sober`](../../examples/mutarg_neg_mark.sober)・[`examples/mutarg_neg_const.sober`](../../examples/mutarg_neg_const.sober)・[`examples/mutarg_decl_mismatch.sober`](../../examples/mutarg_decl_mismatch.sober)
決定: [language.md 26 節](../language.md)

V-5. 同じ呼び出しの mut 実引数どうしは重ならない — 同じ道や、一方が他方の欄の道（`f(mut s, mut s)`・`f(mut t, mut t.xs)`）は拒否する。兄弟の欄・別の根は重ならない。mut と imm の実引数の重なり（`f(mut t, t)`）は許し、imm の側は呼び出しの前の値を見る。
例: [`examples/mut_args_disjoint.sober`](../../examples/mut_args_disjoint.sober)
拒否: [`examples/mutarg_neg_alias.sober`](../../examples/mutarg_neg_alias.sober)
決定: [language.md 26 節](../language.md)

V-6. mut 仮引数（slice・map とそれを含む struct）の中身は呼び出しの外へ逃げない — 仮引数を根に持つ道を return の値・他への代入・欄・append の要素に置けない。要素の読み（`return xs[i]`）とスカラーの欄の読みは書ける。
例: [`examples/hdr_mut2.sober`](../../examples/hdr_mut2.sober)
拒否: [`examples/mutarg_neg_escape.sober`](../../examples/mutarg_neg_escape.sober)
決定: [language.md 26 節](../language.md)

V-7. mut 仮引数を持つ関数は関数値にならず、関数型の仮引数にも渡せない（関数型に mut の席は無い）。
拒否: [`examples/fnarg_mut.sober`](../../examples/fnarg_mut.sober)
決定: [language.md 25 節・26 節](../language.md)

## 3.3 freeze

V-8. `freeze(x)` は可変のコンテナ（`mut []T`・`mut map[K]V`）を不変（`[]T`・`map[K]V`）にする — 中身は写さない。freeze できるのは、局所の束縛を根に持つ道（`x`・`x.f`）で、その点で他に別名の無いものだけ。期待型が imm の位置に mut のコンテナを置く暗黙の freeze（2 章 T-26）にも同じ規則が掛かる。
例: [`examples/freeze_unique.sober`](../../examples/freeze_unique.sober)・[`examples/implicit_freeze.sober`](../../examples/implicit_freeze.sober)
拒否: [`examples/freeze_neg_alias.sober`](../../examples/freeze_neg_alias.sober)
決定: [language.md 17 節](../language.md)

V-9. freeze の後は、凍らせた道へ添字・欄・map の書き込みをすることも、mut で渡すこともできない（ループの中の freeze なら同じループ全体が「後」）。`append` で伸ばすのは書ける（凍った範囲の外にしか書かない）。凍らせた値が変わらないことは受理の時点で決まり、実行時の検査は無い。この規則は `sober build` でも検査する。
例: [`examples/freeze_unique.sober`](../../examples/freeze_unique.sober)
拒否: [`examples/freeze_neg_write.sober`](../../examples/freeze_neg_write.sober)
決定: [language.md 17 節](../language.md)
