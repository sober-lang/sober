const std = @import("std");
const peg = @import("peg.zig");
const Lexer = @import("lexer.zig");
const grammar = @import("grammar.zig");

const g = peg.compile(grammar.v0);
const M = peg.Matcher(g);

/// ソースを字句解析して rule からパースし、全トークンを消費したら true
fn parses(comptime rule: []const u8, source: [:0]const u8) !bool {
    const allocator = std.testing.allocator;
    const tokens = try Lexer.tokenize(allocator, source);
    defer allocator.free(tokens);
    var m = M.init(allocator, tokens);
    defer m.deinit();
    const root = (try m.parse(rule)) orelse return false;
    const node = m.nodes.items[root];
    // source_file は EOF まで食う。部分ルールは EOF と、その直前に自動挿入された ';' を除いて全消費
    if (std.mem.eql(u8, rule, "source_file")) return node.token_end == tokens.len;
    // top_level_decl / import_decl のように自分で ';' を食うルールは EOF 直前まで
    const before_eof: usize = tokens.len - 1;
    if (node.token_end == before_eof) return true;
    var want_end: usize = before_eof;
    if (want_end > 0 and tokens[want_end - 1].tag == .semicolon) want_end -= 1;
    return node.token_end == want_end;
}

test "grammar compiles and names resolve" {
    try std.testing.expectEqualStrings("source_file", g.rules[0].name);
}

test "fib program parses as source_file" {
    const src =
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
    try std.testing.expect(try parses("source_file", src));
}

test "source_file requires package clause" {
    try std.testing.expect(!try parses("source_file", "func main() {}\n"));
}

test "package clause alone is a source file" {
    try std.testing.expect(try parses("source_file", "package main\n"));
    try std.testing.expect(try parses("source_file", "package main"));
}

test "func_decl: parameters and result forms" {
    try std.testing.expect(try parses("func_decl", "func f()"));
    try std.testing.expect(try parses("func_decl", "func f() {}"));
    try std.testing.expect(try parses("func_decl", "func f(a int)"));
    try std.testing.expect(try parses("func_decl", "func f(a, b int, c string) int"));
    try std.testing.expect(try parses("func_decl", "func f(int, string) (int, error)"));
    try std.testing.expect(try parses("func_decl", "func f(a int,)"));
    try std.testing.expect(!try parses("func_decl", "func (a int) int"));
    try std.testing.expect(!try parses("func_decl", "func f"));
}

test "func_decl: unnamed parameter is not confused with a name" {
    // `int` は identifier_list として読まれた後 type が無くて失敗し、type 単独に戻る
    try std.testing.expect(try parses("parameters", "(int)"));
    try std.testing.expect(try parses("parameters", "(n int)"));
}

test "block: statements separated by newline or ; and optional before }" {
    try std.testing.expect(try parses("block", "{}"));
    try std.testing.expect(try parses("block", "{ n }"));
    try std.testing.expect(try parses("block", "{ a; b }"));
    try std.testing.expect(try parses("block", "{\n a\n b\n}"));
    try std.testing.expect(try parses("block", "{ a; b; }"));
    try std.testing.expect(!try parses("block", "{ a b }"));
}

test "return with and without values" {
    try std.testing.expect(try parses("return_stmt", "return"));
    try std.testing.expect(try parses("return_stmt", "return 1"));
    try std.testing.expect(try parses("return_stmt", "return a, b"));
}

test "expression: precedence chain accepts Go binary operators" {
    try std.testing.expect(try parses("expression", "1"));
    try std.testing.expect(try parses("expression", "a + b * c - d / e % f"));
    try std.testing.expect(try parses("expression", "a < b && c >= d || !e"));
    try std.testing.expect(try parses("expression", "-(a ^ b) << 2 & c | d"));
    try std.testing.expect(try parses("expression", "-(-a)"));
}

test "expression: calls chain and take argument lists" {
    try std.testing.expect(try parses("expression", "f()"));
    try std.testing.expect(try parses("expression", "f(1)(2, 3)"));
    try std.testing.expect(try parses("expression", "f(a, g(b),)"));
    try std.testing.expect(!try parses("expression", "f(,)"));
}

