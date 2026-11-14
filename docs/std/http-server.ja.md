# std/http/server

日本語

`import "std/http/server"`

multipart/form-data の受け（RFC 7578 — 本文の切り方は RFC 2046 5.1.1）。本文は ServeConn が maxBody で切った r.body に全部載っているので、ここはr.bodyの上の位置を読むだけ（部分の本文はr.bodyの切り出し — コピーしない）。読むのは芯だけ: Content-Typeのboundary・部分ごとのContent-Disposition（form-data の name / filename）と Content-Type・CRLF の規律・閉じの境界。読まないもの: filename\*=（RFC 5987 の符号化 — 他の引数と同じく読み飛ばす）・入れ子の multipart（部分の本文のまま返す）・Content-Transfer-Encoding（解釈しない — RFC 7578 4.7 で非推奨）・name / filename の % の復号（ブラウザが '"' CR LF を %22 %0D %0A にする — WHATWG HTML — のは戻さない。生のまま）

## BadMultipart

```sober
type BadMultipart error
```

Multipart が読めない本文（Content-Type が multipart/form-data でない・boundary が無いか形が違う・境界の行や部分の頭の形の誤り・閉じの境界が無い・部分の数か部分の頭の大きさが上限を超える）。レスポンスはふつう400

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

フィールド:

