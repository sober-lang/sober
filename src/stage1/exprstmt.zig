//! 式文の検査（syntax.md ブロックの行 — 裁定 C 2026-09-27、Go 同型）。
//!
//! 文位置（値を捨てる位置）に置けるのは、呼び出し（`f(x)`・`x |> f()`・`f()?`）と、腕がまた文位置になる
//! if / switch / ブロックだけ。純粋な式（`x + 1`・名前・リテラル・`xs[i]` 等）の値を捨てる文は拒否する —
//! 書いた意味が無いか、代入の書き忘れ。呼び出しの結果を捨てるのは許す（error? の取りこぼしは analyzer が別途担う）。
//! 文位置 = 関数本体・while 本体・for 本体・defer の式・文位置の if / switch / ブロックの腕の全文、
//! 値位置のブロック（式の if の腕・ブロック式・ラムダ本体）の末尾以外の文。
//! 例外: main package の `main` の本体の末尾は値位置 — check の検査単位は main 本体の式で、`*_pure` 例は末尾の値を
//! Lean の評価（Examples.lean のスナップショット）と突き合わせる（formal.md「型検査器の断片」）。codegen はその値を捨てる。
//! loader.link で一度だけ走らせるので、desugar と codegen は同じ規則を構成的に共有する（localnames.zig と同じ置き場）。
const std = @import("std");
const ast = @import("ast.zig");

pub const Hit = struct {
    tok: u32,

    pub fn what(_: Hit) []const u8 {
        return "an expression statement must be a call: the value of a pure expression is unused (bind or assign it, or remove it)";
    }
};

/// 最初の違反を返す。無ければ null
pub fn check(pkg: *const ast.Pkg) ?Hit {
    for (pkg.files) |file| {
        for (file.funcs) |f| {
            const is_main = std.mem.eql(u8, pkg.name, "main") and std.mem.eql(u8, f.name, "main");
            if (block(f.body, if (is_main) .value else .stmt)) |h| return h;
        }
        for (file.consts) |c| if (expr(c.expr)) |h| return h;
    }
    return null;
}

const Ctx = enum { stmt, value };

fn block(b: *const ast.Block, ctx: Ctx) ?Hit {
    for (b.stmts, 0..) |s, i| {
        const at_stmt = ctx == .stmt or i + 1 < b.stmts.len;
        if (stmt(s, at_stmt)) |h| return h;
    }
    return null;
}

fn exprs(es: []const *ast.Expr) ?Hit {
    for (es) |e| if (expr(e)) |h| return h;
    return null;
}

fn stmt(s: ast.Stmt, at_stmt: bool) ?Hit {
    switch (s) {
        .bind => |b| return exprs(b.values),
        .assign => |a| return exprs(a.targets) orelse exprs(a.values),
        .ret => |r| return exprs(r.values),
        .expr => |e| return if (at_stmt) discarded(e) else expr(e),
        .while_ => |wl| return expr(wl.cond) orelse block(wl.body, .stmt),
        .break_, .continue_ => return null,
        .defer_ => |d| return discarded(d.expr),
        .yield_ => |y| return expr(y.expr),
    }
}

/// 値を捨てる位置の式
fn discarded(e: *const ast.Expr) ?Hit {
    switch (e.*) {
        .call, .pipe, .try_ => return expr(e),
        .if_ => |i| {
            if (expr(i.cond) orelse block(i.then, .stmt)) |h| return h;
            const els = i.else_ orelse return null;
            return if (els.* == .block) block(els.block, .stmt) else discarded(els);
        },
        .switch_ => |sw| {
            if (exprs(sw.subjects)) |h| return h;
            for (sw.cases) |c| {
                for (c.patterns) |p| if (pattern(p)) |h| return h;
                if (block(c.body, .stmt)) |h| return h;
            }
            return if (sw.default_) |d| block(d, .stmt) else null;
        },
        .block => |b| return block(b, .stmt),
        else => return .{ .tok = e.tok() },
    }
}

fn expr(e: *const ast.Expr) ?Hit {
    switch (e.*) {
        .int, .nil, .ident, .strlit, .mut_arg => return null,
        .binary => |b| return expr(b.lhs) orelse expr(b.rhs),
        .interp => |it| return exprs(it.tmpl.holes),
        .unary => |u| return expr(u.operand),
        .call => |c| return expr(c.callee) orelse exprs(c.args),
        .pipe => |p| {
            if (expr(p.lhs) orelse expr(p.callee)) |h| return h;
            for (p.args) |a| if (a) |x| if (expr(x)) |h| return h;
            return null;
        },
        .index => |i| return expr(i.base) orelse expr(i.idx),
        .slice3 => |s| return expr(s.base) orelse expr(s.lo) orelse expr(s.hi),
        .slicelit => |s| return exprs(s.elems),
        .maplit => |m| {
            for (m.entries) |en| if (expr(en.key) orelse expr(en.value)) |h| return h;
            return null;
        },
        .composite => |c| {
            for (c.elems) |el| if (expr(el.value)) |h| return h;
            return null;
        },
        .selector => |s| return expr(s.base),
        .try_ => |t| {
            if (expr(t.e)) |h| return h;
            if (t.wrap) |c| for (c.elems) |el| if (expr(el.value)) |h| return h;
            return null;
        },
        .lambda => |l| return if (l.body.* == .block) block(l.body.block, .value) else expr(l.body),
        .if_ => |i| {
            if (expr(i.cond) orelse block(i.then, .value)) |h| return h;
            const els = i.else_ orelse return null;
            return if (els.* == .block) block(els.block, .value) else expr(els);
        },
        .switch_ => |sw| {
            if (exprs(sw.subjects)) |h| return h;
            for (sw.cases) |c| {
                for (c.patterns) |p| if (pattern(p)) |h| return h;
                if (block(c.body, .value)) |h| return h;
            }
            return if (sw.default_) |d| block(d, .value) else null;
        },
        .block => |b| return block(b, .value),
        .for_ => |f| {
            for (f.gens) |g| if (expr(g.src) orelse exprs(g.guards)) |h| return h;
            return switch (f.body) {
                .yield_ => |y| expr(y),
                .block => |b| block(b, .stmt),
            };
        },
    }
}

fn pattern(p: ast.Pattern) ?Hit {
    switch (p) {
        .const_ => |alts| return exprs(alts),
        .type_ => |tp| {
            for (tp.fields) |fp| if (fp.sub) |sub| if (pattern(sub.*)) |h| return h;
            return null;
        },
    }
}
