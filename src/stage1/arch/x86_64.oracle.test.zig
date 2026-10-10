//! x86_64 エンコーダのオラクルテスト。
//! 自前エンコードのバイト列を GNU as（Intel 構文）の出力と比較する。
//! as はテストでのみ使う（docs/oracles.md「外部の確立したツール」）。
const std = @import("std");
const Emitter = @import("x86_64.zig");

const Case = struct {
    asm_text: []const u8,
    emit: *const fn (*Emitter) anyerror!void,
};

fn assemble(allocator: std.mem.Allocator, tmp: std.testing.TmpDir, asm_text: []const u8) ![]u8 {
    const src = try std.fmt.allocPrint(allocator, ".intel_syntax noprefix\n.text\n{s}\n", .{asm_text});
    defer allocator.free(src);
    try tmp.dir.writeFile(.{ .sub_path = "in.s", .data = src });

    const as_result = try std.process.Child.run(.{
        .allocator = allocator,
        .argv = &.{ "as", "--64", "-o", "out.o", "in.s" },
        .cwd_dir = tmp.dir,
    });
    defer allocator.free(as_result.stdout);
    defer allocator.free(as_result.stderr);
    if (as_result.term != .Exited or as_result.term.Exited != 0) {
        std.debug.print("as failed for `{s}`:\n{s}\n", .{ asm_text, as_result.stderr });
        return error.AssemblerFailed;
    }

    const oc_result = try std.process.Child.run(.{
        .allocator = allocator,
        .argv = &.{ "objcopy", "-O", "binary", "-j", ".text", "out.o", "out.bin" },
        .cwd_dir = tmp.dir,
    });
    defer allocator.free(oc_result.stdout);
    defer allocator.free(oc_result.stderr);
    if (oc_result.term != .Exited or oc_result.term.Exited != 0) return error.ObjcopyFailed;

    return tmp.dir.readFileAlloc(allocator, "out.bin", 1 << 16);
}

fn check(allocator: std.mem.Allocator, tmp: std.testing.TmpDir, case: Case) !void {
    var e = Emitter.init(allocator);
    defer e.deinit();
    try case.emit(&e);

    const expected = try assemble(allocator, tmp, case.asm_text);
    defer allocator.free(expected);

    std.testing.expectEqualSlices(u8, expected, e.getCode()) catch |err| {
        std.debug.print("encoding mismatch for `{s}`\n", .{case.asm_text});
        return err;
    };
}

fn regName(r: Emitter.Register) []const u8 {
    return @tagName(r);
}

/// 1 命令ぶんの emit と asm を比較する
fn checkOne(allocator: std.mem.Allocator, tmp: std.testing.TmpDir, asm_text: []const u8, e: *Emitter) !void {
    const expected = try assemble(allocator, tmp, asm_text);
    defer allocator.free(expected);
    std.testing.expectEqualSlices(u8, expected, e.getCode()) catch |err| {
        std.debug.print("encoding mismatch for `{s}`\n", .{asm_text});
        return err;
    };
}

const regs = std.meta.tags(Emitter.Register);

test "oracle: fixed instructions" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const cases = [_]Case{
        .{ .asm_text = "mov rax, 1", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                try e.movRegImm32(.rax, 1);
            }
        }.f },
        .{ .asm_text = "mov rdi, 1", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                try e.movRegImm32(.rdi, 1);
            }
        }.f },
        .{ .asm_text = "movabs rsi, 0x400100", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                try e.movRegImm64(.rsi, 0x400100);
            }
        }.f },
        .{ .asm_text = "xor rdi, rdi", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                try e.xorRegReg(.rdi, .rdi);
            }
        }.f },
        .{ .asm_text = "syscall", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                try e.syscall_();
            }
        }.f },
        .{ .asm_text = "lea rax, [rbp-8]", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                try e.leaRegMem(.rax, .rbp, -8);
            }
        }.f },
        .{ .asm_text = "lea rcx, [rax+16]", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                try e.leaRegMem(.rcx, .rax, 16);
            }
        }.f },
        .{ .asm_text = "lea rdx, [rsp+8]", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                try e.leaRegMem(.rdx, .rsp, 8);
            }
        }.f },
        .{ .asm_text = "lea rcx, [rax]", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                try e.leaRegMem(.rcx, .rax, 0);
            }
        }.f },
        .{ .asm_text = "sub rsp, 4096", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                _ = try e.subRegImm32(.rsp, 4096);
            }
        }.f },
        .{ .asm_text = "sub rsp, 200", .emit = &struct {
            fn f(e: *Emitter) anyerror!void {
                _ = try e.subRegImm32(.rsp, 200);
            }
        }.f },
    };
    for (cases) |c| try check(allocator, tmp, c);
}

