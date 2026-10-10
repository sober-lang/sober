const std = @import("std");

/// ELF layout constants
const BASE_ADDR: u64 = 0x400000;
const ELF_HEADER_SIZE: u64 = 64;
const PROG_HEADER_SIZE: u64 = 56;
// ── 2 セグメントの ELF（IR バックエンド ir_x86 — B-8a。1 セグメント版は codegen と一緒に退役 — B-9b）──
// 書き込み可能な .bss を持つ:
//   セグメント 1（R+X）: ELF ヘッダ + phdr 2 本、code、8 整列の rodata（読み取り専用の語列 — 文字列リテラル）
//   セグメント 2（R+W）: .bss（filesz 0 / memsz n — カーネルが 0 で埋める。IR ランタイムの rt.meta・rt.iobuf）
// 番地は 0x400000 帯（< 2^31）なので、コードは global / 関数の番地を imm32 の絶対値で持てる

/// Offset / virtual address where code begins in the 2-segment layout (= ELF header + 2 program headers)
pub const CODE_OFFSET_RW: u64 = ELF_HEADER_SIZE + 2 * PROG_HEADER_SIZE; // 0xB0
pub const CODE_VADDR_RW: u64 = BASE_ADDR + CODE_OFFSET_RW;
const PAGE: u64 = 0x1000;

pub const LayoutRw = struct {
    code: u64,
    rodata: u64,
    bss: u64,
    /// ファイルの大きさ（= セグメント 1 の大きさ）
    file_size: u64,
};

/// code と rodata の大きさから各部の番地を決める（コードの fixup を埋める前に呼ぶ）
pub fn layoutRw(code_len: usize, rodata_len: usize) LayoutRw {
    const rodata_off = std.mem.alignForward(u64, CODE_OFFSET_RW + code_len, 8);
    const file_size = rodata_off + rodata_len;
    return .{
        .code = CODE_VADDR_RW,
        .rodata = BASE_ADDR + rodata_off,
        .bss = std.mem.alignForward(u64, BASE_ADDR + file_size, PAGE),
        .file_size = file_size,
    };
}

/// 入口はコードの先頭（CODE_VADDR_RW）
pub fn writeExecutableRw(allocator: std.mem.Allocator, code: []const u8, rodata: []const u8, bss_bytes: u64) ![]u8 {
    const lay = layoutRw(code.len, rodata.len);
    const buf = try allocator.alloc(u8, @intCast(lay.file_size));
    errdefer allocator.free(buf);
    @memset(buf, 0);

    @memcpy(buf[0..4], "\x7FELF");
    buf[4] = 2; // ELFCLASS64
    buf[5] = 1; // little-endian
    buf[6] = 1; // EV_CURRENT
    std.mem.writeInt(u16, buf[16..18], 2, .little); // ET_EXEC
    std.mem.writeInt(u16, buf[18..20], 0x3E, .little); // EM_X86_64
    std.mem.writeInt(u32, buf[20..24], 1, .little);
    std.mem.writeInt(u64, buf[24..32], lay.code, .little); // e_entry
    std.mem.writeInt(u64, buf[32..40], ELF_HEADER_SIZE, .little); // e_phoff
    std.mem.writeInt(u16, buf[52..54], 64, .little); // e_ehsize
    std.mem.writeInt(u16, buf[54..56], PROG_HEADER_SIZE, .little); // e_phentsize
    std.mem.writeInt(u16, buf[56..58], 2, .little); // e_phnum

    writePhdr(buf[64..120], 5, 0, BASE_ADDR, lay.file_size, lay.file_size); // R+X
    writePhdr(buf[120..176], 6, 0, lay.bss, 0, bss_bytes); // R+W、ファイルの中身は無い

    @memcpy(buf[CODE_OFFSET_RW..][0..code.len], code);
    @memcpy(buf[@intCast(lay.rodata - BASE_ADDR)..][0..rodata.len], rodata);
    return buf;
}

fn writePhdr(ph: []u8, flags: u32, offset: u64, vaddr: u64, filesz: u64, memsz: u64) void {
    std.mem.writeInt(u32, ph[0..4], 1, .little); // PT_LOAD
    std.mem.writeInt(u32, ph[4..8], flags, .little);
    std.mem.writeInt(u64, ph[8..16], offset, .little);
    std.mem.writeInt(u64, ph[16..24], vaddr, .little);
    std.mem.writeInt(u64, ph[24..32], vaddr, .little);
    std.mem.writeInt(u64, ph[32..40], filesz, .little);
    std.mem.writeInt(u64, ph[40..48], memsz, .little);
    std.mem.writeInt(u64, ph[48..56], PAGE, .little);
}
