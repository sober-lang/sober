//! lower の呼び出しの生成方式（B-5）: inline 展開・閉包（ラムダ）・mut 引数・ジェネリクスの単相化・関数値・辞書 const。
//! codegen の inlineCallIn / lambdaCall / makeClosure / genericCall / genericInline / instFunc / liftLambda / fnValue /
//! callIndirect / dictConst と同じ形。
//!
//! - mut_def（再帰する mut 引数の関数 — loader が決める。R2 / K-a）: 展開せず Def として呼ぶ。mut 仮引数は IR の ptr 引数 1 語で、
//!   呼び手のセル（mut ローカル、または自分の mut 仮引数 — 受け取ったアドレスを転送）のアドレスを渡す（lower.emitCall / funcBody）。
//!   anchor は型付けの座標で実行時表現は無い。mut slice への append はヘッダの深度の region に書く既存の規則のまま
//! - inline 展開（関数型か mut の仮引数を持つ関数 = decl.expands）: 呼び出し点に本体を展開する。region は開かない・relocate もしない
//!   （実体の関数との非対称は codegen と同じ）。callee は自分のスコープだけを見る（View の鎖を空にして開く）。
//!   `return` の行き先は RetCtx のスタックの先頭 — inline なら「結果スロットへ書く → 展開範囲の defer → 展開入口の深度へ戻す → 末尾へ br」。
//!   深度を戻すのは codegen との差分: codegen の inlineReturn は戻さず、展開本体の式ブロックの中から return すると
//!   深度が 1 段漏れる（実測: 再帰 600 段で exit 102）。region を閉じるのが言語の意味なので lower は戻す
//! - 閉包: ラムダ本体は定義時に見えていたスコープ + 自分の引数を見る。`return` は定義時の RetCtx へ（囲みの名前付き関数か inline）
//! - 関数値: 名前付き関数の参照・持ち上げたラムダ（関数型フィールドの位置）はコードアドレス 1 語（funcaddr）、呼び出しは call_indirect
const std = @import("std");
const ast = @import("ast.zig");
const ir = @import("ir.zig");
const forexpand = @import("forexpand.zig");
const lower = @import("lower.zig");
const types = @import("lower_types.zig");
const cont = @import("lower_cont.zig");
const Lowerer = lower.Lowerer;
const Error = lower.Error;
const Val = lower.Val;
const Results = lower.Results;
const ArgSrc = lower.ArgSrc;
const FnInfo = lower.FnInfo;
const never_results = lower.never_results;
const Type = types.Type;
const FnType = types.FnType;
const TypeBind = types.TypeBind;

/// 名前の可視範囲: scopes[lo..hi)。hi == open は「スタックの先頭まで」（codegen View）
pub const View = struct {
    lo: usize,
    hi: usize,
    pub const open = std.math.maxInt(usize);
};

/// `return` の行き先: 実体の関数か、展開中の inline 関数
pub const RetCtx = union(enum) { func, inline_: *InlineCtx };

pub const InlineCtx = struct {
    results: []const Type,
    /// 全結果の語を並べたスロット（呼び手はここから読む）
    slot: ir.Value,
    /// 展開範囲の最外スコープ（return はここから内側の defer を展開する）
    base_scope: usize,
    /// 展開入口の深度（return が戻す）
    depth: ir.Value,
    end: ir.BlockId,
};

/// ラムダ引数。定義時の可視範囲と `return` の行き先を閉じ込める（codegen Closure）
pub const Closure = struct {
    lambda: *const ast.Lambda,
    fn_type: *const FnType,
    pkg: *const ast.Pkg,
    chain: []const View,
    ret_ctx: RetCtx,
    /// 定義時に展開中だった inline 関数の列（本体の展開ではこの列に差し替える — ラムダから同じ inline 関数を呼ぶのは再帰ではない）
    inlining_at: []const []const u8,
    type_env: []const TypeBind,
    /// 型だけを取る試し生成の番兵（forIterType）: 呼ばれたら引数の型を記録して値なしで返る
    probe: ?*?Type = null,
};

/// 展開する関数の署名（型は型環境で読み済み）
pub const Sig = struct {
    decl: *const ast.FuncDecl,
    pkg: *const ast.Pkg,
    params: []const Type,
    results: []const Type,
};

// ── 名前の可視範囲 ──

