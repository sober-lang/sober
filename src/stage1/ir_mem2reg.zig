//! mem2reg（B-7）: スカラーのスロット（mut ローカル）をブロック引数の SSA 値へ持ち上げる IR パス。
//!
//! 対象: 1 語のスロットで、アドレス（slotaddr の結果）の使い道がオフセット 0 の `load.i64` の番地と `store` の番地だけ
//! （他の命令の引数・辺の引数・ret・格納される値になったら逃げている — 対象外）。格納される値はすべて i64。
//! スロットは入口でゼロ初期化される（ir_llvm の規約）ので、定義前の読みは 0。
//! 手順: 格納のあるブロックから反復支配境界にブロック引数を置き、支配木を前順でたどって各スロットの現在値を持ち回す
//! （load は現在値に置き換えて消す、store は現在値を更新して消す、辺は置いた引数ぶんの実引数を足す）。
//! 到達しないブロックの中は現在値 0 として同じように消す（そこから到達するブロックへの辺にも 0 を渡す）。
//! 最後に値の番号を詰め直す（関数の仮引数は 0.. のまま — ir_parse の「番号に欠けがない」規則を保つ）。
//! region op には触らない（深度の観測 = panic_depth は動かない）。使われなくなったスロットは落として番号を詰める
const std = @import("std");
const ir = @import("ir.zig");
const cfg_ = @import("ir_cfg.zig");

pub fn run(m: *ir.Module) !void {
    for (m.funcs.items) |f| try runFunc(m, f);
}

const none = std.math.maxInt(u32);

/// v が対象スロットのアドレスならその通し番号（so: 値 → スロット、cd: スロット → 通し番号）
fn candOf(so: []const u32, cd: []const u32, v: ir.Value) u32 {
    return if (so[v] == none) none else cd[so[v]];
}

