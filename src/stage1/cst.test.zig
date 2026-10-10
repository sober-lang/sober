//! parse → print → parse の不動点オラクル（docs/oracles.md）。
//! print∘parse が冪等で、印字結果を読み戻した CST が元と一致することを確かめる。
const std = @import("std");
const Lexer = @import("lexer.zig");
const grammar = @import("grammar.zig");
const cst = @import("cst.zig");

const Parsed = struct {
    tokens: []Token,
    matcher: grammar.Matcher,
    source: [:0]const u8,
    root: u32,

    fn deinit(self: *Parsed, allocator: std.mem.Allocator) void {
        self.matcher.deinit();
        allocator.free(self.tokens);
    }
    fn tree(self: *const Parsed) cst.Tree {
        return cst.Tree.fromMatcher(&self.matcher, self.source, self.root);
    }
};
const Token = @import("token.zig");

fn parse(allocator: std.mem.Allocator, source: [:0]const u8) !Parsed {
    const tokens = try Lexer.tokenize(allocator, source);
    errdefer allocator.free(tokens);
    var m = grammar.Matcher.init(allocator, tokens);
    errdefer m.deinit();
    const root = (try m.parse("source_file")) orelse return error.ParseFailed;
    return .{ .tokens = tokens, .matcher = m, .source = source, .root = root };
}

/// 不動点: sexpr(parse(src)) == sexpr(parse(print(parse(src)))) かつ print が冪等
fn expectFixpoint(source: [:0]const u8) !void {
    const a = std.testing.allocator;

    var p1 = try parse(a, source);
    defer p1.deinit(a);
    const s1 = try cst.sexpr(a, p1.tree());
    defer a.free(s1);
    const printed1 = try cst.print(a, p1.tree());
    defer a.free(printed1);

    const src2 = try a.dupeZ(u8, printed1);
    defer a.free(src2);
    var p2 = parse(a, src2) catch |err| {
        std.debug.print("printed source does not parse:\n{s}\n", .{printed1});
        return err;
    };
    defer p2.deinit(a);
    const s2 = try cst.sexpr(a, p2.tree());
    defer a.free(s2);
    const printed2 = try cst.print(a, p2.tree());
    defer a.free(printed2);

    try std.testing.expectEqualStrings(s1, s2);
    try std.testing.expectEqualStrings(printed1, printed2);
}

const fib_src =
    \\package main
    \\
    \\func fib(n int) int {
    \\    return if n < 2 { n } else { fib(n - 1) + fib(n - 2) }
    \\}
    \\
    \\func main() {
    \\    println(fib(10))
    \\}
    \\
;

test "sexpr: package clause" {
    const a = std.testing.allocator;
    var p = try parse(a, "package main\n");
    defer p.deinit(a);
    const s = try cst.sexpr(a, p.tree());
    defer a.free(s);
    try std.testing.expectEqualStrings("(source_file (package_clause package main))", s);
}

test "sexpr: fib shows rule structure" {
    const a = std.testing.allocator;
    var p = try parse(a, "package main\nfunc f(n int) int { return -n }\n");
    defer p.deinit(a);
    const s = try cst.sexpr(a, p.tree());
    defer a.free(s);
    try std.testing.expectEqualStrings(
        "(source_file (package_clause package main) (top_level_decl (func_decl func f (signature (parameters ( (parameter_decl (identifier_list n) (type (type_name int))) )) (result (type (type_name int)))) (block { (statement_list (statement (return_stmt return (expression_list (expression (pipe_expr (or_expr (and_expr (rel_expr (add_expr (mul_expr (unary_expr (unary_op -) (unary_expr (postfix_expr (primary_expr (operand n)))))))))))))))) }))))",
        s,
    );
}

test "print: canonical layout of fib" {
    const a = std.testing.allocator;
    var p = try parse(a, fib_src);
    defer p.deinit(a);
    const out = try cst.print(a, p.tree());
    defer a.free(out);
    try std.testing.expectEqualStrings(
        \\package main
        \\
        \\func fib(n int) int {
        \\    return if n < 2 {
        \\        n
        \\    } else {
        \\        fib(n - 1) + fib(n - 2)
        \\    }
        \\}
        \\
        \\func main() {
        \\    println(fib(10))
        \\}
        \\
    , out);
}

