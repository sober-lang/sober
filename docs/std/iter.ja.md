# std/iter

日本語

`import "std/iter"`

push 型の生産者 Iter[T] と、for 式の生成元（Slice・Range）・消費（Each・Count・Sum）

## Iter

```sober
type Iter[T] func(func(T))
```

push 型の生産者（Go 1.23 の iter.Seq と同形 — [language.md 7 節](../language.md)）。変数に入れず、`Iter[T]` の仮引数の位置で消費する（呼び出し点で展開する）。for 式 `for x <- xs if g yield e` はこの型の引数になる: `iter.Sum(for …)`・`for v <- xs if v % 2 == 0 yield v |> iter.Sum`

例:

```sober
// examples/tour_03_collections.sober
package main

import "std/iter"

// Tour 3: slices, maps, for (docs/guide/tour.md)

func main() int {
    // Build a slice with mut, then freeze it to pass it around immutably
    mut xs := mut []int{}
    for i <- iter.Range(1, 6) {
        xs = append(xs, i * i)
    }
    squares := freeze(xs)
    println(len(squares), squares[0], squares[4])

    // for ... yield is a lazy producer (Iter) — consume it through a pipe, not a variable
    println(for v <- squares if v % 2 == 0 yield v |> iter.Sum)

    // map: a lookup is T? (nil when absent)
    mut ages := mut map[string]int{}
    ages["ada"] = 36
    ages["alan"] = 41
    a := ages["ada"]
    if a != nil {
        println("ada is ${a}")
    }
    println(ages["grace"] == nil)
    return 0
}
```

## Slice

```sober
func Slice[T](xs []T, k func(T))
```

slice の走査。for 式の生成元 `x <- xs`（slice の特例）の実体

## Range

```sober
func Range(lo int, hi int, k func(int))
```

整数の半開区間 [lo, hi) を昇順に回す。呼び出し形の生成元 `for i <- iter.Range(0, n)` の実体（継続 k は for が末尾の実引数に足す — [language.md 7 節](../language.md)）

## Each

```sober
func Each[T](it Iter[T], f func(T))
```

要素ごとに f を呼ぶ

## Count

```sober
func Count[T](it Iter[T]) int
```

要素の個数

## Sum

```sober
func Sum(it Iter[int]) int
```

int の要素の和
