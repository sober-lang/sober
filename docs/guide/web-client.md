# Web client

English | [日本語](web-client.ja.md)

This guide walks through calling outside HTTP APIs with `std/http/client`, step by step, using one small running example: the outgoing side of a small web app that calls an outside API and keeps a login session (the serving side is in [Web server](web-server.md)).

Each example runs a stand-in for the outside API in the same process with `std/http/server` and connects to it. The repository's checks run the examples and compare their output, so the examples must not reach the internet; to call a real API, just change the URL. `https://` is written the same way, and the certificate chain is always verified (there is no field that turns verification off).

Prerequisites: sections 1–5 of the [language tour](tour.md) and error handling (`?` and `catch`).

## 1. A one-shot request — `http.client.Request`

Pass a URL to `http.client.Request` and it returns the response. The client holds no state, so there is nothing to create first. Every policy you leave out gets the safe default (section 3).

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

Output:

```
status 200
content-type application/json
[{"id":1,"name":"apple"},{"id":2,"name":"pear"}]
```

- Leaving out `method:` means GET. `headers:` is a `[]http.Field` (the shared type in `std/http`); `Host`, `Content-Length`, `Transfer-Encoding` and `Connection` are written by the standard library and cannot be set by you (setting one panics)
- Header names in a response are lower-case. `http.client.Header(r, name)` returns the first match, ignoring case
- `Request` opens a connection per request and closes it. To send many requests to the same server, use a session (section 6)

## 2. Telling failures apart by label

When `Request` fails, the error carries a label. Matching on it with `switch` spells out how each kind of failure is handled.

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

Output:

```
refused: Closed
bad url: BadUrl
silent: Timeout
```

