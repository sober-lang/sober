//! IR の CFG 解析（B-7）: 後続・前任・到達可能性・逆後順・支配木（Cooper–Harvey–Kennedy の反復法）・支配境界。
//! 検証器（ir_verify.zig — 定義が使用を支配するか）と mem2reg（ir_mem2reg.zig — ブロック引数の置き場所）が共有する
const std = @import("std");
const ir = @import("ir.zig");

pub const none: ir.BlockId = std.math.maxInt(ir.BlockId);

pub const Cfg = struct {
    succs: []const []const ir.BlockId,
    preds: []const []const ir.BlockId,
    /// 逆後順（入口から到達するブロックだけ）
    rpo: []const ir.BlockId,
    /// ブロック → rpo の添字（到達しないブロックは none）
    order: []const ir.BlockId,
    /// 直接支配ブロック（入口は自分自身、到達しないブロックは none）
    idom: []const ir.BlockId,

    pub fn reachable(self: *const Cfg, b: ir.BlockId) bool {
        return self.order[b] != none;
    }

    /// a が b を支配するか（a == b を含む。どちらも到達するブロック）
    pub fn dominates(self: *const Cfg, a: ir.BlockId, b: ir.BlockId) bool {
        var x = b;
        while (true) {
            if (x == a) return true;
            const up = self.idom[x];
            if (up == x) return false;
            x = up;
        }
    }
};

pub fn successors(t: ir.Term, out: *std.ArrayListUnmanaged(ir.BlockId), a: std.mem.Allocator) !void {
    switch (t) {
        .br => |e| try out.append(a, e.to),
        .condbr => |c| {
            try out.append(a, c.t.to);
            try out.append(a, c.e.to);
        },
        .none, .ret, .exit => {},
    }
}

/// a は結果の寿命（arena を推奨）
pub fn analyze(a: std.mem.Allocator, f: *const ir.Func) !Cfg {
    const n = f.blocks.items.len;
    const succs = try a.alloc([]const ir.BlockId, n);
    var pl = try a.alloc(std.ArrayListUnmanaged(ir.BlockId), n);
    for (pl) |*p| p.* = .empty;
    for (f.blocks.items, succs, 0..) |blk, *s, i| {
        var l: std.ArrayListUnmanaged(ir.BlockId) = .empty;
        try successors(blk.term, &l, a);
        s.* = l.items;
        for (l.items) |to| try pl[to].append(a, @intCast(i));
    }
    const preds = try a.alloc([]const ir.BlockId, n);
    for (pl, preds) |p, *o| o.* = p.items;

    // 後順（反復 DFS）
    const post = try a.alloc(ir.BlockId, n);
    var np: usize = 0;
    const visited = try a.alloc(bool, n);
    @memset(visited, false);
    const Frame = struct { b: ir.BlockId, next: usize };
    var stack: std.ArrayListUnmanaged(Frame) = .empty;
    if (n > 0) {
        visited[0] = true;
        try stack.append(a, .{ .b = 0, .next = 0 });
    }
    while (stack.items.len > 0) {
        const top = &stack.items[stack.items.len - 1];
        if (top.next < succs[top.b].len) {
            const s = succs[top.b][top.next];
            top.next += 1;
            if (!visited[s]) {
                visited[s] = true;
                try stack.append(a, .{ .b = s, .next = 0 });
            }
        } else {
            post[np] = top.b;
            np += 1;
            _ = stack.pop();
        }
    }
    const rpo = try a.alloc(ir.BlockId, np);
    for (rpo, 0..) |*r, i| r.* = post[np - 1 - i];
    const order = try a.alloc(ir.BlockId, n);
    @memset(order, none);
    for (rpo, 0..) |b, i| order[b] = @intCast(i);

    // 支配木（Cooper–Harvey–Kennedy）
    const idom = try a.alloc(ir.BlockId, n);
    @memset(idom, none);
    if (np > 0) idom[0] = 0;
    var changed = true;
    while (changed) {
        changed = false;
        for (rpo[1..]) |b| {
            var new: ir.BlockId = none;
            for (preds[b]) |p| {
                if (idom[p] == none) continue;
                new = if (new == none) p else intersect(idom, order, p, new);
            }
            if (new != idom[b]) {
                idom[b] = new;
                changed = true;
            }
        }
    }
    return .{ .succs = succs, .preds = preds, .rpo = rpo, .order = order, .idom = idom };
}

fn intersect(idom: []const ir.BlockId, order: []const ir.BlockId, x0: ir.BlockId, y0: ir.BlockId) ir.BlockId {
    var x = x0;
    var y = y0;
    while (x != y) {
        while (order[x] > order[y]) x = idom[x];
        while (order[y] > order[x]) y = idom[y];
    }
    return x;
}

/// 支配境界（到達するブロックだけ。Cooper–Harvey–Kennedy の走査）
pub fn frontiers(a: std.mem.Allocator, cfg: *const Cfg) ![]const []const ir.BlockId {
    const n = cfg.idom.len;
    var df = try a.alloc(std.ArrayListUnmanaged(ir.BlockId), n);
    for (df) |*d| d.* = .empty;
    for (cfg.rpo) |b| {
        var reach: usize = 0;
        for (cfg.preds[b]) |p| reach += @intFromBool(cfg.reachable(p));
        if (reach < 2) continue;
        for (cfg.preds[b]) |p| {
            if (!cfg.reachable(p)) continue;
            var r = p;
            while (r != cfg.idom[b]) {
                if (std.mem.indexOfScalar(ir.BlockId, df[r].items, b) == null) try df[r].append(a, b);
                r = cfg.idom[r];
            }
        }
    }
    const out = try a.alloc([]const ir.BlockId, n);
    for (df, out) |d, *o| o.* = d.items;
    return out;
}

/// 支配木の子（到達するブロックだけ）
pub fn domChildren(a: std.mem.Allocator, cfg: *const Cfg) ![]const []const ir.BlockId {
    const n = cfg.idom.len;
    var ch = try a.alloc(std.ArrayListUnmanaged(ir.BlockId), n);
    for (ch) |*c| c.* = .empty;
    for (cfg.rpo[@min(1, cfg.rpo.len)..]) |b| try ch[cfg.idom[b]].append(a, b);
    const out = try a.alloc([]const ir.BlockId, n);
    for (ch, out) |c, *o| o.* = c.items;
    return out;
}
