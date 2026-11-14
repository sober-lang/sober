# Webクライアント

[English](web-client.md) | 日本語

`std/http/client` で外のHTTP APIを呼ぶ書き方を、小さな題材で順に見ていきます。題材は「外のAPIを叩いて、ログインの状態を持つ小さなWebアプリ」の、外へ出ていく側です（受ける側は [Webサーバ](web-server.ja.md)）。

例はどれも、外のAPIの代役を同じプロセスの中で `std/http/server` で立て、そこへ繋ぎます。リポジトリの検査が例を走らせて出力を照合するためで、本物のAPIに向けるときはURLを差し替えるだけです。`https://` も同じ書き方で、証明書チェーンは常に検証されます（検証を切るフィールドはありません）。

前提: [言語ツアー](tour.ja.md) の1〜5節と、エラーの扱い（`?` と `catch`）。

## 1. 単発のリクエスト — `http.client.Request`

`http.client.Request` にURLを渡すとレスポンスが返ります。クライアントは状態を持たないので、作っておく値はありません。期限や上限の方針は省けばどれも安全な側の既定です（3節）。

```sober
// examples/web_client_do.sober
package main

// Web クライアントのガイド 1 節（docs/guide/web-client）: http.client.Request の一発。外の API の代わりに、同じプロセスの中で std/http/server の
// 小さなAPIを立てて繋ぐ（本物のAPIならurlを差し替えるだけ — httpsも同じ書き方で、証明書のチェーンは常に検証される）

import "std/http/client"
import "std/http/server"
import "std/net"
import "std/task"

// 外の API の代役: GET /v1/items は JSON の配列を返す
func api(r http.server.Request) http.server.Response {
    return if r.path == "/v1/items" { http.server.Json("[{\"id\":1,\"name\":\"apple\"},{\"id\":2,\"name\":\"pear\"}]") } else { http.server.Status(404) }
}

func fetch(base string) []string {
    r, e := http.client.Request("${base}/v1/items")
    if e != nil {
        return []string{"request failed"}
    }
    ct := http.client.Header(r, "content-type")
    return []string{"status ${r.status}", "content-type ${if ct != nil { ct } else { "-" }}", string(r.body) catch ""}
}

func serve(l net.Listener, n int) error? {
    mut k := 0
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, api)?
        k = k + 1
        if k == n {
            break
        }
    }
    return nil
}

func main() {
    e := net.Listen("127.0.0.1:0", (l) => {
        base := "http://127.0.0.1:${net.Port(l)}"
        got, _ := task.Run((s) => {
            h := task.Spawn(s, () => fetch(base))
            _ = serve(l, 1)
            task.Join(h)
        })
        for line <- got {
            println(line)
        }
    })
    if e != nil {
        println("listen failed")
    }
}
```

出力:

```
status 200
content-type application/json
[{"id":1,"name":"apple"},{"id":2,"name":"pear"}]
```

- `method:` を省くとGETです。`headers:` は `[]http.Field`（`std/http` の共有の型）で、`Host`・`Content-Length`・`Transfer-Encoding`・`Connection` はstdが書くので書けません（書くとpanic）
- レスポンスの `headers` の名前は小文字に揃っています。`http.client.Header(r, name)` は大文字小文字を区別せずに最初の1本を返します
- `Request` はリクエストごとに接続を張って閉じます。同じ相手に何度も送るなら6節のセッションを使います

## 2. 失敗をラベルで分ける

`Request` の失敗はerrorのラベルで分けられます。`switch` で受けると、どの失敗をどう扱うかがそのまま書けます。

