# PostgreSQL

English | [日本語](postgres.ja.md)

This guide walks through using PostgreSQL with `std/pg` on three small subjects: a table of items, moving a balance between two accounts, and requests served from a pool.

The examples take the database from environment variables (`PG_URL` = `postgres://user@host[:port]/db`, `PG_PASSWORD`, and `PG_CA` = the path of a PEM file with a private CA). The repository's checks have no database, so they only build and check these three examples. `scripts/pgoracle.sh` is what runs them and compares their output; it starts throwaway PostgreSQL 17 and 18 servers.

Before this: sections 1–5 of the [language tour](tour.md) and error handling (`?` and `catch`). Scopes handed to a k (CPS) work as in section 6 of [Web client](web-client.md).

## 1. Connecting — `pg.Open`

`pg.Open(url, k, policy: …)` connects, authenticates, passes the connection `pg.Conn` to k, and closes it when k returns. A connection only exists as k's parameter, so a forgotten close cannot be written.

The defaults lean to the safe side.

- TLS 1.3 (after SSLRequest, with the certificate chain verified — there is no field that turns verification off)
- SCRAM-SHA-256-PLUS authentication (channel binding tied to the TLS keys — a party that re-terminates TLS in the middle never gets the password proof). MD5 and plaintext password authentication are refused
- The password cannot go in the URL; it goes in the `@secret` field of `Policy` (it does not leak into logs or string interpolation)

The only fields that relax the defaults are spelled with `dangerously` (`dangerouslyPlaintext` and others). Every place that relaxes them can be found with grep, and `sober check` warns about each one. The deadline (`timeout` — per call, 30 seconds by default) and the limit on one row (`maxRow` — 16 MiB by default) are also fields of `Policy`.

## 2. Running statements — `pg.Exec` and `pg.Script`

The text of SQL must be a const. The `sql` of `pg.Exec` / `pg.Query` / `pg.Script` only takes a string literal or a const; a string built at run time fails to compile. Values always travel as the `$1` … arguments (`args: []pg.Value{…}`), so SQL injection cannot be written.

- `pg.Exec(c, sql, args: …)` — runs one statement and returns the number of rows it affected
- `pg.Script(c, sql)` — sends several statements separated by `;`, without arguments, in one go (creating tables, migrations). It stops at the first error

Each statement text is prepared once per connection; from the second use on, the type lookup is skipped.

## 3. Reading rows — `pg.Query`

`for r <- pg.Query(c, sql, args: …)? { … }` receives one row at a time. Columns are picked by number and read either typed (`pg.ColInt`, `pg.ColString` and others) or as a value with `pg.Col(r, i)` (the `pg.Value` union — NULL is `pg.Null{}`). A typed read returns `WrongType` if the type differs and `NullColumn` on NULL. For a json / jsonb column, `pg.ColJsonText(r, i)` returns the JSON text as a string, so `json.Put` can copy it into a response as is (`pg.ColJson` returns the same text as `[]byte`). The UTF-8 of text and json columns is checked when the row arrives; broken UTF-8 is `Protocol`.

Leaving the body early with `break` or `?` discards the remaining rows and keeps the connection usable. Sending another statement on the same connection while its rows are still streaming is a panic (`Reentered`). Read the rows to the end first, or use another connection.

## 4. Telling failures apart

`pg.Server` is the server's ErrorResponse, and `code` is the SQLSTATE (unique violation 23505, check violation 23514, serialization failure 40001 and so on). `message` / `detail` / `hint` are text for people, and `constraint` is the name of the violated constraint. After a server error the connection stays usable. After any other failure (`Closed`, `Protocol`, `io.Expired`) the connection is dropped and the next call returns `Closed`.

Here is all of the above in one example.

