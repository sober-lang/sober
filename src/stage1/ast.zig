//! Sober の AST（Phase 1 の範囲）。
//! CST（peg.CstNode の森）から cst_to_ast.zig が組み立てる。ノードは arena に置き、ポインタで結ぶ。
//! Phase 1 で扱わない構文は cst_to_ast が error.Unsupported で拒否する（型は無い。全て int と見做す）。
const std = @import("std");
const Token = @import("token.zig");
const srcpos = @import("srcpos.zig");
/// AST の tok はすべてこの座標（全ソース通しのトークン番号 — srcpos.zig）
pub const Pos = srcpos.Pos;

pub const Ast = struct {
    arena: std.heap.ArenaAllocator,
    file: *File,

    pub fn deinit(self: *Ast) void {
        self.arena.deinit();
    }
};

pub const File = struct {
    package: []const u8,
    imports: []const Import = &.{},
    types: []const *TypeDecl,
    funcs: []const *FuncDecl,
    consts: []const *ConstDecl = &.{},
};

/// `import "util/strings"` / `import ustr "util/strings"`（language.md 20 節）。
/// path はプロジェクトルート相対。参照名は alias か path の末尾要素
pub const Import = struct { alias: ?[]const u8, path: []const u8, tok: Pos };

/// トップレベルの `const N = 式`（const 式のみ — 決定 14）。
/// int の const は value をロード時（loader.zig）に畳んで埋める。
/// 辞書 const（struct リテラル — 閉じたラムダ / 関数参照 / int const / 入れ子の辞書だけからなる）は
/// dict = true で expr を保持し、参照点で宣言側の文脈のまま展開する（同一性は保証しない）
pub const ConstDecl = struct {
    name: []const u8,
    expr: *Expr,
    value: ?i64 = null,
    dict: bool = false,
    tok: Pos,
    /// `@embed("glob")`（language.md 20 節 — go:embed の意味論）のパターン（ルート相対）。loader が const 畳み込みの段で
    /// パターンに合うファイルを読み、expr（受け皿 `map[string]string{}`）を「パス → 内容」の map リテラルに置き換えて dict にする
    embed: ?[]const u8 = null,
    /// トップレベル宣言のトークン範囲（`.sobi` の切り出し用 — iface.zig）。`const a, b = …` は同じ範囲を共有する
    span: Span = .{},
};

/// トップレベル宣言のトークン範囲 [start, end)（注釈込み・末尾の ';' 込み。Pos 座標）
pub const Span = struct { start: Pos = 0, end: Pos = 0 };

/// 名前解決の単位（language.md 20 節）。path はルート相対、name = ディレクトリ名（main は例外）
pub const Pkg = struct {
    path: []const u8,
    name: []const u8,
    files: []const *File,
    /// 参照名（alias か path 末尾）→ import 先の pkg path
    imports: std.StringHashMapUnmanaged([]const u8) = .empty,

    /// package のトップレベル名（const・func・型・union の variant）か。
    /// ローカル束縛はこれと同名にできず（syntax.md 決定 13 の延長）、パターン位置の裸の識別子は
    /// これに当たれば比較になる（9 節）。desugar と codegen が同じこの判定を使う
    pub fn hasTopName(self: *const Pkg, name: []const u8) bool {
        for (self.files) |file| {
            for (file.consts) |c| if (std.mem.eql(u8, c.name, name)) return true;
            for (file.funcs) |f| if (std.mem.eql(u8, f.name, name)) return true;
            for (file.types) |td| {
                if (std.mem.eql(u8, td.name, name)) return true;
                if (td.body == .union_) for (td.body.union_) |v| if (std.mem.eql(u8, v.name, name)) return true;
            }
        }
        return false;
    }

    /// package のどれかのファイルが import した参照名（alias か path 末尾）か。
    /// ローカル束縛はこれと同名にできない（決定 13 の延長 — 2026-09-27 追加裁定）
    pub fn hasImportName(self: *const Pkg, name: []const u8) bool {
        for (self.files) |file| {
            for (file.imports) |imp| {
                const ref = imp.alias orelse std.fs.path.basename(imp.path);
                if (std.mem.eql(u8, ref, name)) return true;
            }
        }
        return false;
    }

    /// トップレベルの型名（type 宣言）か。型パラメータはこれと同名にできない（同上）
    pub fn hasTypeName(self: *const Pkg, name: []const u8) bool {
        for (self.files) |file| {
            for (file.types) |td| if (std.mem.eql(u8, td.name, name)) return true;
        }
        return false;
    }
};