pub fn lookup(self: *Lowerer, name: []const u8) ?lower.Local {
    var v = self.chain.items.len;
    while (v > 0) : (v -= 1) {
        const view = self.chain.items[v - 1];
        var i = @min(view.hi, self.scopes.items.len);
        while (i > view.lo) : (i -= 1) {
            if (self.scopes.items[i - 1].names.get(name)) |l| return l;
        }
    }
    return null;
}

/// 今の鎖を、開いた上限を現在のスコープ数で閉じて複製する（ラムダの定義時の可視範囲）
fn freezeChain(self: *Lowerer) Error![]const View {
    const out = try self.a().alloc(View, self.chain.items.len);
    for (self.chain.items, out) |v, *o| o.* = .{ .lo = v.lo, .hi = @min(v.hi, self.scopes.items.len) };
    return out;
}

/// 展開の文脈（可視範囲・package・型環境・RetCtx・ループの床・inline 列）。enter で差し替え、leave で戻す
const Saved = struct {
    chain: []const View,
    pkg: *const ast.Pkg,
    env: []const TypeBind,
    inlining: []const []const u8,
};

fn enter(self: *Lowerer, views: []const View, pkg: *const ast.Pkg, env: []const TypeBind, ret_ctx: RetCtx, inlining: ?[]const []const u8) Error!Saved {
    const saved: Saved = .{
        .chain = try self.a().dupe(View, self.chain.items),
        .pkg = self.cur_pkg,
        .env = self.type_env,
        .inlining = try self.a().dupe([]const u8, self.inlining.items),
    };
    self.chain.clearRetainingCapacity();
    try self.chain.appendSlice(self.gpa, views);
    try self.chain.append(self.gpa, .{ .lo = self.scopes.items.len, .hi = View.open });
    self.cur_pkg = pkg;
    self.type_env = env;
    try self.ret_ctxs.append(self.gpa, ret_ctx);
    try self.loop_floors.append(self.gpa, self.loops.items.len);
    if (inlining) |xs| {
        self.inlining.clearRetainingCapacity();
        try self.inlining.appendSlice(self.gpa, xs);
    }
    return saved;
}

fn leave(self: *Lowerer, s: Saved) Error!void {
    self.chain.clearRetainingCapacity();
    try self.chain.appendSlice(self.gpa, s.chain);
    self.cur_pkg = s.pkg;
    self.type_env = s.env;
    _ = self.ret_ctxs.pop();
    _ = self.loop_floors.pop();
    self.inlining.clearRetainingCapacity();
    try self.inlining.appendSlice(self.gpa, s.inlining);
}

// ── inline 展開 ──

/// mut 引数の実引数: 呼び手の mut ローカル `mut x` のスロットそのもの（別名 — codegen mutArgSlot）
pub fn mutArgCell(self: *Lowerer, src: ArgSrc, tok: ast.Pos) Error!lower.Local {
    const e = switch (src) {
        .expr => |e| e,
        .val => return self.fail(error.TypeMismatch, tok, "a mut parameter takes `mut x` (a mut local) at the call site"),
    };
    if (e.* != .mut_arg) return self.fail(error.TypeMismatch, tok, "a mut parameter takes `mut x` (a mut local) at the call site");
    const l = lookup(self, e.mut_arg.name) orelse return self.fail(error.UndefinedName, e.mut_arg.tok, e.mut_arg.name);
    if (l != .cell) return self.fail(error.Immutable, e.mut_arg.tok, "`mut x` needs a mut local");
    return l;
}

/// 関数型の引数位置に書ける形: ラムダ（閉包にする）・for 式・閉包に束縛された名前（転送。型は一致が要る）
pub fn closureArg(self: *Lowerer, src: ArgSrc, want: *const FnType, tok: ast.Pos) Error!*const Closure {
    if (src == .expr) switch (src.expr.*) {
        .lambda => |*lam| return makeClosure(self, lam, want),
        .for_ => |*fe| {
            const lowered = try lowerFor(self, fe);
            return makeClosure(self, &lowered.lambda, want);
        },
        .ident => |id| if (lookup(self, id.name)) |l| if (l == .closure) {
            if (!l.closure.fn_type.eql(want)) return self.fail(error.TypeMismatch, tok, "function-typed argument type differs from the parameter");
            return l.closure;
        },
        else => {},
    };
    return self.fail(error.TypeMismatch, tok, "expected a lambda for a function-typed parameter");
}