```sober
// examples/web_client_errors.sober
package main

// Web クライアントのガイド 2 節: 失敗はラベルで分ける。誰も待っていない port は Closed・形の誤った URL は BadUrl・
// 受けるだけでレスポンスを返さない相手は期限（Policy の timeout）で Timeout

import "std/http/client"
import "std/net"
import "std/task"

func label(e error?) string {
    return switch e {
    case nil: "ok"
    case http.client.Closed{}: "Closed"
    case http.client.BadUrl{}: "BadUrl"
    case http.client.Timeout{}: "Timeout"
    case http.client.Dns{}: "Dns"
    case http.client.Tls{}: "Tls"
    default: "other"
    }
}

func main() {
    pol := http.client.Policy{timeout: 300 * task.MS}
    _, e1 := http.client.Request("http://127.0.0.1:1/", policy: pol)
    println("refused: ${label(e1)}")
    _, e2 := http.client.Request("ftp://example.com/", policy: pol)
    println("bad url: ${label(e2)}")
    e := net.Listen("127.0.0.1:0", (l) => {
        _, e3 := http.client.Request("http://127.0.0.1:${net.Port(l)}/", policy: pol)
        println("silent: ${label(e3)}")
    })
    if e != nil {
        println("listen failed")
    }
}
```

出力:

```
refused: Closed
bad url: BadUrl
silent: Timeout
```

| ラベル | 起きること |
|---|---|
| `http.client.Dns` | 名前が引けない（causeに `net.NoHost` など） |
| `http.client.Tls` | TLSの失敗（証明書チェーンの検証・相手のalert — causeに内側の誤り） |
| `http.client.Timeout` | リクエスト1本の期限（Policyの `timeout`）が過ぎた |
| `http.client.Closed` | 相手が接続を拒んだ・レスポンスの途中で閉じた |
| `http.client.BadUrl` | URLの形の誤り（schemeがhttp / httpsでない・userinfo・空白や制御文字） |
| `http.client.BadResponse` | レスポンスの形の誤り |
| `http.client.BodyTooLarge` | 本文が上限（Policyの `maxBody`）を超えた |
| `http.client.TooManyRedirects` | redirectが上限を超えた |
| `http.client.InsecureRedirect` | httpsからhttpへのredirect（降格は追わない） |
| `http.client.ProxyRefused` | proxyがCONNECTを断った |

4xx・5xxのレスポンスは失敗ではなく、`r.status` に入ったレスポンスとして返ります。

## 3. 期限・上限・redirect — `http.client.Policy`

方針は `http.client.Policy` というただのstructで、`policy:` に渡します。フィールドは全部省けて、省いた値が安全な側の既定です（`http.client.Policy{}` も `policy:` を書かないのも同じ）。緩めるフィールドは `dangerously` で始まる綴りなので、緩めた所はgrepで拾えます。方針は値なので、変数に置いて何本ものリクエストで使い回せます。

| フィールド | 既定 | 意味 |
|---|---|---|
| `timeout` | 30秒 | リクエスト1本の全体の期限（ns — `5 * time.Second` や `5000 * task.MS` の形で書く・7節） |
| `maxBody` | 8 MiB | 本文の上限（上限は1 GiB — 無制限は書けない） |
| `redirects` | 10 | 追うredirectの回数（0 = 追わない — 3xxをそのまま返す） |
| `userAgent` | `"sober"` | User-Agent |
| `extraRoots` | なし | 信頼の起点に足す `tls.Roots`（8節） |
| `proxy` / `proxyAuth` | なし | 通すproxy（8節） |
| `dangerouslyAllowTls12` | false | TLS 1.2も申し出る（既定は1.3だけ） |

redirectを追うとき、originが変われば `Authorization` と `Cookie` の頭と `cookies:` は落とします。301 / 302 / 303はPOSTをGETに変えて本文を落とし、307 / 308は保ちます。

## 4. ログインの状態を持つ — cookieは値

クライアントはcookieを貯めません。レスポンスの `Set-Cookie` から `http.client.CookieValue(r, name)` で値を取り出して自分で持ち、次のリクエストの `cookies:` に載せます。何が送られるかは呼び出しに書いてある分だけです。

