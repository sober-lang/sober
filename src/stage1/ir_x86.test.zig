//! 正規バックエンド（ir_x86 — B-8）: 手書きの IR テキストを x86 と LLVM（-O0）の両方で下ろして走らせ、終了コードを期待値と比べる。
//! op の境界（div / rem の -1 と最小値・シフト量のマスク・辺の並行コピーの循環・7 引数の呼び出し・バイト格納）と、
//! 割り当て器の規約（callee-saved・syscall の周り・辺のコピーの書き先）を突く。x86 は割り当て器 2 種（linear / naive）× IR パスの有無で下ろす
const std = @import("std");
const ir = @import("ir.zig");
const ir_parse = @import("ir_parse.zig");
const ir_llvm = @import("ir_llvm.zig");
const ir_x86 = @import("ir_x86.zig");
const ir_mem2reg = @import("ir_mem2reg.zig");
const build_options = @import("build_options");

fn parse(text: []const u8) !ir.Module {
    var pd: ir_parse.Diag = .{};
    var m = ir_parse.parse(std.testing.allocator, text, &pd) catch |err| {
        std.debug.print("line {d}: {s}\n", .{ pd.line, pd.what });
        return err;
    };
    errdefer m.deinit();
    try ir.verify(&m);
    return m;
}

fn runPath(a: std.mem.Allocator, dir: std.fs.Dir, exe: []const u8) !std.process.Child.Term {
    const path = try dir.realpathAlloc(a, exe);
    defer a.free(path);
    const r = try std.process.Child.run(.{ .allocator = a, .argv = &.{path} });
    defer a.free(r.stdout);
    defer a.free(r.stderr);
    return r.term;
}

/// text の sober_entry は syscall(60, v) で終わる。x86（linear / naive × パス無し / mem2reg）と LLVM -O0 の 5 通りで終了コードを確かめる
fn expectExit(text: []const u8, code: u8) !void {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    const want: std.process.Child.Term = .{ .Exited = code };
    for ([_]bool{ false, true }) |opt| for ([_]ir_x86.Kind{ .linear, .naive }) |kind| {
        var m = try parse(text);
        defer m.deinit();
        if (opt) {
            try ir_mem2reg.run(&m);
            try ir.verify(&m);
        }
        const bin = try ir_x86.emitWith(a, &m, kind);
        defer a.free(bin);
        try tmp.dir.writeFile(.{ .sub_path = "x", .data = bin, .flags = .{ .mode = 0o755 } });
        std.testing.expectEqual(want, try runPath(a, tmp.dir, "x")) catch |err| {
            std.debug.print("(ir_x86 {s}, mem2reg: {})\n", .{ @tagName(kind), opt });
            return err;
        };
    };
    var m = try parse(text);
    defer m.deinit();
    const ll = try ir_llvm.emit(a, &m);
    defer a.free(ll);
    try tmp.dir.writeFile(.{ .sub_path = "p.ll", .data = ll });
    const cc = try std.process.Child.run(.{
        .allocator = a,
        .cwd_dir = tmp.dir,
        .argv = &.{ build_options.zig_exe, "cc", "-target", "x86_64-linux-none", "-nostdlib", "-static", "-O0", "-Wno-override-module", "p.ll", "-o", "l" },
    });
    defer a.free(cc.stdout);
    defer a.free(cc.stderr);
    if (cc.term != .Exited or cc.term.Exited != 0) {
        std.debug.print("zig cc failed:\n{s}\n", .{cc.stderr});
        return error.CcFailed;
    }
    std.testing.expectEqual(want, try runPath(a, tmp.dir, "l")) catch |err| {
        std.debug.print("(llvm -O0)\n", .{});
        return err;
    };
}

