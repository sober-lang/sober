//! lower のコンテナ: slice / string / map（codegen と同じメモリ形 — lower.zig 冒頭）。
//! ヘッダは 3 語 (ptr, len, 深度)。ptr は語として（ptoi して）置き、読むときに itop する。
//! セルは region アリーナに置き、割り当ては region.alloc / region.bump の op で吐く（最適化が region の対を見る層 — backend-drafts）。
//! 文字列リテラルは rodata（1 文字 1 語）で、深度 0（最外 region）の imm セルとして扱う（codegen .strlit と同じ）。
//! 成長（append / map の挿入）は codegen appendCall / emitMapSet と同じ規則: mut は「ヘッダの region の先端なら 1 セル伸長、
//! 他は同じ region へ全コピー」、imm は「現在の最内 region へ常に全コピー」。
const std = @import("std");
const ast = @import("ast.zig");
const ir = @import("ir.zig");
const ir_rt = @import("ir_rt.zig");
const lower = @import("lower.zig");
const types = @import("lower_types.zig");
const Lowerer = lower.Lowerer;
const Error = lower.Error;
const Val = lower.Val;
const Results = lower.Results;
const ArgSrc = lower.ArgSrc;
const never_results = lower.never_results;
const Type = types.Type;
const MapInfo = types.MapInfo;
const OptInfo = types.OptInfo;

fn hdrPtr(self: *Lowerer, h: ir.Value) Error!ir.Value {
    return self.b.itop(try self.b.load(h, 0));
}

fn newHeader(self: *Lowerer, t: Type, p: ir.Value, len: ir.Value, depth: ir.Value) Error!Val {
    const h = try self.newAgg(t);
    try self.b.store(h, 0, try self.b.ptoi(p));
    try self.b.store(h, 1, len);
    try self.b.store(h, 2, depth);
    return .{ .t = t, .v = h };
}

/// p + i 語
fn cellAt(self: *Lowerer, p: ir.Value, i: ir.Value, cellw: u32) Error!ir.Value {
    return self.b.gepWord(p, try self.b.bin(.mul, i, try self.b.iconst(cellw)));
}

/// c が 0 でなければ exit 101（範囲外 — language.md 27 節）
fn panicIf(self: *Lowerer, c: ir.Value) Error!void {
    const bad = try self.b.newBlock();
    const ok = try self.b.newBlock();
    try self.b.condbr(c, bad, &.{}, ok, &.{});
    self.b.cur = bad;
    self.b.exit(101);
    self.b.cur = ok;
}

pub fn strlit(self: *Lowerer, s: []const u8) Error!Val {
    const g = self.strs.get(s) orelse blk: {
        const ws = try self.a().alloc(i64, s.len);
        for (s, ws) |ch, *w| w.* = ch;
        const name = try std.fmt.allocPrint(self.a(), "str.{d}", .{self.strs.count()});
        const g = try self.m.addRodata(name, ws);
        try self.strs.put(self.gpa, s, g);
        break :blk g;
    };
    return newHeader(self, types.string_t, try self.b.globaladdr(g), try self.b.iconst(@intCast(s.len)), try self.b.iconst(0));
}

/// `[]T{e, ...}`: 要素を全部評価してから、現在の深度の先端へまとめて書く（codegen .slicelit）
pub fn slicelit(self: *Lowerer, sl: ast.SliceLit) Error!Val {
    const elem = try self.resolveType(sl.elem, sl.tok);
    if (elem.words() == 0) return self.fail(error.Unsupported, sl.tok, "slice element type");
    const vals = try self.a().alloc(Val, sl.elems.len);
    for (sl.elems, vals) |e, *v| {
        v.* = try self.exprExpecting(e, elem, e.tok());
        if (v.t == .never) return v.*;
        v.* = try self.copyVal(v.*);
    }
    const cellw = elem.words();
    const d = try self.b.regionDepth();
    const p = try self.b.regionAlloc(d, try self.b.iconst(@intCast(cellw * vals.len)));
    for (vals, 0..) |v, i| try self.storeVal(p, @intCast(cellw * i), v);
    return newHeader(self, try types.mkSlice(self, elem, sl.mut), p, try self.b.iconst(@intCast(vals.len)), d);
}

/// 空のヘッダ（現在の深度の先端・長さ 0）。map リテラルの始まりと `T{}` の slice / map フィールド（codegen zeroFill）
fn emptyAt(self: *Lowerer, p: ir.Value) Error!void {
    const d = try self.b.regionDepth();
    try self.b.store(p, 0, try self.b.ptoi(try self.b.regionBump(d)));
    try self.b.store(p, 1, try self.b.iconst(0));
    try self.b.store(p, 2, d);
}

