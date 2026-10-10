//! IR テキストのパーサ（B-6）: 往復不動点 print(parse(t)) == t と、構造の誤りの拒否
const std = @import("std");
const ir = @import("ir.zig");
const ir_parse = @import("ir_parse.zig");

fn printed(m: *const ir.Module) ![]u8 {
    var out: std.Io.Writer.Allocating = .init(std.testing.allocator);
    errdefer out.deinit();
    try ir.print(m, &out.writer);
    return out.toOwnedSlice();
}

fn expectRoundTrip(text: []const u8) !void {
    var diag: ir_parse.Diag = .{};
    var m = ir_parse.parse(std.testing.allocator, text, &diag) catch |err| {
        std.debug.print("line {d}: {s}\n", .{ diag.line, diag.what });
        return err;
    };
    defer m.deinit();
    try ir.verify(&m);
    const again = try printed(&m);
    defer std.testing.allocator.free(again);
    try std.testing.expectEqualStrings(text, again);
}

fn expectReject(text: []const u8, what: []const u8) !void {
    var diag: ir_parse.Diag = .{};
    try std.testing.expectError(error.ParseError, ir_parse.parse(std.testing.allocator, text, &diag));
    std.testing.expect(std.mem.indexOf(u8, diag.what, what) != null) catch |err| {
        std.debug.print("diag: {s}\n", .{diag.what});
        return err;
    };
}

test "往復: ブロック引数・前方参照のブロック・値の番号がブロック順と一致しない関数" {
    try expectRoundTrip(
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
    );
}

test "往復: global（rodata と .bss）・引用符つきの名前・前方参照の関数・関数値と間接呼び出し・スロット・export" {
    try expectRoundTrip(
        \\global @s.0 [2] = {104, -1}
        \\global @rt.buf [4]
        \\
        \\export func @entry() {
        \\  slot s0 [3]
        \\b0:
        \\  %0 = slotaddr s0
        \\  %1 = globaladdr @s.0
        \\  %2 = load.i64 %1[1]
        \\  store %0[2], %2
        \\  %3 = funcaddr @"main.id[Pair@7f00,fn(int,)]"
        \\  %4 = call.indirect.i64 %3(%2)
        \\  call.indirect %3(%4)
        \\  %5 = call @"main.id[Pair@7f00,fn(int,)]"(%4)
        \\  %6 = gep.byte %0, %5
        \\  %7 = load8 %6[0]
        \\  store8 %6[1], %7
        \\  %8 = ptoi %6
        \\  %9 = itop %8
        \\  %10 = load.ptr %9[0]
        \\  %11 = syscall(%8, %7)
        \\  exit 0
        \\}
        \\
        \\func @"main.id[Pair@7f00,fn(int,)]"(%0 i64) i64 {
        \\b0:
        \\  ret %0
        \\}
        \\
        \\func @"q\"x\\y"() {
        \\b0:
        \\  ret
        \\}
        \\
    );
}

test "往復: region op はランタイムの名前で結び直す" {
    try expectRoundTrip(
        \\global @rt.meta [4]
        \\
        \\func @rt.region_enter() {
        \\b0:
        \\  ret
        \\}
        \\
        \\func @rt.region_alloc(%0 i64, %1 i64) ptr {
        \\b0:
        \\  %2 = itop %1
        \\  ret %2
        \\}
        \\
        \\func @rt.region_relocate(%0 ptr, %1 i64, %2 i64) {
        \\b0:
        \\  ret
        \\}
        \\
        \\func @f(%0 ptr) {
        \\b0:
        \\  %1 = region.depth
        \\  region.enter
        \\  %2 = region.alloc %1, %1
        \\  %3 = region.bump %1
        \\  region.relocate %0, 3, %1
        \\  region.setdepth %1
        \\  ret
        \\}
        \\
    );
}

test "拒否: 構造の誤り（未定義の値・二重定義・欠けた番号・未知の op・結果の有無・未定義のブロック・ランタイム無しの region op）" {
    try expectReject("\nfunc @f() i64 {\nb0:\n  ret %3\n}\n", "not defined");
    try expectReject("\nfunc @f() {\nb0:\n  %0 = const 1\n  %0 = const 2\n  ret\n}\n", "defined twice");
    try expectReject("\nfunc @f() {\nb0:\n  %1 = const 1\n  ret\n}\n", "dense");
    try expectReject("\nfunc @f() {\nb0:\n  %0 = frob %0\n  ret\n}\n", "unknown op");
    try expectReject("\nfunc @f() {\nb0:\n  const 1\n  ret\n}\n", "has a result");
    try expectReject("\nfunc @f() {\nb0:\n  br b3\n}\n", "not defined");
    try expectReject("\nfunc @f() {\nb0:\n  %0 = call @g()\n  ret\n}\n", "undefined func");
    try expectReject("\nfunc @f() {\nb0:\n  region.enter\n  ret\n}\n", "runtime");
    try expectReject("\nfunc @f() {\nb0:\n  %0 = const 1\n", "missing");
}
