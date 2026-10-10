const std = @import("std");
const peg = @import("peg.zig");
const Token = @import("token.zig");
const Lexer = @import("lexer.zig");

const Expr = peg.Expr;
const Grammar = peg.Grammar;

// ────────────────────────────────────────────────────────────────
// ヘルパー
// ────────────────────────────────────────────────────────────────

fn expectToken(expr: Expr, tag: Token.Tag) !void {
    switch (expr) {
        .token => |t| try std.testing.expectEqual(tag, t),
        else => {
            std.debug.print("expected .token, got {s}\n", .{@tagName(expr)});
            return error.WrongExprKind;
        },
    }
}

fn expectRuleRef(expr: Expr, idx: u16) !void {
    switch (expr) {
        .rule_ref => |i| try std.testing.expectEqual(idx, i),
        else => {
            std.debug.print("expected .rule_ref, got {s}\n", .{@tagName(expr)});
            return error.WrongExprKind;
        },
    }
}

// ────────────────────────────────────────────────────────────────
// テスト: 最小文法 (rule <- IDENT)
// ────────────────────────────────────────────────────────────────

test "minimal grammar: rule <- IDENT" {
    const g = comptime peg.compile("rule <- IDENT");
    try std.testing.expectEqual(@as(usize, 1), g.rules.len);
    try std.testing.expectEqualStrings("rule", g.rules[0].name);
    try expectToken(g.rules[0].expr, .identifier);
}

// ────────────────────────────────────────────────────────────────
// テスト: 連接 (rule <- IDENT '(' ')')
// ────────────────────────────────────────────────────────────────

test "sequence: rule <- IDENT '(' ')'" {
    const g = comptime peg.compile("rule <- IDENT '(' ')'");
    try std.testing.expectEqual(@as(usize, 1), g.rules.len);
    const expr = g.rules[0].expr;
    switch (expr) {
        .seq => |elems| {
            try std.testing.expectEqual(@as(usize, 3), elems.len);
            try expectToken(elems[0], .identifier);
            try expectToken(elems[1], .l_paren);
            try expectToken(elems[2], .r_paren);
        },
        else => {
            std.debug.print("expected .seq, got {s}\n", .{@tagName(expr)});
            return error.WrongExprKind;
        },
    }
}

// ────────────────────────────────────────────────────────────────
// テスト: 順序付き選択 (rule <- IDENT / INT)
// ────────────────────────────────────────────────────────────────

test "ordered choice: rule <- IDENT / INT" {
    const g = comptime peg.compile("rule <- IDENT / INT");
    try std.testing.expectEqual(@as(usize, 1), g.rules.len);
    const expr = g.rules[0].expr;
    switch (expr) {
        .alt => |elems| {
            try std.testing.expectEqual(@as(usize, 2), elems.len);
            try expectToken(elems[0], .identifier);
            try expectToken(elems[1], .integer_literal);
        },
        else => {
            std.debug.print("expected .alt, got {s}\n", .{@tagName(expr)});
            return error.WrongExprKind;
        },
    }
}

// ────────────────────────────────────────────────────────────────
// テスト: 繰り返し (rule <- IDENT*)
// ────────────────────────────────────────────────────────────────

test "many: rule <- IDENT*" {
    const g = comptime peg.compile("rule <- IDENT*");
    try std.testing.expectEqual(@as(usize, 1), g.rules.len);
    const expr = g.rules[0].expr;
    switch (expr) {
        .many => |inner| {
            try expectToken(inner.*, .identifier);
        },
        else => {
            std.debug.print("expected .many, got {s}\n", .{@tagName(expr)});
            return error.WrongExprKind;
        },
    }
}

// ────────────────────────────────────────────────────────────────
// テスト: 1回以上 (rule <- IDENT+)
// ────────────────────────────────────────────────────────────────

test "many1: rule <- IDENT+" {
    const g = comptime peg.compile("rule <- IDENT+");
    try std.testing.expectEqual(@as(usize, 1), g.rules.len);
    const expr = g.rules[0].expr;
    switch (expr) {
        .many1 => |inner| {
            try expectToken(inner.*, .identifier);
        },
        else => {
            std.debug.print("expected .many1, got {s}\n", .{@tagName(expr)});
            return error.WrongExprKind;
        },
    }
}

// ────────────────────────────────────────────────────────────────
// テスト: オプション (rule <- IDENT?)
// ────────────────────────────────────────────────────────────────

test "opt: rule <- IDENT?" {
    const g = comptime peg.compile("rule <- IDENT?");
    try std.testing.expectEqual(@as(usize, 1), g.rules.len);
    const expr = g.rules[0].expr;
    switch (expr) {
        .opt => |inner| {
            try expectToken(inner.*, .identifier);
        },
        else => {
            std.debug.print("expected .opt, got {s}\n", .{@tagName(expr)});
            return error.WrongExprKind;
        },
    }
}