/// `T{}` の slice / map フィールド（入れ子の struct も）を空ヘッダにする。他のフィールドは呼び手が 0 で埋めてある
pub fn zeroFill(self: *Lowerer, p: ir.Value, off: u32, t: Type) Error!void {
    switch (t) {
        .slice_, .map_ => try emptyAt(self, try self.fieldPtr(p, off)),
        .struct_ => |s| for (s.fields) |f| try zeroFill(self, p, off + f.offset, f.t),
        else => {},
    }
}

/// `map[K]V{k: v, ...}`: 空ヘッダからエントリごとに set（重複キーは後勝ち — codegen .maplit）
pub fn maplit(self: *Lowerer, ml: ast.MapLit) Error!Val {
    const k = try self.resolveType(ml.key, ml.tok);
    if (k != .int and !k.isString()) return self.fail(error.Unsupported, ml.tok, "map key type must be int or string");
    const value = try self.resolveType(ml.value, ml.tok);
    if (value.words() == 0) return self.fail(error.Unsupported, ml.tok, "map value type");
    const t = try types.mkMap(self, k, value, ml.mut);
    const h = try self.newAgg(t);
    try emptyAt(self, h);
    for (ml.entries) |en| {
        const kp = try keyPtr(self, try self.expr(en.key), t.map_, ml.tok) orelse return Val.never;
        const v = try self.exprExpecting(en.value, value, en.value.tok());
        if (v.t == .never) return v;
        try mapSet(self, h, kp, try self.copyVal(v), t.map_);
    }
    return .{ .t = t, .v = h };
}

/// キーの置き場（int は 1 語のスロット、string はヘッダのコピー）。到達しなければ null
fn keyPtr(self: *Lowerer, kv: Val, mi: *const MapInfo, tok: ast.Pos) Error!?ir.Value {
    if (kv.t == .never) return null;
    if (!kv.t.eql(mi.key)) return self.fail(error.TypeMismatch, tok, "map key type");
    if (kv.t == .int) {
        const p = try self.b.slotaddr(try self.b.newSlot(1));
        try self.b.store(p, 0, kv.v);
        return p;
    }
    return (try self.copyVal(kv)).v;
}

/// 一致するセルのアドレス（i64、不在は 0）
fn mapFind(self: *Lowerer, h: ir.Value, kp: ir.Value, mi: *const MapInfo) Error!ir.Value {
    return (try self.b.call(self.rt.map_find, &.{ h, kp, try self.b.iconst(mi.cellWords()), try self.b.iconst(@intFromBool(mi.key.isString())) })).?;
}

const Grown = struct { ptr: ir.Value, dst: ir.Value };

/// ヘッダ h のセル列を 1 セル伸ばす先を取る。tip なら「深度 d の先端に接していれば 1 セル伸長」、
/// それ以外は深度 d へ len + 1 セルを取って全コピー。ptr = 新しいセル列、dst = 新しいセルの位置
fn grow(self: *Lowerer, h: ir.Value, cellw: u32, d: ir.Value, tip: bool) Error!Grown {
    const base = try self.b.load(h, 0);
    const len = try self.b.load(h, 1);
    const join = try self.b.newBlock();
    const np = try self.b.param(join, .ptr);
    const dst = try self.b.param(join, .ptr);
    const copy_b = try self.b.newBlock();
    if (tip) {
        const end = try self.b.bin(.add, base, try self.b.bin(.mul, len, try self.b.iconst(8 * cellw)));
        const tip_b = try self.b.newBlock();
        try self.b.condbr(try self.b.cmp(.eq, try self.b.ptoi(try self.b.regionBump(d)), end), tip_b, &.{}, copy_b, &.{});
        self.b.cur = tip_b;
        const cell = try self.b.regionAlloc(d, try self.b.iconst(cellw));
        try self.b.br(join, &.{ try self.b.itop(base), cell });
    } else try self.b.br(copy_b, &.{});
    self.b.cur = copy_b;
    const n = try self.b.bin(.mul, len, try self.b.iconst(cellw));
    const p = try self.b.regionAlloc(d, try self.b.bin(.add, n, try self.b.iconst(cellw)));
    _ = try self.b.call(self.rt.copy, &.{ p, try self.b.itop(base), n });
    try self.b.br(join, &.{ p, try self.b.gepWord(p, n) });
    self.b.cur = join;
    return .{ .ptr = np, .dst = dst };
}

