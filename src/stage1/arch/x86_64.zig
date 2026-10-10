//! x86_64 命令エンコーダ（codegen と IR バックエンド ir_x86 が共有する）。
//! 各命令の正しさは x86_64.oracle.test.zig で GNU as の出力と比較する。
const std = @import("std");

/// 16 本。r8〜r15 は REX の拡張 bit（R / X / B）で届く
pub const Register = enum(u4) {
    rax = 0,
    rcx = 1,
    rdx = 2,
    rbx = 3,
    rsp = 4,
    rbp = 5,
    rsi = 6,
    rdi = 7,
    r8 = 8,
    r9 = 9,
    r10 = 10,
    r11 = 11,
    r12 = 12,
    r13 = 13,
    r14 = 14,
    r15 = 15,
};

/// 条件コード（jcc / setcc の下位 4 bit）
pub const Cond = enum(u4) {
    e = 0x4,
    ne = 0x5,
    l = 0xC,
    ge = 0xD,
    le = 0xE,
    g = 0xF,
    /// below（符号なし <）。slice の境界検査は符号なし比較 1 回で負も範囲外も受ける
    b = 0x2,
    ae = 0x3,
    /// above（符号なし >）。region の bump 上限検査
    a = 0x7,
};

const Self = @This();
const REX_W: u8 = 0x48;

code: std.ArrayListUnmanaged(u8),
allocator: std.mem.Allocator,

pub fn init(allocator: std.mem.Allocator) Self {
    return .{ .code = .empty, .allocator = allocator };
}

pub fn deinit(self: *Self) void {
    self.code.deinit(self.allocator);
}

/// 現在のコードオフセット（ラベル・パッチ位置に使う）
pub fn here(self: *const Self) u32 {
    return @intCast(self.code.items.len);
}

pub fn getCode(self: *const Self) []const u8 {
    return self.code.items;
}

pub fn emit(self: *Self, bytes: []const u8) !void {
    try self.code.appendSlice(self.allocator, bytes);
}

fn modrm(mod: u2, reg: u3, rm: u3) u8 {
    return (@as(u8, mod) << 6) | (@as(u8, reg) << 3) | @as(u8, rm);
}

fn lo(r: Register) u3 {
    return @truncate(@intFromEnum(r));
}

fn hi(r: Register) u8 {
    return @intFromEnum(r) >> 3;
}

/// REX 接頭辞（W = 64 bit、R = ModRM.reg の拡張、X = SIB.index の拡張、B = ModRM.rm / SIB.base / opcode の拡張）。
/// 0x40 だけのとき（W も拡張も無い）は force のときだけ出す（spl / bpl / sil / dil のバイトレジスタ）
fn rex(self: *Self, w: bool, r: u8, x: u8, b: u8, force: bool) !void {
    const v: u8 = 0x40 | (@as(u8, @intFromBool(w)) << 3) | (r << 2) | (x << 1) | b;
    if (v != 0x40 or force) try self.emit(&.{v});
}

/// REX.W op /r のレジスタ形（reg = ModRM.reg、rm = ModRM.rm）
fn opRR(self: *Self, opcode: []const u8, reg: Register, rm: Register) !void {
    try self.rex(true, hi(reg), 0, hi(rm), false);
    try self.emit(opcode);
    try self.emit(&.{modrm(0b11, lo(reg), lo(rm))});
}

/// REX.W op /ext のレジスタ形
fn opExt(self: *Self, opcode: []const u8, ext: u3, rm: Register) !void {
    try self.rex(true, 0, 0, hi(rm), false);
    try self.emit(opcode);
    try self.emit(&.{modrm(0b11, ext, lo(rm))});
}

/// op のメモリ形 [base + disp]。w = REX.W、reg は ModRM.reg に入るレジスタ番号（/ext なら ext）、reg_hi はその拡張 bit
fn opMem(self: *Self, w: bool, opcode: []const u8, reg: u3, reg_hi: u8, base: Register, disp: i32, force_rex: bool) !void {
    try self.rex(w, reg_hi, 0, hi(base), force_rex);
    try self.emit(opcode);
    try self.memOperand(reg, base, disp);
}

// ── mov ──────────────────────────────────────────────────────────

/// mov reg, imm32（64 bit に符号拡張）— REX.W C7 /0 id
pub fn movRegImm32(self: *Self, reg: Register, imm: i32) !void {
    try self.opExt(&.{0xC7}, 0, reg);
    try self.imm32(imm);
}

