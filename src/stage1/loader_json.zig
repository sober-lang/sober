//! loader 通過後の Program の JSON emitter — selfhost の第 2 黄金（testdata/loaderjson/）の器。
//! 切り面は loader.load の直後（link の全段 — import 解決・循環検査・名前付き関数型の展開・markMutDefs・errors の合成・
//! const の畳み込み — を通った Program）。表層 AST（C4 — testdata/astjson/）に無い、loader が決める / 埋める情報だけを出す:
//! package のロード順とファイル・import 表・FuncDecl の expands / mut_def / has_try / callees・ConstDecl の value / dict（`@embed` なら embed = パスの列）・
//! 組み込み error の variant の並び。srcmap（座標の解決表）は出さない（座標の照合は診断の段）。
//! 形は C4 の流儀: 2 スペースインデント・1 キー 1 行・配列の 1 要素 1 行・空は `[]`・末尾改行 1 つ。
//! 集合の意味しか持たない欄は決定的な順に並べる: import 表は参照名のバイト順（loader は hash map で持つ）、
//! callees は重複を除いたバイト順（loader は所属の判定にしか使わない — 出現順は cst_to_ast の走査順の癖なので焼き込まない）。
//! スキーマは docs への昇格待ち
const std = @import("std");
const ast = @import("ast.zig");

pub const Writer = std.Io.Writer;
pub const Error = Writer.Error || std.mem.Allocator.Error;

pub fn toOwned(gpa: std.mem.Allocator, program: *const ast.Program) ![]u8 {
    var aw: Writer.Allocating = .init(gpa);
    errdefer aw.deinit();
    var j: J = .{ .w = &aw.writer, .gpa = gpa };
    try j.program(program);
    try aw.writer.writeByte('\n');
    return aw.toOwnedSlice();
}

fn lessStr(_: void, x: []const u8, y: []const u8) bool {
    return std.mem.lessThan(u8, x, y);
}

