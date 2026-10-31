# std/http

日本語

`import "std/http"`

HTTP/1.1 のサーバの最小形: 接続 1 本の要求を順に route へ渡し、応答を書く。接続 1 本 = task 1 本は net.Serve の仕事で、ここは包まない（利用者が `func app(c net.Conn) error? { return http.ServeConn(c, route) }` を net.Serve に渡す）。要求 1 件 = route の呼び出し 1 回 = 反復 1 回の region（DOM の「1 フレーム 1 region」と同じ線）。切片 1 つに入った要求（パイプライン）の応答はまとめて send 1 回。ヘッダは頭のバイト列の上の位置の線形の表（map にしない）。ルーターはルートの表（`[]Route` — データ）と純関数の合成（Mount / Merge）+ Dispatch（route のコールバックに包んで渡す — ServeConn は無変更）。ミドルウェアは before / after の組。範囲: HTTP/1.1 と 1.0 の要求・keep-alive（1.1 の既定 / 1.0 は Connection: keep-alive）・Connection: close・パイプライン・本文はContent-Length と chunked（trailer は読み捨て）・形の誤り = 400 / 頭の上限 = 431 / 本文の上限 = 413 / chunked 以外の Transfer-Encoding = 501 / HTTP/1.x 以外 = 505（誤りの応答の後は閉じる）・応答の gzip（ServeConn の compress:）・応答の stream（Response の stream — 長さ既知は Content-Length・長さ不定は chunked〔HTTP/1.0 は閉じで区切る〕）・SSE のイベントの組み立て（FormatEvent）。入れないもの: HTTP/2・TLS・br・応答の trailer・Expect: 100-continue（無視して本文を待つ）・URL のデコード・Date / Server ヘッダ。要求の頭は UTF-8 で検査する（0x80 以上の obs-text は 400）切片をまたぐ要求: 残りを接続ごとの持ち越しの列（大きさは頭の上限 + 本文の上限の 2 倍 + 128 で固定・初めてまたいだときに 1 回だけ確保）へ写し、次の切片と繋いだ写しを反復の region に作って読み直す — 持ち越しは接続の寿命の region でも伸びない（張り直さない）

## Request

```sober
type Request struct {
    method string
    path string
    query string
    head utf8.View @credential
    headers []int
    body []byte
    pattern string
}
```

要求 1 件（この反復の region — route が返ったら消える。外へ持ち出すなら写す）

欄:

- `path` — 要求の対象の '?' の前（生のまま — % のデコードはしない）
- `query` — 要求の対象の '?' の後（生のまま — % のデコードはしない）
- `head` — 要求の頭（要求行からヘッダの終わりの空行まで — 検査済み）。認証のヘッダを含むので認証の源（std の外の package で読むと、その値と読んだ関数は認証に届く — [language.md 12 節](../language.md)「出所の依存」。std の中の読み〔Header・Dispatch の写し〕は源にしない）
- `headers` — head の上のヘッダの位置 [名前の始め, 終わり, 値の始め, 終わり] × 本数
- `body` — 本文（Content-Length の分・chunked は繋いだ写し）
- `pattern` — Dispatch が一致させたルートの path（"/users/:id" — ルーターを通らない要求は ""。Param はこれと path を並べて歩く）

## Response

```sober
type Response struct {
    status StatusCode
    contentType string
    body []byte
    length int?
    stream Stream?
    headers Headers?
    coded Coded?
    cache Cache?
    validators Validators?
}
```