test "oracle: movRegImm32 over all registers and boundary immediates" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const imms = [_]i32{ 0, 1, 0x7F, 0x80, 0xFF, 0x100, 0x7FFF_FFFF, -1, -0x80, -0x8000_0000 };
    inline for (std.meta.tags(Emitter.Register)) |reg| {
        for (imms) |imm| {
            const text = try std.fmt.allocPrint(allocator, "mov {s}, {d}", .{ regName(reg), imm });
            defer allocator.free(text);
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.movRegImm32(reg, imm);
            const expected = try assemble(allocator, tmp, text);
            defer allocator.free(expected);
            std.testing.expectEqualSlices(u8, expected, e.getCode()) catch |err| {
                std.debug.print("encoding mismatch for `{s}`\n", .{text});
                return err;
            };
        }
    }
}

test "oracle: movRegImm64 over all registers" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const imms = [_]u64{ 0, 0x400100, 0x8000_0000, 0xDEAD_BEEF_CAFE_BABE, 0xFFFF_FFFF_FFFF_FFFF };
    inline for (std.meta.tags(Emitter.Register)) |reg| {
        for (imms) |imm| {
            const text = try std.fmt.allocPrint(allocator, "movabs {s}, 0x{x}", .{ regName(reg), imm });
            defer allocator.free(text);
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.movRegImm64(reg, imm);
            const expected = try assemble(allocator, tmp, text);
            defer allocator.free(expected);
            std.testing.expectEqualSlices(u8, expected, e.getCode()) catch |err| {
                std.debug.print("encoding mismatch for `{s}`\n", .{text});
                return err;
            };
        }
    }
}

test "oracle: xorRegReg over all register pairs" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    inline for (std.meta.tags(Emitter.Register)) |dst| {
        inline for (std.meta.tags(Emitter.Register)) |src| {
            const text = try std.fmt.allocPrint(allocator, "xor {s}, {s}", .{ regName(dst), regName(src) });
            defer allocator.free(text);
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.xorRegReg(dst, src);
            const expected = try assemble(allocator, tmp, text);
            defer allocator.free(expected);
            std.testing.expectEqualSlices(u8, expected, e.getCode()) catch |err| {
                std.debug.print("encoding mismatch for `{s}`\n", .{text});
                return err;
            };
        }
    }
}

test "oracle: push / pop / mov reg,reg over all registers" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    inline for (regs) |r| {
        {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.pushReg(r);
            const t = try std.fmt.allocPrint(allocator, "push {s}", .{regName(r)});
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
        {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.popReg(r);
            const t = try std.fmt.allocPrint(allocator, "pop {s}", .{regName(r)});
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
        inline for (regs) |s2| {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.movRegReg(r, s2);
            const t = try std.fmt.allocPrint(allocator, "mov {s}, {s}", .{ regName(r), regName(s2) });
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
    }
}

test "oracle: mov reg,[base+disp] / mov [base+disp],reg with disp 0 / 8 / 32" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const disps = [_]i32{ 0, 8, -8, 16, 127, -128, 128, -129, 4096, -4096 };
    inline for ([_]Emitter.Register{ .rbp, .rsp, .rax, .rcx, .rbx }) |base| {
        for (disps) |d| {
            {
                var e = Emitter.init(allocator);
                defer e.deinit();
                try e.movRegMem(.rax, base, d);
                const t = try std.fmt.allocPrint(allocator, "mov rax, [{s}{s}{d}]", .{ regName(base), if (d < 0) "" else "+", d });
                defer allocator.free(t);
                try checkOne(allocator, tmp, t, &e);
            }
            {
                var e = Emitter.init(allocator);
                defer e.deinit();
                try e.movMemReg(base, d, .rcx);
                const t = try std.fmt.allocPrint(allocator, "mov [{s}{s}{d}], rcx", .{ regName(base), if (d < 0) "" else "+", d });
                defer allocator.free(t);
                try checkOne(allocator, tmp, t, &e);
            }
        }
    }
}

test "oracle: alu reg,reg (add sub and or xor cmp imul) over all pairs" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const Op = struct { name: []const u8, f: *const fn (*Emitter, Emitter.Register, Emitter.Register) anyerror!void };
    const ops = [_]Op{
        .{ .name = "add", .f = &Emitter.addRegReg },
        .{ .name = "sub", .f = &Emitter.subRegReg },
        .{ .name = "and", .f = &Emitter.andRegReg },
        .{ .name = "or", .f = &Emitter.orRegReg },
        .{ .name = "xor", .f = &Emitter.xorRegReg },
        .{ .name = "cmp", .f = &Emitter.cmpRegReg },
        .{ .name = "imul", .f = &Emitter.imulRegReg },
    };
    for (ops) |op| {
        inline for (regs) |d| {
            inline for (regs) |s2| {
                var e = Emitter.init(allocator);
                defer e.deinit();
                try op.f(&e, d, s2);
                const t = try std.fmt.allocPrint(allocator, "{s} {s}, {s}", .{ op.name, regName(d), regName(s2) });
                defer allocator.free(t);
                try checkOne(allocator, tmp, t, &e);
            }
        }
    }
}