// ────────────────────────────────────────────────────────────────
// テスト: グルーピング (rule <- IDENT (',' IDENT)*)
// ────────────────────────────────────────────────────────────────

test "grouping: rule <- IDENT (',' IDENT)*" {
    const g = comptime peg.compile("rule <- IDENT (',' IDENT)*");
    try std.testing.expectEqual(@as(usize, 1), g.rules.len);
    const expr = g.rules[0].expr;
    // トップレベルは seq: [IDENT, (',' IDENT)*]
    switch (expr) {
        .seq => |elems| {
            try std.testing.expectEqual(@as(usize, 2), elems.len);
            try expectToken(elems[0], .identifier);
            // elems[1] は .many{ .seq[comma, IDENT] }
            switch (elems[1]) {
                .many => |inner| {
                    switch (inner.*) {
                        .seq => |inner_elems| {
                            try std.testing.expectEqual(@as(usize, 2), inner_elems.len);
                            try expectToken(inner_elems[0], .comma);
                            try expectToken(inner_elems[1], .identifier);
                        },
                        else => return error.WrongExprKind,
                    }
                },
                else => return error.WrongExprKind,
            }
        },
        else => {
            std.debug.print("expected .seq, got {s}\n", .{@tagName(expr)});
            return error.WrongExprKind;
        },
    }
}

// ────────────────────────────────────────────────────────────────
// テスト: ルール参照がインデックスに解決される
// ────────────────────────────────────────────────────────────────

test "rule reference resolves to index" {
    const g = comptime peg.compile(
        \\file <- fn_decl
        \\fn_decl <- IDENT
    );
    try std.testing.expectEqual(@as(usize, 2), g.rules.len);
    try std.testing.expectEqualStrings("file", g.rules[0].name);
    try std.testing.expectEqualStrings("fn_decl", g.rules[1].name);

    // file の式は fn_decl への参照 (index=1)
    try expectRuleRef(g.rules[0].expr, 1);
    // fn_decl の式は IDENT
    try expectToken(g.rules[1].expr, .identifier);
}

// ────────────────────────────────────────────────────────────────
// テスト: 複数ルールの文法
// ────────────────────────────────────────────────────────────────

test "multiple rules" {
    const g = comptime peg.compile(
        \\file <- fn_decl+ EOF
        \\fn_decl <- 'func' IDENT '(' ')'
    );
    try std.testing.expectEqual(@as(usize, 2), g.rules.len);

    // rule 0: file
    try std.testing.expectEqualStrings("file", g.rules[0].name);
    // file の式: seq[ fn_decl+, EOF ]
    switch (g.rules[0].expr) {
        .seq => |elems| {
            try std.testing.expectEqual(@as(usize, 2), elems.len);
            // fn_decl+ — rule_ref(1) の many1
            switch (elems[0]) {
                .many1 => |inner| {
                    try expectRuleRef(inner.*, 1);
                },
                else => return error.WrongExprKind,
            }
            try expectToken(elems[1], .eof);
        },
        else => return error.WrongExprKind,
    }

    // rule 1: fn_decl
    try std.testing.expectEqualStrings("fn_decl", g.rules[1].name);
    switch (g.rules[1].expr) {
        .seq => |elems| {
            try std.testing.expectEqual(@as(usize, 4), elems.len);
            try expectToken(elems[0], .keyword_func);
            try expectToken(elems[1], .identifier);
            try expectToken(elems[2], .l_paren);
            try expectToken(elems[3], .r_paren);
        },
        else => return error.WrongExprKind,
    }
}

// ────────────────────────────────────────────────────────────────
// テスト: ターミナルマッピング網羅確認
// ────────────────────────────────────────────────────────────────

