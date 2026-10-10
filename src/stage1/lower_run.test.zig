//! codegen.test の実行系を IR 経路へ移したもの（B-9a — codegen 退役の前準備）。期待値は direct で確かめ済みの固定値。
//! 単一ソースは lower_test_run の 6 列（LLVM -O0 / -O2 × IR パス有無 + ir_x86 × IR パス有無）、複数 package は既定経路の ELF。
//! 移さなかったもの: 拒否の表（lower_diag.test が回す）・examples の .out（obs が回す）・inline の return 深度（lower_inline.test に同じもの）。--mem-trace は IR ランタイムへ移した（B-9a-3）
const std = @import("std");
const loader = @import("loader.zig");
const run = @import("lower_test_run.zig");
const std_embed = @import("std_embed");
const std_table: loader.StdTable = .{ .paths = &std_embed.paths, .sources = &std_embed.sources };

const expectRun = run.expectRun;
const expectRunExit = run.expectRunExit;
const expectExitSlot = run.expectExitSlot;
const expectExit = run.expectExit;

fn expectPanic(source: [:0]const u8) !void {
    try expectExit(source, 101);
}

fn compileFiles(allocator: std.mem.Allocator, files: []const loader.SrcFile) ![]u8 {
    return run.buildFiles(allocator, files);
}

test "region arena: a region past its slot panics with 102 instead of overwriting the next depth" {
    const fill =
        \\func fill(n int, v int) []int {
        \\    mut b := mut []int{}
        \\    mut i := 0
        \\    while i < n {
        \\        b = append(b, v)
        \\        i += 1
        \\    }
        \\    return freeze(b)
        \\}
        \\
    ;
    // 2.4MB × 2 深度（旧 1MB スロットでは xs の後半が 9 に書き換わっていた）
    try expectRun("package main\n" ++ fill ++
        \\func scratch() int {
        \\    t := fill(300000, 9)
        \\    return len(t)
        \\}
        \\func main() {
        \\    xs := fill(300000, 7)
        \\    n := scratch()
        \\    println(n, xs[0], xs[150000], xs[299999])
        \\}
        \\
    , "300000 7 7 7\n");
    // 72MB > 64MB スロット（SOBER_REGION_MB=64）: append の先端伸長で溢れる。既定のスロット（4GiB）なら通る
    const big = "package main\n" ++ fill ++ "func main() { println(len(fill(9000000, 7))) }\n";
    try expectExitSlot(big, 102, "64");
    try expectRun(big, "9000000\n");
    // concat の連鎖で溢れる（64MB スロット）
    try expectExitSlot(
        \\package main
        \\func main() {
        \\    mut s := "0123456789abcdef"
        \\    mut i := 0
        \\    while i < 30 {
        \\        s = s + s
        \\        i += 1
        \\    }
        \\}
        \\
    , 102, "64");
}

test "region arena: recursion deeper than the depth slots panics with 102" {
    try expectExit(
        \\package main
        \\func down(n int) int {
        \\    return if n == 0 { 0 } else { 1 + down(n - 1) }
        \\}
        \\func main() { println(down(5000)) }
        \\
    , 102);
}

test "shift by a negative count panics (Go semantics; Lean ArithOp.eval gives none)" {
    try expectPanic("package main\nfunc f(x, n int) int { return x << n }\nfunc main() { println(f(1, 0 - 1)) }\n");
    try expectPanic("package main\nfunc f(x, n int) int { return x >> n }\nfunc main() { println(f(1, 0 - 1)) }\n");
}

test "println evaluates every argument before writing (io-4, Go order) and buffers long lines" {
    try expectRun(
        \\package main
        \\func trace(v int) int {
        \\    println("trace", v)
        \\    return v
        \\}
        \\func main() {
        \\    println(trace(1), trace(2), "x", true)
        \\}
        \\
    , "trace 1\ntrace 2\n1 2 x true\n");
    // 行バッファ（4096）を跨ぐ 1 行
    try expectRun(
        \\package main
        \\func main() {
        \\    mut s := "abcdefgh"
        \\    mut i := 0
        \\    while i < 10 {
        \\        s = s + s
        \\        i += 1
        \\    }
        \\    println(s == s, 1)
        \\    println(s)
        \\}
        \\
    , "true 1\n" ++ ("abcdefgh" ** 1024) ++ "\n");
}