応答（status・Content-Type〔"" なら書かない〕・本文）。stream があれば本文の代わりに ServeConn が頭の後で stream を呼び、stream がemit に渡したバイト列をそのまま送る（コールバック形式〔継続渡し / CPS〕— [language.md 28 節](../language.md) w2 の「応答の枠」）。emit 1 回 = 送り 1 回（emit をまたいで溜めない）。length があれば Content-Length（stream が emit で送る合計は length ちょうどであること — ServeConn は合計を数え、超えた emit は送らず・stream が返った時点で合計が length でなければ閉じる〔相手は本文の切れで知る〕）。length が nil（長さ不定）なら Transfer-Encoding: chunked（emit 1 回 = chunk 1 つ・空の emit は送らない・stream が nil で返ったら終端の chunk）— HTTP/1.0 の要求には Content-Length も chunked も書かず、stream が返ったら閉じる（閉じで区切る）。stream が誤りを返したら終端を書かずに閉じる。compress: があり・Content-Type が圧縮向き・要求が gzip を受け・coded が無い stream の応答（長さ既知なら length が 1024 以上のとき）は gzip にして chunked で送る（emit 1 回 = deflate の sync flush 1 回 = chunk 1 つ・窓は emit をまたいで持ち越す・HTTP/1.0 は閉じで区切る・Vary は body の応答と同じ）。HEAD では呼ばない（頭は GET と同じ）。stream は要求の値（path など）を捕捉してよいクロージャ。File は捕捉させず path を捕捉して stream の中で開く:

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

- `length` — stream の本文の長さ（Content-Length — nil = 長さ不定 = chunked）。body の応答では読まない
- `headers` — 任意ヘッダ（書いた順に Cache-Control の後へ）。std/http が書く名前（Content-Type・Content-Length・Content-Encoding・Transfer-Encoding・Connection・Vary）・保存の方針と検証子の名前（Cache-Control・CDN-Cache-Control・Surrogate-Control・ETag・Last-Modified — 書くのは型の欄 cache / validators だけ）と CR / LF / NUL を含む名前・値は panic(BadHeader) — 応答の分割の封:     http.Response{status: 200, contentType: "text/plain", body: b, headers: http.Headers{list: []http.Field{http.Field{name: "X-Request-Id", value: id}}}}
- `coded` — 本文の符号化を選んだ応答（Static の precompressed — 下の Coded）。あれば ServeConn は Vary: Accept-Encoding を書き、encoding が空でなければContent-Encoding を書き、compress: を掛けない
- `cache` — 保存の方針（Cache-Control）。応答 1 件で書くのは Private / NoStore — 共有キャッシュも保存してよい方針（Fresh）はルートの行（Route.cache・Static の cache:）で書き、Dispatch がこの欄の無い応答に写す〔std の外で応答 1 件に Fresh / Shared を書くと analyzer が拒否する〕）。どこにも無ければ `Cache-Control: private`（利用者のブラウザだけが保存してよい — 認証つきの要求の応答を CDN の規則が拾う形〔web cache deception〕の入口を狭める既定）    http.Response{status: 200, contentType: "text/plain", body: b, cache: http.NoStore{}}
- `validators` — 検証子（ETag・Last-Modified — 作れるのは std/http だけ: 封の型。同じ検証子を別の利用者の中身に付けると、確かめに来たキャッシュへの 304 で他人の版が出る — 検証子は中身から std が作る）

## Validators

```sober
type Validators struct {
    etag string
    modified int
    seal validSeal
}
```

応答の検証子（ETag と Last-Modified — Static が作る。modified は秒・0 以下は Last-Modified を書かない）

## Coded

```sober
type Coded struct {
    encoding string
}
```

