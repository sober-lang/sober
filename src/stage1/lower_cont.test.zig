//! lower のテスト: slice / string / map / region（B-4）
const std = @import("std");
const run = @import("lower_test_run.zig");
const expectRun = run.expectRun;
const expectRunExit = run.expectRunExit;

test "slice: リテラル・添字・len・要素代入・freeze・部分列・struct の要素" {
    try expectRun(
        \\package main
        \\type P struct {
        \\    x, y int
        \\}
        \\func main() {
        \\    xs := []int{3, 1, 4, 1, 5}
        \\    println(len(xs), xs[0], xs[4])
        \\    ws := mut []int{0, 0}
        \\    ws[1] = xs[2] * 10
        \\    fs := freeze(ws)
        \\    println(fs[0], fs[1])
        \\    t := xs[1:4]
        \\    println(len(t), t[0], t[2])
        \\    e := xs[5:5]
        \\    println(len(e))
        \\    ps := []P{P{1, 2}, P{3, 4}}
        \\    q := ps[1]
        \\    println(q.x + q.y, ps[0].y)
        \\}
    , "5 3 5\n0 40\n3 1 1\n0\n7 2\n");
}

test "append: mut は先端なら伸長・他は全コピー、imm は常に全コピー（元の slice は変わらない）" {
    try expectRun(
        \\package main
        \\type P struct {
        \\    x, y int
        \\}
        \\func main() {
        \\    xs := []int{1, 2, 3}
        \\    ys := append(xs, 4)
        \\    zs := append(xs, 5)
        \\    println(len(xs), ys[3], zs[3])
        \\    mut m := mut []int{}
        \\    mut i := 0
        \\    while i < 5 {
        \\        m = append(m, i * i)
        \\        i += 1
        \\    }
        \\    println(len(m), m[0], m[4])
        \\    mut a := mut []int{7}
        \\    mut b := mut []int{8}
        \\    a = append(a, 9)
        \\    b = append(b, 10)
        \\    println(a[0], a[1], b[0], b[1])
        \\    mut ps := mut []P{}
        \\    ps = append(ps, P{1, 2})
        \\    ps = append(ps, P{3, 4})
        \\    println(len(ps), ps[1].x, ps[0].y)
        \\}
    , "3 4 5\n5 0 16\n7 9 8 10\n2 3 2\n");
}

test "範囲外の添字・要素代入・部分列は exit 101（負も範囲外）" {
    try expectRunExit(
        \\package main
        \\func main() {
        \\    xs := []int{1, 2}
        \\    println(xs[1])
        \\    println(xs[0 - 1])
        \\}
    , "2\n", 101);
    try expectRunExit(
        \\package main
        \\func main() {
        \\    ws := mut []int{1}
        \\    ws[1] = 5
        \\}
    , "", 101);
    try expectRunExit(
        \\package main
        \\func main() {
        \\    xs := []int{1, 2, 3}
        \\    println(len(xs[1:3]))
        \\    println(len(xs[2:1]))
        \\}
    , "2\n", 101);
}

test "string: 比較・連結・印字・bytes・補間" {
    try expectRun(
        \\package main
        \\func greet(name string) string {
        \\    return "hi, " + name
        \\}
        \\func main() {
        \\    s := greet("bob")
        \\    println(s, s == "hi, bob", s != "hi, bob", s == "hi")
        \\    b := bytes(s)
        \\    println(len(b), b[0], b[6])
        \\    n := 0 - 42
        \\    ok := true
        \\    println("n=${n} ok=${ok} s=${s}!")
        \\    e := ""
        \\    println(e + e == "", len(bytes(e + "ab")))
        \\}
    , "hi, bob true false false\n7 104 98\nn=-42 ok=true s=hi, bob!\ntrue 2\n");
}

test "map: int / string キー・上書き・delete（墓石）と再挿入・len・freeze" {
    try expectRun(
        \\package main
        \\func get(m map[string]int, k string) int {
        \\    v := m[k]
        \\    return if v != nil { v } else { 0 - 1 }
        \\}
        \\func main() {
        \\    mut m := mut map[int]int{1: 10, 2: 20, 1: 11}
        \\    println(len(m))
        \\    a := m[1]
        \\    if a != nil {
        \\        println(a)
        \\    }
        \\    delete(m, 1)
        \\    println(len(m), m[1] == nil)
        \\    m[1] = 12
        \\    m[3] = 30
        \\    println(len(m))
        \\    f := freeze(m)
        \\    c := f[1]
        \\    if c != nil {
        \\        println(c)
        \\    }
        \\    mut s := mut map[string]int{"ab": 1}
        \\    s["a" + "b"] = 2
        \\    s["abc"] = 3
        \\    println(len(s), get(freeze(s), "ab"), get(freeze(s), "abc"), get(freeze(s), "a"))
        \\}
    , "2\n11\n1 true\n3\n12\n2 2 3 -1\n");
}

test "戻り値の境界コピー: callee の region で作った slice / map / struct 内の slice が呼び手に残る" {
    try expectRun(
        \\package main
        \\type Box struct {
        \\    tag int
        \\    xs []int
        \\}
        \\func build(n int) []int {
        \\    mut xs := mut []int{}
        \\    mut i := 0
        \\    while i < n {
        \\        xs = append(xs, i)
        \\        i += 1
        \\    }
        \\    return freeze(xs)
        \\}
        \\func twice(n int) []int {
        \\    return build(n + n)
        \\}
        \\func boxed(n int) Box {
        \\    return Box{n, build(n)}
        \\}
        \\func table() (map[int]int, int) {
        \\    return map[int]int{5: 50}, 1
        \\}
        \\func main() {
        \\    a := build(3)
        \\    b := twice(2)
        \\    c := boxed(4)
        \\    m, k := table()
        \\    junk := build(100)
        \\    v := m[5]
        \\    if v != nil {
        \\        println(v, k)
        \\    }
        \\    println(len(a), a[2], len(b), b[3], c.tag, c.xs[3], len(junk))
        \\    mut sum := 0
        \\    mut i := 0
        \\    while i < 1000 {
        \\        sum += len(build(10))
        \\        i += 1
        \\    }
        \\    println(sum)
        \\}
    , "50 1\n3 2 4 3 4 3 100\n10000\n");
}

test "T{} の slice / map フィールドは空（そのまま append / set できる）" {
    try expectRun(
        \\package main
        \\type S struct {
        \\    n int
        \\    xs mut []int
        \\    m mut map[int]int
        \\}
        \\func main() {
        \\    mut s := S{}
        \\    s.xs = append(s.xs, 7)
        \\    mut m := s.m
        \\    m[1] = 2
        \\    println(s.n, len(s.xs), s.xs[0], len(m), len(s.m))
        \\}
    , "0 1 7 1 0\n");
}

test "アリーナの上限超過は exit 102（それまでに出した行は残る）" {
    try expectRunExit(
        \\package main
        \\func main() {
        \\    println(1)
        \\    mut xs := []int{}
        \\    while true {
        \\        xs = append(xs, 1)
        \\    }
        \\}
    , "1\n", 102);
}
