//! lower のテスト（スカラー・制御・多値・pipe・シフト・defer）。テーマ別の他ファイルはここから束ねる
//! （build.zig の lower_tests は 1 ファイル固定なので import で拾わせる）。足場は lower_test_run.zig。
const std = @import("std");
const run = @import("lower_test_run.zig");
const expectRun = run.expectRun;
const expectRunExit = run.expectRunExit;

test {
    _ = @import("lower_agg.test.zig");
    _ = @import("lower_cont.test.zig");
    _ = @import("lower_inline.test.zig");
    _ = @import("lower_try.test.zig");
    // IR 単体（ir.test は B-1 から build.zig の一覧に無く回っていなかった — ここで拾う）
    _ = @import("ir.test.zig");
    _ = @import("ir_parse.test.zig");
    _ = @import("ir_verify.test.zig");
    _ = @import("ir_mem2reg.test.zig");
    _ = @import("ir_x86.test.zig");
    _ = @import("ir_live.test.zig");
    _ = @import("lower_diag.test.zig");
    _ = @import("lower_run.test.zig");
}

test "fib" {
    try expectRun(
        \\package main
        \\func fib(n int) int {
        \\    return if n < 2 { n } else { fib(n - 1) + fib(n - 2) }
        \\}
        \\func main() {
        \\    println(fib(10))
        \\}
    , "55\n");
}

test "println: 整数の印字（負数・最小値・最大値）と空白区切り" {
    try expectRun(
        \\package main
        \\func main() {
        \\    println(0, -1, 1234567)
        \\    println(-9223372036854775807 - 1, 9223372036854775807)
        \\}
    , "0 -1 1234567\n-9223372036854775808 9223372036854775807\n");
}

test "算術: 切り捨て除算・剰余の符号・wrap・最小値 / -1" {
    try expectRun(
        \\package main
        \\func d(a int, b int) int { return a / b }
        \\func r(a int, b int) int { return a % b }
        \\const Min = -9223372036854775807 - 1
        \\func main() {
        \\    println(d(7, 2), d(-7, 2), r(-7, 2), r(7, -2))
        \\    println(d(Min, -1), r(Min, -1), d(5, -1))
        \\    println(9223372036854775807 + 1, Min * -1)
        \\    println(-7 / 2, 7 % 3)
        \\}
    , "3 -3 -1 1\n-9223372036854775808 0 -5\n-9223372036854775808 -9223372036854775808\n-3 1\n");
}

test "ゼロ除算は exit 101、それまでに出した行は残る" {
    try expectRunExit(
        \\package main
        \\func d(a int, b int) int { return a / b }
        \\func main() {
        \\    println(d(7, 2))
        \\    println(d(1, 0))
        \\    println(3)
        \\}
    , "3\n", 101);
}

test "剰余のゼロ除算も exit 101" {
    try expectRunExit(
        \\package main
        \\func r(a int, b int) int { return a % b }
        \\func main() { println(r(1, 0)) }
    , "", 101);
}

test "bool: 印字・比較・否定・短絡評価" {
    try expectRun(
        \\package main
        \\func t(n int) bool {
        \\    println(n)
        \\    return true
        \\}
        \\func f(n int) bool {
        \\    println(n)
        \\    return false
        \\}
        \\func main() {
        \\    println(true, false, !true, 1 < 2, 2 <= 1, true == false, true != false)
        \\    println(f(1) && t(2))
        \\    println(t(3) || f(4))
        \\    println(t(5) && f(6))
        \\}
    , "true false false true false false true\n1\nfalse\n3\ntrue\n5\n6\nfalse\n");
}

test "ビット演算と単項" {
    try expectRun(
        \\package main
        \\func main() {
        \\    println(12 & 10, 12 | 10, 12 ^ 10, ^0, -(3))
        \\}
    , "8 14 6 -1 -3\n");
}

test "if 文・早期 return・不変束縛・ブロック式・const" {
    try expectRun(
        \\package main
        \\const Base = 100
        \\func sign(n int) int {
        \\    if n < 0 {
        \\        return -1
        \\    }
        \\    if n == 0 { return 0 } else { return 1 }
        \\}
        \\func main() {
        \\    x := sign(-5) + sign(0) * 10 + sign(7) * 100
        \\    y := { z := x + Base; z * 2 }
        \\    if y > 0 { println(y) }
        \\    println(x)
        \\}
    , "398\n99\n");
}

test "再帰の深さの上限は exit 102（call ごとに region 1 段 — panic_depth と同じ観測）" {
    try expectRunExit(
        \\package main
        \\func down(n int) int {
        \\    return if n == 0 { 0 } else { 1 + down(n - 1) }
        \\}
        \\func main() {
        \\    println(down(1021))
        \\    println(down(1022))
        \\}
    , "1021\n", 102);
}

test "mut・while・break・continue・複合代入・並行代入" {
    try expectRun(
        \\package main
        \\func gcd(a, b int) int {
        \\    mut x, y := a, b
        \\    while y != 0 {
        \\        x, y = y, x % y
        \\    }
        \\    return x
        \\}
        \\func main() {
        \\    mut i := 0
        \\    mut acc := 0
        \\    while true {
        \\        i += 1
        \\        if i % 2 == 0 { continue }
        \\        if i > 9 { break }
        \\        acc += i
        \\    }
        \\    mut k := 5
        \\    k *= 3
        \\    k -= 1
        \\    k /= 2
        \\    k %= 4
        \\    println(gcd(48, 18), acc, i, k)
        \\}
    , "6 25 11 3\n");
}

