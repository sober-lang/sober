//! 独自 SSA IR（backend レーン — docs/design-dev.md「バックエンド戦略」）。
//!
//! -O0 形: スカラー（int / bool / タグ / 深度）は SSA 値、アグリゲートはフレームスロット（B-3〜）。φ はブロック引数。
//! 型は i64 と ptr の 2 つだけ（ptr は LLVM テキストが要求するから分ける。x86 ではどちらも語）。
//! 全 op は全域で定義された意味を持つ — div / rem はゼロ除算で panic（exit 101）、最小値 / -1 は Go と同じ結果。
//! IR に UB を持ち込まず、ガードは各バックエンドが吐く。region 演算は op のまま残す（最適化が enter / alloc / leave の対を見る層）。
//!
//! 規則: 値は一度だけ定義される（関数引数・ブロック引数・命令の結果）。入口ブロック（0）は前任を持たず引数も持たない。
//! 終端は 1 ブロックに 1 つ。condbr の 2 辺が同じブロックへ行くことは許す（バックエンドが中継で割る）。
//! ノードはすべて Module の arena に置く。
//! テキスト形式は print が正で、ir_parse.zig が読み戻す（往復不動点 print(parse(t)) == t — B-6。selfhost のコンポーネント境界）。
//! 値の番号は型表の添字そのまま、名前は必要なときだけ `@"..."` に引用する（printName）。
const std = @import("std");

pub const Ty = enum { i64, ptr };
pub const Value = u32;
pub const BlockId = u32;
pub const FuncId = u32;
pub const GlobalId = u32;
pub const SlotId = u32;

/// shl / sar の量は下位 6 bit だけを見る（x86 のカウントマスクと同じ — 全域で定義）。
/// 言語のシフト（負の量は panic・量 ≥ 64 の畳み込み）は lowering が明示の分岐で吐く
pub const BinOp = enum { add, sub, mul, div, rem, and_, or_, xor, shl, sar };
/// 比較。結果は i64 の 0 / 1。lt / le / gt / ge は符号つき、ult / uge は符号なし（境界検査 — 負の添字も 1 回で受ける）
pub const CmpOp = enum { eq, ne, lt, le, gt, ge, ult, uge };

pub const Op = union(enum) {
    iconst: i64,
    bin: struct { op: BinOp, a: Value, b: Value },
    cmp: struct { op: CmpOp, a: Value, b: Value },
    /// *(p + 8*off) を ty で読む
    load: struct { p: Value, off: i32, ty: Ty = .i64 },
    store: struct { p: Value, off: i32, v: Value },
    /// バイト単位（io の行バッファ・桁バッファ）。load8 はゼロ拡張
    load8: struct { p: Value, off: i32 },
    store8: struct { p: Value, off: i32, v: Value },
    /// p + idx * (8 | 1)（idx は i64 の値）
    gep: struct { p: Value, idx: Value, scale: enum { word, byte } },
    ptoi: Value,
    itop: Value,
    slotaddr: SlotId,
    globaladdr: GlobalId,
    /// 結果は callee の ret（無ければ res = null）
    call: struct { f: FuncId, args: []const Value },
    /// 関数 f のコードアドレス（i64 — 関数値は 1 語。slice ヘッダの ptr と同じく語で持つ）
    funcaddr: FuncId,
    /// 関数値 callee（funcaddr の i64）の間接呼び出し。署名は呼び手が持つ（結果型 ret、引数は args の型）
    call_indirect: struct { callee: Value, args: []const Value, ret: ?Ty },
    /// Linux x86_64 の syscall。args[0] が番号、以降最大 6 個。結果は rax
    syscall: []const Value,
    /// region を 1 段開く（深度 + 1、上限超過は exit 102）
    region_enter,
    /// 現在の深度（i64）
    region_depth,
    /// 深度を退避値に戻す（関数出口・脱出の region 巻き戻し）
    region_setdepth: Value,
    /// 深度 depth の region から words 語を取る（bump を前進。スロット末尾を超えたら exit 102）。結果は先頭（ptr）
    region_alloc: struct { depth: Value, words: Value },
    /// 深度 depth の region の bump 先端（ptr）。append / map の「先端なら 1 セル伸長」の判定に使う
    region_bump: Value,
    /// 戻り値の境界コピー: hdr（3 語ヘッダ (ptr, len, depth)）の depth が floor より深ければ、
    /// len * cellw 語を深度 floor の region へ写してヘッダを付け替える（codegen emitRelocateHeader と同じ）
    region_relocate: struct { hdr: Value, cellw: u32, floor: Value },
};

