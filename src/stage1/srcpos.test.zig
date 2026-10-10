//! 診断の座標系（srcpos.zig）: 通しトークン番号 → path:line:col。
//! ファイル横断（同 package の別ファイル・import 先 package）の診断が正しいファイルを指すこと。
const std = @import("std");
const srcpos = @import("srcpos.zig");
const Lexer = @import("lexer.zig");
const loader = @import("loader.zig");
const desugar = @import("desugar.zig");
const lower = @import("lower.zig");

fn locString(buf: []u8, map: srcpos.SourceMap, pos: ?srcpos.Pos) []const u8 {
    var w: std.Io.Writer = .fixed(buf);
    srcpos.writeLoc(&w, map, pos, "?") catch unreachable;
    return w.buffered();
}

test "SourceMap: bases accumulate per file and resolve to the owning file" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    var map: srcpos.SourceMap = .{};
    const src_a: [:0]const u8 = "package a\nx";
    const src_b: [:0]const u8 = "package b\n\n  y z";
    const ta = try Lexer.tokenize(std.testing.allocator, src_a);
    defer std.testing.allocator.free(ta);
    const tb = try Lexer.tokenize(std.testing.allocator, src_b);
    defer std.testing.allocator.free(tb);
    try std.testing.expectEqual(@as(srcpos.Pos, 0), try map.add(a, "a.sober", src_a, ta));
    const base_b = try map.add(a, "b.sober", src_b, tb);
    try std.testing.expectEqual(@as(srcpos.Pos, @intCast(ta.len)), base_b);

    var buf: [64]u8 = undefined;
    try std.testing.expectEqualStrings("a.sober:1:1", locString(&buf, map, 0));
    try std.testing.expectEqualStrings("a.sober:2:1", locString(&buf, map, 3)); // package a ;(自動挿入) x
    // b の先頭トークンは a の eof の次
    try std.testing.expectEqualStrings("b.sober:1:1", locString(&buf, map, base_b));
    try std.testing.expectEqual(@as(?usize, 1), map.fileOf(base_b));
    try std.testing.expectEqual(@as(?usize, 0), map.fileOf(base_b - 1));
    // 範囲外は解決できず fallback
    try std.testing.expectEqualStrings("?", locString(&buf, map, map.nextBase()));
    try std.testing.expectEqualStrings("?", locString(&buf, map, null));
}

test "loader: a clash in the second file of a package points at that file" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const files = [_]loader.SrcFile{
        .{ .pkg_path = loader.main_pkg_path, .name = "a.sober", .source = "package main\nfunc helper(n int) int { return n + 1 }\n" },
        .{ .pkg_path = loader.main_pkg_path, .name = "b.sober", .source = "package main\nfunc main() {\n    helper := 1\n}\n" },
    };
    var ldiag: loader.Diag = .{};
    try std.testing.expectError(error.LoadError, loader.link(std.testing.allocator, arena.allocator(), &files, &ldiag, .{}));
    try std.testing.expectEqualStrings("b.sober:3:5", ldiag.loc);
}

test "loader: a grammar failure in an imported package points at the farthest token" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const files = [_]loader.SrcFile{
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = "package main\nimport \"util\"\nfunc main() { return util.F() }\n" },
        .{ .pkg_path = "util", .name = "util/u.sober", .source = "package util\nfunc F() int {\n    return (1\n}\n" },
    };
    var ldiag: loader.Diag = .{};
    try std.testing.expectError(error.LoadError, loader.link(std.testing.allocator, arena.allocator(), &files, &ldiag, .{}));
    // `(1` の次（自動挿入された ; の位置 = 行末）で ')' を待って失敗する
    try std.testing.expectEqualStrings("util/u.sober:3:14", ldiag.loc);
    try std.testing.expectEqualStrings("source does not match the v0 grammar", ldiag.msg);
}

test "loader: diagnostics without a position keep the path" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const files = [_]loader.SrcFile{
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = "package main\nimport \"util\"\nfunc main() { return 1 }\n" },
    };
    var ldiag: loader.Diag = .{};
    try std.testing.expectError(error.LoadError, loader.link(std.testing.allocator, arena.allocator(), &files, &ldiag, .{}));
    try std.testing.expectEqualStrings("util", ldiag.loc);
}

const util_bad =
    \\package util
    \\
    \\func F(x int) int {
    \\    return x + nope
    \\}
    \\
;
const main_calls_util = "package main\nimport \"util\"\nfunc main() {\n    println(util.F(1))\n}\n";

fn linkUtil(a: std.mem.Allocator) !@import("ast.zig").Program {
    const files = [_]loader.SrcFile{
        .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = main_calls_util },
        .{ .pkg_path = "util", .name = "util/u.sober", .source = util_bad },
    };
    var ldiag: loader.Diag = .{};
    return loader.link(std.testing.allocator, a, &files, &ldiag, .{});
}

test "desugar: an error in an imported package resolves to that package's file" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const prog = try linkUtil(arena.allocator());
    var ddiag: desugar.Diag = .{};
    try std.testing.expectError(error.UnknownName, desugar.desugar(std.testing.allocator, &prog, &ddiag));
    var buf: [64]u8 = undefined;
    try std.testing.expectEqualStrings("util/u.sober:4:16", locString(&buf, prog.srcmap, ddiag.pos));
}

test "lower: an error in an imported package resolves to that package's file" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const prog = try linkUtil(arena.allocator());
    var ldiag2: lower.Diag = .{};
    try std.testing.expectError(error.UndefinedName, lower.lower(std.testing.allocator, &prog, &ldiag2));
    var buf: [64]u8 = undefined;
    try std.testing.expectEqualStrings("util/u.sober:4:16", locString(&buf, prog.srcmap, ldiag2.pos));
}

test "loader.load: importing a missing package renders the diagnostic before the arena is freed" {
    // 回帰（backend レーンの発見）: dir_path は load の arena にあり、失敗後の render が解放済みの文字列を
    // 読んで segfault していた。render は loadIn の errdefer で arena.deinit より先に走る
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    try tmp.dir.writeFile(.{ .sub_path = "main.sober", .data = "package main\n\nimport \"nope_missing_pkg\"\n\nfunc main() {\n    println(\"x\")\n}\n" });
    const entry = try tmp.dir.realpathAlloc(std.testing.allocator, "main.sober");
    defer std.testing.allocator.free(entry);
    var ldiag: loader.Diag = .{};
    try std.testing.expectError(error.LoadError, loader.load(std.testing.allocator, entry, .{}, &ldiag));
    try std.testing.expectEqualStrings("nope_missing_pkg", ldiag.loc);
    try std.testing.expectEqualStrings("cannot open package directory", ldiag.msg);
}
