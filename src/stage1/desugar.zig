//! AST → コア AST（Featherweight Sober、lean/FeatherweightSober/Syntax.lean）。
//! スキーマの正は lean/FeatherweightSober/Json.lean。ここはそれに合わせて JSON を吐く。
//!
//! 検査単位は関数表（Δ）+ `main` の本体。inline 関数（expands）と
//! ラムダは呼び出し点に展開して消す。断片の外の構文は error.CoreFragment で拒否する。
//! 対応（docs/formal.md の各段の節が正）:
//! - ブロック / 文列 → `letE` の鎖（文位置の式は匿名束縛）。式位置の `{ }` は `block`（region 境界）
//! - 関数本体と main 本体は `block` で包む（alloc 規則が深さ 1 以上を要求する）
//! - `mut x := e` → `alloc true`、読み → `deref`、`x = v` → `assign`、`x += v` → `assign` + `add`
//! - union → `inl` / `inr` の入れ子、型パターンの switch → `case` の入れ子、struct → `pair` 鎖
//! - 定数パターン / subject 無し / 複数 subject の switch → `eq` + `ite` の連鎖（constSwitch）
//! - 演算子は add / lt + arith / cmp ファミリ + ビット演算。シフトと多値 subject switch は断片外
//! - 脱出（V4）: 関数本体と while は `label`、return / break / continue は `jump`（ラベルは id で作り、
//!   JSON 印字で de Bruijn 添字にする。jump に使われないラベルは印字しない）。defer はコアに無く、
//!   出口（ブロック末尾・jump）ごとに越えるスコープの defer を展開する（値確定 → defer → jump）
const std = @import("std");
const ast = @import("ast.zig");
const Token = @import("token.zig");
const forexpand = @import("forexpand.zig");
const interp = @import("interp.zig");

pub const Error = error{ CoreFragment, UnknownName, Malformed } || std.mem.Allocator.Error;

pub const Diag = struct {
    /// 座標（srcpos.zig）。表示は Program.srcmap で path:line:col に解決する
    pos: ast.Pos = 0,
    what: []const u8 = "",
    /// what の実体（arena はエラー時に解放されるので、合成した診断文はここへ写す）
    buf: [256]u8 = undefined,
};

// ────────────────────────────────────────────────────────────────
// コア AST（Lean の Ty / Expr と同形）
// ────────────────────────────────────────────────────────────────

pub const Ty = union(enum) {
    int,
    /// 型変数（V3-2）: ジェネリック Def の型パラメータへの添字
    tvar: u32,
    bool_,
    unit,
    opt: *const Ty,
    /// str = string（不透明なテキスト型。JSON では印を消して imm int slice として出す）
    slice: struct { m: bool, r: u32, t: *const Ty, str: bool = false },
    /// k = キー型（int | string — R3）、t = 値型。Lean ではセル型 prod k (opt t) を持つ（JSON は key / t）
    map: struct { m: bool, r: u32, k: *const Ty, t: *const Ty },
    union_: struct { l: *const Ty, r: *const Ty },
    /// 二項直積。struct は右結合の入れ子（n = 0 は unit、n = 1 は素の型）
    prod: struct { l: *const Ty, r: *const Ty },
    ref: struct { m: bool, r: u32, t: *const Ty },
    chan: struct { rc: u32, t: *const Ty },
    /// 閉じた関数値の型（V3-1）。p / r は Def のシグネチャと同じ base 座標
    /// （パラメータ列の prod 鎖 / 戻り値列の prod 鎖 — defOf と同じ組み立て）
    fn_: struct { p: *const Ty, r: *const Ty },
};

pub const CExpr = union(enum) {
    lit: i64,
    tt,
    ff,
    triv,
    var_: u32,
    let: struct { e: *const CExpr, body: *const CExpr },
    add: struct { a: *const CExpr, b: *const CExpr },
    lt: struct { a: *const CExpr, b: *const CExpr },
    /// arith / cmp ファミリ（Lean 側の Expr.arith / Expr.cmp）。
    /// kind は JSON の種別タグそのもの: sub / mul / div / mod / eq / ne / le / gt / ge
    bin: struct { kind: []const u8, a: *const CExpr, b: *const CExpr },
    ite: struct { c: *const CExpr, t: *const CExpr, e: *const CExpr },
    nil: *const Ty,
    some: *const CExpr,
    ifnil: struct { e: *const CExpr, nil_case: *const CExpr, some_case: *const CExpr },
    inl: struct { r: *const Ty, e: *const CExpr },
    inr: struct { l: *const Ty, e: *const CExpr },
    case: struct { e: *const CExpr, l: *const CExpr, r: *const CExpr },
    pair: struct { a: *const CExpr, b: *const CExpr },
    fst: *const CExpr,
    snd: *const CExpr,
    /// 一階関数の呼び出し（fn は関数表の index、引数は 1 つ — 多引数は pair 鎖に束ねる）
    /// m = anchor つき呼び出し（R2 — mut 引数を Def として渡す callM。JSON は "callm"）
    call: struct { fn_: u32, e: *const CExpr, ts: []const *const Ty = &.{}, m: bool = false },
    /// 名前付き関数の参照 = 閉じた関数値（V3-1）。ts は型引数（持ち上げたラムダが外側の tvar を運ぶ）
    fnref: struct { fn_: u32, ts: []const *const Ty = &.{} },
    /// 関数値の呼び出し（引数は call と同じく pair 鎖）
    callv: struct { f: *const CExpr, e: *const CExpr },
    /// 型注釈（V3-5）: inline 展開で消える仮引数の型・ラムダの引数 / 結果型を、注釈を置く点の座標で書く。
    /// Lean は `Ty.sub (e の型) t` を検査するだけ
    ann: struct { e: *const CExpr, t: *const Ty },
    block: *const CExpr,
    /// 出口で写すブロック（R5）: 値がブロックの region のコンテナを持つとき、出口で親の最内へ写す（jump の脱出と同じ境界コピー）。
    /// t は親の座標の結果型（Lean の blockR — JSON は block に "t"）
    blockR: struct { t: *const Ty, e: *const CExpr },
    alloc: struct { m: bool, e: *const CExpr },
    deref: *const CExpr,
    assign: struct { l: *const CExpr, e: *const CExpr },
    while_: struct { c: *const CExpr, body: *const CExpr },
    freeze: *const CExpr,
    mkslice: struct { m: bool, t: *const Ty },
    /// string リテラル（Lean の strlit — region r の imm int セル列）。r は常に 0（Def 本体・main の呼び手空間 / 最外 region）
    strlit: struct { bs: []const u8, r: u32 },
    /// t: 読み出しの型注釈（R4b-cov A-2 — imm セルは要素型の部分型で置かれうるので、注釈を持つ要素型は読んだ値を
    /// coerceTo で注釈型へ書き換える）。null は注釈なし（annFree な要素型か mut slice に限る — 検査が裁く）
    index: struct { e: *const CExpr, i: *const CExpr, t: ?*const Ty = null },
    lenE: *const CExpr,
    append: struct { e: *const CExpr, v: *const CExpr },
    setidx: struct { e: *const CExpr, i: *const CExpr, v: *const CExpr },
    /// `xs[a:b]`（imm 限定 — language.md 21 節）
    subslice: struct { e: *const CExpr, a: *const CExpr, b: *const CExpr },
    /// `s == t`（string = imm byte slice の比較）
    eqs: struct { a: *const CExpr, b: *const CExpr },
    /// `s + t`（imm slice の連結）
    concat: struct { a: *const CExpr, b: *const CExpr },
    mkmap: struct { m: bool, k: *const Ty, t: *const Ty },
    getm: struct { t: *const Ty, e: *const CExpr, k: *const CExpr },
    setm: struct { e: *const CExpr, k: *const CExpr, v: *const CExpr },
    delm: struct { t: *const Ty, e: *const CExpr, k: *const CExpr },
    lenm: *const CExpr,
    /// `keys(m)`（keysm の段）: 生きたキーの挿入順の列を最内 region に imm slice で（スナップショット）
    keysm: *const CExpr,
    par: struct { e1: *const CExpr, e2: *const CExpr },
    parch: struct { t: *const Ty, e1: *const CExpr, e2: *const CExpr },
    newchan: struct { rc: u32, t: *const Ty },
    send: struct { c: *const CExpr, e: *const CExpr },
    recv: *const CExpr,
    /// 脱出先のラベル（V4）。id は脱糖中の識別子で、JSON 印字が de Bruijn 添字へ直す。
    /// used = jump に参照されたか（参照されないラベルは印字しない — ラベルの無い既存の形を保つ）。
    /// wrap は印字時に本体へ掛ける整形（main 本体は値を捨てて unit、inline 展開は結果型の ann）
    label: struct { id: u32, t: *const Ty, e: *const CExpr, used: *bool, wrap: LabelWrap = .none },
    /// id のラベルへ e の値を持って脱出する。t は jump の位置の期待型（結果型の注釈 — 裁定 J1）
    jump: struct { id: u32, t: *const Ty, e: *const CExpr },
};

pub const LabelWrap = enum { none, discard, ann };

/// 一階関数の定義（Lean の Def と同形）。param はパラメータ列の prod 鎖、
/// ret は戻り値列の prod 鎖、body では引数の束が var 0
pub const CDef = struct {
    param: *const Ty,
    ret: *const Ty,
    body: *const CExpr,
    tparams: u32 = 0,
    /// 署名だけ（部分検査の封筒 — V5-6）: JSON に body を出さない。検査器は検査しない（Split.lean の checkDefsAt の枠）
    sig_only: bool = false,
};

pub const Core = struct {
    arena: std.heap.ArenaAllocator,
    defs: []const CDef,
    root: *const CExpr,
    /// Def ごとの記号名（比較専用の出力 toPkgJson が `"f"` の index の代わりに印字する — V5-5 裁定 N1）:
    /// 名前付き関数 `pkg.Name`・持ち上げたラムダ `<持ち主の Def>/lamK`・辞書 const のラムダ `pkg.Const#K`
    names: []const []const u8 = &.{},
    /// Def ごとの帰属 package のパス（持ち上げたラムダは持ち主の Def の package、辞書 const のラムダは const の package）
    owners: []const []const u8 = &.{},
    /// 名前付き関数の数（defs の先頭 n_named 個。残りは持ち上げたラムダ）
    n_named: usize = 0,

    pub fn deinit(self: *Core) void {
        self.arena.deinit();
    }
};

// ────────────────────────────────────────────────────────────────
// JSON 印字（スキーマは Json.lean 冒頭の列挙が正）
// ────────────────────────────────────────────────────────────────

pub fn toJson(allocator: std.mem.Allocator, core: Core) std.mem.Allocator.Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    var w = JsonWriter{ .allocator = allocator, .out = &out };
    defer w.labels.deinit(allocator);
    // 関数が無ければ素の式（Lean 側は両方受ける）。あれば {"defs":[...],"e":...} の封筒
    if (core.defs.len == 0) {
        try w.expr(core.root);
    } else {
        try w.raw("{\"defs\":[");
        for (core.defs, 0..) |d, i| {
            if (i > 0) try w.raw(",");
            try w.def(d);
        }
        try w.raw("],\"e\":");
        try w.expr(core.root);
        try w.raw("}");
    }
    return out.toOwnedSlice(allocator);
}

const JsonWriter = struct {
    allocator: std.mem.Allocator,
    out: *std.ArrayListUnmanaged(u8),
    /// 印字中の位置を囲む（印字した）ラベルの id。末尾が最内 = jump の de Bruijn 添字 0
    labels: std.ArrayListUnmanaged(u32) = .empty,
    /// 非 null なら `"f"` を index でなく記号名で印字する（比較専用 — toPkgJson）
    names: ?[]const []const u8 = null,

    fn def(self: *JsonWriter, d: CDef) std.mem.Allocator.Error!void {
        try self.raw("{");
        if (d.tparams > 0) {
            try self.raw("\"tparams\":");
            try self.int(d.tparams);
            try self.raw(",");
        }
        try self.raw("\"param\":");
        try self.ty(d.param);
        try self.raw(",\"ret\":");
        try self.ty(d.ret);
        if (!d.sig_only) {
            try self.raw(",\"body\":");
            try self.expr(d.body);
        }
        try self.raw("}");
    }

    fn fnIdx(self: *JsonWriter, idx: u32) std.mem.Allocator.Error!void {
        if (self.names) |ns| {
            try self.raw("\"");
            try self.raw(ns[idx]);
            try self.raw("\"");
        } else try self.int(idx);
    }

    fn raw(self: *JsonWriter, s: []const u8) std.mem.Allocator.Error!void {
        try self.out.appendSlice(self.allocator, s);
    }

    fn int(self: *JsonWriter, n: i64) std.mem.Allocator.Error!void {
        var buf: [24]u8 = undefined;
        const s = std.fmt.bufPrint(&buf, "{d}", .{n}) catch unreachable;
        try self.raw(s);
    }

    fn ty(self: *JsonWriter, t: *const Ty) std.mem.Allocator.Error!void {
        switch (t.*) {
            .int => try self.raw("{\"k\":\"int\"}"),
            .tvar => |i| {
                try self.raw("{\"k\":\"tvar\",\"i\":");
                try self.int(i);
                try self.raw("}");
            },
            .bool_ => try self.raw("{\"k\":\"bool\"}"),
            .unit => try self.raw("{\"k\":\"unit\"}"),
            .slice => |sl| {
                try self.raw("{\"k\":\"slice\",\"m\":");
                try self.raw(if (sl.m) "true" else "false");
                try self.raw(",\"r\":");
                try self.int(sl.r);
                try self.raw(",\"t\":");
                try self.ty(sl.t);
                try self.raw("}");
            },
            .map => |mp| {
                try self.raw("{\"k\":\"map\",\"m\":");
                try self.raw(if (mp.m) "true" else "false");
                try self.raw(",\"r\":");
                try self.int(mp.r);
                try self.raw(",\"key\":");
                try self.ty(mp.k);
                try self.raw(",\"t\":");
                try self.ty(mp.t);
                try self.raw("}");
            },
            .opt => |inner| {
                try self.raw("{\"k\":\"opt\",\"t\":");
                try self.ty(inner);
                try self.raw("}");
            },
            .union_ => |u| {
                try self.raw("{\"k\":\"union\",\"l\":");
                try self.ty(u.l);
                try self.raw(",\"r\":");
                try self.ty(u.r);
                try self.raw("}");
            },
            .prod => |u| {
                try self.raw("{\"k\":\"prod\",\"l\":");
                try self.ty(u.l);
                try self.raw(",\"r\":");
                try self.ty(u.r);
                try self.raw("}");
            },
            .ref => |r| {
                try self.raw("{\"k\":\"ref\",\"m\":");
                try self.raw(if (r.m) "true" else "false");
                try self.raw(",\"r\":");
                try self.int(r.r);
                try self.raw(",\"t\":");
                try self.ty(r.t);
                try self.raw("}");
            },
            .chan => |c| {
                try self.raw("{\"k\":\"chan\",\"rc\":");
                try self.int(c.rc);
                try self.raw(",\"t\":");
                try self.ty(c.t);
                try self.raw("}");
            },
            .fn_ => |f| {
                try self.raw("{\"k\":\"fn\",\"p\":");
                try self.ty(f.p);
                try self.raw(",\"r\":");
                try self.ty(f.r);
                try self.raw("}");
            },
        }
    }

    fn expr(self: *JsonWriter, e: *const CExpr) std.mem.Allocator.Error!void {
        switch (e.*) {
            .lit => |n| {
                try self.raw("{\"k\":\"lit\",\"n\":");
                try self.int(n);
                try self.raw("}");
            },
            .tt => try self.raw("{\"k\":\"true\"}"),
            .ff => try self.raw("{\"k\":\"false\"}"),
            .triv => try self.raw("{\"k\":\"triv\"}"),
            .var_ => |i| {
                try self.raw("{\"k\":\"var\",\"i\":");
                try self.int(i);
                try self.raw("}");
            },
            .let => |l| try self.node2("let", "e", l.e, "body", l.body),
            .add => |b| try self.node2("add", "a", b.a, "b", b.b),
            .lt => |b| try self.node2("lt", "a", b.a, "b", b.b),
            .bin => |b| try self.node2(b.kind, "a", b.a, "b", b.b),
            .ite => |i| try self.node3("if", "c", i.c, "t", i.t, "e", i.e),
            .nil => |t| {
                try self.raw("{\"k\":\"nil\",\"t\":");
                try self.ty(t);
                try self.raw("}");
            },
            .some => |inner| try self.node1("some", "e", inner),
            .ann => |an| {
                try self.raw("{\"k\":\"ann\",\"e\":");
                try self.expr(an.e);
                try self.raw(",\"t\":");
                try self.ty(an.t);
                try self.raw("}");
            },
            .ifnil => |i| try self.node3("ifnil", "e", i.e, "nil", i.nil_case, "some", i.some_case),
            .label => |l| {
                if (!l.used.*) return self.expr(l.e);
                try self.labels.append(self.allocator, l.id);
                defer _ = self.labels.pop();
                try self.raw("{\"k\":\"label\",\"t\":");
                try self.ty(l.t);
                try self.raw(",\"e\":");
                switch (l.wrap) {
                    .none => try self.expr(l.e),
                    .discard => {
                        try self.raw("{\"k\":\"let\",\"e\":");
                        try self.expr(l.e);
                        try self.raw(",\"body\":{\"k\":\"triv\"}}");
                    },
                    .ann => {
                        try self.raw("{\"k\":\"ann\",\"e\":");
                        try self.expr(l.e);
                        try self.raw(",\"t\":");
                        try self.ty(l.t);
                        try self.raw("}");
                    },
                }
                try self.raw("}");
            },
            .jump => |j| {
                // 添字 = 印字中の囲むラベルのうち、目標より内側にある数
                var n: i64 = 0;
                var k = self.labels.items.len;
                while (k > 0) : (n += 1) {
                    k -= 1;
                    if (self.labels.items[k] == j.id) break;
                } else unreachable;
                try self.raw("{\"k\":\"jump\",\"n\":");
                try self.int(n);
                try self.raw(",\"t\":");
                try self.ty(j.t);
                try self.raw(",\"e\":");
                try self.expr(j.e);
                try self.raw("}");
            },
            .inl => |i| {
                try self.raw("{\"k\":\"inl\",\"r\":");
                try self.ty(i.r);
                try self.raw(",\"e\":");
                try self.expr(i.e);
                try self.raw("}");
            },
            .inr => |i| {
                try self.raw("{\"k\":\"inr\",\"l\":");
                try self.ty(i.l);
                try self.raw(",\"e\":");
                try self.expr(i.e);
                try self.raw("}");
            },
            .case => |c| try self.node3("case", "e", c.e, "l", c.l, "r", c.r),
            .pair => |p| try self.node2("pair", "a", p.a, "b", p.b),
            .fst => |inner| try self.node1("fst", "e", inner),
            .snd => |inner| try self.node1("snd", "e", inner),
            .call => |c| {
                try self.raw(if (c.m) "{\"k\":\"callm\",\"f\":" else "{\"k\":\"call\",\"f\":");
                try self.fnIdx(c.fn_);
                if (c.ts.len > 0) {
                    try self.raw(",\"ts\":[");
                    for (c.ts, 0..) |t, i| {
                        if (i > 0) try self.raw(",");
                        try self.ty(t);
                    }
                    try self.raw("]");
                }
                try self.raw(",\"e\":");
                try self.expr(c.e);
                try self.raw("}");
            },
            .fnref => |f| {
                try self.raw("{\"k\":\"fnref\",\"f\":");
                try self.fnIdx(f.fn_);
                if (f.ts.len > 0) {
                    try self.raw(",\"ts\":[");
                    for (f.ts, 0..) |t, i| {
                        if (i > 0) try self.raw(",");
                        try self.ty(t);
                    }
                    try self.raw("]");
                }
                try self.raw("}");
            },
            .callv => |c| {
                try self.raw("{\"k\":\"callv\",\"f\":");
                try self.expr(c.f);
                try self.raw(",\"e\":");
                try self.expr(c.e);
                try self.raw("}");
            },
            .block => |inner| try self.node1("block", "e", inner),
            .blockR => |br| {
                try self.raw("{\"k\":\"block\",\"e\":");
                try self.expr(br.e);
                try self.raw(",\"t\":");
                try self.ty(br.t);
                try self.raw("}");
            },
            .alloc => |a| {
                try self.raw("{\"k\":\"alloc\",\"mut\":");
                try self.raw(if (a.m) "true" else "false");
                try self.raw(",\"e\":");
                try self.expr(a.e);
                try self.raw("}");
            },
            .deref => |inner| try self.node1("deref", "e", inner),
            .assign => |a| try self.node2("assign", "l", a.l, "e", a.e),
            .while_ => |w| try self.node2("while", "c", w.c, "body", w.body),
            .freeze => |inner| try self.node1("freeze", "e", inner),
            .strlit => |sl| {
                try self.raw("{\"k\":\"strlit\",\"bs\":[");
                for (sl.bs, 0..) |ch, i| {
                    if (i > 0) try self.raw(",");
                    try self.int(ch);
                }
                try self.raw("],\"r\":");
                try self.int(sl.r);
                try self.raw("}");
            },
            .mkslice => |m| {
                try self.raw("{\"k\":\"mkslice\",\"m\":");
                try self.raw(if (m.m) "true" else "false");
                try self.raw(",\"t\":");
                try self.ty(m.t);
                try self.raw("}");
            },
            .index => |ix| {
                try self.raw("{\"k\":\"index\",\"e\":");
                try self.expr(ix.e);
                try self.raw(",\"i\":");
                try self.expr(ix.i);
                if (ix.t) |t| {
                    try self.raw(",\"t\":");
                    try self.ty(t);
                }
                try self.raw("}");
            },
            .lenE => |inner| try self.node1("len", "e", inner),
            .append => |ap| try self.node2("append", "e", ap.e, "v", ap.v),
            .setidx => |sx| try self.node3("setidx", "e", sx.e, "i", sx.i, "v", sx.v),
            .subslice => |ss| try self.node3("subslice", "e", ss.e, "a", ss.a, "b", ss.b),
            .eqs => |b| try self.node2("eqs", "a", b.a, "b", b.b),
            .concat => |b| try self.node2("concat", "a", b.a, "b", b.b),
            .mkmap => |m| {
                try self.raw("{\"k\":\"mkmap\",\"m\":");
                try self.raw(if (m.m) "true" else "false");
                try self.raw(",\"key\":");
                try self.ty(m.k);
                try self.raw(",\"t\":");
                try self.ty(m.t);
                try self.raw("}");
            },
            .getm => |g| {
                try self.raw("{\"k\":\"getm\",\"t\":");
                try self.ty(g.t);
                try self.raw(",\"e\":");
                try self.expr(g.e);
                try self.raw(",\"key\":");
                try self.expr(g.k);
                try self.raw("}");
            },
            .setm => |s| try self.node3("setm", "e", s.e, "key", s.k, "v", s.v),
            .delm => |dl| {
                try self.raw("{\"k\":\"delm\",\"t\":");
                try self.ty(dl.t);
                try self.raw(",\"e\":");
                try self.expr(dl.e);
                try self.raw(",\"key\":");
                try self.expr(dl.k);
                try self.raw("}");
            },
            .lenm => |inner| try self.node1("lenm", "e", inner),
            .keysm => |inner| try self.node1("keysm", "e", inner),
            .par => |p| try self.node2("par", "e1", p.e1, "e2", p.e2),
            .parch => |p| {
                try self.raw("{\"k\":\"parch\",\"t\":");
                try self.ty(p.t);
                try self.raw(",\"e1\":");
                try self.expr(p.e1);
                try self.raw(",\"e2\":");
                try self.expr(p.e2);
                try self.raw("}");
            },
            .newchan => |n| {
                try self.raw("{\"k\":\"newchan\",\"rc\":");
                try self.int(n.rc);
                try self.raw(",\"t\":");
                try self.ty(n.t);
                try self.raw("}");
            },
            .send => |s| try self.node2("send", "c", s.c, "e", s.e),
            .recv => |inner| try self.node1("recv", "c", inner),
        }
    }

    fn node1(self: *JsonWriter, k: []const u8, f1: []const u8, e1: *const CExpr) std.mem.Allocator.Error!void {
        try self.raw("{\"k\":\"");
        try self.raw(k);
        try self.raw("\",\"");
        try self.raw(f1);
        try self.raw("\":");
        try self.expr(e1);
        try self.raw("}");
    }

    fn node2(self: *JsonWriter, k: []const u8, f1: []const u8, e1: *const CExpr, f2: []const u8, e2: *const CExpr) std.mem.Allocator.Error!void {
        try self.raw("{\"k\":\"");
        try self.raw(k);
        try self.raw("\",\"");
        try self.raw(f1);
        try self.raw("\":");
        try self.expr(e1);
        try self.raw(",\"");
        try self.raw(f2);
        try self.raw("\":");
        try self.expr(e2);
        try self.raw("}");
    }

    fn node3(self: *JsonWriter, k: []const u8, f1: []const u8, e1: *const CExpr, f2: []const u8, e2: *const CExpr, f3: []const u8, e3: *const CExpr) std.mem.Allocator.Error!void {
        try self.raw("{\"k\":\"");
        try self.raw(k);
        try self.raw("\",\"");
        try self.raw(f1);
        try self.raw("\":");
        try self.expr(e1);
        try self.raw(",\"");
        try self.raw(f2);
        try self.raw("\":");
        try self.expr(e2);
        try self.raw(",\"");
        try self.raw(f3);
        try self.raw("\":");
        try self.expr(e3);
        try self.raw("}");
    }
};

/// 部分検査の封筒（V5-6 = I-3 — Json.lean の partsFromJson）: `{"parts":true,"defs":[...]}`。視点の外の Def は
/// 署名だけ（body 無し）。main 本体を脱糖した（視点が main の）ときだけ `"e"` を付ける
pub fn toPartsJson(allocator: std.mem.Allocator, core: Core, with_root: bool) std.mem.Allocator.Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    var w = JsonWriter{ .allocator = allocator, .out = &out };
    defer w.labels.deinit(allocator);
    try w.raw("{\"parts\":true,\"defs\":[");
    for (core.defs, 0..) |d, i| {
        if (i > 0) try w.raw(",");
        try w.def(d);
    }
    try w.raw("]");
    if (with_root) {
        try w.raw(",\"e\":");
        try w.expr(core.root);
    }
    try w.raw("}");
    return out.toOwnedSlice(allocator);
}

/// 名前付き関数の署名表（V5-6 — Split.lean の SigEq の仮定を確かめる材料）: `pkg.Name TAB {"param":…,"ret":…}` の行を関数表の順に。
/// 視点ごとにこれが全ソースのときと一致すれば、視点の表と全体の表は名前付き関数の部分で署名が一致する
pub fn toSigsJson(allocator: std.mem.Allocator, core: Core, n_named: usize) std.mem.Allocator.Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    var w = JsonWriter{ .allocator = allocator, .out = &out };
    defer w.labels.deinit(allocator);
    for (core.defs[0..n_named], core.names[0..n_named]) |d, n| {
        try w.raw(n);
        try w.raw("\t");
        var sig = d;
        sig.sig_only = true;
        try w.def(sig);
        try w.raw("\n");
    }
    return out.toOwnedSlice(allocator);
}

/// 比較専用の出力（V5-5 の一致検証 — 裁定 N1）: pkg_path に帰属する Def を「記号名 TAB JSON」の行で、記号名順に。
/// main package なら main 本体を `main.main` の行で足す。`"f"` は記号名（他 package の本体に依存する通し番号を消す）
pub fn toPkgJson(allocator: std.mem.Allocator, core: Core, pkg_path: []const u8) std.mem.Allocator.Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    var w = JsonWriter{ .allocator = allocator, .out = &out, .names = core.names };
    defer w.labels.deinit(allocator);
    var order: std.ArrayListUnmanaged(u32) = .empty;
    defer order.deinit(allocator);
    for (core.owners, 0..) |o, i| if (std.mem.eql(u8, o, pkg_path)) try order.append(allocator, @intCast(i));
    const Ctx = struct {
        names: []const []const u8,
        fn less(ctx: @This(), x: u32, y: u32) bool {
            return std.mem.lessThan(u8, ctx.names[x], ctx.names[y]);
        }
    };
    std.mem.sort(u32, order.items, Ctx{ .names = core.names }, Ctx.less);
    for (order.items) |i| {
        try w.raw(core.names[i]);
        try w.raw("\t");
        try w.def(core.defs[i]);
        try w.raw("\n");
    }
    if (std.mem.eql(u8, pkg_path, "main")) { // loader.main_pkg_path
        try w.raw("main.main\t");
        try w.expr(core.root);
        try w.raw("\n");
    }
    return out.toOwnedSlice(allocator);
}

// ────────────────────────────────────────────────────────────────
// 脱糖
// ────────────────────────────────────────────────────────────────

/// `main` の本体と関数表をコア AST に脱糖する。断片の外は error.CoreFragment。
/// 非 inline 関数（全 package）は宣言順に関数表の index を持ち、呼び出しは `call idx` になる。
/// 名前解決（package・可視性）はここで消える — Lean 側は index の世界のみ
pub fn desugar(allocator: std.mem.Allocator, prog: *const ast.Program, diag: *Diag) Error!Core {
    return desugarOpts(allocator, prog, .{}, diag);
}