test "println of literals: positive, zero, negative, several" {
    try expectRun("package main\nfunc main() { println(42) }\n", "42\n");
    try expectRun("package main\nfunc main() { println(0) }\n", "0\n");
    try expectRun("package main\nfunc main() { println(-7) }\n", "-7\n");
    try expectRun("package main\nfunc main() { println(1, 22, 333) }\n", "1 22 333\n");
    try expectRun("package main\nfunc main() { println() }\n", "\n");
    try expectRun("package main\nfunc main() { println(9223372036854775807) }\n", "9223372036854775807\n");
}

test "arithmetic and comparison operators" {
    try expectRun("package main\nfunc main() { println(1 + 2 * 3 - 4 / 2, 7 % 3, -(5 - 8)) }\n", "5 1 3\n");
    try expectRun("package main\nfunc main() { println(1 < 2, 2 < 1, 3 == 3, 3 != 3, 2 >= 2, 1 > 2) }\n", "true false true false true false\n");
    try expectRun("package main\nfunc main() { println(6 & 3, 6 | 3, 6 ^ 3, !false, !true) }\n", "2 7 5 true false\n");
    try expectRun("package main\nfunc main() { println(1 < 2 && 2 < 3, 1 < 2 && 3 < 2, false || false, false || true) }\n", "true false false true\n");
}

test "functions: params, recursion, if expression (fib)" {
    try expectRun(
        \\package main
        \\
        \\func fib(n int) int {
        \\    return if n < 2 { n } else { fib(n - 1) + fib(n - 2) }
        \\}
        \\
        \\func main() {
        \\    println(fib(10), fib(20))
        \\}
        \\
    , "55 6765\n");
}

test "bindings, mut, while, break, continue, compound assignment" {
    try expectRun(
        \\package main
        \\
        \\func gcd(a, b int) int {
        \\    mut x := a
        \\    mut y := b
        \\    while y != 0 {
        \\        t := x % y
        \\        x = y
        \\        y = t
        \\    }
        \\    return x
        \\}
        \\
        \\func count(n int) int {
        \\    mut i := 0
        \\    mut acc := 0
        \\    while i < n {
        \\        i += 1
        \\        if i % 2 == 0 {
        \\            continue
        \\        }
        \\        if acc > 100 {
        \\            break
        \\        }
        \\        acc += i
        \\    }
        \\    return acc
        \\}
        \\
        \\func main() {
        \\    println(gcd(48, 18), count(20), count(100))
        \\}
        \\
    , "6 100 121\n");
}

test "parallel binding and assignment" {
    try expectRun(
        \\package main
        \\func main() {
        \\    mut a, b := 1, 2
        \\    a, b = b, a
        \\    x, y, z := a + b, a * b, a - b
        \\    println(a, b, x, y, z)
        \\}
    , "2 1 3 2 1\n");
}

test "multiple results: bind, assign, forward, discard, nested calls" {
    try expectRun(
        \\package main
        \\
        \\func divmod(a, b int) (int, int) {
        \\    return a / b, a % b
        \\}
        \\
        \\func three(n int) (int, int, int) {
        \\    return n, n * n, n * n * n
        \\}
        \\
        \\func forward(a, b int) (int, int) {
        \\    return divmod(a, b)
        \\}
        \\
        \\func main() {
        \\    q, r := divmod(17, 5)
        \\    mut x, y := 0, 0
        \\    x, y = forward(q + 20, r)
        \\    a, b, c := three(5 + {
        \\        d, e := divmod(7, 7)
        \\        d - e
        \\    })
        \\    divmod(1, 1)
        \\    println(q, r, x, y, a, b, c)
        \\}
        \\
    , "3 2 11 1 6 36 216\n");
}

