//! AST → コア AST JSON の脱糖テスト。
//! 期待値はコア AST の JSON（スキーマは lean/FeatherweightSober/Json.lean が正）。
//! 末尾の統合テストは sober-check（Lean 製検査器）が見つかれば判定まで通す。
const std = @import("std");
const desugar = @import("desugar.zig");
const loader = @import("loader.zig");

fn toCoreJsonFiles(allocator: std.mem.Allocator, files: []const loader.SrcFile) ![]u8 {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    var ldiag: loader.Diag = .{};
    const prog = loader.link(allocator, arena.allocator(), files, &ldiag, .{}) catch |err| {
        if (err != error.Unsupported and err != error.Malformed and err != error.LoadError)
            std.debug.print("link: {s} at {s} what={s}\n", .{ @errorName(err), ldiag.path, ldiag.what });
        return err;
    };
    var ddiag: desugar.Diag = .{};
    var core = desugar.desugar(allocator, &prog, &ddiag) catch |err| {
        if (err != error.CoreFragment and err != error.UnknownName and err != error.Malformed)
            std.debug.print("desugar: {s} what={s}\n", .{ @errorName(err), ddiag.what });
        return err;
    };
    defer core.deinit();
    return desugar.toJson(allocator, core);
}

fn toCoreJson(allocator: std.mem.Allocator, source: [:0]const u8) ![]u8 {
    return toCoreJsonFiles(allocator, &.{.{ .pkg_path = loader.main_pkg_path, .name = "test.sober", .source = source }});
}

fn expectCore(source: [:0]const u8, expected: []const u8) !void {
    const json = try toCoreJson(std.testing.allocator, source);
    defer std.testing.allocator.free(json);
    try std.testing.expectEqualStrings(expected, json);
}

fn expectReject(source: [:0]const u8, expected_err: anyerror) !void {
    const result = toCoreJson(std.testing.allocator, source);
    try std.testing.expectError(expected_err, result);
}

// ── 対応の基本形 ──────────────────────────────

test "main body wraps in a block; tail return is the value" {
    try expectCore("package main\nfunc main() { return 1 }\n",
        \\{"k":"block","e":{"k":"lit","n":1}}
    );
}

test "bind becomes letE; names resolve to de Bruijn indices" {
    try expectCore("package main\nfunc main() { x := 1; y := 2; return x + y }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":1},"body":{"k":"let","e":{"k":"lit","n":2},"body":{"k":"add","a":{"k":"var","i":1},"b":{"k":"var","i":0}}}}}
    );
}

test "mut bind is alloc, read is deref, assignment is assign" {
    try expectCore("package main\nfunc main() { mut x := 1; x = x + 2; return x }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":1}},"body":{"k":"let","e":{"k":"assign","l":{"k":"var","i":0},"e":{"k":"add","a":{"k":"deref","e":{"k":"var","i":0}},"b":{"k":"lit","n":2}}},"body":{"k":"deref","e":{"k":"var","i":1}}}}}
    );
}

test "+= expands to assign with add on the deref" {
    try expectCore("package main\nfunc main() { mut x := 0; x += 3; return 0 }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":0}},"body":{"k":"let","e":{"k":"assign","l":{"k":"var","i":0},"e":{"k":"add","a":{"k":"deref","e":{"k":"var","i":0}},"b":{"k":"lit","n":3}}},"body":{"k":"lit","n":0}}}}
    );
}

test "while body chains to triv; statement position uses an anonymous binder" {
    try expectCore("package main\nfunc main() { mut i := 0; while i < 3 { i += 1 }\n return i }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":0}},"body":{"k":"let","e":{"k":"while","c":{"k":"lt","a":{"k":"deref","e":{"k":"var","i":0}},"b":{"k":"lit","n":3}},"body":{"k":"let","e":{"k":"assign","l":{"k":"var","i":0},"e":{"k":"add","a":{"k":"deref","e":{"k":"var","i":0}},"b":{"k":"lit","n":1}}},"body":{"k":"triv"}}},"body":{"k":"deref","e":{"k":"var","i":1}}}}}
    );
}

test "if with else is ite; if without else gets a triv arm" {
    try expectCore("package main\nfunc main() { return if 1 < 2 { 3 } else { 4 } }\n",
        \\{"k":"block","e":{"k":"if","c":{"k":"lt","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}},"t":{"k":"lit","n":3},"e":{"k":"lit","n":4}}}
    );
    try expectCore("package main\nfunc main() { mut x := 0\n if x < 1 { x = 9 }\n return x }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":0}},"body":{"k":"let","e":{"k":"if","c":{"k":"lt","a":{"k":"deref","e":{"k":"var","i":0}},"b":{"k":"lit","n":1}},"t":{"k":"let","e":{"k":"assign","l":{"k":"var","i":0},"e":{"k":"lit","n":9}},"body":{"k":"triv"}},"e":{"k":"triv"}},"body":{"k":"deref","e":{"k":"var","i":1}}}}}
    );
}

test "expression block is a region boundary (block)" {
    try expectCore("package main\nfunc main() { return { 7 } }\n",
        \\{"k":"block","e":{"k":"block","e":{"k":"lit","n":7}}}
    );
}

test "unary minus folds into the literal" {
    try expectCore("package main\nfunc main() { return -5 }\n",
        \\{"k":"block","e":{"k":"lit","n":-5}}
    );
}

// ── union: inl / inr / case ──────────────────────────────

const shape_prelude =
    \\package main
    \\
    \\type Shape union {
    \\    Circle { r int }
    \\    Empty {}
    \\}
    \\
;

test "composite of variant 0 is inl annotated with the other payload type" {
    try expectCore(shape_prelude ++ "func main() { s := Circle{r: 4}; return 0 }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"inl","r":{"k":"unit"},"e":{"k":"lit","n":4}},"body":{"k":"lit","n":0}}}
    );
}

test "composite of variant 1 is inr; empty variant carries triv" {
    try expectCore(shape_prelude ++ "func main() { s := Empty{}; return 0 }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"inr","l":{"k":"int"},"e":{"k":"triv"}},"body":{"k":"lit","n":0}}}
    );
}

test "switch with type patterns is case; the field name binds var 0" {
    try expectCore(shape_prelude ++
        \\func main() {
        \\    s := Circle{r: 4}
        \\    return switch s {
        \\    case Circle{r}: r + 1
        \\    case Empty{}: 0
        \\    }
        \\}
        \\
    ,
        \\{"k":"block","e":{"k":"let","e":{"k":"inl","r":{"k":"unit"},"e":{"k":"lit","n":4}},"body":{"k":"case","e":{"k":"var","i":0},"l":{"k":"add","a":{"k":"var","i":0},"b":{"k":"lit","n":1}},"r":{"k":"lit","n":0}}}}
    );
}

test "switch default fills the missing variant arm" {
    try expectCore(shape_prelude ++
        \\func main() {
        \\    s := Empty{}
        \\    return switch s {
        \\    case Circle{r}: r
        \\    default: 9
        \\    }
        \\}
        \\
    ,
        \\{"k":"block","e":{"k":"let","e":{"k":"inr","l":{"k":"int"},"e":{"k":"triv"}},"body":{"k":"case","e":{"k":"var","i":0},"l":{"k":"var","i":0},"r":{"k":"lit","n":9}}}}
    );
}

// ── n 項化: struct（prod 鎖）・n-ary union・多値の同時束縛 ──────────────────────────────

test "struct literal is a pair chain; selectors are projections" {
    try expectCore(
        \\package main
        \\
        \\type Point struct {
        \\    x, y, z int
        \\}
        \\
        \\func main() {
        \\    p := Point{1, 2, 3}
        \\    return p.x + p.z
        \\}
        \\
    ,
        \\{"k":"block","e":{"k":"let","e":{"k":"pair","a":{"k":"lit","n":1},"b":{"k":"pair","a":{"k":"lit","n":2},"b":{"k":"lit","n":3}}},"body":{"k":"add","a":{"k":"fst","e":{"k":"var","i":0}},"b":{"k":"snd","e":{"k":"snd","e":{"k":"var","i":0}}}}}}
    );
}

test "field assignment rebuilds the pair chain" {
    try expectCore(
        \\package main
        \\
        \\type Point struct {
        \\    x, y int
        \\}
        \\
        \\func main() {
        \\    mut p := Point{1, 2}
        \\    p.y = 9
        \\    return p.y
        \\}
        \\
    ,
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"pair","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}}},"body":{"k":"let","e":{"k":"let","e":{"k":"lit","n":9},"body":{"k":"assign","l":{"k":"var","i":1},"e":{"k":"pair","a":{"k":"fst","e":{"k":"deref","e":{"k":"var","i":1}}},"b":{"k":"var","i":0}}}},"body":{"k":"snd","e":{"k":"deref","e":{"k":"var","i":1}}}}}}
    );
}

test "3-variant union nests binary unions; switch nests cases" {
    try expectCore(
        \\package main
        \\
        \\type Shape union {
        \\    Circle { r int }
        \\    Rect { w, h int }
        \\    Empty {}
        \\}
        \\
        \\func main() {
        \\    s := Rect{2, 3}
        \\    return switch s {
        \\    case Circle{r}: r
        \\    case Rect{w, h}: w * h
        \\    case Empty{}: 0
        \\    }
        \\}
        \\
    ,
        \\{"k":"block","e":{"k":"let","e":{"k":"inr","l":{"k":"int"},"e":{"k":"inl","r":{"k":"unit"},"e":{"k":"pair","a":{"k":"lit","n":2},"b":{"k":"lit","n":3}}}},"body":{"k":"case","e":{"k":"var","i":0},"l":{"k":"var","i":0},"r":{"k":"case","e":{"k":"var","i":0},"l":{"k":"let","e":{"k":"fst","e":{"k":"var","i":0}},"body":{"k":"let","e":{"k":"snd","e":{"k":"var","i":1}},"body":{"k":"mul","a":{"k":"var","i":1},"b":{"k":"var","i":0}}}},"r":{"k":"lit","n":0}}}}}
    );
}

test "simultaneous bind and assignment evaluate all values first" {
    try expectCore("package main\nfunc main() { mut x, y := 1, 2\n x, y = y, x\n return x + y }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":1}},"body":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":2}},"body":{"k":"let","e":{"k":"let","e":{"k":"deref","e":{"k":"var","i":0}},"body":{"k":"let","e":{"k":"deref","e":{"k":"var","i":2}},"body":{"k":"let","e":{"k":"assign","l":{"k":"var","i":3},"e":{"k":"var","i":1}},"body":{"k":"let","e":{"k":"assign","l":{"k":"var","i":3},"e":{"k":"var","i":1}},"body":{"k":"triv"}}}}},"body":{"k":"add","a":{"k":"deref","e":{"k":"var","i":2}},"b":{"k":"deref","e":{"k":"var","i":1}}}}}}}
    );
}

// ── inline 展開 ──────────────────────────────