pub const Opts = struct {
    /// interface 視点（V5-5）: この package の Def だけを脱糖する。他の package は `.sobi` から読んだ署名だけでよい
    /// （本体なし宣言を許す）。main 本体は only が main のときだけ。出力は toPkgJson で読む
    only: ?[]const u8 = null,
    /// 比較専用出力の package（toPkgJson で読む）: この package の辞書 const を全部展開してラムダを持ち上げる。
    /// 辞書 const のラムダは参照されたときだけ持ち上がるので、そのままだと Def の有無が参照側（他 package の本体）に依存する
    view: ?[]const u8 = null,
};

pub fn desugarOpts(allocator: std.mem.Allocator, prog: *const ast.Program, opts: Opts, diag: *Diag) Error!Core {
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    var d = Desugarer{ .a = arena.allocator(), .prog = prog, .cur_pkg = prog.main, .diag = diag };
    for (prog.pkgs) |pkg| {
        if (opts.only) |o| if (!std.mem.eql(u8, pkg.path, o)) continue;
        for (pkg.files) |file| for (file.funcs) |f| if (f.bodiless)
            return d.fail(error.CoreFragment, f.tok, "a function without a body (read from a .sobi interface) has no core");
    }
    const run_root = if (opts.only) |o| std.mem.eql(u8, o, prog.main.path) else true;

    // 関数表: 非 inline・main 以外を（package, 宣言）順に
    var fns: std.ArrayListUnmanaged(FnEntry) = .empty;
    for (prog.pkgs) |pkg| {
        for (pkg.files) |file| {
            for (file.funcs) |f| {
                if (f.expands) continue;
                if (pkg == prog.main and std.mem.eql(u8, f.name, "main")) continue;
                try fns.append(d.a, .{ .decl = f, .pkg = pkg });
            }
        }
    }
    d.fns = fns.items;
    const names = try d.a.alloc([]const u8, fns.items.len);
    const owners = try d.a.alloc([]const u8, fns.items.len);
    for (fns.items, names, owners) |f, *n, *o| {
        n.* = try std.fmt.allocPrint(d.a, "{s}.{s}", .{ f.pkg.path, f.decl.name });
        o.* = f.pkg.path;
    }

    const defs0 = try d.a.alloc(CDef, d.fns.len);
    for (d.fns, 0..) |f, i| {
        if (opts.only) |o| if (!std.mem.eql(u8, f.pkg.path, o)) {
            // 視点の外の Def は署名だけ（部分検査の封筒では body を出さない。比較出力には現れない）
            d.sig_only = true;
            defer d.sig_only = false;
            defs0[i] = try d.defOf(f);
            continue;
        };
        d.owner = names[i];
        d.owner_pkg = f.pkg.path;
        d.owner_lifts = 0;
        defs0[i] = try d.defOf(f);
    }
    if (opts.view) |v| for (prog.pkgs) |pkg| if (std.mem.eql(u8, pkg.path, v)) {
        for (pkg.files) |file| for (file.consts) |c| if (c.dict) {
            _ = try d.dictExpr(c, pkg, 1);
        };
    };
    if (!run_root) {
        const triv = try d.mk(.triv);
        return d.finishCore(&arena, defs0, triv, names, owners);
    }

    var main_fn_opt: ?*const ast.FuncDecl = null;
    for (prog.main.files) |file| {
        for (file.funcs) |f| {
            if (std.mem.eql(u8, f.name, "main")) main_fn_opt = f;
        }
    }
    const main_fn = main_fn_opt orelse return d.fail(error.Malformed, 0, "no main function");
    if (main_fn.params.len != 0) return d.fail(error.CoreFragment, main_fn.tok, "main with parameters");

    // 本体を block で包む: alloc（mut 束縛）は深さ 1 以上でしか型が付かない
    d.cur_pkg = prog.main;
    d.owner = "main.main";
    d.owner_pkg = prog.main.path;
    d.owner_lifts = 0;
    // main 本体 = `block (label unit body)`（途中の return は jump。本体の値は捨てる）。
    // `func main() int`（R31 — 戻り値 = 終了コード）は `block (label int body)`（Def の本体と同じ ann の形）
    const main_int = main_fn.results.len == 1 and blk: {
        const t = d.tyOf(prog.main, main_fn.results[0], main_fn.tok, 32) catch break :blk false;
        break :blk t.* == .int;
    };
    if (main_fn.results.len != 0 and !main_int) return d.fail(error.CoreFragment, main_fn.tok, "main returns nothing or int");
    const int_ty = try d.mkTy(.int);
    var rl = try d.newLabelCtx(.ret, if (main_int) int_ty else try d.mkTy(.unit));
    if (main_int) {
        rl.rtys = try d.a.dupe(*const Ty, &.{int_ty});
        rl.ann = true;
        d.cur_rtys = rl.rtys;
    }
    d.ret_target = try d.pushLabel(rl);
    d.loop_floor = d.labels.items.len;
    const body = try d.scoped(main_fn.body.stmts, Env.empty, 0, .{ .ret_allowed = true, .want = if (main_int) int_ty else null });
    d.labels.items.len -= 1;
    const root = try d.mk(.{ .block = try d.labelNode(rl, body, if (main_int) .ann else .discard) });
    return d.finishCore(&arena, defs0, root, names, owners);
}

/// 関数表のエントリ（宣言と、その名前解決の文脈になる package）
const FnEntry = struct { decl: *const ast.FuncDecl, pkg: *const ast.Pkg };

/// 型宣言と、それが属する package（フィールド型の解決は宣言側の package で行う）
const DeclRef = struct { decl: *const ast.TypeDecl, pkg: *const ast.Pkg, env: []const TBind = &.{} };

/// 型パラメータの束縛（V3-3）: ジェネリック Def の本体では `T ↦ tvar i`、
/// ジェネリック struct の具体化では `T ↦ 型引数`
const TBind = struct { name: []const u8, ty: *const Ty, decl: ?DeclRef = null };

/// 推論用のプレースホルダ tvar の底（ジェネリック Def の本体の tvar と衝突しない）
const PH: u32 = 1 << 20;

/// 名前 → コア束縛の対応。level は束縛の絶対位置（外側から 0）。
/// de Bruijn index は使用点で depth - 1 - level。
/// decl は値の型宣言（struct / union）— selector の射影とフィールド代入の解決に使う
const Binding = struct {
    name: []const u8,
    level: u32,
    mutable: bool,
    decl: ?DeclRef = null,
    ty: ?*const Ty = null,
    /// slice 束縛の要素型宣言（`xs[i].field` の base 型解決に使う）
    elem_decl: ?DeclRef = null,
    /// mut 束縛の ref が指すセルの region（alloc した点の最内 region。mut 引数の別名も元の region を運ぶ）。
    /// mut 引数の ann（ref の型は正確一致）に使う — V3-5
    region: u32 = 0,
    /// コア AST 上の正確な型（imm の region まで実体どおり）。Def の値仮引数（署名の r0）と展開の値引数（ann した型）だけが持つ。
    /// ty は展開の仮引数だと callee の base 座標のままで実体とずれるので、region の精度が要る所（inlineArgTy）はこちらを見る
    core_ty: ?*const Ty = null,
};

/// 関数型引数に束縛されたラムダ（実行時の値にならない。展開で消える）
/// 関数型フィールドの宣言（書かれた pkg と型引数の束縛）。持ち上げたラムダの引数に decl を付ける
const LiftHint = struct { pkg: *const ast.Pkg, env: []const TBind, ft: *const ast.FuncType };

const FEntry = struct { name: []const u8, closure: *const Closure };

/// 定義時の env・package・型環境を凍結する（本体の展開は定義側の文脈で — ジェネリック inline の本体から呼ばれても）
/// ft は関数型の仮引数の型（その時点の型環境で解いたもの）。inline 展開で core から消える
/// 引数型・結果型を、展開時に ann として書き込むために持つ（検査は Lean — V3-5 ③）
const Closure = struct { lambda: *const ast.Lambda, env: Env, pkg: *const ast.Pkg, tenv: []const TBind = &.{}, ft: ?*const Ty = null, ret_target: ?usize = null };

/// 脱出先（V4）。関数本体の return 先・while の break 先 / continue 先。
/// scope_depth = ラベルを置いた時点の defer スコープ数（脱出はそこより内側のスコープの defer を展開する —
/// codegen の runDefers(from) と同じ範囲）
const LabelCtx = struct {
    id: u32,
    kind: enum { ret, brk, cont },
    scope_depth: usize,
    /// ラベルの型。inline 展開で結果型が静的に決まらないときは null（その return は断片外）
    t: ?*const Ty,
    used: *bool,
    /// return の値の強制に使う結果型の列（Def は cur_rtys、inline 展開は点座標の結果型）
    rtys: []const *const Ty = &.{},
    /// ペイロードを t への ann で包む（inline 展開: 値の型をラベルの型に揃える）
    ann: bool = false,
};

/// defer 1 つ（登録時の名前・package・型環境で、出口ごとに脱糖し直す）
const DeferEntry = struct { expr: *const ast.Expr, env: Env, pkg: *const ast.Pkg, tenv: []const TBind };

/// 可視な名前の集合。ラムダは定義時の env を凍結して持つ（永続・arena 上）
const Env = struct {
    bindings: []const Binding,
    fenv: []const FEntry,

    const empty: Env = .{ .bindings = &.{}, .fenv = &.{} };
};

/// 文列の値の扱い
const Tail = struct {
    /// 末尾の `return e` を値として受けるか（関数本体の最上段のみ。それ以外の return は jump）
    ret_allowed: bool = false,
    /// true なら値を捨てて unit（triv）で終える（else 無し if の then 腕）
    discard: bool = false,
    /// 末尾の値の期待型（V4）: 末尾に置いた jump の結果型の注釈に使う。分からなければ null
    want: ?*const Ty = null,
};