| Label | What happened |
|---|---|
| `http.client.Dns` | the name could not be resolved (the cause is `net.NoHost` or similar) |
| `http.client.Tls` | TLS failed (certificate chain verification, or an alert from the peer — the inner error is the cause) |
| `http.client.Timeout` | the deadline for the request (the policy's `timeout`) passed |
| `http.client.Closed` | the peer refused the connection or closed it mid-response |
| `http.client.BadUrl` | a malformed URL (scheme other than http / https, userinfo, spaces or control characters) |
| `http.client.BadResponse` | a malformed response |
| `http.client.BodyTooLarge` | the body went over the limit (the policy's `maxBody`) |
| `http.client.TooManyRedirects` | redirects went over the limit |
| `http.client.InsecureRedirect` | a redirect from https to http (downgrades are not followed) |
| `http.client.ProxyRefused` | the proxy refused CONNECT |

A 4xx or 5xx response is not a failure: it comes back as an ordinary response, with the code in `r.status`.

## 3. Deadlines, limits and redirects — `http.client.Policy`

The policy is a plain struct, `http.client.Policy`, passed as `policy:`. Every field is optional, and a field you leave out gets the safe default (`http.client.Policy{}` is the same as leaving `policy:` out). Fields that loosen a guarantee start with `dangerously`, so a grep finds every place that loosens one. A policy is a value, so you can keep it in a variable and reuse it for many requests.

| Field | Default | Meaning |
|---|---|---|
| `timeout` | 30 seconds | deadline for one whole request (ns — write `5 * time.Second` or `5000 * task.MS`; section 7) |
| `maxBody` | 8 MiB | limit on the body (at most 1 GiB — "unlimited" cannot be written) |
| `redirects` | 10 | how many redirects to follow (0 = none — 3xx comes back as is) |
| `userAgent` | `"sober"` | User-Agent |
| `extraRoots` | none | a `tls.Roots` added to the trust anchors (section 8) |
| `proxy` / `proxyAuth` | none | the proxy to go through (section 8) |
| `dangerouslyAllowTls12` | false | also offer TLS 1.2 (by default only 1.3) |

When a redirect changes the origin, the `Authorization` and `Cookie` headers and the `cookies:` are dropped. 301 / 302 / 303 turn POST into GET and drop the body; 307 / 308 keep them.

## 4. Keeping a login session — cookies are values

The client does not store cookies. Read the value from a response's `Set-Cookie` with `http.client.CookieValue(r, name)`, keep it yourself, and send it with the next request's `cookies:`. What gets sent is exactly what the call says.

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

Output:

```
login: welcome (sid s123)
with cookie: you are s123
without: who are you?
```

The value you keep is a plain string, so you can also store it in a file or a database and use it on the next run. `CookieValue` reads only the value, not attributes such as `Path` or `Max-Age`; when to discard it is yours to decide, following the API's own rules.

## 5. Receiving the body in pieces — `http.client.Stream`

Use `http.client.Stream` for large bodies and for bodies that arrive over time (logs, event feeds). Instead of collecting the whole response, it hands you each piece as it arrives.

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

Output:

```
status 200
received 21 bytes
```

If the body as a whole goes over the policy's `maxBody`, it stops with `BodyTooLarge`. To receive a large file, raise `maxBody` explicitly.

## 6. Many requests to the same server — `http.client.Open` and `http.client.Send`

`http.client.Open` opens a connection to one origin and gives you a `Session` (its `policy:` applies to every round trip on it); each `http.client.Send` on it is a round trip over that same connection (keep-alive). A `Session` exists only as the parameter of the function given to `Open`: it cannot be copied, stored in a field, or taken out of that function. The connection closes when that function returns.

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

Output:

```
200 GET /a
200 GET /b
200 GET /c
```

## 7. Time and deadlines — `std/time`

Deadlines and elapsed times are both an `int` of nanoseconds, so the value you put in the policy's `timeout` and a duration measured with `std/time` can be compared directly.

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

Output:

```
status 503
within budget: true
retry after (UTC) 1994-11-06T08:49:37Z
retry after (JST) 1994-11-06T17:49:37+09:00
may retry now: true
```

- `time.Second` and `task.MS` are constants in the same unit (ns): `2 * time.Second` and `2000 * task.MS` are the same value
- `timeout` is the deadline for one whole request: connecting, the TLS handshake, the headers, and reading the body to the end. For `Stream`, the request lasts until the last piece arrives, so give a long-running response a long deadline. For `Open` the deadline covers setting up the route (proxy, TLS handshakes); for `Send` it applies to each round trip
- Measure elapsed time with the monotonic clock (`time.Mono` returns a `time.Instant`, and `time.Since` returns ns). The wall-clock `time.Time` can jump backwards when the clock is adjusted, so it is not for deadline arithmetic. The two are distinct types, so mixing them up is a type error
- To put one budget on several requests, pass what is left, `budget - time.Since(start)`, to the next request as `policy: http.client.Policy{timeout: …}`
- Read dates in response headers (`Date`, `Retry-After`, `Last-Modified`) with `time.ParseHTTP`, and timestamps inside JSON (RFC 3339) with `time.ParseRFC3339`; both give a `time.Time`. `Retry-After` may also be a number of seconds, so if `ParseHTTP` fails, read it as an integer
- Offsets for display are given in seconds (Japan is `9 * 3600`). For regions with daylight saving time, get the offset from a `Zone` (`time.LoadZone`) with `time.OffsetAt`

## 8. Private PKI and proxies

- Private PKI: for servers signed by an in-house CA, add the anchor with `http.client.Policy{extraRoots: tls.ParseRoots(pem)?}`. If the PEM cannot be read, `ParseRoots` returns `tls.BadRoots`, so you find out before any request is sent. Chains that end at an added anchor are not held to the WebPKI (CA/B) rules. The built-in WebPKI roots (Mozilla NSS) stay in place
- Proxies: `http.client.Policy{proxy: http.client.ParseProxy("http://proxy.internal:3128")?}` (a malformed URL gives `http.client.BadProxy`). https requests go through a CONNECT tunnel, and TLS is negotiated end to end with the destination server. `proxyAuth` takes the `Proxy-Authorization` value as is (`"Basic …"`). Environment variables (`HTTPS_PROXY` and the like) are not read

## 9. What is guaranteed

- The certificate chain is always verified (there is no field to turn it off)
- A body limit, a request deadline and a redirect count are on by default ("unlimited" cannot be written)
- No downgrade from https to http; authentication headers are dropped when the origin changes
- Headers that frame the request (`Host`, `Content-Length` and the like) are written only by the standard library
