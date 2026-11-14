# 抽象化 — interfaceの代わりに

[English](abstraction.md) | 日本語

Soberにはinterfaceもクラスもメソッドもありません。振る舞いの差し替えは、関数の差し替えです。それ以上の機構はありません。

このページは、他の言語でinterface（やtrait・型クラス・抽象クラス）を使って書いていたことを、Soberでどう書くかの案内です。形は3つだけです。

| やりたいこと | Soberの形 | 節 |
| --- | --- | --- |
| 関数1つを差し替える | 名前付き関数型 + クロージャ | 1 |
| 関数をいくつか組で差し替える | 関数のフィールドを持つstruct（辞書） | 2 |
| 決まった種類のどれか、で場合分けする | union + 型パターンのswitch | 3 |

前提: [言語ツアー](tour.ja.md) の2節（ラムダ）と4節（struct・union・辞書）。

## 1. 関数1つ — 名前付き関数型とクロージャ

std/http/serverのハンドラはinterfaceではなく、名前付きの関数型です。

```sober
type Handler func(r Request) Response
```

ハンドラを差し替えたければ、別の関数を渡します。状態が要るときは、その状態をクロージャが捕まえます。捕まえた値は、クロージャを作った行に書いてあります。

```sober
// examples/abstraction_handler.sober
package main

// Abstraction 1 and 2: a named function type (http.server.Handler) built by closures, and a struct of
// function fields (http.server.Middleware) (docs/guide/abstraction.md). The requests are fed from a string
// instead of the network, and each response is printed (the form of examples/http_router)

import "std/http/server"

func or(s string?) string {
    return if s != nil { s } else { "-" }
}

// stops a request without X-Token (only `before` is given; `after` is left out)
const Auth = http.server.Middleware{before: (r) => if http.server.Header(r, "x-token") == nil { http.server.Status(401) } else { nil }}

// a Handler that answers with `word`: the closure captures `word` on this line
func greeter(word string) http.server.Handler {
    return (r) => http.server.Text("${word}, ${or(http.server.Param(r, "name"))}\n")
}

func routes() []http.server.Route {
    return http.server.Mount("", []http.server.Route{
        http.server.Route{method: "GET", path: "/hello/:name", handler: greeter("hello")},
        http.server.Route{method: "GET", path: "/bye/:name", handler: greeter("see you")}}, []http.server.Middleware{Auth})
}

func main() {
    reqs := "GET /hello/ann HTTP/1.1\r\nX-Token: t\r\n\r\n" +
        "GET /bye/bob HTTP/1.1\r\nX-Token: t\r\n\r\n" +
        "GET /hello/eve HTTP/1.1\r\nConnection: close\r\n\r\n"
    rs := routes()
    e := http.server.ServeWith((k) => feed(reqs, k), (b) => show(b), (r) => http.server.Dispatch(rs, r))
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

- `greeter` は `http.server.Handler` を返す関数です。返すクロージャが `word` を捕まえていて、何を捕まえたかは `return` の行を見れば分かります。`greeter("hello")` と `greeter("see you")` は、同じ形の別のハンドラです。
- `Auth` は2節の形（関数のフィールドを持つstruct）で、`before` だけを書いて `after` を省いています。
- レスポンスを印字するために、ネットワークの代わりにリクエストを文字列から流しています（`feed` / `show`）。実際のサーバーでは `http.server.Serve` に同じ `Dispatch` を渡します。

## 2. 関数の組 — 関数のフィールドを持つstruct（辞書）

メソッドが何本もあるinterfaceの代わりに、関数をフィールドに持つstructを値として渡します。このstructを辞書と呼びます（[言語ツアー](tour.ja.md) 4節の `Ord[T]` も同じ形です）。

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

- 実装は値です。状態の要らない実装は `const`（`Flat`）、状態の要る実装はフィールドにクロージャを入れて組み立てる関数（`bulk`）で作ります。`over` と `off` を捕まえているのは `bulk` の中の2行だけです。
- 実装によっては省いてよいフィールドは `?` を付けます（`note Note?`）。関数型にはゼロ値が無いので、省けるフィールドは型の上で省けると書くしかありません。呼ぶ側は `nil` かどうかを確認してから呼びます。
- どの実装が使われるかは、呼び出し（`quote(Flat, …)` / `quote(b, …)`）に書いてあります。

実戦サイズの実物（ルート表・Mount / Merge・middlewareのbefore / after）は [`examples/http_router.sober`](../../examples/http_router.sober) にあります。

## 3. 決まった種類のどれか — unionと型パターンのswitch

種類が閉じていて（支払い方法・図形・トークンの種類など）、種類ごとに振る舞いが違うなら、unionにしてswitchで分けます。

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

switchがunionのvariantを1つでも漏らすと、コンパイルエラーになります。種類を足したときに、直すべきswitchを全部コンパイラが列挙します。

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

`default` の分岐を書くと、漏れの検査はそのswitchでは効かなくなります。種類を足したときに見直したいswitchでは、variantを全部書きます（`fee` のように）。

## 4. 失ったものと得たもの

失ったもの:

- `this` が無い — これはオブジェクトではありません。 関数のフィールドを持つstructはCの関数ポインタのstructに似ていますが、自分自身を第一引数に受け取る仕組み（`this` / `self`）がありません。状態はクロージャが、作る行で明示に捕まえます
- メソッドの呼び出しの構文（`x.f()`）と、型にメソッドを足していく書き方。Zigのようなmethodの構文（structの名前空間に関数を置き、`x.f()` と呼べる糖衣）もありません。呼び方は常に `f(x)` の1つです。同じ呼び出しに2通りの書き方を作らず、振る舞いがデータに属しているように見える心的モデルの入口を、構文の段階で断っています
- 暗黙の満足（Goのinterface・Haskellの型クラスのインスタンスの解決）。実装は毎回、引数として渡します

得たもの:

- どの実装が使われるかが、呼び出しの場所に書いてある。 暗黙の解決を追いかける必要がありません
- 何を捕まえたかが、クロージャを作った行に書いてある。 隠れたフィールドや継承した状態はありません
- nilのinterfaceの罠が無い。 関数型にゼロ値が無いので、「フィールドが空かもしれない」は `?` として型に出ます
- 種類が閉じているならunionとswitchで、足し漏れをコンパイラが見つけます

## 5. 他の言語からの対応表

| 言語 | そこで書いていたもの | Sober |
| --- | --- | --- |
| Go | メソッド1本のinterface（`http.server.Handler`） | 名前付き関数型（`http.server.Handler` は関数型） |
| Go | メソッドが複数のinterface（`sort.Interface`） | 関数のフィールドを持つstructを渡す（`Ord[T]{less: …}`） |
| Rust | traitと `impl Trait for T`・`dyn Trait` | 関数のフィールドを持つstruct（辞書）を値として渡す |
| Rust | `enum` と `match` | unionとswitch |
| TypeScript / React | `onClick` をpropsに渡す | そのままの形（関数を値として渡す）。これを書いたことがあれば、もう書けます |
| TypeScript | 判別可能なunion（`kind` のフィールド）と `switch` | unionと型パターンのswitch |
| Java | `Comparator` を `sort` に渡す | 関数（か関数のフィールドを持つstruct）を渡す。`Comparator` を渡すとき、実質は関数を渡しています |
| Java | 抽象クラスとサブクラス | 共通の部分は関数に、差し替える部分は関数のフィールドに |
| Haskell | 型クラス（`Ord a =>`） | 辞書を手で渡す（型クラスの辞書渡しを、コンパイラでなく呼び出しの場所に書く） |

まとめると、Soberの抽象化はCの関数ポインタのstructを、型安全・メモリ安全・null安全にしたものです（関数型にゼロ値が無いので省けるフィールドは `?` が強制し、捕まえた値の寿命はregionが守り、関数が持つエフェクトは宣言に出ます）。
