# std/convert

日本語

`import "std/convert"`

数値と文字列の変換（[language.md 37 節](../language.md)・[language.md 34 節](../language.md)の Format… / Parse…）。float の最短の往復表現と正しく丸めた解析の公開の API — 中身は std/internal/floatfmt（整数だけの多倍長・float の字句を含まない内部の算法）。int の 10 進表記 FormatInt は文字列補間の裏方（parser の合成の暗黙 import）。int の解析（ParseInt）もここ

## FormatFloat

```sober
func FormatFloat(f float) string
```

f の最短の往復表現（読み戻すと同じビットになる最短の 10 進 — Go の strconv.FormatFloat(f, 'g', -1, 64) と同じ綴り・println と同じ）

## FormatFixed

```sober
func FormatFixed(f float, prec int) string
```

f を小数点以下 prec 桁で（Go の strconv.FormatFloat(f, 'f', prec, 64)・fmt の %.\<prec>f と同じ綴り — 正確な値を最近接・偶数へ丸める）

対の `ParseFixed` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## InvalidFloat

```sober
type InvalidFloat error
```

ParseFloat の構文の違い（10 進の数字・小数点・指数、または inf / infinity / nan でない）

## FloatOutOfRange

```sober
type FloatOutOfRange error
```

ParseFloat の溢れ（値は ±Inf — Go の ErrRange と同じ）

## ParseFloat

```sober
@errors(InvalidFloat, FloatOutOfRange)
func ParseFloat(s string) (float, error?)
```

s の値（10 進の正確な値を 1 回だけ最近接・偶数へ丸める — 浮動小数のリテラルと同じ算法。0 に丸まる小さい値は誤りでない）。受ける形は [+-]? 数字の列（小数点 1 つ・指数 e / E [+-] 数字）か inf / infinity（符号可）/ nan（大文字小文字を問わない）。16 進・\_ は受けない

失敗のラベル: [`InvalidFloat`](#invalidfloat)・[`FloatOutOfRange`](#floatoutofrange)

## InvalidInt

```sober
type InvalidInt error
```

ParseInt の構文の違い（[+-]? と 10 進の数字の列でない — 空・空白・\_・16 進は受けない）

## IntOutOfRange

```sober
type IntOutOfRange error
```

ParseInt の溢れ（int〔64 ビット〕の範囲の外 — Go の ErrRange と同じ。値は 0）

## ParseInt

```sober
@errors(InvalidInt, IntOutOfRange)
func ParseInt(s string) (int, error?)
```

s の 10 進の値（Go の strconv.Atoi と同じ受け方 — `[+-]? 数字+`）

失敗のラベル: [`InvalidInt`](#invalidint)・[`IntOutOfRange`](#intoutofrange)

## FormatInt

```sober
func FormatInt(n int) string
```

n の 10 進表記（Go の strconv.Itoa と同じ — ParseInt の対）。文字列補間 `${n}` の int の変換もこれ（parser の合成の暗黙 import $convert — コアに変換 op を足さない）。最小値は符号反転が溢れるので綴りをそのまま返す