/// movabs reg, imm64 — REX.W B8+r io
pub fn movRegImm64(self: *Self, reg: Register, imm: u64) !void {
    try self.rex(true, 0, 0, hi(reg), false);
    try self.emit(&.{0xB8 | @as(u8, lo(reg))});
    var b: [8]u8 = undefined;
    std.mem.writeInt(u64, &b, imm, .little);
    try self.emit(&b);
}

/// mov dst, src — REX.W 89 /r（reg=src, rm=dst）
pub fn movRegReg(self: *Self, dst: Register, src: Register) !void {
    try self.opRR(&.{0x89}, src, dst);
}

/// mov dst, [base + disp] — REX.W 8B /r
pub fn movRegMem(self: *Self, dst: Register, base: Register, disp: i32) !void {
    try self.opMem(true, &.{0x8B}, lo(dst), hi(dst), base, disp, false);
}

/// lea dst, [base + disp] — REX.W 8D /r
pub fn leaRegMem(self: *Self, dst: Register, base: Register, disp: i32) !void {
    try self.opMem(true, &.{0x8D}, lo(dst), hi(dst), base, disp, false);
}

/// mov [base + disp], src — REX.W 89 /r
pub fn movMemReg(self: *Self, base: Register, disp: i32, src: Register) !void {
    try self.opMem(true, &.{0x89}, lo(src), hi(src), base, disp, false);
}

/// mov qword ptr [base + disp], imm32（符号拡張）— REX.W C7 /0 id
pub fn movMemImm32(self: *Self, base: Register, disp: i32, imm: i32) !void {
    try self.opMem(true, &.{0xC7}, 0, 0, base, disp, false);
    try self.imm32(imm);
}

pub const Scale = enum(u2) { x1 = 0, x2 = 1, x4 = 2, x8 = 3 };

/// lea dst, [base + index * scale] — REX.W 8D /r + SIB（gep）。index に rsp は置けない
pub fn leaRegSib(self: *Self, dst: Register, base: Register, index: Register, scale: Scale) !void {
    std.debug.assert(index != .rsp);
    try self.rex(true, hi(dst), hi(index), hi(base), false);
    try self.emit(&.{0x8D});
    const sib = (@as(u8, @intFromEnum(scale)) << 6) | (@as(u8, lo(index)) << 3) | @as(u8, lo(base));
    // base の下位 3 bit が 5（rbp / r13）は mod=00 が「base 無し + disp32」になるので disp8 = 0 を付ける
    if (lo(base) == 5) {
        try self.emit(&.{ modrm(0b01, lo(dst), 4), sib, 0 });
    } else {
        try self.emit(&.{ modrm(0b00, lo(dst), 4), sib });
    }
}

fn imm32(self: *Self, v: i32) !void {
    var b: [4]u8 = undefined;
    std.mem.writeInt(i32, &b, v, .little);
    try self.emit(&b);
}

/// ModRM(+SIB)(+disp) のメモリオペランド。as と同じく disp は 0 / disp8 / disp32 の最短を選ぶ。
/// 下位 3 bit が 5（rbp / r13）は mod=00 が RIP 相対になるので disp8 以上、4（rsp / r12）は SIB が要る。
fn memOperand(self: *Self, reg: u3, base: Register, disp: i32) !void {
    const rm: u3 = lo(base);
    const needs_sib = rm == 4;
    const fits8 = disp >= -128 and disp <= 127;
    if (disp == 0 and rm != 5) {
        try self.emit(&.{modrm(0b00, reg, rm)});
        if (needs_sib) try self.emit(&.{0x24});
    } else if (fits8) {
        try self.emit(&.{modrm(0b01, reg, rm)});
        if (needs_sib) try self.emit(&.{0x24});
        try self.emit(&.{@bitCast(@as(i8, @intCast(disp)))});
    } else {
        try self.emit(&.{modrm(0b10, reg, rm)});
        if (needs_sib) try self.emit(&.{0x24});
        try self.imm32(disp);
    }
}

/// mov byte ptr [base + disp], src8 — 88 /r。spl / bpl / sil / dil と r8b〜 は REX 付き（as と同じ）
pub fn movMem8Reg(self: *Self, base: Register, disp: i32, src: Register) !void {
    const force = @intFromEnum(src) >= 4 and @intFromEnum(src) < 8;
    try self.opMem(false, &.{0x88}, lo(src), hi(src), base, disp, force);
}

