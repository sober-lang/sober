# Web server

English | [日本語](web-server.ja.md)

This guide walks through receiving HTTP requests and returning responses with `std/http/server`, step by step, using one small running example: the serving side of a small web app that calls an outside API and keeps a login session (the outgoing side is in [Web client](web-client.md)).

In every example, a task in the same process plays the client with `std/http/client`. That is so the repository's checks can run the examples and compare their output; for a real server, drop the client part and change the listening address to something like `"0.0.0.0:8080"`.

Prerequisites: sections 1–5 of the [language tour](tour.md), error handling (`?` and `catch`), and parallelism (`task.Run` / `task.Spawn`).

## 1. Receive and respond — `net.Serve` and `http.server.ServeConn`

`net.Serve` hands each connection that arrives at a listening address (`net.Listener`) to the handler, one connection per task. Inside the handler, `http.server.ServeConn` passes the requests arriving on that connection to `route` in order and writes the responses it returns.

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

Output:

```
GET / -> 200 hello
GET /api/status -> 200 {"ok":true}
GET /nope -> 404
```

- `route` is just a function from `http.server.Request` to `http.server.Response`. `http.server.Text` / `http.server.Json` / `http.server.Status` build short responses
- One connection is one task. Whether the handler returns an error or dies with a panic, `net.Serve` closes that connection and keeps accepting. The counts are in the pool rows of `task.Ledger()` (`fail` / `died`)
- `ServeConn` handles keep-alive and pipelining (several requests in one read). A head over the limit (`maxHead:`, 8 KiB by default) gets 431, a body over the limit (`maxBody:`, 16 KiB by default) gets 413, and the connection is closed
- The time spent waiting for the peer is also bounded by default: `headWait:` (30 s by default) until the head is complete, including the keep-alive wait; `bodyWait:` (60 s by default) until the body is received; `sendWait:` (60 s by default) for the longest interval in which sending makes no progress. When a deadline passes, the connection is closed without sending anything
- The values of a `Request` (`path`, `body` and so on) live only for that one request. They are gone when `route` returns, so copy them if they must outlive it
- For the checks, the example stops `net.Serve` by wrapping it in a 2-second deadline. In production, run it unwrapped and stop it with SIGTERM (sections 11 and 12)

## 2. Routing — `Route` and `Dispatch`

A route table is a value of type `[]http.server.Route` (plain data). `Mount` adds a path prefix and middleware, `Merge` joins tables, and `Dispatch` calls the handler of the row that matches the request.

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

Output:

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

- A pattern is a sequence of segments separated by `/`, of three kinds: static (`users`), `:name` (one segment) and `*name` (last only — all the rest). Read the values with `http.server.Param(r, "id")`
- Which row wins does not depend on the order of the table (static > `:name` > `*name`). Rearranging the table does not change the behavior
- A `Middleware` is a pair of `before` and `after`; both are optional. When `before` returns a response, the handler does not run and that response is returned (the 401 in the example). The chain runs outside-in (`before` outer → inner, `after` inner → outer)
- If the path matches but the method does not, the response is 405 with an `Allow` header. HEAD is answered by the GET row (without sending the body)
- The table is a value, so `for x <- routes()` walks every route (the first three lines of the output)

## 3. Where state lives — a domain, or an outside store

State that changes across requests, like a table of users, goes in a domain or in an outside store (a database or the like).

`net.Serve` runs its handler on a separate task per connection, all at once. `ServeConn` runs the route on a separate task per stream under HTTP/2. So neither the handler nor the route can capture a `mut` binding or `mut` contents. The rule holds whatever `proto:` is, and check and build reject it at the call. Two tasks writing the same table at the same time (a data race) is a shape the language does not let you write.

- To keep the state in the process, put it in a domain. Make it with `task.NewDomain(s, init)` in the scope that calls `ServeConn`, let the handler capture it, read it with `task.Read(d, (st T) => …)` and write it with `task.Update(d, (st mut T) => …)`. A domain body is a short update that neither waits nor does io (counters, small tables, the free slots of a connection pool). The body writes only elements of slices allocated beforehand and values that do not grow a region
- Ask an outside store for large or durable state

The example in section 7 (`examples/web_login.sober`) takes the first form. `serve` makes the domain of the user table and the key, and passes them to `route`. The rows keep names and hashes in byte slices allocated beforehand, so the number of rows has a limit (`maxUsers`).

```sober
// examples/web_login.sober (excerpt)
// n 本の接続を順に受ける（ユーザーの表のdomainはこのscopeの寿命）
func serve(l net.Listener, n int) error? {
    _, e := task.Run((s) => {
        mut u := Users{n: 0, names: mut []byte{}, nlen: mut []int{}, hashes: mut []byte{}, hlen: mut []int{}, gens: mut []int{}}
        while len(u.names) < maxUsers * nameCap {
            u.names = append(u.names, byte(0))
        }
        while len(u.hashes) < maxUsers * hashCap {
            u.hashes = append(u.hashes, byte(0))
        }
        while len(u.gens) < maxUsers {
            u.nlen = append(u.nlen, 0)
            u.hlen = append(u.hlen, 0)
            u.gens = append(u.gens, 0)
        }
        users := task.NewDomain(s, u)
        k := session.KeyNew()
        serveWith(l, n, (r) => route(users, k, r)) catch 1
    })
    return e
}
```