test "switch: subject-less, constant alternatives, wildcard, multi-value subject, parenthesized bit-or" {
    try expectRun(
        \\package main
        \\
        \\func sign(n int) int {
        \\    return switch {
        \\    case n < 0: -1
        \\    case n == 0: 0
        \\    default: 1
        \\    }
        \\}
        \\
        \\func small(n int) int {
        \\    return switch n {
        \\    case 1 | 2 | 3: 1
        \\    case 2 + 3 | 7: 5
        \\    case (8 | 1): 9
        \\    default: 0
        \\    }
        \\}
        \\
        \\func divmod(a, b int) (int, int) {
        \\    return a / b, a % b
        \\}
        \\
        \\func kind(a, b int) int {
        \\    return switch divmod(a, b) {
        \\    case 0, _: 100
        \\    case _, 0: 200
        \\    case 1 | 2, 1 | 2: 300
        \\    default: 400
        \\    }
        \\}
        \\
        \\func main() {
        \\    v := switch 1, 2 {
        \\    case 1, 2: 12
        \\    default: 0
        \\    }
        \\    println(sign(-5), sign(0), sign(3), small(2), small(5), small(7), small(9), small(8), kind(1, 5), kind(10, 5), kind(5, 3), kind(9, 2), v)
        \\}
        \\
    , "-1 0 1 1 5 5 9 0 100 200 300 400 12\n");
}

test "pipe: first argument, holes, multi-value into holes, bare stage, discard with _" {
    try expectRun(
        \\package main
        \\
        \\func divmod(a, b int) (int, int) {
        \\    return a / b, a % b
        \\}
        \\
        \\func sub(a, b int) int {
        \\    return a - b
        \\}
        \\
        \\func neg(n int) int {
        \\    return -n
        \\}
        \\
        \\func main() {
        \\    a := 10 |> sub(3)
        \\    b := 10 |> sub(3, _)
        \\    c := 10 |> neg |> neg
        \\    q, r := 17 |> divmod(5)
        \\    d := 17 |> divmod(5) |> sub(_, _)
        \\    mut e := 0
        \\    _, e = divmod(9, 4)
        \\    f := switch 17 |> divmod(5) {
        \\    case 3, 2: 1
        \\    default: 0
        \\    }
        \\    println(a, b, c, q, r, d, e, f)
        \\    17 |> divmod(5)
        \\}
        \\
    , "7 -7 10 3 2 1 1 1\n");
}

test "defer: multi-value return, locals inside defer, break path, LIFO order" {
    try expectRun(
        \\package main
        \\
        \\func pair(n int) (int, int) {
        \\    defer {
        \\        t := n * 100
        \\        println(t)
        \\    }
        \\    defer println(n)
        \\    mut i := 0
        \\    while i < 10 {
        \\        defer println(-i)
        \\        i += 1
        \\        if i == 3 {
        \\            break
        \\        }
        \\    }
        \\    return n + 1, n + 2
        \\}
        \\
        \\func main() {
        \\    a, b := pair(7)
        \\    println(a, b)
        \\}
        \\
    , "-1\n-2\n-3\n7\n700\n8 9\n");
}

test "struct: value semantics, nested copy, pipe and switch subject with struct results, defer keeps struct value" {
    try expectRun(
        \\package main
        \\
        \\type P struct {
        \\    x, y int
        \\}
        \\
        \\type Box struct {
        \\    lo P
        \\    hi P
        \\    tag int
        \\}
        \\
        \\func mk(x, y int) P {
        \\    return P{x, y}
        \\}
        \\
        \\func sum(p P) int {
        \\    return p.x + p.y
        \\}
        \\
        \\func split(b Box) (P, int, P) {
        \\    return b.lo, b.tag, b.hi
        \\}
        \\
        \\func grow(b Box, d int) Box {
        \\    mut c := b
        \\    c.hi.x += d
        \\    c.hi.y += d
        \\    return c
        \\}
        \\
        \\func main() {
        \\    a := mk(1, 2)
        \\    mut b := a
        \\    b.x = 10
        \\    box := Box{lo: a, hi: b, tag: 7}
        \\    big := grow(box, 5)
        \\    lo, tag, hi := split(big)
        \\    s := mk(3, 4) |> sum
        \\    t := box |> grow(1) |> split |> pick(_, _, _)
        \\    v := {
        \\        defer println(0)
        \\        mk(5, 6)
        \\    }
        \\    w := switch split(box) {
        \\    case _, 7, _: 1
        \\    default: 2
        \\    }
        \\    mut x, y := mk(1, 1), mk(2, 2)
        \\    x, y = y, x
        \\    println(a.x, b.x, box.hi.x, big.hi.x, big.hi.y, lo.y, tag, hi.x, s, t, v.y, w, x.x, y.x)
        \\}
        \\
        \\func pick(lo P, tag int, hi P) int {
        \\    return lo.x * 100 + tag * 10 + hi.y
        \\}
        \\
    , "0\n1 10 10 15 7 2 7 15 7 173 6 1 2 1\n");
}