/// error の鎖に内側の error を積む（K1'' の包み替え）: dst_chain ← append(内側の鎖, 内側の先頭)。
/// 内側の error は src + src_off 語（先頭ラベル lt、その後に鎖のヘッダ）。imm の append なので最内 region へ全コピー + 1 セル
pub fn chainPush(self: *Lowerer, dst_chain: ir.Value, src: ir.Value, src_off: u32, lt: Type) Error!void {
    const inner = try self.fieldPtr(src, src_off);
    const inner_chain = try self.fieldPtr(inner, lt.words());
    const d = try self.b.regionDepth();
    const g = try grow(self, inner_chain, lt.words(), d, false);
    try self.storeVal(g.dst, 0, .{ .t = lt, .v = inner });
    try self.b.store(dst_chain, 0, try self.b.ptoi(g.ptr));
    try self.b.store(dst_chain, 1, try self.b.bin(.add, try self.b.load(inner_chain, 1), try self.b.iconst(1)));
    try self.b.store(dst_chain, 2, d);
}

/// error の cause（K1''）: e（error の値のアドレス）の 1 つ内側の error?。鎖が空なら nil、
/// でなければ (鎖の末尾, 鎖の [0 : len-1])（部分列はビュー — 同じセル・同じ深度）
pub fn causeOf(self: *Lowerer, e: ir.Value, et: Type, lt: Type) Error!Val {
    const ot = try types.optOf(self, et);
    const out = try self.newAgg(ot);
    const chain = try self.fieldPtr(e, lt.words());
    const len = try self.b.load(chain, 1);
    const some = try self.b.newBlock();
    const none = try self.b.newBlock();
    const join = try self.b.newBlock();
    try self.b.condbr(try self.b.cmp(.ne, len, try self.b.iconst(0)), some, &.{}, none, &.{});
    self.b.cur = none;
    try self.b.store(out, 0, try self.b.iconst(0));
    try self.b.br(join, &.{});
    self.b.cur = some;
    try self.b.store(out, 0, try self.b.iconst(1));
    const n1 = try self.b.bin(.sub, len, try self.b.iconst(1));
    const last = try cellAt(self, try self.b.itop(try self.b.load(chain, 0)), n1, lt.words());
    try self.storeVal(out, 1, .{ .t = lt, .v = last });
    const oc = try self.fieldPtr(out, 1 + lt.words());
    try self.b.store(oc, 0, try self.b.load(chain, 0));
    try self.b.store(oc, 1, n1);
    try self.b.store(oc, 2, try self.b.load(chain, 2));
    try self.b.br(join, &.{});
    self.b.cur = join;
    return .{ .t = ot, .v = out };
}

/// map の set: 既存キー（墓石も）はその場で tag = 1 と値を書く。新規は成長してセルを足し、ヘッダ h を書き戻す（codegen emitMapSet）
fn mapSet(self: *Lowerer, h: ir.Value, kp: ir.Value, v: Val, mi: *const MapInfo) Error!void {
    const c = try mapFind(self, h, kp, mi);
    const upd = try self.b.newBlock();
    const ins = try self.b.newBlock();
    const done = try self.b.newBlock();
    const tag = mi.tagOff();
    try self.b.condbr(try self.b.cmp(.ne, c, try self.b.iconst(0)), upd, &.{}, ins, &.{});
    self.b.cur = upd;
    const cp = try self.b.itop(c);
    try self.b.store(cp, @intCast(tag), try self.b.iconst(1));
    try self.storeVal(cp, tag + 1, v);
    try self.b.br(done, &.{});
    self.b.cur = ins;
    const g = try grow(self, h, mi.cellWords(), try self.b.load(h, 2), true);
    for (0..mi.key.words()) |w| try self.b.store(g.dst, @intCast(w), try self.b.load(kp, @intCast(w)));
    try self.b.store(g.dst, @intCast(tag), try self.b.iconst(1));
    try self.storeVal(g.dst, tag + 1, v);
    try self.b.store(h, 0, try self.b.ptoi(g.ptr));
    try self.b.store(h, 1, try self.b.bin(.add, try self.b.load(h, 1), try self.b.iconst(1)));
    try self.b.br(done, &.{});
    self.b.cur = done;
}

