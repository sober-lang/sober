/// comptime PEG パーサー
/// token.zig の Token.Tag をターミナルとして使う
/// lexer.zig, parser.zig, ast.zig には依存しない
const std = @import("std");
const Token = @import("token.zig");

// ────────────────────────────────────────────────────────────────
// 型定義
// ────────────────────────────────────────────────────────────────

pub const Expr = union(enum) {
    token: Token.Tag, // ターミナル: 特定のトークンにマッチ
    rule_ref: u16, // 他ルールへの参照（comptime でインデックスに解決済み）
    seq: []const Expr, // 連接: e1 e2 e3
    alt: []const Expr, // 順序付き選択: e1 / e2 / e3
    many: *const Expr, // 0回以上: e*
    many1: *const Expr, // 1回以上: e+
    opt: *const Expr, // オプション: e?
    pos: *const Expr, // 肯定先読み: &e
    neg: *const Expr, // 否定先読み: !e
};

pub const Rule = struct {
    name: []const u8,
    expr: Expr,
};

pub const Grammar = struct {
    rules: []const Rule,
};

// ────────────────────────────────────────────────────────────────
// ターミナル → Token.Tag マッピング（comptime）
// ────────────────────────────────────────────────────────────────

/// 大文字名 (IDENT 等) または引用符リテラル ('func' '(' 等) を Token.Tag に解決する。
/// 綴りの表は token.zig の keywords / symbols（lexer と共有）
pub fn resolveTerminal(comptime name: []const u8) Token.Tag {
    if (comptime strEql(name, "IDENT")) return .identifier;
    if (comptime strEql(name, "INT")) return .integer_literal;
    if (comptime strEql(name, "STR")) return .string_literal;
    if (comptime strEql(name, "RAWSTR")) return .raw_string_literal;
    if (comptime strEql(name, "EOF")) return .eof;

    // StaticStringMap.get は comptime クロスモジュール呼び出しで信頼できないため線形走査
    inline for (Token.keywords) |entry| {
        if (comptime strEql(name, entry[0])) return entry[1];
    }
    inline for (Token.symbols) |entry| {
        if (comptime strEql(name, entry[0])) return entry[1];
    }

    @compileError("unknown terminal: '" ++ name ++ "'");
}

fn strEql(comptime a: []const u8, comptime b: []const u8) bool {
    if (a.len != b.len) return false;
    for (a, b) |x, y| {
        if (x != y) return false;
    }
    return true;
}

// ────────────────────────────────────────────────────────────────
// comptime PEG パーサー
// ────────────────────────────────────────────────────────────────

/// 文法テキストを comptime でパースして Grammar を返す
pub fn compile(comptime source: []const u8) Grammar {
    @setEvalBranchQuota(100000);
    // ── パス1: ルール名を収集 ──────────────────────────────────
    comptime var rule_names_buf: [256][]const u8 = undefined;
    comptime var rule_count: usize = 0;

    comptime {
        var lines = splitLines(source);
        while (lines.next()) |line| {
            const trimmed = trimLeft(line);
            if (trimmed.len == 0) continue; // 空行
            if (startsWith(trimmed, "//")) continue; // コメント行
            // `rule_name <-` を探す
            if (indexOfStr(trimmed, "<-")) |arrow_pos| {
                const name = trimRight(trimmed[0..arrow_pos]);
                if (name.len > 0) {
                    rule_names_buf[rule_count] = name;
                    rule_count += 1;
                }
            }
        }
    }

    const rule_names = rule_names_buf[0..rule_count];

    // ── パス2: 各行の式をパース ───────────────────────────────
    comptime var rules_buf: [256]Rule = undefined;
    comptime var rules_out: usize = 0;

    comptime {
        var lines = splitLines(source);
        while (lines.next()) |line| {
            const trimmed = trimLeft(line);
            if (trimmed.len == 0) continue;
            if (startsWith(trimmed, "//")) continue;
            if (indexOfStr(trimmed, "<-")) |arrow_pos| {
                const name = trimRight(trimmed[0..arrow_pos]);
                if (name.len == 0) continue;
                const rest = trimLeft(trimmed[arrow_pos + 2 ..]);
                var ctx = ParseCtx{ .src = rest, .pos = 0, .rule_names = rule_names };
                const expr = ctx.parseAlt();
                rules_buf[rules_out] = Rule{ .name = name, .expr = expr };
                rules_out += 1;
            }
        }
    }

    // comptime var から const に昇格（Matcher に渡せるようにする）
    const final_rules: [rules_out]Rule = rules_buf[0..rules_out].*;
    return Grammar{ .rules = &final_rules };
}

