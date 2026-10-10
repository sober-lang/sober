//! CST の読み出し: S 式ダンプと、ソースへの印字（parse → print → parse の不動点オラクル用）。
const std = @import("std");
const peg = @import("peg.zig");
const Token = @import("token.zig");
const grammar = @import("grammar.zig");

pub const TERMINAL: u16 = 0xFFFF;

pub const Tree = struct {
    nodes: []const peg.CstNode,
    children: []const u32,
    tokens: []const Token,
    source: [:0]const u8,
    root: u32,

    pub fn fromMatcher(m: *const grammar.Matcher, source: [:0]const u8, root: u32) Tree {
        return .{
            .nodes = m.nodes.items,
            .children = m.children.items,
            .tokens = m.tokens,
            .source = source,
            .root = root,
        };
    }

    fn childrenOf(self: Tree, idx: u32) []const u32 {
        const n = self.nodes[idx];
        return self.children[n.children_start..n.children_end];
    }

    fn isLeaf(self: Tree, idx: u32) bool {
        const n = self.nodes[idx];
        return n.rule_id == TERMINAL and n.children_start == n.children_end;
    }
};

// ────────────────────────────────────────────────────────────────
// S 式ダンプ
// ────────────────────────────────────────────────────────────────

/// 匿名ノード（seq / alt / many / opt の包み）は平坦化し、ルールノードだけ括弧にする。
/// 終端はトークンの綴り。';' は区切りであって構造ではないので出さない
/// （不動点オラクルが `{ n }` と改行形を同じ木として比較できるように）。
pub fn sexpr(allocator: std.mem.Allocator, tree: Tree) ![]u8 {
    var w = Sexpr{ .allocator = allocator, .tree = tree };
    errdefer w.out.deinit(allocator);
    try w.node(tree.root);
    return w.out.toOwnedSlice(allocator);
}

const Sexpr = struct {
    allocator: std.mem.Allocator,
    tree: Tree,
    out: std.ArrayListUnmanaged(u8) = .empty,
    /// 出力先頭（区切り空白を入れない）。トークン '(' の直後と区別するため末尾文字は見ない
    after_open: bool = true,

    fn node(self: *Sexpr, idx: u32) std.mem.Allocator.Error!void {
        const n = self.tree.nodes[idx];
        if (n.rule_id != TERMINAL) {
            try self.sep();
            try self.out.append(self.allocator, '(');
            try self.out.appendSlice(self.allocator, grammar.ruleName(n.rule_id));
            self.after_open = false;
            for (self.tree.childrenOf(idx)) |c| try self.node(c);
            try self.out.append(self.allocator, ')');
            self.after_open = false;
            return;
        }
        if (self.tree.isLeaf(idx)) {
            if (n.token_end == n.token_start) return; // 先読み / 空 opt
            const tok = self.tree.tokens[n.token_start];
            if (tok.tag == .eof or tok.tag == .semicolon) return;
            try self.sep();
            try self.out.appendSlice(self.allocator, tok.slice(self.tree.source));
            self.after_open = false;
            return;
        }
        for (self.tree.childrenOf(idx)) |c| try self.node(c);
    }

    fn sep(self: *Sexpr) std.mem.Allocator.Error!void {
        if (self.after_open) return;
        try self.out.append(self.allocator, ' ');
    }
};

// ────────────────────────────────────────────────────────────────
// 印字（正規形）
// ────────────────────────────────────────────────────────────────

/// CST を Go 風の正規形で印字する。
/// - '{' の後と ';' の位置で改行、ブレース深さでインデント（4 スペース）
/// - 呼び出しの '(' 、')' ']' ',' ';' '.' の前、'(' '[' '.' の後には空白を置かない
/// - 単項演算子の後には空白を置かない（unary_op ルールで判定）
pub fn print(allocator: std.mem.Allocator, tree: Tree) ![]u8 {
    var p = Printer{ .allocator = allocator, .tree = tree };
    errdefer p.out.deinit(allocator);
    try p.node(tree.root);
    if (p.out.items.len > 0 and p.out.items[p.out.items.len - 1] != '\n') try p.out.append(allocator, '\n');
    return p.out.toOwnedSlice(allocator);
}

