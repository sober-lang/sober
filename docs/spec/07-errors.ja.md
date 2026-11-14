# 7. エラーとpanic

日本語

[目次](README.ja.md)

実行時の失敗の受け皿は3つ — error（正しいプログラムでも入力次第で起きる失敗）・`T?`（不在が仕様の一部 — 2章）・panic（正しいプログラムなら起きないこと）。この章はerrorの宣言・伝播・処理・網羅と、panicの範囲を扱う。

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

E-1. 失敗の受け皿は1つの規準で選ぶ —「正しいプログラムでも入力次第で起きるか」。起きる（ファイルが無い・構文が壊れている・UTF-8が壊れている）ならerror、不在そのものが仕様の一部なら `T?`（mapの読み `m[k]` など）、起きない（起きたらコードの誤り — 範囲外の添字・ゼロ除算）ならpanic。
例: [`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)・[`examples/panic_index.sober`](../../examples/panic_index.sober)
決定: [language.md 27節](../language.md)

## 7.2 error型とラベル

E-2. `error` は組み込みの開いたvariant型。各packageが `type L error { フィールド… }`（フィールドなしは `type L error`）でラベルを足す。errorの値はただの値で、束縛・引数・戻り値として持ち回せる。
例: [`examples/errval.sober`](../../examples/errval.sober)・[`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)
決定: [language.md 13節](../language.md)

E-3. 失敗しうる関数は最後の結果を `error?` にする（`(T, error?)`・単値なら `error?`）。成功は `nil` を返す。結果を複数返す呼び出しは全部を束縛するか、`?` / `catch` で受ける — 値1つの束縛には置けない。
例: [`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)
拒否: [`examples/multibind.sober`](../../examples/multibind.sober)
決定: [language.md 2節・13節・15節](../language.md)

E-4. ラベルは型として書けない（仮引数・フィールド・戻りの型にならない）。ラベルのリテラルの値は組み込みの `error` で、ラベルのリテラルで束縛した名前には別のラベルも入る。ラベルの区別は型パターン（E-12）で行う。
例: [`examples/errlabel_rebind.sober`](../../examples/errlabel_rebind.sober)
決定: [language.md 13節・32節](../language.md)

E-5. ラベルのフィールドはstring・slice・mapを持てる。関数の中で作った値をフィールドに載せて返しても、`?` で伝播しても、呼び手へコピーされる。
例: [`examples/errlabel.sober`](../../examples/errlabel.sober)
決定: [language.md 13節](../language.md)

E-6. ラベルの名前はpackageのトップレベルの名前の中で一意（unionのvariant・他の宣言と重ならない）。
拒否: [`examples/variant_label_dup.sober`](../../examples/variant_label_dup.sober)
決定: [language.md 13節](../language.md)

## 7.3 伝播 `?`

E-7. 後置の `f()?` は、最後の結果が `error?` の呼び出しに付ける。errorがnilでなければ、行き先の関数からそのerrorを返す（他の結果はゼロ値で埋める）。nilなら最後の成分を剥がした残りが値になる（0個なら値なし・1個ならその値・2個以上なら多値）。行き先は `return` と同じで、ラムダの中の `?` はラムダを定義した関数へ向かう。行き先の最後の結果が `error?` でない関数の中では使えない。他の結果にゼロ値を持たない型（関数値・union・型パラメータ）があれば使えない。
例: [`examples/try_prop.sober`](../../examples/try_prop.sober)・[`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)
拒否: [`examples/errors_neg_try_dest.sober`](../../examples/errors_neg_try_dest.sober)
決定: [language.md 13節](../language.md)

E-8. 包み替え `f()? L{フィールド…}` は、内側のerrorを捨てずにチェーンに積み、Lを先頭にして返す。Lのフィールドはエラーの経路でだけ評価する。Lはerrorラベルに限る。暗黙の変換は無く、包み替える場所にラベルを書く。
例: [`examples/try_wrap.sober`](../../examples/try_wrap.sober)・[`examples/errcause.sober`](../../examples/errcause.sober)
決定: [language.md 13節](../language.md)