test "inline lambdas: nesting, struct params, defer in lambda, return from mid-expression, pipe into inline, closure sees caller locals" {
    try expectRun(
        \\package main
        \\
        \\type P struct {
        \\    x, y int
        \\}
        \\
        \\func times(n int, f func(int)) {
        \\    mut i := 0
        \\    while i < n {
        \\        f(i)
        \\        i += 1
        \\    }
        \\}
        \\
        \\func with(p P, f func(P) int) int {
        \\    return 1000 + f(p)
        \\}
        \\
        \\func twice(f func() int) int {
        \\    return f() + f()
        \\}
        \\
        \\func mkp(a int, f func(int) P) P {
        \\    return f(a)
        \\}
        \\
        \\func grid(n int) int {
        \\    mut acc := 0
        \\    times(n, i => times(n, j => {
        \\        acc += i * j
        \\    }))
        \\    return acc
        \\}
        \\
        \\func early(n int) int {
        \\    v := 1 + twice(() => {
        \\        if n > 5 {
        \\            return 99
        \\        }
        \\        n
        \\    })
        \\    return v
        \\}
        \\
        \\func main() {
        \\    base := 7
        \\    a := with(P{2, 3}, p => p.x * 10 + p.y + base)
        \\    b := P{4, 5} |> with(p => {
        \\        defer println(-1)
        \\        p.y
        \\    })
        \\    c := mkp(6, k => P{k, k + 1})
        \\    println(grid(3), early(2), early(9), a, b, c.y)
        \\}
        \\
    , "-1\n9 5 99 1030 1005 7\n");
}

test "union: variant literals, nested patterns, whole-value bind, union in struct and as result, multi-subject mix" {
    try expectRun(
        \\package main
        \\
        \\type P struct {
        \\    x, y int
        \\}
        \\
        \\type Tree union {
        \\    Leaf { v int }
        \\    Pair {
        \\        a P
        \\        k Kind
        \\    }
        \\    Nil {}
        \\}
        \\
        \\type Kind union {
        \\    Big {}
        \\    Small { n int }
        \\}
        \\
        \\func weight(t Tree) int {
        \\    return switch t {
        \\    case Leaf{v: 0}: -1
        \\    case Leaf{v}: v
        \\    case Pair{a, k: Small{n}}: a.x + a.y + n
        \\    case whole Pair{k: Big{}}: 1000 + weight(Nil{}) + size(whole)
        \\    case Nil{}: 7
        \\    }
        \\}
        \\
        \\func size(t Tree) int {
        \\    return switch t {
        \\    case Pair{a}: a.x * a.y
        \\    case _: 0
        \\    }
        \\}
        \\
        \\func mk(n int) (Tree, int) {
        \\    return if n == 0 { Nil{} } else { Leaf{n} }, n * 2
        \\}
        \\
        \\func main() {
        \\    a := weight(Leaf{0})
        \\    b := weight(Leaf{5})
        \\    c := weight(Pair{P{1, 2}, Small{10}})
        \\    d := weight(Pair{a: P{3, 4}, k: Big{}})
        \\    e := weight(Nil{})
        \\    t, n := mk(0)
        \\    f := switch mk(4) {
        \\    case Leaf{v}, m: v * m
        \\    case _, _: 0
        \\    }
        \\    mut g := Leaf{1}
        \\    g = Nil{}
        \\    println(a, b, c, d, e, weight(t), n, f, weight(g))
        \\}
        \\
    , "-1 5 13 1019 7 7 0 32 7\n");
}

test "block expression and nested if chains as values" {
    try expectRun(
        \\package main
        \\
        \\func sign(n int) int {
        \\    return if n < 0 { -1 } else if n == 0 { 0 } else { 1 }
        \\}
        \\
        \\func main() {
        \\    v := {
        \\        a := 3
        \\        b := 4
        \\        a * a + b * b
        \\    }
        \\    println(sign(-5), sign(0), sign(9), v)
        \\}
        \\
    , "-1 0 1 25\n");
}