- `name` — Content-Dispositionのname（フォームのフィールドの名前）
- `filename` — Content-Dispositionのfilename（ファイルのフィールド — 中身はブラウザが送った名前のまま。パスとして使うなら検査は呼び手。ファイルを選ばなかったフィールドはブラウザが "" を送る）。filenameの無い部分（テキストのフィールド）はnil
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
func upload(r http.server.Request) http.server.Response {
    parts := http.server.Multipart(r) catch return http.server.Status(http.BadRequest)
    for i <- iter.Range(0, len(parts)) {
        p := parts[i]
        f := p.filename
        if p.name == "file" && f != nil { save(f, p.body) }
    }
    return http.server.Text("ok")
}
```

失敗のラベル: [`BadMultipart`](#badmultipart)

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

リクエスト1件（この反復のregion — routeが返ったら消える。外へ持ち出すならコピーする）

フィールド:

- `path` — リクエストの対象の '?' の前（生のまま — %のデコードはしない）
- `query` — リクエストの対象の '?' の後（生のまま — %のデコードはしない）
- `head` — リクエストの頭（リクエスト行からヘッダの終わりの空行まで — 検査済み）。認証のヘッダを含むので認証の源（stdの外のpackageで読むと、その値と読んだ関数は認証に届く — [language.md 12 節](../language.md)「出所の依存」。stdの中の読み〔Header・Dispatchのコピー〕は源にしない）
- `headers` — headの上のヘッダの位置 × 本数。1本 = 2ワード [名前の始め | 終わり \<\< 32, 値の始め | 終わり \<\< 32]（lo32 / hi32で読む — 頭は4 GiB未満）
- `body` — 本文（Content-Lengthの分・chunkedは繋いだコピー）
- `pattern` — Dispatchが一致させたルートのpath（"/users/:id" — ルーターを通らないリクエストは ""。Paramはこれとpathを並べて歩く）

## Response

```sober
type Response struct {
    status http.StatusCode
    contentType string
    body []byte
    length int?
    stream Stream?
    headers Headers?
    coded Coded?
    cache Cache?
    validators Validators?
    cookies []SetCookie
    delay int
}
```

レスポンス（status・Content-Type〔"" なら書かない〕・本文）。streamがあれば本文の代わりにServeConnが頭の後でstreamを呼び、streamがemitに渡したバイト列をそのまま送る（コールバック形式〔継続渡し / CPS〕— [language.md 28 節](../language.md)w2の「レスポンスの枠」）。emit 1回 = 送り1回（emitをまたいでバッファしない）。length があれば Content-Length（stream が emit で送る合計は length ちょうどであること — ServeConn は合計を数え、超えた emit は送らず・stream が返った時点で合計が length でなければ閉じる〔相手は本文の切れで知る〕）。length が nil（長さ不定）なら Transfer-Encoding: chunked（emit 1 回 = chunk 1 つ・空の emit は送らない・stream が nil で返ったら終端のchunk）— HTTP/1.0のリクエストにはContent-Lengthもchunkedも書かず、streamが返ったら閉じる（閉じで区切る）。streamが誤りを返したら終端を書かずに閉じる。compression: があり・Content-Typeが圧縮向き・リクエストがgzipを受け・codedが無いstreamのレスポンス（長さ既知ならlengthが1024以上のとき）はgzipにしてchunkedで送る（emit 1回 = deflateの sync flush 1回 = chunk 1つ・ウィンドウはemitをまたいで持ち越す・HTTP/1.0は閉じで区切る・Varyはbodyのレスポンスと同じ）。HEADでは呼ばない（頭はGETと同じ）。streamはリクエストの値（pathなど）を捕捉してよいクロージャ。Fileは捕捉させずpathを捕捉してstreamの中で開く。送りの状態out（Out — 中身はstd/http/serverの外から見えない）は呼び手が持ち、emitを呼ぶたびに `emit(mut out, b)` と渡す（クロージャはmutを捕捉しない — [language.md 25 節](../language.md)「関数型のmut仮引数」）:

```sober
func handle(r http.server.Request) http.server.Response {
    return http.server.Response{status: 200, contentType: "text/plain", length: n, stream: (out, emit) => sendFile(r.path, mut out, emit)}
}
func sendFile(path string, out mut http.server.Out, emit func(out mut http.server.Out, b []byte) error?) error? {
    f := io.Open(path)?
    defer io.Close(f)
    for b <- io.Chunks(f)? { emit(mut out, io.Raw(b))? }
    return nil
}
```

フィールド:

- `length` — streamの本文の長さ（Content-Length — nil = 長さ不定 = chunked）。bodyのレスポンスでは読まない
- `headers` — 任意ヘッダ（書いた順に Cache-Control の後へ）。std/http/server が書く名前（Content-Type・Content-Length・Content-Encoding・Transfer-Encoding・Connection・Vary）・保存の方針と検証子の名前（Cache-Control・CDN-Cache-Control・Surrogate-Control・ETag・Last-Modified — 書くのは型のフィールドcache / validatorsだけ）とCR / LF / NULを含む名前・値はpanic(BadHeader) — レスポンスの分割の封:     http.server.Response{status: 200, contentType: "text/plain", body: b, headers: http.server.Headers{list: []http.Field{http.Field{name: "X-Request-Id", value: id}}}}
- `coded` — 本文の符号化を選んだレスポンス（Staticのprecompressed — 下のCoded）。あればServeConnはVary: Accept-Encodingを書き、encodingが空でなければContent-Encoding を書き、compression: を掛けない
- `cache` — 保存の方針（Cache-Control）。レスポンス1件で書くのはPrivate / NoStore — 共有キャッシュも保存してよい方針（Fresh）はルートの行（Route.cache・Staticのcache:）で書き、Dispatchがこのフィールドの無いレスポンスにコピーする〔stdの外でレスポンス1件にFresh / Sharedを書くとanalyzerが拒否する〕）。どこにも無ければ `Cache-Control: private`（利用者のブラウザだけが保存してよい — 認証つきのリクエストのレスポンスをCDNの規則が拾う形〔web cache deception〕の入口を狭める既定）    http.server.Response{status: 200, contentType: "text/plain", body: b, cache: http.server.NoStore{}}
- `validators` — 検証子（ETag・Last-Modified — 作れるのはstd/http/serverだけ: 封の型。同じ検証子を別の利用者の中身に付けると、検証しに来たキャッシュへの304で他人の版が出る — 検証子は中身から std が作る）
- `cookies` — Set-Cookie（書けるのはこのフィールドだけ — 下のSetCookie）。書いた順に任意ヘッダの後へ
- `delay` — 送る前の待ち（ミリ秒 — Delayed で付ける。0 以下 = 待たない）。接続の task はハンドラから戻った浅い点で待つ

## Validators

```sober
type Validators struct {
    etag string
    modified int
    seal validSeal
}
```

レスポンスの検証子（ETagとLast-Modified — Staticが作る。modifiedは秒・0以下はLast-Modifiedを書かない）

## Coded

```sober
type Coded struct {
    encoding string
}
```

レスポンスの本文がリクエストのAccept-Encodingで選ばれたこと（encoding = 選んだ符号化〔"br" / "gzip"〕・"" = 候補を見たが元のまま）。本文は既にその符号化のバイト列（ServeConnは圧縮しない — 選ぶだけ）。同じURLのレスポンスがリクエストの頭で変わるので、元のままのレスポンスにもVaryを付ける

## Headers

```sober
type Headers struct {
    list []http.Field
}
```

任意ヘッダの列（Responseのフィールドをoptionの包みにしてあるのは、フィールドを持たないレスポンス〔大半〕のパスに空の列の確保とregionの付け替えを積まないため）

## SetCookie

```sober
type SetCookie struct {
    name string
    value string
    maxAge int?
    path string?
    domain string?
    sameSite SameSite?
    dangerouslyAllowHttp bool
    dangerouslyScriptReadable bool
}
```

Set-Cookieの1本（Response.cookiesの要素 — Set-Cookieを書けるのはこのフィールドだけ。生のSet-Cookieをheadersに書くとpanic(BadHeader)）。省いたフィールドのゼロ値が安全な側: Secure・HttpOnly・SameSite=Lax・Path=/・Domainなし（host-only — サブドメインへ送らない）・Max-Ageなし（ブラウザを閉じるまで）。緩めるフィールドはdangerouslyの綴り（grepで全部拾える）。値は符号化しない — cookie-octet〔英数字と記号のうち空白・`"` `,` `;` `\` 以外〕に収まらない値は呼び手がurl.Escapeかbase64urlで包む。名前・値・フィールドの組み合わせが書けなければpanic(BadHeader{name: "Set-Cookie"})