test "inline function expands at the call site; value args become letE" {
    try expectCore(
        \\package main
        \\
        \\func twice(x int, f func(int) int) int {
        \\    return f(x) + f(x)
        \\}
        \\
        \\func main() {
        \\    n := 3
        \\    return twice(n, a => a + n)
        \\}
        \\
    ,
        // n = var(外), twice の x が letE で束縛され、f(x) はラムダ本体 a + n に展開される
        // （a は引数の letE 束縛、n は定義時 env から）
        // 仮引数 x・ラムダの引数 a・ラムダの結果は ann で型を残す（V3-5 ③ — 検査は Lean）
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":3},"body":{"k":"let","e":{"k":"ann","e":{"k":"var","i":0},"t":{"k":"int"}},"body":{"k":"add","a":{"k":"let","e":{"k":"ann","e":{"k":"var","i":0},"t":{"k":"int"}},"body":{"k":"ann","e":{"k":"add","a":{"k":"var","i":0},"b":{"k":"var","i":2}},"t":{"k":"int"}}},"b":{"k":"let","e":{"k":"ann","e":{"k":"var","i":0},"t":{"k":"int"}},"body":{"k":"ann","e":{"k":"add","a":{"k":"var","i":0},"b":{"k":"var","i":2}},"t":{"k":"int"}}}}}}}
    );
}

test "pipe desugars to a call (lhs as the first argument)" {
    try expectCore(
        \\package main
        \\
        \\func id(x int, f func(int) int) int {
        \\    return f(x)
        \\}
        \\
        \\func main() {
        \\    return 5 |> id(a => a + 1)
        \\}
        \\
    ,
        \\{"k":"block","e":{"k":"let","e":{"k":"ann","e":{"k":"lit","n":5},"t":{"k":"int"}},"body":{"k":"let","e":{"k":"ann","e":{"k":"var","i":0},"t":{"k":"int"}},"body":{"k":"ann","e":{"k":"add","a":{"k":"var","i":0},"b":{"k":"lit","n":1}},"t":{"k":"int"}}}}}
    );
}

// ── 関数（一階）: call と関数表 ──────────────────────────────

test "non-inline functions become defs; recursion calls by index (fib)" {
    try expectCore(
        \\package main
        \\
        \\func fib(n int) int {
        \\    return if n < 2 { n } else { fib(n - 1) + fib(n - 2) }
        \\}
        \\
        \\func main() {
        \\    return fib(10)
        \\}
        \\
    ,
        \\{"defs":[{"param":{"k":"int"},"ret":{"k":"int"},"body":{"k":"if","c":{"k":"lt","a":{"k":"var","i":0},"b":{"k":"lit","n":2}},"t":{"k":"var","i":0},"e":{"k":"add","a":{"k":"call","f":0,"e":{"k":"sub","a":{"k":"var","i":0},"b":{"k":"lit","n":1}}},"b":{"k":"call","f":0,"e":{"k":"sub","a":{"k":"var","i":0},"b":{"k":"lit","n":2}}}}}}],"e":{"k":"block","e":{"k":"call","f":0,"e":{"k":"lit","n":10}}}}
    );
}

test "multi-parameter functions pack args into a pair; multi-value return is a pair" {
    try expectCore(
        \\package main
        \\
        \\func divmod(a, b int) (int, int) {
        \\    return a / b, a % b
        \\}
        \\
        \\func main() {
        \\    q, r := divmod(7, 2)
        \\    return q + r
        \\}
        \\
    ,
        \\{"defs":[{"param":{"k":"prod","l":{"k":"int"},"r":{"k":"int"}},"ret":{"k":"prod","l":{"k":"int"},"r":{"k":"int"}},"body":{"k":"let","e":{"k":"fst","e":{"k":"var","i":0}},"body":{"k":"let","e":{"k":"snd","e":{"k":"var","i":1}},"body":{"k":"pair","a":{"k":"div","a":{"k":"var","i":1},"b":{"k":"var","i":0}},"b":{"k":"mod","a":{"k":"var","i":1},"b":{"k":"var","i":0}}}}}}],"e":{"k":"block","e":{"k":"let","e":{"k":"call","f":0,"e":{"k":"pair","a":{"k":"lit","n":7},"b":{"k":"lit","n":2}}},"body":{"k":"let","e":{"k":"fst","e":{"k":"var","i":0}},"body":{"k":"let","e":{"k":"snd","e":{"k":"var","i":1}},"body":{"k":"add","a":{"k":"var","i":1},"b":{"k":"var","i":0}}}}}}}
    );
}

// ── 断片の外は拒否 ──────────────────────────────

test "arith/cmp operators map to flat kinds" {
    try expectCore("package main\nfunc main() { return 10 - 3 * 2 }\n",
        \\{"k":"block","e":{"k":"sub","a":{"k":"lit","n":10},"b":{"k":"mul","a":{"k":"lit","n":3},"b":{"k":"lit","n":2}}}}
    );
    try expectCore("package main\nfunc main() { return 7 / 2 % 3 }\n",
        \\{"k":"block","e":{"k":"mod","a":{"k":"div","a":{"k":"lit","n":7},"b":{"k":"lit","n":2}},"b":{"k":"lit","n":3}}}
    );
    try expectCore("package main\nfunc main() { return 1 == 2 }\n",
        \\{"k":"block","e":{"k":"eq","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}}}
    );
    try expectCore("package main\nfunc main() { return 1 >= 2 }\n",
        \\{"k":"block","e":{"k":"ge","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}}}
    );
}

test "short-circuit && || and ! desugar to ite; unary minus to sub from 0" {
    try expectCore("package main\nfunc main() { return 1 < 2 && 2 < 3 }\n",
        \\{"k":"block","e":{"k":"if","c":{"k":"lt","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}},"t":{"k":"lt","a":{"k":"lit","n":2},"b":{"k":"lit","n":3}},"e":{"k":"false"}}}
    );
    try expectCore("package main\nfunc main() { return 1 < 2 || 2 < 3 }\n",
        \\{"k":"block","e":{"k":"if","c":{"k":"lt","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}},"t":{"k":"true"},"e":{"k":"lt","a":{"k":"lit","n":2},"b":{"k":"lit","n":3}}}}
    );
    try expectCore("package main\nfunc main() { return !(1 < 2) }\n",
        \\{"k":"block","e":{"k":"if","c":{"k":"lt","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}},"t":{"k":"false"},"e":{"k":"true"}}}
    );
    try expectCore("package main\nfunc main() { x := 3\n return -x }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":3},"body":{"k":"sub","a":{"k":"lit","n":0},"b":{"k":"var","i":0}}}}
    );
}

test "compound assignments expand through the operator families" {
    try expectCore("package main\nfunc main() { mut x := 9\n x /= 2\n return x }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":9}},"body":{"k":"let","e":{"k":"assign","l":{"k":"var","i":0},"e":{"k":"div","a":{"k":"deref","e":{"k":"var","i":0}},"b":{"k":"lit","n":2}}},"body":{"k":"deref","e":{"k":"var","i":1}}}}}
    );
}

test "bitwise operators map to and/or/xor; unary ^ is xor with -1; shifts map to shl/shr" {
    try expectCore("package main\nfunc main() { return 6 & 3 }\n",
        \\{"k":"block","e":{"k":"and","a":{"k":"lit","n":6},"b":{"k":"lit","n":3}}}
    );
    try expectCore("package main\nfunc main() { return 6 | 3 }\n",
        \\{"k":"block","e":{"k":"or","a":{"k":"lit","n":6},"b":{"k":"lit","n":3}}}
    );
    try expectCore("package main\nfunc main() { return 6 ^ 3 }\n",
        \\{"k":"block","e":{"k":"xor","a":{"k":"lit","n":6},"b":{"k":"lit","n":3}}}
    );
    try expectCore("package main\nfunc main() { return ^6 }\n",
        \\{"k":"block","e":{"k":"xor","a":{"k":"lit","n":6},"b":{"k":"lit","n":-1}}}
    );
    try expectCore("package main\nfunc main() { mut x := 6\n x &= 3\n return x }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":6}},"body":{"k":"let","e":{"k":"assign","l":{"k":"var","i":0},"e":{"k":"and","a":{"k":"deref","e":{"k":"var","i":0}},"b":{"k":"lit","n":3}}},"body":{"k":"deref","e":{"k":"var","i":1}}}}}
    );
    try expectCore("package main\nfunc main() { return 6 << 1 }\n",
        \\{"k":"block","e":{"k":"shl","a":{"k":"lit","n":6},"b":{"k":"lit","n":1}}}
    );
    try expectCore("package main\nfunc main() { return 6 >> 1 }\n",
        \\{"k":"block","e":{"k":"shr","a":{"k":"lit","n":6},"b":{"k":"lit","n":1}}}
    );
}

test "constant switch desugars to let + eq/ite chains" {
    // 単値 subject は letE で 1 回評価、case は eq の ite 連鎖
    try expectCore("package main\nfunc main() { return switch 1 {\ncase 1: 10\ndefault: 20\n} }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":1},"body":{"k":"if","c":{"k":"eq","a":{"k":"var","i":0},"b":{"k":"lit","n":1}},"t":{"k":"lit","n":10},"e":{"k":"lit","n":20}}}}
    );
    // `1 | 2` の選択肢は or（ite 脱糖）の左から短絡
    try expectCore("package main\nfunc main() { return switch 5 {\ncase 1 | 2: 10\ndefault: 20\n} }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":5},"body":{"k":"if","c":{"k":"if","c":{"k":"eq","a":{"k":"var","i":0},"b":{"k":"lit","n":1}},"t":{"k":"true"},"e":{"k":"eq","a":{"k":"var","i":0},"b":{"k":"lit","n":2}}},"t":{"k":"lit","n":10},"e":{"k":"lit","n":20}}}}
    );
    // subject 無しは条件式そのまま
    try expectCore("package main\nfunc main() { return switch {\ncase 1 < 2: 10\ndefault: 20\n} }\n",
        \\{"k":"block","e":{"k":"if","c":{"k":"lt","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}},"t":{"k":"lit","n":10},"e":{"k":"lit","n":20}}}
    );
    // 裸の未知の識別子は subject の値の束縛（以降の case は不到達で消える）
    try expectCore("package main\nfunc main() { return switch 7 {\ncase v: v\ndefault: 0\n} }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":7},"body":{"k":"var","i":0}}}
    );
    // `_` は常に一致
    try expectCore("package main\nfunc main() { return switch 7 {\ncase _: 1\n} }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":7},"body":{"k":"lit","n":1}}}
    );
    // 多値呼び出しを単一 subject に置く形は R4 で回収（"multi-value call subject" のテスト）
}

