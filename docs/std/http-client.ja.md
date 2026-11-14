# std/http/client

日本語

`import "std/http/client"`

HTTP/1.1のクライアント（httpとhttps — TLSは1.3が既定・証明書のチェーンは常に検証する〔検証を切るフィールドは無い〕）。状態は持たない: 方針は呼び手が持つデータPolicy（ゼロ値 = 既定 — フィールドはどれも安全な側: 本文の上限つき・期限つき・redirectは10回まで追いhttps → httpへは降りない）を `policy:` で渡し、cookieはレスポンスからCookieValueで取り出して次のリクエストの `cookies:` に自分で載せる。Requestはリクエスト1本ごとに接続を張って閉じる（Connection: close）。同じoriginへのkeep-aliveはOpenの範囲の中のまとめで

```sober
r := http.client.Request("https://api.example/v1/items")?
println(r.status)
```

## Policy

```sober
type Policy struct {
    timeout int?
    redirects int?
    maxBody int?
    userAgent string?
    extraRoots tls.Roots?
    dangerouslyAllowTls12 bool
    proxy Proxy?
    proxyAuth string?
}
```

方針（省いたフィールド・nilは既定）: timeout = リクエスト1本の全体の期限30秒〔ns・0以下も既定〕・redirects = 追う回数10〔0 = 追わない — 3xxをそのまま返す〕・maxBody = 本文の上限8 MiB〔上限1 GiB — 無制限は書けない〕・userAgent = "sober"・extraRoots = 焼き込みのWebPKIのルート〔Mozilla NSS — チェーンのleafにCA/Bの規則を掛ける〕に足す起点〔私的PKI — tls.ParseRootsの値。この起点で止まるチェーンにはCA/Bの規則を掛けない〕・dangerouslyAllowTls12 = TLS 1.2も申し出る（既定は 1.3 だけ — 1.2 だけのサーバのための緩和。綴りで緩めたことが grep で拾える）・proxy = 通す proxy（ParseProxy の値 — nil = 直結。環境変数は読まない）・proxyAuth = proxy へ渡す Proxy-Authorization の値そのもの（"Basic …" の組み立ては呼び手 — CR / LF / NUL があれば panic(http.BadHeader) — route.sober）

## Cookie

```sober
type Cookie struct {
    name string
    value string
}
```

リクエストに載せるcookie 1本（Cookieの頭に `name=value` を `; ` で繋いで載せる。名前がtokenでない・値に `;` や制御文字があればpanic(http.BadHeader)）

## Response

```sober
type Response struct {
    status int
    headers []http.Field
    body []byte
    url string
}
```

レスポンス（headersの名前は小文字・url = redirectを辿った後のURL）

## Dns

```sober
type Dns error
```

名前の解決の失敗（cause = net.NoHost / net.NonASCIIHost）

## Tls

```sober
type Tls error
```

TLSの失敗（証明書のチェーンの検証・相手のalert・recordの形の誤り — causeに内側の誤り）

## Timeout

```sober
type Timeout error
```

リクエスト1本の期限（Policyのtimeout）が過ぎた・相手が応答しない

## TooManyRedirects

```sober
type TooManyRedirects error
```

redirect が上限を超えた

## InsecureRedirect

```sober
type InsecureRedirect error
```

https から http への redirect（降格は追わない）

## BodyTooLarge

```sober
type BodyTooLarge error
```

本文が上限（Policy の maxBody）を超えた

## Closed

```sober
type Closed error
```

相手が接続を拒んだ・レスポンスの途中で閉じた

## BadUrl

```sober
type BadUrl error
```

URL の形の誤り（scheme が http / https でない・userinfo・IPv6 の番地・空白や制御文字）

## BadResponse

```sober
type BadResponse error
```

レスポンスの形の誤り（状態行・頭・chunkedの形・頭の上限64 KiB超え）

## Header

```sober
@effects()
func Header(r Response, name string) string?
```

レスポンスの頭の最初の1本（名前は大文字小文字を区別しない）

## Request

```sober
@errors(Dns, Tls, Timeout, TooManyRedirects, InsecureRedirect, BodyTooLarge, Closed, BadUrl, BadResponse, ProxyRefused, io.Expired)
@effects(block, io, panic, nondet)
func Request(url string, method string?, headers ([]http.Field)?, body ([]byte)?, cookies ([]Cookie)?, policy Policy?) (Response, error?)
```

urlへリクエストを送ってレスポンスを返す（methodの既定 = GET・headersはHost / Content-Length / Transfer-Encoding / Connectionを書けない〔stdが書く — 書くと panic(http.BadHeader)〕・body があれば Content-Length をつけて送る・cookies は Cookie の頭に載せる・policy の既定 = Policy{}）。redirect を追う — 301 / 302 / 303 は POST を GET に変えて本文を落とす・307 / 308 は保つ・origin が変われば Authorization と Cookie の頭と cookies を落とす。接続はリクエストごとに張って閉じる