test "defer: 出口ごとの展開順（ブロック・continue・break・return の値確定が先）" {
    try expectRun(
        \\package main
        \\func trace(n int) int {
        \\    println(n)
        \\    return n
        \\}
        \\func work() int {
        \\    defer println(1)
        \\    {
        \\        defer println(2)
        \\        println(3)
        \\    }
        \\    mut i := 0
        \\    while i < 3 {
        \\        defer println(10 + i)
        \\        i += 1
        \\        if i == 1 { continue }
        \\        if i == 2 { break }
        \\    }
        \\    return trace(100)
        \\}
        \\func main() {
        \\    defer println(0)
        \\    println(work())
        \\}
    , "3\n2\n11\n12\n100\n1\n100\n0\n");
}

test "多値: sret の return・分解束縛・転送・_ で捨てる・文位置で捨てる" {
    try expectRun(
        \\package main
        \\func divmod(a, b int) (int, int) {
        \\    return a / b, a % b
        \\}
        \\func fwd(a int) (int, int) {
        \\    return divmod(a, 3)
        \\}
        \\func flags(n int) (bool, int, bool) {
        \\    println(n)
        \\    return n > 0, n * 2, n < 0
        \\}
        \\func main() {
        \\    q, r := divmod(17, 5)
        \\    _, s := fwd(10)
        \\    mut a, b, c := flags(4)
        \\    a, b, c = flags(-1)
        \\    flags(7)
        \\    println(q, r, s, a, b, c)
        \\}
    , "4\n-1\n7\n3 2 1 false -2 true\n");
}

test "switch: 定数・選択・束縛・_・subject 無し・多値 subject・default 無し" {
    try expectRun(
        \\package main
        \\const Two = 2
        \\func divmod(a, b int) (int, int) {
        \\    println(a)
        \\    return a / b, a % b
        \\}
        \\func cls(n int) int {
        \\    return switch n {
        \\    case 1 | Two: 12
        \\    case v: v * 10
        \\    }
        \\}
        \\func main() {
        \\    println(cls(1), cls(2), cls(3))
        \\    println(switch {
        \\    case 3 < 2: 1
        \\    case _: 2
        \\    })
        \\    println(switch divmod(9, 4) {
        \\    case 2, r: 100 + r
        \\    default: 0
        \\    })
        \\    switch true {
        \\    case false:
        \\        println(0)
        \\    }
        \\    println(switch true, 5 {
        \\    case false, _: 1
        \\    case true, 4: 2
        \\    case _, w: w
        \\    })
        \\}
    , "12 12 30\n2\n9\n101\n5\n");
}

test "pipe: 第 1 引数・穴・多値の穴・括弧なしの callee" {
    try expectRun(
        \\package main
        \\func divmod(a, b int) (int, int) { return a / b, a % b }
        \\func add(a, b int) int { return a + b }
        \\func twice(n int) int { return n * 2 }
        \\func main() {
        \\    x := 17 |> divmod(5) |> add(_, _) |> twice
        \\    _, r := 17 |> divmod(_, 5)
        \\    println(x, r, 3 |> add(10, _))
        \\}
    , "10 2 13\n");
}

test "シフト: 量 ≥ 64 の畳み込みと複合代入" {
    try expectRun(
        \\package main
        \\func shl(x, n int) int { return x << n }
        \\func shr(x, n int) int { return x >> n }
        \\func main() {
        \\    println(shl(1, 3), shl(-7, 2), shl(1, 63), shl(1, 64), shl(3, 100))
        \\    println(shr(40, 3), shr(-7, 1), shr(-1, 100), shr(7, 64), shr(-8, 63))
        \\    mut x := 3
        \\    x <<= 4
        \\    x >>= 1
        \\    println(x)
        \\}
    , "8 -28 -9223372036854775808 0 0\n5 -4 -1 0 -1\n24\n");
}

test "負のシフト量は exit 101" {
    try expectRunExit(
        \\package main
        \\func shl(x, n int) int { return x << n }
        \\func main() {
        \\    println(shl(1, 1))
        \\    println(shl(1, -1))
        \\}
    , "2\n", 101);
}

test "脱出で終わる腕は到達しない（if / switch の値位置）" {
    try expectRun(
        \\package main
        \\func f(c int) int {
        \\    x := if c > 5 { return 100 } else { c * 2 }
        \\    y := switch c {
        \\    case 1: return 7
        \\    default: c
        \\    }
        \\    mut s := 0
        \\    mut i := 0
        \\    while i < 10 {
        \\        z := if i == 4 { break } else { i }
        \\        s += z
        \\        i += 1
        \\    }
        \\    return x + y + s
        \\}
        \\func main() {
        \\    println(f(9), f(1), f(3))
        \\}
    , "100 7 15\n");
}

test "式ブロックは region を 1 段開く（深度の上限が 1 段早まる）、while 本体は透過" {
    try expectRunExit(
        \\package main
        \\func down(n int) int {
        \\    mut i := 0
        \\    while i < 3 { i += 1 }
        \\    return if n == 0 { 0 } else { { 1 + down(n - 1) } }
        \\}
        \\func main() {
        \\    println(down(510))
        \\    println(down(511))
        \\}
    , "510\n", 102);
}

test "println の文字列リテラル" {
    try expectRun(
        \\package main
        \\func main() {
        \\    println("a b", 1, "", true)
        \\}
    , "a b 1  true\n");
}
