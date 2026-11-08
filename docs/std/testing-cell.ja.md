# std/testing/cell

日本語

`import "std/testing/cell"`

テストの構成（`_test.sober`・`_double.sober`）の状態の置き場（[language.md 41 節](../language.md)「状態を貯める fake」）。把手は const の宣言だけが作り（`const Rows = testing.cell.Cell[[]Row]{}`・初期値は `init:`）、値はプロセスに 1 つの置き場に写して持つ。Get / Set / Update の呼び出しは compiler が呼び出し点で置き場の読み書きに写す（下の本体は使われない）

## Cell

```sober
type Cell[T] struct {
    key int
    init T
}
```

置き場の把手（key は loader が const の宣言ごとに振る — 書かない）

## Get

```sober
@effects(io, nondet)
func Get[T](h Cell[T]) T
```

置き場の今の値（一度も Set していなければ init — 書いていなければ T のゼロ値）

## Set

```sober
@effects(io)
func Set[T](h Cell[T], v T)
```

置き場の値を v にする

## Update

```sober
@effects(io)
func Update[T](h Cell[T], f func(T) T)
```

置き場の値を f(今の値) にする（読みと書きの間に他の task の書きが挟まらない）。f はラムダのリテラルで効果なし — 置き場のロックを持ったまま走る
