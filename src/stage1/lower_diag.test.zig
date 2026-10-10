//! 拒否の表（diag_cases.zig）を IR 経路（load + lower）で回し、表の error 名で拒否することを確かめる（B-8.5 で codegen と揃えた名 — codegen は B-9b で退役）
const std = @import("std");
const run = @import("lower_test_run.zig");
const diag_cases = @import("diag_cases.zig");

test "lower: diag_cases の拒否ケースを表の error 名で拒否する" {
    var bad: usize = 0;
    for (diag_cases.cases, 0..) |c, i| {
        const want = c.lower_err orelse c.err;
        if (run.lowerOnly(std.testing.allocator, c.src)) |_| {
            std.debug.print("diag case {d}: accepted, want {s}\n  {s}\n", .{ i, @errorName(want), c.src });
            bad += 1;
        } else |err| if (err != want) {
            std.debug.print("diag case {d}: got {s}, want {s}\n  {s}\n", .{ i, @errorName(err), @errorName(want), c.src });
            bad += 1;
        }
    }
    try std.testing.expectEqual(@as(usize, 0), bad);
}

test "lower: 別 package の非公開名は Unexported（呼び出し・参照とも）" {
    const loader = @import("loader.zig");
    const geo = "package geo\nconst k = 1\nfunc hidden(n int) int { return n * 2 }\nfunc Double(n int) int { return hidden(n) }\n";
    for ([_][:0]const u8{
        "package main\nimport \"geo\"\nfunc main() { println(geo.hidden(1)) }\n",
        "package main\nimport \"geo\"\nfunc main() { println(geo.k) }\n",
    }) |main_src| {
        const files = [_]loader.SrcFile{
            .{ .pkg_path = "geo", .name = "geo/g.sober", .source = geo },
            .{ .pkg_path = loader.main_pkg_path, .name = "main.sober", .source = main_src },
        };
        try std.testing.expectError(error.Unexported, run.lowerFiles(std.testing.allocator, &files));
    }
}