```sober
// examples/web_login.sober (excerpt)
func route(users task.Domain[Users], k session.Key, r http.server.Request) http.server.Response {
    if r.method == "POST" && r.path == "/signup" {
        return signup(users, r)
    }
    if r.method == "POST" && r.path == "/login" {
        return logIn(users, k, r)
    }
    if r.method == "GET" && r.path == "/me" {
        name, why := whoami(users, k, r)
        return if name == "" { unauthorized(why) } else { http.server.Text("hello ${name}") }
    }
    if r.method == "POST" && r.path == "/change-password" {
        return changePassword(users, k, r)
    }
    if r.method == "POST" && r.path == "/logout" {
        return logout()
    }
    return http.server.Status(404)
}
```

The handlers are ordinary functions that take the domain `users`. The domain is passed as a value, and every read and write goes through `task.Read` and `task.Update` (`rowOf` reads a copy of the table and looks the name up in the copy).

## 4. Streaming the body — `Response.stream`

For large files or bodies produced little by little, pass a function in `stream` instead of `body`. `ServeConn` sends the head, then calls `stream`, and sends the bytes `stream` passes to `emit` as they are.

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

Output:

```
HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 37
Date: Sun, 06 Nov 1994 08:49:37 GMT

HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 37
Date: Sun, 06 Nov 1994 08:49:37 GMT

streamed from a file, chunk by chunk
HTTP/1.1 404 Not Found
Cache-Control: private
Content-Length: 0
Connection: close
Date: Sun, 06 Nov 1994 08:49:37 GMT

```

- With `length:` the response carries `Content-Length`; without it (unknown length) it is sent with `Transfer-Encoding: chunked`. If the total does not match a declared length, `ServeConn` closes the connection (the peer notices the truncated body)
- One `emit` is one send. The standard library does not buffer across `emit` calls
- The send state `out` arrives as a parameter of `stream`. Pass it back on every call as `emit(mut out, b)` (without reading or writing its contents)
- Do not capture a file in the closure; capture the path and open the file inside `stream` (`sendFile`). For a HEAD request `stream` is not called

## 5. SSE — `http.server.FormatEvent`

Server-Sent Events are a `text/event-stream` response sent with a `stream` of unknown length. Build the event lines with `http.server.FormatEvent`.

```sober
// examples/http_sse.sober
package main

// Server-Sent Events（language.md 28 節の「SSE」）: レスポンスの stream で text/event-stream を送る。長さ不定の stream なので chunked で、
// emit 1 回 = chunk 1 つ = 送り 1 回（std は emit をまたいでバッファリングしない — イベントは組んだ順にすぐ届く）。イベントの行は http.server.FormatEvent で組む
// （data の改行は行ごとの `data:` に割る・event / id の改行は panic(BadEvent) — examples/http_sse_bad）。保存させない（cache: NoStore）。
// text/event-stream は compression: の対象外（ServeConn に compression: を渡しても圧縮しない — 頭に Content-Encoding も Vary も無い）。
// 繋ぎ直した受け手は最後に受けた id を Last-Event-ID で返す（http.server.Header で読む — ここではその続きから送る）。
// 長命の接続は scope の deadline の外に置く（ServeConn を deadline つきの task.Run で包むと流れが切れる）。
// ネットの代わりに recv が決まったリクエストの列を渡し、send が送りの 1 回ずつを印字する（行末の CR は外す・送りの区切りに `--`）

import "std/convert"
import "std/http/server"
import "std/net"

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

func main() {
    reqs := "GET /events HTTP/1.1\r\nHost: x\r\nAccept: text/event-stream\r\nAccept-Encoding: gzip\r\n\r\n" +
        "GET /events HTTP/1.1\r\nHost: x\r\nLast-Event-ID: 41\r\nConnection: close\r\n\r\n"
    e := net.Pair((c) => http.server.ServeConn(c, route, compression: http.server.Gzip{}), (c) => {
        _ = net.Send(c, bytes(reqs))
        _ = show(readAll(c))
    })
    println(e == nil)
}

// 相手が閉じるまで受けたバイト列（最後の要求はConnection: close — サーバーが応答の後に閉じる）
func readAll(c net.Conn) []byte {
    mut got := mut []byte{}
    _ = net.Recv(c, (x) => {
        for y <- x {
            got = append(got, y)
        }
    })
    return freeze(got)
}
```

Output:

```
-- HTTP/1.1 200 OK
Content-Type: text/event-stream
Cache-Control: no-store
Transfer-Encoding: chunked
Date: Sun, 06 Nov 1994 08:49:37 GMT

30
event: tick
id: 1
data: n = 1
data: square = 1


8
: ping


30
event: tick
id: 2
data: n = 2
data: square = 4


30
event: tick
id: 3
data: n = 3
data: square = 9


17
retry: 5000
data: bye


0

HTTP/1.1 200 OK
Content-Type: text/event-stream
Cache-Control: no-store
Transfer-Encoding: chunked
Connection: close
Date: Sun, 06 Nov 1994 08:49:37 GMT

35
event: tick
id: 42
data: n = 42
data: square = 1764


8
: ping


35
event: tick
id: 43
data: n = 43
data: square = 1849


35
event: tick
id: 44
data: n = 44
data: square = 1936


17
retry: 5000
data: bye


0


true
```

