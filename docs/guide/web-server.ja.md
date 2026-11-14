# Webサーバ

[English](web-server.md) | 日本語

`std/http/server` でHTTPのリクエストを受けてレスポンスを返す書き方を、小さな題材で順に見ていきます。題材は「外のAPIを叩いて、ログインの状態を持つ小さなWebアプリ」の、リクエストを受ける側です（外へ出ていく側は [Webクライアント](web-client.ja.md)）。

例はどれも、客の役を同じプロセスの中のtaskが `std/http/client` で務めます。リポジトリの検査が例を走らせて出力を照合するためで、本物のサーバでは客の部分を消し、待ち受ける番地を `"0.0.0.0:8080"` などに替えるだけです。

前提: [言語ツアー](tour.ja.md) の1〜5節と、エラーの扱い（`?` と `catch`）・並列（`task.Run` / `task.Spawn`）。

## 1. 受けて返す — `net.Serve` と `http.server.ServeConn`

`net.Serve` は待ち受けの番地（`net.Listener`）に来た接続を1本ずつ別のtaskでhandlerに渡します。handlerの中の `http.server.ServeConn` が、その接続に届くリクエストを順に `route` へ渡し、返ったレスポンスを書きます。

```sober
// examples/web_server_hello.sober
package main

// Web サーバのガイド 1 節: net.Serve が接続 1 本 = task 1 本で受け、http.server.ServeConn がその接続のリクエストを順に route へ渡す。
// 客（http.client.Request）は同じプロセスの task。Serve は包む scope の期限で accept を止め、走っている接続の決着を待ってから返す

import "std/http/client"
import "std/http/server"
import "std/net"
import "std/task"

func route(r http.server.Request) http.server.Response {
    if r.method == "GET" && r.path == "/" {
        return http.server.Text("hello")
    }
    if r.method == "GET" && r.path == "/api/status" {
        return http.server.Json("{\"ok\":true}")
    }
    return http.server.Status(404)
}

// 接続 1 本の handler（net.Serve がこれを接続ごとの task で走らせる）
func app(c net.Conn) error? {
    return http.server.ServeConn(c, route)
}

func get(base string, path string) string {
    r, e := http.client.Request("${base}${path}")
    if e != nil {
        return "GET ${path}: failed"
    }
    b := string(r.body) catch ""
    return if b == "" { "GET ${path} -> ${r.status}" } else { "GET ${path} -> ${r.status} ${b}" }
}

func visit(base string) []string {
    return []string{get(base, "/"), get(base, "/api/status"), get(base, "/nope")}
}

func main() {
    e := net.Listen("127.0.0.1:0", (l) => {
        base := "http://127.0.0.1:${net.Port(l)}"
        got, _ := task.Run((s) => {
            h := task.Spawn(s, () => visit(base))
            // この例では 2 秒で受けを止める（本番の Serve は期限で包まない — 止めるのは SIGTERM）
            _, _ = task.Run((s2) => net.Serve(l, app), deadline: 2000 * task.MS)
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
GET / -> 200 hello
GET /api/status -> 200 {"ok":true}
GET /nope -> 404
```

- `route` は `http.server.Request` を受けて `http.server.Response` を返すだけの関数です。`http.server.Text` / `http.server.Json` / `http.server.Status` が短いレスポンスを作ります
- 接続1本 = task 1本です。handlerが失敗を返しても、panicで死んでも、`net.Serve` はその接続を閉じて受け続けます。数は `task.Ledger()` のpoolの行（`fail` / `died`）で見られます
- `ServeConn` はkeep-aliveとパイプライン（1回の受けに入った複数のリクエスト）を扱います。頭が上限（`maxHead:` 既定8 KiB）を超えたら431、本文が上限（`maxBody:` 既定16 KiB）を超えたら413を返して閉じます
- `Request` の値（`path`・`body` など）はリクエスト1件の間だけ生きます。`route` が返ったら消えるので、リクエストをまたいで残すならコピーします
- 例は検査の都合で `net.Serve` を2秒の期限で包んで止めています。本番では包まずに走らせ続け、止めるのはSIGTERMです（10・11節）

## 2. ルーティング — `Route` と `Dispatch`

ルートの表は `[]http.server.Route` の値（ただのデータ）です。`Mount` がpathの前置きとmiddlewareを足し、`Merge` が表をつなぎ、`Dispatch` がリクエストに合う行のハンドラを呼びます。