/// `xs[i]`（符号なしの境界検査 1 本 — 負も範囲外）/ `m[k]`（V? — 不在は nil）
pub fn index(self: *Lowerer, ix: ast.Index) Error!Val {
    const base = try self.expr(ix.base);
    if (base.t == .never) return base;
    if (base.t == .map_) {
        const mi = base.t.map_;
        const kp = try keyPtr(self, try self.expr(ix.idx), mi, ix.tok) orelse return Val.never;
        const c = try mapFind(self, base.v, kp, mi);
        const o = try self.a().create(OptInfo);
        o.* = .{ .payload = mi.value, .words = 1 + mi.value.words() };
        const ot: Type = .{ .opt = o };
        const r = try self.newAgg(ot);
        const hit = try self.b.newBlock();
        const miss = try self.b.newBlock();
        const done = try self.b.newBlock();
        try self.b.condbr(try self.b.cmp(.ne, c, try self.b.iconst(0)), hit, &.{}, miss, &.{});
        self.b.cur = hit;
        // [tag][value] をそのまま写す（墓石はタグ 0 = nil）
        const cp = try self.b.itop(c);
        for (0..o.words) |w| try self.b.store(r, @intCast(w), try self.b.load(cp, @intCast(mi.tagOff() + w)));
        try self.b.br(done, &.{});
        self.b.cur = miss;
        try self.b.store(r, 0, try self.b.iconst(0));
        try self.b.br(done, &.{});
        self.b.cur = done;
        return .{ .t = ot, .v = r };
    }
    const si = try sliceOf(self, base.t, ix.tok, "indexing");
    const i = try self.expr(ix.idx);
    if (i.t == .never) return i;
    try self.want(i, .int, ix.tok);
    try panicIf(self, try self.b.cmp(.uge, i.v, try self.b.load(base.v, 1)));
    return self.loadVal(try cellAt(self, try hdrPtr(self, base.v), i.v, si.elem.words()), 0, si.elem);
}

fn sliceOf(self: *Lowerer, t: Type, tok: ast.Pos, what: []const u8) Error!*const types.SliceInfo {
    if (t.isString()) return self.fail(error.TypeMismatch, tok, "string has no indexing or slicing; name the view (bytes(s))");
    if (t != .slice_) return self.fail(error.TypeMismatch, tok, what);
    return t.slice_;
}

/// `xs[a:b]`（imm 限定）: 同じセル列を指す新ヘッダ。0 ≤ a ≤ b ≤ len でなければ panic（codegen .slice3）
pub fn slice3(self: *Lowerer, s3: ast.Slice3) Error!Val {
    const base = try self.expr(s3.base);
    if (base.t == .never) return base;
    const si = try sliceOf(self, base.t, s3.tok, "slicing a non-slice value");
    if (si.mut) return self.fail(error.Immutable, s3.tok, "slicing a mut slice (imm only)");
    const lo = try self.expr(s3.lo);
    if (lo.t == .never) return lo;
    try self.want(lo, .int, s3.tok);
    const hi = try self.expr(s3.hi);
    if (hi.t == .never) return hi;
    try self.want(hi, .int, s3.tok);
    try panicIf(self, try self.b.cmp(.lt, lo.v, try self.b.iconst(0)));
    try panicIf(self, try self.b.cmp(.lt, hi.v, lo.v));
    try panicIf(self, try self.b.cmp(.gt, hi.v, try self.b.load(base.v, 1)));
    const p = try cellAt(self, try hdrPtr(self, base.v), lo.v, si.elem.words());
    return newHeader(self, base.t, p, try self.b.bin(.sub, hi.v, lo.v), try self.b.load(base.v, 2));
}

/// string の == / != / +（左辺は評価済み）。連結は最内 region の先端へ両セル列を写す（codegen stringBinary）
pub fn stringBinary(self: *Lowerer, bin: ast.Binary, l: Val) Error!Val {
    const r = try self.expr(bin.rhs);
    if (r.t == .never) return r;
    if (!r.t.isString()) return self.fail(error.TypeMismatch, bin.tok, "string operator on a non-string value");
    if (bin.op == .plus) {
        const l1 = try self.b.load(l.v, 1);
        const l2 = try self.b.load(r.v, 1);
        const n = try self.b.bin(.add, l1, l2);
        const d = try self.b.regionDepth();
        const p = try self.b.regionAlloc(d, n);
        _ = try self.b.call(self.rt.copy, &.{ p, try hdrPtr(self, l.v), l1 });
        _ = try self.b.call(self.rt.copy, &.{ try self.b.gepWord(p, l1), try hdrPtr(self, r.v), l2 });
        return newHeader(self, l.t, p, n, d);
    }
    const eq = (try self.b.call(self.rt.str_eq, &.{ l.v, r.v })).?;
    return .{ .t = .bool_, .v = if (bin.op == .equal_equal) eq else try self.b.bin(.xor, eq, try self.b.iconst(1)) };
}

fn srcVal(self: *Lowerer, src: ArgSrc) Error!Val {
    return switch (src) {
        .expr => |e| self.expr(e),
        .val => |v| v,
    };
}

fn one(self: *Lowerer, v: Val) Error!Results {
    if (v.t == .never) return never_results;
    if (v.t == .none) return &.{};
    const out = try self.a().alloc(Val, 1);
    out[0] = v;
    return out;
}