応答の本文が要求の Accept-Encoding で選ばれたこと（encoding = 選んだ符号化〔"br" / "gzip"〕・"" = 候補を見たが元のまま）。本文は既にその符号化のバイト列（ServeConn は圧縮しない — 選ぶだけ）。同じ URL の応答が要求の頭で変わるので、元のままの応答にも Vary を付ける

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
type Stream func(emit func(b []byte) error?) error? @errors(emit, io.NotFound, io.Denied, io.Timeout, io.Expired, io.Other)
```

応答の本文の供給（emit は借り — 呼ぶ・借りの位置へ渡すだけ。[language.md 25 節](../language.md)「借り」）

## Text

```sober
@effects()
func Text(s string) Response
```

200・text/plain の応答

## Json

```sober
@effects()
func Json(s string) Response
```

200・application/json の応答（s は組み上がった JSON — std/json の Put… / Done）

## Event

```sober
type Event struct {
    event string?
    data string
    id string?
    retry int?
}
```

Server-Sent Events のイベント 1 つ（WHATWG HTML 9.2 の text/event-stream — FormatEvent で組んで stream の emit に渡す）。event = イベントの種類（nil = 書かない・受け手は message）・data = 本文（改行で行に割る）・id = 最後のイベントの番号（受け手が繋ぎ直すときに Last-Event-ID で返す — `http.Header(r, "Last-Event-ID")`）・retry = 繋ぎ直しの待ち（ミリ秒）

## BadEvent

```sober
type BadEvent panic {
    field string
}
```

Event の event / id に CR・LF・NUL がある（呼び手の契約違反 — イベントの差し込みの封: 行の区切りを値に書けると、受け手に別のイベントや欄を足せる。panic ラベル）

## FormatEvent

```sober
@effects(panic)
func FormatEvent(e Event) string
```

e の text/event-stream の 1 イベント（`event:`・`id:`・`retry:`・`data:` の行と、終わりの空行）。data は改行（LF・CRLF・CR）で割って行ごとの `data:` にする（受け手は行を LF で繋ぎ直す — 改行の種類は LF に揃う）。event / id に CR・LF・NUL があれば panic(BadEvent)。配送は応答の stream で、emit 1 回 = 送り 1 回（[language.md 28 節](../language.md)の「SSE」— 長さ不定の stream は chunked）。心拍のコメントは `emit(bytes(": ping\n\n"))` で書ける:

```sober
http.Response{status: 200, contentType: "text/event-stream", cache: http.NoStore{}, stream: (emit) => {
    emit(bytes(http.FormatEvent(http.Event{event: "tick", data: "1", id: "1"})))?
    nil
}}
```

## StatusCode

```sober
type StatusCode int
```

応答の状態の番号（RFC 9110 15 節）。std/http が理由句を知る番号は下の型つきの const（http.OK …）— 状態行の表はこの const の全部を名指す（@exhaustive — [language.md 13 節](../language.md)の補「表の網羅」）。const に無い番号も `http.StatusCode(418)` や整数のリテラル（`status: 418`）で書ける（理由句は空）

## OK

```sober
const OK = 200
```

200 OK

## Created

```sober
const Created = 201
```

201 Created

## NoContent

```sober
const NoContent = 204
```

204 No Content（本文なし・Content-Length を書かない）

## MovedPermanently

```sober
const MovedPermanently = 301
```

301 Moved Permanently

## Found

```sober
const Found = 302
```

302 Found

## NotModified

```sober
const NotModified = 304
```

304 Not Modified（条件付き GET の一致 — 本文なし）

## BadRequest

```sober
const BadRequest = 400
```

400 Bad Request（要求の頭が読めない）

## Unauthorized

```sober
const Unauthorized = 401
```

401 Unauthorized

## Forbidden

```sober
const Forbidden = 403
```

403 Forbidden

## NotFound

```sober
const NotFound = 404
```

404 Not Found（Dispatch の一致なし・Static のファイルなし）

## MethodNotAllowed

```sober
const MethodNotAllowed = 405
```

405 Method Not Allowed（Dispatch — Allow を付ける）

## PreconditionFailed

```sober
const PreconditionFailed = 412
```

412 Precondition Failed（If-Match / If-Unmodified-Since の不一致）

## ContentTooLarge

```sober
const ContentTooLarge = 413
```

413 Content Too Large（本文が上限を超える）

## RequestHeaderFieldsTooLarge

```sober
const RequestHeaderFieldsTooLarge = 431
```

431 Request Header Fields Too Large（要求の頭が上限を超える）

## InternalServerError

```sober
const InternalServerError = 500
```

500 Internal Server Error（handler の失敗）

## NotImplemented

```sober
const NotImplemented = 501
```

501 Not Implemented（知らない Transfer-Encoding）

## ServiceUnavailable

```sober
const ServiceUnavailable = 503
```

503 Service Unavailable

## HTTPVersionNotSupported

```sober
const HTTPVersionNotSupported = 505
```

505 HTTP Version Not Supported

## Status

```sober
@effects()
func Status(code StatusCode) Response
```

本文なしの応答（http.NotFound / http.MethodNotAllowed …）

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
@effects()
func Header(r Request, name string) string?
```

