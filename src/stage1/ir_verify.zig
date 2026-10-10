//! IR の検証器（B-7）: 構造（ir.verify の従来の検査）に加えて、命令ごとのオペランドの型・結果の型・参照の範囲、
//! 定義が使用を支配すること（SSA の条件 — 同じブロックなら先に、他のブロックなら支配するブロックで定義）を検査する。
//! 辺の引数の使用点は前任ブロックの末尾。到達しないブロックの中は型と範囲だけを見る（支配は定義されない）。
//! lower の出力・IR テキストの入力（ir_parse）・IR パス（mem2reg）の前後の全部に掛ける
const std = @import("std");
const ir = @import("ir.zig");
const cfg_ = @import("ir_cfg.zig");

pub const Diag = struct {
    what: []const u8 = "",
    buf: [200]u8 = undefined,
};

pub fn verify(m: *const ir.Module) error{InvalidIr}!void {
    var d: Diag = .{};
    return verifyDiag(m, &d);
}

pub fn verifyDiag(m: *const ir.Module, diag: *Diag) error{InvalidIr}!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    for (m.funcs.items) |f| {
        var v: V = .{ .m = m, .f = f, .diag = diag, .a = arena.allocator() };
        v.func() catch |err| switch (err) {
            error.OutOfMemory => return v.fail("out of memory in the verifier", .{}),
            error.InvalidIr => return error.InvalidIr,
        };
    }
}

