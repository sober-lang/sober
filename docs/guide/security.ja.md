# 安全性ガイド

[English](security.md) | 日本語

Sober のプログラムがどんな事故から守られていて、どんな事故からは守られていないかを、脅威ごとに書きます。各節は「脅威 → Sober での答え → 実例」の順です。実例は `examples/` の実物で、検査の網が毎回検査し（出力のある例は建てて走らせて）、ここに載せた出力と拒否の診断を照合しています。

最後の節「[Sober が守らないもの](#12-sober-が守らないもの)」も読んでください。言語が消せる事故には限りがあり、残る側を知っていることが安全の前提です。

## 0. 読み方 — 2 つの層と 2 つの検査

Sober は事故の種類ごとに、2 つの層のどちらかで答えます。

- **構造で消す**: その事故を起こす形が、言語に書けない。メモリの破壊・データ競合・資源の漏れ・パストラバーサルがこちらです。書けば `sober build` も `sober check` も拒否します。
- **宣言と解析で消す**: 構造では言えない性質を、解析器（analyzer）が呼び出しのグラフと値の流れから導き、宣言と照合します。エラーの取りこぼし・秘密に依存した分岐・認証つきの応答の共有キャッシュへの保存・関数の効果がこちらです。

**解析器の規則は `sober check` だけが掛けます。** `sober build` は解析器を走らせず、受理を変えません（解析器は受理を狭めるだけで、プログラムの意味を変えないため）。この文書で「check が拒否」と書いた規則を効かせるには、CI やコミットの前に `sober check <file.sober>` を回してください。build が拒否する規則（構造の層）は、どちらでも止まります。

この後の各節は脅威ごとの詳しい答えですが、早見には次の 3 分類が目安になります。

| 分類 | 意味 | 該当節 |
|---|---|---|
| 成立しない | 言語の構造がその形を書かせない | 1 節・2 節 |
| 定義された死に変わる | 未定義動作でなくラベルつきの panic。死は task（接続単位）に閉じ、プロセスは生きる | 1 節・4 節・9 節 |
| 残る — 利用者の設計の仕事 | 認可・ビジネスロジック・入力の意味の検証・計算量の DoS 等 | 12 節 |

表は早見のためのもので、脅威ごとの詳細は各節に、「残る」側の正直な説明は 12 節にまとめています。

## 1. メモリの破壊

脅威: 解放済みの領域を指す参照（use after free・宙吊りのポインタ）、二重解放、配列の範囲外の読み書き、null の参照。

Sober の答え: GC も借用検査もありませんが、値の寿命をスコープの入れ子に一致させています。全部のブロックが region（割り当ての領域）で、ブロックを出るとそこで作った値はまとめて解放されます。スコープの外へ出る値（戻り値・外の束縛への代入）は、外の region へ写されます。外の region が中の region を指すことが起きないので、宙吊りの参照が作れません。解放は region ごとなので、二重解放もありません。

- 添字と部分列は範囲を検査します。範囲外の添字は panic（終了コード 101）で止まり、隣のメモリを読み書きしません。
- 値は既定で非 null です。`nil` は `T?` の型にしか住めず、`T?` の値は `nil` でないことを確かめてからでないと `T` として使えません。

```sober
// examples/security_memory.sober
package main

// Security: memory — values outlive their scope by being copied out, never by dangling (docs/guide/security.md)

// the string is made in this function's region; return copies it out to the caller's region
func greeting(name string) string {
    msg := "hello, ${name}"
    return msg
}

// an index can fail, so the lookup says so in its type: int? must be checked before use
func at(xs []int, i int) int? {
    return if i >= 0 && i < len(xs) { xs[i] } else { nil }
}

func main() int {
    people := []string{"ada", "bob"}
    mut names := mut []string{}
    for n <- people {
        names = append(names, greeting(n))   // the loop body's region is freed each iteration; the kept value is copied out
    }
    println(names[0], "/", names[1])
    xs := []int{10, 20, 30}
    probes := []int{1, 5}
    for i <- probes {
        v := at(xs, i)
        println(if v != nil { "xs[${i}] = ${v}" } else { "xs[${i}]: out of range" })
    }
    return 0
}
```

出力:

```
hello, ada / hello, bob
xs[1] = 20
xs[5]: out of range
```

`at` が `int?` を返すので、呼び手は範囲外の場合を書かずに値を使えません。`xs[5]` と直に書けば、範囲外は panic で止まります。

実世界の対比: 2026 年 10 月の Node.js のセキュリティリリースでは、同梱の Brotli（C 実装）の展開処理の境界外書き込みがリモートコード実行につながるおそれがある脆弱性（CVE-2026-111497）が修正されました。同じ形を Sober で書くと、展開器の出力の書き込みは slice の境界検査つきなので、細工された圧縮データが起こせるのは「展開の失敗 = ラベルつきの panic（その接続の task だけが死ぬ）」までです — メモリ破壊や RCE の形にはなりません。それでも、panic を起こす入力を送りつけて接続を切らせること自体は残る側です（[9 節](#9-資源の枯渇サービス拒否)の受け入れの設計を参照）。

詳しく: [言語仕様 9 章 メモリ](../spec/09-memory.ja.md)・[設計ノート: 安全](../design-notes/safe.md)

## 2. データ競合

脅威: 複数のスレッドが同じ可変の値を同時に読み書きして、壊れた値や順序に依存した結果が出る。

Sober の答え: 並列のスコープ（`task.Spawn` の子・`task.Map` の要素の task）へ渡せるのは、不変の値（`freeze` したもの・不変の束縛）とチャネルだけです。`mut` の値は task の境界を越えません。チャネルの送り端・受け端は 1 つの task だけが所有します。共有された可変の状態が書けないので、データ競合は書けません。この規則は build でも check でも掛かります。

```sober
// examples/security_race_neg.sober
package main

// Security: data races — a spawned task cannot capture a mut binding (rejected by check and build) (docs/guide/security.md)

import "std/task"

func main() {
    mut hits := 0
    r, _ := task.Run((s task.Scope) => task.Join(task.Spawn(s, () => hits + 1)))
    hits += 1
    println(r)
}
```

拒否:

```
sober: load error at examples/security_race_neg.sober:9:70: a spawned task cannot capture a mut binding (the child sees only imm values — pass a copy: v := x before the Spawn)
```

並列の書き方そのものは [ツアー 7 節](tour.ja.md#7-並列--structured-concurrencyチャネル) にあります。

詳しく: [言語仕様 10 章 並行](../spec/10-concurrency.ja.md)

## 3. エラーの取りこぼし

脅威: 失敗した処理の結果を確かめずに先へ進む（認証の失敗を見落として通す、など）。どの関数が何で失敗しうるかがソースから見えない。

Sober の答え: エラーはラベル（`type Expired error`）で、失敗しうる関数は `(T, error?)` を返します。解析器が呼び出しのグラフから、各関数が返しうるラベルの集合を導きます。

- `switch err` は、その値が持ちうるラベルを全部覆わなければなりません（覆わない腕は `default` で明示する）。
- error を返す公開関数（名前が大文字で始まる関数）は、返しうるラベルを `@errors(…)` で宣言します。宣言は導出と照合され、宣言に無いラベルが返りうれば拒否します（公開関数では、宣言が導出より広くても拒否 — 古い宣言が残らない）。package をまたぐ呼び出しは呼び先の宣言を読むので、依存先が新しい失敗を返すようになれば、宣言の変更として差分に現れます。宣言は `sober fix --errors` が導出から書けます。
- `@exhaustive` を付けた関数の switch は、閉じた集合（union の全 variant・その package の全 error ラベル）の全員を名指さなければなりません。後から variant やラベルを足したとき、扱いを書き忘れた switch が止まります。

```sober
// examples/security_errors_neg.sober
package main

// Security: unhandled errors — a switch over an error must cover every label it may carry (rejected by check) (docs/guide/security.md)

type Expired error

type Revoked error {
    by string
}

func session(token string) (string, error?) {
    if token == "" {
        return "", Expired{}
    }
    if token == "old" {
        return "", Revoked{by: "admin"}
    }
    return "user-1", nil
}

func main() {
    who, err := session("old")
    if err != nil {
        switch err {
        case Expired{}: println("please sign in again")
        }
        return
    }
    println(who)
}
```

拒否:

```
examples/security_errors_neg.sober:24:9: error: switch does not cover Revoked (error labels the subject may carry): add cases or a default (Analyzer)
```

`Revoked` の扱いを忘れたまま、`err != nil` の後をすり抜ける形は check が止めます（build は解析器を走らせないので受理し、覆っていないラベルが実際に来ると panic で止まります）。

詳しく: [ツアー 5 節](tour.ja.md#5-エラー--ラベルcatchswitch)・[言語仕様 7 章 エラー](../spec/07-errors.ja.md)・[12 章 A-8（@exhaustive）](../spec/12-annotations.ja.md)

## 4. panic — 止まるときは理由と位置つきで

脅威: プログラムが壊れた状態のまま走り続ける。止まっても、なぜ止まったかが分からない。

Sober の答え: panic は 2 種類だけです。続けると安全性が破れるもの（不変にした値への書き込み・region の上限の超過など）と、正しいプログラムでは届かないもの（範囲外の添字・明示の `panic(L{…})`）。ファイルが無い・入力が壊れているといった普通の失敗は、panic でなくエラーのラベルで返します。

明示の panic には理由のラベルが要ります（`Unreachable`・`InvariantBroken`・自分で宣言する `type L panic{…}`）。死ぬときは、ラベルの欄と位置（ファイル:行:列）を標準エラーに 1 行で書き、終了コード 101 で終わります（region の資源が尽きたときは 102）。

```sober
// examples/security_panic_neg.sober
package main

// Security: panic needs a reason — a bare panic() is rejected (docs/guide/security.md)

func main() {
    panic()
}
```

拒否:

```
sober: load error at examples/security_panic_neg.sober:6:10: panic needs a reason: panic(L{…}) with a panic label (Unreachable, InvariantBroken, or one declared as type L panic{…})
```

子の task が死んだときは、死は値でなく構造で親へ伝わります（scope は出口で失敗になる）。死んだ task の壊れた途中の状態で利用者のコードを走らせないため、死んだ task の `defer` は走りません — それでも開いたファイルと接続は task の出口で閉じます（次の節）。

詳しく: [設計ノート: 安全 — panic はいつ起きるのか](../design-notes/safe.md#panic-はいつ起きるのか)

## 5. 資源の漏れ

脅威: 開いたファイルや接続を閉じ忘れる（記述子が尽きる）、二重に閉じる、閉じた後に使う。

Sober の答え: 開いた資源（`io.File`・`io.Root`・`net.Conn` など）は同一性を持つ型で、写せず、開いたブロックの外へ出せず、struct やチャネルにも格納できません。`io.Open` の直後の文は `defer io.Close(f)` でなければならず、`io.Close` はこの形の外に書けません。だから閉じ忘れ・早すぎる close・二重の close が形として書けません。task が死んで defer が走らなくても、開いた記述子は task の出口で閉じます。接続（`net.Listen`・`net.Dial`・`net.Accept`）は for の生成元で、本体を抜けたら std が閉じます。

```sober
// examples/security_file_neg.sober
package main

// Security: leaked files — the statement right after an Open must be its defer io.Close (docs/guide/security.md)

import "std/io"

func main() {
    f := io.Open("testdata/io/hello.txt") catch return
    b := io.ReadAll(f) catch return
    println(len(b))
}
```

拒否:

```
sober: load error at examples/security_file_neg.sober:8:17: the file opened here must be closed by the next statement: insert `defer io.Close(f)` (with the name bound here — `defer io.CloseRoot(r)` for io.OpenRoot) right after this line
```

診断は、入れる行（`defer io.Close(f)`）をそのまま示します。

詳しく: [言語仕様 11 章 io](../spec/11-io.ja.md)

## 6. パストラバーサル

脅威: 利用者が送ってきたパス（`../../etc/passwd`・絶対パス・外を指す symlink）で、公開するつもりのディレクトリの外のファイルを読まれる。

Sober の答え: 信用できないパスは、根のディレクトリ `io.Root` の下でだけ開きます。`io.OpenUnder(r, rel)` は r の下の rel だけを開き、`..` で外へ出る・絶対パス・外を指す symlink は解決の途中で拒否されて `io.Denied` になります。保証はカーネル（Linux の openat2 の `RESOLVE_BENEATH`）が持ち、std は rel を文字列として検査しません — 文字列の検査の抜け道（エンコードの違い・symlink の差し替え）が入る余地がありません。openat2 の無いカーネルでは開かずに `io.Other` を返します（開いてしまう側には倒れません）。

```sober
// examples/security_root.sober
package main

// Security: path traversal — open a path only under a root directory (docs/guide/security.md)
// run from the repository root

import "std/io"

// serve reads the file named by an untrusted path, but only under r
@errors(io.NotFound, io.Denied, io.Other, io.Timeout, io.Expired)
func serve(r io.Root, rel string) (int, error?) {
    f := io.OpenUnder(r, rel)?
    defer io.Close(f)
    b := io.ReadAll(f)?
    return len(b), nil
}

func show(r io.Root, rel string) {
    n, e := serve(r, rel)
    println(switch e {
    case nil: "${rel}: ${n} bytes"
    case io.NotFound{}: "${rel}: not found"
    case io.Denied{}: "${rel}: denied"
    default: "${rel}: other error"
    })
}

@errors(io.NotFound, io.Denied, io.Other, io.Timeout, io.Expired)
func run() error? {
    r := io.OpenRoot("testdata/io")?
    defer io.CloseRoot(r)
    paths := []string{"hello.txt", "../../README.md", "/etc/passwd", "missing.txt"}
    for rel <- paths {
        show(r, rel)
    }
    return nil
}

func main() {
    if run() != nil {
        println("cannot open the root")
    }
}
```

出力:

```
hello.txt: 17 bytes
../../README.md: denied
/etc/passwd: denied
missing.txt: not found
```

`http.Static`（静的ファイルの配信）はこの口で開きます。根の外を指す要求は、無いファイルと同じ 404 を返します（外のファイルの存在を漏らさない）。

詳しく: [言語仕様 11 章 I-7](../spec/11-io.ja.md)・[std/http の Static](../std/http.ja.md#static)

## 7. タイミングで秘密が漏れる

脅威: 鍵や MAC の tag のような秘密の値で分岐・添字・除算をすると、処理の時間が秘密によって変わり、外から時間を測って秘密を推測される（典型は、先頭から比べて最初の食い違いで抜ける比較）。

Sober の答え: 自分の値が秘密だと `@secret` で宣言します — 関数の前置 `@secret(k)`（仮引数 k を秘密として扱う）・struct の欄の後置・const の前置の 3 か所に書けます。解析器は秘密の値と、そこから算術・比較・代入・関数の結果で導いた値を追い、それが分岐の条件・switch の subject・`&&` / `||` の左辺・添字・slice の端・map の鍵・`/` と `%` に届く形を拒否します。秘密を受けた関数がその仮引数を分岐に使うなら、渡した呼び出しも拒否します。`len` の結果は公開の値です。

比較には std の `crypto.Equal` を使います。全バイトを畳んでから最後に 1 回だけ判定するので、どこで食い違ったかが時間に出ません。その結果は公開の値として扱われます（std がそう宣言しています）。std/crypto と std/tls の鍵の材料は、std の側で秘密として宣言済みです。

```sober
// examples/security_secret.sober
package main

// Security: timing — a MAC tag is compared with crypto.Equal, which does not branch on the bytes (docs/guide/security.md)

import "std/crypto"
import "std/crypto/hmac"

// the key is a secret: no branch, index or division may depend on it
@secret(key)
func valid(key []byte, msg []byte, tag []byte) bool {
    return crypto.Equal(hmac.Sum256(key, msg), tag)
}

func main() {
    key := bytes("k3y-0f-the-server")
    tag := hmac.Sum256(key, bytes("user=ada"))
    println(valid(key, bytes("user=ada"), tag))
    println(valid(key, bytes("user=root"), tag))
}
```

出力:

```
true
false
```

同じことを、先頭から比べて食い違いで抜ける比較で書くと、check が拒否します。

```sober
// examples/security_secret_neg.sober
package main

// Security: timing — an early-exit comparison of a secret leaks where the bytes differ (rejected by check) (docs/guide/security.md)

@secret(tag)
func same(tag []byte, got []byte) bool {
    if len(tag) != len(got) {
        return false
    }
    mut i := 0
    while i < len(tag) {
        if tag[i] != got[i] {
            return false
        }
        i += 1
    }
    return true
}

func main() {
    println(same(bytes("abc"), bytes("abd")))
}
```

拒否:

```
examples/security_secret_neg.sober:12:19: error: a value derived from the @secret parameter 'tag' of 'main.same' reaches a branch condition — its timing would reveal the secret (language.md 12 節「秘密の値の宣言」) (Analyzer)
```

7 行目の長さの比較は通ります（長さは公開の値）。拒否されるのは、秘密の中身で分岐する 12 行目です。

詳しく: [言語仕様 12 章 A-9〜A-11](../spec/12-annotations.ja.md)

## 8. 認証つきの応答が共有キャッシュに載る

脅威: Cookie や Authorization で中身が変わる応答（「自分のアカウント」のページ）を、origin が CDN や中継のキャッシュに保存してよいと宣言してしまう。保存された応答は、次に同じ URL を要求した別の人に配られます（web cache deception の一形）。HTTP の規格は Authorization つきの要求への応答には保護を持ちますが、Cookie には同じ保護がありません。

Sober の答え: 2 つの層で答えます。

- 構造（std/http）: 保存の方針は型の欄（`Route.cache`・`Response.cache`・Static の `cache:`）でだけ書き、任意のヘッダとして Cache-Control を書く口はありません。動的な応答の既定は `Cache-Control: private` です。認証の値は名指しの口 `http.Authorization` / `http.Cookie` でだけ読めます（`http.Header` は認証のヘッダに nil を返す）。
- 解析: 共有キャッシュにも保存させる方針（`http.Fresh`・`http.Shared`）は、ルートの行でだけ書けます。そのルートのハンドラや middleware が認証の口に届きうる形、認証の middleware の下に共有の方針のルートを Mount する形を、check が拒否します。

公開の資産は共有させ、認証の後ろの API は private にする形は受理されます。

```sober
// examples/security_cache.sober
package main

// Security: shared caches — public assets may be cached by a CDN; responses that read a cookie stay private (docs/guide/security.md)

import "std/http"

// me depends on the session cookie, so its response must not be stored by a shared cache
func me(r http.Request) http.Response {
    sid := http.Cookie(r, "sid")
    return http.Text(if sid != nil { "signed in" } else { "guest" })
}

func main() {
    auth := http.Middleware{before: (r) => if http.Cookie(r, "sid") == nil { http.Status(401) } else { nil }}
    api := http.Mount("/api", []http.Route{http.Route{method: "GET", path: "/me", handler: me, cache: http.Private{maxAge: 30}}}, []http.Middleware{auth})
    assets := http.Static("/assets", "/srv/www", cache: http.Shared{maxAge: 3600, sMaxAge: 86400})
    routes := http.Merge(api, assets)
    println(len(routes))
}
```

出力:

```
2
```

Cookie を読むハンドラのルートに共有の方針を書くと、check が拒否します。

```sober
// examples/security_cache_neg.sober
package main

// Security: shared caches — a route that lets a CDN store its response must not read a cookie (rejected by check) (docs/guide/security.md)

import "std/http"

func me(r http.Request) http.Response {
    sid := http.Cookie(r, "sid")
    return http.Text(if sid != nil { "signed in" } else { "guest" })
}

func main() {
    routes := []http.Route{http.Route{method: "GET", path: "/me", handler: me, cache: http.Shared{maxAge: 60}}}
    println(len(routes))
}
```

拒否:

```
examples/security_cache_neg.sober:13:28: error: the shared cache policy 'Shared' meets a handler or middleware that reaches a credential source (http.Authorization / http.Cookie / Request.head) in one route — a response that depends on Authorization / Cookie must not be stored by a shared cache — it would be served to other users (language.md 12 節「出所の依存」); use http.Private / http.NoStore for this route, or move the credential read out of it (Analyzer)
```

詳しく: [std/http の Cache](../std/http.ja.md#cache)・[言語仕様 12 章 A-12・A-13](../spec/12-annotations.ja.md)

## 9. 資源の枯渇（サービス拒否）

脅威: 大量の接続、大きな要求、メモリを食う要求で、サーバ全体が止まる・メモリを使い切る。

Sober の答え: サーバ（`net.Serve`）は 3 つの層で資源に天井を持ちます。

- **受け入れ（admission）**: `conns:` は同時の接続の数の天井です（既定 10000）。天井を超えた接続には、利用者のコードを走らせずに `reject:` のバイト列を送って閉じます。
- **予算（`budget:`）**: 接続 1 本が使うメモリの上界の宣言です（既定 64 KiB）。受け入れの天井は `conns × budget` のバイト数で数えます。task 一般でも、`task.Spawn` などに `budget:` を書くと、天井に入らない子は並列にせず逐次に走ります（値と出力は変わりません）。
- **region の上限（`region:`）**: 接続の task の region 1 つの上限です（既定 128 MiB）。超えたらその接続の task だけが死に、Serve は吸収して他の接続を続けます。

HTTP の層では、要求の頭と本文に上限があります（`http.ServeConn` の `maxHead:` 既定 8 KiB を超えたら 431・`maxBody:` 既定 16 KiB を超えたら 413 — ハンドラは走りません）。待ちには期限を付けられます（`task.Run(…, deadline:)` — 期限の後の io は `io.Expired` を返し、net の待ちは期限で切れる）。

```sober
// examples/security_limits.sober
package main

// Security: resource exhaustion — admission, a per-connection budget and a per-connection region cap (docs/guide/security.md)
// a server: check and build only (it does not stop by itself)

import "std/http"
import "std/net"
import "std/task"

func route(r http.Request) http.Response {
    return http.Text("ok")
}

// app serves one connection; oversized heads and bodies get 431 / 413 before route runs
func app(c net.Conn) error? {
    return http.ServeConn(c, route, maxHead: 8 * task.KB, maxBody: 64 * task.KB)
}

func run() error? {
    for l <- net.Listen("0.0.0.0:8080")? {
        // at most 2,000 connections at once (the 2,001st gets the reject bytes and is closed without running app);
        // each connection may use up to 256 KiB, and a connection whose region passes 32 MiB dies alone
        net.Serve(l, app, budget: 256 * task.KB, conns: 2000, reject: "HTTP/1.1 503 Service Unavailable\r\ncontent-length: 0\r\n\r\n", region: 32 * task.MB)?
    }
    return nil
}

func main() {
    if run() != nil {
        println("listen failed")
    }
}
```

この例はサーバなので、網は検査と建てるところまでを確かめます（走らせて止まらないため、出力の照合はありません）。

詳しく: [std/net の Serve](../std/net.ja.md)・[言語仕様 10 章 10.6 予算・プール・期限](../spec/10-concurrency.ja.md)・[std/http の ServeConn](../std/http.ja.md)

## 10. 関数が隠れて何かをする

脅威: 純粋な計算のつもりの関数が、いつの間にかログを書く・ネットワークに出る・時刻を読む・待ちに入る。依存先の関数がそう変わっても、呼び手のソースからは見えない。

Sober の答え: 関数の効果を解析器が導出します。語彙は 4 つです — `block`（待ちに入りうる）・`io`（プロセスの外と出入りする — `println` を含む）・`panic`（明示の `panic(L{…})`）・`nondet`（時刻の読みなど、入力を固定しても揺れる値）。呼んだ関数の効果は呼び手の効果です。

`@effects(…)` は「この関数の効果は、ここに書いたものに収まる」という主張で、check が導出と照合します。

- 否定形 `@effects(!io, !block)` は人の意図の主張です。将来その関数に io が入ったら、宣言の位置で止まり、入った呼び出しを名指します。
- 正の列挙 `@effects(io)` は許す効果の上界です。`sober fix --effects` が導出から書けます。
- 名前付き関数型の後置 `type Rule func(…) R @effects(…)` は、その型の値（ラムダ・関数）全部への契約です。

標準ライブラリの公開関数は、全部が `@effects` を宣言しています（[std リファレンス](../std/README.ja.md)の各関数の署名に出ています）。宣言は導出と一致することが検査されているので、std の関数がいつから io をするようになったかは、宣言の変更として差分に現れます。

```sober
// examples/security_effects.sober
package main

// Security: hidden effects — @effects states what a function may do, and check compares it with what the body does (docs/guide/security.md)

// a pricing rule: the type promises its values do no I/O, never wait, and do not read the clock
type Rule func(amount int) int @effects(!io, !block, !nondet)

@effects(!io, !block, !nondet)
func fee(amount int) int {
    return amount / 100 + 30
}

// the positive list is an upper bound: this function may do io (printing) and nothing else
@effects(io)
func audit(msg string) {
    println(msg)
}

@effects(io, Rule)
func charge(rule Rule, amount int) {
    audit("charge ${amount + rule(amount)}")
}

func main() {
    charge(fee, 5000)
    charge((a) => a / 50, 5000)
}
```

出力:

```
charge 5080
charge 5100
```

io をしないと宣言した関数が、ログの関数を呼び始めると止まります。

```sober
// examples/security_effects_neg.sober
package main

// Security: hidden effects — a function declared without io starts logging (rejected by check) (docs/guide/security.md)

func audit(msg string) {
    println(msg)
}

@effects(!io, !block, !nondet)
func fee(amount int) int {
    audit("fee for ${amount}")
    return amount / 100 + 30
}

func main() {
    println(fee(5000))
}
```

拒否:

```
examples/security_effects_neg.sober:9:1: error: 'main.fee' may have the effect io via the call of 'main.audit', which its @effects does not allow (allowed: panic) (Analyzer)
```

同じ導出は、ワーカー局所の作業域を借りる `task.Lease` の窓の警告にも使われています（窓の中で待ちに入りうると、借りが新しい割り当てに倒れて遅くなる — 拒否ではなく警告）。関数値を通した待ちも、この導出で見えます。

詳しく: [言語仕様 12 章 12.5 関数の効果](../spec/12-annotations.ja.md)

## 11. 供給網

脅威: 依存のパッケージ、ビルドの道具、実行時のライブラリに、悪意のあるコードや脆弱性が混ざる。実行環境のイメージに余計なものが載る。

Sober の答え:

- 依存ゼロ。コンパイラは libc にも LLVM にも依らない静的な ELF 1 つで、出力の実行ファイルも静的な ELF です。標準ライブラリは外部のライブラリに依りません。パッケージ管理の道具はまだ無く、プログラムが import できるのは std と自分のソースの package だけです。
- 完全ブートストラップ。コンパイラは凍結した Zig 製の最初の版から、`bootstrap/` のソースのスナップショットを順に建てて作ります。種のバイナリはありません（[インストール](install.ja.md)）。
- 実行環境を空にできる。出力が静的な ELF 1 つなので、コンテナのイメージは `FROM scratch` に実行ファイル 1 つを置くだけで足ります — シェルも libc もパッケージも載りません。HttpArena の提出物の [Dockerfile](../../bench/httparena/Dockerfile) がこの形です（建てる段は sober の公式イメージ、走る段は scratch）。PID 1 として走らせても SIGTERM / SIGINT で止まるので、init の道具も要りません。io_uring と資源の上限の設定は [インストールの「サーバを走らせる」](install.ja.md#サーバを走らせる) を見てください。

## 12. Sober が守らないもの

言語が消せる事故には限りがあります。次のものは、Sober を使っても書き手の責任のまま残ります。

- **認可とビジネスロジック**: 誰が何をしてよいか、その要求がその利用者に許されるか、金額や在庫の規則が正しいか。言語はこれを消しません。認証の値を読んで分岐するのは正しいプログラムの普通の形で、その分岐が正しいかは言語には分かりません。
- **解析器を回さない場合**: 3・7・8・10 節の規則は `sober check` だけが掛けます。build だけで済ませると効きません。
- **入力の意味の検証**: 型と UTF-8 の検査の先 — 値の範囲・形式・業務上の妥当さ — は書き手が確かめます。
- **SQL injection**: データベースのクライアントはまだ std にありません。今の Sober はこの事故に固有の答えを持っていません。
- **秘密の扱いの誤り**: `@secret` が見るのはソースの上のタイミングの流れ（分岐・添字・除算）だけです。秘密をログや応答に書き出すこと（印字は検査の対象外）、鍵や nonce の使い回し、乱数の誤用は止めません。利用者のコードについて、生成された機械語に分岐が無いことまでは確かめません。
- **キャッシュの残り**: CDN 側の設定が `private` を無視して保存する場合・Vary の漏れ・query や本文に載せた token・相手の IP で変わる応答は、8 節の検査の外です。
- **計算で詰まる要求**: 期限（`deadline:`）は待ちの上限であって、実行時間の上限ではありません。走っている計算は止めません。重い計算を受ける口には、書き手が入力の大きさの上限を置いてください。また、処理中の接続を流し切る優雅な停止はまだありません（止めると処理中の接続は切れます）。
- **同じ uid のプロセスとの port の共有**: `net.Listen` は SO_REUSEPORT を立てます（`net.Serve` がワーカーごとに同じ番地の listener を足して、accept をワーカーごとに並べるため）。このため、同じ uid で動く別のプロセスは同じ番地に bind でき、届く接続をカーネルの振り分けで分け合います。同じ番地での 2 つ目の起動は「使用中」で失敗せず、黙って接続の一部を受けます。別の uid のプロセスは bind できません。同じ uid は、もともと ptrace や `/proc/<pid>/mem` でプロセスに届く範囲の内側なので新しい境界の破れではありませんが、サービスごとに uid を分けてください（systemd の `DynamicUser`・コンテナの既定の分け方）。
- **証明の射程**: メモリ安全・データ競合自由は、言語のコアを形式化したモデルで Lean 4 により証明していますが、証明されているのはモデルの性質で、コンパイラの実装そのものではありません（[設計ノート: 安全](../design-notes/safe.md#その安全性はどこまで証明されているのか)）。コンパイラ・ランタイム・カーネルの不具合は、この文書のどの答えの外にもあります。

---

この文書は、言語に新しい安全の機構が入るたびに節が増えます。規則の正確な定義は [言語仕様](../spec/README.ja.md) に、決定の経緯は [決定の記録](../language.md)（開発者向け）にあります。