```sober
http.server.Response{status: 200, contentType: "text/plain", body: b, cookies: []http.server.SetCookie{http.server.SetCookie{name: "__Host-sid", value: tok}}}
```

フィールド:

- `maxAge` — 秒（0 = 今ある cookie を消す・負は書けない）。nil = Max-Age を書かない
- `path` — nil = "/"
- `domain` — nil = Domain を書かない（host-only）
- `sameSite` — nil = Lax
- `dangerouslyAllowHttp` — trueでSecureを外す（httpの開発環境だけのオプション — SameSiteNone・名前の \_\_Host- / \_\_Secure- とは組めない）
- `dangerouslyScriptReadable` — true で HttpOnly を外す（スクリプトから読ませる）

## SameSite

```sober
type SameSite union {
    SameSiteLax {}
    SameSiteStrict {}
    SameSiteNone {}
}
```

SameSite 属性（RFC 6265bis 5.4.7 — None は Secure が要る）

## Stream

```sober
type Stream func(out mut Out, emit func(out mut Out, b []byte) error?) error? @errors(emit, io.NotFound, io.Denied, io.Timeout, io.Expired, io.Other)
```

レスポンスの本文の供給（emitは借り — 呼ぶ・借りの位置へ渡すだけ。[language.md 25 節](../language.md)「借り」）。outは送りの状態で、emitに毎回mutで渡す

## Out

```sober
type Out struct {
    s internal.deflate.Stream
    n int
    lim int?
    over bool
}
```

stream の送りの状態（圧縮する stream の符号器・送った合計・長さ既知なら length・超えたか）。ServeConn が作って stream に渡す — 利用者は中身を読み書きせず、受け取った out を emit にそのまま渡す

## Text

```sober
@effects()
func Text(s string) Response
```

200・text/plainのレスポンス

## Delayed

```sober
@effects()
func Delayed(ms int, r Response) Response
```

rをmsミリ秒待ってから送るレスポンス（ms ≤ 0は待たない）。待つのはそのレスポンスの頭を書く直前で、同じ接続の前のリクエストのレスポンスは先に送る。ハンドラの中でos.Sleepしてから返すのと送る時刻は同じだが、待つ間ハンドラのスタックとリクエストのregionを持たない（接続のtaskはハンドラから戻った浅い点でスリープする）。接続の期限はos.Sleepと同じく待ちを切る（[language.md 28 節](../language.md)）

