# 言語ツアー

[English](tour.md) | 日本語

Go か Rust を書ける人向けに、Sober の言語を短い動く例で一周します。各節の例は `examples/` の実物で、検査の網が毎回建てて走らせ、出力を照合しています（`sober build examples/<名前>.sober -o a && ./a` で同じ結果になります）。

各節の終わりの「Go との違い」は、Go から来た人が最初につまずく点だけを 1〜2 行で書いています。

## 1. 値と束縛・式

```sober
// examples/tour_01_values.sober
package main

// Tour 1: values, bindings, expressions (docs/guide/tour.md)

func sign(n int) string {
    // if is an expression — it returns a value
    return if n < 0 { "negative" } else if n == 0 { "zero" } else { "positive" }
}

func size(n int) string {
    // so is switch
    return switch {
    case n < 10: "small"
    case n < 1000: "medium"
    default: "large"
    }
}

func main() int {
    x := 40                // bindings are immutable by default
    mut total := 0         // mut for a binding that changes
    total += x
    total += 2
    // a block has a value too (its last expression)
    y := {
        t := total * 2
        t + 1
    }
    println("total = ${total}, y = ${y}")
    println(sign(0 - 3), sign(0), sign(7))
    println(size(5), size(500), size(50000))
    return 0
}
```

出力:

```
total = 42, y = 85
negative zero positive
small medium large
```

- 束縛は既定で不変です。変える束縛にだけ `mut` を付けます。同じ名前で別の束縛を作り直す（シャドーイング）ことはできません。
- if・switch・ブロックは値を持ちます（最後の式が値）。値を選ぶための一時的な `mut` が要りません。
- `switch` は条件の並び（`switch { case … }`）にも、値の分岐（`switch x { … }`）にも使えます。

Go との違い: `var x T; if c { x = a } else { x = b }` と書く場面は `x := if c { a } else { b }` になります。三項演算子はありません（if がその役です）。

## 2. 関数・多値・ラムダ・パイプ

```sober
// examples/tour_02_functions.sober
package main

// Tour 2: functions, multiple results, lambdas, pipes (docs/guide/tour.md)

// returns two results
func divmod(a int, b int) (int, int) {
    return a / b, a % b
}

func add(a int, b int) int {
    return a + b
}

func twice(f func(int) int, x int) int {
    return f(f(x))
}

func main() int {
    q, r := divmod(17, 5)
    println("17 = 5 * ${q} + ${r}")
    // multiple results flow through a pipe into the next call (_ is a hole)
    s := divmod(17, 5) |> add(_, _)
    println(s)
    // a pipe feeds the first argument by default
    n := 3 |> add(10)
    println(n)
    // a lambda
    println(twice((v) => v * 3, 2))
    return 0
}
```

出力:

```
17 = 5 * 3 + 2
5
13
18
```

- 多値は Go と同じく結果を複数返す形です。受けるのは分解（`q, r := …`）か、パイプの先の引数（`|> add(_, _)`）だけで、組として変数に入れることはしません。
- `x |> f(a)` は `f(x, a)`。入れる位置を変えたいときは穴 `_` を書きます。
- ラムダ `(v) => v * 3` は関数の値です。関数の型は `func(int) int`。

Go との違い: メソッドはありません。`x.f(a)` の代わりに `x |> f(a)` と書きます。

## 3. slice・map・for

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

- slice は `mut` で組み立てて `freeze` で不変にするのが基本の流れです。`freeze` した値は、並列の task にもそのまま渡せます。
- `for … yield` は遅延の生産者（`Iter`）を作ります。消費はパイプの先（`|> iter.Sum` など）で行い、変数には入れません。
- map の引きは `T?` です。無ければ `nil` で、`!= nil` で確かめてから値として使います。

Go との違い: map の引きの「ゼロ値が返る」はありません — 無いことは `nil` で表されます。

## 4. struct・union・ジェネリクス・辞書

```sober
// examples/tour_04_types.sober
package main

// Tour 4: structs, unions, generics, dictionaries (docs/guide/tour.md)

type Point struct {
    x, y int
}

// A union (sum type) — take it apart with an exhaustive switch
type Shape union {
    Rect { w, h int }
    Circle { r int }
}

func area(s Shape) int {
    return switch s {
    case Rect{w, h}: w * h
    case Circle{r}: 3 * r * r
    }
}

// Instead of methods: pass a struct of function values (a dictionary) explicitly
type Ord[T] struct {
    less func(T, T) bool
}

func min[T](a T, b T, ord Ord[T]) T {
    return if ord.less(b, a) { b } else { a }
}

const ByX = Ord[Point]{less: (a, b) => a.x < b.x}

func main() int {
    p := Point{x: 3, y: 4}
    q := Point{x: 1, y: 9}
    println(p.x + p.y)
    println(area(Rect{w: 2, h: 5}), area(Circle{r: 2}))
    m := min(p, q, ByX)
    println(m.x, m.y)
    return 0
}
```

