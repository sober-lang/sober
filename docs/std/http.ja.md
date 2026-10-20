# std/http

日本語

`import "std/http"`

HTTP/1.1 のサーバの最小形: 接続 1 本の要求を順に route へ渡し、応答を書く。接続 1 本 = task 1 本は net.Serve の仕事で、ここは包まない（利用者が `func app(c net.Conn) error? { return http.ServeConn(c, route) }` を net.Serve に渡す）。要求 1 件 = route の呼び出し 1 回 = 反復 1 回の region（DOM の「1 フレーム 1 region」と同じ線）。切片 1 つに入った要求（パイプライン）の応答はまとめて send 1 回。ヘッダは頭のバイト列の上の位置の線形の表（map にしない）。ルーターはルートの表（`[]Route` — データ）と純関数の合成（Mount / Merge）+ Dispatch（route のコールバックに包んで渡す — ServeConn は無変更）。ミドルウェアは before / after の組。範囲: HTTP/1.1 と 1.0 の要求・keep-alive（1.1 の既定 / 1.0 は Connection: keep-alive）・Connection: close・パイプライン・本文はContent-Length と chunked（trailer は読み捨て）・形の誤り = 400 / 頭の上限 = 431 / 本文の上限 = 413 / chunked 以外の Transfer-Encoding = 501 / HTTP/1.x 以外 = 505（誤りの応答の後は閉じる）・応答の gzip（ServeConn の compress:）・応答の stream（Response の stream — 長さ既知）。入れないもの: HTTP/2・TLS・br・応答の chunked（応答は常に Content-Length）・Expect: 100-continue（無視して本文を待つ）・URL のデコード・Date / Server ヘッダ。要求の頭は UTF-8 で検査する（0x80 以上の obs-text は 400）切片をまたぐ要求: 残りを接続ごとの持ち越しの列（大きさは頭の上限 + 本文の上限の 2 倍 + 128 で固定・初めてまたいだときに 1 回だけ確保）へ写し、次の切片と繋いだ写しを反復の region に作って読み直す — 持ち越しは接続の寿命の region でも伸びない（張り直さない）

## Request

```sober
type Request struct {
    method string
    path string
    query string
    head utf8.View
    headers []int
    body []byte
    pattern string
}
```

要求 1 件（この反復の region — route が返ったら消える。外へ持ち出すなら写す）

欄:

- `path` — 要求の対象の '?' の前（生のまま — % のデコードはしない）
- `query` — 要求の対象の '?' の後（生のまま — % のデコードはしない）
- `head` — 要求の頭（要求行からヘッダの終わりの空行まで — 検査済み）
- `headers` — head の上のヘッダの位置 [名前の始め, 終わり, 値の始め, 終わり] × 本数
- `body` — 本文（Content-Length の分・chunked は繋いだ写し）
- `pattern` — Dispatch が一致させたルートの path（"/users/:id" — ルーターを通らない要求は ""。Param はこれと path を並べて歩く）

## Response

```sober
type Response struct {
    status int
    contentType string
    body []byte
    length int
    stream Stream?
    headers Headers?
}
```

応答（status・Content-Type〔"" なら書かない〕・本文）。stream があれば本文の代わりに ServeConn が頭の後で stream を呼び、stream がemit に渡したバイト列をそのまま送る（コールバック形式〔継続渡し / CPS〕— [language.md 28 節](../language.md) w2）。長さは length（Content-Length — stream が emit で送る合計はlength ちょうどであること〔呼び手の契約 — 応答の chunked は持たない。ServeConn は合計を検査しない: 足りなければ相手は本文の残りを待ち、多ければ超えた分を次の応答として読む〕）。stream の応答は圧縮しない（compress: の対象外）・HEAD では呼ばない。stream は要求の値（path など）を捕捉してよい閉包。File は捕捉させず path を捕捉して stream の中で開く:

```sober
func handle(r http.Request) http.Response {
    return http.Response{status: 200, contentType: "text/plain", length: n, stream: (emit) => sendFile(r.path, emit)}
}
func sendFile(path string, emit func(b []byte) error?) error? {
    f := io.Open(path)?
    defer io.Close(f)
    for b <- io.Chunks(f)? { emit(io.Raw(b))? }
    return nil
}
```

欄:

- `headers` — 任意ヘッダ（書いた順に Content-Type の後へ）。std/http が書く名前（Content-Type・Content-Length・Content-Encoding・Transfer-Encoding・Connection・Vary）と CR / LF / NUL を含む名前・値は panic(BadHeader) — 応答の分割の封:     http.Response{status: 200, contentType: "text/plain", body: b, headers: http.Headers{list: []http.Field{http.Field{name: "Cache-Control", value: "no-store"}}}}