```sober
// examples/pg_shop.sober
package main

// PostgreSQL のガイド 1〜4 節（docs/guide/postgres）: 接続・文の実行・行の読み・誤りの見分け。繋ぎ先は環境変数（std/env）から —
// PG_URL = "postgres://user@host/db"・PG_PASSWORD・PG_CA = 私的 PKI の CA の PEM のパス（無ければ焼き込みの WebPKI のルートだけ）。
// リポジトリの検査（scripts/pgoracle.sh）が使い捨ての PostgreSQL 17 / 18 を立ててこの例を走らせ、出力を照合する

import "std/env"
import "std/io"
import "std/pg"
import "std/tls"

const Url = env.StrVar{name: "PG_URL", help: "the database URL (postgres://user@host[:port]/db)"}
const Password = env.StrVar{name: "PG_PASSWORD", help: "the SCRAM password", opt: true}
const Ca = env.StrVar{name: "PG_CA", help: "a PEM file of extra trusted CAs", opt: true}

const Vars = env.Table{strs: []env.StrVar{Url, Password, Ca}}

// 方針: password は URL に書かず Policy に（@secret のフィールド）・私的 PKI の CA は extraRoots に足す
func policyOf(e env.Values) pg.Policy {
    pw := env.StrOpt(e, Password)
    ca := env.StrOpt(e, Ca)
    roots := if ca == nil { nil } else { rootsOf(ca) }
    return pg.Policy{password: if pw == nil { "" } else { pw }, extraRoots: roots}
}

func rootsOf(path string) tls.Roots? {
    pem := io.ReadFile(path) catch return nil
    return tls.ParseRoots(string(pem) catch "") catch nil
}

func setup(c pg.Conn) error? {
    // 複数の文（; 区切り・引数なし）は Script で 1 回に
    pg.Script(c, "create temp table item (id int8 primary key, name text not null, price int4 not null)")?
    add(c, 1, "apple", 120)?
    add(c, 2, "pear", 340)?
    add(c, 3, "fig", 560)?
    return nil
}

// 値は $1 … の引数で渡す（SQL の文面は const 仮引数 — 実行時に組んだ文字列は渡せない）
func add(c pg.Conn, id int, name string, price int) error? {
    _ = pg.Exec(c, "insert into item (id, name, price) values ($1, $2, $3)", args: []pg.Value{pg.Int{v: id}, pg.String{v: name}, pg.Int{v: price}})?
    return nil
}

func list(c pg.Conn, limit int) error? {
    for r <- pg.Query(c, "select id, name, price from item where price <= $1 order by id", args: []pg.Value{pg.Int{v: limit}})? {
        println("${pg.ColInt(r, 0)?} ${pg.ColString(r, 1)?} ${pg.ColInt(r, 2)?}")
    }
    return nil
}

// サーバの誤りは Server（code = SQLSTATE）— 接続はそのまま使える
func duplicate(c pg.Conn) {
    _, e := pg.Exec(c, "insert into item (id, name, price) values (3, 'dup', 1)")
    switch e {
    case nil: println("inserted?")
    case pg.Server{code, message, detail, constraint, hint}: println("server error ${code} on ${constraint}")
    default: println("other error")
    }
    n := pg.Exec(c, "select 1") catch -1
    println("still usable: ${n}")
}

func shop(c pg.Conn) {
    se := setup(c)
    if se != nil {
        println("setup failed")
        return
    }
    le := list(c, 400)
    if le != nil {
        println("list failed")
    }
    duplicate(c)
}

func main() int {
    e, err := env.Load(Vars)
    if err != nil {
        _ = io.WriteStdout(bytes(env.Format(err)))
        return 1
    }
    oe := pg.Open(env.Str(e, Url), shop, policy: policyOf(e))
    if oe != nil {
        println("open failed")
        return 1
    }
    return 0
}
```

Output on PostgreSQL 17 / 18 (compared by `scripts/pgoracle.sh`):

```
1 apple 120
2 pear 340
server error 23505 on item_pkey
still usable: 1
```

## 5. Transactions — `pg.Tx`

`pg.Tx(c, k, isolation: …, readOnly: …)` runs k as a transaction. It makes one promise.

- If k finishes normally, COMMIT; if it does not (k is left with `?`), ROLLBACK

