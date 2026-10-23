# 7. エラーと panic

日本語

[目次](README.ja.md)

実行時の失敗の受け皿は 3 つ — error（正しいプログラムでも入力次第で起きる失敗）・`T?`（不在が仕様の一部 — 2 章）・panic（正しいプログラムなら起きないこと）。この章は error の宣言・伝播・処理・網羅と、panic の範囲を扱う。

```sober
// examples/tour_05_errors.sober
package main

// Tour 5: errors — labels, ?, catch, switch (docs/guide/tour.md)

type Empty error

type BadDigit error {
    at int
}

func parse(s []byte) (int, error?) {
    if len(s) == 0 {
        return 0, Empty{}
    }
    mut n := 0
    mut i := 0
    while i < len(s) {
        c := int(s[i])
        if c < 48 || c > 57 {
            return 0, BadDigit{at: i}
        }
        n = n * 10 + c - 48
        i += 1
    }
    return n, nil
}

// ? returns an error to the caller as is
func sum2(a []byte, b []byte) (int, error?) {
    x := parse(a)?
    y := parse(b)?
    return x + y, nil
}

func main() int {
    // catch supplies a default value
    println(parse(bytes("42")) catch -1)
    println(parse(bytes("4x2")) catch -1)
    // handle each label with switch (the analyzer checks exhaustiveness)
    _, err := sum2(bytes("12"), bytes(""))
    if err != nil {
        switch err {
        case Empty{}: println("empty input")
        case BadDigit{at}: println("bad digit at ${at}")
        }
    }
    return 0
}
```

出力:

```
42
-1
empty input
```

## 7.1 どの受け皿を使うか

E-1. 失敗の受け皿は 1 つの規準で選ぶ —「正しいプログラムでも入力次第で起きるか」。起きる（ファイルが無い・構文が壊れている・UTF-8 が壊れている）なら error、不在そのものが仕様の一部なら `T?`（map の読み `m[k]` など）、起きない（起きたらコードの誤り — 範囲外の添字・ゼロ除算）なら panic。
例: [`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)・[`examples/panic_index.sober`](../../examples/panic_index.sober)
決定: [language.md 27 節](../language.md)

## 7.2 error 型とラベル

E-2. `error` は組み込みの開いた variant 型。各 package が `type L error { 欄… }`（欄なしは `type L error`）でラベルを足す。error の値はただの値で、束縛・引数・戻り値として持ち回せる。
例: [`examples/errval.sober`](../../examples/errval.sober)・[`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)
決定: [language.md 13 節](../language.md)

E-3. 失敗しうる関数は最後の結果を `error?` にする（`(T, error?)`・単値なら `error?`）。成功は `nil` を返す。結果を複数返す呼び出しは全部を束縛するか、`?` / `catch` で受ける — 値 1 つの束縛には置けない。
例: [`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)
拒否: [`examples/multibind.sober`](../../examples/multibind.sober)
決定: [language.md 2 節・13 節・15 節](../language.md)

E-4. ラベルは型として書けない（仮引数・欄・戻りの型にならない）。ラベルのリテラルの値は組み込みの `error` で、ラベルのリテラルで束縛した名前には別のラベルも入る。ラベルの区別は型パターン（E-12）で行う。
例: [`examples/errlabel_rebind.sober`](../../examples/errlabel_rebind.sober)
決定: [language.md 13 節・32 節](../language.md)

E-5. ラベルの欄は string・slice・map を持てる。関数の中で作った値を欄に載せて返しても、`?` で伝播しても、呼び手へ写る。
例: [`examples/errlabel.sober`](../../examples/errlabel.sober)
決定: [language.md 13 節](../language.md)

E-6. ラベルの名前は package のトップレベルの名前の中で一意（union の variant・他の宣言と重ならない）。
拒否: [`examples/variant_label_dup.sober`](../../examples/variant_label_dup.sober)
決定: [language.md 13 節](../language.md)

## 7.3 伝播 `?`

E-7. 後置の `f()?` は、最後の結果が `error?` の呼び出しに付ける。error が nil でなければ、行き先の関数からその error を返す（他の結果はゼロ値で埋める）。nil なら最後の成分を剥がした残りが値になる（0 個なら値なし・1 個ならその値・2 個以上なら多値）。行き先は `return` と同じで、ラムダの中の `?` はラムダを定義した関数へ向かう。行き先の最後の結果が `error?` でない関数の中では使えない。他の結果にゼロ値を持たない型（関数値・union・型パラメータ）があれば使えない。
例: [`examples/try_prop.sober`](../../examples/try_prop.sober)・[`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)
拒否: [`examples/errors_neg_try_dest.sober`](../../examples/errors_neg_try_dest.sober)
決定: [language.md 13 節](../language.md)

