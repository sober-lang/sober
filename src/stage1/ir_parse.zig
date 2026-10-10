//! IR テキスト（ir.print の出力形式）のパーサ（backend B-6）。print(parse(t)) == t の往復不動点を持つ。
//! 用途: selfhost のコンポーネント境界（Sober 製 lowering → IR テキスト → Zig 製バックエンド）と、V5 I-4 のオブジェクト形式。
//!
//! 形式（行指向。空行は読み飛ばす）:
//!   global @名前 [語数] [= {初期値, …}]
//!   [export] func @名前(%0 ty, …) [ty] {
//!     slot sN [語数]
//!   bN[(%v ty, …)]:
//!     [%v = ]op 引数…
//!     終端（br / condbr / ret / exit）
//!   }
//! 名前は [A-Za-z0-9_.#/$] だけなら裸、他は `@"..."`（`"` と `\` は `\` でエスケープ）。
//! 値の番号は関数内の型表の添字そのまま（print と同じ番号で読み戻す — 定義は 1 回、0..n-1 に欠けがないこと）。
//! 関数と global は前方参照してよい（先に見出しだけを全部読む 2 パス）。ブロックも前方参照してよい（bN は 0 から順に定義）。
//! 検査は構造だけ（番号・定義の一意・結果の有無・引数の数）。辺の引数と ret の型は ir.verify、命令のオペランド型は B-7 の検証器が見る。
//! region op の下ろし先（m.rt）は ir_rt が置く名前（rt.meta / rt.region_enter / rt.region_alloc / rt.region_relocate）で結び直す
const std = @import("std");
const ir = @import("ir.zig");

pub const Diag = struct {
    line: u32 = 0,
    what: []const u8 = "",
    buf: [160]u8 = undefined,
};

pub const Error = error{ ParseError, OutOfMemory };

/// 呼び手が deinit する
pub fn parse(gpa: std.mem.Allocator, text: []const u8, diag: *Diag) Error!ir.Module {
    var m = ir.Module.init(gpa);
    errdefer m.deinit();
    var p: Parser = .{ .m = &m, .text = text, .diag = diag };
    defer p.funcs.deinit(gpa);
    defer p.globals.deinit(gpa);
    p.gpa = gpa;
    try p.headers();
    p.pos = 0;
    p.line = 1;
    try p.bodies();
    try p.bindRuntime();
    return m;
}

