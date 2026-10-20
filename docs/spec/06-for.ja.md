# 6. for

日本語

[目次](README.ja.md)

`for` は 2 つの形だけ — 式の位置の生成器（`yield` 形）と、文の位置の消費（文形）。状態機械や終わりの条件で回るループは `while`。終端の操作（合計・集め・each）は std の関数とパイプで書く。

```sober
// examples/tour_03_collections.sober
package main

import "std/iter"

// Tour 3: slices, maps, for (docs/guide/tour.md)

func main() int {
    // Build a slice with mut, then freeze it to pass it around immutably
    mut xs := mut []int{}
    for i <- iter.Range(1, 6) {
        xs = append(xs, i * i)
    }
    squares := freeze(xs)
    println(len(squares), squares[0], squares[4])

    // for ... yield is a lazy producer (Iter) — consume it through a pipe, not a variable
    println(for v <- squares if v % 2 == 0 yield v |> iter.Sum)

    // map: a lookup is T? (nil when absent)
    mut ages := mut map[string]int{}
    ages["ada"] = 36
    ages["alan"] = 41
    a := ages["ada"]
    if a != nil {
        println("ada is ${a}")
    }
    println(ages["grace"] == nil)
    return 0
}
```

出力:

```
5 1 25
20
ada is 36
true
```

## 6.1 生成器（yield 形）

R-1. 式の位置の `for x <- 生成元 if 条件 yield e` は、要素を 1 つずつ押し出す生産者（std/iter の `Iter[T]`）。中間のコレクションは作らない。生成器は関数の `Iter[T]` の仮引数の位置で消費する（`iter.Sum(for …)`・`for … yield e |> iter.Count()`）。ガード `if` は生成元の直後に書く。
例: [`examples/tour_03_collections.sober`](../../examples/tour_03_collections.sober)・[`examples/lexer_iter.sober`](../../examples/lexer_iter.sober)・[`examples/for_callgen_expr.sober`](../../examples/for_callgen_expr.sober)
決定: [language.md 7 節](../language.md)・[syntax.md 決定 4](../syntax.md)

R-2. `for … yield e |> f` の `|>` は for 式全体に掛かる（yield の値は `|>` の手前で止まる）。yield の値の中でパイプするときは `yield (e |> g)` と括弧で書く。
例: [`examples/lexer_iter.sober`](../../examples/lexer_iter.sober)・[`examples/tour_03_collections.sober`](../../examples/tour_03_collections.sober)
決定: [language.md 7 節](../language.md)

R-3. `yield` は字句的に囲む生成器のもの。生成器のブロック形の中の文形 for から `yield` すると外の生成器へ押し出す（入れ子の走査）。囲む生成器が無い `yield` は拒否する。
例: [`examples/for_stmt.sober`](../../examples/for_stmt.sober)
拒否: [`examples/for_neg_yield_outside.sober`](../../examples/for_neg_yield_outside.sober)
決定: [language.md 7 節](../language.md)

## 6.2 生成元

R-4. slice は `x <- xs` で要素を先頭から回す。map は `k <- m` でキーを初回挿入の順に回す（`keys(m)` の写しの上を回るので、回している間の変更は回る列に影響しない — 2 章 T-30）。
例: [`examples/for_stmt.sober`](../../examples/for_stmt.sober)・[`examples/map_keys.sober`](../../examples/map_keys.sober)
決定: [language.md 7 節・22 節](../language.md)

R-5. 生成元が名前つきの関数の呼び出しで、仮引数が実引数より 1 つ多く、最後の仮引数が関数型なら、for は継続 `(x) => …` を末尾の実引数に足して呼ぶ（呼び出し形の生成元 — `for i <- iter.Range(0, n)`）。判定は呼び先の宣言の署名だけで決まる。
例: [`examples/for_stmt.sober`](../../examples/for_stmt.sober)・[`examples/for_callgen_expr.sober`](../../examples/for_callgen_expr.sober)
決定: [language.md 7 節](../language.md)

## 6.3 文形の for

R-6. 文の位置のブロック形 `for x <- xs if g { 本体 }` は消費。本体は呼び出し点に展開されるので、外の mut への代入・mut 引数の呼び出し・囲む関数からの `return` が書ける。`break` は生成元の展開ごと抜け、`continue` は次の要素へ進む（どちらも途中の defer を走らせる）。
例: [`examples/for_stmt.sober`](../../examples/for_stmt.sober)・[`examples/for_break.sober`](../../examples/for_break.sober)
決定: [language.md 7 節・8 節](../language.md)

R-7. 結果が `error?` の呼び出し形の生成元（`io.Chunks(f)`）は、印 `?` を付けて `for x <- g(a)? { … }` と回す — 生成元が失敗を返したら、生成元の defer を走らせてから `?` と同じく上へ伝える。包み替えは括弧で `for x <- (g(a)? L{…}) { … }`。印の無い形（error を黙って捨てる）・結果が `error?` 1 つでない生成元への印・yield 形の生成元は拒否する。捨てるなら `_ = g(a, (x) => { … })` と呼び出しで書く。
例: [`examples/for_fallible.sober`](../../examples/for_fallible.sober)
拒否: [`examples/for_fallible_unmarked.sober`](../../examples/for_fallible_unmarked.sober)・[`examples/for_fallible_result.sober`](../../examples/for_fallible_result.sober)・[`examples/for_fallible_yield.sober`](../../examples/for_fallible_yield.sober)
決定: [language.md 7 節](../language.md)

R-8. 展開される関数の中では、匿名の関数型の仮引数 `recv func(k func(T)) error?` も呼び出し形の生成元にできる（`for x <- recv()? { … }`）。印 `?` の規則は R-7 と同じ。名前つき関数型の仮引数は値の閉包で展開されないので生成元にならない。
例: [`examples/for_closure_gen.sober`](../../examples/for_closure_gen.sober)
拒否: [`examples/for_closure_gen_unmarked.sober`](../../examples/for_closure_gen_unmarked.sober)・[`examples/for_closure_gen_result.sober`](../../examples/for_closure_gen_result.sober)・[`examples/for_closure_gen_named.sober`](../../examples/for_closure_gen_named.sober)
決定: [language.md 7 節](../language.md)