test "T?: nil annotation, implicit some, ifnil flow typing, nil tag test" {
    // return の期待型 int? が if の腕に押し込まれ、nil は注釈つき、int の腕は some で包まれる。
    // `if x != nil` は ifnil（some 腕で x が var 0 = ペイロードに再束縛）、`x == nil` はタグ検査
    try expectCore(
        "package main\nfunc f(k int) int? { return if k < 1 { nil } else { k } }\n" ++
            "func main() {\n    x := f(0)\n    if x != nil { println(x) }\n    println(x == nil)\n}\n",
        \\{"defs":[{"param":{"k":"int"},"ret":{"k":"opt","t":{"k":"int"}},"body":{"k":"if","c":{"k":"lt","a":{"k":"var","i":0},"b":{"k":"lit","n":1}},"t":{"k":"nil","t":{"k":"int"}},"e":{"k":"some","e":{"k":"var","i":0}}}}],"e":{"k":"block","e":{"k":"let","e":{"k":"call","f":0,"e":{"k":"lit","n":0}},"body":{"k":"let","e":{"k":"ifnil","e":{"k":"var","i":0},"nil":{"k":"triv"},"some":{"k":"let","e":{"k":"let","e":{"k":"var","i":0},"body":{"k":"triv"}},"body":{"k":"triv"}}},"body":{"k":"let","e":{"k":"ifnil","e":{"k":"var","i":1},"nil":{"k":"true"},"some":{"k":"false"}},"body":{"k":"triv"}}}}}}
    );
    // nil は T? の期待がある場所にしか書けない
    try expectReject("package main\nfunc main() { x := nil\n println(x) }\n", error.CoreFragment);
    try expectReject("package main\nfunc main() { println(1 + nil) }\n", error.CoreFragment);
}

test "error labels (V4-4a): one label is the bare payload, a let-bound switch; two labels nest in declaration order" {
    try expectCore("package main\ntype Bad error { at int }\nfunc main() { e := Bad{at: 3}; x := switch e { case Bad{at}: at }; return 0 }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"pair","a":{"k":"lit","n":3},"b":{"k":"freeze","e":{"k":"mkslice","m":true,"t":{"k":"int"}}}},"body":{"k":"let","e":{"k":"let","e":{"k":"var","i":0},"body":{"k":"let","e":{"k":"fst","e":{"k":"var","i":0}},"body":{"k":"var","i":0}}},"body":{"k":"lit","n":0}}}}
    );
    try expectCore("package main\ntype A error\ntype B error { n int }\nfunc main() { e := B{n: 3}; f := A{}; return 0 }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"pair","a":{"k":"inr","l":{"k":"unit"},"e":{"k":"lit","n":3}},"b":{"k":"freeze","e":{"k":"mkslice","m":true,"t":{"k":"union","l":{"k":"unit"},"r":{"k":"int"}}}}},"body":{"k":"let","e":{"k":"pair","a":{"k":"inl","r":{"k":"int"},"e":{"k":"triv"}},"b":{"k":"freeze","e":{"k":"mkslice","m":true,"t":{"k":"union","l":{"k":"unit"},"r":{"k":"int"}}}}},"body":{"k":"lit","n":0}}}}
    );
}

test "error labels are not types and cannot hold an error (V4 has no cause)" {
    try expectReject("package main\ntype A error\nfunc f(x A) int { return 1 }\nfunc main() { return 0 }\n", error.Malformed);
    try expectReject("package main\ntype A error { inner error? }\nfunc main() { return 0 }\n", error.LoadError);
}

test "error label fields may hold string / slice / map (R0: L1 lifted) — load, build and check" {
    const allocator = std.testing.allocator;
    const pre = "package main\ntype NotFound error { path string }\ntype Many error { xs []int }\n" ++
        "type W struct { n int\n s string }\ntype Wrapped error { w W? }\ntype Code error { c int }\n";
    const cases = [_][:0]const u8{
        // 呼び手の string をそのままラベルへ（sf3）
        pre ++ "func f(p string) (int, error?) { return 0, NotFound{path: p} }\nfunc main() { _, e := f(\"a\")\n if e != nil { println(\"x\") } }\n",
        // callee で構築した string（sf2）・slice
        pre ++ "func f(p string) (int, error?) { return 0, NotFound{path: p + \".bak\"} }\nfunc main() { _, e := f(\"a\")\n if e != nil { println(\"x\") } }\n",
        pre ++ "func f() (int, error?) { return 0, Many{xs: append([]int{}, 1)} }\nfunc main() { _, e := f()\n if e != nil { println(\"x\") } }\n",
        // 1 段 ? で伝播（sf4）
        pre ++ "func f(p string) (int, error?) { return 0, NotFound{path: p} }\nfunc g(p string) (int, error?) { x := f(p)?\n return x, nil }\nfunc main() { _, e := g(\"a\")\n if e != nil { println(\"x\") } }\n",
        // string ラベルが宣言だけされていて int ラベルしか返さない（sf6）
        pre ++ "func f(n int) (int, error?) { if n > 0 { return n, nil }\n return 0, Code{c: n} }\nfunc main() { _, e := f(1)\n if e != nil { println(\"x\") } }\n",
        // struct の T? の中の string
        pre ++ "func f(p string) (int, error?) { return 0, Wrapped{w: W{n: 1, s: p}} }\nfunc main() { _, e := f(\"a\")\n if e != nil { println(\"x\") } }\n",
        // パターンで束縛した string フィールドの補間
        pre ++ "func f(p string) (int, error?) { return 0, NotFound{path: p} }\nfunc main() { _, e := f(\"a\")\n if e != nil { switch e { case NotFound{path}: println(\"${path}\")\n default: println(\"y\") } } }\n",
    };
    for (cases) |src| {
        try std.testing.expect(try buildAccepts(allocator, src));
        try std.testing.expect(try checkAccepts(allocator, src));
    }
}

test "postfix ? (V4-4b, S1): let p = call in (ifnil (last p) triv (jump k unit (zeros, some err)); init p)" {
    try expectCore("package main\ntype E error\nfunc g() (int, error?) { return 1, nil }\nfunc f() (int, error?) { x := g()?; return x, nil }\nfunc main() { return 0 }\n",
        \\{"defs":[{"param":{"k":"unit"},"ret":{"k":"prod","l":{"k":"int"},"r":{"k":"opt","t":{"k":"prod","l":{"k":"unit"},"r":{"k":"slice","m":false,"r":1,"t":{"k":"unit"}}}}},"body":{"k":"pair","a":{"k":"lit","n":1},"b":{"k":"ann","e":{"k":"nil","t":{"k":"prod","l":{"k":"unit"},"r":{"k":"slice","m":false,"r":1,"t":{"k":"unit"}}}},"t":{"k":"opt","t":{"k":"prod","l":{"k":"unit"},"r":{"k":"slice","m":false,"r":1,"t":{"k":"unit"}}}}}}},{"param":{"k":"unit"},"ret":{"k":"prod","l":{"k":"int"},"r":{"k":"opt","t":{"k":"prod","l":{"k":"unit"},"r":{"k":"slice","m":false,"r":1,"t":{"k":"unit"}}}}},"body":{"k":"label","t":{"k":"prod","l":{"k":"int"},"r":{"k":"opt","t":{"k":"prod","l":{"k":"unit"},"r":{"k":"slice","m":false,"r":1,"t":{"k":"unit"}}}}},"e":{"k":"let","e":{"k":"let","e":{"k":"call","f":0,"e":{"k":"triv"}},"body":{"k":"let","e":{"k":"ifnil","e":{"k":"snd","e":{"k":"var","i":0}},"nil":{"k":"triv"},"some":{"k":"jump","n":0,"t":{"k":"unit"},"e":{"k":"pair","a":{"k":"lit","n":0},"b":{"k":"some","e":{"k":"var","i":0}}}}},"body":{"k":"fst","e":{"k":"var","i":1}}}},"body":{"k":"pair","a":{"k":"var","i":0},"b":{"k":"ann","e":{"k":"nil","t":{"k":"prod","l":{"k":"unit"},"r":{"k":"slice","m":false,"r":1,"t":{"k":"unit"}}}},"t":{"k":"opt","t":{"k":"prod","l":{"k":"unit"},"r":{"k":"slice","m":false,"r":1,"t":{"k":"unit"}}}}}}}}}],"e":{"k":"block","e":{"k":"lit","n":0}}}
    );
}

test "postfix ? is rejected without error? on both sides or without zero values" {
    const pre = "package main\ntype E error\nfunc g() (int, error?) { return 1, nil }\nfunc h() int { return 1 }\n";
    try expectReject(pre ++ "func f() int { g()?; return 1 }\nfunc main() { return 0 }\n", error.Malformed);
    try expectReject(pre ++ "func main() { g()?; return 0 }\n", error.Malformed);
    try expectReject(pre ++ "func f() error? { h()?; return nil }\nfunc main() { return 0 }\n", error.Malformed);
    try expectReject(pre ++ "type P struct { x int }\nfunc f() (int, error?) { v := g()? P{x: 1}; return v, nil }\nfunc main() { return 0 }\n", error.Malformed);
    try expectReject(pre ++ "type U union {\n    A {}\n    B {}\n}\nfunc f() (U, error?) { g()?; return A{}, nil }\nfunc main() { return 0 }\n", error.CoreFragment);
}

test "forwarding return of a parameter slice: ann to the result type (imm upper bound r0 <= r1, Ty.sub)" {
    try expectCore("package main\nfunc id(b []int) []int { return b }\nfunc main() { return len(id([]int{})) }\n",
        \\{"defs":[{"param":{"k":"slice","m":false,"r":0,"t":{"k":"int"}},"ret":{"k":"slice","m":false,"r":1,"t":{"k":"int"}},"body":{"k":"ann","e":{"k":"var","i":0},"t":{"k":"slice","m":false,"r":1,"t":{"k":"int"}}}}],"e":{"k":"block","e":{"k":"len","e":{"k":"call","f":0,"e":{"k":"freeze","e":{"k":"mkslice","m":true,"t":{"k":"int"}}}}}}}
    );
}

test "bytesToString is a std-only primitive (io-2)" {
    try expectReject("package main\nfunc main() { s := bytesToString([]int{104}); return 0 }\n", error.CoreFragment);
}

test "io builtins are std-only (io-3)" {
    try expectReject("package main\nfunc main() { b := sysReadFile(\"x\"); return 0 }\n", error.CoreFragment);
    try expectReject("package main\nfunc main() { e := sysErrno(); return e }\n", error.CoreFragment);
}

test "calling main and unknown functions is rejected" {
    try expectReject("package main\nfunc main() { return nope(1) }\n", error.CoreFragment);
}

test "println evaluates args to unit; break / defer / non-tail return become label / jump (V4-3)" {
    try expectCore("package main\nfunc main() { println(1) }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":1},"body":{"k":"triv"}}}
    );
    // break = while の外側のラベルへの jump（continue 側の内側ラベルは使われないので印字しない）
    try expectCore("package main\nfunc main() { mut i := 0\n while i < 1 { break }\n return 0 }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":0}},"body":{"k":"let","e":{"k":"label","t":{"k":"unit"},"e":{"k":"while","c":{"k":"lt","a":{"k":"deref","e":{"k":"var","i":0}},"b":{"k":"lit","n":1}},"body":{"k":"jump","n":0,"t":{"k":"unit"},"e":{"k":"triv"}}}},"body":{"k":"lit","n":0}}}}
    );
    // defer = 出口で値を束縛してから展開（値確定 → defer）。コアに defer は無い
    try expectCore("package main\nfunc main() { defer println(1)\n return 0 }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":0},"body":{"k":"let","e":{"k":"let","e":{"k":"lit","n":1},"body":{"k":"triv"}},"body":{"k":"var","i":1}}}}
    );
    // 結果の無い関数（main）の値つき return
    try expectReject("package main\nfunc main() { return 1\n x := 2 }\n", error.Malformed);
}

