# std/crypto/rsa

日本語

`import "std/crypto/rsa"`

RSASSA-PKCS1-v1\_5 の署名（RFC 8017 8.2 — TLS 1.2 の ServerKeyExchange の rsa\_pkcs1\_sha1 / sha256 / sha384）と、TLS 1.2 の RSA 鍵交換の premaster の復号（RFC 5246 7.4.7.1 — Bleichenbacher / ROBOT の対策: 形の検査を分岐なしで畳み、外れたら呼び手が渡した乱数に定数時間で差し替える。失敗を呼び手にも相手にも区別させない）。どちらも std/tls の dangerouslyAllowTls12 の道だけ

## ParsePKCS8

```sober
@errors(BadKey)
@effects(!io, !block, !nondet)
func ParsePKCS8(der []byte) (PrivateKey, error?)
```

PKCS#8 の DER（PEM の中身を base64 で戻したもの）の RSA の秘密鍵

失敗のラベル: [`BadKey`](#badkey)

対の `FormatPKCS8` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## NewPublic

```sober
@errors(BadKey)
@effects(!io, !block, !nondet)
func NewPublic(nb []byte, eb []byte) (PublicKey, error?)
```

大きい端のバイト列のnとeの公開鍵（検証に使うAPI）

失敗のラベル: [`BadKey`](#badkey)

## HashSha1

```sober
const HashSha1 = 1
```

署名のハッシュの種類（DigestInfo の前置き — RFC 8017 9.2 の注 1）

## HashSha256

```sober
const HashSha256 = 2
```

署名のハッシュの種類（DigestInfo の前置き — RFC 8017 9.2 の注 1）

## HashSha384

```sober
const HashSha384 = 3
```

署名のハッシュの種類（DigestInfo の前置き — RFC 8017 9.2 の注 1）

## SignPKCS1v15

```sober
@errors(BadSize, Fault)
@bless
@effects(!io, !block, !nondet)
func SignPKCS1v15(k PrivateKey, hash int, digest []byte) ([]byte, error?)
```

digest（hash の値 — SHA-1 は 20・SHA-256 は 32・SHA-384 は 48 バイト）の RSASSA-PKCS1-v1\_5 の署名（k バイト）

失敗のラベル: [`BadSize`](#badsize)・[`Fault`](#fault)

## DecryptPremaster

```sober
@effects(!io, !block, !nondet)
func DecryptPremaster(k PrivateKey, ct []byte, ver []byte, fallback []byte) []byte
```

TLS 1.2 の RSA 鍵交換の premaster（48 バイト）。ct = EncryptedPreMasterSecret の中身・ver = ClientHello の client\_version（2 バイト）・fallback = 呼び手が先に作った 48 バイトの乱数。形（0x00 0x02 ‖ 0 を含まない埋め草 ‖ 0x00 ‖ 48 バイト・先頭 2 バイトが ver）が合わなければ fallback を返す。形の検査・版の照合・差し替えは秘密の値に依る分岐を持たない（全部を OR で畳んで最後に 1 回の mask で選ぶ）。長さの違う ct は公開の誤りとして fallback を返す

## PublicKey

```sober
type PublicKey struct {
    n []int
    e []int
    k int
    bits int
    mt mont
}
```

法 n と公開の指数 e（limb の列）・k = n のバイト長・bits = n のビット長・mt = n の Montgomery の文脈（鍵を読むときに 1 回）

## PrivateKey

```sober
type PrivateKey struct {
    pub PublicKey
    mp mont @secret
    mq mont @secret
    dp []int @secret
    dq []int @secret
    qinv []int @secret
    pbits int
    qbits int
}
```

RSAPrivateKey の成分（RFC 8017 A.1.2 — d は使わない・CRT の p, q〔の Montgomery の文脈 mp, mq〕, dp, dq, qinv）

フィールド:

- `pbits` — p, q の bit 長（鍵の大きさ — 公開の値。CRT の冪の回数。秘密の素数そのものから毎回数えない）

## BadKey

```sober
type BadKey error
```

鍵の DER の形が違う（PKCS#8 の RSA でない・長さが合わない）

## Fault

```sober
type Fault error
```

署名の自己検証が合わなかった（計算の故障 — 署名を捨てた）

## BadSize

```sober
type BadSize error
```

salt の長さや鍵の大きさが PSS に足りない

## Public

```sober
@bless
@effects(!io, !block, !nondet)
func Public(k PrivateKey) PublicKey
```

k の公開鍵

## Size

```sober
@effects(!io, !block, !nondet)
func Size(pub PublicKey) int
```

pub の法のバイト長（署名の長さ）

## SignPSS

```sober
@errors(BadSize, Fault)
@bless
@effects(!io, !block, !nondet)
func SignPSS(k PrivateKey, msg []byte, salt []byte) ([]byte, error?)
```

msg の RSASSA-PSS の署名（k バイト）。salt の長さが PSS の salt 長（通常は crypto.Rand(32) — ハッシュ〔SHA-256〕と同じ長さの乱数。検証の VerifyPSS の sLen に同じ長さを渡す）

失敗のラベル: [`BadSize`](#badsize)・[`Fault`](#fault)

## VerifyPSS

```sober
@effects(!io, !block, !nondet)
func VerifyPSS(pub PublicKey, msg []byte, sig []byte, sLen int) bool
```

sig が pub で msg の RSASSA-PSS の署名（salt 長 sLen）か