失敗のラベル: [`Dns`](#dns)・[`Tls`](#tls)・[`Timeout`](#timeout)・[`TooManyRedirects`](#toomanyredirects)・[`InsecureRedirect`](#insecureredirect)・[`BodyTooLarge`](#bodytoolarge)・[`Closed`](#closed)・[`BadUrl`](#badurl)・[`BadResponse`](#badresponse)・[`ProxyRefused`](#proxyrefused)・`io.Expired`

## CookieValue

```sober
@effects()
func CookieValue(r Response, name string) string?
```

レスポンスのSet-Cookieのうち名前がnameの最後の1本の値（無ければnil — 属性〔Path・Max-Age …〕は読まない。載せ直すのは呼び手 — `cookies:`）

## ProxyRefused

```sober
type ProxyRefused error {
    status int
}
```

proxyがCONNECTを断った（status = proxyのレスポンスの状態 — 407は認証の要求）

## BadProxy

```sober
type BadProxy error
```

ParseProxy の文字列が http / https の URL（path なし・userinfo なし）でない

## Proxy

```sober
type Proxy struct {
    t target
    seal proxySeal
}
```

通す proxy（ParseProxy が作る — 封の型。t = proxy の番地と TLS の有無）

## ParseProxy

```sober
@errors(BadProxy)
@effects()
func ParseProxy(s string) (Proxy, error?)
```

proxy の URL s（"http://host:port" か "https://host:port" — https なら proxy へも TLS）の Proxy。形が違えば BadProxy

失敗のラベル: [`BadProxy`](#badproxy)

## Session

```sober
type Session struct {
    c net.Conn
    p cfg
    blk []int
    t target
    pa internal.hsc.CParams
    pb internal.hsc.CParams
    seal sessionSeal
}
```

1つのoriginへのkeep-aliveの接続（同一性の型 — Openのkの仮引数としてだけ生まれる。blk = 経路の層の格納場所〔link.sober〕・pa / pb = proxy / 行き先の握手の設定・p = Openのpolicyを読み解いた設定〔まとめの往復の期限・上限・経路〕）

## Open

```sober
@errors(Dns, Tls, Timeout, Closed, BadUrl, BadResponse, ProxyRefused, io.Expired)
@effects(block, io, panic, nondet)
func Open(at string, k func(s Session), policy Policy?) error?
```

at の origin（"https://host[:port]" — path は見ない）へ接続を張り（proxy があれば proxy を通す）、Session を k に渡す（k が返ったら TLS なら close\_notify を送って閉じる）。policy（既定 = Policy{}）はまとめの全往復に掛かる。policyのtimeoutの期限は経路の層を重ねるまで（proxyへのTLS・CONNECT・行き先へのTLSの握手）— TCPの接続そのものの不達はOSのconnectの期限に任せる。k の中の誤りは k の中で受ける（Open が返すのは接続と経路の失敗だけ）

失敗のラベル: [`Dns`](#dns)・[`Tls`](#tls)・[`Timeout`](#timeout)・[`Closed`](#closed)・[`BadUrl`](#badurl)・[`BadResponse`](#badresponse)・[`ProxyRefused`](#proxyrefused)・`io.Expired`

## Send

```sober
@errors(Tls, Timeout, BodyTooLarge, Closed, BadUrl, BadResponse, io.Expired)
@effects(block, io, panic, nondet)
func Send(s Session, url string, method string?, headers ([]http.Field)?, body ([]byte)?, cookies ([]Cookie)?) (Response, error?)
```

sの接続の上でリクエストを1往復（urlは "/path" かsと同じoriginの絶対URL — 別のoriginはBadUrl・method / headers / body / cookiesはRequestと同じ）。redirectは追わない（3xxをそのまま返す — まとめは1本の接続の往復）。期限・本文の上限はOpenのpolicy。相手が閉じた後・閉じで区切るレスポンスの後・Connection: closeのレスポンスの後・途中の失敗の後のSendはClosed（張り直すのは呼び手 — 新しいOpenで）

失敗のラベル: [`Tls`](#tls)・[`Timeout`](#timeout)・[`BodyTooLarge`](#bodytoolarge)・[`Closed`](#closed)・[`BadUrl`](#badurl)・[`BadResponse`](#badresponse)・`io.Expired`

## Part

```sober
type Part struct {
    head Response
    chunk []byte
}
```

Streamの生成元の要素（head = レスポンスの頭〔bodyは空 — 要素ごとに同じ値〕・chunk = 本文の切片）

## Stream

```sober
@errors(Dns, Tls, Timeout, TooManyRedirects, InsecureRedirect, BodyTooLarge, Closed, BadUrl, BadResponse, ProxyRefused, io.Expired)
@effects(block, io, panic, nondet)
func Stream(url string, k func(p Part), method string?, headers ([]http.Field)?, body ([]byte)?, cookies ([]Cookie)?, policy Policy?) error?
```

urlへリクエストを送り（method / headers / body / cookies / policyはRequestと同じ）、レスポンスの頭と本文の切片をkへ渡す（最初の要素は頭と空の切片で、本文が空でも1度は渡る）。redirectはRequestと同じ規則で追い、追ったレスポンスはkへ渡さない。本文の合計がpolicyのmaxBodyを超えたらBodyTooLarge（大きい本文は maxBody で明示的に上げる）

```sober
for part <- http.client.Stream(u)? {
    if part.head.status != 200 { … }
    io.Write(f, part.chunk)?
}
```

失敗のラベル: [`Dns`](#dns)・[`Tls`](#tls)・[`Timeout`](#timeout)・[`TooManyRedirects`](#toomanyredirects)・[`InsecureRedirect`](#insecureredirect)・[`BodyTooLarge`](#bodytoolarge)・[`Closed`](#closed)・[`BadUrl`](#badurl)・[`BadResponse`](#badresponse)・[`ProxyRefused`](#proxyrefused)・`io.Expired`