pub const Program = struct {
    pkgs: []const *Pkg,
    main: *Pkg,
    /// tok（Pos）→ path:line:col の解決表。loader が parse 順に積む
    srcmap: srcpos.SourceMap = .{},
    /// 組み込みの `error` 型（V4-4a、language.md 13 節）: ロードした全 package の error ラベルを
    /// ロード順 × 宣言順に並べた閉じた union。loader が組む（リンク時に世界が閉じる — 各 Variant.pkg が宣言側）
    errors: *const TypeDecl = &no_errors,

    /// 本体なし宣言（`.sobi` から読んだ関数）の最初の 1 つ。codegen と通常の脱糖は本体を要るので、これがあれば拒否する
    pub fn firstBodiless(self: *const Program) ?*const FuncDecl {
        for (self.pkgs) |pkg| {
            for (pkg.files) |file| {
                for (file.funcs) |f| if (f.bodiless) return f;
            }
        }
        return null;
    }
};

pub const no_errors: TypeDecl = .{ .name = "error", .body = .{ .union_ = &.{} }, .tok = 0 };

/// `type Name struct { ... }` / `type Name union { V { ... } ... }`
pub const TypeDecl = struct {
    name: []const u8,
    /// 型パラメータ（V3-3: `type Ord[T] struct {...}`）。空なら非ジェネリック
    type_params: []const []const u8 = &.{},
    /// func_ は名前付き関数型 `type Iter[T] func(func(T))`（language.md 14 節。nominal 検査は断片外 — 構造で解決する）
    /// error_ はエラーラベル `type NotFound error { id int }`（V4-4a）。型としては使えず、
    /// 値は組み込みの `error`（Program.errors）の variant になる
    body: union(enum) { struct_: []const Field, union_: []const Variant, func_: *const FuncType, error_: []const Field },
    tok: Pos,
    span: Span = .{},
};

/// union の variant。構築は composite literal `V{...}`、分解は型パターン `V{f}`（決定 2）
pub const Variant = struct {
    name: []const u8,
    fields: []const Field,
    tok: Pos,
    /// フィールド型を解決する宣言側 package。error ラベル（Program.errors）だけが持つ — 普通の union は宣言の pkg
    pkg: ?*const Pkg = null,
};

pub const Field = struct {
    name: []const u8,
    type: TypeExpr,
    tok: Pos,
};

/// 型の書き方（Phase 1 は名前と関数型だけ）
pub const TypeExpr = union(enum) {
    name: []const u8,
    func: *const FuncType,
    /// `T?`（language.md 15 節。nil を取れるのは opt だけ）
    opt: *const TypeExpr,
    /// `[]T` / `mut []T`（imm がデフォルト — language.md 22 節。string = imm byte slice は name "string"）
    slice_of: struct { elem: *const TypeExpr, mut: bool },
    /// `map[K]V` / `mut map[K]V`（language.md 22 節） -/
    map_of: struct { key: *const TypeExpr, value: *const TypeExpr, mut: bool },
    /// ジェネリック型の適用 `Ord[int]`（V3-3）
    generic: struct { name: []const u8, args: []const TypeExpr },
};

pub const FuncType = struct { params: []const TypeExpr, results: []const TypeExpr };

pub const FuncDecl = struct {
    name: []const u8,
    /// 型パラメータ（V3-3: `func sort[T](...)`）。空なら非ジェネリック
    type_params: []const []const u8 = &.{},
    params: []const Param,
    results: []const TypeExpr,
    body: *Block,
    /// 関数型の引数を持つ関数。Phase 1 の codegen はこれを呼び出し点に展開する（展開は言語の規則ではなく生成方式）
    expands: bool,
    tok: Pos,
    /// 本体（中のラムダ込み）で呼んでいる名前（`F` / `ref.F` の綴りのまま — 解決は loader）。
    /// mut 引数の関数の再帰判定（region 多相の裁定 R2、K-a）に使う
    callees: []const []const u8 = &.{},
    /// mut 引数を持つが展開せず Def として呼ぶ関数（R2 K-a: 再帰する mut 引数の関数。呼び出しは anchor つき callM）。
    /// loader が呼び出しグラフの循環で決める。expands は false になる
    mut_def: bool = false,
    /// `@noinline`: 非再帰の mut 引数関数を呼び出し点に展開せず Def として呼ぶ（loader が mut_def に合流させる）。
    /// 観測不能 — 実行結果は変わらず、IR の大きさと check の座標条件（anchor 1 slot）だけが変わる
    no_inline: bool = false,
    /// 本体（中のラムダ込み）に後置 `?` があるか（V4-4b）。ゼロ値の入口束縛（Z1）を置くかの判定に使う
    has_try: bool = false,
    /// 本体なし宣言 `func F(x int) int`（`.sobi` の中だけで書ける — language.md 29 節）。body は空ブロック
    bodiless: bool = false,
    span: Span = .{},
    /// signature の終わり（排他）。本体なし宣言として切り出すときの末尾
    sig_end: Pos = 0,
};

