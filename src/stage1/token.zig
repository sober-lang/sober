//! Sober の字句（docs/syntax.md 1 節）。Go のトークン集合からの差分で決まる。
const std = @import("std");

tag: Tag,
loc: Loc,

pub const Loc = struct {
    start: u32,
    end: u32,
};

pub const Tag = enum {
    identifier,
    integer_literal,
    string_literal, // "..."（補間 ${ } は後で）
    raw_string_literal, // `...`

    // キーワード（Go 由来）
    keyword_package,
    keyword_import,
    keyword_const,
    keyword_type,
    keyword_func,
    keyword_struct,
    keyword_map,
    keyword_if,
    keyword_else,
    keyword_switch,
    keyword_case,
    keyword_default,
    keyword_return,
    keyword_break,
    keyword_continue,
    keyword_defer,
    keyword_for,
    // キーワード（Sober 追加）
    keyword_mut,
    keyword_union,
    keyword_error,
    keyword_yield,
    keyword_while,
    keyword_scope,
    keyword_parallel,
    keyword_spawn,
    keyword_shield,

    // 区切り
    l_paren,
    r_paren,
    l_brace,
    r_brace,
    l_bracket,
    r_bracket,
    comma,
    dot,
    ellipsis,
    semicolon, // 明示 or 自動挿入（自動挿入は幅 0）
    colon,
    colon_equal,
    at,
    question,
    // 演算子
    plus,
    minus,
    star,
    slash,
    percent,
    ampersand,
    pipe,
    caret,
    shl,
    shr,
    ampersand_ampersand,
    pipe_pipe,
    bang,
    equal,
    equal_equal,
    bang_equal,
    less,
    less_equal,
    greater,
    greater_equal,
    plus_equal,
    minus_equal,
    star_equal,
    slash_equal,
    percent_equal,
    ampersand_equal,
    pipe_equal,
    caret_equal,
    shl_equal,
    shr_equal,
    // Sober 追加
    pipe_greater, // |>
    fat_arrow, // =>
    left_arrow, // <-

    eof,
    invalid,
};

pub fn slice(self: @This(), source: [:0]const u8) []const u8 {
    return source[self.loc.start..self.loc.end];
}

pub const Entry = struct { []const u8, Tag };

/// 綴り → Tag。lexer（実行時）と peg.resolveTerminal（comptime）が同じ表を見る
pub const keywords = [_]Entry{
    .{ "package", .keyword_package },
    .{ "import", .keyword_import },
    .{ "const", .keyword_const },
    .{ "type", .keyword_type },
    .{ "func", .keyword_func },
    .{ "struct", .keyword_struct },
    .{ "map", .keyword_map },
    .{ "if", .keyword_if },
    .{ "else", .keyword_else },
    .{ "switch", .keyword_switch },
    .{ "case", .keyword_case },
    .{ "default", .keyword_default },
    .{ "return", .keyword_return },
    .{ "break", .keyword_break },
    .{ "continue", .keyword_continue },
    .{ "defer", .keyword_defer },
    .{ "for", .keyword_for },
    .{ "mut", .keyword_mut },
    .{ "union", .keyword_union },
    .{ "error", .keyword_error },
    .{ "yield", .keyword_yield },
    .{ "while", .keyword_while },
    .{ "scope", .keyword_scope },
    .{ "parallel", .keyword_parallel },
    .{ "spawn", .keyword_spawn },
    .{ "shield", .keyword_shield },
};

/// 記号。lexer は最長一致（3 文字 → 2 文字 → 1 文字）で引く
pub const symbols = [_]Entry{
    .{ "(", .l_paren },
    .{ ")", .r_paren },
    .{ "{", .l_brace },
    .{ "}", .r_brace },
    .{ "[", .l_bracket },
    .{ "]", .r_bracket },
    .{ ",", .comma },
    .{ ".", .dot },
    .{ "...", .ellipsis },
    .{ ";", .semicolon },
    .{ ":", .colon },
    .{ ":=", .colon_equal },
    .{ "@", .at },
    .{ "?", .question },
    .{ "+", .plus },
    .{ "-", .minus },
    .{ "*", .star },
    .{ "/", .slash },
    .{ "%", .percent },
    .{ "&", .ampersand },
    .{ "|", .pipe },
    .{ "^", .caret },
    .{ "<<", .shl },
    .{ ">>", .shr },
    .{ "&&", .ampersand_ampersand },
    .{ "||", .pipe_pipe },
    .{ "!", .bang },
    .{ "=", .equal },
    .{ "==", .equal_equal },
    .{ "!=", .bang_equal },
    .{ "<", .less },
    .{ "<=", .less_equal },
    .{ ">", .greater },
    .{ ">=", .greater_equal },
    .{ "+=", .plus_equal },
    .{ "-=", .minus_equal },
    .{ "*=", .star_equal },
    .{ "/=", .slash_equal },
    .{ "%=", .percent_equal },
    .{ "&=", .ampersand_equal },
    .{ "|=", .pipe_equal },
    .{ "^=", .caret_equal },
    .{ "<<=", .shl_equal },
    .{ ">>=", .shr_equal },
    .{ "|>", .pipe_greater },
    .{ "=>", .fat_arrow },
    .{ "<-", .left_arrow },
};

pub const keyword_map = std.StaticStringMap(Tag).initComptime(keywords);
pub const symbol_map = std.StaticStringMap(Tag).initComptime(symbols);

/// 行末にこのトークンがあればセミコロンを自動挿入する（Go 仕様 + `?`）
pub fn endsStatement(tag: Tag) bool {
    return switch (tag) {
        .identifier,
        .integer_literal,
        .string_literal,
        .raw_string_literal,
        .keyword_return,
        .keyword_break,
        .keyword_continue,
        // 'error' はキーワードだが型名として行末に立つ（`type Timeout error`）。Go では識別子なので挿入対象
        .keyword_error,
        .r_paren,
        .r_bracket,
        .r_brace,
        .question,
        => true,
        else => false,
    };
}
