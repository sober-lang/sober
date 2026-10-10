const std = @import("std");
const Lexer = @import("lexer.zig");
const grammar = @import("grammar.zig");
const cst = @import("cst.zig");
const ast = @import("ast.zig");
const cst_to_ast = @import("cst_to_ast.zig");

fn parseToAst(allocator: std.mem.Allocator, source: [:0]const u8, diag: *cst_to_ast.Diag) !ast.Ast {
    const tokens = try Lexer.tokenize(allocator, source);
    defer allocator.free(tokens);
    var m = grammar.Matcher.init(allocator, tokens);
    defer m.deinit();
    const root = (try m.parse("source_file")) orelse return error.ParseFailed;
    return cst_to_ast.convert(allocator, cst.Tree.fromMatcher(&m, source, root), diag);
}

test "fib: functions, params, result, if expression, calls" {
    const a = std.testing.allocator;
    var diag: cst_to_ast.Diag = .{};
    var t = try parseToAst(a,
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
    , &diag);
    defer t.deinit();

    try std.testing.expectEqualStrings("main", t.file.package);
    try std.testing.expectEqual(@as(usize, 2), t.file.funcs.len);

    const fib = t.file.funcs[0];
    try std.testing.expectEqualStrings("fib", fib.name);
    try std.testing.expectEqual(@as(usize, 1), fib.params.len);
    try std.testing.expectEqualStrings("n", fib.params[0].name);
    try std.testing.expectEqualStrings("int", fib.params[0].type.name);
    try std.testing.expectEqual(@as(usize, 1), fib.results.len);
    try std.testing.expectEqualStrings("int", fib.results[0].name);
    try std.testing.expectEqual(@as(usize, 1), fib.body.stmts.len);

    const ret = fib.body.stmts[0].ret;
    try std.testing.expectEqual(@as(usize, 1), ret.values.len);
    const if_ = ret.values[0].if_;
    try std.testing.expectEqual(.less, if_.cond.binary.op);
    try std.testing.expectEqualStrings("n", if_.cond.binary.lhs.ident.name);
    try std.testing.expectEqual(@as(i64, 2), if_.cond.binary.rhs.int.value);
    try std.testing.expectEqualStrings("n", if_.then.tailExpr().?.ident.name);
    const else_block = if_.else_.?.block;
    const sum = else_block.tailExpr().?.binary;
    try std.testing.expectEqual(.plus, sum.op);
    try std.testing.expectEqualStrings("fib", sum.lhs.call.callee.ident.name);
    try std.testing.expectEqual(.minus, sum.lhs.call.args[0].binary.op);

    const main_fn = t.file.funcs[1];
    try std.testing.expectEqual(@as(usize, 0), main_fn.results.len);
    const call = main_fn.body.stmts[0].expr.call;
    try std.testing.expectEqualStrings("println", call.callee.ident.name);
    try std.testing.expectEqual(@as(i64, 10), call.args[0].call.args[0].int.value);
}

test "binary operators fold left-associatively with precedence from the grammar" {
    const a = std.testing.allocator;
    var diag: cst_to_ast.Diag = .{};
    var t = try parseToAst(a, "package p\nfunc f() int { return 1 - 2 - 3 * 4 }\n", &diag);
    defer t.deinit();
    const e = t.file.funcs[0].body.stmts[0].ret.values[0].binary;
    // (1 - 2) - (3 * 4)
    try std.testing.expectEqual(.minus, e.op);
    try std.testing.expectEqual(.minus, e.lhs.binary.op);
    try std.testing.expectEqual(@as(i64, 1), e.lhs.binary.lhs.int.value);
    try std.testing.expectEqual(.star, e.rhs.binary.op);
}

