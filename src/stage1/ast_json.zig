//! 表層 AST（ast.zig）の JSON emitter — selfhost の C4 黄金（testdata/astjson/）の器。
//! 切り面は parse 直後・ファイル単位（cst_to_ast の出力そのまま、Pos はファイル内トークン番号）。
//! loader が埋める / 上書きするフィールド（ConstDecl.value / dict・FuncDecl.expands / mut_def・Variant.pkg）と、
//! AST から導出できる計算結果（FuncDecl.callees / has_try）は出さない。
//! 形: union は "k" タグを先頭に置き、キーは ast.zig の宣言順。デフォルト値も省略しない。
//! 整形は 2 スペースインデント・1 キー 1 行・末尾改行 1 つ（同じ入力なら同じバイト列）。
//! スキーマは docs への昇格待ち
const std = @import("std");
const ast = @import("ast.zig");
const Token = @import("token.zig");
const Lexer = @import("lexer.zig");
const grammar = @import("grammar.zig");
const cst = @import("cst.zig");
const cst_to_ast = @import("cst_to_ast.zig");

pub const Writer = std.Io.Writer;
pub const Error = Writer.Error;

/// 1 ファイル分の JSON（末尾改行つき）
pub fn write(w: *Writer, file: *const ast.File) Error!void {
    var j: J = .{ .w = w };
    try j.file(file);
    try w.writeByte('\n');
}

pub fn toOwned(gpa: std.mem.Allocator, file: *const ast.File) ![]u8 {
    var aw: Writer.Allocating = .init(gpa);
    errdefer aw.deinit();
    try write(&aw.writer, file);
    return aw.toOwnedSlice();
}

pub const ParseError = error{ParseFailed} || cst_to_ast.Error;

/// ソース 1 ファイル → AST（base = 0）。iface = `.sobi` として読む
pub fn parse(gpa: std.mem.Allocator, source: [:0]const u8, iface: bool, diag: *cst_to_ast.Diag) ParseError!ast.Ast {
    const tokens = try Lexer.tokenize(gpa, source);
    defer gpa.free(tokens);
    var m = grammar.Matcher.init(gpa, tokens);
    defer m.deinit();
    const root = (try m.parse("source_file")) orelse return error.ParseFailed;
    return cst_to_ast.convertOpts(gpa, cst.Tree.fromMatcher(&m, source, root), 0, .{ .iface = iface }, diag);
}

/// 演算子の綴り（Token.symbols の逆引き）
fn opSpelling(tag: Token.Tag) []const u8 {
    inline for (Token.symbols) |e| if (e[1] == tag) return e[0];
    return @tagName(tag);
}

