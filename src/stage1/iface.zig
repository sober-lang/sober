//! package の interface（`.sobi` — language.md 29 節）の生成と、リンク表。
//!
//! `.sobi` は Sober ソースの部分集合。宣言をソースのトークン範囲からそのまま切り出す（cst.zig の印字器は
//! ヒューリスティックなので使わない）。合成するのは数値 const の畳み込み値だけ:
//! - 型宣言・辞書 const・展開される関数（関数型引数 / mut 引数）・ジェネリック関数 → 宣言ごと
//! - 非展開の関数 → 本体なし宣言（`func` 〜 signature の末尾の切り出し）
//! - 数値 const → `const N = <畳み込んだ値>`
//!
//! 載せる項目 = 公開の項目 + error ラベル全部（閉じた union の要素 — 13 節）を根にした、
//! **リンク可視**の推移閉包: 載せる範囲のトークンが参照する非公開のトップレベル名を足していく。
//! 字句の走査で厳密になるのは、ローカル束縛がトップレベル名と同名にできないから（localnames.zig）。
//! `.` の直後の識別子（フィールド名・他 package の名前）は数えない。
//! import は載せた範囲が参照する参照名のものだけ。暗黙 import（`$` 始まり）は載せた本体から cst_to_ast が再び足す。
//!
//! ロード順（リンク集合と順序）は `.sobi` に載せない — リンク表（`link.txt`）がリンカ側の知識として持つ（V5-5 裁定 M3）
const std = @import("std");
const ast = @import("ast.zig");
const Lexer = @import("lexer.zig");
const Token = @import("token.zig");
const srcpos = @import("srcpos.zig");

pub const Error = error{Unsupported} || std.mem.Allocator.Error;

pub const Diag = struct { pos: srcpos.Pos = 0, what: []const u8 = "" };

const Kind = union(enum) {
    func: *const ast.FuncDecl,
    type_: *const ast.TypeDecl,
    const_: *const ast.ConstDecl,
};

const Item = struct {
    kind: Kind,
    span: ast.Span,
    included: bool = false,

    fn name(self: Item) []const u8 {
        return switch (self.kind) {
            .func => |f| f.name,
            .type_ => |t| t.name,
            .const_ => |c| c.name,
        };
    }

    /// 載せる形: 宣言ごと / 本体なし / 畳んだ値
    const Form = enum { whole, signature, folded };

    fn form(self: Item) Form {
        return switch (self.kind) {
            .func => |f| if (!f.bodiless and (f.expands or f.type_params.len > 0)) .whole else .signature,
            .type_ => .whole,
            .const_ => |c| if (c.dict) .whole else .folded,
        };
    }

    /// 載せるトークン範囲（folded は参照を持たない）
    fn range(self: Item) ?ast.Span {
        return switch (self.form()) {
            .whole => self.span,
            .signature => .{ .start = self.span.start, .end = self.kind.func.sig_end },
            .folded => null,
        };
    }
};

/// ファイルごとのトークン列（Pos → トークン）。srcmap のファイル表と同じ添字
const Toks = struct {
    map: srcpos.SourceMap,
    tokens: []const []const Token,

    fn init(a: std.mem.Allocator, map: srcpos.SourceMap) Error!Toks {
        const ts = try a.alloc([]const Token, map.files.len);
        for (map.files, ts) |f, *t| t.* = try Lexer.tokenize(a, f.source);
        return .{ .map = map, .tokens = ts };
    }

    /// Pos 範囲 [s, e) のファイル・ローカル添字（範囲はファイルをまたがない）
    fn local(self: Toks, r: ast.Span) struct { file: usize, s: usize, e: usize } {
        const fid = self.map.fileOf(r.start).?;
        const base = self.map.files[fid].base;
        return .{ .file = fid, .s = r.start - base, .e = r.end - base };
    }

    /// 範囲の原文（末尾の ';' — 自動挿入を含む — は落とす）
    fn text(self: Toks, r: ast.Span) []const u8 {
        const l = self.local(r);
        const toks = self.tokens[l.file];
        var e = l.e;
        while (e > l.s and toks[e - 1].tag == .semicolon) e -= 1;
        const src = self.map.files[l.file].source;
        return src[toks[l.s].loc.start..toks[e - 1].loc.end];
    }
};

