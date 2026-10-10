//! analyzer 1 本目（acquire / release の局所照合 — R-a）のテスト。
//! 受理 / 拒否の手書きコーパスと、受理例から `defer ...Release` 行を 1 本ずつ消す変異（必ず拒否）。
//! 動的な底（Pool.Outstanding = 0）は scripts/pool_oracle.sh が testdata/pool で照合する。
const std = @import("std");
const analyzer = @import("analyzer.zig");
const loader = @import("loader.zig");
const std_embed = @import("std_embed");
const std_table: loader.StdTable = .{ .paths = &std_embed.paths, .sources = &std_embed.sources };

/// main package 1 ファイル（std を焼き込みから引く）を照合し、指摘の本文を返す
fn findings(a: std.mem.Allocator, source: [:0]const u8) ![]const []const u8 {
    var ldiag: loader.Diag = .{};
    const files = [_]loader.SrcFile{.{ .pkg_path = loader.main_pkg_path, .name = "test.sober", .source = source }};
    const prog = try loader.linkWithStd(a, a, &files, std_table, &ldiag);
    const fs = try analyzer.analyze(a, &prog);
    const out = try a.alloc([]const u8, fs.len);
    for (fs, out) |f, *o| o.* = f.what;
    return out;
}

const pre =
    \\package main
    \\import "std/pool"
    \\type Buf struct {
    \\    n int
    \\}
    \\func use(h pool.Handle) int {
    \\    return h.idx
    \\}
    \\
;

fn mainProg(a: std.mem.Allocator, comptime body: []const u8) ![:0]const u8 {
    return std.fmt.allocPrintSentinel(a, "{s}func main() {{\n    mut p := pool.Pool[Buf]{{}}\n{s}}}\n", .{ pre, body }, 0);
}

fn expectFindings(comptime body: []const u8, n: usize, needle: []const u8) !void {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const fs = try findings(a, try mainProg(a, body));
    if (fs.len != n or (n > 0 and std.mem.indexOf(u8, fs[0], needle) == null)) {
        std.debug.print("body:\n{s}findings ({d}, want {d} with '{s}'):\n", .{ body, fs.len, n, needle });
        for (fs) |f| std.debug.print("  {s}\n", .{f});
        return error.TestUnexpectedResult;
    }
}

test "accepted: acquire followed by defer release, in every block form" {
    // 直下・if の腕・while 本体・式ブロック・ラムダ本体・2 本並べる
    try expectFindings(
        \\    h := pool.Acquire(mut p, Buf{n: 1})
        \\    defer pool.Release(mut p, h)
        \\    if use(h) == 0 {
        \\        g := pool.Acquire(mut p, Buf{n: 2})
        \\        defer pool.Release(mut p, g)
        \\    }
        \\    mut i := 0
        \\    while i < 2 {
        \\        k := pool.Acquire(mut p, Buf{n: i})
        \\        defer pool.Release(mut p, k)
        \\        i += 1
        \\    }
        \\    v := {
        \\        a := pool.Acquire(mut p, Buf{n: 3})
        \\        defer pool.Release(mut p, a)
        \\        b := pool.Acquire(mut p, Buf{n: 4})
        \\        defer pool.Release(mut p, b)
        \\        use(a) + use(b)
        \\    }
        \\    println(v)
        \\
    , 0, "");
}

test "rejected: missing, late, or mismatched release (the fix line is shown)" {
    try expectFindings(
        \\    h := pool.Acquire(mut p, Buf{n: 1})
        \\    println(use(h))
        \\
    , 1, "insert `defer pool.Release(mut p, h)` right after this line");
    // 間に文が挟まる（脱出が挟まりうる）
    try expectFindings(
        \\    h := pool.Acquire(mut p, Buf{n: 1})
        \\    println(use(h))
        \\    defer pool.Release(mut p, h)
        \\
    , 2, "must be released by the next statement");
    // 別の Handle / 別の Pool
    try expectFindings(
        \\    g := pool.Acquire(mut p, Buf{n: 0})
        \\    defer pool.Release(mut p, g)
        \\    h := pool.Acquire(mut p, Buf{n: 1})
        \\    defer pool.Release(mut p, g)
        \\
    , 1, "this defer must release the handle just acquired: write `defer pool.Release(mut p, h)`");
    try expectFindings(
        \\    mut q := pool.Pool[Buf]{}
        \\    h := pool.Acquire(mut p, Buf{n: 1})
        \\    defer pool.Release(mut q, h)
        \\
    , 1, "this defer must release the handle just acquired");
    // 末尾で終わる（次の文が無い）
    try expectFindings(
        \\    h := pool.Acquire(mut p, Buf{n: 1})
        \\
    , 1, "must be released by the next statement");
}

test "rejected: Acquire outside the binding form, Release outside the paired defer" {
    // 捨てる文・式の途中・mut 束縛
    try expectFindings(
        \\    println(use(pool.Acquire(mut p, Buf{n: 1})))
        \\
    , 1, "Acquire must be bound");
    try expectFindings(
        \\    mut h := pool.Acquire(mut p, Buf{n: 1})
        \\    defer pool.Release(mut p, h)
        \\
    , 2, "Acquire must be bound");
    // 早すぎる release・二重 release・別名経由
    try expectFindings(
        \\    h := pool.Acquire(mut p, Buf{n: 1})
        \\    defer pool.Release(mut p, h)
        \\    pool.Release(mut p, h)
        \\
    , 1, "Release may only appear as `defer");
    try expectFindings(
        \\    h := pool.Acquire(mut p, Buf{n: 1})
        \\    defer pool.Release(mut p, h)
        \\    defer pool.Release(mut p, h)
        \\
    , 1, "Release may only appear");
    try expectFindings(
        \\    h := pool.Acquire(mut p, Buf{n: 1})
        \\    defer pool.Release(mut p, h)
        \\    h2 := h
        \\    defer pool.Release(mut p, h2)
        \\
    , 1, "Release may only appear");
}

test "mutation: deleting any defer-release line of an accepted program is rejected" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const src = try std.fs.cwd().readFileAlloc(a, "testdata/pool/nested.sober", 1 << 20);
    try std.testing.expectEqual(@as(usize, 0), (try findings(a, try a.dupeZ(u8, src))).len);
    var lines: std.ArrayListUnmanaged([]const u8) = .empty;
    var it = std.mem.splitScalar(u8, src, '\n');
    while (it.next()) |l| try lines.append(a, l);
    var mutants: usize = 0;
    for (lines.items, 0..) |l, drop| {
        if (std.mem.indexOf(u8, l, "defer pool.Release(") == null) continue;
        var buf: std.ArrayListUnmanaged(u8) = .empty;
        for (lines.items, 0..) |m, i| if (i != drop) {
            try buf.appendSlice(a, m);
            try buf.append(a, '\n');
        };
        const fs = try findings(a, try a.dupeZ(u8, buf.items));
        if (fs.len == 0) {
            std.debug.print("mutant accepted: line {d} deleted\n", .{drop + 1});
            return error.TestUnexpectedResult;
        }
        mutants += 1;
    }
    try std.testing.expect(mutants >= 4);
}
