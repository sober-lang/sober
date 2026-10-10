//! `@embed("glob")` のパターン展開（language.md 20 節 — go:embed の意味論。loader が const 畳み込みの段で使う）。
//! パターンはルート（= cwd）相対の `/` 区切り。セグメントごとに照合する: `**` はセグメントまるごとで 0 個以上のディレクトリ、
//! `*` は `/` を含まない任意の列、`?` は 1 バイト、他はそのまま。最後のセグメントは通常ファイルにだけ、途中のセグメントは
//! ディレクトリにだけ当たる（symlink はどちらにも当たらない — build.zig の std 焼き込みの walker と同じ集合）。
//! 結果はパスのバイト辞書順（hermetic — 同じファイル集合なら同じ列）
const std = @import("std");

pub const Error = error{ BadPattern, OutOfMemory };

/// パターンの形の検査: 空・先頭 `/`・空セグメント・`.` / `..`・セグメントの一部としての `**`・`[` と `\` を拒否
pub fn validPattern(pat: []const u8) bool {
    if (pat.len == 0 or pat[0] == '/') return false;
    var it = std.mem.splitScalar(u8, pat, '/');
    while (it.next()) |seg| {
        if (seg.len == 0) return false;
        if (std.mem.eql(u8, seg, ".") or std.mem.eql(u8, seg, "..")) return false;
        if (!std.mem.eql(u8, seg, "**") and std.mem.indexOf(u8, seg, "**") != null) return false;
        if (std.mem.indexOfAny(u8, seg, "[\\") != null) return false;
    }
    return true;
}

/// セグメント 1 つの照合（`*` と `?`）
pub fn matchSeg(pat: []const u8, name: []const u8) bool {
    if (pat.len == 0) return name.len == 0;
    if (pat[0] == '*') {
        var i: usize = 0;
        while (i <= name.len) : (i += 1) {
            if (matchSeg(pat[1..], name[i..])) return true;
        }
        return false;
    }
    if (name.len == 0) return false;
    if (pat[0] != '?' and pat[0] != name[0]) return false;
    return matchSeg(pat[1..], name[1..]);
}

/// pat に合うファイルのルート相対パスを辞書順・重複なしで返す（a に確保）。pat は validPattern 済みであること
pub fn expand(gpa: std.mem.Allocator, a: std.mem.Allocator, pat: []const u8) Error![]const []const u8 {
    var segs: std.ArrayListUnmanaged([]const u8) = .empty;
    defer segs.deinit(gpa);
    var it = std.mem.splitScalar(u8, pat, '/');
    while (it.next()) |seg| try segs.append(gpa, seg);
    var out: std.ArrayListUnmanaged([]const u8) = .empty;
    try walk(gpa, a, "", segs.items, &out);
    std.mem.sort([]const u8, out.items, {}, lessStr);
    // `**/**` 等で同じパスが複数の道筋から来る
    var n: usize = 0;
    for (out.items) |p| {
        if (n > 0 and std.mem.eql(u8, out.items[n - 1], p)) continue;
        out.items[n] = p;
        n += 1;
    }
    return out.items[0..n];
}

fn lessStr(_: void, x: []const u8, y: []const u8) bool {
    return std.mem.lessThan(u8, x, y);
}

const Kind = enum { file, dir, other };

/// dir（ルート相対、"" = ルート）の中で segs を照合する。開けないディレクトリは「当たりなし」
fn walk(gpa: std.mem.Allocator, a: std.mem.Allocator, dir: []const u8, segs: []const []const u8, out: *std.ArrayListUnmanaged([]const u8)) Error!void {
    if (segs.len == 0) return;
    const seg = segs[0];
    if (std.mem.eql(u8, seg, "**")) {
        // 0 個: このディレクトリのまま次のセグメントへ
        try walk(gpa, a, dir, segs[1..], out);
    }
    var d = std.fs.cwd().openDir(if (dir.len == 0) "." else dir, .{ .iterate = true }) catch return;
    defer d.close();
    var names: std.ArrayListUnmanaged(struct { name: []const u8, kind: Kind }) = .empty;
    defer names.deinit(gpa);
    var di = d.iterate();
    while (di.next() catch return) |e| {
        const k: Kind = switch (e.kind) {
            .file => .file,
            .directory => .dir,
            else => .other,
        };
        try names.append(gpa, .{ .name = try a.dupe(u8, e.name), .kind = k });
    }
    for (names.items) |e| {
        const child = if (dir.len == 0) e.name else try std.fmt.allocPrint(a, "{s}/{s}", .{ dir, e.name });
        if (std.mem.eql(u8, seg, "**")) {
            // 1 個以上: サブディレクトリに入って ** のまま
            if (e.kind == .dir) try walk(gpa, a, child, segs, out);
            continue;
        }
        if (!matchSeg(seg, e.name)) continue;
        if (segs.len == 1) {
            if (e.kind == .file) try out.append(a, child);
        } else if (e.kind == .dir) {
            try walk(gpa, a, child, segs[1..], out);
        }
    }
}