/// movzx dst, byte ptr [base + disp] — REX.W 0F B6 /r（バイト列 → 1 語セルの広げ。io のランタイム）
pub fn movzxRegMem8(self: *Self, dst: Register, base: Register, disp: i32) !void {
    try self.opMem(true, &.{ 0x0F, 0xB6 }, lo(dst), hi(dst), base, disp, false);
}

/// rep stosq — F3 48 AB（rcx 語を rdi から rax で埋める。フレームスロットの入口ゼロ初期化）
pub fn repStosq(self: *Self) !void {
    try self.emit(&.{ 0xF3, REX_W, 0xAB });
}

// ── スタック ─────────────────────────────────────────────────────

pub fn pushReg(self: *Self, reg: Register) !void {
    try self.rex(false, 0, 0, hi(reg), false);
    try self.emit(&.{0x50 | @as(u8, lo(reg))});
}

pub fn popReg(self: *Self, reg: Register) !void {
    try self.rex(false, 0, 0, hi(reg), false);
    try self.emit(&.{0x58 | @as(u8, lo(reg))});
}

// ── 算術・論理（reg, reg。REX.W op /r、reg=src rm=dst） ──────────

fn aluRegReg(self: *Self, opcode: u8, dst: Register, src: Register) !void {
    try self.opRR(&.{opcode}, src, dst);
}

pub fn addRegReg(self: *Self, dst: Register, src: Register) !void {
    try self.aluRegReg(0x01, dst, src);
}
pub fn subRegReg(self: *Self, dst: Register, src: Register) !void {
    try self.aluRegReg(0x29, dst, src);
}
pub fn andRegReg(self: *Self, dst: Register, src: Register) !void {
    try self.aluRegReg(0x21, dst, src);
}
pub fn orRegReg(self: *Self, dst: Register, src: Register) !void {
    try self.aluRegReg(0x09, dst, src);
}
pub fn xorRegReg(self: *Self, dst: Register, src: Register) !void {
    try self.aluRegReg(0x31, dst, src);
}
pub fn cmpRegReg(self: *Self, dst: Register, src: Register) !void {
    try self.aluRegReg(0x39, dst, src);
}

/// imul dst, src — REX.W 0F AF /r（reg=dst rm=src）
pub fn imulRegReg(self: *Self, dst: Register, src: Register) !void {
    try self.opRR(&.{ 0x0F, 0xAF }, dst, src);
}

/// op reg, imm — as と同じ最短形を選ぶ:
/// imm8 に収まれば 83 /ext ib、rax なら短縮形 (05 / 2D / 3D) id、それ以外は 81 /ext id
fn aluRegImm(self: *Self, ext: u3, reg: Register, imm: i32) !void {
    if (imm >= -128 and imm <= 127) {
        try self.opExt(&.{0x83}, ext, reg);
        try self.emit(&.{@bitCast(@as(i8, @intCast(imm)))});
        return;
    }
    if (reg == .rax) {
        // ext → 短縮 opcode: add 05, sub 2D, cmp 3D（= ext*8 + 5）
        try self.emit(&.{ REX_W, @as(u8, ext) * 8 + 0x05 });
    } else {
        try self.opExt(&.{0x81}, ext, reg);
    }
    try self.imm32(imm);
}

pub fn addRegImm(self: *Self, reg: Register, imm: i32) !void {
    try self.aluRegImm(0, reg, imm);
}
pub fn subRegImm(self: *Self, reg: Register, imm: i32) !void {
    try self.aluRegImm(5, reg, imm);
}
pub fn cmpRegImm(self: *Self, reg: Register, imm: i32) !void {
    try self.aluRegImm(7, reg, imm);
}
/// and reg, imm（rax の短縮形 25 も ext*8 + 5 の規則に乗る）
pub fn andRegImm(self: *Self, reg: Register, imm: i32) !void {
    try self.aluRegImm(4, reg, imm);
}

/// sub reg, imm32 — 常に REX.W 81 /5 id（後から patchImm32 で埋めるフレーム確保用）。imm32 フィールドの位置を返す
pub fn subRegImm32(self: *Self, reg: Register, imm: i32) !u32 {
    try self.opExt(&.{0x81}, 5, reg);
    const at = self.here();
    try self.imm32(imm);
    return at;
}

/// imm32 フィールド（位置 at）を書き換える
pub fn patchImm32(self: *Self, at: u32, value: i32) void {
    std.mem.writeInt(i32, self.code.items[at..][0..4], value, .little);
}