test "ir_x86: div / rem の -1・最小値・負の被除数（Go と同じ結果）" {
    // (MIN / -1 = MIN) の下位 8 bit = 0、MIN % -1 = 0、-7 / 2 = -3、-7 % 2 = -1 → 0 + 0 + (-3) * 10 + (-1) = -31 → 225
    try expectExit(
        \\
        \\export func @sober_entry() {
        \\b0:
        \\  %0 = const -9223372036854775808
        \\  %1 = const -1
        \\  %2 = div %0, %1
        \\  %3 = rem %0, %1
        \\  %4 = const -7
        \\  %5 = const 2
        \\  %6 = div %4, %5
        \\  %7 = rem %4, %5
        \\  %8 = const 10
        \\  %9 = mul %6, %8
        \\  %10 = add %2, %3
        \\  %11 = add %10, %9
        \\  %12 = add %11, %7
        \\  %13 = const 60
        \\  %14 = syscall(%13, %12)
        \\  exit 0
        \\}
        \\
    , 225);
}

test "ir_x86: ゼロ除算は exit 101（被除数が値でも定数でも）" {
    try expectExit(
        \\
        \\export func @sober_entry() {
        \\b0:
        \\  %0 = const 5
        \\  %1 = const 0
        \\  %2 = rem %0, %1
        \\  %3 = const 60
        \\  %4 = syscall(%3, %2)
        \\  exit 0
        \\}
        \\
    , 101);
}

test "ir_x86: シフト量は下位 6 bit（shl 65 = shl 1）・sar は符号を保つ・ult / uge は符号なし" {
    // (3 shl 65) = 6、(-16 sar 2) = -4、ult(-1, 1) = 0、uge(-1, 1) = 1 → 6 + (-4) * -10 + 0 * 100 + 1 * 3 = 49
    try expectExit(
        \\
        \\export func @sober_entry() {
        \\b0:
        \\  %0 = const 3
        \\  %1 = const 65
        \\  %2 = shl %0, %1
        \\  %3 = const -16
        \\  %4 = const 2
        \\  %5 = sar %3, %4
        \\  %6 = const -10
        \\  %7 = mul %5, %6
        \\  %8 = const -1
        \\  %9 = const 1
        \\  %10 = ult %8, %9
        \\  %11 = uge %8, %9
        \\  %12 = const 100
        \\  %13 = mul %10, %12
        \\  %14 = const 3
        \\  %15 = mul %11, %14
        \\  %16 = add %2, %7
        \\  %17 = add %16, %13
        \\  %18 = add %17, %15
        \\  %19 = const 60
        \\  %20 = syscall(%19, %18)
        \\  exit 0
        \\}
        \\
    , 49);
}

test "ir_x86: 辺の並行コピー（ループの頭で a, b = b, a + b の入れ替え）・condbr の 2 辺が同じブロック" {
    // fib: (a, b) = (0, 1) を 10 回 → a = 55。最後に condbr の両辺を b4 へ別の実引数で
    try expectExit(
        \\
        \\export func @sober_entry() {
        \\b0:
        \\  %0 = const 0
        \\  %1 = const 1
        \\  %2 = const 10
        \\  br b1(%0, %1, %2)
        \\b1(%3 i64, %4 i64, %5 i64):
        \\  %6 = const 0
        \\  %7 = gt %5, %6
        \\  condbr %7, b2, b3
        \\b2:
        \\  %8 = add %3, %4
        \\  %9 = const 1
        \\  %10 = sub %5, %9
        \\  br b1(%4, %8, %10)
        \\b3:
        \\  %11 = const 1
        \\  condbr %11, b4(%3), b4(%4)
        \\b4(%12 i64):
        \\  %13 = const 60
        \\  %14 = syscall(%13, %12)
        \\  exit 0
        \\}
        \\
    , 55);
}