E-9. 包み替えで積んだ内側のerrorは、型パターンのフィールド `cause` で取り出す: `case L{…, cause}` のcauseは1つ内側の `error?`。`cause` はリテラルに書けない（包み替えが埋める）。causeの入れ子のパターン `case W{cause: A{n}}` も書ける。
例: [`examples/errcause.sober`](../../examples/errcause.sober)・[`examples/errcause_nested.sober`](../../examples/errcause_nested.sober)
決定: [language.md 13節](../language.md)

E-10. 関数値の呼び出しにも `?` を付けられる — 名前つき関数から束縛したimmの関数値と、結果に `error?` を持つ関数型の仮引数。
例: [`examples/try_fnvalue.sober`](../../examples/try_fnvalue.sober)・[`examples/fnval_err.sober`](../../examples/fnval_err.sober)
決定: [language.md 13節・25節](../language.md)

## 7.4 その場で落とす `catch`

E-11. `f() catch D` は、errorならD・そうでなければ値。Dは単項式・`return …`・`panic(L{…})` のどれか（二項式は括弧で `catch (a + b)`）。`catch` は二項演算子より強く結合する（`f() catch -1 + 1` は `(f() catch -1) + 1`）。`return` と `panic` の分岐は兄弟の型に合う。`catch nil` は値の型を `T?` にする。左辺は結果が `(T, error?)` の関数の直接呼び出しに限る。errorの値は束縛しない（見たいときはE-12・E-13のswitch）。
例: [`examples/catch.sober`](../../examples/catch.sober)・[`examples/catch_arg_nil.sober`](../../examples/catch_arg_nil.sober)
拒否: [`examples/catch_infallible.sober`](../../examples/catch_infallible.sober)・[`examples/catch_infallible_pkg.sober`](../../examples/catch_infallible_pkg.sober)
決定: [language.md 13節](../language.md)

## 7.5 switchで分ける

E-12. `error?` の単値のswitchは `case nil:` の分岐とラベルの型パターンの分岐（`case L{フィールド}:`）で書く（nilの分岐の規則はT-19）。errorの値のフィールドは `.` で読めず、型パターンで取り出す。
例: [`examples/switch_nil.sober`](../../examples/switch_nil.sober)・[`examples/errval.sober`](../../examples/errval.sober)
決定: [language.md 13節・15節](../language.md)

E-13. `(T, error?)` の2位置のswitch（`switch f() { … }` か `switch v, err { … }`）は `case v, nil:`・`case _, L{…}:`・`case _, e:` の分岐で書く。エラーの分岐の値のパターンは `_`。nilの分岐は `_`・束縛の分岐より前に置く。`case _, e:` があるときはnilの分岐が値を全部覆う。nilでないerrorの行き先（エラーの分岐かdefault）が要る。defaultはnilの分岐が値を全部覆うときだけ書ける。
例: [`examples/switch_multi_nil.sober`](../../examples/switch_multi_nil.sober)
拒否: [`examples/switch_multi_nil_order.sober`](../../examples/switch_multi_nil_order.sober)・[`examples/switch_multi_nil_value.sober`](../../examples/switch_multi_nil_value.sober)・[`examples/switch_multi_nil_cover.sober`](../../examples/switch_multi_nil_cover.sober)・[`examples/switch_multi_nil_default.sober`](../../examples/switch_multi_nil_default.sober)・[`examples/switch_multi_nil_noerr.sober`](../../examples/switch_multi_nil_noerr.sober)
決定: [language.md 13節](../language.md)

E-14. errorのswitchの網羅の対象は、subjectが持ちうるラベルの集合（analyzerが導出する — packageの中はreturnの経路から・packageをまたぐ呼び先は `@errors` の宣言から）。集合を覆えばdefaultは要らない。覆っていなければ、覆っていないラベルを列挙して拒否する。集合を導出できないsubject（関数値の呼び出し・要素の読みなど）にはdefaultが要る。subjectが持ちえないラベルの分岐と、集合を覆った上でのdefaultは到達しないので拒否する（`@exhaustive` の関数の中の例外はA-8）。
例: [`examples/errors_derived.sober`](../../examples/errors_derived.sober)・[`examples/tour_05_errors.sober`](../../examples/tour_05_errors.sober)
拒否: [`examples/errors_neg_nonexh.sober`](../../examples/errors_neg_nonexh.sober)・[`examples/errors_neg_unreach.sober`](../../examples/errors_neg_unreach.sober)
決定: [language.md 13節](../language.md)

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