## Headers

```sober
type Headers struct {
    list []Field
}
```

任意ヘッダの列（Response の欄を option の包みにしてあるのは、欄を持たない応答〔大半〕の道に空の列の確保と region の付け替えを積まないため）

## Field

```sober
type Field struct {
    name string
    value string
}
```

任意ヘッダの 1 本

## BadHeader

```sober
type BadHeader panic {
    name string
}
```

Response の headers の 1 本が書けない（名前が空か tchar でない・値に CR / LF / NUL・std/http が書く名前 — 呼び手の契約違反。panic ラベル）

## Stream

```sober
type Stream func(emit func(b []byte) error?) error?
```

応答の本文の供給（emit は借り — 呼ぶ・借りの位置へ渡すだけ。[language.md 25 節](../language.md)「借り」）

## Text

```sober
func Text(s string) Response
```

200・text/plain の応答

## Json

```sober
func Json(s string) Response
```

200・application/json の応答（s は組み上がった JSON — std/json の Put… / Done）

## Status

```sober
func Status(code int) Response
```

本文なしの応答（404 / 405 …）

## Gzip

```sober
type Gzip struct {
    level int
}
```

ServeConn の compress: の値（応答の gzip — RFC 1952。level は std/compress/flate と同じ 1〜9・0 は既定の 6 と読む — ゼロ値 `http.Gzip{}` が既定）:

```sober
http.ServeConn(c, route, compress: http.Gzip{level: 6})
```

ServeConn が要求の Accept-Encoding を見て、応答の Content-Type が圧縮向き（text/\* か application/json）で本文が 1024 バイト以上なら、本文をgzip にして Content-Encoding: gzip を付ける。圧縮しうる応答には受けない要求にも Vary: Accept-Encoding を付ける（同じ URL の応答が要求の頭で変わる — 中継のキャッシュの正しさ）。route は圧縮を知らない（middleware と同じ位置 — 要求ごとに直列化 + 圧縮・圧縮済みの写しを溜めない）。1〜9 の外の level は panic(BadLevel)

## BadLevel

```sober
type BadLevel panic {
    level int
}
```

Gzip の level が 0〜9 の外（呼び手の契約違反 — panic ラベル。[language.md 27 節](../language.md)）

## WorkNoCompress

```sober
type WorkNoCompress panic
```

ServeConn の work: を compress: なしで渡した（作業域は圧縮の符号器のもの — 呼び手の契約違反。panic ラベル）

## Header

```sober
func Header(r Request, name string) string?
```

r のヘッダ name の値（名前は大文字小文字を区別しない — 最初の一致。無ければ nil）

## Query

```sober
func Query(r Request, key string) string?
```

r の query の key の値（`k=v&…` の最初の一致・= の無い項目は値 ""・デコードしない。無ければ nil）

## Form

```sober
func Form(r Request, key string) string?
```

本文（Content-Type が application/x-www-form-urlencoded のとき）の key の値（Query と同じ切り方 — `k=v&…` の最初の一致・デコードしない。form でない・本文が UTF-8 でない・無ければ nil）

## JsonDoc

```sober
@errors(json.InvalidJson)
func JsonDoc(r Request) (json.Doc, error?)
```

本文を JSON として読んだ表（std/json の Doc — 型へは `json.Decode[T](d, json.Root(d))`。総称の包み〔T を受ける関数〕はjson.Decode の型引数が具体の struct を要るので書けない）

失敗のラベル: `json.InvalidJson`

## Handler

```sober
type Handler func(r Request) Response
```

要求 1 件の処理（ルートの表の行が持つ）

## Before

```sober
type Before func(r Request) Response?
```

ハンドラの前に走るコールバック（nil = 続ける・応答を返すと short-circuit — 内側の middleware とハンドラは走らない）

## After

```sober
type After func(r Request, w Response) Response
```

ハンドラの後に走るコールバック（内側が返した応答 w を受けて応答を返す）

## Middleware

```sober
type Middleware struct {
    before Before?
    after After?
}
```

ルートの前後に挟む処理（before と after の組 — どちらも省ける）。鎖の順は外から内: before は外→内、ハンドラ、after は内→外。before が応答を返したら、それより外の middleware の after だけを内→外で掛ける（玉ねぎの意味 — short-circuit した mw 自身と内側の after は走らない）。next を受けて内側を呼ぶ形（Express / Koa）は今の言語で書けない（型が自分を関数型の中で名指す再帰型 — [language.md 28 節](../language.md)）

## Route

```sober
type Route struct {
    method string
    path string
    handler Handler
    middleware []Middleware
}
```