/// 組み込み（len / bytes / freeze / delete / append、std 専用の bytesToString）。name が組み込みでなければ null
pub fn builtin(self: *Lowerer, name: []const u8, srcs: []const ArgSrc, tok: ast.Pos) Error!?Results {
    if (std.mem.startsWith(u8, self.cur_pkg.path, "std/")) if (try ioBuiltin(self, name, srcs, tok)) |r| return r;
    const Kind = enum { len, keys, bytes, freeze, delete, append, bytesToString };
    const k = std.meta.stringToEnum(Kind, name) orelse return null;
    if (k == .bytesToString and !std.mem.startsWith(u8, self.cur_pkg.path, "std/")) return null;
    const arity: usize = if (k == .delete or k == .append) 2 else 1;
    if (srcs.len != arity) return self.fail(error.ArityMismatch, tok, name);
    const x = try srcVal(self, srcs[0]);
    if (x.t == .never) return never_results;
    switch (k) {
        .len => {
            if (x.t == .map_) return try one(self, .{ .t = .int, .v = try mapLen(self, x.v, x.t.map_) });
            if (x.t.isString()) return self.fail(error.TypeMismatch, tok, "string has no len; name the view (len(bytes(s)))");
            if (x.t != .slice_) return self.fail(error.TypeMismatch, tok, "len of a non-slice value");
            return try one(self, .{ .t = .int, .v = try self.b.load(x.v, 1) });
        },
        .keys => {
            if (x.t != .map_) return self.fail(error.TypeMismatch, tok, "keys of a non-map value");
            return try one(self, try mapKeys(self, x.v, x.t.map_));
        },
        // 表現が同じなのでヘッダはそのまま、型だけ変える
        .bytes => {
            if (!x.t.isString()) return self.fail(error.TypeMismatch, tok, "bytes of a non-string value");
            return try one(self, .{ .t = try types.mkSlice(self, .int, false), .v = x.v });
        },
        .bytesToString => {
            if (x.t != .slice_ or x.t.isString() or x.t.slice_.elem != .int) return self.fail(error.TypeMismatch, tok, "bytesToString of a non-[]int value");
            return try one(self, .{ .t = types.string_t, .v = x.v });
        },
        .freeze => {
            const t: Type = switch (x.t) {
                .slice_ => |si| if (si.str) x.t else try types.mkSlice(self, si.elem, false),
                .map_ => |mi| try types.mkMap(self, mi.key, mi.value, false),
                else => return self.fail(error.TypeMismatch, tok, "freeze of a non-container value"),
            };
            return try one(self, .{ .t = t, .v = x.v });
        },
        // 墓石（tag = 0）をその場で書く。不在は何もしない
        .delete => {
            if (x.t != .map_) return self.fail(error.TypeMismatch, tok, "delete on a non-map value");
            const mi = x.t.map_;
            if (!mi.mut) return self.fail(error.Immutable, tok, "delete on an immutable map");
            const kp = try keyPtr(self, try srcVal(self, srcs[1]), mi, tok) orelse return never_results;
            const c = try mapFind(self, x.v, kp, mi);
            const hit = try self.b.newBlock();
            const done = try self.b.newBlock();
            try self.b.condbr(try self.b.cmp(.ne, c, try self.b.iconst(0)), hit, &.{}, done, &.{});
            self.b.cur = hit;
            try self.b.store(try self.b.itop(c), @intCast(mi.tagOff()), try self.b.iconst(0));
            try self.b.br(done, &.{});
            self.b.cur = done;
            return &.{};
        },
        .append => return try one(self, try append(self, x, srcs[1], tok)),
    }
}