test "terminal mappings" {
    try std.testing.expectEqual(Token.Tag.identifier, peg.resolveTerminal("IDENT"));
    try std.testing.expectEqual(Token.Tag.integer_literal, peg.resolveTerminal("INT"));
    try std.testing.expectEqual(Token.Tag.string_literal, peg.resolveTerminal("STR"));
    try std.testing.expectEqual(Token.Tag.raw_string_literal, peg.resolveTerminal("RAWSTR"));
    try std.testing.expectEqual(Token.Tag.eof, peg.resolveTerminal("EOF"));
    try std.testing.expectEqual(Token.Tag.l_paren, peg.resolveTerminal("("));
    try std.testing.expectEqual(Token.Tag.r_paren, peg.resolveTerminal(")"));
    try std.testing.expectEqual(Token.Tag.l_brace, peg.resolveTerminal("{"));
    try std.testing.expectEqual(Token.Tag.r_brace, peg.resolveTerminal("}"));
    try std.testing.expectEqual(Token.Tag.comma, peg.resolveTerminal(","));
    try std.testing.expectEqual(Token.Tag.dot, peg.resolveTerminal("."));
    try std.testing.expectEqual(Token.Tag.semicolon, peg.resolveTerminal(";"));
    try std.testing.expectEqual(Token.Tag.keyword_func, peg.resolveTerminal("func"));
    try std.testing.expectEqual(Token.Tag.keyword_mut, peg.resolveTerminal("mut"));
    try std.testing.expectEqual(Token.Tag.pipe_greater, peg.resolveTerminal("|>"));
    try std.testing.expectEqual(Token.Tag.left_arrow, peg.resolveTerminal("<-"));
    try std.testing.expectEqual(Token.Tag.colon_equal, peg.resolveTerminal(":="));
}

// ────────────────────────────────────────────────────────────────
// テスト: 複数のスペースや空行を含む文法
// ────────────────────────────────────────────────────────────────

test "grammar with blank lines and comments" {
    const g = comptime peg.compile(
        \\// Phase 0 文法
        \\
        \\file <- fn_decl
        \\
        \\fn_decl <- IDENT
    );
    try std.testing.expectEqual(@as(usize, 2), g.rules.len);
    try std.testing.expectEqualStrings("file", g.rules[0].name);
    try std.testing.expectEqualStrings("fn_decl", g.rules[1].name);
}

// ────────────────────────────────────────────────────────────────
// テスト: 否定先読み (rule <- IDENT !'(')
// ────────────────────────────────────────────────────────────────

test "neg lookahead: rule <- IDENT !'('" {
    const g = comptime peg.compile("rule <- IDENT !'('");
    const expr = g.rules[0].expr;
    switch (expr) {
        .seq => |elems| {
            try std.testing.expectEqual(@as(usize, 2), elems.len);
            try expectToken(elems[0], .identifier);
            switch (elems[1]) {
                .neg => |inner| {
                    try expectToken(inner.*, .l_paren);
                },
                else => return error.WrongExprKind,
            }
        },
        else => return error.WrongExprKind,
    }
}

// ────────────────────────────────────────────────────────────────
// テスト: 肯定先読み (rule <- &IDENT IDENT)
// ────────────────────────────────────────────────────────────────

test "pos lookahead: rule <- &IDENT IDENT" {
    const g = comptime peg.compile("rule <- &IDENT IDENT");
    const expr = g.rules[0].expr;
    switch (expr) {
        .seq => |elems| {
            try std.testing.expectEqual(@as(usize, 2), elems.len);
            switch (elems[0]) {
                .pos => |inner| {
                    try expectToken(inner.*, .identifier);
                },
                else => return error.WrongExprKind,
            }
            try expectToken(elems[1], .identifier);
        },
        else => return error.WrongExprKind,
    }
}

// ────────────────────────────────────────────────────────────────
// ランタイムマッチャー テスト
// ────────────────────────────────────────────────────────────────

/// テスト用トークン列生成ヘルパー
fn tok(tag: Token.Tag, start: u32) Token {
    return Token{ .tag = tag, .loc = .{ .start = start, .end = start + 1 } };
}

// テスト1: 単一トークンマッチ
test "matcher: single token match" {
    const g = comptime peg.compile("rule <- IDENT");
    const M = peg.Matcher(g);

    const tokens = [_]Token{tok(.identifier, 0)};
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result != null);

    const root = m.nodes.items[result.?];
    try std.testing.expectEqual(@as(u16, 0), root.rule_id); // rule index = 0
    try std.testing.expectEqual(@as(u32, 0), root.token_start);
    try std.testing.expectEqual(@as(u32, 1), root.token_end);
}

// テスト2: 連接マッチ
test "matcher: sequence match IDENT '(' ')'" {
    const g = comptime peg.compile("rule <- IDENT '(' ')'");
    const M = peg.Matcher(g);

    const tokens = [_]Token{
        tok(.identifier, 0),
        tok(.l_paren, 1),
        tok(.r_paren, 2),
    };
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result != null);

    const root = m.nodes.items[result.?];
    try std.testing.expectEqual(@as(u32, 0), root.token_start);
    try std.testing.expectEqual(@as(u32, 3), root.token_end);
}