r のヘッダ name の値（名前は大文字小文字を区別しない — 最初の一致。無ければ nil）。認証のヘッダ（Authorization・Proxy-Authorization・Cookie）は読めない（nil）— 読む口は Authorization と Cookie だけ（認証の源の名指し: 認証に届く応答を共有キャッシュへ宣言する形を analyzer が拒否する — [language.md 13 節](../language.md)の補 3）

## Authorization

```sober
@credential
@effects()
func Authorization(r Request) string?
```

r の Authorization ヘッダの値（認証の源 — 最初の行。無ければ nil。scheme の解釈〔Bearer / Basic〕はしない）

## Cookie

```sober
@credential
@effects()
func Cookie(r Request, name string) string?
```

r の Cookie ヘッダの name の値（認証の源 — RFC 6265 5.4 の `name=value; name2=value2` を `;` で切り、前後の空白を除いて名前がちょうど等しい〔大文字小文字を区別する〕最初の組の値。値が `"` で囲まれていれば外す。Cookie の行が 2 本以上あれば順に見る・`=` の無い組は飛ばす・デコードしない。無ければ nil）

## Query

```sober
@effects()
func Query(r Request, key string) string?
```

r の query の key の値（`k=v&…` の最初の一致・= の無い項目は値 ""・デコードしない。無ければ nil — デコードした値・同じキーの全部の組は url.ParseQuery(r.query)）

## Form

```sober
@effects()
func Form(r Request, key string) string?
```

本文（Content-Type が application/x-www-form-urlencoded のとき）の key の値（Query と同じ切り方 — `k=v&…` の最初の一致・デコードしない。form でない・本文が UTF-8 でない・無ければ nil — デコードした値・全部の組は url.ParseQuery）

## JsonDoc

```sober
@errors(json.InvalidJson)
@effects()
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
    cache Cache?
}
```

ルートの表の 1 行（method + path のパターン → ハンドラ・ルート単位の middleware）。パターンは "/" で区切ったセグメントの列:静的（`users`）・`:name`（1 セグメント — 空は不一致）・`*name`（末尾だけ — 残り全部〔0 個以上のセグメント・"/" を含む〕。値は先頭の "/" を除いた残り）。表はただのデータ — モジュールは `[]http.Route` を返す関数を export し、Mount / Merge で合成する（表を歩けば全ルートが見える）:

```sober
func routes() []http.Route {
    return http.Merge(
        http.Mount("/users", users.Routes(), []http.Middleware{auth}),
        []http.Route{http.Route{method: "GET", path: "/health", handler: health}})
}
rs := routes()
http.ServeConn(c, (r) => http.Dispatch(rs, r))
```

欄:

- `cache` — この行の応答の保存の方針（応答が cache を持たない 2xx と 304 に Dispatch が写す — 応答の cache が勝つ・他の状態は既定の private。nil = 既定の private）。共有キャッシュも保存してよい方針（Fresh）を書けるのはこの行と Static だけ（Response.cache の欄の説明）

## Mount

```sober
@effects()
func Mount(prefix string, routes []Route, mw []Middleware) []Route
```

routes の各行の path の前に prefix を付け、mw を各行の middleware の列の頭に足した表（純関数 — 足した mw は元の行の mw より外側で走る）。アプリ単位の middleware は `Mount("", routes, appMw)`