const Printer = struct {
    allocator: std.mem.Allocator,
    tree: Tree,
    out: std.ArrayListUnmanaged(u8) = .empty,
    indent: u32 = 0,
    prev: ?Token.Tag = null,
    at_line_start: bool = true,
    /// 直前が単項演算子: 次のトークンとの間に空白を置かない
    glue_next: bool = false,
    /// 直前が '{': 次が '}' なら `{}`、それ以外なら改行してから出す
    block_open: bool = false,
    /// 次のトークンの前に必ず空白を置く（result ルールの先頭）
    space_next: bool = false,
    /// literal_value の入れ子深さ（> 0 なら { } を一行に詰める）
    literal_depth: u32 = 0,
    /// type / literal_type の入れ子深さ（> 0 なら ] と * の後を密着）
    type_depth: u32 = 0,
    /// variant 本体の入れ子深さ（> 0 なら `{ a; b }` と一行に書く）
    inline_block_depth: u32 = 0,
    /// inline block 内で ';' を見た（次が '}' でなければ "; " を出す）
    pending_semi: bool = false,
    /// inline block の '{' を出した直後
    inline_open: bool = false,
    /// generators の中（';' を "; " と書く）
    semi_inline_depth: u32 = 0,
    /// top_level_decl の注釈部分（各注釈の後で改行）
    top_annot: bool = false,
    /// import_decl の中（'(' ')' をブロック扱い）
    import_group: bool = false,
    /// case ヘッダの中（pattern_depth == 0 での ':' がヘッダの終わり）
    in_case_header: bool = false,
    pattern_depth: u32 = 0,

    fn node(self: *Printer, idx: u32) std.mem.Allocator.Error!void {
        const n = self.tree.nodes[idx];
        if (n.rule_id != TERMINAL) {
            const name = grammar.ruleName(n.rule_id);
            const eq = std.mem.eql;
            // トップレベル宣言の間は空行
            const is_top = eq(u8, name, "top_level_decl");
            if (is_top and self.out.items.len > 0) {
                try self.newline();
                try self.out.append(self.allocator, '\n');
            }
            // トップレベルの注釈は自分の行（宣言本体が始まるまで）
            if (is_top) self.top_annot = true;
            if (eq(u8, name, "const_decl") or eq(u8, name, "func_decl") or eq(u8, name, "type_decl") or eq(u8, name, "bind_decl")) self.top_annot = false;
            const is_annotation = eq(u8, name, "annotation");
            // import ( ... ) のグループは ( ) をブロックのように改行 + インデント
            const is_import = eq(u8, name, "import_decl");
            if (is_import) self.import_group = true;
            // 戻り値の '(' は呼び出しではないので直前の ')' と離す
            if (eq(u8, name, "result")) self.space_next = true;
            // composite literal の { } はブロックではなく一行に詰める
            const is_literal = eq(u8, name, "literal_value");
            if (is_literal) self.literal_depth += 1;
            // 型の中では [] * map[..] を後続に密着させる
            const is_type = eq(u8, name, "type") or eq(u8, name, "literal_type");
            if (is_type) self.type_depth += 1;
            // case 節: ヘッダの ':' で改行して本体を 1 段深く
            const is_case = eq(u8, name, "case_clause");
            if (is_case) self.in_case_header = true;
            const is_pattern = eq(u8, name, "pattern_list");
            if (is_pattern) self.pattern_depth += 1;
            // 型パターンの { } は literal と同じ詰め方
            const is_type_pattern = eq(u8, name, "type_pattern");
            if (is_type_pattern) self.literal_depth += 1;
            // union の variant 本体 `Rect { w, h int }` は一行のブロック
            // for のジェネレータ間の ';' は改行ではなく "; "
            const is_semi_inline = eq(u8, name, "generators");
            if (is_semi_inline) self.semi_inline_depth += 1;
            const is_inline_block = eq(u8, name, "variant");
            if (is_inline_block) self.inline_block_depth += 1;
            // `x []int` `y map[K]V`: 名前の直後に始まる型は離す（`]` `*` の後は密着のまま）
            if (eq(u8, name, "type") and self.prev == .identifier and !self.glue_next) self.space_next = true;
            for (self.tree.childrenOf(idx)) |c| try self.node(c);
            if (is_literal) self.literal_depth -= 1;
            if (is_type) {
                self.type_depth -= 1;
                self.glue_next = false; // 型の外に出たら `]` の密着は終わり（`Iter[T] {` のブロック）
            }
            if (is_semi_inline) self.semi_inline_depth -= 1;
            if (is_type_pattern) self.literal_depth -= 1;
            if (is_inline_block) self.inline_block_depth -= 1;
            if (is_pattern) self.pattern_depth -= 1;
            if (is_case) self.indent -|= 1;
            if (eq(u8, name, "unary_op")) self.glue_next = true;
            if (is_annotation and self.top_annot) try self.newline();
            if (is_import) self.import_group = false;
            return;
        }
        if (self.tree.isLeaf(idx)) {
            if (n.token_end == n.token_start) return;
            try self.leaf(self.tree.tokens[n.token_start]);
            return;
        }
        for (self.tree.childrenOf(idx)) |c| try self.node(c);
    }

    fn leaf(self: *Printer, tok: Token) std.mem.Allocator.Error!void {
        if (tok.tag == .eof) return;

        if (self.inline_block_depth > 0 and self.literal_depth == 0) {
            switch (tok.tag) {
                .semicolon => {
                    self.pending_semi = true;
                    return;
                },
                .r_brace => {
                    self.pending_semi = false;
                    self.inline_open = false;
                    if (self.prev != .l_brace) try self.out.append(self.allocator, ' ');
                    try self.out.append(self.allocator, '}');
                    self.prev = .r_brace;
                    return;
                },
                .l_brace => {
                    try self.out.appendSlice(self.allocator, " {");
                    self.prev = .l_brace;
                    self.inline_open = true;
                    return;
                },
                else => {
                    if (self.pending_semi) {
                        self.pending_semi = false;
                        try self.out.append(self.allocator, ';');
                    }
                    if (self.inline_open) {
                        self.inline_open = false;
                        try self.out.append(self.allocator, ' ');
                        self.glue_next = true; // 空白はここで出したので needsSpace に足させない
                    }
                },
            }
        }

        if (self.literal_depth > 0 and (tok.tag == .l_brace or tok.tag == .r_brace)) {
            if (self.block_open) {
                self.block_open = false;
                try self.newline();
            }
            if (self.at_line_start) try self.writeIndent();
            // `T{` `{1, 2}` は密着、`{{1}, {2}}` の内側 `{` は ', ' の後なので needsSpace に任せる
            if (tok.tag == .l_brace and self.prev != null and self.prev.? != .comma and self.prev.? != .colon and self.prev.? != .l_brace) {} else if (tok.tag == .l_brace and self.needsSpace(tok.tag)) try self.out.append(self.allocator, ' ');
            try self.out.append(self.allocator, if (tok.tag == .l_brace) '{' else '}');
            self.prev = tok.tag;
            self.at_line_start = false;
            self.glue_next = false;
            self.space_next = false;
            return;
        }

        const is_close = tok.tag == .r_brace or (self.import_group and tok.tag == .r_paren);
        const is_open = tok.tag == .l_brace or (self.import_group and tok.tag == .l_paren);
        if (is_close and self.block_open) {
            self.block_open = false;
            self.indent -|= 1;
            try self.out.appendSlice(self.allocator, tok.slice(self.tree.source));
            self.prev = tok.tag;
            return;
        }
        if (self.block_open) {
            self.block_open = false;
            try self.newline();
        }

        switch (tok.tag) {
            .colon => {
                try self.out.append(self.allocator, ':');
                self.prev = .colon;
                self.at_line_start = false;
                if (self.in_case_header and self.pattern_depth == 0) {
                    self.in_case_header = false;
                    self.indent += 1;
                    try self.newline();
                }
            },
            .semicolon => {
                if (self.semi_inline_depth > 0) {
                    try self.out.append(self.allocator, ';');
                } else {
                    // 文の区切りは常に改行（明示 ';' も正規形では改行）
                    try self.newline();
                }
                self.prev = .semicolon;
            },
            else => if (is_close) {
                self.indent -|= 1;
                try self.newline();
                try self.writeIndent();
                try self.out.appendSlice(self.allocator, tok.slice(self.tree.source));
                self.prev = tok.tag;
                self.at_line_start = false;
            } else {
                if (self.at_line_start) {
                    try self.writeIndent();
                } else if (self.needsSpace(tok.tag)) {
                    try self.out.append(self.allocator, ' ');
                }
                try self.out.appendSlice(self.allocator, tok.slice(self.tree.source));
                self.prev = tok.tag;
                self.at_line_start = false;
                self.glue_next = false;
                self.space_next = false;
                if (is_open) {
                    self.indent += 1;
                    self.block_open = true;
                }
                if (self.type_depth > 0 and (tok.tag == .r_bracket or tok.tag == .star)) self.glue_next = true;
            },
        }
    }

    fn needsSpace(self: *Printer, tag: Token.Tag) bool {
        if (self.glue_next) return false;
        if (self.space_next) return true;
        const prev = self.prev orelse return false;
        switch (prev) {
            .l_paren, .l_bracket, .dot, .at => return false,
            .l_brace => if (self.literal_depth > 0) return false,
            else => {},
        }
        return switch (tag) {
            .r_paren, .r_bracket, .comma, .dot, .question, .colon, .semicolon => false,
            .l_paren => switch (prev) {
                .identifier, .r_paren, .r_bracket, .keyword_func, .keyword_scope => self.import_group,
                else => true,
            },
            .l_bracket => switch (prev) {
                .identifier, .r_paren, .r_bracket, .keyword_map => false,
                else => true,
            },
            .l_brace => switch (prev) {
                // composite literal の型と '{' は密着（literal_depth 側で処理されなかった場合の保険）
                .r_bracket, .identifier => self.literal_depth == 0,
                else => true,
            },
            else => true,
        };
    }

    fn newline(self: *Printer) !void {
        if (self.at_line_start) return; // 連続する区切りは 1 改行
        try self.out.append(self.allocator, '\n');
        self.at_line_start = true;
    }

    fn writeIndent(self: *Printer) !void {
        var i: u32 = 0;
        while (i < self.indent) : (i += 1) try self.out.appendSlice(self.allocator, "    ");
    }
};