test "unknown names are reported" {
    try expectReject("package main\nfunc main() { return nope }\n", error.UnknownName);
}

test "assignment to a non-mut binding is malformed" {
    try expectReject("package main\nfunc main() { x := 1\n x = 2\n return x }\n", error.Malformed);
}

test "function values (V3-3 3a): a named function is fnref, a function-typed field call is callv" {
    try expectCore("package main\ntype D struct { f func(int) int }\nfunc inc(x int) int { return x + 1 }\nfunc main() { d := D{f: inc}\n return d.f(1) }\n",
        \\{"defs":[{"param":{"k":"int"},"ret":{"k":"int"},"body":{"k":"add","a":{"k":"var","i":0},"b":{"k":"lit","n":1}}}],"e":{"k":"block","e":{"k":"let","e":{"k":"fnref","f":0},"body":{"k":"callv","f":{"k":"var","i":0},"e":{"k":"lit","n":1}}}}}
    );
}

test "generics (V3-3 3b): one generic Def with tvar, call-site ts inferred from value arguments" {
    try expectCore("package main\nfunc id[T](x T) T { return x }\nfunc main() { return id(true) }\n",
        \\{"defs":[{"tparams":1,"param":{"k":"tvar","i":0},"ret":{"k":"tvar","i":0},"body":{"k":"var","i":0}}],"e":{"k":"block","e":{"k":"call","f":0,"ts":[{"k":"bool"}],"e":{"k":"true"}}}}
    );
    try expectReject("package main\nfunc k[T](x int) int { return x }\nfunc main() { return k(1) }\n", error.CoreFragment);
    try expectReject("package main\nfunc pick[T](c bool, x T, y T) T { return if c { x } else { y } }\nfunc main() { return pick(true, 1, false) }\n", error.Malformed);
    try expectReject("package main\nfunc id[T](x T) T { return x }\nfunc main() { s := id(\"a\")\n return 0 }\n", error.CoreFragment);
}

test "dictionary lambdas (V3-3 3c): a closed lambda in a function-typed field is lifted to a Def at the end of the table" {
    try expectCore("package main\ntype D struct { f func(int) bool }\nfunc main() { d := D{f: (x) => x < 3}\n return d.f(1) }\n",
        \\{"defs":[{"param":{"k":"int"},"ret":{"k":"bool"},"body":{"k":"lt","a":{"k":"var","i":0},"b":{"k":"lit","n":3}}}],"e":{"k":"block","e":{"k":"let","e":{"k":"fnref","f":0},"body":{"k":"callv","f":{"k":"var","i":0},"e":{"k":"lit","n":1}}}}}
    );
    try expectReject("package main\ntype D struct { f func(int) bool }\nfunc main() { k := 1\n d := D{f: (x) => x < k}\n return d.f(0) }\n", error.CoreFragment);
}

test "true / false are tt / ff; bool == is the ite form (core cmp is int only)" {
    try expectCore("package main\nfunc main() { b := true; return b == false }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"true"},"body":{"k":"if","c":{"k":"var","i":0},"t":{"k":"false"},"e":{"k":"if","c":{"k":"false"},"t":{"k":"false"},"e":{"k":"true"}}}}}
    );
}

test "constant pattern true on a bool subject is a constant, not a binding" {
    try expectCore("package main\nfunc main() { return switch false { case true: 1\n case _: 0 } }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"false"},"body":{"k":"if","c":{"k":"if","c":{"k":"var","i":0},"t":{"k":"true"},"e":{"k":"if","c":{"k":"true"},"t":{"k":"false"},"e":{"k":"true"}}},"t":{"k":"lit","n":1},"e":{"k":"lit","n":0}}}}
    );
}

test "shifts become shl / shr (Go semantics live in the core op)" {
    try expectCore("package main\nfunc main() { mut x := 3\n x <<= 1\n return x >> 1 }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":3}},"body":{"k":"let","e":{"k":"assign","l":{"k":"var","i":0},"e":{"k":"shl","a":{"k":"deref","e":{"k":"var","i":0}},"b":{"k":"lit","n":1}}},"body":{"k":"shr","a":{"k":"deref","e":{"k":"var","i":1}},"b":{"k":"lit","n":1}}}}}
    );
}

test "a local binding cannot reuse an import reference name; a type parameter cannot reuse a top-level type name" {
    // := が import の参照名を隠す（alias なし・alias あり）
    try expectLoadClash("package main\nimport \"util\"\nfunc main() { util := 1\n return util }\n", "import reference name");
    try expectLoadClash("package main\nimport u \"util\"\nfunc f(u int) int { return u }\nfunc main() { return f(1) }\n", "import reference name");
    // 型パラメータがトップレベル型名を隠す（func と type の両方）
    try expectLoadClash("package main\ntype P struct { x int }\nfunc id[P](x P) P { return x }\nfunc main() { return id(1) }\n", "type parameter");
    try expectLoadClash("package main\ntype P struct { x int }\ntype Box[P] struct { v P }\nfunc main() { return 0 }\n", "type parameter");
}

test "multi-value call subject: the call is bound once, components are projected into subjects" {
    try expectCore("package main\nfunc g() (int, int) { return 1, 2 }\nfunc main() { return switch g() { case 1, y: y\n default: 0 } }\n",
        \\{"defs":[{"param":{"k":"unit"},"ret":{"k":"prod","l":{"k":"int"},"r":{"k":"int"}},"body":{"k":"pair","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}}}],"e":{"k":"block","e":{"k":"let","e":{"k":"call","f":0,"e":{"k":"triv"}},"body":{"k":"let","e":{"k":"fst","e":{"k":"var","i":0}},"body":{"k":"let","e":{"k":"snd","e":{"k":"var","i":1}},"body":{"k":"if","c":{"k":"eq","a":{"k":"var","i":1},"b":{"k":"lit","n":1}},"t":{"k":"var","i":0},"e":{"k":"lit","n":0}}}}}}}
    );
    // case の項数 ≠ 結果の個数
    try expectReject("package main\nfunc g() (int, int) { return 1, 2 }\nfunc main() { return switch g() { case 1: 1\n default: 0 } }\n", error.CoreFragment);
    try expectReject("package main\nfunc g() (int, int) { return 1, 2 }\nfunc main() { return switch g() { case 1, 2, 3: 1\n default: 0 } }\n", error.CoreFragment);
}

test "bare top-level const in a pattern is a comparison; an unknown name still binds" {
    try expectCore("package main\nconst K = 7\nfunc main() { return switch 3 { case K: 1\n case v: v } }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"lit","n":3},"body":{"k":"if","c":{"k":"eq","a":{"k":"var","i":0},"b":{"k":"lit","n":7}},"t":{"k":"lit","n":1},"e":{"k":"var","i":0}}}}
    );
}

/// loader がローカル束縛とトップレベル名の衝突で拒否すること（文法エラー等の別理由の LoadError と区別する）
fn expectTopNameClash(source: [:0]const u8) !void {
    return expectLoadClash(source, "top-level name");
}

fn expectLoadClash(source: [:0]const u8, needle: []const u8) !void {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var ldiag: loader.Diag = .{};
    const files = [_]loader.SrcFile{.{ .pkg_path = loader.main_pkg_path, .name = "test.sober", .source = source }};
    try std.testing.expectError(error.LoadError, loader.link(std.testing.allocator, arena.allocator(), &files, &ldiag, .{}));
    std.testing.expect(std.mem.indexOf(u8, ldiag.what, needle) != null) catch |err| {
        std.debug.print("other LoadError: {s}\n", .{ldiag.what});
        return err;
    };
}

test "a local binding cannot reuse a top-level name (const, func, type, variant)" {
    // := が const を隠す
    try expectTopNameClash("package main\nconst K = 1\nfunc main() { K := 5\n return K }\n");
    // 引数が func 名を隠す
    try expectTopNameClash("package main\nfunc g() int { return 1 }\nfunc f(g int) int { return g }\nfunc main() { return f(1) }\n");
    // ラムダ引数が型名を隠す
    try expectTopNameClash("package main\ntype P struct { x int }\nfunc ap(h func(int) int) int { return h(1) }\nfunc main() { return ap(P => P) }\n");
    // 型パターンのフィールド束縛が variant 名を隠す
    try expectTopNameClash("package main\ntype S union {\n A{B int}\n B{v int}\n}\nfunc f(s S) int { return switch s { case A{B}: B\n case B{v}: v } }\nfunc main() { return f(A{B: 1}) }\n");
    // for の生成元の名前が const を隠す
    try expectTopNameClash("package main\nconst K = 1\nfunc main() { xs := []int{1, 2}\n return for K <- xs yield K |> iter.Count() }\n");
}

// ── 統合: Lean 製検査器（sober-check があれば）──────────────────────────────

test "sober-check accepts a well-typed program and rejects an ill-typed one" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;

    const ok_json = try toCoreJson(allocator,
        "package main\nfunc main() { mut i := 0\n while i < 3 { i += 1 }\n return i }\n");
    defer allocator.free(ok_json);
    try expectVerdict(allocator, ok_json, 0);

    const bad_json = try toCoreJson(allocator,
        "package main\nfunc main() { return if 1 { 2 } else { 3 } }\n");
    defer allocator.free(bad_json);
    try expectVerdict(allocator, bad_json, 1);

    // bool と int は交わらない: 比較（bool）を int として返す def は検査で落ちる
    const mix_json = try toCoreJson(allocator,
        "package main\nfunc f(n int) int { return n == 0 }\nfunc main() { return f(1) }\n");
    defer allocator.free(mix_json);
    try expectVerdict(allocator, mix_json, 1);
    const bool_json = try toCoreJson(allocator,
        "package main\nfunc f(n int) bool { return n == 0 }\nfunc main() { return f(1) }\n");
    defer allocator.free(bool_json);
    try expectVerdict(allocator, bool_json, 0);
}

fn expectVerdict(allocator: std.mem.Allocator, json: []const u8, expected_code: u8) !void {
    var child = std.process.Child.init(&.{"lean/.lake/build/bin/sober-check"}, allocator);
    child.stdin_behavior = .Pipe;
    child.stdout_behavior = .Pipe;
    try child.spawn();
    try child.stdin.?.writeAll(json);
    child.stdin.?.close();
    child.stdin = null;
    const out = try child.stdout.?.readToEndAlloc(allocator, 1 << 20);
    defer allocator.free(out);
    const term = try child.wait();
    try std.testing.expectEqual(std.process.Child.Term{ .Exited = expected_code }, term);
}

// ── string キーの map（随時回収 R3）──────────────────────────────

test "string-keyed map: key / t fields in JSON, stored keys are ann'ed to the key type" {
    try expectCore("package main\nfunc main() { m := map[string]int{\"a\": 1}\n return len(m) }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"freeze","e":{"k":"setm","e":{"k":"mkmap","m":true,"key":{"k":"slice","m":false,"r":0,"t":{"k":"int"}},"t":{"k":"int"}},"key":{"k":"ann","e":{"k":"strlit","bs":[97],"r":0},"t":{"k":"slice","m":false,"r":0,"t":{"k":"int"}}},"v":{"k":"lit","n":1}}},"body":{"k":"lenm","e":{"k":"var","i":0}}}}
    );
    try expectReject("package main\nfunc main() { m := map[bool]int{}\n return len(m) }\n", error.CoreFragment);
}

test "sober-check: return / break / continue in arm tails get their annotation from the position (V4-3)" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    // 関数末尾の switch: 全腕の return は関数の結果型で注釈
    try std.testing.expect(try checkAccepts(allocator, "package main\nfunc f(x int) int {\n switch x {\n case 1: return 10\n default: return 20\n }\n}\nfunc main() { println(f(1)) }\n"));
    // 文位置の if-else: else 腕が値を持たない文なら unit
    try std.testing.expect(try checkAccepts(allocator, "package main\nfunc f(c bool) int {\n mut y := 0\n if c { return 1 } else { y = 2 }\n return y\n}\nfunc main() { println(f(false)) }\n"));
    // 値位置の if: もう片方の腕の型
    try std.testing.expect(try checkAccepts(allocator, "package main\nfunc f(c bool) int {\n x := if c { return 1 } else { 2 }\n return x\n}\nfunc main() { println(f(true)) }\n"));
    // ループ内の return が式ブロックの region を越える
    try std.testing.expect(try checkAccepts(allocator, "package main\nfunc f() int {\n mut i := 0\n while i < 5 {\n i += 1\n v := { xs := append([]int{}, i)\n xs[0] }\n if v > 2 { return v }\n }\n return 0\n}\nfunc main() { println(f()) }\n"));
}

test "sober-check: a key built in an inner scope cannot be stored in an outer map, but can be looked up" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const store = try toCoreJson(allocator,
        "package main\nfunc main() { mut m := mut map[string]int{}\n n := { s := \"a\" + \"b\"\n m[s] = 1\n 0 }\n return n + len(m) }\n");
    defer allocator.free(store);
    try expectVerdict(allocator, store, 1);
    const lookup = try toCoreJson(allocator,
        "package main\nfunc main() { m := map[string]int{\"ab\": 1}\n n := { s := \"a\" + \"b\"\n v := m[s]\n if v != nil { v } else { 0 } }\n return n + len(m) }\n");
    defer allocator.free(lookup);
    try expectVerdict(allocator, lookup, 0);
}

// ── 名前解決の最小形（language.md 20 節）──────────────────────────────

const util_src: [:0]const u8 =
    \\package util
    \\
    \\const Answer = 40 + 2
    \\
    \\func Twice(n int) int { return n * 2 }
    \\
    \\func hidden() int { return 1 }
    \\
;

fn mainWith(comptime body: []const u8) [:0]const u8 {
    return "package main\n\nimport \"util\"\n\n" ++ body;
}

test "packages: qualified call and const, defs span packages" {
    const files = [_]loader.SrcFile{
        .{ .pkg_path = "util", .name = "util/u.sober", .source = util_src },
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = mainWith("func main() { return util.Twice(util.Answer) }\n") },
    };
    const json = try toCoreJsonFiles(std.testing.allocator, &files);
    defer std.testing.allocator.free(json);
    try std.testing.expectEqualStrings(
        \\{"defs":[{"param":{"k":"int"},"ret":{"k":"int"},"body":{"k":"mul","a":{"k":"var","i":0},"b":{"k":"lit","n":2}}},{"param":{"k":"unit"},"ret":{"k":"int"},"body":{"k":"lit","n":1}}],"e":{"k":"block","e":{"k":"call","f":0,"e":{"k":"lit","n":42}}}}
    , json);
}