出力:

```
7
10 12
1 9
```

- union（和型）は名前つきの variant の集まりです。`switch` で取り出し、variant の漏れはコンパイルエラーになります。
- ジェネリクス `min[T](…)` の型引数は、ふつうは実引数から推論されます。
- interface の代わりに、関数値を欄に持つ struct（辞書）を明示で渡します。暗黙の実装の解決はありません — どの実装が使われるかは呼び出しの場所に書いてあります。

Go との違い: `interface` も暗黙の満足もありません。`sort.Interface` を満たす型を作る代わりに `Ord[T]{less: …}` を渡します。

## 5. エラー — ラベル・`?`・`catch`・switch

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

- エラーはラベル（`type Empty error`・欄つきの `type BadDigit error { at int }`）で、関数は `(T, error?)` で返します。
- `f()?` はエラーならそのまま呼び手へ返します。`f() catch D` はエラーなら既定値 `D` にします（`catch return 1` のように抜けることもできます）。
- `switch err` でラベルごとに扱えます。どのラベルが返りうるかは解析器が呼び出しのグラフから導いていて、扱い漏れは拒否されます（公開の関数は返しうるラベルを宣言します）。

Go との違い: `if err != nil { return err }` の多くが `?` 1 文字になります。`errors.Is` / `errors.As` の代わりに `switch err` で網羅します。

## 6. mut 引数と freeze

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

- 呼び手の変数を書き換える関数は、仮引数に `mut` と書き、呼び出しの場所でも `f(mut x)` と書きます。どこで何が書き換わるかがソースに見えます。
- ポインタはありません。寿命の注釈も借用の規則もありません — 書き換えは `mut` の印のある場所だけで起き、共有するときは `freeze` した不変の値を渡します。
- `freeze` できるのは、他に別名の無い値だけです（`mut a := xs` のように同じ中身を別の名前でも持っていると拒否されます）。`freeze` した後は、元の変数から書き換えることも `mut` で渡すこともできません。コンパイラが確かめるので、凍結した値は変わりません。
- 不変の値を受ける場所（不変の仮引数・`return`・不変の欄など）に mut の変数をそのまま書くと、そこで `freeze` されます（7 節の `task.Map(ns, …)` の `ns`）。その後の規則は `freeze` と同じです — 書き終えてから渡すか、写し（`clone(xs)` — 浅い写しを mut で返す）を渡します。束縛 `ys := xs` では凍りません（`ys` も同じ中身の mut）。不変の写しを束縛に取るときは `ys := freeze(xs)` と書きます。

Go との違い: `*T` と `&x` の代わりに `mut` の引数を使います。値の意味は Go と同じ「ただの値」です。

## 7. 並列 — structured concurrency・チャネル

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

- `task.Map` は要素ごとに task を作り、結果は入力の順で返ります。
- `task.Run` の中で `task.Spawn` した子は、scope の終わりまでに必ず合流します（置き去りの goroutine はありません）。
- 子に渡せるのは不変の値かチャネルだけです。データ競合は書けません。
- 出力は決定的です: ワーカー数（`SOBER_WORKERS`）を変えても、標準出力は同じバイトになります。
- チャネルは `task.NewChannel` で作り、送り端を `give:` で子に渡します。`for v <- task.Recv(rx)` は閉じるまで受けます。

Go との違い: `go f()` と `sync.WaitGroup` の代わりに `task.Run` + `task.Spawn` + `task.Join` を使います。`GOMAXPROCS` を変えても出力の順は変わりません。

## 8. テスト

package の中の `*_test.sober` の `func TestXxx()` がテストです。`sober test <package>` が 1 テスト 1 プロセスで走らせます。書き方は [最初のプログラム](first-program.ja.md#テストを書く) を見てください。

## この先

- 標準ライブラリの地図: [標準ライブラリの案内](std.ja.md)
- なぜこういう形なのか: [設計ノート](../design-notes/)
- 正確な定義: [言語仕様](../spec/README.ja.md)・[構文](../syntax.md)（決定の経緯は [決定の記録](../language.md) — 開発者向け）