// ────────────────────────────────────────────────────────────────
// 再帰下降パーサー（comptime）
// ────────────────────────────────────────────────────────────────

const ParseCtx = struct {
    src: []const u8,
    pos: usize,
    rule_names: []const []const u8,

    fn peek(self: *ParseCtx) ?u8 {
        if (self.pos >= self.src.len) return null;
        return self.src[self.pos];
    }

    fn advance(self: *ParseCtx) void {
        self.pos += 1;
    }

    fn skipWs(self: *ParseCtx) void {
        while (self.pos < self.src.len) {
            switch (self.src[self.pos]) {
                ' ', '\t', '\r' => self.pos += 1,
                else => break,
            }
        }
    }

    /// 優先順位1: 順序付き選択 (/)
    fn parseAlt(self: *ParseCtx) Expr {
        self.skipWs();
        comptime var buf: [64]Expr = undefined;
        comptime var count: usize = 0;
        buf[count] = self.parseSeq();
        count += 1;

        while (true) {
            self.skipWs();
            // '/' の後に空白か識別子が続く場合のみ選択演算子
            if (self.pos < self.src.len and self.src[self.pos] == '/') {
                // 選択演算子か記号リテラル内かを判断
                // ここでは '/' 単独を選択演算子として扱う
                self.pos += 1;
                self.skipWs();
                buf[count] = self.parseSeq();
                count += 1;
            } else {
                break;
            }
        }

        if (count == 1) return buf[0];
        const exprs: [count]Expr = buf[0..count].*;
        return Expr{ .alt = &exprs };
    }

    /// 優先順位2: 連接（空白区切りの並び）
    fn parseSeq(self: *ParseCtx) Expr {
        self.skipWs();
        comptime var buf: [64]Expr = undefined;
        comptime var count: usize = 0;

        while (true) {
            self.skipWs();
            if (self.pos >= self.src.len) break;
            const ch = self.src[self.pos];
            // 終端条件: '/' は上位に返す、')' はグループ終端
            if (ch == '/' or ch == ')') break;
            buf[count] = self.parsePrefix();
            count += 1;
        }

        if (count == 1) return buf[0];
        if (count == 0) @compileError("empty sequence");
        const exprs: [count]Expr = buf[0..count].*;
        return Expr{ .seq = &exprs };
    }

    /// 優先順位3: 接頭辞 (&, !)
    fn parsePrefix(self: *ParseCtx) Expr {
        self.skipWs();
        if (self.pos >= self.src.len) @compileError("unexpected end of input");
        const ch = self.src[self.pos];
        if (ch == '&') {
            self.advance();
            const inner = self.parseSuffix();
            const ptr: *const Expr = &inner;
            return Expr{ .pos = ptr };
        }
        if (ch == '!') {
            self.advance();
            const inner = self.parseSuffix();
            const ptr: *const Expr = &inner;
            return Expr{ .neg = ptr };
        }
        return self.parseSuffix();
    }

    /// 優先順位4: 接尾辞 (*, +, ?)
    fn parseSuffix(self: *ParseCtx) Expr {
        const inner = self.parsePrimary();
        self.skipWs();
        if (self.pos < self.src.len) {
            switch (self.src[self.pos]) {
                '*' => {
                    self.advance();
                    const ptr: *const Expr = &inner;
                    return Expr{ .many = ptr };
                },
                '+' => {
                    self.advance();
                    const ptr: *const Expr = &inner;
                    return Expr{ .many1 = ptr };
                },
                '?' => {
                    self.advance();
                    const ptr: *const Expr = &inner;
                    return Expr{ .opt = ptr };
                },
                else => {},
            }
        }
        return inner;
    }

    /// 優先順位5: 一次式（ターミナル、ルール参照、グループ）
    fn parsePrimary(self: *ParseCtx) Expr {
        self.skipWs();
        if (self.pos >= self.src.len) @compileError("unexpected end of input in primary");
        const ch = self.src[self.pos];

        // グループ: (...)
        if (ch == '(') {
            self.advance();
            const inner = self.parseAlt();
            self.skipWs();
            if (self.pos >= self.src.len or self.src[self.pos] != ')') {
                @compileError("expected ')' to close group");
            }
            self.advance();
            return inner;
        }

        // 引用符リテラル: '...'
        if (ch == '\'') {
            self.advance();
            const start = self.pos;
            while (self.pos < self.src.len and self.src[self.pos] != '\'') {
                self.pos += 1;
            }
            if (self.pos >= self.src.len) @compileError("unterminated quoted literal");
            const literal = self.src[start..self.pos];
            self.advance(); // closing '
            const tag = resolveTerminal(literal);
            return Expr{ .token = tag };
        }

        // 大文字名（ターミナル）または小文字名（ルール参照）
        if (isAlpha(ch) or ch == '_') {
            const start = self.pos;
            while (self.pos < self.src.len and (isAlphaNum(self.src[self.pos]) or self.src[self.pos] == '_')) {
                self.pos += 1;
            }
            const name = self.src[start..self.pos];

            // 大文字かどうか判定: 最初の文字が大文字
            if (name[0] >= 'A' and name[0] <= 'Z') {
                // ターミナル: 大文字名
                const tag = resolveTerminal(name);
                return Expr{ .token = tag };
            } else {
                // ルール参照: ルール名配列でインデックスを探す
                for (self.rule_names, 0..) |rname, i| {
                    if (strEql(rname, name)) {
                        return Expr{ .rule_ref = @intCast(i) };
                    }
                }
                @compileError("unknown rule reference: '" ++ name ++ "'");
            }
        }

        @compileError("unexpected character in PEG expression");
    }
};

