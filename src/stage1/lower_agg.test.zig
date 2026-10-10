//! lower のテスト: struct / union / T? / error ラベル（B-3）
const std = @import("std");
const run = @import("lower_test_run.zig");
const expectRun = run.expectRun;
const expectRunExit = run.expectRunExit;
const emitLl = run.emitLl;

test "struct: 値のコピー（束縛・引数・並行代入）とフィールド代入" {
    try expectRun(
        \\package main
        \\type P struct { x, y int }
        \\type L struct { a P
        \\    b P }
        \\func bump(p P) P { return P{p.x + 1, p.y} }
        \\func main() {
        \\    mut p := P{1, 2}
        \\    q := p
        \\    p.x = 10
        \\    mut l := L{b: p}
        \\    l.a.y = 7
        \\    r := bump(p)
        \\    mut s := P{100, 200}
        \\    p, s = s, p
        \\    println(q.x, p.x, s.x, l.a.x, l.a.y, l.b.x, r.x, bump(bump(q)).x)
        \\}
    , "1 100 10 0 7 10 11 3\n");
}

test "アグリゲートの合流と多値（struct と int の混在 sret）" {
    try expectRun(
        \\package main
        \\type P struct { x, y int }
        \\func pick(c bool, a, b P) P { return if c { a } else { b } }
        \\func split(p P) (int, P, bool) { return p.x, P{p.y, p.x}, p.x < p.y }
        \\func main() {
        \\    a := P{1, 2}
        \\    b := P{3, 4}
        \\    n, q, lt := split(pick(false, a, b))
        \\    w := switch n {
        \\    case 3: a
        \\    default: b
        \\    }
        \\    println(n, q.x, q.y, lt, pick(true, a, b).y, w.y)
        \\}
    , "3 4 3 true 2 2\n");
}

test "T?: nil と暗黙 some（return・引数・フィールド・代入・if の腕）と flow typing" {
    try expectRun(
        \\package main
        \\type Box struct {
        \\    v int?
        \\    n int
        \\}
        \\func find(k int) int? { return if k > 0 { k * 2 } else { nil } }
        \\func get(v int?) int {
        \\    if v == nil {
        \\        return -1
        \\    } else {
        \\        return v
        \\    }
        \\}
        \\func main() {
        \\    mut o := find(3)
        \\    println(get(o), get(find(0)), get(5), get(nil))
        \\    o = nil
        \\    println(get(o))
        \\    o = 9
        \\    if o != nil { println(o + 1) }
        \\    b := Box{v: 4}
        \\    z := Box{}
        \\    println(get(b.v), get(z.v), z.n, if b.v != nil { 1 } else { 0 })
        \\}
    , "6 -1 5 -1\n-1\n10\n4 -1 0 1\n");
}

test "union: 型パターン（束縛・フィールドの下位パターン・値全体の束縛）と error ラベル" {
    try expectRun(
        \\package main
        \\type S union {
        \\    C { r int }
        \\    R { w, h int }
        \\    E {}
        \\}
        \\type Bad error { code int }
        \\type Gone error
        \\func area(s S) int {
        \\    return switch s {
        \\    case C{r}: r * r
        \\    case R{w, h}: w * h
        \\    case E{}: 0
        \\    }
        \\}
        \\func cls(s S, n int) int {
        \\    return switch s, n {
        \\    case R{w: 1 | 2, h}, _: 1000 + h
        \\    case x R{}, 0: 2000 + area(x)
        \\    case C{r: 3}, _: 3000
        \\    case _, k: k
        \\    }
        \\}
        \\func check(k int) (int, error?) {
        \\    if k < 0 { return 0, Bad{code: k} }
        \\    if k == 0 { return 0, Gone{} }
        \\    return k, nil
        \\}
        \\func codeOf(k int) int {
        \\    v, err := check(k)
        \\    return if err != nil {
        \\        switch err {
        \\        case Bad{code}: code
        \\        case Gone{}: 99
        \\        }
        \\    } else { v }
        \\}
        \\func main() {
        \\    println(area(C{2}), area(R{w: 3, h: 4}), area(E{}))
        \\    println(cls(R{2, 5}, 9), cls(R{3, 5}, 0), cls(C{3}, 9), cls(C{4}, 7), cls(R{3, 5}, 8))
        \\    println(codeOf(5), codeOf(-4), codeOf(0))
        \\}
    , "4 12 0\n1005 2015 3000 7 8\n5 -4 99\n");
}

test "範囲外の構文は Unsupported" {
    try std.testing.expectError(error.Unsupported, emitLl(std.testing.allocator,
        \\package main
        \\func walk(n int, f func(int)) {
        \\    if n > 0 {
        \\        f(n)
        \\        walk(n - 1, f)
        \\    }
        \\}
        \\func main() {
        \\    walk(3, i => println(i))
        \\}
    ));
}