test "oracle: alu reg,imm (add sub cmp) picks imm8 / imm32 like as" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const Op = struct { name: []const u8, f: *const fn (*Emitter, Emitter.Register, i32) anyerror!void };
    const ops = [_]Op{
        .{ .name = "add", .f = &Emitter.addRegImm },
        .{ .name = "sub", .f = &Emitter.subRegImm },
        .{ .name = "cmp", .f = &Emitter.cmpRegImm },
    };
    const imms = [_]i32{ 0, 1, 8, 127, 128, -1, -128, -129, 4096, 0x7FFF_FFFF, -0x8000_0000 };
    for (ops) |op| {
        inline for (regs) |r| {
            for (imms) |imm| {
                var e = Emitter.init(allocator);
                defer e.deinit();
                try op.f(&e, r, imm);
                const t = try std.fmt.allocPrint(allocator, "{s} {s}, {d}", .{ op.name, regName(r), imm });
                defer allocator.free(t);
                try checkOne(allocator, tmp, t, &e);
            }
        }
    }
}

test "oracle: neg / idiv over registers, cqo, setcc, movzx, ret" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    inline for (regs) |r| {
        {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.negReg(r);
            const t = try std.fmt.allocPrint(allocator, "neg {s}", .{regName(r)});
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
        {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.callReg(r);
            const t = try std.fmt.allocPrint(allocator, "call {s}", .{regName(r)});
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
        {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.shlRegCl(r);
            const t = try std.fmt.allocPrint(allocator, "shl {s}, cl", .{regName(r)});
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
        {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.sarRegCl(r);
            const t = try std.fmt.allocPrint(allocator, "sar {s}, cl", .{regName(r)});
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
        {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.notReg(r);
            const t = try std.fmt.allocPrint(allocator, "not {s}", .{regName(r)});
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
        {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.idivReg(r);
            const t = try std.fmt.allocPrint(allocator, "idiv {s}", .{regName(r)});
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
        {
            var e = Emitter.init(allocator);
            defer e.deinit();
            try e.divReg(r);
            const t = try std.fmt.allocPrint(allocator, "div {s}", .{regName(r)});
            defer allocator.free(t);
            try checkOne(allocator, tmp, t, &e);
        }
    }
    {
        var e = Emitter.init(allocator);
        defer e.deinit();
        try e.cqo();
        try checkOne(allocator, tmp, "cqo", &e);
    }
    {
        var e = Emitter.init(allocator);
        defer e.deinit();
        try e.movzxRaxAl();
        try checkOne(allocator, tmp, "movzx rax, al", &e);
    }
    {
        var e = Emitter.init(allocator);
        defer e.deinit();
        try e.ret();
        try checkOne(allocator, tmp, "ret", &e);
    }
    inline for (std.meta.tags(Emitter.Cond)) |c| {
        var e = Emitter.init(allocator);
        defer e.deinit();
        try e.setccAl(c);
        const t = try std.fmt.allocPrint(allocator, "set{s} al", .{@tagName(c)});
        defer allocator.free(t);
        try checkOne(allocator, tmp, t, &e);
    }
}

test "oracle: jmp / jcc / call rel32 forward to a label past the short range" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    // as は数値ターゲットを再配置にするので（objcopy で 0 になる）、ラベル + .skip で距離を作る。
    // ±127 以内だと as が rel8 を選ぶので、それより遠くへ飛ぶ
    const targets = [_]u32{ 0x200, 0x1000 };
    const Kind = enum { jmp, call, jcc };
    for (targets) |target| {
        inline for ([_]Kind{ .jmp, .call, .jcc }) |kind| {
            const all_conds = std.meta.tags(Emitter.Cond);
            const conds: []const Emitter.Cond = if (kind == .jcc) all_conds[0..] else &[_]Emitter.Cond{.e};
            for (conds) |c| {
                var e = Emitter.init(allocator);
                defer e.deinit();
                const at = switch (kind) {
                    .jmp => try e.jmpRel32(),
                    .call => try e.callRel32(),
                    .jcc => try e.jccRel32(c),
                };
                const len = e.here();
                var i: u32 = len;
                while (i < target) : (i += 1) try e.emit(&.{0});
                e.patchRel32(at, target);
                const mnemonic: []const u8 = switch (kind) {
                    .jmp => "jmp",
                    .call => "call",
                    .jcc => "j",
                };
                const suffix: []const u8 = if (kind == .jcc) @tagName(c) else "";
                const t = try std.fmt.allocPrint(allocator, "{s}{s} L\n.skip {d}, 0\nL:", .{ mnemonic, suffix, target - len });
                defer allocator.free(t);
                try checkOne(allocator, tmp, t, &e);
            }
        }
    }
}

test "oracle: backward rel32 (target before the instruction)" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    var e = Emitter.init(allocator);
    defer e.deinit();
    var i: u32 = 0;
    while (i < 300) : (i += 1) try e.emit(&.{0});
    const at = try e.jmpRel32();
    e.patchRel32(at, 0);
    try checkOne(allocator, tmp, "L:\n.skip 300, 0\njmp L", &e);
}

test "oracle: mov byte ptr [base+disp], r8" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const names8 = [_][]const u8{ "al", "cl", "dl", "bl" };
    inline for ([_]Emitter.Register{ .rax, .rcx, .rdx, .rbx }, 0..) |src, si| {
        inline for ([_]Emitter.Register{ .rcx, .rbp, .rsp, .rsi }) |base| {
            for ([_]i32{ 0, -1, 8, 200 }) |d| {
                var e = Emitter.init(allocator);
                defer e.deinit();
                try e.movMem8Reg(base, d, src);
                const t = try std.fmt.allocPrint(allocator, "mov byte ptr [{s}{s}{d}], {s}", .{ regName(base), if (d < 0) "" else "+", d, names8[si] });
                defer allocator.free(t);
                try checkOne(allocator, tmp, t, &e);
            }
        }
    }
}

test "oracle: movzx r64, byte ptr [base+disp] / mov r10d, imm32" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    inline for ([_]Emitter.Register{ .rax, .rcx, .rsi, .rdi }) |dst| {
        inline for ([_]Emitter.Register{ .rcx, .rbp, .rsp, .rsi }) |base| {
            for ([_]i32{ 0, -1, 8, -4200 }) |d| {
                var e = Emitter.init(allocator);
                defer e.deinit();
                try e.movzxRegMem8(dst, base, d);
                const t = try std.fmt.allocPrint(allocator, "movzx {s}, byte ptr [{s}{s}{d}]", .{ regName(dst), regName(base), if (d < 0) "" else "+", d });
                defer allocator.free(t);
                try checkOne(allocator, tmp, t, &e);
            }
        }
    }
}

// ── r8〜r15・SIB・IR バックエンド用の命令（B-8a）────────────────────
// 1 命令ずつ as を起こすと遅いので、群ごとに 1 本の asm にまとめて比べる（食い違いは群の asm ごと表示）

const Batch = struct {
    text: std.ArrayListUnmanaged(u8) = .empty,
    e: Emitter,

    fn init(a: std.mem.Allocator) Batch {
        return .{ .e = Emitter.init(a) };
    }
    fn deinit(self: *Batch, a: std.mem.Allocator) void {
        self.text.deinit(a);
        self.e.deinit();
    }
    fn line(self: *Batch, a: std.mem.Allocator, comptime fmt: []const u8, args: anytype) !void {
        const t = try std.fmt.allocPrint(a, fmt ++ "\n", args);
        defer a.free(t);
        try self.text.appendSlice(a, t);
    }
    fn check(self: *Batch, a: std.mem.Allocator, tmp: std.testing.TmpDir) !void {
        try checkOne(a, tmp, self.text.items, &self.e);
    }
};

fn sgn(d: i32) []const u8 {
    return if (d < 0) "" else "+";
}

const bases = [_]Emitter.Register{ .rax, .rbp, .rsp, .r8, .r11, .r12, .r13, .r15 };
const mem_disps = [_]i32{ 0, 8, -8, 127, -129, 4096 };

test "oracle: memory operands over r8-r15 (base rsp / r12 need SIB, rbp / r13 need disp)" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    var b = Batch.init(a);
    defer b.deinit(a);
    for (bases) |base| for (mem_disps) |d| for ([_]Emitter.Register{ .rcx, .rdi, .r9, .r14 }) |r| {
        try b.e.movRegMem(r, base, d);
        try b.line(a, "mov {s}, [{s}{s}{d}]", .{ regName(r), regName(base), sgn(d), d });
        try b.e.movMemReg(base, d, r);
        try b.line(a, "mov [{s}{s}{d}], {s}", .{ regName(base), sgn(d), d, regName(r) });
        try b.e.leaRegMem(r, base, d);
        try b.line(a, "lea {s}, [{s}{s}{d}]", .{ regName(r), regName(base), sgn(d), d });
        try b.e.movzxRegMem8(r, base, d);
        try b.line(a, "movzx {s}, byte ptr [{s}{s}{d}]", .{ regName(r), regName(base), sgn(d), d });
    };
    try b.check(a, tmp);
}