test "packages: unexported names are rejected across the boundary" {
    const files = [_]loader.SrcFile{
        .{ .pkg_path = "util", .name = "util/u.sober", .source = util_src },
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = mainWith("func main() { return util.hidden() }\n") },
    };
    try std.testing.expectError(error.CoreFragment, toCoreJsonFiles(std.testing.allocator, &files));
}

test "packages: name must match the directory, cycles are rejected" {
    // package 名 ≠ ディレクトリ名
    const files1 = [_]loader.SrcFile{
        .{ .pkg_path = "tools/util", .name = "tools/util/u.sober", .source = "package utils\nfunc F() int { return 1 }\n" },
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = "package main\nimport \"tools/util\"\nfunc main() { return util.F() }\n" },
    };
    try std.testing.expectError(error.LoadError, toCoreJsonFiles(std.testing.allocator, &files1));
    // 循環 import
    const files2 = [_]loader.SrcFile{
        .{ .pkg_path = "a", .name = "a/a.sober", .source = "package a\nimport \"b\"\nfunc F() int { return b.G() }\n" },
        .{ .pkg_path = "b", .name = "b/b.sober", .source = "package b\nimport \"a\"\nfunc G() int { return a.F() }\n" },
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = "package main\nimport \"a\"\nfunc main() { return a.F() }\n" },
    };
    try std.testing.expectError(error.LoadError, toCoreJsonFiles(std.testing.allocator, &files2));
}

test "packages: one package can span several files" {
    const files = [_]loader.SrcFile{
        .{ .pkg_path = loader.main_pkg_path, .name = "a.sober", .source = "package main\nfunc helper(n int) int { return n + 1 }\n" },
        .{ .pkg_path = loader.main_pkg_path, .name = "b.sober", .source = "package main\nfunc main() { return helper(41) }\n" },
    };
    const json = try toCoreJsonFiles(std.testing.allocator, &files);
    defer std.testing.allocator.free(json);
    try std.testing.expectEqualStrings(
        \\{"defs":[{"param":{"k":"int"},"ret":{"k":"int"},"body":{"k":"add","a":{"k":"var","i":0},"b":{"k":"lit","n":1}}}],"e":{"k":"block","e":{"k":"call","f":0,"e":{"k":"lit","n":41}}}}
    , json);
}

// ── slice / string（language.md 21 節）──────────────────────────────

test "slice literal is mkslice + append chain; index/len/setidx map to core ops" {
    // `[]T{...}` = imm 構築（mut 構築 + freeze — language.md 22 節）
    try expectCore("package main\nfunc main() { return len([]int{5}) }\n",
        \\{"k":"block","e":{"k":"len","e":{"k":"freeze","e":{"k":"append","e":{"k":"mkslice","m":true,"t":{"k":"int"}},"v":{"k":"lit","n":5}}}}}
    );
    // 可変は `mut []T{...}`
    try expectCore("package main\nfunc main() { xs := mut []int{1}\n xs[0] = 2\n return xs[0] }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"append","e":{"k":"mkslice","m":true,"t":{"k":"int"}},"v":{"k":"lit","n":1}},"body":{"k":"let","e":{"k":"setidx","e":{"k":"var","i":0},"i":{"k":"lit","n":0},"v":{"k":"lit","n":2}},"body":{"k":"index","e":{"k":"var","i":1},"i":{"k":"lit","n":0}}}}}
    );
    // freeze builtin: mut スライス → imm
    try expectCore("package main\nfunc main() { return len(freeze(mut []int{5})) }\n",
        \\{"k":"block","e":{"k":"len","e":{"k":"freeze","e":{"k":"append","e":{"k":"mkslice","m":true,"t":{"k":"int"}},"v":{"k":"lit","n":5}}}}}
    );
}

// ── map（language.md 22 節）──────────────────────────────

test "map literal is mkmap + setm chain; get/set/delete/len map to core ops" {
    // mut map: リテラル → setm 連鎖、m[k] = v → mut 束縛への再代入、delete / len
    try expectCore("package main\nfunc main() { mut m := mut map[int]int{}\n m[1] = 10\n return len(m) }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"mkmap","m":true,"key":{"k":"int"},"t":{"k":"int"}}},"body":{"k":"let","e":{"k":"assign","l":{"k":"var","i":0},"e":{"k":"setm","e":{"k":"deref","e":{"k":"var","i":0}},"key":{"k":"lit","n":1},"v":{"k":"lit","n":10}}},"body":{"k":"lenm","e":{"k":"deref","e":{"k":"var","i":1}}}}}}
    );
    try expectCore("package main\nfunc main() { mut m := mut map[int]int{1: 10}\n delete(m, 1)\n return len(m) }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"setm","e":{"k":"mkmap","m":true,"key":{"k":"int"},"t":{"k":"int"}},"key":{"k":"lit","n":1},"v":{"k":"lit","n":10}}},"body":{"k":"let","e":{"k":"delm","t":{"k":"int"},"e":{"k":"deref","e":{"k":"var","i":0}},"key":{"k":"lit","n":1}},"body":{"k":"lenm","e":{"k":"deref","e":{"k":"var","i":1}}}}}}
    );
}

test "string literal is a strlit (imm int cells in the annotated region — the innermost by default)" {
    try expectCore("package main\nfunc main() { return len(bytes(\"a\")) }\n",
        \\{"k":"block","e":{"k":"len","e":{"k":"strlit","bs":[97],"r":0}}}
    );
}

test "string is opaque: len / index / slicing / append are rejected; bytes(s) is the identity view" {
    try expectReject("package main\nfunc main() { return len(\"ab\") }\n", error.Malformed);
    try expectReject("package main\nfunc main() { s := \"ab\"\n return s[0] }\n", error.Malformed);
    try expectReject("package main\nfunc main() { s := \"ab\"\n t := s[0:1]\n return 0 }\n", error.Malformed);
    try expectReject("package main\nfunc main() { s := append(\"ab\", 99)\n return 0 }\n", error.Malformed);
    try expectReject("package main\nfunc main() { return len(bytes([]int{1})) }\n", error.Malformed);
}

test "slices cross a function boundary (round4 (5)): param = caller space r0, ret top = own frame r1" {
    // 引数: []int → slice r0（呼び手空間の上界）
    try expectCore("package main\nfunc f(xs []int) int { return len(xs) }\nfunc main() { return f([]int{1}) }\n",
        \\{"defs":[{"param":{"k":"slice","m":false,"r":0,"t":{"k":"int"}},"ret":{"k":"int"},"body":{"k":"len","e":{"k":"var","i":0}}}],"e":{"k":"block","e":{"k":"call","f":0,"e":{"k":"freeze","e":{"k":"append","e":{"k":"mkslice","m":true,"t":{"k":"int"}},"v":{"k":"lit","n":1}}}}}}
    );
    // 戻り値: []int → 最上段は自フレーム r1（新規構築 + freeze が合成する region）
    try expectCore("package main\nfunc f() []int { return []int{1} }\nfunc main() { return len(f()) }\n",
        \\{"defs":[{"param":{"k":"unit"},"ret":{"k":"slice","m":false,"r":1,"t":{"k":"int"}},"body":{"k":"freeze","e":{"k":"append","e":{"k":"mkslice","m":true,"t":{"k":"int"}},"v":{"k":"lit","n":1}}}}],"e":{"k":"block","e":{"k":"len","e":{"k":"call","f":0,"e":{"k":"triv"}}}}}
    );
}

