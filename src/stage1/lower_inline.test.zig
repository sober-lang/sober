//! lower のテスト: inline 展開・閉包・mut 引数・ジェネリクス・関数値・辞書 const（B-5）
const std = @import("std");
const run = @import("lower_test_run.zig");
const expectRun = run.expectRun;
const expectRunExit = run.expectRunExit;

test "inline: 閉包の呼び出し・ラムダの return は囲みの関数から抜ける・展開の return と defer" {
    try expectRun(
        \\package main
        \\func each(n int, f func(int)) {
        \\    defer println("each done")
        \\    mut i := 0
        \\    while i < n {
        \\        f(i)
        \\        i += 1
        \\    }
        \\}
        \\func twice(x int, f func(int) int) int {
        \\    defer println("twice")
        \\    if x < 0 {
        \\        return 0
        \\    }
        \\    return f(f(x))
        \\}
        \\func first(limit int) int {
        \\    defer println("first out")
        \\    each(limit, i => {
        \\        if i * i > 10 {
        \\            return i
        \\        }
        \\    })
        \\    return -1
        \\}
        \\func main() {
        \\    each(2, i => println(i * 10))
        \\    println(twice(3, x => x * x), twice(-1, x => x))
        \\    println(first(9), first(2))
        \\}
    , "0\n10\neach done\ntwice\ntwice\n81 0\neach done\nfirst out\neach done\nfirst out\n4 -1\n");
}

test "inline: 閉包の転送・展開の中で定義したラムダの return は展開の結果になる・外の名前は見えない" {
    try expectRun(
        \\package main
        \\func apply(x int, f func(int) int) int {
        \\    return f(x)
        \\}
        \\func via(x int, g func(int) int) int {
        \\    return apply(x, g) + 1
        \\}
        \\func pick(xs []int, want int) int {
        \\    mut i := 0
        \\    while i < len(xs) {
        \\        apply(xs[i], v => {
        \\            if v == want {
        \\                return i
        \\            }
        \\            0
        \\        })
        \\        i += 1
        \\    }
        \\    return -1
        \\}
        \\func outer(n int, f func(int) int) int {
        \\    return inner(n, v => {
        \\        if v > 5 {
        \\            return 100
        \\        }
        \\        f(v)
        \\    })
        \\}
        \\func inner(n int, h func(int) int) int {
        \\    return h(n) + h(n + 4)
        \\}
        \\func main() {
        \\    k := 7
        \\    println(via(2, x => x * k), pick([]int{4, 5, 6}, 6), pick([]int{1}, 9))
        \\    println(outer(1, v => v * 2), outer(3, v => v))
        \\}
    , "15 2 -1\n12 100\n");
}

test "mut 引数: struct・slice・ジェネリック struct（呼び手のセルの別名、転送）" {
    try expectRun(
        \\package main
        \\type C struct { n, total int }
        \\func bump(c mut C, by int) {
        \\    c.n = c.n + 1
        \\    c.total = c.total + by
        \\}
        \\func push(xs mut []int, x int) {
        \\    xs = append(xs, x)
        \\}
        \\type Stack[T] struct {
        \\    items mut []T
        \\    size int
        \\}
        \\func Push[T](s mut Stack[T], x T) {
        \\    s.items = append(s.items, x)
        \\    s.size = s.size + 1
        \\}
        \\func PushTwice[T](s mut Stack[T], x T) {
        \\    Push(mut s, x)
        \\    Push(mut s, x)
        \\}
        \\func main() {
        \\    mut c := C{0, 0}
        \\    bump(mut c, 5)
        \\    bump(mut c, 7)
        \\    mut xs := mut []int{}
        \\    push(mut xs, 3)
        \\    push(mut xs, 4)
        \\    mut s := Stack[bool]{mut []bool{}, 0}
        \\    Push(mut s, true)
        \\    PushTwice(mut s, false)
        \\    println(c.n, c.total, len(xs), xs[1], s.size, s.items[0], s.items[2])
        \\}
    , "2 12 2 4 3 true false\n");
}

test "ジェネリクス: 推論・明示・ジェネリック struct・単相コピーの共有・ジェネリック本体からの呼び出し" {
    try expectRun(
        \\package main
        \\type Pair[T] struct { a, b T }
        \\type Box[T] struct { v T? }
        \\func swap[T](p Pair[T]) Pair[T] {
        \\    return Pair[T]{p.b, p.a}
        \\}
        \\func pick[T](c bool, x T, y T) T {
        \\    return if c { x } else { y }
        \\}
        \\func unbox[T](b Box[T], d T) T {
        \\    v := b.v
        \\    return if v != nil { v } else { d }
        \\}
        \\func both[T](p Pair[T]) Pair[T] {
        \\    return swap(swap(p))
        \\}
        \\func main() {
        \\    q := swap(Pair[int]{1, 2})
        \\    r := both(Pair[bool]{true, false})
        \\    println(q.a, q.b, r.a, pick(false, 10, 20), pick[bool](true, false, true))
        \\    println(unbox(Box[int]{7}, 0), unbox(Box[int]{nil}, 9), unbox(Box[Pair[int]]{q}, q).b)
        \\}
    , "2 1 true 20 false\n7 9 1\n");
}