/// neg reg — REX.W F7 /3
pub fn negReg(self: *Self, reg: Register) !void {
    try self.opExt(&.{0xF7}, 3, reg);
}

/// not reg — REX.W F7 /2
pub fn notReg(self: *Self, reg: Register) !void {
    try self.opExt(&.{0xF7}, 2, reg);
}

/// shl reg, cl — REX.W D3 /4（量は cl の下位 6bit — IR の shl と同じ意味。言語の範囲外の畳みは lowering / codegen が先に行う）
pub fn shlRegCl(self: *Self, reg: Register) !void {
    try self.opExt(&.{0xD3}, 4, reg);
}

/// sar reg, cl — REX.W D3 /7（算術右シフト）
pub fn sarRegCl(self: *Self, reg: Register) !void {
    try self.opExt(&.{0xD3}, 7, reg);
}

/// cqo — rax を rdx:rax に符号拡張（idiv の前）
pub fn cqo(self: *Self) !void {
    try self.emit(&.{ REX_W, 0x99 });
}

/// idiv reg — rdx:rax / reg → 商 rax、余り rdx — REX.W F7 /7
pub fn idivReg(self: *Self, reg: Register) !void {
    try self.opExt(&.{0xF7}, 7, reg);
}

/// div reg — rdx:rax / reg（符号なし）→ 商 rax、余り rdx — REX.W F7 /6
pub fn divReg(self: *Self, reg: Register) !void {
    try self.opExt(&.{0xF7}, 6, reg);
}

/// setcc al — 0F 9x C0（比較結果を 0 / 1 に）
pub fn setccAl(self: *Self, cond: Cond) !void {
    try self.emit(&.{ 0x0F, 0x90 | @as(u8, @intFromEnum(cond)), 0xC0 });
}

/// movzx rax, al — REX.W 0F B6 C0
pub fn movzxRaxAl(self: *Self) !void {
    try self.emit(&.{ REX_W, 0x0F, 0xB6, 0xC0 });
}

// ── 制御 ─────────────────────────────────────────────────────────

/// jmp rel32 — E9 cd。rel32 の位置（パッチ用）を返す
pub fn jmpRel32(self: *Self) !u32 {
    try self.emit(&.{ 0xE9, 0, 0, 0, 0 });
    return self.here() - 4;
}

/// jcc rel32 — 0F 8x cd。rel32 の位置を返す
pub fn jccRel32(self: *Self, cond: Cond) !u32 {
    try self.emit(&.{ 0x0F, 0x80 | @as(u8, @intFromEnum(cond)), 0, 0, 0, 0 });
    return self.here() - 4;
}

/// call rel32 — E8 cd。rel32 の位置を返す
pub fn callRel32(self: *Self) !u32 {
    try self.emit(&.{ 0xE8, 0, 0, 0, 0 });
    return self.here() - 4;
}

/// call r64 — FF /2（間接呼び出し。関数値 = コードアドレスの呼び出し — V3-3）
pub fn callReg(self: *Self, reg: Register) !void {
    try self.rex(false, 0, 0, hi(reg), false);
    try self.emit(&.{ 0xFF, 0xD0 | @as(u8, lo(reg)) });
}

/// leave — C9（mov rsp, rbp; pop rbp）
pub fn leave(self: *Self) !void {
    try self.emit(&.{0xC9});
}

pub fn ret(self: *Self) !void {
    try self.emit(&.{0xC3});
}

pub fn syscall_(self: *Self) !void {
    try self.emit(&.{ 0x0F, 0x05 });
}

/// ud2 — 0F 0B（到達しない印。_start の main 呼び出しの後ろ）
pub fn ud2(self: *Self) !void {
    try self.emit(&.{ 0x0F, 0x0B });
}

/// rel32 フィールド（位置 at）を target オフセットへの相対値で埋める
pub fn patchRel32(self: *Self, at: u32, target: u32) void {
    const rel: i32 = @as(i32, @intCast(target)) - @as(i32, @intCast(at + 4));
    std.mem.writeInt(i32, self.code.items[at..][0..4], rel, .little);
}

/// 64 bit 値をオフセット位置に書く（アドレス解決の 2 パス用）
pub fn patch64(self: *Self, offset: usize, value: u64) void {
    std.mem.writeInt(u64, self.code.items[offset..][0..8], value, .little);
}