const Desugarer = struct {
    a: std.mem.Allocator,
    prog: *const ast.Program,
    /// いま脱糖している本体の属する package（名前解決の文脈）
    cur_pkg: *const ast.Pkg,
    diag: *Diag,
    /// 関数表（非 inline・main 以外、宣言順）。index が call の fn
    fns: []const FnEntry = &.{},
    /// 脱糖中の関数の結果型（return の T? coercion 用）。main は空
    cur_rtys: []const *const Ty = &.{},
    /// 型パラメータの束縛（V3-3）。tyOf の名前解決が最初に見る
    tenv: []const TBind = &.{},
    /// 脱糖中の Def の型パラメータ数（持ち上げたラムダが引き継ぐ）
    cur_tparams: u32 = 0,
    /// 持ち上げたラムダ（V3-3 A1）: 関数表の fns の後ろに並ぶ
    lifted: std.ArrayListUnmanaged(CDef) = .empty,
    /// 持ち上げたラムダの本体を脱糖中なら、捕捉してはいけない外側の束縛
    lift_outer: ?Env = null,
    /// inline 展開中の関数（再帰展開の検出）
    inlining: std.ArrayListUnmanaged(*const ast.FuncDecl) = .empty,
    /// 辞書 const を参照点で展開中か（持ち上げたラムダを AST ポインタで 1 本に寄せる）
    in_dict_const: bool = false,
    /// 辞書 const のラムダ → 持ち上げた Def の index
    dict_lifts: std.AutoHashMapUnmanaged(*const ast.Lambda, u32) = .empty,
    /// 展開中の辞書 const と宣言側 package（持ち上げたラムダの記号名 `pkg.Const#K` の帰属）
    dict_const: ?*const ast.ConstDecl = null,
    dict_pkg: []const u8 = "",
    /// 脱糖中の Def の記号名・package と、その中で持ち上げたラムダの数（記号名 `<owner>/lamK`）
    owner: []const u8 = "",
    owner_pkg: []const u8 = "",
    owner_lifts: u32 = 0,
    lifted_names: std.ArrayListUnmanaged([]const u8) = .empty,
    lifted_owners: std.ArrayListUnmanaged([]const u8) = .empty,
    /// defOf が署名だけを作る（視点の外の Def — 部分検査の封筒）
    sig_only: bool = false,
    /// 次に持ち上げるラムダの引数の型注釈（関数型フィールドの宣言 — 引数の struct 宣言を運ぶ）
    lift_hint: ?LiftHint = null,
    /// いまの region 深さ（Lean の d）。最内 region = rdepth - 1。main 本体は block 包みで 1、
    /// Def 本体は base 2、式位置の `{ }` が +1。本体に書かれた型式の点座標に使う（language.md 21 節）
    rdepth: u32 = 1,
    /// 脱出先のスタック（V4）。末尾が最内
    labels: std.ArrayListUnmanaged(LabelCtx) = .empty,
    /// defer スコープのスタック（V4）。文列のブロック 1 つ = 1 スコープ（codegen の pushScope と同じ単位）
    scopes: std.ArrayListUnmanaged(std.ArrayListUnmanaged(DeferEntry)) = .empty,
    next_label: u32 = 0,
    /// いまの return の行き先（labels の添字）。持ち上げたラムダの本体では null（return は断片外）
    ret_target: ?usize = null,
    /// 後置 `?` の成功値の型追跡（V4-4b）: 次の call の結果を「最後の error? を落とした 1 個」として読む。
    /// computeTy / declOfExpr / elemDeclOfExpr の call 腕が入口で消費する
    try_skip: u32 = 0,
    /// 次の if が文位置（値を捨てる）: 腕を discard で脱糖し、腕の末尾の値の型を揃えなくてよい（codegen と同じ — V5-7）。
    /// .expr 文が立て、.if_ の入口が消費する（else if の鎖は else 腕へ引き継ぐ）
    stmt_if: bool = false,
    /// break / continue が探してよい labels の下限（ラムダ本体は外側のループへ抜けない — codegen の loop_floors）
    loop_floor: usize = 0,
    /// 次の expr 呼び出しの末尾期待型（stmts の末尾の式から if / ブロックの腕へ渡す。expr の入口で消費）
    tail_want: ?*const Ty = null,
    /// 脱糖中の switch の腕の末尾期待型（switchExpr が設定し、腕の文列へ渡す）
    sw_want: ?*const Ty = null,
    /// error の switch（R4b）: subject（先頭 + 鎖）を束縛したレベルと、その型（cause の nil 注釈 — 分からなければ null）
    err_switch: ?struct { level: u32, ty: ?*const Ty } = null,

    /// 持ち上げたラムダは fns の後ろ（index = fns.len + 持ち上げ順）。記号名と帰属も同じ並びで
    fn finishCore(self: *Desugarer, arena: *std.heap.ArenaAllocator, defs0: []const CDef, root: *const CExpr, names0: []const []const u8, owners0: []const []const u8) Error!Core {
        const defs = try self.a.alloc(CDef, defs0.len + self.lifted.items.len);
        @memcpy(defs[0..defs0.len], defs0);
        @memcpy(defs[defs0.len..], self.lifted.items);
        const names = try std.mem.concat(self.a, []const u8, &.{ names0, self.lifted_names.items });
        const owners = try std.mem.concat(self.a, []const u8, &.{ owners0, self.lifted_owners.items });
        // arena は全割り当ての後で写す（値で受けると以降の割り当てが写しに載らない）
        return .{ .arena = arena.*, .defs = defs, .root = root, .names = names, .owners = owners, .n_named = defs0.len };
    }

    fn fail(self: *Desugarer, err: Error, tok: ast.Pos, what: []const u8) Error {
        const n = @min(what.len, self.diag.buf.len);
        @memcpy(self.diag.buf[0..n], what[0..n]);
        self.diag.pos = tok;
        self.diag.what = self.diag.buf[0..n];
        return err;
    }

    fn mk(self: *Desugarer, e: CExpr) std.mem.Allocator.Error!*const CExpr {
        const p = try self.a.create(CExpr);
        p.* = e;
        return p;
    }

    fn mkTy(self: *Desugarer, t: Ty) std.mem.Allocator.Error!*const Ty {
        const p = try self.a.create(Ty);
        p.* = t;
        return p;
    }

    fn bind(self: *Desugarer, env: Env, b: Binding) std.mem.Allocator.Error!Env {
        const out = try self.a.alloc(Binding, env.bindings.len + 1);
        @memcpy(out[0..env.bindings.len], env.bindings);
        out[env.bindings.len] = b;
        return .{ .bindings = out, .fenv = env.fenv };
    }

    fn lookup(env: Env, name: []const u8) ?Binding {
        var i = env.bindings.len;
        while (i > 0) {
            i -= 1;
            if (std.mem.eql(u8, env.bindings[i].name, name)) return env.bindings[i];
        }
        return null;
    }

    fn lookupF(env: Env, name: []const u8) ?*const Closure {
        var i = env.fenv.len;
        while (i > 0) {
            i -= 1;
            if (std.mem.eql(u8, env.fenv[i].name, name)) return env.fenv[i].closure;
        }
        return null;
    }

    // ── 脱出（V4）: label / jump と defer の出口展開 ──────────────
    // formal.md「label / jump の段」: return / break / continue は jump、関数本体と while は label。
    // defer は出口ごとに、越えるスコープの defer を静的に列挙して差し込む（値確定 → defer → jump。
    // codegen の runDefers と同じテンプレート）。コアに defer は無い

    const CtlSave = struct { ret_target: ?usize, loop_floor: usize };

    fn saveCtl(self: *Desugarer) CtlSave {
        return .{ .ret_target = self.ret_target, .loop_floor = self.loop_floor };
    }

    fn restoreCtl(self: *Desugarer, c: CtlSave) void {
        self.ret_target = c.ret_target;
        self.loop_floor = c.loop_floor;
    }

    fn pushLabel(self: *Desugarer, ctx: LabelCtx) Error!usize {
        try self.labels.append(self.a, ctx);
        return self.labels.items.len - 1;
    }

    fn newLabelCtx(self: *Desugarer, kind: @FieldType(LabelCtx, "kind"), t: ?*const Ty) Error!LabelCtx {
        const used = try self.a.create(bool);
        used.* = false;
        const id = self.next_label;
        self.next_label += 1;
        return .{ .id = id, .kind = kind, .scope_depth = self.scopes.items.len, .t = t, .used = used };
    }

    fn labelNode(self: *Desugarer, ctx: LabelCtx, body: *const CExpr, wrap: LabelWrap) Error!*const CExpr {
        const t = ctx.t orelse try self.mkTy(.unit);
        return self.mk(.{ .label = .{ .id = ctx.id, .t = t, .e = body, .used = ctx.used, .wrap = wrap } });
    }

    /// 文列のブロック 1 つを 1 つの defer スコープで脱糖する（codegen の pushScope と同じ単位）
    fn scoped(self: *Desugarer, list: []const ast.Stmt, env: Env, depth: u32, tail: Tail) Error!*const CExpr {
        try self.scopes.append(self.a, .empty);
        defer _ = self.scopes.pop();
        return self.stmts(list, env, depth, tail);
    }

    /// 出口の defer 展開: 値 v（深さ depth）を束縛し、scopes[from..] の defer を内側のスコープから
    /// （各スコープは登録の逆順に）値を捨てて評価してから v を返す。defer は登録時の名前・package・
    /// 型環境で、出口の深さで脱糖し直す（codegen の runDefers と同じ順 = 値確定 → defer）
    fn withDefers(self: *Desugarer, v: *const CExpr, from: usize, depth: u32) Error!*const CExpr {
        var list: std.ArrayListUnmanaged(DeferEntry) = .empty;
        var i = self.scopes.items.len;
        while (i > from) {
            i -= 1;
            const ds = self.scopes.items[i].items;
            var j = ds.len;
            while (j > 0) {
                j -= 1;
                try list.append(self.a, ds[j]);
            }
        }
        if (list.items.len == 0) return v;
        const n: u32 = @intCast(list.items.len);
        const cores = try self.a.alloc(*const CExpr, list.items.len);
        const saved_pkg = self.cur_pkg;
        const saved_tenv = self.tenv;
        defer {
            self.cur_pkg = saved_pkg;
            self.tenv = saved_tenv;
        }
        for (list.items, cores, 0..) |d, *c, k| {
            self.cur_pkg = d.pkg;
            self.tenv = d.tenv;
            c.* = try self.expr(d.expr, d.env, depth + 1 + @as(u32, @intCast(k)));
        }
        var body: *const CExpr = try self.mk(.{ .var_ = n });
        var k = cores.len;
        while (k > 0) {
            k -= 1;
            body = try self.mk(.{ .let = .{ .e = cores[k], .body = body } });
        }
        return self.mk(.{ .let = .{ .e = v, .body = body } });
    }

    /// 文列の末尾の値: 最内スコープ（この文列のブロック）の defer を展開して締める
    fn finish(self: *Desugarer, v: *const CExpr, depth: u32) Error!*const CExpr {
        if (self.scopes.items.len == 0) return v;
        return self.withDefers(v, self.scopes.items.len - 1, depth);
    }

    /// `error?`（組み込み error の opt）か。region は見ない（ラベルのフィールドの座標は位置で変わる）
    fn isErrOpt(self: *Desugarer, t: *const Ty) Error!bool {
        if (t.* != .opt) return false;
        const et = try self.errTy(self.cur_pkg, 0, 32);
        return tyEqlLoose(t.opt, et);
    }

    /// 組み込み error の型（R4b K1''）: `prod L []L`（L = 全ラベルの閉じた union、鎖は imm slice — base 座標 r0）
    fn errTy(self: *Desugarer, pkg: *const ast.Pkg, tok: u32, fuel: u32) Error!*const Ty {
        const l = try self.unionTreeTy(pkg, self.prog.errors.body.union_, tok, fuel);
        const chain = try self.mkTy(.{ .slice = .{ .m = false, .r = 0, .t = l } });
        return self.mkTy(.{ .prod = .{ .l = l, .r = chain } });
    }

    /// 空の鎖（包んでいない error）: 点座標の空 imm slice。セルを確保しないのでコストはヘッダだけ
    fn emptyChain(self: *Desugarer, tok: u32) Error!*const CExpr {
        const l = try self.unionTreeTy(self.cur_pkg, self.prog.errors.body.union_, tok, 32);
        return self.mk(.{ .freeze = try self.mk(.{ .mkslice = .{ .m = true, .t = try self.pointTy(l) } }) });
    }

    /// 後置 `?`（V4-4b、裁定 S1）: `let p = f() in (ifnil (last p) triv (jump k unit (zeros…, some err)); init p)`。
    /// jump は文の位置（ifnil の両腕が unit）に置くので注釈は常に unit — 成功値の型を computeTy に頼らない。
    /// 行き先は return と同じ（ret_target）、越える defer は withDefers
    fn tryExpr(self: *Desugarer, t: ast.Try, env: Env, depth: u32) Error!*const CExpr {
        const tc = switch (t.e.*) {
            .call => |c| c,
            else => return self.fail(error.CoreFragment, t.tok, "? applies to a function call"),
        };
        const callee = if (tc.callee.* == .index) tc.callee.index.base else tc.callee;
        const fe = (try self.findFn(callee, env)) orelse
            return self.fail(error.CoreFragment, t.tok, "? on a call that is not a named function is outside the core fragment");
        const res = fe.decl.results;
        if (res.len == 0 or !isErrOptTE(res[res.len - 1]))
            return self.fail(error.Malformed, t.tok, "? needs a call whose last result is error?");
        const target = self.ret_target orelse
            return self.fail(error.CoreFragment, t.tok, "? inside a lambda lifted to a function value (? leaves the enclosing named function, like return)");
        const ctx = self.labels.items[target];
        if (ctx.t == null)
            return self.fail(error.CoreFragment, t.tok, "? in an inline function whose result type is not statically known");
        if (ctx.rtys.len == 0 or !(try self.isErrOpt(ctx.rtys[ctx.rtys.len - 1])))
            return self.fail(error.Malformed, t.tok, "? needs the enclosing function to return error? as its last result");
        const n = ctx.rtys.len;
        for (ctx.rtys[0 .. n - 1]) |rt| {
            if (!hasZero(rt))
                return self.fail(error.CoreFragment, t.tok, "? needs zero values for the other results of the enclosing function (not a function value, union or type parameter — language.md 15)");
        }
        const p = try self.expr(t.e, env, depth);
        const k = res.len;
        // some 腕（深さ depth + 2: var 0 = err、var 1 = p）: ゼロ値 + some err → 越える defer → jump
        const sd = depth + 2;
        const values = try self.a.alloc(*const CExpr, n);
        // ゼロ値はその場で組む（深い位置の imm コンテナは jump の clampR — R4b — がラベルの region へ締める）
        for (ctx.rtys[0 .. n - 1], 0..) |rt, i| {
            values[i] = try self.zeroOf(rt, t.tok);
        }
        // 包み替え `f()? L{…}`（V4-4c、K3）: err を捨てて L に置き換える。フィールドはエラーの経路でだけ評価される
        // R4b（K1''）: 包み替えは内側の err（先頭 + 鎖）の先頭を鎖の末尾へ積み、L を新しい先頭にする —
        // 包んだ error は `case L{..., cause}` で辿れる。鎖は最内 region へ全コピー（imm append）
        const err_v: *const CExpr = if (t.wrap) |w| blk: {
            const found = self.findVariant(self.cur_pkg, w.type_name);
            if (found == null or found.?.decl != self.prog.errors)
                return self.fail(error.Malformed, w.tok, "an error wrap `? L{...}` needs an error label");
            const top = try self.labelL(w.*, found.?, env, sd);
            const inner = try self.mk(.{ .var_ = 0 });
            const chain = try self.mk(.{ .append = .{ .e = try self.mk(.{ .snd = inner }), .v = try self.mk(.{ .fst = inner }) } });
            break :blk try self.mk(.{ .pair = .{ .a = top, .b = chain } });
        } else try self.mk(.{ .var_ = 0 });
        values[n - 1] = try self.mk(.{ .some = err_v });
        const payload0 = try self.pairChain(values);
        const payload = if (ctx.ann) try self.mk(.{ .ann = .{ .e = payload0, .t = ctx.t.? } }) else payload0;
        ctx.used.* = true;
        const unit = try self.mkTy(.unit);
        const jump = try self.mk(.{ .jump = .{ .id = ctx.id, .t = unit, .e = try self.withDefers(payload, ctx.scope_depth, sd) } });
        // 判定（深さ depth + 1: var 0 = p）
        const err_opt = try self.projection(try self.mk(.{ .var_ = 0 }), k - 1, k);
        const check = try self.mk(.{ .ifnil = .{ .e = err_opt, .nil_case = try self.mk(.triv), .some_case = jump } });
        // 成功値（深さ depth + 2: 判定の匿名束縛の下で var 1 = p）
        const succ: *const CExpr = switch (k) {
            1 => try self.mk(.triv),
            2 => try self.projection(try self.mk(.{ .var_ = 1 }), 0, 2),
            else => blk: {
                const comps = try self.a.alloc(*const CExpr, k - 1);
                for (comps, 0..) |*c, i| c.* = try self.projection(try self.mk(.{ .var_ = 1 }), i, k);
                break :blk try self.pairChain(comps);
            },
        };
        return self.mk(.{ .let = .{ .e = p, .body = try self.mk(.{ .let = .{ .e = check, .body = succ } }) } });
    }

    /// 脱出の文（return / break / continue）: ペイロードを確定 → 越える defer → jump。
    /// jump の結果型の注釈は位置の期待型 — 文位置（続きがある・値を捨てる）は unit、
    /// 値を使う末尾は Tail.want（分からなければ断片外）
    fn exitStmt(self: *Desugarer, target: usize, payload: *const CExpr, rest: []const ast.Stmt, env: Env, depth: u32, tail: Tail, is_last: bool, tok: ast.Pos) Error!*const CExpr {
        const want: *const Ty = if (!is_last or tail.discard)
            try self.mkTy(.unit)
        else
            tail.want orelse return self.fail(error.CoreFragment, tok, "return / break / continue in a value position whose type is not statically known");
        const ctx = self.labels.items[target];
        ctx.used.* = true;
        const p = if (ctx.ann) try self.mk(.{ .ann = .{ .e = payload, .t = ctx.t.? } }) else payload;
        const j = try self.mk(.{ .jump = .{ .id = ctx.id, .t = want, .e = try self.withDefers(p, ctx.scope_depth, depth) } });
        if (is_last) return j;
        return self.seq(j, rest, env, depth, tail, false);
    }

    /// break / continue の行き先: ラムダ・inline 本体の床より上で最内のループのラベル
    fn loopTarget(self: *Desugarer, kind: @FieldType(LabelCtx, "kind"), tok: ast.Pos) Error!usize {
        var i = self.labels.items.len;
        while (i > self.loop_floor) {
            i -= 1;
            if (self.labels.items[i].kind == kind) return i;
        }
        return self.fail(error.Malformed, tok, if (kind == .brk) "break outside a loop" else "continue outside a loop");
    }

    /// 腕の末尾の値の型: 最後が式文なら computeTy（腕内の束縛は見えないので分かる範囲だけ）、
    /// 値を持たない文（束縛・代入・while・defer）や空の腕なら unit、脱出の文なら不明（null）
    fn armTy(self: *Desugarer, list: []const ast.Stmt, env: Env) ?*const Ty {
        if (list.len == 0) return self.mkTy(.unit) catch null;
        return switch (list[list.len - 1]) {
            .expr => |e| self.computeTy(e, env),
            .ret, .break_, .continue_ => null,
            .yield_ => null,
            .bind, .assign, .while_, .defer_ => self.mkTy(.unit) catch null,
        };
    }

    /// switch の値の型（腕の末尾から。上の case → default の順に分かる方）
    fn switchTy(self: *Desugarer, sw: ast.Switch, env: Env) ?*const Ty {
        for (sw.cases) |c| {
            if (self.armTy(c.body.stmts, env)) |t| return t;
        }
        if (sw.default_) |blk| return self.armTy(blk.stmts, env);
        return null;
    }

    /// if 式の値の型（腕の末尾の式から。then → else の順に分かる方）
    fn ifTy(self: *Desugarer, i: ast.If, env: Env) ?*const Ty {
        const els = i.else_ orelse return null;
        if (self.armTy(i.then.stmts, env)) |t| return t;
        if (els.* == .block) return self.armTy(els.block.stmts, env);
        return self.computeTy(els, env);
    }

    // ── 文列 → letE の鎖 ──────────────────────────────

    fn stmts(self: *Desugarer, list: []const ast.Stmt, env: Env, depth: u32, tail: Tail) Error!*const CExpr {
        if (list.len == 0) return self.finish(try self.mk(.triv), depth);
        // yield 文は束縛 `yield`（for 式を書き換えたラムダの引数 — forexpand.zig）の呼び出し
        const s: ast.Stmt = if (list[0] == .yield_)
            .{ .expr = try forexpand.yieldCall(self.a, list[0].yield_.expr, list[0].yield_.tok) }
        else
            list[0];
        const rest = list[1..];
        const is_last = rest.len == 0;
        switch (s) {
            .bind => |b| {
                // 多値呼び出しの分解 `x, y := g(...)`: call を匿名束縛し、射影で名前を付ける
                if (b.names.len > 1 and b.values.len == 1) {
                    const v0 = try self.expr(b.values[0], env, depth);
                    // 分解束縛の型追跡: 呼び出しなら関数の結果型注釈から decl を引く
                    var res_tys: []const ast.TypeExpr = &.{};
                    var res_pkg: *const ast.Pkg = self.cur_pkg;
                    var res_generic = false;
                    const callee0: ?*const ast.Expr = switch (b.values[0].*) {
                        .call => |c| c.callee,
                        .pipe => |p| p.callee,
                        .try_ => |t| if (t.e.* == .call) t.e.call.callee else null,
                        else => null,
                    };
                    if (callee0) |ce| {
                        if (try self.findFn(ce, env)) |fe| {
                            res_tys = fe.decl.results;
                            res_pkg = fe.pkg;
                            res_generic = fe.decl.type_params.len > 0;
                        }
                    }
                    var env2 = env;
                    var body_depth = depth + 1;
                    const n = b.names.len;
                    var extracts: std.ArrayListUnmanaged(*const CExpr) = .empty;
                    for (b.names, 0..) |name, i| {
                        const tuple_index = body_depth - (depth + 1);
                        const tuple = try self.mk(.{ .var_ = tuple_index });
                        var v = try self.projection(tuple, i, n);
                        if (b.mutable) v = try self.mk(.{ .alloc = .{ .m = true, .e = v } });
                        try extracts.append(self.a, v);
                        env2 = try self.bind(env2, .{
                            .name = name,
                            .level = body_depth,
                            .mutable = b.mutable,
                            .region = self.rdepth - 1,
                            .decl = if (i < res_tys.len) self.declOfTypeExpr(res_pkg, res_tys[i]) else null,
                            .elem_decl = if (i < res_tys.len) self.elemDeclOfTypeExpr(res_pkg, res_tys[i]) else null,
                            // 型は region を持たないときだけ（座標の変換が要らない — T? の sink の some 包み判定用。V4-4b）
                            .ty = if (i < res_tys.len and res_generic == false) blk: {
                                const rt = self.tyOf(res_pkg, res_tys[i], b.tok, 32) catch break :blk null;
                                break :blk self.callResultTop(rt);
                            } else null,
                        });
                        body_depth += 1;
                    }
                    var body = try self.stmts(rest, env2, body_depth, tail);
                    var i = extracts.items.len;
                    while (i > 0) {
                        i -= 1;
                        body = try self.mk(.{ .let = .{ .e = extracts.items[i], .body = body } });
                    }
                    return self.mk(.{ .let = .{ .e = v0, .body = body } });
                }
                // 同時束縛 `x, y := a, b`。値は元の env（新しい名前が見えない）で
                // letE の入れ子として左から右へ評価される
                if (b.names.len != b.values.len)
                    return self.fail(error.CoreFragment, b.tok, "bind arity mismatch");
                const n: u32 = @intCast(b.names.len);
                const values = try self.a.alloc(*const CExpr, b.names.len);
                var env2 = env;
                for (b.names, b.values, 0..) |name, value, i| {
                    var v = try self.expr(value, env, depth + @as(u32, @intCast(i)));
                    if (b.mutable) v = try self.mk(.{ .alloc = .{ .m = true, .e = try self.mutInitAnn(value, v, env) } });
                    values[i] = v;
                    env2 = try self.bind(env2, .{
                        .name = name,
                        .level = depth + @as(u32, @intCast(i)),
                        .mutable = b.mutable,
                        .region = self.rdepth - 1,
                        .decl = self.declOfExpr(value, env),
                        .ty = self.computeTy(value, env),
                        .elem_decl = self.elemDeclOfExpr(value, env),
                    });
                }
                var body = try self.stmts(rest, env2, depth + n, tail);
                var i = values.len;
                while (i > 0) {
                    i -= 1;
                    body = try self.mk(.{ .let = .{ .e = values[i], .body = body } });
                }
                return body;
            },
            .assign => |asg| {
                const e = try self.assignExpr(asg, env, depth);
                return self.seq(e, rest, env, depth, tail, is_last);
            },
            .ret => |r| {
                if (is_last and tail.ret_allowed) {
                    // 関数本体の最上段の末尾: 値そのもの（ラベルへ跳ばない）
                    if (r.values.len == 0) return self.finish(try self.mk(.triv), depth);
                    // 多値 return は pair 鎖（多値 = struct の裁定。実体化しないのは codegen の仕事）
                    const values = try self.a.alloc(*const CExpr, r.values.len);
                    for (r.values, 0..) |value, i| {
                        values[i] = if (self.cur_rtys.len == r.values.len)
                            try self.retValue(value, self.cur_rtys[i], env, depth, r.tok)
                        else
                            try self.expr(value, env, depth);
                    }
                    const v = try self.pairChain(values);
                    if (tail.discard) return self.finish(try self.mk(.{ .let = .{ .e = v, .body = try self.mk(.triv) } }), depth);
                    return self.finish(v, depth);
                }
                // それ以外の return は関数ラベルへの jump（V4）
                const target = self.ret_target orelse
                    return self.fail(error.CoreFragment, r.tok, "return inside a lambda lifted to a function value (a lambda's return leaves the enclosing named function — language.md 8)");
                const ctx = self.labels.items[target];
                if (ctx.t == null)
                    return self.fail(error.CoreFragment, r.tok, "return in an inline function whose result type is not statically known");
                if (ctx.rtys.len == 0 and r.values.len > 0)
                    return self.fail(error.Malformed, r.tok, "return with values in a function without results");
                const values = try self.a.alloc(*const CExpr, r.values.len);
                for (r.values, 0..) |value, i| {
                    values[i] = if (ctx.rtys.len == r.values.len)
                        try self.retValue(value, ctx.rtys[i], env, depth, r.tok)
                    else
                        try self.expr(value, env, depth);
                }
                const payload = if (values.len == 0) try self.mk(.triv) else try self.pairChain(values);
                return self.exitStmt(target, payload, rest, env, depth, tail, is_last, r.tok);
            },
            .expr => |e| {
                if (is_last and !tail.discard) {
                    self.tail_want = tail.want;
                    const v = try self.expr(e, env, depth);
                    return self.finish(v, depth);
                }
                self.stmt_if = e.* == .if_;
                const v = try self.expr(e, env, depth);
                return self.seq(v, rest, env, depth, tail, is_last);
            },
            .while_ => |w| {
                // `label brk (while c (label cont body))`: break = 外側、continue = 内側（本体の defer を展開して次の周回）
                const cond = try self.expr(w.cond, env, depth);
                const unit = try self.mkTy(.unit);
                const brk = try self.newLabelCtx(.brk, unit);
                const cont = try self.newLabelCtx(.cont, unit);
                _ = try self.pushLabel(brk);
                _ = try self.pushLabel(cont);
                const body = blk: {
                    defer self.labels.items.len -= 2;
                    break :blk try self.scoped(w.body.stmts, env, depth, .{ .discard = true });
                };
                const loop = try self.mk(.{ .while_ = .{ .c = cond, .body = try self.labelNode(cont, body, .none) } });
                const e = try self.labelNode(brk, loop, .none);
                return self.seq(e, rest, env, depth, tail, is_last);
            },
            .break_ => |tok| return self.exitStmt(try self.loopTarget(.brk, tok), try self.mk(.triv), rest, env, depth, tail, is_last, tok),
            .continue_ => |tok| return self.exitStmt(try self.loopTarget(.cont, tok), try self.mk(.triv), rest, env, depth, tail, is_last, tok),
            .defer_ => |d| {
                // 登録だけ（コアには現れない）。出口（末尾・jump）ごとに展開する
                try self.scopes.items[self.scopes.items.len - 1].append(self.a, .{ .expr = d.expr, .env = env, .pkg = self.cur_pkg, .tenv = self.tenv });
                return self.stmts(rest, env, depth, tail);
            },
            .yield_ => unreachable,
        }
    }

    /// 値 e を文位置に置く: 続きがあれば匿名束縛（letE）、末尾なら unit で締める
    fn seq(self: *Desugarer, e: *const CExpr, rest: []const ast.Stmt, env: Env, depth: u32, tail: Tail, is_last: bool) Error!*const CExpr {
        if (is_last) return self.finish(try self.mk(.{ .let = .{ .e = e, .body = try self.mk(.triv) } }), depth);
        const body = try self.stmts(rest, env, depth + 1, tail);
        return self.mk(.{ .let = .{ .e = e, .body = body } });
    }

    fn assignExpr(self: *Desugarer, asg: ast.Assign, env: Env, depth: u32) Error!*const CExpr {
        if (asg.targets.len != asg.values.len)
            return self.fail(error.CoreFragment, asg.tok, "destructuring a multi-value call is outside the core fragment");
        if (asg.targets.len == 1 and asg.targets[0].* == .index) {
            if (asg.op != .equal)
                return self.fail(error.CoreFragment, asg.tok, "compound assignment to a slice element");
            const ix = asg.targets[0].index;
            // map: `m[k] = v` は成長でヘッダが変わり得るので mut 束縛への再代入
            // `m = setm(m, k, v)` に脱糖する（language.md 22 節）
            if (self.computeTy(ix.base, env)) |bt| {
                if (bt.* == .map) {
                    if (ix.base.* != .ident)
                        return self.fail(error.CoreFragment, asg.tok, "map assignment target must be a mut binding");
                    const base = try self.expr(ix.base, env, depth);
                    // キー・値の型は mut 束縛のセル型 = 束縛点の点座標（V3-5 — appendValueAnn と同じ不変条件）。宣言由来の
                    // Binding.ty は base 座標（r0）のままなので、そのまま ann するとキーの string リテラル（最内 region）を
                    // r0 へ締める向きになって Lean が拒否していた（selfhost-drafts F-26）
                    const kt, const vt = try self.mapCellAt(ix.base, bt, env);
                    const idx = try self.mapKey(ix.idx, kt, env, depth);
                    const v = try self.looserAnn(asg.values[0], try self.coerceExpr(asg.values[0], vt, env, depth, asg.tok), vt, env);
                    const newmap = try self.mk(.{ .setm = .{ .e = base, .k = idx, .v = v } });
                    return self.assignTarget(asg.targets[0].index.base, newmap, env, depth, asg.tok);
                }
            }
            const base = try self.expr(ix.base, env, depth);
            const idx = try self.expr(ix.idx, env, depth);
            const v = try self.expr(asg.values[0], env, depth);
            return self.mk(.{ .setidx = .{ .e = base, .i = idx, .v = v } });
        }
        if (asg.targets.len == 1) {
            const target = asg.targets[0];
            if (target.* == .ident and asg.op != .equal)
                return self.compoundAssign(target.ident, asg.op, asg.values[0], env, depth, asg.tok);
            if (asg.op != .equal)
                return self.fail(error.CoreFragment, asg.tok, "compound assignment on a field path is outside the core fragment");
            const v0 = if (self.targetTy(target, env)) |w|
                try self.coerceExpr(asg.values[0], w, env, depth, asg.tok)
            else
                try self.expr(asg.values[0], env, depth);
            if (target.* == .ident) return self.assignTarget(target, v0, env, depth, asg.tok);
            const v = try self.fieldValueAnn(target, asg.values[0], v0, env);
            // フィールドパス: 値を先に束縛してから代入（再構築が値を var 0 で参照する）
            const a = try self.assignTarget(target, try self.mk(.{ .var_ = 0 }), env, depth + 1, asg.tok);
            return self.mk(.{ .let = .{ .e = v, .body = a } });
        }
        // 同時代入 `x, y = y, x % y`: 全値を評価してから順に代入
        if (asg.op != .equal)
            return self.fail(error.CoreFragment, asg.tok, "compound assignment with multiple targets is outside the core fragment");
        const n: u32 = @intCast(asg.targets.len);
        const values = try self.a.alloc(*const CExpr, asg.values.len);
        for (asg.values, 0..) |value, i| {
            values[i] = try self.expr(value, env, depth + @as(u32, @intCast(i)));
        }
        // 代入 j の時点の深さは depth + n + j。値 j の index は常に n - 1
        var body: *const CExpr = try self.mk(.triv);
        var j = asg.targets.len;
        while (j > 0) {
            j -= 1;
            const a = try self.assignTarget(asg.targets[j], try self.mk(.{ .var_ = n - 1 }), env, depth + n + @as(u32, @intCast(j)), asg.tok);
            body = try self.mk(.{ .let = .{ .e = a, .body = body } });
        }
        var i = values.len;
        while (i > 0) {
            i -= 1;
            body = try self.mk(.{ .let = .{ .e = values[i], .body = body } });
        }
        return body;
    }

    /// 複合代入（名前のみ）: `x op= v` → `assign x (op (deref x) v)`
    fn compoundAssign(self: *Desugarer, id: ast.Ident, op: Token.Tag, value: *const ast.Expr, env: Env, depth: u32, tok: u32) Error!*const CExpr {
        const b = lookup(env, id.name) orelse
            return self.fail(error.UnknownName, id.tok, "unknown name in assignment");
        if (!b.mutable) return self.fail(error.Malformed, tok, "assignment to a non-mut binding");
        const lref = try self.mk(.{ .var_ = depth - 1 - b.level });
        const cur = try self.mk(.{ .deref = lref });
        var v = try self.expr(value, env, depth);
        switch (op) {
            .plus_equal => v = try self.mk(.{ .add = .{ .a = cur, .b = v } }),
            .minus_equal, .star_equal, .slash_equal, .percent_equal, .ampersand_equal, .pipe_equal, .caret_equal, .shl_equal, .shr_equal => {
                const kind: []const u8 = switch (op) {
                    .minus_equal => "sub",
                    .star_equal => "mul",
                    .slash_equal => "div",
                    .ampersand_equal => "and",
                    .pipe_equal => "or",
                    .caret_equal => "xor",
                    .shl_equal => "shl",
                    .shr_equal => "shr",
                    else => "mod",
                };
                v = try self.mk(.{ .bin = .{ .kind = kind, .a = cur, .b = v } });
            },
            else => return self.fail(error.CoreFragment, tok, "compound assignment outside the core fragment"),
        }
        return self.mk(.{ .assign = .{ .l = lref, .e = v } });
    }

    /// 代入先 1 つ。new は代入する値のコア式、depth はその時点の深さ。
    /// 名前は素の assign、フィールドパスは struct の再構築（読み替え → pair 鎖の組み直し）
    fn assignTarget(self: *Desugarer, target: *const ast.Expr, new: *const CExpr, env: Env, depth: u32, tok: u32) Error!*const CExpr {
        switch (target.*) {
            .ident => |id| {
                const b = lookup(env, id.name) orelse
                    return self.fail(error.UnknownName, id.tok, "unknown name in assignment");
                if (!b.mutable) return self.fail(error.Malformed, tok, "assignment to a non-mut binding");
                const lref = try self.mk(.{ .var_ = depth - 1 - b.level });
                return self.mk(.{ .assign = .{ .l = lref, .e = new } });
            },
            .selector => {
                // フィールドパスを外側から並べる
                var path: std.ArrayListUnmanaged([]const u8) = .empty;
                var cur: *const ast.Expr = target;
                while (cur.* == .selector) {
                    try path.append(self.a, cur.selector.field);
                    cur = cur.selector.base;
                }
                std.mem.reverse([]const u8, path.items);
                if (cur.* != .ident)
                    return self.fail(error.CoreFragment, tok, "assignment target must be a name or a field path");
                const b = lookup(env, cur.ident.name) orelse
                    return self.fail(error.UnknownName, cur.ident.tok, "unknown name in assignment");
                if (!b.mutable) return self.fail(error.Malformed, tok, "assignment to a non-mut binding");
                const lref = try self.mk(.{ .var_ = depth - 1 - b.level });
                const whole = try self.mk(.{ .deref = lref });
                const rebuilt = try self.rebuildPath(whole, b.decl, path.items, new, tok);
                return self.mk(.{ .assign = .{ .l = lref, .e = rebuilt } });
            },
            else => return self.fail(error.CoreFragment, tok, "assignment target must be a name or a field path"),
        }
    }

    /// パスのフィールドだけ new に置き換えた struct 値を組み直す
    fn rebuildPath(self: *Desugarer, cur: *const CExpr, decl: ?DeclRef, path: []const []const u8, new: *const CExpr, tok: u32) Error!*const CExpr {
        if (path.len == 0) return new;
        const d = decl orelse return self.fail(error.CoreFragment, tok, "field path type is unknown");
        const fields = switch (d.decl.body) {
            .struct_ => |fs| fs,
            .union_ => return self.fail(error.Malformed, tok, "field access on a union value (use a switch pattern)"),
            .func_ => return self.fail(error.Malformed, tok, "field access on a function type"),
            .error_ => return self.fail(error.Malformed, tok, "an error label is not a type (use error)"),
        };
        const idx = for (fields, 0..) |f, i| {
            if (std.mem.eql(u8, f.name, path[0])) break i;
        } else return self.fail(error.UnknownName, tok, "unknown field");
        const comps = try self.a.alloc(*const CExpr, fields.len);
        for (fields, 0..) |f, i| {
            const proj = try self.projection(cur, i, fields.len);
            comps[i] = if (i == idx)
                try self.rebuildPath(proj, self.declOfTypeExpr(d.pkg, f.type), path[1..], new, tok)
            else
                proj;
        }
        return self.pairChain(comps);
    }

    // ── 式 ──────────────────────────────

    fn expr(self: *Desugarer, e: *const ast.Expr, env: Env, depth: u32) Error!*const CExpr {
        // 末尾期待型は直下の式（if / ブロック）だけが使う。部分式へ漏らさない
        const want = self.tail_want;
        self.tail_want = null;
        switch (e.*) {
            .int => |n| return self.mk(.{ .lit = n.value }),
            .try_ => |t| return self.tryExpr(t, env, depth),
            .ident => |id| {
                const b = lookup(env, id.name) orelse {
                    // トップレベル const（ロード時に畳み込み済み）
                    if (lookupConst(self.cur_pkg, id.name)) |c| {
                        if (c.dict) return self.dictExpr(c, self.cur_pkg, depth);
                        return self.mk(.{ .lit = c.value.? });
                    }
                    // 事前宣言の true / false（Go 同様キーワードでなく識別子）
                    if (std.mem.eql(u8, id.name, "true")) return self.mk(.tt);
                    if (std.mem.eql(u8, id.name, "false")) return self.mk(.ff);
                    // 名前付き関数の参照 = 閉じた関数値（V3-3）
                    if (try self.findFn(e, env)) |entry| return self.fnRef(entry, id.tok);
                    if (self.lift_outer) |outer| {
                        if (lookup(outer, id.name) != null)
                            return self.fail(error.CoreFragment, id.tok, "a lambda in a dictionary cannot capture an outer variable (closed function values only — V3-1)");
                    }
                    return self.fail(error.UnknownName, id.tok, "unknown name");
                };
                const v = try self.mk(.{ .var_ = depth - 1 - b.level });
                if (b.mutable) return self.mk(.{ .deref = v });
                return v;
            },
            .nil => |n| return self.fail(error.CoreFragment, n.tok, "nil needs a T? context"),
            .interp => |it| return self.expr(try self.lowerInterp(it, env), env, depth),
            // 文字列リテラル: コアの strlit（注釈の region r の imm int セル列 — Lean の strlit の段）。codegen は rodata に置く — 観測同値。
            // 既定の r は書かれた点の最内 region（旧テンプレート freeze(append 連鎖) と同じ型）: if の両腕・Def の結果・mut セルは
            // 型を厳密に比べるので、他の string 値（最内に作る）と座標を揃える。Def 呼び出しの実引数の位置だけ r = 0（呼び手空間 —
            // defCall の strArg）: 再帰する mut Def（callM）の imm 引数は anchor 以下の region を要求する（selfhost-drafts F-6）
            .strlit => |sl| return self.mk(.{ .strlit = .{ .bs = sl.value, .r = self.rdepth - 1 } }),
            // slice リテラル: mkslice + append 連鎖。imm（デフォルト）は mut 構築 + freeze
            // （string リテラルと同じコア形 — language.md 22 節）
            .slicelit => |sl| {
                const elem = try self.tyOf(self.cur_pkg, sl.elem, sl.tok, 32);
                var e2: *const CExpr = try self.mk(.{ .mkslice = .{ .m = true, .t = try self.pointTy(elem) } });
                for (sl.elems) |el| {
                    e2 = try self.mk(.{ .append = .{ .e = e2, .v = try self.coerceExpr(el, elem, env, depth, sl.tok) } });
                }
                if (!sl.mut) return self.mk(.{ .freeze = e2 });
                return e2;
            },
            // map リテラル: mkmap + setm 連鎖（重複キーは後勝ち — setm の意味論そのまま）。
            // imm は mut 構築 + freeze
            .maplit => |ml| {
                const key = try self.pointTy(try self.mapKeyTy(try self.tyOf(self.cur_pkg, ml.key, ml.tok, 32), ml.tok));
                const value = try self.tyOf(self.cur_pkg, ml.value, ml.tok, 32);
                var e2: *const CExpr = try self.mk(.{ .mkmap = .{ .m = true, .k = key, .t = try self.pointTy(value) } });
                for (ml.entries) |en| {
                    e2 = try self.mk(.{ .setm = .{
                        .e = e2,
                        .k = try self.mapKey(en.key, key, env, depth),
                        .v = try self.coerceExpr(en.value, value, env, depth, ml.tok),
                    } });
                }
                if (!ml.mut) return self.mk(.{ .freeze = e2 });
                return e2;
            },
            .index => |ix| {
                // map の添字は getm（m[k] : V?）、slice は index。subject の型で分岐
                if (self.computeTy(ix.base, env)) |bt| {
                    if (bt.* == .map) {
                        const base = try self.expr(ix.base, env, depth);
                        const idx = try self.expr(ix.idx, env, depth);
                        return self.mk(.{ .getm = .{ .t = try self.mapValueAt(ix.base, bt, env), .e = base, .k = idx } });
                    }
                }
                // string は添字を持たない（見方を名指し — bytes(s)[i]）
                if (isStringTy(self.computeTy(ix.base, env))) return self.fail(error.Malformed, ix.tok, "string has no indexing; name the view (bytes(s))");
                const base = try self.expr(ix.base, env, depth);
                const idx = try self.expr(ix.idx, env, depth);
                return self.mk(.{ .index = .{ .e = base, .i = idx, .t = self.readAnn(self.computeTy(ix.base, env)) } });
            },
            .slice3 => |s3| {
                // `xs[a:b]`（imm 限定 — 21 節。極性は検査器が subslice 規則で落とす）。string は対象外
                if (isStringTy(self.computeTy(s3.base, env))) return self.fail(error.Malformed, s3.tok, "string has no slicing; name the view (bytes(s))");
                const base = try self.expr(s3.base, env, depth);
                const lo = try self.expr(s3.lo, env, depth);
                const hi = try self.expr(s3.hi, env, depth);
                return self.mk(.{ .subslice = .{ .e = base, .a = lo, .b = hi } });
            },
            .binary => |b| {
                // string（imm byte slice）の == / != / + は eqs / concat（21 節）。
                // どちらかの型が string と分かれば分岐、両方不明なら int 系のまま
                if (b.op == .equal_equal or b.op == .bang_equal or b.op == .plus) {
                    const l_str = isStringTy(self.computeTy(b.lhs, env));
                    const r_str = isStringTy(self.computeTy(b.rhs, env));
                    if (l_str or r_str) {
                        const lhs2 = try self.expr(b.lhs, env, depth);
                        const rhs2 = try self.expr(b.rhs, env, depth);
                        switch (b.op) {
                            .plus => return self.mk(.{ .concat = .{ .a = lhs2, .b = rhs2 } }),
                            .equal_equal => return self.mk(.{ .eqs = .{ .a = lhs2, .b = rhs2 } }),
                            .bang_equal => return self.mk(.{ .ite = .{
                                .c = try self.mk(.{ .eqs = .{ .a = lhs2, .b = rhs2 } }),
                                .t = try self.mk(.ff),
                                .e = try self.mk(.tt),
                            } }),
                            else => unreachable,
                        }
                    }
                }
                // `x == nil` / `x != nil`: ifnil の tt / ff（タグ検査）
                if ((b.op == .equal_equal or b.op == .bang_equal) and (b.lhs.* == .nil or b.rhs.* == .nil)) {
                    if (b.lhs.* == .nil and b.rhs.* == .nil)
                        return self.fail(error.CoreFragment, b.tok, "comparing nil with nil");
                    const side = if (b.lhs.* == .nil) b.rhs else b.lhs;
                    const subject = try self.expr(side, env, depth);
                    const is_eq = b.op == .equal_equal;
                    return self.mk(.{ .ifnil = .{
                        .e = subject,
                        .nil_case = try self.mk(if (is_eq) CExpr.tt else CExpr.ff),
                        .some_case = try self.mk(if (is_eq) CExpr.ff else CExpr.tt),
                    } });
                }
                // 短絡演算子は ite へ（短絡がそのまま出る）
                switch (b.op) {
                    .ampersand_ampersand => {
                        const lhs = try self.expr(b.lhs, env, depth);
                        const rhs = try self.expr(b.rhs, env, depth);
                        return self.mk(.{ .ite = .{ .c = lhs, .t = rhs, .e = try self.mk(.ff) } });
                    },
                    .pipe_pipe => {
                        const lhs = try self.expr(b.lhs, env, depth);
                        const rhs = try self.expr(b.rhs, env, depth);
                        return self.mk(.{ .ite = .{ .c = lhs, .t = try self.mk(.tt), .e = rhs } });
                    },
                    else => {},
                }
                // bool の == / != はコアの cmp（int × int）に無いので ite の形に落とす（形の変換のみ）
                if ((b.op == .equal_equal or b.op == .bang_equal) and self.isBoolTy(self.computeTy(b.lhs, env))) {
                    const lhs = try self.expr(b.lhs, env, depth);
                    const rhs = try self.expr(b.rhs, env, depth);
                    return self.boolEq(lhs, rhs, b.op == .equal_equal);
                }
                const lhs = try self.expr(b.lhs, env, depth);
                const rhs = try self.expr(b.rhs, env, depth);
                const kind: []const u8 = switch (b.op) {
                    .plus => return self.mk(.{ .add = .{ .a = lhs, .b = rhs } }),
                    .less => return self.mk(.{ .lt = .{ .a = lhs, .b = rhs } }),
                    .minus => "sub",
                    .star => "mul",
                    .slash => "div",
                    .percent => "mod",
                    .equal_equal => "eq",
                    .bang_equal => "ne",
                    .less_equal => "le",
                    .greater => "gt",
                    .greater_equal => "ge",
                    .ampersand => "and",
                    .pipe => "or",
                    .caret => "xor",
                    .shl => "shl",
                    .shr => "shr",
                    else => return self.fail(error.CoreFragment, b.tok, "operator outside the core fragment"),
                };
                return self.mk(.{ .bin = .{ .kind = kind, .a = lhs, .b = rhs } });
            },
            .unary => |u| {
                switch (u.op) {
                    .minus => {
                        if (u.operand.* == .int) return self.mk(.{ .lit = -u.operand.int.value });
                        const operand = try self.expr(u.operand, env, depth);
                        return self.mk(.{ .bin = .{ .kind = "sub", .a = try self.mk(.{ .lit = 0 }), .b = operand } });
                    },
                    .bang => {
                        const operand = try self.expr(u.operand, env, depth);
                        return self.mk(.{ .ite = .{ .c = operand, .t = try self.mk(.ff), .e = try self.mk(.tt) } });
                    },
                    .caret => {
                        // ^x（ビット NOT）= x ^ -1
                        const operand = try self.expr(u.operand, env, depth);
                        return self.mk(.{ .bin = .{ .kind = "xor", .a = operand, .b = try self.mk(.{ .lit = -1 }) } });
                    },
                    else => return self.fail(error.CoreFragment, u.tok, "unary operator outside the core fragment"),
                }
            },
            .call => |c| return self.call(c.callee, c.args, c.tok, env, depth),
            .pipe => |p| {
                // `lhs |> callee(args)`: 穴があれば穴に、無ければ第 1 引数に lhs
                var args: std.ArrayListUnmanaged(*ast.Expr) = .empty;
                var has_hole = false;
                for (p.args) |arg| {
                    if (arg == null) has_hole = true;
                }
                if (!has_hole) try args.append(self.a, p.lhs);
                for (p.args) |arg| try args.append(self.a, arg orelse p.lhs);
                return self.call(p.callee, try args.toOwnedSlice(self.a), p.tok, env, depth);
            },
            .composite => |c| return self.composite(c, env, depth),
            .selector => |sel| {
                // 修飾 const 参照 `pkg.N`（base がローカルに無く import の参照名なら）
                if (sel.base.* == .ident and lookup(env, sel.base.ident.name) == null and
                    self.cur_pkg.imports.get(sel.base.ident.name) != null)
                {
                    const r = self.resolveIn(self.cur_pkg, try self.dotted(sel.base.ident.name, sel.field)) orelse
                        return self.fail(error.UnknownName, sel.tok, "unexported or unknown name");
                    if (lookupConst(r.pkg, r.base)) |c| {
                        if (c.dict) return self.dictExpr(c, r.pkg, depth);
                        return self.mk(.{ .lit = c.value.? });
                    }
                    if (try self.findFn(e, env)) |entry| return self.fnRef(entry, sel.tok);
                    return self.fail(error.UnknownName, sel.tok, "unknown name in the imported package");
                }
                const base_decl = self.declOfExpr(sel.base, env) orelse
                    return self.fail(error.CoreFragment, sel.tok, "selector base type is unknown");
                const fields = switch (base_decl.decl.body) {
                    .struct_ => |fs| fs,
                    .union_ => return self.fail(error.Malformed, sel.tok, "field access on a union value (use a switch pattern)"),
                    .func_ => return self.fail(error.Malformed, sel.tok, "field access on a function type"),
                    .error_ => return self.fail(error.Malformed, sel.tok, "an error label is not a type (use error)"),
                };
                const idx = for (fields, 0..) |f, i| {
                    if (std.mem.eql(u8, f.name, sel.field)) break i;
                } else return self.fail(error.UnknownName, sel.tok, "unknown field");
                const base = try self.expr(sel.base, env, depth);
                return self.projection(base, idx, fields.len);
            },
            .lambda => |l| return self.fail(error.CoreFragment, l.tok, "lambda outside a function-typed argument"),
            .if_ => |i| {
                const stmt = self.stmt_if;
                self.stmt_if = false;
                // flow typing: `if x != nil` / `if x == nil` は ifnil（値のある腕で x を再束縛）
                // 腕の末尾の jump（V4）の注釈: 期待型が来ていなければ腕の型から（文位置の腕は discard が unit に揃える）
                const arm_want = if (stmt) null else want orelse self.ifTy(i, env);
                if (self.nilTest(i.cond, env)) |nt| return self.ifnilExpr(nt, i, env, depth, arm_want, stmt);
                const cond = try self.expr(i.cond, env, depth);
                if (i.else_) |els| {
                    const then = try self.scoped(i.then.stmts, env, depth, .{ .want = arm_want, .discard = stmt });
                    // else 腕のブロックは then と同じく透過（region 境界ではない）
                    const other = if (els.* == .block)
                        try self.scoped(els.block.stmts, env, depth, .{ .want = arm_want, .discard = stmt })
                    else blk: {
                        self.tail_want = arm_want;
                        self.stmt_if = stmt and els.* == .if_;
                        break :blk try self.expr(els, env, depth);
                    };
                    return self.mk(.{ .ite = .{ .c = cond, .t = then, .e = other } });
                }
                // else 無し（文位置）: 両腕 unit の ite
                const then = try self.scoped(i.then.stmts, env, depth, .{ .discard = true });
                return self.mk(.{ .ite = .{ .c = cond, .t = then, .e = try self.mk(.triv) } });
            },
            .switch_ => |sw| return self.switchExpr(sw, env, depth, want),
            .block => |blk| {
                self.rdepth += 1;
                defer self.rdepth -= 1;
                const inner = try self.scoped(blk.stmts, env, depth, .{ .want = want });
                // R5: 末尾値がブロックの region（最内）のコンテナを持つなら、出口で親の最内へ写す（普通の出口 = 暗黙のラベルへの脱出）
                if (self.blockTailTy(blk.stmts, env)) |tt| {
                    const k = self.rdepth - 2;
                    if (tyRegionAbove(tt, k)) {
                        const t = if (want) |w| w else try self.tyClamp(tt, k);
                        return self.mk(.{ .blockR = .{ .t = t, .e = inner } });
                    }
                }
                return self.mk(.{ .block = inner });
            },
            .for_ => |f| return self.fail(error.CoreFragment, f.tok, "a for expression is consumed only as an Iter argument (an escaping Iter is outside the fragment)"),
            .mut_arg => |m| return self.fail(error.Malformed, m.tok, "`mut x` marks only an argument of a mut parameter"),
        }
    }

    // ── 型宣言の対応（struct → prod 鎖、n-ary union → union の入れ子）──────────────

    fn lookupType(self: *Desugarer, from: *const ast.Pkg, name: []const u8) ?DeclRef {
        const r = self.resolveIn(from, name) orelse return null;
        for (r.pkg.files) |file| {
            for (file.types) |td| {
                if (std.mem.eql(u8, td.name, r.base)) return .{ .decl = td, .pkg = r.pkg };
            }
        }
        return null;
    }

    fn dotted(self: *Desugarer, ref: []const u8, base: []const u8) Error![]const u8 {
        return std.fmt.allocPrint(self.a, "{s}.{s}", .{ ref, base });
    }

    /// 参照名（"N" か "ref.N"）→ (宣言を探す pkg, 基底名)。
    /// 修飾参照は from の import 表で解決し、公開（大文字）を検査する（language.md 20 節）
    fn resolveIn(self: *Desugarer, from: *const ast.Pkg, name: []const u8) ?struct { pkg: *const ast.Pkg, base: []const u8 } {
        if (std.mem.indexOfScalar(u8, name, '.')) |dot| {
            const path = from.imports.get(name[0..dot]) orelse return null;
            const base = name[dot + 1 ..];
            if (base.len == 0 or !std.ascii.isUpper(base[0])) return null;
            for (self.prog.pkgs) |pkg| {
                if (std.mem.eql(u8, pkg.path, path)) return .{ .pkg = pkg, .base = base };
            }
            return null;
        }
        return .{ .pkg = from, .base = name };
    }

    fn lookupConst(from: *const ast.Pkg, name: []const u8) ?*const ast.ConstDecl {
        for (from.files) |file| {
            for (file.consts) |c| {
                if (std.mem.eql(u8, c.name, name)) return c;
            }
        }
        return null;
    }

    /// 式が辞書 const の参照（`N` / `pkg.N`）なら その宣言と宣言側 pkg
    fn dictConstOf(self: *Desugarer, e: *const ast.Expr, env: Env) ?struct { c: *const ast.ConstDecl, pkg: *const ast.Pkg } {
        switch (e.*) {
            .ident => |id| {
                if (lookup(env, id.name) != null) return null;
                const c = lookupConst(self.cur_pkg, id.name) orelse return null;
                return if (c.dict) .{ .c = c, .pkg = self.cur_pkg } else null;
            },
            .selector => |sel| {
                if (sel.base.* != .ident or lookup(env, sel.base.ident.name) != null) return null;
                if (self.cur_pkg.imports.get(sel.base.ident.name) == null) return null;
                const name = self.dotted(sel.base.ident.name, sel.field) catch return null;
                const r = self.resolveIn(self.cur_pkg, name) orelse return null;
                const c = lookupConst(r.pkg, r.base) orelse return null;
                return if (c.dict) .{ .c = c, .pkg = r.pkg } else null;
            },
            else => return null,
        }
    }

    /// 辞書 const の文脈（宣言側 package・空の型環境・型パラメータ無し）に切り替える
    const DictCtx = struct { pkg: *const ast.Pkg, tenv: []const TBind, tparams: u32, outer: ?Env, in_dict: bool };
    fn enterDictCtx(self: *Desugarer, pkg: *const ast.Pkg) DictCtx {
        const saved: DictCtx = .{ .pkg = self.cur_pkg, .tenv = self.tenv, .tparams = self.cur_tparams, .outer = self.lift_outer, .in_dict = self.in_dict_const };
        self.cur_pkg = pkg;
        self.tenv = &.{};
        self.cur_tparams = 0;
        self.lift_outer = null;
        self.in_dict_const = true;
        return saved;
    }
    fn restoreDictCtx(self: *Desugarer, saved: DictCtx) void {
        self.cur_pkg = saved.pkg;
        self.tenv = saved.tenv;
        self.cur_tparams = saved.tparams;
        self.lift_outer = saved.outer;
        self.in_dict_const = saved.in_dict;
    }

    /// 辞書 const の参照点での展開（language.md 25 節: 同一性は保証しない — 参照ごとに struct を作り直す）
    fn dictExpr(self: *Desugarer, c: *const ast.ConstDecl, pkg: *const ast.Pkg, depth: u32) Error!*const CExpr {
        const saved = self.enterDictCtx(pkg);
        defer self.restoreDictCtx(saved);
        const saved_c = self.dict_const;
        const saved_p = self.dict_pkg;
        defer self.dict_const = saved_c;
        defer self.dict_pkg = saved_p;
        self.dict_const = c;
        self.dict_pkg = pkg.path;
        return self.expr(c.expr, Env.empty, depth);
    }

    /// 名前の型を断片の Ty へ（int / struct / union）。te は pkg の文脈で書かれた型
    fn tyOf(self: *Desugarer, pkg: *const ast.Pkg, te: ast.TypeExpr, tok: u32, fuel: u32) Error!*const Ty {
        if (fuel == 0) return self.fail(error.CoreFragment, tok, "recursive type");
        switch (te) {
            .name => |name| {
                for (self.tenv) |b| {
                    if (std.mem.eql(u8, b.name, name)) return b.ty;
                }
                if (std.mem.eql(u8, name, "int")) return self.mkTy(.int);
                if (std.mem.eql(u8, name, "bool")) return self.mkTy(.bool_);
                // string = imm byte slice（language.md 21 節）。region は使用点の深さに
                // 依存しない静的データ = 最外 region（r = 0）
                if (std.mem.eql(u8, name, "string"))
                    return self.mkTy(.{ .slice = .{ .m = false, .r = 0, .t = try self.mkTy(.int), .str = true } });
                // 組み込みの error = 先頭のラベル（全ラベルの閉じた union — V4-4a）+ 包み替えの鎖（R4b K1'' —
                // imm []L、外側が末尾。cause = (鎖の末尾, 鎖の残り)）
                if (std.mem.eql(u8, name, "error"))
                    return self.errTy(pkg, tok, fuel - 1);
                const td = self.lookupType(pkg, name) orelse
                    return self.fail(error.CoreFragment, tok, "type outside the core fragment");
                return switch (td.decl.body) {
                    .struct_ => |fields| self.fieldsTy(td.pkg, fields, tok, fuel - 1),
                    .union_ => |variants| self.unionTreeTy(td.pkg, variants, tok, fuel - 1),
                    .func_ => self.fail(error.CoreFragment, tok, "a named function type is expanded at load (loader)"),
                    .error_ => self.fail(error.Malformed, tok, "an error label is not a type (use error)"),
                };
            },
            // ジェネリック struct の適用（V3-3）: 型引数を束縛してフィールド列の prod 鎖へ
            .generic => |g| {
                const td = self.lookupType(pkg, g.name) orelse
                    return self.fail(error.CoreFragment, tok, "type outside the core fragment");
                const env = try self.genericEnv(pkg, td, g.args, tok);
                const saved = self.tenv;
                defer self.tenv = saved;
                self.tenv = env;
                return switch (td.decl.body) {
                    .struct_ => |fields| self.fieldsTy(td.pkg, fields, tok, fuel - 1),
                    .union_ => self.fail(error.CoreFragment, tok, "generic union"),
                    .func_ => self.fail(error.CoreFragment, tok, "a named function type is expanded at load (loader)"),
                    .error_ => self.fail(error.Malformed, tok, "an error label is not a type (use error)"),
                };
            },
            // 関数型 = 閉じた関数値の型（V3-1）。シグネチャは defOf と同じ組み立て
            .func => |ft| {
                const ps = try self.a.alloc(*const Ty, ft.params.len);
                for (ft.params, 0..) |pt, i| ps[i] = try self.tyOf(pkg, pt, tok, fuel - 1);
                const rs = try self.a.alloc(*const Ty, ft.results.len);
                for (ft.results, 0..) |rt, i| rs[i] = try self.retTy(try self.tyOf(pkg, rt, tok, fuel - 1));
                return self.mkTy(.{ .fn_ = .{ .p = try self.tyChain(ps), .r = try self.tyChain(rs) } });
            },
            .opt => |inner| return self.mkTy(.{ .opt = try self.tyOf(pkg, inner.*, tok, fuel - 1) }),
            // `[]T` / `map[K]V` の region 添字は呼び手空間の上界 = 0（round4: Def は
            // base 1 で型付け、region 0 = 圧縮された呼び手空間）。戻り値の最上段だけ
            // defOf が自フレーム（r = 1）に付け替える
            .slice_of => |sl| return self.mkTy(.{ .slice = .{
                .m = sl.mut,
                .r = 0,
                .t = try self.tyOf(pkg, sl.elem.*, tok, fuel - 1),
            } }),
            .map_of => |mp| {
                const key = try self.mapKeyTy(try self.tyOf(pkg, mp.key.*, tok, fuel - 1), tok);
                return self.mkTy(.{ .map = .{
                    .m = mp.mut,
                    .r = 0,
                    .k = key,
                    .t = try self.tyOf(pkg, mp.value.*, tok, fuel - 1),
                } });
            },
        }
    }

    /// フィールド列 → 右結合の prod 鎖（0 は unit、1 は素の型）。フィールド型は宣言側 pkg で解決
    /// ジェネリック struct の型引数 → 束縛（型引数は呼び手の文脈 = 現在の tenv で解決）。
    /// 型引数は値を持つ型なら region を含んでよい（R1 = ①s: ジェネリック struct は使用点で prod 鎖に展開され、
    /// コアに届く型は具体型。座標は点座標 pointTy が付ける）。チャネル・関数型は不可
    fn genericEnv(self: *Desugarer, pkg: *const ast.Pkg, td: DeclRef, args: []const ast.TypeExpr, tok: u32) Error![]const TBind {
        if (args.len != td.decl.type_params.len) return self.fail(error.Malformed, tok, "type argument count");
        const env = try self.a.alloc(TBind, args.len);
        for (args, td.decl.type_params, env) |ae, n, *b| {
            const t = try self.tyOf(pkg, ae, tok, 32);
            if (!tyArgValueOk(t)) return self.fail(error.CoreFragment, tok, "a type argument must be a value type (no channels)");
            b.* = .{ .name = n, .ty = t };
        }
        return env;
    }

    /// 束縛 env のもとで te を解決する（宣言側の型を、インスタンスの型引数で読む）
    fn tyIn(self: *Desugarer, pkg: *const ast.Pkg, env: []const TBind, te: ast.TypeExpr, tok: u32) Error!*const Ty {
        const saved = self.tenv;
        defer self.tenv = saved;
        self.tenv = env;
        return self.tyOf(pkg, te, tok, 32);
    }

    fn fieldsTy(self: *Desugarer, pkg: *const ast.Pkg, fields: []const ast.Field, tok: u32, fuel: u32) Error!*const Ty {
        if (fields.len == 0) return self.mkTy(.unit);
        if (fields.len == 1) return self.tyOf(pkg, fields[0].type, tok, fuel);
        const head = try self.tyOf(pkg, fields[0].type, tok, fuel);
        const rest = try self.fieldsTy(pkg, fields[1..], tok, fuel);
        return self.mkTy(.{ .prod = .{ .l = head, .r = rest } });
    }

    /// variant のペイロード型 = フィールド列の prod 鎖
    fn payloadTy(self: *Desugarer, pkg: *const ast.Pkg, v: ast.Variant, tok: u32, fuel: u32) Error!*const Ty {
        _ = tok;
        return self.fieldsTy(v.pkg orelse pkg, v.fields, v.tok, fuel);
    }

    /// variant 列（2 個以上）→ 右結合の union の入れ子
    fn unionTreeTy(self: *Desugarer, pkg: *const ast.Pkg, variants: []const ast.Variant, tok: u32, fuel: u32) Error!*const Ty {
        // error（V4-4a）の特例: ラベル 0 個 = unit（構築できない）、1 個 = ペイロードそのもの
        if (self.isErrors(variants)) {
            if (variants.len == 0) return self.mkTy(.unit);
            if (variants.len == 1) return self.payloadTy(pkg, variants[0], tok, fuel);
        }
        if (variants.len < 2)
            return self.fail(error.CoreFragment, tok, "unions need at least 2 variants in the core fragment");
        const l = try self.payloadTy(pkg, variants[0], tok, fuel);
        const r = if (variants.len == 2)
            try self.payloadTy(pkg, variants[1], tok, fuel)
        else
            try self.unionTreeTy(pkg, variants[1..], tok, fuel);
        return self.mkTy(.{ .union_ = .{ .l = l, .r = r } });
    }

    /// variant 列が組み込み error のラベル列（全体）か
    fn isErrors(self: *const Desugarer, variants: []const ast.Variant) bool {
        return variants.ptr == self.prog.errors.body.union_.ptr and variants.len == self.prog.errors.body.union_.len;
    }

    /// variant 名（"V" か "ref.V"）→ (宣言, pkg, インデックス)。error ラベルは組み込み error の variant として返る
    fn findVariant(self: *Desugarer, from: *const ast.Pkg, name: []const u8) ?struct { decl: *const ast.TypeDecl, pkg: *const ast.Pkg, index: usize } {
        const r = self.resolveIn(from, name) orelse return null;
        for (r.pkg.files) |file| {
            for (file.types) |td| {
                const variants = switch (td.body) {
                    .union_ => |vs| vs,
                    .error_ => {
                        if (!std.mem.eql(u8, td.name, r.base)) continue;
                        const errs = self.prog.errors;
                        for (errs.body.union_, 0..) |v, i| {
                            if (v.pkg == r.pkg and std.mem.eql(u8, v.name, r.base)) return .{ .decl = errs, .pkg = r.pkg, .index = i };
                        }
                        return null;
                    },
                    .struct_, .func_ => continue,
                };
                for (variants, 0..) |v, i| {
                    if (std.mem.eql(u8, v.name, r.base)) return .{ .decl = td, .pkg = r.pkg, .index = i };
                }
            }
        }
        return null;
    }

    /// 式の値の型宣言（struct / union）を静的に辿る。selector / フィールド代入の解決用
    fn declOfExpr(self: *Desugarer, e: *const ast.Expr, env: Env) ?DeclRef {
        if (self.dictConstOf(e, env)) |dc| {
            const saved = self.enterDictCtx(dc.pkg);
            defer self.restoreDictCtx(saved);
            return self.declOfExpr(dc.c.expr, Env.empty);
        }
        switch (e.*) {
            .ident => |id| {
                const b = lookup(env, id.name) orelse return null;
                return b.decl;
            },
            .try_ => |t| {
                if (t.e.* != .call) return null;
                self.try_skip = 1;
                defer self.try_skip = 0;
                return self.declOfExpr(t.e, env);
            },
            // 呼び出しの結果（単値）: 戻り値型の宣言。ジェネリックなら推論した型引数の束縛で読む（V3-3）
            .call => |c| {
                const skip = self.try_skip;
                self.try_skip = 0;
                var callee = c.callee;
                var explicit: ?*const ast.Expr = null;
                if (callee.* == .index) {
                    explicit = callee.index.idx;
                    callee = callee.index.base;
                }
                const entry = (self.findFn(callee, env) catch return null) orelse return null;
                if (entry.decl.results.len != 1 + skip) return null;
                if (entry.decl.type_params.len == 0) return self.declOfTypeExpr(entry.pkg, entry.decl.results[0]);
                const penv = self.callEnv(entry, explicit, c.args, env, c.tok) catch return null;
                const saved = self.tenv;
                defer self.tenv = saved;
                self.tenv = penv;
                return self.declOfTypeExpr(entry.pkg, entry.decl.results[0]);
            },
            .composite => |c| {
                if (self.lookupType(self.cur_pkg, c.type_name)) |td| {
                    if (td.decl.body == .struct_) {
                        // ジェネリック struct のリテラル: 型引数の束縛を運ぶ（呼び手の文脈 = 現在の tenv で解決）
                        if (c.type_args.len > 0) {
                            const genv = self.genericEnv(self.cur_pkg, td, c.type_args, c.tok) catch return null;
                            return .{ .decl = td.decl, .pkg = td.pkg, .env = genv };
                        }
                        return td;
                    }
                }
                if (self.findVariant(self.cur_pkg, c.type_name)) |found|
                    return .{ .decl = found.decl, .pkg = found.pkg };
                return null;
            },
            .selector => |sel| {
                const base = self.declOfExpr(sel.base, env) orelse return null;
                const fields = switch (base.decl.body) {
                    .struct_ => |fs| fs,
                    .union_, .func_, .error_ => return null,
                };
                for (fields) |f| {
                    if (!std.mem.eql(u8, f.name, sel.field)) continue;
                    // フィールド型は宣言側 pkg の文脈で解決
                    return switch (f.type) {
                        .name => |n| self.lookupType(base.pkg, n),
                        .generic => blk: {
                            const saved = self.tenv;
                            defer self.tenv = saved;
                            self.tenv = base.env;
                            break :blk self.declOfTypeExpr(base.pkg, f.type);
                        },
                        .func, .opt, .slice_of, .map_of => null,
                    };
                }
                return null;
            },
            .index => |ix| return self.elemDeclOfExpr(ix.base, env),
            .block => |blk| {
                const tail = blk.tailExpr() orelse return null;
                return self.declOfExpr(tail, env);
            },
            .if_ => |i| {
                var blk_env = env;
                _ = &blk_env;
                const tail = i.then.tailExpr() orelse return null;
                return self.declOfExpr(tail, env);
            },
            else => return null,
        }
    }

    /// 型宣言つきの TypeExpr → decl（名前が struct / union 宣言なら）。te は pkg の文脈
    fn declOfTypeExpr(self: *Desugarer, pkg: *const ast.Pkg, te: ast.TypeExpr) ?DeclRef {
        return switch (te) {
            .name => |n| blk: {
                // 型パラメータ（呼び出しの束縛が型引数の宣言を運ぶ — V3-3）
                for (self.tenv) |b| {
                    if (std.mem.eql(u8, b.name, n)) break :blk b.decl;
                }
                break :blk self.lookupType(pkg, n);
            },
            // ジェネリック struct（V3-3）: フィールドの型はインスタンスの型引数の束縛で読む
            .generic => |g| blk: {
                const td = self.lookupType(pkg, g.name) orelse break :blk null;
                const env = self.genericEnv(pkg, td, g.args, 0) catch break :blk null;
                break :blk .{ .decl = td.decl, .pkg = td.pkg, .env = env };
            },
            // `T?` はペイロードの宣言（flow typing で再束縛した名前の `.field` が引く — V5-7。
            // 絞り込み前の `x.field` は opt への射影になり Lean が型で拒否する）
            .opt => |o| self.declOfTypeExpr(pkg, o.*),
            .func, .slice_of, .map_of => null,
        };
    }

    /// slice 型注釈の要素型宣言（`[]Node` → Node の decl）
    fn elemDeclOfTypeExpr(self: *Desugarer, pkg: *const ast.Pkg, te: ast.TypeExpr) ?DeclRef {
        return switch (te) {
            .slice_of => |s| self.declOfTypeExpr(pkg, s.elem.*),
            else => null,
        };
    }

    /// 式が slice のとき、その要素型宣言。`xs[i]` の declOfExpr が base 側から引く
    fn elemDeclOfExpr(self: *Desugarer, e: *const ast.Expr, env: Env) ?DeclRef {
        switch (e.*) {
            .ident => |id| {
                const b = lookup(env, id.name) orelse return null;
                return b.elem_decl;
            },
            .try_ => |t| {
                if (t.e.* != .call) return null;
                self.try_skip = 1;
                defer self.try_skip = 0;
                return self.elemDeclOfExpr(t.e, env);
            },
            .slicelit => |sl| return self.declOfTypeExpr(self.cur_pkg, sl.elem),
            .slice3 => |s3| return self.elemDeclOfExpr(s3.base, env),
            // struct の slice フィールド `c.ts`（V5-7）: フィールド型は宣言側 pkg・型引数はインスタンスの束縛で読む
            .selector => |sel| {
                const base = self.declOfExpr(sel.base, env) orelse return null;
                const fields = switch (base.decl.body) {
                    .struct_ => |fs| fs,
                    .union_, .func_, .error_ => return null,
                };
                for (fields) |f| {
                    if (!std.mem.eql(u8, f.name, sel.field)) continue;
                    const saved = self.tenv;
                    defer self.tenv = saved;
                    self.tenv = base.env;
                    return self.elemDeclOfTypeExpr(base.pkg, f.type);
                }
                return null;
            },
            .call => |c| {
                const skip = self.try_skip;
                self.try_skip = 0;
                // freeze(xs) は要素型を変えない
                if (skip == 0 and c.callee.* == .ident and std.mem.eql(u8, c.callee.ident.name, "freeze") and c.args.len == 1)
                    return self.elemDeclOfExpr(c.args[0], env);
                var callee = c.callee;
                var explicit: ?*const ast.Expr = null;
                if (callee.* == .index) {
                    explicit = callee.index.idx;
                    callee = callee.index.base;
                }
                const fe = (self.findFn(callee, env) catch return null) orelse return null;
                if (fe.decl.results.len != 1 + skip) return null;
                if (fe.decl.type_params.len == 0) return self.elemDeclOfTypeExpr(fe.pkg, fe.decl.results[0]);
                const penv = self.callEnv(fe, explicit, c.args, env, c.tok) catch return null;
                const saved = self.tenv;
                defer self.tenv = saved;
                self.tenv = penv;
                return self.elemDeclOfTypeExpr(fe.pkg, fe.decl.results[0]);
            },
            else => return null,
        }
    }

    // ── 直積の構築と射影 ──────────────────────────────

    /// 値列 → 右結合の pair 鎖（0 は triv、1 は素の値）
    fn pairChain(self: *Desugarer, values: []const *const CExpr) Error!*const CExpr {
        if (values.len == 0) return self.mk(.triv);
        if (values.len == 1) return values[0];
        const rest = try self.pairChain(values[1..]);
        return self.mk(.{ .pair = .{ .a = values[0], .b = rest } });
    }

    /// n フィールドの i 番目の射影: i < n-1 は fst(snd^i)、i = n-1 は snd^(n-1)
    fn projection(self: *Desugarer, base: *const CExpr, i: usize, n: usize) Error!*const CExpr {
        var cur = base;
        var k: usize = 0;
        while (k < i) : (k += 1) cur = try self.mk(.{ .snd = cur });
        if (n >= 2 and i < n - 1) cur = try self.mk(.{ .fst = cur });
        return cur;
    }

    /// struct リテラルの値列（フィールド順に評価。名前つきは位置に並べ替え）。
    /// 各値は letE で入れ子にならず pair 鎖の中で順に評価されるので depth は動かない
    fn fieldValues(self: *Desugarer, pkg: *const ast.Pkg, fields: []const ast.Field, elems: []const ast.Elem, tok: u32, env: Env, depth: u32) Error![]const *const CExpr {
        return self.fieldValuesIn(pkg, self.tenv, fields, elems, tok, env, depth);
    }

    /// フィールドの期待型は宣言側の束縛 fenv で、要素の式は呼び手の束縛（現在の tenv）で読む
    fn fieldValuesIn(self: *Desugarer, pkg: *const ast.Pkg, fenv: []const TBind, fields: []const ast.Field, elems: []const ast.Elem, tok: u32, env: Env, depth: u32) Error![]const *const CExpr {
        const out = try self.a.alloc(*const CExpr, fields.len);
        // ゼロ値リテラル `T{}`（syntax.md の約束 — V3-5）: フィールドごとのゼロ。固定テンプレート（形の変換）
        if (elems.len == 0 and fields.len > 0) {
            for (fields, 0..) |f, i| {
                const want = self.tyIn(pkg, fenv, f.type, tok) catch return self.fail(error.CoreFragment, tok, "zero-value literal: field type outside the core fragment");
                out[i] = try self.zeroOf(want, tok);
            }
            return out;
        }
        if (elems.len != fields.len)
            return self.fail(error.Malformed, tok, "element count differs from the fields");
        if (elems.len > 0 and elems[0].key != null) {
            for (fields, 0..) |f, i| {
                const elem = for (elems) |el| {
                    const key = el.key orelse return self.fail(error.Malformed, tok, "mixing positional and named fields");
                    if (std.mem.eql(u8, key, f.name)) break el;
                } else return self.fail(error.Malformed, tok, "missing field in literal");
                const want = self.tyIn(pkg, fenv, f.type, tok) catch null;
                self.lift_hint = if (f.type == .func) .{ .pkg = pkg, .env = fenv, .ft = f.type.func } else null;
                defer self.lift_hint = null;
                out[i] = if (want) |w|
                    try self.coerceExpr(elem.value, w, env, depth, tok)
                else
                    try self.expr(elem.value, env, depth);
            }
        } else {
            for (elems, 0..) |el, i| {
                if (el.key != null) return self.fail(error.Malformed, tok, "mixing positional and named fields");
                const want = self.tyIn(pkg, fenv, fields[i].type, tok) catch null;
                self.lift_hint = if (fields[i].type == .func) .{ .pkg = pkg, .env = fenv, .ft = fields[i].type.func } else null;
                defer self.lift_hint = null;
                out[i] = if (want) |w|
                    try self.coerceExpr(el.value, w, env, depth, tok)
                else
                    try self.expr(el.value, env, depth);
            }
        }
        return out;
    }

    // ── union の構築と分解 ──────────────────────────────

    /// 代入先の期待型（T? coercion 用）。分からなければ null
    fn targetTy(self: *Desugarer, target: *const ast.Expr, env: Env) ?*const Ty {
        switch (target.*) {
            .ident => |id| {
                const b = lookup(env, id.name) orelse return null;
                return b.ty;
            },
            .selector => |sel| {
                const base = self.declOfExpr(sel.base, env) orelse return null;
                const fields = switch (base.decl.body) {
                    .struct_ => |fs| fs,
                    .union_, .func_, .error_ => return null,
                };
                for (fields) |f| {
                    if (std.mem.eql(u8, f.name, sel.field)) return self.tyIn(base.pkg, base.env, f.type, sel.tok) catch null;
                }
                return null;
            },
            else => return null,
        }
    }

    /// 式のコア型を静的に計算する（T? の暗黙 some の判定用）。分からなければ null
    /// string = imm byte slice（21 節）
    fn isStringTy(t: ?*const Ty) bool {
        const ty = t orelse return false;
        return ty.* == .slice and ty.slice.str;
    }

    fn isBoolTy(_: *Desugarer, t: ?*const Ty) bool {
        return if (t) |tt| tt.* == .bool_ else false;
    }

    /// bool の等値: a == b は `if a { b } else { !b }`、!= は腕を入れ替える（a → b の評価順を保つ）
    fn boolEq(self: *Desugarer, a: *const CExpr, b: *const CExpr, eq: bool) Error!*const CExpr {
        const not_b = try self.mk(.{ .ite = .{ .c = b, .t = try self.mk(.ff), .e = try self.mk(.tt) } });
        return self.mk(.{ .ite = .{ .c = a, .t = if (eq) b else not_b, .e = if (eq) not_b else b } });
    }

    /// 補間を連結の連鎖に脱糖する（interp.zig の固定テンプレート。型判定は computeTy）
    fn lowerInterp(self: *Desugarer, it: ast.Interp, env: Env) Error!*const ast.Expr {
        var bad: ?*const ast.Expr = null;
        return interp.lower(self.a, it, InterpCtx{ .d = self, .env = env }, interpKind, &bad) catch |err| switch (err) {
            error.OutOfMemory => error.OutOfMemory,
            error.BadType => self.fail(error.CoreFragment, bad.?.tok(), "interpolation takes int, string or bool"),
        };
    }

    const InterpCtx = struct { d: *Desugarer, env: Env };

    fn interpKind(c: InterpCtx, e: *const ast.Expr) ?interp.Kind {
        // struct / union の値は拒否（1 フィールドの struct は core で素の型と同型なので、型だけでは見分けられない）
        if (c.d.declOfExpr(e, c.env) != null) return null;
        const t = c.d.computeTy(e, c.env) orelse return null;
        return switch (t.*) {
            .int => .int,
            .bool_ => .bool,
            .slice => |sl| if (sl.str) .string else null,
            else => null,
        };
    }

    fn computeTy(self: *Desugarer, e: *const ast.Expr, env: Env) ?*const Ty {
        switch (e.*) {
            .for_ => |*fe| return self.forIterTy(fe, env),
            // `mut x`（mut 引数の実引数）: 束縛の型（型引数の推論に使う — V3-5）
            .mut_arg => |m| return if (lookup(env, m.name)) |b| b.ty else null,
            .try_ => |t| {
                if (t.e.* != .call) return null;
                self.try_skip = 1;
                defer self.try_skip = 0;
                return self.computeTy(t.e, env);
            },
            .int => return self.mkTy(.int) catch null,
            .nil => return null,
            .ident => |id| {
                const b = lookup(env, id.name) orelse {
                    if (lookupConst(self.cur_pkg, id.name)) |c| {
                        if (!c.dict) return self.mkTy(.int) catch null;
                        const saved = self.enterDictCtx(self.cur_pkg);
                        defer self.restoreDictCtx(saved);
                        return self.computeTy(c.expr, Env.empty);
                    }
                    if (std.mem.eql(u8, id.name, "true") or std.mem.eql(u8, id.name, "false")) return self.mkTy(.bool_) catch null;
                    // 名前付き関数の参照 = 関数値（シグネチャは defOf と同じ組み立て）
                    const entry = (self.findFn(e, env) catch return null) orelse return null;
                    return self.sigTy(entry) catch null;
                };
                return b.ty;
            },
            .strlit, .interp => return self.mkTy(.{ .slice = .{ .m = false, .r = 0, .t = self.mkTy(.int) catch return null, .str = true } }) catch null,
            .index => |ix| {
                const bt = self.computeTy(ix.base, env) orelse return null;
                return switch (bt.*) {
                    .slice => |sl| sl.t,
                    // m[k] : V?（language.md 22 節）。V はセルが組まれた点の座標（F-34 — getm の注釈と同じ読み）
                    .map => self.mkTy(.{ .opt = self.mapValueAt(ix.base, bt, env) catch return null }) catch null,
                    else => null,
                };
            },
            // xs[a:b] は型不変（同じセル列の新ヘッダ — 21 節）
            .slice3 => |s3| return self.computeTy(s3.base, env),
            .maplit => |ml| {
                const key = self.tyOf(self.cur_pkg, ml.key, ml.tok, 32) catch return null;
                const value = self.tyOf(self.cur_pkg, ml.value, ml.tok, 32) catch return null;
                // リテラルは最内 region に作る（mkmap / mkslice — R5 の出口の判定が region を読む）
                return self.mkTy(.{ .map = .{ .m = ml.mut, .r = self.rdepth - 1, .k = key, .t = value } }) catch null;
            },
            .slicelit => |sl| {
                const elem = self.tyOf(self.cur_pkg, sl.elem, sl.tok, 32) catch return null;
                return self.mkTy(.{ .slice = .{ .m = sl.mut, .r = self.rdepth - 1, .t = elem } }) catch null;
            },
            .binary => |b| return switch (b.op) {
                // string の + は string（連結 — 21 節）
                // 結果は最内 region に作る新しい string（Lean の concat — 被演算子の region ではない。R5 の出口の判定が読む）
                .plus => {
                    const lt = self.computeTy(b.lhs, env);
                    const rt2 = if (isStringTy(lt)) lt else self.computeTy(b.rhs, env);
                    if (isStringTy(rt2)) return self.mkTy(.{ .slice = .{ .m = false, .r = self.rdepth - 1, .t = self.mkTy(.int) catch return null, .str = true } }) catch null;
                    return self.mkTy(.int) catch null;
                },
                .minus, .star, .slash, .percent, .ampersand, .pipe, .caret, .shl, .shr => self.mkTy(.int) catch null,
                .equal_equal, .bang_equal, .less, .less_equal, .greater, .greater_equal, .ampersand_ampersand, .pipe_pipe => self.mkTy(.bool_) catch null,
                else => null,
            },
            .unary => |u| return switch (u.op) {
                .minus, .caret => self.mkTy(.int) catch null,
                .bang => self.mkTy(.bool_) catch null,
                else => null,
            },
            .call => |c| {
                const skip = self.try_skip;
                self.try_skip = 0;
                if (skip == 0 and c.callee.* == .ident) {
                    if (std.mem.eql(u8, c.callee.ident.name, "len")) return self.mkTy(.int) catch null;
                    // keys(m): 最内 region の imm slice（要素 = キー型）
                    if (std.mem.eql(u8, c.callee.ident.name, "keys") and c.args.len == 1) {
                        const mt = self.computeTy(c.args[0], env) orelse return null;
                        if (mt.* != .map) return null;
                        return self.mkTy(.{ .slice = .{ .m = false, .r = self.rdepth - 1, .t = mt.map.k } }) catch null;
                    }
                    if (std.mem.eql(u8, c.callee.ident.name, "append")) {
                        if (c.args.len != 2) return null;
                        return self.computeTy(c.args[0], env);
                    }
                    // freeze(x): 同じ region の imm（R5 の出口の判定が読む）
                    if (std.mem.eql(u8, c.callee.ident.name, "freeze") and c.args.len == 1) {
                        const at = self.computeTy(c.args[0], env) orelse return null;
                        return switch (at.*) {
                            .slice => |sl| self.mkTy(.{ .slice = .{ .m = false, .r = sl.r, .t = sl.t, .str = sl.str } }) catch null,
                            .map => |mp| self.mkTy(.{ .map = .{ .m = false, .r = mp.r, .k = mp.k, .t = mp.t } }) catch null,
                            else => null,
                        };
                    }
                    if (isStdPkg(self.cur_pkg)) {
                        const nm = c.callee.ident.name;
                        if (std.mem.eql(u8, nm, "sysErrno") or std.mem.eql(u8, nm, "sysWriteFile") or std.mem.eql(u8, nm, "sysWriteFd"))
                            return self.mkTy(.int) catch null;
                        if (std.mem.eql(u8, nm, "sysReadFile") or std.mem.eql(u8, nm, "sysReadDir") or std.mem.eql(u8, nm, "sysArgs"))
                            return self.mkTy(.{ .slice = .{ .m = false, .r = self.rdepth - 1, .t = self.mkTy(.int) catch return null } }) catch null;
                    }
                    // bytesToString（std 専用）: bytes の逆で string の印が付く
                    if (std.mem.eql(u8, c.callee.ident.name, "bytesToString") and isStdPkg(self.cur_pkg)) {
                        if (c.args.len != 1) return null;
                        const bt = self.computeTy(c.args[0], env) orelse return null;
                        if (bt.* != .slice or bt.slice.str) return null;
                        return self.mkTy(.{ .slice = .{ .m = false, .r = bt.slice.r, .t = bt.slice.t, .str = true } }) catch null;
                    }
                    // bytes: string の印だけ外れる（同じ region の imm int slice）
                    if (std.mem.eql(u8, c.callee.ident.name, "bytes")) {
                        if (c.args.len != 1) return null;
                        const bt = self.computeTy(c.args[0], env) orelse return null;
                        if (!isStringTy(bt)) return null;
                        return self.mkTy(.{ .slice = .{ .m = false, .r = bt.slice.r, .t = bt.slice.t } }) catch null;
                    }
                    // freeze: mut コンテナ → imm（型は m だけ倒れる）
                    if (std.mem.eql(u8, c.callee.ident.name, "freeze")) {
                        if (c.args.len != 1) return null;
                        const bt = self.computeTy(c.args[0], env) orelse return null;
                        return switch (bt.*) {
                            .slice => |sl| self.mkTy(.{ .slice = .{ .m = false, .r = sl.r, .t = sl.t, .str = sl.str } }) catch null,
                            .map => |mp| self.mkTy(.{ .map = .{ .m = false, .r = mp.r, .k = mp.k, .t = mp.t } }) catch null,
                            else => null,
                        };
                    }
                }
                if (skip == 0) if (self.fnValueTy(c.callee, env)) |ft| return ft.fn_.r;
                var callee = c.callee;
                var explicit: ?*const ast.Expr = null;
                if (callee.* == .index) {
                    explicit = callee.index.idx;
                    callee = callee.index.base;
                }
                const entry = (self.findFn(callee, env) catch return null) orelse return null;
                if (entry.decl.results.len != 1 + skip) return null;
                if (entry.decl.type_params.len > 0) {
                    const ts = self.inferTs(entry, explicit, c.args, env, c.tok, entry.decl.expands) catch return null;
                    const penv = self.a.alloc(TBind, ts.len) catch return null;
                    for (entry.decl.type_params, ts, penv) |n, t, *b| b.* = .{ .name = n, .ty = t };
                    const gt = self.tyIn(entry.pkg, penv, entry.decl.results[0], c.tok) catch return null;
                    return if (plainDef(entry.decl)) self.callResultTop(gt) orelse gt else gt;
                }
                // 素の Def 呼び出し（call）の結果は呼び手の最内 region へ境界コピーされる（Lean の call 結果型 ret.relocR d）— 署名の座標（r0）の
                // ままだと実体より浅く読み、その型を信じた ann（名前の return 等）が実体を締めすぎる（selfhost-drafts F-25）。
                // 展開される関数（関数型 / mut 引数）と anchor つきの callM（mut_def）は結果の座標が別の規則なので従来どおり署名の座標
                const rt = self.tyOf(entry.pkg, entry.decl.results[0], c.tok, 32) catch return null;
                return if (plainDef(entry.decl)) self.callResultTop(rt) orelse rt else rt;
            },
            .composite => |c| {
                if (self.lookupType(self.cur_pkg, c.type_name)) |td| {
                    if (td.decl.body == .struct_) {
                        if (c.type_args.len > 0) {
                            const genv = self.genericEnv(self.cur_pkg, td, c.type_args, c.tok) catch return null;
                            const saved = self.tenv;
                            defer self.tenv = saved;
                            self.tenv = genv;
                            return self.fieldsTy(td.pkg, td.decl.body.struct_, c.tok, 32) catch null;
                        }
                        return self.fieldsTy(td.pkg, td.decl.body.struct_, c.tok, 32) catch null;
                    }
                }
                if (self.findVariant(self.cur_pkg, c.type_name)) |found| {
                    if (found.decl == self.prog.errors) return self.errTy(found.pkg, c.tok, 32) catch null;
                    return self.unionTreeTy(found.pkg, found.decl.body.union_, c.tok, 32) catch null;
                }
                return null;
            },
            .selector => |sel| {
                if (self.dictConstOf(e, env)) |dc| {
                    const saved = self.enterDictCtx(dc.pkg);
                    defer self.restoreDictCtx(saved);
                    return self.computeTy(dc.c.expr, Env.empty);
                }
                const base = self.declOfExpr(sel.base, env) orelse return null;
                const fields = switch (base.decl.body) {
                    .struct_ => |fs| fs,
                    .union_, .func_, .error_ => return null,
                };
                for (fields) |f| {
                    if (std.mem.eql(u8, f.name, sel.field)) return self.tyIn(base.pkg, base.env, f.type, sel.tok) catch null;
                }
                return null;
            },
            .block => |blk| {
                const tail = blk.tailExpr() orelse return null;
                return self.computeTy(tail, env);
            },
            else => return null,
        }
    }

    fn tyEql(a: *const Ty, b: *const Ty) bool {
        if (std.meta.activeTag(a.*) != std.meta.activeTag(b.*)) return false;
        return switch (a.*) {
            .int, .bool_, .unit => true,
            .tvar => |i| i == b.tvar,
            .opt => |t| tyEql(t, b.opt),
            .union_ => |u| tyEql(u.l, b.union_.l) and tyEql(u.r, b.union_.r),
            .prod => |pr| tyEql(pr.l, b.prod.l) and tyEql(pr.r, b.prod.r),
            .ref => |r| r.m == b.ref.m and r.r == b.ref.r and tyEql(r.t, b.ref.t),
            .slice => |sl| sl.m == b.slice.m and sl.r == b.slice.r and sl.str == b.slice.str and tyEql(sl.t, b.slice.t),
            .map => |mp| mp.m == b.map.m and mp.r == b.map.r and tyEql(mp.k, b.map.k) and tyEql(mp.t, b.map.t),
            .chan => |c| c.rc == b.chan.rc and tyEql(c.t, b.chan.t),
            .fn_ => |f| tyEql(f.p, b.fn_.p) and tyEql(f.r, b.fn_.r),
        };
    }

    /// 期待型 want に向けて式を脱糖する。T? の期待に対して nil は注釈つき nil、
    /// ペイロード型の値は some で包む（暗黙 some — language.md 15 節）
    /// return の値: coerceExpr に加え、region だけが結果型と違う名前（仮引数の imm slice をそのまま返す転送 return —
    /// 仮引数は r0、戻り値の最上段は r1）を結果型で ann する（imm の上界を緩める浅い共変 Ty.sub。注釈埋めのみ — V3-5 の
    /// 検査の返還と同じ側）。型が一致・不明・形が違うときは従来どおり（検査に裁かせる）
    fn retValue(self: *Desugarer, e: *const ast.Expr, want: *const Ty, env: Env, depth: u32, tok: u32) Error!*const CExpr {
        const core = try self.coerceExpr(e, want, env, depth, tok);
        // 値ラッパの中のコンテナ（R0）: 引数由来（r0）と自フレーム構築（r1）が混ざるので、結果型へ ann で緩める
        // （浅い共変 Ty.sub が値ラッパへ分配する。一致していれば恒等、緩められなければ検査が拒否する）
        if ((want.* == .opt or want.* == .union_ or want.* == .prod) and wrapsContainer(want))
            return self.mk(.{ .ann = .{ .e = core, .t = want } });
        if (want.* == .opt) return core;
        // 名前: 束縛の型（宣言由来で正確な仮引数・その別名）で判定する
        if (e.* == .ident) {
            const b = lookup(env, e.ident.name) orelse return core;
            const t = b.ty orelse return core;
            if (b.mutable or tyEql(t, want) or !tyLooser(t, want)) return core;
            return self.mk(.{ .ann = .{ .e = core, .t = want } });
        }
        // 名前でない式（`return p[0:k]`・`return s.a` 等 — 仮引数由来の imm を含む）: 式の型（computeTy）が結果型より締まっているときだけ
        // 結果型へ ann で緩める（selfhost-drafts F-14 (1)）。computeTy が region を実体とずらしても、ann は Lean の Ty.sub が検査するので
        // 健全性は変わらない（ずれていれば拒否されるだけ）。型が一致・不明・形が違うときは従来どおり ann を付けない
        // Def の本体の return だけ（展開の中の return は値が呼び手の式へ流れる — 展開点の座標へ緩めると、その先のブロック脱出が要る
        // 浅い region の精度を失う。例: strings.Keep の結果を Arena の region のまま外へ運ぶ pool_string。Def の return は緩めた先 = 結果型が
        // そのまま行き先なので失うものが無い）
        if (self.inlining.items.len > 0) return core;
        const t = self.retExprTy(e, env) orelse return core;
        if (!hasRegion(want) or tyEql(t, want) or !tyLooser(t, want)) return core;
        return self.mk(.{ .ann = .{ .e = core, .t = want } });
    }

    /// return の値の式の型（retValue の判定用）: if 式は、両腕が単一式で型が一致すればその型（`return if c { p } else { p[0:k] }`）。
    /// 他は computeTy
    fn retExprTy(self: *Desugarer, e: *const ast.Expr, env: Env) ?*const Ty {
        if (e.* == .if_) {
            const i = e.if_;
            const els = i.else_ orelse return self.computeTy(e, env);
            if (i.then.stmts.len != 1 or i.then.stmts[0] != .expr) return self.computeTy(e, env);
            const t1 = self.retExprTy(i.then.stmts[0].expr, env) orelse return null;
            const t2 = switch (els.*) {
                .block => |b| if (b.stmts.len == 1 and b.stmts[0] == .expr) self.retExprTy(b.stmts[0].expr, env) else null,
                .if_ => self.retExprTy(els, env),
                else => null,
            } orelse return null;
            return if (tyEql(t1, t2)) t1 else null;
        }
        return self.computeTy(e, env);
    }

    /// append の値引数（mut slice の subject — 名前の mut 束縛）: 値の型（computeTy）が subject の要素型より締まっている
    /// （仮引数由来の imm — region が浅い）ときだけ、要素型へ ann で緩める（selfhost-drafts F-14 (2)）。mut 束縛のセル型は
    /// 束縛点の点座標（V3-5 — mutInitAnn・mutParamArg と同じ不変条件）なので、要素型は subject の型の要素を束縛点で点座標に写したもの。
    /// 緩める向きの浅い共変だけで、ann は Lean の Ty.sub が検査する（座標の読みがずれていれば拒否されるだけ — 健全性は変わらない）
    fn appendValueAnn(self: *Desugarer, subject: *const ast.Expr, value: *const ast.Expr, core: *const CExpr, env: Env) Error!*const CExpr {
        if (subject.* != .ident) return core;
        const b = lookup(env, subject.ident.name) orelse return core;
        if (!b.mutable) return core;
        const st = b.ty orelse return core;
        if (st.* != .slice or !st.slice.m) return core;
        const vt = self.computeTy(value, env) orelse return core;
        const saved = self.rdepth;
        defer self.rdepth = saved;
        self.rdepth = b.region + 1;
        const et = try self.pointTy(st.slice.t);
        if (!hasRegion(et) or tyEql(vt, et) or !tyLooser(vt, et)) return core;
        return self.mk(.{ .ann = .{ .e = core, .t = et } });
    }

    /// mut 束縛の struct のフィールドへの代入の値（`s.a = p` — フィールドパスの根が名前の mut 束縛）: 値の型（computeTy）が
    /// フィールドの宣言型を束縛点の点座標に写した型より締まっている（仮引数由来の imm — region が浅い）ときだけ、その型へ ann で緩める
    /// （selfhost-drafts F-14 (3)）。mut 束縛のセル型は束縛点の点座標（V3-5）なので、再構築した struct のそのフィールドの位置の型がこれになる。
    /// appendValueAnn と同じ規律: 行き先の型が確定している所だけ・緩める向きの浅い共変だけ（ann は Lean の Ty.sub が検査する）
    fn fieldValueAnn(self: *Desugarer, target: *const ast.Expr, value: *const ast.Expr, core: *const CExpr, env: Env) Error!*const CExpr {
        var root = target;
        while (root.* == .selector) root = root.selector.base;
        if (root.* != .ident) return core;
        const b = lookup(env, root.ident.name) orelse return core;
        if (!b.mutable) return core;
        const w = self.targetTy(target, env) orelse return core;
        const vt = self.computeTy(value, env) orelse return core;
        const saved = self.rdepth;
        defer self.rdepth = saved;
        self.rdepth = b.region + 1;
        const et = try self.pointTy(w);
        if (!hasRegion(et) or tyEql(vt, et) or !tyLooser(vt, et)) return core;
        return self.mk(.{ .ann = .{ .e = core, .t = et } });
    }

    /// `mut x := y`（y は名前）の初期値を束縛点の点座標へ ann で緩める: mut のセル型は初期値の型そのものになるので、
    /// y が仮引数（region 0）等の型を持つとセル型が点座標とずれ、mut 引数の ann（束縛点の点座標で正確一致 — V3-5）に
    /// 合わなくなる（例: `mut d := c` の写しを `Next(mut d)` に渡す）。緩める向きの浅い共変なので健全、名前だけ
    /// （宣言由来の Binding.ty — retValue と同じ理由で式一般の computeTy は見ない）
    fn mutInitAnn(self: *Desugarer, value: *const ast.Expr, core: *const CExpr, env: Env) Error!*const CExpr {
        if (value.* != .ident) return core;
        const b = lookup(env, value.ident.name) orelse return core;
        const t = b.ty orelse return core;
        if (!hasRegion(t) and !wrapsContainer(t)) return core;
        const pt = try self.pointTy(t);
        if (tyEql(t, pt) or !tyLooser(t, pt)) return core;
        return self.mk(.{ .ann = .{ .e = core, .t = pt } });
    }

    fn coerceExpr(self: *Desugarer, e: *const ast.Expr, want: *const Ty, env: Env, depth: u32, tok: u32) Error!*const CExpr {
        // 関数値が期待される位置のラムダは匿名 Def へ持ち上げる（V3-3 A1）
        if (e.* == .lambda and want.* == .fn_) return self.liftLambda(&e.lambda, want, env, tok);
        if (want.* != .opt) return self.expr(e, env, depth);
        const payload = want.opt;
        if (e.* == .nil) return self.mk(.{ .nil = payload });
        // if 式は腕ごとに期待型を押し込む（腕が nil を書ける）。nil テストの if は ifnil 側へ
        if (e.* == .if_ and e.if_.else_ != null and self.nilTest(e.if_.cond, env) == null) {
            const i = e.if_;
            const cond = try self.expr(i.cond, env, depth);
            const then = try self.coerceArm(i.then.stmts, want, env, depth, tok);
            const els = i.else_.?;
            const other = if (els.* == .block)
                try self.coerceArm(els.block.stmts, want, env, depth, tok)
            else
                try self.coerceExpr(els, want, env, depth, tok);
            return self.mk(.{ .ite = .{ .c = cond, .t = then, .e = other } });
        }
        const t = self.computeTy(e, env);
        const core = try self.expr(e, env, depth);
        if (t) |tt| {
            // 一致に加え、region の上界だけが緩む形（R0: 戻り値の値ラッパの中は r1 — ann が緩める）でも判定する
            if (tyEql(tt, want) or tyLooser(tt, want)) return core;
            if (tyEql(tt, payload) or tyLooser(tt, payload)) return self.mk(.{ .some = core });
            // 包むかどうかは形で決まる（region は検査が裁く — R4b: error の鎖のセル型は座標が位置でずれる）
            if (tyEqlLoose(tt, want)) return core;
            if (tyEqlLoose(tt, payload)) return self.mk(.{ .some = core });
            return core; // 型が合わない — 検査（Lean）に裁かせる
        }
        return self.fail(error.CoreFragment, tok, "cannot decide whether to wrap in some (type is not statically known)");
    }

    /// if 式の腕（文列）へ期待型を押し込む。単一式の腕だけ（それ以外は型の静的計算に任せる）
    fn coerceArm(self: *Desugarer, list: []const ast.Stmt, want: *const Ty, env: Env, depth: u32, tok: u32) Error!*const CExpr {
        if (list.len == 1 and list[0] == .expr)
            return self.coerceExpr(list[0].expr, want, env, depth, tok);
        const t = if (list.len > 0 and list[list.len - 1] == .expr)
            self.computeTy(list[list.len - 1].expr, env)
        else
            null;
        // 脱出で終わる腕（V4-4d）: 末尾の jump の注釈が期待型そのもの — 包む必要は無い
        const ends_exit = list.len > 0 and switch (list[list.len - 1]) {
            .ret, .break_, .continue_ => true,
            else => false,
        };
        const core = try self.scoped(list, env, depth, .{ .want = if (ends_exit) want else null });
        if (ends_exit) return core;
        if (t) |tt| {
            if (tyEql(tt, want) or tyLooser(tt, want)) return core;
            if (tyEql(tt, want.opt) or tyLooser(tt, want.opt)) return self.mk(.{ .some = core });
            if (tyEqlLoose(tt, want)) return core;
            if (tyEqlLoose(tt, want.opt)) return self.mk(.{ .some = core });
        }
        return self.fail(error.CoreFragment, tok, "cannot decide whether to wrap in some (type is not statically known)");
    }

    const NilTest = struct { name: []const u8, some_in_then: bool };

    /// 条件が `x != nil` / `x == nil`（x は束縛された名前）なら flow typing の情報を返す
    fn nilTest(self: *Desugarer, cond: *const ast.Expr, env: Env) ?NilTest {
        _ = self;
        if (cond.* != .binary) return null;
        const b = cond.binary;
        if (b.op != .equal_equal and b.op != .bang_equal) return null;
        const side = if (b.lhs.* == .nil) b.rhs else if (b.rhs.* == .nil) b.lhs else return null;
        if (side.* != .ident) return null;
        if (lookup(env, side.ident.name) == null) return null;
        return .{ .name = side.ident.name, .some_in_then = b.op == .bang_equal };
    }

    /// `if x != nil { A } else { B }` → `ifnil x B A'`（A' では x が var 0 = ペイロードに再束縛）
    fn ifnilExpr(self: *Desugarer, nt: NilTest, i: ast.If, env: Env, depth: u32, want: ?*const Ty, stmt: bool) Error!*const CExpr {
        const b = lookup(env, nt.name).?;
        var subject = try self.mk(.{ .var_ = depth - 1 - b.level });
        if (b.mutable) subject = try self.mk(.{ .deref = subject });
        const payload_ty: ?*const Ty = if (b.ty) |t| (if (t.* == .opt) t.opt else null) else null;
        const env2 = try self.bind(env, .{
            .name = nt.name,
            .level = depth,
            .mutable = false,
            .decl = b.decl,
            .ty = payload_ty,
        });
        // 値のある腕（some）は env2 / depth+1、nil 腕は env / depth のまま
        const then_discard = stmt or i.else_ == null;
        const then_body = if (nt.some_in_then)
            try self.scoped(i.then.stmts, env2, depth + 1, .{ .discard = then_discard, .want = want })
        else
            try self.scoped(i.then.stmts, env, depth, .{ .discard = then_discard, .want = want });
        var else_body: *const CExpr = undefined;
        if (i.else_) |els| {
            if (nt.some_in_then) {
                else_body = if (els.* == .block)
                    try self.scoped(els.block.stmts, env, depth, .{ .want = want, .discard = stmt })
                else blk: {
                    self.tail_want = want;
                    self.stmt_if = stmt and els.* == .if_;
                    break :blk try self.expr(els, env, depth);
                };
            } else {
                else_body = if (els.* == .block)
                    try self.scoped(els.block.stmts, env2, depth + 1, .{ .want = want, .discard = stmt })
                else blk: {
                    self.tail_want = want;
                    self.stmt_if = stmt and els.* == .if_;
                    break :blk try self.expr(els, env2, depth + 1);
                };
            }
        } else {
            else_body = try self.mk(.triv);
        }
        if (nt.some_in_then)
            return self.mk(.{ .ifnil = .{ .e = subject, .nil_case = else_body, .some_case = then_body } });
        return self.mk(.{ .ifnil = .{ .e = subject, .nil_case = then_body, .some_case = else_body } });
    }

    fn composite(self: *Desugarer, c: ast.Composite, env: Env, depth: u32) Error!*const CExpr {
        // struct リテラル → pair 鎖
        if (self.lookupType(self.cur_pkg, c.type_name)) |td| {
            if (td.decl.body == .struct_) {
                // ジェネリック struct（V3-3）: フィールドの期待型をインスタンスの型引数で読む
                const tenv = if (c.type_args.len > 0) try self.genericEnv(self.cur_pkg, td, c.type_args, c.tok) else if (td.decl.type_params.len > 0)
                    return self.fail(error.Malformed, c.tok, "a generic struct literal needs type arguments")
                else
                    &[_]TBind{};
                const values = try self.fieldValuesIn(td.pkg, tenv, td.decl.body.struct_, c.elems, c.tok, env, depth);
                return self.pairChain(values);
            }
        }
        // union variant → inl / inr の鎖（右結合の union の入れ子に沿って）
        const found = self.findVariant(self.cur_pkg, c.type_name) orelse
            return self.fail(error.CoreFragment, c.tok, "composite literal without a declaration is outside the core fragment");
        if (found.decl == self.prog.errors) {
            // error ラベルの値（R4b K1''）= 先頭 + 空の鎖。cause は自動（書けない）
            for (c.elems) |el| {
                if (el.key) |n| if (std.mem.eql(u8, n, "cause"))
                    return self.fail(error.Malformed, c.tok, "cause is filled by the wrap `f()? L{...}` and cannot be written in a label literal");
            }
            const top = try self.labelL(c, found, env, depth);
            return self.mk(.{ .pair = .{ .a = top, .b = try self.emptyChain(c.tok) } });
        }
        return self.labelL(c, found, env, depth);
    }

    /// union variant / error ラベルのリテラル → inl / inr の鎖（error ラベルなら閉じた union L の値 — 鎖は付けない）
    fn labelL(self: *Desugarer, c: ast.Composite, found: anytype, env: Env, depth: u32) Error!*const CExpr {
        const variants = found.decl.body.union_;
        const v = variants[found.index];
        const values = try self.fieldValues(found.pkg, v.fields, c.elems, c.tok, env, depth);
        const payload = try self.pairChain(values);
        return self.encodeVariant(found.pkg, variants, found.index, payload, c.tok);
    }

    /// variant idx のペイロードを右結合の union の入れ子へ包む
    fn encodeVariant(self: *Desugarer, pkg: *const ast.Pkg, variants: []const ast.Variant, idx: usize, payload: *const CExpr, tok: u32) Error!*const CExpr {
        if (variants.len == 1 and self.isErrors(variants)) return payload;
        if (variants.len < 2)
            return self.fail(error.CoreFragment, tok, "unions need at least 2 variants in the core fragment");
        if (idx == 0) {
            const r = if (variants.len == 2)
                try self.payloadTy(pkg, variants[1], tok, 32)
            else
                try self.unionTreeTy(pkg, variants[1..], tok, 32);
            return self.mk(.{ .inl = .{ .r = r, .e = payload } });
        }
        const l = try self.payloadTy(pkg, variants[0], tok, 32);
        const inner = if (variants.len == 2)
            payload
        else
            try self.encodeVariant(pkg, variants[1..], idx - 1, payload, tok);
        return self.mk(.{ .inr = .{ .l = l, .e = inner } });
    }

    const SwitchArm = struct { tp: ?ast.TypePattern, body: *const ast.Block };

    fn switchExpr(self: *Desugarer, sw: ast.Switch, env: Env, depth: u32, want: ?*const Ty) Error!*const CExpr {
        // 腕の末尾の jump（V4）の注釈: 期待型が来ていなければ腕の型から
        const saved_sw = self.sw_want;
        defer self.sw_want = saved_sw;
        self.sw_want = want orelse self.switchTy(sw, env);
        // 型パターンが 1 つでもあれば union の switch、無ければ定数 / 条件の switch
        for (sw.cases) |case| {
            for (case.patterns) |p| {
                if (p == .type_) return self.unionSwitch(sw, env, depth);
            }
        }
        return self.constSwitch(sw, env, depth);
    }

    /// 定数パターン / subject 無し（bool 条件）/ 複数 subject の switch を eq + ite に脱糖する。
    /// codegen と同じ意味論: subject は宣言順に 1 回ずつ評価、case は上から、
    /// 選択肢（`1 | 2`）は左から短絡、`_` は常に一致、裸の未知の識別子は値の束縛（syntax.md 9 節）。
    /// default 無しでどの case も外れたら unit（値として使うと腕の型が割れて検査で落ちる）。
    /// 多値呼び出しを単一 subject に置く形（`switch g() { case 1, 2: … }`）は、名前付き関数の結果型から
    /// アリティを引き、呼び出しを 1 回だけ letE で評価して各成分を射影で subject に並べる
    /// （分解 bind `x, y := g()` と同じ形 — codegen の evalMulti + spill と同じ評価順）
    fn constSwitch(self: *Desugarer, sw: ast.Switch, env: Env, depth: u32) Error!*const CExpr {
        var n: u32 = @intCast(sw.subjects.len);
        // sb = 最初の subject の束縛レベル。多値 subject では組の匿名束縛が depth に入るので 1 つ深い
        var sb: u32 = depth;
        var tuple: ?*const CExpr = null;
        var subjects: std.ArrayListUnmanaged(*const CExpr) = .empty;
        var subj_bool: std.ArrayListUnmanaged(bool) = .empty;
        if (n == 1) {
            if (try self.multiResults(sw.subjects[0], env)) |fe| {
                const k: u32 = @intCast(fe.decl.results.len);
                tuple = try self.expr(sw.subjects[0], env, depth);
                sb = depth + 1;
                for (0..k) |i| {
                    try subjects.append(self.a, try self.projection(try self.mk(.{ .var_ = @intCast(i) }), i, k));
                    const rt = self.tyOf(fe.pkg, fe.decl.results[i], sw.tok, 32) catch null;
                    try subj_bool.append(self.a, self.isBoolTy(rt));
                }
                n = k;
            }
        }
        if (tuple == null) {
            for (sw.subjects, 0..) |s, i| {
                try subjects.append(self.a, try self.expr(s, env, depth + @as(u32, @intCast(i))));
            }
            for (sw.subjects) |s| try subj_bool.append(self.a, self.isBoolTy(self.computeTy(s, env)));
        }
        const d2 = sb + n;
        var acc: *const CExpr = if (sw.default_) |blk|
            try self.scoped(blk.stmts, env, d2, .{ .want = self.sw_want })
        else
            try self.mk(.triv);
        var ci = sw.cases.len;
        while (ci > 0) {
            ci -= 1;
            const c = sw.cases[ci];
            if (c.patterns.len != @max(n, 1)) {
                return self.fail(error.CoreFragment, c.tok, if (n <= 1)
                    "a multi-value subject needs a named function call (its arity comes from the result types)"
                else
                    "pattern count differs from the switch subject");
            }
            var env2 = env;
            var cond: ?*const CExpr = null;
            for (c.patterns, 0..) |p, i| {
                const alts = p.const_; // 型パターン混在は unionSwitch 側で弾かれる
                if (hasWildcard(alts)) continue;
                if (n > 0 and alts.len == 1 and alts[0].* == .ident and self.isBindingPattern(env, alts[0].ident.name)) {
                    env2 = try self.bind(env2, .{
                        .name = alts[0].ident.name,
                        .level = sb + @as(u32, @intCast(i)),
                        .mutable = false,
                    });
                    continue;
                }
                // 選択肢の or 連鎖（ite 脱糖 = 短絡）。subject 有りは eq、無しは条件式そのもの
                var pcond: ?*const CExpr = null;
                for (alts) |alt| {
                    const one = if (n > 0) blk: {
                        const subj = try self.mk(.{ .var_ = d2 - 1 - (sb + @as(u32, @intCast(i))) });
                        const pv = try self.expr(alt, env, d2);
                        if (subj_bool.items[i]) break :blk try self.boolEq(subj, pv, true);
                        break :blk try self.mk(.{ .bin = .{ .kind = "eq", .a = subj, .b = pv } });
                    } else try self.expr(alt, env, d2);
                    pcond = if (pcond) |pc|
                        try self.mk(.{ .ite = .{ .c = pc, .t = try self.mk(.tt), .e = one } })
                    else
                        one;
                }
                if (pcond) |pc| {
                    cond = if (cond) |cc|
                        try self.mk(.{ .ite = .{ .c = cc, .t = pc, .e = try self.mk(.ff) } })
                    else
                        pc;
                }
            }
            const body = try self.scoped(c.body.stmts, env2, d2, .{ .want = self.sw_want });
            acc = if (cond) |cc| try self.mk(.{ .ite = .{ .c = cc, .t = body, .e = acc } }) else body;
        }
        var i = subjects.items.len;
        while (i > 0) {
            i -= 1;
            acc = try self.mk(.{ .let = .{ .e = subjects.items[i], .body = acc } });
        }
        if (tuple) |t| return self.mk(.{ .let = .{ .e = t, .body = acc } });
        return acc;
    }

    /// パターン位置の裸の識別子が束縛か（syntax.md 9 節「未知なら束縛」）。既知 = ローカル・
    /// 事前宣言の true / false・現 package のトップレベル名（ast.Pkg.hasTopName）。codegen の isBindingPattern と同じ規則
    fn isBindingPattern(self: *Desugarer, env: Env, name: []const u8) bool {
        return lookup(env, name) == null and !isBoolName(name) and !self.cur_pkg.hasTopName(name);
    }

    /// subject が結果 2 個以上の名前付き関数の呼び出し（`g(...)` / `x |> g(...)`）なら その関数
    fn multiResults(self: *Desugarer, subj: *const ast.Expr, env: Env) Error!?FnEntry {
        const callee: *const ast.Expr = switch (subj.*) {
            .call => |c| c.callee,
            .pipe => |p| p.callee,
            else => return null,
        };
        const fe = (try self.findFn(callee, env)) orelse return null;
        if (fe.decl.results.len < 2) return null;
        return fe;
    }

    fn hasWildcard(alts: []const *ast.Expr) bool {
        for (alts) |alt| {
            if (alt.* == .ident and std.mem.eql(u8, alt.ident.name, "_")) return true;
        }
        return false;
    }

    fn unionSwitch(self: *Desugarer, sw: ast.Switch, env: Env, depth: u32) Error!*const CExpr {
        if (sw.subjects.len != 1)
            return self.fail(error.CoreFragment, sw.tok, "switch without a single subject is outside the core fragment");
        var decl: ?DeclRef = null;
        var arms: std.ArrayListUnmanaged(?SwitchArm) = .empty;
        // `case _:` は default と同じ（codegen と同じ線 — V5-7）
        var wild: ?*ast.Block = sw.default_;
        for (sw.cases) |case| {
            if (case.patterns.len != 1) return self.fail(error.Malformed, case.tok, "pattern count");
            const tp = switch (case.patterns[0]) {
                .type_ => |tp| tp,
                .const_ => |alts| {
                    if (hasWildcard(alts) and wild == null) {
                        wild = case.body;
                        continue;
                    }
                    return self.fail(error.Malformed, case.tok, "constant pattern mixed with type patterns");
                },
            };
            if (tp.bind != null)
                return self.fail(error.CoreFragment, tp.tok, "binding the whole value is outside the core fragment");
            const found = self.findVariant(self.cur_pkg, tp.variant) orelse
                return self.fail(error.UnknownName, tp.tok, "unknown variant");
            if (decl) |d2| {
                if (d2.decl != found.decl) return self.fail(error.Malformed, tp.tok, "variants from different unions");
            } else {
                decl = .{ .decl = found.decl, .pkg = found.pkg };
                try arms.appendNTimes(self.a, null, found.decl.body.union_.len);
            }
            if (arms.items[found.index] != null) return self.fail(error.Malformed, tp.tok, "duplicate variant case");
            arms.items[found.index] = .{ .tp = tp, .body = case.body };
        }
        const d2 = decl orelse return self.fail(error.Malformed, sw.tok, "switch with no type-pattern case");
        if (wild) |blk| {
            for (arms.items) |*slot| {
                if (slot.* == null) slot.* = .{ .tp = null, .body = blk };
            }
        }
        for (arms.items) |slot| {
            if (slot == null) return self.fail(error.Malformed, sw.tok, "switch does not cover every variant");
        }
        const subject = try self.expr(sw.subjects[0], env, depth);
        if (d2.decl == self.prog.errors) {
            // error（R4b K1''）: subject（先頭 + 鎖）を束縛し、先頭で分岐する。鎖は腕の `cause` が読む
            const saved = self.err_switch;
            defer self.err_switch = saved;
            self.err_switch = .{ .level = depth, .ty = self.computeTy(sw.subjects[0], env) };
            const top = try self.mk(.{ .fst = try self.mk(.{ .var_ = 0 }) });
            const tree = try self.caseTree(top, d2.pkg, d2.decl.body.union_, arms.items, env, depth + 1);
            return self.mk(.{ .let = .{ .e = subject, .body = tree } });
        }
        return self.caseTree(subject, d2.pkg, d2.decl.body.union_, arms.items, env, depth);
    }

    /// 右結合の union の入れ子に沿った case の入れ子。
    /// 各段の右腕は残りの variant を var 0 で再分解する（束縛が 1 つずつ深くなる）
    fn caseTree(self: *Desugarer, subject: *const CExpr, pkg: *const ast.Pkg, variants: []const ast.Variant, arms: []const ?SwitchArm, env: Env, depth: u32) Error!*const CExpr {
        // ラベル 1 個の error（V4-4a）: 値がそのままペイロード — 腕の束縛（var 0）に let で置く
        if (variants.len == 1)
            return self.mk(.{ .let = .{ .e = subject, .body = try self.caseArm(arms[0].?, pkg, variants[0], env, depth) } });
        const l = try self.caseArm(arms[0].?, pkg, variants[0], env, depth);
        const r = if (variants.len == 2)
            try self.caseArm(arms[1].?, pkg, variants[1], env, depth)
        else
            try self.caseTree(try self.mk(.{ .var_ = 0 }), pkg, variants[1..], arms[1..], env, depth + 1);
        return self.mk(.{ .case = .{ .e = subject, .l = l, .r = r } });
    }

    /// case の腕: ペイロード（フィールドの pair 鎖）が var 0。
    /// パターンで名前の付いたフィールドを letE の射影で束縛してから本体を脱糖する
    fn caseArm(self: *Desugarer, arm: SwitchArm, union_pkg: *const ast.Pkg, v: ast.Variant, env: Env, depth: u32) Error!*const CExpr {
        const pkg = v.pkg orelse union_pkg;
        // 腕に入った時点でペイロードの束縛が 1 つ（var 0 = depth）
        var env2 = env;
        var d = depth + 1;
        var extracts: std.ArrayListUnmanaged(*const CExpr) = .empty;
        if (arm.tp) |tp| {
            for (tp.fields) |fp| {
                if (fp.sub != null)
                    return self.fail(error.CoreFragment, fp.tok, "field sub-patterns are outside the core fragment");
                const idx = for (v.fields, 0..) |f, i| {
                    if (std.mem.eql(u8, f.name, fp.name)) break i;
                } else {
                    // error ラベルの自動フィールド cause（R4b K1''）: 鎖が空なら nil、でなければ (鎖の末尾, 鎖の残り)
                    if (std.mem.eql(u8, fp.name, "cause")) if (self.err_switch) |es| {
                        const et = es.ty orelse
                            return self.fail(error.CoreFragment, fp.tok, "cause needs the switched error's type to be statically known (bind the error to a name first)");
                        const chain = try self.mk(.{ .snd = try self.mk(.{ .var_ = d - 1 - es.level }) });
                        const n = try self.mk(.{ .lenE = chain });
                        const last = try self.mk(.{ .bin = .{ .kind = "sub", .a = n, .b = try self.mk(.{ .lit = 1 }) } });
                        const cause = try self.mk(.{ .pair = .{
                            .a = try self.mk(.{ .index = .{ .e = chain, .i = last, .t = if (et.* == .prod) et.prod.l else null } }),
                            .b = try self.mk(.{ .subslice = .{ .e = chain, .a = try self.mk(.{ .lit = 0 }), .b = last } }),
                        } });
                        const empty = try self.mk(.{ .bin = .{ .kind = "eq", .a = n, .b = try self.mk(.{ .lit = 0 }) } });
                        const value = try self.mk(.{ .ite = .{ .c = empty, .t = try self.mk(.{ .nil = et }), .e = try self.mk(.{ .some = cause }) } });
                        try extracts.append(self.a, value);
                        env2 = try self.bind(env2, .{
                            .name = fp.name,
                            .level = d,
                            .mutable = false,
                            .ty = try self.mkTy(.{ .opt = et }),
                        });
                        d += 1;
                        continue;
                    };
                    return self.fail(error.Malformed, fp.tok, "unknown field in pattern");
                };
                if (v.fields.len == 1) {
                    // 射影が恒等なので case の束縛（var 0）にそのまま名前を付ける
                    env2 = try self.bind(env2, .{
                        .name = fp.name,
                        .level = depth,
                        .mutable = false,
                        .decl = self.declOfTypeExpr(pkg, v.fields[idx].type),
                        .ty = self.patFieldTy(pkg, v.fields[idx].type, fp.tok),
                    });
                    continue;
                }
                // payload は腕の先頭の束縛。抽出のたびに 1 つ沈む
                const payload_index = d - (depth + 1);
                const payload = try self.mk(.{ .var_ = payload_index });
                const value = try self.projection(payload, idx, v.fields.len);
                try extracts.append(self.a, value);
                env2 = try self.bind(env2, .{
                    .name = fp.name,
                    .level = d,
                    .mutable = false,
                    .decl = self.declOfTypeExpr(pkg, v.fields[idx].type),
                    .ty = self.patFieldTy(pkg, v.fields[idx].type, fp.tok),
                });
                d += 1;
            }
        }
        var body = try self.scoped(arm.body.stmts, env2, d, .{ .want = self.sw_want });
        var i = extracts.items.len;
        while (i > 0) {
            i -= 1;
            body = try self.mk(.{ .let = .{ .e = extracts.items[i], .body = body } });
        }
        return body;
    }

    /// 素の Def として call で呼ばれる関数（展開されない・anchor つき callM でない）
    fn plainDef(f: *const ast.FuncDecl) bool {
        if (f.expands or f.mut_def) return false;
        for (f.params) |p| if (p.mutable) return false;
        return true;
    }

    /// call 結果の imm slice / map を呼び手座標で読む: 戻り値は呼び手の最内 region へ中身ごと境界コピーされる
    /// （Lean の call 結果型 ret.relocR d と同じ上界 — R4a で中身も締まる）。値ラッパ（opt / union / prod）の中へは分配する
    /// （R0）。region を持たない部分はそのまま。mut を含むものは null
    fn callResultTop(self: *Desugarer, rt: *const Ty) ?*const Ty {
        if (tyArgOk(rt)) return rt;
        const r = self.rdepth - 1;
        return switch (rt.*) {
            // R4a: 中身も深く締まる（Lean の relocR が imm コンテナの中身まで呼び手最内へ）
            .slice => |x| blk: {
                if (x.m) break :blk null;
                const t2 = self.callResultTop(x.t) orelse break :blk null;
                break :blk self.mkTy(.{ .slice = .{ .m = false, .r = r, .t = t2, .str = x.str } }) catch null;
            },
            .map => |x| blk: {
                if (x.m) break :blk null;
                const k2 = self.callResultTop(x.k) orelse break :blk null;
                const t2 = self.callResultTop(x.t) orelse break :blk null;
                break :blk self.mkTy(.{ .map = .{ .m = false, .r = r, .k = k2, .t = t2 } }) catch null;
            },
            .opt => |t| blk: {
                const t2 = self.callResultTop(t) orelse break :blk null;
                break :blk self.mkTy(.{ .opt = t2 }) catch null;
            },
            .union_ => |u| blk: {
                const l = self.callResultTop(u.l) orelse break :blk null;
                const rr = self.callResultTop(u.r) orelse break :blk null;
                break :blk self.mkTy(.{ .union_ = .{ .l = l, .r = rr } }) catch null;
            },
            .prod => |pr| blk: {
                const l = self.callResultTop(pr.l) orelse break :blk null;
                const rr = self.callResultTop(pr.r) orelse break :blk null;
                break :blk self.mkTy(.{ .prod = .{ .l = l, .r = rr } }) catch null;
            },
            else => null,
        };
    }

    /// パターンで束縛したフィールドの型（補間・T? の sink の判定用）。region を持たない型はそのまま、
    /// 最上段の imm slice / map（string 等 — R0 で error ラベルに解禁）は現在の最内 region を上界にする
    /// （生きている imm 値の上界として常に正しい。注釈に使われても緩める向きなので誤拒否にしかならない）
    fn patFieldTy(self: *Desugarer, pkg: *const ast.Pkg, te: ast.TypeExpr, tok: u32) ?*const Ty {
        const t = self.tyOf(pkg, te, tok, 32) catch return null;
        return self.callResultTop(t);
    }

    // ── 呼び出し（inline 展開・ラムダ展開）──────────────────────────────

    /// callee 式（名前か `pkg.Fn`）を関数表 / inline 関数の候補に解決する。
    /// 見つからなければ null（呼び手がエラーにする）。ローカルの closure はここでは見ない
    fn findFn(self: *Desugarer, callee: *const ast.Expr, env: Env) Error!?FnEntry {
        var name: []const u8 = undefined;
        switch (callee.*) {
            .ident => |id| name = id.name,
            .selector => |sel| {
                if (sel.base.* != .ident or lookup(env, sel.base.ident.name) != null or
                    self.cur_pkg.imports.get(sel.base.ident.name) == null) return null;
                name = try self.dotted(sel.base.ident.name, sel.field);
            },
            else => return null,
        }
        const r = self.resolveIn(self.cur_pkg, name) orelse return null;
        for (r.pkg.files) |file| {
            for (file.funcs) |f| {
                if (std.mem.eql(u8, f.name, r.base)) return .{ .decl = f, .pkg = r.pkg };
            }
        }
        return null;
    }

    /// 閉じたラムダ → 匿名 Def（関数表の末尾）+ fnref。引数の型は期待される関数型 ft から、
    /// 本体は引数だけの環境で脱糖する（外側の束縛を参照したら捕捉として拒否）。
    /// ジェネリック Def の中なら型パラメータを引き継ぎ、fnref に同じ tvar を型引数として渡す
    fn liftLambda(self: *Desugarer, lam: *const ast.Lambda, ft: *const Ty, outer: Env, tok: u32) Error!*const CExpr {
        // Def 本体は base 2（最内 = 自フレーム region 1）
        const saved_rdepth = self.rdepth;
        self.rdepth = 2;
        defer self.rdepth = saved_rdepth;
        // 辞書 const のラムダは単相・文脈固定なので、参照点が何箇所でも Def は 1 本
        if (self.in_dict_const) {
            if (self.dict_lifts.get(lam)) |idx| return self.mk(.{ .fnref = .{ .fn_ = idx } });
        }
        const n = lam.params.len;
        // 期待型のパラメータ列（pair 鎖）を剥がす
        const ptys = try self.a.alloc(*const Ty, n);
        var p = ft.fn_.p;
        for (0..n) |i| {
            if (i + 1 == n) {
                ptys[i] = p;
            } else switch (p.*) {
                .prod => |pr| {
                    ptys[i] = pr.l;
                    p = pr.r;
                },
                else => return self.fail(error.Malformed, tok, "lambda parameter count differs from the function type"),
            }
        }
        if (n == 0 and ft.fn_.p.* != .unit) return self.fail(error.Malformed, tok, "lambda parameter count differs from the function type");
        // 引数の型宣言（struct の射影用）: 関数型フィールドの宣言から
        const pdecls = try self.a.alloc(?DeclRef, n);
        @memset(pdecls, null);
        const pelems = try self.a.alloc(?DeclRef, n);
        @memset(pelems, null);
        if (self.lift_hint) |h| {
            self.lift_hint = null;
            if (h.ft.params.len == n) {
                const saved = self.tenv;
                defer self.tenv = saved;
                self.tenv = h.env;
                for (h.ft.params, pdecls, pelems) |te, *pd, *pe| {
                    pd.* = self.declOfTypeExpr(h.pkg, te);
                    pe.* = self.elemDeclOfTypeExpr(h.pkg, te);
                }
            }
        }
        var env = Env.empty;
        var d: u32 = 1;
        var extracts: std.ArrayListUnmanaged(*const CExpr) = .empty;
        if (n == 1) {
            env = try self.bind(env, .{ .name = lam.params[0].name, .level = 0, .mutable = false, .ty = ptys[0], .decl = pdecls[0], .elem_decl = pelems[0] });
        } else if (n >= 2) {
            for (lam.params, 0..) |lp, i| {
                const tuple = try self.mk(.{ .var_ = d - 1 });
                try extracts.append(self.a, try self.projection(tuple, i, n));
                env = try self.bind(env, .{ .name = lp.name, .level = d, .mutable = false, .ty = ptys[i], .decl = pdecls[i], .elem_decl = pelems[i] });
                d += 1;
            }
        }
        const saved_outer = self.lift_outer;
        defer self.lift_outer = saved_outer;
        self.lift_outer = outer;
        // 持ち上げたラムダは独立の Def: return（外側の関数から抜ける）は断片外、外側のループへも抜けない
        const saved_ctl = self.saveCtl();
        defer self.restoreCtl(saved_ctl);
        self.ret_target = null;
        self.loop_floor = self.labels.items.len;
        var body = if (lam.body.* == .block)
            try self.scoped(lam.body.block.stmts, env, d, .{})
        else
            try self.coerceExpr(lam.body, ft.fn_.r, env, d, tok);
        var i = extracts.items.len;
        while (i > 0) {
            i -= 1;
            body = try self.mk(.{ .let = .{ .e = extracts.items[i], .body = body } });
        }
        const idx: u32 = @intCast(self.fns.len + self.lifted.items.len);
        try self.lifted.append(self.a, .{ .param = ft.fn_.p, .ret = ft.fn_.r, .body = body, .tparams = self.cur_tparams });
        if (self.in_dict_const and self.dict_const != null) {
            const c = self.dict_const.?;
            try self.lifted_names.append(self.a, try std.fmt.allocPrint(self.a, "{s}.{s}#{d}", .{ self.dict_pkg, c.name, lambdaOrdinal(c.expr, lam) }));
            try self.lifted_owners.append(self.a, self.dict_pkg);
        } else {
            try self.lifted_names.append(self.a, try std.fmt.allocPrint(self.a, "{s}/lam{d}", .{ self.owner, self.owner_lifts }));
            try self.lifted_owners.append(self.a, self.owner_pkg);
            self.owner_lifts += 1;
        }
        if (self.in_dict_const) try self.dict_lifts.put(self.a, lam, idx);
        const ts = try self.a.alloc(*const Ty, self.cur_tparams);
        for (ts, 0..) |*t, k| t.* = try self.mkTy(.{ .tvar = @intCast(k) });
        return self.mk(.{ .fnref = .{ .fn_ = idx, .ts = ts } });
    }

    /// 名前付き関数 → fnref（関数表の index）。展開される関数（関数型引数を持つ）は値にならない
    fn fnRef(self: *Desugarer, entry: FnEntry, tok: u32) Error!*const CExpr {
        if (entry.decl.expands)
            return self.fail(error.CoreFragment, tok, "a function with function-typed parameters is not a value (it is expanded at call sites)");
        if (entry.decl.mut_def)
            return self.fail(error.CoreFragment, tok, "a function with mut parameters is not a value (R2)");
        if (entry.decl.type_params.len > 0)
            return self.fail(error.CoreFragment, tok, "a generic function value needs explicit type arguments (not yet supported)");
        const idx = for (self.fns, 0..) |fe, i| {
            if (fe.decl == entry.decl) break i;
        } else return self.fail(error.CoreFragment, tok, "function is not in the function table");
        return self.mk(.{ .fnref = .{ .fn_ = @intCast(idx) } });
    }

    /// callee が関数値（関数型のローカル / フィールド）なら その型。名前付き関数・builtin・ラムダは null
    fn fnValueTy(self: *Desugarer, callee: *const ast.Expr, env: Env) ?*const Ty {
        switch (callee.*) {
            .ident => |id| {
                const b = lookup(env, id.name) orelse return null;
                const t = b.ty orelse return null;
                return if (t.* == .fn_) t else null;
            },
            .selector => |sel| {
                if (sel.base.* == .ident and lookup(env, sel.base.ident.name) == null and
                    self.cur_pkg.imports.get(sel.base.ident.name) != null) return null;
                const t = self.computeTy(callee, env) orelse return null;
                return if (t.* == .fn_) t else null;
            },
            else => return null,
        }
    }

    /// 関数値の呼び出し: 関数値を先に評価し、引数は pair 鎖（call と同じ規約）
    fn callValue(self: *Desugarer, callee: *const ast.Expr, ft: *const Ty, args: []const *ast.Expr, tok: u32, env: Env, depth: u32) Error!*const CExpr {
        const f = try self.expr(callee, env, depth);
        const n = args.len;
        const values = try self.a.alloc(*const CExpr, n);
        var p = ft.fn_.p;
        for (args, 0..) |arg, i| {
            // pair 鎖を先頭から剥がして各引数の期待型を得る（最後の 1 個は鎖の残りそのもの）
            const want: *const Ty = if (i + 1 == n) p else switch (p.*) {
                .prod => |pr| blk: {
                    p = pr.r;
                    break :blk pr.l;
                },
                else => return self.fail(error.Malformed, tok, "argument count"),
            };
            values[i] = try self.coerceExpr(arg, want, env, depth, tok);
        }
        if (n == 0 and p.* != .unit) return self.fail(error.Malformed, tok, "argument count");
        return self.mk(.{ .callv = .{ .f = f, .e = try self.pairChain(values) } });
    }

    fn call(self: *Desugarer, callee0: *const ast.Expr, args: []const *ast.Expr, tok: u32, env: Env, depth: u32) Error!*const CExpr {
        // 明示の型引数 `f[T](...)`（index + call と同形 — syntax.md 9 節）
        var callee = callee0;
        var explicit: ?*const ast.Expr = null;
        if (callee0.* == .index and (try typeExprOfExpr(callee0.index.idx)) != null) {
            if (try self.findFn(callee0.index.base, env)) |_| {
                explicit = callee0.index.idx;
                callee = callee0.index.base;
            }
        }
        if (self.fnValueTy(callee, env)) |ft| return self.callValue(callee, ft, args, tok, env, depth);
        if (callee.* == .ident) {
            const name = callee.ident.name;
            // println は型付け上「引数を評価して unit」（出力の効果は analyzer 層の領分）
            if (std.mem.eql(u8, name, "println")) {
                var body: *const CExpr = try self.mk(.triv);
                var i = args.len;
                while (i > 0) {
                    i -= 1;
                    const v = try self.expr(args[i], env, depth + @as(u32, @intCast(i)));
                    body = try self.mk(.{ .let = .{ .e = v, .body = body } });
                }
                return body;
            }
            if (std.mem.eql(u8, name, "len")) {
                if (args.len != 1) return self.fail(error.Malformed, tok, "len takes one argument");
                if (isStringTy(self.computeTy(args[0], env))) return self.fail(error.Malformed, tok, "string has no len; name the view (len(bytes(s)))");
                if (self.computeTy(args[0], env)) |bt| {
                    if (bt.* == .map) return self.mk(.{ .lenm = try self.expr(args[0], env, depth) });
                }
                return self.mk(.{ .lenE = try self.expr(args[0], env, depth) });
            }
            // keys(m)（keysm の段）: map のキー列のスナップショット（最内 region の imm slice）
            if (std.mem.eql(u8, name, "keys")) {
                if (args.len != 1) return self.fail(error.Malformed, tok, "keys takes one argument");
                const bt = self.computeTy(args[0], env) orelse return self.fail(error.CoreFragment, tok, "keys of a value whose type is not known");
                if (bt.* != .map) return self.fail(error.Malformed, tok, "keys of a non-map value");
                return self.mk(.{ .keysm = try self.expr(args[0], env, depth) });
            }
            // io の builtin（std 専用、io-3 裁定 C1）: 外界は型だけ — 型どおりの固定の代役に置き換える（println → unit と同じ姿勢）。
            // sysReadFile(p) / sysReadDir(p) / sysArgs() = 空のバイト列（`let p in freeze(mkslice int)`）、
            // sysWriteFile(p, b) / sysWriteFd(fd, b) / sysErrno() = 0（成功）。
            // 引数は評価順どおり let で評価して捨てる。io の中身は codegen の実行テストで検証する
            if (isStdPkg(self.cur_pkg)) {
                if (std.mem.eql(u8, name, "sysErrno")) {
                    if (args.len != 0) return self.fail(error.Malformed, tok, "sysErrno takes no arguments");
                    return self.mk(.{ .lit = 0 });
                }
                if (std.mem.eql(u8, name, "sysArgs")) {
                    if (args.len != 0) return self.fail(error.Malformed, tok, "sysArgs takes no arguments");
                    return self.mk(.{ .freeze = try self.mk(.{ .mkslice = .{ .m = true, .t = try self.mkTy(.int) } }) });
                }
                const rd = std.mem.eql(u8, name, "sysReadFile") or std.mem.eql(u8, name, "sysReadDir");
                if (rd or std.mem.eql(u8, name, "sysWriteFile") or std.mem.eql(u8, name, "sysWriteFd")) {
                    const n: usize = if (rd) 1 else 2;
                    if (args.len != n) return self.fail(error.Malformed, tok, "io builtin arity");
                    const int = try self.mkTy(.int);
                    var body: *const CExpr = if (n == 1)
                        try self.mk(.{ .freeze = try self.mk(.{ .mkslice = .{ .m = true, .t = int } }) })
                    else
                        try self.mk(.{ .lit = 0 });
                    var i = n;
                    while (i > 0) {
                        i -= 1;
                        body = try self.mk(.{ .let = .{ .e = try self.expr(args[i], env, depth + @as(u32, @intCast(i))), .body = body } });
                    }
                    return body;
                }
            }
            // bytesToString(b): std 専用（std/utf8 が検査の後に使う）。bytes の逆で恒等（形の変換のみ）
            if (std.mem.eql(u8, name, "bytesToString") and isStdPkg(self.cur_pkg)) {
                if (args.len != 1) return self.fail(error.Malformed, tok, "bytesToString takes one argument");
                const bt = self.computeTy(args[0], env) orelse return self.fail(error.CoreFragment, tok, "bytesToString needs a statically known []int");
                if (bt.* != .slice or bt.slice.str or bt.slice.m or bt.slice.t.* != .int) return self.fail(error.Malformed, tok, "bytesToString of a non-[]int value");
                return self.expr(args[0], env, depth);
            }
            // bytes(s): string のバイト列ビュー。表現が同じなので恒等（形の変換のみ）
            if (std.mem.eql(u8, name, "bytes")) {
                if (args.len != 1) return self.fail(error.Malformed, tok, "bytes takes one argument");
                if (!isStringTy(self.computeTy(args[0], env))) return self.fail(error.Malformed, tok, "bytes of a non-string value");
                return self.expr(args[0], env, depth);
            }
            // freeze: mut コンテナ → imm（language.md 22 節。builtin・再束縛不可）
            if (std.mem.eql(u8, name, "freeze")) {
                if (args.len != 1) return self.fail(error.Malformed, tok, "freeze takes one argument");
                return self.mk(.{ .freeze = try self.expr(args[0], env, depth) });
            }
            // delete(m, k): 墓石を書く（不在は no-op）。t 注釈は map の値型
            if (std.mem.eql(u8, name, "delete")) {
                if (args.len != 2) return self.fail(error.Malformed, tok, "delete takes two arguments");
                const bt = self.computeTy(args[0], env) orelse
                    return self.fail(error.CoreFragment, tok, "delete needs a map-typed subject");
                if (bt.* != .map) return self.fail(error.Malformed, tok, "delete on a non-map value");
                return self.mk(.{ .delm = .{
                    .t = bt.map.t,
                    .e = try self.expr(args[0], env, depth),
                    .k = try self.expr(args[1], env, depth),
                } });
            }
            if (std.mem.eql(u8, name, "append")) {
                if (args.len != 2) return self.fail(error.Malformed, tok, "append takes two arguments");
                if (isStringTy(self.computeTy(args[0], env))) return self.fail(error.Malformed, tok, "append to a string (use +)");
                const subject = try self.expr(args[0], env, depth);
                const v = try self.appendValueAnn(args[0], args[1], try self.expr(args[1], env, depth), env);
                return self.mk(.{ .append = .{ .e = subject, .v = v } });
            }
            if (lookupF(env, name)) |closure| return self.lambdaCall(closure, args, tok, env, depth);
        }
        const entry = (try self.findFn(callee, env)) orelse
            return self.fail(error.CoreFragment, tok, "unknown or builtin function is outside the core fragment");
        const f = entry.decl;
        if (f.expands) return self.inlineCall(entry, explicit, args, tok, env, depth);
        if (entry.pkg == self.prog.main and std.mem.eql(u8, f.name, "main"))
            return self.fail(error.CoreFragment, tok, "call to main is outside the core fragment");
        // 関数表の index を引く（decl 一致）
        const idx = for (self.fns, 0..) |fe, i| {
            if (fe.decl == f) break i;
        } else return self.fail(error.CoreFragment, tok, "unknown or builtin function is outside the core fragment");
        if (args.len != f.params.len) return self.fail(error.Malformed, tok, "argument count");
        // ジェネリック（V3-3）: 型引数を決めて、仮引数の型をその束縛で読む
        const ts: []const *const Ty = if (f.type_params.len > 0) try self.inferTs(entry, explicit, args, env, tok, false) else blk: {
            if (explicit != null) return self.fail(error.Malformed, tok, "type arguments to a non-generic function");
            break :blk &.{};
        };
        const penv = try self.a.alloc(TBind, ts.len);
        for (f.type_params, ts, penv) |n, t, *b| b.* = .{ .name = n, .ty = t };
        // 多引数は pair 鎖に束ねて 1 引数で渡す（多値 = struct と対称）
        const values = try self.a.alloc(*const CExpr, args.len);
        for (args, 0..) |arg, i| {
            if (f.params[i].mutable) {
                // mut 引数（R2: Def として呼ぶ mut 引数の関数）: 呼び手の mut ローカルの ref をそのまま渡す。
                // region は anchor として Lean が型から読む（正確一致 — 束縛の region）
                values[i] = try self.mutRefArg(arg, env, depth);
                continue;
            }
            const want = self.tyIn(entry.pkg, penv, f.params[i].type, tok) catch null;
            // string リテラルの実引数は region 0（呼び手空間の上界 — Def の region 0 の仮引数は call で呼び手の最内、callM で anchor に写る。
            // 実体は rodata なのでどちらにも収まる）。最内に置くと callM の imm 引数の条件（anchor 以下）に掛かる（F-6）
            if (arg.* == .strlit and isStringTy(want)) {
                values[i] = try self.mk(.{ .strlit = .{ .bs = arg.strlit.value, .r = 0 } });
                continue;
            }
            values[i] = if (want) |w| try self.coerceExpr(arg, w, env, depth, tok) else try self.expr(arg, env, depth);
        }
        const packed_ = try self.pairChain(values);
        return self.mk(.{ .call = .{ .fn_ = @intCast(idx), .e = packed_, .ts = ts, .m = f.mut_def } });
    }

    /// mut 引数の実引数 `mut x`（R2）: 呼び手の mut ローカル（または mut 仮引数）の ref
    fn mutRefArg(self: *Desugarer, arg: *const ast.Expr, env: Env, depth: u32) Error!*const CExpr {
        if (arg.* != .mut_arg) return self.fail(error.CoreFragment, arg.tok(), "a mut parameter takes `mut x` (a mut local) at the call site");
        const m = arg.mut_arg;
        const b = lookup(env, m.name) orelse return self.fail(error.UnknownName, m.tok, "unknown name");
        if (!b.mutable) return self.fail(error.CoreFragment, m.tok, "`mut x` needs a mut local");
        return self.mk(.{ .var_ = depth - 1 - b.level });
    }

    /// expands 関数の呼び出し点展開。値引数は letE、関数型引数はラムダを fenv に積む。
    /// 本体から見えるのは自分の引数だけ（View の鎖の凍結と同じ規律）
    fn inlineCall(self: *Desugarer, entry: FnEntry, explicit: ?*const ast.Expr, args: []const *ast.Expr, tok: u32, env: Env, depth: u32) Error!*const CExpr {
        const f = entry.decl;
        for (self.inlining.items) |g| {
            if (g == f) return self.fail(error.CoreFragment, tok, "recursive inline expansion");
        }
        if (args.len != f.params.len) return self.fail(error.Malformed, tok, "argument count");
        // ジェネリック inline（V3-4）: 型引数を値引数（と Iter を生む for 式）から推論し、
        // 仮引数の型と本体はその束縛で読む。ラムダは定義側の型環境を凍結して持つ
        const body_tenv: []const TBind = if (f.type_params.len > 0)
            try self.callEnv(entry, explicit, args, env, tok)
        else if (explicit != null)
            return self.fail(error.Malformed, tok, "type arguments on a non-generic function")
        else
            self.tenv;

        var fenv: std.ArrayListUnmanaged(FEntry) = .empty;
        var values: std.ArrayListUnmanaged(*const CExpr) = .empty;
        var bindings: std.ArrayListUnmanaged(Binding) = .empty;
        var level = depth;
        for (f.params, args) |p, arg| {
            if (p.mutable) {
                try values.append(self.a, try self.mutParamArg(entry, p, arg, body_tenv, env, level, tok));
                const pb = lookup(env, arg.mut_arg.name).?;
                const want = blk: {
                    const saved = self.tenv;
                    defer self.tenv = saved;
                    self.tenv = body_tenv;
                    break :blk .{ self.tyOf(entry.pkg, p.type, tok, 32) catch null, self.declOfTypeExpr(entry.pkg, p.type), self.elemDeclOfTypeExpr(entry.pkg, p.type) };
                };
                try bindings.append(self.a, .{ .name = p.name, .level = level, .mutable = true, .region = pb.region, .ty = want[0], .decl = want[1], .elem_decl = want[2] });
                level += 1;
                continue;
            }
            if (arg.* == .mut_arg) return self.fail(error.CoreFragment, arg.mut_arg.tok, "`mut x` passed to a parameter that is not mut");
            switch (p.type) {
                .func => {
                    const want = blk: {
                        const saved = self.tenv;
                        defer self.tenv = saved;
                        self.tenv = body_tenv;
                        break :blk self.tyOf(entry.pkg, p.type, tok, 32) catch null;
                    };
                    try fenv.append(self.a, .{ .name = p.name, .closure = try self.closureArg(arg, want, env, tok) });
                },
                .name, .opt, .slice_of, .map_of, .generic => {
                    // 引数は左から右へ letE で入れ子にするので、評価時の深さは先行する値引数のぶん増える
                    const want, const pdecl, const pelem = blk: {
                        const saved = self.tenv;
                        defer self.tenv = saved;
                        self.tenv = body_tenv;
                        break :blk .{ self.tyOf(entry.pkg, p.type, tok, 32) catch null, self.declOfTypeExpr(entry.pkg, p.type), self.elemDeclOfTypeExpr(entry.pkg, p.type) };
                    };
                    // 仮引数の型は展開で core から消えるので、展開点の座標の ann で検査を Lean に返す（V3-5 ③）
                    const at: ?*const Ty = if (want) |w| try self.inlineArgTy(arg, w, env) else null;
                    const v = if (at) |t| try self.mk(.{ .ann = .{ .e = try self.coerceExpr(arg, want.?, env, level, tok), .t = t } }) else try self.expr(arg, env, level);
                    try values.append(self.a, v);
                    try bindings.append(self.a, .{ .name = p.name, .level = level, .mutable = false, .decl = pdecl, .ty = want, .elem_decl = pelem, .core_ty = at });
                    level += 1;
                },
            }
        }

        const body_env: Env = .{ .bindings = bindings.items, .fenv = fenv.items };
        try self.inlining.append(self.a, f);
        defer _ = self.inlining.pop();
        // 本体は callee の package 文脈で
        const saved_pkg = self.cur_pkg;
        self.cur_pkg = entry.pkg;
        defer self.cur_pkg = saved_pkg;
        const saved_tenv = self.tenv;
        self.tenv = body_tenv;
        defer self.tenv = saved_tenv;
        // 本体 = `label t body`（V4）。t は結果型の展開点の座標（jump のペイロードと本体を ann で t に揃える）。
        // 結果の無い関数は unit で本体の値を捨てる。結果型が静的に決まらなければ途中の return だけ断片外
        const rtys: ?[]const *const Ty = blk: {
            const out = try self.a.alloc(*const Ty, f.results.len);
            for (f.results, out) |rt, *o| {
                const t = self.tyOf(entry.pkg, rt, tok, 32) catch break :blk null;
                o.* = try self.pointTy(t);
            }
            break :blk out;
        };
        const saved_ctl = self.saveCtl();
        defer self.restoreCtl(saved_ctl);
        var rl = try self.newLabelCtx(.ret, if (rtys) |rs| try self.tyChain(rs) else null);
        if (rtys) |rs| rl.rtys = rs;
        rl.ann = f.results.len > 0;
        self.ret_target = try self.pushLabel(rl);
        self.loop_floor = self.labels.items.len;
        // 末尾の return（ラベルへ跳ばない形）の値の強制も callee の結果型で（暗黙 some 等）— 呼び手の結果型ではない
        const saved_rtys = self.cur_rtys;
        self.cur_rtys = rtys orelse &.{};
        defer self.cur_rtys = saved_rtys;
        var body = blk: {
            defer self.labels.items.len -= 1;
            const inner = try self.scoped(f.body.stmts, body_env, level, .{ .ret_allowed = true, .want = rl.t });
            break :blk try self.labelNode(rl, inner, if (f.results.len > 0) .ann else .discard);
        };
        var i = values.items.len;
        while (i > 0) {
            i -= 1;
            body = try self.mk(.{ .let = .{ .e = values.items[i], .body = body } });
        }
        return body;
    }

    /// mut 引数の実引数（V3-5）: 呼び手の mut ローカル `mut x` だけ。ref そのものを渡して別名にし、
    /// 仮引数の型を ref の型（region は束縛の alloc 点、中身は同じ点の点座標）で ann する — ref は正確一致なので
    /// 型違い・region 違いは Lean が拒否する
    fn mutParamArg(self: *Desugarer, entry: FnEntry, p: ast.Param, arg: *const ast.Expr, body_tenv: []const TBind, env: Env, level: u32, tok: u32) Error!*const CExpr {
        if (arg.* != .mut_arg) return self.fail(error.CoreFragment, arg.tok(), "a mut parameter takes `mut x` (a mut local) at the call site");
        const m = arg.mut_arg;
        const b = lookup(env, m.name) orelse return self.fail(error.UnknownName, m.tok, "unknown name");
        if (!b.mutable) return self.fail(error.CoreFragment, m.tok, "`mut x` needs a mut local");
        const ref = try self.mk(.{ .var_ = level - 1 - b.level });
        const want = blk: {
            const saved = self.tenv;
            defer self.tenv = saved;
            self.tenv = body_tenv;
            break :blk self.tyOf(entry.pkg, p.type, tok, 32) catch return ref;
        };
        const saved_rdepth = self.rdepth;
        defer self.rdepth = saved_rdepth;
        self.rdepth = b.region + 1;
        const inner = try self.pointTy(want);
        return self.mk(.{ .ann = .{ .e = ref, .t = try self.mkTy(.{ .ref = .{ .m = true, .r = b.region, .t = inner } }) } });
    }

    /// 関数型の引数位置に書ける形: ラムダ（閉包にする）・閉包に束縛された名前（転送）・
    /// for 式（Iter[T] のラムダに書き換える — forexpand.zig）
    fn closureArg(self: *Desugarer, arg: *const ast.Expr, want: ?*const Ty, env: Env, tok: u32) Error!*const Closure {
        switch (arg.*) {
            .for_ => |*fe| {
                if (forexpand.outOfFragment(fe)) |what| return self.fail(error.CoreFragment, fe.tok, what);
                const lowered = try forexpand.lower(self.a, fe, self.forSrcKind(fe.gens[0].src, env));
                const c = try self.a.create(Closure);
                c.* = .{ .lambda = &lowered.lambda, .env = env, .pkg = self.cur_pkg, .tenv = self.tenv, .ft = want, .ret_target = self.ret_target };
                return c;
            },
            .lambda => |*l| {
                const c = try self.a.create(Closure);
                c.* = .{ .lambda = l, .env = env, .pkg = self.cur_pkg, .tenv = self.tenv, .ft = want, .ret_target = self.ret_target };
                return c;
            },
            .ident => |id| {
                if (lookup(env, id.name) == null) {
                    if (lookupF(env, id.name)) |c| return c;
                }
            },
            else => {},
        }
        return self.fail(error.CoreFragment, tok, "expected a lambda for a function-typed parameter");
    }

    /// for の生成元の種類（forexpand.lower が書き換えを選ぶ）
    fn forSrcKind(self: *Desugarer, src: *const ast.Expr, env: Env) forexpand.SrcKind {
        if (isClosureName(src, env)) return .closure;
        if (self.computeTy(src, env)) |t| if (t.* == .map) return .map;
        return .slice;
    }

    /// 閉包（関数型の引数に束縛されたラムダ）の名前か
    fn isClosureName(e: *const ast.Expr, env: Env) bool {
        return e.* == .ident and lookup(env, e.ident.name) == null and lookupF(env, e.ident.name) != null;
    }

    /// for 式の型 = Iter[T]（func(func(T))）。T は yield の値の型。推論に使えるのは生成元が slice のときだけ
    /// （codegen の推論と同じ線 — 閉包の生成元は推論に寄与しない）
    fn forIterTy(self: *Desugarer, fe: *const ast.ForExpr, env: Env) ?*const Ty {
        if (forexpand.outOfFragment(fe) != null) return null;
        const g = fe.gens[0];
        if (isClosureName(g.src, env)) return null;
        const st = self.computeTy(g.src, env) orelse return null;
        // map の生成元はキーを回す（keysm の段）
        const elem: *const Ty = switch (st.*) {
            .slice => |sl| sl.t,
            .map => |mp| mp.k,
            else => return null,
        };
        const decl = if (st.* == .slice) self.elemDeclOfExpr(g.src, env) else null;
        const env2 = self.bind(env, .{ .name = g.names[0], .level = 0, .mutable = false, .ty = elem, .decl = decl }) catch return null;
        const y = switch (fe.body) {
            .yield_ => |e| self.computeTy(e, env2),
            .block => |b| self.yieldTyIn(b.stmts, env2),
        } orelse return null;
        const unit = self.mkTy(.unit) catch return null;
        const k = self.mkTy(.{ .fn_ = .{ .p = y, .r = unit } }) catch return null;
        return self.mkTy(.{ .fn_ = .{ .p = k, .r = unit } }) catch null;
    }

    /// ブロック形の本体で最初に現れる yield の値の型（束縛・if・while の中まで見る）
    fn yieldTyIn(self: *Desugarer, list: []const ast.Stmt, env0: Env) ?*const Ty {
        var env = env0;
        for (list) |st| {
            switch (st) {
                .yield_ => |y| return self.computeTy(y.expr, env),
                .bind => |b| {
                    if (b.names.len != b.values.len) continue;
                    for (b.names, b.values) |n, v| {
                        env = self.bind(env, .{ .name = n, .level = 0, .mutable = b.mutable, .ty = self.computeTy(v, env), .decl = self.declOfExpr(v, env), .elem_decl = self.elemDeclOfExpr(v, env) }) catch return null;
                    }
                },
                .while_ => |w| if (self.yieldTyIn(w.body.stmts, env)) |t| return t,
                .expr => |e| if (e.* == .if_) {
                    var i: ?*const ast.Expr = e;
                    while (i) |cur| {
                        if (cur.* != .if_) {
                            if (cur.* == .block) {
                                if (self.yieldTyIn(cur.block.stmts, env)) |t| return t;
                            }
                            break;
                        }
                        if (self.yieldTyIn(cur.if_.then.stmts, env)) |t| return t;
                        i = cur.if_.else_;
                    }
                },
                else => {},
            }
        }
        return null;
    }

    /// 引数が閉包として束縛される形か（ラムダ・閉包の名前）。ラムダの引数の束縛で使う
    fn isClosureArg(arg: *const ast.Expr, env: Env) bool {
        return switch (arg.*) {
            .lambda, .for_ => true,
            .ident => |id| lookup(env, id.name) == null and lookupF(env, id.name) != null,
            else => false,
        };
    }

    /// 型列 → 右結合の prod 鎖（0 は unit、1 は素の型）
    fn tyChain(self: *Desugarer, tys: []const *const Ty) Error!*const Ty {
        if (tys.len == 0) return self.mkTy(.unit);
        if (tys.len == 1) return tys[0];
        const rest = try self.tyChain(tys[1..]);
        return self.mkTy(.{ .prod = .{ .l = tys[0], .r = rest } });
    }

    /// 非 inline 関数 → コアの Def。パラメータ列は prod 鎖（本体で束が var 0）、
    /// 2 個以上なら射影の letE で名前を付ける。戻り値列も prod 鎖。
    /// 本体は block で包む（mut 束縛の alloc は深さ 1 以上が要る — main と同じ）
    /// 戻り値型の最上段の slice / map を自フレーム（r = 1）へ付け替える（round4 (5)）。
    /// retOk の r < 2 のうち、最上段 = 本体で新規構築して返す形（mkslice → freeze が
    /// r = 1 を合成する）に合わせる。入れ子（struct のフィールド等）は呼び手空間
    /// r = 0 のまま — 引数由来のデータの持ち場。呼び手空間の値をそのまま返す転送形
    /// （return s）は型が合わず check に落ちる（V1 の断片外、formal.md が正）
    /// 本体に書かれた型式の点座標（language.md 21 節）: tyOf の region 添字（base 座標 = 0）を、
    /// 書かれた点の最内 region（rdepth - 1）へ写す。imm は上界なので最も緩い正しい値、
    /// mut はその点での新規構築の正確な region。関数値の型は base 座標のスキームなので触らない
    /// 読み出しの注釈（R4b-cov A-2）: imm slice の要素型が注釈を持つ（opt / union / 型変数を含む）なら、静的な要素型で
    /// 注釈する（読んだ値の注釈を coerceTo が要素型へ書き換える — セル型は要素型の部分型）。annFree・mut・型不明は注釈なし
    fn readAnn(self: *Desugarer, bt: ?*const Ty) ?*const Ty {
        _ = self;
        const t = bt orelse return null;
        if (t.* != .slice or t.slice.m or tyAnnFree(t.slice.t)) return null;
        return t.slice.t;
    }

    /// ブロックの末尾値の型（R5）: 文の束縛を辿ってから末尾の式を型付ける（ブロックの中の点座標 — 呼び手が rdepth を上げてから呼ぶ）
    fn blockTailTy(self: *Desugarer, list: []const ast.Stmt, env0: Env) ?*const Ty {
        if (list.len == 0 or list[list.len - 1] != .expr) return null;
        var env = env0;
        for (list[0 .. list.len - 1]) |st| {
            switch (st) {
                .bind => |b| {
                    if (b.names.len != b.values.len) return null;
                    for (b.names, b.values) |n, v| {
                        env = self.bind(env, .{ .name = n, .level = 0, .mutable = b.mutable, .ty = self.computeTy(v, env), .decl = self.declOfExpr(v, env), .elem_decl = self.elemDeclOfExpr(v, env) }) catch return null;
                    }
                },
                else => {},
            }
        }
        return self.computeTy(list[list.len - 1].expr, env);
    }

    /// imm の region を k へ締める（Lean の Ty.clampR — 中身へ再帰。mut / chan はそのまま）
    fn tyClamp(self: *Desugarer, t: *const Ty, k: u32) std.mem.Allocator.Error!*const Ty {
        return switch (t.*) {
            .int, .bool_, .unit, .tvar, .fn_, .chan => t,
            .opt => |x| self.mkTy(.{ .opt = try self.tyClamp(x, k) }),
            .union_ => |u| self.mkTy(.{ .union_ = .{ .l = try self.tyClamp(u.l, k), .r = try self.tyClamp(u.r, k) } }),
            .prod => |p| self.mkTy(.{ .prod = .{ .l = try self.tyClamp(p.l, k), .r = try self.tyClamp(p.r, k) } }),
            .slice => |sl| if (sl.m) t else self.mkTy(.{ .slice = .{ .m = false, .r = @min(sl.r, k), .t = try self.tyClamp(sl.t, k), .str = sl.str } }),
            .map => |mp| if (mp.m) t else self.mkTy(.{ .map = .{ .m = false, .r = @min(mp.r, k), .k = try self.tyClamp(mp.k, k), .t = try self.tyClamp(mp.t, k) } }),
            .ref => |rf| if (rf.m) t else self.mkTy(.{ .ref = .{ .m = false, .r = @min(rf.r, k), .t = try self.tyClamp(rf.t, k) } }),
        };
    }

    fn pointTy(self: *Desugarer, t: *const Ty) std.mem.Allocator.Error!*const Ty {
        const r = self.rdepth - 1;
        return switch (t.*) {
            .int, .bool_, .unit, .tvar, .fn_, .chan => t,
            .opt => |x| self.mkTy(.{ .opt = try self.pointTy(x) }),
            .union_ => |u| self.mkTy(.{ .union_ = .{ .l = try self.pointTy(u.l), .r = try self.pointTy(u.r) } }),
            .prod => |p| self.mkTy(.{ .prod = .{ .l = try self.pointTy(p.l), .r = try self.pointTy(p.r) } }),
            .slice => |sl| self.mkTy(.{ .slice = .{ .m = sl.m, .r = r, .t = try self.pointTy(sl.t), .str = sl.str } }),
            .map => |mp| self.mkTy(.{ .map = .{ .m = mp.m, .r = r, .k = try self.pointTy(mp.k), .t = try self.pointTy(mp.t) } }),
            .ref => |rf| self.mkTy(.{ .ref = .{ .m = rf.m, .r = r, .t = try self.pointTy(rf.t) } }),
        };
    }

    /// 型のゼロ値（ゼロ値リテラル `T{}` の中身）。コンテナは点座標の空（imm は mut 構築 + freeze）
    fn zeroOf(self: *Desugarer, t: *const Ty, tok: u32) Error!*const CExpr {
        return switch (t.*) {
            .int => self.mk(.{ .lit = 0 }),
            .bool_ => self.mk(.ff),
            .unit => self.mk(.triv),
            .opt => |p| self.mk(.{ .nil = try self.pointTy(p) }),
            .slice => |sl| blk: {
                const e = try self.mk(.{ .mkslice = .{ .m = true, .t = try self.pointTy(sl.t) } });
                break :blk if (sl.m) e else self.mk(.{ .freeze = e });
            },
            .map => |mp| blk: {
                const e = try self.mk(.{ .mkmap = .{ .m = true, .k = try self.pointTy(mp.k), .t = try self.pointTy(mp.t) } });
                break :blk if (mp.m) e else self.mk(.{ .freeze = e });
            },
            .prod => |pr| self.mk(.{ .pair = .{ .a = try self.zeroOf(pr.l, tok), .b = try self.zeroOf(pr.r, tok) } }),
            else => self.fail(error.CoreFragment, tok, "a zero-value literal T{} needs every field to have a zero value (not a function value, union or type parameter)"),
        };
    }

    /// 期待型 want（base 座標）を現在の点座標へ写した ann で包む（V3-5 ③）
    /// map のキー型（R3: int | string — Lean の keyOk と同じ二択。他は断片外）
    fn mapKeyTy(self: *Desugarer, k: *const Ty, tok: u32) Error!*const Ty {
        if (k.* == .int or isStringTy(k)) return k;
        return self.fail(error.CoreFragment, tok, "map key type must be int or string");
    }

    /// 格納するキー（setm）。string キーはキー型へ ann で緩める（region の上界 — 内側 scope の
    /// string は Lean の sub で落ちる = escape 拒否、R3 の了承済みの帰結）
    /// `m[k] = v` の m（名前の mut 束縛の map）のキー型・値型を束縛点の点座標で読む（束縛が見つからなければ bt のまま）
    fn mapCellAt(self: *Desugarer, base: *const ast.Expr, bt: *const Ty, env: Env) std.mem.Allocator.Error!struct { *const Ty, *const Ty } {
        const b = lookup(env, base.ident.name) orelse return .{ bt.map.k, bt.map.t };
        if (!b.mutable) return .{ bt.map.k, bt.map.t };
        const saved = self.rdepth;
        defer self.rdepth = saved;
        self.rdepth = b.region + 1;
        return .{ try self.pointTy(bt.map.k), try self.pointTy(bt.map.t) };
    }

    /// `m[k]` の V（getm の注釈と computeTy の結果）: map の値型を、セルが実際に組まれた点の座標で読む（F-34 — F-26 の mapCellAt と同じ読み）。
    /// 宣言の型式から作った bt は string を r0 に固定するので、関数の frame（r1〜）で組んだ map の値型より締まり、Lean の getm の
    /// `Ty.sub t' t` で落ちていた。名前の束縛はコア上の正確な型（core_ty — Def の値仮引数・展開の値引数）があればそれ、無ければ束縛点
    /// （map リテラル・呼び出しの結果・mut 束縛はそこで組まれるか写される）。辞書 const の参照は参照点で展開される（25 節）ので現在の点。
    /// 他は bt のまま（従来どおり）
    fn mapValueAt(self: *Desugarer, base: *const ast.Expr, bt: *const Ty, env: Env) std.mem.Allocator.Error!*const Ty {
        if (base.* == .ident) {
            if (lookup(env, base.ident.name)) |b| {
                if (b.core_ty) |ct| return if (ct.* == .map) ct.map.t else bt.map.t;
                const saved = self.rdepth;
                defer self.rdepth = saved;
                self.rdepth = b.region + 1;
                return self.pointTy(bt.map.t);
            }
        }
        if (self.dictConstOf(base, env) != null) return self.pointTy(bt.map.t);
        return bt.map.t;
    }

    /// 値 value（コアは core）の型が行き先の型 et より締まっている（仮引数由来の imm — region が浅い）ときだけ、et へ ann で緩める
    /// （appendValueAnn と同じ規律 — 行き先の型が確定している所だけ・緩める向きの浅い共変だけ）
    fn looserAnn(self: *Desugarer, value: *const ast.Expr, core: *const CExpr, et: *const Ty, env: Env) Error!*const CExpr {
        const vt = self.computeTy(value, env) orelse return core;
        if (!hasRegion(et) or tyEql(vt, et) or !tyLooser(vt, et)) return core;
        return self.mk(.{ .ann = .{ .e = core, .t = et } });
    }

    fn mapKey(self: *Desugarer, key: *const ast.Expr, kt: *const Ty, env: Env, depth: u32) Error!*const CExpr {
        const core = try self.expr(key, env, depth);
        if (kt.* == .int) return core;
        return self.mk(.{ .ann = .{ .e = core, .t = kt } });
    }

    fn annAt(self: *Desugarer, e: *const CExpr, want: *const Ty) std.mem.Allocator.Error!*const CExpr {
        return self.mk(.{ .ann = .{ .e = e, .t = try self.pointTy(want) } });
    }

    /// 展開（inline / ラムダ）の値引数を ann する型: 既定は展開点の点座標（annAt と同じ — V3-5 ③）。ただし実引数が名前で、
    /// その束縛がコア上の正確な型（Binding.core_ty）を持ち、点座標より締まっている（imm の region が浅い — 例: Def 本体の
    /// 仮引数の r0）ときは、その型のまま ann する。点座標へ緩めると、展開した本体から anchor つきの mut Def（R2 の callM）へ渡す
    /// imm 引数が mut 束縛より深い扱いになり、手で展開して書けば通る形が def error になる（selfhost-drafts F-11）。
    /// 締まった型でも Ty.sub で点座標の仮引数型に収まるので、仮引数の型の検査は Lean に返ったまま
    fn inlineArgTy(self: *Desugarer, arg: *const ast.Expr, want: *const Ty, env: Env) std.mem.Allocator.Error!*const Ty {
        const pt = try self.pointTy(want);
        if (arg.* != .ident) return pt;
        const b = lookup(env, arg.ident.name) orelse return pt;
        const t = b.core_ty orelse return pt;
        if (b.mutable or tyEql(t, pt) or !tyLooser(t, pt)) return pt;
        return t;
    }

    /// 最上段 = 値ラッパ（opt / union / prod）を分配した位置（R0: Lean の relocR・relocate と同じ最上段）。
    /// error? の中のラベルの string・struct の結果のフィールドも自フレーム可になる
    fn retTy(self: *Desugarer, t: *const Ty) std.mem.Allocator.Error!*const Ty {
        return switch (t.*) {
            // R4a（深い relocate）: imm コンテナの中身も自フレーム可 — 中身へも分配する（fretK が中身ごと写す）
            .slice => |sl| self.mkTy(.{ .slice = .{ .m = sl.m, .r = 1, .t = if (sl.m) sl.t else try self.retTy(sl.t), .str = sl.str } }),
            // キー型も中身（string キーの map — 値型と同じく自フレーム可。selfhost-drafts F-24）
            .map => |mp| self.mkTy(.{ .map = .{ .m = mp.m, .r = 1, .k = if (mp.m) mp.k else try self.retTy(mp.k), .t = if (mp.m) mp.t else try self.retTy(mp.t) } }),
            .opt => |x| if (wrapsContainer(t)) self.mkTy(.{ .opt = try self.retTy(x) }) else t,
            .union_ => |u| if (wrapsContainer(t)) self.mkTy(.{ .union_ = .{ .l = try self.retTy(u.l), .r = try self.retTy(u.r) } }) else t,
            .prod => |p| if (wrapsContainer(t)) self.mkTy(.{ .prod = .{ .l = try self.retTy(p.l), .r = try self.retTy(p.r) } }) else t,
            else => t,
        };
    }

    /// 関数のシグネチャ → 関数値の型（defOf の param / ret と同じ）
    fn sigTy(self: *Desugarer, entry: FnEntry) Error!*const Ty {
        const f = entry.decl;
        const ps = try self.a.alloc(*const Ty, f.params.len);
        for (f.params, 0..) |prm, i| ps[i] = try self.tyOf(entry.pkg, prm.type, f.tok, 32);
        const rs = try self.a.alloc(*const Ty, f.results.len);
        for (f.results, 0..) |rt, i| rs[i] = try self.retTy(try self.tyOf(entry.pkg, rt, f.tok, 32));
        return self.mkTy(.{ .fn_ = .{ .p = try self.tyChain(ps), .r = try self.tyChain(rs) } });
    }

    fn defOf(self: *Desugarer, entry: FnEntry) Error!CDef {
        // Def 本体は base 2（最内 = 自フレーム region 1）
        const saved_rdepth = self.rdepth;
        self.rdepth = 2;
        defer self.rdepth = saved_rdepth;
        const f = entry.decl;
        const saved_pkg = self.cur_pkg;
        self.cur_pkg = entry.pkg;
        defer self.cur_pkg = saved_pkg;
        // ジェネリック Def（V3-3）: 本体は型パラメータを tvar のまま一度だけ脱糖する（検査も一度 — V3-2）
        const saved_tenv = self.tenv;
        defer self.tenv = saved_tenv;
        self.tenv = try self.tvarEnv(f.type_params, 0);
        const saved_tp = self.cur_tparams;
        defer self.cur_tparams = saved_tp;
        self.cur_tparams = @intCast(f.type_params.len);
        const ptys = try self.a.alloc(*const Ty, f.params.len);
        for (f.params, 0..) |prm, i| {
            if (prm.type == .func)
                return self.fail(error.CoreFragment, f.tok, "function-typed parameter on a non-inline function");
            ptys[i] = try self.tyOf(entry.pkg, prm.type, f.tok, 32);
        }
        // mut 仮引数（R2 K-a の Def 化）: 呼び手の束縛の ref。region 0 = anchor（Lean の callM が束縛の region を与える）
        const vtys = try self.a.dupe(*const Ty, ptys);
        for (f.params, 0..) |prm, i| {
            if (prm.mutable) ptys[i] = try self.mkTy(.{ .ref = .{ .m = true, .r = 0, .t = ptys[i] } });
        }
        const param = try self.tyChain(ptys);
        const rtys = try self.a.alloc(*const Ty, f.results.len);
        for (f.results, 0..) |rt, i| rtys[i] = try self.retTy(try self.tyOf(entry.pkg, rt, f.tok, 32));
        const ret = try self.tyChain(rtys);
        if (self.sig_only) return .{ .param = param, .ret = ret, .body = try self.mk(.triv), .tparams = @intCast(f.type_params.len), .sig_only = true };

        var env = Env.empty;
        var d: u32 = 1;
        var extracts: std.ArrayListUnmanaged(*const CExpr) = .empty;
        if (f.params.len == 1) {
            env = try self.bind(env, .{
                .name = f.params[0].name,
                .level = 0,
                .mutable = f.params[0].mutable,
                .region = 0,
                .decl = self.declOfTypeExpr(entry.pkg, f.params[0].type),
                .ty = vtys[0],
                .core_ty = if (f.params[0].mutable) null else vtys[0],
                .elem_decl = self.elemDeclOfTypeExpr(entry.pkg, f.params[0].type),
            });
        } else if (f.params.len >= 2) {
            for (f.params, 0..) |prm, i| {
                const tuple = try self.mk(.{ .var_ = d - 1 });
                try extracts.append(self.a, try self.projection(tuple, i, f.params.len));
                env = try self.bind(env, .{
                    .name = prm.name,
                    .level = d,
                    .mutable = prm.mutable,
                    .region = 0,
                    .decl = self.declOfTypeExpr(entry.pkg, prm.type),
                    .ty = vtys[i],
                    .core_ty = if (prm.mutable) null else vtys[i],
                    .elem_decl = self.elemDeclOfTypeExpr(entry.pkg, prm.type),
                });
                d += 1;
            }
        }
        const saved_rtys = self.cur_rtys;
        self.cur_rtys = rtys;
        defer self.cur_rtys = saved_rtys;
        // 本体 = `label ret body`（途中の return は jump。使われなければ印字しない）
        const saved_ctl = self.saveCtl();
        defer self.restoreCtl(saved_ctl);
        var rl = try self.newLabelCtx(.ret, ret);
        rl.rtys = rtys;
        self.ret_target = try self.pushLabel(rl);
        self.loop_floor = self.labels.items.len;
        var body = blk: {
            defer self.labels.items.len -= 1;
            break :blk try self.labelNode(rl, try self.scoped(f.body.stmts, env, d, .{ .ret_allowed = true, .want = ret }), .none);
        };
        var i = extracts.items.len;
        while (i > 0) {
            i -= 1;
            body = try self.mk(.{ .let = .{ .e = extracts.items[i], .body = body } });
        }
        // block では包まない（round4 (5)）: 本体は base d = 2 で直に型付ける。
        // 自フレーム = call が push する region 1 — 新規構築（mkslice / alloc）が
        // region 1 に乗り、retOk（最上段 r = 1）と fretK の relocate に揃う。
        // block で包むと構築が region 2 に落ち、出口の regionsBelow 2 で返せない
        return .{ .param = param, .ret = ret, .body = body, .tparams = @intCast(f.type_params.len) };
    }

    /// 型パラメータ名 → tvar(base + i)
    fn tvarEnv(self: *Desugarer, names: []const []const u8, base: u32) Error![]const TBind {
        const env = try self.a.alloc(TBind, names.len);
        for (names, env, 0..) |n, *b, i| b.* = .{ .name = n, .ty = try self.mkTy(.{ .tvar = base + @as(u32, @intCast(i)) }) };
        return env;
    }

    /// ジェネリック関数の型引数: 明示（`f[T](...)`）か、値引数の型からの推論（V3-3 C1）。
    /// 推論は仮引数の型（型パラメータをプレースホルダに）と実引数の型の単一化
    /// ジェネリック呼び出しの束縛（型引数 + 分かる範囲で型引数の struct 宣言 — フィールド / 要素の decl 追跡用）
    fn callEnv(self: *Desugarer, entry: FnEntry, explicit: ?*const ast.Expr, args: []const *ast.Expr, env: Env, tok: u32) Error![]const TBind {
        const f = entry.decl;
        const ts = try self.inferTs(entry, explicit, args, env, tok, true);
        const penv = try self.a.alloc(TBind, ts.len);
        for (f.type_params, ts, penv) |n, t, *b| b.* = .{ .name = n, .ty = t };
        for (f.params, args) |p, arg| {
            const pn: ?[]const u8, const is_elem: bool = switch (p.type) {
                .name => |n| .{ n, false },
                .slice_of => |sl| if (sl.elem.* == .name) .{ sl.elem.name, true } else .{ null, false },
                else => .{ null, false },
            };
            const name = pn orelse continue;
            for (penv) |*b| {
                if (!std.mem.eql(u8, b.name, name) or b.decl != null) continue;
                b.decl = if (is_elem) self.elemDeclOfExpr(arg, env) else self.declOfExpr(arg, env);
            }
        }
        return penv;
    }

    /// inline = 展開される関数（R1: 型引数は region を含んでよい — コアに届くのは展開後の具体型）。
    /// Def として呼ぶジェネリックは loc-free・chan-free のまま（Lean の型引数 — R3 の後置代入まで）
    fn inferTs(self: *Desugarer, entry: FnEntry, explicit: ?*const ast.Expr, args: []const *ast.Expr, env: Env, tok: u32, inline_: bool) Error![]const *const Ty {
        const f = entry.decl;
        const binds = try self.a.alloc(?*const Ty, f.type_params.len);
        @memset(binds, null);
        if (explicit) |x| {
            if (f.type_params.len != 1) return self.fail(error.Malformed, tok, "explicit type arguments (only f[T](...) with one type parameter)");
            binds[0] = try self.tyOf(self.cur_pkg, try typeExprOfExpr(x) orelse return self.fail(error.Malformed, tok, "type argument"), tok, 32);
        }
        const ph = try self.tvarEnv(f.type_params, PH);
        if (args.len != f.params.len) return self.fail(error.Malformed, tok, "argument count");
        for (f.params, args) |p, arg| {
            const pat = try self.tyIn(entry.pkg, ph, p.type, tok);
            const act = self.computeTy(arg, env) orelse continue;
            if (!unifyTy(pat, act, binds)) return self.fail(error.Malformed, tok, "conflicting inferences for a type parameter");
        }
        const ts = try self.a.alloc(*const Ty, binds.len);
        for (binds, ts, 0..) |b, *t, i| {
            t.* = b orelse {
                const msg = try std.fmt.allocPrint(self.a, "cannot infer type parameter {s} of {s}; write {s}[{s}](...)", .{ f.type_params[i], f.name, f.name, f.type_params[i] });
                return self.fail(error.CoreFragment, tok, msg);
            };
            if (inline_) {
                if (!tyArgValueOk(t.*)) return self.fail(error.CoreFragment, tok, "a type argument must be a value type (no channels)");
            } else if (!tyArgOk(t.*)) return self.fail(error.CoreFragment, tok, "a type argument of a generic function called as a Def cannot contain regions or channels (V3-2; inline-expanded generics and generic structs may — R1)");
        }
        return ts;
    }

    /// ラムダの呼び出し点展開。本体から見えるのは定義時の env + 引数
    fn lambdaCall(self: *Desugarer, closure: *const Closure, args: []const *ast.Expr, tok: u32, env: Env, depth: u32) Error!*const CExpr {
        const lam = closure.lambda;
        if (args.len != lam.params.len) return self.fail(error.Malformed, tok, "argument count");
        var values: std.ArrayListUnmanaged(*const CExpr) = .empty;
        var body_env = closure.env;
        var fenv: std.ArrayListUnmanaged(FEntry) = .empty;
        try fenv.appendSlice(self.a, closure.env.fenv);
        // 期待される関数型の引数列（pair 鎖を剥がす）
        const wants = try self.a.alloc(?*const Ty, args.len);
        @memset(wants, null);
        if (closure.ft) |ft| {
            if (ft.* == .fn_) {
                var pt = ft.fn_.p;
                for (wants, 0..) |*w, i| {
                    if (i + 1 == wants.len) {
                        w.* = pt;
                    } else if (pt.* == .prod) {
                        w.* = pt.prod.l;
                        pt = pt.prod.r;
                    } else break;
                }
            }
        }
        var level = depth;
        for (lam.params, args, wants) |p, arg, want| {
            // 関数型の引数（ラムダ・閉包の名前・for 式）は閉包のまま束縛する（高階の展開 — V3-4 の Iter）
            if (isClosureArg(arg, env)) {
                try fenv.append(self.a, .{ .name = p.name, .closure = try self.closureArg(arg, want, env, tok) });
                continue;
            }
            // 引数型の検査は ann で Lean に返す（V3-5 ③。旧: desugar の照合 = language.md 25 節の過渡措置）
            const at = self.computeTy(arg, env);
            const ann_t: ?*const Ty = if (want) |w| try self.inlineArgTy(arg, w, env) else null;
            try values.append(self.a, if (ann_t) |t| try self.mk(.{ .ann = .{ .e = try self.coerceExpr(arg, want.?, env, level, tok), .t = t } }) else try self.expr(arg, env, level));
            body_env = try self.bind(body_env, .{
                .name = p.name,
                .level = level,
                .mutable = false,
                .decl = if (p.type) |t| self.declOfTypeExpr(closure.pkg, t) else self.declOfExpr(arg, env),
                .ty = want orelse at,
                .elem_decl = if (p.type) |t| self.elemDeclOfTypeExpr(closure.pkg, t) else self.elemDeclOfExpr(arg, env),
                .core_ty = ann_t,
            });
            level += 1;
        }
        body_env.fenv = fenv.items;
        const saved_tenv = self.tenv;
        self.tenv = closure.tenv;
        defer self.tenv = saved_tenv;
        // 本体はラムダ定義時の package 文脈で
        const saved_pkg = self.cur_pkg;
        self.cur_pkg = closure.pkg;
        defer self.cur_pkg = saved_pkg;
        var body: *const CExpr = undefined;
        // ラムダ本体の return は定義時の関数ラベルへ（非局所 return — language.md 8 節）。
        // break / continue は外側のループへ抜けない（codegen の loop_floors）
        const saved_ctl = self.saveCtl();
        defer self.restoreCtl(saved_ctl);
        self.ret_target = closure.ret_target;
        self.loop_floor = self.labels.items.len;
        if (lam.body.* == .block) {
            body = try self.scoped(lam.body.block.stmts, body_env, level, .{});
        } else {
            body = try self.expr(lam.body, body_env, level);
        }
        // 結果型も ann で Lean に返す（V3-5 ③）。期待関数型が分かるときだけ
        if (closure.ft) |ft| {
            if (ft.* == .fn_) body = try self.annAt(body, ft.fn_.r);
        }
        var i = values.items.len;
        while (i > 0) {
            i -= 1;
            body = try self.mk(.{ .let = .{ .e = values.items[i], .body = body } });
        }
        return body;
    }
};