pub const Inst = struct { res: ?Value, op: Op };

pub const Edge = struct { to: BlockId, args: []const Value = &.{} };

pub const Term = union(enum) {
    /// 構築中（未終端）
    none,
    br: Edge,
    condbr: struct { c: Value, t: Edge, e: Edge },
    ret: ?Value,
    /// exit(code)。行バッファは flush しない（panic 101 / 102 と正常終了 0 の共通形 — 現行 codegen の観測を写す）
    exit: u8,
};

pub const Block = struct {
    params: std.ArrayListUnmanaged(Value) = .empty,
    insts: std.ArrayListUnmanaged(Inst) = .empty,
    term: Term = .none,
    preds: u32 = 0,
};

pub const Func = struct {
    name: []const u8,
    params: []const Value = &.{},
    ret: ?Ty,
    /// 値の型（添字 = Value）
    tys: std.ArrayListUnmanaged(Ty) = .empty,
    blocks: std.ArrayListUnmanaged(Block) = .empty,
    /// フレームスロットの語数（添字 = SlotId）
    slots: std.ArrayListUnmanaged(u32) = .empty,
    /// 外から呼ばれる入口（LLVM では非 internal）
    exported: bool = false,
};

/// init が null なら 0 初期化の可変領域（.bss）、あれば読み取り専用の語列（rodata — 文字列リテラル）
pub const Global = struct { name: []const u8, words: u32, init: ?[]const i64 = null };

/// ランタイム（ir_rt.zig）が置く部品。region op の下ろし先
pub const Runtime = struct {
    meta: GlobalId = 0,
    region_enter: FuncId = 0,
    region_alloc: FuncId = 0,
    region_relocate: FuncId = 0,
};

pub const Module = struct {
    arena: std.heap.ArenaAllocator,
    funcs: std.ArrayListUnmanaged(*Func) = .empty,
    globals: std.ArrayListUnmanaged(Global) = .empty,
    rt: Runtime = .{},

    pub fn init(gpa: std.mem.Allocator) Module {
        return .{ .arena = std.heap.ArenaAllocator.init(gpa) };
    }

    pub fn deinit(self: *Module) void {
        self.arena.deinit();
    }

    pub fn alloc(self: *Module) std.mem.Allocator {
        return self.arena.allocator();
    }

    /// 本体の無い関数を足す（本体は Builder で後から組む — 前方参照の call に使う）
    pub fn addFunc(self: *Module, name: []const u8, param_tys: []const Ty, ret: ?Ty) !FuncId {
        const a = self.alloc();
        const f = try a.create(Func);
        f.* = .{ .name = try a.dupe(u8, name), .ret = ret };
        const ps = try a.alloc(Value, param_tys.len);
        for (param_tys, ps) |t, *p| {
            p.* = @intCast(f.tys.items.len);
            try f.tys.append(a, t);
        }
        f.params = ps;
        try self.funcs.append(a, f);
        return @intCast(self.funcs.items.len - 1);
    }

    pub fn addGlobal(self: *Module, name: []const u8, words: u32) !GlobalId {
        try self.globals.append(self.alloc(), .{ .name = name, .words = words });
        return @intCast(self.globals.items.len - 1);
    }

    /// 読み取り専用の語列（名前は呼び手が一意にする）
    pub fn addRodata(self: *Module, name: []const u8, ws: []const i64) !GlobalId {
        const a = self.alloc();
        try self.globals.append(a, .{ .name = try a.dupe(u8, name), .words = @intCast(ws.len), .init = try a.dupe(i64, ws) });
        return @intCast(self.globals.items.len - 1);
    }
};