test "packages: cross-package funcs, consts, types, patterns run (language.md 20)" {
    const allocator = std.testing.allocator;
    const geo: [:0]const u8 =
        \\package geo
        \\
        \\const Scale = 3
        \\
        \\type Shape union {
        \\    Circle { r int }
        \\    Empty {}
        \\}
        \\
        \\func Area(s Shape) int {
        \\    return switch s {
        \\    case Circle{r}: r * r * Scale
        \\    case Empty{}: 0
        \\    }
        \\}
        \\
        \\func hidden(n int) int { return n * 2 }
        \\
        \\func Double(n int) int { return hidden(n) }
        \\
    ;
    const main_src: [:0]const u8 =
        \\package main
        \\
        \\import g "geo"
        \\
        \\const Local = g.Scale + 1
        \\
        \\func main() {
        \\    c := g.Circle{r: 2}
        \\    println(g.Area(c), g.Double(5), g.Scale, Local, switch c {
        \\    case g.Circle{r}: r
        \\    case g.Empty{}: -1
        \\    })
        \\}
        \\
    ;
    const files = [_]loader.SrcFile{
        .{ .pkg_path = "geo", .name = "geo/g.sober", .source = geo },
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = main_src },
    };
    const binary = try compileFiles(allocator, &files);
    defer allocator.free(binary);
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    try tmp.dir.writeFile(.{ .sub_path = "prog", .data = binary });
    const f = try tmp.dir.openFile("prog", .{});
    try f.chmod(0o755);
    f.close();
    const path = try tmp.dir.realpathAlloc(allocator, "prog");
    defer allocator.free(path);
    const result = try std.process.Child.run(.{ .allocator = allocator, .argv = &.{path} });
    defer allocator.free(result.stdout);
    defer allocator.free(result.stderr);
    try std.testing.expectEqualStrings("12 10 3 4 2\n", result.stdout);

    // 非公開名は境界を越えられない
    const bad = [_]loader.SrcFile{
        .{ .pkg_path = "geo", .name = "geo/g.sober", .source = geo },
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = "package main\nimport \"geo\"\nfunc main() { println(geo.hidden(1)) }\n" },
    };
    try std.testing.expectError(error.Unexported, compileFiles(allocator, &bad));
}

test "std/ prefix は std 表から解決する（表の中身は注入可能、ディスクは読まない）" {
    const allocator = std.testing.allocator;
    const fake: loader.StdTable = .{
        .paths = &.{ "std/pair/a.sober", "std/pair/b.sober", "std/pairx/c.sober" },
        .sources = &.{
            "package pair\nfunc Left() int { return 1 }\n",
            "package pair\nfunc Right() int { return Left() + 1 }\n",
            "package pairx\nfunc Bad() int { return oops }\n",
        },
    };
    const main_src = "package main\nimport \"std/pair\"\nfunc main() { println(pair.Right()) }\n";
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    var ldiag: loader.Diag = .{};
    const files = [_]loader.SrcFile{.{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = main_src }};
    // dirname 完全一致で束ねる — std/pairx は巻き込まない
    const prog = try loader.linkWithStd(allocator, arena.allocator(), &files, fake, &ldiag);
    var pair_files: usize = 0;
    for (prog.pkgs) |p| {
        if (std.mem.eql(u8, p.path, "std/pair")) pair_files = p.files.len;
        try std.testing.expect(!std.mem.eql(u8, p.path, "std/pairx"));
    }
    try std.testing.expectEqual(@as(usize, 2), pair_files);

    // 表に無い std package は LoadError
    const missing = [_]loader.SrcFile{.{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = "package main\nimport \"std/nope\"\nfunc main() { println(1) }\n" }};
    try std.testing.expectError(error.LoadError, loader.linkWithStd(allocator, arena.allocator(), &missing, fake, &ldiag));
    try std.testing.expectEqualStrings("no such std package", ldiag.what);
}

test "string 演算: ==/!=/+ は string 直、len / 添字 / [a:b] は bytes ビュー経由、mut の [a:b] は拒否" {
    try expectRun(
        \\package main
        \\func main() {
        \\    s := "hello world"
        \\    t := bytes(s)[0:5]
        \\    println(s == "hello world", s != "hello", len(bytes(s + "!")), len(t), t[4])
        \\}
    , "true true 12 5 111\n");
}