- Newlines in `data` are split into one `data:` line each. A newline in `event` or `id` is a panic (`BadEvent`)
- One `emit` is one chunk, so events reach the client right away, in the order you build them
- Do not let it be stored: set `cache: http.server.NoStore{}`. `text/event-stream` is excluded from `compression:` (passing `compression:` to `ServeConn` does not compress it)
- A client that reconnects sends back the last `id` it received in the `Last-Event-ID` header (read it with `http.server.Header` and continue from there)
- Keep long-lived connections outside any scope with a deadline. Wrapped in a deadline, the stream is cut when the deadline passes

## 6. Cookies — the safe defaults of `SetCookie`

The only way to write `Set-Cookie` is the `Response.cookies` field. The zero value of a `SetCookie` with fields left out is the safe default.

```sober
// examples/web_login.sober (excerpt)
// 世代 user.gen のトークンを cookie に載せたレスポンス
func issue(name string, user User, k session.Key, msg string) http.server.Response {
    t := session.Mint(k, name, user.gen, time.Now(), ttlSec)
    c := http.server.SetCookie{name: cookieName, value: session.Seal(t), maxAge: ttlSec}
    return http.server.Response{status: 200, contentType: "text/plain", body: bytes(msg), cookies: []http.server.SetCookie{c}}
}
```

```sober
// examples/web_login.sober (excerpt)
// この端末の cookie を消す（トークンそのものは期限まで有効 — 全部の端末を切るのは世代を進める changePassword）
func logout() http.server.Response {
    c := http.server.SetCookie{name: cookieName, value: "", maxAge: 0}
    return http.server.Response{status: 200, contentType: "text/plain", body: bytes("bye"), cookies: []http.server.SetCookie{c}}
}
```

| Field | When left out | Meaning |
|---|---|---|
| `dangerouslyAllowHttp:` | false (`Secure` is set) | true drops `Secure` (only for http development environments) |
| `dangerouslyScriptReadable:` | false (`HttpOnly` is set) | true drops `HttpOnly` (lets scripts read it) |
| `sameSite:` | `Lax` | the cookie is not sent with POSTs from other sites |
| `path:` | `/` | |
| `domain:` | none (host-only) | not sent to subdomains |
| `maxAge:` | none | until the browser closes (`0` deletes an existing cookie — `logout` in the example) |

- With a name starting with `__Host-`, browsers accept only a cookie that is `Secure`, `Path=/` and without a Domain. That is exactly the default, so `__Host-` names work as they are (they cannot be combined with `dangerouslyAllowHttp`)
- Writing a raw `Set-Cookie` in `headers` is a panic (`BadHeader`). Cookie values are not encoded, so wrap values that contain `;` or spaces in base64url or similar
- Read incoming cookies with `http.server.Cookie(r, name)`

## 7. Login and sessions — `std/session`

With the pieces so far, build a small app that keeps a login session. Passwords are hashed with `std/crypto/password`, and the login mark is a generational token from `std/session`, carried in a `__Host-` cookie.

The flow:

1. `signup`: hash the password with `crypto.password.Argon2id` and store the user's row (`User{hash, gen}`) at generation 0
2. `logIn`: check with `crypto.password.Verify`; `issue` turns `session.Mint` (a token with owner, generation and expiry) into a string with `session.Seal` and puts it in the cookie
3. `whoami` (the check on every request): `session.Open` checks the form, the signature and the expiry; `session.Subject` looks up the owner's row; and `session.Check` is given that row's current generation. Only `Check` fills the value that names the owner (`Claims`), so there is no way to read the owner's name without looking up the current generation. The name is read with `session.Who` — the zero value `session.Claims{}` can be written anywhere, but it holds nothing, so `Who` returns false
4. `changePassword`: switch to the new hash and advance the generation by one at the same time. Every token issued before, including those on other devices, becomes `Stale`. This device gets a fresh token for the new generation
5. `logout`: only deletes this device's cookie. The token itself stays valid until it expires; cutting off every device is what advancing the generation does

```sober
// examples/web_login.sober (excerpt)
// cookieのトークンの持ち主（nameが "" ならwhyが断る理由）
func whoami(users task.Domain[Users], k session.Key, r http.server.Request) (string, string) {
    u, why := opened(k, r)
    if u == nil {
        return "", why
    }
    return checked(u, rowOf(users, bytes(session.Subject(u))))
}
```

```sober
// examples/web_login.sober (excerpt)
// 古いパスワードを検証して新しいハッシュに替え、世代を進める（他の端末のトークンは全部Staleになる）。この端末には新しい世代のトークンを渡し直す
func changePassword(users task.Domain[Users], k session.Key, r http.server.Request) http.server.Response {
    name, why := whoami(users, k, r)
    if name == "" {
        return unauthorized(why)
    }
    oldPw := field(r, "old")
    newPw := field(r, "new")
    if oldPw == nil || newPw == nil {
        return http.server.Status(400)
    }
    row := rowOf(users, bytes(name))
    if !verifyPw(row.hash, oldPw) {
        return http.server.Response{status: 403, contentType: "text/plain", body: bytes("wrong password")}
    }
    h := crypto.password.Argon2id(newPw) catch return http.server.Status(500)
    nb := bytes(name)
    hb := bytes(h)
    next := User{hash: h, gen: row.gen + 1}
    g := next.gen
    _ = task.Update(users, (st mut Users) => store(mut st, nb, hb, g))
    return issue(name, next, k, "password changed: other sessions are revoked")
}
```

