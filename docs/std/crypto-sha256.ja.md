# std/crypto/sha256

日本語

`import "std/crypto/sha256"`

SHA-256（FIPS 180-4）のインクリメンタル API。状態 State は値（写せば途中の値の写し — TLS の transcript hash は同じ状態から何度も Sum を取る）:

```sober
mut s := sha256.New()
sha256.Write(mut s, a)
h1 := sha256.Sum(s)        // a の値（s は変わらない）
sha256.Write(mut s, b)
h2 := sha256.Sum(s)        // a ++ b の値
```

ワンショット API は Sum256（std/hash の hash.Sha256 はこれを呼ぶ）。算術は全部 32 bit の語（[0, 2^32)）の上で閉じる — 和は 5 項まで（2^35 未満）を足してから mask32 で畳み、回転は shift 2 回 + or。積を使わないので int の 64 bit の溢れに触れない。データに依る分岐・添字は無い（定数時間 — HMAC の鍵を通してよい）

## Size

```sober
const Size = 32
```

長さの定数（バイト）

値の長さ

## BlockSize

```sober
const BlockSize = 64
```

長さの定数（バイト）

1 ブロックの長さ

## State

```sober
type State struct {
    h []int
    tail []byte
    n int
}
```

途中の状態（h = 8 語の連鎖値・tail = まだ畳んでいない 64 バイト未満の端・n = これまでに書いた長さ）

## New

```sober
func New() State
```

空の入力の状態

## Write

```sober
func Write(s mut State, data []byte)
```

data を続けて書く（64 バイトのブロックが揃った分だけ畳み、端は tail に残す）

対の `Read` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## Sum

```sober
func Sum(s State) []byte
```

s に書いた全体の値（32 バイト）。s は変えない（末尾の詰め = 端 + 0x80 + 0 埋め + ビット長〔64 bit big endian〕を写しの上で畳む）

## Sum256

```sober
func Sum256(data []byte) []byte
```

data の SHA-256 の値（ワンショット API）
