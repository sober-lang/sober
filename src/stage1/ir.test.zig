const std = @import("std");
const ir = @import("ir.zig");

fn printed(m: *const ir.Module) ![]u8 {
    var out: std.Io.Writer.Allocating = .init(std.testing.allocator);
    errdefer out.deinit();
    try ir.print(m, &out.writer);
    return out.toOwnedSlice();
}

test "builder: ブロック引数つきの if を組んで印字する" {
    var m = ir.Module.init(std.testing.allocator);
    defer m.deinit();
    const id = try m.addFunc("abs", &.{.i64}, .i64);
    var b = try ir.Builder.begin(&m, id);
    const x = m.funcs.items[id].params[0];
    const neg = try b.newBlock();
    const join = try b.newBlock();
    const r = try b.param(join, .i64);
    const zero = try b.iconst(0);
    try b.condbr(try b.cmp(.lt, x, zero), neg, &.{}, join, &.{x});
    b.cur = neg;
    try b.br(join, &.{try b.bin(.sub, zero, x)});
    b.cur = join;
    b.ret(r);

    try ir.verify(&m);
    try std.testing.expectEqual(@as(u32, 2), b.block(join).preds);
    const text = try printed(&m);
    defer std.testing.allocator.free(text);
    try std.testing.expectEqualStrings(
        \\
        \\func @abs(%0 i64) i64 {
        \\b0:
        \\  %2 = const 0
        \\  %3 = lt %0, %2
        \\  condbr %3, b1, b2(%0)
        \\b1:
        \\  %4 = sub %2, %0
        \\  br b2(%4)
        \\b2(%1 i64):
        \\  ret %1
        \\}
        \\
    , text);
}

test "verify: 未終端のブロックを拒否する" {
    var m = ir.Module.init(std.testing.allocator);
    defer m.deinit();
    const id = try m.addFunc("f", &.{}, null);
    var b = try ir.Builder.begin(&m, id);
    _ = try b.newBlock();
    b.ret(null);
    try std.testing.expectError(error.InvalidIr, ir.verify(&m));
}

test "verify: ret の型が関数の結果と合わなければ拒否する" {
    var m = ir.Module.init(std.testing.allocator);
    defer m.deinit();
    const id = try m.addFunc("f", &.{}, .i64);
    var b = try ir.Builder.begin(&m, id);
    const g = try m.addGlobal("g", 1);
    const p = try b.globaladdr(g);
    // ptr を i64 の結果として返す（Builder の assert は数しか見ない）
    b.block(b.cur.?).term = .{ .ret = p };
    try std.testing.expectError(error.InvalidIr, ir.verify(&m));
}