// ── トップレベルの辞書 const（language.md 25 節）──────────────────────────────

const ord_decl = "package main\ntype Ord struct { less func(int, int) bool }\n";

test "dictionary const expands at each reference; its lambda lifts once" {
    // 2 箇所から参照しても持ち上げた Def は 1 本（fnref 0 を 2 回）
    try expectCore(ord_decl ++ "const O = Ord{less: (a, b) => a < b}\nfunc main() { x := O.less(1, 2)\n return O.less(2, 1) }\n",
        \\{"defs":[{"param":{"k":"prod","l":{"k":"int"},"r":{"k":"int"}},"ret":{"k":"bool"},"body":{"k":"let","e":{"k":"fst","e":{"k":"var","i":0}},"body":{"k":"let","e":{"k":"snd","e":{"k":"var","i":1}},"body":{"k":"lt","a":{"k":"var","i":1},"b":{"k":"var","i":0}}}}}],"e":{"k":"block","e":{"k":"let","e":{"k":"callv","f":{"k":"fnref","f":0},"e":{"k":"pair","a":{"k":"lit","n":1},"b":{"k":"lit","n":2}}},"body":{"k":"callv","f":{"k":"fnref","f":0},"e":{"k":"pair","a":{"k":"lit","n":2},"b":{"k":"lit","n":1}}}}}}
    );
}

test "dictionary const: calls, generic / inline function values, containers and int use are rejected at load" {
    // 持つのは可・呼ぶのは不可
    try expectReject(ord_decl ++ "func mk() int { return 1 }\ntype R struct { n int }\nconst D = R{n: mk()}\nfunc main() { return D.n }\n", error.LoadError);
    // ジェネリック関数は値にならない
    try expectReject(ord_decl ++ "func lt[T](a T, b T) bool { return false }\nconst D = Ord{less: lt}\nfunc main() { return 0 }\n", error.LoadError);
    // slice は const 式の外
    try expectReject("package main\ntype S struct { xs []int }\nconst D = S{xs: []int{1}}\nfunc main() { return 0 }\n", error.LoadError);
    // 辞書 const は int の const 式に使えない
    try expectReject("package main\ntype R struct { n int }\nconst D = R{n: 1}\nconst N = D + 1\nfunc main() { return N }\n", error.LoadError);
}

test "dictionary const: a lambda resolves in the declaring context, not the use site" {
    // 参照点のローカル k は見えない（トップレベルに k は無い）
    try expectReject(ord_decl ++ "const O = Ord{less: (a, b) => a < k}\nfunc main() { k := 1\n return O.less(1, 2) }\n", error.UnknownName);
}

// ── V3-4: for 式の Iter[T] 推論の両層一致（lower = 試し生成 / desugar = computeTy）──────────

const lower = @import("lower.zig");
const ir = @import("ir.zig");
const std_embed = @import("std_embed");
const std_table: loader.StdTable = .{ .paths = &std_embed.paths, .sources = &std_embed.sources };

/// build が受理するか（lower が IR を生成し、検証器を通るか — B-9a で codegen から lower へ）
fn buildAccepts(allocator: std.mem.Allocator, source: [:0]const u8) !bool {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    var ldiag: loader.Diag = .{};
    const files = [_]loader.SrcFile{.{ .pkg_path = loader.main_pkg_path, .name = "test.sober", .source = source }};
    const prog = loader.linkWithStd(allocator, arena.allocator(), &files, std_table, &ldiag) catch return false;
    var ldiag2: lower.Diag = .{};
    var m = lower.lower(allocator, &prog, &ldiag2) catch return false;
    defer m.deinit();
    ir.verify(&m) catch return false;
    return true;
}

/// desugar → sober-check が受理するか
fn checkAccepts(allocator: std.mem.Allocator, source: [:0]const u8) !bool {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    var ldiag: loader.Diag = .{};
    const files = [_]loader.SrcFile{.{ .pkg_path = loader.main_pkg_path, .name = "test.sober", .source = source }};
    const prog = loader.linkWithStd(allocator, arena.allocator(), &files, std_table, &ldiag) catch return false;
    var ddiag: desugar.Diag = .{};
    var core = desugar.desugar(allocator, &prog, &ddiag) catch return false;
    defer core.deinit();
    const json = try desugar.toJson(allocator, core);
    defer allocator.free(json);
    var child = std.process.Child.init(&.{"lean/.lake/build/bin/sober-check"}, allocator);
    child.stdin_behavior = .Pipe;
    child.stdout_behavior = .Pipe;
    try child.spawn();
    try child.stdin.?.writeAll(json);
    child.stdin.?.close();
    child.stdin = null;
    const out = try child.stdout.?.readToEndAlloc(allocator, 1 << 20);
    defer allocator.free(out);
    const term = try child.wait();
    return std.meta.eql(term, std.process.Child.Term{ .Exited = 0 });
}

// ── B-9a: 受理の両層検査を拒否の表の全体へ — build が拒否する入力は check も拒否する（既知の差は check_ok で持つ）──

test "diag_cases: build が拒否する入力は check も拒否する（check_ok の行は check が受理する既知の差）" {
    const diag_cases = @import("diag_cases.zig");
    const allocator = std.testing.allocator;
    var bad: usize = 0;
    for (diag_cases.cases, 0..) |c, i| {
        const ck = try checkAccepts(allocator, c.src);
        if (ck != c.check_ok) {
            std.debug.print("diag case {d}: check {s}, table says check_ok={}\n  {s}\n", .{ i, if (ck) "accepts" else "rejects", c.check_ok, c.src });
            bad += 1;
        }
    }
    try std.testing.expectEqual(@as(usize, 0), bad);
}

const iter_prelude =
    \\package main
    \\
    \\import "std/iter"
    \\
    \\type P struct {
    \\    a, b int
    \\}
    \\
    \\type Ord struct { less func(int, int) bool }
    \\
    \\const IntOrd = Ord{less: (a, b) => a < b}
    \\
    \\func twice(n int) int { return n * 2 }
    \\
    \\func id[T](x T) T { return x }
    \\
    \\// 生成元が Iter の閉包（型引数の推論には寄与しない — 両層同じ線）
    \\func each2[T](it iter.Iter[T], f func(T)) { iter.Each[T](for x <- it yield x, f) }
    \\
    \\func each3[T](it iter.Iter[T], f func(T)) { iter.Each(for x <- it yield x, f) }
    \\
    \\func main() {
    \\    xs := []int{3, 1, 4}
    \\    ps := []P{P{1, 2}}
    \\
;

test "for expression: Iter[T] inference agrees between lower and desugar + check" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const Case = struct { body: []const u8, accept: bool };
    const cases = [_]Case{
        // 受理: yield の値の型が推論できる形
        .{ .body = "iter.Each(for x <- xs yield x * 2, (w) => { println(w) })", .accept = true },
        .{ .body = "println(iter.Count(for x <- xs yield x > 1))", .accept = true },
        .{ .body = "for p <- ps yield P{p.b, p.a} |> iter.Each(_, (q) => { println(q.a) })", .accept = true },
        .{ .body = "iter.Each(for x <- xs if x != 1 yield twice(x), (w) => { println(w) })", .accept = true },
        .{ .body = "iter.Each(for x <- xs yield id(x), (w) => { println(w) })", .accept = true },
        .{ .body = "iter.Each(for x <- xs yield IntOrd.less(x, 3), (b) => { println(if b { 1 } else { 0 }) })", .accept = true },
        .{ .body = "iter.Each(for p <- ps {\n s := p.a + p.b\n if s > 0 {\n yield s\n }\n }, (w) => { println(w) })", .accept = true },
        .{ .body = "each2(for x <- xs yield x + 1, (w) => { println(w) })", .accept = true },
        // 拒否: 推論できない・断片外
        .{ .body = "each3(for x <- xs yield x + 1, (w) => { println(w) })", .accept = false },
        .{ .body = "it := for x <- xs yield x\n println(0)", .accept = false },
        .{ .body = "iter.Each(for x <- xs; y <- xs yield x + y, (w) => { println(w) })", .accept = false },
        .{ .body = "iter.Each(for x <- xs {\n yield x\n yield x > 0\n }, (w) => { println(0) })", .accept = false },
    };
    for (cases) |c| {
        const src = try std.fmt.allocPrintSentinel(allocator, "{s}    {s}\n}}\n", .{ iter_prelude, c.body }, 0);
        defer allocator.free(src);
        const cg = try buildAccepts(allocator, src);
        const ck = try checkAccepts(allocator, src);
        if (cg != c.accept or ck != c.accept) {
            std.debug.print("case: {s}\n  build={} check={} want={}\n", .{ c.body, cg, ck, c.accept });
            return error.TestUnexpectedResult;
        }
    }
}

test "inline-expanded parameter types are checked by Lean through ann (V3-5)" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const Case = struct { src: [:0]const u8, accept: bool };
    const cases = [_]Case{
        // 関数型の仮引数 func(int) に bool を渡す（旧: desugar の照合 = 25 節の過渡措置で拒否していた形）
        .{ .src = "package main\nfunc apply(f func(int), b bool) { f(b) }\nfunc main() { apply((w) => { println(0) }, true) }\n", .accept = false },
        // inline 関数の値の仮引数（int）に bool（T3 — 旧実装では check を素通りしていた）
        .{ .src = "package main\nfunc twice(x int, f func(int) int) int { return f(f(x)) }\nfunc main() { println(twice(true, (y) => { 1 })) }\n", .accept = false },
        // ラムダの結果型（int を期待する位置で bool を返す）
        .{ .src = "package main\nfunc twice(x int, f func(int) int) int { return f(f(x)) }\nfunc main() { println(twice(1, (y) => { y > 0 })) }\n", .accept = false },
        // 一致すれば通る
        .{ .src = "package main\nfunc apply(f func(int), n int) { f(n) }\nfunc main() { apply((w) => { println(w) }, 1) }\n", .accept = true },
        .{ .src = "package main\nfunc twice(x int, f func(int) int) int { return f(f(x)) }\nfunc main() { println(twice(1, (y) => { y + 1 })) }\n", .accept = true },
    };
    for (cases) |c| {
        const ck = try checkAccepts(allocator, c.src);
        if (ck != c.accept) {
            std.debug.print("case: {s}\n  check={} want={}\n", .{ c.src, ck, c.accept });
            return error.TestUnexpectedResult;
        }
    }
}

