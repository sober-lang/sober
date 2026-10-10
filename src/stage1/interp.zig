//! 文字列補間 `"a${x}b"` の脱糖（随時回収 R7）。
//!
//! 固定テンプレート（formal.md「脱糖器の規律」— 形の変換だけ）: ast.Template（定数部 n+1 + 穴 n）を左から `+` の連鎖に畳み、
//! 式の断片は型で 3 通りに包む — string はそのまま、int は `strings.Itoa(e)`（std/strings を Sober で書いた
//! もの — コアを増やさない）、bool は `if e { "true" } else { "false" }`。それ以外の型は拒否。
//! 型判定だけが各層（desugar の computeTy / codegen の型表）の持ち物なので、この関数は判定を受け取って
//! 普通の AST を組み、各層はそれを通常どおり処理する。
//! std/strings への参照は、補間を含むファイルに cst_to_ast が予約参照名 `itoa_ref` の import を足して解決する
//! （loader は普通の import として読み込む。`$` は識別子に現れないので利用者の名前と衝突しない）。
const std = @import("std");
const ast = @import("ast.zig");

pub const Kind = enum { string, int, bool };

/// 補間が参照する std package と、その予約参照名
pub const std_pkg = "std/strings";
pub const itoa_ref = "$strings";

pub const Error = error{ BadType, OutOfMemory };

/// classify(ctx, e) は e の型（補間できない型なら null）。BadType のとき bad に問題の式を入れる
pub fn lower(
    a: std.mem.Allocator,
    it: ast.Interp,
    ctx: anytype,
    comptime classify: fn (@TypeOf(ctx), *const ast.Expr) ?Kind,
    bad: *?*const ast.Expr,
) Error!*ast.Expr {
    var acc: ?*ast.Expr = null;
    for (it.tmpl.lits, 0..) |text, k| {
        if (text.len > 0) acc = try append(a, acc, try new(a, .{ .strlit = .{ .value = text, .tok = it.tok } }), it.tok);
        if (k == it.tmpl.holes.len) break;
        const e = it.tmpl.holes[k];
        const piece = switch (classify(ctx, e) orelse {
            bad.* = e;
            return error.BadType;
        }) {
            .string => e,
            .int => try itoaCall(a, e, it.tok),
            .bool => try boolText(a, e, it.tok),
        };
        acc = try append(a, acc, piece, it.tok);
    }
    return acc orelse new(a, .{ .strlit = .{ .value = "", .tok = it.tok } });
}

/// 連鎖の末尾に 1 片足す（空の定数部は足さない — 正規形の空文字列は連結の単位元）
fn append(a: std.mem.Allocator, acc: ?*ast.Expr, piece: *ast.Expr, tok: ast.Pos) !*ast.Expr {
    const l = acc orelse return piece;
    return new(a, .{ .binary = .{ .op = .plus, .lhs = l, .rhs = piece, .tok = tok } });
}

fn new(a: std.mem.Allocator, e: ast.Expr) !*ast.Expr {
    const p = try a.create(ast.Expr);
    p.* = e;
    return p;
}

fn itoaCall(a: std.mem.Allocator, e: *ast.Expr, tok: ast.Pos) !*ast.Expr {
    const base = try new(a, .{ .ident = .{ .name = itoa_ref, .tok = tok } });
    const callee = try new(a, .{ .selector = .{ .base = base, .field = "Itoa", .tok = tok } });
    const args = try a.alloc(*ast.Expr, 1);
    args[0] = e;
    return new(a, .{ .call = .{ .callee = callee, .args = args, .tok = tok } });
}

fn boolText(a: std.mem.Allocator, e: *ast.Expr, tok: ast.Pos) !*ast.Expr {
    const t = try textBlock(a, "true", tok);
    const f = try textBlock(a, "false", tok);
    return new(a, .{ .if_ = .{ .cond = e, .then = t, .else_ = try new(a, .{ .block = f }), .tok = tok } });
}

fn textBlock(a: std.mem.Allocator, text: []const u8, tok: ast.Pos) !*ast.Block {
    const stmts = try a.alloc(ast.Stmt, 1);
    stmts[0] = .{ .expr = try new(a, .{ .strlit = .{ .value = text, .tok = tok } }) };
    const b = try a.create(ast.Block);
    b.* = .{ .stmts = stmts };
    return b;
}