test "ir_x86: 7 引数の呼び出し（引数の順）・関数値の間接呼び出し・スロットのゼロ初期化・バイトの格納と読み" {
    // f(a..g) = a - b + c - d + e - f + g*2 = 1 - 2 + 3 - 4 + 5 - 6 + 14 = 11。
    // 間接で g2(x) = x * 3 → 33。スロット（未書き込み = 0）の語 1 を足す → 33。byte 255 を格納して読む → 33 + 255 = 288 → 32
    try expectExit(
        \\
        \\func @f(%0 i64, %1 i64, %2 i64, %3 i64, %4 i64, %5 i64, %6 i64) i64 {
        \\b0:
        \\  %7 = sub %0, %1
        \\  %8 = add %7, %2
        \\  %9 = sub %8, %3
        \\  %10 = add %9, %4
        \\  %11 = sub %10, %5
        \\  %12 = add %11, %6
        \\  %13 = add %12, %6
        \\  ret %13
        \\}
        \\
        \\func @g2(%0 i64) i64 {
        \\b0:
        \\  %1 = const 3
        \\  %2 = mul %0, %1
        \\  ret %2
        \\}
        \\
        \\export func @sober_entry() {
        \\  slot s0 [2]
        \\b0:
        \\  %0 = const 1
        \\  %1 = const 2
        \\  %2 = const 3
        \\  %3 = const 4
        \\  %4 = const 5
        \\  %5 = const 6
        \\  %6 = const 7
        \\  %7 = call @f(%0, %1, %2, %3, %4, %5, %6)
        \\  %8 = funcaddr @g2
        \\  %9 = call.indirect.i64 %8(%7)
        \\  %10 = slotaddr s0
        \\  %11 = load.i64 %10[1]
        \\  %12 = add %9, %11
        \\  %13 = const 255
        \\  store8 %10[3], %13
        \\  %14 = load8 %10[3]
        \\  %15 = add %12, %14
        \\  %16 = const 60
        \\  %17 = syscall(%16, %15)
        \\  exit 0
        \\}
        \\
    , 32);
}

test "ir_x86: callee の syscall は呼び手がレジスタに持つ値を壊さない（引数レジスタも callee-saved）" {
    // 7 個の値が call をまたいで生きる → rbx, r12〜r15, rsi, rdi に載る。callee は write(1, p, 0) で rdi / rsi / rdx / r10 を使う
    // 1 + 2 + … + 7 = 28
    try expectExit(
        \\
        \\func @touch() {
        \\b0:
        \\  %0 = const 1
        \\  %1 = const 0
        \\  %2 = syscall(%0, %0, %1, %1, %1)
        \\  ret
        \\}
        \\
        \\export func @sober_entry() {
        \\b0:
        \\  %0 = const 1
        \\  %1 = const 2
        \\  %2 = const 3
        \\  %3 = const 4
        \\  %4 = const 5
        \\  %5 = const 6
        \\  %6 = const 7
        \\  call @touch()
        \\  %7 = add %0, %1
        \\  %8 = add %7, %2
        \\  %9 = add %8, %3
        \\  %10 = add %9, %4
        \\  %11 = add %10, %5
        \\  %12 = add %11, %6
        \\  %13 = const 60
        \\  %14 = syscall(%13, %12)
        \\  exit 0
        \\}
        \\
    , 28);
}

test "ir_x86: 辺のコピーはループの頭の引数の置き場へ書く — 引数が頭で死んでも末尾で生きている値を壊さない" {
    // %3 はループの頭でしか使わない。末尾の b2 では %2（ループの外の値）が生きている。10 回回して %2 * 10 + 1 = 71
    try expectExit(
        \\
        \\export func @sober_entry() {
        \\b0:
        \\  %0 = const 10
        \\  %1 = const 0
        \\  %2 = const 7
        \\  br b1(%0, %1)
        \\b1(%3 i64, %4 i64):
        \\  %5 = const 0
        \\  %6 = gt %3, %5
        \\  condbr %6, b2, b3
        \\b2:
        \\  %7 = const 1
        \\  %8 = sub %3, %7
        \\  %9 = add %4, %2
        \\  br b1(%8, %9)
        \\b3:
        \\  %10 = const 1
        \\  %11 = add %4, %10
        \\  %12 = const 60
        \\  %13 = syscall(%12, %11)
        \\  exit 0
        \\}
        \\
    , 71);
}