/// for 式 → Iter[T] 型のラムダ（forexpand.zig — desugar / codegen と同じ書き換え）
pub fn lowerFor(self: *Lowerer, fe: *const ast.ForExpr) Error!*ast.Expr {
    if (forexpand.outOfFragment(fe)) |what| return self.fail(error.Unsupported, fe.tok, what);
    const src = fe.gens[0].src;
    const is_closure = src.* == .ident and if (lookup(self, src.ident.name)) |l| l == .closure else false;
    if (is_closure) return forexpand.lower(self.a(), fe, .closure);
    // map の生成元はキーを回す（keysm の段）。型は試し生成で取り、IR は巻き戻す（forIterType と同じ方式）
    const mk = try self.b.mark();
    const probe = try self.expr(src);
    self.b.rollback(mk);
    return forexpand.lower(self.a(), fe, if (probe.t == .map_) .map else .slice);
}

fn makeClosure(self: *Lowerer, lam: *const ast.Lambda, ft: *const FnType) Error!*const Closure {
    if (lam.params.len != ft.params.len) return self.fail(error.ArityMismatch, lam.tok, "lambda parameter count differs from the function type");
    for (lam.params, ft.params) |p, want| if (p.type) |te| {
        if (!(try self.resolveType(te, lam.tok)).eql(want)) return self.fail(error.TypeMismatch, lam.tok, "lambda parameter type differs from the function type");
    };
    const c = try self.a().create(Closure);
    c.* = .{
        .lambda = lam,
        .fn_type = ft,
        .pkg = self.cur_pkg,
        .chain = try freezeChain(self),
        .ret_ctx = self.ret_ctxs.items[self.ret_ctxs.items.len - 1],
        .inlining_at = try self.a().dupe([]const u8, self.inlining.items),
        .type_env = self.type_env,
    };
    return c;
}

/// 関数型か mut の仮引数を持つ関数の呼び出し: 引数を呼び手の文脈で束縛し、callee 本体を新しい可視範囲で展開する。
/// body_env: ジェネリック inline の型環境（null なら呼び手の型環境のまま — codegen inlineCallIn）
pub fn inlineCall(self: *Lowerer, sig: Sig, srcs: []const ArgSrc, tok: ast.Pos, body_env: ?[]const TypeBind) Error!Results {
    const decl = sig.decl;
    for (self.inlining.items) |n| if (std.mem.eql(u8, n, decl.name))
        return self.fail(error.Unsupported, tok, "recursive function expanded at the call site (a function-typed or mut parameter)");
    if (srcs.len != sig.params.len) return self.fail(error.ArityMismatch, tok, decl.name);
    // 引数（mut は呼び手のセルの別名、関数型は閉包、他は評価してコピー）
    const binds = try self.a().alloc(lower.Local, srcs.len);
    for (srcs, sig.params, decl.params, binds) |src, want, p, *bnd| {
        if (p.mutable) {
            const l = try mutArgCell(self, src, tok);
            if (!l.cell.t.eql(want)) return self.fail(error.TypeMismatch, tok, "mut argument type differs from the parameter");
            bnd.* = l;
        } else if (want == .func_) {
            bnd.* = .{ .closure = try closureArg(self, src, want.func_, tok) };
        } else {
            const v = try self.argVal(src, want, tok);
            if (v.t == .never) return never_results;
            bnd.* = .{ .val = try self.copyVal(v) };
        }
    }
    var total: u32 = 0;
    for (sig.results) |t| total += t.words();
    var ctx: InlineCtx = .{
        .results = sig.results,
        .slot = try self.b.slotaddr(try self.b.newSlot(@max(total, 1))),
        .base_scope = self.scopes.items.len,
        .depth = try self.b.regionDepth(),
        .end = try self.b.newBlock(),
    };
    const saved = try enter(self, &.{}, sig.pkg, body_env orelse self.type_env, .{ .inline_ = &ctx }, null);
    try self.inlining.append(self.gpa, decl.name);
    try self.pushScope();
    for (decl.params, binds) |p, bnd| try self.declareNew(p.name, bnd, tok);
    try self.stmts(decl.body.stmts);
    if (self.b.cur != null) {
        if (sig.results.len != 0) return self.fail(error.MissingReturn, decl.tok, decl.name);
        try self.runDefers(ctx.base_scope);
        if (self.b.cur != null) try self.b.br(ctx.end, &.{});
    }
    self.popScope();
    try leave(self, saved);
    if (self.b.block(ctx.end).preds == 0) {
        self.b.cur = null;
        return never_results;
    }
    self.b.cur = ctx.end;
    const out = try self.a().alloc(Val, sig.results.len);
    var off: u32 = 0;
    for (sig.results, out) |t, *v| {
        v.* = try self.loadVal(ctx.slot, off, t);
        off += t.words();
    }
    return out;
}