test "mut parameters: `mut x` aliases a mut local; Lean checks the ref type through ann (V3-5)" {
    const allocator = std.testing.allocator;
    const pre = "package main\ntype C struct {\n    n int\n}\nfunc inc(c mut C) {\n    c.n = c.n + 1\n}\nfunc rec(c mut C) {\n    rec(mut c)\n}\nfunc main() {\n";
    // 脱糖器が拒否する形（印・束縛の種類）。再帰する mut 引数の関数は R2（K-a）で Def として呼ぶ — 下の受理側
    const Rej = struct { body: []const u8, err: anyerror };
    const rejects = [_]Rej{
        .{ .body = "    mut c := C{0}\n    inc(c)\n}\n", .err = error.CoreFragment }, // 印なし
        .{ .body = "    c := C{0}\n    inc(mut c)\n}\n", .err = error.CoreFragment }, // 不変束縛
        .{ .body = "    mut c := C{0}\n    println(mut c)\n}\n", .err = error.Malformed }, // mut 引数でない位置
    };
    for (rejects) |r| {
        const src = try std.fmt.allocPrintSentinel(allocator, "{s}{s}", .{ pre, r.body }, 0);
        defer allocator.free(src);
        try expectReject(src, r.err);
    }
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const Case = struct { body: []const u8, accept: bool };
    const cases = [_]Case{
        .{ .body = "    mut c := C{0}\n    inc(mut c)\n    println(c.n)\n}\n", .accept = true },
        // R2（K-a）: 再帰する mut 引数の関数は展開せず Def として anchor つきで呼ぶ（callm）
        .{ .body = "    mut c := C{0}\n    rec(mut c)\n}\n", .accept = true },
        // 宣言より深い式位置ブロックから渡す（ref の region は alloc 点のもの）
        .{ .body = "    mut c := C{0}\n    k := {\n        inc(mut c)\n        c.n\n    }\n    println(k)\n}\n", .accept = true },
        // 型違い（mut bool を mut C に）は ann で Lean が拒否する（1 フィールドの C は core で int と同型なので bool で試す）
        .{ .body = "    mut c := true\n    inc(mut c)\n    println(0)\n}\n", .accept = false },
    };
    for (cases) |c| {
        const src = try std.fmt.allocPrintSentinel(allocator, "{s}{s}", .{ pre, c.body }, 0);
        defer allocator.free(src);
        const ck = try checkAccepts(allocator, src);
        if (ck != c.accept) {
            std.debug.print("case: {s}\n  check={} want={}\n", .{ c.body, ck, c.accept });
            return error.TestUnexpectedResult;
        }
    }
}

test "zero-value literal T{} rejects fields without a zero value (V3-5)" {
    try expectReject("package main\ntype F struct {\n    f func(int) int\n    n int\n}\nfunc main() {\n    x := F{}\n    println(x.n)\n}\n", error.CoreFragment);
    try expectReject("package main\ntype U union {\n    A{ a int }\n    B{ b int }\n}\ntype S struct {\n    u U\n    n int\n}\nfunc main() {\n    x := S{}\n    println(x.n)\n}\n", error.CoreFragment);
}

test "inline-expanded tail return is coerced to the callee's result type (implicit some), not the caller's (V5-2)" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    // mut 引数の関数は展開される。末尾の `return b.v` は int? へ暗黙 some（旧: 呼び手 main の結果型を見て包まず type error）
    const src =
        \\package main
        \\type Box struct {
        \\    v int
        \\    ok bool
        \\}
        \\func get(b mut Box) int? {
        \\    if !b.ok {
        \\        return nil
        \\    }
        \\    return b.v
        \\}
        \\func main() {
        \\    mut b := Box{v: 3, ok: true}
        \\    x := get(mut b)
        \\    println(x != nil)
        \\}
        \\
    ;
    try std.testing.expect(try checkAccepts(allocator, src));
    try std.testing.expect(try buildAccepts(allocator, src));
}

test "flow typing keeps the payload's struct decl: `j.field` after `j != nil`, also on a generic call result (V5-7)" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const src =
        \\package main
        \\type Job struct {
        \\    line, toks int
        \\}
        \\func first[T](xs []T) T? {
        \\    return if len(xs) > 0 { xs[0] } else { nil }
        \\}
        \\func show(j Job?) int {
        \\    if j != nil {
        \\        return j.line + j.toks
        \\    }
        \\    return 0
        \\}
        \\func main() {
        \\    g := first([]Job{Job{line: 1, toks: 2}})
        \\    if g != nil {
        \\        println(g.toks)
        \\    }
        \\    println(show(Job{line: 3, toks: 4}))
        \\}
        \\
    ;
    try std.testing.expect(try checkAccepts(allocator, src));
    try std.testing.expect(try buildAccepts(allocator, src));
    // 絞り込み前の `j.field` は opt への射影 — Lean が型で拒否する（build も拒否）
    const before =
        \\package main
        \\type Job struct {
        \\    line, toks int
        \\}
        \\func show(j Job?) int {
        \\    return j.line
        \\}
        \\func main() {
        \\    println(show(Job{line: 3, toks: 4}))
        \\}
        \\
    ;
    try std.testing.expect(!try checkAccepts(allocator, before));
    try std.testing.expect(!try buildAccepts(allocator, before));
}

test "struct slice field keeps its element decl: `c.ts[i].kind` (V5-7)" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const src =
        \\package main
        \\type Tok struct {
        \\    kind, pos int
        \\}
        \\type Cursor struct {
        \\    ts []Tok
        \\    i int
        \\}
        \\func peek(c Cursor) int {
        \\    return c.ts[c.i].kind
        \\}
        \\func main() {
        \\    println(peek(Cursor{ts: []Tok{Tok{7, 0}}, i: 0}))
        \\}
        \\
    ;
    try std.testing.expect(try checkAccepts(allocator, src));
    try std.testing.expect(try buildAccepts(allocator, src));
}

test "an if statement discards its arms' values: tails of different types, through else-if chains and ifnil (V5-7)" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const src =
        \\package main
        \\func bump(x mut int) int {
        \\    x = x + 1
        \\    return x
        \\}
        \\func pick(k int) int? {
        \\    return if k > 0 { k } else { nil }
        \\}
        \\func main() {
        \\    mut n := 0
        \\    o := pick(5)
        \\    if n == 0 {
        \\        bump(mut n)
        \\    } else if n == 1 {
        \\        n = 7
        \\    } else {
        \\        bump(mut n)
        \\    }
        \\    if o != nil {
        \\        bump(mut n)
        \\    } else {
        \\        n = 0
        \\    }
        \\    println(n)
        \\}
        \\
    ;
    try std.testing.expect(try checkAccepts(allocator, src));
    try std.testing.expect(try buildAccepts(allocator, src));
    // 値を使う if（末尾）は従来どおり腕の型が揃わなければ拒否
    const value =
        \\package main
        \\func main() {
        \\    n := 0
        \\    x := if n == 0 { 1 } else { true }
        \\    println(n)
        \\}
        \\
    ;
    try std.testing.expect(!try checkAccepts(allocator, value));
}

test "a type-pattern switch takes `case _:` as its default (V5-7)" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const src =
        \\package main
        \\type A error { n int }
        \\type B error
        \\func why(e error) int {
        \\    return switch e {
        \\    case A{n}: n
        \\    case _: 0 - 1
        \\    }
        \\}
        \\func main() {
        \\    println(why(B{}))
        \\}
        \\
    ;
    try std.testing.expect(try checkAccepts(allocator, src));
    try std.testing.expect(try buildAccepts(allocator, src));
}

test "expression statements: a call's result may be dropped, a pure expression's may not — both layers (decision C)" {
    const allocator = std.testing.allocator;
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const ok =
        \\package main
        \\func bump(x mut int) int {
        \\    x = x + 1
        \\    return x
        \\}
        \\func main() {
        \\    mut n := 0
        \\    bump(mut n)
        \\    if n > 0 { bump(mut n) } else { bump(mut n) }
        \\    k := if n > 0 { bump(mut n); n } else { 0 }
        \\    println(n, k)
        \\}
        \\
    ;
    try std.testing.expect(try checkAccepts(allocator, ok));
    try std.testing.expect(try buildAccepts(allocator, ok));
    const bad = [_][:0]const u8{
        // 名前・演算・リテラル・添字の式文
        "package main\nfunc main() {\n    n := 1\n    n + 1\n    println(n)\n}\n",
        "package main\nfunc f() int {\n    n := 1\n    n\n    return n\n}\nfunc main() {\n    println(f())\n}\n",
        "package main\nfunc main() {\n    xs := []int{1}\n    xs[0]\n    println(1)\n}\n",
        // 文位置の if の腕の末尾・while 本体の末尾も文位置
        "package main\nfunc main() {\n    n := 1\n    if n > 0 { n } else { 0 }\n    println(n)\n}\n",
        "package main\nfunc main() {\n    mut i := 0\n    while i < 3 {\n        i += 1\n        i\n    }\n    println(i)\n}\n",
        // 値位置のブロックでも末尾以外は文位置
        "package main\nfunc main() {\n    k := if true { 5\n 6 } else { 0 }\n    println(k)\n}\n",
    };
    for (bad) |src| {
        try std.testing.expect(!try checkAccepts(allocator, src));
        try std.testing.expect(!try buildAccepts(allocator, src));
    }
}

test "R1 (region polymorphism ruling, ①s): region-bearing type arguments for generic structs and inline-expanded generics; Keep" {
    const allocator = std.testing.allocator;
    const accepts = [_][:0]const u8{
        // ジェネリック struct（使用点で prod 鎖に展開 — コアは具体型）
        "package main\ntype Box[T] struct { v T\n n int }\nfunc main() { b := Box[string]{v: \"hi\", n: 1}\n println(b.v) }\n",
        "package main\ntype Box[T] struct { v T }\nfunc main() { b := Box[[]int]{v: append([]int{}, 3)}\n println(\"${len(b.v)}\") }\n",
        // 展開されるジェネリック（関数型引数を持つ）に string
        "package main\nfunc apply[T](x T, f func(T) int) int { return f(x) }\nfunc main() { println(\"${apply(\"abc\", (s) => len(bytes(s)))}\") }\n",
        // std の Pool[string]・Builder[string]（mut 引数の関数 = 展開）
        "package main\nimport \"std/pool\"\nfunc main() { mut p := pool.Pool[string]{}\n h := pool.Acquire(mut p, \"a\")\n defer pool.Release(mut p, h)\n v := pool.Get(mut p, h)\n if v != nil { println(v) } }\n",
        "package main\nimport \"std/builder\"\nfunc main() { mut b := builder.Builder[string]{}\n builder.Push(mut b, \"a\")\n xs := builder.Build(mut b)\n println(xs[0]) }\n",
        // Keep: 深いブロックで作った string を Arena の region へ置き直して外へ出す
        "package main\nimport \"std/strings\"\nfunc main() { mut a := strings.Arena{}\n t := { s := \"x\" + \"y\"\n strings.Keep(mut a, s) }\n println(t) }\n",
    };
    for (accepts) |src| {
        try std.testing.expect(try buildAccepts(allocator, src));
        try std.testing.expect(try checkAccepts(allocator, src));
    }
    // Def として呼ぶジェネリックの型引数は loc-free のまま（R3 の後置代入まで）— 両層とも拒否
    const def_generic: [:0]const u8 = "package main\nfunc id[T](x T) T { return x }\nfunc main() { println(id(\"a\")) }\n";
    try std.testing.expect(!try buildAccepts(allocator, def_generic));
    try std.testing.expect(!try checkAccepts(allocator, def_generic));
    // Keep なしで深いブロックの string を外へ出す形は、R5（普通の出口の対称化）でブロックの出口の境界コピーとして通る
    try std.testing.expect(try checkAccepts(allocator, "package main\nfunc main() { t := { s := \"x\" + \"y\"\n s }\n println(t) }\n"));
}