/// 事前宣言の true / false（パターン位置でも束縛でなく定数として読む）
fn isBoolName(name: []const u8) bool {
    return std.mem.eql(u8, name, "true") or std.mem.eql(u8, name, "false");
}

/// 型引数として許される型（Lean の Ty.tyArgOk: regionsBelow 0 かつ chanFree）
/// 展開されるジェネリック・ジェネリック struct の型引数（R1）: チャネル・参照を含まない値の型。
/// slice / map / string は可（区別は codegen の tyArgValueOk と同じ）
fn tyArgValueOk(t: *const Ty) bool {
    return switch (t.*) {
        .int, .bool_, .unit, .tvar, .fn_ => true,
        .opt => |x| tyArgValueOk(x),
        .union_ => |u| tyArgValueOk(u.l) and tyArgValueOk(u.r),
        .prod => |p| tyArgValueOk(p.l) and tyArgValueOk(p.r),
        .slice => |x| tyArgValueOk(x.t),
        .map => |x| tyArgValueOk(x.k) and tyArgValueOk(x.t),
        .ref, .chan => false,
    };
}

fn tyArgOk(t: *const Ty) bool {
    return switch (t.*) {
        .int, .bool_, .unit, .tvar, .fn_ => true,
        .opt => |x| tyArgOk(x),
        .union_ => |u| tyArgOk(u.l) and tyArgOk(u.r),
        .prod => |p| tyArgOk(p.l) and tyArgOk(p.r),
        .slice, .map, .ref, .chan => false,
    };
}