To commit a success that ends early, let k run to its end. If k swallows a statement error with `catch` and still finishes normally, the server's transaction is already in the failed state, so Tx rolls it back and returns `pg.Aborted` (nothing was committed).

- A nested `pg.Tx` is a SAVEPOINT. A failure inside rolls back only the inside, and the outer transaction can go on
- The isolation level (`pg.ReadCommitted` / `pg.RepeatableRead` / `pg.Serializable`) and `readOnly` take effect only on the outermost Tx; nested ones inherit them
- Nothing is retried automatically. A serialization failure (40001) under `Serializable` comes back as `pg.Server`, and the caller decides how many times to try again

```sober
// examples/pg_transfer.sober
package main

// PostgreSQL のガイド 5 節（docs/guide/postgres）: トランザクション。pg.Tx の k が普通に終われば COMMIT・k の中の ? で抜けたら ROLLBACK。
// 入れ子は SAVEPOINT・直列化の失敗（40001）は自動で再試行しない — 呼び手が回数を決めて書き直す。繋ぎ先は pg_shop と同じ環境変数

import "std/env"
import "std/io"
import "std/pg"
import "std/tls"

const Url = env.StrVar{name: "PG_URL", help: "the database URL (postgres://user@host[:port]/db)"}
const Password = env.StrVar{name: "PG_PASSWORD", help: "the SCRAM password", opt: true}
const Ca = env.StrVar{name: "PG_CA", help: "a PEM file of extra trusted CAs", opt: true}

const Vars = env.Table{strs: []env.StrVar{Url, Password, Ca}}

func policyOf(e env.Values) pg.Policy {
    pw := env.StrOpt(e, Password)
    ca := env.StrOpt(e, Ca)
    roots := if ca == nil { nil } else { rootsOf(ca) }
    return pg.Policy{password: if pw == nil { "" } else { pw }, extraRoots: roots}
}

func rootsOf(path string) tls.Roots? {
    pem := io.ReadFile(path) catch return nil
    return tls.ParseRoots(string(pem) catch "") catch nil
}

// 残高の移し替え: 2 つの文が両方効くか、どちらも効かないか
func transfer(c pg.Conn, from int, to int, amount int) error? {
    pg.Tx(c, (tc) => {
        _ = pg.Exec(tc, "update account set balance = balance - $1 where id = $2", args: []pg.Value{pg.Int{v: amount}, pg.Int{v: from}})?
        // 残高が負になる移し替えは check 制約（balance >= 0）が 23514 で断る → ? で抜けて ROLLBACK
        _ = pg.Exec(tc, "update account set balance = balance + $1 where id = $2", args: []pg.Value{pg.Int{v: amount}, pg.Int{v: to}})?
    }, isolation: pg.Serializable)?
    return nil
}

// 直列化の失敗だけを数回まで書き直す（他の誤りはそのまま返す）
func transferRetry(c pg.Conn, from int, to int, amount int) error? {
    mut last := transfer(c, from, to, amount)
    mut n := 1
    while n < 3 && serialization(last) {
        last = transfer(c, from, to, amount)
        n += 1
    }
    return last
}

func serialization(e error?) bool {
    return switch e {
    case nil: false
    case pg.Server{code, message, detail, constraint, hint}: code == "40001"
    default: false
    }
}

func balances(c pg.Conn) error? {
    for r <- pg.Query(c, "select id, balance from account order by id")? {
        println("  account ${pg.ColInt(r, 0)?}: ${pg.ColInt(r, 1)?}")
    }
    return nil
}

func bank(c pg.Conn) {
    se := pg.Script(c, "create temp table account (id int8 primary key, balance int8 not null check (balance >= 0)); insert into account values (1, 100), (2, 0)")
    if se != nil {
        println("setup failed")
        return
    }
    ok := transferRetry(c, 1, 2, 30)
    println("transfer 30: ${if ok == nil { "ok" } else { "failed" }}")
    _ = balances(c)
    over := transferRetry(c, 1, 2, 500)
    println("transfer 500: ${describe(over)}")
    _ = balances(c)
}

func describe(e error?) string {
    switch e {
    case nil: return "ok"
    case pg.Server{code, message, detail, constraint, hint}: return "server error ${code}"
    default: {}
    }
    return "other error"
}

func main() int {
    e, err := env.Load(Vars)
    if err != nil {
        _ = io.WriteStdout(bytes(env.Format(err)))
        return 1
    }
    oe := pg.Open(env.Str(e, Url), bank, policy: policyOf(e))
    if oe != nil {
        println("open failed")
        return 1
    }
    return 0
}
```