The whole program (the second half is a client standing in for two devices, sending 12 requests):

```sober
// examples/web_login.sober
package main

// ログインのセッション: パスワードのハッシュ（crypto/password）と世代つきのトークン（std/session）を __Host- の cookie に載せる。
// ユーザーの行はハッシュの隣に世代を持ち、パスワードを変えると世代が進んで、それまでに発行したトークンは全部切れる（他の端末の古い cookie も）。
// ユーザーの表はdomain（task.NewDomain）に置く: ServeConnのrouteは並行に呼ばれうる（HTTP/2のストリームごとの子task）ので、可変の表を捕獲できない。
// domainの本体は先に確保した列の要素だけを書く（名前とハッシュのバイト・長さ・世代 — 表を伸ばさない。行の数の上限はmaxUsers）。
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

// ユーザーの表（domainの状態）: i番目の行の名前は names[i * nameCap ..] の nlen[i] バイト、ハッシュは hashes[i * hashCap ..] の hlen[i] バイト
const maxUsers = 16
const nameCap = 64
const hashCap = 160

type Users struct {
    n int
    names mut []byte
    nlen mut []int
    hashes mut []byte
    hlen mut []int
    gens mut []int
}

// 表の写し（task.Readの本体が返す — 不変の欄だけ。探しはこの上で行う）
type Snap struct {
    n int
    names []byte
    nlen []int
    hashes []byte
    hlen []int
    gens []int
}


// 表の行（見つからなければ found = false）
type Row struct {
    found bool
    hash string
    gen int
}



// 写しの中の名前nbの行
func lookup(st Snap, nb []byte) Row {
    mut at := -1
    mut i := 0
    while i < st.n {
        if st.nlen[i] == len(nb) {
            mut same := true
            mut j := 0
            while j < len(nb) {
                if st.names[i * nameCap + j] != nb[j] {
                    same = false
                }
                j += 1
            }
            if same {
                at = i
            }
        }
        i += 1
    }
    if at < 0 {
        return Row{found: false, hash: "", gen: 0}
    }
    mut hb := mut []byte{}
    mut j := 0
    while j < st.hlen[at] {
        hb = append(hb, st.hashes[at * hashCap + j])
        j += 1
    }
    return Row{found: true, hash: string(freeze(hb)) catch "", gen: st.gens[at]}
}

// 行を書く（無ければ足す — task.Updateの本体から）。gen < 0 = 足すだけ（あれば1）。結果 = 0（書いた）・1（もうある）・2（表が満杯か長すぎる）
func store(st mut Users, nb []byte, hb []byte, gen int) int {
    mut at := -1
    mut i := 0
    while i < st.n {
        if st.nlen[i] == len(nb) {
            mut same := true
            mut j := 0
            while j < len(nb) {
                if st.names[i * nameCap + j] != nb[j] {
                    same = false
                }
                j += 1
            }
            if same {
                at = i
            }
        }
        i += 1
    }
    if at >= 0 && gen < 0 {
        return 1
    }
    if len(nb) > nameCap || len(hb) > hashCap || (at < 0 && st.n >= maxUsers) {
        return 2
    }
    row := if at >= 0 { at } else { st.n }
    mut j := 0
    while j < len(nb) {
        st.names[row * nameCap + j] = nb[j]
        j += 1
    }
    j = 0
    while j < len(hb) {
        st.hashes[row * hashCap + j] = hb[j]
        j += 1
    }
    st.nlen[row] = len(nb)
    st.hlen[row] = len(hb)
    st.gens[row] = if gen < 0 { 0 } else { gen }
    if at < 0 {
        st.n += 1
    }
    return 0
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

// cookieのトークンを開いて、subject（根の行を引く名前）を返す（開けなければ空の名前と理由）
func opened(k session.Key, r http.server.Request) (session.Unchecked?, string) {
    raw := http.server.Cookie(r, cookieName)
    if raw == nil {
        return nil, "not logged in"
    }
    u, e := session.Open(k, raw, time.Now())
    if e != nil {
        return nil, switch e {
            case session.Bad{}: "invalid session: log in"
            case session.Expired{}: "session expired: log in again"
        }
    }
    return u, ""
}

// 開いたトークンを根の行（今の世代）と照らして、認可に使える名前を返す（使えなければ空の名前と理由）
func checked(u session.Unchecked, row Row) (string, string) {
    if !row.found {
        return "", "unknown user: log in"
    }
    c, es := session.Check(u, row.gen)
    if es != nil {
        return "", "session revoked (the password was changed): log in again"
    }
    who, _ := session.Who(c)
    return who, ""
}

// この端末の cookie を消す（トークンそのものは期限まで有効 — 全部の端末を切るのは世代を進める changePassword）
func logout() http.server.Response {
    c := http.server.SetCookie{name: cookieName, value: "", maxAge: 0}
    return http.server.Response{status: 200, contentType: "text/plain", body: bytes("bye"), cookies: []http.server.SetCookie{c}}
}

// 保存したハッシュとパスワードの照合（失敗は偽）
func verifyPw(stored string, pw string) bool {
    return crypto.password.Verify(stored, pw) catch false
}

// nbの行（task.Readで表の写しを取り、写しの上で探す）
func rowOf(users task.Domain[Users], nb []byte) Row {
    return lookup(task.Read(users, (st Users) => Snap{n: st.n, names: clone(st.names), nlen: clone(st.nlen), hashes: clone(st.hashes), hlen: clone(st.hlen), gens: clone(st.gens)}), nb)
}

// パスワードをハッシュにして、世代0の行を足す
func signup(users task.Domain[Users], r http.server.Request) http.server.Response {
    name := field(r, "name")
    pw := field(r, "password")
    if name == nil || pw == nil || name == "" {
        return http.server.Status(400)
    }
    nb := bytes(name)
    if rowOf(users, nb).found {
        return http.server.Status(409)
    }
    h := crypto.password.Argon2id(pw) catch return http.server.Status(500)
    hb := bytes(h)
    // 確かめてから書くまでに同じ名前が足されていれば409（task.Updateの中で決める）
    code := task.Update(users, (st mut Users) => store(mut st, nb, hb, -1))
    if code != 0 {
        return http.server.Status(if code == 1 { 409 } else { 507 })
    }
    return http.server.Response{status: 201, contentType: "text/plain", body: bytes("created ${name}")}
}

// パスワードを照合して、今の世代のトークンをcookieに載せる
func logIn(users task.Domain[Users], k session.Key, r http.server.Request) http.server.Response {
    name := field(r, "name")
    pw := field(r, "password")
    if name == nil || pw == nil {
        return http.server.Status(400)
    }
    row := rowOf(users, bytes(name))
    if !row.found || !verifyPw(row.hash, pw) {
        return unauthorized("wrong name or password")
    }
    return issue(name, User{hash: row.hash, gen: row.gen}, k, "welcome ${name}")
}

// cookieのトークンの持ち主（nameが "" ならwhyが断る理由）
func whoami(users task.Domain[Users], k session.Key, r http.server.Request) (string, string) {
    u, why := opened(k, r)
    if u == nil {
        return "", why
    }
    return checked(u, rowOf(users, bytes(session.Subject(u))))
}

// 古いパスワードを検証して新しいハッシュに替え、世代を進める（他の端末のトークンは全部Staleになる）。この端末には新しい世代のトークンを渡し直す
func changePassword(users task.Domain[Users], k session.Key, r http.server.Request) http.server.Response {
    name, why := whoami(users, k, r)
    if name == "" {
        return unauthorized(why)
    }
    oldPw := field(r, "old")
    newPw := field(r, "new")
    if oldPw == nil || newPw == nil {
        return http.server.Status(400)
    }
    row := rowOf(users, bytes(name))
    if !verifyPw(row.hash, oldPw) {
        return http.server.Response{status: 403, contentType: "text/plain", body: bytes("wrong password")}
    }
    h := crypto.password.Argon2id(newPw) catch return http.server.Status(500)
    nb := bytes(name)
    hb := bytes(h)
    next := User{hash: h, gen: row.gen + 1}
    g := next.gen
    _ = task.Update(users, (st mut Users) => store(mut st, nb, hb, g))
    return issue(name, next, k, "password changed: other sessions are revoked")
}

func route(users task.Domain[Users], k session.Key, r http.server.Request) http.server.Response {
    if r.method == "POST" && r.path == "/signup" {
        return signup(users, r)
    }
    if r.method == "POST" && r.path == "/login" {
        return logIn(users, k, r)
    }
    if r.method == "GET" && r.path == "/me" {
        name, why := whoami(users, k, r)
        return if name == "" { unauthorized(why) } else { http.server.Text("hello ${name}") }
    }
    if r.method == "POST" && r.path == "/change-password" {
        return changePassword(users, k, r)
    }
    if r.method == "POST" && r.path == "/logout" {
        return logout()
    }
    return http.server.Status(404)
}

// n 本の接続を順に受ける（ユーザーの表のdomainはこのscopeの寿命）
func serve(l net.Listener, n int) error? {
    _, e := task.Run((s) => {
        mut u := Users{n: 0, names: mut []byte{}, nlen: mut []int{}, hashes: mut []byte{}, hlen: mut []int{}, gens: mut []int{}}
        while len(u.names) < maxUsers * nameCap {
            u.names = append(u.names, byte(0))
        }
        while len(u.hashes) < maxUsers * hashCap {
            u.hashes = append(u.hashes, byte(0))
        }
        while len(u.gens) < maxUsers {
            u.nlen = append(u.nlen, 0)
            u.hlen = append(u.hlen, 0)
            u.gens = append(u.gens, 0)
        }
        users := task.NewDomain(s, u)
        k := session.KeyNew()
        serveWith(l, n, (r) => route(users, k, r)) catch 1
    })
    return e
}

func serveWith(l net.Listener, n int, rt func(http.server.Request) http.server.Response) (int, error?) {
    mut i := 0
    for c <- net.Accept(l)? {
        http.server.ServeConn(c, rt)?
        i = i + 1
        if i == n {
            break
        }
    }
    return 0, nil
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

Output:

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

Lines 6–7 of the output show the generation at work. After the password is changed on the laptop, both the phone's cookie and the laptop's old cookie are refused as `Stale`.

What the token defends against and what it does not (a token stolen within the same generation, per-device revocation, a leaked key, replays) is listed in the threat model of [std/session](../std/session.ja.md). It also describes how to revoke per device by keeping the `id` read with `session.Of` in the app's own table (`Of` returns all the fields of the `Claims` — generation, id, issue and expiry times — and, like `Who`, returns false for the zero value).

## 8. Pitfalls

- `http.server.Form` and `http.server.Query` do not decode values. `a+b` and `%40` come back raw, so a value like a password becomes something else. Read decoded values with `url.ParseQuery` (`field` in the example)

```sober
// examples/web_login.sober (excerpt)
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

