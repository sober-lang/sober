# std/sort

日本語

`import "std/sort"`

並べ替え（[language.md 34 節](../language.md)「並べ替え」の族）。値の列でなく添字を並べる: 比べ方は呼び手の閉包が持ち（行の開始位置の列とバイト列・struct の欄 …）、並べた結果は添字の列で返す — 呼び手は元の列を写さずに、その順で読むか組み直す。less(a, b) は「添字 a の要素が添字 b の要素より前」で、狭義の弱順序であること（そうでなければ順は決まらないが、添字の列であることは保ち、範囲の外で落ちない — ループは全部境界で止まる）。どちらの関数も決定的（同じ入力・同じ less なら常に同じ列 — 乱択の pivot を使わない）

## Order

```sober
@effects(!io, !block, !nondet)
func Order(n int, less func(int, int) bool) []int
```

0..n−1 を less の順に並べた添字の列を返す（安定 — less で前後の付かない添字は小さい順のまま）。実装 = 自然な列のマージソート: 昇順の列と狭義の降順の列（反転する — 等しいものを含まないので安定のまま）を拾い、base より短い列は二分挿入で伸ばして、隣どうしを対でマージする周を列が 1 本になるまで繰り返す（既に並んでいる対は写すだけ・右が丸ごと前なら右・左の順に写す）。比べる回数は O(n log n)・並んだ入力と逆順の入力は O(n)・作業域は添字 2n 語

例:

```sober
// examples/sort_order.sober
package main

// Sort with std/sort: Order returns the indices 0..n−1 in the order of a comparison closure. The values stay where they are —
// read them in that order, or build a sorted copy. The order is stable: items that compare equal keep their original order.
// OrderUnstable has the same shape and is faster, but makes no promise about the order of equal items (it is still deterministic:
// the same input always gives the same order) — use it when ties cannot be observed.
import "std/iter"
import "std/sort"

type Item struct {
    name string
    price int
}

func main() int {
    items := []Item{
        Item{name: "tea", price: 300},
        Item{name: "bread", price: 250},
        Item{name: "milk", price: 180},
        Item{name: "coffee", price: 300},
        Item{name: "jam", price: 250},
    }
    // cheapest first; equal prices keep the list order (bread before jam, tea before coffee)
    byPrice := sort.Order(len(items), (a, b) => items[a].price < items[b].price)
    for i <- byPrice {
        println("${items[i].price} ${items[i].name}")
    }
    // sorting by one column and reading another: the rank of each item in the original list
    mut rank := mut []int{}
    for i <- iter.Range(0, len(items)) {
        rank = append(rank, 0)
    }
    for k <- iter.Range(0, len(byPrice)) {
        rank[byPrice[k]] = k + 1
    }
    for i <- iter.Range(0, len(items)) {
        println("${items[i].name}: #${rank[i]}")
    }
    // no two keys are equal (here: the list positions, last first), so ties cannot be observed and the unstable sort gives the one possible order
    reversed := sort.OrderUnstable(len(items), (a, b) => a > b)
    for i <- reversed {
        println(items[i].name)
    }
    // empty and single are fine
    println(len(sort.Order(0, (a, b) => a < b)), sort.Order(1, (a, b) => a < b)[0])
    return 0
}
```

## OrderUnstable

```sober
@effects(!io, !block, !nondet)
func OrderUnstable(n int, less func(int, int) bool) []int
```

0..n−1 を less の順に並べた添字の列を返す（不安定 — less で前後の付かない添字の順は約束しない。ただし決定的: 同じ入力・同じ less なら常に同じ列）。Order より速い（写しの作業域が要らず、要素の動きが少ない）。外部ソートの run の組み立てのように、行の全体で比べて同値の順が観測できない形に。実装 = pattern-defeating quicksort（pdqsort）: pivot = 3 点（長い区間は 9 点）の中央値・pivot と等しい要素が多い区間は等しいものを左へ寄せて飛ばす・分割が既に済んでいた区間は部分挿入ソートで仕上げを試す・偏った分割が log₂ n 回続いた区間は heapsort（最悪 O(n log n)）・偏った分割の後は決まった位置を入れ替えて並びの癖を崩す（乱択しない）。短い区間は挿入ソート。再帰しない（区間を積む）。作業域は区間の積み（O(log n) 語）

例:

```sober
// examples/sort_order.sober
package main

// Sort with std/sort: Order returns the indices 0..n−1 in the order of a comparison closure. The values stay where they are —
// read them in that order, or build a sorted copy. The order is stable: items that compare equal keep their original order.
// OrderUnstable has the same shape and is faster, but makes no promise about the order of equal items (it is still deterministic:
// the same input always gives the same order) — use it when ties cannot be observed.
import "std/iter"
import "std/sort"

type Item struct {
    name string
    price int
}

func main() int {
    items := []Item{
        Item{name: "tea", price: 300},
        Item{name: "bread", price: 250},
        Item{name: "milk", price: 180},
        Item{name: "coffee", price: 300},
        Item{name: "jam", price: 250},
    }
    // cheapest first; equal prices keep the list order (bread before jam, tea before coffee)
    byPrice := sort.Order(len(items), (a, b) => items[a].price < items[b].price)
    for i <- byPrice {
        println("${items[i].price} ${items[i].name}")
    }
    // sorting by one column and reading another: the rank of each item in the original list
    mut rank := mut []int{}
    for i <- iter.Range(0, len(items)) {
        rank = append(rank, 0)
    }
    for k <- iter.Range(0, len(byPrice)) {
        rank[byPrice[k]] = k + 1
    }
    for i <- iter.Range(0, len(items)) {
        println("${items[i].name}: #${rank[i]}")
    }
    // no two keys are equal (here: the list positions, last first), so ties cannot be observed and the unstable sort gives the one possible order
    reversed := sort.OrderUnstable(len(items), (a, b) => a > b)
    for i <- reversed {
        println(items[i].name)
    }
    // empty and single are fine
    println(len(sort.Order(0, (a, b) => a < b)), sort.Order(1, (a, b) => a < b)[0])
    return 0
}
```
