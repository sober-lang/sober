const std = @import("std");
const loader = @import("loader.zig");
const iface = @import("iface.zig");
const lower = @import("lower.zig");
const std_embed = @import("std_embed");
const std_table: loader.StdTable = .{ .paths = &std_embed.paths, .sources = &std_embed.sources };

fn emit(a: std.mem.Allocator, files: []const loader.SrcFile, pkg_path: []const u8) ![]u8 {
    var ldiag: loader.Diag = .{};
    const prog = loader.linkWithStd(std.testing.allocator, a, files, std_table, &ldiag) catch |err| {
        std.debug.print("link: {s} {s}\n", .{ ldiag.loc, ldiag.msg });
        return err;
    };
    for (prog.pkgs) |pkg| {
        if (!std.mem.eql(u8, pkg.path, pkg_path)) continue;
        var idiag: iface.Diag = .{};
        return iface.emitPkg(a, &prog, pkg, &idiag);
    }
    return error.NoSuchPackage;
}

const app: loader.SrcFile = .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source =
    \\package main
    \\import "lib"
    \\func main() { println(lib.F(1)) }
    \\
};

test "iface: link-visible closure, bodiless decls, folded consts, import pruning" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const files = [_]loader.SrcFile{
        app,
        .{ .pkg_path = "k", .name = "k/k.sober", .source = "package k\nconst Base = 40\n" },
        .{ .pkg_path = "u", .name = "u/u.sober", .source = "package u\nfunc G(x int) int { return x }\n" },
        .{ .pkg_path = "lib", .name = "lib/a.sober", .source =
        \\package lib
        \\
        \\import "k"
        \\import "u"
        \\
        \\// 公開 const は畳んだ値（k への参照は消える）
        \\const N = k.Base + 2
        \\
        \\type hid struct { v int }
        \\
        \\type Lost error
        \\
        \\// 公開の非展開関数: 本体なし。署名の非公開型 hid はリンク可視で載る
        \\func F(x int) int { return u.G(x) + helper(x) }
        \\
        \\func Wrap(x int) hid { return hid{v: x} }
        \\
        \\func Twice(f func(int) int, x int) int { return f(f(x)) + helper(x) }
        \\
        \\func helper(x int) int { return x * step }
        \\
        \\const step = 3
        \\
        \\func unused(x int) int { return x }
        \\
        },
    };
    const out = try emit(a, &files, "lib");
    try std.testing.expectEqualStrings(
        \\package lib
        \\
        \\const N = 42
        \\
        \\type hid struct { v int }
        \\
        \\type Lost error
        \\
        \\func F(x int) int
        \\
        \\func Wrap(x int) hid
        \\
        \\func Twice(f func(int) int, x int) int { return f(f(x)) + helper(x) }
        \\
        \\func helper(x int) int
        \\
    , out);
}

test "iface: a variant name pulls in its union; files keep load order; import used by a whole body stays" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const files = [_]loader.SrcFile{
        app,
        .{ .pkg_path = "u", .name = "u/u.sober", .source = "package u\nfunc G(x int) int { return x }\n" },
        .{ .pkg_path = "lib", .name = "lib/a.sober", .source = "package lib\nimport w \"u\"\nfunc F(x mut int) int { return pick(mut x) }\n" },
        .{ .pkg_path = "lib", .name = "lib/b.sober", .source =
        \\package lib
        \\import w "u"
        \\type shape union { Dot {}; Box { s int } }
        \\func pick(x mut int) int { return w.G(area(Box{s: x})) }
        \\func area(s shape) int { return 1 }
        \\
        },
    };
    const out = try emit(a, &files, "lib");
    try std.testing.expectEqualStrings(
        \\package lib
        \\
        \\import w "u"
        \\
        \\func F(x mut int) int { return pick(mut x) }
        \\
        \\type shape union { Dot {}; Box { s int } }
        \\
        \\func pick(x mut int) int { return w.G(area(Box{s: x})) }
        \\
        \\func area(s shape) int
        \\
    , out);
}

test "iface: a program with a bodiless function does not build" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const files = [_]loader.SrcFile{
        app,
        .{ .pkg_path = "lib", .name = "lib.sobi", .source = "package lib\nfunc F(x int) int\n" },
    };
    var ldiag: loader.Diag = .{};
    const prog = try loader.linkWithStd(std.testing.allocator, a, &files, std_table, &ldiag);
    var ldiag2: lower.Diag = .{};
    try std.testing.expectError(error.Unsupported, lower.lower(std.testing.allocator, &prog, &ldiag2));
}
