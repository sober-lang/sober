# std/env

日本語

`import "std/env"`

環境変数の宣言の表: プログラムが読む環境変数を const の表で宣言し（StrVar・IntVar・BoolVar・Table）、Load が入場で 1 回だけ全部を読んで検査し、凍った値の表（Values）を返す。値は宣言の const を把手にして引く（Str・StrOpt・Int・IntOpt・Bool — 綴りの誤りはコンパイルで落ち、値の型は把手の型で決まる）。表面は表に全部ある（Spec — 表の JSON）。値の規則: 空の値（`NAME=`）は無いのと同じ・真偽は `1` / `true` が真・`0` / `false` / 無い が偽・それ以外は BadValue。例: examples/env\_table.sober

## StrVar

```sober
type StrVar struct {
    name string
    help string
    def string?
    opt bool
    dev bool
}
```

文字列の環境変数。def は無いときの値。def も値も無いときは、opt なら StrOpt が nil を返し、opt でなければ Load が Missing で落とす。dev は開発の口（文書の印 — 読みは同じ）

## IntVar

```sober
type IntVar struct {
    name string
    help string
    def int?
    min int?
    max int?
    opt bool
    dev bool
}
```

整数の環境変数（10 進）。min / max は両端を含む範囲。他の欄は StrVar と同じ

## BoolVar

```sober
type BoolVar struct {
    name string
    help string
    dev bool
}
```

真偽の環境変数（無ければ偽）

## Table

```sober
type Table struct {
    strs []StrVar
    ints []IntVar
    bools []BoolVar
}
```

プログラムが読む環境変数の表（Load の入口）

## Values

```sober
type Values struct {
    sn []string
    sv []string
    sh []bool
    inames []string
    iv []int
    ih []bool
    bn []string
    bv []bool
    seal sealed
}
```

読んだ値の表。作れるのは Load / Parse だけ（非公開の型の封の欄）。値は把手で引く

## Missing

```sober
type Missing error {
    name string
}
```

opt でも def つきでもない変数が無い

## BadValue

```sober
type BadValue error {
    name string
    word string
    want string
}
```

値が受けられない（want = 受ける値の説明 — `an integer`・`an integer in 1..65535`・`1, true, 0 or false`）

## InvalidUtf8

```sober
type InvalidUtf8 error {
    name string
}
```

値が不正な UTF-8

## Undeclared

```sober
type Undeclared panic {
    name string
    why string
}
```

引いた把手が表に無い・値の無いことがある把手を値の要る引き（Str・Int）で引いた

## Misdeclared

```sober
type Misdeclared panic {
    name string
    why string
}
```

表の宣言の誤り（同じ名前の 2 回の宣言・def と opt の併記・空の名前）

## Load

```sober
@errors(Missing, BadValue, InvalidUtf8)
@effects(io, panic)
func Load(t Table) (Values, error?)
```

t の変数を全部プロセスの環境から読んで検査する（誤りは宣言の順で最初の 1 つ）。入場（main の頭）で 1 回呼んで、値の表を渡して使う

失敗のラベル: [`Missing`](#missing)・[`BadValue`](#badvalue)・[`InvalidUtf8`](#invalidutf8)

## Parse

```sober
@errors(Missing, BadValue)
@effects(panic)
func Parse(t Table, pairs []string) (Values, error?)
```

t の変数を pairs（`NAME=value` の列 — environ と同じ形・同名は最初の 1 つ）から読んで検査する（Load の中身 — テストと再現の口）

失敗のラベル: [`Missing`](#missing)・[`BadValue`](#badvalue)

## Format

```sober
@effects()
func Format(e error) string
```

Load / Parse の誤り e の文面（1〜2 行 — 最後は改行）

## Str

```sober
@effects(panic)
func Str(v Values, h StrVar) string
```

v の値（値・def のどちらも無い opt の変数は panic — StrOpt で引く）

## StrOpt

```sober
@effects(panic)
func StrOpt(v Values, h StrVar) string?
```

v の値（無ければ nil）

## Int

```sober
@effects(panic)
func Int(v Values, h IntVar) int
```

v の値（Str と同じ規則 — 無い opt の変数は panic — IntOpt で引く）

## IntOpt

```sober
@effects(panic)
func IntOpt(v Values, h IntVar) int?
```

v の値（無ければ nil）

## Bool

```sober
@effects(panic)
func Bool(v Values, h BoolVar) bool
```

v の値

## Spec

```sober
@effects()
func Spec(t Table) string
```

t の表の JSON（空白なし・宣言の順。変数は種類つきの 1 本の列 — kind = string / int / bool）