## Merge

```sober
@effects()
func Merge(a []Route, b []Route) []Route
```

a と b を繋いだ表

## Dispatch

```sober
@effects(Handler, Before, After)
func Dispatch(routes []Route, r Request) Response
```

routes から r に一致する行を選んで middleware とハンドラを走らせる。一致は path のパターンと method（大文字小文字を区別する）。優先順は表の並びに依らない: 一致した行どうしは、先頭から見て最初に種類が違うセグメントで 静的 > :name > \*name の方が勝つ（同じ具体さなら表の先の行）。HEAD の要求は HEAD の行が無ければ GET の行へ（本文は ServeConn が落とす）。path が一致する行があって method が合わなければ 405・無ければ 404。パスはデコードしない・末尾の "/" は区別する（リダイレクトしない）

## Static

```sober
@effects()
func Static(prefix string, root string, precompressed bool?, cache Cache?) []Route
```

prefix の下の GET を root の下のファイルで返すルートの表（1 行 — `GET <prefix>/*path` — Mount / Merge で合成する。prefix は "" か "/" で始まり "/" で終わらない形）:

```sober
rs := http.Merge(http.Static("/assets", "/srv/www", precompressed: true, cache: http.Fresh{maxAge: 31536000, immutable: true}), app())
http.ServeConn(c, (r) => http.Dispatch(rs, r))
```

要求ごとに root を io.OpenRoot し、`*path` を io.OpenUnder で開いて io.Stat の大きさを Content-Length に、本文を stream で送る（キャッシュしない — ディスクに追従。root の付け替えにも追従）。root の外へ出ないのはカーネルの保証（io.OpenUnder — `..`・絶対パス・外を指す symlink は拒否）で、ここは path を検査しない。無い・根の外・通常のファイルでない・権限なし・`*path` が空 = 404（存在を漏らさない）・それ以外の失敗 = 500。ドットファイルも出す（root は公開するもの）。precompressed: true なら要求の Accept-Encoding で `<name>.br`（br を優先）か `<name>.gz` を選んで素通しし（圧縮はしない）、Content-Encoding とVary: Accept-Encoding を付ける（元の名前のファイルが無ければ 404）。Content-Type は元の名前の拡張子（mimeOf）。条件付き GET（RFC 9110 13 節）: 応答に弱い ETag（送る実体の更新時刻と大きさ + 変種の印 — `W/"<ns の 16 進>-<大きさの 16 進>[-br|-gz]"`）・Last-Modified・Cache-Control（cache: — 省略は Revalidate）を付け、If-Match / If-Unmodified-Since が偽なら 412・If-None-Match が一致するか、If-None-Match が無く If-Modified-Since が Last-Modified とちょうど等しければ 304（等しいだけ — 古い版へ戻したデプロイで新しい版を使い続けさせない）。304 の頭は ETag・Cache-Control・（precompressed なら）Vary だけ。開いてから送るまでの間にファイルが差し替わったら（大きさか更新時刻が変われば）接続を閉じる。root を開いた io.Root で受けないのは、行の handler も stream も値のクロージャで、同一性の型を捕捉できないから（[language.md 28 節](../language.md)「静的ファイル」）

## Cache

```sober
type Cache union {
    Revalidate {}
    Fresh { maxAge int; immutable bool? } @shared
    Shared { maxAge int; sMaxAge int? } @shared
    NoStore {}
    Private { maxAge int? }
}
```

保存の方針（Cache-Control の値）。書く所は 2 つ: ルートの行（Route.cache・Static の cache: — 全部の variant）と応答 1 件（Response.cache — Private / NoStore だけ）。Fresh と Shared は共有キャッシュ（CDN・中継）も保存してよい方針（`@shared`）で、ルートの行でだけ書く（共有してよいかはルート単位の宣言 — 認証に届くハンドラ・middleware のルートでの共有の宣言・認証の middleware の Mount の下の共有のルートを analyzer が拒否する — [language.md 12 節](../language.md)「出所の依存」）

