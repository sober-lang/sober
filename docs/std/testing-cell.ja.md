# std/testing/cell

日本語

`import "std/testing/cell"`

テストの構成（`_test.sober`・`_double.sober`）の状態の格納場所（[language.md 41 節](../language.md)「状態を貯めるfake」）。把手はconstの宣言だけが作り（`const Rows = testing.cell.Cell[[]Row]{}`・初期値は `init:`）、値はプロセスに1つの格納場所にコピーして持つ。Get / Set / Updateの呼び出しはcompilerが呼び出し点で格納場所の読み書きに変換する（下の本体は使われない）

## Cell

```sober
type Cell[T] struct {
    key int
    init T
}
```

格納場所の把手（keyはloaderがconstの宣言ごとに振る — 書かない）

## Get

```sober
@effects(io, nondet)
func Get[T](h Cell[T]) T
```

格納場所の今の値（一度もSetしていなければinit — 書いていなければTのゼロ値）

## Set

```sober
@effects(io)
func Set[T](h Cell[T], v T)
```

格納場所の値をvにする

## Update

```sober
@effects(io)
func Update[T](h Cell[T], f func(T) T)
```

格納場所の値をf(今の値) にする（読みと書きの間に他のtaskの書きが挟まらない）。fはラムダのリテラルでエフェクトなし — 格納場所のロックを持ったまま走る
