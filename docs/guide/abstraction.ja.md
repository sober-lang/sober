# 抽象化 — interface の代わりに

[English](abstraction.md) | 日本語

Sober には interface もクラスもメソッドもありません。振る舞いの差し替えは、関数の差し替えです。それ以上の機構はありません。

このページは、他の言語で interface（や trait・型クラス・抽象クラス）を使って書いていたことを、Sober でどう書くかの案内です。形は 3 つだけです。

| やりたいこと | Sober の形 | 節 |
| --- | --- | --- |
| 関数 1 つを差し替える | 名前付き関数型 + クロージャ | 1 |
| 関数をいくつか組で差し替える | 関数の欄を持つ struct（辞書） | 2 |
| 決まった種類のどれか、で場合分けする | union + 型パターンの switch | 3 |

前提: [言語ツアー](tour.ja.md) の 2 節（ラムダ）と 4 節（struct・union・辞書）。

## 1. 関数 1 つ — 名前付き関数型とクロージャ

std/http のハンドラは interface ではなく、名前付きの関数型です。

```sober
type Handler func(r Request) Response
```

ハンドラを差し替えたければ、別の関数を渡します。状態が要るときは、その状態をクロージャが捕まえます。捕まえた値は、クロージャを作った行に書いてあります。

```sober
// examples/abstraction_handler.sober
package main

// Abstraction 1 and 2: a named function type (http.Handler) built by closures, and a struct of
// function fields (http.Middleware) (docs/guide/abstraction.md). The requests are fed from a string
// instead of the network, and each response is printed (the form of examples/http_router)

import "std/http"

func or(s string?) string {
    return if s != nil { s } else { "-" }
}

// stops a request without X-Token (only `before` is given; `after` is left out)
const Auth = http.Middleware{before: (r) => if http.Header(r, "x-token") == nil { http.Status(401) } else { nil }}

// a Handler that answers with `word`: the closure captures `word` on this line
func greeter(word string) http.Handler {
    return (r) => http.Text("${word}, ${or(http.Param(r, "name"))}\n")
}

func routes() []http.Route {
    return http.Mount("", []http.Route{
        http.Route{method: "GET", path: "/hello/:name", handler: greeter("hello")},
        http.Route{method: "GET", path: "/bye/:name", handler: greeter("see you")}}, []http.Middleware{Auth})
}

func main() {
    reqs := "GET /hello/ann HTTP/1.1\r\nX-Token: t\r\n\r\n" +
        "GET /bye/bob HTTP/1.1\r\nX-Token: t\r\n\r\n" +
        "GET /hello/eve HTTP/1.1\r\nConnection: close\r\n\r\n"
    rs := routes()
    e := http.ServeWith((k) => feed(reqs, k), (b) => show(b), (r) => http.Dispatch(rs, r))
    println(e == nil)
}

func feed(s string, k func([]byte)) error? {
    k(bytes(s))
    return nil
}

// prints a response without the CR at the end of each line
func show(b []byte) error? {
    mut out := mut []byte{}
    for x <- b {
        if x != '\r' {
            out = append(out, x)
        }
    }
    println(string(freeze(out)) catch "?")
    return nil
}
```

出力:

```
HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 11

hello, ann
HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 13

see you, bob
HTTP/1.1 401 Unauthorized
Cache-Control: private
Content-Length: 0
Connection: close


true
```

- `greeter` は `http.Handler` を返す関数です。返すクロージャが `word` を捕まえていて、何を捕まえたかは `return` の行を見れば分かります。`greeter("hello")` と `greeter("see you")` は、同じ形の別のハンドラです。
- `Auth` は 2 節の形（関数の欄を持つ struct）で、`before` だけを書いて `after` を省いています。
- 応答を印字するために、ネットワークの代わりに要求を文字列から流しています（`feed` / `show`）。実際のサーバーでは `http.Serve` に同じ `Dispatch` を渡します。

## 2. 関数の組 — 関数の欄を持つ struct（辞書）

メソッドが何本もある interface の代わりに、関数を欄に持つ struct を値として渡します。この struct を辞書と呼びます（[言語ツアー](tour.ja.md) 4 節の `Ord[T]` も同じ形です）。

```sober
// examples/abstraction_dict.sober
package main

// Abstraction 2: a struct of function fields (a dictionary) in place of an interface with several
// methods. Each implementation is a value; state is captured by the closures on the line that
// builds them, and a field that an implementation may leave out is optional (docs/guide/abstraction.md)

type Note func(qty int) string

type Pricing struct {
    name string
    price func(unit int, qty int) int
    // optional: an implementation without a note leaves it out
    note Note?
}

// an implementation with no state, written as a const
const Flat = Pricing{name: "flat", price: (unit, qty) => unit * qty}

// an implementation with state: `over` and `off` are captured here, in plain sight
func bulk(over int, off int) Pricing {
    return Pricing{
        name: "bulk",
        price: (unit, qty) => if qty > over { unit * qty * (100 - off) / 100 } else { unit * qty },
        note: (qty) => if qty > over { "${off}% off over ${over}" } else { "no discount" }}
}

// takes any implementation: which one is used is written at each call
func quote(p Pricing, unit int, qty int) {
    n := p.note
    extra := if n != nil { " (${n(qty)})" } else { "" }
    println("${p.name}: ${p.price(unit, qty)}${extra}")
}

func main() {
    quote(Flat, 120, 10)
    b := bulk(5, 20)
    quote(b, 120, 10)
    quote(b, 120, 3)
}
```

出力:

```
flat: 1200
bulk: 960 (20% off over 5)
bulk: 360 (no discount)
```