const J = struct {
    w: *Writer,
    depth: u32 = 0,
    /// 今の容器にまだ要素が無いか
    first: bool = true,

    // ── 整形の骨 ────────────────────────────────────────────────

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

    fn key(self: *J, k: []const u8) Error!void {
        try self.sep();
        try self.str(k);
        try self.w.writeAll(": ");
    }

    fn str(self: *J, s: []const u8) Error!void {
        const w = self.w;
        try w.writeByte('"');
        for (s) |c| switch (c) {
            '"' => try w.writeAll("\\\""),
            '\\' => try w.writeAll("\\\\"),
            '\n' => try w.writeAll("\\n"),
            '\t' => try w.writeAll("\\t"),
            '\r' => try w.writeAll("\\r"),
            0...0x08, 0x0b, 0x0c, 0x0e...0x1f => try w.print("\\u{x:0>4}", .{c}),
            else => try w.writeByte(c),
        };
        try w.writeByte('"');
    }

    fn kStr(self: *J, k: []const u8, v: []const u8) Error!void {
        try self.key(k);
        try self.str(v);
    }

    fn kOptStr(self: *J, k: []const u8, v: ?[]const u8) Error!void {
        try self.key(k);
        if (v) |s| try self.str(s) else try self.w.writeAll("null");
    }

    fn kInt(self: *J, k: []const u8, v: anytype) Error!void {
        try self.key(k);
        try self.w.print("{d}", .{v});
    }

    fn kBool(self: *J, k: []const u8, v: bool) Error!void {
        try self.key(k);
        try self.w.writeAll(if (v) "true" else "false");
    }

    fn kNull(self: *J, k: []const u8) Error!void {
        try self.key(k);
        try self.w.writeAll("null");
    }

    fn tag(self: *J, k: []const u8) Error!void {
        try self.kStr("k", k);
    }

    fn kStrs(self: *J, k: []const u8, xs: []const []const u8) Error!void {
        try self.key(k);
        try self.open('[');
        for (xs) |x| {
            try self.sep();
            try self.str(x);
        }
        try self.close(']');
    }

    fn kExprs(self: *J, k: []const u8, xs: []const *ast.Expr) Error!void {
        try self.key(k);
        try self.open('[');
        for (xs) |x| {
            try self.sep();
            try self.expr(x);
        }
        try self.close(']');
    }

    fn kTypes(self: *J, k: []const u8, xs: []const ast.TypeExpr) Error!void {
        try self.key(k);
        try self.open('[');
        for (xs) |x| {
            try self.sep();
            try self.typeExpr(x);
        }
        try self.close(']');
    }

    fn kFields(self: *J, k: []const u8, xs: []const ast.Field) Error!void {
        try self.key(k);
        try self.open('[');
        for (xs) |f| {
            try self.sep();
            try self.open('{');
            try self.kStr("name", f.name);
            try self.key("type");
            try self.typeExpr(f.type);
            try self.kInt("tok", f.tok);
            try self.close('}');
        }
        try self.close(']');
    }

    fn kSpan(self: *J, s: ast.Span) Error!void {
        try self.key("span");
        try self.open('{');
        try self.kInt("start", s.start);
        try self.kInt("end", s.end);
        try self.close('}');
    }

    // ── 宣言 ─────────────────────────────────────────────────────

    fn file(self: *J, f: *const ast.File) Error!void {
        try self.open('{');
        try self.kStr("package", f.package);
        try self.key("imports");
        try self.open('[');
        for (f.imports) |imp| {
            try self.sep();
            try self.open('{');
            try self.kOptStr("alias", imp.alias);
            try self.kStr("path", imp.path);
            try self.kInt("tok", imp.tok);
            try self.close('}');
        }
        try self.close(']');
        try self.key("types");
        try self.open('[');
        for (f.types) |t| {
            try self.sep();
            try self.typeDecl(t);
        }
        try self.close(']');
        try self.key("funcs");
        try self.open('[');
        for (f.funcs) |fd| {
            try self.sep();
            try self.funcDecl(fd);
        }
        try self.close(']');
        try self.key("consts");
        try self.open('[');
        for (f.consts) |c| {
            try self.sep();
            try self.open('{');
            try self.kStr("name", c.name);
            try self.key("expr");
            try self.expr(c.expr);
            try self.kInt("tok", c.tok);
            try self.kSpan(c.span);
            try self.close('}');
        }
        try self.close(']');
        try self.close('}');
    }

    fn typeDecl(self: *J, t: *const ast.TypeDecl) Error!void {
        try self.open('{');
        try self.kStr("name", t.name);
        try self.kStrs("type_params", t.type_params);
        try self.key("body");
        try self.open('{');
        switch (t.body) {
            .struct_ => |fs| {
                try self.tag("struct");
                try self.kFields("fields", fs);
            },
            .union_ => |vs| {
                try self.tag("union");
                try self.key("variants");
                try self.open('[');
                for (vs) |v| {
                    try self.sep();
                    try self.open('{');
                    try self.kStr("name", v.name);
                    try self.kFields("fields", v.fields);
                    try self.kInt("tok", v.tok);
                    try self.close('}');
                }
                try self.close(']');
            },
            .func_ => |ft| {
                try self.tag("func");
                try self.funcTypeBody(ft);
            },
            .error_ => |fs| {
                try self.tag("error");
                try self.kFields("fields", fs);
            },
        }
        try self.close('}');
        try self.kInt("tok", t.tok);
        try self.kSpan(t.span);
        try self.close('}');
    }

    fn funcTypeBody(self: *J, ft: *const ast.FuncType) Error!void {
        try self.kTypes("params", ft.params);
        try self.kTypes("results", ft.results);
    }

    fn typeExpr(self: *J, t: ast.TypeExpr) Error!void {
        try self.open('{');
        switch (t) {
            .name => |n| {
                try self.tag("name");
                try self.kStr("name", n);
            },
            .func => |ft| {
                try self.tag("func");
                try self.funcTypeBody(ft);
            },
            .opt => |inner| {
                try self.tag("opt");
                try self.key("type");
                try self.typeExpr(inner.*);
            },
            .slice_of => |s| {
                try self.tag("slice_of");
                try self.key("elem");
                try self.typeExpr(s.elem.*);
                try self.kBool("mut", s.mut);
            },
            .map_of => |m| {
                try self.tag("map_of");
                try self.key("key");
                try self.typeExpr(m.key.*);
                try self.key("value");
                try self.typeExpr(m.value.*);
                try self.kBool("mut", m.mut);
            },
            .generic => |g| {
                try self.tag("generic");
                try self.kStr("name", g.name);
                try self.kTypes("args", g.args);
            },
        }
        try self.close('}');
    }

    fn funcDecl(self: *J, f: *const ast.FuncDecl) Error!void {
        try self.open('{');
        try self.kStr("name", f.name);
        try self.kStrs("type_params", f.type_params);
        try self.key("params");
        try self.open('[');
        for (f.params) |p| {
            try self.sep();
            try self.open('{');
            try self.kStr("name", p.name);
            try self.key("type");
            try self.typeExpr(p.type);
            try self.kBool("mutable", p.mutable);
            try self.close('}');
        }
        try self.close(']');
        try self.kTypes("results", f.results);
        try self.key("body");
        try self.block(f.body);
        try self.kInt("tok", f.tok);
        try self.kBool("bodiless", f.bodiless);
        try self.kSpan(f.span);
        try self.kInt("sig_end", f.sig_end);
        try self.close('}');
    }

    // ── 文 ───────────────────────────────────────────────────────

    fn block(self: *J, b: *const ast.Block) Error!void {
        try self.open('{');
        try self.blockBody(b);
        try self.close('}');
    }

    fn blockBody(self: *J, b: *const ast.Block) Error!void {
        try self.key("stmts");
        try self.open('[');
        for (b.stmts) |s| {
            try self.sep();
            try self.stmt(s);
        }
        try self.close(']');
    }

    fn stmt(self: *J, s: ast.Stmt) Error!void {
        try self.open('{');
        switch (s) {
            .bind => |b| {
                try self.tag("bind");
                try self.kStrs("names", b.names);
                try self.kBool("mutable", b.mutable);
                try self.kExprs("values", b.values);
                try self.kInt("tok", b.tok);
            },
            .assign => |a| {
                try self.tag("assign");
                try self.kExprs("targets", a.targets);
                try self.kStr("op", opSpelling(a.op));
                try self.kExprs("values", a.values);
                try self.kInt("tok", a.tok);
            },
            .ret => |r| {
                try self.tag("ret");
                try self.kExprs("values", r.values);
                try self.kInt("tok", r.tok);
            },
            .expr => |e| {
                try self.tag("expr");
                try self.key("expr");
                try self.expr(e);
            },
            .while_ => |wl| {
                try self.tag("while");
                try self.key("cond");
                try self.expr(wl.cond);
                try self.key("body");
                try self.block(wl.body);
                try self.kInt("tok", wl.tok);
            },
            .break_ => |p| {
                try self.tag("break");
                try self.kInt("tok", p);
            },
            .continue_ => |p| {
                try self.tag("continue");
                try self.kInt("tok", p);
            },
            .defer_ => |d| {
                try self.tag("defer");
                try self.key("expr");
                try self.expr(d.expr);
                try self.kInt("tok", d.tok);
            },
            .yield_ => |y| {
                try self.tag("yield");
                try self.key("expr");
                try self.expr(y.expr);
                try self.kInt("tok", y.tok);
            },
        }
        try self.close('}');
    }

    // ── 式 ───────────────────────────────────────────────────────

    fn composite(self: *J, c: ast.Composite) Error!void {
        try self.kStr("type_name", c.type_name);
        try self.key("elems");
        try self.open('[');
        for (c.elems) |el| {
            try self.sep();
            try self.open('{');
            try self.kOptStr("key", el.key);
            try self.key("value");
            try self.expr(el.value);
            try self.close('}');
        }
        try self.close(']');
        try self.kInt("tok", c.tok);
        try self.kTypes("type_args", c.type_args);
    }

    fn expr(self: *J, e: *const ast.Expr) Error!void {
        try self.open('{');
        switch (e.*) {
            .int => |n| {
                try self.tag("int");
                try self.kInt("value", n.value);
                try self.kInt("tok", n.tok);
            },
            .nil => |n| {
                try self.tag("nil");
                try self.kInt("tok", n.tok);
            },
            .ident => |n| {
                try self.tag("ident");
                try self.kStr("name", n.name);
                try self.kInt("tok", n.tok);
            },
            .binary => |n| {
                try self.tag("binary");
                try self.kStr("op", opSpelling(n.op));
                try self.key("lhs");
                try self.expr(n.lhs);
                try self.key("rhs");
                try self.expr(n.rhs);
                try self.kInt("tok", n.tok);
            },
            .unary => |n| {
                try self.tag("unary");
                try self.kStr("op", opSpelling(n.op));
                try self.key("operand");
                try self.expr(n.operand);
                try self.kInt("tok", n.tok);
            },
            .call => |n| {
                try self.tag("call");
                try self.key("callee");
                try self.expr(n.callee);
                try self.kExprs("args", n.args);
                try self.kInt("tok", n.tok);
            },
            .pipe => |n| {
                try self.tag("pipe");
                try self.key("lhs");
                try self.expr(n.lhs);
                try self.key("callee");
                try self.expr(n.callee);
                try self.key("args");
                try self.open('[');
                for (n.args) |a| {
                    try self.sep();
                    if (a) |x| try self.expr(x) else try self.w.writeAll("null");
                }
                try self.close(']');
                try self.kInt("tok", n.tok);
            },
            .index => |n| {
                try self.tag("index");
                try self.key("base");
                try self.expr(n.base);
                try self.key("idx");
                try self.expr(n.idx);
                try self.kInt("tok", n.tok);
            },
            .slice3 => |n| {
                try self.tag("slice3");
                try self.key("base");
                try self.expr(n.base);
                try self.key("lo");
                try self.expr(n.lo);
                try self.key("hi");
                try self.expr(n.hi);
                try self.kInt("tok", n.tok);
            },
            .strlit => |n| {
                try self.tag("strlit");
                try self.kStr("value", n.value);
                try self.kInt("tok", n.tok);
            },
            .interp => |n| {
                try self.tag("interp");
                try self.key("tmpl");
                try self.open('{');
                try self.kStrs("lits", n.tmpl.lits);
                try self.kExprs("holes", n.tmpl.holes);
                try self.close('}');
                try self.kInt("tok", n.tok);
            },
            .slicelit => |n| {
                try self.tag("slicelit");
                try self.key("elem");
                try self.typeExpr(n.elem);
                try self.kExprs("elems", n.elems);
                try self.kBool("mut", n.mut);
                try self.kInt("tok", n.tok);
            },
            .maplit => |n| {
                try self.tag("maplit");
                try self.key("key");
                try self.typeExpr(n.key);
                try self.key("value");
                try self.typeExpr(n.value);
                try self.key("entries");
                try self.open('[');
                for (n.entries) |en| {
                    try self.sep();
                    try self.open('{');
                    try self.key("key");
                    try self.expr(en.key);
                    try self.key("value");
                    try self.expr(en.value);
                    try self.close('}');
                }
                try self.close(']');
                try self.kBool("mut", n.mut);
                try self.kInt("tok", n.tok);
            },
            .composite => |n| {
                try self.tag("composite");
                try self.composite(n);
            },
            .selector => |n| {
                try self.tag("selector");
                try self.key("base");
                try self.expr(n.base);
                try self.kStr("field", n.field);
                try self.kInt("tok", n.tok);
            },
            .lambda => |n| {
                try self.tag("lambda");
                try self.key("params");
                try self.open('[');
                for (n.params) |p| {
                    try self.sep();
                    try self.open('{');
                    try self.kStr("name", p.name);
                    if (p.type) |t| {
                        try self.key("type");
                        try self.typeExpr(t);
                    } else try self.kNull("type");
                    try self.close('}');
                }
                try self.close(']');
                try self.key("body");
                try self.expr(n.body);
                try self.kInt("tok", n.tok);
            },
            .if_ => |n| {
                try self.tag("if");
                try self.key("cond");
                try self.expr(n.cond);
                try self.key("then");
                try self.block(n.then);
                if (n.else_) |x| {
                    try self.key("else");
                    try self.expr(x);
                } else try self.kNull("else");
                try self.kInt("tok", n.tok);
            },
            .switch_ => |n| {
                try self.tag("switch");
                try self.kExprs("subjects", n.subjects);
                try self.key("cases");
                try self.open('[');
                for (n.cases) |c| {
                    try self.sep();
                    try self.open('{');
                    try self.key("patterns");
                    try self.open('[');
                    for (c.patterns) |p| {
                        try self.sep();
                        try self.pattern(&p);
                    }
                    try self.close(']');
                    try self.key("body");
                    try self.block(c.body);
                    try self.kInt("tok", c.tok);
                    try self.close('}');
                }
                try self.close(']');
                if (n.default_) |d| {
                    try self.key("default");
                    try self.block(d);
                } else try self.kNull("default");
                try self.kInt("tok", n.tok);
            },
            .block => |b| {
                try self.tag("block");
                try self.blockBody(b);
            },
            .for_ => |n| {
                try self.tag("for");
                try self.key("gens");
                try self.open('[');
                for (n.gens) |g| {
                    try self.sep();
                    try self.open('{');
                    try self.kStrs("names", g.names);
                    try self.key("src");
                    try self.expr(g.src);
                    try self.kExprs("guards", g.guards);
                    try self.kInt("tok", g.tok);
                    try self.close('}');
                }
                try self.close(']');
                try self.key("body");
                try self.open('{');
                switch (n.body) {
                    .yield_ => |y| {
                        try self.tag("yield");
                        try self.key("expr");
                        try self.expr(y);
                    },
                    .block => |b| {
                        try self.tag("block");
                        try self.blockBody(b);
                    },
                }
                try self.close('}');
                try self.kInt("tok", n.tok);
            },
            .mut_arg => |n| {
                try self.tag("mut_arg");
                try self.kStr("name", n.name);
                try self.kInt("tok", n.tok);
            },
            .try_ => |n| {
                try self.tag("try");
                try self.key("e");
                try self.expr(n.e);
                if (n.wrap) |c| {
                    try self.key("wrap");
                    try self.open('{');
                    try self.composite(c.*);
                    try self.close('}');
                } else try self.kNull("wrap");
                try self.kInt("tok", n.tok);
            },
        }
        try self.close('}');
    }

    fn pattern(self: *J, p: *const ast.Pattern) Error!void {
        try self.open('{');
        switch (p.*) {
            .const_ => |alts| {
                try self.tag("const");
                try self.kExprs("alts", alts);
            },
            .type_ => |tp| {
                try self.tag("type");
                try self.kOptStr("bind", tp.bind);
                try self.kStr("variant", tp.variant);
                try self.key("fields");
                try self.open('[');
                for (tp.fields) |fp| {
                    try self.sep();
                    try self.open('{');
                    try self.kStr("name", fp.name);
                    if (fp.sub) |sub| {
                        try self.key("sub");
                        try self.pattern(sub);
                    } else try self.kNull("sub");
                    try self.kInt("tok", fp.tok);
                    try self.close('}');
                }
                try self.close(']');
                try self.kInt("tok", tp.tok);
            },
        }
        try self.close('}');
    }
};