E-15. 網羅と到達の検査は `sober check` が行う。`sober build` はanalyzerを走らせないので、網羅していないerrorのswitchも通し、覆っていないラベルが来たらpanic（終了コード101）になる。
例: [`examples/errors_derived.sober`](../../examples/errors_derived.sober)
拒否: [`examples/errors_neg_nonexh.sober`](../../examples/errors_neg_nonexh.sober)
決定: [language.md 13節](../language.md)

## 7.6 `@errors` の宣言

E-16. errorを返す公開関数（名前が大文字で始まる関数）は `@errors(L1, L2, …)` で返しうるラベルを宣言する。項はラベルの名前（`L` か `pkg.L`）の正の列挙。宣言はanalyzerの導出と照合する: 導出が宣言に含まれなければ拒否（漏れ）・公開関数で宣言が導出より広ければ拒否（余分）。内部の関数の `@errors` は任意で、書けば上界として照合する。packageをまたぐ呼び出しは、呼び先の宣言を読む。
例: [`examples/errval.sober`](../../examples/errval.sober)・[`examples/errors_param.sober`](../../examples/errors_param.sober)
拒否: [`examples/errors_neg_undeclared.sober`](../../examples/errors_neg_undeclared.sober)・[`examples/errors_neg_leak.sober`](../../examples/errors_neg_leak.sober)・[`examples/errors_neg_stale.sober`](../../examples/errors_neg_stale.sober)
決定: [language.md 13節](../language.md)

E-17. 匿名の関数型の仮引数r（結果に `error?` を持つ）を呼ぶ関数は、`@errors` に仮引数の名前を書ける: `@errors(Bad, recv, send)` は「Badと、recv / sendに渡したものが返すもの」。呼び手から見た集合は、呼び出し点ごとに、その点でrに渡した実引数のラベルを代入したもの。包み替え（E-8）で返したrの失敗は漏れに数えない。省略可の匿名関数型 `(func(…) error?)?` の仮引数（5章F-22）も項になれ、rを渡さない呼び出し点ではrの項は空。省略可の匿名関数型の仮引数を持つ関数の宣言は、漏れだけを照合する（E-16の「宣言が導出より広ければ拒否」は掛けない）。
例: [`examples/errors_param.sober`](../../examples/errors_param.sober)・[`examples/optfn_errors.sober`](../../examples/optfn_errors.sober)
決定: [language.md 13節](../language.md)

E-23. 名前付き関数型は結果の後に `@errors(…)` を書ける（`type F func(x int) error? @errors(Bad, emit)` — 型宣言の前に置く `@errors` は文法の外）。項は宣言のpackageのラベルと、Fの仮引数のうち匿名の関数型で結果に `error?` を持つものの名前。宣言はFの値の失敗の上界: Fの値を通した呼び出しの集合は、宣言のラベルと、仮引数の名前の項の位置に渡した実引数のラベル。Fの値になるラムダの本体が宣言の外のラベル・宣言に書いていない仮引数の失敗を返しうるなら、そのラムダの位置で拒否する。宣言が導出より広くても拒否しない。`@errors` の無いFの値を通した呼び出しのラベルは導出できない（公開関数の `@errors` の照合とswitchの網羅はdefaultを求める）。
例: [`examples/fntype_errors.sober`](../../examples/fntype_errors.sober)・[`examples/fntype_errors_flow.sober`](../../examples/fntype_errors_flow.sober)
拒否: [`examples/fntype_errors_neg_leak.sober`](../../examples/fntype_errors_neg_leak.sober)・[`examples/fntype_errors_neg_flow.sober`](../../examples/fntype_errors_neg_flow.sober)・[`examples/fntype_errors_neg_label.sober`](../../examples/fntype_errors_neg_label.sober)・[`examples/fntype_errors_neg_prefix.sober`](../../examples/fntype_errors_neg_prefix.sober)
決定: [language.md 13節](../language.md)