/// 推論の単一化: pat のプレースホルダ tvar（PH 以上）を act の対応部分に束縛する。
/// region 添字・mut は見ない（型引数は region を持たないので束縛に効かない）。衝突は false
fn unifyTy(pat: *const Ty, act: *const Ty, binds: []?*const Ty) bool {
    if (pat.* == .tvar and pat.tvar >= PH) {
        const k = pat.tvar - PH;
        if (k >= binds.len) return true;
        if (binds[k]) |b| return tyEqlLoose(b, act);
        binds[k] = act;
        return true;
    }
    if (std.meta.activeTag(pat.*) != std.meta.activeTag(act.*)) return true;
    return switch (pat.*) {
        .opt => |t| unifyTy(t, act.opt, binds),
        .union_ => |u| unifyTy(u.l, act.union_.l, binds) and unifyTy(u.r, act.union_.r, binds),
        .prod => |p| unifyTy(p.l, act.prod.l, binds) and unifyTy(p.r, act.prod.r, binds),
        .slice => |x| unifyTy(x.t, act.slice.t, binds),
        .map => |x| unifyTy(x.k, act.map.k, binds) and unifyTy(x.t, act.map.t, binds),
        .ref => |x| unifyTy(x.t, act.ref.t, binds),
        .chan => |x| unifyTy(x.t, act.chan.t, binds),
        .fn_ => |f| unifyTy(f.p, act.fn_.p, binds) and unifyTy(f.r, act.fn_.r, binds),
        else => true,
    };
}

