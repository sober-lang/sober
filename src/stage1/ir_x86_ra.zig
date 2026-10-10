//! ir_x86 の割り当て器（値 → 置き場）。命令選択（ir_x86）は Loc を通してしか置き場を見ない。
//!
//! linear scan（B-8b、Poletto–Sarkar）: ir_live の穴の無い区間を start の順に見て、10 本の割り当て可能レジスタを配る。
//! 空きが無ければ、生きている区間と今の区間のうち end がいちばん遠いものを**区間ごと**フレームへ落とす（分割しない）。
//! 同じ位置で終わる区間のレジスタは、その位置で始まる区間に渡してよい（命令選択はオペランドを全部読んでから結果を書く）。
//! 使ったレジスタは callee が退避する（呼び出しをまたぐ区間の扱いが要らない）。割り当てに使わずに壊すもの
//!（syscall の引数レジスタ・rep stosq の rdi）も「使った」に数える。
//! 関数の引数は入口で定義され、spill されたら呼び手が積んだ [rbp + 16 + 8k] をそのまま置き場にする。
//!
//! 素朴版（naive — B-8a の全部フレーム）も残す: ir_x86.test が同じ IR を両方で下ろし、割り当て器のバグを切り分ける。
const std = @import("std");
const ir = @import("ir.zig");
const ir_cfg = @import("ir_cfg.zig");
const ir_live = @import("ir_live.zig");
const Enc = @import("arch/x86_64.zig");
const Reg = Enc.Register;

pub const Loc = union(enum) {
    reg: Reg,
    /// rbp からの変位
    frame: i32,

    pub fn eql(x: Loc, y: Loc) bool {
        return switch (x) {
            .reg => |r| y == .reg and y.reg == r,
            .frame => |d| y == .frame and y.frame == d,
        };
    }
};

/// 割り当てる順（syscall の引数に使う rsi / rdi / r8〜r10 は後ろ — syscall の周りの退避を減らす）
pub const allocatable = [_]Reg{ .rbx, .r12, .r13, .r14, .r15, .rsi, .rdi, .r8, .r9, .r10 };

pub const Kind = enum { linear, naive };

pub const Save = struct { reg: Reg, disp: i32 };

pub const Alloc = struct {
    locs: []Loc,
    /// フレームの最も低い変位（rbp 基準、負）。ir_x86 はここまでを sub rsp で取る
    frame_bottom: i32,
    /// 使った callee-saved レジスタと退避先の変位（入口で退避、ret の前に戻す）
    saves: []const Save,
    live: ir_live.Live,
};