pub const Param = struct {
    name: []const u8,
    type: TypeExpr,
    /// mut 引数（V3-5）: 呼び手の mut ローカルへの参照。実引数は `mut x` と印を付ける。
    /// この引数を持つ関数は呼び出し点に展開する（再帰は拒否 — 関数型引数と同じ実装制限）
    mutable: bool = false,
};

pub const Block = struct {
    stmts: []const Stmt,
    /// 式位置のブロックでは最後の文が式文ならその値。文位置では意味を持たない
    pub fn tailExpr(self: Block) ?*Expr {
        if (self.stmts.len == 0) return null;
        return switch (self.stmts[self.stmts.len - 1]) {
            .expr => |e| e,
            else => null,
        };
    }
};

pub const Stmt = union(enum) {
    bind: Bind,
    assign: Assign,
    ret: Return,
    expr: *Expr,
    while_: While,
    break_: Pos,
    continue_: Pos,
    defer_: Defer,
    /// `yield e`（for 本体の字句的内側のみ — 位置は cst_to_ast が検査する）
    yield_: Yield,
};

pub const Yield = struct { expr: *Expr, tok: Pos };

/// `defer e`。ブロックスコープ。式全体をブロック出口で評価し、値は捨てる（決定 17）
pub const Defer = struct { expr: *Expr, tok: Pos };

pub const Bind = struct {
    names: []const []const u8,
    mutable: bool,
    values: []const *Expr,
    tok: Pos,
};

pub const Assign = struct {
    targets: []const *Expr,
    /// '=' または複合代入のトークン（plus_equal 等）
    op: Token.Tag,
    values: []const *Expr,
    tok: Pos,
};

pub const Return = struct {
    values: []const *Expr,
    tok: Pos,
};

pub const While = struct {
    cond: *Expr,
    body: *Block,
    tok: Pos,
};

pub const Expr = union(enum) {
    int: Int,
    /// `nil`（識別子でなくリテラル。AST 層判定 — syntax.md 9 節と同じ扱い）
    nil: Nil,
    ident: Ident,
    binary: Binary,
    unary: Unary,
    call: Call,
    pipe: Pipe,
    /// `xs[i]`
    index: Index,
    slice3: Slice3,
    /// 文字列リテラル（imm byte slice — language.md 21 節）
    strlit: StrLit,
    /// 補間つき文字列 `"a${x}b"`（syntax.md 5.4）。連結の連鎖への脱糖は型が要るので各層（desugar /
    /// codegen）が lowerInterp で行う
    interp: Interp,
    /// slice リテラル `[]T{e, ...}` / `mut []T{e, ...}`
    slicelit: SliceLit,
    /// map リテラル `map[K]V{k: v, ...}` / `mut map[K]V{...}`
    maplit: MapLit,
    composite: Composite,
    selector: Selector,
    lambda: Lambda,
    if_: If,
    switch_: Switch,
    block: *Block,
    /// `for x <- src if g yield e` / `for x <- src { ...; yield v }`（language.md 7 節）。
    /// 値は Iter[T] で、関数型の引数位置でだけ消費する（F1: 消費点での融合展開）
    for_: ForExpr,
    /// 実引数位置の `mut x`（mut 引数への参照渡しの印 — V3-5）。他の位置には現れない
    mut_arg: MutArg,
    /// 後置 `?`（V4-4b、language.md 13 節）: `f()?` は最後の結果 error? が非 nil なら囲みの関数から
    /// ゼロ値 + err で return（行き先は return と同じ）。wrap があれば err を `L{…}` に置き換える（V4-4c。cause は無い — K3）
    try_: Try,

    pub fn tok(self: Expr) Pos {
        return switch (self) {
            .int => |n| n.tok,
            .nil => |n| n.tok,
            .ident => |n| n.tok,
            .binary => |n| n.tok,
            .unary => |n| n.tok,
            .call => |n| n.tok,
            .pipe => |n| n.tok,
            .index => |n| n.tok,
            .slice3 => |n| n.tok,
            .strlit => |n| n.tok,
            .interp => |n| n.tok,
            .slicelit => |n| n.tok,
            .maplit => |n| n.tok,
            .composite => |n| n.tok,
            .selector => |n| n.tok,
            .lambda => |n| n.tok,
            .if_ => |n| n.tok,
            .switch_ => |n| n.tok,
            .block => 0,
            .for_ => |n| n.tok,
            .mut_arg => |n| n.tok,
            .try_ => |n| n.tok,
        };
    }
};