test "division: zero divisor panics, minInt / -1 wraps (Go), no SIGFPE" {
    try expectPanic("package main\nfunc f(a int, b int) int { return a / b }\nfunc main() { println(f(1, 0)) }\n");
    try expectPanic("package main\nfunc f(a int, b int) int { return a % b }\nfunc main() { println(f(1, 0)) }\n");
    try expectPanic("package main\nfunc main() {\n    mut x := 5\n    mut z := 0\n    x /= z\n    println(x)\n}\n");
    try expectRun(
        \\package main
        \\func q(a int, b int) int { return a / b }
        \\func r(a int, b int) int { return a % b }
        \\func main() {
        \\    m := 0 - 9223372036854775807 - 1
        \\    println(m, q(m, 0 - 1), r(m, 0 - 1), q(0 - 7, 2), r(0 - 7, 2))
        \\}
        \\
    , "-9223372036854775808 -9223372036854775808 0 -3 -1\n");
}

test "a qualified call's result count is known statically (an if arm that ends in pkg.F(...))" {
    const allocator = std.testing.allocator;
    const binary = try compileFiles(allocator, &.{
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = "package main\nimport \"lib\"\nfunc main() {\n    ok := if true { lib.F(2) } else { false }\n    println(ok)\n}\n" },
        .{ .pkg_path = "lib", .name = "lib.sober", .source = "package lib\nfunc F(x int) bool {\n    return x > 1\n}\n" },
    });
    allocator.free(binary);
}

test "--mem-trace (IR ランタイム): exit 時に深度別の割り当て総量を stderr へ出力する" {
    const allocator = std.testing.allocator;
    // main フレーム = 深度 1。先端一致の append ×3 は伸長のみ = 3 セル 24 byte。
    // scratch のフレーム（深度 2）の slice リテラルは 2 セル 16 byte で region と共に破棄
    const src =
        \\package main
        \\
        \\func scratch() int {
        \\    ys := []int{7, 8}
        \\    return len(ys)
        \\}
        \\
        \\func main() {
        \\    mut xs := mut []int{}
        \\    xs = append(xs, 1)
        \\    xs = append(xs, 2)
        \\    xs = append(xs, 3)
        \\    println(len(xs) + scratch())
        \\}
        \\
    ;
    const binary = try run.buildOpts(allocator, src, .{ .mem_trace = true });
    defer allocator.free(binary);
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    try tmp.dir.writeFile(.{ .sub_path = "prog", .data = binary });
    const f = try tmp.dir.openFile("prog", .{});
    try f.chmod(0o755);
    f.close();
    const path = try tmp.dir.realpathAlloc(allocator, "prog");
    defer allocator.free(path);
    const result = try std.process.Child.run(.{ .allocator = allocator, .argv = &.{path} });
    defer allocator.free(result.stdout);
    defer allocator.free(result.stderr);
    try std.testing.expectEqual(std.process.Child.Term{ .Exited = 0 }, result.term);
    try std.testing.expectEqualStrings("5\n", result.stdout);
    try std.testing.expectEqualStrings("1 24\n2 16\n0 40\n", result.stderr);
}


test "R2 mut_def: 再帰する mut 引数の関数は Def として呼び、mut 仮引数は呼び手のセルのアドレスで渡す（転送・Builder・相互再帰 + ?・mut slice の append はヘッダの region へ）" {
    try expectRun("package main\nfunc acc(s mut int, n int) {\n    if n > 0 {\n        s = s + n\n        acc(mut s, n - 1)\n    }\n}\nfunc main() {\n    mut t := 0\n    acc(mut t, 4)\n    println(t)\n}\n", "10\n");
    try expectRun("package main\nimport \"std/builder\"\nfunc fill(nb mut builder.Builder[int], n int) {\n    if n > 0 {\n        builder.Push(mut nb, n)\n        fill(mut nb, n - 1)\n    }\n}\nfunc main() {\n    mut nb := builder.Builder[int]{}\n    fill(mut nb, 3)\n    println(\"${builder.Len(mut nb)}\")\n}\n", "3\n");
    try expectRun("package main\ntype E error { pos int }\nfunc a(s mut int, n int) (int, error?) {\n    if n < 0 { return 0, E{pos: n} }\n    if n == 0 { return s, nil }\n    s = s + n\n    return b(mut s, n - 1)?, nil\n}\nfunc b(s mut int, n int) (int, error?) {\n    x := a(mut s, n)?\n    return x, nil\n}\nfunc main() {\n    mut s := 0\n    v, e := a(mut s, 3)\n    println(\"${v}\", s, e == nil)\n}\n", "6 6 true\n");
    try expectRun("package main\nfunc push(xs mut []int, n int) {\n    if n > 0 {\n        xs = append(xs, n)\n        push(mut xs, n - 1)\n    }\n}\nfunc noise(n int) int {\n    ys := []int{n, n, n, n, n, n, n, n, n, n}\n    return len(ys)\n}\nfunc main() {\n    mut xs := mut []int{}\n    push(mut xs, 4)\n    k := noise(7)\n    println(len(xs), xs[0], xs[3], k)\n}\n", "4 4 1 10\n");
}


