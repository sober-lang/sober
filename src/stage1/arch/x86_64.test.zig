const std = @import("std");
const Emitter = @import("x86_64.zig");
const Elf = @import("../format/elf.zig"); // resolved via build.zig module import

// ---------------------------------------------------------------------------
// Unit tests for the emitter (byte-level encoding checks)
// ---------------------------------------------------------------------------

test "movRegImm32: rax, 1 → 48 C7 C0 01 00 00 00" {
    var e = Emitter.init(std.testing.allocator);
    defer e.deinit();

    try e.movRegImm32(.rax, 1);
    try std.testing.expectEqualSlices(u8, &[_]u8{ 0x48, 0xC7, 0xC0, 0x01, 0x00, 0x00, 0x00 }, e.getCode());
}

test "movRegImm32: rdi, 1 → 48 C7 C7 01 00 00 00" {
    var e = Emitter.init(std.testing.allocator);
    defer e.deinit();

    try e.movRegImm32(.rdi, 1);
    try std.testing.expectEqualSlices(u8, &[_]u8{ 0x48, 0xC7, 0xC7, 0x01, 0x00, 0x00, 0x00 }, e.getCode());
}

test "movRegImm64: rsi, 0x400100 → 48 BE 00 01 40 00 00 00 00 00" {
    var e = Emitter.init(std.testing.allocator);
    defer e.deinit();

    try e.movRegImm64(.rsi, 0x400100);
    const expected = [_]u8{ 0x48, 0xBE, 0x00, 0x01, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00 };
    try std.testing.expectEqualSlices(u8, &expected, e.getCode());
}

test "xorRegReg: rdi, rdi → 48 31 FF" {
    var e = Emitter.init(std.testing.allocator);
    defer e.deinit();

    try e.xorRegReg(.rdi, .rdi);
    // ModRM = 0xC0 | (7 << 3) | 7 = 0xC0 | 0x38 | 0x07 = 0xFF
    try std.testing.expectEqualSlices(u8, &[_]u8{ 0x48, 0x31, 0xFF }, e.getCode());
}

test "syscall_ → 0F 05" {
    var e = Emitter.init(std.testing.allocator);
    defer e.deinit();

    try e.syscall_();
    try std.testing.expectEqualSlices(u8, &[_]u8{ 0x0F, 0x05 }, e.getCode());
}

test "patch64: overwrite 8 bytes at given offset" {
    var e = Emitter.init(std.testing.allocator);
    defer e.deinit();

    // emit movRegImm64(rsi, 0) as placeholder → offset of imm64 is at byte 2
    try e.movRegImm64(.rsi, 0);
    e.patch64(2, 0xDEADBEEF_CAFEBABE);

    const code = e.getCode();
    var got: u64 = undefined;
    got = std.mem.readInt(u64, code[2..10], .little);
    try std.testing.expectEqual(@as(u64, 0xDEADBEEF_CAFEBABE), got);
}

test "elf 2 segments: rodata is readable, .bss is zero and writable (r8-r15 addressing)" {
    const allocator = std.testing.allocator;
    var e = Emitter.init(allocator);
    defer e.deinit();
    const rodata = "ro\n";
    // 番地はコードの大きさで決まるので、imm32 を後から埋める
    try e.movRegImm32(.r12, 0);
    const ro_at = e.here() - 4;
    try e.movRegImm32(.r13, 0);
    const bss_at = e.here() - 4;
    // r14 = bss[1]（0 のはず）。bss[0..2] = "w\n"
    try e.movRegMem(.r14, .r13, 8);
    try e.movRegImm32(.rax, 'w');
    try e.movMem8Reg(.r13, 0, .rax);
    try e.movRegImm32(.r9, '\n');
    try e.movMem8Reg(.r13, 1, .r9);
    // write(1, rodata, 3); write(1, bss, 2)
    try e.movRegImm32(.rax, 1);
    try e.movRegImm32(.rdi, 1);
    try e.movRegReg(.rsi, .r12);
    try e.movRegImm32(.rdx, 3);
    try e.syscall_();
    try e.movRegImm32(.rax, 1);
    try e.movRegReg(.rsi, .r13);
    try e.movRegImm32(.rdx, 2);
    try e.syscall_();
    // exit(r14 + 7)
    try e.leaRegMem(.rdi, .r14, 7);
    try e.movRegImm32(.rax, 60);
    try e.syscall_();

    const lay = Elf.layoutRw(e.getCode().len, rodata.len);
    e.patchImm32(ro_at, @intCast(lay.rodata));
    e.patchImm32(bss_at, @intCast(lay.bss));
    const binary = try Elf.writeExecutableRw(allocator, e.getCode(), rodata, 16);
    defer allocator.free(binary);

    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    try tmp.dir.writeFile(.{ .sub_path = "p", .data = binary, .flags = .{ .mode = 0o755 } });
    const path = try tmp.dir.realpathAlloc(allocator, "p");
    defer allocator.free(path);
    const r = try std.process.Child.run(.{ .allocator = allocator, .argv = &.{path} });
    defer allocator.free(r.stdout);
    defer allocator.free(r.stderr);
    try std.testing.expectEqual(std.process.Child.Term{ .Exited = 7 }, r.term);
    try std.testing.expectEqualStrings("ro\nw\n", r.stdout);
}