```sober
return http.server.Delayed(50, http.server.Text("ok"))
```

## Json

```sober
@effects()
func Json(s string) Response
```

200・application/jsonのレスポンス（sは組み上がったJSON — std/jsonのPut… / Done）

## Event

```sober
type Event struct {
    event string?
    data string
    id string?
    retry int?
}
```

Server-Sent Events のイベント 1 つ（WHATWG HTML 9.2 の text/event-stream — FormatEvent で組んで stream の emit に渡す）。event = イベントの種類（nil = 書かない・受け手は message）・data = 本文（改行で行に割る）・id = 最後のイベントの番号（受け手が繋ぎ直すときに Last-Event-ID で返す — `http.server.Header(r, "Last-Event-ID")`）・retry = 繋ぎ直しの待ち（ミリ秒）

## BadEvent

```sober
type BadEvent panic {
    field string
}
```

Eventのevent / idにCR・LF・NULがある（呼び手の契約違反 — イベントの差し込みの封: 行の区切りを値に書けると、受け手に別のイベントやフィールドを足せる。panicラベル）

## FormatEvent

```sober
@effects(panic)
func FormatEvent(e Event) string
```

e の text/event-stream の 1 イベント（`event:`・`id:`・`retry:`・`data:` の行と、終わりの空行）。data は改行（LF・CRLF・CR）で割って行ごとの `data:` にする（受け手は行をLFで繋ぎ直す — 改行の種類はLFに揃う）。event / idにCR・LF・NULがあればpanic(BadEvent)。配送はレスポンスのstreamで、emit 1回 = 送り1回（[language.md 28 節](../language.md)の「SSE」— 長さ不定の stream は chunked）。心拍のコメントは `emit(mut out, bytes(": ping\n\n"))` で書ける:

```sober
http.server.Response{status: 200, contentType: "text/event-stream", cache: http.server.NoStore{}, stream: (out, emit) => {
    emit(mut out, bytes(http.server.FormatEvent(http.server.Event{event: "tick", data: "1", id: "1"})))?
    nil
}}
```

## Status

```sober
@effects()
func Status(code http.StatusCode) Response
```

本文なしのレスポンス（http.NotFound / http.MethodNotAllowed …）

## Gzip

```sober
type Gzip struct {
    level int
    fresh bool
}
```

ServeConnのcompression: の値（レスポンスのgzip — RFC 1952。levelはstd/compress/flateと同じ1〜9・0は既定の6と読む — ゼロ値 `http.server.Gzip{}` が既定）:

```sober
http.server.ServeConn(c, route, compression: http.server.Gzip{level: 6})
```

ServeConnがリクエストのAccept-Encodingを見て、レスポンスのContent-Typeが圧縮向き（text/\* かapplication/json）で本文が1024バイト以上なら、本文をgzipにしてContent-Encoding: gzipを付ける。圧縮しうるレスポンスには受けないリクエストにもVary: Accept-Encodingを付ける（同じURLのレスポンスがリクエストの頭で変わる — 中継のキャッシュの正しさ）。routeは圧縮を知らない（middlewareと同じ位置 — リクエストごとに直列化 + 圧縮・圧縮済みのコピーをバッファしない）。1〜9の外のlevelはpanic(BadLevel)。接続ごとに直近の動的Huffmanの木を記録し（compress.gzip.History — 最初に圧縮したレスポンスで接続あたり4 KB: 記録 ≈1.2 KBが接続のページを1枚持つ）、似た本文の続く接続では木を作らずに使う:圧縮した本文は接続のリクエストの列で決まる（同じ列なら同じバイト列）・大きさは記録を使ったブロックで記録なしの1.03倍まで（ε = 0.03）。`Gzip{fresh: true}` で記録を持たない（毎回最適の木 = 今までの決定的なパス）

フィールド:

- `fresh` — true = 接続ごとの記録を持たない（毎回その本文の最適の木 = 記録なしの決定的なパス — 圧縮した本文がリクエストごとに本文だけで決まる。内容アドレスのキャッシュ等）

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