test "print: empty block, unary glue, call spacing" {
    const a = std.testing.allocator;
    var p = try parse(a, "package p; func f() {}; func g(a, b int) (int, error) { return -(-a), !b, f()(1,2,) }");
    defer p.deinit(a);
    const out = try cst.print(a, p.tree());
    defer a.free(out);
    try std.testing.expectEqualStrings(
        \\package p
        \\
        \\func f() {}
        \\
        \\func g(a, b int) (int, error) {
        \\    return -(-a), !b, f()(1, 2,)
        \\}
        \\
    , out);
}

test "print: types and composite literals" {
    const a = std.testing.allocator;
    var p = try parse(a, "package p; type L struct { xs []int; m map[string][]P?; f func(int) (int, error); q *Buf }; func f() { l := L{xs: []int{1, 2}, m: map[string][]P?{\"k\": {{1}, {}}}}; g := [2]int{{0}, {1}} }");
    defer p.deinit(a);
    const out = try cst.print(a, p.tree());
    defer a.free(out);
    try std.testing.expectEqualStrings(
        \\package p
        \\
        \\type L struct {
        \\    xs []int
        \\    m map[string][]P?
        \\    f func(int) (int, error)
        \\    q *Buf
        \\}
        \\
        \\func f() {
        \\    l := L{xs: []int{1, 2}, m: map[string][]P?{"k": {{1}, {}}}}
        \\    g := [2]int{{0}, {1}}
        \\}
        \\
    , out);
}

test "print: union variants stay on one line" {
    const a = std.testing.allocator;
    var p = try parse(a, "package p; type S union { A {}; B { x int }; C {\n w, h int\n tag string\n} }");
    defer p.deinit(a);
    const out = try cst.print(a, p.tree());
    defer a.free(out);
    try std.testing.expectEqualStrings(
        \\package p
        \\
        \\type S union {
        \\    A {}
        \\    B { x int }
        \\    C { w, h int; tag string }
        \\}
        \\
    , out);
}

test "fixpoint: fib" {
    try expectFixpoint(fib_src);
}

test "fixpoint: one-liners with explicit semicolons" {
    try expectFixpoint("package p; func f() {}; func g() int { return 1 }");
}

test "fixpoint: nested if chains and precedence" {
    try expectFixpoint(
        \\package p
        \\func f(a, b, c int) int {
        \\    return if a < b { if b < c { c } else { b } } else if a == c { a * 2 - -b } else { (a + b) * c }
        \\}
    );
}

test "fixpoint: samples under examples/" {
    const a = std.testing.allocator;
    var dir = std.fs.cwd().openDir("examples", .{ .iterate = true }) catch return;
    defer dir.close();
    var it = dir.iterate();
    while (try it.next()) |entry| {
        if (entry.kind != .file or !std.mem.endsWith(u8, entry.name, ".sober")) continue;
        const content = try dir.readFileAlloc(a, entry.name, 1 << 20);
        defer a.free(content);
        const src = try a.dupeZ(u8, content);
        defer a.free(src);
        expectFixpoint(src) catch |err| {
            std.debug.print("fixpoint failed for examples/{s}\n", .{entry.name});
            return err;
        };
    }
}

test "fixpoint: .sobi interface with bodiless declarations (language.md 29)" {
    try expectFixpoint(
        \\package geo
        \\
        \\import "std/strings"
        \\
        \\type Point struct {
        \\    x, y int
        \\}
        \\
        \\func Area(p Point) int
        \\
        \\func Split(s string) (int, error?)
        \\
        \\@errors(NotFound)
        \\func Find(k int) error?
        \\
        \\func Push[T](b mut []T, x T) {
        \\    b = append(b, x)
        \\}
        \\
    );
}
