const std = @import("std");
const Lexer = @import("lexer.zig");
const Token = @import("token.zig");

fn expectTokens(source: [:0]const u8, expected: []const Token.Tag) !void {
    var lexer = Lexer.init(source);
    for (expected) |tag| {
        const tok = lexer.next();
        try std.testing.expectEqual(tag, tok.tag);
    }
    const eof = lexer.next();
    try std.testing.expectEqual(Token.Tag.eof, eof.tag);
}

fn expectSlices(source: [:0]const u8, expected: []const []const u8) !void {
    var lexer = Lexer.init(source);
    for (expected) |text| {
        const tok = lexer.next();
        try std.testing.expectEqualStrings(text, tok.slice(source));
    }
}

test "empty source" {
    try expectTokens("", &.{});
}

test "identifier" {
    try expectTokens("foo _bar baz9", &.{ .identifier, .identifier, .identifier, .semicolon });
}

test "keyword prefix is not keyword" {
    try expectTokens("funcs mutable", &.{ .identifier, .identifier, .semicolon });
}

test "every keyword round-trips through the table" {
    inline for (Token.keywords) |entry| {
        const src: [:0]const u8 = entry[0] ++ "";
        var lexer = Lexer.init(src);
        try std.testing.expectEqual(entry[1], lexer.next().tag);
    }
}

test "every symbol round-trips through the table" {
    inline for (Token.symbols) |entry| {
        const src: [:0]const u8 = entry[0] ++ "";
        var lexer = Lexer.init(src);
        const tok = lexer.next();
        try std.testing.expectEqual(entry[1], tok.tag);
        try std.testing.expectEqualStrings(entry[0], tok.slice(src));
    }
}

test "longest match: <<= << <= <- <" {
    try expectTokens("<<= << <= <- <", &.{ .shl_equal, .shl, .less_equal, .left_arrow, .less });
}

test "longest match: |> || |= |" {
    try expectTokens("|> || |= |", &.{ .pipe_greater, .pipe_pipe, .pipe_equal, .pipe });
}

test "longest match: => == =" {
    try expectTokens("=> == =", &.{ .fat_arrow, .equal_equal, .equal });
}

test "longest match: := :" {
    try expectTokens(":= :", &.{ .colon_equal, .colon });
}

test "longest match: ... ." {
    try expectTokens("... .", &.{ .ellipsis, .dot });
}

test "adjacent symbols split" {
    try expectTokens("x:=1", &.{ .identifier, .colon_equal, .integer_literal, .semicolon });
    try expectTokens("f()?", &.{ .identifier, .l_paren, .r_paren, .question, .semicolon });
}

test "integer literal" {
    try expectSlices("42 7", &.{ "42", "7" });
}

test "string literal" {
    try expectTokens("\"hello\"", &.{ .string_literal, .semicolon });
    try expectSlices("\"a\\\"b\"", &.{"\"a\\\"b\""});
}

test "unterminated string" {
    try expectTokens("\"abc", &.{.invalid});
    try expectTokens("\"abc\nx", &.{ .invalid, .identifier, .semicolon });
}

test "raw string literal spans lines" {
    try expectTokens("`a\nb`", &.{ .raw_string_literal, .semicolon });
}

test "unterminated raw string" {
    try expectTokens("`abc", &.{.invalid});
}

test "invalid character" {
    try expectTokens("#", &.{.invalid});
}

test "line comment" {
    try expectTokens("// comment\nfunc", &.{.keyword_func});
    try expectTokens("func // trailing", &.{.keyword_func});
}

test "block comment without newline is a space" {
    try expectTokens("a /* c */ b", &.{ .identifier, .identifier, .semicolon });
}

// ── セミコロン自動挿入 ──────────────────────────────────────────

test "semicolon: inserted at newline after identifier" {
    try expectTokens("a\nb", &.{ .identifier, .semicolon, .identifier, .semicolon });
}

test "semicolon: inserted at eof after literal" {
    try expectTokens("1", &.{ .integer_literal, .semicolon });
}

test "semicolon: not inserted after operator" {
    try expectTokens("a +\nb", &.{ .identifier, .plus, .identifier, .semicolon });
}

test "semicolon: not inserted after opening brace" {
    try expectTokens("{\n}", &.{ .l_brace, .r_brace, .semicolon });
}

test "semicolon: inserted after ) ] } ?" {
    try expectTokens(")\n", &.{ .r_paren, .semicolon });
    try expectTokens("]\n", &.{ .r_bracket, .semicolon });
    try expectTokens("}\n", &.{ .r_brace, .semicolon });
    try expectTokens("?\n", &.{ .question, .semicolon });
}

test "semicolon: inserted after return break continue" {
    try expectTokens("return\n", &.{ .keyword_return, .semicolon });
    try expectTokens("break\n", &.{ .keyword_break, .semicolon });
    try expectTokens("continue\n", &.{ .keyword_continue, .semicolon });
}

test "semicolon: inserted after error (type name position)" {
    try expectTokens("type T error\nfunc", &.{ .keyword_type, .identifier, .keyword_error, .semicolon, .keyword_func });
}

test "semicolon: not inserted after other keywords" {
    try expectTokens("func\nif\n", &.{ .keyword_func, .keyword_if });
}

test "semicolon: blank lines insert only one" {
    try expectTokens("a\n\n\nb", &.{ .identifier, .semicolon, .identifier, .semicolon });
}

test "semicolon: line comment does not suppress insertion" {
    try expectTokens("a // c\nb", &.{ .identifier, .semicolon, .identifier, .semicolon });
}

test "semicolon: multi-line block comment acts as newline" {
    try expectTokens("a /* x\ny */ b", &.{ .identifier, .semicolon, .identifier, .semicolon });
}

test "semicolon: inserted one has zero width at the newline" {
    const src: [:0]const u8 = "ab\ncd";
    var lexer = Lexer.init(src);
    _ = lexer.next();
    const semi = lexer.next();
    try std.testing.expectEqual(Token.Tag.semicolon, semi.tag);
    try std.testing.expectEqual(@as(u32, 2), semi.loc.start);
    try std.testing.expectEqual(@as(u32, 2), semi.loc.end);
}

test "semicolon: explicit one has width" {
    try expectTokens("a; b", &.{ .identifier, .semicolon, .identifier, .semicolon });
    try expectSlices("a; b", &.{ "a", ";", "b" });
}

test "fib tokens" {
    const src =
        \\package main
        \\
        \\func fib(n int) int {
        \\    return if n < 2 { n } else { fib(n - 1) + fib(n - 2) }
        \\}
        \\
        \\func main() {
        \\    println(fib(10))
        \\}
        \\
    ;
    try expectTokens(src, &.{
        .keyword_package, .identifier,      .semicolon,
        .keyword_func,    .identifier,      .l_paren,
        .identifier,      .identifier,      .r_paren,
        .identifier,      .l_brace,         .keyword_return,
        .keyword_if,      .identifier,      .less,
        .integer_literal, .l_brace,         .identifier,
        .r_brace,         .keyword_else,    .l_brace,
        .identifier,      .l_paren,         .identifier,
        .minus,           .integer_literal, .r_paren,
        .plus,            .identifier,      .l_paren,
        .identifier,      .minus,           .integer_literal,
        .r_paren,         .r_brace,         .semicolon,
        .r_brace,         .semicolon,       .keyword_func,
        .identifier,      .l_paren,         .r_paren,
        .l_brace,         .identifier,      .l_paren,
        .identifier,      .l_paren,         .integer_literal,
        .r_paren,         .r_paren,         .semicolon,
        .r_brace,         .semicolon,
    });
}