/// 1 関数の本体を組む。cur = null は「到達しない」（終端の直後）で、命令を足してはいけない
pub const Builder = struct {
    m: *Module,
    f: *Func,
    cur: ?BlockId = null,

    /// 入口ブロックを作って cur にする
    pub fn begin(m: *Module, id: FuncId) !Builder {
        var b: Builder = .{ .m = m, .f = m.funcs.items[id] };
        b.cur = try b.newBlock();
        return b;
    }

    pub fn newBlock(self: *Builder) !BlockId {
        try self.f.blocks.append(self.m.alloc(), .{});
        return @intCast(self.f.blocks.items.len - 1);
    }

    pub fn block(self: *Builder, id: BlockId) *Block {
        return &self.f.blocks.items[id];
    }

    pub fn param(self: *Builder, blk: BlockId, t: Ty) !Value {
        const v = try self.newValue(t);
        try self.block(blk).params.append(self.m.alloc(), v);
        return v;
    }

    pub fn newSlot(self: *Builder, words: u32) !SlotId {
        try self.f.slots.append(self.m.alloc(), words);
        return @intCast(self.f.slots.items.len - 1);
    }

    fn newValue(self: *Builder, t: Ty) !Value {
        try self.f.tys.append(self.m.alloc(), t);
        return @intCast(self.f.tys.items.len - 1);
    }

    pub fn tyOf(self: *const Builder, v: Value) Ty {
        return self.f.tys.items[v];
    }

    fn push(self: *Builder, res_ty: ?Ty, op: Op) !?Value {
        const blk = self.cur.?;
        std.debug.assert(self.block(blk).term == .none);
        const res: ?Value = if (res_ty) |t| try self.newValue(t) else null;
        try self.block(blk).insts.append(self.m.alloc(), .{ .res = res, .op = op });
        return res;
    }

    fn value(self: *Builder, t: Ty, op: Op) !Value {
        return (try self.push(t, op)).?;
    }

    pub fn iconst(self: *Builder, n: i64) !Value {
        return self.value(.i64, .{ .iconst = n });
    }
    pub fn bin(self: *Builder, op: BinOp, a: Value, b: Value) !Value {
        return self.value(.i64, .{ .bin = .{ .op = op, .a = a, .b = b } });
    }
    pub fn cmp(self: *Builder, op: CmpOp, a: Value, b: Value) !Value {
        return self.value(.i64, .{ .cmp = .{ .op = op, .a = a, .b = b } });
    }
    pub fn load(self: *Builder, p: Value, off: i32) !Value {
        return self.value(.i64, .{ .load = .{ .p = p, .off = off } });
    }
    pub fn store(self: *Builder, p: Value, off: i32, v: Value) !void {
        _ = try self.push(null, .{ .store = .{ .p = p, .off = off, .v = v } });
    }
    pub fn load8(self: *Builder, p: Value, off: i32) !Value {
        return self.value(.i64, .{ .load8 = .{ .p = p, .off = off } });
    }
    pub fn store8(self: *Builder, p: Value, off: i32, v: Value) !void {
        _ = try self.push(null, .{ .store8 = .{ .p = p, .off = off, .v = v } });
    }
    pub fn gepWord(self: *Builder, p: Value, idx: Value) !Value {
        return self.value(.ptr, .{ .gep = .{ .p = p, .idx = idx, .scale = .word } });
    }
    pub fn gepByte(self: *Builder, p: Value, idx: Value) !Value {
        return self.value(.ptr, .{ .gep = .{ .p = p, .idx = idx, .scale = .byte } });
    }
    pub fn ptoi(self: *Builder, p: Value) !Value {
        return self.value(.i64, .{ .ptoi = p });
    }
    pub fn itop(self: *Builder, v: Value) !Value {
        return self.value(.ptr, .{ .itop = v });
    }
    pub fn slotaddr(self: *Builder, s: SlotId) !Value {
        return self.value(.ptr, .{ .slotaddr = s });
    }
    pub fn globaladdr(self: *Builder, g: GlobalId) !Value {
        return self.value(.ptr, .{ .globaladdr = g });
    }
    pub fn call(self: *Builder, f: FuncId, args: []const Value) !?Value {
        return self.push(self.m.funcs.items[f].ret, .{ .call = .{ .f = f, .args = try self.m.alloc().dupe(Value, args) } });
    }
    pub fn funcaddr(self: *Builder, f: FuncId) !Value {
        return self.value(.i64, .{ .funcaddr = f });
    }
    pub fn callIndirect(self: *Builder, callee: Value, args: []const Value, ret_ty: ?Ty) !?Value {
        return self.push(ret_ty, .{ .call_indirect = .{ .callee = callee, .args = try self.m.alloc().dupe(Value, args), .ret = ret_ty } });
    }
    pub fn syscall(self: *Builder, args: []const Value) !Value {
        std.debug.assert(args.len >= 1 and args.len <= 7);
        return self.value(.i64, .{ .syscall = try self.m.alloc().dupe(Value, args) });
    }
    pub fn regionEnter(self: *Builder) !void {
        _ = try self.push(null, .region_enter);
    }
    pub fn regionDepth(self: *Builder) !Value {
        return self.value(.i64, .region_depth);
    }
    pub fn regionSetDepth(self: *Builder, v: Value) !void {
        _ = try self.push(null, .{ .region_setdepth = v });
    }
    pub fn regionAlloc(self: *Builder, depth: Value, words: Value) !Value {
        return self.value(.ptr, .{ .region_alloc = .{ .depth = depth, .words = words } });
    }
    pub fn regionBump(self: *Builder, depth: Value) !Value {
        return self.value(.ptr, .{ .region_bump = depth });
    }
    pub fn regionRelocate(self: *Builder, hdr: Value, cellw: u32, floor: Value) !void {
        _ = try self.push(null, .{ .region_relocate = .{ .hdr = hdr, .cellw = cellw, .floor = floor } });
    }

    // ── 試し生成の巻き戻し（型だけを取るための生成 — lower の for 式の型推論）──

    pub const Mark = struct {
        cur: ?BlockId,
        tys: usize,
        slots: usize,
        /// 既存ブロックの命令数・引数の数・終端・前任数
        blocks: []const struct { insts: usize, params: usize, term: Term, preds: u32 },
    };

    /// 現在の関数の状態を記録する（rollback で戻す）。Builder は追記しかしないので、長さと既存ブロックの終端・前任数で足りる
    pub fn mark(self: *Builder) !Mark {
        const bs = self.f.blocks.items;
        const out = try self.m.alloc().alloc(@typeInfo(@FieldType(Mark, "blocks")).pointer.child, bs.len);
        for (bs, out) |blk, *o| o.* = .{ .insts = blk.insts.items.len, .params = blk.params.items.len, .term = blk.term, .preds = blk.preds };
        return .{ .cur = self.cur, .tys = self.f.tys.items.len, .slots = self.f.slots.items.len, .blocks = out };
    }

    pub fn rollback(self: *Builder, mk: Mark) void {
        self.f.blocks.shrinkRetainingCapacity(mk.blocks.len);
        for (self.f.blocks.items, mk.blocks) |*blk, o| {
            blk.insts.shrinkRetainingCapacity(o.insts);
            blk.params.shrinkRetainingCapacity(o.params);
            blk.term = o.term;
            blk.preds = o.preds;
        }
        self.f.tys.shrinkRetainingCapacity(mk.tys);
        self.f.slots.shrinkRetainingCapacity(mk.slots);
        self.cur = mk.cur;
    }

    // ── 終端（cur を null にする）──

    fn terminate(self: *Builder, t: Term) void {
        const blk = self.block(self.cur.?);
        std.debug.assert(blk.term == .none);
        blk.term = t;
        self.cur = null;
    }

    fn edge(self: *Builder, to: BlockId, args: []const Value) !Edge {
        std.debug.assert(to != 0);
        std.debug.assert(args.len == self.block(to).params.items.len);
        self.block(to).preds += 1;
        return .{ .to = to, .args = try self.m.alloc().dupe(Value, args) };
    }

    pub fn br(self: *Builder, to: BlockId, args: []const Value) !void {
        self.terminate(.{ .br = try self.edge(to, args) });
    }
    pub fn condbr(self: *Builder, c: Value, t: BlockId, t_args: []const Value, e: BlockId, e_args: []const Value) !void {
        self.terminate(.{ .condbr = .{ .c = c, .t = try self.edge(t, t_args), .e = try self.edge(e, e_args) } });
    }
    pub fn ret(self: *Builder, v: ?Value) void {
        std.debug.assert((v == null) == (self.f.ret == null));
        self.terminate(.{ .ret = v });
    }
    pub fn exit(self: *Builder, code: u8) void {
        self.terminate(.{ .exit = code });
    }
};