```sober
// examples/web_client_session.sober
package main

// Web クライアントのガイド 4 節: ログインの状態は cookie の値として自分で持つ。外の API の代役は POST /login で
// セッションの cookie を置き（Set-Cookie は型のフィールド cookies だけで書く）、GET /me はその cookie を読む。客はレスポンスから CookieValue で取り出し、
// 次のリクエストの cookies: に載せる — 載せたものだけが届く

import "std/http/client"
import "std/http/server"
import "std/net"
import "std/task"

func api(r http.server.Request) http.server.Response {
    if r.method == "POST" && r.path == "/login" {
        return http.server.Response{status: 200, contentType: "text/plain", body: bytes("welcome"), cookies: []http.server.SetCookie{http.server.SetCookie{name: "sid", value: "s123", dangerouslyAllowHttp: true}}}
    }
    if r.path == "/me" {
        sid := http.server.Cookie(r, "sid")
        return http.server.Text(if sid != nil { "you are ${sid}" } else { "who are you?" })
    }
    return http.server.Status(404)
}

func visit(base string) []string {
    r1, _ := http.client.Request("${base}/login", method: "POST")
    sid := http.client.CookieValue(r1, "sid")
    if sid == nil {
        return []string{"no session"}
    }
    r2, _ := http.client.Request("${base}/me", cookies: []http.client.Cookie{http.client.Cookie{name: "sid", value: sid}})
    r3, _ := http.client.Request("${base}/me")
    return []string{"login: ${string(r1.body) catch ""} (sid ${sid})", "with cookie: ${string(r2.body) catch ""}", "without: ${string(r3.body) catch ""}"}
}

func serve(l net.Listener, n int) error? {
    mut k := 0
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, api)?
        k = k + 1
        if k == n {
            break
        }
    }
    return nil
}

func main() {
    e := net.Listen("127.0.0.1:0", (l) => {
        base := "http://127.0.0.1:${net.Port(l)}"
        got, _ := task.Run((s) => {
            h := task.Spawn(s, () => visit(base))
            _ = serve(l, 3)
            task.Join(h)
        })
        for line <- got {
            println(line)
        }
    })
    if e != nil {
        println("listen failed")
    }
}
```

出力:

```
login: welcome (sid s123)
with cookie: you are s123
without: who are you?
```

持った値は普通の文字列なので、ファイルやDBに置いて次の起動で使うこともできます。`CookieValue` は値だけを読み、`Path` や `Max-Age` などの属性は読みません。いつ捨てるかは、相手のAPIの約束に合わせて自分で決めます。

## 5. 本文を切片で受ける — `http.client.Stream`

大きな本文や、少しずつ届く本文（ログ・イベントの列）は `http.client.Stream` で受けます。レスポンスを丸ごと積まず、届いた切片をそのまま渡します。

```sober
// examples/web_client_stream.sober
package main

// Web クライアントのガイド 5 節: http.client.Stream で本文を切片のまま受ける（レスポンスを丸ごと積まない）。最初の要素は頭と空の切片で、
// 以降は届いた切片。外の API の代役は長さ不定（chunked）の本文を 3 回に分けて送る

import "std/http/client"
import "std/http/server"
import "std/iter"
import "std/net"
import "std/task"

func api(r http.server.Request) http.server.Response {
    return http.server.Response{status: 200, contentType: "text/plain", cache: http.server.NoStore{}, stream: (out, emit) => feed(mut out, emit)}
}

func feed(out mut http.server.Out, emit func(out mut http.server.Out, b []byte) error?) error? {
    for i <- iter.Range(1, 4) {
        emit(mut out, bytes("line ${i}\n"))?
    }
    return nil
}

func fetch(base string) []string {
    mut lines := mut []string{}
    mut total := 0
    e := http.client.Stream("${base}/feed", (part) => {
        if len(part.chunk) == 0 {
            lines = append(lines, "status ${part.head.status}")
        }
        total = total + len(part.chunk)
    })
    lines = append(lines, if e == nil { "received ${total} bytes" } else { "stream failed" })
    return freeze(lines)
}

func serve(l net.Listener) error? {
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, api)?
        break
    }
    return nil
}

func main() {
    e := net.Listen("127.0.0.1:0", (l) => {
        base := "http://127.0.0.1:${net.Port(l)}"
        got, _ := task.Run((s) => {
            h := task.Spawn(s, () => fetch(base))
            _ = serve(l)
            task.Join(h)
        })
        for line <- got {
            println(line)
        }
    })
    if e != nil {
        println("listen failed")
    }
}
```