pub fn runFunc(m: *ir.Module, f: *ir.Func) !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const t = arena.allocator();
    const a = m.alloc();
    const nv = f.tys.items.len;

    // ── 対象のスロット ──
    // slot_of[v]: v が slotaddr の結果ならそのスロット
    const slot_of = try t.alloc(u32, nv);
    @memset(slot_of, none);
    for (f.blocks.items) |blk| for (blk.insts.items) |inst| if (inst.op == .slotaddr) {
        slot_of[inst.res.?] = inst.op.slotaddr;
    };
    const ok = try t.alloc(bool, f.slots.items.len);
    for (f.slots.items, ok) |w, *o| o.* = w == 1;
    const Esc = struct {
        fn mark(so: []const u32, okv: []bool, v: ir.Value) void {
            if (so[v] != none) okv[so[v]] = false;
        }
    };
    for (f.blocks.items) |blk| {
        for (blk.insts.items) |inst| switch (inst.op) {
            .load => |l| if (l.off != 0 or l.ty != .i64) Esc.mark(slot_of, ok, l.p),
            .store => |s| {
                if (s.off != 0) Esc.mark(slot_of, ok, s.p);
                Esc.mark(slot_of, ok, s.v);
                if (slot_of[s.p] != none and f.tys.items[s.v] != .i64) ok[slot_of[s.p]] = false;
            },
            .slotaddr => {},
            else => {
                var it = UseIter.init(inst.op);
                while (it.next()) |v| Esc.mark(slot_of, ok, v);
            },
        };
        var tit = TermUses.init(blk.term);
        while (tit.next()) |v| Esc.mark(slot_of, ok, v);
    }
    // 対象の通し番号
    const cand = try t.alloc(u32, f.slots.items.len);
    var nc: u32 = 0;
    for (ok, cand) |o, *c| {
        c.* = if (o) nc else none;
        nc += @intFromBool(o);
    }
    if (nc == 0) return;

    const cfg = try cfg_.analyze(t, f);
    const df = try cfg_.frontiers(t, &cfg);
    const kids = try cfg_.domChildren(t, &cfg);
    const nb = f.blocks.items.len;

    // ── ブロック引数の置き場所（反復支配境界） ──
    const Added = struct { c: u32, v: ir.Value };
    var added = try t.alloc(std.ArrayListUnmanaged(Added), nb);
    for (added) |*x| x.* = .empty;
    {
        const has = try t.alloc(bool, nb);
        var work: std.ArrayListUnmanaged(ir.BlockId) = .empty;
        for (0..nc) |ci| {
            @memset(has, false);
            work.clearRetainingCapacity();
            const in_work = try t.alloc(bool, nb);
            @memset(in_work, false);
            for (f.blocks.items, 0..) |blk, bi| {
                if (!cfg.reachable(@intCast(bi))) continue;
                for (blk.insts.items) |inst| if (inst.op == .store and candOf(slot_of, cand, inst.op.store.p) == ci) {
                    if (!in_work[bi]) try work.append(t, @intCast(bi));
                    in_work[bi] = true;
                    break;
                };
            }
            while (work.pop()) |b| for (df[b]) |y| if (!has[y]) {
                has[y] = true;
                try f.tys.append(a, .i64);
                const pv: ir.Value = @intCast(f.tys.items.len - 1);
                try f.blocks.items[y].params.append(a, pv);
                try added[y].append(t, .{ .c = @intCast(ci), .v = pv });
                if (!in_work[y]) {
                    in_work[y] = true;
                    try work.append(t, y);
                }
            };
        }
    }

    // ── 置き換え表と、ゼロの定数（入口の先頭） ──
    const nv2 = f.tys.items.len + 1;
    const repl = try t.alloc(ir.Value, nv2);
    for (repl, 0..) |*r, i| r.* = @intCast(i);
    try f.tys.append(a, .i64);
    const zero: ir.Value = @intCast(f.tys.items.len - 1);
    try f.blocks.items[0].insts.insert(a, 0, .{ .res = zero, .op = .{ .iconst = 0 } });

    // ── 名前の付け替え（支配木の前順）──
    const dead = try t.alloc(std.ArrayListUnmanaged(bool), nb);
    for (f.blocks.items, dead) |blk, *d| {
        d.* = .empty;
        try d.appendNTimes(t, false, blk.insts.items.len);
    }
    const stacks = try t.alloc(std.ArrayListUnmanaged(ir.Value), nc);
    for (stacks) |*s| s.* = .empty;
    const Frame = struct { b: ir.BlockId, heights: []const usize, next_kid: usize };
    var frames: std.ArrayListUnmanaged(Frame) = .empty;

    const Visit = struct {
        fn top(st: []std.ArrayListUnmanaged(ir.Value), c: u32, z: ir.Value) ir.Value {
            const s = st[c].items;
            return if (s.len == 0) z else s[s.len - 1];
        }

        /// ブロック b の命令を処理し、出ていく辺に置いた引数ぶんの実引数を足す
        fn block(ma: std.mem.Allocator, ta: std.mem.Allocator, fu: *ir.Func, b: ir.BlockId, st: []std.ArrayListUnmanaged(ir.Value), z: ir.Value, ad: []std.ArrayListUnmanaged(Added), so: []const u32, cd: []const u32, rp: []ir.Value, dd: []std.ArrayListUnmanaged(bool), live: bool) !void {
            const blk = &fu.blocks.items[b];
            if (live) for (ad[b].items) |x| try st[x.c].append(ta, x.v);
            const chain: Chain = .{ .map = rp };
            for (blk.insts.items, 0..) |inst, ii| switch (inst.op) {
                .load => |l| {
                    const c = candOf(so, cd, l.p);
                    if (c == none) continue;
                    rp[inst.res.?] = if (live) top(st, c, z) else z;
                    dd[b].items[ii] = true;
                },
                .store => |s| {
                    const c = candOf(so, cd, s.p);
                    if (c == none) continue;
                    if (live) try st[c].append(ta, chain.apply(s.v));
                    dd[b].items[ii] = true;
                },
                .slotaddr => if (candOf(so, cd, inst.res.?) != none) {
                    dd[b].items[ii] = true;
                },
                else => {},
            };
            switch (blk.term) {
                .br => |*e| try extend(ma, e, st, z, ad, live),
                .condbr => |*c| {
                    try extend(ma, &c.t, st, z, ad, live);
                    try extend(ma, &c.e, st, z, ad, live);
                },
                else => {},
            }
        }

        fn extend(ma: std.mem.Allocator, e: *ir.Edge, st: []std.ArrayListUnmanaged(ir.Value), z: ir.Value, ad: []std.ArrayListUnmanaged(Added), live: bool) !void {
            const extra = ad[e.to].items;
            if (extra.len == 0) return;
            const args = try ma.alloc(ir.Value, e.args.len + extra.len);
            @memcpy(args[0..e.args.len], e.args);
            for (extra, args[e.args.len..]) |x, *o| o.* = if (live) top(st, x.c, z) else z;
            e.args = args;
        }
    };

    {
        const h = try t.alloc(usize, nc);
        for (h, stacks) |*x, s| x.* = s.items.len;
        try Visit.block(a, t, f, 0, stacks, zero, added, slot_of, cand, repl, dead, true);
        try frames.append(t, .{ .b = 0, .heights = h, .next_kid = 0 });
    }
    while (frames.items.len > 0) {
        const fr = &frames.items[frames.items.len - 1];
        if (fr.next_kid < kids[fr.b].len) {
            const k = kids[fr.b][fr.next_kid];
            fr.next_kid += 1;
            const h = try t.alloc(usize, nc);
            for (h, stacks) |*x, s| x.* = s.items.len;
            try Visit.block(a, t, f, k, stacks, zero, added, slot_of, cand, repl, dead, true);
            try frames.append(t, .{ .b = k, .heights = h, .next_kid = 0 });
        } else {
            for (fr.heights, stacks) |hh, *s| s.shrinkRetainingCapacity(hh);
            _ = frames.pop();
        }
    }
    for (0..nb) |bi| if (!cfg.reachable(@intCast(bi))) try Visit.block(a, t, f, @intCast(bi), stacks, zero, added, slot_of, cand, repl, dead, false);

    // ── 消した命令を詰め、使用を置き換える（dead はゼロの定数を足した後に作ったので添字はそのまま）──
    const chain: Chain = .{ .map = repl };
    for (f.blocks.items, dead) |*blk, d| {
        var w: usize = 0;
        for (blk.insts.items, d.items) |inst, is_dead| {
            if (is_dead) continue;
            blk.insts.items[w] = .{ .res = inst.res, .op = try mapOp(a, inst.op, chain) };
            w += 1;
        }
        blk.insts.shrinkRetainingCapacity(w);
        blk.term = try mapTerm(a, blk.term, chain);
    }
    try compact(m, f);
    try dropSlots(m, f);
}