/// std 専用の io 組み込み（codegen ioBuiltin）: sysReadFile(path) []int（1 バイト 1 語、失敗は空）・
/// sysWriteFile(path, []int) int（errno）・sysErrno() int（直前の sys* の errno）・
/// sysArgs() []int（argv の「バイト + 0」の連結）・sysReadDir(path) []int（「d_type + 名前のバイト + 0」の連結、失敗は空）・
/// sysWriteFd(fd, []int) int（開いている fd へ — errno）。本体は ir_rt_io のランタイム関数
fn ioBuiltin(self: *Lowerer, name: []const u8, srcs: []const ArgSrc, tok: ast.Pos) Error!?Results {
    const Kind = enum { sysReadFile, sysWriteFile, sysErrno, sysArgs, sysReadDir, sysWriteFd };
    const k = std.meta.stringToEnum(Kind, name) orelse return null;
    const arity: usize = switch (k) {
        .sysErrno, .sysArgs => 0,
        .sysReadFile, .sysReadDir => 1,
        .sysWriteFile, .sysWriteFd => 2,
    };
    if (srcs.len != arity) return self.fail(error.ArityMismatch, tok, name);
    if (k == .sysErrno) return try one(self, .{ .t = .int, .v = try self.b.load(try self.b.globaladdr(self.m.rt.meta), ir_rt.W_ERRNO) });
    if (k == .sysArgs) {
        const t = try types.mkSlice(self, .int, false);
        const out = try self.newAgg(t);
        _ = try self.b.call(self.rt.io.read_args, &.{out});
        return try one(self, .{ .t = t, .v = out });
    }
    if (k == .sysWriteFd) {
        const fd = try srcVal(self, srcs[0]);
        if (fd.t == .never) return never_results;
        if (fd.t != .int) return self.fail(error.TypeMismatch, tok, "sysWriteFd takes an int fd");
        const data = try srcVal(self, srcs[1]);
        if (data.t == .never) return never_results;
        if (data.t != .slice_ or data.t.isString() or data.t.slice_.elem != .int) return self.fail(error.TypeMismatch, tok, "sysWriteFd takes []int bytes");
        return try one(self, .{ .t = .int, .v = (try self.b.call(self.rt.io.write_fd, &.{ fd.v, data.v })).? });
    }
    const path = try srcVal(self, srcs[0]);
    if (path.t == .never) return never_results;
    if (!path.t.isString()) return self.fail(error.TypeMismatch, tok, "sys* takes a string path");
    if (k == .sysReadFile or k == .sysReadDir) {
        const t = try types.mkSlice(self, .int, false);
        const out = try self.newAgg(t);
        _ = try self.b.call(if (k == .sysReadFile) self.rt.io.read_file else self.rt.io.read_dir, &.{ path.v, out });
        return try one(self, .{ .t = t, .v = out });
    }
    const data = try srcVal(self, srcs[1]);
    if (data.t == .never) return never_results;
    if (data.t != .slice_ or data.t.isString() or data.t.slice_.elem != .int) return self.fail(error.TypeMismatch, tok, "sysWriteFile takes []int bytes");
    return try one(self, .{ .t = .int, .v = (try self.b.call(self.rt.io.write_file, &.{ path.v, data.v })).? });
}

/// 生きたエントリ（tag = 1）の数。墓石は数えない
fn mapLen(self: *Lowerer, h: ir.Value, mi: *const MapInfo) Error!ir.Value {
    const p = try hdrPtr(self, h);
    const n = try self.b.load(h, 1);
    const loop = try self.b.newBlock();
    const i = try self.b.param(loop, .i64);
    const acc = try self.b.param(loop, .i64);
    const body = try self.b.newBlock();
    const done = try self.b.newBlock();
    const res = try self.b.param(done, .i64);
    const zero = try self.b.iconst(0);
    try self.b.br(loop, &.{ zero, zero });
    self.b.cur = loop;
    try self.b.condbr(try self.b.cmp(.lt, i, n), body, &.{}, done, &.{acc});
    self.b.cur = body;
    const tagv = try self.b.load(try cellAt(self, p, i, mi.cellWords()), @intCast(mi.tagOff()));
    try self.b.br(loop, &.{ try self.b.bin(.add, i, try self.b.iconst(1)), try self.b.bin(.add, acc, tagv) });
    self.b.cur = done;
    return res;
}

/// keys(m)（keysm の段）: 生きたエントリ（tag = 1）のキーを挿入順に、現在の深度へ imm slice として写す
/// （Lean の liveKeys と同じ走査 — 墓石はスキップ、キーのセル（int 1 語 / string ヘッダ）をそのままコピー）
fn mapKeys(self: *Lowerer, h: ir.Value, mi: *const MapInfo) Error!Val {
    const kw = mi.key.words();
    const cw = mi.cellWords();
    const live = try mapLen(self, h, mi);
    const d = try self.b.regionDepth();
    const out = try self.b.regionAlloc(d, try self.b.bin(.mul, live, try self.b.iconst(kw)));
    const p = try hdrPtr(self, h);
    const n = try self.b.load(h, 1);
    const loop = try self.b.newBlock();
    const i = try self.b.param(loop, .i64);
    const j = try self.b.param(loop, .i64);
    const body = try self.b.newBlock();
    const hit = try self.b.newBlock();
    const done = try self.b.newBlock();
    const zero = try self.b.iconst(0);
    try self.b.br(loop, &.{ zero, zero });
    self.b.cur = loop;
    try self.b.condbr(try self.b.cmp(.lt, i, n), body, &.{}, done, &.{});
    self.b.cur = body;
    const cell = try cellAt(self, p, i, cw);
    const inext = try self.b.bin(.add, i, try self.b.iconst(1));
    try self.b.condbr(try self.b.cmp(.ne, try self.b.load(cell, @intCast(mi.tagOff())), zero), hit, &.{}, loop, &.{ inext, j });
    self.b.cur = hit;
    const dst = try cellAt(self, out, j, kw);
    for (0..kw) |w| try self.b.store(dst, @intCast(w), try self.b.load(cell, @intCast(w)));
    try self.b.br(loop, &.{ inext, try self.b.bin(.add, j, try self.b.iconst(1)) });
    self.b.cur = done;
    return newHeader(self, try types.mkSlice(self, mi.key, false), out, live, d);
}