test "statements: bind, mut, assign, compound assign, while, break, continue, unary" {
    const a = std.testing.allocator;
    var diag: cst_to_ast.Diag = .{};
    var t = try parseToAst(a,
        \\package p
        \\func f(n int) int {
        \\    mut i := 0
        \\    acc := -n
        \\    while i < n {
        \\        i += 1
        \\        if i == 3 { break }
        \\        continue
        \\    }
        \\    i = (acc)
        \\    return i
        \\}
    , &diag);
    defer t.deinit();
    const s = t.file.funcs[0].body.stmts;
    try std.testing.expectEqual(@as(usize, 5), s.len);
    try std.testing.expect(s[0].bind.mutable);
    try std.testing.expectEqualStrings("i", s[0].bind.names[0]);
    try std.testing.expect(!s[1].bind.mutable);
    try std.testing.expectEqual(.minus, s[1].bind.values[0].unary.op);
    const w = s[2].while_;
    try std.testing.expectEqual(.less, w.cond.binary.op);
    try std.testing.expectEqual(.plus_equal, w.body.stmts[0].assign.op);
    try std.testing.expect(w.body.stmts[1].expr.if_.then.stmts[0] == .break_);
    try std.testing.expect(w.body.stmts[2] == .continue_);
    try std.testing.expectEqual(.equal, s[3].assign.op);
    try std.testing.expectEqualStrings("acc", s[3].assign.values[0].ident.name);
}

test "unsupported constructs are reported with rule and token" {
    const a = std.testing.allocator;
    var diag: cst_to_ast.Diag = .{};
    try std.testing.expectError(error.Unsupported, parseToAst(a, "package p\nfunc f() int { return xs |> g(x => x)? }\n", &diag));
    try std.testing.expectEqualStrings("postfix after the pipe stage call", diag.what);
    try std.testing.expectError(error.Unsupported, parseToAst(a, "package p\nfunc f() int { return xs |> g()? }\n", &diag));
    try std.testing.expectEqualStrings("postfix after the pipe stage call", diag.what);
    try std.testing.expectError(error.Unsupported, parseToAst(a, "package p\n@pure\nfunc f() int { return 1 }\n", &diag));
    try std.testing.expectEqualStrings("annotation", diag.what);
    try std.testing.expectError(error.Unsupported, parseToAst(a, "package p\nfunc f() { x := `raw` }\n", &diag));
    try std.testing.expectEqualStrings("literal kind", diag.what);
}

test "for expression, yield statement, named function type (V3-4)" {
    const a = std.testing.allocator;
    var diag: cst_to_ast.Diag = .{};
    var t = try parseToAst(a,
        \\package p
        \\
        \\type Iter[T] func(func(T))
        \\
        \\func f(xs []int) int {
        \\    n := for x <- xs if x > 0 if x < 9 yield x * 2 |> count
        \\    m := for x <- xs {
        \\        y := x + 1
        \\        yield y
        \\    }
        \\    return n
        \\}
        \\
    , &diag);
    defer t.deinit();
    const it = t.file.types[0];
    try std.testing.expectEqualStrings("T", it.type_params[0]);
    try std.testing.expectEqual(@as(usize, 1), it.body.func_.params.len);
    const s = t.file.funcs[0].body.stmts;
    // `|>` は for 式全体に掛かる（language.md 7 節）
    const p = s[0].bind.values[0].pipe;
    const fe = p.lhs.for_;
    try std.testing.expectEqual(@as(usize, 1), fe.gens.len);
    try std.testing.expectEqualStrings("x", fe.gens[0].names[0]);
    try std.testing.expectEqual(@as(usize, 2), fe.gens[0].guards.len);
    try std.testing.expectEqual(.star, fe.body.yield_.binary.op);
    const blk = s[1].bind.values[0].for_.body.block;
    try std.testing.expect(blk.stmts[1] == .yield_);
    // yield は for 本体の外（とラムダ本体の中）では書けない
    try std.testing.expectError(error.Unsupported, parseToAst(a, "package p\nfunc f() { yield 1 }\n", &diag));
    try std.testing.expectError(error.Unsupported, parseToAst(a, "package p\nfunc f(xs []int) { g(for x <- xs { h(y => { yield y }) }) }\n", &diag));
}

