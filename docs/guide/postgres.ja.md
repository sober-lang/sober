# PostgreSQL

[English](postgres.md) | 日本語

`std/pg` でPostgreSQLを使う書き方を、小さな題材で見ていきます。題材は「商品の表」と「口座の残高の移し替え」と「プールで受けるリクエスト」です。

例は環境変数で繋ぎ先を受け取ります（`PG_URL` = `postgres://user@host[:port]/db`・`PG_PASSWORD`・`PG_CA` = 私的PKIのCAのPEMのパス）。リポジトリの検査はデータベースを持たないので、この3本の例はビルドして検査するだけです。走らせて出力を照合するのは `scripts/pgoracle.sh` で、使い捨てのPostgreSQL 17と18を立てて回します。

前提: [言語ツアー](tour.ja.md) の1〜5節と、エラーの扱い（`?` と `catch`）。範囲をkで受ける形（CPS）は [Webクライアント](web-client.ja.md) の6節と同じ考え方です。

## 1. 繋ぐ — `pg.Open`

`pg.Open(url, k, policy: …)` は、繋いで認証まで済ませた接続 `pg.Conn` をkに渡し、kが返ったら閉じます。接続の値はkの仮引数としてしか生まれないので、閉じ忘れは書けません。

既定は安全な側に寄せてあります。

- TLS 1.3（SSLRequestの後に証明書チェーンを検証します。検証を切るフィールドはありません）
- 認証はSCRAM-SHA-256-PLUS（TLSの鍵に縛ったchannel binding。途中でTLSを張り替える相手にpasswordの証明を渡しません）。MD5と平文のpasswordの認証には応じません
- passwordはURLに書けず、`Policy` の `@secret` のフィールドで渡します（ログや文字列の補間に漏れません）

既定を緩めるフィールドは `dangerously` で始まる綴りだけです（`dangerouslyPlaintext` ほか）。緩めた所はgrepで拾え、`sober check` が毎回警告します。期限（`timeout` — 呼び出し1回ごと・既定30秒）と1行の上限（`maxRow` — 既定16 MiB）も `Policy` のフィールドです。

## 2. 文を実行する — `pg.Exec` と `pg.Script`

SQLの文面はconstに限ります。`pg.Exec` / `pg.Query` / `pg.Script` の `sql` には文字列リテラルかconstしか渡せず、実行時に組んだ文字列はコンパイルで落ちます。値は必ず `$1` … の引数（`args: []pg.Value{…}`）で渡すので、SQLインジェクションは書けません。

- `pg.Exec(c, sql, args: …)` — 文を1つ実行して、影響した行の数を返す
- `pg.Script(c, sql)` — `;` で区切った複数の文を、引数なしで1回に送る（表の作成・migration）。最初の誤りで止まる

文面ごとのprepared statementは接続ごとに1回だけ作られ、2回目からは型の問い合わせを省きます。

## 3. 行を読む — `pg.Query`

`for r <- pg.Query(c, sql, args: …)? { … }` で1行ずつ受けます。列は番号で指し、型つきの読み（`pg.ColInt`・`pg.ColString` ほか）か、値 `pg.Col(r, i)`（`pg.Value` のunion — NULLは `pg.Null{}`）で読みます。型つきの読みは、型が違えば `WrongType`、NULLなら `NullColumn` を返します。json / jsonbの列は `pg.ColJsonText(r, i)` がJSONの字句をstringで返すので、`json.Put` でレスポンスへそのまま積めます（`pg.ColJson` は同じ字句を `[]byte` で）。textやjsonの列のUTF-8は行を受けたときに検証し、壊れていれば `Protocol` です。

本体を `break` や `?` で途中で抜けても、残りの行は読み捨てられ、接続はそのまま使えます。行を流している途中に同じ接続で別の文を投げるとpanic（`Reentered`）です。行を読み切ってから使うか、別の接続を使います。

## 4. 失敗を見分ける

`pg.Server` はサーバのErrorResponseで、`code` がSQLSTATEです（一意制約違反23505・check制約23514・直列化の失敗40001ほか）。`message` / `detail` / `hint` は人に見せる文面、`constraint` は違反した制約の名前です。サーバの誤りの後も接続はそのまま使えます。それ以外の失敗（`Closed`・`Protocol`・`io.Expired`）の後は接続を捨て、次の呼び出しは `Closed` を返します。

ここまでを1本にした例です。

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

