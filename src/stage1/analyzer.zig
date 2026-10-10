//! analyzer 1 本目: acquire / release の局所照合（V5-3。docs/design-dev.md Phase 4 の先頭、region-domain-pool.md 4 節）。
//!
//! 規則（R-a）: `h := pool.Acquire(mut p, v)` の**直後の文**は `defer pool.Release(mut p, h)` でなければならない。
//! 同じブロックの直後なので、間に脱出（return / `?` / break）が挟まる漏れが形で起きない。defer はブロックの全出口で
//! 走る（V4-3）ので、返却は全経路で保証される。
//! - Acquire はこの束縛の形以外に書けない（式の途中・捨てる文・多名束縛は拒否）
//! - Release はこの defer の形以外に書けない（早すぎる release・二重 release・Handle の別名経由を拒否）
//! - 対象の特定は std/pool の関数名に焼き込む（H1 — 2 番目の顧客が現れたら注釈で一般化する）
//!
//! 層: 受理の定義に含む analyzer 層（docs/design-dev.md 層の線引き）— `sober check` が走らせ、build は走らせない。
//! 入力はソースの AST（脱糖後は defer が出口ごとに展開され関数名も消えるので、照合はここでしかできない）。
//! 出力は診断の列。fix は書き込まず、差し込む行を診断に示すだけ（V5-0 裁定 3）。
//! 動的な底: Pool.Outstanding（未返却カウンタ — 受理したプログラムは終了時に 0。scripts/pool_oracle.sh）。
const std = @import("std");
const ast = @import("ast.zig");

pub const pool_path = "std/pool";

pub const Finding = struct {
    pos: ast.Pos,
    /// 診断本文（fix が差し込む行の提示を含む）。Analyzer の arena に住む
    what: []const u8,
};

const Kind = enum { acquire, release };