/// inline 展開中の `return` / `?` のエラー側の後半: 展開範囲の defer → 結果の境界コピー → 展開入口の深度 → 末尾へ（値は書き済み）。
/// 境界コピー（Lean の relocTo k、k = 呼び出し点の最内）: 結果スロットの値のうち、ヘッダの深度が
/// 呼び出し点の深度より深いもの（展開本体の式ブロックで作ったコンテナ）を呼び出し点の最内 region へ中身ごと写す。
/// 写さないと深度を戻した後の確保に上書きされる（inline は region を開かないが、本体の式ブロックは開く）
pub fn inlineExit(self: *Lowerer, ctx: *const InlineCtx, tok: ast.Pos) Error!void {
    try self.runDefers(ctx.base_scope);
    if (self.b.cur == null) return;
    var off: u32 = 0;
    for (ctx.results) |t| {
        try cont.relocateTo(self, ctx.slot, off, t, ctx.depth, tok);
        off += t.words();
    }
    try self.b.regionSetDepth(ctx.depth);
    try self.b.br(ctx.end, &.{});
}

/// for 式の型 = Iter[T]（func(func(T))）。T は yield の値の型で、書き換えたラムダの本体を試し生成して取る
/// （`yield` を番兵の閉包に束縛し、生成した IR は Builder.rollback で巻き戻す — codegen forIterType と同じ方式）。
/// 推論に使うのは生成元が slice のときだけ（desugar と同じ線）— 閉包の生成元なら null。
/// 試し生成が IR の外に残すもの（登録された関数・rodata の文字列）は本番の生成でも同じものが要るので無害
fn forIterType(self: *Lowerer, fe: *const ast.ForExpr) Error!?Type {
    const src = fe.gens[0].src;
    if (src.* == .ident) if (lookup(self, src.ident.name)) |l| if (l == .closure) return null;
    const lowered = try lowerFor(self, fe);
    var seen: ?Type = null;
    const dummy = try self.a().create(FnType);
    dummy.* = .{ .params = &.{}, .results = &.{} };
    const probe = try self.a().create(Closure);
    probe.* = .{ .lambda = &lowered.lambda, .fn_type = dummy, .pkg = self.cur_pkg, .chain = &.{}, .ret_ctx = self.ret_ctxs.items[self.ret_ctxs.items.len - 1], .inlining_at = &.{}, .type_env = self.type_env, .probe = &seen };
    const mk = try self.b.mark();
    try self.pushScope();
    try self.declare(forexpand.yield_name, .{ .closure = probe });
    _ = try self.expr(lowered.lambda.body);
    self.popScope();
    self.b.rollback(mk);
    const y = seen orelse return null;
    const kp = try self.a().alloc(Type, 1);
    kp[0] = y;
    const k = try self.a().create(FnType);
    k.* = .{ .params = kp, .results = &.{} };
    const ip = try self.a().alloc(Type, 1);
    ip[0] = .{ .func_ = k };
    const it = try self.a().create(FnType);
    it.* = .{ .params = ip, .results = &.{} };
    return .{ .func_ = it };
}