const J = struct {
    w: *Writer,
    gpa: std.mem.Allocator,
    depth: u32 = 0,
    first: bool = true,

    fn open(self: *J, c: u8) Error!void {
        try self.w.writeByte(c);
        self.depth += 1;
        self.first = true;
    }

    fn close(self: *J, c: u8) Error!void {
        self.depth -= 1;
        if (!self.first) try self.newline();
        try self.w.writeByte(c);
        self.first = false;
    }

    fn newline(self: *J) Error!void {
        try self.w.writeByte('\n');
        try self.w.splatByteAll(' ', self.depth * 2);
    }

    fn sep(self: *J) Error!void {
        if (!self.first) try self.w.writeByte(',');
        try self.newline();
        self.first = false;
    }

    fn key(self: *J, name: []const u8) Error!void {
        try self.sep();
        try self.w.print("\"{s}\": ", .{name});
    }

    /// 文字列（C4 と同じ escape — 名前とパスしか来ないが揃えておく）
    fn str(self: *J, s: []const u8) Error!void {
        try self.w.writeByte('"');
        for (s) |c| switch (c) {
            '"' => try self.w.writeAll("\\\""),
            '\\' => try self.w.writeAll("\\\\"),
            '\n' => try self.w.writeAll("\\n"),
            '\t' => try self.w.writeAll("\\t"),
            '\r' => try self.w.writeAll("\\r"),
            0...8, 11, 12, 14...0x1f => try self.w.print("\\u00{x:0>2}", .{c}),
            else => try self.w.writeByte(c),
        };
        try self.w.writeByte('"');
    }

    fn kStr(self: *J, name: []const u8, s: []const u8) Error!void {
        try self.key(name);
        try self.str(s);
    }

    fn kBool(self: *J, name: []const u8, v: bool) Error!void {
        try self.key(name);
        try self.w.writeAll(if (v) "true" else "false");
    }

    fn strList(self: *J, name: []const u8, xs: []const []const u8) Error!void {
        try self.key(name);
        if (xs.len == 0) return self.w.writeAll("[]");
        try self.open('[');
        for (xs) |x| {
            try self.sep();
            try self.str(x);
        }
        try self.close(']');
    }

    fn program(self: *J, p: *const ast.Program) Error!void {
        try self.open('{');
        try self.kStr("main", p.main.path);
        try self.key("pkgs");
        try self.open('[');
        for (p.pkgs) |pkg| {
            try self.sep();
            try self.pkgObj(pkg);
        }
        try self.close(']');
        try self.key("errors");
        const vs = p.errors.body.union_;
        if (vs.len == 0) {
            try self.w.writeAll("[]");
        } else {
            try self.open('[');
            for (vs) |v| {
                try self.sep();
                try self.open('{');
                try self.kStr("name", v.name);
                try self.kStr("pkg", if (v.pkg) |vp| vp.path else "");
                try self.close('}');
            }
            try self.close(']');
        }
        try self.close('}');
    }

    fn pkgObj(self: *J, pkg: *const ast.Pkg) Error!void {
        try self.open('{');
        try self.kStr("path", pkg.path);
        try self.kStr("name", pkg.name);
        // import 表: 参照名のバイト順
        var refs: std.ArrayListUnmanaged([]const u8) = .empty;
        defer refs.deinit(self.gpa);
        var it = pkg.imports.keyIterator();
        while (it.next()) |k| try refs.append(self.gpa, k.*);
        std.mem.sort([]const u8, refs.items, {}, lessStr);
        try self.key("imports");
        if (refs.items.len == 0) {
            try self.w.writeAll("[]");
        } else {
            try self.open('[');
            for (refs.items) |r| {
                try self.sep();
                try self.open('{');
                try self.kStr("ref", r);
                try self.kStr("path", pkg.imports.get(r).?);
                try self.close('}');
            }
            try self.close(']');
        }
        try self.key("funcs");
        var nf: usize = 0;
        for (pkg.files) |file| nf += file.funcs.len;
        if (nf == 0) {
            try self.w.writeAll("[]");
        } else {
            try self.open('[');
            for (pkg.files) |file| for (file.funcs) |f| {
                try self.sep();
                try self.func(f);
            };
            try self.close(']');
        }
        try self.key("consts");
        var nc: usize = 0;
        for (pkg.files) |file| nc += file.consts.len;
        if (nc == 0) {
            try self.w.writeAll("[]");
        } else {
            try self.open('[');
            for (pkg.files) |file| for (file.consts) |c| {
                try self.sep();
                try self.open('{');
                try self.kStr("name", c.name);
                try self.key("value");
                if (c.value) |v| try self.w.print("{d}", .{v}) else try self.w.writeAll("null");
                try self.kBool("dict", c.dict);
                // `@embed` の const だけ: 埋めたファイルのパスの列（loader が畳んだ map リテラルのキー = バイト辞書順）
                if (c.embed != null) {
                    const es = c.expr.maplit.entries;
                    const ps = try self.gpa.alloc([]const u8, es.len);
                    defer self.gpa.free(ps);
                    for (es, ps) |en, *q| q.* = en.key.strlit.value;
                    try self.strList("embed", ps);
                }
                try self.close('}');
            };
            try self.close(']');
        }
        try self.close('}');
    }

    fn func(self: *J, f: *const ast.FuncDecl) Error!void {
        try self.open('{');
        try self.kStr("name", f.name);
        try self.kBool("expands", f.expands);
        try self.kBool("mut_def", f.mut_def);
        try self.kBool("has_try", f.has_try);
        // callees: 重複を除いたバイト順
        const cs = try self.gpa.dupe([]const u8, f.callees);
        defer self.gpa.free(cs);
        std.mem.sort([]const u8, cs, {}, lessStr);
        var n: usize = 0;
        for (cs) |c| {
            if (n > 0 and std.mem.eql(u8, cs[n - 1], c)) continue;
            cs[n] = c;
            n += 1;
        }
        try self.strList("callees", cs[0..n]);
        try self.close('}');
    }
};