/// append(xs, v): mut はヘッダの深度で先端伸長か全コピー、imm は現在の深度へ全コピー（codegen appendCall）
fn append(self: *Lowerer, xs0: Val, src: ArgSrc, tok: ast.Pos) Error!Val {
    if (xs0.t.isString()) return self.fail(error.TypeMismatch, tok, "append to a string (use +)");
    if (xs0.t != .slice_) return self.fail(error.TypeMismatch, tok, "append to a non-slice value");
    const si = xs0.t.slice_;
    const xs = try self.copyVal(xs0);
    const v0 = try self.argVal(src, si.elem, tok);
    if (v0.t == .never) return v0;
    const v = try self.copyVal(v0);
    const d = if (si.mut) try self.b.load(xs.v, 2) else try self.b.regionDepth();
    const g = try grow(self, xs.v, si.elem.words(), d, si.mut);
    try self.storeVal(g.dst, 0, v);
    return newHeader(self, xs.t, g.ptr, try self.b.bin(.add, try self.b.load(xs.v, 1), try self.b.iconst(1)), d);
}

/// `xs[i] = v`（mut slice）/ `m[k] = v`（mut 束縛の mut map — 成長でヘッダが変わるので束縛の置き場を書き戻す）。
/// 評価順は codegen setIndex と同じ: 基底 → 添字 → 右辺 → 境界検査
pub fn setIndex(self: *Lowerer, ix: ast.Index, value: *const ast.Expr) Error!void {
    if (ix.base.* == .ident) if (self.lookup(ix.base.ident.name)) |l| if (l.ty() == .map_) {
        const mi = l.ty().map_;
        if (!mi.mut) return self.fail(error.Immutable, ix.tok, "assignment to an entry of an immutable map");
        const h = switch (l) {
            .cell => |c| c.p,
            .val, .closure => return self.fail(error.Immutable, ix.tok, "map assignment target must be a mut binding"),
        };
        const kp = try keyPtr(self, try self.expr(ix.idx), mi, ix.tok) orelse return;
        const v = try self.exprExpecting(value, mi.value, ix.tok);
        if (v.t == .never) return;
        return mapSet(self, h, kp, try self.copyVal(v), mi);
    };
    const base = try self.expr(ix.base);
    if (base.t == .never) return;
    if (base.t == .map_) return self.fail(error.Unsupported, ix.tok, "map assignment target must be a mut binding");
    const si = try sliceOf(self, base.t, ix.tok, "indexing a non-slice value");
    if (!si.mut) return self.fail(error.Immutable, ix.tok, "assignment to an element of an immutable slice");
    const i = try self.expr(ix.idx);
    if (i.t == .never) return;
    try self.want(i, .int, ix.tok);
    const v = try self.exprExpecting(value, si.elem, ix.tok);
    if (v.t == .never) return;
    try panicIf(self, try self.b.cmp(.uge, i.v, try self.b.load(base.v, 1)));
    try self.storeVal(try cellAt(self, try hdrPtr(self, base.v), i.v, si.elem.words()), 0, v);
}

/// 戻り値の境界コピー（codegen relocateValue）: 結果の中の slice / map ヘッダを呼び手の最内 region（入口の深度）へ写す。
pub fn relocate(self: *Lowerer, p: ir.Value, off: u32, t: Type, tok: ast.Pos) Error!void {
    return relocateTo(self, p, off, t, self.entry_depth, tok);
}