/// 型引数どうしの一致（型引数は region を持たないので構造一致で足りる）
/// 型式が `error?` か（V4-4b）
fn isErrOptTE(te: ast.TypeExpr) bool {
    return te == .opt and te.opt.* == .name and std.mem.eql(u8, te.opt.name, "error");
}

/// ゼロ値を持つ型か（language.md 15 節 — zeroOf が組めるもの）
fn hasZero(t: *const Ty) bool {
    return switch (t.*) {
        .int, .bool_, .unit, .opt, .slice, .map => true,
        .prod => |p| hasZero(p.l) and hasZero(p.r),
        else => false,
    };
}

/// ゼロ値の構築が region に乗るか（slice / map を opt の外に含む）
/// 値ラッパ（opt / union / prod）越しに最上段の slice / map を持つか（R0 の戻り値座標の対象）
fn wrapsContainer(t: *const Ty) bool {
    return switch (t.*) {
        .slice, .map => true,
        .opt => |x| wrapsContainer(x),
        .union_ => |u| wrapsContainer(u.l) or wrapsContainer(u.r),
        .prod => |p| wrapsContainer(p.l) or wrapsContainer(p.r),
        else => false,
    };
}

fn hasRegion(t: *const Ty) bool {
    return switch (t.*) {
        .slice, .map => true,
        .prod => |p| hasRegion(p.l) or hasRegion(p.r),
        else => false,
    };
}