const V = struct {
    m: *const ir.Module,
    f: *const ir.Func,
    diag: *Diag,
    a: std.mem.Allocator,
    cfg: cfg_.Cfg = undefined,
    /// 値 → 定義ブロック（未定義は none）と、ブロック内の位置（引数は -1）
    def_blk: []ir.BlockId = &.{},
    def_idx: []i64 = &.{},
    /// 検査中の使用点
    cur_blk: ir.BlockId = 0,
    cur_idx: i64 = 0,

    fn fail(self: *V, comptime fmt: []const u8, args: anytype) error{InvalidIr} {
        const head = std.fmt.bufPrint(&self.diag.buf, "func @{s}: ", .{self.f.name}) catch "";
        const rest = std.fmt.bufPrint(self.diag.buf[head.len..], fmt, args) catch "";
        self.diag.what = self.diag.buf[0 .. head.len + rest.len];
        return error.InvalidIr;
    }

    fn func(self: *V) error{ InvalidIr, OutOfMemory }!void {
        const f = self.f;
        const nb = f.blocks.items.len;
        if (nb == 0) return self.fail("no blocks", .{});
        const entry = f.blocks.items[0];
        if (entry.preds != 0 or entry.params.items.len != 0) return self.fail("the entry block has predecessors or parameters", .{});
        const nv = f.tys.items.len;
        self.def_blk = try self.a.alloc(ir.BlockId, nv);
        @memset(self.def_blk, cfg_.none);
        self.def_idx = try self.a.alloc(i64, nv);
        for (f.params) |p| try self.def(p, 0, -1);
        for (f.blocks.items, 0..) |blk, bi| {
            if (blk.term == .none) return self.fail("b{d} is not terminated", .{bi});
            for (blk.params.items) |p| try self.def(p, @intCast(bi), -1);
            for (blk.insts.items, 0..) |inst, ii| if (inst.res) |r| try self.def(r, @intCast(bi), @intCast(ii));
        }
        for (self.def_blk, 0..) |d, v| if (d == cfg_.none) return self.fail("%{d} is never defined", .{v});
        self.cfg = try cfg_.analyze(self.a, f);
        // 前任数（Builder / パーサが数えたもの）が辺と合うこと
        for (f.blocks.items, 0..) |blk, bi| if (blk.preds != self.cfg.preds[bi].len)
            return self.fail("b{d} records {d} predecessors but has {d} incoming edges", .{ bi, blk.preds, self.cfg.preds[bi].len });
        for (f.blocks.items, 0..) |blk, bi| {
            self.cur_blk = @intCast(bi);
            for (blk.insts.items, 0..) |inst, ii| {
                self.cur_idx = @intCast(ii);
                try self.checkInst(inst);
            }
            self.cur_idx = std.math.maxInt(i64);
            try self.term(blk.term);
        }
    }

    fn def(self: *V, v: ir.Value, b: ir.BlockId, idx: i64) error{InvalidIr}!void {
        if (v >= self.def_blk.len) return self.fail("%{d} has no type", .{v});
        if (self.def_blk[v] != cfg_.none) return self.fail("%{d} is defined twice", .{v});
        self.def_blk[v] = b;
        self.def_idx[v] = idx;
    }

    /// v の使用: 型（want が null なら問わない）と、到達するブロックなら支配
    fn use(self: *V, v: ir.Value, want: ?ir.Ty, what: []const u8) error{InvalidIr}!void {
        if (v >= self.def_blk.len) return self.fail("b{d}: {s} uses undefined %{d}", .{ self.cur_blk, what, v });
        if (want) |t| if (self.f.tys.items[v] != t)
            return self.fail("b{d}: {s} wants {s} but %{d} is {s}", .{ self.cur_blk, what, @tagName(t), v, @tagName(self.f.tys.items[v]) });
        if (!self.cfg.reachable(self.cur_blk)) return;
        const db = self.def_blk[v];
        const ok = if (db == self.cur_blk)
            self.def_idx[v] < self.cur_idx
        else
            self.cfg.reachable(db) and self.cfg.dominates(db, self.cur_blk);
        if (!ok) return self.fail("b{d}: {s} uses %{d} whose definition (b{d}) does not dominate the use", .{ self.cur_blk, what, v, db });
    }

    fn result(self: *V, inst: ir.Inst, want: ?ir.Ty, what: []const u8) error{InvalidIr}!void {
        if ((inst.res == null) != (want == null)) return self.fail("b{d}: {s} result presence is wrong", .{ self.cur_blk, what });
        if (inst.res) |r| if (self.f.tys.items[r] != want.?) return self.fail("b{d}: {s} result %{d} should be {s}", .{ self.cur_blk, what, r, @tagName(want.?) });
    }

    fn checkInst(self: *V, inst: ir.Inst) error{InvalidIr}!void {
        const i64_: ?ir.Ty = .i64;
        const ptr: ?ir.Ty = .ptr;
        switch (inst.op) {
            .iconst => try self.result(inst, i64_, "const"),
            .bin => |b| {
                try self.use(b.a, i64_, @tagName(b.op));
                try self.use(b.b, i64_, @tagName(b.op));
                try self.result(inst, i64_, @tagName(b.op));
            },
            .cmp => |c| {
                try self.use(c.a, i64_, @tagName(c.op));
                try self.use(c.b, i64_, @tagName(c.op));
                try self.result(inst, i64_, @tagName(c.op));
            },
            .load => |l| {
                try self.use(l.p, ptr, "load");
                try self.result(inst, l.ty, "load");
            },
            .store => |s| {
                try self.use(s.p, ptr, "store");
                try self.use(s.v, null, "store");
                try self.result(inst, null, "store");
            },
            .load8 => |l| {
                try self.use(l.p, ptr, "load8");
                try self.result(inst, i64_, "load8");
            },
            .store8 => |s| {
                try self.use(s.p, ptr, "store8");
                try self.use(s.v, i64_, "store8");
                try self.result(inst, null, "store8");
            },
            .gep => |g| {
                try self.use(g.p, ptr, "gep");
                try self.use(g.idx, i64_, "gep");
                try self.result(inst, ptr, "gep");
            },
            .ptoi => |v| {
                try self.use(v, ptr, "ptoi");
                try self.result(inst, i64_, "ptoi");
            },
            .itop => |v| {
                try self.use(v, i64_, "itop");
                try self.result(inst, ptr, "itop");
            },
            .slotaddr => |sl| {
                if (sl >= self.f.slots.items.len) return self.fail("b{d}: undefined slot s{d}", .{ self.cur_blk, sl });
                try self.result(inst, ptr, "slotaddr");
            },
            .globaladdr => |g| {
                if (g >= self.m.globals.items.len) return self.fail("b{d}: undefined global #{d}", .{ self.cur_blk, g });
                try self.result(inst, ptr, "globaladdr");
            },
            .funcaddr => |fid| {
                if (fid >= self.m.funcs.items.len) return self.fail("b{d}: undefined func #{d}", .{ self.cur_blk, fid });
                try self.result(inst, i64_, "funcaddr");
            },
            .call => |c| {
                if (c.f >= self.m.funcs.items.len) return self.fail("b{d}: undefined func #{d}", .{ self.cur_blk, c.f });
                const callee = self.m.funcs.items[c.f];
                if (c.args.len != callee.params.len) return self.fail("b{d}: call @{s} with {d} arguments for {d}", .{ self.cur_blk, callee.name, c.args.len, callee.params.len });
                for (c.args, callee.params) |x, p| try self.use(x, callee.tys.items[p], "call argument");
                try self.result(inst, callee.ret, "call");
            },
            .call_indirect => |c| {
                try self.use(c.callee, i64_, "call.indirect callee");
                for (c.args) |x| try self.use(x, null, "call.indirect argument");
                try self.result(inst, c.ret, "call.indirect");
            },
            .syscall => |args| {
                if (args.len < 1 or args.len > 7) return self.fail("b{d}: syscall with {d} arguments", .{ self.cur_blk, args.len });
                for (args) |x| try self.use(x, i64_, "syscall");
                try self.result(inst, i64_, "syscall");
            },
            .region_enter => try self.result(inst, null, "region.enter"),
            .region_depth => try self.result(inst, i64_, "region.depth"),
            .region_setdepth => |v| {
                try self.use(v, i64_, "region.setdepth");
                try self.result(inst, null, "region.setdepth");
            },
            .region_alloc => |r| {
                try self.use(r.depth, i64_, "region.alloc");
                try self.use(r.words, i64_, "region.alloc");
                try self.result(inst, ptr, "region.alloc");
            },
            .region_bump => |d| {
                try self.use(d, i64_, "region.bump");
                try self.result(inst, ptr, "region.bump");
            },
            .region_relocate => |r| {
                try self.use(r.hdr, ptr, "region.relocate");
                try self.use(r.floor, i64_, "region.relocate");
                try self.result(inst, null, "region.relocate");
            },
        }
    }

    fn edge(self: *V, e: ir.Edge) error{InvalidIr}!void {
        if (e.to >= self.f.blocks.items.len) return self.fail("b{d}: branch to undefined b{d}", .{ self.cur_blk, e.to });
        if (e.to == 0) return self.fail("b{d}: branch to the entry block", .{self.cur_blk});
        const ps = self.f.blocks.items[e.to].params.items;
        if (ps.len != e.args.len) return self.fail("b{d}: edge to b{d} passes {d} arguments for {d}", .{ self.cur_blk, e.to, e.args.len, ps.len });
        for (e.args, ps) |x, p| try self.use(x, self.f.tys.items[p], "edge argument");
    }

    fn term(self: *V, t: ir.Term) error{InvalidIr}!void {
        switch (t) {
            .none => unreachable,
            .br => |e| try self.edge(e),
            .condbr => |c| {
                try self.use(c.c, .i64, "condbr");
                try self.edge(c.t);
                try self.edge(c.e);
            },
            .ret => |v| {
                if ((v == null) != (self.f.ret == null)) return self.fail("b{d}: ret value presence differs from the signature", .{self.cur_blk});
                if (v) |x| try self.use(x, self.f.ret.?, "ret");
            },
            .exit => {},
        }
    }
};