// ── テキスト形式（デバッグと golden テスト用。パーサは B-6）──

pub fn print(m: *const Module, w: *std.Io.Writer) std.Io.Writer.Error!void {
    for (m.globals.items) |g| {
        try w.writeAll("global ");
        try printName(g.name, w);
        try w.print(" [{d}]", .{g.words});
        if (g.init) |ws| {
            try w.writeAll(" = {");
            for (ws, 0..) |x, i| try w.print("{s}{d}", .{ if (i > 0) ", " else "", x });
            try w.writeAll("}");
        }
        try w.writeAll("\n");
    }
    for (m.funcs.items) |f| {
        try w.writeAll(if (f.exported) "\nexport func " else "\nfunc ");
        try printName(f.name, w);
        try w.writeAll("(");
        for (f.params, 0..) |p, i| {
            if (i > 0) try w.writeAll(", ");
            try w.print("%{d} {s}", .{ p, @tagName(f.tys.items[p]) });
        }
        try w.writeAll(")");
        if (f.ret) |t| try w.print(" {s}", .{@tagName(t)});
        try w.writeAll(" {\n");
        for (f.slots.items, 0..) |words, i| try w.print("  slot s{d} [{d}]\n", .{ i, words });
        for (f.blocks.items, 0..) |b, bi| {
            try w.print("b{d}", .{bi});
            if (b.params.items.len > 0) {
                try w.writeAll("(");
                for (b.params.items, 0..) |p, i| {
                    if (i > 0) try w.writeAll(", ");
                    try w.print("%{d} {s}", .{ p, @tagName(f.tys.items[p]) });
                }
                try w.writeAll(")");
            }
            try w.writeAll(":\n");
            for (b.insts.items) |inst| {
                try w.writeAll("  ");
                if (inst.res) |r| try w.print("%{d} = ", .{r});
                try printOp(m, inst.op, w);
                try w.writeAll("\n");
            }
            try w.writeAll("  ");
            try printTerm(b.term, w);
            try w.writeAll("\n");
        }
        try w.writeAll("}\n");
    }
}