/// 使われなくなったスロットを落として番号を詰める（持ち上げたスロット — -O0 でも入口のゼロ初期化が要らなくなる）
fn dropSlots(m: *ir.Module, f: *ir.Func) !void {
    const a = m.alloc();
    const used = try a.alloc(bool, f.slots.items.len);
    @memset(used, false);
    for (f.blocks.items) |blk| for (blk.insts.items) |inst| if (inst.op == .slotaddr) {
        used[inst.op.slotaddr] = true;
    };
    const map = try a.alloc(ir.SlotId, f.slots.items.len);
    var n: ir.SlotId = 0;
    for (f.slots.items, used, map) |w, u, *o| if (u) {
        o.* = n;
        f.slots.items[n] = w;
        n += 1;
    };
    f.slots.shrinkRetainingCapacity(n);
    for (f.blocks.items) |*blk| for (blk.insts.items) |*inst| if (inst.op == .slotaddr) {
        inst.op = .{ .slotaddr = map[inst.op.slotaddr] };
    };
}

// ── オペランドの走査と置き換え ──

/// buf の使う長さは n で持つ（buf を指すスライスを持つと、値で返したコピーが init のフレームの死んだ buf を指す —
/// Debug では偶然読めて ReleaseSafe / ReleaseFast で壊れていた。B-9b で発見）
const UseIter = struct {
    buf: [3]ir.Value = undefined,
    n: usize = 0,
    extra: []const ir.Value = &.{},
    i: usize = 0,

    fn init(op: ir.Op) UseIter {
        var u: UseIter = .{};
        var n: usize = 0;
        switch (op) {
            .iconst, .slotaddr, .globaladdr, .funcaddr, .region_enter, .region_depth => {},
            .bin => |b| {
                u.buf[0] = b.a;
                u.buf[1] = b.b;
                n = 2;
            },
            .cmp => |c| {
                u.buf[0] = c.a;
                u.buf[1] = c.b;
                n = 2;
            },
            .load => |l| {
                u.buf[0] = l.p;
                n = 1;
            },
            .store => |s| {
                u.buf[0] = s.p;
                u.buf[1] = s.v;
                n = 2;
            },
            .load8 => |l| {
                u.buf[0] = l.p;
                n = 1;
            },
            .store8 => |s| {
                u.buf[0] = s.p;
                u.buf[1] = s.v;
                n = 2;
            },
            .gep => |g| {
                u.buf[0] = g.p;
                u.buf[1] = g.idx;
                n = 2;
            },
            .ptoi, .itop, .region_setdepth, .region_bump => |v| {
                u.buf[0] = v;
                n = 1;
            },
            .call => |c| u.extra = c.args,
            .call_indirect => |c| {
                u.buf[0] = c.callee;
                n = 1;
                u.extra = c.args;
            },
            .syscall => |args| u.extra = args,
            .region_alloc => |r| {
                u.buf[0] = r.depth;
                u.buf[1] = r.words;
                n = 2;
            },
            .region_relocate => |r| {
                u.buf[0] = r.hdr;
                u.buf[1] = r.floor;
                n = 2;
            },
        }
        u.n = n;
        return u;
    }

    fn next(self: *UseIter) ?ir.Value {
        defer self.i += 1;
        if (self.i < self.n) return self.buf[self.i];
        const j = self.i - self.n;
        return if (j < self.extra.len) self.extra[j] else null;
    }
};