出力:

```
status 200
received 21 bytes
```

本文の合計がPolicyの `maxBody` を超えると `BodyTooLarge` で止まります。大きいファイルを受けるなら `maxBody` を明示して上げます。

## 6. 同じ相手に何度も — `http.client.Open` と `http.client.Send`

`http.client.Open` は1つのoriginへ接続を張り、`Session` を渡します（`policy:` はセッションの全往復に掛かります）。その中の `http.client.Send` は同じ接続の上で往復します（keep-alive）。`Session` は `Open` に渡した関数の仮引数としてだけ生まれる値で、コピーする・フィールドに入れる・外へ持ち出すことはできません。関数が返ると接続が閉じます。

```sober
// examples/http_client_session.sober
package main

// HTTP クライアントのセッション（std/http/client の Open / Send）: 1 本の接続の上でリクエストを 3 往復。loopback で、親の task が接続を 1 本だけ受けて
// std/http/server のサーバの役をし（ServeConn — keep-alive）、子の task が Open の範囲の中で Send を 3 回呼ぶ。Session は Open の k の仮引数としてだけ生まれ、
// k が返ると接続が閉じる（同一性の型 — コピー・フィールド・捕捉・持ち出しは負例 client_neg_*）

import "std/http/client"
import "std/http/server"
import "std/net"
import "std/task"

func route(r http.server.Request) http.server.Response {
    return http.server.Text("${r.method} ${r.path}")
}

func fetch(port int) []string {
    mut out := mut []string{}
    paths := []string{"/a", "/b", "/c"}
    e := http.client.Open("http://127.0.0.1:${port}", (s) => {
        for p <- paths {
            r, err := http.client.Send(s, p)
            out = append(out, if err == nil { "${r.status} ${string(r.body) catch ""}" } else { "error" })
        }
    })
    if e != nil {
        out = append(out, "open failed")
    }
    return freeze(out)
}

func serveOne(l net.Listener) error? {
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, route)?
        break
    }
    return nil
}

func main() {
    e := net.Listen("127.0.0.1:0", (l) => {
        port := net.Port(l)
        got, _ := task.Run((s) => {
            h := task.Spawn(s, () => fetch(port))
            _ = serveOne(l)
            task.Join(h)
        })
        for line <- got {
            println(line)
        }
    })
    if e != nil {
        println("listen failed")
    }
}
```

出力:

```
200 GET /a
200 GET /b
200 GET /c
```

## 7. 時刻と期限 — `std/time`

期限も経過もnsの `int` です。Policyの `timeout` に渡す値と、`std/time` で測った経過は同じ基準で比べられます。

```sober
// examples/web_client_time.sober
package main

// Web クライアントのガイド 7 節: 時刻と期限。経過は単調時計（time.Mono / time.Since）で測り、レスポンスの日付の頭は
// time.ParseHTTP で壁時計の Time に読む（Retry-After）。Policy の timeout と time.Since はどちらも ns の int で、同じ基準で比べられる

import "std/http"
import "std/http/client"
import "std/http/server"
import "std/net"
import "std/task"
import "std/time"

// 外の API の代役: GET /v1/report は混んでいる — 503 と、いつ出直せばよいかの Retry-After（HTTP の日付の形）を返す
func api(r http.server.Request) http.server.Response {
    return if r.path == "/v1/report" {
        http.server.Response{status: http.ServiceUnavailable, contentType: "text/plain", body: bytes("busy"),
            headers: http.server.Headers{list: []http.Field{http.Field{name: "Retry-After", value: "Sun, 06 Nov 1994 08:49:37 GMT"}}}}
    } else {
        http.server.Status(404)
    }
}

func fetch(base string) []string {
    budget := 2 * time.Second
    start := time.Mono()
    r, e := http.client.Request("${base}/v1/report", policy: http.client.Policy{timeout: budget})
    took := time.Since(start)
    if e != nil {
        return []string{"request failed"}
    }
    mut out := []string{"status ${r.status}", "within budget: ${took < budget}"}
    ra := http.client.Header(r, "retry-after")
    if ra != nil {
        t, pe := time.ParseHTTP(ra)
        if pe == nil {
            out = append(out, "retry after (UTC) ${time.FormatRFC3339(t, 0)}")
            out = append(out, "retry after (JST) ${time.FormatRFC3339(t, 9 * 3600)}")
            out = append(out, "may retry now: ${time.Before(t, time.Now())}")
        }
    }
    return out
}

func serve(l net.Listener, n int) error? {
    mut k := 0
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, api)?
        k = k + 1
        if k == n {
            break
        }
    }
    return nil
}

func main() {
    e := net.Listen("127.0.0.1:0", (l) => {
        base := "http://127.0.0.1:${net.Port(l)}"
        got, _ := task.Run((s) => {
            h := task.Spawn(s, () => fetch(base))
            _ = serve(l, 1)
            task.Join(h)
        })
        for line <- got {
            println(line)
        }
    })
    if e != nil {
        println("listen failed")
    }
}
```

