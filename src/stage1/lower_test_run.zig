//! lower テストの足場: AST → IR → LLVM テキスト → `zig cc` → 実行（IR 経路の end-to-end）。
//! 各ケースを -O0 と -O2 の両方で、IR パス（mem2reg）の有無の 2 通りずつ下ろして観測（stdout + exit code）を比べる — -O0 / -O2 の食い違いは吐いた IR の UB 漏れ、パスの有無の食い違いは IR パスのバグ。
//! 同じ IR を正規バックエンド（ir_x86）でも下ろす（パスの有無の 2 列）— LLVM 列と食い違えばバックエンドのバグ（B-8）。
const std = @import("std");
const lower = @import("lower.zig");
const ir = @import("ir.zig");
const ir_llvm = @import("ir_llvm.zig");
const ir_mem2reg = @import("ir_mem2reg.zig");
const ir_rtlower = @import("ir_rtlower.zig");
const ir_x86 = @import("ir_x86.zig");
const loader = @import("loader.zig");
const build_options = @import("build_options");
const std_embed = @import("std_embed");
const std_table: loader.StdTable = .{ .paths = &std_embed.paths, .sources = &std_embed.sources };

/// load + lower だけ（拒否の検査 — lower_diag.test）。受理なら verify まで通す
pub fn lowerOnly(allocator: std.mem.Allocator, source: [:0]const u8) !void {
    return lowerFiles(allocator, &.{.{ .pkg_path = loader.main_pkg_path, .name = "test.sober", .source = source }});
}

pub fn lowerFiles(allocator: std.mem.Allocator, files: []const loader.SrcFile) !void {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    var ldiag: loader.Diag = .{};
    const prog = try loader.linkWithStd(allocator, arena.allocator(), files, std_table, &ldiag);
    var diag: lower.Diag = .{};
    var m = try lower.lower(allocator, &prog, &diag);
    defer m.deinit();
    try ir.verify(&m);
}

pub fn emitLl(allocator: std.mem.Allocator, source: [:0]const u8) ![]u8 {
    return emitLlOpt(allocator, source, false);
}

/// opt: IR パス（mem2reg）を通してから下ろす（パスの前後で検証する）
fn emitLlOpt(allocator: std.mem.Allocator, source: [:0]const u8, opt: bool) ![]u8 {
    return emitWith(allocator, source, opt, .ll);
}

fn emitWith(allocator: std.mem.Allocator, source: [:0]const u8, opt: bool, out: Out) ![]u8 {
    return emitFilesWith(allocator, &.{.{ .pkg_path = loader.main_pkg_path, .name = "test.sober", .source = source }}, opt, out, .{});
}

const Out = enum { ll, elf };

/// 複数 package の ELF（既定経路 = IR パス込みの正規バックエンド）
pub fn buildFiles(allocator: std.mem.Allocator, files: []const loader.SrcFile) ![]u8 {
    return emitFilesWith(allocator, files, true, .elf, .{});
}

/// 既定経路の ELF を lower の Options つきで（--mem-trace）
pub fn buildOpts(allocator: std.mem.Allocator, source: [:0]const u8, opts: lower.Options) ![]u8 {
    return emitFilesWith(allocator, &.{.{ .pkg_path = loader.main_pkg_path, .name = "test.sober", .source = source }}, true, .elf, opts);
}

fn emitFilesWith(allocator: std.mem.Allocator, files: []const loader.SrcFile, opt: bool, out: Out, opts: lower.Options) ![]u8 {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    var ldiag: loader.Diag = .{};
    const prog = try loader.linkWithStd(allocator, arena.allocator(), files, std_table, &ldiag);
    var diag: lower.Diag = .{};
    var m = lower.lowerOpts(allocator, &prog, &diag, opts) catch |err| {
        if (err != error.Unsupported) std.debug.print("lower: {s} what={s} tok#{d}\n", .{ @errorName(err), diag.what, diag.pos });
        return err;
    };
    defer m.deinit();
    try ir.verify(&m);
    if (opt) {
        try ir_mem2reg.run(&m);
        try ir.verify(&m);
    }
    try ir_rtlower.run(&m);
    try ir.verify(&m);
    return switch (out) {
        .ll => ir_llvm.emit(allocator, &m),
        .elf => ir_x86.emit(allocator, &m),
    };
}