/// 名前の文字（これ以外を含む名前は `@"..."` に引用する — ジェネリクスの単相コピーの名前は `[` `,` `(` `@` を含む）
pub fn isNameChar(c: u8) bool {
    return std.ascii.isAlphanumeric(c) or c == '_' or c == '.' or c == '#' or c == '/' or c == '$';
}

pub fn printName(name: []const u8, w: *std.Io.Writer) !void {
    const bare = name.len > 0 and for (name) |c| {
        if (!isNameChar(c)) break false;
    } else true;
    if (bare) return w.print("@{s}", .{name});
    try w.writeAll("@\"");
    for (name) |c| {
        if (c == '"' or c == '\\') try w.writeByte('\\');
        try w.writeByte(c);
    }
    try w.writeAll("\"");
}

fn printVals(vs: []const Value, w: *std.Io.Writer) !void {
    for (vs, 0..) |v, i| {
        if (i > 0) try w.writeAll(", ");
        try w.print("%{d}", .{v});
    }
}

fn printOp(m: *const Module, op: Op, w: *std.Io.Writer) !void {
    switch (op) {
        .iconst => |n| try w.print("const {d}", .{n}),
        .bin => |b| try w.print("{s} %{d}, %{d}", .{ @tagName(b.op), b.a, b.b }),
        .cmp => |c| try w.print("{s} %{d}, %{d}", .{ @tagName(c.op), c.a, c.b }),
        .load => |l| try w.print("load.{s} %{d}[{d}]", .{ @tagName(l.ty), l.p, l.off }),
        .store => |s| try w.print("store %{d}[{d}], %{d}", .{ s.p, s.off, s.v }),
        .load8 => |l| try w.print("load8 %{d}[{d}]", .{ l.p, l.off }),
        .store8 => |s| try w.print("store8 %{d}[{d}], %{d}", .{ s.p, s.off, s.v }),
        .gep => |g| try w.print("gep.{s} %{d}, %{d}", .{ @tagName(g.scale), g.p, g.idx }),
        .ptoi => |v| try w.print("ptoi %{d}", .{v}),
        .itop => |v| try w.print("itop %{d}", .{v}),
        .slotaddr => |s| try w.print("slotaddr s{d}", .{s}),
        .globaladdr => |g| {
            try w.writeAll("globaladdr ");
            try printName(m.globals.items[g].name, w);
        },
        .call => |c| {
            try w.writeAll("call ");
            try printName(m.funcs.items[c.f].name, w);
            try w.writeAll("(");
            try printVals(c.args, w);
            try w.writeAll(")");
        },
        .funcaddr => |f| {
            try w.writeAll("funcaddr ");
            try printName(m.funcs.items[f].name, w);
        },
        // 結果の型は callee の署名から引けないので op に書く（値なしは接尾辞なし）
        .call_indirect => |c| {
            try w.writeAll("call.indirect");
            if (c.ret) |t| try w.print(".{s}", .{@tagName(t)});
            try w.print(" %{d}(", .{c.callee});
            try printVals(c.args, w);
            try w.writeAll(")");
        },
        .syscall => |args| {
            try w.writeAll("syscall(");
            try printVals(args, w);
            try w.writeAll(")");
        },
        .region_enter => try w.writeAll("region.enter"),
        .region_depth => try w.writeAll("region.depth"),
        .region_setdepth => |v| try w.print("region.setdepth %{d}", .{v}),
        .region_alloc => |r| try w.print("region.alloc %{d}, %{d}", .{ r.depth, r.words }),
        .region_bump => |d| try w.print("region.bump %{d}", .{d}),
        .region_relocate => |r| try w.print("region.relocate %{d}, {d}, %{d}", .{ r.hdr, r.cellw, r.floor }),
    }
}

fn printEdge(e: Edge, w: *std.Io.Writer) !void {
    try w.print("b{d}", .{e.to});
    if (e.args.len > 0) {
        try w.writeAll("(");
        try printVals(e.args, w);
        try w.writeAll(")");
    }
}

fn printTerm(t: Term, w: *std.Io.Writer) !void {
    switch (t) {
        .none => try w.writeAll("<unterminated>"),
        .br => |e| {
            try w.writeAll("br ");
            try printEdge(e, w);
        },
        .condbr => |c| {
            try w.print("condbr %{d}, ", .{c.c});
            try printEdge(c.t, w);
            try w.writeAll(", ");
            try printEdge(c.e, w);
        },
        .ret => |v| if (v) |x| try w.print("ret %{d}", .{x}) else try w.writeAll("ret"),
        .exit => |c| try w.print("exit {d}", .{c}),
    }
}

/// 検査（テストとバックエンドの入口で使う）: 構造・オペランドの型・定義が使用を支配すること（ir_verify.zig — B-7）
pub fn verify(m: *const Module) error{InvalidIr}!void {
    return @import("ir_verify.zig").verify(m);
}