/// ラムダの呼び出し: 引数を評価して束縛し、定義時の可視範囲 + 引数スコープで本体を展開する（codegen lambdaCall）
pub fn lambdaCall(self: *Lowerer, c: *const Closure, srcs: []const ArgSrc, tok: ast.Pos) Error!Results {
    if (c.probe) |seen| {
        if (srcs.len != 1) return self.fail(error.ArityMismatch, tok, "yield takes one value");
        const v = switch (srcs[0]) {
            .expr => |e| try self.expr(e),
            .val => |x| x,
        };
        if (v.t == .never) return never_results;
        if (seen.*) |prev| {
            if (!prev.eql(v.t)) return self.fail(error.TypeMismatch, tok, "yield values of different types");
        } else seen.* = v.t;
        return &.{};
    }
    const ft = c.fn_type;
    if (srcs.len != ft.params.len) return self.fail(error.ArityMismatch, tok, "lambda argument count");
    if (ft.results.len >= 2) return self.fail(error.Unsupported, tok, "lambda with multiple results");
    const binds = try self.a().alloc(lower.Local, srcs.len);
    for (srcs, ft.params, binds) |src, want, *bnd| {
        // 関数型の引数は閉包のまま束縛する（高階の展開 — Iter）
        if (want == .func_) {
            bnd.* = .{ .closure = try closureArg(self, src, want.func_, tok) };
            continue;
        }
        const v = try self.argVal(src, want, tok);
        if (v.t == .never) return never_results;
        bnd.* = .{ .val = try self.copyVal(v) };
    }
    const saved = try enter(self, c.chain, c.pkg, c.type_env, c.ret_ctx, c.inlining_at);
    try self.pushScope();
    for (c.lambda.params, binds) |p, bnd| try self.declareNew(p.name, bnd, tok);
    const body = c.lambda.body;
    // 本体が呼び出し / パイプなら値なしも許す（codegen callValue(allow_none)）
    var v: Val = if (body.* == .call or body.* == .pipe) blk: {
        const r = try self.evalMulti(body);
        if (lower.isNever(r)) break :blk Val.never;
        if (r.len > 1) return self.fail(error.ResultCountMismatch, tok, "multi-value call used as a single value");
        break :blk if (r.len == 0) Val.none else r[0];
    } else try self.expr(body);
    if (v.t != .never) {
        try self.runDefers(self.scopes.items.len - 1);
        if (self.b.cur == null) v = Val.never;
    }
    self.popScope();
    try leave(self, saved);
    if (v.t == .never) return never_results;
    if (ft.results.len == 0) return &.{};
    if (!v.t.eql(ft.results[0])) return self.fail(error.TypeMismatch, c.lambda.tok, "lambda body type differs from the function type result");
    const out = try self.a().alloc(Val, 1);
    out[0] = v;
    return out;
}

// ── `?`（error の伝播） ──

fn isErrOpt(self: *Lowerer, t: Type) bool {
    return t == .opt and types.isErr(self, t.opt.payload);
}

/// 後置 `?`（codegen tryResults）: 呼び出しの最後の結果 error? のタグが非 0 なら、囲み（return と同じ行き先）の結果へ
/// ゼロ値 + err（`? L{…}` なら包み替え）を書いて出口の後半（関数なら defer → relocate → 深度復元 → ret、inline なら末尾）へ。
/// 0 なら残りの結果を返す。desugar の S1 と同じ順: 呼び出し → 判定 → 値確定 → defer → 脱出
pub fn tryResults(self: *Lowerer, t: ast.Try) Error!Results {
    if (t.e.* != .call) return self.fail(error.Unsupported, t.tok, "? applies to a function call");
    const top = self.ret_ctxs.items[self.ret_ctxs.items.len - 1];
    const rts = switch (top) {
        .func => self.info.results,
        .inline_ => |ctx| ctx.results,
    };
    const n = rts.len;
    if (n == 0 or !isErrOpt(self, rts[n - 1]))
        return self.fail(error.TypeMismatch, t.tok, "? needs the enclosing function to return error? as its last result");
    for (rts[0 .. n - 1]) |rt| self.requireZero(rt, t.tok) catch
        return self.fail(error.TypeMismatch, t.tok, "? needs zero values for the other results of the enclosing function (not a function value or union)");
    const r = try self.evalMulti(t.e);
    if (lower.isNever(r)) return r;
    const k = r.len;
    if (k == 0 or !isErrOpt(self, r[k - 1].t)) return self.fail(error.TypeMismatch, t.tok, "? needs a call whose last result is error?");
    const errv = r[k - 1];
    const err_b = try self.b.newBlock();
    const ok_b = try self.b.newBlock();
    try self.b.condbr(try self.b.cmp(.ne, try self.b.load(errv.v, 0), try self.b.iconst(0)), err_b, &.{}, ok_b, &.{});
    // エラー側: ゼロ値（語を 0 埋め → slice / map は空ヘッダ）+ err を結果の置き場へ（関数の結果は error? を含むので常に sret）
    self.b.cur = err_b;
    const dst = switch (top) {
        .func => self.sret_ptr,
        .inline_ => |ctx| ctx.slot,
    };
    var off: u32 = 0;
    const zero = try self.b.iconst(0);
    for (rts[0 .. n - 1]) |rt| {
        for (0..rt.words()) |w| try self.b.store(dst, @intCast(off + w), zero);
        try cont.zeroFill(self, dst, off, rt);
        off += rt.words();
    }
    if (t.wrap) |w| {
        // 包み替え（K1'' — Lean・desugar と同じ）: 内側の error (top, 鎖) から (W{…}, append(鎖, top)) を作る。
        // 鎖の append は imm（最内 region へ全コピー + 1 セル）。フィールドはエラーの経路でだけ評価する
        const vr = self.variants.get(try self.resolveName(w.type_name, w.tok));
        if (vr == null or vr.?.u != self.errors) return self.fail(error.TypeMismatch, w.tok, "an error wrap `? L{...}` needs an error label");
        const wv = try self.composite(w.*);
        if (wv.t == .never) return never_results;
        const ev = try self.labelToErr(wv);
        try cont.chainPush(self, try self.fieldPtr(ev.v, wv.t.words()), errv.v, 1, wv.t);
        try self.storeVal(dst, off, try self.coerce(ev, rts[n - 1], w.tok));
    } else try self.storeVal(dst, off, errv);
    switch (top) {
        .func => try self.funcExit(null, t.tok),
        .inline_ => |ctx| try inlineExit(self, ctx, t.tok),
    }
    self.b.cur = ok_b;
    return r[0 .. k - 1];
}