/// a を b へ緩められるか（Lean の Ty.sub の鏡: imm の slice / map / ref は region が a ≤ b、要素型は一致、値ラッパは分配）
/// 値が型注釈を持たない型（Lean の Ty.annFree と同じ — opt / union / 型変数を含まない。mut コンテナはセルが正確なので可）
fn tyAnnFree(t: *const Ty) bool {
    return switch (t.*) {
        .int, .bool_, .unit, .ref, .chan, .fn_ => true,
        .tvar, .opt, .union_ => false,
        .prod => |p| tyAnnFree(p.l) and tyAnnFree(p.r),
        .slice => |sl| sl.m or tyAnnFree(sl.t),
        .map => |mp| mp.m,
    };
}

/// k より深い region を指すか（Lean の noClamp の否定 — imm と mut の両方を見る）
fn tyRegionAbove(t: *const Ty, k: u32) bool {
    return switch (t.*) {
        .int, .bool_, .unit, .tvar, .fn_ => false,
        .chan => |c| c.rc > k + 1 or tyRegionAbove(c.t, k),
        .opt => |x| tyRegionAbove(x, k),
        .union_ => |u| tyRegionAbove(u.l, k) or tyRegionAbove(u.r, k),
        .prod => |p| tyRegionAbove(p.l, k) or tyRegionAbove(p.r, k),
        .slice => |sl| sl.r > k or tyRegionAbove(sl.t, k),
        .map => |mp| mp.r > k or tyRegionAbove(mp.k, k) or tyRegionAbove(mp.t, k),
        .ref => |rf| rf.r > k or tyRegionAbove(rf.t, k),
    };
}