/// top: 値の置き場に使える最も高い変位（その下へ積む — ir_x86 がスロットを先に取った残り）
pub fn allocate(a: std.mem.Allocator, f: *const ir.Func, top: i32, kind: Kind) !Alloc {
    const cfg = try ir_cfg.analyze(a, f);
    const live = try ir_live.analyze(a, f, &cfg);
    const locs = try a.alloc(Loc, f.tys.items.len);
    if (kind == .naive) {
        var d = top;
        for (locs, 0..) |*l, v| {
            if (paramIndex(f, @intCast(v))) |k| {
                l.* = .{ .frame = paramDisp(k) };
            } else {
                d -= 8;
                l.* = .{ .frame = d };
            }
        }
        return .{ .locs = locs, .frame_bottom = d, .saves = &.{}, .live = live };
    }

    // spill の置き場は番号で持ち、退避域の大きさが決まってから変位にする
    const Spill = struct { v: ir.Value };
    var spills: std.ArrayListUnmanaged(Spill) = .empty;
    const spill_mark: i32 = std.math.minInt(i32);

    var ivs: std.ArrayListUnmanaged(ir.Value) = .empty;
    for (live.iv, 0..) |iv, v| {
        if (iv != null) try ivs.append(a, @intCast(v)) else locs[v] = .{ .frame = spill_mark };
    }
    const Ctx = struct {
        iv: []const ?ir_live.Interval,
        fn lt(c: @This(), x: ir.Value, y: ir.Value) bool {
            const sx = c.iv[x].?.start;
            const sy = c.iv[y].?.start;
            return sx < sy or (sx == sy and x < y);
        }
    };
    std.mem.sort(ir.Value, ivs.items, Ctx{ .iv = live.iv }, Ctx.lt);

    var free = std.EnumSet(Reg).initEmpty();
    for (allocatable) |r| free.insert(r);
    var used = std.EnumSet(Reg).initEmpty();
    // 生きている区間（レジスタを持つもの）
    var active: std.ArrayListUnmanaged(ir.Value) = .empty;

    for (ivs.items) |v| {
        const cur = live.iv[v].?;
        // 終わった区間のレジスタを返す（end ≤ start — 同じ位置の受け渡しを許す）
        var i: usize = 0;
        while (i < active.items.len) {
            const w = active.items[i];
            if (live.iv[w].?.end <= cur.start) {
                free.insert(locs[w].reg);
                _ = active.swapRemove(i);
            } else i += 1;
        }
        if (firstFree(free)) |r| {
            free.remove(r);
            used.insert(r);
            locs[v] = .{ .reg = r };
            try active.append(a, v);
            continue;
        }
        // 空きが無い: end がいちばん遠い区間を落とす（同点は値の番号の大きい方 — 決定的）
        var far: ir.Value = v;
        for (active.items) |w| {
            const ew = live.iv[w].?.end;
            const ef = live.iv[far].?.end;
            if (ew > ef or (ew == ef and w > far)) far = w;
        }
        if (far == v) {
            locs[v] = .{ .frame = spill_mark };
            try spills.append(a, .{ .v = v });
        } else {
            locs[v] = locs[far];
            locs[far] = .{ .frame = spill_mark };
            try spills.append(a, .{ .v = far });
            for (active.items) |*w| if (w.* == far) {
                w.* = v;
            };
        }
    }

    // 割り当てに使わなくても壊すレジスタも callee-saved として退避する: syscall の引数レジスタ（rdi / rsi / r10 / r8 / r9）と、
    // スロットのゼロ初期化（rep stosq）の rdi
    if (f.slots.items.len > 0) used.insert(.rdi);
    const sys_regs = [_]Reg{ .rdi, .rsi, .rdx, .r10, .r8, .r9 };
    for (f.blocks.items) |blk| for (blk.insts.items) |inst| if (inst.op == .syscall) {
        for (sys_regs[0 .. inst.op.syscall.len - 1]) |r| if (r != .rdx) used.insert(r);
    };

    // フレーム: [top) の下に退避域、その下に spill
    var saves: std.ArrayListUnmanaged(Save) = .empty;
    var d = top;
    for (allocatable) |r| if (used.contains(r)) {
        d -= 8;
        try saves.append(a, .{ .reg = r, .disp = d });
    };
    for (spills.items) |s| {
        if (paramIndex(f, s.v)) |k| {
            locs[s.v] = .{ .frame = paramDisp(k) };
        } else {
            d -= 8;
            locs[s.v] = .{ .frame = d };
        }
    }
    // 区間を持たない値（到達しないブロックでだけ定義）は使われない — どこでもよいが番地は有効にしておく
    for (locs, 0..) |*l, v| if (l.* == .frame and l.frame == spill_mark) {
        l.* = if (paramIndex(f, @intCast(v))) |k| .{ .frame = paramDisp(k) } else .{ .frame = top - 8 };
    };
    return .{ .locs = locs, .frame_bottom = @min(d, top - 8), .saves = saves.items, .live = live };
}

fn firstFree(free: std.EnumSet(Reg)) ?Reg {
    for (allocatable) |r| if (free.contains(r)) return r;
    return null;
}

pub fn paramDisp(k: usize) i32 {
    return 16 + 8 * @as(i32, @intCast(k));
}

pub fn paramIndex(f: *const ir.Func, v: ir.Value) ?usize {
    return std.mem.indexOfScalar(ir.Value, f.params, v);
}