test "string template: normal form is n+1 constant parts and n holes (empty parts kept)" {
    const a = std.testing.allocator;
    var diag: cst_to_ast.Diag = .{};
    var t = try parseToAst(a, "package main\nfunc main() { return \"${x}${y}-\\${z}\" }\n", &diag);
    defer t.deinit();
    const e = t.file.funcs[0].body.stmts[0].ret.values[0];
    const tmpl = e.interp.tmpl;
    try std.testing.expectEqual(@as(usize, 2), tmpl.holes.len);
    try std.testing.expectEqual(@as(usize, 3), tmpl.lits.len);
    try std.testing.expectEqualStrings("", tmpl.lits[0]);
    try std.testing.expectEqualStrings("", tmpl.lits[1]);
    try std.testing.expectEqualStrings("-${z}", tmpl.lits[2]);
    try std.testing.expectEqualStrings("x", tmpl.holes[0].ident.name);
    try std.testing.expectEqualStrings("y", tmpl.holes[1].ident.name);
    // 穴の無いリテラルは strlit のまま
    var t2 = try parseToAst(a, "package main\nfunc main() { return \"a$b\" }\n", &diag);
    defer t2.deinit();
    try std.testing.expectEqualStrings("a$b", t2.file.funcs[0].body.stmts[0].ret.values[0].strlit.value);
}

fn parseIface(allocator: std.mem.Allocator, source: [:0]const u8, iface: bool, diag: *cst_to_ast.Diag) !ast.Ast {
    const tokens = try Lexer.tokenize(allocator, source);
    defer allocator.free(tokens);
    var m = grammar.Matcher.init(allocator, tokens);
    defer m.deinit();
    const root = (try m.parse("source_file")) orelse return error.ParseFailed;
    return cst_to_ast.convertOpts(allocator, cst.Tree.fromMatcher(&m, source, root), 0, .{ .iface = iface }, diag);
}

test "bodiless func: only in a .sobi interface (language.md 29)" {
    const a = std.testing.allocator;
    var diag: cst_to_ast.Diag = .{};
    const src = "package p\nfunc F(x int) int\nfunc g() {}\n";
    try std.testing.expectError(error.Unsupported, parseIface(a, src, false, &diag));
    var t = try parseIface(a, src, true, &diag);
    defer t.deinit();
    try std.testing.expect(t.file.funcs[0].bodiless);
    try std.testing.expectEqual(@as(usize, 0), t.file.funcs[0].body.stmts.len);
    try std.testing.expect(!t.file.funcs[1].bodiless);
}

test "top-level spans: annotations and the trailing ';' are inside, signature end is before the body" {
    const a = std.testing.allocator;
    var diag: cst_to_ast.Diag = .{};
    // 0 package 1 p 2 ; | 3 @ 4 errors 5 ( 6 E 7 ) 8 ; 9 func 10 F 11 ( 12 ) 13 error 14 ? 15 { 16 } 17 ; | 18 const 19 a 20 , 21 b 22 = 23 1 24 , 25 2 26 ;
    var t = try parseIface(a, "package p\n@errors(E)\nfunc F() error? {}\nconst a, b = 1, 2\n", false, &diag);
    defer t.deinit();
    const f = t.file.funcs[0];
    try std.testing.expectEqual(@as(u32, 3), f.span.start);
    try std.testing.expectEqual(@as(u32, 18), f.span.end);
    try std.testing.expectEqual(@as(u32, 15), f.sig_end);
    try std.testing.expectEqual(t.file.consts[0].span.start, t.file.consts[1].span.start);
}

test "補間の穴の中の呼び出しと ? も囲みの関数の callees / has_try に数える" {
    const a = std.testing.allocator;
    var diag: cst_to_ast.Diag = .{};
    var t = try parseToAst(a,
        \\package main
        \\
        \\func f(n int) (int, error?) {
        \\    println("a${g(n)?}b${h(n)}")
        \\    return 0, nil
        \\}
        \\
    , &diag);
    defer t.deinit();
    const f = t.file.funcs[0];
    try std.testing.expect(f.has_try);
    try std.testing.expectEqual(@as(usize, 3), f.callees.len);
    // 引数を先に変換するので、外側の呼び出しは後ろ
    try std.testing.expectEqualStrings("g", f.callees[0]);
    try std.testing.expectEqualStrings("h", f.callees[1]);
    try std.testing.expectEqualStrings("println", f.callees[2]);
}