fn tyLooser(a: *const Ty, b: *const Ty) bool {
    if (std.meta.activeTag(a.*) != std.meta.activeTag(b.*)) return false;
    return switch (a.*) {
        .opt => |t| tyLooser(t, b.opt),
        .union_ => |u| tyLooser(u.l, b.union_.l) and tyLooser(u.r, b.union_.r),
        .prod => |p| tyLooser(p.l, b.prod.l) and tyLooser(p.r, b.prod.r),
        // imm のセルは深く共変（R4b-cov — Lean の Ty.sub と同じ）。mut と ref は正確一致
        .slice => |x| !x.m and !b.slice.m and x.r <= b.slice.r and tyLooser(x.t, b.slice.t),
        .map => |x| !x.m and !b.map.m and x.r <= b.map.r and tyLooser(x.k, b.map.k) and tyLooser(x.t, b.map.t),
        .ref => |x| !x.m and !b.ref.m and x.r <= b.ref.r and Desugarer.tyEql(x.t, b.ref.t),
        else => Desugarer.tyEql(a, b),
    };
}

fn tyEqlLoose(a: *const Ty, b: *const Ty) bool {
    if (std.meta.activeTag(a.*) != std.meta.activeTag(b.*)) return false;
    return switch (a.*) {
        .int, .bool_, .unit => true,
        .tvar => |i| i == b.tvar,
        .opt => |t| tyEqlLoose(t, b.opt),
        .union_ => |u| tyEqlLoose(u.l, b.union_.l) and tyEqlLoose(u.r, b.union_.r),
        .prod => |p| tyEqlLoose(p.l, b.prod.l) and tyEqlLoose(p.r, b.prod.r),
        .fn_ => |f| tyEqlLoose(f.p, b.fn_.p) and tyEqlLoose(f.r, b.fn_.r),
        .slice => |x| x.m == b.slice.m and tyEqlLoose(x.t, b.slice.t),
        .map => |x| x.m == b.map.m and tyEqlLoose(x.k, b.map.k) and tyEqlLoose(x.t, b.map.t),
        .ref => |x| x.m == b.ref.m and tyEqlLoose(x.t, b.ref.t),
        .chan => |x| tyEqlLoose(x.t, b.chan.t),
    };
}

/// index 位置の式を型名として読む（`f[int]` / `f[pkg.T]`）。型名でなければ null
fn typeExprOfExpr(e: *const ast.Expr) std.mem.Allocator.Error!?ast.TypeExpr {
    return switch (e.*) {
        .ident => |id| .{ .name = id.name },
        else => null,
    };
}

/// std/ 配下の package か（std 専用の内部プリミティブ — bytesToString — の解決に使う）
fn isStdPkg(pkg: *const ast.Pkg) bool {
    return std.mem.startsWith(u8, pkg.path, "std/");
}

/// 辞書 const の式の中でのラムダの通し番号（struct リテラルの要素を前から — 記号名 `pkg.Const#K`）。
/// 入れ子のラムダ（ラムダ本体の中）は数えない — 見つからなければ 999
fn lambdaOrdinal(e: *const ast.Expr, lam: *const ast.Lambda) u32 {
    var n: u32 = 0;
    return if (walkLambdas(e, lam, &n)) n else 999;
}

fn walkLambdas(e: *const ast.Expr, lam: *const ast.Lambda, n: *u32) bool {
    switch (e.*) {
        .lambda => |*l| {
            if (l == lam) return true;
            n.* += 1;
            return false;
        },
        .composite => |c| {
            for (c.elems) |el| if (walkLambdas(el.value, lam, n)) return true;
            return false;
        },
        else => return false,
    }
}
