//! ローカル束縛とトップレベル名の衝突検査（syntax.md 決定 13 の延長 — 裁定 2026-09-27）。
//!
//! ローカルの束縛（`:=`・引数・ラムダ引数・for の生成元・型パターンの束縛）は、同じ package の
//! トップレベル名（const・func・型・variant — ast.Pkg.hasTopName）とも import の参照名とも同名にできない。
//! 型パラメータ（func / type の `[T]`）はトップレベルの型名と同名にできない（追加裁定 2026-09-27）。
//! loader.link で一度だけ走らせるので、desugar と codegen は同じ規則を構成的に共有する。
//! パターン位置の裸の識別子はトップレベル名に当たれば比較になる（9 節）ので、ここでは見ない。
const std = @import("std");
const ast = @import("ast.zig");

pub const Hit = struct {
    name: []const u8,
    tok: u32,
    kind: Kind,

    pub const Kind = enum { top_level, import_ref, type_param };

    pub fn what(h: Hit) []const u8 {
        return switch (h.kind) {
            .top_level => "a local binding cannot reuse a top-level name (const, func or type)",
            .import_ref => "a local binding cannot reuse an import reference name",
            .type_param => "a type parameter cannot reuse a top-level type name",
        };
    }
};

/// 最初の衝突を返す。無ければ null
pub fn check(pkg: *const ast.Pkg) ?Hit {
    const w: Walker = .{ .pkg = pkg };
    for (pkg.files) |file| {
        for (file.types) |td| if (typeParams(pkg, td.type_params, td.tok)) |h| return h;
        for (file.funcs) |f| {
            if (typeParams(pkg, f.type_params, f.tok)) |h| return h;
            for (f.params) |p| if (w.name(p.name, f.tok)) |h| return h;
            if (w.block(f.body)) |h| return h;
        }
        for (file.consts) |c| if (w.expr(c.expr)) |h| return h;
    }
    return null;
}

fn typeParams(pkg: *const ast.Pkg, names: []const []const u8, tok: u32) ?Hit {
    for (names) |n| if (pkg.hasTypeName(n)) return .{ .name = n, .tok = tok, .kind = .type_param };
    return null;
}

const Walker = struct {
    pkg: *const ast.Pkg,

    fn name(w: Walker, n: []const u8, tok: u32) ?Hit {
        if (w.pkg.hasTopName(n)) return .{ .name = n, .tok = tok, .kind = .top_level };
        if (w.pkg.hasImportName(n)) return .{ .name = n, .tok = tok, .kind = .import_ref };
        return null;
    }

    fn block(w: Walker, b: *const ast.Block) ?Hit {
        for (b.stmts) |s| if (w.stmt(s)) |h| return h;
        return null;
    }

    fn exprs(w: Walker, es: []const *ast.Expr) ?Hit {
        for (es) |e| if (w.expr(e)) |h| return h;
        return null;
    }

    fn stmt(w: Walker, s: ast.Stmt) ?Hit {
        switch (s) {
            .bind => |b| {
                for (b.names) |n| if (w.name(n, b.tok)) |h| return h;
                return w.exprs(b.values);
            },
            .assign => |a| return w.exprs(a.targets) orelse w.exprs(a.values),
            .ret => |r| return w.exprs(r.values),
            .expr => |e| return w.expr(e),
            .while_ => |wl| return w.expr(wl.cond) orelse w.block(wl.body),
            .break_, .continue_ => return null,
            .defer_ => |d| return w.expr(d.expr),
            .yield_ => |y| return w.expr(y.expr),
        }
    }

    fn expr(w: Walker, e: *const ast.Expr) ?Hit {
        switch (e.*) {
            .int, .nil, .ident, .strlit, .mut_arg => return null,
            .binary => |b| return w.expr(b.lhs) orelse w.expr(b.rhs),
            .interp => |it| {
                for (it.tmpl.holes) |h0| if (w.expr(h0)) |h| return h;
                return null;
            },
            .unary => |u| return w.expr(u.operand),
            .call => |c| return w.expr(c.callee) orelse w.exprs(c.args),
            .pipe => |p| {
                if (w.expr(p.lhs) orelse w.expr(p.callee)) |h| return h;
                for (p.args) |a| if (a) |x| if (w.expr(x)) |h| return h;
                return null;
            },
            .index => |i| return w.expr(i.base) orelse w.expr(i.idx),
            .slice3 => |s| return w.expr(s.base) orelse w.expr(s.lo) orelse w.expr(s.hi),
            .slicelit => |s| return w.exprs(s.elems),
            .maplit => |m| {
                for (m.entries) |en| if (w.expr(en.key) orelse w.expr(en.value)) |h| return h;
                return null;
            },
            .composite => |c| {
                for (c.elems) |el| if (w.expr(el.value)) |h| return h;
                return null;
            },
            .selector => |s| return w.expr(s.base),
            .try_ => |t| {
                if (w.expr(t.e)) |h| return h;
                if (t.wrap) |c| for (c.elems) |el| if (w.expr(el.value)) |h| return h;
                return null;
            },
            .lambda => |l| {
                for (l.params) |p| if (w.name(p.name, l.tok)) |h| return h;
                return w.expr(l.body);
            },
            .if_ => |i| {
                if (w.expr(i.cond) orelse w.block(i.then)) |h| return h;
                return if (i.else_) |x| w.expr(x) else null;
            },
            .switch_ => |sw| {
                if (w.exprs(sw.subjects)) |h| return h;
                for (sw.cases) |c| {
                    for (c.patterns) |p| if (w.pattern(p)) |h| return h;
                    if (w.block(c.body)) |h| return h;
                }
                return if (sw.default_) |d| w.block(d) else null;
            },
            .block => |b| return w.block(b),
            .for_ => |f| {
                for (f.gens) |g| {
                    for (g.names) |n| if (w.name(n, g.tok)) |h| return h;
                    if (w.expr(g.src) orelse w.exprs(g.guards)) |h| return h;
                }
                return switch (f.body) {
                    .yield_ => |y| w.expr(y),
                    .block => |b| w.block(b),
                };
            },
        }
    }

    fn pattern(w: Walker, p: ast.Pattern) ?Hit {
        switch (p) {
            // 裸の識別子はトップレベル名なら比較、でなければ束縛 — 衝突は構成的に起きない
            .const_ => |alts| return w.exprs(alts),
            .type_ => |tp| {
                if (tp.bind) |b| if (w.name(b, tp.tok)) |h| return h;
                for (tp.fields) |fp| {
                    if (fp.sub) |sub| {
                        if (w.pattern(sub.*)) |h| return h;
                    } else if (w.name(fp.name, fp.tok)) |h| return h;
                }
                return null;
            },
        }
    }
};