E-8. 包み替え `f()? L{欄…}` は、内側の error を捨てずに鎖に積み、L を先頭にして返す。L の欄はエラーの経路でだけ評価する。L は error ラベルに限る。暗黙の変換は無く、包み替える場所にラベルを書く。
例: [`examples/try_wrap.sober`](../../examples/try_wrap.sober)・[`examples/errcause.sober`](../../examples/errcause.sober)
決定: [language.md 13 節](../language.md)

E-9. 包み替えで積んだ内側の error は、型パターンの欄 `cause` で取り出す: `case L{…, cause}` の cause は 1 つ内側の `error?`。`cause` はリテラルに書けない（包み替えが埋める）。cause の入れ子のパターン `case W{cause: A{n}}` も書ける。
例: [`examples/errcause.sober`](../../examples/errcause.sober)・[`examples/errcause_nested.sober`](../../examples/errcause_nested.sober)
決定: [language.md 13 節](../language.md)

E-10. 関数値の呼び出しにも `?` を付けられる — 名前つき関数から束縛した imm の関数値と、結果に `error?` を持つ関数型の仮引数。
例: [`examples/try_fnvalue.sober`](../../examples/try_fnvalue.sober)・[`examples/fnval_err.sober`](../../examples/fnval_err.sober)
決定: [language.md 13 節・25 節](../language.md)

## 7.4 その場で落とす `catch`

E-11. `f() catch D` は、error なら D・そうでなければ値。D は単項式・`return …`・`panic(L{…})` のどれか（二項式は括弧で `catch (a + b)`）。`catch` は二項演算子より強く結合する（`f() catch -1 + 1` は `(f() catch -1) + 1`）。`return` と `panic` の腕は兄弟の型に合う。`catch nil` は値の型を `T?` にする。左辺は結果が `(T, error?)` の関数の直接呼び出しに限る。error の値は束縛しない（見たいときは E-12・E-13 の switch）。
例: [`examples/catch.sober`](../../examples/catch.sober)・[`examples/catch_arg_nil.sober`](../../examples/catch_arg_nil.sober)
拒否: [`examples/catch_infallible.sober`](../../examples/catch_infallible.sober)・[`examples/catch_infallible_pkg.sober`](../../examples/catch_infallible_pkg.sober)
決定: [language.md 13 節](../language.md)

## 7.5 switch で分ける

E-12. `error?` の単値の switch は `case nil:` の腕とラベルの型パターンの腕（`case L{欄}:`）で書く（nil の腕の規則は T-19）。error の値の欄は `.` で読めず、型パターンで取り出す。
例: [`examples/switch_nil.sober`](../../examples/switch_nil.sober)・[`examples/errval.sober`](../../examples/errval.sober)
決定: [language.md 13 節・15 節](../language.md)

E-13. `(T, error?)` の 2 位置の switch（`switch f() { … }` か `switch v, err { … }`）は `case v, nil:`・`case _, L{…}:`・`case _, e:` の腕で書く。エラーの腕の値のパターンは `_`。nil の腕は `_`・束縛の腕より前に置く。`case _, e:` があるときは nil の腕が値を全部覆う。nil でない error の行き先（エラーの腕か default）が要る。default は nil の腕が値を全部覆うときだけ書ける。
例: [`examples/switch_multi_nil.sober`](../../examples/switch_multi_nil.sober)
拒否: [`examples/switch_multi_nil_order.sober`](../../examples/switch_multi_nil_order.sober)・[`examples/switch_multi_nil_value.sober`](../../examples/switch_multi_nil_value.sober)・[`examples/switch_multi_nil_cover.sober`](../../examples/switch_multi_nil_cover.sober)・[`examples/switch_multi_nil_default.sober`](../../examples/switch_multi_nil_default.sober)・[`examples/switch_multi_nil_noerr.sober`](../../examples/switch_multi_nil_noerr.sober)
決定: [language.md 13 節](../language.md)

