//! AST → 独自 SSA IR（ir.zig）。codegen.zig（AST 直吐き）の後継 — codegen は並走の後 B-9b で退役した。
//! このファイル群のコメントの「codegen の X と同じ」は移植元の出典（退役前の src/codegen.zig — git 履歴で引ける）。
//!
//! 意味は codegen と同じ（言語の意味は docs/language.md が正）。
//! 下ろし方の対応: codegen の「rax の値」→ SSA 値、mut ローカル → スロット（-O0 形。B-7 の mem2reg で持ち上げる）、
//! 関数の region（入口の深度退避 + region.enter、出口で深度復元）は codegen の funcDeclAt と同じ位置。
//! region 境界は式位置の `{ }` だけ（if / switch の腕・while 本体は透過 — codegen の armBlock / blockExpr と同じ）。
//! 脱出（return / break / continue）は出口ごとに「値確定 → defer 展開 → br」を吐く（codegen の runDefers と同じ位置）。
//!
//! アグリゲート（struct / union / T?）: メモリ形は codegen と同一（union / opt = 語 0 タグ + 最大ペイロード）。
//! 式の値はアドレス（ptr）で、束縛・格納・引数渡しでコピーする（codegen の「struct はアドレスが rax」と同じ）。
//! 引数は語に展開したスカラーの列で渡し、callee が入口で自分のスロットへ写す。
//! 結果は int / bool 1 個なら ret、それ以外（多値・アグリゲート）は sret: 呼び手が全結果の語数ぶんのスロットを取り、
//! そのアドレスを第 0 引数で渡す。
//!
//! slice / string / map（B-4）: ヘッダ 3 語 (ptr, len, 深度) のアグリゲートで、セルは region アリーナ（lower_cont.zig）。
//! 結果の slice / map は defer の後・深度復元の前に呼び手の region へ写す（region.relocate — codegen epilogue と同じ順）。
//!
//! 範囲（B-4）: int / bool / struct / union / error / T? / slice / string / map、関数、if（flow typing 込み）/ switch（定数・束縛・`_`・
//! 型パターン・subject 無し・多値 subject）、束縛・分解・代入（フィールド・並行・複合・要素）、while / break / continue / defer、return、
//! pipe、composite リテラル（位置・名前・ゼロ値）、slice / map リテラル、添字・部分列、len / bytes / freeze / delete / append、
//! string の比較・連結・補間、nil と暗黙 some（期待型のある sink）、演算子、トップレベル int const、println(int / bool / string)。
//! B-5: inline 展開（関数型 / mut の仮引数）・閉包・ジェネリクスの単相化（関数と struct）・関数値（funcaddr / call_indirect）・
//! 持ち上げたラムダ・辞書 const・for 式（Iter — T は試し生成 + Builder.rollback で推論）・後置 `?`（lower_inline.zig — 名前は
//! View の鎖で引き、return は RetCtx のスタックへ）、std 専用の io 組み込み（lower_cont.zig → ir_rt_io.zig）。
//! 範囲外は error.Unsupported。関数は main.main から呼ばれるものだけ下ろす（未対応の std を踏まない）。
//! ファイル: 型表・レイアウト・型式の解決・単一化は lower_types.zig、switch とパターン照合は lower_switch.zig、コンテナは lower_cont.zig、
//! 呼び出しの生成方式は lower_inline.zig（`*Lowerer` を取る自由関数。本体からは転送メソッドで呼ぶ）。
const std = @import("std");
const ast = @import("ast.zig");
const Token = @import("token.zig");
const ir = @import("ir.zig");
const ir_rt = @import("ir_rt.zig");

pub const Error = error{
    Unsupported,
    UndefinedName,
    UndefinedFunction,
    UndefinedType,
    UndefinedField,
    TypeMismatch,
    ArityMismatch,
    ResultCountMismatch,
    HoleCountMismatch,
    PatternCountMismatch,
    Immutable,
    NotAssignable,
    OutsideLoop,
    MissingMain,
    MissingReturn,
    Redeclared,
    Unexported,
} || std.mem.Allocator.Error;

pub const Diag = struct {
    pos: ast.Pos = 0,
    what: []const u8 = "",
    buf: [128]u8 = undefined,
};

/// 呼び手が deinit する
pub fn lower(gpa: std.mem.Allocator, prog: *const ast.Program, diag: *Diag) Error!ir.Module {
    return lowerOpts(gpa, prog, diag, .{});
}

pub const Options = struct {
    /// exit 時に深度別の割り当て総量を stderr へ（ir_rt.buildMemTrace — codegen の --mem-trace の後継）
    mem_trace: bool = false,
};

pub fn lowerOpts(gpa: std.mem.Allocator, prog: *const ast.Program, diag: *Diag, opts: Options) Error!ir.Module {
    var m = ir.Module.init(gpa);
    errdefer m.deinit();
    var l: Lowerer = .{ .gpa = gpa, .m = &m, .prog = prog, .diag = diag, .rt = try ir_rt.install(&m, opts.mem_trace) };
    defer l.deinit();
    try l.program();
    try checkUnreached(gpa, prog, diag);
    return m;
}

/// main から届かない関数の本体も検査する（B-9a — codegen は全関数を下ろすので未使用関数の誤りも拒否する。受理範囲を揃える）。
/// 使い捨てのモジュールに全関数（展開される関数・ジェネリック関数を除く — codegen と同じ範囲）を下ろして捨てる。
/// 本番のモジュールには何も足さない（出力の IR / ELF は main から届く関数だけのまま）
fn checkUnreached(gpa: std.mem.Allocator, prog: *const ast.Program, diag: *Diag) Error!void {
    var m = ir.Module.init(gpa);
    defer m.deinit();
    var l: Lowerer = .{ .gpa = gpa, .m = &m, .prog = prog, .diag = diag, .rt = try ir_rt.install(&m, false) };
    defer l.deinit();
    try types.registerTypes(&l);
    for (prog.pkgs) |pkg| for (pkg.files) |file| for (file.funcs) |f| {
        if (f.expands or f.type_params.len > 0) continue;
        _ = try l.funcByKey(pkg, f.name);
        while (l.work.pop()) |fi| try l.funcBody(fi);
    };
}

const types = @import("lower_types.zig");
const lower_switch = @import("lower_switch.zig");
const cont = @import("lower_cont.zig");
const interp = @import("interp.zig");
const forexpand = @import("forexpand.zig");
const Type = types.Type;
const FieldInfo = types.FieldInfo;
const findField = types.findField;
const StructInfo = types.StructInfo;
const UnionInfo = types.UnionInfo;
const VariantRef = types.VariantRef;
const OptInfo = types.OptInfo;
const FnType = types.FnType;
const TypeBind = types.TypeBind;
const baseName = types.baseName;
const inl = @import("lower_inline.zig");

pub const Val = struct {
    t: Type,
    /// スカラーは値、アグリゲートはアドレス
    v: ir.Value = undefined,

    pub const none: Val = .{ .t = .none };
    pub const never: Val = .{ .t = .never };
};

/// 多値を許す評価の結果。到達しないときは [never] 1 つ
pub const Results = []const Val;
pub const never_results: Results = &.{Val.never};

pub fn isNever(r: Results) bool {
    return r.len == 1 and r[0].t == .never;
}

/// 呼び出しの実引数: 式か、評価済みの値（pipe の左辺）
pub const ArgSrc = union(enum) {
    expr: *const ast.Expr,
    val: Val,
};

pub const FnInfo = struct {
    decl: *const ast.FuncDecl,
    pkg: *const ast.Pkg,
    id: ir.FuncId,
    params: []const Type,
    results: []const Type,
    /// ジェネリックの単相コピーの型環境（他は空）
    env: []const TypeBind = &.{},
    /// 持ち上げたラムダの合成 return の値列（利用者が書いた return と区別する — codegen lift_ret）
    synth_ret: ?[*]const *ast.Expr = null,
    /// 持ち上げたラムダ: 持ち上げた点で見えていた外側のローカル名（捕捉の診断用 — codegen lift_outer）
    lift_outer: []const []const u8 = &.{},

    /// int / bool / 関数値 1 個以外は sret（IR の第 0 引数が結果スロットのアドレス）
    pub fn sret(self: *const FnInfo) bool {
        return types.sretOf(self.results);
    }
};

/// decl の i 番目の仮引数が mut か（mut_def の関数だけが Def として mut 仮引数を持つ — 他の mut 関数は展開される）
pub fn isMutParam(decl: *const ast.FuncDecl, i: usize) bool {
    return i < decl.params.len and decl.params[i].mutable;
}

/// 名前の実体: 不変束縛は値、mut ローカルはスロット（p はそのアドレス）、関数型の仮引数は閉包（inline 展開 — 値ではない）
pub const Local = union(enum) {
    val: Val,
    cell: struct { t: Type, p: ir.Value },
    closure: *const inl.Closure,

    pub fn ty(self: Local) Type {
        return switch (self) {
            .val => |v| v.t,
            .cell => |c| c.t,
            .closure => |c| .{ .func_ = c.fn_type },
        };
    }
};

const Scope = struct {
    names: std.StringHashMapUnmanaged(Local) = .empty,
    /// 登録順。出口で逆順に展開する
    defers: std.ArrayListUnmanaged(*const ast.Expr) = .empty,

    fn deinit(self: *Scope, gpa: std.mem.Allocator) void {
        self.names.deinit(gpa);
        self.defers.deinit(gpa);
    }
};

