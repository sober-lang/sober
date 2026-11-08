# Web クライアント

[English](web-client.md) | 日本語

`std/http/client` で外の HTTP API を呼ぶ書き方を、小さな題材で順に見ていきます。題材は「外の API を叩いて、ログインの状態を持つ小さな Web アプリ」の、外へ出ていく側です（受ける側は [Web サーバ](web-server.ja.md)）。

例はどれも、外の API の代役を同じプロセスの中で `std/http/server` で立て、そこへ繋ぎます。リポジトリの検査が例を走らせて出力を照合するためで、本物の API に向けるときは URL を差し替えるだけです。`https://` も同じ書き方で、証明書の鎖は常に検証されます（検証を切る欄はありません）。

前提: [言語ツアー](tour.ja.md) の 1〜5 節と、エラーの扱い（`?` と `catch`）。

## 1. 一発の要求 — `http.client.Request`

`http.client.Request` に URL を渡すと応答が返ります。クライアントは状態を持たないので、作っておく値はありません。期限や上限の方針は省けばどれも安全な側の既定です（3 節）。

```sober
// examples/web_client_do.sober
package main

// Web クライアントのガイド 1 節（docs/guide/web-client）: http.client.Request の一発。外の API の代わりに、同じプロセスの中で std/http/server の
// 小さな API を立てて繋ぐ（本物の API なら url を差し替えるだけ — https も同じ書き方で、証明書の鎖は常に検証される）

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

- `method:` を省くと GET です。`headers:` は `[]http.Field`（`std/http` の共有の型）で、`Host`・`Content-Length`・`Transfer-Encoding`・`Connection` は std が書くので書けません（書くと panic）
- 応答の `headers` の名前は小文字に揃っています。`http.client.Header(r, name)` は大文字小文字を区別せずに最初の 1 本を返します
- `Request` は要求ごとに接続を張って閉じます。同じ相手に何度も送るなら 6 節の束を使います

## 2. 失敗をラベルで分ける

`Request` の失敗は error のラベルで分けられます。`switch` で受けると、どの失敗をどう扱うかがそのまま書けます。

```sober
// examples/web_client_errors.sober
package main

// Web クライアントのガイド 2 節: 失敗はラベルで分ける。誰も待っていない port は Closed・形の誤った URL は BadUrl・
// 受けるだけで応答しない相手は期限（Policy の timeout）で Timeout

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
| `http.client.Dns` | 名前が引けない（cause に `net.NoHost` など） |
| `http.client.Tls` | TLS の失敗（証明書の鎖の検証・相手の alert — cause に内側の誤り） |
| `http.client.Timeout` | 要求 1 本の期限（Policy の `timeout`）が過ぎた |
| `http.client.Closed` | 相手が接続を拒んだ・応答の途中で閉じた |
| `http.client.BadUrl` | URL の形の誤り（scheme が http / https でない・userinfo・空白や制御文字） |
| `http.client.BadResponse` | 応答の形の誤り |
| `http.client.BodyTooLarge` | 本文が上限（Policy の `maxBody`）を超えた |
| `http.client.TooManyRedirects` | redirect が上限を超えた |
| `http.client.InsecureRedirect` | https から http への redirect（降格は追わない） |
| `http.client.ProxyRefused` | proxy が CONNECT を断った |

4xx・5xx の応答は失敗ではなく、`r.status` に入った応答として返ります。

## 3. 期限・上限・redirect — `http.client.Policy`

方針は `http.client.Policy` というただの struct で、`policy:` に渡します。欄は全部省けて、省いた値が安全な側の既定です（`http.client.Policy{}` も `policy:` を書かないのも同じ）。緩める欄は `dangerously` で始まる綴りなので、緩めた所は grep で拾えます。方針は値なので、変数に置いて何本もの要求で使い回せます。

| 欄 | 既定 | 意味 |
|---|---|---|
| `timeout` | 30 秒 | 要求 1 本の全体の期限（ns — `5 * time.Second` や `5000 * task.MS` の形で書く・7 節） |
| `maxBody` | 8 MiB | 本文の上限（上限は 1 GiB — 無制限は書けない） |
| `redirects` | 10 | 追う redirect の回数（0 = 追わない — 3xx をそのまま返す） |
| `userAgent` | `"sober"` | User-Agent |
| `extraRoots` | なし | 信頼の起点に足す `tls.Roots`（8 節） |
| `proxy` / `proxyAuth` | なし | 通す proxy（8 節） |
| `dangerouslyAllowTls12` | false | TLS 1.2 も申し出る（既定は 1.3 だけ） |

redirect を追うとき、origin が変われば `Authorization` と `Cookie` の頭と `cookies:` は落とします。301 / 302 / 303 は POST を GET に変えて本文を落とし、307 / 308 は保ちます。

## 4. ログインの状態を持つ — cookie は値

クライアントは cookie を貯めません。応答の `Set-Cookie` から `http.client.CookieValue(r, name)` で値を取り出して自分で持ち、次の要求の `cookies:` に載せます。何が送られるかは呼び出しに書いてある分だけです。