- `__Host-` cookies assume https. Browsers do not accept a `Secure` cookie from an http response, so the example in section 7 (loopback http) cannot be tried in a browser. The example's client (`std/http/client`) keeps the cookie as a value: it reads it with `http.client.CookieValue` and sends it with the next request's `cookies:` (`send`) — the regular way for a client to carry cookies, and it works unchanged against a server published over https (section 9)
- The values of a `Request` live only for that one request (section 1). Copy them before putting them in a table that outlives the request

- To respond after a wait, return `http.server.Delayed(ms, response)` instead of calling `os.Sleep` inside the handler. The response goes out at the same time or slightly earlier (it does not wait for its turn to run after the wait ends), and the connection does not keep the handler's stack and the request region while it waits, so connections that are waiting stay as small as keep-alive connections. The wait happens right before that response's head; earlier responses on the same connection are sent first

```sober
// examples/http_delayed.sober (excerpt)
func route(r http.server.Request) http.server.Response {
    if r.path == "/slow" {
        return http.server.Delayed(20, http.server.Text("slow\n"))
    }
    return http.server.Text("hello\n")
}
```

## 9. Publishing over TLS — `tls.Serve`

To publish over https, use `std/tls`. `tls.Serve` completes the handshake on each connection before calling the handler, and the handler receives a `net.Conn` that carries the TLS state, which it passes to `http.server.ServeConn` like a plain connection (`net.Recv` / `net.Send` encrypt and decrypt too).

