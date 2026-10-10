//! lower のテスト: 後置 `?`（関数・inline 展開・包み替え・ゼロ値）と std/io の sys* 組み込み（B-5）
const std = @import("std");
const run = @import("lower_test_run.zig");
const expectRun = run.expectRun;
const expectRunExit = run.expectRunExit;

test "?: 関数と inline 展開の中の伝播・他の結果はゼロ値（slice は空）・包み替え・defer" {
    try expectRun(
        \\package main
        \\type Bad error { at int }
        \\func parse(n int) (int, error?) {
        \\    if n < 0 {
        \\        return 0, Bad{n}
        \\    }
        \\    return n * 2, nil
        \\}
        \\func twice(n int) ([]int, int, error?) {
        \\    defer println("twice out")
        \\    a := parse(n)?
        \\    b := parse(a - 5)?
        \\    return []int{a, b}, a + b, nil
        \\}
        \\func wrapped(n int) (int, error?) {
        \\    x := parse(n)? Bad{100}
        \\    return x, nil
        \\}
        \\func viaInline(n int, f func(int)) (int, error?) {
        \\    defer println("inline out")
        \\    f(n)
        \\    v := parse(n - 2)?
        \\    return v, nil
        \\}
        \\func code(e error?) int {
        \\    return if e != nil {
        \\        switch e {
        \\        case Bad{at}: at
        \\        }
        \\    } else {
        \\        999
        \\    }
        \\}
        \\func main() {
        \\    xs, s, e := twice(5)
        \\    println(len(xs), xs[1], s, code(e))
        \\    ys, t, e2 := twice(2)
        \\    println(len(ys), t, code(e2))
        \\    w, e4 := wrapped(-1)
        \\    w2, e5 := wrapped(4)
        \\    println(w, code(e4), w2, code(e5))
        \\    v, e6 := viaInline(7, i => println(i))
        \\    println(v, code(e6))
        \\    v2, e7 := viaInline(1, i => println(i))
        \\    println(v2, code(e7))
        \\}
    , "twice out\n2 10 20 999\ntwice out\n0 0 -1\n0 100 8 999\n7\ninline out\n10 999\n1\ninline out\n0 -1\n");
}

test "io: 書いて読み戻す・存在しない path は NotFound・長すぎる path は ENAMETOOLONG" {
    try expectRun(
        \\package main
        \\import "std/io"
        \\import "std/utf8"
        \\func code(e error?) int {
        \\    return if e != nil {
        \\        switch e {
        \\        case io.NotFound{}: 1
        \\        case io.Denied{}: 2
        \\        case io.Other{errno}: errno
        \\        case utf8.InvalidUtf8{pos}: -1
        \\        }
        \\    } else {
        \\        0
        \\    }
        \\}
        \\func main() {
        \\    e := io.WriteFile("zig-out/lower_io_test.txt", []int{104, 105, 10})
        \\    b, e2 := io.ReadFile("zig-out/lower_io_test.txt")
        \\    println(code(e), len(b), b[0], b[2], code(e2))
        \\    _, e3 := io.ReadFile("zig-out/no/such/file")
        \\    mut long := "a"
        \\    mut i := 0
        \\    while i < 13 {
        \\        long = long + long
        \\        i += 1
        \\    }
        \\    _, e4 := io.ReadFile(long)
        \\    println(code(e3), code(e4))
        \\}
    , "0 3 104 10 0\n1 36\n");
}
