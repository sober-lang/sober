# std/http/client

日本語

`import "std/http/client"`

HTTP/1.1 のクライアント（http と https — TLS は 1.3 が既定・証明書の鎖は常に検証する〔検証を切る欄は無い〕）。状態は持たない: 方針は呼び手が持つデータ Policy（ゼロ値 = 既定 — 欄はどれも安全な側: 本文の上限つき・期限つき・redirect は 10 回まで追い https → http へは降りない）を `policy:` で渡し、cookie は応答から CookieValue で取り出して次の要求の `cookies:` に自分で載せる。Request は要求 1 本ごとに接続を張って閉じる（Connection: close）。同じ origin への keep-alive は Open の範囲の中の束で

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

方針（省いた欄・nil は既定）: timeout = 要求 1 本の全体の期限 30 秒〔ns・0 以下も既定〕・redirects = 追う回数 10〔0 = 追わない — 3xx をそのまま返す〕・maxBody = 本文の上限 8 MiB〔上限 1 GiB — 無制限は書けない〕・userAgent = "sober"・extraRoots = 焼き込みの WebPKI のルート〔Mozilla NSS — 鎖の leaf にCA/B の規則を掛ける〕に足す起点〔私的 PKI — tls.ParseRoots の値。この起点で止まる鎖には CA/B の規則を掛けない〕・dangerouslyAllowTls12 = TLS 1.2 も申し出る（既定は 1.3 だけ — 1.2 だけのサーバのための緩和。綴りで緩めたことが grep で拾える）・proxy = 通す proxy（ParseProxy の値 — nil = 直結。環境変数は読まない）・proxyAuth = proxy へ渡す Proxy-Authorization の値そのもの（"Basic …" の組み立ては呼び手 — CR / LF / NUL があれば panic(http.BadHeader) — route.sober）

## Cookie

```sober
type Cookie struct {
    name string
    value string
}
```

要求に載せる cookie 1 本（Cookie の頭に `name=value` を `; ` で繋いで載せる。名前が token でない・値に `;` や制御文字があれば panic(http.BadHeader)）

## Response

```sober
type Response struct {
    status int
    headers []http.Field
    body []byte
    url string
}
```

応答（headers の名前は小文字・url = redirect を辿った後の URL）

## Dns

```sober
type Dns error
```

名前の解決の失敗（cause = net.NoHost / net.NonASCIIHost）

## Tls

```sober
type Tls error
```

TLS の失敗（証明書の鎖の検証・相手の alert・record の形の誤り — cause に内側の誤り）

## Timeout

```sober
type Timeout error
```

要求 1 本の期限（Policy の timeout）が過ぎた・相手が応答しない

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

相手が接続を拒んだ・応答の途中で閉じた

## BadUrl

```sober
type BadUrl error
```

URL の形の誤り（scheme が http / https でない・userinfo・IPv6 の番地・空白や制御文字）

## BadResponse

```sober
type BadResponse error
```

応答の形の誤り（状態行・頭・chunked の形・頭の上限 64 KiB 超え）

## Header

```sober
@effects()
func Header(r Response, name string) string?
```

応答の頭の最初の 1 本（名前は大文字小文字を区別しない）

## Request

```sober
@errors(Dns, Tls, Timeout, TooManyRedirects, InsecureRedirect, BodyTooLarge, Closed, BadUrl, BadResponse, ProxyRefused, io.Expired)
@effects(block, io, panic, nondet)
func Request(url string, method string?, headers ([]http.Field)?, body ([]byte)?, cookies ([]Cookie)?, policy Policy?) (Response, error?)
```

url へ要求を送って応答を返す（method の既定 = GET・headers は Host / Content-Length / Transfer-Encoding / Connection を書けない〔std が書く — 書くと panic(http.BadHeader)〕・body があれば Content-Length をつけて送る・cookies は Cookie の頭に載せる・policy の既定 = Policy{}）。redirect を追う — 301 / 302 / 303 は POST を GET に変えて本文を落とす・307 / 308 は保つ・origin が変われば Authorization と Cookie の頭と cookies を落とす。接続は要求ごとに張って閉じる

