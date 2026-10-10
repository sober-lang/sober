//! mem2reg（B-7）: IR テキストで書いた関数にパスを掛けて、結果のテキストと検証を確かめる
const std = @import("std");
const ir = @import("ir.zig");
const ir_parse = @import("ir_parse.zig");
const ir_mem2reg = @import("ir_mem2reg.zig");

fn expectPass(before: []const u8, after: []const u8) !void {
    var pd: ir_parse.Diag = .{};
    var m = ir_parse.parse(std.testing.allocator, before, &pd) catch |err| {
        std.debug.print("line {d}: {s}\n", .{ pd.line, pd.what });
        return err;
    };
    defer m.deinit();
    try ir.verify(&m);
    try ir_mem2reg.run(&m);
    try ir.verify(&m);
    var out: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer out.deinit();
    try ir.print(&m, &out.writer);
    try std.testing.expectEqualStrings(after, out.written());
}

test "mem2reg: ループの mut ローカルはループの頭のブロック引数になる・定義前の読みは 0" {
    try expectPass(
        \\
        \\func @sum(%0 i64) i64 {
        \\  slot s0 [1]
        \\  slot s1 [1]
        \\b0:
        \\  %1 = slotaddr s0
        \\  %2 = slotaddr s1
        \\  %3 = load.i64 %2[0]
        \\  store %1[0], %3
        \\  br b1
        \\b1:
        \\  %4 = load.i64 %1[0]
        \\  %5 = lt %4, %0
        \\  condbr %5, b2, b3
        \\b2:
        \\  %6 = const 1
        \\  %7 = add %4, %6
        \\  store %1[0], %7
        \\  br b1
        \\b3:
        \\  %8 = load.i64 %1[0]
        \\  ret %8
        \\}
        \\
    ,
        \\
        \\func @sum(%0 i64) i64 {
        \\b0:
        \\  %1 = const 0
        \\  br b1(%1)
        \\b1(%2 i64):
        \\  %3 = lt %2, %0
        \\  condbr %3, b2, b3
        \\b2:
        \\  %4 = const 1
        \\  %5 = add %2, %4
        \\  br b1(%5)
        \\b3:
        \\  ret %2
        \\}
        \\
    );
}

test "mem2reg: 逃げるスロット（アドレスが呼び出し・辺・格納値・gep に出る）と多語・ptr のスロットは残す" {
    try expectPass(
        \\
        \\func @g(%0 ptr) {
        \\b0:
        \\  ret
        \\}
        \\
        \\func @f(%0 ptr) i64 {
        \\  slot s0 [1]
        \\  slot s1 [2]
        \\  slot s2 [1]
        \\  slot s3 [1]
        \\b0:
        \\  %1 = slotaddr s0
        \\  call @g(%1)
        \\  %2 = slotaddr s1
        \\  %3 = load.i64 %2[0]
        \\  %4 = slotaddr s2
        \\  store %4[0], %0
        \\  %5 = slotaddr s3
        \\  %6 = const 7
        \\  store %5[0], %6
        \\  %7 = load.i64 %5[0]
        \\  ret %7
        \\}
        \\
    ,
        \\
        \\func @g(%0 ptr) {
        \\b0:
        \\  ret
        \\}
        \\
        \\func @f(%0 ptr) i64 {
        \\  slot s0 [1]
        \\  slot s1 [2]
        \\  slot s2 [1]
        \\b0:
        \\  %1 = const 0
        \\  %2 = slotaddr s0
        \\  call @g(%2)
        \\  %3 = slotaddr s1
        \\  %4 = load.i64 %3[0]
        \\  %5 = slotaddr s2
        \\  store %5[0], %0
        \\  %6 = const 7
        \\  ret %6
        \\}
        \\
    );
}

test "mem2reg: 合流で片腕だけ書く・到達しないブロックの読み書きも消える" {
    try expectPass(
        \\
        \\func @f(%0 i64) i64 {
        \\  slot s0 [1]
        \\b0:
        \\  %1 = slotaddr s0
        \\  %2 = const 5
        \\  store %1[0], %2
        \\  condbr %0, b1, b2
        \\b1:
        \\  store %1[0], %0
        \\  br b2
        \\b2:
        \\  %3 = load.i64 %1[0]
        \\  ret %3
        \\b3:
        \\  %4 = load.i64 %1[0]
        \\  store %1[0], %4
        \\  br b2
        \\}
        \\
    ,
        \\
        \\func @f(%0 i64) i64 {
        \\b0:
        \\  %1 = const 0
        \\  %2 = const 5
        \\  condbr %0, b1, b2(%2)
        \\b1:
        \\  br b2(%0)
        \\b2(%3 i64):
        \\  ret %3
        \\b3:
        \\  br b2(%1)
        \\}
        \\
    );
}