fn isAlpha(c: u8) bool {
    return (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z');
}

fn isAlphaNum(c: u8) bool {
    return isAlpha(c) or (c >= '0' and c <= '9');
}

// ────────────────────────────────────────────────────────────────
// 文字列ユーティリティ（comptime 対応）
// ────────────────────────────────────────────────────────────────

fn trimLeft(s: []const u8) []const u8 {
    var i: usize = 0;
    while (i < s.len and (s[i] == ' ' or s[i] == '\t')) i += 1;
    return s[i..];
}

fn trimRight(s: []const u8) []const u8 {
    var i: usize = s.len;
    while (i > 0 and (s[i - 1] == ' ' or s[i - 1] == '\t')) i -= 1;
    return s[0..i];
}

fn startsWith(s: []const u8, prefix: []const u8) bool {
    if (s.len < prefix.len) return false;
    return strEql(s[0..prefix.len], prefix);
}

fn indexOfStr(haystack: []const u8, needle: []const u8) ?usize {
    if (needle.len == 0) return 0;
    if (haystack.len < needle.len) return null;
    var i: usize = 0;
    while (i <= haystack.len - needle.len) : (i += 1) {
        if (strEql(haystack[i .. i + needle.len], needle)) return i;
    }
    return null;
}

/// 行イテレータ
const LineIter = struct {
    src: []const u8,
    pos: usize,

    fn next(self: *LineIter) ?[]const u8 {
        if (self.pos >= self.src.len) return null;
        const start = self.pos;
        while (self.pos < self.src.len and self.src[self.pos] != '\n') {
            self.pos += 1;
        }
        const line = self.src[start..self.pos];
        if (self.pos < self.src.len) self.pos += 1; // skip '\n'
        return line;
    }
};

fn splitLines(s: []const u8) LineIter {
    return LineIter{ .src = s, .pos = 0 };
}

// ────────────────────────────────────────────────────────────────
// ランタイムマッチャー
// ────────────────────────────────────────────────────────────────

/// ランタイム CST ノード
pub const CstNode = struct {
    /// マッチしたルールのインデックス (0xFFFF = ターミナル)
    rule_id: u16,
    /// 開始トークンインデックス
    token_start: u32,
    /// 終了トークンインデックス（排他）
    token_end: u32,
    /// children バッファ内の開始
    children_start: u32,
    /// children バッファ内の終了
    children_end: u32,
};

/// comptime Grammar を受け取り、ランタイムマッチャー型を返す
pub fn Matcher(comptime grammar: Grammar) type {
    return struct {
        tokens: []const Token,
        pos: usize,
        /// 照合を試みて失敗した最も先のトークン位置（parse が null のときの診断位置）
        farthest: usize = 0,
        allocator: std.mem.Allocator,
        nodes: std.ArrayListUnmanaged(CstNode),
        children: std.ArrayListUnmanaged(u32),

        const Self = @This();
        const TERMINAL_RULE_ID: u16 = 0xFFFF;

        pub fn init(allocator: std.mem.Allocator, tokens: []const Token) Self {
            return Self{
                .tokens = tokens,
                .pos = 0,
                .allocator = allocator,
                .nodes = .empty,
                .children = .empty,
            };
        }

        pub fn deinit(self: *Self) void {
            self.nodes.deinit(self.allocator);
            self.children.deinit(self.allocator);
        }

        /// 指定ルール名からマッチを開始する。成功時はルート CstNode インデックス、失敗時は null
        pub fn parse(self: *Self, comptime rule_name: []const u8) std.mem.Allocator.Error!?u32 {
            // ルール名からインデックスを解決（comptime）
            const rule_idx: u16 = comptime blk: {
                for (grammar.rules, 0..) |rule, i| {
                    if (strEql(rule.name, rule_name)) break :blk @intCast(i);
                }
                @compileError("unknown rule: '" ++ rule_name ++ "'");
            };
            return self.matchRule(rule_idx);
        }

        /// 特定ルールにマッチ
        fn matchRule(self: *Self, rule_idx: u16) std.mem.Allocator.Error!?u32 {
            const saved_pos = self.pos;
            const saved_nodes = self.nodes.items.len;
            const saved_children = self.children.items.len;

            const expr = &grammar.rules[rule_idx].expr;
            const result = try self.matchExpr(expr);
            if (result == null) {
                self.pos = saved_pos;
                self.nodes.shrinkRetainingCapacity(saved_nodes);
                self.children.shrinkRetainingCapacity(saved_children);
                return null;
            }

            // マッチしたサブツリーをこのルールのノードでラップする
            const child_idx = result.?;
            // ルールノードの children はこのサブノードを直接格納
            const children_start: u32 = @intCast(self.children.items.len);
            try self.children.append(self.allocator, child_idx);
            const children_end: u32 = @intCast(self.children.items.len);

            const sub = self.nodes.items[child_idx];
            const node = CstNode{
                .rule_id = rule_idx,
                .token_start = sub.token_start,
                .token_end = sub.token_end,
                .children_start = children_start,
                .children_end = children_end,
            };
            const node_idx: u32 = @intCast(self.nodes.items.len);
            try self.nodes.append(self.allocator, node);
            return node_idx;
        }

        /// Expr をランタイムディスパッチでマッチ。成功時はノードインデックス、失敗時は null
        fn matchExpr(self: *Self, expr: *const Expr) std.mem.Allocator.Error!?u32 {
            switch (expr.*) {
                .token => |tag| {
                    if (self.pos >= self.tokens.len) return null;
                    const tok = self.tokens[self.pos];
                    if (tok.tag != tag) {
                        if (self.pos > self.farthest) self.farthest = self.pos;
                        return null;
                    }
                    const start: u32 = @intCast(self.pos);
                    self.pos += 1;
                    const end: u32 = @intCast(self.pos);
                    const node = CstNode{
                        .rule_id = TERMINAL_RULE_ID,
                        .token_start = start,
                        .token_end = end,
                        .children_start = 0,
                        .children_end = 0,
                    };
                    const idx: u32 = @intCast(self.nodes.items.len);
                    try self.nodes.append(self.allocator, node);
                    return idx;
                },

                .rule_ref => |idx| {
                    return self.matchRule(idx);
                },

                .seq => |elems| {
                    const saved_pos = self.pos;
                    const saved_nodes = self.nodes.items.len;
                    const saved_children = self.children.items.len;

                    const token_start: u32 = @intCast(self.pos);

                    // 各要素の結果を一時バッファに収集してから children に追加する。
                    // こうすることで seq ノードの children が「seq 自身の直接の子のみ」になる。
                    var direct_buf: [64]u32 = undefined;
                    var direct_count: usize = 0;

                    for (elems) |*elem| {
                        const r = try self.matchExpr(elem);
                        if (r == null) {
                            self.pos = saved_pos;
                            self.nodes.shrinkRetainingCapacity(saved_nodes);
                            self.children.shrinkRetainingCapacity(saved_children);
                            return null;
                        }
                        direct_buf[direct_count] = r.?;
                        direct_count += 1;
                    }

                    // まとめて children に追加
                    const children_start: u32 = @intCast(self.children.items.len);
                    for (direct_buf[0..direct_count]) |child_idx| {
                        try self.children.append(self.allocator, child_idx);
                    }
                    const token_end: u32 = @intCast(self.pos);
                    const children_end: u32 = @intCast(self.children.items.len);

                    const node = CstNode{
                        .rule_id = TERMINAL_RULE_ID,
                        .token_start = token_start,
                        .token_end = token_end,
                        .children_start = children_start,
                        .children_end = children_end,
                    };
                    const idx: u32 = @intCast(self.nodes.items.len);
                    try self.nodes.append(self.allocator, node);
                    return idx;
                },

                .alt => |elems| {
                    for (elems) |*elem| {
                        const saved_pos = self.pos;
                        const saved_nodes = self.nodes.items.len;
                        const saved_children = self.children.items.len;

                        const r = try self.matchExpr(elem);
                        if (r != null) return r;

                        self.pos = saved_pos;
                        self.nodes.shrinkRetainingCapacity(saved_nodes);
                        self.children.shrinkRetainingCapacity(saved_children);
                    }
                    return null;
                },

                .many, .many1 => |inner| {
                    const token_start: u32 = @intCast(self.pos);

                    // 反復の各結果を一時バッファに集めてから children に追加する。
                    // 内側のマッチも同じ children バッファに書くので、逐次 append すると
                    // この反復ノードの範囲が内側ノードの子を巻き込む（古くからのバグ）。
                    var direct: std.ArrayListUnmanaged(u32) = .empty;
                    defer direct.deinit(self.allocator);

                    while (true) {
                        const saved_pos = self.pos;
                        const saved_nodes = self.nodes.items.len;
                        const saved_children = self.children.items.len;

                        const r = try self.matchExpr(inner);
                        if (r == null) {
                            self.pos = saved_pos;
                            self.nodes.shrinkRetainingCapacity(saved_nodes);
                            self.children.shrinkRetainingCapacity(saved_children);
                            break;
                        }
                        try direct.append(self.allocator, r.?);
                        if (self.pos == saved_pos) break; // 空マッチの無限ループ防止
                    }
                    if (expr.* == .many1 and direct.items.len == 0) return null;

                    const children_start: u32 = @intCast(self.children.items.len);
                    try self.children.appendSlice(self.allocator, direct.items);
                    const token_end: u32 = @intCast(self.pos);
                    const children_end: u32 = @intCast(self.children.items.len);

                    const node = CstNode{
                        .rule_id = TERMINAL_RULE_ID,
                        .token_start = token_start,
                        .token_end = token_end,
                        .children_start = children_start,
                        .children_end = children_end,
                    };
                    const idx: u32 = @intCast(self.nodes.items.len);
                    try self.nodes.append(self.allocator, node);
                    return idx;
                },

                .opt => |inner| {
                    const token_start: u32 = @intCast(self.pos);

                    const saved_pos = self.pos;
                    const saved_nodes = self.nodes.items.len;
                    const saved_children = self.children.items.len;

                    const r = try self.matchExpr(inner);
                    if (r != null) return r;

                    // マッチしなかった場合: 巻き戻して空のノードを返す
                    self.pos = saved_pos;
                    self.nodes.shrinkRetainingCapacity(saved_nodes);
                    self.children.shrinkRetainingCapacity(saved_children);

                    const token_end: u32 = @intCast(self.pos);
                    const node = CstNode{
                        .rule_id = TERMINAL_RULE_ID,
                        .token_start = token_start,
                        .token_end = token_end,
                        .children_start = 0,
                        .children_end = 0,
                    };
                    const idx: u32 = @intCast(self.nodes.items.len);
                    try self.nodes.append(self.allocator, node);
                    return idx;
                },

                .pos => |inner| {
                    const saved_pos = self.pos;
                    const saved_nodes = self.nodes.items.len;
                    const saved_children = self.children.items.len;

                    const r = try self.matchExpr(inner);

                    // 入力を消費しない: 常にposを戻す
                    self.pos = saved_pos;
                    self.nodes.shrinkRetainingCapacity(saved_nodes);
                    self.children.shrinkRetainingCapacity(saved_children);

                    if (r == null) return null;

                    // 成功: 空のノードを返す（消費なし）
                    const node = CstNode{
                        .rule_id = TERMINAL_RULE_ID,
                        .token_start = @intCast(self.pos),
                        .token_end = @intCast(self.pos),
                        .children_start = 0,
                        .children_end = 0,
                    };
                    const idx: u32 = @intCast(self.nodes.items.len);
                    try self.nodes.append(self.allocator, node);
                    return idx;
                },

                .neg => |inner| {
                    const saved_pos = self.pos;
                    const saved_nodes = self.nodes.items.len;
                    const saved_children = self.children.items.len;

                    const r = try self.matchExpr(inner);

                    // 入力を消費しない: 常にposを戻す
                    self.pos = saved_pos;
                    self.nodes.shrinkRetainingCapacity(saved_nodes);
                    self.children.shrinkRetainingCapacity(saved_children);

                    if (r != null) return null; // マッチしたら失敗

                    // 失敗なら成功: 空のノードを返す（消費なし）
                    const node = CstNode{
                        .rule_id = TERMINAL_RULE_ID,
                        .token_start = @intCast(self.pos),
                        .token_end = @intCast(self.pos),
                        .children_start = 0,
                        .children_end = 0,
                    };
                    const idx: u32 = @intCast(self.nodes.items.len);
                    try self.nodes.append(self.allocator, node);
                    return idx;
                },
            }
        }
    };
}