Output on PostgreSQL 17 / 18 (compared by `scripts/pgoracle.sh`):

```
transfer 30: ok
  account 1: 70
  account 2: 30
transfer 500: server error 23514
  account 1: 70
  account 2: 30
```

The transfer of 500 makes the first balance negative, and the check constraint (23514) refuses it. `?` leaves k, so the transaction rolls back and the balances stay at 70 / 30.

## 6. Connection pooling — `pg.OpenPool` and `pg.With`

Calling `pg.Open` for every request pays a TLS handshake and a SCRAM round trip for every request. When many tasks use the same database, as a server does, use a pool that reuses the connections it has opened.

- `pg.OpenPool(url, k, size: …, wait: …, policy: …)` — passes k a pool `pg.Pool` that opens and shares up to `size` connections (default 10), and closes them all when k returns. Connections are opened on first borrow
- `pg.With(p, k)` — borrows one connection, passes it to k, and puts it back when k returns. When none is free, callers wait in arrival order; past `wait` (default 30 seconds) it returns `io.Expired`

The pool value `p` can be captured and passed to functions, so a handler can stay a named function that takes `p`. The connection value `pg.Conn` is still born only as k's parameter, so forgetting to return it cannot be written.

A connection goes back only when k returned normally and the connection is in a usable state. Otherwise it is closed and dropped, and the next borrow opens a new one (a connection in the middle of something is never handed to another borrower):

- k was left with `?` or return
- the connection broke (after `Closed` and the like)
- k returned in the middle of a transaction (still after `pg.Exec(c, "BEGIN")` — `pg.Tx` always closes before it returns, so it never hits this)

A connection held by a task that died (a panic, a region limit) is also reclaimed by the next `pg.With`, which corrects the counts. Each borrow can get a different connection, so temporary tables (per connection) and `SET` state do not carry over between borrows.

