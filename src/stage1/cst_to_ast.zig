//! CST → AST。ルール名で分岐して ast.zig のノードを組む。
//! Phase 1 の範囲外の構文は error.Unsupported（どのトークンで、どのルールかを diag に残す）。
const std = @import("std");
const peg = @import("peg.zig");
const Token = @import("token.zig");
const grammar = @import("grammar.zig");
const cst = @import("cst.zig");
const ast = @import("ast.zig");
const srcpos = @import("srcpos.zig");
const interp = @import("interp.zig");
/// `string(b)` の行き先（予約参照名 — ソースの識別子にならない `$` 始まり。interp.itoa_ref と同じ流儀）
pub const utf8_ref = "$utf8";
pub const utf8_path = "std/utf8";
const Lexer = @import("lexer.zig");
const forexpand = @import("forexpand.zig");

pub const Error = error{ Unsupported, Malformed } || std.mem.Allocator.Error;

/// 失敗時の説明。err が返ったら呼び手はこれを読む
pub const Diag = struct {
    rule: []const u8 = "",
    tok: srcpos.Pos = 0,
    what: []const u8 = "",
};

pub fn convert(allocator: std.mem.Allocator, tree: cst.Tree, diag: *Diag) Error!ast.Ast {
    return convertAt(allocator, tree, 0, diag);
}

pub const Opts = struct {
    /// `.sobi`（interface — language.md 29 節）として読む: 本体なしの関数宣言を許す
    iface: bool = false,
};

pub fn convertOpts(allocator: std.mem.Allocator, tree: cst.Tree, base: srcpos.Pos, opts: Opts, diag: *Diag) Error!ast.Ast {
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    var c = Converter{ .tree = tree, .base = base, .a = arena.allocator(), .diag = diag, .iface = opts.iface };
    const file = try c.file(tree.root);
    return .{ .arena = arena, .file = file };
}

/// base = このファイルの先頭トークンの通し番号（srcpos.zig）。AST の tok と Diag.tok は base 込みの Pos
pub fn convertAt(allocator: std.mem.Allocator, tree: cst.Tree, base: srcpos.Pos, diag: *Diag) Error!ast.Ast {
    return convertOpts(allocator, tree, base, .{}, diag);
}

/// ルールノードの「意味のある子」: 匿名ノードは平坦化、空ノード・';'・EOF は落とす
const Item = struct {
    idx: u32,
    /// ルールノードなら名前、終端なら null
    rule: ?[]const u8,
    /// 終端ならトークン
    tok: ?Token,
    tok_index: srcpos.Pos,
};