const Parser = struct {
    gpa: std.mem.Allocator = undefined,
    m: *ir.Module,
    text: []const u8,
    pos: usize = 0,
    line: u32 = 1,
    diag: *Diag,
    funcs: std.StringHashMapUnmanaged(ir.FuncId) = .empty,
    globals: std.StringHashMapUnmanaged(ir.GlobalId) = .empty,
    uses_region: bool = false,

    fn fail(self: *Parser, comptime fmt: []const u8, args: anytype) Error {
        const s = std.fmt.bufPrint(&self.diag.buf, fmt, args) catch self.diag.buf[0..];
        self.diag.what = s;
        self.diag.line = self.line;
        return error.ParseError;
    }

    fn a(self: *Parser) std.mem.Allocator {
        return self.m.alloc();
    }

    // ── 字句 ──

    /// 行内の空白を飛ばす（改行は飛ばさない）
    fn ws(self: *Parser) void {
        while (self.pos < self.text.len and (self.text[self.pos] == ' ' or self.text[self.pos] == '\t' or self.text[self.pos] == '\r')) self.pos += 1;
    }

    /// 空行を飛ばし、次の行の先頭（空白の後）へ。終わりなら false
    fn nextLine(self: *Parser) bool {
        while (true) {
            self.ws();
            if (self.pos >= self.text.len) return false;
            if (self.text[self.pos] != '\n') return true;
            self.pos += 1;
            self.line += 1;
        }
    }

    fn eol(self: *Parser) Error!void {
        self.ws();
        if (self.pos >= self.text.len) return;
        if (self.text[self.pos] != '\n') return self.fail("expected end of line, found '{c}'", .{self.text[self.pos]});
        self.pos += 1;
        self.line += 1;
    }

    fn peek(self: *Parser) u8 {
        self.ws();
        return if (self.pos < self.text.len) self.text[self.pos] else 0;
    }

    fn eat(self: *Parser, c: u8) bool {
        if (self.peek() != c) return false;
        self.pos += 1;
        return true;
    }

    fn expect(self: *Parser, c: u8) Error!void {
        if (!self.eat(c)) return self.fail("expected '{c}'", .{c});
    }

    /// 英字・数字・'.'・'_' の並び（op 名・キーワード・型名）
    fn word(self: *Parser) []const u8 {
        self.ws();
        const start = self.pos;
        while (self.pos < self.text.len and (std.ascii.isAlphanumeric(self.text[self.pos]) or self.text[self.pos] == '.' or self.text[self.pos] == '_')) self.pos += 1;
        return self.text[start..self.pos];
    }

    fn keyword(self: *Parser, kw: []const u8) bool {
        const save = self.pos;
        if (std.mem.eql(u8, self.word(), kw)) return true;
        self.pos = save;
        return false;
    }

    fn int(self: *Parser, comptime T: type) Error!T {
        self.ws();
        const start = self.pos;
        if (self.pos < self.text.len and self.text[self.pos] == '-') self.pos += 1;
        while (self.pos < self.text.len and std.ascii.isDigit(self.text[self.pos])) self.pos += 1;
        return std.fmt.parseInt(T, self.text[start..self.pos], 10) catch self.fail("expected an integer", .{});
    }

    /// `@名前` か `@"..."`
    fn name(self: *Parser) Error![]const u8 {
        try self.expect('@');
        if (self.pos < self.text.len and self.text[self.pos] == '"') {
            self.pos += 1;
            var out: std.ArrayListUnmanaged(u8) = .empty;
            while (true) {
                if (self.pos >= self.text.len or self.text[self.pos] == '\n') return self.fail("unterminated quoted name", .{});
                var c = self.text[self.pos];
                self.pos += 1;
                if (c == '"') break;
                if (c == '\\') {
                    if (self.pos >= self.text.len) return self.fail("unterminated quoted name", .{});
                    c = self.text[self.pos];
                    self.pos += 1;
                }
                try out.append(self.a(), c);
            }
            if (out.items.len == 0) return self.fail("empty name", .{});
            return out.items;
        }
        const start = self.pos;
        while (self.pos < self.text.len and ir.isNameChar(self.text[self.pos])) self.pos += 1;
        if (self.pos == start) return self.fail("expected a name after '@'", .{});
        return self.text[start..self.pos];
    }

    fn ty(self: *Parser) Error!ir.Ty {
        const w = self.word();
        return std.meta.stringToEnum(ir.Ty, w) orelse self.fail("expected a type (i64 / ptr), found '{s}'", .{w});
    }

    /// `%N`
    fn value(self: *Parser) Error!ir.Value {
        try self.expect('%');
        return self.int(ir.Value);
    }

    /// 印字でも関数見出しでもない行を読み飛ばす（見出しパス）
    fn skipLine(self: *Parser) void {
        while (self.pos < self.text.len and self.text[self.pos] != '\n') self.pos += 1;
        if (self.pos < self.text.len) {
            self.pos += 1;
            self.line += 1;
        }
    }

    // ── パス 1: global と関数の見出し ──

    fn headers(self: *Parser) Error!void {
        while (self.nextLine()) {
            if (self.keyword("global")) {
                try self.global();
                continue;
            }
            const exported = self.keyword("export");
            if (self.keyword("func")) {
                try self.funcHeader(exported);
                continue;
            }
            if (exported) return self.fail("expected 'func' after 'export'", .{});
            self.skipLine();
        }
    }

    fn global(self: *Parser) Error!void {
        const n = try self.name();
        try self.expect('[');
        const words = try self.int(u32);
        try self.expect(']');
        var init: ?[]const i64 = null;
        if (self.eat('=')) {
            try self.expect('{');
            var ws_: std.ArrayListUnmanaged(i64) = .empty;
            if (!self.eat('}')) {
                while (true) {
                    try ws_.append(self.a(), try self.int(i64));
                    if (self.eat('}')) break;
                    try self.expect(',');
                }
            }
            if (ws_.items.len != words) return self.fail("global @{s}: {d} initial words for [{d}]", .{ n, ws_.items.len, words });
            init = ws_.items;
        }
        try self.eol();
        if (self.globals.contains(n)) return self.fail("duplicate global @{s}", .{n});
        const id: ir.GlobalId = @intCast(self.m.globals.items.len);
        try self.m.globals.append(self.a(), .{ .name = n, .words = words, .init = init });
        try self.globals.put(self.gpa, n, id);
    }

    /// 仮引数は addFunc が 0.. の番号で作る（print も同じ番号を出す）ので、番号がその並びであることだけ確かめる
    fn funcHeader(self: *Parser, exported: bool) Error!void {
        const n = try self.name();
        try self.expect('(');
        var tys: std.ArrayListUnmanaged(ir.Ty) = .empty;
        if (!self.eat(')')) {
            while (true) {
                const v = try self.value();
                if (v != tys.items.len) return self.fail("parameter %{d} out of order (expected %{d})", .{ v, tys.items.len });
                try tys.append(self.a(), try self.ty());
                if (self.eat(')')) break;
                try self.expect(',');
            }
        }
        const ret: ?ir.Ty = if (self.peek() == '{') null else try self.ty();
        try self.expect('{');
        try self.eol();
        if (self.funcs.contains(n)) return self.fail("duplicate func @{s}", .{n});
        const id = try self.m.addFunc(n, tys.items, ret);
        self.m.funcs.items[id].exported = exported;
        try self.funcs.put(self.gpa, n, id);
        // 本体はパス 2 で読む
        while (self.nextLine()) {
            if (self.eat('}')) return self.eol();
            self.skipLine();
        }
        return self.fail("func @{s}: missing '}}'", .{n});
    }

    // ── パス 2: 本体 ──

    fn bodies(self: *Parser) Error!void {
        var fi: ir.FuncId = 0;
        while (self.nextLine()) {
            if (self.keyword("global")) {
                self.skipLine();
                continue;
            }
            _ = self.keyword("export");
            if (!self.keyword("func")) return self.fail("expected 'global' or 'func'", .{});
            self.skipLine(); // 見出しはパス 1 で読んだ
            try self.body(self.m.funcs.items[fi]);
            fi += 1;
        }
    }

    const Fn = struct {
        f: *ir.Func,
        /// 値の定義済み印（添字 = 番号）
        defined: std.ArrayListUnmanaged(bool) = .empty,
        /// ブロックの見出しを読んだか
        seen: std.ArrayListUnmanaged(bool) = .empty,
        max_use: ?ir.Value = null,
    };

    fn define(self: *Parser, fs: *Fn, v: ir.Value, t: ir.Ty) Error!void {
        const f = fs.f;
        while (f.tys.items.len <= v) {
            try f.tys.append(self.a(), .i64);
            try fs.defined.append(self.a(), false);
        }
        if (fs.defined.items[v]) return self.fail("%{d} defined twice", .{v});
        fs.defined.items[v] = true;
        f.tys.items[v] = t;
    }

    fn use(self: *Parser, fs: *Fn) Error!ir.Value {
        const v = try self.value();
        fs.max_use = if (fs.max_use) |x| @max(x, v) else v;
        return v;
    }

    fn uses(self: *Parser, fs: *Fn) Error![]const ir.Value {
        try self.expect('(');
        var out: std.ArrayListUnmanaged(ir.Value) = .empty;
        if (!self.eat(')')) {
            while (true) {
                try out.append(self.a(), try self.use(fs));
                if (self.eat(')')) break;
                try self.expect(',');
            }
        }
        return out.items;
    }

    fn blockRef(self: *Parser, fs: *Fn) Error!ir.BlockId {
        self.ws();
        if (!self.eat('b')) return self.fail("expected a block bN", .{});
        const id = try self.int(ir.BlockId);
        try self.ensureBlock(fs, id);
        return id;
    }

    fn ensureBlock(self: *Parser, fs: *Fn, id: ir.BlockId) Error!void {
        while (fs.f.blocks.items.len <= id) {
            try fs.f.blocks.append(self.a(), .{});
            try fs.seen.append(self.a(), false);
        }
    }

    fn edge(self: *Parser, fs: *Fn) Error!ir.Edge {
        const to = try self.blockRef(fs);
        const args: []const ir.Value = if (self.peek() == '(') try self.uses(fs) else &.{};
        fs.f.blocks.items[to].preds += 1;
        return .{ .to = to, .args = args };
    }

    fn body(self: *Parser, f: *ir.Func) Error!void {
        var fs: Fn = .{ .f = f };
        for (f.params, 0..) |pv, i| {
            try fs.defined.append(self.a(), true);
            std.debug.assert(pv == i);
        }
        var cur: ?ir.BlockId = null;
        while (true) {
            if (!self.nextLine()) return self.fail("func @{s}: missing '}}'", .{f.name});
            if (self.eat('}')) break;
            const save = self.pos;
            if (self.keyword("slot")) {
                if (f.blocks.items.len > 0) return self.fail("slot after the first block", .{});
                if (!self.eat('s')) return self.fail("expected sN", .{});
                const n = try self.int(u32);
                if (n != f.slots.items.len) return self.fail("slot s{d} out of order (expected s{d})", .{ n, f.slots.items.len });
                try self.expect('[');
                try f.slots.append(self.a(), try self.int(u32));
                try self.expect(']');
                try self.eol();
                continue;
            }
            // ブロックの見出し `bN(…):`
            if (self.peek() == 'b' and self.pos + 1 < self.text.len and std.ascii.isDigit(self.text[self.pos + 1])) {
                self.pos += 1;
                const id = try self.int(ir.BlockId);
                if (self.peek() == '(' or self.peek() == ':') {
                    if (cur != null) return self.fail("block b{d} starts before b{d} is terminated", .{ id, cur.? });
                    if (id != countSeen(&fs)) return self.fail("block b{d} out of order (expected b{d})", .{ id, countSeen(&fs) });
                    try self.ensureBlock(&fs, id);
                    fs.seen.items[id] = true;
                    if (self.eat('(')) {
                        while (true) {
                            const v = try self.value();
                            const t = try self.ty();
                            try self.define(&fs, v, t);
                            try f.blocks.items[id].params.append(self.a(), v);
                            if (self.eat(')')) break;
                            try self.expect(',');
                        }
                    }
                    try self.expect(':');
                    try self.eol();
                    cur = id;
                    continue;
                }
                self.pos = save;
            }
            const blk = cur orelse return self.fail("instruction outside a block", .{});
            if (try self.term(&fs)) |t| {
                f.blocks.items[blk].term = t;
                cur = null;
            } else try f.blocks.items[blk].insts.append(self.a(), try self.inst(&fs));
            try self.eol();
        }
        try self.eol();
        if (cur) |blk| return self.fail("block b{d} is not terminated", .{blk});
        if (f.blocks.items.len == 0) return self.fail("func @{s} has no blocks", .{f.name});
        for (fs.seen.items, 0..) |s, i| if (!s) return self.fail("block b{d} is referenced but not defined", .{i});
        for (fs.defined.items, 0..) |d, i| if (!d) return self.fail("func @{s}: %{d} is not defined (value numbers must be dense)", .{ f.name, i });
        if (fs.max_use) |mu| if (mu >= f.tys.items.len) return self.fail("func @{s}: %{d} is not defined", .{ f.name, mu });
    }

    fn countSeen(fs: *const Fn) ir.BlockId {
        var n: ir.BlockId = 0;
        for (fs.seen.items) |s| n += @intFromBool(s);
        return n;
    }

    /// 終端なら読んで返す（違えば位置を戻して null）
    fn term(self: *Parser, fs: *Fn) Error!?ir.Term {
        const save = self.pos;
        const w = self.word();
        if (std.mem.eql(u8, w, "br")) return .{ .br = try self.edge(fs) };
        if (std.mem.eql(u8, w, "condbr")) {
            const c = try self.use(fs);
            try self.expect(',');
            const t = try self.edge(fs);
            try self.expect(',');
            return .{ .condbr = .{ .c = c, .t = t, .e = try self.edge(fs) } };
        }
        if (std.mem.eql(u8, w, "ret")) return .{ .ret = if (self.peek() == '%') try self.use(fs) else null };
        if (std.mem.eql(u8, w, "exit")) return .{ .exit = try self.int(u8) };
        self.pos = save;
        return null;
    }

    /// `%p[off]`
    fn place(self: *Parser, fs: *Fn) Error!struct { p: ir.Value, off: i32 } {
        const p = try self.use(fs);
        try self.expect('[');
        const off = try self.int(i32);
        try self.expect(']');
        return .{ .p = p, .off = off };
    }

    fn two(self: *Parser, fs: *Fn) Error![2]ir.Value {
        const x = try self.use(fs);
        try self.expect(',');
        return .{ x, try self.use(fs) };
    }

    fn inst(self: *Parser, fs: *Fn) Error!ir.Inst {
        var res: ?ir.Value = null;
        if (self.peek() == '%') {
            res = try self.value();
            try self.expect('=');
        }
        const w = self.word();
        var rty: ?ir.Ty = .i64;
        const op: ir.Op = blk: {
            if (std.mem.eql(u8, w, "const")) break :blk .{ .iconst = try self.int(i64) };
            if (std.meta.stringToEnum(ir.BinOp, w)) |b| {
                const xy = try self.two(fs);
                break :blk .{ .bin = .{ .op = b, .a = xy[0], .b = xy[1] } };
            }
            if (std.meta.stringToEnum(ir.CmpOp, w)) |c| {
                const xy = try self.two(fs);
                break :blk .{ .cmp = .{ .op = c, .a = xy[0], .b = xy[1] } };
            }
            if (std.mem.startsWith(u8, w, "load.")) {
                const t = std.meta.stringToEnum(ir.Ty, w[5..]) orelse return self.fail("unknown op '{s}'", .{w});
                const pl = try self.place(fs);
                rty = t;
                break :blk .{ .load = .{ .p = pl.p, .off = pl.off, .ty = t } };
            }
            if (std.mem.eql(u8, w, "store") or std.mem.eql(u8, w, "store8")) {
                const pl = try self.place(fs);
                try self.expect(',');
                const v = try self.use(fs);
                rty = null;
                break :blk if (w.len == 5) .{ .store = .{ .p = pl.p, .off = pl.off, .v = v } } else .{ .store8 = .{ .p = pl.p, .off = pl.off, .v = v } };
            }
            if (std.mem.eql(u8, w, "load8")) {
                const pl = try self.place(fs);
                break :blk .{ .load8 = .{ .p = pl.p, .off = pl.off } };
            }
            if (std.mem.eql(u8, w, "gep.word") or std.mem.eql(u8, w, "gep.byte")) {
                const xy = try self.two(fs);
                rty = .ptr;
                break :blk .{ .gep = .{ .p = xy[0], .idx = xy[1], .scale = if (w[4] == 'w') .word else .byte } };
            }
            if (std.mem.eql(u8, w, "ptoi")) break :blk .{ .ptoi = try self.use(fs) };
            if (std.mem.eql(u8, w, "itop")) {
                rty = .ptr;
                break :blk .{ .itop = try self.use(fs) };
            }
            if (std.mem.eql(u8, w, "slotaddr")) {
                if (!self.eat('s')) return self.fail("expected sN", .{});
                const sl = try self.int(ir.SlotId);
                if (sl >= fs.f.slots.items.len) return self.fail("undefined slot s{d}", .{sl});
                rty = .ptr;
                break :blk .{ .slotaddr = sl };
            }
            if (std.mem.eql(u8, w, "globaladdr")) {
                const n = try self.name();
                rty = .ptr;
                break :blk .{ .globaladdr = self.globals.get(n) orelse return self.fail("undefined global @{s}", .{n}) };
            }
            if (std.mem.eql(u8, w, "funcaddr")) {
                const n = try self.name();
                break :blk .{ .funcaddr = self.funcs.get(n) orelse return self.fail("undefined func @{s}", .{n}) };
            }
            if (std.mem.eql(u8, w, "call")) {
                const n = try self.name();
                const f = self.funcs.get(n) orelse return self.fail("undefined func @{s}", .{n});
                const args = try self.uses(fs);
                if (args.len != self.m.funcs.items[f].params.len) return self.fail("call @{s}: {d} arguments for {d} parameters", .{ n, args.len, self.m.funcs.items[f].params.len });
                rty = self.m.funcs.items[f].ret;
                break :blk .{ .call = .{ .f = f, .args = args } };
            }
            if (std.mem.startsWith(u8, w, "call.indirect")) {
                const rest = w["call.indirect".len..];
                rty = if (rest.len == 0) null else if (rest[0] == '.') (std.meta.stringToEnum(ir.Ty, rest[1..]) orelse return self.fail("unknown op '{s}'", .{w})) else return self.fail("unknown op '{s}'", .{w});
                const callee = try self.use(fs);
                break :blk .{ .call_indirect = .{ .callee = callee, .args = try self.uses(fs), .ret = rty } };
            }
            if (std.mem.eql(u8, w, "syscall")) {
                const args = try self.uses(fs);
                if (args.len < 1 or args.len > 7) return self.fail("syscall takes 1 to 7 arguments", .{});
                break :blk .{ .syscall = args };
            }
            if (std.mem.startsWith(u8, w, "region.")) {
                self.uses_region = true;
                const r = w["region.".len..];
                if (std.mem.eql(u8, r, "enter")) {
                    rty = null;
                    break :blk .region_enter;
                }
                if (std.mem.eql(u8, r, "depth")) break :blk .region_depth;
                if (std.mem.eql(u8, r, "setdepth")) {
                    rty = null;
                    break :blk .{ .region_setdepth = try self.use(fs) };
                }
                if (std.mem.eql(u8, r, "alloc")) {
                    const xy = try self.two(fs);
                    rty = .ptr;
                    break :blk .{ .region_alloc = .{ .depth = xy[0], .words = xy[1] } };
                }
                if (std.mem.eql(u8, r, "bump")) {
                    rty = .ptr;
                    break :blk .{ .region_bump = try self.use(fs) };
                }
                if (std.mem.eql(u8, r, "relocate")) {
                    const h = try self.use(fs);
                    try self.expect(',');
                    const cw = try self.int(u32);
                    try self.expect(',');
                    rty = null;
                    break :blk .{ .region_relocate = .{ .hdr = h, .cellw = cw, .floor = try self.use(fs) } };
                }
            }
            return self.fail("unknown op '{s}'", .{w});
        };
        if (res == null and rty != null) return self.fail("'{s}' has a result — write %N = …", .{w});
        if (res != null and rty == null) return self.fail("'{s}' has no result", .{w});
        if (res) |r| try self.define(fs, r, rty.?);
        return .{ .res = res, .op = op };
    }

    /// region op の下ろし先を ir_rt の名前で結ぶ（ir_rt.install が置く名前 — 無ければ region op を使えない）
    fn bindRuntime(self: *Parser) Error!void {
        const g = self.globals.get("rt.meta");
        const e = self.funcs.get("rt.region_enter");
        const al = self.funcs.get("rt.region_alloc");
        const rl = self.funcs.get("rt.region_relocate");
        if (g) |x| self.m.rt.meta = x;
        if (e) |x| self.m.rt.region_enter = x;
        if (al) |x| self.m.rt.region_alloc = x;
        if (rl) |x| self.m.rt.region_relocate = x;
        if (self.uses_region and (g == null or e == null or al == null or rl == null)) {
            self.line = 0;
            return self.fail("region ops need the runtime (@rt.meta, @rt.region_enter, @rt.region_alloc, @rt.region_relocate)", .{});
        }
    }
};