const TermUses = struct {
    t: ir.Term,
    i: usize = 0,

    fn init(t: ir.Term) TermUses {
        return .{ .t = t };
    }

    fn next(self: *TermUses) ?ir.Value {
        defer self.i += 1;
        switch (self.t) {
            .br => |e| return if (self.i < e.args.len) e.args[self.i] else null,
            .condbr => |c| {
                if (self.i == 0) return c.c;
                const j = self.i - 1;
                if (j < c.t.args.len) return c.t.args[j];
                const k = j - c.t.args.len;
                return if (k < c.e.args.len) c.e.args[k] else null;
            },
            .ret => |v| return if (self.i == 0) v else null,
            .none, .exit => return null,
        }
    }
};

/// 置き換えの連鎖（map[x] == x で止まる — mem2reg の load の結果 → 現在値）
const Chain = struct {
    map: []const ir.Value,
    fn apply(self: Chain, v: ir.Value) ir.Value {
        var x = v;
        while (self.map[x] != x) x = self.map[x];
        return x;
    }
};

/// 番号の付け替え（1 段 — compact）
const Renum = struct {
    map: []const ir.Value,
    fn apply(self: Renum, v: ir.Value) ir.Value {
        std.debug.assert(self.map[v] != none);
        return self.map[v];
    }
};

fn mapVals(a: std.mem.Allocator, vs: []const ir.Value, ctx: anytype) ![]const ir.Value {
    const out = try a.alloc(ir.Value, vs.len);
    for (vs, out) |v, *o| o.* = ctx.apply(v);
    return out;
}

