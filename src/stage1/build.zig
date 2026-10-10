const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const elf_module = b.createModule(.{
        .root_source_file = b.path("format/elf.zig"),
        .target = target,
        .optimize = optimize,
    });
    const x86_64_module = b.createModule(.{
        .root_source_file = b.path("arch/x86_64.zig"),
        .target = target,
        .optimize = optimize,
    });

    const std_embed = stdEmbedModule(b);

    // stage1 の決定的ビルド: Debug の DWARF が std_embed（WriteFiles）のキャッシュパスを埋め込み、
    // 同じソースでも ELF が割れる → stage2 の鍵（stage1 バイナリを含む）が無駄にずれる。
    // stage1 は照合専用でデバッグ情報は不要なので exe だけ strip（-Dstrip=false で戻せる）
    const strip = b.option(bool, "strip", "stage1 の ELF からデバッグ情報を落とす（決定的ビルド — 既定 true）") orelse true;

    const use_llvm = b.option(bool, "llvm", "stage1 を LLVM バックエンドで建てる（決定的ビルド — 既定 true）") orelse true;

    const exe = b.addExecutable(.{
        .name = "sober",
        .root_module = b.createModule(.{
            .root_source_file = b.path("main.zig"),
            .target = target,
            .optimize = optimize,
            .strip = strip,
        }),
        .use_llvm = use_llvm,
    });
    exe.root_module.addImport("arch/x86_64.zig", x86_64_module);
    exe.root_module.addImport("format/elf.zig", elf_module);
    exe.root_module.addImport("std_embed", std_embed);
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_cmd.addArgs(args);
    b.step("run", "Run the compiler").dependOn(&run_cmd.step);

    const test_step = b.step("test", "Run unit tests");

    // 単独で完結するテスト（同ディレクトリ内の @import のみ）
    for ([_][]const u8{
        "lexer.test.zig",
        "peg.test.zig",
        "grammar.test.zig",
        "cst.test.zig",
        "cst_to_ast.test.zig",
        "desugar.test.zig",
        "srcpos.test.zig",
        "interp.test.zig",
        "analyzer.test.zig",
        "iface.test.zig",
        "ast_json.test.zig",
        "embed.test.zig",
    }) |path| {
        const t = b.addTest(.{
            .root_module = b.createModule(.{
                .root_source_file = b.path(path),
                .target = target,
                .optimize = optimize,
            }),
        });
        t.root_module.addImport("std_embed", std_embed);
        test_step.dependOn(&rootRun(b, t).step);
    }

    // IR 経路の end-to-end（.ll を zig cc で下ろして実行 — ビルドに使っている zig をそのまま渡す）
    const lower_opts = b.addOptions();
    lower_opts.addOption([]const u8, "zig_exe", b.graph.zig_exe);
    const lower_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("lower.test.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    lower_tests.root_module.addImport("std_embed", std_embed);
    lower_tests.root_module.addOptions("build_options", lower_opts);
    test_step.dependOn(&rootRun(b, lower_tests).step);

    // arch/x86_64.test.zig は ../format/elf.zig を跨ぐので module import で解決する
    const x86_64_test_module = b.createModule(.{
        .root_source_file = b.path("arch/x86_64.test.zig"),
        .target = target,
        .optimize = optimize,
    });
    x86_64_test_module.addImport("x86_64.zig", x86_64_module);
    x86_64_test_module.addImport("../format/elf.zig", elf_module);
    const x86_64_tests = b.addTest(.{ .root_module = x86_64_test_module });
    test_step.dependOn(&rootRun(b, x86_64_tests).step);

    // オラクル: GNU as の出力と自前エンコードを比較（as / objcopy が PATH に要る）
    const x86_64_oracle_module = b.createModule(.{
        .root_source_file = b.path("arch/x86_64.oracle.test.zig"),
        .target = target,
        .optimize = optimize,
    });
    x86_64_oracle_module.addImport("x86_64.zig", x86_64_module);
    const x86_64_oracle = b.addTest(.{ .root_module = x86_64_oracle_module });
    test_step.dependOn(&rootRun(b, x86_64_oracle).step);
}

/// テストの実行はリポジトリのルートを cwd にする（テストは testdata/・examples/・lean/ をルート相対で読む — build.zig を src/stage1/ へ移した後も同じ読み）
fn rootRun(b: *std.Build, t: *std.Build.Step.Compile) *std.Build.Step.Run {
    const r = b.addRunArtifact(t);
    r.setCwd(b.path("../.."));
    return r;
}

/// std/**/*.sober をコンパイラに焼き込む生成モジュール（ファイル名 → ソースの表）。
/// 読み元は凍結した写し src/stage1/std_frozen/（byte の段 S4 の前の std/ — 決定 2026-10-01。stage1 は凍結物なので、焼き込む std も凍結物にする。
/// std/ は以後 stage1 の知らない言語で書ける。鍵の名前は "std/…" のまま — import の綴りは変わらない）。
/// 列挙はソートして決定的に。std/ の中身は WriteFiles にコピーし、同じ場所に
/// @embedFile する索引 std_embed.zig を生成する（@embedFile はモジュールのディレクトリ内しか引けない）
fn stdEmbedModule(b: *std.Build) *std.Build.Module {
    const wf = b.addWriteFiles();
    var paths: std.ArrayListUnmanaged([]const u8) = .empty;
    var dir = b.build_root.handle.openDir("std_frozen", .{ .iterate = true }) catch |err|
        std.debug.panic("cannot open std_frozen/: {s}", .{@errorName(err)});
    defer dir.close();
    var walker = dir.walk(b.allocator) catch @panic("OOM");
    defer walker.deinit();
    while (walker.next() catch |err| std.debug.panic("walking std/: {s}", .{@errorName(err)})) |entry| {
        if (entry.kind != .file or !std.mem.endsWith(u8, entry.basename, ".sober")) continue;
        const rel = b.fmt("std/{s}", .{entry.path});
        std.mem.replaceScalar(u8, rel, std.fs.path.sep, '/');
        paths.append(b.allocator, rel) catch @panic("OOM");
    }
    std.mem.sort([]const u8, paths.items, {}, struct {
        fn lt(_: void, x: []const u8, y: []const u8) bool {
            return std.mem.order(u8, x, y) == .lt;
        }
    }.lt);

    var src: std.ArrayListUnmanaged(u8) = .empty;
    const w = src.writer(b.allocator);
    w.writeAll("// 生成物（build.zig の stdEmbedModule）。編集しない\npub const paths = [_][]const u8{\n") catch @panic("OOM");
    for (paths.items) |p| w.print("    \"{s}\",\n", .{p}) catch @panic("OOM");
    w.writeAll("};\npub const sources = [_][:0]const u8{\n") catch @panic("OOM");
    for (paths.items) |p| {
        _ = wf.addCopyFile(b.path(b.fmt("std_frozen/{s}", .{p["std/".len..]})), p);
        w.print("    @embedFile(\"{s}\"),\n", .{p}) catch @panic("OOM");
    }
    w.writeAll("};\n") catch @panic("OOM");
    const index = wf.add("std_embed.zig", src.items);
    return b.createModule(.{ .root_source_file = index });
}