E-14. error の switch の網羅の対象は、subject が持ちうるラベルの集合（analyzer が導出する — package の中は return の経路から・package をまたぐ呼び先は `@errors` の宣言から）。集合を覆えば default は要らない。覆っていなければ、覆っていないラベルを名指して拒否する。集合を導出できない subject（関数値の呼び出し・要素の読みなど）には default が要る。subject が持ちえないラベルの腕と、集合を覆った上での default は到達しないので拒否する（`@exhaustive` の関数の中の例外は A-8）。
例: [`examples/errors_derived.sober`](../../examples/errors_derived.sober)・[`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)
拒否: [`examples/errors_neg_nonexh.sober`](../../examples/errors_neg_nonexh.sober)・[`examples/errors_neg_unreach.sober`](../../examples/errors_neg_unreach.sober)
決定: [language.md 13 節](../language.md)

```sober
// examples/errors_neg_nonexh.sober
package main

// 負例（check が拒否 — analyzer）: error の switch が、subject が持ちうるラベル（Empty と TooLong）を覆わず default も無い（language.md 13 節）。
// build は analyzer を走らせないので受理し、覆っていないラベルが来たら exit 101

type Empty error

type TooLong error {
    n int
}

func parse(s string) (int, error?) {
    n := len(bytes(s))
    if n == 0 {
        return 0, Empty{}
    }
    if n > 8 {
        return 0, TooLong{n: n}
    }
    return n, nil
}

func main() {
    _, err := parse("")
    if err != nil {
        switch err {
        case Empty{}: println("empty")
        }
    }
}
```

拒否:

```
examples/errors_neg_nonexh.sober:26:9: error: switch does not cover TooLong (error labels the subject may carry): add cases or a default (Analyzer)
```

E-15. 網羅と到達の検査は `sober check` が行う。`sober build` は analyzer を走らせないので、網羅していない error の switch も通し、覆っていないラベルが来たら panic（終了コード 101）になる。
例: [`examples/errors_derived.sober`](../../examples/errors_derived.sober)
拒否: [`examples/errors_neg_nonexh.sober`](../../examples/errors_neg_nonexh.sober)
決定: [language.md 13 節](../language.md)

## 7.6 `@errors` の宣言

E-16. error を返す公開関数（名前が大文字で始まる関数）は `@errors(L1, L2, …)` で返しうるラベルを宣言する。項はラベルの名前（`L` か `pkg.L`）の正の列挙。宣言は analyzer の導出と照合する: 導出が宣言に含まれなければ拒否（漏れ）・公開関数で宣言が導出より広ければ拒否（余分）。内部の関数の `@errors` は任意で、書けば上界として照合する。package をまたぐ呼び出しは、呼び先の宣言を読む。
例: [`examples/errval.sober`](../../examples/errval.sober)・[`examples/errors_param.sober`](../../examples/errors_param.sober)
拒否: [`examples/errors_neg_undeclared.sober`](../../examples/errors_neg_undeclared.sober)・[`examples/errors_neg_leak.sober`](../../examples/errors_neg_leak.sober)・[`examples/errors_neg_stale.sober`](../../examples/errors_neg_stale.sober)
決定: [language.md 13 節](../language.md)

E-17. 匿名の関数型の仮引数 r（結果に `error?` を持つ）を呼ぶ関数は、`@errors` に仮引数の名前を書ける: `@errors(Bad, recv, send)` は「Bad と、recv / send に渡したものが返すもの」。呼び手から見た集合は、呼び出し点ごとに、その点で r に渡した実引数のラベルを代入したもの。包み替え（E-8）で返した r の失敗は漏れに数えない。
例: [`examples/errors_param.sober`](../../examples/errors_param.sober)
決定: [language.md 13 節](../language.md)

E-23. 名前付き関数型は結果の後に `@errors(…)` を書ける（`type F func(x int) error? @errors(Bad, emit)` — 型宣言の前に置く `@errors` は文法の外）。項は宣言の package のラベルと、F の仮引数のうち匿名の関数型で結果に `error?` を持つものの名前。宣言は F の値の失敗の上界: F の値を通した呼び出しの集合は、宣言のラベルと、仮引数の名前の項の位置に渡した実引数のラベル。F の値になるラムダの本体が宣言の外のラベル・宣言に書いていない仮引数の失敗を返しうるなら、そのラムダの位置で拒否する。宣言が導出より広くても拒否しない。`@errors` の無い F の値を通した呼び出しのラベルは導出できない（公開関数の `@errors` の照合と switch の網羅は default を求める）。
例: [`examples/fntype_errors.sober`](../../examples/fntype_errors.sober)・[`examples/fntype_errors_flow.sober`](../../examples/fntype_errors_flow.sober)
拒否: [`examples/fntype_errors_neg_leak.sober`](../../examples/fntype_errors_neg_leak.sober)・[`examples/fntype_errors_neg_flow.sober`](../../examples/fntype_errors_neg_flow.sober)・[`examples/fntype_errors_neg_label.sober`](../../examples/fntype_errors_neg_label.sober)・[`examples/fntype_errors_neg_prefix.sober`](../../examples/fntype_errors_neg_prefix.sober)
決定: [language.md 13 節](../language.md)

## 7.7 panic

E-18. panic は 2 種類だけ — ① 健全性の防衛（続けると言語の保証が破れるもの — 資源の上限〔region の深さ・容量の溢れ〕は終了コード 102）と、② 到達 = プログラムの誤り（範囲外の添字・ゼロ除算・負のシフト量・`byte(n)` / `int(f)` の範囲外・明示の `panic(L{…})`・main の戻り値の範囲外）— 終了コード 101。panic の前に出した出力は失われない。
例: [`examples/panic_div.sober`](../../examples/panic_div.sober)・[`examples/panic_index.sober`](../../examples/panic_index.sober)・[`examples/panic_depth.sober`](../../examples/panic_depth.sober)
決定: [language.md 27 節](../language.md)

E-19. panic のラベルは `type L panic { 欄… }`（欄なしは `type L panic`）で宣言する。欄の型は int・byte・bool・string だけ。組み込みのラベル `Unreachable`・`InvariantBroken` は import なしで使える。組み込みと同じ名前のラベルは宣言できない。`RegionExceeded` はランタイムだけが上げる。
例: [`examples/panic_label.sober`](../../examples/panic_label.sober)・[`examples/panic_builtin.sober`](../../examples/panic_builtin.sober)
拒否: [`examples/panic_neg_fieldty.sober`](../../examples/panic_neg_fieldty.sober)・[`examples/panic_neg_builtin.sober`](../../examples/panic_neg_builtin.sober)・[`examples/panic_neg_runtime.sober`](../../examples/panic_neg_runtime.sober)
決定: [language.md 27 節](../language.md)

E-20. panic は `panic(L{欄: 値, …})` の形だけで書く — 実引数はラベルのリテラル 1 つ（欄は名前つきで 1 回ずつ・省いた欄はゼロ値）。理由の無い `panic()` は無い。panic のラベルは値として使えない（束縛・仮引数・欄・戻りの型にならず、`@errors`・`?`・switch の対象でもない）。欄の値を書いた順に評価してから死ぬ。`panic(…)` の値の型は兄弟に合う（腕・`return panic(…)`・`catch panic(…)`）。
例: [`examples/panic_builtin.sober`](../../examples/panic_builtin.sober)・[`examples/panic_partial.sober`](../../examples/panic_partial.sober)
拒否: [`examples/panic_neg_bare.sober`](../../examples/panic_neg_bare.sober)・[`examples/panic_neg_arg.sober`](../../examples/panic_neg_arg.sober)・[`examples/panic_neg_fields.sober`](../../examples/panic_neg_fields.sober)・[`examples/panic_neg_notlabel.sober`](../../examples/panic_neg_notlabel.sober)・[`examples/panic_neg_use.sober`](../../examples/panic_neg_use.sober)
決定: [language.md 27 節](../language.md)

E-21. 死ぬとき標準エラーに 1 行を書く: `panic: L{欄: 値, …} at ファイル:行:桁`。欄は宣言の順・string は二重引用符で囲み `"` `\` 改行をエスケープする。組み込みと main package のラベルは修飾なし・他の package のラベルは package 名で修飾する。
例: [`examples/panic_label.sober`](../../examples/panic_label.sober)・[`examples/panic_partial.sober`](../../examples/panic_partial.sober)
決定: [language.md 27 節](../language.md)

## 7.8 終了コード

E-22. `func main() int` の戻り値が終了コード（`func main()` は 0）。0〜255 の外は panic（終了コード 101）。`os.Exit` は無い — 深い位置からの終了は error と `?` で main まで戻して返す。main の出口でも defer は評価する。
例: [`examples/exit_code.sober`](../../examples/exit_code.sober)・[`examples/exit_range.sober`](../../examples/exit_range.sober)
決定: [language.md 27 節](../language.md)