ServeConn の work: を compression: なしで渡した（作業域は圧縮の符号器のもの — 呼び手の契約違反。panic ラベル）

## Header

```sober
@effects()
func Header(r Request, name string) string?
```

r のヘッダ name の値（名前は大文字小文字を区別しない — 最初の一致。無ければ nil）。認証のヘッダ（Authorization・Proxy-Authorization・Cookie）は読めない（nil）— 読むインターフェースはAuthorizationとCookieだけ（認証の源の明示: 認証に届くレスポンスを共有キャッシュへ宣言する形をanalyzerが拒否する — [language.md 13 節](../language.md)の補3）

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
@errors(json.BadJson)
@effects()
func JsonDoc(r Request) (json.Doc, error?)
```

本文を JSON として読んだ表（std/json の Doc — 型へは `json.Decode[T](d, json.Root(d))`。総称の包み〔T を受ける関数〕はjson.Decode の型引数が具体の struct を要るので書けない）

失敗のラベル: `json.BadJson`

## Handler

```sober
type Handler func(r Request) Response
```

リクエスト1件の処理（ルートの表の行が持つ）

## Before

```sober
type Before func(r Request) Response?
```

ハンドラの前に走るコールバック（nil = 続ける・レスポンスを返すとshort-circuit — 内側のmiddlewareとハンドラは走らない）

## After

```sober
type After func(r Request, w Response) Response
```

ハンドラの後に走るコールバック（内側が返したレスポンスwを受けてレスポンスを返す）

## Middleware

```sober
type Middleware struct {
    before Before?
    after After?
}
```

ルートの前後に挟む処理（beforeとafterの組 — どちらも省ける）。チェーンの順は外から内: beforeは外→内、ハンドラ、afterは内→外。beforeがレスポンスを返したら、それより外のmiddlewareのafterだけを内→外で掛ける（玉ねぎの意味 — short-circuitしたmw自身と内側のafterは走らない）。nextを受けて内側を呼ぶ形（Express / Koa）は今の言語で書けない（型が自分を関数型の中で名前で参照する再帰型 — [language.md 28 節](../language.md)）

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

ルートの表の 1 行（method + path のパターン → ハンドラ・ルート単位の middleware）。パターンは "/" で区切ったセグメントの列:静的（`users`）・`:name`（1 セグメント — 空は不一致）・`*name`（末尾だけ — 残り全部〔0 個以上のセグメント・"/" を含む〕。値は先頭の "/" を除いた残り）。表はただのデータ — モジュールは `[]http.server.Route` を返す関数を export し、Mount / Merge で合成する（表を歩けば全ルートが見える）:

```sober
func routes() []http.server.Route {
    return http.server.Merge(
        http.server.Mount("/users", users.Routes(), []http.server.Middleware{auth}),
        []http.server.Route{http.server.Route{method: "GET", path: "/health", handler: health}})
}
rs := routes()
http.server.ServeConn(c, (r) => http.server.Dispatch(rs, r))
```

フィールド:

- `cache` — この行のレスポンスの保存の方針（レスポンスがcacheを持たない2xxと304にDispatchがコピーする・レスポンスのcacheが勝つ・他の状態は既定のprivate。nil = 既定のprivate）。共有キャッシュも保存してよい方針（Fresh）を書けるのはこの行とStaticだけ（Response.cacheのフィールドの説明）

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

routes から r に一致する行を選んで middleware とハンドラを走らせる。一致は path のパターンと method（大文字小文字を区別する）。優先順は表の並びに依らない: 一致した行どうしは、先頭から見て最初に種類が違うセグメントで 静的 > :name > \*name の方が勝つ（同じ具体さなら表の先の行）。HEADのリクエストはHEADの行が無ければGETの行へ（本文はServeConnが落とす）。pathが一致する行があってmethodが合わなければ405・無ければ404。パスはデコードしない・末尾の "/" は区別する（リダイレクトしない）

## Static

```sober
@effects()
func Static(prefix string, root string, precompressed bool?, cache Cache?) []Route
```

prefix の下の GET を root の下のファイルで返すルートの表（1 行 — `GET <prefix>/*path` — Mount / Merge で合成する。prefix は "" か "/" で始まり "/" で終わらない形）:

```sober
rs := http.server.Merge(http.server.Static("/assets", "/srv/www", precompressed: true, cache: http.server.Fresh{maxAge: 31536000, immutable: true}), app())
http.server.ServeConn(c, (r) => http.server.Dispatch(rs, r))
```

リクエストごとにrootをio.OpenRootし、`*path` をio.OpenUnderで開いてio.Statの大きさをContent-Lengthに、本文をstreamで送る（キャッシュしない — ディスクに追従。root の付け替えにも追従）。root の外へ出ないのはカーネルの保証（io.OpenUnder — `..`・絶対パス・外を指す symlink は拒否）で、ここは path を検査しない。無い・根の外・通常のファイルでない・権限なし・`*path` が空 = 404（存在を漏らさない）・それ以外の失敗 = 500。ドットファイルも出す（root は公開するもの）。precompressed: trueならリクエストのAccept-Encodingで `<name>.br`（brを優先）か `<name>.gz` を選んで素通しし（圧縮はしない）、Content-EncodingとVary: Accept-Encoding を付ける（元の名前のファイルが無ければ 404）。Content-Type は元の名前の拡張子（mimeOf）。条件付きGET（RFC 9110 13 節）: レスポンスに弱いETag（送る実体の更新時刻と大きさ + 変種のマーク — `W/"<ns の 16 進>-<大きさの 16 進>[-br|-gz]"`）・Last-Modified・Cache-Control（cache: — 省略は Revalidate）を付け、If-Match / If-Unmodified-Since が偽なら 412・If-None-Match が一致するか、If-None-Match が無く If-Modified-Since が Last-Modified とちょうど等しければ 304（等しいだけ — 古い版へ戻したデプロイで新しい版を使い続けさせない）。304 の頭は ETag・Cache-Control・（precompressed なら）Vary だけ。開いてから送るまでの間にファイルが差し替わったら（大きさか更新時刻が変われば）接続を閉じる。root を開いた io.Root で受けないのは、行の handler も stream も値のクロージャで、同一性の型を捕捉できないから（[language.md 28 節](../language.md)「静的ファイル」）

## Cache

```sober
type Cache union {
    Revalidate {}
    Fresh { maxAge int; immutable bool? } @shared
    Shared { maxAge int; sMaxAge int? } @shared
    NoStore {}
    Private { maxAge int? }
    Unstated {} @shared
}
```

保存の方針（Cache-Controlの値）。書く所は2つ: ルートの行（Route.cache・Staticのcache: — 全部のvariant）とレスポンス1件（Response.cache — Private / NoStore だけ）。Fresh と Shared は共有キャッシュ（CDN・中継）も保存してよい方針（`@shared`）で、ルートの行でだけ書く（共有してよいかはルート単位の宣言 — 認証に届くハンドラ・middleware のルートでの共有の宣言・認証の middleware の Mount の下の共有のルートを analyzer が拒否する — [language.md 12 節](../language.md)「出所の依存」）

variant:

- `Revalidate` — `no-cache` — 保存してよいが、使う前に毎回検証する（304で本文を送らない — 検証のリクエストは今のリクエスト元の頭を運ぶので、共有可の宣言に数えない）
- `Fresh` — `max-age=<maxAge>`（immutableなら `, immutable`）— maxAge秒は検証せずに使う（名前に版やハッシュを入れた資産向け・負の値は0）
- `Shared` — `public, max-age=<maxAge>`（sMaxAgeがあれば `, s-maxage=<sMaxAge>`）— 共有キャッシュにも明示で保存させる（Authorizationつきのリクエストのレスポンスも — RFC 9111 3.5。負の値は 0）
- `NoStore` — `no-store` — 保存しない
- `Private` — `private`（maxAgeがあれば `private, max-age=<maxAge>`）— 利用者のブラウザだけが保存してよい（レスポンスの既定）
- `Unstated` — 毎レスポンスの頭の24バイトが要らない公開のAPI向け（認証に届くルートでは書けない — 上のFresh / Sharedと同じ検査）

## Param

```sober
@effects()
func Param(r Request, key string) string?
```

rのパターンの :key / \*keyの値（Dispatchが一致させたパターンとpathを並べて歩く — パターンにkeyが無い・ルーターを通らないリクエストはnil）

## ServeConn

```sober
@errors(io.NotFound, io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, panic, nondet, Stream)
func ServeConn(c net.Conn, route func(Request) Response, maxHead int?, maxBody int?, compression Gzip?, work task.Local?) error?
```

cのリクエストを順にrouteに渡してレスポンスを書く（keep-alive）。相手が閉じる（FIN）・Connection: close・HTTP/1.0の既定・誤りのレスポンスの後で返る（閉じるのは呼び手 — net.Serveの接続のtaskの出口）。maxHead = リクエストの頭の上限（既定8 KiB — 超えたら431）・maxBody = 本文の上限（既定 16 KiB — 超えたら 413）。本文と持ち越しは接続の task の region に載るので、上限は net.Serve の budget（既定 64 KiB）に収まる大きさで（目安: budget ≥ 3 × (maxHead + maxBody) + 16 KiB〔受けの切片〕）。compression: はレスポンスのgzip（上のGzip — 省略 = 圧縮しない）。work: はcompression: の符号器の作業域のストレージ（ワーカー局所のlease — region-domain-pool.md 4d節）: 省略するとリクエストごとに作業域を取る（接続のtaskのregionにページとして残る — 接続の数に比例）。渡すと同じワーカーのストレージを借りる（作業域は ≈ 200 KB × ワーカーの数で接続の数に依らない・結果は同じバイト列）:

```sober
gzw := task.NewLocal((w mut compress.flate.Work) => compress.flate.NewWork(mut w))   // Serve の前に 1 回
net.Serve(l, (c net.Conn) => http.server.ServeConn(c, route, compression: http.server.Gzip{}, work: gzw))
```

work: は compression: と組みで（compression: なしの work: は panic(WorkNoCompress{}) — 呼び手の契約違反）。1 つのストレージを全部の接続で共有してよい（中はワーカーごとに分かれている）

失敗のラベル: `io.NotFound`・`io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## ServeWith

```sober
@errors(recv, send, put, io.NotFound, io.Denied, io.Timeout, io.Expired, io.Other)
@effects(block, panic, Stream)
func ServeWith(recv func(k func([]byte)) error?, send func(b []byte) error?, route func(Request) Response, maxHead int?, maxBody int?, compression Gzip?, work task.Local?, put (func(b []byte) error?)?) error?
```

ServeConn の核を転送路の受信コールバック recv（`for chunk <- recv()? { … }` の生成元 — net.Recv / tls.Recv の形）と送信コールバック send に一般化したもの（ServeConn は net の 1 行の包み・TLS の接続は `http.server.ServeWith((k) => tls.Recv(c, k), (b) => tls.Send(c, b), route, put: (b) => tls.Put(c, b))`）。失敗は recv / send / put が返すもの（仮引数の名前の @errors — [language.md 13 節](../language.md): 呼び手は渡したコールバックのラベルで switch を網羅する）。put（省略可 — [language.md 25 節](../language.md)Z）を渡すと送りを2フェーズにする: 受けた切片1つ分のレスポンスの列をputで積み（送らない）、積んだ分はrecvが次の受けを待つ前に送る約束（tls.Recvは切片1つを配り終えるたびにtls.Flushする — 送りの完了待ちがレスポンスの作業のregion〔受けの反復〕の閉じた後になり、待ちの間にレスポンスの平文のページを抱えない）。streamのレスポンス（前のレスポンスと頭・emitごと — emitの間隔のまま相手へ届く）はputがあってもsendで送る。putを渡さない呼び出し点のコードは put の無い形と同じ（`if put != nil` は呼び出し点ごとに畳まれる）誤りのレスポンスの後の読み捨て（linger）もrecvの続きを読む — tls.Recvは2度目をClosedで返すので読み捨てずに閉じる（TLSのclose\_notifyは呼び手のServeが送る）

失敗のラベル: `recv`・`send`・`put`・`io.NotFound`・`io.Denied`・`io.Timeout`・`io.Expired`・`io.Other`