```sober
// examples/web_client_session.sober
package main

// Web クライアントのガイド 4 節: ログインの状態は cookie の値として自分で持つ。外の API の代役は POST /login で
// セッションの cookie を置き（Set-Cookie は型の欄 cookies だけで書く）、GET /me はその cookie を読む。客は応答から CookieValue で取り出し、
// 次の要求の cookies: に載せる — 載せたものだけが届く

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

持った値は普通の文字列なので、ファイルや DB に置いて次の起動で使うこともできます。`CookieValue` は値だけを読み、`Path` や `Max-Age` などの属性は読みません。いつ捨てるかは、相手の API の約束に合わせて自分で決めます。

## 5. 本文を切片で受ける — `http.client.Stream`

大きな本文や、少しずつ届く本文（ログ・イベントの列）は `http.client.Stream` で受けます。応答を丸ごと積まず、届いた切片をそのまま渡します。

```sober
// examples/web_client_stream.sober
package main

// Web クライアントのガイド 5 節: http.client.Stream で本文を切片のまま受ける（応答を丸ごと積まない）。最初の要素は頭と空の切片で、
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

本文の合計が Policy の `maxBody` を超えると `BodyTooLarge` で止まります。大きいファイルを受けるなら `maxBody` を明示して上げます。

## 6. 同じ相手に何度も — `http.client.Open` と `http.client.Send`

`http.client.Open` は 1 つの origin へ接続を張り、`Session` を渡します（`policy:` は束の全往復に掛かります）。その中の `http.client.Send` は同じ接続の上で往復します（keep-alive）。`Session` は `Open` に渡した関数の仮引数としてだけ生まれる値で、写す・欄に入れる・外へ持ち出すことはできません。関数が返ると接続が閉じます。

```sober
// examples/http_client_session.sober
package main

// HTTP クライアントの束（std/http/client の Open / Send）: 1 本の接続の上で要求を 3 往復。loopback で、親の task が接続を 1 本だけ受けて
// std/http/server のサーバの役をし（ServeConn — keep-alive）、子の task が Open の範囲の中で Send を 3 回呼ぶ。Session は Open の k の仮引数としてだけ生まれ、
// k が返ると接続が閉じる（同一性の型 — 写し・欄・捕獲・持ち出しは負例 client_neg_*）

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

期限も経過も ns の `int` です。Policy の `timeout` に渡す値と、`std/time` で測った経過は同じ物差しで比べられます。

```sober
// examples/web_client_time.sober
package main

// Web クライアントのガイド 7 節: 時刻と期限。経過は単調時計（time.Mono / time.Since）で測り、応答の日付の頭は
// time.ParseHTTP で壁時計の Time に読む（Retry-After）。Policy の timeout と time.Since はどちらも ns の int で、同じ物差しで比べられる

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
- `timeout` は要求 1 本の全体の期限です。接続・TLS の握手・頭・本文の読み終わりまでを含みます。`Stream` は最後の切片を受け終わるまでが 1 本なので、長く流れる応答には長い期限を渡します。`Open` は経路の層（proxy・TLS の握手）を張り終わるまで、`Send` は往復 1 回ごとに期限が掛かります
- 経過は単調時計で測ります（`time.Mono` が `time.Instant` を返し、`time.Since` が ns を返す）。壁時計の `time.Time` は時刻の調整で戻ることがあるので、期限の計算には使えません。2 つは別の型なので、取り違えると型の誤りになります
- 何本かの要求にまとめて予算を掛けるなら、残り `budget - time.Since(start)` を次の要求の `policy: http.client.Policy{timeout: …}` に渡します
- 応答の頭の日付（`Date`・`Retry-After`・`Last-Modified`）は `time.ParseHTTP`、JSON の中の時刻（RFC 3339）は `time.ParseRFC3339` で `time.Time` に読みます。`Retry-After` は秒数の形もあるので、`ParseHTTP` が失敗したら整数として読みます
- 表示のオフセットは秒で渡します（日本は `9 * 3600`）。夏時間のある地域は `time.LoadZone` の `Zone` から `time.OffsetAt` で引きます

## 8. 私的 PKI と proxy

- 私的 PKI: 社内の CA で署名したサーバには `http.client.Policy{extraRoots: tls.ParseRoots(pem)?}` で起点を足します。PEM が読めなければ `ParseRoots` が `tls.BadRoots` を返すので、要求を送る前に分かります。足した起点で止まる鎖には WebPKI の規則（CA/B）を掛けません。焼き込みの WebPKI のルート（Mozilla NSS）は残ったままです
- proxy: `http.client.Policy{proxy: http.client.ParseProxy("http://proxy.internal:3128")?}`（形が違えば `http.client.BadProxy`）。https の要求は CONNECT のトンネルを通り、TLS は相手のサーバと直に結びます。`proxyAuth` には `Proxy-Authorization` の値そのもの（`"Basic …"`）を渡します。環境変数（`HTTPS_PROXY` など）は読みません

## 9. 何を守っているか

- 証明書の鎖は常に検証する（検証を切る欄が無い）
- 本文の上限・要求の期限・redirect の回数は既定で付いている（無制限は書けない）
- https から http へは降りない・origin が変われば認証の頭を落とす
- 送る頭のうち、要求の枠を決めるもの（`Host`・`Content-Length` など）は std だけが書く