variant:

- `Revalidate` — `no-cache` — 保存してよいが、使う前に毎回確かめる（304 で本文を送らない — 確かめの要求は今の要求者の頭を運ぶので、共有可の宣言に数えない）
- `Fresh` — `max-age=<maxAge>`（immutable なら `, immutable`）— maxAge 秒は確かめずに使う（名前に版やハッシュを入れた資産向け・負の値は 0）
- `Shared` — `public, max-age=<maxAge>`（sMaxAge があれば `, s-maxage=<sMaxAge>`）— 共有キャッシュにも明示で保存させる（Authorization つきの要求の応答も — RFC 9111 3.5。負の値は 0）
- `NoStore` — `no-store` — 保存しない
- `Private` — `private`（maxAge があれば `private, max-age=<maxAge>`）— 利用者のブラウザだけが保存してよい（応答の既定）

## Param

```sober
@effects()
func Param(r Request, key string) string?
```

r のパターンの :key / \*key の値（Dispatch が一致させたパターンと path を並べて歩く — パターンに key が無い・ルーターを通らない要求は nil）

## ServeConn

```sober
@errors(io.NotFound, io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, panic, nondet, Stream)
func ServeConn(c net.Conn, route func(Request) Response, maxHead int?, maxBody int?, compress Gzip?, work task.Local?) error?
```

c の要求を順に route に渡して応答を書く（keep-alive）。相手が閉じる（FIN）・Connection: close・HTTP/1.0 の既定・誤りの応答の後で返る（閉じるのは呼び手 — net.Serve の接続の task の出口）。maxHead = 要求の頭の上限（既定 8 KiB — 超えたら 431）・maxBody = 本文の上限（既定 16 KiB — 超えたら 413）。本文と持ち越しは接続の task の region に載るので、上限は net.Serve の budget（既定 64 KiB）に収まる大きさで（目安: budget ≥ 3 × (maxHead + maxBody) + 16 KiB〔受けの切片〕）。compress: は応答の gzip（上の Gzip — 省略 = 圧縮しない）。work: は compress: の符号器の作業域のストレージ（ワーカー局所の lease — region-domain-pool.md 4d 節）: 省略すると要求ごとに作業域を取る（接続の task のregion に頁として残る — 接続の数に比例）。渡すと同じワーカーのストレージを借りる（作業域は ≈ 650 KB × ワーカーの数で接続の数に依らない・結果は同じバイト列）:

```sober
gzw := task.NewLocal((w mut flate.Work) => flate.Prepare(mut w))   // Serve の前に 1 回
net.Serve(l, (c net.Conn) => http.ServeConn(c, route, compress: http.Gzip{}, work: gzw))
```

work: は compress: と組みで（compress: なしの work: は panic(WorkNoCompress{}) — 呼び手の契約違反）。1 つのストレージを全部の接続で共有してよい（中はワーカーごとに分かれている）