```sober
// examples/web_server_route.sober
package main

// Web サーバのガイド 2 節: ルートの表（[]http.server.Route — ただのデータ）を Mount / Merge で合成し、Dispatch で引く。
// /users の下には X-Token を見る middleware（before がレスポンスを返すとハンドラは走らない）。:id は Param で読む。
// 一致しない path は 404・path は合うが method が違えば 405（Allow つき）

import "std/http"
import "std/http/client"
import "std/http/server"
import "std/net"
import "std/task"

func or(s string?) string {
    return if s != nil { s } else { "-" }
}

func listUsers(r http.server.Request) http.server.Response {
    return http.server.Text("users: alice, bob")
}

func getUser(r http.server.Request) http.server.Response {
    return http.server.Text("user ${or(http.server.Param(r, "id"))}")
}

func health(r http.server.Request) http.server.Response {
    return http.server.Text("ok")
}

// X-Token の無いリクエストをここで 401 にする
func auth(r http.server.Request) http.server.Response? {
    return if http.server.Header(r, "x-token") == nil { http.server.Status(401) } else { nil }
}

func routes() []http.server.Route {
    users := []http.server.Route{
        http.server.Route{method: "GET", path: "/", handler: listUsers},
        http.server.Route{method: "GET", path: "/:id", handler: getUser}}
    return http.server.Merge(
        http.server.Mount("/users", users, []http.server.Middleware{http.server.Middleware{before: auth}}),
        []http.server.Route{http.server.Route{method: "GET", path: "/health", handler: health}})
}

func call(base string, method string, path string, token bool) string {
    hs := if token { []http.Field{http.Field{name: "x-token", value: "t"}} } else { []http.Field{} }
    r, e := http.client.Request("${base}${path}", method: method, headers: hs)
    if e != nil {
        return "${method} ${path}: failed"
    }
    allow := http.client.Header(r, "allow")
    b := string(r.body) catch ""
    tail := if allow != nil { " (allow: ${allow})" } else if b != "" { " ${b}" } else { "" }
    return "${method} ${path}${if token { " +token" } else { "" }} -> ${r.status}${tail}"
}

func visit(base string) []string {
    return []string{
        call(base, "GET", "/health", false),
        call(base, "GET", "/users/42", false),
        call(base, "GET", "/users/42", true),
        call(base, "GET", "/users/", true),
        call(base, "DELETE", "/health", false),
        call(base, "GET", "/nope", false)}
}

// n 本の接続を順に受ける
func serve(l net.Listener, n int) error? {
    rs := routes()
    mut k := 0
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, (r) => http.server.Dispatch(rs, r))?
        k = k + 1
        if k == n {
            break
        }
    }
    return nil
}

func main() {
    for x <- routes() {
        println("${x.method} ${x.path}")
    }
    e := net.Listen("127.0.0.1:0", (l) => {
        base := "http://127.0.0.1:${net.Port(l)}"
        got, _ := task.Run((s) => {
            h := task.Spawn(s, () => visit(base))
            _ = serve(l, 6)
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
GET /users/
GET /users/:id
GET /health
GET /health -> 200 ok
GET /users/42 -> 401
GET /users/42 +token -> 200 user 42
GET /users/ +token -> 200 users: alice, bob
DELETE /health -> 405 (allow: GET, HEAD)
GET /nope -> 404
```

- パターンは `/` で区切ったセグメントの列で、静的（`users`）・`:name`（1セグメント）・`*name`（末尾だけ — 残り全部）の3種です。値は `http.server.Param(r, "id")` で読みます
- どの行が勝つかは表の並びに依りません（静的 > `:name` > `*name`）。表を組み替えても振る舞いは変わりません
- `Middleware` は `before` と `after` の組で、どちらも省けます。`before` がレスポンスを返すと、ハンドラは走らずにそのレスポンスが返ります（例の401）。チェーンの順は外から内です（`before` は外→内、`after` は内→外）
- pathは合うがmethodが違えば405で、`Allow` の頭が付きます。HEADはGETの行で答えます（本文は送らない）
- 表は値なので、`for x <- routes()` で全部のルートを歩けます（例の最初の3行）

## 3. 状態の置き場所 — 直列か、外の保存先か

ユーザーの表のように、リクエストをまたいで変わる状態を持ちたくなったら、置き場所は2つに1つです。

- 状態をプロセスの中に持つなら、受けを直列にする。接続を `for c <- net.Accept(l)` で1本ずつ受け、`ServeConn` に渡すラムダで `mut` の表を通します。`ServeConn` の `route` の仮引数は借り（呼び出しの間だけ使い、持ち出さない）なので、`mut` を捕まえたラムダを渡せます
- 並行に受けるなら、状態はdomainか外の保存先（DBなど）に置く。`net.Serve` のhandlerは接続ごとに別のtaskで同時に走るので、`mut` の値を捕まえられません。同じ表を2本のtaskが同時に書く形（データ競合）は、言語の約束として書けない形です。プロセスの中に持つなら、`net.Serve` を囲む `task.Run` の中で `task.NewDomain(s, 初期値)` を作ってhandlerに捕まえさせ、`task.Update(d, (st mut T) => …)` で1つずつ適用します（domainの本体は待たずioもしない短い更新 — カウンタ・小さな表・接続のプールの空き）。大きい表や永続させたい状態は外の保存先に問い合わせます

7節の題材（`examples/web_login.sober`）は前者の形です。`users` の表と鍵を `serve` が持ち、借りのラムダで `route` に通します。

```sober
// examples/web_login.sober（抜粋）
// n 本の接続を順に受ける
func serve(l net.Listener, n int) error? {
    mut users := mut map[string]User{}
    k := session.KeyNew()
    mut i := 0
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, (r) => route(mut users, k, r))?
        i = i + 1
        if i == n {
            break
        }
    }
    return nil
}
```

```sober
// examples/web_login.sober（抜粋）
func route(users mut map[string]User, k session.Key, r http.server.Request) http.server.Response {
    if r.method == "POST" && r.path == "/signup" {
        return signup(mut users, r)
    }
    if r.method == "POST" && r.path == "/login" {
        return logIn(mut users, k, r)
    }
    if r.method == "GET" && r.path == "/me" {
        name, why := whoami(mut users, k, r)
        return if name == "" { unauthorized(why) } else { http.server.Text("hello ${name}") }
    }
    if r.method == "POST" && r.path == "/change-password" {
        return changePassword(mut users, k, r)
    }
    if r.method == "POST" && r.path == "/logout" {
        return logout()
    }
    return http.server.Status(404)
}
```

ハンドラは `mut users` を受ける普通の関数です。読むだけの関数（`whoami`）も `mut` で受けます。`mut` の値を `mut` でない仮引数に渡すと、渡した点で凍結（freeze）され、その後に書くとcheckが拒否します。

## 4. 本文を流す — `Response.stream`