test "oracle: mov byte ptr [m], r8 over all 16 byte registers / mov qword ptr [m], imm32" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    const names8 = [_][]const u8{ "al", "cl", "dl", "bl", "spl", "bpl", "sil", "dil", "r8b", "r9b", "r10b", "r11b", "r12b", "r13b", "r14b", "r15b" };
    var b = Batch.init(a);
    defer b.deinit(a);
    for (bases) |base| for ([_]i32{ 0, -1, 200 }) |d| {
        for (regs, 0..) |src, si| {
            try b.e.movMem8Reg(base, d, src);
            try b.line(a, "mov byte ptr [{s}{s}{d}], {s}", .{ regName(base), sgn(d), d, names8[si] });
        }
        for ([_]i32{ 0, -1, 0x7fffffff, -0x80000000 }) |imm| {
            try b.e.movMemImm32(base, d, imm);
            try b.line(a, "mov qword ptr [{s}{s}{d}], {d}", .{ regName(base), sgn(d), d, imm });
        }
    };
    try b.check(a, tmp);
}

test "oracle: lea with SIB (base + index * 1 / 8) over all base / index pairs" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    var b = Batch.init(a);
    defer b.deinit(a);
    for (regs) |base| for (regs) |index| {
        if (index == .rsp) continue;
        for ([_]Emitter.Register{ .rax, .r10 }) |dst| {
            try b.e.leaRegSib(dst, base, index, .x8);
            try b.line(a, "lea {s}, [{s}+{s}*8]", .{ regName(dst), regName(base), regName(index) });
            try b.e.leaRegSib(dst, base, index, .x1);
            try b.line(a, "lea {s}, [{s}+{s}*1]", .{ regName(dst), regName(base), regName(index) });
        }
    };
    try b.check(a, tmp);
}