test "expression: mut argument marks a by-reference argument (V3-5)" {
    try std.testing.expect(try parses("expression", "Push(mut b, x)"));
    try std.testing.expect(try parses("expression", "f(x, mut b)"));
    // mut の後は識別子 1 つだけ（式・フィールドは不可）
    try std.testing.expect(!try parses("expression", "f(mut b.c)"));
    try std.testing.expect(!try parses("expression", "f(mut g(x))"));
    // mut コンテナの composite literal は従来どおり
    try std.testing.expect(try parses("expression", "f(mut []int{1})"));
}

test "if is an expression: arms are blocks, else may chain" {
    try std.testing.expect(try parses("expression", "if a { b }"));
    try std.testing.expect(try parses("expression", "if a { b } else { c }"));
    try std.testing.expect(try parses("expression", "if a { b } else if c { d } else { e }"));
    try std.testing.expect(try parses("expression", "1 + if a { b } else { c }"));
    // 腕はブロック必須（Go 同様）
    try std.testing.expect(!try parses("expression", "if a b else c"));
}

test "bind_decl: := with optional mut, multi-value" {
    try std.testing.expect(try parses("statement", "x := 1"));
    try std.testing.expect(try parses("statement", "mut x := 1"));
    try std.testing.expect(try parses("statement", "a, b := f()"));
    try std.testing.expect(try parses("statement", "a, b := 1, 2"));
    try std.testing.expect(try parses("source_file", "package p\nlimit := 10\nmut n := 0\n"));
    try std.testing.expect(!try parses("statement", "x :="));
    try std.testing.expect(!try parses("statement", ":= 1"));
    try std.testing.expect(!try parses("statement", "mut := 1"));
}

test "assignment: = and compound operators, multi-value" {
    try std.testing.expect(try parses("statement", "x = 1"));
    try std.testing.expect(try parses("statement", "x += 1"));
    try std.testing.expect(try parses("statement", "x <<= 2"));
    try std.testing.expect(try parses("statement", "a, b = b, a"));
    try std.testing.expect(!try parses("statement", "x ="));
    try std.testing.expect(!try parses("statement", "x++"));
}

test "while with break / continue" {
    try std.testing.expect(try parses("statement", "while a < b { a += 1 }"));
    try std.testing.expect(try parses("statement", "while a { if b { break }; continue }"));
    try std.testing.expect(!try parses("statement", "while { }"));
    try std.testing.expect(!try parses("statement", "while a b"));
}

test "type_decl: struct, defined type, type params" {
    try std.testing.expect(try parses("type_decl", "type P struct {}"));
    try std.testing.expect(try parses("type_decl", "type P struct { x, y int; name string }"));
    try std.testing.expect(try parses("type_decl", "type P struct {\n x int\n y int\n}"));
    try std.testing.expect(try parses("type_decl", "type ID int"));
    try std.testing.expect(try parses("type_decl", "type Pair[K, V] struct { k K; v V }"));
    try std.testing.expect(!try parses("type_decl", "type A = B"));
    try std.testing.expect(!try parses("type_decl", "type P struct { x int y int }"));
}

test "type: literals, generics, optional, pinned" {
    try std.testing.expect(try parses("type", "int"));
    try std.testing.expect(try parses("type", "pkg.T"));
    try std.testing.expect(try parses("type", "int?"));
    try std.testing.expect(try parses("type", "[]int"));
    try std.testing.expect(try parses("type", "[4]int"));
    try std.testing.expect(try parses("type", "map[string][]int"));
    try std.testing.expect(try parses("type", "List[T]?"));
    try std.testing.expect(try parses("type", "map[K]V"));
    try std.testing.expect(try parses("type", "func(int, string) (int, error)"));
    try std.testing.expect(try parses("type", "*Buf"));
    try std.testing.expect(try parses("type", "(int)"));
    try std.testing.expect(try parses("type", "error"));
    try std.testing.expect(!try parses("type", "[]"));
    try std.testing.expect(!try parses("type", "interface{}"));
}