```sober
// examples/web_server_tls.sober
package main

// Web サーバのガイド 9 節: https で公開する。tls.Serve が handshake を済ませた接続だけを app に渡し、app はその接続（TLS の状態を持つ
// net.Conn）を平文の接続と同じに http.server.ServeConn へ渡す。証明書と鍵は @embed で焼き込む（起動時にファイルから読むなら tls.Load）。
// 既定の走りは設定の確認だけ。`web_server_tls live <port>` で127.0.0.1:<port> にhttpsで待ち受ける
// （試すなら curl --cacert testdata/crypto/httparena-server.crt https://localhost:<port>/ — 自己署名の証明書なので起点を足す）

import "std/http/server"
import "std/net"
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
func app(c net.Conn) error? {
    return http.server.ServeConn(c, route)
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

Output:

```
certificate and key: ok
```

- `tls.Serve` is a TLS 1.3 server (X25519, AES-128-GCM / ChaCha20-Poly1305, RSA certificates). There is no setting to fall back to older versions
- `tls.Serve` listens on `addr` itself (no `net.Listen` in between). One connection is one task, and the promises about accepting (absorbing failures and deaths, deadlines) are the same as for `net.Serve`
- Pass the certificate chain and the key to `tls.Parse` as PEM strings. The example bakes them into the executable with `@embed`. To read them from files at startup, use `tls.Load(certPath, keyPath)`
- `tls.Alpn(cfg, []string{"http/1.1"})` sets the protocols to select with ALPN
- On a TLS connection, `ServeConn` queues the responses for one received chunk and sends them together before the next receive (`net.Put` / `net.Flush`). Every optional field is in the [std/http/server](../std/http-server.ja.md) reference
- In the repository's checks the example only checks its configuration; `live <port>` actually listens (see the note at the top of the example for how to try it)

## 10. HTTP/2: `proto:` and ALPN

`http.server.ServeConn` answers HTTP/1.1 only by default. To answer HTTP/2 too, write the optional argument `proto:`. On a plain connection it answers h2c (with prior knowledge, RFC 9113); on a TLS connection it answers h2 when ALPN picks it.

| `proto:` | Plain connection | TLS connection |
|---|---|---|
| `http.server.H1` (default) | HTTP/1.1 | HTTP/1.1 |
| `http.server.H2` | HTTP/2 only. A connection that does not start with the preface gets GOAWAY (PROTOCOL_ERROR) | HTTP/2 |
| `http.server.Both` | HTTP/2 when the first 24 bytes are the preface, HTTP/1.1 otherwise | HTTP/2 when ALPN picked h2, HTTP/1.1 otherwise |

### Plain connections (h2c)

```sober
// examples/http_h2c.sober
package main