// ── ジェネリクス ──

/// ジェネリック関数のインスタンス（単相コピー）。キー = "pkg.name[型…]"、本体は作業列で下ろす（codegen instFunc）
pub fn instFunc(self: *Lowerer, pkg: *const ast.Pkg, decl: *const ast.FuncDecl, targs: []const Type) Error!*FnInfo {
    const k = try types.instKey(self, try self.key(pkg.path, decl.name), targs);
    if (self.funcs.get(k)) |fi| return fi;
    return self.newFunc(k, decl, pkg, try types.bindsOf(self, decl.type_params, targs));
}

/// 型引数の束縛を集める（明示 `f[T](...)` は第 1 型パラメータ）。vals[i] は値の仮引数の評価済みの値（他は null）
/// value_ok: 展開されるジェネリックは値の型（string / slice / map を含む）を型引数に取れる（R1 — codegen tyArgValueOk）。
/// Def として呼ぶジェネリックは tyArgOk のまま（region を持たない）
fn inferTypeArgs(self: *Lowerer, pkg: *const ast.Pkg, decl: *const ast.FuncDecl, explicit: ?ast.TypeExpr, vals: []const ?Type, tok: ast.Pos, value_ok: bool) Error![]const Type {
    const binds = try self.a().alloc(?Type, decl.type_params.len);
    @memset(binds, null);
    if (explicit) |te| {
        if (decl.type_params.len != 1) return self.fail(error.ArityMismatch, tok, "explicit type arguments (only f[T](...) with one type parameter)");
        binds[0] = try self.resolveType(te, tok);
    }
    {
        const saved_pkg = self.cur_pkg;
        defer self.cur_pkg = saved_pkg;
        self.cur_pkg = pkg;
        for (decl.params, vals) |p, v| if (v) |t| try types.unify(self, p.type, t, decl.type_params, binds, tok);
    }
    const targs = try self.a().alloc(Type, binds.len);
    for (binds, targs, 0..) |bnd, *t, i| {
        t.* = bnd orelse {
            const msg = try std.fmt.allocPrint(self.a(), "cannot infer type parameter {s} of {s}; write {s}[{s}](...)", .{ decl.type_params[i], decl.name, decl.name, decl.type_params[i] });
            return self.fail(error.TypeMismatch, tok, msg);
        };
        if (value_ok) {
            if (!types.tyArgValueOk(t.*)) return self.fail(error.TypeMismatch, tok, "a type argument must be a value type");
        } else if (!types.tyArgOk(t.*)) return self.fail(error.TypeMismatch, tok, "a type argument of a generic function called as a Def cannot contain regions or channels (V3-2; inline-expanded generics and generic structs may — R1)");
    }
    return targs;
}