大きなファイルや、少しずつ作る本文は、`body` の代わりに `stream` に関数を渡して送ります。`ServeConn` は頭を送ってから `stream` を呼び、`stream` が `emit` に渡したバイト列をそのまま送ります。

```sober
// examples/http_stream.sober
package main

// std/http/server のレスポンスの stream（language.md 28 節 w2）: route が返す Response の stream はリクエストの path を
// 捕捉したクロージャで、ServeConn が頭（Content-Length = length）を送ってから呼ぶ。File はクロージャに捕捉させず、path を受けて stream の中で開く
// （sendFile — emit は借り: 文形 for の本体が捕捉して呼ぶ）。loopback で 1 本の task が Dial → リクエストを送る → Accept して ServeConn → レスポンスを受ける（net_echo の形）

import "std/http/server"
import "std/io"
import "std/net"
import "std/strings"
import "std/task"

func body() string { return "streamed from a file, chunk by chunk\n" }

func sendFile(path string, out mut http.server.Out, emit func(out mut http.server.Out, b []byte) error?) error? {
    f := io.Open(path)?
    defer io.Close(f)
    for b <- io.Chunks(f)? {
        emit(mut out, io.Raw(b))?
    }
    return nil
}

func route(dir string, r http.server.Request) http.server.Response {
    return switch {
    case strings.HasPrefix(r.path, "/file/"): {
        p := dir + "/" + strings.TrimPrefix(r.path, "/file/")
        http.server.Response{status: 200, contentType: "text/plain", length: len(bytes(body())), stream: (out, emit) => sendFile(p, mut out, emit)}
    }
    default: http.server.Status(404)
    }
}

func run(dir string) error? {
    io.WriteFile(dir + "/http_stream.tmp", bytes(body()))?
    for l <- net.Listen("127.0.0.1:0")? {
        for c <- net.Dial("127.0.0.1:${net.Port(l)}")? {
            // パイプライン 3 本: HEAD（頭だけ — stream は呼ばない）・GET（stream）・その後ろのリクエスト（stream の後も同じ切片の残りを続けて処理する）
            net.Send(c, bytes("HEAD /file/http_stream.tmp HTTP/1.1\r\nHost: x\r\n\r\nGET /file/http_stream.tmp HTTP/1.1\r\nHost: x\r\n\r\nGET /none HTTP/1.1\r\nHost: x\r\nConnection: close\r\n\r\n"))?
            _, e := task.Run((s task.Scope) => serveOne(l, dir) catch -1, deadline: 5000 * task.MS)
            if e != nil {
                println("serve failed")
            }
            mut got := mut []byte{}
            for chunk <- net.Recv(c)? {
                for x <- chunk { got = append(got, x) }
            }
            io.WriteStdout(freeze(got))?
        }
    }
    return nil
}

// 1 本だけ受けて ServeConn に渡す（Connection: close で返る）
func serveOne(l net.Listener, dir string) (int, error?) {
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, (r http.server.Request) => route(dir, r))?
        break
    }
    return 0, nil
}

func main() {
    e := run("out")
    if e != nil {
        println("error")
    }
}
```

出力:

```
HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 37

HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 37

streamed from a file, chunk by chunk
HTTP/1.1 404 Not Found
Cache-Control: private
Content-Length: 0
Connection: close

```

- `length:` があれば `Content-Length`、無ければ（長さ不定）`Transfer-Encoding: chunked` で送ります。長さを宣言したのに合計が合わなければ、`ServeConn` は接続を閉じます（相手は本文の切れで知る）
- `emit` 1回が送り1回です。stdは `emit` をまたいでバッファリングしません
- 送りの状態 `out` は `stream` の仮引数として渡ってきます。`emit` を呼ぶたびに `emit(mut out, b)` と渡し返します（中身は読み書きしません）
- ファイルはクロージャに捕まえず、pathを捕まえて `stream` の中で開きます（`sendFile`）。HEADのリクエストでは `stream` を呼びません

## 5. SSE — `http.server.FormatEvent`

Server-Sent Eventsは、`text/event-stream` のレスポンスを長さ不定の `stream` で送る形です。イベントの行は `http.server.FormatEvent` で組みます。

```sober
// examples/http_sse.sober
package main

// Server-Sent Events（language.md 28 節の「SSE」）: レスポンスの stream で text/event-stream を送る。長さ不定の stream なので chunked で、
// emit 1 回 = chunk 1 つ = 送り 1 回（std は emit をまたいでバッファリングしない — イベントは組んだ順にすぐ届く）。イベントの行は http.server.FormatEvent で組む
// （data の改行は行ごとの `data:` に割る・event / id の改行は panic(BadEvent) — examples/http_sse_bad）。保存させない（cache: NoStore）。
// text/event-stream は compression: の対象外（ServeWith に compression: を渡しても圧縮しない — 頭に Content-Encoding も Vary も無い）。
// 繋ぎ直した受け手は最後に受けた id を Last-Event-ID で返す（http.server.Header で読む — ここではその続きから送る）。
// 長命の接続は scope の deadline の外に置く（ServeConn を deadline つきの task.Run で包むと流れが切れる）。
// ネットの代わりに recv が決まったリクエストの列を渡し、send が送りの 1 回ずつを印字する（行末の CR は外す・送りの区切りに `--`）

import "std/convert"
import "std/http/server"

func show(b []byte) error? {
    mut out := mut []byte{}
    for x <- b {
        if x != '\r' {
            out = append(out, x)
        }
    }
    println("-- ${string(freeze(out)) catch "?"}")
    return nil
}

// from の次から 3 つのイベントを送る（心拍のコメントを 1 つ挟む）
func events(from int, out mut http.server.Out, emit func(out mut http.server.Out, b []byte) error?) error? {
    mut i := from + 1
    while i <= from + 3 {
        emit(mut out, bytes(http.server.FormatEvent(http.server.Event{event: "tick", data: "n = ${i}\nsquare = ${i * i}", id: convert.FormatInt(i)})))?
        if i == from + 1 {
            emit(mut out, bytes(": ping\n\n"))?
        }
        i += 1
    }
    emit(mut out, bytes(http.server.FormatEvent(http.server.Event{data: "bye", retry: 5000})))?
    return nil
}

func route(r http.server.Request) http.server.Response {
    if r.path != "/events" {
        return http.server.Status(404)
    }
    last := http.server.Header(r, "Last-Event-ID")
    from := if last != nil { convert.ParseInt(last) catch 0 } else { 0 }
    return http.server.Response{status: 200, contentType: "text/event-stream", cache: http.server.NoStore{}, stream: (out, emit) => events(from, mut out, emit)}
}

func give(a string, k func([]byte)) error? {
    k(bytes(a))
    return nil
}

func main() {
    reqs := "GET /events HTTP/1.1\r\nAccept: text/event-stream\r\nAccept-Encoding: gzip\r\n\r\n" +
        "GET /events HTTP/1.1\r\nLast-Event-ID: 41\r\nConnection: close\r\n\r\n"
    e := http.server.ServeWith((k) => give(reqs, k), (b) => show(b), route, compression: http.server.Gzip{})
    println(e == nil)
}
```

