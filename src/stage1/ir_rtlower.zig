//! region op の展開（IR → IR — B-8a）。両バックエンド（ir_llvm / ir_x86）の手前で走らせ、
//! バックエンドが見るのは region op の無い素の IR だけにする（B-0「展開はバックエンドの手前で、IR で書いたランタイム関数への call として」）。
//!
//! 1 op → 固定の命令列（位置は動かさない — panic_depth の観測は不変）:
//! - region_enter → call rt.region_enter()
//! - region_depth → load.i64 @rt.meta[W_DEPTH]
//! - region_setdepth v → store @rt.meta[W_DEPTH], v
//! - region_alloc d, n → call rt.region_alloc(d, n)
//! - region_bump d → load.ptr (gep.word @rt.meta, d)[W_BUMP]
//! - region_relocate hdr, cellw, floor → call rt.region_relocate(hdr, const cellw, floor)
//!
//! 結果の値の番号は元の op のものを引き継ぎ、中間の値は関数の末尾に番号を足す。
//! --emit=ir の出力には掛けない（region op は最適化が enter / alloc / leave の対を見る層に残す）。
const std = @import("std");
const ir = @import("ir.zig");
const rt = @import("ir_rt.zig");

pub fn run(m: *ir.Module) !void {
    const a = m.alloc();
    for (m.funcs.items) |f| {
        for (f.blocks.items) |*blk| {
            var out: std.ArrayListUnmanaged(ir.Inst) = .empty;
            for (blk.insts.items) |inst| try expand(m, f, &out, inst);
            blk.insts.deinit(a);
            blk.insts = out;
        }
    }
}

fn newValue(m: *ir.Module, f: *ir.Func, t: ir.Ty) !ir.Value {
    try f.tys.append(m.alloc(), t);
    return @intCast(f.tys.items.len - 1);
}

fn expand(m: *ir.Module, f: *ir.Func, out: *std.ArrayListUnmanaged(ir.Inst), inst: ir.Inst) !void {
    const a = m.alloc();
    switch (inst.op) {
        .region_enter => try out.append(a, .{ .res = null, .op = .{ .call = .{ .f = m.rt.region_enter, .args = &.{} } } }),
        .region_depth => {
            const meta = try metaAddr(m, f, out);
            try out.append(a, .{ .res = inst.res, .op = .{ .load = .{ .p = meta, .off = rt.W_DEPTH } } });
        },
        .region_setdepth => |v| {
            const meta = try metaAddr(m, f, out);
            try out.append(a, .{ .res = null, .op = .{ .store = .{ .p = meta, .off = rt.W_DEPTH, .v = v } } });
        },
        .region_alloc => |ra| try out.append(a, .{ .res = inst.res, .op = .{ .call = .{ .f = m.rt.region_alloc, .args = try a.dupe(ir.Value, &.{ ra.depth, ra.words }) } } }),
        .region_bump => |d| {
            const meta = try metaAddr(m, f, out);
            const p = try newValue(m, f, .ptr);
            try out.append(a, .{ .res = p, .op = .{ .gep = .{ .p = meta, .idx = d, .scale = .word } } });
            try out.append(a, .{ .res = inst.res, .op = .{ .load = .{ .p = p, .off = rt.W_BUMP, .ty = .ptr } } });
        },
        .region_relocate => |rl| {
            const c = try newValue(m, f, .i64);
            try out.append(a, .{ .res = c, .op = .{ .iconst = rl.cellw } });
            try out.append(a, .{ .res = null, .op = .{ .call = .{ .f = m.rt.region_relocate, .args = try a.dupe(ir.Value, &.{ rl.hdr, c, rl.floor }) } } });
        },
        else => try out.append(a, inst),
    }
}

fn metaAddr(m: *ir.Module, f: *ir.Func, out: *std.ArrayListUnmanaged(ir.Inst)) !ir.Value {
    const v = try newValue(m, f, .ptr);
    try out.append(m.alloc(), .{ .res = v, .op = .{ .globaladdr = m.rt.meta } });
    return v;
}