/// op の全オペランドを ctx.apply で写した op
pub fn mapOp(a: std.mem.Allocator, op: ir.Op, ctx: anytype) !ir.Op {
    return switch (op) {
        .iconst, .slotaddr, .globaladdr, .funcaddr, .region_enter, .region_depth => op,
        .bin => |b| .{ .bin = .{ .op = b.op, .a = ctx.apply(b.a), .b = ctx.apply(b.b) } },
        .cmp => |c| .{ .cmp = .{ .op = c.op, .a = ctx.apply(c.a), .b = ctx.apply(c.b) } },
        .load => |l| .{ .load = .{ .p = ctx.apply(l.p), .off = l.off, .ty = l.ty } },
        .store => |x| .{ .store = .{ .p = ctx.apply(x.p), .off = x.off, .v = ctx.apply(x.v) } },
        .load8 => |l| .{ .load8 = .{ .p = ctx.apply(l.p), .off = l.off } },
        .store8 => |x| .{ .store8 = .{ .p = ctx.apply(x.p), .off = x.off, .v = ctx.apply(x.v) } },
        .gep => |g| .{ .gep = .{ .p = ctx.apply(g.p), .idx = ctx.apply(g.idx), .scale = g.scale } },
        .ptoi => |v| .{ .ptoi = ctx.apply(v) },
        .itop => |v| .{ .itop = ctx.apply(v) },
        .call => |c| .{ .call = .{ .f = c.f, .args = try mapVals(a, c.args, ctx) } },
        .call_indirect => |c| .{ .call_indirect = .{ .callee = ctx.apply(c.callee), .args = try mapVals(a, c.args, ctx), .ret = c.ret } },
        .syscall => |args| .{ .syscall = try mapVals(a, args, ctx) },
        .region_setdepth => |v| .{ .region_setdepth = ctx.apply(v) },
        .region_alloc => |x| .{ .region_alloc = .{ .depth = ctx.apply(x.depth), .words = ctx.apply(x.words) } },
        .region_bump => |v| .{ .region_bump = ctx.apply(v) },
        .region_relocate => |x| .{ .region_relocate = .{ .hdr = ctx.apply(x.hdr), .cellw = x.cellw, .floor = ctx.apply(x.floor) } },
    };
}

pub fn mapTerm(a: std.mem.Allocator, t: ir.Term, ctx: anytype) !ir.Term {
    return switch (t) {
        .none, .exit => t,
        .br => |e| .{ .br = .{ .to = e.to, .args = try mapVals(a, e.args, ctx) } },
        .condbr => |c| .{ .condbr = .{ .c = ctx.apply(c.c), .t = .{ .to = c.t.to, .args = try mapVals(a, c.t.args, ctx) }, .e = .{ .to = c.e.to, .args = try mapVals(a, c.e.args, ctx) } } },
        .ret => |v| .{ .ret = if (v) |x| ctx.apply(x) else null },
    };
}

/// 値の番号を定義の順（仮引数 → ブロックごとに引数・命令の結果）に詰め直す。消えた値の番号を埋め、
/// 仮引数は 0.. のまま（ir_parse の規則）
fn compact(m: *ir.Module, f: *ir.Func) !void {
    const a = m.alloc();
    const map = try a.alloc(ir.Value, f.tys.items.len);
    @memset(map, none);
    var tys: std.ArrayListUnmanaged(ir.Ty) = .empty;
    const old = f.tys.items;
    const Assign = struct {
        fn go(al: std.mem.Allocator, mp: []ir.Value, ts: *std.ArrayListUnmanaged(ir.Ty), o: []const ir.Ty, v: ir.Value) !ir.Value {
            mp[v] = @intCast(ts.items.len);
            try ts.append(al, o[v]);
            return mp[v];
        }
    };
    const ps = try a.alloc(ir.Value, f.params.len);
    for (f.params, ps) |p, *o| o.* = try Assign.go(a, map, &tys, old, p);
    f.params = ps;
    for (f.blocks.items) |*blk| {
        for (blk.params.items) |*p| p.* = try Assign.go(a, map, &tys, old, p.*);
        for (blk.insts.items) |*inst| if (inst.res) |r| {
            inst.res = try Assign.go(a, map, &tys, old, r);
        };
    }
    const rn: Renum = .{ .map = map };
    for (f.blocks.items) |*blk| {
        for (blk.insts.items) |*inst| inst.op = try mapOp(a, inst.op, rn);
        blk.term = try mapTerm(a, blk.term, rn);
    }
    f.tys = tys;
}