- 実装は値です。状態の要らない実装は `const`（`Flat`）、状態の要る実装は欄にクロージャを入れて組み立てる関数（`bulk`）で作ります。`over` と `off` を捕まえているのは `bulk` の中の 2 行だけです。
- 実装によっては省いてよい欄は `?` を付けます（`note Note?`）。関数型にはゼロ値が無いので、省ける欄は型の上で省けると書くしかありません。呼ぶ側は `nil` かどうかを確かめてから呼びます。
- どの実装が使われるかは、呼び出し（`quote(Flat, …)` / `quote(b, …)`）に書いてあります。

実戦サイズの実物（ルート表・Mount / Merge・middleware の before / after）は [`examples/http_router.sober`](../../examples/http_router.sober) にあります。

## 3. 決まった種類のどれか — union と型パターンの switch

種類が閉じていて（支払い方法・図形・トークンの種類など）、種類ごとに振る舞いが違うなら、union にして switch で分けます。

```sober
// examples/abstraction_union.sober
package main

// Abstraction 3: a closed set of kinds as a union, taken apart with a type-pattern switch
// (docs/guide/abstraction.md). Adding a variant makes every switch that misses it a compile error

type Payment union {
    Card { last4 string }
    Cash {}
    Points { n int }
}

func describe(p Payment) string {
    return switch p {
    case Card{last4}: "card ending ${last4}"
    case Cash{}: "cash"
    case Points{n}: "${n} points"
    }
}

// the fee in yen: only cards cost something
func fee(p Payment, amount int) int {
    return switch p {
    case Card{}: amount * 3 / 100
    case Cash{}: 0
    case Points{}: 0
    }
}

func main() {
    ps := []Payment{Card{last4: "4242"}, Cash{}, Points{n: 500}}
    for p <- ps {
        println("${describe(p)}: fee ${fee(p, 1000)}")
    }
}
```

出力:

```
card ending 4242: fee 30
cash: fee 0
500 points: fee 0
```

switch が union の variant を 1 つでも漏らすと、コンパイルエラーになります。種類を足したときに、直すべき switch を全部コンパイラが名指しします。

```sober
// examples/abstraction_union_neg.sober
package main

// Abstraction 3, rejected: a switch on a union that misses a variant (docs/guide/abstraction.md)

type Payment union {
    Card { last4 string }
    Cash {}
    Points { n int }
}

func describe(p Payment) string {
    return switch p {
    case Card{last4}: "card ending ${last4}"
    case Cash{}: "cash"
    }
}

func main() {
    println(describe(Cash{}))
}
```

拒否:

```
sober: error at examples/abstraction_union_neg.sober:12:12 (NonExhaustive): switch does not cover every variant of the union — add the missing cases or a default (missing: Points)
```

`default` の腕を書くと、漏れの検査はその switch では効かなくなります。種類を足したときに見直したい switch では、variant を全部書きます（`fee` のように）。

## 4. 失ったものと得たもの

失ったもの:

- **`this` が無い — これはオブジェクトではありません。** 関数の欄を持つ struct は C の関数ポインタの struct に似ていますが、自分自身を第一引数に受け取る仕組み（`this` / `self`）がありません。状態はクロージャが、作る行で明示に捕まえます
- メソッドの呼び出しの構文（`x.f()`）と、型にメソッドを足していく書き方。Zig のような method の構文（struct の名前空間に関数を置き、`x.f()` と呼べる糖衣）もありません。呼び方は常に `f(x)` の 1 つです。同じ呼び出しに 2 通りの書き方を作らず、振る舞いがデータに属しているように見える心的モデルの入口を、構文の段階で断っています
- 暗黙の満足（Go の interface・Haskell の型クラスのインスタンスの解決）。実装は毎回、引数として渡します

得たもの:

- **どの実装が使われるかが、呼び出しの場所に書いてある。** 暗黙の解決を追いかける必要がありません
- **何を捕まえたかが、クロージャを作った行に書いてある。** 隠れたフィールドや継承した状態はありません
- **nil の interface の罠が無い。** 関数型にゼロ値が無いので、「欄が空かもしれない」は `?` として型に出ます
- 種類が閉じているなら union と switch で、足し漏れをコンパイラが見つけます

## 5. 他の言語からの対応表

| 言語 | そこで書いていたもの | Sober |
| --- | --- | --- |
| Go | メソッド 1 本の interface（`http.Handler`） | 名前付き関数型（`http.Handler` は関数型） |
| Go | メソッドが複数の interface（`sort.Interface`） | 関数の欄を持つ struct を渡す（`Ord[T]{less: …}`） |
| Rust | trait と `impl Trait for T`・`dyn Trait` | 関数の欄を持つ struct（辞書）を値として渡す |
| Rust | `enum` と `match` | union と switch |
| TypeScript / React | `onClick` を props に渡す | そのままの形（関数を値として渡す）。これを書いたことがあれば、もう書けます |
| TypeScript | 判別可能な union（`kind` の欄）と `switch` | union と型パターンの switch |
| Java | `Comparator` を `sort` に渡す | 関数（か関数の欄の struct）を渡す。`Comparator` を渡すとき、実質は関数を渡しています |
| Java | 抽象クラスとサブクラス | 共通の部分は関数に、差し替える部分は関数の欄に |
| Haskell | 型クラス（`Ord a =>`） | 辞書を手で渡す（型クラスの辞書渡しを、コンパイラでなく呼び出しの場所に書く） |

まとめると、Sober の抽象化は C の関数ポインタの struct を、型安全・メモリ安全・null 安全にしたものです（関数型にゼロ値が無いので省ける欄は `?` が強制し、捕まえた値の寿命は region が守り、関数が持つエフェクトは宣言に出ます）。