/// 型 t の値（p + off 語）の中の slice / map ヘッダのうち、深度が floor より深いもの（= floor より内側の region にあるもの）を
/// 深度 floor の region の先端へ写す — Lean の relocT（regionpoly R4a の深い relocate）。
/// 境界の側は floor で渡す: 関数の戻りは入口の深度（relocate）。jump の脱出・普通の出口（R4b / R5）も同じ形で floor を渡す。
/// - struct は静的オフセットで辿る。opt / union はタグで分岐して生きている腕のペイロードだけ辿る
///   （語 0 がタグ、ペイロードは語 1 から — regionpoly R0: relocR が opt / union の中まで締める）
/// - slice / map のヘッダは 2 相: ヘッダが floor より深いときだけ、① 要素の型がコンテナを含むなら各セルの中身を先に（元の位置で）
///   再帰して写し、② その後にセル列を floor の region の先端へ連続にコピーしてヘッダを付け替える（region.relocate）。
///   順序が要る: 入れ子の写しが先に bump を進めるので、外側のセル列は後から積まないと連続にならない（Lean と同じ順）。
///   ヘッダが floor 以下なら中身ごと触らない（中身は型の床から floor 以下にあることが保証される — HeapOk の tyBelow）
/// - map のセル [key][tag][value]: key は墓石（tag 0）でも照合に使うので常に、value は tag 1 のときだけ写す
pub fn relocateTo(self: *Lowerer, p: ir.Value, off: u32, t: Type, floor: ir.Value, tok: ast.Pos) Error!void {
    switch (t) {
        .slice_ => |si| try relocateCells(self, try self.fieldPtr(p, off), si.elem.words(), floor, if (si.elem.containsSlice()) .{ .slice = si.elem } else .none, tok),
        .map_ => |mi| try relocateCells(self, try self.fieldPtr(p, off), mi.cellWords(), floor, if (mi.key.containsSlice() or mi.value.containsSlice()) .{ .map = mi } else .none, tok),
        .struct_ => |s| for (s.fields) |f| try relocateTo(self, p, off + f.offset, f.t, floor, tok),
        .opt => |o| if (o.payload.containsSlice()) {
            // nil（タグ 0）ならペイロードは無い
            const tag = try self.b.load(p, @intCast(off));
            const live = try relocateArm(self, try self.b.cmp(.ne, tag, try self.b.iconst(0)));
            try relocateTo(self, p, off + 1, o.payload, floor, tok);
            try self.b.br(live, &.{});
            self.b.cur = live;
        },
        .union_ => |u| if (t.containsSlice()) {
            const tag = try self.b.load(p, @intCast(off));
            for (u.variants) |v| {
                const has = for (v.fields) |f| {
                    if (f.t.containsSlice()) break true;
                } else false;
                if (!has) continue;
                const join = try relocateArm(self, try self.b.cmp(.eq, tag, try self.b.iconst(v.tag)));
                for (v.fields) |f| try relocateTo(self, p, off + 1 + f.offset, f.t, floor, tok);
                try self.b.br(join, &.{});
                self.b.cur = join;
            }
        },
        else => {},
    }
}

/// セルの中身の型（中身にコンテナが無ければ none — 浅い relocate だけ）
const Inner = union(enum) { none, slice: Type, map: *const MapInfo };

/// ヘッダ h（3 語: ptr, len, 深度）のセル列を floor の region へ写す。inner があれば先に各セルの中身を写す（relocateTo の 2 相）
fn relocateCells(self: *Lowerer, h: ir.Value, cellw: u32, floor: ir.Value, inner: Inner, tok: ast.Pos) Error!void {
    if (inner == .none) return self.b.regionRelocate(h, cellw, floor);
    // 外側が floor 以下なら中身ごと触らない（region.relocate も同じ判定で何もしない）
    const deep = try relocateArm(self, try self.b.cmp(.gt, try self.b.load(h, 2), floor));
    const base = try self.b.itop(try self.b.load(h, 0));
    const n = try self.b.load(h, 1);
    const loop = try self.b.newBlock();
    const i = try self.b.param(loop, .i64);
    const body = try self.b.newBlock();
    const after = try self.b.newBlock();
    try self.b.br(loop, &.{try self.b.iconst(0)});
    self.b.cur = loop;
    try self.b.condbr(try self.b.cmp(.lt, i, n), body, &.{}, after, &.{});
    self.b.cur = body;
    const cp = try cellAt(self, base, i, cellw);
    switch (inner) {
        .none => unreachable,
        .slice => |et| try relocateTo(self, cp, 0, et, floor, tok),
        .map => |mi| {
            try relocateTo(self, cp, 0, mi.key, floor, tok);
            if (mi.value.containsSlice()) {
                const live = try relocateArm(self, try self.b.cmp(.ne, try self.b.load(cp, @intCast(mi.tagOff())), try self.b.iconst(0)));
                try relocateTo(self, cp, mi.tagOff() + 1, mi.value, floor, tok);
                try self.b.br(live, &.{});
                self.b.cur = live;
            }
        },
    }
    try self.b.br(loop, &.{try self.b.bin(.add, i, try self.b.iconst(1))});
    self.b.cur = after;
    try self.b.regionRelocate(h, cellw, floor);
    try self.b.br(deep, &.{});
    self.b.cur = deep;
}

/// c が真の腕へ入る（cur = 腕）。返すのは合流ブロック — 呼び手が腕の最後で br してから cur にする
fn relocateArm(self: *Lowerer, c: ir.Value) Error!ir.BlockId {
    const arm = try self.b.newBlock();
    const join = try self.b.newBlock();
    try self.b.condbr(c, arm, &.{}, join, &.{});
    self.b.cur = arm;
    return join;
}