test "関数値: 名前付き関数の参照・関数型フィールド・持ち上げたラムダ・struct の結果" {
    try expectRun(
        \\package main
        \\type P struct { x, y int }
        \\type Ops struct {
        \\    f func(int, int) int
        \\    mk func(int) P
        \\}
        \\func add(a int, b int) int {
        \\    return a + b
        \\}
        \\func twin(n int) P {
        \\    return P{n, n * 2}
        \\}
        \\func use(o Ops, n int) int {
        \\    p := o.mk(n)
        \\    return o.f(p.x, p.y)
        \\}
        \\func main() {
        \\    a := Ops{f: add, mk: twin}
        \\    b := Ops{f: (x, y) => x * y, mk: (n) => P{n + 1, 3}}
        \\    g := add
        \\    println(use(a, 4), use(b, 4), g(20, 1), b.mk(0).x)
        \\}
    , "12 15 21 1\n");
}

test "辞書 const: 参照点ごとの展開・持ち上げたラムダ・入れ子の辞書と int const" {
    try expectRun(
        \\package main
        \\type Ord[T] struct { less func(T, T) bool }
        \\type R struct {
        \\    ord Ord[int]
        \\    lo, hi int
        \\}
        \\const Lim = 10
        \\const Asc = Ord[int]{less: (a, b) => a < b}
        \\const D = R{ord: Asc, lo: 0, hi: Lim}
        \\func minOf[T](a T, b T, o Ord[T]) T {
        \\    return if o.less(a, b) { a } else { b }
        \\}
        \\func main() {
        \\    println(minOf(4, 2, Asc), minOf(1, 3, D.ord), D.hi, Asc.less(1, 2))
        \\}
    , "2 1 10 true\n");
}

test "for 式: Iter のジェネリック引数（型は試し生成で推論して巻き戻す — 副作用は実行時の 1 回だけ）・ブロック形・閉包の生成元" {
    try expectRun(
        \\package main
        \\import "std/iter"
        \\type P struct { a, b int }
        \\func Twice[T](it iter.Iter[T], f func(T)) {
        \\    it(f)
        \\    it(f)
        \\}
        \\func noisy(x int) int {
        \\    println("noisy", x)
        \\    return x
        \\}
        \\func main() {
        \\    xs := []int{1, 2, 3, 4}
        \\    println(for x <- xs if x % 2 == 0 yield noisy(x) |> iter.Count())
        \\    println(iter.Sum(for x <- xs yield x * 10))
        \\    iter.Each(for x <- xs {
        \\        if x > 2 {
        \\            yield P{x, x * x}
        \\        }
        \\    }, (p) => { println(p.a, p.b) })
        \\    Twice(for x <- xs if x == 1 yield x, (v) => { println("v", v) })
        \\}
    , "noisy 2\nnoisy 4\n2\n100\n3 9\n4 16\nv 1\nv 1\n");
}

test "inline の return / ? は展開入口の深度へ戻す（式ブロック・展開中に定義したラムダの本体・? のエラー側 — 再帰 600 段で深度が漏れない）" {
    try expectRun(
        \\package main
        \\type Neg error
        \\func g(x int, f func(int) int) int {
        \\    y := {
        \\        if x > 0 {
        \\            return f(x)
        \\        }
        \\        0
        \\    }
        \\    return y
        \\}
        \\func apply(x int, f func(int) int) int {
        \\    return f(x)
        \\}
        \\func g2(x int, k func(int) int) int {
        \\    return apply(x, v => {
        \\        if v > 0 {
        \\            return k(v)
        \\        }
        \\        0
        \\    })
        \\}
        \\func parse(n int) (int, error?) {
        \\    if n < 0 {
        \\        return 0, Neg{}
        \\    }
        \\    return n, nil
        \\}
        \\func h(x int, f func(int)) (int, error?) {
        \\    y := {
        \\        v := parse(x)?
        \\        v
        \\    }
        \\    f(y)
        \\    return y, nil
        \\}
        \\func r(n int) int {
        \\    v := g(n, a => a + 1)
        \\    if n == 0 {
        \\        return 0
        \\    }
        \\    return r(n - 1) + v - v
        \\}
        \\func r2(n int) int {
        \\    v := g2(n, a => a + 1)
        \\    if n == 0 {
        \\        return 0
        \\    }
        \\    return r2(n - 1) + v - v
        \\}
        \\func r3(n int) int {
        \\    _, e := h(-1, a => println(a))
        \\    if n == 0 || e == nil {
        \\        return 0
        \\    }
        \\    return r3(n - 1)
        \\}
        \\func main() {
        \\    println(r(600), r2(600), r3(600))
        \\}
    , "0 0 0\n");
}