pub const Int = struct { value: i64, tok: Pos };
pub const ForExpr = struct { gens: []const Generator, body: ForBody, tok: Pos };
/// `x <- src if g1 if g2`
pub const Generator = struct { names: []const []const u8, src: *Expr, guards: []const *Expr, tok: Pos };
pub const ForBody = union(enum) { yield_: *Expr, block: *Block };
pub const Nil = struct { tok: Pos };
pub const Index = struct { base: *Expr, idx: *Expr, tok: Pos };
/// `xs[a:b]`（imm slice / string 限定 — language.md 21 節）
pub const Slice3 = struct { base: *Expr, lo: *Expr, hi: *Expr, tok: Pos };
pub const StrLit = struct { value: []const u8, tok: Pos };

/// テンプレート（補間つき文字列）の正規形: 定数部 lits（エスケープ解決済み、len = holes.len + 1 — 穴の隣接や
/// 端でも空文字列を置く）と穴の式 holes を分けたまま持つ。連結への脱糖は各層（interp.zig）の仕事で、この形は
/// 将来のタグ付きテンプレート（`sql"..."` → 定数部の配列と穴の値を分けて渡す呼び出し — language.md 未決）が
/// そのまま受け取れる中間形として字句解釈から切り離してある
pub const Template = struct { lits: []const []const u8, holes: []const *Expr };
pub const Interp = struct { tmpl: Template, tok: Pos };
pub const SliceLit = struct { elem: TypeExpr, elems: []const *Expr, mut: bool, tok: Pos };
pub const MapEntry = struct { key: *Expr, value: *Expr };
pub const MapLit = struct { key: TypeExpr, value: TypeExpr, entries: []const MapEntry, mut: bool, tok: Pos };
pub const Ident = struct { name: []const u8, tok: Pos };
pub const Binary = struct { op: Token.Tag, lhs: *Expr, rhs: *Expr, tok: Pos };
pub const MutArg = struct { name: []const u8, tok: Pos };
pub const Try = struct { e: *Expr, wrap: ?*const Composite, tok: Pos };
pub const Unary = struct { op: Token.Tag, operand: *Expr, tok: Pos };
pub const Call = struct { callee: *Expr, args: []const *Expr, tok: Pos };
/// `lhs |> callee(args)`。args の null は穴 `_`。穴が無ければ lhs は第 1 引数（language.md 4 節）
pub const Pipe = struct { lhs: *Expr, callee: *Expr, args: []const ?*Expr, tok: Pos };
/// `T{a, b}` / `T{x: a, y: b}`。key の有無は全要素で揃っていることを codegen が確かめる
pub const Composite = struct { type_name: []const u8, elems: []const Elem, tok: Pos, type_args: []const TypeExpr = &.{} };
pub const Elem = struct { key: ?[]const u8, value: *Expr };
pub const Selector = struct { base: *Expr, field: []const u8, tok: Pos };
/// `x => e` / `(a, b) => e` / `(a int, b int) => { ... }`。本体はブロック式か式。値は末尾式、中の return は囲みの名前付き関数から（決定 10）
pub const Lambda = struct { params: []const LambdaParam, body: *Expr, tok: Pos };
pub const LambdaParam = struct { name: []const u8, type: ?TypeExpr };
pub const If = struct {
    cond: *Expr,
    then: *Block,
    /// else 腕: ブロック式か入れ子の if 式。無ければ null
    else_: ?*Expr,
    tok: Pos,
};

pub const Switch = struct {
    /// subject。空なら bool case の if-else 連鎖。1 つの多値呼び出しなら結果の個数ぶんの subject
    subjects: []const *Expr,
    cases: []const Case,
    default_: ?*Block,
    tok: Pos,
};

pub const Case = struct {
    /// 1 subject に 1 パターン（subject 無しなら 1 つ）
    patterns: []const Pattern,
    body: *Block,
    tok: Pos,
};

/// case のパターン 1 つ
pub const Pattern = union(enum) {
    /// 定数パターン。`1 | 2` の最上位 '|' 連鎖は選択（alts に分ける）。`_` は何にでも一致する
    const_: []const *Expr,
    /// 型パターン `[name] Variant{field, field: pattern}`（決定 3）
    type_: TypePattern,
};

pub const TypePattern = struct {
    /// 値全体の束縛 `e NotFound{}`
    bind: ?[]const u8,
    variant: []const u8,
    fields: []const FieldPat,
    tok: Pos,
};

/// `f` はフィールド f を同名で束縛、`f: p` はフィールド f を p で照合
pub const FieldPat = struct { name: []const u8, sub: ?*const Pattern, tok: Pos };
