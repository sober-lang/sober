//! IR 検証器（B-7）: 型・支配・前任数の誤りを拒否する（テキストで書いて ir_parse で読む — パーサは構造しか見ない）
const std = @import("std");
const ir = @import("ir.zig");
const ir_parse = @import("ir_parse.zig");
const ir_verify = @import("ir_verify.zig");

fn expectInvalid(text: []const u8, what: []const u8) !void {
    var pd: ir_parse.Diag = .{};
    var m = try ir_parse.parse(std.testing.allocator, text, &pd);
    defer m.deinit();
    var d: ir_verify.Diag = .{};
    try std.testing.expectError(error.InvalidIr, ir_verify.verifyDiag(&m, &d));
    std.testing.expect(std.mem.indexOf(u8, d.what, what) != null) catch |err| {
        std.debug.print("diag: {s}\n", .{d.what});
        return err;
    };
}

fn expectValid(text: []const u8) !void {
    var pd: ir_parse.Diag = .{};
    var m = try ir_parse.parse(std.testing.allocator, text, &pd);
    defer m.deinit();
    var d: ir_verify.Diag = .{};
    ir_verify.verifyDiag(&m, &d) catch |err| {
        std.debug.print("diag: {s}\n", .{d.what});
        return err;
    };
}

test "検証器: オペランドの型（i64 と ptr の取り違え）" {
    try expectInvalid("\nfunc @f(%0 ptr) i64 {\nb0:\n  %1 = add %0, %0\n  ret %1\n}\n", "wants i64");
    try expectInvalid("\nfunc @f(%0 i64) {\nb0:\n  %1 = load.i64 %0[0]\n  ret\n}\n", "wants ptr");
    try expectInvalid("\nfunc @g(%0 ptr) {\nb0:\n  ret\n}\n\nfunc @f(%0 i64) {\nb0:\n  call @g(%0)\n  ret\n}\n", "call argument");
    try expectInvalid("\nfunc @f(%0 ptr) {\nb0:\n  br b1(%0)\nb1(%1 i64):\n  ret\n}\n", "edge argument");
    try expectInvalid("\nfunc @f(%0 ptr) i64 {\nb0:\n  ret %0\n}\n", "ret");
}

test "検証器: 定義が使用を支配しない（後の命令・兄弟の腕・合流後の片腕の値）" {
    try expectInvalid("\nfunc @f() i64 {\nb0:\n  %0 = add %1, %1\n  %1 = const 1\n  ret %0\n}\n", "does not dominate");
    try expectInvalid(
        \\
        \\func @f(%0 i64) i64 {
        \\b0:
        \\  condbr %0, b1, b2
        \\b1:
        \\  %1 = const 1
        \\  br b3
        \\b2:
        \\  br b3
        \\b3:
        \\  ret %1
        \\}
        \\
    , "does not dominate");
}

test "検証器: 支配する定義・ループの頭の引数・到達しないブロックの中は通す" {
    try expectValid(
        \\
        \\func @f(%0 i64) i64 {
        \\b0:
        \\  %1 = const 0
        \\  br b1(%1)
        \\b1(%2 i64):
        \\  %3 = lt %2, %0
        \\  condbr %3, b2, b3
        \\b2:
        \\  %4 = add %2, %0
        \\  br b1(%4)
        \\b3:
        \\  ret %2
        \\b4:
        \\  %5 = add %6, %6
        \\  %6 = const 1
        \\  exit 101
        \\}
        \\
    );
}