出力:

```
status 503
within budget: true
retry after (UTC) 1994-11-06T08:49:37Z
retry after (JST) 1994-11-06T17:49:37+09:00
may retry now: true
```

- `time.Second` と `task.MS` は同じ単位（ns）の定数です。`2 * time.Second` と `2000 * task.MS` は同じ値です
- `timeout` はリクエスト1本の全体の期限です。接続・TLSの握手・頭・本文の読み終わりまでを含みます。`Stream` は最後の切片を受け終わるまでが1本なので、長く流れるレスポンスには長い期限を渡します。`Open` は経路の層（proxy・TLSの握手）を張り終わるまで、`Send` は往復1回ごとに期限が掛かります
- 経過は単調時計で測ります（`time.Mono` が `time.Instant` を返し、`time.Since` がnsを返す）。壁時計の `time.Time` は時刻の調整で戻ることがあるので、期限の計算には使えません。2つは別の型なので、取り違えると型の誤りになります
- 何本かのリクエストにまとめて予算を掛けるなら、残り `budget - time.Since(start)` を次のリクエストの `policy: http.client.Policy{timeout: …}` に渡します
- レスポンスの頭の日付（`Date`・`Retry-After`・`Last-Modified`）は `time.ParseHTTP`、JSONの中の時刻（RFC 3339）は `time.ParseRFC3339` で `time.Time` に読みます。`Retry-After` は秒数の形もあるので、`ParseHTTP` が失敗したら整数として読みます
- 表示のオフセットは秒で渡します（日本は `9 * 3600`）。夏時間のある地域は `time.LoadZone` の `Zone` から `time.OffsetAt` で引きます

## 8. 私的PKIとproxy

- 私的PKI: 社内のCAで署名したサーバには `http.client.Policy{extraRoots: tls.ParseRoots(pem)?}` で起点を足します。PEMが読めなければ `ParseRoots` が `tls.BadRoots` を返すので、リクエストを送る前に分かります。足した起点で止まるチェーンにはWebPKIの規則（CA/B）を掛けません。焼き込みのWebPKIのルート（Mozilla NSS）は残ったままです
- proxy: `http.client.Policy{proxy: http.client.ParseProxy("http://proxy.internal:3128")?}`（形が違えば `http.client.BadProxy`）。httpsのリクエストはCONNECTのトンネルを通り、TLSは相手のサーバと直に結びます。`proxyAuth` には `Proxy-Authorization` の値そのもの（`"Basic …"`）を渡します。環境変数（`HTTPS_PROXY` など）は読みません

## 9. 何を守っているか

- 証明書チェーンは常に検証する（検証を切るフィールドが無い）
- 本文の上限・リクエストの期限・redirectの回数は既定で付いている（無制限は書けない）
- httpsからhttpへは降りない・originが変われば認証の頭を落とす
- 送る頭のうち、リクエストの枠を決めるもの（`Host`・`Content-Length` など）はstdだけが書く