失敗のラベル: [`Dns`](#dns)・[`Tls`](#tls)・[`Timeout`](#timeout)・[`TooManyRedirects`](#toomanyredirects)・[`InsecureRedirect`](#insecureredirect)・[`BodyTooLarge`](#bodytoolarge)・[`Closed`](#closed)・[`BadUrl`](#badurl)・[`BadResponse`](#badresponse)・[`ProxyRefused`](#proxyrefused)・`io.Expired`

## CookieValue

```sober
@effects()
func CookieValue(r Response, name string) string?
```

応答の Set-Cookie のうち名前が name の最後の 1 本の値（無ければ nil — 属性〔Path・Max-Age …〕は読まない。載せ直すのは呼び手 — `cookies:`）

## ProxyRefused

```sober
type ProxyRefused error {
    status int
}
```

proxy が CONNECT を断った（status = proxy の応答の状態 — 407 は認証の要求）

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

1 つの origin への keep-alive の接続（同一性の型 — Open の k の仮引数としてだけ生まれる。blk = 経路の層の置き場〔link.sober〕・pa / pb = proxy / 行き先の握手の設定・p = Open の policy を読み解いた設定〔束の往復の期限・上限・経路〕）

## Open

```sober
@errors(Dns, Tls, Timeout, Closed, BadUrl, BadResponse, ProxyRefused, io.Expired)
@effects(block, io, panic, nondet)
func Open(at string, k func(s Session), policy Policy?) error?
```

at の origin（"https://host[:port]" — path は見ない）へ接続を張り（proxy があれば proxy を通す）、Session を k に渡す（k が返ったら TLS なら close\_notify を送って閉じる）。policy（既定 = Policy{}）は束の全往復に掛かる。policy の timeout の期限は経路の層を重ねるまで（proxy への TLS・CONNECT・行き先への TLS の握手）— TCP の接続そのものの不達は OS の connect の期限に任せる。k の中の誤りは k の中で受ける（Open が返すのは接続と経路の失敗だけ）

失敗のラベル: [`Dns`](#dns)・[`Tls`](#tls)・[`Timeout`](#timeout)・[`Closed`](#closed)・[`BadUrl`](#badurl)・[`BadResponse`](#badresponse)・[`ProxyRefused`](#proxyrefused)・`io.Expired`

## Send

```sober
@errors(Tls, Timeout, BodyTooLarge, Closed, BadUrl, BadResponse, io.Expired)
@effects(block, io, panic, nondet)
func Send(s Session, url string, method string?, headers ([]http.Field)?, body ([]byte)?, cookies ([]Cookie)?) (Response, error?)
```

s の接続の上で要求を 1 往復（url は "/path" か s と同じ origin の絶対 URL — 別の origin は BadUrl・method / headers / body / cookies は Request と同じ）。redirect は追わない（3xx をそのまま返す — 束は 1 本の接続の往復）。期限・本文の上限は Open の policy。相手が閉じた後・閉じで区切る応答の後・Connection: close の応答の後・途中の失敗の後の Send は Closed（張り直すのは呼び手 — 新しい Open で）

失敗のラベル: [`Tls`](#tls)・[`Timeout`](#timeout)・[`BodyTooLarge`](#bodytoolarge)・[`Closed`](#closed)・[`BadUrl`](#badurl)・[`BadResponse`](#badresponse)・`io.Expired`

## Part

```sober
type Part struct {
    head Response
    chunk []byte
}
```

Stream の生成元の要素（head = 応答の頭〔body は空 — 要素ごとに同じ値〕・chunk = 本文の切片）

## Stream

```sober
@errors(Dns, Tls, Timeout, TooManyRedirects, InsecureRedirect, BodyTooLarge, Closed, BadUrl, BadResponse, ProxyRefused, io.Expired)
@effects(block, io, panic, nondet)
func Stream(url string, k func(p Part), method string?, headers ([]http.Field)?, body ([]byte)?, cookies ([]Cookie)?, policy Policy?) error?
```

url へ要求を送り（method / headers / body / cookies / policy は Request と同じ）、応答の頭と本文の切片を k へ渡す（最初の要素は頭と空の切片で、本文が空でも 1 度は渡る）。redirect は Request と同じ規則で追い、追った応答は k へ渡さない。本文の合計が policy の maxBody を超えたら BodyTooLarge（大きい本文は maxBody で明示的に上げる）

```sober
for part <- http.client.Stream(u)? {
    if part.head.status != 200 { … }
    io.Write(f, part.chunk)?
}
```

失敗のラベル: [`Dns`](#dns)・[`Tls`](#tls)・[`Timeout`](#timeout)・[`TooManyRedirects`](#toomanyredirects)・[`InsecureRedirect`](#insecureredirect)・[`BodyTooLarge`](#bodytoolarge)・[`Closed`](#closed)・[`BadUrl`](#badurl)・[`BadResponse`](#badresponse)・[`ProxyRefused`](#proxyrefused)・`io.Expired`