出力:

```
-- HTTP/1.1 200 OK
Content-Type: text/event-stream
Cache-Control: no-store
Transfer-Encoding: chunked


-- 30
event: tick
id: 1
data: n = 1
data: square = 1



-- 8
: ping



-- 30
event: tick
id: 2
data: n = 2
data: square = 4



-- 30
event: tick
id: 3
data: n = 3
data: square = 9



-- 17
retry: 5000
data: bye



-- 0


-- HTTP/1.1 200 OK
Content-Type: text/event-stream
Cache-Control: no-store
Transfer-Encoding: chunked
Connection: close


-- 35
event: tick
id: 42
data: n = 42
data: square = 1764



-- 8
: ping



-- 35
event: tick
id: 43
data: n = 43
data: square = 1849



-- 35
event: tick
id: 44
data: n = 44
data: square = 1936



-- 17
retry: 5000
data: bye



-- 0


true
```

- `data` の改行は行ごとの `data:` に割ります。`event` と `id` に改行があるとpanic（`BadEvent`）です
- `emit` 1回がchunk 1つで、イベントは組んだ順にすぐ届きます
- 保存させないので `cache: http.server.NoStore{}` を付けます。`text/event-stream` は `compression:` の対象外です（`ServeWith` に `compression:` を渡しても圧縮しません）
- 繋ぎ直した受け手は、最後に受けた `id` を `Last-Event-ID` の頭で返します（`http.server.Header` で読み、続きから送る）
- 長く流す接続は期限つきのscopeの外に置きます。期限で包むと流れが期限で切れます

## 6. cookie — `SetCookie` の安全な既定

`Set-Cookie` を書けるのは `Response.cookies` のフィールドだけです。フィールドを省いた `SetCookie` のゼロ値が安全な側の既定です。

```sober
// examples/web_login.sober（抜粋）
// 世代 user.gen のトークンを cookie に載せたレスポンス
func issue(name string, user User, k session.Key, msg string) http.server.Response {
    t := session.Mint(k, name, user.gen, time.Now(), ttlSec)
    c := http.server.SetCookie{name: cookieName, value: session.Seal(t), maxAge: ttlSec}
    return http.server.Response{status: 200, contentType: "text/plain", body: bytes(msg), cookies: []http.server.SetCookie{c}}
}
```

```sober
// examples/web_login.sober（抜粋）
// この端末の cookie を消す（トークンそのものは期限まで有効 — 全部の端末を切るのは世代を進める changePassword）
func logout() http.server.Response {
    c := http.server.SetCookie{name: cookieName, value: "", maxAge: 0}
    return http.server.Response{status: 200, contentType: "text/plain", body: bytes("bye"), cookies: []http.server.SetCookie{c}}
}
```

| フィールド | 省いたとき | 意味 |
|---|---|---|
| `dangerouslyAllowHttp:` | false（`Secure` が付く） | trueで `Secure` を外す（httpの開発環境だけのオプション） |
| `dangerouslyScriptReadable:` | false（`HttpOnly` が付く） | trueで `HttpOnly` を外す（スクリプトから読ませる） |
| `sameSite:` | `Lax` | 他のサイトからのPOSTにcookieを載せない |
| `path:` | `/` | |
| `domain:` | なし（host-only） | サブドメインへ送らない |
| `maxAge:` | なし | ブラウザを閉じるまで（`0` は今あるcookieを消す — 例の `logout`） |

- 名前を `__Host-` で始めると、ブラウザは `Secure`・`Path=/`・Domainなしのcookieしか受けません。既定がその形なので、`__Host-` の名前はそのまま使えます（`dangerouslyAllowHttp` とは組めません）
- 生の `Set-Cookie` を `headers` に書くとpanic（`BadHeader`）です。cookieの値は符号化しないので、`;` や空白を含む値はbase64urlなどで包みます
- 届いたcookieは `http.server.Cookie(r, name)` で読みます

## 7. ログインとセッション — `std/session`

ここまでの部品で、ログインの状態を持つ小さなアプリを組みます。パスワードは `std/crypto/password` でハッシュにし、ログインの証明には `std/session` の世代つきのトークンを `__Host-` のcookieに載せます。

流れ:

1. `signup`: パスワードを `crypto.password.Argon2id` でハッシュにし、ユーザーの行（`User{hash, gen}`）に世代0で置きます
2. `logIn`: `crypto.password.Verify` で検証し、`issue` が `session.Mint`（持ち主・世代・期限のトークン）を `session.Seal` で文字列にしてcookieに載せます
3. `whoami`（リクエストごとの照合）: `session.Open` が形・署名・期限を見て、`session.Subject` で持ち主の行を引き、`session.Check` にその行の今の世代を渡します。持ち主を名乗る値（`Claims`）の中身は `Check` だけが入れるので、今の世代を引かずに持ち主の名前は読めません。名前は `session.Who` で読みます — ゼロ値の `session.Claims{}` は外でも書けますが、中身が無いので `Who` はfalseを返します
4. `changePassword`: 新しいハッシュに替えると同時に世代を1つ進めます。それまでに発行したトークンは、他の端末の分も全部 `Stale` になります。この端末には新しい世代のトークンを渡し直します
5. `logout`: この端末のcookieを消すだけです。トークンそのものは期限まで有効で、全部の端末を切るのは世代を進めることです

```sober
// examples/web_login.sober（抜粋）
// cookie のトークンの持ち主（name が "" なら why が断る理由）
func whoami(users mut map[string]User, k session.Key, r http.server.Request) (string, string) {
    raw := http.server.Cookie(r, cookieName)
    if raw == nil {
        return "", "not logged in"
    }
    u, e := session.Open(k, raw, time.Now())
    if e != nil {
        return "", switch e {
            case session.Bad{}: "invalid session: log in"
            case session.Expired{}: "session expired: log in again"
        }
    }
    user := users[session.Subject(u)]
    if user == nil {
        return "", "unknown user: log in"
    }
    c, es := session.Check(u, user.gen)
    if es != nil {
        return "", "session revoked (the password was changed): log in again"
    }
    who, _ := session.Who(c)
    return who, ""
}
```

```sober
// examples/web_login.sober（抜粋）
// 古いパスワードを検証して新しいハッシュに替え、世代を進める（他の端末のトークンは全部Staleになる）。この端末には新しい世代のトークンを渡し直す
func changePassword(users mut map[string]User, k session.Key, r http.server.Request) http.server.Response {
    name, why := whoami(mut users, k, r)
    if name == "" {
        return unauthorized(why)
    }
    old := field(r, "old")
    pw := field(r, "new")
    if old == nil || pw == nil {
        return http.server.Status(400)
    }
    user := users[name]
    if user == nil {
        return unauthorized("unknown user: log in")
    }
    ok := crypto.password.Verify(user.hash, old) catch false
    if !ok {
        return http.server.Response{status: 403, contentType: "text/plain", body: bytes("wrong password")}
    }
    h := crypto.password.Argon2id(pw) catch return http.server.Status(500)
    next := User{hash: h, gen: user.gen + 1}
    users[name] = next
    return issue(name, next, k, "password changed: other sessions are revoked")
}
```

全体（後半は2台の端末の代役の客で、12本のリクエストを送ります）:

```sober
// examples/web_login.sober
package main

// ログインのセッション: パスワードのハッシュ（crypto/password）と世代つきのトークン（std/session）を __Host- の cookie に載せる。
// ユーザーの行はハッシュの隣に世代を持ち、パスワードを変えると世代が進んで、それまでに発行したトークンは全部切れる（他の端末の古い cookie も）。
// 状態（ユーザーの表）を持つので受けは直列（ServeConn に渡すラムダは借り — mut の表を通せる）。並行に受けるなら状態は外の保存先に置く。
// 後半の客は 2 台の端末（laptop / phone）の代役で、cookie は値として各端末が持つ（レスポンスから http.client.CookieValue で取り出し、次のリクエストの cookies: に載せる）

import "std/crypto/password"
import "std/http"
import "std/http/client"
import "std/http/server"
import "std/net"
import "std/session"
import "std/task"
import "std/time"
import "std/url"

type User struct {
    hash string
    gen int
}

const cookieName = "__Host-sid"
const ttlSec = 3600

// form の本文の key の値（% と + をデコードした値 — http.server.Form は生のまま）
func field(r http.server.Request, key string) string? {
    ps, e := url.ParseQuery(string(r.body) catch "")
    if e != nil {
        return nil
    }
    for p <- ps {
        if p.key == key {
            return p.value
        }
    }
    return nil
}

// 世代 user.gen のトークンを cookie に載せたレスポンス
func issue(name string, user User, k session.Key, msg string) http.server.Response {
    t := session.Mint(k, name, user.gen, time.Now(), ttlSec)
    c := http.server.SetCookie{name: cookieName, value: session.Seal(t), maxAge: ttlSec}
    return http.server.Response{status: 200, contentType: "text/plain", body: bytes(msg), cookies: []http.server.SetCookie{c}}
}

func unauthorized(why string) http.server.Response {
    return http.server.Response{status: 401, contentType: "text/plain", body: bytes(why)}
}

// cookie のトークンの持ち主（name が "" なら why が断る理由）
func whoami(users mut map[string]User, k session.Key, r http.server.Request) (string, string) {
    raw := http.server.Cookie(r, cookieName)
    if raw == nil {
        return "", "not logged in"
    }
    u, e := session.Open(k, raw, time.Now())
    if e != nil {
        return "", switch e {
            case session.Bad{}: "invalid session: log in"
            case session.Expired{}: "session expired: log in again"
        }
    }
    user := users[session.Subject(u)]
    if user == nil {
        return "", "unknown user: log in"
    }
    c, es := session.Check(u, user.gen)
    if es != nil {
        return "", "session revoked (the password was changed): log in again"
    }
    who, _ := session.Who(c)
    return who, ""
}

func signup(users mut map[string]User, r http.server.Request) http.server.Response {
    name := field(r, "name")
    pw := field(r, "password")
    if name == nil || pw == nil || name == "" {
        return http.server.Status(400)
    }
    if users[name] != nil {
        return http.server.Status(409)
    }
    h := crypto.password.Argon2id(pw) catch return http.server.Status(500)
    users[name] = User{hash: h, gen: 0}
    return http.server.Response{status: 201, contentType: "text/plain", body: bytes("created ${name}")}
}

func logIn(users mut map[string]User, k session.Key, r http.server.Request) http.server.Response {
    name := field(r, "name")
    pw := field(r, "password")
    if name == nil || pw == nil {
        return http.server.Status(400)
    }
    user := users[name]
    if user == nil {
        return unauthorized("wrong name or password")
    }
    ok := crypto.password.Verify(user.hash, pw) catch false
    if !ok {
        return unauthorized("wrong name or password")
    }
    return issue(name, user, k, "welcome ${name}")
}

// 古いパスワードを検証して新しいハッシュに替え、世代を進める（他の端末のトークンは全部Staleになる）。この端末には新しい世代のトークンを渡し直す
func changePassword(users mut map[string]User, k session.Key, r http.server.Request) http.server.Response {
    name, why := whoami(mut users, k, r)
    if name == "" {
        return unauthorized(why)
    }
    old := field(r, "old")
    pw := field(r, "new")
    if old == nil || pw == nil {
        return http.server.Status(400)
    }
    user := users[name]
    if user == nil {
        return unauthorized("unknown user: log in")
    }
    ok := crypto.password.Verify(user.hash, old) catch false
    if !ok {
        return http.server.Response{status: 403, contentType: "text/plain", body: bytes("wrong password")}
    }
    h := crypto.password.Argon2id(pw) catch return http.server.Status(500)
    next := User{hash: h, gen: user.gen + 1}
    users[name] = next
    return issue(name, next, k, "password changed: other sessions are revoked")
}

// この端末の cookie を消す（トークンそのものは期限まで有効 — 全部の端末を切るのは世代を進める changePassword）
func logout() http.server.Response {
    c := http.server.SetCookie{name: cookieName, value: "", maxAge: 0}
    return http.server.Response{status: 200, contentType: "text/plain", body: bytes("bye"), cookies: []http.server.SetCookie{c}}
}

func route(users mut map[string]User, k session.Key, r http.server.Request) http.server.Response {
    if r.method == "POST" && r.path == "/signup" {
        return signup(mut users, r)
    }
    if r.method == "POST" && r.path == "/login" {
        return logIn(mut users, k, r)
    }
    if r.method == "GET" && r.path == "/me" {
        name, why := whoami(mut users, k, r)
        return if name == "" { unauthorized(why) } else { http.server.Text("hello ${name}") }
    }
    if r.method == "POST" && r.path == "/change-password" {
        return changePassword(mut users, k, r)
    }
    if r.method == "POST" && r.path == "/logout" {
        return logout()
    }
    return http.server.Status(404)
}

// n 本の接続を順に受ける
func serve(l net.Listener, n int) error? {
    mut users := mut map[string]User{}
    k := session.KeyNew()
    mut i := 0
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, (r) => route(mut users, k, r))?
        i = i + 1
        if i == n {
            break
        }
    }
    return nil
}

// --- ここから客（端末の代役） ---

// リクエスト 1 本の結果（レスポンスの行と、Set-Cookie で渡された cookie の値 — 無ければ nil）
type Reply struct {
    line string
    cookie string?
}

func send(base string, method string, path string, cookie string?, form []url.Pair) Reply {
    hs := []http.Field{http.Field{name: "content-type", value: "application/x-www-form-urlencoded"}}
    cs := if cookie == nil { []http.client.Cookie{} } else { []http.client.Cookie{http.client.Cookie{name: cookieName, value: cookie}} }
    resp, e := http.client.Request("${base}${path}", method: method, headers: hs, body: bytes(url.FormatQuery(form)), cookies: cs)
    if e != nil {
        return Reply{line: "${method} ${path}: failed", cookie: nil}
    }
    return Reply{line: "${method} ${path} -> ${resp.status} ${string(resp.body) catch ""}", cookie: http.client.CookieValue(resp, cookieName)}
}

func pairs(kv []string) []url.Pair {
    mut ps := mut []url.Pair{}
    mut i := 0
    while i + 1 < len(kv) {
        ps = append(ps, url.Pair{key: kv[i], value: kv[i + 1]})
        i += 2
    }
    return freeze(ps)
}

// 2 台の端末でログインし、laptop でパスワードを変えると phone の古いトークンが切れる流れ（リクエストは 12 本）
func tour(base string) []string {
    mut out := mut []string{}
    none := []url.Pair{}
    out = append(out, send(base, "POST", "/signup", nil, pairs([]string{"name", "alice", "password", "correct horse"})).line)
    laptop := send(base, "POST", "/login", nil, pairs([]string{"name", "alice", "password", "correct horse"}))
    phone := send(base, "POST", "/login", nil, pairs([]string{"name", "alice", "password", "correct horse"}))
    out = append(out, "laptop: ${laptop.line}")
    out = append(out, "phone: ${phone.line}")
    out = append(out, "phone: ${send(base, "GET", "/me", phone.cookie, none).line}")
    changed := send(base, "POST", "/change-password", laptop.cookie, pairs([]string{"old", "correct horse", "new", "battery staple"}))
    out = append(out, "laptop: ${changed.line}")
    out = append(out, "phone: ${send(base, "GET", "/me", phone.cookie, none).line}")
    out = append(out, "laptop (old cookie): ${send(base, "GET", "/me", laptop.cookie, none).line}")
    out = append(out, "laptop (new cookie): ${send(base, "GET", "/me", changed.cookie, none).line}")
    out = append(out, "phone: ${send(base, "POST", "/login", nil, pairs([]string{"name", "alice", "password", "correct horse"})).line}")
    again := send(base, "POST", "/login", nil, pairs([]string{"name", "alice", "password", "battery staple"}))
    out = append(out, "phone: ${again.line}")
    bye := send(base, "POST", "/logout", again.cookie, none)
    bc := bye.cookie
    cleared := bc != nil && bc == ""
    out = append(out, "phone: ${bye.line} (cookie cleared: ${cleared})")
    out = append(out, "phone: ${send(base, "GET", "/me", nil, none).line}")
    return freeze(out)
}

func main() {
    e := net.Listen("127.0.0.1:0", (l) => {
        base := "http://127.0.0.1:${net.Port(l)}"
        got, _ := task.Run((s) => {
            h := task.Spawn(s, () => tour(base))
            _ = serve(l, 12)
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
POST /signup -> 201 created alice
laptop: POST /login -> 200 welcome alice
phone: POST /login -> 200 welcome alice
phone: GET /me -> 200 hello alice
laptop: POST /change-password -> 200 password changed: other sessions are revoked
phone: GET /me -> 401 session revoked (the password was changed): log in again
laptop (old cookie): GET /me -> 401 session revoked (the password was changed): log in again
laptop (new cookie): GET /me -> 200 hello alice
phone: POST /login -> 401 wrong name or password
phone: POST /login -> 200 welcome alice
phone: POST /logout -> 200 bye (cookie cleared: true)
phone: GET /me -> 401 not logged in
```