pub const Analyzer = struct {
    a: std.mem.Allocator,
    pkg: *const ast.Pkg = undefined,
    findings: std.ArrayListUnmanaged(Finding) = .empty,
    /// 規則どおりの位置にある Acquire / Release の呼び出し（走査でこれ以外を見つけたら拒否）
    ok_calls: std.AutoHashMapUnmanaged(*const ast.Expr, void) = .empty,

    fn report(self: *Analyzer, pos: ast.Pos, comptime fmt: []const u8, args: anytype) !void {
        try self.findings.append(self.a, .{ .pos = pos, .what = try std.fmt.allocPrint(self.a, fmt, args) });
    }

    /// 呼び出しの callee が std/pool の Acquire / Release か。修飾名 `pool.X`（import の参照名 — ローカルは
    /// 参照名を再利用できないので衝突しない）・明示の型引数 `pool.X[T]`・std/pool 自身の中の裸の `X`
    fn poolFn(self: *const Analyzer, callee: *const ast.Expr) ?Kind {
        const c = if (callee.* == .index) callee.index.base else callee;
        const name: []const u8 = switch (c.*) {
            .selector => |sel| blk: {
                if (sel.base.* != .ident) return null;
                const path = self.pkg.imports.get(sel.base.ident.name) orelse return null;
                if (!std.mem.eql(u8, path, pool_path)) return null;
                break :blk sel.field;
            },
            .ident => |id| blk: {
                if (!std.mem.eql(u8, self.pkg.path, pool_path)) return null;
                break :blk id.name;
            },
            else => return null,
        };
        if (std.mem.eql(u8, name, "Acquire")) return .acquire;
        if (std.mem.eql(u8, name, "Release")) return .release;
        return null;
    }

    fn callKind(self: *const Analyzer, e: *const ast.Expr) ?Kind {
        return if (e.* == .call) self.poolFn(e.call.callee) else null;
    }

    /// Pool の実引数の表記（`mut p` / `p`）を名前にする。比べられない形は null
    fn poolName(e: *const ast.Expr) ?[]const u8 {
        return switch (e.*) {
            .mut_arg => |m| m.name,
            .ident => |id| id.name,
            else => null,
        };
    }

    /// callee の表記（診断の提示用 — `pool.Release` / `Release`）
    fn releaseSpelling(self: *Analyzer, callee: *const ast.Expr) ![]const u8 {
        const c = if (callee.* == .index) callee.index.base else callee;
        return switch (c.*) {
            .selector => |sel| try std.fmt.allocPrint(self.a, "{s}.Release", .{sel.base.ident.name}),
            else => "Release",
        };
    }

    fn stmtList(self: *Analyzer, list: []const ast.Stmt) error{OutOfMemory}!void {
        for (list, 0..) |st, i| {
            if (st == .bind) try self.acquireBind(st.bind, list[i + 1 ..]);
        }
        for (list) |st| try self.stmt(st);
    }

    /// 束縛が Acquire なら、直後の文を照合して両方の呼び出しを「規則どおり」に登録する
    fn acquireBind(self: *Analyzer, b: ast.Bind, rest: []const ast.Stmt) !void {
        if (b.values.len != 1) return;
        const v = if (b.values[0].* == .try_) b.values[0].try_.e else b.values[0];
        if (self.callKind(v) != .acquire) return;
        const acq = v.call;
        if (b.names.len != 1 or b.mutable) return; // 形が違う — 走査が「規則外の Acquire」として拒否する
        const h = b.names[0];
        const p = if (acq.args.len > 0) poolName(acq.args[0]) else null;
        const want = try std.fmt.allocPrint(self.a, "defer {s}({s}{s}, {s})", .{
            try self.releaseSpelling(acq.callee),
            if (acq.args.len > 0 and acq.args[0].* == .mut_arg) "mut " else "",
            p orelse "<pool>",
            h,
        });
        try self.ok_calls.put(self.a, v, {});
        if (rest.len > 0 and rest[0] == .defer_) {
            const d = rest[0].defer_.expr;
            if (self.callKind(d) == .release) {
                const rel = d.call;
                const same_h = rel.args.len == 2 and rel.args[1].* == .ident and std.mem.eql(u8, rel.args[1].ident.name, h);
                const rp = if (rel.args.len > 0) poolName(rel.args[0]) else null;
                const same_p = p != null and rp != null and std.mem.eql(u8, p.?, rp.?);
                if (same_h and same_p) {
                    try self.ok_calls.put(self.a, d, {});
                    return;
                }
                try self.ok_calls.put(self.a, d, {}); // 報告はここで 1 回（走査で重ねて言わない）
                return self.report(rel.tok, "this defer must release the handle just acquired: write `{s}`", .{want});
            }
        }
        try self.report(acq.tok, "acquired handle '{s}' must be released by the next statement: insert `{s}` right after this line", .{ h, want });
    }

    fn stmt(self: *Analyzer, st: ast.Stmt) !void {
        switch (st) {
            .bind => |b| for (b.values) |v| try self.expr(v),
            .assign => |asg| {
                for (asg.targets) |t| try self.expr(t);
                for (asg.values) |v| try self.expr(v);
            },
            .ret => |r| for (r.values) |v| try self.expr(v),
            .expr => |e| try self.expr(e),
            .while_ => |w| {
                try self.expr(w.cond);
                try self.stmtList(w.body.stmts);
            },
            .break_, .continue_ => {},
            .defer_ => |d| try self.expr(d.expr),
            .yield_ => |y| try self.expr(y.expr),
        }
    }

    fn expr(self: *Analyzer, e: *const ast.Expr) error{OutOfMemory}!void {
        switch (e.*) {
            .int, .nil, .ident, .strlit, .mut_arg => {},
            .binary => |b| {
                try self.expr(b.lhs);
                try self.expr(b.rhs);
            },
            .unary => |u| try self.expr(u.operand),
            .call => |c| {
                if (self.poolFn(c.callee)) |k| if (!self.ok_calls.contains(e)) switch (k) {
                    .acquire => try self.report(c.tok, "Acquire must be bound by `h := ...Acquire(...)` as a statement of its own, and released by the next statement", .{}),
                    .release => try self.report(c.tok, "Release may only appear as `defer ...Release(p, h)` right after the `h := ...Acquire(...)` it releases", .{}),
                };
                try self.expr(c.callee);
                for (c.args) |a| try self.expr(a);
            },
            .pipe => |p| {
                if (self.poolFn(p.callee) != null)
                    try self.report(p.tok, "Acquire / Release cannot be called through `|>` (write the call form so the pairing is checkable)", .{});
                try self.expr(p.lhs);
                try self.expr(p.callee);
                for (p.args) |a| if (a) |x| try self.expr(x);
            },
            .index => |ix| {
                try self.expr(ix.base);
                try self.expr(ix.idx);
            },
            .slice3 => |s| {
                try self.expr(s.base);
                try self.expr(s.lo);
                try self.expr(s.hi);
            },
            .interp => |it| for (it.tmpl.holes) |h| try self.expr(h),
            .slicelit => |s| for (s.elems) |x| try self.expr(x),
            .maplit => |m| for (m.entries) |en| {
                try self.expr(en.key);
                try self.expr(en.value);
            },
            .composite => |c| for (c.elems) |el| try self.expr(el.value),
            .selector => |s| try self.expr(s.base),
            .lambda => |l| try self.expr(l.body),
            .if_ => |i| {
                try self.expr(i.cond);
                try self.stmtList(i.then.stmts);
                if (i.else_) |x| try self.expr(x);
            },
            .switch_ => |s| {
                for (s.subjects) |x| try self.expr(x);
                for (s.cases) |c| {
                    for (c.patterns) |pat| if (pat == .const_) for (pat.const_) |x| try self.expr(x);
                    try self.stmtList(c.body.stmts);
                }
                if (s.default_) |d| try self.stmtList(d.stmts);
            },
            .block => |b| try self.stmtList(b.stmts),
            .for_ => |f| {
                for (f.gens) |g| {
                    try self.expr(g.src);
                    for (g.guards) |x| try self.expr(x);
                }
                switch (f.body) {
                    .yield_ => |y| try self.expr(y),
                    .block => |b| try self.stmtList(b.stmts),
                }
            },
            .try_ => |t| {
                try self.expr(t.e);
                if (t.wrap) |w| for (w.elems) |el| try self.expr(el.value);
            },
        }
    }
};

/// 全 package の全関数本体（ラムダ・const 辞書のラムダ込み）を照合する。findings は a（arena 推奨）に住む
pub fn analyze(a: std.mem.Allocator, prog: *const ast.Program) ![]const Finding {
    var an: Analyzer = .{ .a = a };
    for (prog.pkgs) |pkg| {
        an.pkg = pkg;
        for (pkg.files) |f| {
            for (f.funcs) |fd| try an.stmtList(fd.body.stmts);
            for (f.consts) |c| try an.expr(c.expr);
        }
    }
    return an.findings.items;
}