test "composite literal: positional, keyed, nested, slice/map" {
    try std.testing.expect(try parses("expression", "P{}"));
    try std.testing.expect(try parses("expression", "P{1, 2}"));
    try std.testing.expect(try parses("expression", "P{x: 1, y: 2,}"));
    try std.testing.expect(try parses("expression", "pkg.P{x: 1}"));
    try std.testing.expect(try parses("expression", "[]int{1, 2, 3}"));
    try std.testing.expect(try parses("expression", "[2]P{{1, 2}, {3, 4}}"));
    try std.testing.expect(try parses("expression", "map[string]int{\"a\": 1}"));
    try std.testing.expect(try parses("expression", "List[int]{}"));
    try std.testing.expect(try parses("expression", "P{1, 2}.x"));
}

test "selector and index chain" {
    try std.testing.expect(try parses("expression", "a.b.c"));
    try std.testing.expect(try parses("expression", "a[0][i + 1]"));
    try std.testing.expect(try parses("expression", "a.b(c)[d].e"));
    try std.testing.expect(try parses("expression", "f[int](x)"));
}

test "condition position does not read a bare composite literal (決定 5)" {
    // `if a {` の `a {` は composite literal ではなく条件 + ブロック
    try std.testing.expect(try parses("statement", "if a { b }"));
    try std.testing.expect(try parses("statement", "while a { b }"));
    try std.testing.expect(try parses("statement", "if a == b { c }"));
    // 括弧の中では読める
    try std.testing.expect(try parses("statement", "if (a == P{1}) { c }"));
    // 括弧なしは `a == P` の後に `{1}` ブロック、その後 `{ c }` が続いて失敗
    try std.testing.expect(!try parses("statement", "if a == P{1} { c }"));
}

test "switch: subject forms and case clauses" {
    try std.testing.expect(try parses("expression", "switch x { }"));
    try std.testing.expect(try parses("expression", "switch x { case 1: a; case 2: b; default: c }"));
    try std.testing.expect(try parses("expression", "switch x {\ncase 1:\n a\n b\ndefault:\n c\n}"));
    try std.testing.expect(try parses("expression", "switch { case a > 0: x; case a < 0: y }"));
    try std.testing.expect(try parses("expression", "switch f(a), g(b) { case v, nil: v; case _, err: err }"));
    try std.testing.expect(try parses("expression", "switch x { case 1 | 2: a; case -1: b; case pkg.C: c }"));
    try std.testing.expect(!try parses("expression", "switch x { case 1 a }"));
    try std.testing.expect(!try parses("expression", "switch x { a }"));
}

test "switch: type patterns (決定 3)" {
    try std.testing.expect(try parses("pattern", "NotFound{}"));
    try std.testing.expect(try parses("pattern", "NotFound{id}"));
    try std.testing.expect(try parses("pattern", "e NotFound{}"));
    try std.testing.expect(try parses("pattern", "e NotFound{id}"));
    try std.testing.expect(try parses("pattern", "BadLine{cause: strconv.Range{}}"));
    try std.testing.expect(try parses("pattern", "Hit{p: Profile{name, age: 3}}"));
    try std.testing.expect(try parses("pattern", "_"));
    try std.testing.expect(try parses("expression", "switch r { case Hit{p}: p.name; case Null{}: \"\" }"));
    try std.testing.expect(!try parses("pattern", "e f NotFound{}"));
}

test "pipe: stages are postfix expressions, left-assoc, holes" {
    try std.testing.expect(try parses("expression", "xs |> f"));
    try std.testing.expect(try parses("expression", "xs |> filter(p) |> collect"));
    try std.testing.expect(try parses("expression", "f() |> g(_, _)"));
    try std.testing.expect(try parses("expression", "a + b |> f"));
    try std.testing.expect(try parses("expression", "xs |> pkg.f(1)[0]"));
    try std.testing.expect(try parses("statement", "if xs |> any(p) { a }"));
    try std.testing.expect(!try parses("expression", "xs |> a + b"));
    try std.testing.expect(!try parses("expression", "xs |>"));
}