/// ジェネリック関数の呼び出し: 引数を左から評価して退避 → 型引数を推論（明示があればそれを優先）→ インスタンスを呼ぶ（codegen genericCall）
pub fn genericCall(self: *Lowerer, pkg: *const ast.Pkg, decl: *const ast.FuncDecl, explicit: ?ast.TypeExpr, srcs: []const ArgSrc, tok: ast.Pos) Error!Results {
    if (decl.expands) return genericInline(self, pkg, decl, explicit, srcs, tok);
    if (decl.params.len != srcs.len) return self.fail(error.ArityMismatch, tok, decl.name);
    const vsrcs = try self.a().alloc(ArgSrc, srcs.len);
    const vts = try self.a().alloc(?Type, srcs.len);
    for (decl.params, srcs, vsrcs, vts) |p, src, *o, *t| {
        // mut 仮引数（mut_def — R2）: 実引数は呼び手のセルのまま渡す（評価してコピーしない）
        if (p.mutable) {
            t.* = (try mutArgCell(self, src, tok)).cell.t;
            o.* = src;
            continue;
        }
        var v = switch (src) {
            .expr => |e| try self.expr(e),
            .val => |x| x,
        };
        if (v.t == .never) return never_results;
        v = try self.copyVal(v);
        t.* = v.t;
        o.* = .{ .val = v };
    }
    const fi = try instFunc(self, pkg, decl, try inferTypeArgs(self, pkg, decl, explicit, vts, tok, false));
    return self.callDirect(fi, vsrcs, tok);
}

/// ジェネリックかつ関数型 / mut の仮引数を持つ関数: 値の引数を先に評価して単一化し、閉包は型引数が決まってから作る。
/// 本体は束縛した型環境で展開する（codegen genericInline）
fn genericInline(self: *Lowerer, pkg: *const ast.Pkg, decl: *const ast.FuncDecl, explicit: ?ast.TypeExpr, srcs: []const ArgSrc, tok: ast.Pos) Error!Results {
    if (decl.params.len != srcs.len) return self.fail(error.ArityMismatch, tok, decl.name);
    const out_srcs = try self.a().alloc(ArgSrc, srcs.len);
    const vts = try self.a().alloc(?Type, srcs.len);
    for (decl.params, srcs, out_srcs, vts) |p, src, *o, *t| {
        o.* = src;
        t.* = null;
        if (p.mutable) {
            t.* = (try mutArgCell(self, src, tok)).cell.t;
        } else if (p.type == .func) {
            // for 式は Iter[T] の型を試し生成で取って単一化に使う
            if (src == .expr and src.expr.* == .for_) t.* = try forIterType(self, &src.expr.for_);
        } else {
            var v = switch (src) {
                .expr => |e| try self.expr(e),
                .val => |x| x,
            };
            if (v.t == .never) return never_results;
            v = try self.copyVal(v);
            o.* = .{ .val = v };
            t.* = v.t;
        }
    }
    const targs = try inferTypeArgs(self, pkg, decl, explicit, vts, tok, true);
    const env = try types.bindsOf(self, decl.type_params, targs);
    const sig = try sigIn(self, decl, pkg, env);
    return inlineCall(self, sig, out_srcs, tok, env);
}

/// decl の署名を pkg の文脈・型環境 env で読む
pub fn sigIn(self: *Lowerer, decl: *const ast.FuncDecl, pkg: *const ast.Pkg, env: []const TypeBind) Error!Sig {
    const saved_pkg = self.cur_pkg;
    const saved_env = self.type_env;
    defer {
        self.cur_pkg = saved_pkg;
        self.type_env = saved_env;
    }
    self.cur_pkg = pkg;
    self.type_env = env;
    const params = try self.a().alloc(Type, decl.params.len);
    for (decl.params, params) |p, *t| t.* = try self.resolveType(p.type, decl.tok);
    const results = try self.a().alloc(Type, decl.results.len);
    for (decl.results, results) |r, *t| {
        t.* = try self.resolveType(r, decl.tok);
        if (t.* == .func_) return self.fail(error.Unsupported, decl.tok, "function-typed result");
    }
    return .{ .decl = decl, .pkg = pkg, .params = params, .results = results };
}

// ── 関数値 ──

