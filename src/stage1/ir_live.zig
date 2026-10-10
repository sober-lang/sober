//! 生存解析と live interval（B-8b）。
//!
//! 番号付け: 到達するブロックを逆後順に並べ（後続を後ろから辿る DFS — condbr の then 側・ループ本体がすぐ後ろに来る）、ブロック b の頭を pos(b)、k 番目の命令を pos(b) + 2(k + 1)、
//! 終端（condbr の条件・ret の値・辺の実引数の使用）を pos(b) + 2(len + 1) とし、次のブロックは +2 から。
//! ブロック引数はブロックの頭で定義、関数の引数は入口の頭（0）で定義。辺の実引数は前任の終端で使用し、
//! 後続の仮引数は前任の終端でも生きているとする（並行コピーがそこで仮引数の置き場へ書くため）。
//! 区間は値ごとに穴の無い 1 本 [start, end]（生きている位置の最小〜最大）。ループの頭で生きている値は
//! 後ろ向きの辺の前任（ループの末尾）の live-out に入るので、ループの末尾まで自然に伸びる。
//! 到達しないブロックは番号を持たず、区間にも寄与しない（ir_x86 はそれを吐かない）。
const std = @import("std");
const ir = @import("ir.zig");
const ir_cfg = @import("ir_cfg.zig");

pub const Interval = struct { start: u32, end: u32 };

pub const Live = struct {
    /// 吐く順（= 逆後順、到達するブロックだけ）
    order: []const ir.BlockId,
    /// ブロックの頭の位置（到達しないブロックは使わない）
    block_pos: []const u32,
    /// 値 → 区間（到達するブロックに定義を持たない値は null）
    iv: []const ?Interval,

    /// ブロック b の k 番目の命令の位置
    pub fn instPos(self: *const Live, b: ir.BlockId, k: usize) u32 {
        return self.block_pos[b] + 2 * @as(u32, @intCast(k + 1));
    }
};

const Set = std.DynamicBitSetUnmanaged;

/// a は結果の寿命（arena を推奨）
pub fn analyze(a: std.mem.Allocator, f: *const ir.Func, cfg: *const ir_cfg.Cfg) !Live {
    const nb = f.blocks.items.len;
    const nv = f.tys.items.len;

    // ブロックごとの use（定義より前の使用 — 辺の実引数を含む）と def（引数と命令の結果）
    const use = try a.alloc(Set, nb);
    const def = try a.alloc(Set, nb);
    for (f.blocks.items, use, def) |blk, *u, *d| {
        u.* = try Set.initEmpty(a, nv);
        d.* = try Set.initEmpty(a, nv);
        for (blk.params.items) |p| d.set(p);
        for (blk.insts.items) |inst| {
            var it = operands(inst.op);
            while (it.next()) |v| if (!d.isSet(v)) u.set(v);
            if (inst.res) |r| d.set(r);
        }
        var tt = termOperands(blk.term);
        while (tt.next()) |v| if (!d.isSet(v)) u.set(v);
    }
    for (f.params) |p| def[0].set(p);

    // live_in(b) = use(b) ∪ (live_out(b) − def(b))、live_out(b) = ∪ live_in(後続) − 後続の引数（引数は後続の頭で定義）
    const live_in = try a.alloc(Set, nb);
    const live_out = try a.alloc(Set, nb);
    for (live_in, live_out) |*i, *o| {
        i.* = try Set.initEmpty(a, nv);
        o.* = try Set.initEmpty(a, nv);
    }
    var tmp = try Set.initEmpty(a, nv);
    var changed = true;
    while (changed) {
        changed = false;
        var k = cfg.rpo.len;
        while (k > 0) {
            k -= 1;
            const b = cfg.rpo[k];
            tmp.unsetAll();
            for (cfg.succs[b]) |s| {
                tmp.setUnion(live_in[s]);
                for (f.blocks.items[s].params.items) |p| tmp.unset(p);
            }
            if (!tmp.eql(live_out[b])) {
                live_out[b].unsetAll();
                live_out[b].setUnion(tmp);
                changed = true;
            }
            // live_in = use ∪ (out − def)
            tmp.unsetAll();
            tmp.setUnion(live_out[b]);
            var dit = def[b].iterator(.{});
            while (dit.next()) |v| tmp.unset(v);
            tmp.setUnion(use[b]);
            if (!tmp.eql(live_in[b])) {
                live_in[b].unsetAll();
                live_in[b].setUnion(tmp);
                changed = true;
            }
        }
    }

    // 位置と区間
    const order = try linearOrder(a, f, cfg);
    const block_pos = try a.alloc(u32, nb);
    @memset(block_pos, 0);
    var pos: u32 = 0;
    for (order) |b| {
        block_pos[b] = pos;
        pos += 2 * @as(u32, @intCast(f.blocks.items[b].insts.items.len + 2));
    }
    const iv = try a.alloc(?Interval, nv);
    @memset(iv, null);
    for (order) |b| {
        const blk = f.blocks.items[b];
        const bs = block_pos[b];
        const be = bs + 2 * @as(u32, @intCast(blk.insts.items.len + 1));
        var ii = live_in[b].iterator(.{});
        while (ii.next()) |v| touch(iv, @intCast(v), bs);
        var oi = live_out[b].iterator(.{});
        while (oi.next()) |v| touch(iv, @intCast(v), be);
        if (b == 0) for (f.params) |p| touch(iv, p, bs);
        for (blk.params.items) |p| touch(iv, p, bs);
        for (blk.insts.items, 0..) |inst, k| {
            const ip = bs + 2 * @as(u32, @intCast(k + 1));
            var it = operands(inst.op);
            while (it.next()) |v| touch(iv, v, ip);
            if (inst.res) |r| touch(iv, r, ip);
        }
        var tt = termOperands(blk.term);
        while (tt.next()) |v| touch(iv, v, be);
        // 辺の並行コピーは前任の終端で後続の仮引数の置き場へ書く — 仮引数はそこでも生きている（でないと同じレジスタを
        // 前任の終端で生きている別の値に配られ、コピーが壊す）
        for (cfg.succs[b]) |s| for (f.blocks.items[s].params.items) |p| touch(iv, p, be);
    }
    return .{ .order = order, .block_pos = block_pos, .iv = iv };
}