The k of `pg.OpenPool` runs inside the body of a task scope (a domain keeps the pool's counts), so k cannot `return` out of it.

```sober
// examples/pg_pool.sober
package main

// PostgreSQL のガイド 6 節（docs/guide/postgres）: 接続のプール。pg.OpenPool の k の中で受けるリクエストごとに pg.With で 1 本借りる —
// プールの値 p は関数の実引数にできるので、ハンドラは名前つきの関数のまま p を受ける。ここではリクエストをネットの代わりに決まった列で流す
// （http.server.ServeWith — net の接続なら `net.Serve(l, (c) => http.server.ServeConn(c, (r) => route(p, r)))` の形）。
// 繋ぎ先は環境変数（PG_URL・PG_PASSWORD・PG_CA — examples/pg_shop と同じ）。scripts/pgoracle.sh が PostgreSQL 17 / 18 で走らせて出力を照合する

import "std/convert"
import "std/env"
import "std/http"
import "std/http/server"
import "std/io"
import "std/pg"
import "std/strings"
import "std/tls"

const Url = env.StrVar{name: "PG_URL", help: "the database URL (postgres://user@host[:port]/db)"}
const Password = env.StrVar{name: "PG_PASSWORD", help: "the SCRAM password", opt: true}
const Ca = env.StrVar{name: "PG_CA", help: "a PEM file of extra trusted CAs", opt: true}

const Vars = env.Table{strs: []env.StrVar{Url, Password, Ca}}

func policyOf(e env.Values) pg.Policy {
    pw := env.StrOpt(e, Password)
    ca := env.StrOpt(e, Ca)
    roots := if ca == nil { nil } else { rootsOf(ca) }
    return pg.Policy{password: if pw == nil { "" } else { pw }, extraRoots: roots}
}

func rootsOf(path string) tls.Roots? {
    pem := io.ReadFile(path) catch return nil
    return tls.ParseRoots(string(pem) catch "") catch nil
}

func setup(c pg.Conn) error? {
    // プールの接続は借りるたびに違う接続でありうる — 一時表（接続ごと）ではなく普通の表に
    pg.Script(c, "drop table if exists pool_item; create table pool_item (id int8 primary key, name text not null, price int4 not null)")?
    _ = pg.Exec(c, "insert into pool_item (id, name, price) values (1, 'apple', 120), (2, 'pear', 340), (3, 'fig', 560)")?
    return nil
}

// GET /item?id=N — 1 行を読んで返す（借りた接続は With が返したあと次のリクエストへ回る）
func route(p pg.Pool, r http.server.Request) http.server.Response {
    q := http.server.Query(r, "id")
    id := if q == nil { -1 } else { convert.ParseInt(q) catch -1 }
    mut body := ""
    e := pg.With(p, (c) => {
        body = lookup(c, id) catch ""
    })
    if e != nil {
        return http.server.Status(http.ServiceUnavailable)
    }
    return if body == "" { http.server.Status(http.NotFound) } else { http.server.Text(body) }
}

func lookup(c pg.Conn, id int) (string, error?) {
    mut out := ""
    for row <- pg.Query(c, "select name, price from pool_item where id = $1", args: []pg.Value{pg.Int{v: id}})? {
        out = "${pg.ColString(row, 0)?} ${pg.ColInt(row, 1)?}\n"
    }
    return out, nil
}

// 送られたレスポンス（続けて来たリクエストのレスポンスは 1 回の送りにまとまることがある — 行の終わりの \r を落として印字）
func show(b []byte) error? {
    println(strings.TrimSpace(strings.Replace(string(b) catch "", "\r\n", "\n", -1)))
    return nil
}

func feed(s string, k func([]byte)) error? {
    k(bytes(s))
    return nil
}

func main() int {
    e, err := env.Load(Vars)
    if err != nil {
        _ = io.WriteStdout(bytes(env.Format(err)))
        return 1
    }
    reqs := "GET /item?id=1 HTTP/1.1\r\nHost: x\r\n\r\nGET /item?id=3 HTTP/1.1\r\nHost: x\r\n\r\nGET /item?id=9 HTTP/1.1\r\nHost: x\r\nConnection: close\r\n\r\n"
    oe := pg.OpenPool(env.Str(e, Url), (p) => {
        se := pg.With(p, (c) => {
            if setup(c) != nil {
                println("setup failed")
            }
        })
        if se != nil {
            println("with failed")
        } else {
            ve := http.server.ServeWith((k) => feed(reqs, k), (b) => show(b), (r) => route(p, r))
            println("served: ${ve == nil}")
        }
    }, size: 4, policy: policyOf(e))
    if oe != nil {
        println("pool failed")
        return 1
    }
    return 0
}
```

Output on PostgreSQL 17 / 18 (compared by `scripts/pgoracle.sh`):

```
HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 10

apple 120
HTTP/1.1 200 OK
Content-Type: text/plain
Cache-Control: private
Content-Length: 8

fig 560
HTTP/1.1 404 Not Found
Cache-Control: private
Content-Length: 0
Connection: close
served: true
```

## 7. What it protects, and what it does not do

- Protects: SQL text kept apart from values (the text is const only), verified TLS with channel binding, a hidden password (`@secret`), forgotten closes and returns (CPS), reuse of a connection in the middle of its rows (discarding and `Reentered`), and putting back a connection in the middle of something (the pool)
- Does not do (in this version): health checks for pooled connections (a query before borrowing, a maximum lifetime, an idle timeout — a broken connection makes the call that used it return `Closed`, and With drops it and opens a new one on the next borrow), LISTEN / NOTIFY, COPY, fetching through cursors in parts (rows stream one at a time, so the size of a result does not affect the working memory), and cancel requests (CancelRequest)