test "R2 (region polymorphism ruling, K-a): recursive mut-parameter functions are Defs called with an anchor (callm)" {
    const allocator = std.testing.allocator;
    // 再帰する mut 引数の関数は Def（callm）、再帰しないものは従来どおり展開
    try expectCore("package main\nfunc acc(s mut int, n int) {\n    if n > 0 {\n        s = s + n\n        acc(mut s, n - 1)\n    }\n}\nfunc main() {\n    mut t := 0\n    acc(mut t, 2)\n    return t\n}\n",
        \\{"defs":[{"param":{"k":"prod","l":{"k":"ref","m":true,"r":0,"t":{"k":"int"}},"r":{"k":"int"}},"ret":{"k":"unit"},"body":{"k":"let","e":{"k":"fst","e":{"k":"var","i":0}},"body":{"k":"let","e":{"k":"snd","e":{"k":"var","i":1}},"body":{"k":"if","c":{"k":"gt","a":{"k":"var","i":0},"b":{"k":"lit","n":0}},"t":{"k":"let","e":{"k":"assign","l":{"k":"var","i":1},"e":{"k":"add","a":{"k":"deref","e":{"k":"var","i":1}},"b":{"k":"var","i":0}}},"body":{"k":"let","e":{"k":"callm","f":0,"e":{"k":"pair","a":{"k":"var","i":2},"b":{"k":"sub","a":{"k":"var","i":1},"b":{"k":"lit","n":1}}}},"body":{"k":"triv"}}},"e":{"k":"triv"}}}}}],"e":{"k":"block","e":{"k":"let","e":{"k":"alloc","mut":true,"e":{"k":"lit","n":0}},"body":{"k":"let","e":{"k":"callm","f":0,"e":{"k":"pair","a":{"k":"var","i":0},"b":{"k":"lit","n":2}}},"body":{"k":"deref","e":{"k":"var","i":1}}}}}}
    );
    // 関数値にはできない
    try expectReject("package main\nfunc acc(s mut int, n int) {\n    if n > 0 {\n        acc(mut s, n - 1)\n    }\n}\ntype D struct { f func(int, int) }\nfunc main() {\n    d := D{f: acc}\n    return 0\n}\n", error.CoreFragment);
    std.fs.cwd().access("lean/.lake/build/bin/sober-check", .{}) catch return error.SkipZigTest;
    const Case = struct { src: [:0]const u8, accept: bool };
    const cases = [_]Case{
        // Builder を mut 引数で引き回す再帰（初回 Push が再帰の中 — seed は Builder のゼロ値が束縛の region に持つ）
        .{ .src = "package main\nimport \"std/builder\"\nfunc fill(nb mut builder.Builder[int], n int) {\n    if n > 0 {\n        builder.Push(mut nb, n)\n        fill(mut nb, n - 1)\n    }\n}\nfunc main() {\n    mut nb := builder.Builder[int]{}\n    fill(mut nb, 3)\n    println(\"${builder.Len(mut nb)}\")\n}\n", .accept = true },
        // 相互再帰 + `?`
        .{ .src = "package main\ntype E error { pos int }\nfunc a(s mut int, n int) (int, error?) {\n    if n < 0 { return 0, E{pos: n} }\n    if n == 0 { return s, nil }\n    s = s + n\n    return b(mut s, n - 1)?, nil\n}\nfunc b(s mut int, n int) (int, error?) {\n    x := a(mut s, n)?\n    return x, nil\n}\nfunc main() {\n    mut s := 0\n    v, e := a(mut s, 3)\n    println(\"${v}\")\n}\n", .accept = true },
        // mut ローカルを外側に、呼び出しは深い式位置ブロックから（anchor = 束縛の region < 呼び手最内）
        .{ .src = "package main\nfunc acc(s mut int, n int) {\n    if n > 0 {\n        s = s + n\n        acc(mut s, n - 1)\n    }\n}\nfunc main() {\n    mut t := 0\n    x := {\n        acc(mut t, 3)\n        1\n    }\n    println(\"${t + x}\")\n}\n", .accept = true },
        // 1 slot anchor の割り切り: imm 引数は anchor（mut 引数の束縛の region）以下 — 深い位置で作った string は渡せない
        .{ .src = "package main\nfunc f(s mut int, p string, n int) {\n    if n > 0 {\n        s = s + len(bytes(p))\n        f(mut s, p, n - 1)\n    }\n}\nfunc main() {\n    mut t := 0\n    x := {\n        q := \"a\" + \"b\"\n        f(mut t, q, 2)\n        1\n    }\n    println(\"${t + x}\")\n}\n", .accept = false },
        // mut ローカルの写し（`mut d := c`、c は仮引数）を展開される mut 関数へ（初期値を点座標へ ann — V3-5 の穴の回収）
        .{ .src = "package main\ntype Cur struct {\n    xs []int\n    i int\n}\nfunc next(c mut Cur) int {\n    v := c.xs[c.i]\n    c.i = c.i + 1\n    return v\n}\nfunc peekv(c Cur) int {\n    mut d := c\n    return next(mut d)\n}\nfunc main() {\n    c := Cur{xs: append([]int{}, 5), i: 0}\n    println(\"${peekv(c)}\")\n}\n", .accept = true },
    };
    for (cases) |c| {
        const ck = try checkAccepts(allocator, c.src);
        if (ck != c.accept) {
            std.debug.print("case: {s}\n  check={} want={}\n", .{ c.src, ck, c.accept });
            return error.TestUnexpectedResult;
        }
    }
    // mut_def は IR 経路（lower）が実装する（直吐き codegen は明示の Unsupported のまま退役）
    try std.testing.expect(try buildAccepts(allocator, cases[0].src));
}

test "R4a (region polymorphism ruling, deep relocate): a callee may return nested containers built in its frame" {
    const allocator = std.testing.allocator;
    const cases = [_][:0]const u8{
        // []string（中身の string もフレーム）
        "package main\nimport \"std/strings\"\nfunc words(n int) []string {\n    mut out := mut []string{}\n    mut i := 0\n    while i < n {\n        out = append(out, \"w\" + strings.Itoa(i))\n        i += 1\n    }\n    return freeze(out)\n}\nfunc main() {\n    ws := words(2)\n    println(ws[1])\n}\n",
        // [][]int を 2 段の呼び出しで転送
        "package main\nfunc row(n int) []int {\n    return append([]int{}, n)\n}\nfunc grid(n int) [][]int {\n    return append([][]int{}, row(n))\n}\nfunc twice(n int) [][]int {\n    return grid(n)\n}\nfunc main() {\n    g := twice(3)\n    println(\"${g[0][0]}\")\n}\n",
    };
    for (cases) |src| try std.testing.expect(try checkAccepts(allocator, src));
    // 実行系（深い relocate）は IR 経路の lower が実装する（lower_cont.relocateTo — B-10）
    for (cases) |src| try std.testing.expect(try buildAccepts(allocator, src));
}

test "R5 (block exit is symmetric with jump): a value built in an expression block leaves by a boundary copy" {
    const allocator = std.testing.allocator;
    // 末尾値がブロックの region のコンテナを持つと、出口で親の最内へ写すブロック（"block" に "t"）になる
    try expectCore("package main\nfunc main() { t := { s := \"a\" + \"b\"\n s }\n return 0 }\n",
        \\{"k":"block","e":{"k":"let","e":{"k":"block","e":{"k":"let","e":{"k":"concat","a":{"k":"strlit","bs":[97],"r":1},"b":{"k":"strlit","bs":[98],"r":1}},"body":{"k":"var","i":0}},"t":{"k":"slice","m":false,"r":0,"t":{"k":"int"}}},"body":{"k":"lit","n":0}}}
    );
    const cases = [_][:0]const u8{
        "package main\nimport \"std/strings\"\nfunc label(n int) string {\n    s := {\n        t := \"n=\" + strings.Itoa(n)\n        t + \"!\"\n    }\n    return s\n}\nfunc main() {\n    println(label(4))\n}\n",
        "package main\nfunc squares(n int) []int {\n    xs := {\n        mut out := mut []int{}\n        mut i := 0\n        while i < n {\n            out = append(out, i * i)\n            i += 1\n        }\n        freeze(out)\n    }\n    return xs\n}\nfunc main() {\n    println(\"${len(squares(3))}\")\n}\n",
    };
    for (cases) |src| try std.testing.expect(try checkAccepts(allocator, src));
}

test "R4b-cov (imm cells are deeply covariant): nested imm containers from a parameter forward to another call" {
    const allocator = std.testing.allocator;
    const cases = [_][:0]const u8{
        // []string を仮引数から別の関数へ（旧: セル型の正確一致で拒否）
        "package main\nfunc count(xs []string) int {\n    return len(xs)\n}\nfunc fwd(xs []string) int {\n    return count(xs)\n}\nfunc main() {\n    println(fwd(append([]string{}, \"a\")))\n}\n",
        // 仮引数由来の入れ子コンテナの転送 return（積み — retValue の ann が深く緩める）
        "package main\nfunc same(xss [][]int) [][]int {\n    return xss\n}\nfunc main() {\n    g := same(append([][]int{}, append([]int{}, 7)))\n    println(\"${g[0][0]}\")\n}\n",
        // error? の転送（string ラベルがあると error は入れ子のコンテナ — K1''）
        "package main\ntype NotFound error { path string }\nfunc log(e error?) {\n    if e != nil {\n        println(\"err\")\n    }\n}\nfunc handle(e error?) {\n    log(e)\n}\nfunc main() {\n    handle(nil)\n}\n",
        // cause を再帰で辿る（union の鎖の読み出しは注釈つき index — A-2）
        "package main\ntype NotFound error { path string }\ntype W error { n int }\nfunc open(p string) (int, error?) {\n    return 0, NotFound{path: p}\n}\nfunc load(p string) (int, error?) {\n    n := open(p)? W{n: 1}\n    return n, nil\n}\nfunc show(e error?) {\n    if e != nil {\n        switch e {\n        case W{n, cause}:\n            show(cause)\n        case NotFound{path, cause}:\n            println(path)\n            show(cause)\n        }\n    }\n}\nfunc main() {\n    _, e := load(\"a\")\n    show(e)\n}\n",
    };
    for (cases) |src| try std.testing.expect(try checkAccepts(allocator, src));
}
