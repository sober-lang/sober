//! 診断の座標系（随時回収 R5）。
//!
//! 座標は **Pos = ロードした全ソースを通したトークン番号** 1 語。loader がファイルを parse する順に
//! トークン数を積み上げて各ファイルに base を割り当て、cst_to_ast が AST の tok に base を足して焼く。
//! AST・各層の Diag・（V4 の）error 値はこの 1 語だけを運び、表示時に SourceMap で
//! path:line:col へ解決する。ファイル id を別に運ばないので、AST ノードの形は変わらない。
//! 棄てた案: ノードごとに {file, tok} の組を持たせる（35 箇所の tok フィールドと全層の受け渡しが倍になる）
const std = @import("std");
const Token = @import("token.zig");

/// 診断座標。単一ファイルのテストでは base = 0 なのでファイル内のトークン番号と一致する
pub const Pos = u32;

/// 表示用に解決した座標（line / col は 1 始まり、col はバイト単位）
pub const Loc = struct {
    path: []const u8,
    line: u32,
    col: u32,
};

pub const File = struct {
    path: []const u8,
    source: [:0]const u8,
    base: Pos,
    /// 各トークンの開始バイト位置（eof 込み）
    starts: []const u32,
};

/// ファイル表（file id = files の添字）と Pos → Loc の解決
pub const SourceMap = struct {
    files: []const File = &.{},

    /// 次のファイルの base（= これまでの総トークン数）
    pub fn nextBase(self: SourceMap) Pos {
        if (self.files.len == 0) return 0;
        const last = self.files[self.files.len - 1];
        return last.base + @as(Pos, @intCast(last.starts.len));
    }

    /// ファイルを表に積み、その base を返す。path / source は呼び手が a と同じ寿命で持つこと
    pub fn add(self: *SourceMap, a: std.mem.Allocator, path: []const u8, source: [:0]const u8, tokens: []const Token) !Pos {
        const base = self.nextBase();
        const starts = try a.alloc(u32, tokens.len);
        for (tokens, starts) |t, *s| s.* = t.loc.start;
        const grown = try a.alloc(File, self.files.len + 1);
        @memcpy(grown[0..self.files.len], self.files);
        grown[self.files.len] = .{ .path = path, .source = source, .base = base, .starts = starts };
        self.files = grown;
        return base;
    }

    /// Pos を含むファイルの id
    pub fn fileOf(self: SourceMap, pos: Pos) ?usize {
        var i = self.files.len;
        while (i > 0) {
            i -= 1;
            const f = self.files[i];
            if (pos >= f.base) return if (pos - f.base < f.starts.len) i else null;
        }
        return null;
    }

    pub fn resolve(self: SourceMap, pos: Pos) ?Loc {
        const f = self.files[self.fileOf(pos) orelse return null];
        const start = f.starts[pos - f.base];
        var line: u32 = 1;
        var col: u32 = 1;
        for (f.source[0..start]) |c| {
            if (c == '\n') {
                line += 1;
                col = 1;
            } else col += 1;
        }
        return .{ .path = f.path, .line = line, .col = col };
    }
};

/// 座標部分を書く: 解決できれば `path:line:col`、できなければ fallback_path（空なら何も書かない）
pub fn writeLoc(w: *std.Io.Writer, map: SourceMap, pos: ?Pos, fallback_path: []const u8) !void {
    if (pos) |p| if (map.resolve(p)) |loc| {
        return w.print("{s}:{d}:{d}", .{ loc.path, loc.line, loc.col });
    };
    try w.writeAll(fallback_path);
}

/// 診断 1 行の標準形 `loc: error: what (Err)`（loc が空なら `error: what (Err)`）。エディタで飛べる形
pub fn printDiag(loc: []const u8, what: []const u8, err: []const u8) void {
    if (loc.len > 0) std.debug.print("{s}: ", .{loc});
    std.debug.print("error: {s} ({s})\n", .{ what, err });
}
