const std = @import("std");
const embed = @import("embed.zig");
const std_embed = @import("std_embed");

test "embed: std/**/*.sober の展開が build.zig の std 焼き込みと同じ列（同じ集合・同じ順）" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const got = try embed.expand(std.testing.allocator, arena.allocator(), "std/**/*.sober");
    try std.testing.expectEqual(std_embed.paths.len, got.len);
    for (std_embed.paths, got) |want, g| try std.testing.expectEqualStrings(want, g);
}

test "embed: パターンの形" {
    try std.testing.expect(embed.validPattern("std/**/*.sober"));
    try std.testing.expect(embed.validPattern("a/b?.txt"));
    for ([_][]const u8{ "", "/abs", "a//b", "a/../b", "./a", "a/**b", "a/[ab]", "a\\b" }) |p|
        try std.testing.expect(!embed.validPattern(p));
}

test "embed: セグメントの照合" {
    try std.testing.expect(embed.matchSeg("*.txt", "a.txt"));
    try std.testing.expect(embed.matchSeg("*", ".hidden"));
    try std.testing.expect(embed.matchSeg("a?c", "abc"));
    try std.testing.expect(!embed.matchSeg("a?c", "ac"));
    try std.testing.expect(!embed.matchSeg("*.txt", "a.md"));
}
