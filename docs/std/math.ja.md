# std/math

日本語

`import "std/math"`

float の数学（[language.md 37 節](../language.md)）: 基本演算で書けないものだけを組み込みで（sqrtsd・ビット列の読み替え）。超越関数（Sin・Exp・Log 等）は入れない — libm は実装・環境で最後のビットが割れる（決定性）。要るときは std で自前に書き、オラクルとの差分で守る

## Sqrt

```sober
@effects()
func Sqrt(x float) float
```

x の平方根（IEEE 754 の sqrt — 正しく丸めた値・負は NaN・-0 は -0）

## Abs

```sober
@effects()
func Abs(x float) float
```

x の絶対値（符号ビットを落とす — NaN の符号も落ちる・-0 は +0）

## Bits

```sober
@effects()
func Bits(x float) int
```

x の IEEE 754 のビット列（i64 で読んだ値 — 変換でなく同じビットの読み替え）

## FromBits

```sober
@effects()
func FromBits(b int) float
```

ビット列 b の float（±Inf・NaN もこれで作る）

## Trunc

```sober
@effects()
func Trunc(x float) float
```

x の 0 方向への切り捨て（整数部 — 小数部のビットを落とす。±Inf・NaN・|x| ≥ 2^52 はそのまま・|x| \< 1 は符号を残した 0）

## Floor

```sober
@effects()
func Floor(x float) float
```

x 以下の最大の整数（-0.5 → -1・-0 → -0・±Inf・NaN はそのまま）

## Ceil

```sober
@effects()
func Ceil(x float) float
```

x 以上の最小の整数（-0.5 → -0・±Inf・NaN はそのまま）

## Min

```sober
@effects()
func Min(x float, y float) float
```

x と y の小さいほう（どちらかが NaN ならその NaN・-0 と +0 では -0）

## Max

```sober
@effects()
func Max(x float, y float) float
```

x と y の大きいほう（どちらかが NaN ならその NaN・-0 と +0 では +0）