test "lambda: parameter forms and bodies" {
    try std.testing.expect(try parses("expression", "x => x + 1"));
    try std.testing.expect(try parses("expression", "(a, b) => a < b"));
    try std.testing.expect(try parses("expression", "(p Profile, n int) => p.age > n"));
    try std.testing.expect(try parses("expression", "() => 1"));
    try std.testing.expect(try parses("expression", "x => { y := x * 2; y }"));
    try std.testing.expect(try parses("expression", "x => y => x + y"));
    try std.testing.expect(try parses("expression", "xs |> pluck(u => u.id) |> filter((a, b) => a < b)"));
    try std.testing.expect(try parses("statement", "f := (a, b) => a < b"));
    try std.testing.expect(!try parses("expression", "x =>"));
    try std.testing.expect(!try parses("expression", "(x int) int => x"));
}

test "union and error declarations" {
    try std.testing.expect(try parses("type_decl", "type L union { A {} }"));
    try std.testing.expect(try parses("type_decl", "type Lookup union { Hit { p Profile }; Miss { reason string } }"));
    try std.testing.expect(try parses("type_decl", "type Value union {\n Null {}\n Bool { b bool }\n Num { v float64 }\n}"));
    try std.testing.expect(try parses("type_decl", "type Opt[T] union { Some { v T }; None {} }"));
    try std.testing.expect(try parses("type_decl", "type NotFound error { id int }"));
    try std.testing.expect(try parses("type_decl", "type Timeout error"));
    // 単一型の略記は無い（決定 2）
    try std.testing.expect(!try parses("type_decl", "type V union { Num float64 }"));
    try std.testing.expect(!try parses("type_decl", "type V union { A }"));
}

test "for ... yield: generators, guards, block body" {
    // '|>' は for 式全体に掛かる（yield の値は '|>' の手前で止まる）
    try std.testing.expect(try parses("expression", "for x <- xs yield x + 1 |> count"));
    try std.testing.expect(!try parses("for_expr", "for x <- xs yield x + 1 |> count"));
    try std.testing.expect(try parses("for_expr", "for x <- xs yield (x |> f)"));
    try std.testing.expect(try parses("expression", "for x <- xs { yield x } |> count"));
    try std.testing.expect(try parses("expression", "for x <- xs yield x"));
    try std.testing.expect(try parses("expression", "for x <- xs if p(x); y <- ys(x) yield Pair{x, y}"));
    try std.testing.expect(try parses("expression", "for x <- xs if a(x) if b(x) yield x"));
    try std.testing.expect(try parses("expression", "for k, v <- entries(m) yield k"));
    try std.testing.expect(try parses("expression", "for l <- lines(p) { u := parse(l); yield u }"));
    try std.testing.expect(try parses("expression", "for l <- lines(p) {\n u := parse(l)\n yield u\n}"));
    try std.testing.expect(!try parses("expression", "for x <- xs yield x, y"));
    try std.testing.expect(!try parses("expression", "for x <- xs, y <- ys yield x"));
    try std.testing.expect(!try parses("expression", "for x in xs yield x"));
}

test "postfix ?: propagate and rewrap" {
    try std.testing.expect(try parses("expression", "f()?"));
    try std.testing.expect(try parses("expression", "f()?.x"));
    try std.testing.expect(try parses("expression", "f()? BadLine{line: n}"));
    try std.testing.expect(try parses("expression", "a |> f()? |> g()"));
    try std.testing.expect(try parses("statement", "x := f()?\n"));
    // 条件位置: 包み替えは括弧が要る
    try std.testing.expect(try parses("statement", "if f()? { a }"));
    try std.testing.expect(try parses("statement", "if (f()? Label{}) { a }"));
    try std.testing.expect(!try parses("statement", "if f()? Label{} { a }"));
    // 裸のラベルは無い
    try std.testing.expect(!try parses("statement", "x := f()? Label\n"));
}

