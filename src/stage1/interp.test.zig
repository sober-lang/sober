//! 文字列補間 `${}`（随時回収 R7）: 字句（1 トークンのまま入れ子を読み飛ばす）・脱糖の受理 / 拒否。
//! 実行結果の突き合わせは examples/interp.sober(.out)
const std = @import("std");
const Lexer = @import("lexer.zig");
const Token = @import("token.zig");
const loader = @import("loader.zig");
const desugar = @import("desugar.zig");
const lower = @import("lower.zig");
const ir = @import("ir.zig");
const std_embed = @import("std_embed");
const std_table: loader.StdTable = .{ .paths = &std_embed.paths, .sources = &std_embed.sources };

fn expectOneString(source: [:0]const u8) !void {
    var l = Lexer.init(source);
    const t = l.next();
    try std.testing.expectEqual(Token.Tag.string_literal, t.tag);
    try std.testing.expectEqual(@as(u32, @intCast(source.len)), t.loc.end);
}

test "lexer: an interpolated string stays one token, skipping nested strings and braces" {
    try expectOneString("\"a${x}b\"");
    try expectOneString("\"${f(\"}\")}\"");
    try expectOneString("\"${\"in${n}ner\"}\"");
    try expectOneString("\"${P{x: 1}.x}\"");
    try expectOneString("\"${`raw}`}\"");
    try expectOneString("\"lone $ and \\${esc}\"");
}

test "lexer: an unterminated interpolation is invalid" {
    var l = Lexer.init("\"${x\"");
    try std.testing.expectEqual(Token.Tag.invalid, l.next().tag);
    var l2 = Lexer.init("\"${x\n}\"");
    try std.testing.expectEqual(Token.Tag.invalid, l2.next().tag);
}

fn link(a: std.mem.Allocator, source: [:0]const u8) !@import("ast.zig").Program {
    var ldiag: loader.Diag = .{};
    const files = [_]loader.SrcFile{.{ .pkg_path = loader.main_pkg_path, .name = "test.sober", .source = source }};
    return loader.linkWithStd(std.testing.allocator, a, &files, std_table, &ldiag);
}

fn desugarResult(source: [:0]const u8) !void {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const prog = try link(arena.allocator(), source);
    var ddiag: desugar.Diag = .{};
    var core = try desugar.desugar(std.testing.allocator, &prog, &ddiag);
    core.deinit();
}

fn lowerResult(source: [:0]const u8) !void {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const prog = try link(arena.allocator(), source);
    var ldiag2: lower.Diag = .{};
    var m = try lower.lower(std.testing.allocator, &prog, &ldiag2);
    defer m.deinit();
    try ir.verify(&m);
}

test "interp: int / string / bool are accepted by both layers (std/strings is imported implicitly)" {
    const src = "package main\nfunc main() {\n    n := 1\n    println(\"${n} ${\"s\"} ${n > 0} ${-n}\")\n}\n";
    try desugarResult(src);
    try lowerResult(src);
}

test "interp: other types are rejected by both layers" {
    const cases = [_][:0]const u8{
        "package main\nfunc main() { xs := []int{1}\n println(\"${xs}\") }\n",
        "package main\ntype P struct { x int }\nfunc main() { p := P{1}\n println(\"${p}\") }\n",
        "package main\nfunc main() { m := map[int]int{1: 2}\n println(\"${m}\") }\n",
        "package main\nfunc f(x int?) string { return \"${x}\" }\nfunc main() { println(f(1)) }\n",
    };
    for (cases) |src| {
        try std.testing.expectError(error.CoreFragment, desugarResult(src));
        try std.testing.expectError(error.TypeMismatch, lowerResult(src));
    }
}

test "interp: the body must be a single expression" {
    try std.testing.expectError(error.Unsupported, desugarResult("package main\nfunc main() { println(\"${1 2}\") }\n"));
    try std.testing.expectError(error.Unsupported, desugarResult("package main\nfunc main() { println(\"${}\") }\n"));
}