const Converter = struct {
    tree: cst.Tree,
    base: srcpos.Pos,
    a: std.mem.Allocator,
    diag: *Diag,
    /// for 本体（ブロック形）の字句的内側か。yield はここでだけ書ける（ラムダ本体で 0 に戻る）
    for_depth: u32 = 0,
    /// for 式を 1 つでも含むか（含めば std/iter を予約名で暗黙に import する — forexpand.zig）
    uses_for: bool = false,
    /// 変換した後置 `?` の数（FuncDecl.has_try の判定 — 本体の前後の差）
    try_count: u32 = 0,
    /// 変換した呼び出しの callee 名（FuncDecl.callees — 本体の前後の差）
    callee_names: std.ArrayListUnmanaged([]const u8) = .empty,
    /// 補間を 1 つでも含むか（含めば std/strings を予約名で暗黙に import する — interp.zig）
    uses_interp: bool = false,
    /// `string(b)` を 1 つでも含むか（含めば std/utf8 を予約名で暗黙に import し、呼び出しを utf8.FromBytes に置き換える —
    /// language.md 27 節の綴り S-a）
    uses_utf8: bool = false,
    /// 非 null なら全ノードの tok をこの座標にする（補間の式は部分文字列を解析し直すので、
    /// 座標は囲む文字列リテラルのトークンで代表する）
    fixed_tok: ?srcpos.Pos = null,
    /// `.sobi` として読む（本体なし宣言を許す）
    iface: bool = false,

    fn posOf(self: *const Converter, token_start: u32) srcpos.Pos {
        return self.fixed_tok orelse self.base + token_start;
    }

    /// idx（ルールノード）の意味のある子を並べる
    fn items(self: *Converter, idx: u32) Error![]Item {
        var list: std.ArrayListUnmanaged(Item) = .empty;
        const n = self.tree.nodes[idx];
        for (self.tree.children[n.children_start..n.children_end]) |k| try self.collect(k, &list);
        return list.toOwnedSlice(self.a);
    }

    fn collect(self: *Converter, idx: u32, out: *std.ArrayListUnmanaged(Item)) Error!void {
        const n = self.tree.nodes[idx];
        if (n.rule_id != cst.TERMINAL) {
            try out.append(self.a, .{ .idx = idx, .rule = grammar.ruleName(n.rule_id), .tok = null, .tok_index = self.posOf(n.token_start) });
            return;
        }
        const kids = self.tree.children[n.children_start..n.children_end];
        if (kids.len == 0) {
            if (n.token_end == n.token_start) return;
            const t = self.tree.tokens[n.token_start];
            if (t.tag == .semicolon or t.tag == .eof) return;
            try out.append(self.a, .{ .idx = idx, .rule = null, .tok = t, .tok_index = self.posOf(n.token_start) });
            return;
        }
        for (kids) |k| try self.collect(k, out);
    }

    /// ルールノードの唯一の子ルールへ降りる（expression → pipe_expr → … の一本鎖）
    fn only(self: *Converter, idx: u32) Error!Item {
        const its = try self.items(idx);
        if (its.len != 1) return self.malformed(idx, "expected a single child");
        return its[0];
    }

    fn text(self: *Converter, it: Item) []const u8 {
        return it.tok.?.slice(self.tree.source);
    }

    fn unsupported(self: *Converter, it: Item, what: []const u8) Error {
        self.diag.* = .{ .rule = it.rule orelse "token", .tok = it.tok_index, .what = what };
        return error.Unsupported;
    }

    fn malformed(self: *Converter, idx: u32, what: []const u8) Error {
        const n = self.tree.nodes[idx];
        self.diag.* = .{ .rule = if (n.rule_id != cst.TERMINAL) grammar.ruleName(n.rule_id) else "token", .tok = self.posOf(n.token_start), .what = what };
        return error.Malformed;
    }

    fn isRule(it: Item, name: []const u8) bool {
        return it.rule != null and std.mem.eql(u8, it.rule.?, name);
    }

    fn isTok(it: Item, tag: Token.Tag) bool {
        return it.tok != null and it.tok.?.tag == tag;
    }

    /// "c_" 接頭辞を剥がした式ルール名
    fn exprRule(name: []const u8) []const u8 {
        return if (std.mem.startsWith(u8, name, "c_")) name[2..] else name;
    }

    // ── 宣言 ─────────────────────────────────────────────────────

    fn file(self: *Converter, root: u32) Error!*ast.File {
        const its = try self.items(root);
        var package: []const u8 = "";
        var imports: std.ArrayListUnmanaged(ast.Import) = .empty;
        var types: std.ArrayListUnmanaged(*ast.TypeDecl) = .empty;
        var funcs: std.ArrayListUnmanaged(*ast.FuncDecl) = .empty;
        var consts: std.ArrayListUnmanaged(*ast.ConstDecl) = .empty;
        for (its) |it| {
            if (isRule(it, "package_clause")) {
                const pc = try self.items(it.idx);
                package = self.text(pc[1]);
            } else if (isRule(it, "import_decl")) {
                for (try self.items(it.idx)) |spec| {
                    if (!isRule(spec, "import_spec")) continue;
                    const parts = try self.items(spec.idx); // IDENT? STR
                    var alias: ?[]const u8 = null;
                    var path_item: Item = parts[parts.len - 1];
                    if (parts.len == 2) {
                        alias = self.text(parts[0]);
                        // 副作用 import は持たない（決定 14）
                        if (std.mem.eql(u8, alias.?, "_")) return self.unsupported(parts[0], "blank import");
                        path_item = parts[1];
                    }
                    const raw = self.text(path_item);
                    if (raw.len < 2) return self.malformed(spec.idx, "import path");
                    try imports.append(self.a, .{ .alias = alias, .path = raw[1 .. raw.len - 1], .tok = path_item.tok_index });
                }
            } else if (isRule(it, "top_level_decl")) {
                const d = try self.items(it.idx);
                const node = self.tree.nodes[it.idx];
                const span: ast.Span = .{ .start = self.base + node.token_start, .end = self.base + node.token_end };
                const nt = types.items.len;
                const nf = funcs.items.len;
                const nc = consts.items.len;
                defer {
                    for (types.items[nt..]) |t| t.span = span;
                    for (funcs.items[nf..]) |f| f.span = span;
                    for (consts.items[nc..]) |c| c.span = span;
                }
                var noinline_at: ?Item = null;
                var embed_at: ?Item = null;
                var embed_pat: []const u8 = "";
                for (d) |decl| {
                    if (isRule(decl, "annotation")) {
                        // `@errors(...)` は受理して読み捨てる（V4 — 強制は Phase 4 の analyzer。language.md 13 節）
                        const ai = try self.items(decl.idx);
                        if (ai.len >= 2 and std.mem.eql(u8, self.text(ai[1]), "errors")) continue;
                        // `@noinline`（引数なし）は続く関数宣言の印（言語の意味は変えない — loader が Def 化を決める）
                        if (ai.len == 2 and std.mem.eql(u8, self.text(ai[1]), "noinline")) {
                            noinline_at = decl;
                            continue;
                        }
                        // `@embed("glob")` は続く const 宣言の印（引数は文字列リテラル 1 つ — ファイルの読み込みは loader）
                        if (ai.len >= 2 and std.mem.eql(u8, self.text(ai[1]), "embed")) {
                            embed_pat = try self.embedPattern(decl, ai);
                            embed_at = decl;
                            continue;
                        }
                        return self.unsupported(decl, "annotation");
                    } else if (embed_at) |at| {
                        if (!isRule(decl, "const_decl") or noinline_at != null) return self.unsupported(at, "@embed on a declaration other than a const");
                        const n0 = consts.items.len;
                        try self.constDecl(decl.idx, &consts);
                        if (consts.items.len - n0 != 1) return self.unsupported(at, "@embed on a const declaring more than one name");
                        consts.items[n0].embed = embed_pat;
                        embed_at = null;
                    } else if (isRule(decl, "func_decl")) {
                        const fd = try self.funcDecl(decl.idx);
                        if (noinline_at != null) fd.no_inline = true;
                        noinline_at = null;
                        try funcs.append(self.a, fd);
                    } else if (noinline_at) |at| {
                        return self.unsupported(at, "@noinline on a declaration other than a function");
                    } else if (isRule(decl, "type_decl")) {
                        try types.append(self.a, try self.typeDecl(decl.idx));
                    } else if (isRule(decl, "const_decl")) {
                        try self.constDecl(decl.idx, &consts);
                    } else return self.unsupported(decl, "top-level declaration kind");
                }
            } else return self.unsupported(it, "top-level construct");
        }
        if (self.uses_for) try imports.append(self.a, .{ .alias = forexpand.iter_ref, .path = forexpand.iter_path, .tok = 0 });
        if (self.uses_interp) try imports.append(self.a, .{ .alias = interp.itoa_ref, .path = interp.std_pkg, .tok = 0 });
        if (self.uses_utf8) try imports.append(self.a, .{ .alias = utf8_ref, .path = utf8_path, .tok = 0 });
        const f = try self.a.create(ast.File);
        f.* = .{
            .package = package,
            .imports = try imports.toOwnedSlice(self.a),
            .types = try types.toOwnedSlice(self.a),
            .funcs = try funcs.toOwnedSlice(self.a),
            .consts = try consts.toOwnedSlice(self.a),
        };
        return f;
    }

    /// `@embed("glob")` の引数: 補間なしの文字列リテラル 1 つ
    fn embedPattern(self: *Converter, decl: Item, ai: []const Item) Error![]const u8 {
        var pat: ?[]const u8 = null;
        var n: usize = 0;
        for (ai) |ci| {
            if (!isRule(ci, "argument_list")) continue;
            for (try self.items(ci.idx)) |arg| {
                if (!isRule(arg, "argument")) continue;
                n += 1;
                const xs = try self.items(arg.idx);
                if (xs.len != 1) return self.unsupported(decl, "@embed takes one string literal");
                const e = try self.argExpr(xs[0]);
                if (e.* != .strlit) return self.unsupported(decl, "@embed takes one string literal");
                pat = e.strlit.value;
            }
        }
        if (n != 1 or pat == null) return self.unsupported(decl, "@embed takes one string literal");
        return pat.?;
    }

    /// 'const' identifier_list '=' expression_list（トップレベルは const 式のみ — 決定 14）。
    /// 値の畳み込みは loader.zig の仕事
    fn constDecl(self: *Converter, idx: u32, out: *std.ArrayListUnmanaged(*ast.ConstDecl)) Error!void {
        const its = try self.items(idx);
        var names: std.ArrayListUnmanaged(Item) = .empty;
        var values: std.ArrayListUnmanaged(Item) = .empty;
        for (its) |it| {
            if (isRule(it, "identifier_list")) {
                for (try self.items(it.idx)) |id| {
                    if (isTok(id, .identifier)) try names.append(self.a, id);
                }
            } else if (isRule(it, "expression_list")) {
                for (try self.items(it.idx)) |e| {
                    if (isRule(e, "expression")) try values.append(self.a, e);
                }
            }
        }
        if (names.items.len != values.items.len)
            return self.malformed(idx, "const name and value counts differ");
        for (names.items, values.items) |n, v| {
            const c = try self.a.create(ast.ConstDecl);
            c.* = .{ .name = self.text(n), .expr = try self.expr(v), .tok = n.tok_index };
            try out.append(self.a, c);
        }
    }

    fn typeDecl(self: *Converter, idx: u32) Error!*ast.TypeDecl {
        const its = try self.items(idx);
        // 'type' IDENT type_params? type_spec_body
        var tparams: []const []const u8 = &.{};
        var bi: usize = 2;
        if (isRule(its[2], "type_params")) {
            tparams = try self.typeParams(its[2]);
            bi = 3;
        }
        // func_type の後ろには注釈が続きうる（`type F func(T) @pure`）
        const body = (try self.items(its[bi].idx))[0];
        const t = try self.a.create(ast.TypeDecl);
        if (isRule(body, "struct_type")) {
            var fields: []const ast.Field = &.{};
            for (try self.items(body.idx)) |b| {
                if (isRule(b, "field_list")) fields = try self.fieldList(b);
            }
            t.* = .{ .name = self.text(its[1]), .type_params = tparams, .body = .{ .struct_ = fields }, .tok = its[1].tok_index };
        } else if (isRule(body, "union_type")) {
            var variants: std.ArrayListUnmanaged(ast.Variant) = .empty;
            for (try self.items(body.idx)) |v| {
                if (!isRule(v, "variant")) continue;
                const vi = try self.items(v.idx); // IDENT '{' field_list '}'
                var fields: []const ast.Field = &.{};
                for (vi) |x| {
                    if (isRule(x, "field_list")) fields = try self.fieldList(x);
                }
                try variants.append(self.a, .{ .name = self.text(vi[0]), .fields = fields, .tok = vi[0].tok_index });
            }
            if (tparams.len > 0) return self.unsupported(its[2], "generic union (V3-3 covers generic structs only)");
            t.* = .{ .name = self.text(its[1]), .body = .{ .union_ = try variants.toOwnedSlice(self.a) }, .tok = its[1].tok_index };
        } else if (isRule(body, "func_type")) {
            // 名前付き関数型（language.md 14 節）。注釈は Phase 2 では読み捨てる
            t.* = .{ .name = self.text(its[1]), .type_params = tparams, .body = .{ .func_ = try self.funcTypeLit(body) }, .tok = its[1].tok_index };
        } else if (isRule(body, "error_type")) {
            // エラーラベル（V4-4a）: `type NotFound error { id int }` / `type Timeout error`
            var fields: []const ast.Field = &.{};
            for (try self.items(body.idx)) |b| {
                if (isRule(b, "field_list")) fields = try self.fieldList(b);
            }
            if (tparams.len > 0) return self.unsupported(its[2], "generic error label");
            t.* = .{ .name = self.text(its[1]), .body = .{ .error_ = fields }, .tok = its[1].tok_index };
        } else return self.unsupported(body, "type other than struct, union, error, or a function type");
        return t;
    }

    /// '[' IDENT (',' IDENT)* ']'
    fn typeParams(self: *Converter, it: Item) Error![]const []const u8 {
        var names: std.ArrayListUnmanaged([]const u8) = .empty;
        for (try self.items(it.idx)) |x| {
            if (isTok(x, .identifier)) try names.append(self.a, self.text(x));
        }
        return names.toOwnedSlice(self.a);
    }

    /// '[' type (',' type)* ']'
    fn typeArgs(self: *Converter, it: Item) Error![]const ast.TypeExpr {
        var args: std.ArrayListUnmanaged(ast.TypeExpr) = .empty;
        for (try self.items(it.idx)) |x| {
            if (isRule(x, "type")) try args.append(self.a, try self.typeExpr(x));
        }
        return args.toOwnedSlice(self.a);
    }

    fn fieldList(self: *Converter, it: Item) Error![]const ast.Field {
        var fields: std.ArrayListUnmanaged(ast.Field) = .empty;
        for (try self.items(it.idx)) |fd| {
            if (!isRule(fd, "field_decl")) continue;
            const parts = try self.items(fd.idx);
            if (parts.len != 2) return self.unsupported(fd, "field annotation");
            const ty = try self.typeExpr(parts[1]);
            for (try self.items(parts[0].idx)) |id| {
                if (isTok(id, .identifier)) try fields.append(self.a, .{ .name = self.text(id), .type = ty, .tok = id.tok_index });
            }
        }
        return fields.toOwnedSlice(self.a);
    }

    fn funcDecl(self: *Converter, idx: u32) Error!*ast.FuncDecl {
        const its = try self.items(idx);
        // 'func' IDENT type_params? signature block?
        var i: usize = 1;
        const name = self.text(its[i]);
        i += 1;
        var tparams: []const []const u8 = &.{};
        if (i < its.len and isRule(its[i], "type_params")) {
            tparams = try self.typeParams(its[i]);
            i += 1;
        }
        if (i >= its.len or !isRule(its[i], "signature")) return self.malformed(idx, "missing signature");
        const sig = try self.items(its[i].idx);
        const sig_end = self.base + self.tree.nodes[its[i].idx].token_end;
        i += 1;
        const bodiless = i >= its.len or !isRule(its[i], "block");
        // 本体なし宣言は `.sobi` の中だけ（language.md 29 節。Go の「アセンブリ実装」とは意味が違う）
        if (bodiless and !self.iface) return self.unsupported(its[i - 1], "func without body (allowed only in a .sobi interface)");

        var params: std.ArrayListUnmanaged(ast.Param) = .empty;
        var results: std.ArrayListUnmanaged(ast.TypeExpr) = .empty;
        for (sig) |s| {
            if (isRule(s, "parameters")) {
                for (try self.items(s.idx)) |p| {
                    if (!isRule(p, "parameter_decl")) continue;
                    const pd = try self.items(p.idx);
                    // identifier_list '...'? type / '...'? type
                    if (pd.len == 2 and isRule(pd[0], "identifier_list") and isRule(pd[1], "type")) {
                        var pmut = false;
                        const ty = try self.paramType(pd[1], &pmut);
                        for (try self.items(pd[0].idx)) |id| {
                            if (isTok(id, .identifier)) try params.append(self.a, .{ .name = self.text(id), .type = ty, .mutable = pmut });
                        }
                    } else return self.unsupported(p, "unnamed or variadic parameter");
                }
            } else if (isRule(s, "result")) {
                try self.resultTypes(s, &results);
            }
        }
        const f = try self.a.create(ast.FuncDecl);
        const expands = hasFuncParam(params.items);
        f.* = .{
            .name = name,
            .type_params = tparams,
            .params = try params.toOwnedSlice(self.a),
            .results = try results.toOwnedSlice(self.a),
            .body = undefined,
            .expands = expands,
            .tok = its[1].tok_index,
            .bodiless = bodiless,
            .sig_end = sig_end,
        };
        if (bodiless) {
            const empty = try self.a.create(ast.Block);
            empty.* = .{ .stmts = &.{} };
            f.body = empty;
            return f;
        }
        const tries_before = self.try_count;
        const callees_before = self.callee_names.items.len;
        f.body = try self.block(its[i].idx);
        f.has_try = self.try_count != tries_before;
        f.callees = try self.a.dupe([]const u8, self.callee_names.items[callees_before..]);
        self.callee_names.shrinkRetainingCapacity(callees_before);
        return f;
    }

    /// 関数型の引数か mut 引数を持つ関数は呼び出し点に展開する（生成方式 — 意味の規則ではない。language.md 8 節）
    fn hasFuncParam(params: []const ast.Param) bool {
        for (params) |p| if (p.type == .func or p.mutable) return true;
        return false;
    }

    fn resultTypes(self: *Converter, result: Item, out: *std.ArrayListUnmanaged(ast.TypeExpr)) Error!void {
        for (try self.items(result.idx)) |r| {
            if (isRule(r, "type")) try out.append(self.a, try self.typeExpr(r));
        }
    }

    /// type_name の中身（IDENT ('.' IDENT)?）をドット付き文字列にする。
    /// 修飾名の解決（import 表・可視性）は loader / 各コンパイラの仕事
    fn qualName(self: *Converter, tn: []const Item, ctx: Item) Error![]const u8 {
        if (tn.len == 1 and isTok(tn[0], .identifier)) return self.text(tn[0]);
        // 組み込みの error 型（V4-4a。'error' はキーワードだが型名として使う — syntax.md 1 節）
        if (tn.len == 1 and isTok(tn[0], .keyword_error)) return "error";
        if (tn.len == 3 and isTok(tn[0], .identifier) and isTok(tn[2], .identifier)) {
            const out = try self.a.alloc(u8, self.text(tn[0]).len + 1 + self.text(tn[2]).len);
            @memcpy(out[0..self.text(tn[0]).len], self.text(tn[0]));
            out[self.text(tn[0]).len] = '.';
            @memcpy(out[self.text(tn[0]).len + 1 ..], self.text(tn[2]));
            return out;
        }
        return self.unsupported(ctx, "type name");
    }

    /// 型: 名前・関数型 `func(T, U) R`・optional `T?`・slice / map（`mut` 前置可 —
    /// language.md 22 節）。他（型引数、array、`*T`）は Unsupported
    fn typeExpr(self: *Converter, it: Item) Error!ast.TypeExpr {
        return self.typeExprMut(it, null);
    }

    /// 仮引数の型: 先頭の `mut` は mut 引数（呼び手の mut ローカルへの参照渡し — V3-5）の印。
    /// コンテナ型なら型の mut（可変コンテナ）も兼ねる。それ以外の型では印だけ外して型を読む
    fn paramType(self: *Converter, it: Item, mutable: *bool) Error!ast.TypeExpr {
        return self.typeExprMut(it, mutable);
    }

    fn typeExprMut(self: *Converter, it: Item, param_mut: ?*bool) Error!ast.TypeExpr {
        var its = try self.items(it.idx);
        var mutable = false;
        if (its.len >= 1 and isTok(its[0], .keyword_mut)) {
            mutable = true;
            its = its[1..];
            if (param_mut) |pm| {
                pm.* = true;
                // 型としての mut はコンテナ（slice / map）だけに残す
                const container = its.len == 1 and isRule(its[0], "type_lit") and blk: {
                    const lit = try self.only(its[0].idx);
                    break :blk isRule(lit, "slice_type") or isRule(lit, "map_type");
                };
                if (!container) mutable = false;
            }
        }
        var optional = false;
        if (its.len == 2 and isTok(its[1], .question)) {
            optional = true;
            its = its[0..1];
        }
        // ジェネリック型の適用 `Name[T, ...]`（V3-3）
        if (its.len == 2 and isRule(its[0], "type_name") and isRule(its[1], "type_args")) {
            if (mutable) return self.malformed(it.idx, "mut on a non-container type");
            const tn = try self.items(its[0].idx);
            const g: ast.TypeExpr = .{ .generic = .{ .name = try self.qualName(tn, its[0]), .args = try self.typeArgs(its[1]) } };
            if (optional) {
                const inner = try self.a.create(ast.TypeExpr);
                inner.* = g;
                return .{ .opt = inner };
            }
            return g;
        }
        if (its.len != 1) return self.unsupported(it, "type with a suffix or in parentheses");
        if (optional) {
            if (mutable) return self.malformed(it.idx, "mut on an optional type");
            const inner = try self.a.create(ast.TypeExpr);
            inner.* = try self.typeExprBase(its[0], false);
            return .{ .opt = inner };
        }
        return self.typeExprBase(its[0], mutable);
    }

    fn typeExprBase(self: *Converter, base: Item, mutable: bool) Error!ast.TypeExpr {
        // 'mut' はコンテナ型（slice / map）にだけ付く（language.md 22 節）
        if (mutable) {
            if (isRule(base, "type_lit")) {
                const lit = try self.only(base.idx);
                if (!isRule(lit, "slice_type") and !isRule(lit, "map_type"))
                    return self.malformed(base.idx, "mut on a non-container type");
            } else return self.malformed(base.idx, "mut on a non-container type");
        }
        return self.typeExprBase2(base, mutable);
    }

    fn typeExprBase2(self: *Converter, base: Item, mutable: bool) Error!ast.TypeExpr {
        if (isRule(base, "type_name")) {
            const tn = try self.items(base.idx);
            return .{ .name = try self.qualName(tn, base) };
        }
        if (isRule(base, "type_lit")) {
            const lit = try self.only(base.idx);
            if (isRule(lit, "slice_type")) {
                for (try self.items(lit.idx)) |si| {
                    if (!isRule(si, "type")) continue;
                    const inner = try self.a.create(ast.TypeExpr);
                    inner.* = try self.typeExpr(si);
                    return .{ .slice_of = .{ .elem = inner, .mut = mutable } };
                }
                return self.malformed(lit.idx, "slice type");
            }
            if (isRule(lit, "map_type")) {
                // map '[' type ']' type
                var tys: [2]?Item = .{ null, null };
                var n: usize = 0;
                for (try self.items(lit.idx)) |si| {
                    if (!isRule(si, "type")) continue;
                    if (n < 2) tys[n] = si;
                    n += 1;
                }
                if (n != 2) return self.malformed(lit.idx, "map type");
                const key = try self.a.create(ast.TypeExpr);
                key.* = try self.typeExpr(tys[0].?);
                const value = try self.a.create(ast.TypeExpr);
                value.* = try self.typeExpr(tys[1].?);
                return .{ .map_of = .{ .key = key, .value = value, .mut = mutable } };
            }
            if (!isRule(lit, "func_type")) return self.unsupported(lit, "type literal other than a function type");
            return .{ .func = try self.funcTypeLit(lit) };
        }
        return self.unsupported(base, "type kind");
    }

    /// 'func' signature — 引数は型だけ（`func(int, int) int`）か名前つき
    fn funcTypeLit(self: *Converter, lit: Item) Error!*const ast.FuncType {
        const sig = try self.items((try self.items(lit.idx))[1].idx);
        var params: std.ArrayListUnmanaged(ast.TypeExpr) = .empty;
        var results: std.ArrayListUnmanaged(ast.TypeExpr) = .empty;
        for (sig) |s| {
            if (isRule(s, "parameters")) {
                for (try self.items(s.idx)) |p| {
                    if (!isRule(p, "parameter_decl")) continue;
                    const pd = try self.items(p.idx);
                    if (pd.len == 1 and isRule(pd[0], "type")) {
                        try params.append(self.a, try self.typeExpr(pd[0]));
                    } else if (pd.len == 2 and isRule(pd[0], "identifier_list") and isRule(pd[1], "type")) {
                        const ty = try self.typeExpr(pd[1]);
                        for (try self.items(pd[0].idx)) |id| {
                            if (isTok(id, .identifier)) try params.append(self.a, ty);
                        }
                    } else return self.unsupported(p, "variadic parameter");
                }
            } else if (isRule(s, "result")) try self.resultTypes(s, &results);
        }
        const ft = try self.a.create(ast.FuncType);
        ft.* = .{ .params = try params.toOwnedSlice(self.a), .results = try results.toOwnedSlice(self.a) };
        return ft;
    }

    // ── 文 ───────────────────────────────────────────────────────

    fn block(self: *Converter, idx: u32) Error!*ast.Block {
        for (try self.items(idx)) |it| {
            if (isRule(it, "statement_list")) return self.stmtList(it.idx);
        }
        return self.stmtList(null);
    }

    /// statement_list（無ければ空ブロック）
    fn stmtList(self: *Converter, idx: ?u32) Error!*ast.Block {
        var stmts: std.ArrayListUnmanaged(ast.Stmt) = .empty;
        if (idx) |i| {
            for (try self.items(i)) |s| {
                if (isRule(s, "statement")) try stmts.append(self.a, try self.statement(s.idx));
            }
        }
        const b = try self.a.create(ast.Block);
        b.* = .{ .stmts = try stmts.toOwnedSlice(self.a) };
        return b;
    }

    fn statement(self: *Converter, idx: u32) Error!ast.Stmt {
        var it = try self.only(idx);
        // statement → declaration / simple_stmt の包みを剥がす
        while (isRule(it, "declaration") or isRule(it, "simple_stmt")) it = try self.only(it.idx);
        const name = it.rule orelse return self.malformed(idx, "statement without rule");

        if (std.mem.eql(u8, name, "bind_decl")) {
            const its = try self.items(it.idx);
            var i: usize = 0;
            const mutable = isTok(its[0], .keyword_mut);
            if (mutable) i += 1;
            const names = try self.identList(its[i].idx);
            const values = try self.exprList(its[i + 2].idx);
            return .{ .bind = .{ .names = names, .mutable = mutable, .values = values, .tok = it.tok_index } };
        }
        if (std.mem.eql(u8, name, "assignment")) {
            const its = try self.items(it.idx);
            const op_items = try self.items(its[1].idx);
            return .{ .assign = .{
                .targets = try self.exprList(its[0].idx),
                .op = op_items[0].tok.?.tag,
                .values = try self.exprList(its[2].idx),
                .tok = it.tok_index,
            } };
        }
        if (std.mem.eql(u8, name, "return_stmt")) {
            const its = try self.items(it.idx);
            const values: []const *ast.Expr = if (its.len > 1) try self.exprList(its[1].idx) else &.{};
            return .{ .ret = .{ .values = values, .tok = it.tok_index } };
        }
        if (std.mem.eql(u8, name, "expression_stmt")) {
            return .{ .expr = try self.expr(try self.only(it.idx)) };
        }
        if (std.mem.eql(u8, name, "while_stmt")) {
            const its = try self.items(it.idx);
            return .{ .while_ = .{ .cond = try self.expr(its[1]), .body = try self.block(its[2].idx), .tok = it.tok_index } };
        }
        if (std.mem.eql(u8, name, "defer_stmt")) {
            const its = try self.items(it.idx);
            return .{ .defer_ = .{ .expr = try self.expr(its[1]), .tok = it.tok_index } };
        }
        if (std.mem.eql(u8, name, "yield_stmt")) {
            if (self.for_depth == 0) return self.unsupported(it, "yield outside the body of a for expression");
            const its = try self.items(it.idx);
            return .{ .yield_ = .{ .expr = try self.expr(its[1]), .tok = it.tok_index } };
        }
        if (std.mem.eql(u8, name, "break_stmt")) return .{ .break_ = it.tok_index };
        if (std.mem.eql(u8, name, "continue_stmt")) return .{ .continue_ = it.tok_index };
        return self.unsupported(it, "statement kind");
    }

    fn identList(self: *Converter, idx: u32) Error![]const []const u8 {
        var names: std.ArrayListUnmanaged([]const u8) = .empty;
        for (try self.items(idx)) |it| {
            if (isTok(it, .identifier)) try names.append(self.a, self.text(it));
        }
        return names.toOwnedSlice(self.a);
    }

    fn exprList(self: *Converter, idx: u32) Error![]const *ast.Expr {
        var list: std.ArrayListUnmanaged(*ast.Expr) = .empty;
        for (try self.items(idx)) |it| {
            if (it.rule != null) try list.append(self.a, try self.expr(it));
        }
        return list.toOwnedSlice(self.a);
    }

    // ── 式 ───────────────────────────────────────────────────────

    fn newExpr(self: *Converter, e: ast.Expr) Error!*ast.Expr {
        const p = try self.a.create(ast.Expr);
        p.* = e;
        return p;
    }

    fn expr(self: *Converter, it: Item) Error!*ast.Expr {
        const name = exprRule(it.rule orelse return self.malformed(it.idx, "expression without rule"));
        const its = try self.items(it.idx);

        if (std.mem.eql(u8, name, "expression")) {
            if (isRule(its[0], "lambda")) return self.lambda(its[0]);
            return self.expr(its[0]);
        }
        if (std.mem.eql(u8, name, "pipe_expr")) {
            // or_expr ('|>' pipe_stage)* を左結合で畳む
            var lhs = try self.expr(its[0]);
            var i: usize = 2;
            while (i < its.len) : (i += 2) lhs = try self.pipeStage(lhs, its[i], its[i - 1].tok_index);
            return lhs;
        }
        // 二項階層: operand (op operand)* を左結合で畳む
        if (std.mem.eql(u8, name, "or_expr") or std.mem.eql(u8, name, "and_expr") or
            std.mem.eql(u8, name, "rel_expr") or std.mem.eql(u8, name, "add_expr") or std.mem.eql(u8, name, "mul_expr"))
        {
            return self.foldBinary(its);
        }
        if (std.mem.eql(u8, name, "unary_expr")) {
            if (its.len == 2) {
                const op_items = try self.items(its[0].idx);
                const arg = try self.expr(its[1]);
                return self.newExpr(.{ .unary = .{ .op = op_items[0].tok.?.tag, .operand = arg, .tok = its[0].tok_index } });
            }
            return self.expr(its[0]);
        }
        if (std.mem.eql(u8, name, "postfix_expr")) {
            var e = try self.expr(its[0]);
            for (its[1..]) |pf| {
                const kind = try self.only(pf.idx);
                if (isRule(kind, "call")) {
                    var args: std.ArrayListUnmanaged(*ast.Expr) = .empty;
                    for (try self.items(kind.idx)) |ci| {
                        if (!isRule(ci, "argument_list")) continue;
                        for (try self.items(ci.idx)) |arg| {
                            if (!isRule(arg, "argument")) continue;
                            const ai = try self.items(arg.idx);
                            if (ai.len != 1) return self.unsupported(arg, "named or variadic argument");
                            try args.append(self.a, try self.argExpr(ai[0]));
                        }
                    }
                    // `string(b)` → `$utf8.FromBytes(b)`（固定テンプレートの置き換え。検査と戻しの意味は std/utf8 の Sober 側）
                    if (e.* == .ident and std.mem.eql(u8, e.ident.name, "string")) {
                        const base = try self.newExpr(.{ .ident = .{ .name = utf8_ref, .tok = e.ident.tok } });
                        e = try self.newExpr(.{ .selector = .{ .base = base, .field = "FromBytes", .tok = e.ident.tok } });
                        self.uses_utf8 = true;
                    }
                    switch (e.*) {
                        .ident => |id| try self.callee_names.append(self.a, id.name),
                        .selector => |sel| if (sel.base.* == .ident)
                            try self.callee_names.append(self.a, try std.fmt.allocPrint(self.a, "{s}.{s}", .{ sel.base.ident.name, sel.field })),
                        else => {},
                    }
                    e = try self.newExpr(.{ .call = .{ .callee = e, .args = try args.toOwnedSlice(self.a), .tok = kind.tok_index } });
                } else if (isRule(kind, "selector")) {
                    const si = try self.items(kind.idx); // '.' IDENT
                    e = try self.newExpr(.{ .selector = .{ .base = e, .field = self.text(si[1]), .tok = si[1].tok_index } });
                } else if (isRule(kind, "index")) {
                    // '[' expression (':' expression)? ']' — 2 式なら xs[a:b]（21 節）
                    var idx_exprs: [2]?*ast.Expr = .{ null, null };
                    var idx_n: usize = 0;
                    for (try self.items(kind.idx)) |ii| {
                        if (ii.rule != null) {
                            if (idx_n >= 2) return self.malformed(kind.idx, "index expression");
                            idx_exprs[idx_n] = try self.expr(ii);
                            idx_n += 1;
                        }
                    }
                    if (idx_n == 2) {
                        e = try self.newExpr(.{ .slice3 = .{
                            .base = e,
                            .lo = idx_exprs[0].?,
                            .hi = idx_exprs[1].?,
                            .tok = kind.tok_index,
                        } });
                    } else {
                        e = try self.newExpr(.{ .index = .{
                            .base = e,
                            .idx = idx_exprs[0] orelse return self.malformed(kind.idx, "index expression"),
                            .tok = kind.tok_index,
                        } });
                    }
                } else if (isRule(kind, "try") or isRule(kind, "c_try")) {
                    // '?' composite_lit?（包み替え — 条件位置の c_try は読まない）
                    var wrap: ?*const ast.Composite = null;
                    for (try self.items(kind.idx)) |ti| {
                        if (isRule(ti, "composite_lit")) {
                            const c = try self.compositeLit(ti);
                            if (c.* != .composite) return self.unsupported(ti, "error wrap other than a label literal");
                            wrap = &c.composite;
                        }
                    }
                    e = try self.newExpr(.{ .try_ = .{ .e = e, .wrap = wrap, .tok = kind.tok_index } });
                    self.try_count += 1;
                } else return self.unsupported(kind, "postfix other than call, selector, index, or ?");
            }
            return e;
        }
        if (std.mem.eql(u8, name, "primary_expr")) {
            const inner = its[0];
            if (isRule(inner, "if_expr")) return self.ifExpr(inner);
            if (isRule(inner, "switch_expr")) return self.switchExpr(inner);
            if (isRule(inner, "block")) return self.newExpr(.{ .block = try self.block(inner.idx) });
            if (isRule(inner, "operand")) return self.operand(inner);
            if (isRule(inner, "composite_lit")) return self.compositeLit(inner);
            if (isRule(inner, "for_expr")) return self.forExpr(inner);
            return self.unsupported(inner, "primary expression kind");
        }
        return self.unsupported(it, "expression rule");
    }

    /// 二項階層の子列 operand (op operand)* を左結合で畳む
    fn foldBinary(self: *Converter, its: []const Item) Error!*ast.Expr {
        var lhs = try self.expr(its[0]);
        var i: usize = 1;
        while (i + 1 < its.len) : (i += 2) {
            const rhs = try self.expr(its[i + 1]);
            lhs = try self.newExpr(.{ .binary = .{ .op = (try self.opTok(its[i])).tag, .lhs = lhs, .rhs = rhs, .tok = its[i].tok_index } });
        }
        return lhs;
    }

    /// 演算子の項（終端か、rel_op / add_op 等の包みルール）からトークンを取る
    fn opTok(self: *Converter, it: Item) Error!Token {
        if (it.tok) |t| return t;
        const op_items = try self.items(it.idx);
        return op_items[0].tok.?;
    }

    fn operand(self: *Converter, it: Item) Error!*ast.Expr {
        const its = try self.items(it.idx);
        if (its.len == 3) return self.expr(its[1]); // '(' expression ')'
        const t = its[0];
        if (isTok(t, .integer_literal)) {
            const value = std.fmt.parseInt(i64, self.text(t), 10) catch return self.unsupported(t, "integer literal out of range");
            return self.newExpr(.{ .int = .{ .value = value, .tok = t.tok_index } });
        }
        if (isTok(t, .string_literal)) return self.stringLit(t);
        if (isTok(t, .identifier)) {
            // `nil` はリテラル（AST 層判定。language.md 15 節 — nil は T? にしか住めない）
            if (std.mem.eql(u8, self.text(t), "nil"))
                return self.newExpr(.{ .nil = .{ .tok = t.tok_index } });
            return self.newExpr(.{ .ident = .{ .name = self.text(t), .tok = t.tok_index } });
        }
        return self.unsupported(t, "literal kind");
    }

    /// `"..."`。穴が無ければ strlit、あれば補間（ast.Interp）
    fn stringLit(self: *Converter, t: Item) Error!*ast.Expr {
        const tmpl = try self.template(t);
        if (tmpl.holes.len == 0) return self.newExpr(.{ .strlit = .{ .value = tmpl.lits[0], .tok = t.tok_index } });
        self.uses_interp = true;
        return self.newExpr(.{ .interp = .{ .tmpl = tmpl, .tok = t.tok_index } });
    }

    /// 文字列リテラルをテンプレートの正規形（定数部 n+1 個 + 穴 n 個）に分解する。エスケープを解決し、
    /// `${ 式 }` の式は部分文字列を字句・構文解析し直す（閉じ括弧は Lexer.interpEnd — 字句と読み飛ばし規則を共有）。
    /// 補間とタグ付きテンプレート（将来）の共通の入口 — 連結の意味はここで持たない
    fn template(self: *Converter, t: Item) Error!ast.Template {
        const raw = self.text(t);
        const start = t.tok.?.loc.start;
        var lits: std.ArrayListUnmanaged([]const u8) = .empty;
        var holes: std.ArrayListUnmanaged(*ast.Expr) = .empty;
        var out: std.ArrayListUnmanaged(u8) = .empty;
        var i: usize = 1;
        while (i + 1 < raw.len) : (i += 1) {
            const c = raw[i];
            if (c == '\\' and i + 2 < raw.len) {
                i += 1;
                const esc: u8 = switch (raw[i]) {
                    'n' => '\n',
                    't' => '\t',
                    'r' => '\r',
                    '0' => 0,
                    '\\' => '\\',
                    '"' => '"',
                    '$' => '$',
                    else => return self.unsupported(t, "escape sequence"),
                };
                try out.append(self.a, esc);
            } else if (c == '$' and raw[i + 1] == '{') {
                const end = (Lexer.interpEnd(self.tree.source, start + i + 1) orelse return self.malformed(t.idx, "interpolation")) - start;
                try lits.append(self.a, try out.toOwnedSlice(self.a));
                try holes.append(self.a, try self.interpExpr(t, raw[i + 2 .. end - 1]));
                i = end - 1;
            } else try out.append(self.a, c);
        }
        try lits.append(self.a, try out.toOwnedSlice(self.a));
        return .{ .lits = try lits.toOwnedSlice(self.a), .holes = try holes.toOwnedSlice(self.a) };
    }

    /// 補間 `${ text }` の式。text を 1 つの expression として解析し、全ノードの座標を文字列リテラルに揃える
    fn interpExpr(self: *Converter, t: Item, body: []const u8) Error!*ast.Expr {
        const src = try self.a.dupeZ(u8, body);
        const tokens = try Lexer.tokenize(self.a, src);
        var m = grammar.Matcher.init(self.a, tokens);
        const root = (try m.parse("expression")) orelse return self.unsupported(t, "interpolation is not an expression");
        // 末尾は自動挿入の ; と eof だけ
        for (tokens[m.pos..]) |rest| if (rest.tag != .semicolon and rest.tag != .eof)
            return self.unsupported(t, "interpolation must be a single expression");
        var sub = Converter{
            .tree = cst.Tree.fromMatcher(&m, src, root),
            .base = 0,
            .a = self.a,
            .diag = self.diag,
            .for_depth = self.for_depth,
            .fixed_tok = t.tok_index,
        };
        const e = try sub.expr(.{ .idx = root, .rule = "expression", .tok = null, .tok_index = t.tok_index });
        if (sub.uses_for) self.uses_for = true;
        if (sub.uses_interp) self.uses_interp = true;
        if (sub.uses_utf8) self.uses_utf8 = true;
        // 穴の中の `?` と呼び出しも囲みの関数のもの（FuncDecl.has_try / callees は本体の前後の差で数える）
        self.try_count += sub.try_count;
        try self.callee_names.appendSlice(self.a, sub.callee_names.items);
        return e;
    }

    /// lambda_params '=>' (block / expression)。`(a, b)` は型だけの parameter_decl として読まれるので名前と解釈する
    fn lambda(self: *Converter, it: Item) Error!*ast.Expr {
        const its = try self.items(it.idx);
        var params: std.ArrayListUnmanaged(ast.LambdaParam) = .empty;
        const lp = try self.only(its[0].idx); // lambda_params → IDENT / parameters
        if (lp.tok != null) {
            try params.append(self.a, .{ .name = self.text(lp), .type = null });
        } else {
            for (try self.items(lp.idx)) |p| {
                if (!isRule(p, "parameter_decl")) continue;
                const pd = try self.items(p.idx);
                if (pd.len == 1 and isRule(pd[0], "type")) {
                    const ty = try self.typeExpr(pd[0]);
                    if (ty != .name) return self.unsupported(p, "lambda parameter without a name");
                    try params.append(self.a, .{ .name = ty.name, .type = null });
                } else if (pd.len == 2 and isRule(pd[0], "identifier_list") and isRule(pd[1], "type")) {
                    const ty = try self.typeExpr(pd[1]);
                    for (try self.items(pd[0].idx)) |id| {
                        if (isTok(id, .identifier)) try params.append(self.a, .{ .name = self.text(id), .type = ty });
                    }
                } else return self.unsupported(p, "variadic lambda parameter");
            }
        }
        const body_item = its[2];
        const saved_for = self.for_depth;
        self.for_depth = 0;
        defer self.for_depth = saved_for;
        const body = if (isRule(body_item, "block")) try self.newExpr(.{ .block = try self.block(body_item.idx) }) else try self.expr(body_item);
        return self.newExpr(.{ .lambda = .{ .params = try params.toOwnedSlice(self.a), .body = body, .tok = its[1].tok_index } });
    }

    fn compositeLit(self: *Converter, it: Item) Error!*ast.Expr {
        var its = try self.items(it.idx); // 'mut'? literal_type literal_value
        var mutable = false;
        if (its.len >= 1 and isTok(its[0], .keyword_mut)) {
            mutable = true;
            its = its[1..];
        }
        const lt = try self.items(its[0].idx);
        if (mutable and !(lt.len == 1 and (isRule(lt[0], "slice_type") or isRule(lt[0], "map_type"))))
            return self.malformed(its[0].idx, "mut on a non-container literal");
        if (lt.len == 1 and isRule(lt[0], "map_type")) {
            // map リテラル `map[K]V{k: v, ...}`
            var tys: [2]?Item = .{ null, null };
            var n: usize = 0;
            for (try self.items(lt[0].idx)) |si| {
                if (!isRule(si, "type")) continue;
                if (n < 2) tys[n] = si;
                n += 1;
            }
            if (n != 2) return self.malformed(lt[0].idx, "map literal type");
            const key_ty = try self.typeExpr(tys[0].?);
            const value_ty = try self.typeExpr(tys[1].?);
            var entries: std.ArrayListUnmanaged(ast.MapEntry) = .empty;
            for (try self.items(its[1].idx)) |lv| {
                if (!isRule(lv, "element_list")) continue;
                for (try self.items(lv.idx)) |ke| {
                    if (!isRule(ke, "keyed_element")) continue;
                    const parts = try self.items(ke.idx);
                    var key_item: ?Item = null;
                    var elem_item: ?Item = null;
                    for (parts) |p| {
                        if (isRule(p, "key")) key_item = p;
                        if (isRule(p, "element")) elem_item = p;
                    }
                    if (key_item == null or elem_item == null)
                        return self.malformed(ke.idx, "map literal entry needs key: value");
                    const kexpr = try self.expr(try self.only(key_item.?.idx));
                    const vexpr = try self.expr(try self.only(elem_item.?.idx));
                    try entries.append(self.a, .{ .key = kexpr, .value = vexpr });
                }
            }
            return self.newExpr(.{ .maplit = .{ .key = key_ty, .value = value_ty, .entries = try entries.toOwnedSlice(self.a), .mut = mutable, .tok = its[0].tok_index } });
        }
        if (lt.len == 1 and isRule(lt[0], "slice_type")) {
            // slice リテラル `[]T{e, ...}`
            var elem_opt: ?ast.TypeExpr = null;
            for (try self.items(lt[0].idx)) |si| {
                if (isRule(si, "type")) elem_opt = try self.typeExpr(si);
            }
            const elem = elem_opt orelse return self.malformed(lt[0].idx, "slice literal type");
            var elems: std.ArrayListUnmanaged(*ast.Expr) = .empty;
            for (try self.items(its[1].idx)) |lv| {
                if (!isRule(lv, "element_list")) continue;
                for (try self.items(lv.idx)) |ke| {
                    if (!isRule(ke, "keyed_element")) continue;
                    const parts = try self.items(ke.idx);
                    if (parts.len != 1) return self.unsupported(ke, "keyed element in a slice literal");
                    const el = try self.only(parts[0].idx);
                    try elems.append(self.a, try self.expr(el));
                }
            }
            return self.newExpr(.{ .slicelit = .{ .elem = elem, .elems = try elems.toOwnedSlice(self.a), .mut = mutable, .tok = its[0].tok_index } });
        }
        var ctargs: []const ast.TypeExpr = &.{};
        if (lt.len == 2 and isRule(lt[0], "type_name") and isRule(lt[1], "type_args")) {
            ctargs = try self.typeArgs(lt[1]);
        } else if (lt.len != 1 or !isRule(lt[0], "type_name")) return self.unsupported(its[0], "composite literal of a non-struct type");
        const tn = try self.items(lt[0].idx);
        const type_name = try self.qualName(tn, lt[0]);
        var elems: std.ArrayListUnmanaged(ast.Elem) = .empty;
        for (try self.items(its[1].idx)) |lv| {
            if (!isRule(lv, "element_list")) continue;
            for (try self.items(lv.idx)) |ke| {
                if (!isRule(ke, "keyed_element")) continue;
                const parts = try self.items(ke.idx); // (key ':')? element
                var key: ?[]const u8 = null;
                if (parts.len == 3) {
                    const k = try self.only(parts[0].idx); // key → expression
                    const ke_expr = try self.expr(k);
                    if (ke_expr.* != .ident) return self.unsupported(parts[0], "non-identifier key");
                    key = ke_expr.ident.name;
                }
                const el = try self.only(parts[parts.len - 1].idx); // element → literal_value / expression
                if (!std.mem.eql(u8, el.rule orelse "", "expression")) return self.unsupported(el, "nested literal without type");
                try elems.append(self.a, .{ .key = key, .value = try self.expr(el) });
            }
        }
        return self.newExpr(.{ .composite = .{ .type_name = type_name, .elems = try elems.toOwnedSlice(self.a), .tok = it.tok_index, .type_args = ctargs } });
    }

    fn ifExpr(self: *Converter, it: Item) Error!*ast.Expr {
        const its = try self.items(it.idx);
        // 'if' c_expression block ('else' (if_expr / block))?
        const cond = try self.expr(its[1]);
        const then = try self.block(its[2].idx);
        var else_: ?*ast.Expr = null;
        if (its.len == 5) {
            const alt = its[4];
            else_ = if (isRule(alt, "if_expr")) try self.ifExpr(alt) else try self.newExpr(.{ .block = try self.block(alt.idx) });
        }
        return self.newExpr(.{ .if_ = .{ .cond = cond, .then = then, .else_ = else_, .tok = it.tok_index } });
    }

    /// 'for' generators ('yield' or_expr / block)。ジェネレータ間は ';'、ガードは各ジェネレータ直後（決定 4）
    fn forExpr(self: *Converter, it: Item) Error!*ast.Expr {
        const its = try self.items(it.idx);
        var gens: std.ArrayListUnmanaged(ast.Generator) = .empty;
        for (try self.items(its[1].idx)) |g| {
            if (!isRule(g, "generator")) continue;
            const gi = try self.items(g.idx); // identifier_list '<-' c_expression ('if' c_expression)*
            var guards: std.ArrayListUnmanaged(*ast.Expr) = .empty;
            var k: usize = 3;
            while (k + 1 < gi.len) : (k += 2) try guards.append(self.a, try self.expr(gi[k + 1]));
            try gens.append(self.a, .{
                .names = try self.identList(gi[0].idx),
                .src = try self.expr(gi[2]),
                .guards = try guards.toOwnedSlice(self.a),
                .tok = g.tok_index,
            });
        }
        const body: ast.ForBody = if (its.len == 4)
            .{ .yield_ = try self.expr(its[3]) }
        else blk: {
            self.for_depth += 1;
            defer self.for_depth -= 1;
            break :blk .{ .block = try self.block(its[2].idx) };
        };
        self.uses_for = true;
        return self.newExpr(.{ .for_ = .{ .gens = try gens.toOwnedSlice(self.a), .body = body, .tok = it.tok_index } });
    }

    /// パイプ段: 裸の名前 `f` か呼び出し `f(a, _, b)`。直下の引数の `_` が穴
    fn pipeStage(self: *Converter, lhs: *ast.Expr, stage: Item, tok: u32) Error!*ast.Expr {
        const pf = try self.only(stage.idx); // pipe_stage → postfix_expr
        const its = try self.items(pf.idx);
        var callee = try self.expr(its[0]);
        // 修飾名 `pkg.F` の段: 呼び出しの手前の selector は callee の一部
        var n = its.len;
        while (n > 1) {
            const kind = try self.only(its[n - 1].idx);
            if (isRule(kind, "call")) break;
            n -= 1;
        }
        const call_at: ?usize = if (n > 1) n - 1 else null;
        const callee_end = call_at orelse its.len;
        for (its[1..callee_end]) |pfx| {
            const kind = try self.only(pfx.idx);
            if (!isRule(kind, "selector")) return self.unsupported(kind, "pipe stage other than a (qualified) call");
            const si = try self.items(kind.idx); // '.' IDENT
            callee = try self.newExpr(.{ .selector = .{ .base = callee, .field = self.text(si[1]), .tok = si[1].tok_index } });
        }
        var args: std.ArrayListUnmanaged(?*ast.Expr) = .empty;
        if (call_at) |ci_at| {
            if (ci_at + 1 < its.len) return self.unsupported(its[ci_at + 1], "postfix after the pipe stage call");
            const kind = try self.only(its[ci_at].idx);
            for (try self.items(kind.idx)) |ci| {
                if (!isRule(ci, "argument_list")) continue;
                for (try self.items(ci.idx)) |arg| {
                    if (!isRule(arg, "argument")) continue;
                    const ai = try self.items(arg.idx);
                    if (ai.len != 1) return self.unsupported(arg, "named or variadic argument");
                    const e = try self.argExpr(ai[0]);
                    try args.append(self.a, if (e.* == .ident and std.mem.eql(u8, e.ident.name, "_")) null else e);
                }
            }
        }
        return self.newExpr(.{ .pipe = .{ .lhs = lhs, .callee = callee, .args = try args.toOwnedSlice(self.a), .tok = tok } });
    }

    /// 実引数: `mut x`（mut 引数への参照渡しの印 — V3-5）か式
    fn argExpr(self: *Converter, it: Item) Error!*ast.Expr {
        if (isRule(it, "mut_arg")) {
            const mi = try self.items(it.idx); // 'mut' IDENT
            return self.newExpr(.{ .mut_arg = .{ .name = self.text(mi[1]), .tok = mi[1].tok_index } });
        }
        return self.expr(it);
    }

    fn switchExpr(self: *Converter, it: Item) Error!*ast.Expr {
        const its = try self.items(it.idx);
        // 'switch' c_expression_list? '{' case_clause* '}'
        var subjects: []const *ast.Expr = &.{};
        var cases: std.ArrayListUnmanaged(ast.Case) = .empty;
        var default_: ?*ast.Block = null;
        for (its[1..]) |c| {
            if (isRule(c, "c_expression_list")) {
                subjects = try self.exprList(c.idx);
            } else if (isRule(c, "case_clause")) {
                const ci = try self.items(c.idx);
                // 'case' pattern_list ':' statement_list? / 'default' ':' statement_list?
                const body_idx: ?u32 = if (isRule(ci[ci.len - 1], "statement_list")) ci[ci.len - 1].idx else null;
                if (isTok(ci[0], .keyword_default)) {
                    if (default_ != null) return self.unsupported(ci[0], "second default");
                    default_ = try self.stmtList(body_idx);
                    continue;
                }
                var patterns: std.ArrayListUnmanaged(ast.Pattern) = .empty;
                for (try self.items(ci[1].idx)) |p| {
                    if (isRule(p, "pattern")) try patterns.append(self.a, try self.pattern(p));
                }
                try cases.append(self.a, .{ .patterns = try patterns.toOwnedSlice(self.a), .body = try self.stmtList(body_idx), .tok = c.tok_index });
            }
        }
        return self.newExpr(.{ .switch_ = .{
            .subjects = subjects,
            .cases = try cases.toOwnedSlice(self.a),
            .default_ = default_,
            .tok = it.tok_index,
        } });
    }

    fn pattern(self: *Converter, it: Item) Error!ast.Pattern {
        const its = try self.items(it.idx);
        // IDENT type_pattern / type_pattern / const_pattern
        if (isRule(its[its.len - 1], "type_pattern")) {
            const bind: ?[]const u8 = if (its.len == 2) self.text(its[0]) else null;
            return .{ .type_ = try self.typePattern(its[its.len - 1], bind) };
        }
        // const_pattern → c_expression → … と一本鎖で降りて、c_add_expr の最上位 '|' 連鎖を選択に分ける
        const c_expr = try self.only(its[its.len - 1].idx);
        var cur = c_expr;
        while (true) {
            const name = exprRule(cur.rule orelse break);
            const kids = try self.items(cur.idx);
            if (std.mem.eql(u8, name, "add_expr") and kids.len >= 3) {
                // 左結合なので、末尾から続く '|' の並びが木の最上位。その手前までは 1 つの式
                var first: usize = kids.len;
                var i: usize = kids.len - 2;
                while (i >= 1) : (i -= 2) {
                    if ((try self.opTok(kids[i])).tag != .pipe) break;
                    first = i;
                    if (i == 1) break;
                }
                if (first == kids.len) break;
                var alts: std.ArrayListUnmanaged(*ast.Expr) = .empty;
                try alts.append(self.a, try self.foldBinary(kids[0..first]));
                var j = first + 1;
                while (j < kids.len) : (j += 2) try alts.append(self.a, try self.expr(kids[j]));
                return .{ .const_ = try alts.toOwnedSlice(self.a) };
            }
            if (kids.len != 1) break;
            cur = kids[0];
        }
        const single = try self.a.alloc(*ast.Expr, 1);
        single[0] = try self.expr(c_expr);
        return .{ .const_ = single };
    }

    /// type_name '{' (field_pattern (',' field_pattern)* ','?)? '}'
    fn typePattern(self: *Converter, it: Item, bind: ?[]const u8) Error!ast.TypePattern {
        const its = try self.items(it.idx);
        const tn = try self.items(its[0].idx);
        const variant_name = try self.qualName(tn, its[0]);
        var fields: std.ArrayListUnmanaged(ast.FieldPat) = .empty;
        for (its[1..]) |fp| {
            if (!isRule(fp, "field_pattern")) continue;
            const parts = try self.items(fp.idx); // IDENT (':' pattern)?
            var sub: ?*const ast.Pattern = null;
            if (parts.len == 3) {
                const p = try self.a.create(ast.Pattern);
                p.* = try self.pattern(parts[2]);
                sub = p;
            }
            try fields.append(self.a, .{ .name = self.text(parts[0]), .sub = sub, .tok = parts[0].tok_index });
        }
        return .{ .bind = bind, .variant = variant_name, .fields = try fields.toOwnedSlice(self.a), .tok = it.tok_index };
    }
};
