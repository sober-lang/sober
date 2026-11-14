# 安全性ガイド

[English](security.md) | 日本語

Soberのプログラムがどんな事故から守られていて、どんな事故からは守られていないかを、脅威ごとに書きます。各節は「脅威 → Soberでの答え → 実例」の順です。実例は `examples/` の実物で、検査一式が毎回検査し（出力のある例はビルドして走らせて）、ここに載せた出力と拒否の診断を照合しています。

最後の節「[Soberが守らないもの](#12-soberが守らないもの)」も読んでください。言語が消せる事故には限りがあり、残る側を知っていることが安全の前提です。

## 0. 読み方 — 2つの層と2つの検査

Soberは事故の種類ごとに、2つの層のどちらかで答えます。

- 構造で消す: その事故を起こす形が、言語に書けない。メモリの破壊・データ競合・資源の漏れ・パストラバーサルがこちらです。書けば `sober build` も `sober check` も拒否します。
- 宣言と解析で消す: 構造では言えない性質を、解析器（analyzer）が呼び出しのグラフと値の流れから導き、宣言と照合します。エラーの取りこぼし・秘密に依存した分岐・認証つきのレスポンスの共有キャッシュへの保存・関数のエフェクトがこちらです。

解析器の規則は `sober check` だけが掛けます。 `sober build` は解析器を走らせず、受理を変えません（解析器は受理を狭めるだけで、プログラムの意味を変えないため）。この文書で「checkが拒否」と書いた規則を効かせるには、CIやコミットの前に `sober check <file.sober>` を回してください。buildが拒否する規則（構造の層）は、どちらでも止まります。

この後の各節は脅威ごとの詳しい答えですが、早見には次の3分類が目安になります。

| 分類 | 意味 | 該当節 |
|---|---|---|
| 成立しない | 言語の構造がその形を書かせない | 1節・2節 |
| 定義された死に変わる | 未定義動作でなくラベルつきのpanic。死はtask（接続単位）に閉じ、プロセスは生きる | 1節・4節・9節 |
| 残る — 利用者の設計の仕事 | 認可・ビジネスロジック・入力の意味の検証・計算量のDoS等 | 12節 |

表は早見のためのもので、脅威ごとの詳細は各節に、「残る」側の正直な説明は12節にまとめています。

## 1. メモリの破壊

脅威: 解放済みの領域を指す参照（use after free・宙吊りのポインタ）、二重解放、配列の範囲外の読み書き、nullの参照。

Soberの答え: GCも借用検査もありませんが、値の寿命をスコープの入れ子に一致させています。全部のブロックがregion（割り当ての領域）で、ブロックを出るとそこで作った値はまとめて解放されます。スコープの外へ出る値（戻り値・外の束縛への代入）は、外のregionへコピーされます。外のregionが中のregionを指すことが起きないので、宙吊りの参照が作れません。解放はregionごとなので、二重解放もありません。

- 添字と部分列は範囲を検査します。範囲外の添字はpanic（終了コード101）で止まり、隣のメモリを読み書きしません。
- 値は既定で非nullです。`nil` は `T?` の型にしか住めず、`T?` の値は `nil` でないことを確認してからでないと `T` として使えません。

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

`at` が `int?` を返すので、呼び手は範囲外の場合を書かずに値を使えません。`xs[5]` と直に書けば、範囲外はpanicで止まります。

実世界の対比: 2026年10月のNode.jsのセキュリティリリースでは、同梱のBrotli（C実装）の展開処理の境界外書き込みがリモートコード実行につながるおそれがある脆弱性（CVE-2026-111497）が修正されました。同じ形をSoberで書くと、展開器の出力の書き込みはsliceの境界検査つきなので、細工された圧縮データが起こせるのは「展開の失敗 = ラベルつきのpanic（その接続のtaskだけが死ぬ）」までです — メモリ破壊やRCEの形にはなりません。それでも、panicを起こす入力を送りつけて接続を切らせること自体は残る側です（[9節](#9-資源の枯渇サービス拒否)の受け入れの設計を参照）。


実行可能メモリの放棄: Soberのプログラムは起動の最初に、プロセスが以後「書けて実行できるメモリ」を作ることと、実行できないメモリに実行の権限を足すことを、カーネルに恒久的に禁じさせます（`PR_SET_MDWE` — Linux 6.6以降で既定装着）。Soberは実行時にコードを作らない（JITも動的なライブラリの読み込みもない）ので、失うものはありません。処理系やstdにバグがあってメモリを書き換えられても、それを注入したコードの実行へ昇格させる経路がカーネルの側で閉じています。外すAPIはプログラムの中には無いので、依存のライブラリがこれを破ることもできません。valgrindのような動的計装の下で動かすときだけ、起動時の環境変数 `SOBER_MDWE=0` で掛けずに起動できます（計装はプロセスの中でコードを作るため）。守っているのはプロセスの中のメモリ破壊からの昇格で、起動前に環境変数を操れる者はそもそも別のプログラムを走らせられるので、この環境変数はその守りを弱めません。`os.Run` で起動する子のプロセスには引き継がないので、JITを使うほかの処理系を子として動かしても壊しません。古いカーネル（6.5以前）では掛からず、プログラムはそのまま動きます。

詳しく: [言語仕様9章 メモリ](../spec/09-memory.ja.md)・[設計ノート: 安全](../design-notes/safe.md)

## 2. データ競合

脅威: 複数のスレッドが同じ可変の値を同時に読み書きして、壊れた値や順序に依存した結果が出る。

Soberの答え: 並列のスコープ（`task.Spawn` の子・`task.Map` の要素のtask）へ渡せるのは、不変の値（`freeze` したもの・不変の束縛）とチャネルだけです。`mut` の値はtaskの境界を越えません。チャネルの送り端・受け端は1つのtaskだけが所有します。共有された可変の状態が書けないので、データ競合は書けません。この規則はbuildでもcheckでも掛かります。

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

多くのtaskから1つの状態を更新したいときは、domainを使います。domainは状態を1つ持ち、その状態への呼び出しを1つずつ直列に走らせます。状態に触れるのは、本体を実行している1つのtaskだけです。そのため、共有する状態があっても、データ競合は書けません。domainにはlockの値が無いので、取り忘れも返し忘れも起こりません。lockの順序で起きるデッドロックも書けません（[並行のガイド5節](concurrency.ja.md#5-domain--多くのtaskから1つの状態へ)）。

並列の書き方そのものは [ツアー7節](tour.ja.md#7-並列--structured-concurrencyチャネル) にあります。

詳しく: [言語仕様10章 並行](../spec/10-concurrency.ja.md)

## 3. エラーの取りこぼし

脅威: 失敗した処理の結果を確認せずに先へ進む（認証の失敗を見落として通す、など）。どの関数が何で失敗しうるかがソースから見えない。

Soberの答え: エラーはラベル（`type Expired error`）で、失敗しうる関数は `(T, error?)` を返します。解析器が呼び出しのグラフから、各関数が返しうるラベルの集合を導きます。

- `switch err` は、その値が持ちうるラベルを全部覆わなければなりません（覆わない分岐は `default` で明示する）。
- errorを返す公開関数（名前が大文字で始まる関数）は、返しうるラベルを `@errors(…)` で宣言します。宣言は導出と照合され、宣言に無いラベルが返りうれば拒否します（公開関数では、宣言が導出より広くても拒否 — 古い宣言が残らない）。packageをまたぐ呼び出しは呼び先の宣言を読むので、依存先が新しい失敗を返すようになれば、宣言の変更として差分に現れます。宣言は `sober fix --errors` が導出から書けます。
- `@exhaustive` を付けた関数のswitchは、閉じた集合（unionの全variant・そのpackageの全errorラベル）の全員を列挙しなければなりません。後からvariantやラベルを足したとき、扱いを書き忘れたswitchが止まります。

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

`Revoked` の扱いを忘れたまま、`err != nil` の後をすり抜ける形はcheckが止めます（buildは解析器を走らせないので受理し、覆っていないラベルが実際に来るとpanicで止まります）。

詳しく: [ツアー5節](tour.ja.md#5-エラー--ラベルcatchswitch)・[言語仕様7章 エラー](../spec/07-errors.ja.md)・[12章A-8（@exhaustive）](../spec/12-annotations.ja.md)

## 4. panic — 止まるときは理由と位置つきで

脅威: プログラムが壊れた状態のまま走り続ける。止まっても、なぜ止まったかが分からない。

Soberの答え: panicは2種類だけです。続けると安全性が破れるもの（不変にした値への書き込み・regionの上限の超過など）と、正しいプログラムでは届かないもの（範囲外の添字・明示の `panic(L{…})`）。ファイルが無い・入力が壊れているといった普通の失敗は、panicでなくエラーのラベルで返します。

明示のpanicには理由のラベルが要ります（`Unreachable`・`InvariantBroken`・自分で宣言する `type L panic{…}`）。死ぬときは、ラベルのフィールドと位置（ファイル:行:列）を標準エラーに1行で書き、終了コード101で終わります（regionの資源が尽きたときは102）。

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

子のtaskが死んだときは、死は値でなく構造で親へ伝わります（scopeは出口で失敗になる）。死んだtaskの壊れた途中の状態で利用者のコードを走らせないため、死んだtaskの `defer` は走りません — それでも開いたファイルと接続はtaskの出口で閉じます（次の節）。

詳しく: [設計ノート: 安全 — panicはいつ起きるのか](../design-notes/safe.md#panicはいつ起きるのか)

## 5. 資源の漏れ

脅威: 開いたファイルや接続を閉じ忘れる（記述子が尽きる）、二重に閉じる、閉じた後に使う。

Soberの答え: 開いた資源（`io.File`・`io.Root`・`net.Conn` など）は同一性を持つ型で、コピーできず、開いたブロックの外へ出せず、structやチャネルにも格納できません。`io.Open` の直後の文は `defer io.Close(f)` でなければならず、`io.Close` はこの形の外に書けません。だから閉じ忘れ・早すぎるclose・二重のcloseが形として書けません。taskが死んでdeferが走らなくても、開いた記述子はtaskの出口で閉じます。接続（`net.Listen`・`net.Dial`・`net.Accept`）はforの生成元で、本体を抜けたらstdが閉じます。

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

詳しく: [言語仕様11章io](../spec/11-io.ja.md)

## 6. パストラバーサル

脅威: 利用者が送ってきたパス（`../../etc/passwd`・絶対パス・外を指すsymlink）で、公開するつもりのディレクトリの外のファイルを読まれる。

Soberの答え: 信用できないパスは、根のディレクトリ `io.Root` の下でだけ開きます。`io.OpenUnder(r, rel)` はrの下のrelだけを開き、`..` で外へ出る・絶対パス・外を指すsymlinkは解決の途中で拒否されて `io.Denied` になります。保証はカーネル（Linuxのopenat2の `RESOLVE_BENEATH`）が持ち、stdはrelを文字列として検査しません — 文字列の検査の抜け道（エンコードの違い・symlinkの差し替え）が入る余地がありません。openat2の無いカーネルでは開かずに `io.Other` を返します（開いてしまう側にはフォールバックしません）。

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

`http.server.Static`（静的ファイルの配信）はこのAPIで開きます。根の外を指すリクエストは、無いファイルと同じ404を返します（外のファイルの存在を漏らさない）。

詳しく: [言語仕様11章I-7](../spec/11-io.ja.md)・[std/http/serverのStatic](../std/http-server.ja.md#static)

## 7. タイミングで秘密が漏れる

脅威: 鍵やMACのtagのような秘密の値で分岐・添字・除算をすると、処理の時間が秘密によって変わり、外から時間を測って秘密を推測される（典型は、先頭から比べて最初の食い違いで抜ける比較）。

Soberの答え: 自分の値が秘密だと `@secret` で宣言します — 関数の前置 `@secret(k)`（仮引数kを秘密として扱う）・structのフィールドの後置・constの前置の3か所に書けます。解析器は秘密の値と、そこから算術・比較・代入・関数の結果で導いた値を追い、それが分岐の条件・switchのsubject・`&&` / `||` の左辺・添字・sliceの端・mapの鍵・`/` と `%` に届く形を拒否します。秘密を受けた関数がその仮引数を分岐に使うなら、渡した呼び出しも拒否します。`len` の結果は公開の値です。

比較にはstdの `crypto.Equal` を使います。全バイトを畳んでから最後に1回だけ判定するので、どこで食い違ったかが時間に出ません。その結果は公開の値として扱われます（stdがそう宣言しています）。std/cryptoとstd/tlsの鍵の材料は、stdの側で秘密として宣言済みです。

```sober
// examples/security_secret.sober
package main

// Security: timing — a MAC tag is compared with crypto.Equal, which does not branch on the bytes (docs/guide/security.md)

import "std/crypto"
import "std/crypto/hmac"

// the key is a secret: no branch, index or division may depend on it
@secret(key)
func valid(key []byte, msg []byte, tag []byte) bool {
    return crypto.Equal(crypto.hmac.Sum256(key, msg), tag)
}

func main() {
    key := bytes("k3y-0f-the-server")
    tag := crypto.hmac.Sum256(key, bytes("user=ada"))
    println(valid(key, bytes("user=ada"), tag))
    println(valid(key, bytes("user=root"), tag))
}
```

出力:

```
true
false
```

同じことを、先頭から比べて食い違いで抜ける比較で書くと、checkが拒否します。

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

7行目の長さの比較は通ります（長さは公開の値）。拒否されるのは、秘密の中身で分岐する12行目です。

詳しく: [言語仕様12章A-9〜A-11](../spec/12-annotations.ja.md)

## 8. 認証つきのレスポンスが共有キャッシュに載る

脅威: CookieやAuthorizationで中身が変わるレスポンス（「自分のアカウント」のページ）を、originがCDNや中継のキャッシュに保存してよいと宣言してしまう。保存されたレスポンスは、次に同じURLをリクエストした別の人に配られます（web cache deceptionの一形）。HTTPの規格はAuthorizationつきのリクエストへのレスポンスには保護を持ちますが、Cookieには同じ保護がありません。

Soberの答え: 2つの層で答えます。

- 構造（std/http/server）: 保存の方針は型のフィールド（`Route.cache`・`Response.cache`・Staticの `cache:`）でだけ書き、任意のヘッダとしてCache-Controlを書くAPIはありません。動的なレスポンスの既定は `Cache-Control: private` です。認証の値は専用のAPI `http.server.Authorization` / `http.server.Cookie` でだけ読めます（`http.server.Header` は認証のヘッダにnilを返す）。
- 解析: 共有キャッシュにも保存させる方針（`http.server.Fresh`・`http.server.Shared`）は、ルートの行でだけ書けます。そのルートのハンドラやmiddlewareが認証のAPIに届きうる形、認証のmiddlewareの下に共有の方針のルートをMountする形を、checkが拒否します。

公開の資産は共有させ、認証の後ろのAPIはprivateにする形は受理されます。

```sober
// examples/security_cache.sober
package main

// Security: shared caches — public assets may be cached by a CDN; responses that read a cookie stay private (docs/guide/security.md)

import "std/http/server"

// me depends on the session cookie, so its response must not be stored by a shared cache
func me(r http.server.Request) http.server.Response {
    sid := http.server.Cookie(r, "sid")
    return http.server.Text(if sid != nil { "signed in" } else { "guest" })
}

func main() {
    auth := http.server.Middleware{before: (r) => if http.server.Cookie(r, "sid") == nil { http.server.Status(401) } else { nil }}
    api := http.server.Mount("/api", []http.server.Route{http.server.Route{method: "GET", path: "/me", handler: me, cache: http.server.Private{maxAge: 30}}}, []http.server.Middleware{auth})
    assets := http.server.Static("/assets", "/srv/www", cache: http.server.Shared{maxAge: 3600, sMaxAge: 86400})
    routes := http.server.Merge(api, assets)
    println(len(routes))
}
```

出力:

```
2
```

Cookieを読むハンドラのルートに共有の方針を書くと、checkが拒否します。

```sober
// examples/security_cache_neg.sober
package main

// Security: shared caches — a route that lets a CDN store its response must not read a cookie (rejected by check) (docs/guide/security.md)

import "std/http/server"

func me(r http.server.Request) http.server.Response {
    sid := http.server.Cookie(r, "sid")
    return http.server.Text(if sid != nil { "signed in" } else { "guest" })
}

func main() {
    routes := []http.server.Route{http.server.Route{method: "GET", path: "/me", handler: me, cache: http.server.Shared{maxAge: 60}}}
    println(len(routes))
}
```

拒否:

```
examples/security_cache_neg.sober:13:35: error: the shared cache policy 'Shared' meets a handler or middleware that reaches a credential source (server.Authorization / server.Cookie / Request.head) in one route — a response that depends on Authorization / Cookie must not be stored by a shared cache — it would be served to other users (language.md 12 節「出所の依存」); use server.Private / server.NoStore for this route, or move the credential read out of it (Analyzer)
```

詳しく: [std/http/serverのCache](../std/http-server.ja.md#cache)・[言語仕様12章A-12・A-13](../spec/12-annotations.ja.md)

## 9. 資源の枯渇（サービス拒否）

脅威: 大量の接続、大きなリクエスト、メモリを食うリクエストで、サーバ全体が止まる・メモリを使い切る。

Soberの答え: サーバ（`net.Serve`）は3つの層で資源に上限を持ちます。

- 受け入れ（admission）: `conns:` は同時の接続の数の上限です（既定10000）。上限を超えた接続には、利用者のコードを走らせずに `reject:` のバイト列を送って閉じます。
- 予算（`budget:`）: 接続1本が使うメモリの上界の宣言です（既定64 KiB）。受け入れの上限は `conns × budget` のバイト数で数えます。task一般でも、`task.Spawn` などに `budget:` を書くと、上限に入らない子は並列にせず逐次に走ります（値と出力は変わりません）。
- regionの上限（`region:`）: 接続のtaskのregion 1つの上限です（既定128 MiB）。超えたらその接続のtaskだけが死に、Serveは吸収して他の接続を続けます。

HTTPの層では、リクエストの頭と本文に上限があります（`http.server.ServeConn` の `maxHead:` 既定8 KiBを超えたら431・`maxBody:` 既定16 KiBを超えたら413 — ハンドラは走りません）。待ちには期限を付けられます（`task.Run(…, deadline:)` — 期限の後のioは `io.Expired` を返し、netの待ちは期限で切れる）。

```sober
// examples/security_limits.sober
package main

// Security: resource exhaustion — admission, a per-connection budget and a per-connection region cap (docs/guide/security.md)
// a server: check and build only (it does not stop by itself)

import "std/http/server"
import "std/net"
import "std/task"

func route(r http.server.Request) http.server.Response {
    return http.server.Text("ok")
}

// app serves one connection; oversized heads and bodies get 431 / 413 before route runs
func app(c net.Conn) error? {
    return http.server.ServeConn(c, route, maxHead: 8 * task.KB, maxBody: 64 * task.KB)
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

この例はサーバなので、検査一式はcheckとビルドまでを確認します（走らせて止まらないため、出力の照合はありません）。

詳しく: [std/netのServe](../std/net.ja.md)・[言語仕様10章10.6予算・プール・期限](../spec/10-concurrency.ja.md)・[std/http/serverのServeConn](../std/http-server.ja.md)

## 10. 関数が隠れて何かをする

脅威: 純粋な計算のつもりの関数が、いつの間にかログを書く・ネットワークに出る・時刻を読む・待ちに入る。依存先の関数がそう変わっても、呼び手のソースからは見えない。

Soberの答え: 関数のエフェクトを解析器が導出します。語彙は4つです — `block`（待ちに入りうる）・`io`（プロセスの外と出入りする — `println` を含む）・`panic`（明示の `panic(L{…})`）・`nondet`（時刻の読みなど、入力を固定しても揺れる値）。呼んだ関数のエフェクトは呼び手のエフェクトです。

`@effects(…)` は「この関数のエフェクトは、ここに書いたものに収まる」という主張で、checkが導出と照合します。

- 否定形 `@effects(!io, !block)` は人の意図の主張です。将来その関数にioが入ったら、宣言の位置で止まり、入った呼び出しを特定します。
- 正の列挙 `@effects(io)` は許すエフェクトの上界です。`sober fix --effects` が導出から書けます。
- 名前付き関数型の後置 `type Rule func(…) R @effects(…)` は、その型の値（ラムダ・関数）全部への契約です。

標準ライブラリの公開関数は、全部が `@effects` を宣言しています（[stdリファレンス](../std/README.ja.md)の各関数の署名に出ています）。宣言は導出と一致することが検査されているので、stdの関数がいつからioをするようになったかは、宣言の変更として差分に現れます。

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

ioをしないと宣言した関数が、ログの関数を呼び始めると止まります。

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

同じ導出は、ワーカー局所の作業域を借りる `task.Lease` のウィンドウの警告にも使われています（ウィンドウの中で待ちに入りうると、借りが新しい割り当てにフォールバックして遅くなる — 拒否ではなく警告）。関数値を通した待ちも、この導出で見えます。

詳しく: [言語仕様12章12.5関数のエフェクト](../spec/12-annotations.ja.md)

## 11. サプライチェーン

脅威: 依存のパッケージ、ビルドの道具、実行時のライブラリに、悪意のあるコードや脆弱性が混ざる。実行環境のイメージに余計なものが載る。

Soberの答え:

- 依存ゼロ。コンパイラはlibcにもLLVMにも依らない静的なELF 1つで、出力の実行ファイルも静的なELFです。標準ライブラリは外部のライブラリに依りません。パッケージ管理の道具はまだ無く、プログラムがimportできるのはstdと自分のソースのpackageだけです。
- 完全ブートストラップ。コンパイラは凍結したZig製の最初の版から、`bootstrap/` のソースのスナップショットを順にビルドして作ります。種のバイナリはありません（[インストール](install.ja.md)）。
- 実行環境を空にできる。出力が静的なELF 1つなので、コンテナのイメージは `FROM scratch` に実行ファイル1つを置くだけで足ります — シェルもlibcもパッケージも載りません。HttpArenaの提出物の [Dockerfile](../../bench/httparena/Dockerfile) がこの形です（ビルドするステージはsoberの公式イメージ、走るステージはscratch）。PID 1として走らせてもSIGTERM / SIGINTで止まるので、initの道具も要りません。io_uringと資源の上限の設定は [インストールの「サーバを走らせる」](install.ja.md#サーバを走らせる) を見てください。

## 12. Soberが守らないもの

言語が消せる事故には限りがあります。次のものは、Soberを使っても書き手の責任のまま残ります。

- 認可とビジネスロジック: 誰が何をしてよいか、そのリクエストがその利用者に許されるか、金額や在庫の規則が正しいか。言語はこれを消しません。認証の値を読んで分岐するのは正しいプログラムの普通の形で、その分岐が正しいかは言語には分かりません。
- 解析器を回さない場合: 3・7・8・10節の規則は `sober check` だけが掛けます。buildだけで済ませると効きません。
- 入力の意味の検証: 型とUTF-8の検査の先 — 値の範囲・形式・業務上の妥当さ — は書き手が確認します。
- SQL injection: `std/pg` を使う範囲では書けません。SQLの文面は文字列リテラルかconstに限られ、値は必ず引数で渡します（[PostgreSQLのガイド 2節](postgres.ja.md)）。std/pg以外の経路でSQLを組み立てて送る場合は、この保護の外です。
- 秘密の扱いの誤り: `@secret` が見るのはソースの上のタイミングの流れ（分岐・添字・除算）だけです。秘密をログやレスポンスに書き出すこと（印字は検査の対象外）、鍵やnonceの使い回し、乱数の誤用は止めません。利用者のコードについて、生成された機械語に分岐が無いことまでは確認しません。
- キャッシュの残り: CDN側の設定が `private` を無視して保存する場合・Varyの漏れ・queryや本文に載せたtoken・相手のIPで変わるレスポンスは、8節の検査の外です。
- 計算で詰まるリクエスト: 期限（`deadline:`）は待ちの上限であって、実行時間の上限ではありません。走っている計算は止めません。重い計算を受けるエンドポイントには、書き手が入力の大きさの上限を置いてください。また、処理中の接続を流し切る優雅な停止はまだありません（止めると処理中の接続は切れます）。
- 同じuidのプロセスとのportの共有: `net.Listen` はSO_REUSEPORTを立てます（`net.Serve` がワーカーごとに同じ番地のlistenerを足して、acceptをワーカーごとに並べるため）。このため、同じuidで動く別のプロセスは同じ番地にbindでき、届く接続をカーネルの振り分けで分け合います。同じ番地での2つ目の起動は「使用中」で失敗せず、黙って接続の一部を受けます。別のuidのプロセスはbindできません。同じuidは、もともとptraceや `/proc/<pid>/mem` でプロセスに届く範囲の内側なので新しい境界の破れではありませんが、サービスごとにuidを分けてください（systemdの `DynamicUser`・コンテナの既定の分け方）。
- 証明の射程: メモリ安全・データ競合自由は、言語のコアを形式化したモデルでLean 4により証明していますが、証明されているのはモデルの性質で、コンパイラの実装そのものではありません（[設計ノート: 安全](../design-notes/safe.md#その安全性はどこまで証明されているのか)）。コンパイラ・ランタイム・カーネルの不具合は、この文書のどの答えの外にもあります。

---

この文書は、言語に新しい安全の機構が入るたびに節が増えます。規則の正確な定義は [言語仕様](../spec/README.ja.md) に、決定の経緯は [決定の記録](../language.md)（開発者向け）にあります。
