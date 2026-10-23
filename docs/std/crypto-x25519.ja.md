# std/crypto/x25519

日本語

`import "std/crypto/x25519"`

X25519（RFC 7748 5 節 — Curve25519 の Montgomery ladder）。

```sober
pub := x25519.Base(priv)              // 公開鍵（32 バイト）
shared := x25519.Shared(priv, peer)    // 共有値（32 バイト — 全 0 の検査〔低位数の点〕は呼び手 = TLS 7.4.2 の側）
```

定数時間: 秘密（鍵のビット・体の元）に依る分岐・添字は無い — ladder の入れ替えは mask の xor（cswap）・ループは 255 段固定・逆元は p - 2 乗（指数は公開）

## Base

```sober
@secret(k)
@bless
func Base(k []byte) []byte
```

秘密鍵 k（32 バイト — 短ければ添字の境界の panic・長い分は読まない）の公開鍵 = k × 9

## Shared

```sober
@secret(k)
func Shared(k []byte, u []byte) []byte
```

秘密鍵 k（32 バイト — 内部で RFC 7748 の clamp を掛ける）と相手の u 座標（32 バイト — 最上位のビットは無視）の X25519。k・u が 32 バイトより短ければ添字の境界の panic（長い分は読まない）。u が低位数の点なら結果は全 0 — 全 0 を拒否する検査は呼び手がする（RFC 7748 6.1・TLS 1.3 は RFC 9846 7.4.2）
