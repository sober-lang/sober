# std/tls

日本語

`import "std/tls"`

TLS 1.3 のサーバ（RFC 9846 — X25519・AES-128-GCM / ChaCha20-Poly1305・RSA-PSS の証明書・resumption / 0-RTT なし）。tls.Serve(addr, cfg, k) が net.Serve を包み、handshake が済んだ接続だけを k に渡す（handshake 中の接続を利用者に触らせない）。tls.Conn は net.Conn と同じ顔の同一性の型（写せない・外へ出せない・give: で渡せない）で、tls.Recv / tls.Send が net.Recv / net.Send と同じ形。net.Conn と顔が違う唯一の点: tls.Recv を break で途中で抜けると、その接続の読みは終わる（次の tls.Recv は Closed — 切片に残った record を持ち越さない）。誤りは粗い 3 ラベル（HandshakeFailed〔alert の種は欄〕・BadRecord・Closed）

## HandshakeFailed

```sober
type HandshakeFailed error {
    alert int
}
```

handshake が失敗した（alert = 送った alert の番号 — RFC 9846 6）

## BadRecord

```sober
type BadRecord error
```

受けた record が壊れている（改竄・形の誤り・想定外のメッセージ — 相手へ alert を送って閉じた）

## Closed

```sober
type Closed error
```

接続が閉じている（相手の切断・相手の alert・転送路の失敗・途中で抜けた後の Recv）

## Config

```sober
type Config struct {
    chain [][]byte
    key rsa.PrivateKey
    alpn []string
}
```

サーバの設定（Load / Parse が作る — 証明書の鎖・葉の鍵・受ける ALPN）

## Conn

```sober
type Conn struct {
    c net.Conn
    blk []int
    seal tlsSeal
}
```

handshake の済んだ接続（同一性の型 — net.Conn と同じ規則。tls.Serve の k の仮引数としてだけ生まれる）

## Handler

```sober
type Handler func(c Conn) error?
```

handshake の済んだ接続 1 本の処理（名前つきの関数型 — 値として接続の task へ渡る。[language.md 14 節](../language.md): 公開境界の関数型は名前つき）

## Parse

```sober
@errors(pem.Bad, rsa.BadKey)
func Parse(certPem string, keyPem string) (Config, error?)
```

PEM の証明書の鎖（CERTIFICATE が 1 つ以上 — 葉が先頭）と PKCS#8 の RSA の鍵の Config（ALPN の既定 = http/1.1 — 変えるなら Alpn）

失敗のラベル: `pem.Bad`・`rsa.BadKey`

## Alpn

```sober
func Alpn(cfg Config, alpn []string) Config
```

受ける ALPN をサーバの好みの順 alpn に替えた Config（空 = ALPN を使わない。相手の申し出と重ならなければ no\_application\_protocol — RFC 7301）

## Load

```sober
@errors(pem.Bad, rsa.BadKey, strings.InvalidUtf8, io.NotFound, io.Denied, io.Other, io.Timeout, io.Expired)
func Load(certPath string, keyPath string) (Config, error?)
```

Parse のファイル版（certPath / keyPath を読む）

失敗のラベル: `pem.Bad`・`rsa.BadKey`・`strings.InvalidUtf8`・`io.NotFound`・`io.Denied`・`io.Other`・`io.Timeout`・`io.Expired`

## Serve

```sober
@errors(net.Bad, io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
func Serve(addr string, cfg Config, k Handler) error?
```

addr で待ち受け、接続ごとに handshake を済ませてから k を走らせる（接続 1 本 = task 1 本 — net.Serve と同じ admission・k の失敗と死は吸収）。handshake の失敗は alert を送って閉じ、k は呼ばない。k が返ったら（error を返しても）close\_notify を送って閉じる。k が死んだときは close\_notify を送らずに閉じる

失敗のラベル: `net.Bad`・`io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Overflow

```sober
type Overflow panic
```

方向の語の列が席に入らない（std の内部の約束違反 — panic ラベル）

## Recv

```sober
@errors(BadRecord, Closed)
func Recv(c Conn, k func([]byte)) error?
```

c の受けた application の平文を k に順に渡す（呼び出し形の生成元 — `for b <- tls.Recv(c)? { … }`）。相手の close\_notify で nil。受けの表は hs.Feed の Connected の枝が持つ（受けの方向 rd から作った Hs に枠を 1 つずつ hs.Step〔mut なしの入口 — 表は Feed と共有〕で通す — 表を 1 か所に）。受けた KeyUpdate は受けの鍵を進め、update\_requested なら次の Send が先に自分の KeyUpdate を送る。改竄・形の誤り・想定外は alert を送って BadRecord。1 つの接続で 1 度だけ回せる（break で途中で抜けた後・2 度目は Closed）

失敗のラベル: [`BadRecord`](#badrecord)・[`Closed`](#closed)

## Send

```sober
@errors(Closed)
func Send(c Conn, b []byte) error?
```

b を application の record にして c へ送る（空の b は送らない）。相手の KeyUpdate の要求・AES-GCM の使用上限の手前なら、先に自分の KeyUpdate を送って鍵を進める

失敗のラベル: [`Closed`](#closed)
