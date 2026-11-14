# std/crypto/rsa

日本語

`import "std/crypto/rsa"`

RSA の秘密鍵の読み（PKCS#8 の DER）と RSASSA-PSS（RFC 8017 8.1 — SHA-256・MGF1-SHA256）の署名と検証。TLS 1.3 の CertificateVerify（rsa\_pss\_rsae\_sha256）の本体。

```sober
k := crypto.rsa.ParsePKCS8(der)?
sig := crypto.rsa.SignPSS(k, msg, crypto.Rand(32))?   // saltは呼び手が渡す（決定的な検査のため）
ok := crypto.rsa.VerifyPSS(crypto.rsa.Public(k), msg, sig, 32)
```

署名は CRT（m^dp mod p・m^dq mod q を合わせる）で、出した署名を公開鍵で検証してから返す（CRT の故障攻撃〔Bellcore〕の古典の防御 — 合わなければ crypto.rsa.Fault）。多倍長は 64 bit の limb（bn.sober — 積の上位は組み込み mulhi・montMul は x86 の専用命令の実装）・定数時間の規律は std/crypto の頭の 4 項

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