test "R4a 深い relocate: 入れ子のコンテナを struct / union / map 経由で返し、戻った後に同じ深度を上書きしても中身が残る（浅い relocate ではここで壊れる）" {
    try expectRun("package main\nimport \"std/strings\"\ntype Rec struct {\n    name string\n    tags []string\n}\ntype Box union { Empty {}; Full { rs []Rec } }\nfunc words(n int) []string {\n    mut out := mut []string{}\n    mut i := 0\n    while i < n {\n        out = append(out, \"w\" + strings.Itoa(i))\n        i += 1\n    }\n    return freeze(out)\n}\nfunc recs() []Rec {\n    mut out := mut []Rec{}\n    out = append(out, Rec{name: \"a\" + \"b\", tags: words(2)})\n    out = append(out, Rec{name: \"c\" + \"d\", tags: words(3)})\n    return freeze(out)\n}\nfunc box(full bool) Box {\n    if full { return Full{rs: recs()} }\n    return Empty{}\n}\nfunc dict() map[string][]string {\n    mut m := mut map[string][]string{}\n    m[\"k\" + \"1\"] = words(2)\n    m[\"k\" + \"2\"] = words(1)\n    m[\"k\" + \"3\"] = words(4)\n    delete(m, \"k2\")\n    return freeze(m)\n}\n// 同じ深度の region を上書きする\nfunc noise(n int) int {\n    mut xs := mut []string{}\n    mut i := 0\n    while i < n {\n        xs = append(xs, \"zzzzzzzzzzzzzzzz\" + strings.Itoa(i))\n        i += 1\n    }\n    return len(xs)\n}\nfunc showBox(b Box) {\n    switch b {\n    case Full{rs}: {\n        r := rs[1]\n        println(len(rs), r.tags[0])\n    }\n    case Empty{}: println(\"empty\")\n    }\n}\nfunc showKey(m map[string][]string, k string, i int) {\n    v := m[k]\n    if v != nil { println(k, len(v), v[i]) } else { println(k, \"none\") }\n}\nfunc main() {\n    rs := recs()\n    b := box(true)\n    m := dict()\n    k := noise(50)\n    println(rs[0].name, rs[1].name, rs[0].tags[1], rs[1].tags[2], k)\n    showBox(b)\n    println(len(m))\n    showKey(m, \"k1\", 1)\n    showKey(m, \"k2\", 0)\n    showKey(m, \"k3\", 3)\n}\n", "ab cd w1 w2 50\n2 w0\n2\nk1 2 w1\nk2 none\nk3 4 w3\n");
}