test "import declarations" {
    try std.testing.expect(try parses("source_file", "package p\nimport \"fmt\"\n"));
    try std.testing.expect(try parses("source_file", "package p\nimport io \"std/io\"\n"));
    try std.testing.expect(try parses("source_file", "package p\nimport (\n \"a\"\n b \"c\"\n)\n"));
    try std.testing.expect(try parses("source_file", "package p; import (\"a\"; \"b\"); func f() {}"));
    // `_` は識別子として字句解析されるので構文では別名に見える。決定 14 の拒否は AST 層
    try std.testing.expect(!try parses("source_file", "package p\nimport . \"a\"\n"));
    try std.testing.expect(!try parses("source_file", "package p\nfunc f() {}\nimport \"a\"\n"));
}

test "const declarations" {
    try std.testing.expect(try parses("top_level_decl", "const A = 1\n"));
    try std.testing.expect(try parses("top_level_decl", "const A, B = 1, 2\n"));
    try std.testing.expect(try parses("statement", "const n = 3"));
    try std.testing.expect(!try parses("top_level_decl", "const (A = 1)\n"));
}

test "annotations: declarations, fields, blocks" {
    try std.testing.expect(try parses("top_level_decl", "@pure func f() {}\n"));
    try std.testing.expect(try parses("top_level_decl", "@pure\nfunc f() {}\n"));
    try std.testing.expect(try parses("top_level_decl", "@errors(NotFound, Timeout)\n@recursion(depth: 8)\nfunc f() {}\n"));
    try std.testing.expect(try parses("top_level_decl", "@layout(c) type T struct { x int @json(name: \"x\") }\n"));
    try std.testing.expect(try parses("top_level_decl", "type H func(int) int @pure\n"));
    try std.testing.expect(try parses("statement", "@noblock { f() }"));
    try std.testing.expect(!try parses("top_level_decl", "@ func f() {}\n"));
    try std.testing.expect(!try parses("top_level_decl", "@pure\n"));
}

test "named arguments (決定 7)" {
    try std.testing.expect(try parses("expression", "f(x, sep: \",\")"));
    try std.testing.expect(try parses("expression", "f(sep: \",\", x)")); // 並びは AST 層で拒否
    try std.testing.expect(try parses("expression", "f(xs...)"));
    try std.testing.expect(try parses("expression", "x |> f(_, sep: \",\")"));
    try std.testing.expect(!try parses("expression", "f(x:)"));
}

test "structured concurrency: scope / spawn / shield / await / defer" {
    try std.testing.expect(try parses("expression", "scope { }"));
    try std.testing.expect(try parses("expression", "parallel scope { t := spawn f(x); await(t)? }"));
    try std.testing.expect(try parses("expression", "scope(timeout: 200 * time.ms) { g() }"));
    try std.testing.expect(try parses("expression", "shield { cleanup() }"));
    try std.testing.expect(try parses("statement", "defer close(f)"));
    try std.testing.expect(try parses("statement", "defer shield { flush() }"));
    try std.testing.expect(try parses("statement", "t := spawn compute(1, 2)"));
    try std.testing.expect(try parses("statement", "v := await(t)? |> unwrap"));
    try std.testing.expect(!try parses("expression", "parallel { }"));
    try std.testing.expect(!try parses("expression", "spawn"));
    try std.testing.expect(!try parses("expression", "shield f()"));
    try std.testing.expect(!try parses("statement", "defer"));
}

test "expression: slicing xs[a:b] (21 節)" {
    try std.testing.expect(try parses("expression", "xs[a:b]"));
    try std.testing.expect(try parses("expression", "s[0:5]"));
    try std.testing.expect(try parses("expression", "s[i + 1:len(s)]"));
    try std.testing.expect(try parses("expression", "s[0:5][1:2]"));
    // 添字は従来どおり
    try std.testing.expect(try parses("expression", "xs[i]"));
}