出力の6〜7行目が世代の効き目です。laptopでパスワードを変えた後は、phoneのcookieもlaptopの古いcookieも `Stale` で断られます。

トークンが何に備え、何に備えないか（同じ世代の中で盗まれたトークン・端末ごとの失効・鍵の漏れ・再送）は [std/session](../std/session.ja.md) の脅威モデルの箇条にあります。端末ごとに失効させたいときは、`session.Of` で読んだ `id` をアプリの表に持つ形がそこに書いてあります（`Of` は `Claims` の全フィールド — 世代・id・発行と期限の時刻 — を返し、`Who` と同じくゼロ値ではfalse）。

## 8. 注意点

- `http.server.Form` と `http.server.Query` は値をデコードしません。`a+b` や `%40` が生のまま返るので、パスワードのような値は別物になります。デコードした値は `url.ParseQuery` で読みます（例の `field`）

```sober
// examples/web_login.sober（抜粋）
// form の本文の key の値（% と + をデコードした値 — http.server.Form は生のまま）
func field(r http.server.Request, key string) string? {
    ps, e := url.ParseQuery(string(r.body) catch "")
    if e != nil {
        return nil
    }
    for p <- ps {
        if p.key == key {
            return p.value
        }
    }
    return nil
}
```

- `__Host-` のcookieはhttpsが前提です。ブラウザは `Secure` のcookieをhttpのレスポンスから受けないので、7節の例（loopbackのhttp）はブラウザでは試せません。例の客（`std/http/client`）はcookieを値として持ち、`http.client.CookieValue` で取り出して次のリクエストの `cookies:` に載せます（`send`）— クライアントがcookieを運ぶ正道の形で、httpsで公開したサーバ（9節）にもそのまま使えます
- `Request` の値はリクエスト1件の間だけ生きます（1節）。リクエストをまたぐ表に入れるならコピーします

- 待ってから返すなら、ハンドラの中で `os.Sleep` せずに `http.server.Delayed(ms, 応答)` を返します。送る時刻は同じか少し早く（待ちが明けた後の実行待ちを待たない）、待つ間ハンドラのスタックとリクエストのregionを持たないので、待つ接続が多いときの常駐がkeep-aliveの接続と同じに収まります。待つのはそのレスポンスの頭の直前で、同じ接続の前のレスポンスは先に出ます

```sober
// examples/http_delayed.sober（抜粋）
func route(r http.server.Request) http.server.Response {
    if r.path == "/slow" {
        return http.server.Delayed(20, http.server.Text("slow\n"))
    }
    return http.server.Text("hello\n")
}
```

## 9. TLSで公開する — `tls.Serve`

httpsで公開するには `std/tls` を使います。`tls.Serve` は接続ごとにhandshakeを済ませてからhandlerを呼び、handlerは `tls.Recv` / `tls.Send` を `http.server.ServeWith` の受けと送りに繋ぎます（`ServeConn` は `net.Conn` 用の同じ包みです）。

```sober
// examples/web_server_tls.sober
package main

// Web サーバのガイド 9 節: https で公開する。tls.Serve が handshake を済ませた接続だけを app に渡し、app は tls.Recv / tls.Send を
// http.server.ServeWith の受けと送りに繋ぐ（ServeConn の TLS 版）。証明書と鍵は @embed で焼き込む（起動時にファイルから読むなら tls.Load）。
// 既定の走りは設定の確認だけ。`web_server_tls live <port>` で127.0.0.1:<port> にhttpsで待ち受ける
// （試すなら curl --cacert testdata/crypto/httparena-server.crt https://localhost:<port>/ — 自己署名の証明書なので起点を足す）

import "std/http/server"
import "std/os"
import "std/tls"

@embed("testdata/crypto/httparena-server.*")
const Certs = map[string]string{}

func file(p string) string {
    v := Certs[p]
    return if v != nil { v } else { "" }
}

func route(r http.server.Request) http.server.Response {
    return if r.path == "/" { http.server.Text("hello over TLS\n") } else { http.server.Status(404) }
}

// 接続1本のhandler（handshakeは済んでいる — cは復号した後の読み書きのインターフェース）
func app(c tls.Conn) error? {
    return http.server.ServeWith((k) => tls.Recv(c, k), (b) => tls.Send(c, b), route)
}

func main() int {
    cfg, e := tls.Parse(file("testdata/crypto/httparena-server.crt"), file("testdata/crypto/httparena-server.key"))
    if e != nil {
        println("bad certificate or key")
        return 1
    }
    println("certificate and key: ok")
    args, _ := os.Args()
    if len(args) >= 3 && args[1] == "live" {
        e2 := tls.Serve("127.0.0.1:${args[2]}", tls.Alpn(cfg, []string{"http/1.1"}), app)
        return if e2 == nil { 0 } else { 1 }
    }
    return 0
}
```