// HTTP/2（h2c — 事前知識）に応じるサーバー（ServeConnのproto:）。ストリーム1本 = 子task 1本で、遅いハンドラ（/slow）が
// 同じ接続の速いハンドラ（/fast）を止めない。引数なしでは何もしない。`live <port>` で127.0.0.1の<port>にHTTP/2とHTTP/1.1の両方（proto: Both）、
// `live <port> h2` でHTTP/2だけ（proto: H2）で応じる（scripts/h2spec.shがh2specとcurl --http2-prior-knowledgeで検査する）:
//
//     curl --http2-prior-knowledge -Z http://127.0.0.1:<port>/slow http://127.0.0.1:<port>/fast

import "std/http/server"
import "std/net"
import "std/os"

func route(r http.server.Request) http.server.Response {
    if r.path == "/slow" {
        os.Sleep(300)
        return http.server.Text("slow\n")
    }
    if r.path == "/stream" {
        return http.server.Response{status: 200, contentType: "text/plain", stream: (out, emit) => {
            _ = emit(mut out, bytes("one\n"))
            emit(mut out, bytes("two\n"))
        }}
    }
    return http.server.Text("hello ${r.path}\n")
}

func both(c net.Conn) error? {
    return http.server.ServeConn(c, route, proto: http.server.Both)
}

func only(c net.Conn) error? {
    return http.server.ServeConn(c, route, proto: http.server.H2)
}

func serve(port string, h2only bool) error? {
    for l <- net.Listen("127.0.0.1:${port}")? {
        if h2only {
            net.Serve(l, only)?
        } else {
            net.Serve(l, both)?
        }
    }
    return nil
}

func main() int {
    args, _ := os.Args()
    if len(args) >= 3 && args[1] == "live" {
        return if serve(args[2], len(args) >= 4 && args[3] == "h2") == nil { 0 } else { 1 }
    }
    println("h2c server: run with live <port>")
    return 0
}
```

Output:

```
h2c server: run with live <port>
```

- `both` passes `proto: http.server.Both` and answers both HTTP/2 and HTTP/1.1 on the same port. `only` passes `proto: http.server.H2` and answers HTTP/2 only
- Plain HTTP/2 is only the form where the peer speaks HTTP/2 from the start (prior knowledge). An HTTP/1.1 request with `Upgrade: h2c` is not switched over; it is answered as HTTP/1.1
- In the checks the example does nothing; `live <port>` makes it listen (how to try it is in the comment at the top of the example)

### HTTP/2 over TLS

On a TLS connection the protocol is decided by ALPN in the handshake and by `proto:`, not by the connection preface (RFC 9113 3.2). List the protocols to accept in `tls.Alpn`, in the server's order of preference.

```sober
// examples/web_server_h2.sober
package main

// Web サーバのガイド 10 節: TLS の上で HTTP/2 に応じる。tls.Alpn に受けるプロトコルをサーバの好みの順（h2 を先）で並べ、
// ServeConn を proto: Both で呼ぶ。TLS の接続では、ALPN で h2 に決まれば HTTP/2、http/1.1 に決まれば HTTP/1.1 で応じる（前置きは見ない）。
// 決まったプロトコルは tls.Protocol(c) で読める。既定の走りは設定の確認だけ。`web_server_h2 live <port>` で 127.0.0.1:<port> に https で待ち受ける
// （試すなら curl --http2 --cacert testdata/crypto/httparena-server.crt https://localhost:<port>/。自己署名の証明書なので起点を足す）

import "std/http/server"
import "std/net"
import "std/os"
import "std/tls"

@embed("testdata/crypto/httparena-server.*")
const Certs = map[string]string{}

func file(p string) string {
    v := Certs[p]
    return if v != nil { v } else { "" }
}

// 接続1本のhandler: ALPN で決まったプロトコルを読み、route がそれを返す（route は p を捕まえるだけで、可変は捕まえない）
func app(c net.Conn) error? {
    p := tls.Protocol(c)
    return http.server.ServeConn(c, (r http.server.Request) => http.server.Text("hello over ${p}\n"), proto: http.server.Both)
}