test "oracle: single-register and imm forms over r8-r15, rep stosq, ud2" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    var b = Batch.init(a);
    defer b.deinit(a);
    for (regs) |r| {
        const n = regName(r);
        try b.e.notReg(r);
        try b.line(a, "not {s}", .{n});
        try b.e.sarRegCl(r);
        try b.line(a, "sar {s}, cl", .{n});
        try b.e.idivReg(r);
        try b.line(a, "idiv {s}", .{n});
        try b.e.divReg(r);
        try b.line(a, "div {s}", .{n});
        for ([_]i32{ 1, -128, 200, -0x80000000 }) |imm| {
            try b.e.addRegImm(r, imm);
            try b.line(a, "add {s}, {d}", .{ n, imm });
            try b.e.subRegImm(r, imm);
            try b.line(a, "sub {s}, {d}", .{ n, imm });
            try b.e.cmpRegImm(r, imm);
            try b.line(a, "cmp {s}, {d}", .{ n, imm });
            try b.e.andRegImm(r, imm);
            try b.line(a, "and {s}, {d}", .{ n, imm });
        }
    }
    try b.e.repStosq();
    try b.line(a, "rep stosq", .{});
    try b.e.ud2();
    try b.line(a, "ud2", .{});
    try b.e.leave();
    try b.line(a, "leave", .{});
    try b.check(a, tmp);
}
