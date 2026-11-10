# std/pg

日本語

`import "std/pg"`

PostgreSQL のクライアント（wire protocol 3.0・extended query・TLS 1.3 + SCRAM-SHA-256-PLUS が既定）。SQL の文面は const の席（`@const` — 文字列リテラルか const）で、値は `$1` … の引数で渡す（実行時に組んだ SQL は書けない）。接続は Open の範囲の中だけ（CPS — 閉じ忘れが書けない）。文面ごとの prepared statement は接続ごとに 1 回だけ作り、引数の型と列の型を覚える。結果は binary 形式（第一陣の型）で受けて Value に写す。方針は呼び手のデータ Policy（ゼロ値 = 既定 — どの欄も安全な側）

```sober
pg.Open("postgres://app@db.local/shop", (c) => {
    _ = list(c, 500)
}, policy: pg.Policy{password: pw})?
```

```sober
func list(c pg.Conn, limit int) error? {
    for r <- pg.Query(c, "select id, name from item where price < $1", args: []pg.Value{pg.Int{v: limit}})? {
        println("${pg.ColInt(r, 0)?} ${pg.ColString(r, 1)?}")
    }
    return nil
}
```

## Policy

```sober
type Policy struct {
    password string @secret
    extraRoots tls.Roots?
    timeout int?
    maxRow int?
    appName string?
    dangerouslyPlaintext bool
    dangerouslyAllowNoChannelBinding bool
    dangerouslyAllowTls12 bool
}
```

方針（省いた欄・nil は既定）: password = SCRAM の password（URL には書かない・"" = 無し — サーバが SCRAM を求めれば 28P01 で断られる）・extraRoots = 焼き込みの WebPKI のルートに足す起点（私的 PKI — tls.ParseRoots の値）・timeout = 1 回の呼び出し〔Open の握手と認証・Query / Exec / Script の往復 — Query は k の時間も含む〕の期限 ns・既定 30 秒〔0 以下も既定〕・maxRow = 1 つのメッセージ〔行〕の上限バイト・既定 16 MiB・上限 1 GiB・appName = application\_name〔既定 "sober"〕・dangerouslyPlaintext = TLS を使わない・dangerouslyAllowNoChannelBinding = TLS の上で SCRAM-SHA-256-PLUS を出さないサーバ〔PgBouncer 等〕も受ける・dangerouslyAllowTls12 = TLS 1.2 も申し出る（どれも既定は安全な側 — 綴りで緩めたことが grep で拾え、check が毎回警告する）

## Server

```sober
type Server error {
    code string
    message string
    detail string
    constraint string
    hint string
}
```

サーバの ErrorResponse（code = SQLSTATE — 一意制約違反 23505・password 違い 28P01・直列化の失敗 40001 ほか）。message / detail / hint = 人に見せる文面（hint = サーバの直し方の提案 — 無ければ ""）・constraint = 違反した制約の名前

## Auth

```sober
type Auth error
```

認証が成り立たない（SCRAM の方式が無い・サーバの署名が合わない・SCRAM 以外の方式を求められた）

## Tls

```sober
type Tls error
```

TLS が張れない（サーバが SSLRequest を断った・証明書の検証・握手の失敗）

## Closed

```sober
type Closed error
```

接続が使えない（相手が閉じた・期限切れや壊れた応答の後）

## Protocol

```sober
type Protocol error
```

サーバの応答が wire protocol の形でない

## BadUrl

```sober
type BadUrl error
```

URL が読めない（形・port・password や クエリを含む — password は Policy に）

## Dns

```sober
type Dns error
```

名前が引けない

## BadArg

```sober
type BadArg error {
    index int
    oid int
}
```

引数 index（0 起点）の値の variant がサーバの型 oid に合わない（Int の範囲外も）

## WrongType

```sober
type WrongType error {
    index int
    oid int
}
```

列 index の値の型 oid が読みの関数に合わない

## NullColumn

```sober
type NullColumn error {
    index int
}
```

列 index が NULL（型つきの読み — IsNull で先に分けるか Col の switch で Null{} を受ける）

## Inexact

```sober
type Inexact error
```

Scaled の値が scale 桁に収まらない端数を持つ

## OutOfRange

```sober
type OutOfRange error
```

Scaled の結果が int に収まらない

## Reentered

```sober
type Reentered panic {
    hint string
}
```

Query の本体の中から同じ Conn を使った（行を流している途中の接続は使えない — 行を読み切ってから使うか、別の接続で）

## Conn

```sober
type Conn struct {
    fd int
    blk []int
    cp internal.hsc.CParams
    p cfg
    seal connSeal
}
```

接続 1 本（同一性の型 — Open の k の仮引数としてだけ生まれる。状態は値の外の置き場 blk〔transport.sober〕）

## Row