/// 名前付き関数の参照 = 関数値（codegen fnValue）。展開される関数は値にならない
pub fn fnValue(self: *Lowerer, fi: *const FnInfo) Error!Val {
    const ft = try self.a().create(FnType);
    ft.* = .{ .params = fi.params, .results = fi.results };
    return .{ .t = .{ .fnv = ft }, .v = try self.b.funcaddr(fi.id) };
}

/// 関数値が期待される位置（struct の関数型フィールド）のラムダ → 匿名関数（作業列で下ろす）のコードアドレス（codegen liftLambda）。
/// 本体の値は合成した return。外側のローカルは見えない（別の関数として下ろす）— 参照は捕捉として Unsupported（codegen と同じ診断）
pub fn liftLambda(self: *Lowerer, lam: *const ast.Lambda, ft: *const FnType, tok: ast.Pos) Error!Val {
    if (lam.params.len != ft.params.len) return self.fail(error.ArityMismatch, tok, "lambda parameter count differs from the function type");
    for (lam.params, ft.params) |lp, want| if (lp.type) |te| {
        if (!(try self.resolveType(te, tok)).eql(want)) return self.fail(error.TypeMismatch, tok, "lambda parameter type differs from the function type");
    };
    // 辞書 const のラムダは単相・文脈固定なので、参照点が何箇所でも匿名関数は 1 本
    if (self.in_dict_const) if (self.dict_lifts.get(lam)) |id| return .{ .t = .{ .fnv = ft }, .v = try self.b.funcaddr(id) };
    const params = try self.a().alloc(ast.Param, lam.params.len);
    for (lam.params, params) |lp, *p| p.* = .{ .name = lp.name, .type = .{ .name = "_" } };
    const stmts = try self.a().alloc(ast.Stmt, 1);
    const vals = try self.a().alloc(*ast.Expr, 1);
    vals[0] = lam.body;
    stmts[0] = if (ft.results.len == 0) .{ .expr = lam.body } else .{ .ret = .{ .values = vals, .tok = lam.tok } };
    const body = try self.a().create(ast.Block);
    body.* = .{ .stmts = stmts };
    const decl = try self.a().create(ast.FuncDecl);
    decl.* = .{ .name = "lambda", .params = params, .results = &.{}, .body = body, .expands = false, .tok = lam.tok };
    const k = try std.fmt.allocPrint(self.a(), "lambda#{d}", .{self.lambda_seq});
    self.lambda_seq += 1;
    const fi = try self.newFuncSig(k, decl, self.cur_pkg, self.type_env, ft.params, ft.results);
    fi.synth_ret = vals.ptr;
    // 外側のローカル名（捕捉の診断用）。辞書 const の中は可視範囲が空（codegen と同じく全スコープの名前 — 鎖で絞らない）
    if (!self.in_dict_const) {
        var outer: std.ArrayListUnmanaged([]const u8) = .empty;
        for (self.scopes.items) |sc| {
            var it = sc.names.keyIterator();
            while (it.next()) |n| try outer.append(self.a(), n.*);
        }
        fi.lift_outer = outer.items;
    }
    if (self.in_dict_const) try self.dict_lifts.put(self.gpa, lam, fi.id);
    return .{ .t = .{ .fnv = ft }, .v = try self.b.funcaddr(fi.id) };
}

/// 辞書 const の参照点での展開: 宣言側の文脈（package・空の可視範囲・空の型環境）で struct リテラルを作り直す（codegen dictConst）
pub fn dictConst(self: *Lowerer, c: *const ast.ConstDecl, pkg: *const ast.Pkg) Error!Val {
    const saved_chain = try self.a().dupe(View, self.chain.items);
    const saved_pkg = self.cur_pkg;
    const saved_env = self.type_env;
    const saved_in = self.in_dict_const;
    self.chain.clearRetainingCapacity();
    try self.chain.append(self.gpa, .{ .lo = self.scopes.items.len, .hi = View.open });
    self.cur_pkg = pkg;
    self.type_env = &.{};
    self.in_dict_const = true;
    defer {
        self.chain.clearRetainingCapacity();
        self.chain.appendSliceAssumeCapacity(saved_chain);
        self.cur_pkg = saved_pkg;
        self.type_env = saved_env;
        self.in_dict_const = saved_in;
    }
    return self.expr(c.expr);
}