ルートの表の 1 行（method + path のパターン → ハンドラ・ルート単位の middleware）。パターンは "/" で区切ったセグメントの列:静的（`users`）・`:name`（1 セグメント — 空は不一致）・`*name`（末尾だけ — 残り全部〔0 個以上のセグメント・"/" を含む〕。値は先頭の "/" を除いた残り）。表はただのデータ — モジュールは `[]http.Route` を返す関数を export し、Mount / Merge で合成する（表を歩けば全ルートが見える）:

```sober
func routes() []http.Route {
    return http.Merge(
        http.Mount("/users", users.Routes(), []http.Middleware{auth}),
        []http.Route{http.Route{method: "GET", path: "/health", handler: health}})
}
http.ServeConn(c, (r) => http.Dispatch(rs, r))
```

## Mount

```sober
func Mount(prefix string, routes []Route, mw []Middleware) []Route
```

routes の各行の path の前に prefix を付け、mw を各行の middleware の列の頭に足した表（純関数 — 足した mw は元の行の mw より外側で走る）。アプリ単位の middleware は `Mount("", routes, appMw)`

## Merge

```sober
func Merge(a []Route, b []Route) []Route
```

a と b を繋いだ表

## Dispatch

```sober
func Dispatch(routes []Route, r Request) Response
```

routes から r に一致する行を選んで middleware とハンドラを走らせる。一致は path のパターンと method（大文字小文字を区別する）。優先順は表の並びに依らない: 一致した行どうしは、先頭から見て最初に種類が違うセグメントで 静的 > :name > \*name の方が勝つ（同じ具体さなら表の先の行）。HEAD の要求は HEAD の行が無ければ GET の行へ（本文は ServeConn が落とす）。path が一致する行があって method が合わなければ 405・無ければ 404。パスはデコードしない・末尾の "/" は区別する（リダイレクトしない）

## Param

```sober
func Param(r Request, key string) string?
```

r のパターンの :key / \*key の値（Dispatch が一致させたパターンと path を並べて歩く — パターンに key が無い・ルーターを通らない要求は nil）

## ServeConn

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
func ServeConn(c net.Conn, route func(Request) Response, maxHead int?, maxBody int?, compress Gzip?, work task.Local?) error?
```

c の要求を順に route に渡して応答を書く（keep-alive）。相手が閉じる（FIN）・Connection: close・HTTP/1.0 の既定・誤りの応答の後で返る（閉じるのは呼び手 — net.Serve の接続の task の出口）。maxHead = 要求の頭の上限（既定 8 KiB — 超えたら 431）・maxBody = 本文の上限（既定 16 KiB — 超えたら 413）。本文と持ち越しは接続の task の region に載るので、上限は net.Serve の budget（既定 64 KiB）に収まる大きさで（目安: budget ≥ 3 × (maxHead + maxBody) + 16 KiB〔受けの切片〕）。compress: は応答の gzip（上の Gzip — 省略 = 圧縮しない）。work: は compress: の符号器の作業域のストレージ（ワーカー局所の lease — region-domain-pool.md 4d 節）: 省略すると要求ごとに作業域を取る（接続の task のregion に頁として残る — 接続の数に比例）。渡すと同じワーカーのストレージを借りる（作業域は ≈ 650 KB × ワーカーの数で接続の数に依らない・結果は同じバイト列）:

```sober
gzw := task.NewLocal((w mut flate.Work) => flate.Prepare(mut w))   // Serve の前に 1 回
net.Serve(l, (c net.Conn) => http.ServeConn(c, route, compress: http.Gzip{}, work: gzw))
```

work: は compress: と組みで（compress: なしの work: は panic(WorkNoCompress{}) — 呼び手の契約違反）。1 つのストレージを全部の接続で共有してよい（中はワーカーごとに分かれている）

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## ServeWith

```sober
@errors(recv, send)
func ServeWith(recv func(k func([]byte)) error?, send func(b []byte) error?, route func(Request) Response, maxHead int?, maxBody int?, compress Gzip?, work task.Local?) error?
```

ServeConn の核を転送路の受信コールバック recv（`for chunk <- recv()? { … }` の生成元 — net.Recv / tls.Recv の形）と送信コールバック send に一般化したもの（ServeConn は net の 1 行の包み・TLS の接続は `http.ServeWith((k) => tls.Recv(c, k), (b) => tls.Send(c, b), route)`）。失敗は recv / send が返すもの（仮引数の名前の @errors — [language.md 13 節](../language.md): 呼び手は渡したコールバックのラベルで switch を網羅する）。誤りの応答の後の読み捨て（linger）も recv の続きを読む — tls.Recv は 2 度目を Closed で返すので読み捨てずに閉じる（TLS の close\_notify は呼び手の Serve が送る）

失敗のラベル: `recv`・`send`