// テスト3: 選択マッチ（1番目）
test "matcher: alt match first (INT)" {
    const g = comptime peg.compile("rule <- INT / IDENT");
    const M = peg.Matcher(g);

    const tokens = [_]Token{tok(.integer_literal, 0)};
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result != null);

    const root = m.nodes.items[result.?];
    try std.testing.expectEqual(@as(u32, 0), root.token_start);
    try std.testing.expectEqual(@as(u32, 1), root.token_end);
}

// テスト4: 選択マッチ（2番目）
test "matcher: alt match second (IDENT)" {
    const g = comptime peg.compile("rule <- INT / IDENT");
    const M = peg.Matcher(g);

    const tokens = [_]Token{tok(.identifier, 0)};
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result != null);

    const root = m.nodes.items[result.?];
    try std.testing.expectEqual(@as(u32, 0), root.token_start);
    try std.testing.expectEqual(@as(u32, 1), root.token_end);
}

// テスト5: many（0回）
test "matcher: many zero times" {
    const g = comptime peg.compile("rule <- IDENT*");
    const M = peg.Matcher(g);

    const tokens = [_]Token{};
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result != null);

    const root = m.nodes.items[result.?];
    try std.testing.expectEqual(@as(u32, 0), root.token_start);
    try std.testing.expectEqual(@as(u32, 0), root.token_end);
    // 子ノードなし（many ノードの children は 0 個）
    const many_node = m.nodes.items[m.children.items[root.children_start]];
    try std.testing.expectEqual(many_node.children_start, many_node.children_end);
}

// テスト6: many（複数回）
test "matcher: many multiple times" {
    const g = comptime peg.compile("rule <- IDENT*");
    const M = peg.Matcher(g);

    const tokens = [_]Token{
        tok(.identifier, 0),
        tok(.identifier, 1),
        tok(.identifier, 2),
    };
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result != null);

    const root = m.nodes.items[result.?];
    try std.testing.expectEqual(@as(u32, 0), root.token_start);
    try std.testing.expectEqual(@as(u32, 3), root.token_end);
    // many ノードを取得して children 数を確認
    const many_idx = m.children.items[root.children_start];
    const many_node = m.nodes.items[many_idx];
    const child_count = many_node.children_end - many_node.children_start;
    try std.testing.expectEqual(@as(u32, 3), child_count);
}

// テスト7: バックトラッキング
test "matcher: backtracking alt" {
    const g = comptime peg.compile("rule <- IDENT '(' ')' / IDENT");
    const M = peg.Matcher(g);

    // IDENT 単体: 最初の選択肢 (IDENT '(' ')') は失敗し、2番目 (IDENT) が成功
    const tokens = [_]Token{tok(.identifier, 0)};
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result != null);

    // pos が正しく1になっていること（IDENT1つ消費）
    try std.testing.expectEqual(@as(usize, 1), m.pos);
}

// テスト8: ルール参照
test "matcher: rule reference" {
    const g = comptime peg.compile(
        \\a <- b
        \\b <- IDENT
    );
    const M = peg.Matcher(g);

    const tokens = [_]Token{tok(.identifier, 0)};
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("a");
    try std.testing.expect(result != null);

    const root = m.nodes.items[result.?];
    try std.testing.expectEqual(@as(u16, 0), root.rule_id); // a = rule index 0
    try std.testing.expectEqual(@as(u32, 0), root.token_start);
    try std.testing.expectEqual(@as(u32, 1), root.token_end);
}

// テスト9: 否定先読み（失敗）
test "matcher: neg lookahead fail" {
    const g = comptime peg.compile("rule <- IDENT !'('");
    const M = peg.Matcher(g);

    // IDENT の次に '(' がある → 否定先読みが失敗 → ルール全体が失敗
    const tokens = [_]Token{
        tok(.identifier, 0),
        tok(.l_paren, 1),
    };
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result == null);
}

// テスト9b: 否定先読み（成功）
test "matcher: neg lookahead success" {
    const g = comptime peg.compile("rule <- IDENT !'('");
    const M = peg.Matcher(g);

    // IDENT の次に eof → 否定先読みが成功（'(' でないため）
    const tokens = [_]Token{
        tok(.identifier, 0),
        tok(.eof, 1),
    };
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result != null);
    // IDENT だけ消費（否定先読みは消費しない）
    try std.testing.expectEqual(@as(usize, 1), m.pos);
}

// テスト10: many1 失敗
test "matcher: many1 fails on mismatch" {
    const g = comptime peg.compile("rule <- IDENT+");
    const M = peg.Matcher(g);

    // integer_literal は IDENT にマッチしない → many1 が失敗
    const tokens = [_]Token{tok(.integer_literal, 0)};
    var m = M.init(std.testing.allocator, &tokens);
    defer m.deinit();

    const result = try m.parse("rule");
    try std.testing.expect(result == null);
}
