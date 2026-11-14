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
- The values of a `Request` (`path`, `body` and so on) live only for that one request. They are gone when `route` returns, so copy them if they must outlive it
- For the checks, the example stops `net.Serve` by wrapping it in a 2-second deadline. In production, run it unwrapped and stop it with SIGTERM (sections 10 and 11)

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

## 3. Where state lives — serial, or an outside store

When you want state that changes across requests, like a table of users, there are exactly two places to put it.

- To keep the state in the process, accept serially. Accept connections one at a time with `for c <- net.Accept(l)`, and pass the `mut` table through the lambda you give to `ServeConn`. `ServeConn`'s `route` parameter is a borrow (used only during the call, never kept), so you can pass it a lambda that captures a `mut` value
- To accept in parallel, put the state in a domain or an outside store (a database or the like). `net.Serve` runs its handler in a separate task per connection, all at once, so the handler cannot capture a `mut` value. Two tasks writing the same table at the same time (a data race) is a shape the language does not let you write. To keep the state in the process, make it with `task.NewDomain(s, init)` inside the `task.Run` around `net.Serve`, let the handler capture it, and apply updates one at a time with `task.Update(d, (st mut T) => …)` (a domain body is a short update that neither waits nor does io — counters, small tables, the free slots of a connection pool). Ask an outside store for large or durable state

The example in section 7 (`examples/web_login.sober`) takes the first form. `serve` owns the `users` table and the key, and passes them to `route` through a borrowed lambda.

```sober
// examples/web_login.sober (excerpt)
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
// examples/web_login.sober (excerpt)
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

The handlers are ordinary functions that take `mut users`. Even a function that only reads (`whoami`) takes it as `mut`: passing a `mut` value to a non-`mut` parameter freezes it at that point, and check rejects any later write.

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

Output:

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

- Newlines in `data` are split into one `data:` line each. A newline in `event` or `id` is a panic (`BadEvent`)
- One `emit` is one chunk, so events reach the client right away, in the order you build them
- Do not let it be stored: set `cache: http.server.NoStore{}`. `text/event-stream` is excluded from `compression:` (passing `compression:` to `ServeWith` does not compress it)
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
// examples/web_login.sober (excerpt)
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

The whole program (the second half is a client standing in for two devices, sending 12 requests):

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

To publish over https, use `std/tls`. `tls.Serve` completes the handshake on each connection before calling the handler, and the handler connects `tls.Recv` / `tls.Send` to the receiving and sending sides of `http.server.ServeWith` (`ServeConn` is the same wrapper for a `net.Conn`).

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

Output:

```
certificate and key: ok
```

- `tls.Serve` is a TLS 1.3 server (X25519, AES-128-GCM / ChaCha20-Poly1305, RSA certificates). There is no setting to fall back to older versions
- `tls.Serve` listens on `addr` itself (no `net.Listen` in between). One connection is one task, and the promises about accepting (absorbing failures and deaths, deadlines) are the same as for `net.Serve`
- Pass the certificate chain and the key to `tls.Parse` as PEM strings. The example bakes them into the executable with `@embed`. To read them from files at startup, use `tls.Load(certPath, keyPath)`
- `tls.Alpn(cfg, []string{"http/1.1"})` sets the protocols to select with ALPN
- `ServeWith` also has an optional way to queue sends and send them together (`put:` — pass `tls.Put`). Every optional field is in the [std/http/server](../std/http-server.ja.md) reference
- In the repository's checks the example only checks its configuration; `live <port>` actually listens (see the note at the top of the example for how to try it)

## 10. Running in production

A program that uses std/net (and so `std/http/server` and `std/tls`) asks three things of its environment. The details are in the "Running servers" section of [Install](install.md).

- io_uring: Docker's default seccomp profile blocks io_uring. Sober then falls back to epoll and works, but more slowly
- memlock: on kernels before Linux 5.12, the io_uring ring of each worker counts against the whole user's `RLIMIT_MEMLOCK`. When it runs short, Sober falls back as above
- nofile: one connection is one file descriptor. Raise the soft limit (1024 by default in many places) to at least the number of connections you expect

The fields of `net.Serve` set the limits on accepting connections.

| Field | Default | Meaning |
|---|---|---|
| `budget:` | 64 KiB | memory one connection may use |
| `conns:` | 10000 | number of simultaneous connections (`budget × conns` is the ceiling for accepting — connections beyond it are closed) |
| `reject:` | none | bytes sent once to a connection that was not accepted (left out, it is closed without sending) |
| `region:` | 128 MiB | limit on one region of a connection's task (beyond it, that connection's task dies) |
| `maxWait:` | 100 ms | limit on waiting under load (tasks that have waited past it run first — the count and amount over it are `late` / `maxLate` in `task.Ledger()`) |

When you raise `ServeConn`'s `maxHead:` / `maxBody:`, raise `budget:` with them (a rule of thumb: `budget ≥ 3 × (maxHead + maxBody) + 16 KiB`).

## 11. The boundary of a handover — replacing the binary

When you replace the binary with a new version, these are the two things you can do today.

- SIGTERM / SIGINT stop it immediately. This holds even when it runs as a container's init (PID 1) (exit codes 143 / 130). It stops at once, and connections in progress are cut
- The old and the new can listen on the same port at once. `net.Listen` sets SO_REUSEPORT, so a new process under the same uid can listen on the same address while the old one is still running. The kernel spreads incoming connections across both. If you start the new version before stopping the old one, only the connections the old version was handling are cut. The flip side of this (another process under the same uid can also join the same address) is in the [security guide](security.md#12-what-sober-does-not-protect)

Not there yet: there is no way to signal the old version from outside to "stop accepting, finish the connections in progress, then exit" (graceful drain). `net.Serve` stops accepting at the deadline of its enclosing scope and returns after the running connections settle, but the deadline is a value fixed at startup and cannot be triggered by a signal.

## 12. What this protects

- The request head and body have limits by default (431 / 413); so do the memory per connection and the number of simultaneous connections
- `Set-Cookie` can be written only through typed fields, and left-out fields are on the safe side (`Secure`, `HttpOnly`, `SameSite=Lax`, host-only). Loosening fields are spelled `dangerously…`, so grep finds them
- CR / LF cannot be smuggled into response headers (response splitting is a panic), and the headers the standard library writes (`Content-Length` and so on) cannot be written by hand
- The default storage policy is `Cache-Control: private` (shared caches are not allowed to keep authenticated responses)
- Parallel handlers cannot share `mut` state (data races cannot be written)
- Session tokens are signed and expire, and the value naming the owner cannot be made without looking up the generation