出力:

```
certificate and key: ok
```

- `tls.Serve` はTLS 1.3のサーバです（X25519・AES-128-GCM / ChaCha20-Poly1305・RSAの証明書）。古い版へ降りる設定はありません
- `tls.Serve` は `addr` で自分で待ち受けます（`net.Listen` を挟まない）。接続1本 = task 1本で、受けの約束（失敗と死の吸収・期限）は `net.Serve` と同じです
- 証明書チェーンと鍵はPEMの文字列で `tls.Parse` に渡します。例は `@embed` で実行ファイルに焼き込んでいます。起動時にファイルから読むなら `tls.Load(certPath, keyPath)` です
- `tls.Alpn(cfg, []string{"http/1.1"})` で、ALPNで選ぶプロトコルを設定します
- `ServeWith` には送りを積んでまとめて送る任意の引数（`put:` — `tls.Put` を渡す）もあります。任意の引数の全部は [std/http/server](../std/http-server.ja.md) のリファレンスにあります
- 例は検査一式では設定を確認するだけで、`live <port>` で実際に待ち受けます（試し方は例の冒頭のコメント）

## 10. 本番で走らせる

std/net（したがって `std/http/server` と `std/tls`）を使うプログラムは、環境に3つのことを求めます。詳しくは [インストール](install.ja.md) の「サーバを走らせる」の節にあります。

- io_uring: Dockerの既定のseccompのプロファイルはio_uringを塞ぎます。そのときSoberはepollにフォールバックして動きますが、遅くなります
- memlock: Linux 5.12より前のカーネルでは、ワーカーごとのio_uringのringがユーザー全体の `RLIMIT_MEMLOCK` で数えられます。足りないと上と同じくフォールバックします
- nofile: 接続1本がファイル記述子1つです。softの上限（既定1024が多い）を見込む接続の数以上に上げます

`net.Serve` の引数で、接続の受け入れの上限を決めます。

| 引数 | 既定 | 意味 |
|---|---|---|
| `budget:` | 64 KiB | 接続1本が使ってよいメモリ |
| `conns:` | 10000 | 同時の接続の数（`budget × conns` が受け入れの上限 — 超えた接続は閉じる） |
| `reject:` | なし | 受け入れられなかった接続に1回だけ送るバイト列（省くと送らずに閉じる） |
| `region:` | 128 MiB | 接続のtaskのregion 1つの上限（超えるとその接続のtaskが死ぬ） |
| `maxWait:` | 100 ms | 混んでいるときの待ちの上限（この時間を過ぎたtaskから先に走る — 越えた数と量は `task.Ledger()` の `late` / `maxLate`） |

`ServeConn` の `maxHead:` / `maxBody:` を上げるときは、`budget:` も合わせます（目安は `budget ≥ 3 × (maxHead + maxBody) + 16 KiB`）。

## 11. 交代の境界 — バイナリを入れ替える

新しい版のバイナリへ入れ替えるときに、今できることは次の2つです。

- SIGTERM / SIGINTで即座に止まる。コンテナのinit（PID 1）として走らせても止まります（終了コード143 / 130）。止まるのは即座で、処理中の接続は切れます
- 新旧を同じportに重ねて立てられる。`net.Listen` はSO_REUSEPORTを立てるので、同じuidの新しいプロセスは、古いプロセスが走っている間に同じ番地で待ち受けられます。届く接続はカーネルが両方に振り分けます。新しい版を立ててから古い版を止めれば、切れるのは古い版で処理中だった接続だけです。この性質の裏側（同じuidの別のプロセスも同じ番地に入れる）は [安全性ガイド](security.ja.md#12-soberが守らないもの) にあります

まだ無いもの: 古い版に「受けるのをやめて、処理中の接続を流し切ってから終わる」と外から合図するAPI（graceful drain）はありません。`net.Serve` は包むscopeの期限で受けを止め、走っている接続の決着を待ってから返しますが、期限は起動のときに決める値で、外からの合図では発火しません。

## 12. 何を守っているか

- リクエストの頭と本文には既定で上限がある（431 / 413）・接続ごとのメモリと同時の接続の数にも上限がある
- `Set-Cookie` は型のフィールドでだけ書け、省いたフィールドは安全な側（`Secure`・`HttpOnly`・`SameSite=Lax`・host-only）。緩めるフィールドは `dangerously` の綴りでgrepで拾える
- レスポンスの頭にCR / LFを混ぜられない（レスポンスの分割はpanic）・stdが書く頭（`Content-Length` など）は書けない
- 保存の方針の既定は `Cache-Control: private`（共有キャッシュに認証つきのレスポンスを置かせない）
- 並行のhandlerどうしで `mut` の状態を共有できない（データ競合を書けない）
- セッションのトークンは署名と期限つき・世代を引かずに持ち主の値を作れない
