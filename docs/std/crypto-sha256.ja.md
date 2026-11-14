# std/crypto/sha256

日本語

`import "std/crypto/sha256"`

SHA-256（FIPS 180-4）のインクリメンタル API。状態Stateは値（コピーすれば途中の値のコピー — TLSの transcript hash は同じ状態から何度もSumを取る）:

```sober
mut s := crypto.sha256.New()
crypto.sha256.Write(mut s, a)
h1 := crypto.sha256.Sum(s)        // a の値（s は変わらない）
crypto.sha256.Write(mut s, b)
h2 := crypto.sha256.Sum(s)        // a ++ b の値
```

ワンショットAPIはSum256（std/hashのhash.Sha256はこれを呼ぶ）。算術は全部32 bitのワード（[0, 2^32)）の上で閉じる — 和は5項まで（2^35未満）を足してから mask32 で畳み、回転は shift 2 回 + or。積を使わないので int の 64 bit の溢れに触れない。データに依る分岐・添字は無い（定数時間 — HMAC の鍵を通してよい）

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

途中の状態（h = 8ワードの連鎖値・tail = まだ畳んでいない64バイト未満の端・n = これまでに書いた長さ）

## New

```sober
@effects()
func New() State
```

空の入力の状態

## Write

```sober
@effects()
func Write(s mut State, data []byte)
```

data を続けて書く（64 バイトのブロックが揃った分だけ畳み、端は tail に残す）

対の `Read` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## Sum

```sober
@effects()
func Sum(s State) []byte
```

sに書いた全体の値（32バイト）。sは変えない（末尾の詰め = 端 + 0x80 + 0埋め + ビット長〔64 bit big endian〕をコピーの上で畳む）

## Sum256

```sober
@effects()
func Sum256(data []byte) []byte
```

data の SHA-256 の値（ワンショット API）