const Loop = struct {
    head: ir.BlockId,
    exit: ir.BlockId,
    /// ループ本体の外側のスコープ数（break / continue はこれより内側の defer を展開する）
    scope_depth: usize,
};

/// 腕の合流待ち: 終端していない末尾ブロックと腕の値
pub const ArmEnd = struct { blk: ir.BlockId, v: Val };

/// 代入先（スロット内の場所）
const Place = struct { t: Type, p: ir.Value };

pub const Lowerer = struct {
    gpa: std.mem.Allocator,
    m: *ir.Module,
    prog: *const ast.Program,
    diag: *Diag,
    rt: ir_rt.Rt,
    funcs: std.StringHashMapUnmanaged(*FnInfo) = .empty,
    work: std.ArrayListUnmanaged(*FnInfo) = .empty,
    // 型表（キーは "pkg_path.Name"）
    structs: std.StringHashMapUnmanaged(*StructInfo) = .empty,
    unions: std.StringHashMapUnmanaged(*UnionInfo) = .empty,
    variants: std.StringHashMapUnmanaged(VariantRef) = .empty,
    generic_tys: std.StringHashMapUnmanaged(types.GenericTy) = .empty,
    errors: *UnionInfo = undefined,
    /// 組み込み error の型（lower_types.errType — 初出で作る）
    err_struct: ?*types.StructInfo = null,
    /// 文字列リテラルの rodata（同じ綴りは 1 つ）
    strs: std.StringHashMapUnmanaged(ir.GlobalId) = .empty,

    // 下ろし中の関数
    b: ir.Builder = undefined,
    info: *const FnInfo = undefined,
    /// 下ろし中の関数の FnInfo.lift_outer（funcBody が入れる — info より先に ident が走っても空で安全）
    lift_outer: []const []const u8 = &.{},
    cur_pkg: *const ast.Pkg = undefined,
    scopes: std.ArrayListUnmanaged(Scope) = .empty,
    loops: std.ArrayListUnmanaged(Loop) = .empty,
    /// 入口で退避した深度（出口で戻す）
    entry_depth: ir.Value = 0,
    /// sret のアドレス（sret の関数だけ）
    sret_ptr: ir.Value = 0,
    /// 補間の穴の合成名の通し番号
    interp_seq: u32 = 0,
    /// 型パラメータの束縛（単相コピー・ジェネリック inline・ジェネリック struct のレイアウト中）
    type_env: []const TypeBind = &.{},
    /// 名前の可視範囲の鎖（lower_inline.lookup）。inline 展開は空の鎖で開き、ラムダは定義時の鎖で開く
    chain: std.ArrayListUnmanaged(inl.View) = .empty,
    /// return の行き先のスタック（先頭が現在）
    ret_ctxs: std.ArrayListUnmanaged(inl.RetCtx) = .empty,
    /// break / continue が届くループの下限（展開の中から呼び手のループへは行けない — OutsideLoop）
    loop_floors: std.ArrayListUnmanaged(usize) = .empty,
    /// 展開中の inline 関数の名前（再帰の展開は Unsupported）
    inlining: std.ArrayListUnmanaged([]const u8) = .empty,
    /// 辞書 const の展開中（持ち上げたラムダを参照点の間で共有する）
    in_dict_const: bool = false,
    dict_lifts: std.AutoHashMapUnmanaged(*const ast.Lambda, ir.FuncId) = .empty,
    lambda_seq: u32 = 0,

    fn deinit(self: *Lowerer) void {
        for (self.scopes.items) |*s| s.deinit(self.gpa);
        self.scopes.deinit(self.gpa);
        self.loops.deinit(self.gpa);
        self.funcs.deinit(self.gpa);
        self.work.deinit(self.gpa);
        self.structs.deinit(self.gpa);
        self.unions.deinit(self.gpa);
        self.variants.deinit(self.gpa);
        self.generic_tys.deinit(self.gpa);
        self.strs.deinit(self.gpa);
        self.chain.deinit(self.gpa);
        self.ret_ctxs.deinit(self.gpa);
        self.loop_floors.deinit(self.gpa);
        self.inlining.deinit(self.gpa);
        self.dict_lifts.deinit(self.gpa);
    }

    pub fn a(self: *Lowerer) std.mem.Allocator {
        return self.m.alloc();
    }

    pub fn fail(self: *Lowerer, err: Error, pos: ast.Pos, what: []const u8) Error {
        const n = @min(what.len, self.diag.buf.len);
        @memcpy(self.diag.buf[0..n], what[0..n]);
        self.diag.pos = pos;
        self.diag.what = self.diag.buf[0..n];
        return err;
    }

    fn program(self: *Lowerer) Error!void {
        try types.registerTypes(self);
        try types.checkDecls(self);
        const main_fn = (try self.funcByKey(self.prog.main, "main")) orelse return self.fail(error.MissingMain, 0, "no func main");
        // `func main()` か `func main() int`（戻り値 = 終了コード — R31 の裁定）
        const main_int = main_fn.results.len == 1 and main_fn.results[0] == .int;
        if (main_fn.params.len != 0 or (main_fn.results.len != 0 and !main_int)) return self.fail(error.Unsupported, main_fn.decl.tok, "main with params or results other than int");
        _ = try ir_rt.buildEntry(self.m, main_fn.id, main_int, self.rt.memtrace);
        while (self.work.pop()) |fi| try self.funcBody(fi);
    }

    // ── 型表（lower_types.zig）──

    pub fn key(self: *Lowerer, path: []const u8, name: []const u8) Error![]const u8 {
        return types.key(self, path, name);
    }

    pub fn resolveName(self: *Lowerer, name: []const u8, tok: ast.Pos) Error![]const u8 {
        return types.resolveName(self, name, tok);
    }

    pub fn resolveType(self: *Lowerer, te: ast.TypeExpr, tok: ast.Pos) Error!Type {
        return types.resolveType(self, te, tok);
    }

    // ── 関数表 ──

    pub fn findDecl(pkg: *const ast.Pkg, name: []const u8) ?*const ast.FuncDecl {
        for (pkg.files) |file| for (file.funcs) |f| if (std.mem.eql(u8, f.name, name)) return f;
        return null;
    }

    /// pkg の実体の関数 name の FnInfo（初出なら署名を作って本体を作業列に積む）。無ければ null。
    /// 展開される関数・ジェネリック関数は呼び手が別経路（lower_inline）へ回す
    fn funcByKey(self: *Lowerer, pkg: *const ast.Pkg, name: []const u8) Error!?*FnInfo {
        const k = try self.key(pkg.path, name);
        if (self.funcs.get(k)) |fi| return fi;
        const decl = findDecl(pkg, name) orelse return null;
        if (decl.bodiless) return self.fail(error.Unsupported, decl.tok, "bodiless function");
        std.debug.assert(!decl.expands and decl.type_params.len == 0);
        return try self.newFunc(k, decl, pkg, &.{});
    }

    /// 署名を pkg の文脈・型環境 env で読んで関数を足し、本体を作業列に積む
    pub fn newFunc(self: *Lowerer, k: []const u8, decl: *const ast.FuncDecl, pkg: *const ast.Pkg, env: []const TypeBind) Error!*FnInfo {
        const sig = try inl.sigIn(self, decl, pkg, env);
        return self.newFuncSig(k, decl, pkg, env, sig.params, sig.results);
    }

    pub fn newFuncSig(self: *Lowerer, k: []const u8, decl: *const ast.FuncDecl, pkg: *const ast.Pkg, env: []const TypeBind, params: []const Type, results: []const Type) Error!*FnInfo {
        const fi = try self.a().create(FnInfo);
        fi.* = .{ .decl = decl, .pkg = pkg, .id = undefined, .params = params, .results = results, .env = env };
        var ptys: std.ArrayListUnmanaged(ir.Ty) = .empty;
        if (fi.sret()) try ptys.append(self.a(), .ptr);
        // 引数は語に展開する（アグリゲートは語数ぶんの i64）。mut 仮引数（mut_def — R2）は呼び手のセルのアドレス 1 語
        for (params, 0..) |t, i| {
            if (isMutParam(decl, i)) try ptys.append(self.a(), .ptr) else try ptys.appendNTimes(self.a(), .i64, t.words());
        }
        fi.id = try self.m.addFunc(k, ptys.items, if (fi.sret() or results.len == 0) null else .i64);
        try self.funcs.put(self.gpa, k, fi);
        try self.work.append(self.gpa, fi);
        return fi;
    }

    // ── 値の置き場 ──

    pub fn newAgg(self: *Lowerer, t: Type) Error!ir.Value {
        return self.b.slotaddr(try self.b.newSlot(@max(t.words(), 1)));
    }

    /// p + off 語
    pub fn fieldPtr(self: *Lowerer, p: ir.Value, off: u32) Error!ir.Value {
        if (off == 0) return p;
        return self.b.gepWord(p, try self.b.iconst(off));
    }

    /// p + off 語にある型 t の値（アグリゲートはアドレスのまま — コピーしない）
    pub fn loadVal(self: *Lowerer, p: ir.Value, off: u32, t: Type) Error!Val {
        if (t.isScalar()) return .{ .t = t, .v = try self.b.load(p, @intCast(off)) };
        return .{ .t = t, .v = try self.fieldPtr(p, off) };
    }

    /// v を p + off 語へ書く（アグリゲートは語ごとにコピー）
    pub fn storeVal(self: *Lowerer, p: ir.Value, off: u32, v: Val) Error!void {
        if (v.t.isScalar()) return self.b.store(p, @intCast(off), v.v);
        for (0..v.t.words()) |w| {
            const i: i32 = @intCast(w);
            try self.b.store(p, @as(i32, @intCast(off)) + i, try self.b.load(v.v, i));
        }
    }

    /// アグリゲートを新しいスロットへ写す（スカラーはそのまま）
    pub fn copyVal(self: *Lowerer, v: Val) Error!Val {
        if (!v.t.isAggregate()) return v;
        const p = try self.newAgg(v.t);
        try self.storeVal(p, 0, v);
        return .{ .t = v.t, .v = p };
    }

    // ── 本体 ──

    fn funcBody(self: *Lowerer, fi: *const FnInfo) Error!void {
        self.info = fi;
        self.lift_outer = fi.lift_outer;
        self.cur_pkg = fi.pkg;
        self.type_env = fi.env;
        self.chain.clearRetainingCapacity();
        try self.chain.append(self.gpa, .{ .lo = 0, .hi = inl.View.open });
        self.ret_ctxs.clearRetainingCapacity();
        try self.ret_ctxs.append(self.gpa, .func);
        self.loop_floors.clearRetainingCapacity();
        try self.loop_floors.append(self.gpa, 0);
        self.inlining.clearRetainingCapacity();
        self.b = try ir.Builder.begin(self.m, fi.id);
        try self.pushScope();
        defer self.popScope();
        const f = self.m.funcs.items[fi.id];
        var idx: usize = 0;
        if (fi.sret()) {
            self.sret_ptr = f.params[0];
            idx = 1;
        }
        for (fi.decl.params, fi.params) |p, t| {
            if (p.mutable) {
                // mut 仮引数は呼び手のセルそのもの（アドレス越しに読み書きする — 呼び手に見える。R2）
                try self.declare(p.name, .{ .cell = .{ .t = t, .p = f.params[idx] } });
                idx += 1;
                continue;
            }
            if (t.isScalar()) {
                try self.declare(p.name, .{ .val = .{ .t = t, .v = f.params[idx] } });
            } else {
                // 語で受けた引数を自分のスロットへ写す
                const slot = try self.newAgg(t);
                for (0..t.words()) |w| try self.b.store(slot, @intCast(w), f.params[idx + w]);
                try self.declare(p.name, .{ .val = .{ .t = t, .v = slot } });
            }
            idx += t.words();
        }
        // 関数本体は自分の region を開く（codegen funcDeclAt と同じ: 入口の深度を退避し、出口が復元する）
        self.entry_depth = try self.b.regionDepth();
        try self.b.regionEnter();
        try self.stmts(fi.decl.body.stmts);
        if (self.b.cur != null) {
            if (fi.results.len != 0) return self.fail(error.MissingReturn, fi.decl.tok, fi.decl.name);
            try self.runDefers(0);
            if (self.b.cur != null) {
                try self.b.regionSetDepth(self.entry_depth);
                self.b.ret(null);
            }
        }
        // 到達しない位置で作って前任を持たないまま残ったブロックを閉じる（到達したら panic — 中身は死んでいる）
        for (f.blocks.items) |*blk| if (blk.term == .none and blk.preds == 0) {
            blk.term = .{ .exit = 101 };
        };
    }

    pub fn pushScope(self: *Lowerer) Error!void {
        try self.scopes.append(self.gpa, .{});
    }

    pub fn popScope(self: *Lowerer) void {
        var s = self.scopes.pop().?;
        s.deinit(self.gpa);
    }

    pub fn declare(self: *Lowerer, name: []const u8, l: Local) Error!void {
        if (std.mem.eql(u8, name, "_")) return;
        try self.scopes.items[self.scopes.items.len - 1].names.put(self.gpa, name, l);
    }

    /// 利用者の書いた束縛（:=・パターン・ラムダ / 展開される関数の引数）: 見えている名前の再束縛は拒否（codegen declare / declareAt と同じ）。
    /// declare はそのまま（絞り込みの腕が同名で再束縛する — codegen narrowedBlock と同じ）
    pub fn declareNew(self: *Lowerer, name: []const u8, l: Local, tok: ast.Pos) Error!void {
        if (std.mem.eql(u8, name, "_")) return;
        if (self.lookup(name) != null) return self.fail(error.Unsupported, tok, "shadowing is not allowed");
        try self.declare(name, l);
    }

    /// 束縛 1 つ: スカラーの不変束縛は値そのもの、それ以外はスロットを取って書く（アグリゲートは束縛でコピー）
    fn bindName(self: *Lowerer, name: []const u8, v: Val, mutable: bool, tok: ast.Pos) Error!void {
        if (v.t == .none or v.t == .never) return self.fail(error.TypeMismatch, tok, "binding a value-less expression");
        if (v.t == .nil_) return self.fail(error.TypeMismatch, tok, "nil needs a T? context");
        if (std.mem.eql(u8, name, "_")) return;
        if (v.t.isAggregate()) {
            const c = try self.copyVal(v);
            return self.declareNew(name, if (mutable) .{ .cell = .{ .t = v.t, .p = c.v } } else .{ .val = c }, tok);
        }
        if (!mutable) return self.declareNew(name, .{ .val = v }, tok);
        const p = try self.b.slotaddr(try self.b.newSlot(1));
        try self.b.store(p, 0, v.v);
        try self.declareNew(name, .{ .cell = .{ .t = v.t, .p = p } }, tok);
    }

    pub fn lookup(self: *Lowerer, name: []const u8) ?Local {
        return inl.lookup(self, name);
    }

    /// scopes[from..] に積まれた defer を内側から逆順に展開する（codegen の runDefers と同じ順）。
    /// 各 defer は自分の新スコープで評価し、結果は捨てる
    pub fn runDefers(self: *Lowerer, from: usize) Error!void {
        var i = self.scopes.items.len;
        while (i > from) : (i -= 1) {
            var j = self.scopes.items[i - 1].defers.items.len;
            while (j > 0) : (j -= 1) {
                const d = self.scopes.items[i - 1].defers.items[j - 1];
                try self.pushScope();
                defer self.popScope();
                _ = try self.evalMulti(d);
                if (self.b.cur == null) return;
            }
        }
    }

    /// 文の列。脱出の後の文は到達しないので下ろさない
    pub fn stmts(self: *Lowerer, ss: []const ast.Stmt) Error!void {
        for (ss) |s| {
            if (self.b.cur == null) return;
            try self.stmt(s);
        }
    }

    fn stmt(self: *Lowerer, s: ast.Stmt) Error!void {
        switch (s) {
            // 文位置は結果の個数を問わない（多値の呼び出しは捨てる）
            .expr => |e| _ = try self.evalMulti(e),
            .ret => |r| try self.ret(r),
            .bind => |bd| try self.bind(bd),
            .assign => |x| try self.assign(x),
            .while_ => |w| try self.whileStmt(w),
            .break_, .continue_ => |pos| {
                if (self.loops.items.len <= self.loop_floors.items[self.loop_floors.items.len - 1]) return self.fail(error.OutsideLoop, pos, if (s == .break_) "break" else "continue");
                const loop = self.loops.items[self.loops.items.len - 1];
                try self.runDefers(loop.scope_depth);
                if (self.b.cur == null) return;
                try self.b.br(if (s == .break_) loop.exit else loop.head, &.{});
            },
            .defer_ => |d| try self.scopes.items[self.scopes.items.len - 1].defers.append(self.gpa, d.expr),
            // yield 文は束縛 `yield`（for 式を書き換えたラムダの引数 — forexpand.zig）の呼び出し
            .yield_ => |y| _ = try self.evalMulti(try forexpand.yieldCall(self.a(), y.expr, y.tok)),
        }
    }

    fn bind(self: *Lowerer, bd: ast.Bind) Error!void {
        // `q, r := f()`: 多値の結果を順に束縛する
        if (bd.names.len != bd.values.len) {
            const r = try self.multiValue(bd.values, bd.names.len, bd.tok);
            if (isNever(r)) return;
            for (bd.names, r) |n, v| try self.bindName(n, v, bd.mutable, bd.tok);
            return;
        }
        // 同数の式は右辺を全部評価してから束縛する（束縛がコピーするので右辺の一時は写さなくてよい）
        const vals = try self.a().alloc(Val, bd.values.len);
        for (bd.values, vals) |e, *v| {
            v.* = try self.expr(e);
            if (v.t == .never) return;
            if (bd.values.len > 1) v.* = try self.copyVal(v.*);
        }
        for (bd.names, vals) |n, v| try self.bindName(n, v, bd.mutable, bd.tok);
    }

    /// `x = e` / `x, y = e1, e2`（並行）/ `a, b = f()` / `x op= e`。代入先は名前とフィールド、単独の `xs[i] = v` / `m[k] = v`
    fn assign(self: *Lowerer, x: ast.Assign) Error!void {
        if (x.targets.len == 1 and x.targets[0].* == .index) {
            if (x.op != .equal) return self.fail(error.Unsupported, x.tok, "compound assignment to a slice element");
            if (x.values.len != 1) return self.fail(error.ResultCountMismatch, x.tok, "slice element assignment");
            return cont.setIndex(self, x.targets[0].index, x.values[0]);
        }
        if (x.op != .equal) {
            if (x.targets.len != 1 or x.values.len != 1) return self.fail(error.Unsupported, x.tok, "compound multi-value assignment");
            // codegen と同じ順: 右辺 → 対象の現在値 → 演算 → 書き戻し
            const r = try self.expr(x.values[0]);
            if (r.t == .never) return;
            try self.want(r, .int, x.tok);
            const place = (try self.target(x.targets[0], x.tok)) orelse return self.fail(error.NotAssignable, x.tok, "compound assignment to _");
            if (place.t != .int) return self.fail(error.TypeMismatch, x.tok, "compound assignment to a non-int");
            const cur = try self.b.load(place.p, 0);
            const op: Token.Tag = switch (x.op) {
                .plus_equal => .plus,
                .minus_equal => .minus,
                .star_equal => .star,
                .slash_equal => .slash,
                .percent_equal => .percent,
                .ampersand_equal => .ampersand,
                .pipe_equal => .pipe,
                .caret_equal => .caret,
                .shl_equal => .shl,
                .shr_equal => .shr,
                else => return self.fail(error.Unsupported, x.tok, "compound operator"),
            };
            const v = try self.arith(op, cur, r.v, x.tok);
            try self.b.store(place.p, 0, v);
            return;
        }
        const vals: Results = if (x.targets.len != x.values.len) try self.multiValue(x.values, x.targets.len, x.tok) else blk: {
            // 右辺を全部評価してから左辺に書く（`x, y = y, x` の並行代入 — アグリゲートは一時へ写す）
            const vs = try self.a().alloc(Val, x.values.len);
            for (x.values, vs) |e, *v| {
                v.* = try self.expr(e);
                if (v.t == .never) break :blk never_results;
                if (x.values.len > 1) v.* = try self.copyVal(v.*);
            }
            break :blk vs;
        };
        if (isNever(vals)) return;
        // 書く順は codegen と同じ後ろから（同じ名前が 2 度出たら先頭が勝つ）
        var i = x.targets.len;
        while (i > 0) {
            i -= 1;
            const place = (try self.target(x.targets[i], x.tok)) orelse continue;
            const v = try self.coerce(vals[i], place.t, x.tok);
            try self.storeVal(place.p, 0, v);
        }
    }

    /// 代入先の場所。`_` なら null。フィールドは基底の場所から辿る（基底は mut ローカル — codegen targetAddr と同じ）
    fn target(self: *Lowerer, t: *const ast.Expr, tok: ast.Pos) Error!?Place {
        switch (t.*) {
            .ident => |id| {
                if (std.mem.eql(u8, id.name, "_")) return null;
                const l = self.lookup(id.name) orelse return self.fail(error.UndefinedName, id.tok, id.name);
                return switch (l) {
                    .cell => |c| .{ .t = c.t, .p = c.p },
                    .val, .closure => return self.fail(error.Immutable, id.tok, id.name),
                };
            },
            .selector => |sel| {
                const base = (try self.target(sel.base, tok)) orelse return self.fail(error.NotAssignable, sel.tok, "field of _");
                const f = try self.fieldOf(base.t, sel.field, sel.tok);
                return .{ .t = f.t, .p = try self.fieldPtr(base.p, f.offset) };
            },
            else => return self.fail(error.NotAssignable, tok, "assignment target must be a name or a field"),
        }
    }

    fn fieldOf(self: *Lowerer, t: Type, name: []const u8, tok: ast.Pos) Error!*const FieldInfo {
        const s = switch (t) {
            .struct_ => |s| s,
            else => return self.fail(error.TypeMismatch, tok, "field access on a non-struct value"),
        };
        return findField(s.fields, name) orelse self.fail(error.UndefinedField, tok, name);
    }

    /// while: 入口の深度を退避し、周回の頭と出口で復元する（codegen と同じ — break / continue が
    /// 式ブロックの region を飛び越えるため）。本体は region を開かない
    fn whileStmt(self: *Lowerer, w: ast.While) Error!void {
        const saved = try self.b.regionDepth();
        const head = try self.b.newBlock();
        const body = try self.b.newBlock();
        const exit = try self.b.newBlock();
        try self.b.br(head, &.{});
        self.b.cur = head;
        try self.b.regionSetDepth(saved);
        const c = try self.expr(w.cond);
        if (c.t == .never) return;
        try self.want(c, .bool_, w.tok);
        try self.b.condbr(c.v, body, &.{}, exit, &.{});
        self.b.cur = body;
        try self.loops.append(self.gpa, .{ .head = head, .exit = exit, .scope_depth = self.scopes.items.len });
        _ = try self.armValue(w.body);
        _ = self.loops.pop();
        if (self.b.cur != null) try self.b.br(head, &.{});
        self.b.cur = exit;
        try self.b.regionSetDepth(saved);
    }

    fn ret(self: *Lowerer, r: ast.Return) Error!void {
        if (self.info.synth_ret) |synth| if (r.values.ptr != synth)
            return self.fail(error.Unsupported, r.tok, "return inside a dictionary lambda (a lambda's return leaves the enclosing named function — language.md 8)");
        const top = self.ret_ctxs.items[self.ret_ctxs.items.len - 1];
        const want_ts = switch (top) {
            .func => self.info.results,
            .inline_ => |ctx| ctx.results,
        };
        const vals: Results = if (want_ts.len > 1 and r.values.len == 1)
            // `return g()` の転送: g の結果をそのまま自分の結果へ
            try self.multiValue(r.values, want_ts.len, r.tok)
        else blk: {
            if (r.values.len != want_ts.len) return self.fail(error.ResultCountMismatch, r.tok, "return value count differs from the signature");
            const vs = try self.a().alloc(Val, r.values.len);
            for (r.values, vs, want_ts) |e, *v, t| {
                v.* = try self.exprExpecting(e, t, r.tok);
                if (v.t == .never) break :blk never_results;
            }
            break :blk vs;
        };
        if (isNever(vals)) return;
        for (vals, want_ts) |v, t| if (!v.t.eql(t)) return self.fail(error.TypeMismatch, r.tok, "return type");
        if (top == .inline_) {
            var off: u32 = 0;
            for (vals) |v| {
                try self.storeVal(top.inline_.slot, off, v);
                off += v.t.words();
            }
            return inl.inlineExit(self, top.inline_, r.tok);
        }
        // 結果スロットへ書いてから defer（codegen と同じ — 値は defer より先に確定する）
        if (self.info.sret()) {
            var off: u32 = 0;
            for (vals) |v| {
                try self.storeVal(self.sret_ptr, off, v);
                off += v.t.words();
            }
        }
        try self.funcExit(if (!self.info.sret() and vals.len == 1) vals[0].v else null, r.tok);
    }

    /// 関数の出口の後半（結果は書き済み — sret でなければ v）: defer → 結果の relocate → 深度復元 → ret
    pub fn funcExit(self: *Lowerer, v: ?ir.Value, tok: ast.Pos) Error!void {
        try self.runDefers(0);
        if (self.b.cur == null) return;
        // 結果の slice / map を呼び手の region へ写す（codegen epilogue: defer の後・深度復元の前）
        if (self.info.sret()) {
            var off: u32 = 0;
            for (self.info.results) |t| {
                try cont.relocate(self, self.sret_ptr, off, t, tok);
                off += t.words();
            }
        }
        try self.b.regionSetDepth(self.entry_depth);
        self.b.ret(v);
    }

    /// 文の並びの値（末尾の式文）。スコープは呼び手が切る
    fn blockTail(self: *Lowerer, blk: *const ast.Block) Error!Val {
        const tail = blk.tailExpr();
        const n = if (tail != null) blk.stmts.len - 1 else blk.stmts.len;
        try self.stmts(blk.stmts[0..n]);
        if (self.b.cur == null) return Val.never;
        if (tail) |e| {
            const r = try self.evalMulti(e);
            if (self.b.cur == null) return Val.never;
            return if (r.len == 1) r[0] else Val.none;
        }
        return Val.none;
    }

    /// if / switch の腕・while 本体: 新スコープだけ開き、region は開かない（codegen armBlock）。出口で defer を展開
    pub fn armValue(self: *Lowerer, blk: *const ast.Block) Error!Val {
        try self.pushScope();
        defer self.popScope();
        return self.armTail(blk);
    }

    pub fn armTail(self: *Lowerer, blk: *const ast.Block) Error!Val {
        const v = try self.blockTail(blk);
        if (v.t == .never) return v;
        try self.runDefers(self.scopes.items.len - 1);
        return if (self.b.cur == null) Val.never else v;
    }

    /// 絞り込みつきの腕: name（T?）のペイロードのコピーを同名で再束縛して本体を実行する（codegen narrowedBlock）
    fn narrowedArm(self: *Lowerer, name: []const u8, blk: *const ast.Block) Error!Val {
        const l = self.lookup(name).?;
        const o = l.ty().opt;
        const p = switch (l) {
            .val => |v| v.v,
            .cell => |c| c.p,
            .closure => unreachable, // nilTest が T? を確かめ済み
        };
        const payload = try self.copyVal(try self.loadVal(p, 1, o.payload));
        try self.pushScope();
        defer self.popScope();
        try self.declare(name, .{ .val = payload });
        return self.armTail(blk);
    }

    /// 式位置の `{ }`: 新スコープ + 新 region。出口で defer を展開してから region を閉じる（codegen blockExpr）。
    /// 閉じるのは入口の深度へ戻す形（enter と対なら depth - 1 と同じ）。
    /// 普通の出口の境界コピー（regionpoly R5 — Lean の regionKR）: 末尾値がコンテナを含むなら、defer の後・region を閉じる前に、
    /// ブロックの region にあるヘッダを親の最内 region（入口の深度）へ中身ごと写す（relocateTo — 戻り・inline の脱出と同じ規則）。
    /// 写すのは値の写し（別名の mut ローカルのヘッダを書き換えない）。mut のコンテナはブロックの region を指せない（型の保証）ので触らない
    fn blockValue(self: *Lowerer, blk: *const ast.Block) Error!Val {
        try self.pushScope();
        defer self.popScope();
        const saved = try self.b.regionDepth();
        try self.b.regionEnter();
        var v = try self.blockTail(blk);
        if (v.t == .never) return v;
        try self.runDefers(self.scopes.items.len - 1);
        if (self.b.cur == null) return Val.never;
        if (v.t.containsSlice()) {
            v = try self.copyVal(v);
            try cont.relocateTo(self, v.v, 0, v.t, saved, 0);
        }
        try self.b.regionSetDepth(saved);
        return v;
    }

    /// 多値を許す評価。呼び出し・パイプは結果の並び、他の式は 1 値（値なしは空）
    pub fn evalMulti(self: *Lowerer, e: *const ast.Expr) Error!Results {
        switch (e.*) {
            .call => |c| return self.callArgs(c.callee, try self.exprArgs(c.args), c.tok),
            .pipe => |p| return self.pipe(p),
            .try_ => |t| return inl.tryResults(self, t),
            else => {
                const v = try self.expr(e);
                if (v.t == .never) return never_results;
                if (v.t == .none) return &.{};
                const out = try self.a().alloc(Val, 1);
                out[0] = v;
                return out;
            },
        }
    }

    /// `a, b := e` の右辺: 1 つの多値の式で、結果の個数が want
    fn multiValue(self: *Lowerer, values: []const *ast.Expr, want_n: usize, tok: ast.Pos) Error!Results {
        if (values.len != 1) return self.fail(error.ResultCountMismatch, tok, "value count differs from the number of names");
        const r = try self.evalMulti(values[0]);
        if (isNever(r)) return r;
        if (r.len != want_n) return self.fail(error.ResultCountMismatch, tok, "call result count differs from the number of names");
        return r;
    }

    fn exprArgs(self: *Lowerer, args: []const *ast.Expr) Error![]const ArgSrc {
        const out = try self.a().alloc(ArgSrc, args.len);
        for (args, out) |e, *s| s.* = .{ .expr = e };
        return out;
    }

    /// 値 v を期待型 want に合わせる（codegen coerce）: T? の期待に対して nil はタグ 0 の実体化、
    /// ペイロード型の値はタグ 1 で包む（暗黙 some）。他は型一致を要求
    pub fn coerce(self: *Lowerer, v: Val, want_t: Type, tok: ast.Pos) Error!Val {
        if (v.t.eql(want_t) or v.t == .never) return v;
        if (want_t == .opt) {
            const o = want_t.opt;
            if (v.t == .nil_) {
                const p = try self.newAgg(want_t);
                try self.b.store(p, 0, try self.b.iconst(0));
                return .{ .t = want_t, .v = p };
            }
            const inner = if (types.isErr(self, o.payload) and self.isLabel(v.t)) try self.labelToErr(v) else v;
            if (inner.t.eql(o.payload)) {
                const p = try self.newAgg(want_t);
                try self.b.store(p, 0, try self.b.iconst(1));
                try self.storeVal(p, 1, inner);
                return .{ .t = want_t, .v = p };
            }
        }
        if (types.isErr(self, want_t) and self.isLabel(v.t)) return self.labelToErr(v);
        return self.fail(error.TypeMismatch, tok, "value type differs from the expected type");
    }

    /// error ラベルのリテラルの型（全ラベルの union）か
    pub fn isLabel(self: *const Lowerer, t: Type) bool {
        return t == .union_ and t.union_ == self.errors;
    }

    /// ラベルの値 → error（K1''）: (L, 空の鎖)。空の鎖はゼロのヘッダ（深度 0 — relocate の対象にならない）
    pub fn labelToErr(self: *Lowerer, v: Val) Error!Val {
        const et = try types.errType(self);
        const p = try self.newAgg(et);
        try self.storeVal(p, 0, v);
        const zero = try self.b.iconst(0);
        for (0..3) |w| try self.b.store(p, @intCast(v.t.words() + w), zero);
        return .{ .t = et, .v = p };
    }

    /// 期待型つきの式評価（sink: return・引数・フィールド・代入）。T? を期待する if 式は腕ごとに合わせる（腕に nil を書ける）
    pub fn exprExpecting(self: *Lowerer, e: *const ast.Expr, want_t: Type, tok: ast.Pos) Error!Val {
        // 関数値が期待される位置（struct の関数型フィールド）のラムダは匿名関数へ持ち上げる
        if (e.* == .lambda and want_t == .fnv) return inl.liftLambda(self, &e.lambda, want_t.fnv, tok);
        if (e.* == .if_ and want_t == .opt and e.if_.else_ != null) return self.coerce(try self.ifExpr(e.if_, want_t), want_t, tok);
        return self.coerce(try self.expr(e), want_t, tok);
    }

    pub fn expr(self: *Lowerer, e: *const ast.Expr) Error!Val {
        switch (e.*) {
            .int => |n| return .{ .t = .int, .v = try self.b.iconst(n.value) },
            .nil => return .{ .t = .nil_ },
            .ident => |id| return self.ident(id),
            .binary => |bin| return self.binary(bin),
            .unary => |u| return self.unary(u),
            .call, .pipe => {
                const r = try self.evalMulti(e);
                if (isNever(r)) return Val.never;
                if (r.len == 0) return Val.none;
                if (r.len > 1) return self.fail(error.ResultCountMismatch, e.tok(), "multi-value call in a single-value context");
                return r[0];
            },
            .composite => |c| return self.composite(c),
            .selector => |sel| return self.selector(sel),
            .if_ => |x| return self.ifExpr(x, null),
            .switch_ => |sw| return self.switchExpr(sw),
            .block => |blk| return self.blockValue(blk),
            .strlit => |sl| return cont.strlit(self, sl.value),
            .slicelit => |sl| return cont.slicelit(self, sl),
            .maplit => |ml| return cont.maplit(self, ml),
            .index => |ix| return cont.index(self, ix),
            .slice3 => |s3| return cont.slice3(self, s3),
            .interp => |it| return self.interpExpr(it),
            .lambda => return self.fail(error.Unsupported, e.tok(), "lambda outside a function-typed argument"),
            .try_ => |t| {
                const r = try inl.tryResults(self, t);
                if (isNever(r)) return Val.never;
                return switch (r.len) {
                    0 => Val.none,
                    1 => r[0],
                    else => self.fail(error.ResultCountMismatch, t.tok, "? leaves several values (decompose them with `a, b := f()?`)"),
                };
            },
            .mut_arg => |m| return self.fail(error.TypeMismatch, m.tok, "`mut x` marks only an argument of a mut parameter"),
            .for_ => |f| return self.fail(error.Unsupported, f.tok, "a for expression is consumed only as an Iter argument (an escaping Iter is outside the fragment)"),
        }
    }

    /// 補間（interp.zig の固定テンプレート — codegen interpExpr と同じ形）: 穴を左から順に合成名へ束縛して型を得てから、
    /// その名前を参照する連結の連鎖を組んで下ろす（int は std/strings.Itoa、bool は if）
    fn interpExpr(self: *Lowerer, it: ast.Interp) Error!Val {
        try self.pushScope();
        defer self.popScope();
        const holes = try self.a().alloc(*ast.Expr, it.tmpl.holes.len);
        for (it.tmpl.holes, holes) |e, *out| {
            const v = try self.expr(e);
            if (v.t == .never) return v;
            const name = try std.fmt.allocPrint(self.a(), "$interp{d}", .{self.interp_seq});
            self.interp_seq += 1;
            try self.bindName(name, v, false, it.tok);
            const id = try self.a().create(ast.Expr);
            id.* = .{ .ident = .{ .name = name, .tok = e.tok() } };
            out.* = id;
        }
        var bad: ?*const ast.Expr = null;
        const lowered = interp.lower(self.a(), .{ .tmpl = .{ .lits = it.tmpl.lits, .holes = holes }, .tok = it.tok }, self, interpKind, &bad) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            error.BadType => return self.fail(error.TypeMismatch, it.tok, "interpolation takes int, string or bool"),
        };
        return self.expr(lowered);
    }

    fn interpKind(self: *Lowerer, e: *const ast.Expr) ?interp.Kind {
        const l = self.lookup(e.ident.name) orelse return null;
        const t = l.ty();
        if (t == .int) return .int;
        if (t == .bool_) return .bool;
        if (t.isString()) return .string;
        return null;
    }

    fn ident(self: *Lowerer, id: ast.Ident) Error!Val {
        if (std.mem.eql(u8, id.name, "_")) return self.fail(error.Unsupported, id.tok, "_ is only a hole in a pipe stage argument");
        if (self.lookup(id.name)) |l| switch (l) {
            .val => |v| return v,
            .cell => |c| return if (c.t.isScalar()) .{ .t = c.t, .v = try self.b.load(c.p, 0) } else .{ .t = c.t, .v = c.p },
            .closure => return self.fail(error.TypeMismatch, id.tok, "a function-typed parameter is not a value (it is expanded at call sites)"),
        };
        if (std.mem.eql(u8, id.name, "true")) return .{ .t = .bool_, .v = try self.b.iconst(1) };
        if (std.mem.eql(u8, id.name, "false")) return .{ .t = .bool_, .v = try self.b.iconst(0) };
        if (try self.constIn(self.cur_pkg, id.name, id.tok)) |v| return v;
        if (try self.fnValueIn(self.cur_pkg, id.name, id.tok)) |v| return v;
        for (self.lift_outer) |n| if (std.mem.eql(u8, n, id.name))
            return self.fail(error.Unsupported, id.tok, "a lambda in a dictionary cannot capture an outer variable (closed function values only — V3-1)");
        return self.fail(error.UndefinedName, id.tok, id.name);
    }

    /// トップレベル const: int はロード時に畳み込み済み、辞書は参照点で宣言側の文脈のまま展開する
    fn constIn(self: *Lowerer, pkg: *const ast.Pkg, name: []const u8, tok: ast.Pos) Error!?Val {
        for (pkg.files) |file| for (file.consts) |c| {
            if (!std.mem.eql(u8, c.name, name)) continue;
            if (c.dict) return try inl.dictConst(self, c, pkg);
            const n = c.value orelse return self.fail(error.Unsupported, tok, "const value was not folded (loader)");
            return .{ .t = .int, .v = try self.b.iconst(n) };
        };
        return null;
    }

    /// 名前付き関数の参照 = 関数値（展開される関数・ジェネリック関数は値にならない）
    fn fnValueIn(self: *Lowerer, pkg: *const ast.Pkg, name: []const u8, tok: ast.Pos) Error!?Val {
        const decl = findDecl(pkg, name) orelse return null;
        if (decl.expands) return self.fail(error.Unsupported, tok, "a function with function-typed parameters is not a value (it is expanded at call sites)");
        if (decl.type_params.len > 0) return self.fail(error.Unsupported, tok, "a generic function is not a value");
        return try inl.fnValue(self, (try self.funcByKey(pkg, name)).?);
    }

    fn pkgByPath(self: *Lowerer, path: []const u8) ?*const ast.Pkg {
        for (self.prog.pkgs) |p| if (std.mem.eql(u8, p.path, path)) return p;
        return null;
    }

    /// `x.f`（struct のフィールド）/ `pkg.N`（修飾 const）
    fn selector(self: *Lowerer, sel: ast.Selector) Error!Val {
        if (sel.base.* == .ident and self.lookup(sel.base.ident.name) == null) {
            if (self.cur_pkg.imports.get(sel.base.ident.name)) |path| {
                if (sel.field.len == 0 or !std.ascii.isUpper(sel.field[0])) return self.fail(error.Unexported, sel.tok, sel.field);
                const pkg = self.pkgByPath(path) orelse return self.fail(error.UndefinedName, sel.tok, path);
                if (try self.constIn(pkg, sel.field, sel.tok)) |v| return v;
                if (try self.fnValueIn(pkg, sel.field, sel.tok)) |v| return v;
                return self.fail(error.UndefinedName, sel.tok, sel.field);
            }
        }
        const base = try self.expr(sel.base);
        if (base.t == .never) return base;
        const f = try self.fieldOf(base.t, sel.field, sel.tok);
        return self.loadVal(base.v, f.offset, f.t);
    }

    /// composite リテラル: 新しいスロットに位置か名前でフィールドを埋める。名前指定で省いたフィールドは 0。
    /// 型名が variant なら union 値（語 0 にタグ、ペイロードは語 1 から）。`T{}` はゼロ値（codegen composite と同じ）
    pub fn composite(self: *Lowerer, c: ast.Composite) Error!Val {
        const k = try self.resolveName(c.type_name, c.tok);
        const inst: ?*StructInfo = if (c.type_args.len > 0) try types.instStruct(self, c.type_name, c.type_args, c.tok) else null;
        var t: Type = undefined;
        var fields: []const FieldInfo = undefined;
        var base: u32 = 0;
        var tag: ?u32 = null;
        if (inst orelse self.structs.get(k)) |s| {
            try types.layoutStruct(self, s);
            t = .{ .struct_ = s };
            fields = s.fields;
        } else if (self.variants.get(k)) |vr| {
            try types.layoutUnion(self, vr.u);
            t = .{ .union_ = vr.u };
            fields = vr.u.variants[vr.index].fields;
            base = 1;
            tag = vr.u.variants[vr.index].tag;
        } else return self.fail(error.UndefinedType, c.tok, c.type_name);

        const keyed = c.elems.len > 0 and c.elems[0].key != null;
        for (c.elems) |el| if ((el.key != null) != keyed) return self.fail(error.Unsupported, c.tok, "mixing positional and named fields");
        // 値を全部評価してから書く（評価中の式が同じ型のリテラルを作ってもよい）
        const vals = try self.a().alloc(Val, c.elems.len);
        const offs = try self.a().alloc(u32, c.elems.len);
        if (keyed) {
            for (c.elems, 0..) |el, i| for (c.elems[0..i]) |prev| if (std.mem.eql(u8, prev.key.?, el.key.?))
                return self.fail(error.Redeclared, el.value.tok(), el.key.?);
            for (c.elems, vals, offs) |el, *v, *off| {
                const f = findField(fields, el.key.?) orelse return self.fail(error.UndefinedField, el.value.tok(), el.key.?);
                v.* = try self.exprExpecting(el.value, f.t, el.value.tok());
                if (v.t == .never) return v.*;
                v.* = try self.copyVal(v.*);
                off.* = base + f.offset;
            }
        } else if (c.elems.len > 0 or fields.len == 0) {
            if (c.elems.len != fields.len) return self.fail(error.ArityMismatch, c.tok, "positional literal must set every field");
            for (c.elems, fields, vals, offs) |el, f, *v, *off| {
                v.* = try self.exprExpecting(el.value, f.t, el.value.tok());
                if (v.t == .never) return v.*;
                v.* = try self.copyVal(v.*);
                off.* = base + f.offset;
            }
        } else {
            // ゼロ値リテラル `T{}`: int 0・bool false・T? は nil（タグ 0）・struct はフィールドごと
            for (fields) |f| try self.requireZero(f.t, c.tok);
        }
        const p = try self.newAgg(t);
        const zero = try self.b.iconst(0);
        for (0..t.words()) |w| try self.b.store(p, @intCast(w), zero);
        if (tag) |tg| try self.b.store(p, 0, try self.b.iconst(tg));
        // `T{}` の slice / map フィールドは現在の region の先端を指す空ヘッダ（codegen zeroFill。名前指定で省いたものは全 0）
        if (c.elems.len == 0) for (fields) |f| try cont.zeroFill(self, p, base + f.offset, f.t);
        for (vals, offs) |v, off| try self.storeVal(p, off, v);
        return .{ .t = t, .v = p };
    }

    /// ゼロ値を持つ型か（codegen zeroFill の受理範囲）
    pub fn requireZero(self: *Lowerer, t: Type, tok: ast.Pos) Error!void {
        switch (t) {
            .int, .bool_, .opt, .slice_, .map_ => {},
            .struct_ => |s| for (s.fields) |f| try self.requireZero(f.t, tok),
            else => return self.fail(error.TypeMismatch, tok, "a zero-value literal T{} needs every field to have a zero value"),
        }
    }

    /// 型 t の値を要求する（never はそのまま通す — 呼び手が到達しないことを見る）
    pub fn want(self: *Lowerer, v: Val, t: Type, tok: ast.Pos) Error!void {
        if (!v.t.eql(t)) return self.fail(error.TypeMismatch, tok, @tagName(t));
    }

    fn binary(self: *Lowerer, bin: ast.Binary) Error!Val {
        if (bin.op == .ampersand_ampersand or bin.op == .pipe_pipe) return self.shortCircuit(bin);
        // `x == nil` / `x != nil`: T? のタグ検査（語 0 が 0 なら nil）
        if ((bin.op == .equal_equal or bin.op == .bang_equal) and (bin.lhs.* == .nil or bin.rhs.* == .nil)) {
            if (bin.lhs.* == .nil and bin.rhs.* == .nil) return self.fail(error.TypeMismatch, bin.tok, "comparing nil with nil");
            const side = try self.expr(if (bin.lhs.* == .nil) bin.rhs else bin.lhs);
            if (side.t == .never) return side;
            if (side.t != .opt) return self.fail(error.TypeMismatch, bin.tok, "nil comparison on a non-optional value");
            const tagv = try self.b.load(side.v, 0);
            return .{ .t = .bool_, .v = try self.b.cmp(if (bin.op == .equal_equal) .eq else .ne, tagv, try self.b.iconst(0)) };
        }
        const l = try self.expr(bin.lhs);
        if (l.t == .never) return l;
        // string の == / != / + はセル列の演算（language.md 21 節）
        if (l.t.isString() and (bin.op == .equal_equal or bin.op == .bang_equal or bin.op == .plus)) return cont.stringBinary(self, bin, l);
        const r = try self.expr(bin.rhs);
        if (r.t == .never) return r;
        const cmp: ?ir.CmpOp = switch (bin.op) {
            .equal_equal => .eq,
            .bang_equal => .ne,
            .less => .lt,
            .less_equal => .le,
            .greater => .gt,
            .greater_equal => .ge,
            else => null,
        };
        if (cmp) |op| {
            // == / != は int と bool、順序比較は int のみ
            if (!l.t.eql(r.t) or (l.t != .int and !(l.t == .bool_ and (op == .eq or op == .ne))))
                return self.fail(error.TypeMismatch, bin.tok, "comparison operands");
            return .{ .t = .bool_, .v = try self.b.cmp(op, l.v, r.v) };
        }
        try self.want(l, .int, bin.tok);
        try self.want(r, .int, bin.tok);
        return .{ .t = .int, .v = try self.arith(bin.op, l.v, r.v, bin.tok) };
    }

    /// int の二項演算（二項式と複合代入の共通部）
    fn arith(self: *Lowerer, op: Token.Tag, x: ir.Value, y: ir.Value, tok: ast.Pos) Error!ir.Value {
        const bop: ir.BinOp = switch (op) {
            .plus => .add,
            .minus => .sub,
            .star => .mul,
            .slash => .div,
            .percent => .rem,
            .ampersand => .and_,
            .pipe => .or_,
            .caret => .xor,
            .shl, .shr => return self.shift(op == .shl, x, y),
            else => return self.fail(error.Unsupported, tok, @tagName(op)),
        };
        return self.b.bin(bop, x, y);
    }

    /// シフト（Go 準拠 — codegen arith と同じ場合分け）: 負の量は panic（exit 101）、
    /// 量 ≥ 64 は << = 0・>> = 63 bit（0 / -1）に畳む。畳んだ後の量は 0..63 なので IR の shl / sar（6 bit マスク）と一致する
    fn shift(self: *Lowerer, left: bool, x: ir.Value, n: ir.Value) Error!ir.Value {
        const neg_b = try self.b.newBlock();
        const ok_b = try self.b.newBlock();
        const join = try self.b.newBlock();
        const res = try self.b.param(join, .i64);
        try self.b.condbr(try self.b.cmp(.lt, n, try self.b.iconst(0)), neg_b, &.{}, ok_b, &.{});
        self.b.cur = neg_b;
        self.b.exit(101);
        self.b.cur = ok_b;
        const over_b = try self.b.newBlock();
        const in_b = try self.b.newBlock();
        try self.b.condbr(try self.b.cmp(.gt, n, try self.b.iconst(63)), over_b, &.{}, in_b, &.{});
        self.b.cur = over_b;
        const over_v = if (left) try self.b.iconst(0) else try self.b.bin(.sar, x, try self.b.iconst(63));
        try self.b.br(join, &.{over_v});
        self.b.cur = in_b;
        try self.b.br(join, &.{try self.b.bin(if (left) .shl else .sar, x, n)});
        self.b.cur = join;
        return res;
    }

    /// a && b / a || b: 右辺は左辺で決まらないときだけ評価する
    fn shortCircuit(self: *Lowerer, bin: ast.Binary) Error!Val {
        const l = try self.expr(bin.lhs);
        if (l.t == .never) return l;
        try self.want(l, .bool_, bin.tok);
        const rhs = try self.b.newBlock();
        const join = try self.b.newBlock();
        const res = try self.b.param(join, .i64);
        if (bin.op == .ampersand_ampersand) {
            try self.b.condbr(l.v, rhs, &.{}, join, &.{l.v});
        } else {
            try self.b.condbr(l.v, join, &.{l.v}, rhs, &.{});
        }
        self.b.cur = rhs;
        const r = try self.expr(bin.rhs);
        if (r.t != .never) {
            try self.want(r, .bool_, bin.tok);
            try self.b.br(join, &.{r.v});
        }
        self.b.cur = join;
        return .{ .t = .bool_, .v = res };
    }

    fn unary(self: *Lowerer, u: ast.Unary) Error!Val {
        const x = try self.expr(u.operand);
        if (x.t == .never) return x;
        switch (u.op) {
            .minus => {
                try self.want(x, .int, u.tok);
                return .{ .t = .int, .v = try self.b.bin(.sub, try self.b.iconst(0), x.v) };
            },
            .caret => {
                try self.want(x, .int, u.tok);
                return .{ .t = .int, .v = try self.b.bin(.xor, x.v, try self.b.iconst(-1)) };
            },
            .bang => {
                try self.want(x, .bool_, u.tok);
                return .{ .t = .bool_, .v = try self.b.bin(.xor, x.v, try self.b.iconst(1)) };
            },
            else => return self.fail(error.Unsupported, u.tok, @tagName(u.op)),
        }
    }

    /// 腕の型を合わせる（codegen joinArm と同じ）: 一致か片方 never、片方が値なしなら値なし
    pub fn joinType(self: *Lowerer, acc: ?Type, t: Type, tok: ast.Pos) Error!Type {
        const x = acc orelse return t;
        if (x.eql(t)) return x;
        if (x == .never) return t;
        if (t == .never) return x;
        if (x == .none or t == .none) return .none;
        return self.fail(error.TypeMismatch, tok, "arms have different types");
    }

    /// 腕の末尾を合流させる。値のある型ならブロック引数で受ける（アグリゲートはアドレス）
    pub fn joinArms(self: *Lowerer, ends: []const ArmEnd, t: Type) Error!Val {
        if (t == .never or ends.len == 0) {
            self.b.cur = null;
            return Val.never;
        }
        const join = try self.b.newBlock();
        const ty = t.irTy();
        const res: ir.Value = if (ty) |x| try self.b.param(join, x) else 0;
        for (ends) |end| {
            self.b.cur = end.blk;
            if (ty != null) try self.b.br(join, &.{end.v.v}) else try self.b.br(join, &.{});
        }
        self.b.cur = join;
        return if (ty != null) .{ .t = t, .v = res } else Val.none;
    }

    const NilTest = struct { name: []const u8, some_in_then: bool };

    /// 条件が `x != nil` / `x == nil`（x は T? の名前）なら絞り込みの情報（codegen nilTest）
    fn nilTest(self: *Lowerer, cond: *const ast.Expr) ?NilTest {
        if (cond.* != .binary) return null;
        const bin = cond.binary;
        if (bin.op != .equal_equal and bin.op != .bang_equal) return null;
        const side = if (bin.lhs.* == .nil) bin.rhs else if (bin.rhs.* == .nil) bin.lhs else return null;
        if (side.* != .ident) return null;
        const l = self.lookup(side.ident.name) orelse return null;
        if (l.ty() != .opt) return null;
        return .{ .name = side.ident.name, .some_in_then = bin.op == .bang_equal };
    }

    /// if 式 / 文。then は腕（region 透過）、else はブロックなら腕・else if なら式。else 無しは none。
    /// `x != nil` / `x == nil` の条件は値のある側の腕で x をペイロードに絞る（flow typing）。
    /// want（T? の期待）があれば腕ごとに合わせてから合流する（腕に nil を書ける — codegen exprExpecting）
    fn ifExpr(self: *Lowerer, x: ast.If, want_t: ?Type) Error!Val {
        const nt = self.nilTest(x.cond);
        const c = try self.expr(x.cond);
        if (c.t == .never) return c;
        try self.want(c, .bool_, x.tok);
        const then_b = try self.b.newBlock();
        const else_b = try self.b.newBlock();
        try self.b.condbr(c.v, then_b, &.{}, else_b, &.{});

        var ends: [2]ArmEnd = undefined;
        var n: usize = 0;
        var t: ?Type = null;
        for (0..2) |arm| {
            self.b.cur = if (arm == 0) then_b else else_b;
            const narrow = nt != null and nt.?.some_in_then == (arm == 0);
            var v: Val = if (arm == 0)
                (if (narrow) try self.narrowedArm(nt.?.name, x.then) else try self.armValue(x.then))
            else if (x.else_) |el|
                (if (el.* != .block) (if (want_t) |w| try self.exprExpecting(el, w, x.tok) else try self.expr(el)) else if (narrow) try self.narrowedArm(nt.?.name, el.block) else try self.armValue(el.block))
            else
                Val.none;
            if (want_t) |w| if (self.b.cur != null and v.t != .none) {
                v = try self.coerce(v, w, x.tok);
            };
            t = try self.joinType(t, if (self.b.cur == null) .never else v.t, x.tok);
            if (self.b.cur) |blk| {
                ends[n] = .{ .blk = blk, .v = v };
                n += 1;
            }
        }
        if (x.else_ == null) t = if (t.? == .never) .never else .none;
        return self.joinArms(ends[0..n], t.?);
    }
    fn switchExpr(self: *Lowerer, sw: ast.Switch) Error!Val {
        return lower_switch.switchExpr(self, sw);
    }

    /// `lhs |> f(args)`: 左辺（多値可）を 1 回評価し、穴 `_` へ順に、穴が無ければ第 1 引数へ渡す（codegen pipe と同じ）
    fn pipe(self: *Lowerer, p: ast.Pipe) Error!Results {
        // for 式（Iter[T]）は値にならない: 穴（無ければ第 1 引数）へ式のまま渡し、消費点で展開する（codegen pipe）
        if (p.lhs.* == .for_) {
            var holes: usize = 0;
            for (p.args) |x| holes += @intFromBool(x == null);
            if (holes > 1) return self.fail(error.HoleCountMismatch, p.tok, "a for expression is one value (one hole)");
            var fsrcs: std.ArrayListUnmanaged(ArgSrc) = .empty;
            if (holes == 0) try fsrcs.append(self.a(), .{ .expr = p.lhs });
            for (p.args) |x| try fsrcs.append(self.a(), .{ .expr = x orelse p.lhs });
            return self.callArgs(p.callee, fsrcs.items, p.tok);
        }
        const r = try self.evalMulti(p.lhs);
        if (isNever(r)) return r;
        if (r.len == 0) return self.fail(error.HoleCountMismatch, p.tok, "pipe left side has no value");
        var holes: usize = 0;
        for (p.args) |x| holes += @intFromBool(x == null);
        var srcs: std.ArrayListUnmanaged(ArgSrc) = .empty;
        if (holes == 0) {
            if (r.len != 1) return self.fail(error.HoleCountMismatch, p.tok, "multi-value pipe needs one hole per value");
            try srcs.append(self.a(), .{ .val = r[0] });
        } else if (holes != r.len) return self.fail(error.HoleCountMismatch, p.tok, "hole count differs from the number of piped values");
        var next_hole: usize = 0;
        for (p.args) |x| {
            if (x) |e| {
                try srcs.append(self.a(), .{ .expr = e });
            } else {
                try srcs.append(self.a(), .{ .val = r[next_hole] });
                next_hole += 1;
            }
        }
        return self.callArgs(p.callee, srcs.items, p.tok);
    }

    pub fn argVal(self: *Lowerer, src: ArgSrc, want_t: Type, tok: ast.Pos) Error!Val {
        return switch (src) {
            .expr => |e| self.exprExpecting(e, want_t, tok),
            .val => |v| self.coerce(v, want_t, tok),
        };
    }

    fn callArgs(self: *Lowerer, callee0: *const ast.Expr, srcs: []const ArgSrc, tok: ast.Pos) Error!Results {
        // 明示の型引数 `f[T](...)`（syntax.md 9 節: index + call と同形。型名の index をここで型適用として読む — codegen callFunc）
        var explicit: ?ast.TypeExpr = null;
        var callee = callee0;
        if (callee0.* == .index) {
            const ix = callee0.index;
            const tname: ?[]const u8 = switch (ix.idx.*) {
                .ident => |id| id.name,
                .selector => |sel| if (sel.base.* == .ident) try std.fmt.allocPrint(self.a(), "{s}.{s}", .{ sel.base.ident.name, sel.field }) else null,
                else => null,
            };
            if (tname) |tn| {
                explicit = .{ .name = tn };
                callee = ix.base;
            }
        }
        var pkg: *const ast.Pkg = undefined;
        var name: []const u8 = undefined;
        switch (callee.*) {
            .ident => |id| {
                if (std.mem.eql(u8, id.name, "println")) return self.println(srcs, tok);
                if (try cont.builtin(self, id.name, srcs, tok)) |r| return r;
                if (self.lookup(id.name)) |l| return switch (l) {
                    .closure => |c| inl.lambdaCall(self, c, srcs, tok),
                    else => if (l.ty() == .fnv) self.callIndirect(callee, srcs, tok) else self.fail(error.Unsupported, tok, "calling a local value"),
                };
                pkg = self.cur_pkg;
                name = id.name;
            },
            .selector => |sel| {
                // pkg.F（import の参照名）。base が import の参照名でなければ値（関数型フィールド）の呼び出し
                if (sel.base.* != .ident or self.lookup(sel.base.ident.name) != null or !self.cur_pkg.imports.contains(sel.base.ident.name))
                    return self.callIndirect(callee, srcs, tok);
                const path = self.cur_pkg.imports.get(sel.base.ident.name).?;
                pkg = self.pkgByPath(path) orelse return self.fail(error.UndefinedName, sel.tok, path);
                if (sel.field.len == 0 or !std.ascii.isUpper(sel.field[0])) return self.fail(error.Unexported, sel.tok, sel.field);
                name = sel.field;
            },
            else => return self.fail(error.Unsupported, tok, "call target must be a function name"),
        }
        const decl = findDecl(pkg, name) orelse return self.fail(error.UndefinedFunction, callee.tok(), name);
        if (decl.type_params.len > 0) return inl.genericCall(self, pkg, decl, explicit, srcs, tok);
        if (explicit != null) return self.fail(error.TypeMismatch, tok, "type arguments to a non-generic function");
        if (decl.expands) return inl.inlineCall(self, try inl.sigIn(self, decl, pkg, &.{}), srcs, tok, &.{});
        return self.callDirect((try self.funcByKey(pkg, name)).?, srcs, tok);
    }

    pub fn callDirect(self: *Lowerer, fi: *const FnInfo, srcs: []const ArgSrc, tok: ast.Pos) Error!Results {
        if (srcs.len != fi.params.len) return self.fail(error.ArityMismatch, tok, fi.decl.name);
        return self.emitCall(.{ .direct = fi.id }, fi.params, fi.results, srcs, tok, fi.decl);
    }

    /// 関数値（callee の値）の間接呼び出し。呼び出し規約は直接呼び出しと同じ。関数値を先に評価する（codegen callIndirect）
    fn callIndirect(self: *Lowerer, callee: *const ast.Expr, srcs: []const ArgSrc, tok: ast.Pos) Error!Results {
        const f = try self.expr(callee);
        if (f.t == .never) return never_results;
        const ft = switch (f.t) {
            .fnv => |x| x,
            else => return self.fail(error.TypeMismatch, tok, "calling a non-function value"),
        };
        if (ft.params.len != srcs.len) return self.fail(error.ArityMismatch, tok, "function value call");
        return self.emitCall(.{ .indirect = f.v }, ft.params, ft.results, srcs, tok, null);
    }

    const CallTarget = union(enum) { direct: ir.FuncId, indirect: ir.Value };

    /// decl: 直接呼び出しの宣言（mut 仮引数の位置を知るため — 関数値の呼び出しは null。mut_def は関数値にならない）
    fn emitCall(self: *Lowerer, to: CallTarget, params: []const Type, results: []const Type, srcs: []const ArgSrc, tok: ast.Pos, decl: ?*const ast.FuncDecl) Error!Results {
        const sret = types.sretOf(results);
        var args: std.ArrayListUnmanaged(ir.Value) = .empty;
        const sret_p: ?ir.Value = if (sret) blk: {
            var total: u32 = 0;
            for (results) |t| total += t.words();
            // 結果スロットのアドレスは第 0 引数（スロットは入口で取るので先に作ってよい）
            const p = try self.b.slotaddr(try self.b.newSlot(@max(total, 1)));
            try args.append(self.a(), p);
            break :blk p;
        } else null;
        for (srcs, params, 0..) |src, pt, i| {
            if (decl) |d| if (isMutParam(d, i)) {
                // 呼び手のセルのアドレス（mut 仮引数を転送するときは受け取ったアドレスそのもの — 同じ .cell）
                const l = try inl.mutArgCell(self, src, tok);
                if (!l.cell.t.eql(pt)) return self.fail(error.TypeMismatch, tok, "mut argument type differs from the parameter");
                try args.append(self.a(), l.cell.p);
                continue;
            };
            const v = try self.argVal(src, pt, tok);
            if (v.t == .never) return never_results;
            // アグリゲートは評価した直後に語へ展開する（codegen の pushRaxValue と同じ時点）
            if (v.t.isScalar()) {
                try args.append(self.a(), v.v);
            } else for (0..v.t.words()) |w| try args.append(self.a(), try self.b.load(v.v, @intCast(w)));
        }
        const out = try self.a().alloc(Val, results.len);
        const ret_ty: ?ir.Ty = if (sret or results.len == 0) null else .i64;
        const r = switch (to) {
            .direct => |id| try self.b.call(id, args.items),
            .indirect => |fv| try self.b.callIndirect(fv, args.items, ret_ty),
        };
        if (sret_p) |p| {
            var off: u32 = 0;
            for (results, out) |t, *v| {
                v.* = try self.loadVal(p, off, t);
                off += t.words();
            }
        } else if (results.len == 1) out[0] = .{ .t = results[0], .v = r.? };
        return out;
    }

    /// 全引数を先に評価してから書く（Go の順 — codegen io-4 と同じ）。空白区切り + 改行
    fn println(self: *Lowerer, srcs: []const ArgSrc, tok: ast.Pos) Error!Results {
        const vals = try self.a().alloc(Val, srcs.len);
        for (srcs, vals) |src, *v| {
            const x = switch (src) {
                .expr => |e| try self.expr(e),
                .val => |x| x,
            };
            if (x.t == .never) return never_results;
            if (x.t != .int and x.t != .bool_ and !x.t.isString()) return self.fail(error.Unsupported, tok, "println of a non-int value");
            v.* = x;
        }
        for (vals, 0..) |v, i| {
            {
                if (v.t.isString()) {
                    _ = try self.b.call(self.rt.print_str, &.{v.v});
                } else if (v.t == .int) {
                    _ = try self.b.call(self.rt.print_int, &.{v.v});
                } else {
                    const t_b = try self.b.newBlock();
                    const f_b = try self.b.newBlock();
                    const done = try self.b.newBlock();
                    try self.b.condbr(v.v, t_b, &.{}, f_b, &.{});
                    for ([_]ir.BlockId{ t_b, f_b }, [_][]const u8{ "true", "false" }) |blk, word| {
                        self.b.cur = blk;
                        try self.printChars(word);
                        try self.b.br(done, &.{});
                    }
                    self.b.cur = done;
                }
            }
            if (i + 1 < vals.len) try self.printChars(" ");
        }
        try self.printChars("\n");
        return &.{};
    }

    fn printChars(self: *Lowerer, s: []const u8) Error!void {
        for (s) |ch| _ = try self.b.call(self.rt.print_char, &.{try self.b.iconst(ch)});
    }
};