/// 逆後順（後続を後ろから辿る反復 DFS）。ir_cfg.rpo と同じ集合で順だけ違う — condbr の then 側が直後に来る
fn linearOrder(a: std.mem.Allocator, f: *const ir.Func, cfg: *const ir_cfg.Cfg) ![]ir.BlockId {
    const nb = f.blocks.items.len;
    const seen = try a.alloc(bool, nb);
    @memset(seen, false);
    const post = try a.alloc(ir.BlockId, cfg.rpo.len);
    var np: usize = 0;
    const Frame = struct { b: ir.BlockId, next: usize };
    var stack: std.ArrayListUnmanaged(Frame) = .empty;
    try stack.append(a, .{ .b = 0, .next = 0 });
    seen[0] = true;
    while (stack.items.len > 0) {
        const top = &stack.items[stack.items.len - 1];
        const ss = cfg.succs[top.b];
        if (top.next < ss.len) {
            const s = ss[ss.len - 1 - top.next];
            top.next += 1;
            if (!seen[s]) {
                seen[s] = true;
                try stack.append(a, .{ .b = s, .next = 0 });
            }
        } else {
            post[np] = top.b;
            np += 1;
            _ = stack.pop();
        }
    }
    std.debug.assert(np == post.len);
    std.mem.reverse(ir.BlockId, post);
    return post;
}

fn touch(iv: []?Interval, v: ir.Value, p: u32) void {
    if (iv[v]) |*x| {
        x.start = @min(x.start, p);
        x.end = @max(x.end, p);
    } else iv[v] = .{ .start = p, .end = p };
}

/// 命令・終端のオペランド（値）の列: 固定の最大 2 個 + 可変長の列 2 本（condbr の 2 辺の実引数）
pub const Operands = struct {
    one: [2]ir.Value = undefined,
    n: usize = 0,
    rest: []const ir.Value = &.{},
    rest2: []const ir.Value = &.{},
    i: usize = 0,

    pub fn next(self: *Operands) ?ir.Value {
        const k = self.i;
        self.i += 1;
        if (k < self.n) return self.one[k];
        if (k - self.n < self.rest.len) return self.rest[k - self.n];
        const j = k - self.n - self.rest.len;
        if (j < self.rest2.len) return self.rest2[j];
        return null;
    }
};

fn fixed(vs: []const ir.Value) Operands {
    var o: Operands = .{ .n = vs.len };
    @memcpy(o.one[0..vs.len], vs);
    return o;
}

pub fn operands(op: ir.Op) Operands {
    return switch (op) {
        .iconst, .slotaddr, .globaladdr, .funcaddr, .region_enter, .region_depth => .{},
        .bin => |b| fixed(&.{ b.a, b.b }),
        .cmp => |c| fixed(&.{ c.a, c.b }),
        .load => |l| fixed(&.{l.p}),
        .store => |s| fixed(&.{ s.p, s.v }),
        .load8 => |l| fixed(&.{l.p}),
        .store8 => |s| fixed(&.{ s.p, s.v }),
        .gep => |g| fixed(&.{ g.p, g.idx }),
        .ptoi, .itop, .region_setdepth, .region_bump => |v| fixed(&.{v}),
        .call => |c| .{ .rest = c.args },
        .call_indirect => |c| blk: {
            var o = fixed(&.{c.callee});
            o.rest = c.args;
            break :blk o;
        },
        .syscall => |args| .{ .rest = args },
        .region_alloc => |r| fixed(&.{ r.depth, r.words }),
        .region_relocate => |r| fixed(&.{ r.hdr, r.floor }),
    };
}

/// 終端が使う値（条件・戻り値・辺の実引数）
pub fn termOperands(t: ir.Term) Operands {
    return switch (t) {
        .none, .exit => .{},
        .br => |e| .{ .rest = e.args },
        .ret => |v| if (v) |x| fixed(&.{x}) else .{},
        .condbr => |c| blk: {
            var o = fixed(&.{c.c});
            o.rest = c.t.args;
            o.rest2 = c.e.args;
            break :blk o;
        },
    };
}