```sober
type Row struct {
    vals []Value
    oids []int
}
```

結果の 1 行（k の中で読む — 列は番号で）

## Open

```sober
@errors(BadUrl, Dns, Tls, Auth, Server, Protocol, Closed, io.Expired)
@effects(block, io, panic, nondet)
func Open(at string, k func(c Conn), policy Policy?) error?
```

at（URL "postgres://user@host[:port]/db" — "postgresql://" も・port の既定 5432・db の既定 = user）の PostgreSQL へ繋ぎ、認証まで済ませて Conn を k に渡す（k が返ったら Terminate して閉じる）。既定は TLS（SSLRequest → 検証つき TLS 1.3）+ SCRAM-SHA-256-PLUS。k の中の誤りは k の中で受ける

失敗のラベル: [`BadUrl`](#badurl)・[`Dns`](#dns)・[`Tls`](#tls)・[`Auth`](#auth)・[`Server`](#server)・[`Protocol`](#protocol)・[`Closed`](#closed)・`io.Expired`

## Query

```sober
@errors(Server, Protocol, Closed, BadArg, io.Expired)
@effects(block, io, panic, nondet)
func Query(c Conn, sql string, k func(r Row), args ([]Value)?) error?
```

行を 1 行ずつ k に渡す呼び出し形の生成元: `for r <- pg.Query(c, sql, args: …)? { … }`。本体の `?` / return / break で抜けると、残りの行を読み捨てて接続を使える状態に戻す（生成元の defer）。sql は const の席。本体の中から同じ Conn を使うと panic(Reentered) — 行を読み切ってから使うか、別の接続で

失敗のラベル: [`Server`](#server)・[`Protocol`](#protocol)・[`Closed`](#closed)・[`BadArg`](#badarg)・`io.Expired`

## Exec

```sober
@errors(Server, Protocol, Closed, BadArg, io.Expired)
@effects(block, io, panic, nondet)
func Exec(c Conn, sql string, args ([]Value)?) (int, error?)
```

文を 1 つ実行して影響行数（CommandComplete の数 — 行を返す文は返した行の数）を返す。sql は const の席

失敗のラベル: [`Server`](#server)・[`Protocol`](#protocol)・[`Closed`](#closed)・[`BadArg`](#badarg)・`io.Expired`

## Script

```sober
@errors(Server, Protocol, Closed, io.Expired)
@effects(block, io, panic, nondet)
func Script(c Conn, sql string) error?
```

複数の文（; 区切り — migration 用・引数なし）を simple query で 1 回に送る。最初の誤りで止まる（サーバの振る舞い）。sql は const の席

失敗のラベル: [`Server`](#server)・[`Protocol`](#protocol)・[`Closed`](#closed)・`io.Expired`

## Pool

```sober
type Pool struct {
    d task.Domain[poolSt]
    lot internal.lot.Lot
    c cfg
    cp internal.hsc.CParams
}
```

プール（domain と預かり所の組 — 捕獲でき、関数の実引数にできる。OpenPool の k の中でだけ生きる）

## OpenPool

```sober
@errors(BadUrl)
@effects(block, io, panic, nondet)
func OpenPool(at string, k func(p Pool), size int?, wait int?, policy Policy?) error?
```

at（Open と同じ URL・Policy）の接続を最大 size 本（既定 10・1 未満は 1）まで張って共有するプールを k に渡す。k が返ったら待機の接続に Terminate を送って全部閉じる。wait = With が空きを待つ上限（ns・既定 30 秒 — 越えたら io.Expired）。接続は With の初めての借りで張る（OpenPool は繋がない）

失敗のラベル: [`BadUrl`](#badurl)

## With

```sober
@errors(Dns, Tls, Auth, Server, Protocol, Closed, io.Expired)
@effects(block, io, panic, nondet)
func With(p Pool, k func(c Conn)) error?
```

p から接続を 1 本借りて k に渡す（待機が無く張れる本数も尽きていれば、返されるまで来た順に待つ）。k の中の誤りは k の中で受ける。k が普通に返り、接続が使える状態（トランザクションの外・読み残しなし）なら預け直す — それ以外は閉じる

失敗のラベル: [`Dns`](#dns)・[`Tls`](#tls)・[`Auth`](#auth)・[`Server`](#server)・[`Protocol`](#protocol)・[`Closed`](#closed)・`io.Expired`

## Col

```sober
@effects()
func Col(r Row, i int) Value
```

列 i の値

## Width

```sober
@effects()
func Width(r Row) int
```

列の数

## IsNull

```sober
@effects()
func IsNull(r Row, i int) bool
```

列 i が NULL か

## ColBool

```sober
@errors(NullColumn, WrongType)
@effects()
func ColBool(r Row, i int) (bool, error?)
```

列 i の値 — bool の列

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## ColInt

```sober
@errors(NullColumn, WrongType)
@effects()
func ColInt(r Row, i int) (int, error?)
```

列 i の値 — int2 / int4 / int8 の列

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## ColFloat

```sober
@errors(NullColumn, WrongType)
@effects()
func ColFloat(r Row, i int) (float, error?)
```

列 i の値 — float4 / float8 の列

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## ColString

```sober
@errors(NullColumn, WrongType)
@effects()
func ColString(r Row, i int) (string, error?)
```

列 i の値 — text / varchar / char / name の列

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## ColBytes

```sober
@errors(NullColumn, WrongType)
@effects()
func ColBytes(r Row, i int) ([]byte, error?)
```

列 i の値 — bytea の列

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## ColUuid

```sober
@errors(NullColumn, WrongType)
@effects()
func ColUuid(r Row, i int) (uuid.UUID, error?)
```

列 i の値 — uuid の列

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## ColTime

```sober
@errors(NullColumn, WrongType)
@effects()
func ColTime(r Row, i int) (time.Time, error?)
```

列 i の値 — timestamptz の列（UTC の時刻）

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## ColCivil

```sober
@errors(NullColumn, WrongType)
@effects()
func ColCivil(r Row, i int) (time.Civil, error?)
```

列 i の値 — timestamp / date の列（zone の無い壁の読み — date は時刻 0）

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## ColJson

```sober
@errors(NullColumn, WrongType)
@effects()
func ColJson(r Row, i int) ([]byte, error?)
```

列 i の値 — json / jsonb の列（JSON の字句）

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## ColNumeric

```sober
@errors(NullColumn, WrongType)
@effects()
func ColNumeric(r Row, i int) (string, error?)
```

numeric の十進の字句

失敗のラベル: [`NullColumn`](#nullcolumn)・[`WrongType`](#wrongtype)

## Scaled

```sober
@errors(Inexact, OutOfRange, WrongType)
@effects()
func Scaled(v Value, scale int) (int, error?)
```

Numeric / Int の値の 10^scale 倍の int（金額の固定小数点 — scale 桁より下に 0 でない端数があれば Inexact・int に入らなければ OutOfRange・NaN / Infinity と他の variant は WrongType{index: -1}）

失敗のラベル: [`Inexact`](#inexact)・[`OutOfRange`](#outofrange)・[`WrongType`](#wrongtype)

## Isolation

```sober
type Isolation int
```

分離の水準（省くとサーバの既定 — 通常 READ COMMITTED）

## ReadCommitted

```sober
const ReadCommitted = 1
```

READ COMMITTED（文ごとに、その文の始まりまでに COMMIT された行を見る）

## RepeatableRead

```sober
const RepeatableRead = 2
```

REPEATABLE READ（トランザクションの最初の文の時点の行を見続ける）

## Serializable

```sober
const Serializable = 3
```

SERIALIZABLE（直列に走らせたのと同じ結果にならない組を 40001 で断る — 呼び手が再試行する）

## Aborted

```sober
type Aborted error
```

k の中で文の誤りを握りつぶしたまま k が普通に終わった（サーバのトランザクションは失敗の状態だったので巻き戻した — 何も COMMIT されていない）

## Tx

```sober
@errors(Server, Protocol, Closed, Aborted, io.Expired)
@effects(block, io, panic, nondet)
func Tx(c Conn, k func(c Conn), isolation Isolation?, readOnly bool?) error?
```

c の上で k をトランザクションとして走らせる。k の仮引数は c と同じ接続

```sober
pg.Tx(c, (tc) => {
    _ = pg.Exec(tc, "update account set v = v - $1 where id = $2", args: …)?   // ? で抜けると ROLLBACK してから呼び手の関数を抜ける
    _ = pg.Exec(tc, "update account set v = v + $1 where id = $2", args: …)?
}, isolation: pg.Serializable)?
```

失敗のラベル: [`Server`](#server)・[`Protocol`](#protocol)・[`Closed`](#closed)・[`Aborted`](#aborted)・`io.Expired`

## Value

```sober
type Value union {
    Null {}
    Bool { v bool }
    Int { v int }
    Float { v float }
    String { v string }
    Bytes { v []byte }
    Uuid { v uuid.UUID }
    Time { v time.Time }
    Civil { v time.Civil }
    Json { v []byte }
    Numeric { digits string }
    Unknown { oid int; text string }
}
```

値 1 つ（NULL は Null{}・第一陣の外の型は Unknown — text 形式の字句のまま）

variant:

- `Time` — timestamptz（UTC の時刻 — ±infinity は Unknown）
- `Civil` — timestamp（zone の無い壁の読み）・date（時刻 0）— weekday は暦から
- `Numeric` — numeric の十進の字句（"-12.50"・"NaN"・"Infinity"）
