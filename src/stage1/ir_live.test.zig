//! 生存解析と live interval（B-8b-1）: IR テキストの関数の区間をテキストに吐いて期待値で固定する
const std = @import("std");
const ir = @import("ir.zig");
const ir_parse = @import("ir_parse.zig");
const ir_cfg = @import("ir_cfg.zig");
const ir_live = @import("ir_live.zig");

fn expectIntervals(text: []const u8, want: []const u8) !void {
    var pd: ir_parse.Diag = .{};
    var m = ir_parse.parse(std.testing.allocator, text, &pd) catch |err| {
        std.debug.print("line {d}: {s}\n", .{ pd.line, pd.what });
        return err;
    };
    defer m.deinit();
    try ir.verify(&m);
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const f = m.funcs.items[0];
    const cfg = try ir_cfg.analyze(a, f);
    const live = try ir_live.analyze(a, f, &cfg);
    var out: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer out.deinit();
    for (live.order) |b| try out.writer.print("b{d}@{d} ", .{ b, live.block_pos[b] });
    try out.writer.writeAll("\n");
    for (live.iv, 0..) |iv, v| if (iv) |x| try out.writer.print("%{d} [{d}, {d}]\n", .{ v, x.start, x.end }) else try out.writer.print("%{d} -\n", .{v});
    try std.testing.expectEqualStrings(want, out.written());
}

test "live: ループの頭の引数はループの末尾まで生きる・ループの外の値はループ全体に伸びる・到達しないブロックは番号を持たない" {
    // b0@0: %1 = 2、%2 = 4、終端 6。b1@8: 引数 %3、%4 = 10、%5 = 12、終端 14。b2@16: %6 = 18、終端 20。b3@22: 終端 24
    // %0（関数の引数）はループの条件で使われるので、ループの末尾 b2 の終端（20）まで生きる。
    // ループの頭の引数 %3 は前任の終端（b0 の 6・b2 の 20）でも生きている（辺のコピーの書き先）
    try expectIntervals(
        \\
        \\func @count(%0 i64) i64 {
        \\b0:
        \\  %1 = const 0
        \\  %2 = const 1
        \\  br b1(%1)
        \\b1(%3 i64):
        \\  %4 = lt %3, %0
        \\  %5 = const 0
        \\  condbr %4, b2, b3
        \\b2:
        \\  %6 = add %3, %2
        \\  br b1(%6)
        \\b3:
        \\  ret %3
        \\b4:
        \\  %7 = const 9
        \\  ret %7
        \\}
        \\
    ,
        \\b0@0 b1@8 b2@16 b3@22 
        \\%0 [0, 20]
        \\%1 [2, 6]
        \\%2 [4, 20]
        \\%3 [6, 24]
        \\%4 [10, 14]
        \\%5 [12, 12]
        \\%6 [18, 20]
        \\%7 -
        \\
    );
}

test "live: condbr の 2 辺の実引数はどちらも前任の終端で使用・後続の引数は前任の終端から" {
    try expectIntervals(
        \\
        \\func @pick(%0 i64, %1 i64, %2 i64) i64 {
        \\b0:
        \\  condbr %0, b1(%1), b1(%2)
        \\b1(%3 i64):
        \\  ret %3
        \\}
        \\
    ,
        \\b0@0 b1@4 
        \\%0 [0, 2]
        \\%1 [0, 2]
        \\%2 [0, 2]
        \\%3 [2, 6]
        \\
    );
}