func main() int {
    cfg, e := tls.Parse(file("testdata/crypto/httparena-server.crt"), file("testdata/crypto/httparena-server.key"))
    if e != nil {
        println("bad certificate or key")
        return 1
    }
    h2 := tls.Alpn(cfg, []string{"h2", "http/1.1"})
    println("certificate and key: ok, ALPN h2 first")
    args, _ := os.Args()
    if len(args) >= 3 && args[1] == "live" {
        e2 := tls.Serve("127.0.0.1:${args[2]}", h2, app)
        return if e2 == nil { 0 } else { 1 }
    }
    return 0
}
```

Output:

```
certificate and key: ok, ALPN h2 first
```

- `tls.Alpn(cfg, []string{"h2", "http/1.1"})` picks h2 for a peer that offers h2, and http/1.1 for a peer that offers only http/1.1. When nothing overlaps with the peer's offer, the handshake ends with no_application_protocol (RFC 7301)
- The ALPN default of a Config from `tls.Parse` is http/1.1 only. To answer HTTP/2 over TLS, add h2 with `tls.Alpn`
- `proto: http.server.Both` splits HTTP/2 and HTTP/1.1 by the ALPN result. `proto: http.server.H2` speaks HTTP/2 whatever ALPN picked, so pair it with a Config that lists h2 only
- `tls.Protocol(c)` returns the protocol that ALPN picked (`"h2"`, `"http/1.1"`, or `""` when none was offered, nothing matched, or the connection is plain)
- In the checks the example only checks the configuration; `live <port>` makes it listen

### One child task per stream

Under HTTP/2, `ServeConn` calls the route on a child task per stream. A slow route does not hold up the other streams of the same connection. In the h2c example above, `/fast` on the same connection returns right away while `/slow` waits 300 milliseconds.

The route can be called concurrently, so it cannot capture a `mut` binding or `mut` contents. The rule holds whatever `proto:` is, and check and build reject it at the call site. Where state that spans requests lives is in [section 3](#3-where-state-lives--a-domain-or-an-outside-store).

When a stream's child dies (the route panics or exceeds its budget), the server sends RST_STREAM (INTERNAL_ERROR) for that stream, and the other streams of the connection go on.

### The client side

`http.client.Request`, `http.client.Stream` and `http.client.Open` offer h2 by ALPN to https targets and speak HTTP/2 when the server picks it (one stream at a time per connection). The response shape and the rules for maxBody, redirects and sessions stay the same. http targets stay on HTTP/1.1 only, as before. See [Web client](web-client.md) for how to use them.

## 11. Running in production

A program that uses std/net (and so `std/http/server` and `std/tls`) asks three things of its environment. The details are in the "Running servers" section of [Install](install.md).

- io_uring: Docker's default seccomp profile blocks io_uring. Sober then falls back to epoll and works, but more slowly
- memlock: on kernels before Linux 5.12, the io_uring ring of each worker counts against the whole user's `RLIMIT_MEMLOCK`. When it runs short, Sober falls back as above
- nofile: one connection is one file descriptor. Raise the soft limit (1024 by default in many places) to at least the number of connections you expect

The fields of `net.Serve` set the limits on accepting connections.

| Field | Default | Meaning |
|---|---|---|
| `budget:` | 64 KiB | the reservation of one connection (admission counts it plus `task.Fixed()`; the excess is borrowed from the free part of the ceiling, and if the ceiling is full, that connection's task dies) |
| `conns:` | none | cap on simultaneous connections (when written, `(budget + task.Fixed()) × conns` is the ceiling for accepting; left out, there is no cap on the count, and a byte ceiling derived from what remains of the root ceiling decides admission) |
| `reject:` | none | at the ceiling, bytes sent once to a new connection before closing it (left out, accepted connections wait in a runtime queue, and admitted connections that receive nothing or receive slowly are cut first to free slots) |
| `region:` | 128 MiB | limit on one region of a connection's task (beyond it, that connection's task dies) |

The root ceiling is the memory ceiling of the process (from the cgroup memory.max, or else physical memory). `net.Waiting()` reports the number of connections waiting for admission. Setups that cannot use io_uring (the epoll path) have the same runtime queue and take slots back the same way. The details are in section 9 of the [security guide](security.md#9-resource-exhaustion-denial-of-service).

`ServeConn`'s `maxBody:` may exceed `budget:`. A body beyond the reservation is received by borrowing from the free part of the ceiling. A `Content-Length` body borrows its whole amount when it starts. If the ceiling is full, it waits for room in arrival order until `bodyWait:`. If it still does not fit, that connection's task dies with `RegionExceeded{cause: budget}` (not 413). Raise `budget:` only when you want to avoid borrowing.

## 12. The boundary of a handover — replacing the binary

When you replace the binary with a new version, these are the two things you can do today.

- SIGTERM / SIGINT stop it immediately. This holds even when it runs as a container's init (PID 1) (exit codes 143 / 130). It stops at once, and connections in progress are cut
- The old and the new can listen on the same port at once. `net.Listen` sets SO_REUSEPORT, so a new process under the same uid can listen on the same address while the old one is still running. The kernel spreads incoming connections across both. If you start the new version before stopping the old one, only the connections the old version was handling are cut. The flip side of this (another process under the same uid can also join the same address) is in the [security guide](security.md#12-what-sober-does-not-protect)

Not there yet: there is no way to signal the old version from outside to "stop accepting, finish the connections in progress, then exit" (graceful drain). `net.Serve` stops accepting at the deadline of its enclosing scope and returns after the running connections settle, but the deadline is a value fixed at startup and cannot be triggered by a signal.

## 13. What this protects

- The request head and body have limits by default (431 / 413); so does the time spent waiting for the peer (`headWait:` / `bodyWait:` / `sendWait:`), and so do the reservation per connection and the total memory for accepting
- `Set-Cookie` can be written only through typed fields, and left-out fields are on the safe side (`Secure`, `HttpOnly`, `SameSite=Lax`, host-only). Loosening fields are spelled `dangerously…`, so grep finds them
- CR / LF cannot be smuggled into response headers (response splitting is a panic), and the headers the standard library writes (`Content-Length` and so on) cannot be written by hand
- The default storage policy is `Cache-Control: private` (shared caches are not allowed to keep authenticated responses)
- Parallel handlers cannot share `mut` state (data races cannot be written)
- Session tokens are signed and expire, and the value naming the owner cannot be made without looking up the generation
