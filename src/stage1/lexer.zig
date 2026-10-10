//! 字句解析器。Go 式のセミコロン自動挿入を行う（docs/syntax.md 1 節）。
const std = @import("std");
const Token = @import("token.zig");

source: [:0]const u8,
index: u32,
/// 直前に返したトークン。改行時のセミコロン挿入判定に使う
last_tag: Token.Tag,

pub fn init(source: [:0]const u8) @This() {
    return .{ .source = source, .index = 0, .last_tag = .eof };
}

pub fn next(self: *@This()) Token {
    const tok = self.nextInner();
    self.last_tag = tok.tag;
    return tok;
}

fn nextInner(self: *@This()) Token {
    // トリビアを読み飛ばす。途中で改行に当たり、直前トークンが文末なら幅 0 の ';' を返す
    if (self.skipTrivia()) |newline_at| {
        return .{ .tag = .semicolon, .loc = .{ .start = newline_at, .end = newline_at } };
    }
    const c = self.source[self.index];
    return switch (c) {
        0 => if (Token.endsStatement(self.last_tag))
            .{ .tag = .semicolon, .loc = .{ .start = self.index, .end = self.index } }
        else
            .{ .tag = .eof, .loc = .{ .start = self.index, .end = self.index } },
        '"' => self.lexString(),
        '`' => self.lexRawString(),
        'a'...'z', 'A'...'Z', '_' => self.lexWord(),
        '0'...'9' => self.lexNumber(),
        else => self.lexSymbol(),
    };
}

/// 空白とコメントを飛ばす。セミコロンを挿入すべき改行に当たったらその位置を返す
fn skipTrivia(self: *@This()) ?u32 {
    const insert = Token.endsStatement(self.last_tag);
    while (true) {
        switch (self.source[self.index]) {
            ' ', '\t', '\r' => self.index += 1,
            '\n' => {
                const at = self.index;
                self.index += 1;
                if (insert) return at;
            },
            '/' => {
                if (self.source[self.index + 1] == '/') {
                    while (self.source[self.index] != '\n' and self.source[self.index] != 0) self.index += 1;
                } else if (self.source[self.index + 1] == '*') {
                    // 改行を含むブロックコメントは改行として扱う（Go 仕様）
                    const at = self.index;
                    self.index += 2;
                    var has_newline = false;
                    while (self.source[self.index] != 0) {
                        if (self.source[self.index] == '*' and self.source[self.index + 1] == '/') {
                            self.index += 2;
                            break;
                        }
                        if (self.source[self.index] == '\n') has_newline = true;
                        self.index += 1;
                    }
                    if (has_newline and insert) return at;
                } else return null;
            },
            else => return null,
        }
    }
}

fn lexSymbol(self: *@This()) Token {
    const start = self.index;
    var len: u32 = 3;
    while (len > 0) : (len -= 1) {
        if (start + len > self.source.len) continue;
        if (Token.symbol_map.get(self.source[start .. start + len])) |tag| {
            self.index += len;
            return .{ .tag = tag, .loc = .{ .start = start, .end = self.index } };
        }
    }
    self.index += 1;
    return .{ .tag = .invalid, .loc = .{ .start = start, .end = self.index } };
}

fn lexString(self: *@This()) Token {
    const start = self.index;
    const ok = self.skipString();
    return .{ .tag = if (ok) .string_literal else .invalid, .loc = .{ .start = start, .end = self.index } };
}

/// `"..."` を読み飛ばす（index は開きの `"`）。補間 `${ 式 }` は 1 トークンのまま中を読み飛ばし、
/// 式の中の入れ子の文字列（補間込み）・raw 文字列・`{ }` の対応を追う。式の中身は cst_to_ast が
/// 部分文字列として字句・構文解析し直す（syntax.md 5.4 InterpString）。改行は補間の中でも不可
fn skipString(self: *@This()) bool {
    self.index += 1;
    while (true) {
        switch (self.source[self.index]) {
            0, '\n' => return false,
            '\\' => {
                self.index += 1;
                if (self.source[self.index] != 0) self.index += 1;
            },
            '"' => {
                self.index += 1;
                return true;
            },
            '$' => {
                self.index += 1;
                if (self.source[self.index] != '{') continue;
                if (!self.skipInterp()) return false;
            },
            else => self.index += 1,
        }
    }
}

/// `${ ... }` を読み飛ばす（index は `{`）。終わると index は閉じの `}` の直後
fn skipInterp(self: *@This()) bool {
    self.index += 1;
    var depth: u32 = 1;
    while (depth > 0) {
        switch (self.source[self.index]) {
            0, '\n' => return false,
            '{' => {
                depth += 1;
                self.index += 1;
            },
            '}' => {
                depth -= 1;
                self.index += 1;
            },
            '"' => if (!self.skipString()) return false,
            '`' => {
                self.index += 1;
                while (self.source[self.index] != '`') {
                    if (self.source[self.index] == 0) return false;
                    self.index += 1;
                }
                self.index += 1;
            },
            else => self.index += 1,
        }
    }
    return true;
}

/// 字句済みの文字列リテラル内で、`${` の `{`（位置 at）に対応する閉じ `}` の直後の位置
/// （cst_to_ast が補間の式を切り出すのに使う。字句と同じ読み飛ばし規則を共有する）
pub fn interpEnd(source: [:0]const u8, at: usize) ?usize {
    var l = init(source);
    l.index = @intCast(at);
    return if (l.skipInterp()) l.index else null;
}

fn lexRawString(self: *@This()) Token {
    const start = self.index;
    self.index += 1;
    while (self.source[self.index] != '`') {
        if (self.source[self.index] == 0) return .{ .tag = .invalid, .loc = .{ .start = start, .end = self.index } };
        self.index += 1;
    }
    self.index += 1;
    return .{ .tag = .raw_string_literal, .loc = .{ .start = start, .end = self.index } };
}

fn lexWord(self: *@This()) Token {
    const start = self.index;
    while (isIdentCont(self.source[self.index])) self.index += 1;
    const tag = Token.keyword_map.get(self.source[start..self.index]) orelse .identifier;
    return .{ .tag = tag, .loc = .{ .start = start, .end = self.index } };
}

fn lexNumber(self: *@This()) Token {
    const start = self.index;
    while (self.source[self.index] >= '0' and self.source[self.index] <= '9') self.index += 1;
    return .{ .tag = .integer_literal, .loc = .{ .start = start, .end = self.index } };
}

fn isIdentStart(c: u8) bool {
    return (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or c == '_';
}

fn isIdentCont(c: u8) bool {
    return isIdentStart(c) or (c >= '0' and c <= '9');
}

/// 全トークンを配列にする（末尾は必ず eof）
pub fn tokenize(allocator: std.mem.Allocator, source: [:0]const u8) std.mem.Allocator.Error![]Token {
    var list: std.ArrayListUnmanaged(Token) = .empty;
    errdefer list.deinit(allocator);
    var lexer = init(source);
    while (true) {
        const t = lexer.next();
        try list.append(allocator, t);
        if (t.tag == .eof) break;
    }
    return list.toOwnedSlice(allocator);
}