test "脱出の境界コピー: 式ブロックで作った string の早期 return（defer が間で確保）と、inline の return / ? — inline は呼び出し点の最内へ写す（写さないと後の確保に上書きされて zzzzz になっていた）" {
    try expectRun("package main\nfunc early(n int) string {\n    defer println(\"d\" + \"1\")\n    s := {\n        t := \"ab\" + \"cd\"\n        t + \"!\"\n    }\n    if n > 0 { return s }\n    return \"no\"\n}\nfunc noise() int {\n    mut xs := mut []string{}\n    mut i := 0\n    while i < 20 {\n        xs = append(xs, \"zzzzz\" + \"zzzzz\")\n        i += 1\n    }\n    return len(xs)\n}\nfunc main() {\n    r := early(1)\n    k := noise()\n    println(r, k)\n}\n", "d1\nabcd! 20\n");
    try expectRun("package main\nfunc pick(f func(int) int, n int) string {\n    s := {\n        t := \"ab\" + \"cd\"\n        t + \"!\"\n    }\n    if f(n) > 0 { return s }\n    return \"no\"\n}\nfunc noise() int {\n    mut xs := mut []string{}\n    mut i := 0\n    while i < 20 {\n        xs = append(xs, \"zzzzz\" + \"zzzzz\")\n        i += 1\n    }\n    return len(xs)\n}\nfunc main() {\n    r := pick((x) => x + 1, 1)\n    k := noise()\n    println(r, k)\n}\n", "abcd! 20\n");
    try expectRun("package main\ntype Bad error { why string }\nfunc fail(n int) (int, error?) {\n    if n > 0 { return 0, Bad{why: \"bad\" + \"!\"} }\n    return 1, nil\n}\nfunc step(f func(int) int, n int) (string, error?) {\n    x := fail(f(n))?\n    s := {\n        t := \"ok\" + \"?\"\n        t + \"!\"\n    }\n    return s, nil\n}\nfunc noise() int {\n    mut xs := mut []string{}\n    mut i := 0\n    while i < 20 {\n        xs = append(xs, \"zzzzz\" + \"zzzzz\")\n        i += 1\n    }\n    return len(xs)\n}\nfunc reason(e error) string {\n    return switch e {\n    case Bad{why}: why\n    }\n}\nfunc show(e error?) string {\n    return if e != nil { reason(e) } else { \"-\" }\n}\nfunc main() {\n    a, e1 := step((x) => x - 1, 1)\n    b, e2 := step((x) => x, 1)\n    k := noise()\n    println(a, show(e1), b, show(e2), k)\n}\n", "ok?! -  bad! 20\n");
}


test "K1'' error の鎖と cause: 包み替えが内側を鎖に積み、case L{…, cause} で 1 段ずつ辿れる。鎖の string は戻りと ? の脱出で呼び手へ写り、上書きの後も残る" {
    try expectRun("package main\n\n// R4b（region 多相の裁定 — cause K1''）の検証例: 包み替え `f()? L{...}` は内側の error を捨てず鎖に積み、\n// `case L{..., cause}` で 1 段ずつ辿れる。error = 先頭ラベル + 鎖（imm []L）。ラベルの string は\n// 呼び手の引数・callee で構築したものが混ざり、`?` の脱出（jump の境界コピー — R4b α）と戻りの深い relocate（R4a）で\n// 鎖ごと呼び手の region へ写る\n\ntype NotFound error {\n    path string\n}\n\ntype Wrapped error {\n    step int\n}\n\ntype Bad error {\n    code int\n}\n\nfunc open(p string) (int, error?) {\n    if p == \"ok\" {\n        return 2, nil\n    }\n    return 0, NotFound{path: p + \".txt\"}\n}\n\nfunc load(p string, step int) (int, error?) {\n    n := open(p)? Wrapped{step: step}\n    return n * 10, nil\n}\n\nfunc outer(p string) (int, error?) {\n    n := load(p, 2)? Wrapped{step: 1}\n    return n + 1, nil\n}\n\n// 包まない `?` は鎖を伸ばさない\nfunc plain(n int) (int, error?) {\n    if n < 0 {\n        return 0, Bad{code: n}\n    }\n    return n, nil\n}\n\nfunc passThrough(n int) (int, error?) {\n    m := plain(n)?\n    return m, nil\n}\n\n// 鎖を外側から 1 段ずつ辿る（cause = 1 つ内側の error?）\nfunc show(e error?) {\n    if e != nil {\n        switch e {\n        case Wrapped{step, cause}:\n            println(\"wrapped ${step}\")\n            show(cause)\n        case NotFound{path, cause}:\n            println(\"not found: ${path}\")\n            show(cause)\n        case Bad{code, cause}:\n            println(\"bad ${code}\")\n            show(cause)\n        }\n    } else {\n        println(\"end\")\n    }\n}\n\nfunc noise() int {\n    mut xs := mut []string{}\n    mut i := 0\n    while i < 30 {\n        xs = append(xs, \"zzzzzzzz\" + \"zzzzzzzz\")\n        i += 1\n    }\n    return len(xs)\n}\n\nfunc main() {\n    n1, e1 := outer(\"a\")\n    k := noise()\n    show(e1)\n    n2, e2 := outer(\"ok\")\n    show(e2)\n    _, e3 := passThrough(0 - 4)\n    show(e3)\n    println(\"${n1 + n2}\")\n}\n", "wrapped 1\nwrapped 2\nnot found: a.txt\nend\nend\nbad -4\nend\n21\n");
}
