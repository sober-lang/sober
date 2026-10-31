# std/rand

日本語

`import "std/rand"`

シードを明示する決定的な擬似乱数 Rand（暗号用途には使わない — 鍵は crypto.Rand）

## Rand

```sober
type Rand struct {
    s0 int
    s1 int
    s2 int
    s3 int
}
```

シードを明示する決定的な擬似乱数（`xoshiro128**` — Blackman / Vigna。状態 128 bit・出力 32 bit）。グローバルな乱数の状態は持たない — 乱数が要る関数は Rand を mut 引数で受ける（非決定は入力のシードに外出し: 同じシードなら同じ列。失敗の再現はシード 1 つで足りる — PBT・差分ファジングの第一顧客）。

```sober
mut r := rand.New(42)
x := rand.Intn(mut r, 10)   // 0..9
```

算術は全部 32 bit の値の上で閉じる（各語は [0, 2^32)・積は小さい定数か 16 bit の桁どうし）— int の 64 bit の溢れに触れない（溢れの意味論は Lean の約束〔値が 64 bit に収まる限り一致 — formal.md〕の外なので、64 bit の積を使う SplitMix64 / PCG は採らない）。シードの拡散は SplitMix32（Murmur3 の fmix32 の定数 — 積は 16 bit の桁に割る mul32）。暗号用途には使わない

## New

```sober
@effects()
func New(seed int) Rand
```

シード seed（任意の int — 負でもよい）の Rand。状態の 4 語を SplitMix32 で埋める（下位 32 bit を数え上げ、上位 32 bit を 2 語目と 4 語目に混ぜる — 違うシードは違う状態になる。全部 0 にはしない）

## Next

```sober
@effects()
func Next(r mut Rand) int
```

次の 32 bit の値（[0, 2^32)）

## Int62

```sober
@effects()
func Int62(r mut Rand) int
```

[0, 2^62) の値（Next 2 回 — 上位 30 bit + 下位 32 bit）

## NonPositiveBound

```sober
type NonPositiveBound panic {
    n int
}
```

Intn の上限 n が 1 未満（呼び手の契約違反 — panic ラベル。[language.md 27 節](../language.md)）

## Intn

```sober
@effects(panic)
func Intn(r mut Rand, n int) int
```

[0, n) の値（n は 1 以上 — 0 以下は panic(NonPositiveBound{n})）。偏りなし（棄却法: n の倍数に収まる範囲の値だけ使う）

## Bool

```sober
@effects()
func Bool(r mut Rand) bool
```

真偽を 1 つ

## Split

```sober
@effects()
func Split(r mut Rand) Rand
```

r から独立した列の Rand を作る（r も 1 歩進む — ジェネレータの部分木に別のシードを配る用途）
