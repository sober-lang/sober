# std/tls

日本語

`import "std/tls"`

TLS 1.3 のサーバ（RFC 9846 — X25519・AES-128-GCM / ChaCha20-Poly1305・RSA-PSS の証明書・resumption / 0-RTT なし）。tls.Serve(addr, cfg, k) が net.Serve を包み、handshake が済んだ接続だけを k に渡す（handshake 中の接続を利用者に触らせない）。kへ渡す接続はTLSの状態を持つnet.Conn（net.Recv / net.Send / net.Put / net.Flushが暗号化して読み書きする — 平文の接続と同じ関数・同じ規則。breakで抜けた後も、次のnet.Recvが続きを読む）。受けの誤りはnetのラベル（相手のfatal alert・閉じた後 = io.Closed・壊れたrecord = io.Other{errno: 71}）。handshakeの誤り（HandshakeFailed〔alertの種はフィールド〕・Closed）はServeの中で吸収する（alertを送って閉じ、kは呼ばない）。信頼の起点の値 Roots（ParseRoots が作る — 私的 PKI の CA を足すとき std/http/client の Policy の extraRoots: に渡す）もここに住む

## HandshakeFailed

```sober
type HandshakeFailed error {
    alert int
}
```

handshake が失敗した（alert = 送った alert の番号 — RFC 9846 6）

## Closed

```sober
type Closed error
```

handshakeの途中で接続が閉じた（相手の切断・転送路の失敗）

## Config

```sober
type Config struct {
    chain [][]byte
    key crypto.rsa.PrivateKey
    ec []byte
    alpn []string
    allow12 bool
}
```

サーバの設定（Load / Parseが作る — 証明書のチェーン・葉の鍵・受けるALPN）

フィールド:

- `ec` — 葉の鍵が P-256 の ECDSA ならそのスカラー（空 = key の RSA）

## Roots

```sober
type Roots struct {
    certs []internal.x509.Cert
    seal rootsSeal
}
```

足す信頼の起点（ParseRoots が作る — 封の型。中身は読めた CERTIFICATE の列）

## BadRoots

```sober
type BadRoots error
```

ParseRootsのPEMが読めない（CERTIFICATEのチャンクが無い・チャンクのDERが証明書の形でない）

## Handler

```sober
type Handler func(c net.Conn) error?
```

handshake の済んだ接続 1 本の処理（名前つきの関数型 — 値として接続の task へ渡る。[language.md 14 節](../language.md): 公開境界の関数型は名前つき）。接続はTLSの状態を持つnet.Conn（net.Recv / net.Send / net.Put / net.Flushが暗号化して読み書きする）

## Parse

```sober
@errors(crypto.pem.Bad, crypto.rsa.BadKey)
@effects()
func Parse(certPem string, keyPem string) (Config, error?)
```

PEMの証明書のチェーン（CERTIFICATEが1つ以上 — 葉が先頭）とPKCS#8の鍵のConfig（ALPNの既定 = http/1.1 — 変えるならAlpn）。鍵は RSA か P-256 の ECDSA で、種類から署名とTLS 1.2のスイートの集合が決まる（ECDSA の鍵 = ECDHE-ECDSA のスイート・ecdsa\_secp256r1\_sha256）。どちらとしても読めなければ crypto.rsa.BadKey

失敗のラベル: `crypto.pem.Bad`・`crypto.rsa.BadKey`

## ParseRoots

```sober
@errors(BadRoots)
@effects()
func ParseRoots(pem string) (Roots, error?)
```

PEMの文字列pemのCERTIFICATEのチャンクを全部読んだ信頼の起点（私的PKIのCA — 外部ファイルを読むインターフェースは作らない。読めないチャンクが1つでもあればBadRoots）

失敗のラベル: [`BadRoots`](#badroots)

## Alpn

```sober
@effects()
func Alpn(cfg Config, alpn []string) Config
```

受ける ALPN をサーバの好みの順 alpn に替えた Config（空 = ALPN を使わない。相手の申し出と重ならなければ no\_application\_protocol — RFC 7301）

## DangerouslyAllowTls12

```sober
@effects()
func DangerouslyAllowTls12(cfg Config) Config
```

TLS 1.2 のクライアントも受ける Config（既定は 1.3 だけ）。古いクライアント（Windows 7 / 8.1 の IE 11・古い Safari・Java 7 / 8・Android 4.4 ほか）を繋ぐための opt-in で、1.3 を申し出る相手は今までどおり 1.3。1.2 の道は CBC（MAC-then-encrypt）と RSA 鍵交換（前方秘匿なし）のスイートを含む — 知られた攻撃の面は定数時間の処理・暗黙の拒否・降格の番兵で塞ぐが、1.3 だけの既定より危うい面を持つことを、綴りの dangerously で呼び手に引き受けさせる。ALPN で h2 に決まった接続は ECDHE + AEAD のスイートだけ。再開・再交渉・圧縮・SSL 3.0〜TLS 1.1 は持たない

## Load

```sober
@errors(crypto.pem.Bad, crypto.rsa.BadKey, strings.BadUtf8, io.NotFound, io.Denied, io.Other, io.Timeout, io.Expired)
@effects(io, nondet)
func Load(certPath string, keyPath string) (Config, error?)
```

Parse のファイル版（certPath / keyPath を読む）

失敗のラベル: `crypto.pem.Bad`・`crypto.rsa.BadKey`・`strings.BadUtf8`・`io.NotFound`・`io.Denied`・`io.Other`・`io.Timeout`・`io.Expired`

## Serve

```sober
@errors(net.Bad, io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, panic, nondet, Handler)
func Serve(addr string, cfg Config, k Handler, budget int?, conns int?, reject string?, region int?, headWait int?) error?
```

addr で待ち受け、接続ごとに handshake を済ませてから k を走らせる（接続 1 本 = task 1 本 — net.Serve と同じ admission・k の失敗と死は吸収）。handshake の失敗は alert を送って閉じ、k は呼ばない。k が返ったら（error を返しても）close\_notify を送って閉じる。k が死んだときは close\_notify を送らずに閉じるconns・reject・regionはnet.Serveへそのまま（意味も既定もnet.Serveと同じ）。budgetは接続1本の宣言（既定 64 KiB）にwaitStackを足してnet.Serveへ渡す。headWait = 接続を受けてからhandshakeが済むまでの上限（task.MS・既定30秒・0以下は開いた時点で期限切れ）。期限が来たら何も送らずに閉じ、kは呼ばない。kの中のhttp.server.ServeConnは、入った時刻から自分のheadWait: を数える（handshakeの分は数えない）

失敗のラベル: `net.Bad`・`io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Overflow

```sober
type Overflow panic
```

方向のワードの列が席に入らない（stdの内部の約束違反 — panicラベル）

## Protocol

```sober
@effects()
func Protocol(c net.Conn) string
```

cのALPNで決まったプロトコル（"h2"・"http/1.1"。申し出が無い・合わなかった・平文の接続は ""）