/// package の `.sobi` の本文
pub fn emitPkg(a: std.mem.Allocator, prog: *const ast.Program, pkg: *const ast.Pkg, diag: *Diag) Error![]u8 {
    const toks = try Toks.init(a, prog.srcmap);

    // 項目をソース順に（ファイル順 × 宣言順 — 関数表と error タグの順を保つ）
    var items: std.ArrayListUnmanaged(Item) = .empty;
    for (pkg.files) |file| {
        const first = items.items.len;
        for (file.types) |t| try items.append(a, .{ .kind = .{ .type_ = t }, .span = t.span });
        for (file.funcs) |f| try items.append(a, .{ .kind = .{ .func = f }, .span = f.span });
        for (file.consts) |c| {
            if (c.dict) {
                // 辞書 const は宣言ごと切り出すので、1 宣言 1 名に限る
                for (file.consts) |o| if (o != c and o.span.start == c.span.start) {
                    diag.* = .{ .pos = c.tok, .what = "a dictionary const in a multi-name const declaration cannot be put in an interface" };
                    return error.Unsupported;
                };
            }
            try items.append(a, .{ .kind = .{ .const_ = c }, .span = c.span });
        }
        std.mem.sort(Item, items.items[first..], {}, lessItem);
    }

    // 根: 公開の項目 + error ラベル
    var work: std.ArrayListUnmanaged(usize) = .empty;
    for (items.items, 0..) |*it, i| {
        const is_label = it.kind == .type_ and it.kind.type_.body == .error_;
        if (isPublic(it.name()) or is_label) {
            it.included = true;
            try work.append(a, i);
        }
    }

    // import の参照名（`$` 始まりの暗黙 import は除く）
    var import_used: std.StringHashMapUnmanaged(void) = .empty;

    // 推移閉包（リンク可視）
    while (work.pop()) |i| {
        const r = items.items[i].range() orelse continue;
        const l = toks.local(r);
        const ts = toks.tokens[l.file];
        const src = toks.map.files[l.file].source;
        var k = l.s;
        while (k < l.e) : (k += 1) {
            if (ts[k].tag != .identifier) continue;
            if (k > 0 and ts[k - 1].tag == .dot) continue;
            const id = ts[k].slice(src);
            if (k + 1 < ts.len and ts[k + 1].tag == .dot and pkg.imports.contains(id)) {
                try import_used.put(a, id, {});
                continue;
            }
            if (isPublic(id)) continue;
            for (items.items, 0..) |*o, j| {
                if (o.included or !declares(o.*, id)) continue;
                o.included = true;
                try work.append(a, j);
            }
        }
    }

    var out: std.ArrayListUnmanaged(u8) = .empty;
    const w = out.writer(a);
    try w.print("package {s}\n", .{pkg.name});

    // import（ファイル順 × 宣言順、同じ (alias, path) は 1 回）
    var seen: std.StringHashMapUnmanaged(void) = .empty;
    var wrote_import = false;
    for (pkg.files) |file| {
        for (file.imports) |imp| {
            if (imp.alias) |al| if (al.len > 0 and al[0] == '$') continue;
            const ref = imp.alias orelse std.fs.path.basename(imp.path);
            if (!import_used.contains(ref)) continue;
            const key = try std.fmt.allocPrint(a, "{s}\x00{s}", .{ imp.alias orelse "", imp.path });
            if ((try seen.getOrPut(a, key)).found_existing) continue;
            if (!wrote_import) try w.writeAll("\n");
            wrote_import = true;
            if (imp.alias) |al| try w.print("import {s} \"{s}\"\n", .{ al, imp.path }) else try w.print("import \"{s}\"\n", .{imp.path});
        }
    }

    for (items.items) |it| {
        if (!it.included) continue;
        try w.writeAll("\n");
        switch (it.form()) {
            .whole, .signature => try w.writeAll(toks.text(it.range().?)),
            .folded => {
                const v = it.kind.const_.value.?;
                if (v == std.math.minInt(i64))
                    try w.print("const {s} = -9223372036854775807 - 1", .{it.name()})
                else
                    try w.print("const {s} = {d}", .{ it.name(), v });
            },
        }
        try w.writeAll("\n");
    }
    return out.toOwnedSlice(a);
}

/// リンク表: リンク集合の package パスをロード順に 1 行ずつ（error タグと関数表の順はこの順 × 宣言順）
pub fn linkTable(a: std.mem.Allocator, prog: *const ast.Program) Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    for (prog.pkgs) |pkg| {
        try out.appendSlice(a, pkg.path);
        try out.append(a, '\n');
    }
    return out.toOwnedSlice(a);
}

fn lessItem(_: void, x: Item, y: Item) bool {
    return x.span.start < y.span.start;
}

fn isPublic(name: []const u8) bool {
    return name.len > 0 and std.ascii.isUpper(name[0]);
}

/// 項目が名前 id を宣言するか（union の variant 名はその union が宣言する）
fn declares(it: Item, id: []const u8) bool {
    if (std.mem.eql(u8, it.name(), id)) return true;
    if (it.kind == .type_ and it.kind.type_.body == .union_) {
        for (it.kind.type_.body.union_) |v| if (std.mem.eql(u8, v.name, id)) return true;
    }
    return false;
}