## 7.7 panic

E-18. panicは2種類だけ — ① 健全性の防衛（続けると言語の保証が破れるもの — 資源の上限〔regionの深さ・容量の溢れ〕は終了コード102）と、② 到達 = プログラムの誤り（範囲外の添字・ゼロ除算・負のシフト量・`byte(n)` / `int(f)` の範囲外・明示の `panic(L{…})`・mainの戻り値の範囲外）— 終了コード101。panicの前に出した出力は失われない。
例: [`examples/panic_div.sober`](../../examples/panic_div.sober)・[`examples/panic_index.sober`](../../examples/panic_index.sober)・[`examples/panic_depth.sober`](../../examples/panic_depth.sober)
決定: [language.md 27節](../language.md)

E-19. panicのラベルは `type L panic { フィールド… }`（フィールドなしは `type L panic`）で宣言する。フィールドの型はint・byte・bool・stringだけ。組み込みのラベル `Unreachable`・`InvariantBroken` はimportなしで使える。組み込みと同じ名前のラベルは宣言できない。`RegionExceeded` はランタイムだけが上げる。
例: [`examples/panic_label.sober`](../../examples/panic_label.sober)・[`examples/panic_builtin.sober`](../../examples/panic_builtin.sober)
拒否: [`examples/panic_neg_fieldty.sober`](../../examples/panic_neg_fieldty.sober)・[`examples/panic_neg_builtin.sober`](../../examples/panic_neg_builtin.sober)・[`examples/panic_neg_runtime.sober`](../../examples/panic_neg_runtime.sober)
決定: [language.md 27節](../language.md)

E-20. panicは `panic(L{フィールド: 値, …})` の形だけで書く — 実引数はラベルのリテラル1つ（フィールドは名前つきで1回ずつ・省いたフィールドはゼロ値）。理由の無い `panic()` は無い。panicのラベルは値として使えない（束縛・仮引数・フィールド・戻りの型にならず、`@errors`・`?`・switchの対象でもない）。フィールドの値を書いた順に評価してから死ぬ。`panic(…)` の値の型は兄弟に合う（分岐・`return panic(…)`・`catch panic(…)`）。
例: [`examples/panic_builtin.sober`](../../examples/panic_builtin.sober)・[`examples/panic_partial.sober`](../../examples/panic_partial.sober)
拒否: [`examples/panic_neg_bare.sober`](../../examples/panic_neg_bare.sober)・[`examples/panic_neg_arg.sober`](../../examples/panic_neg_arg.sober)・[`examples/panic_neg_fields.sober`](../../examples/panic_neg_fields.sober)・[`examples/panic_neg_notlabel.sober`](../../examples/panic_neg_notlabel.sober)・[`examples/panic_neg_use.sober`](../../examples/panic_neg_use.sober)
決定: [language.md 27節](../language.md)

E-21. 死ぬとき標準エラーに1行を書く: `panic: L{フィールド: 値, …} at ファイル:行:桁`。フィールドは宣言の順・stringは二重引用符で囲み `"` `\` 改行をエスケープする。組み込みとmain packageのラベルは修飾なし・他のpackageのラベルはpackage名で修飾する。
例: [`examples/panic_label.sober`](../../examples/panic_label.sober)・[`examples/panic_partial.sober`](../../examples/panic_partial.sober)
決定: [language.md 27節](../language.md)

## 7.8 終了コード

E-22. `func main() int` の戻り値が終了コード（`func main()` は0）。0〜255の外はpanic（終了コード101）。`os.Exit` は無い — 深い位置からの終了はerrorと `?` でmainまで戻して返す。mainの出口でもdeferは評価する。
例: [`examples/exit_code.sober`](../../examples/exit_code.sober)・[`examples/exit_range.sober`](../../examples/exit_range.sober)
決定: [language.md 27節](../language.md)