失敗のラベル: `io.NotFound`・`io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## ServeWith

```sober
@errors(recv, send, put, io.NotFound, io.Denied, io.Timeout, io.Expired, io.Other)
@effects(block, panic, Stream)
func ServeWith(recv func(k func([]byte)) error?, send func(b []byte) error?, route func(Request) Response, maxHead int?, maxBody int?, compress Gzip?, work task.Local?, put (func(b []byte) error?)?) error?
```

ServeConn の核を転送路の受信コールバック recv（`for chunk <- recv()? { … }` の生成元 — net.Recv / tls.Recv の形）と送信コールバック send に一般化したもの（ServeConn は net の 1 行の包み・TLS の接続は `http.ServeWith((k) => tls.Recv(c, k), (b) => tls.Send(c, b), route, put: (b) => tls.Put(c, b))`）。失敗は recv / send / put が返すもの（仮引数の名前の @errors — [language.md 13 節](../language.md): 呼び手は渡したコールバックのラベルで switch を網羅する）。put（省略可 — [language.md 25 節](../language.md) Z）を渡すと送りを 2 段にする: 受けた切片 1 つ分の応答の列を put で積み（送らない）、積んだ分は recv が次の受けを待つ前に送る約束（tls.Recv は切片 1 つを配り終えるたびに tls.Flush する — 送りの完了待ちが応答の作業の region〔受けの反復〕の閉じた後になり、待ちの間に応答の平文の頁を抱えない）。stream の応答（前の応答と頭・emit ごと — emit の間隔のまま相手へ届く）は put があっても send で送る。put を渡さない呼び出し点のコードは put の無い形と同じ（`if put != nil` は呼び出し点ごとに畳まれる）誤りの応答の後の読み捨て（linger）も recv の続きを読む — tls.Recv は 2 度目を Closed で返すので読み捨てずに閉じる（TLS の close\_notify は呼び手の Serve が送る）

失敗のラベル: `recv`・`send`・`put`・`io.NotFound`・`io.Denied`・`io.Timeout`・`io.Expired`・`io.Other`

## BadMultipart

```sober
type BadMultipart error
```

Multipart が読めない本文（Content-Type が multipart/form-data でない・boundary が無いか形が違う・境界の行や部分の頭の形の誤り・閉じの境界が無い・部分の数か部分の頭の大きさが上限を超える）。応答はふつう 400

## Part

```sober
type Part struct {
    name string
    filename string?
    contentType string
    body []byte
}
```

multipart/form-data の部分 1 つ（Multipart の結果 — 本文の順）

欄:

- `name` — Content-Disposition の name（フォームの欄の名前）
- `filename` — Content-Disposition の filename（ファイルの欄 — 中身はブラウザが送った名前のまま。パスとして使うなら検査は呼び手。ファイルを選ばなかった欄はブラウザが "" を送る）。filename の無い部分（テキストの欄）は nil
- `contentType` — 部分の Content-Type（前後の空白を除いた値・無ければ "" — RFC 7578 4.4 の既定は text/plain）
- `body` — 部分の本文（r.body の切り出し — 区切りの前の CRLF は含まない）

## Multipart

```sober
@errors(BadMultipart)
@effects()
func Multipart(r Request) ([]Part, error?)
```

r の本文（Content-Type が multipart/form-data — boundary つき）の部分の列（本文の順）。前置き（最初の境界の前）と後置き（閉じの境界の後）は読み飛ばす。境界の行の後の空白（transport-padding）は許し、行の終わりは CRLF だけ（LF だけは誤り）。部分の頭は `名前: 値` の行の並び（折り返しは誤り）で、Content-Disposition（form-data・name 必須）はちょうど 1 本・Content-Type は 0 か 1 本・他の行は読み飛ばす。引数の値は token か quoted-string（'\' は後ろが区切りの字〔'"' '\' など〕のときだけ外す — Windows のパスをそのまま送る古いブラウザの形を壊さない）・引数の名前は大小を無視・同じ引数が 2 つは誤り。name / filename は UTF-8 であること。部分の本文は次の「CRLF + "--" + boundary」の手前まで — その後ろが "--"（閉じ）か空白 + CRLF でなければ誤り（boundary が本文に出ている）。閉じの境界が無い・部分が 1000 を超える・部分の頭が 8 KiB を超える = 誤り。部分 0 個（閉じの境界だけ）は空の列:

```sober
func upload(r http.Request) http.Response {
    parts := http.Multipart(r) catch return http.Status(http.BadRequest)
    for i <- iter.Range(0, len(parts)) {
        p := parts[i]
        f := p.filename
        if p.name == "file" && f != nil { save(f, p.body) }
    }
    return http.Text("ok")
}
```

失敗のラベル: [`BadMultipart`](#badmultipart)