fn runLevel(allocator: std.mem.Allocator, dir: std.fs.Dir, ll_path: []const u8, level: []const u8, expected_stdout: ?[]const u8, code: u8, slot_mb: ?[]const u8) !void {
    const exe = try std.fmt.allocPrint(allocator, "prog{s}", .{level});
    defer allocator.free(exe);
    const cc = try std.process.Child.run(.{
        .allocator = allocator,
        .cwd_dir = dir,
        .argv = &.{ build_options.zig_exe, "cc", "-target", "x86_64-linux-none", "-nostdlib", "-static", level, "-Wno-override-module", ll_path, "-o", exe },
    });
    defer allocator.free(cc.stdout);
    defer allocator.free(cc.stderr);
    if (cc.term != .Exited or cc.term.Exited != 0) {
        std.debug.print("zig cc {s} failed:\n{s}\n", .{ level, cc.stderr });
        return error.CcFailed;
    }
    runExe(allocator, dir, exe, expected_stdout, code, slot_mb) catch |err| {
        std.debug.print("level {s}\n", .{level});
        return err;
    };
}

/// slot_mb: 与えれば環境変数 SOBER_REGION_MB（region のスロットの大きさ — ir_rt.zig）にして実行する（溢れの検査を小さく走らせる）
fn runExe(allocator: std.mem.Allocator, dir: std.fs.Dir, exe: []const u8, expected_stdout: ?[]const u8, code: u8, slot_mb: ?[]const u8) !void {
    const path = try dir.realpathAlloc(allocator, exe);
    defer allocator.free(path);
    var env = std.process.EnvMap.init(allocator);
    defer env.deinit();
    if (slot_mb) |v| try env.put("SOBER_REGION_MB", v);
    const result = try std.process.Child.run(.{ .allocator = allocator, .argv = &.{path}, .env_map = &env });
    defer allocator.free(result.stdout);
    defer allocator.free(result.stderr);
    try std.testing.expectEqual(std.process.Child.Term{ .Exited = code }, result.term);
    if (expected_stdout) |want| try std.testing.expectEqualStrings(want, result.stdout);
}

/// 下ろして実行し、stdout と終了コードを -O0 / -O2 の両方で確かめる
/// 下ろして実行し、stdout と終了コードを -O0 / -O2 の両方で確かめる。IR パス（mem2reg）を通した .ll でも同じく確かめる
/// （4 列が食い違えば: -O0 / -O2 の差は UB 漏れ、パスの前後の差は IR パスのバグ）
pub fn expectRunExit(source: [:0]const u8, expected_stdout: []const u8, code: u8) !void {
    return runAll(source, expected_stdout, code, null);
}

/// 終了コードだけを確かめる（stdout は見ない — 溢れの panic 等）
pub fn expectExit(source: [:0]const u8, code: u8) !void {
    return runAll(source, null, code, null);
}

/// expectExit を、region のスロットを slot_mb MiB にして走らせる（SOBER_REGION_MB — 溢れの挙動を小さい入力で確かめる）
pub fn expectExitSlot(source: [:0]const u8, code: u8, slot_mb: []const u8) !void {
    return runAll(source, null, code, slot_mb);
}

fn runAll(source: [:0]const u8, expected_stdout: ?[]const u8, code: u8, slot_mb: ?[]const u8) !void {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    for ([_]bool{ false, true }) |opt| {
        const ll = try emitLlOpt(allocator, source, opt);
        defer allocator.free(ll);
        try tmp.dir.writeFile(.{ .sub_path = "prog.ll", .data = ll });
        for ([_][]const u8{ "-O0", "-O2" }) |level| runLevel(allocator, tmp.dir, "prog.ll", level, expected_stdout, code, slot_mb) catch |err| {
            std.debug.print("(IR passes: {s})\n", .{if (opt) "mem2reg" else "none"});
            return err;
        };
        const bin = try emitWith(allocator, source, opt, .elf);
        defer allocator.free(bin);
        try tmp.dir.writeFile(.{ .sub_path = "progx", .data = bin, .flags = .{ .mode = 0o755 } });
        runExe(allocator, tmp.dir, "progx", expected_stdout, code, slot_mb) catch |err| {
            std.debug.print("(backend ir_x86, IR passes: {s})\n", .{if (opt) "mem2reg" else "none"});
            return err;
        };
    }
}

pub fn expectRun(source: [:0]const u8, expected_stdout: []const u8) !void {
    try expectRunExit(source, expected_stdout, 0);
}
