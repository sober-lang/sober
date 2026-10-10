//! for 式の F1 脱糖（language.md 7 節、V3-4）: 消費点での融合展開。
//! `for x <- src if g yield e` は Iter[T]（= func(func(T))）の引数位置でだけ消費され、
//! その位置で次のラムダに書き換える（1 ノード → 固定テンプレート 1 段。形の変換）:
//!
//!   (yield) => { GEN(src, (x) => { if g { yield(e) } }) }
//!
//! GEN は生成元が slice なら std/iter.Slice（走査ループは std に Sober で書く — 脱糖器はループを合成しない）、
//! 生成元が map なら `iter#.Slice(keys(src), k)`（keysm の段 — キー列のスナップショットの添字ループ。
//! `for k <- m` はキーを挿入順に回す。反復中の m の変更は列に影響しない）、
//! 生成元が Iter の閉包（関数型の引数に束縛された名前）なら src 自身の呼び出し。
//! ブロック形の本体 `{ ...; yield v }` はそのまま k の本体になり、yield 文は `yield(v)` の呼び出しとして読む
//! （desugar / codegen が yield 文を束縛 `yield` の呼び出しとして扱う）。
//! 書き換えは desugar と codegen が同じこの関数を呼ぶ（両層の一致が構成的に出る）
const std = @import("std");
const ast = @import("ast.zig");

/// 暗黙の import の参照名（利用者の識別子と衝突しない — '#' は識別子に現れない）
pub const iter_ref = "iter#";
pub const iter_path = "std/iter";
/// 書き換えたラムダの引数名（キーワードなので利用者の名前と衝突しない）
pub const yield_name = "yield";

/// 断片外なら理由（V3-4 は単一ジェネレータ・単一束縛）
pub fn outOfFragment(fe: *const ast.ForExpr) ?[]const u8 {
    if (fe.gens.len != 1) return "a for expression with several generators (V3-4 covers a single generator)";
    if (fe.gens[0].names.len != 1) return "a generator binding several names (V3-4 covers a single name)";
    return null;
}

/// `yield(v)` の呼び出し式
pub fn yieldCall(a: std.mem.Allocator, v: *ast.Expr, tok: u32) std.mem.Allocator.Error!*ast.Expr {
    const callee = try newExpr(a, .{ .ident = .{ .name = yield_name, .tok = tok } });
    const args = try a.alloc(*ast.Expr, 1);
    args[0] = v;
    return newExpr(a, .{ .call = .{ .callee = callee, .args = args, .tok = tok } });
}

/// 生成元の種類（呼び手が型から決める）
pub const SrcKind = enum { slice, map, closure };

/// for 式 → Iter[T] 型のラムダ（呼び手が outOfFragment を先に確かめる）
pub fn lower(a: std.mem.Allocator, fe: *const ast.ForExpr, kind: SrcKind) std.mem.Allocator.Error!*ast.Expr {
    const g = fe.gens[0];
    // k の本体: ガードを外側から if で包む
    var inner: *ast.Expr = switch (fe.body) {
        .yield_ => |e| try yieldCall(a, e, fe.tok),
        .block => |b| try newExpr(a, .{ .block = b }),
    };
    var i = g.guards.len;
    while (i > 0) {
        i -= 1;
        inner = try newExpr(a, .{ .if_ = .{ .cond = g.guards[i], .then = try blockOf(a, inner), .else_ = null, .tok = g.tok } });
    }
    const k = try lambda(a, g.names[0], inner, g.tok);
    // GEN(src, k)
    const gen_call: *ast.Expr = if (kind == .closure) blk: {
        const args = try a.alloc(*ast.Expr, 1);
        args[0] = k;
        break :blk try newExpr(a, .{ .call = .{ .callee = g.src, .args = args, .tok = g.tok } });
    } else blk: {
        const base = try newExpr(a, .{ .ident = .{ .name = iter_ref, .tok = g.tok } });
        const callee = try newExpr(a, .{ .selector = .{ .base = base, .field = "Slice", .tok = g.tok } });
        const args = try a.alloc(*ast.Expr, 2);
        args[0] = if (kind == .map) try keysCall(a, g.src, g.tok) else g.src;
        args[1] = k;
        break :blk try newExpr(a, .{ .call = .{ .callee = callee, .args = args, .tok = g.tok } });
    };
    return lambda(a, yield_name, gen_call, fe.tok);
}

/// `keys(src)` の呼び出し式
fn keysCall(a: std.mem.Allocator, src: *ast.Expr, tok: u32) std.mem.Allocator.Error!*ast.Expr {
    const callee = try newExpr(a, .{ .ident = .{ .name = "keys", .tok = tok } });
    const args = try a.alloc(*ast.Expr, 1);
    args[0] = src;
    return newExpr(a, .{ .call = .{ .callee = callee, .args = args, .tok = tok } });
}

/// 1 引数・型注釈なし・本体ブロックのラムダ（本体が既にブロックならそのまま）
fn lambda(a: std.mem.Allocator, param: []const u8, body: *ast.Expr, tok: u32) std.mem.Allocator.Error!*ast.Expr {
    const params = try a.alloc(ast.LambdaParam, 1);
    params[0] = .{ .name = param, .type = null };
    const blk = if (body.* == .block) body else try newExpr(a, .{ .block = try blockOf(a, body) });
    return newExpr(a, .{ .lambda = .{ .params = params, .body = blk, .tok = tok } });
}

/// 式 1 つを文位置に置いたブロック（値は捨てる — Iter の要素は yield でだけ出る）
fn blockOf(a: std.mem.Allocator, e: *ast.Expr) std.mem.Allocator.Error!*ast.Block {
    const stmts = try a.alloc(ast.Stmt, 1);
    stmts[0] = .{ .expr = e };
    const b = try a.create(ast.Block);
    b.* = .{ .stmts = stmts };
    return b;
}

fn newExpr(a: std.mem.Allocator, e: ast.Expr) std.mem.Allocator.Error!*ast.Expr {
    const p = try a.create(ast.Expr);
    p.* = e;
    return p;
}