PostgreSQL 17 / 18での出力（`scripts/pgoracle.sh` が照合）:

```
1 apple 120
2 pear 340
server error 23505 on item_pkey
still usable: 1
```

## 5. トランザクション — `pg.Tx`

`pg.Tx(c, k, isolation: …, readOnly: …)` はkをトランザクションとして走らせます。決まりは1つです。

- kが普通に終わればCOMMIT、普通に終わらなければ（kの中の `?` で抜けたら）ROLLBACK

早く抜けた成功をCOMMITしたいときは、kの最後まで流す形で書きます。kの中で文の誤りを `catch` で握りつぶしたままkが普通に終わったときは、サーバのトランザクションはもう失敗の状態なので、巻き戻して `pg.Aborted` を返します（何もCOMMITされていません）。

- 入れ子の `pg.Tx` はSAVEPOINTになります。内側の失敗は内側だけを巻き戻し、外は続けられます
- 分離の水準（`pg.ReadCommitted` / `pg.RepeatableRead` / `pg.Serializable`）と `readOnly` は一番外のTxだけが効き、入れ子は外を受け継ぎます
- 自動の再試行はしません。`Serializable` の直列化の失敗（40001）は `pg.Server` で返るので、何回まで書き直すかは呼び手が決めます

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

PostgreSQL 17 / 18での出力（`scripts/pgoracle.sh` が照合）:

```
transfer 30: ok
  account 1: 70
  account 2: 30
transfer 500: server error 23514
  account 1: 70
  account 2: 30
```

500の移し替えは1文目で残高が負になり、check制約（23514）で断られます。`?` でkを抜けるのでROLLBACKになり、残高は70 / 30のままです。

## 6. 接続のプール — `pg.OpenPool` と `pg.With`

リクエストごとに `pg.Open` すると、リクエストごとにTLSの握手とSCRAMの往復を払います。サーバのように多くのtaskが同じデータベースを使うときは、張った接続を使い回すプールにします。

- `pg.OpenPool(url, k, size: …, wait: …, policy: …)` — 接続を最大 `size` 本（既定10）まで張って共有するプール `pg.Pool` をkに渡し、kが返ったら全部閉じます。接続は最初に借りたときに張ります
- `pg.With(p, k)` — 接続を1本借りてkに渡し、kが返ったら預け直します。空きが無ければ返されるまで来た順に待ち、`wait`（既定30秒）を越えたら `io.Expired` を返します

プールの値 `p` は捕獲でき、関数の実引数にもできます。ハンドラは名前つきの関数のまま `p` を受けられます。接続の値 `pg.Conn` は今までどおりkの仮引数としてしか生まれないので、返し忘れは書けません。

預け直すのは、kが普通に返り、接続が使える状態のときだけです。次のどれかに当たる接続は閉じて捨て、次に借りたときに新しく張ります（途中の状態の接続を他の借り手に渡しません）。

- kを `?` やreturnで抜けた
- 接続が壊れた（`Closed` などの後）
- トランザクションの途中で返った（`pg.Exec(c, "BEGIN")` のまま。`pg.Tx` は必ず閉じて返るので当たりません）

借りているtaskが死んだ（panic・regionの上限）接続も、次の `pg.With` が回収して数を戻します。プールの接続は借りるたびに違う接続でありうるので、一時表（接続ごと）や `SET` の状態は借りをまたいで残りません。

`pg.OpenPool` のkはtaskのscopeの本体の中で走ります（プールの数をdomainが持つため）。kから `return` で外へは抜けられません。

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

PostgreSQL 17 / 18での出力（`scripts/pgoracle.sh` が照合）:

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

## 7. 何を守っているか / 何をしないか

- 守る: SQLの文面と値の分離（文面はconstだけ）・検証つきのTLSとchannel binding・passwordの秘匿（`@secret`）・閉じ忘れと返し忘れ（CPS）・行の途中の接続の再利用（読み捨てと `Reentered`）・途中の状態の接続の預け直し（プール）
- しない（今の版）: プールの接続の健全性の検査（借りる前の問い合わせ・最大寿命・待機の期限 — 壊れた接続は使った呼び出しが `Closed` を返し、Withが捨てて次に借りたときに張り直します）・LISTEN / NOTIFY・COPY・カーソルでの分割取得（行は1行ずつ流れるので、結果が大きくても作業域は増えません）・取り消しのリクエスト（CancelRequest）
