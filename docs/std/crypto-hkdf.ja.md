# std/crypto/hkdf

日本語

`import "std/crypto/hkdf"`

HKDF-SHA256（RFC 5869）。TLS 1.3 の HKDF-Expand-Label は std/tls の側（ラベルの綴りは TLS の約束）

```sober
prk := hkdf.Extract(salt, ikm)
okm := hkdf.Expand(prk, info, 42)?   // 255 × 32 バイトを超える長さは hkdf.TooLong
```

## Extract

```sober
@secret(ikm)
func Extract(salt []byte, ikm []byte) []byte
```

PRK = HMAC-SHA256(salt, ikm)（salt が空なら 32 バイトの 0 — RFC 5869 2.2）

## TooLong

```sober
type TooLong error
```

Expand の長さが RFC の上限（255 × 32 バイト）を超えた（または負）

## Expand

```sober
@errors(TooLong)
@secret(prk)
func Expand(prk []byte, info []byte, n int) ([]byte, error?)
```

OKM の先頭 n バイト（T(i) = HMAC(prk, T(i-1) ++ info ++ i) を繋ぐ — RFC 5869 2.3）。n が 255 × 32 を超えれば TooLong（RFC の上限）

失敗のラベル: [`TooLong`](#toolong)
