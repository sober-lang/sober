const std = @import("std");
const Lexer = @import("lexer.zig");
const grammar = @import("grammar.zig");
const cst = @import("cst.zig");
const cst_to_ast = @import("cst_to_ast.zig");
const ast = @import("ast.zig");
const ast_json = @import("ast_json.zig");
const loader_json = @import("loader_json.zig");
const lower = @import("lower.zig");
const ir = @import("ir.zig");
const ir_llvm = @import("ir_llvm.zig");
const ir_parse = @import("ir_parse.zig");
const ir_mem2reg = @import("ir_mem2reg.zig");
const ir_verify = @import("ir_verify.zig");
const ir_rtlower = @import("ir_rtlower.zig");
const ir_x86 = @import("ir_x86.zig");
const desugar = @import("desugar.zig");
const analyzer = @import("analyzer.zig");
const iface = @import("iface.zig");
const loader = @import("loader.zig");
const srcpos = @import("srcpos.zig");
const std_embed = @import("std_embed");

/// コンパイラに焼き込まれた std（build.zig の生成モジュール）
const std_table: loader.StdTable = .{ .paths = &std_embed.paths, .sources = &std_embed.sources };

pub fn main() !void {
    var gpa_impl: std.heap.GeneralPurposeAllocator(.{}) = .init;
    defer _ = gpa_impl.deinit();
    const gpa = gpa_impl.allocator();

    var args = std.process.args();
    _ = args.skip(); // argv[0]

    const subcommand = args.next() orelse {
        printUsage();
        std.process.exit(1);
    };

    if (std.mem.eql(u8, subcommand, "lex")) {
        try cmdLex(gpa, &args);
    } else if (std.mem.eql(u8, subcommand, "parse")) {
        try cmdParseDispatch(gpa, &args);
    } else if (std.mem.eql(u8, subcommand, "fmt")) {
        try cmdParse(gpa, &args, .print);
    } else if (std.mem.eql(u8, subcommand, "build")) {
        try cmdBuild(gpa, &args);
    } else if (std.mem.eql(u8, subcommand, "check")) {
        try cmdCheck(gpa, &args);
    } else if (std.mem.eql(u8, subcommand, "iface")) {
        try cmdIface(gpa, &args);
    } else if (std.mem.eql(u8, subcommand, "help")) {
        printUsage();
    } else {
        std.debug.print("error: unknown subcommand '{s}'\n", .{subcommand});
        printUsage();
        std.process.exit(1);
    }
}

fn printUsage() void {
    std.debug.print(
        \\usage: sober <subcommand> [options]
        \\
        \\subcommands:
        \\  lex <file.sober>     dump tokens (one per line: tag start end text)
        \\  parse <file.sober>   parse and dump the CST as an s-expression
        \\  parse --ast-json <file.sober|file.sobi>   dump one file's surface AST as JSON
        \\  parse --loader-json <file.sober|dir>   load the program and dump what the loader decides as JSON
        \\                     (parse-only cut: no loader fields; the selfhost C4 golden — scripts/astjson.sh)
        \\  fmt <file.sober>     parse and print back in canonical form
        \\  build <file.sober> [-o <binary>]   compile to a static x86_64 ELF via the SSA IR (default: a.out)
        \\                     --no-opt skips the IR passes (mem2reg; on by default for the ELF),
        \\                     --emit=ll writes LLVM text instead (dev-only oracle path;
        \\                      lower with `zig cc -target x86_64-linux-none -nostdlib -static`),
        \\                     --emit=ir writes the IR text; --opt runs the IR passes before emitting ll / ir,
        \\                     --mem-trace prints the per-depth arena allocation totals to stderr at exit
        \\  build <file.ir> --emit=ll|ir [-o <out>]   read IR text (the component boundary) and write LLVM text / IR text
        \\  check <file.sober> --core-json-pkg <path> [--iface <dir>]   print one package's Defs with
        \\                     symbolic function names (--iface: read the other packages from <dir>/*.sobi
        \\                     in the order of <dir>/link.txt — the interface-view consistency check)
        \\  check <file.sober> --pkg <path> [--iface <dir>]   type-check one package: its Defs with bodies,
        \\                     the others as signatures only (package-level check — Split.lean;
        \\                     with --core-json: print the named functions' signature table instead)
        \\  check <file.sober> [--core-json]   run the analyzer (acquire / release pairing), then
        \\                     type-check with the Lean checker
        \\                     (--core-json prints the desugared core AST instead;
        \\                      checker binary: $SOBER_CHECK, or sober-check in PATH,
        \\                      or lean/.lake/build/bin/sober-check)
        \\  iface <file.sober> (-o <dir> | --pkg <path>)   write the .sobi interface of every package in
        \\                     the link set to <dir>/<path>.sobi plus the link table <dir>/link.txt
        \\                     (--pkg prints one package's .sobi to stdout)
        \\  help               show this message
        \\
    , .{});
}

fn readSource(gpa: std.mem.Allocator, args: *std.process.ArgIterator, cmd: []const u8) ![:0]const u8 {
    const file_path = args.next() orelse {
        std.debug.print("error: '{s}' requires a source file\n", .{cmd});
        std.process.exit(1);
    };
    const content = try std.fs.cwd().readFileAlloc(gpa, file_path, 1 << 20);
    defer gpa.free(content);
    return gpa.dupeZ(u8, content);
}

fn loadOrExit(gpa: std.mem.Allocator, entry: []const u8) loader.Loaded {
    var ldiag: loader.Diag = .{};
    return loader.load(gpa, entry, std_table, &ldiag) catch |err| {
        srcpos.printDiag(ldiag.loc, ldiag.msg, @errorName(err));
        std.process.exit(1);
    };
}

fn cmdLex(gpa: std.mem.Allocator, args: *std.process.ArgIterator) !void {
    const source = try readSource(gpa, args, "lex");
    defer gpa.free(source);

    var buf: [4096]u8 = undefined;
    var stdout = std.fs.File.stdout().writer(&buf);
    const w = &stdout.interface;

    var lexer = Lexer.init(source);
    while (true) {
        const t = lexer.next();
        try w.print("{s} {d} {d} {s}\n", .{ @tagName(t.tag), t.loc.start, t.loc.end, t.slice(source) });
        if (t.tag == .eof) break;
    }
    try w.flush();
}

fn cmdParseDispatch(gpa: std.mem.Allocator, args: *std.process.ArgIterator) !void {
    var peek = args.*;
    const first = peek.next() orelse return cmdParse(gpa, args, .sexpr);
    if (std.mem.eql(u8, first, "--loader-json")) {
        _ = args.next();
        return cmdLoaderJson(gpa, args);
    }
    if (!std.mem.eql(u8, first, "--ast-json")) return cmdParse(gpa, args, .sexpr);
    _ = args.next();
    try cmdAstJson(gpa, args);
}

/// `parse --loader-json <entry>`: entry（.sober ファイルか main package のディレクトリ）から load した Program の、
/// loader が決める情報を JSON で stdout へ（loader_json.zig — selfhost の第 2 黄金）
fn cmdLoaderJson(gpa: std.mem.Allocator, args: *std.process.ArgIterator) !void {
    const entry = args.next() orelse {
        std.debug.print("error: 'parse --loader-json' requires an entry (file or directory)\n", .{});
        std.process.exit(1);
    };
    var loaded = loadOrExit(gpa, entry);
    defer loaded.deinit();
    const text = try loader_json.toOwned(gpa, &loaded.program);
    defer gpa.free(text);
    try std.fs.File.stdout().writeAll(text);
}

/// `parse --ast-json <file>`: 1 ファイルの表層 AST を JSON で stdout へ（ast_json.zig）
fn cmdAstJson(gpa: std.mem.Allocator, args: *std.process.ArgIterator) !void {
    var peek = args.*;
    const path = peek.next() orelse "";
    const source = try readSource(gpa, args, "parse --ast-json");
    defer gpa.free(source);
    var diag: cst_to_ast.Diag = .{};
    var tree = ast_json.parse(gpa, source, std.mem.endsWith(u8, path, ".sobi"), &diag) catch |err| {
        if (err == error.ParseFailed) {
            std.debug.print("parse error: source does not match the v0 grammar\n", .{});
        } else {
            std.debug.print("error: {s} at tok {d} (rule {s}): {s}\n", .{ @errorName(err), diag.tok, diag.rule, diag.what });
        }
        std.process.exit(1);
    };
    defer tree.deinit();
    const text = try ast_json.toOwned(gpa, tree.file);
    defer gpa.free(text);
    try std.fs.File.stdout().writeAll(text);
}

fn cmdParse(gpa: std.mem.Allocator, args: *std.process.ArgIterator, mode: enum { sexpr, print }) !void {
    const source = try readSource(gpa, args, if (mode == .sexpr) "parse" else "fmt");
    defer gpa.free(source);

    const tokens = try Lexer.tokenize(gpa, source);
    defer gpa.free(tokens);
    var m = grammar.Matcher.init(gpa, tokens);
    defer m.deinit();
    const root = (try m.parse("source_file")) orelse {
        std.debug.print("parse error: source does not match the v0 grammar\n", .{});
        std.process.exit(1);
    };
    const tree = cst.Tree.fromMatcher(&m, source, root);

    const text = if (mode == .sexpr) try cst.sexpr(gpa, tree) else try cst.print(gpa, tree);
    defer gpa.free(text);

    var buf: [4096]u8 = undefined;
    var stdout = std.fs.File.stdout().writer(&buf);
    const w = &stdout.interface;
    try w.writeAll(text);
    if (mode == .sexpr) try w.writeAll("\n");
    try w.flush();
}

fn cmdBuild(gpa: std.mem.Allocator, args: *std.process.ArgIterator) !void {
    const entry = args.next() orelse {
        std.debug.print("error: 'build' requires a source file or a package directory\n", .{});
        std.process.exit(1);
    };

    var out_path: []const u8 = "a.out";
    var mem_trace = false;
    var emit: IrOut = .elf;
    // IR パスの既定: ELF は有効（本番の形）、--emit=ir|ll は無効（パス前の IR を見るのがデバッグの入口）
    var opt: ?bool = null;
    while (args.next()) |flag| {
        if (std.mem.eql(u8, flag, "-o")) {
            out_path = args.next() orelse {
                std.debug.print("error: -o requires an argument\n", .{});
                std.process.exit(1);
            };
        } else if (std.mem.eql(u8, flag, "--mem-trace")) {
            mem_trace = true;
        } else if (std.mem.eql(u8, flag, "--emit=ll")) {
            emit = .ll;
        } else if (std.mem.eql(u8, flag, "--emit=ir")) {
            emit = .ir;
        } else if (std.mem.eql(u8, flag, "--opt")) {
            opt = true;
        } else if (std.mem.eql(u8, flag, "--no-opt")) {
            opt = false;
        } else {
            std.debug.print("error: unknown flag {s}\n", .{flag});
            std.process.exit(1);
        }
    }
    const run_opt = opt orelse (emit == .elf);

    // .ir 入力は IR 経路しか無い（ELF は正規バックエンド ir_x86）
    if (std.mem.endsWith(u8, entry, ".ir")) return emitFromIr(gpa, entry, out_path, emit, run_opt);

    var loaded = loadOrExit(gpa, entry);
    defer loaded.deinit();

    return emitIr(gpa, &loaded.program, out_path, emit, run_opt, mem_trace);
}

/// `build`: AST → SSA IR（lower.zig）→ ELF（正規バックエンド ir_x86）/ LLVM テキスト / IR テキスト
fn emitIr(gpa: std.mem.Allocator, prog: *const ast.Program, out_path: []const u8, out: IrOut, opt: bool, mem_trace: bool) !void {
    var ldiag: lower.Diag = .{};
    var m = lower.lowerOpts(gpa, prog, &ldiag, .{ .mem_trace = mem_trace }) catch |err| {
        reportAt(prog.srcmap, ldiag.pos, @errorName(err), ldiag.what);
        std.process.exit(1);
    };
    defer m.deinit();
    ir.verify(&m) catch {
        std.debug.print("internal error: invalid IR\n", .{});
        std.process.exit(1);
    };
    if (opt) try runPasses(&m);
    try writeIr(gpa, &m, out, out_path);
}

/// IR 経路の成果物: ELF（ir_x86 — 正規バックエンド）/ LLVM テキスト / IR テキスト
const IrOut = enum { elf, ll, ir };

/// IR を成果物にして書き出す。ELF と .ll は region op を展開してから（ir_rtlower — バックエンドの手前の共有境界）、
/// IR テキストは展開前の形のまま
fn writeIr(gpa: std.mem.Allocator, m: *ir.Module, out: IrOut, out_path: []const u8) !void {
    if (out == .elf) {
        try lowerRt(m);
        const bin = try ir_x86.emit(gpa, m);
        defer gpa.free(bin);
        if (std.fs.path.dirname(out_path)) |d| try std.fs.cwd().makePath(d);
        const file = try std.fs.cwd().createFile(out_path, .{ .mode = 0o755 });
        defer file.close();
        return file.writeAll(bin);
    }
    const text = if (out == .ll) blk: {
        try lowerRt(m);
        break :blk try ir_llvm.emit(gpa, m);
    } else blk: {
        var w: std.Io.Writer.Allocating = .init(gpa);
        try ir.print(m, &w.writer);
        break :blk try w.toOwnedSlice();
    };
    defer gpa.free(text);
    try writeFileMkdir(out_path, text);
}

fn lowerRt(m: *ir.Module) !void {
    try ir_rtlower.run(m);
    var vd: ir_verify.Diag = .{};
    ir_verify.verifyDiag(m, &vd) catch {
        std.debug.print("internal error: invalid IR after rtlower: {s}\n", .{vd.what});
        std.process.exit(1);
    };
}

/// `build <file.ir> --emit=ll|ir`: IR テキスト（ir_parse.zig — コンポーネント境界）→ LLVM テキスト / IR テキスト
/// IR パス列（B-7: mem2reg）。各パスの後で検証する（パスのバグを観測の前に止める）
fn runPasses(m: *ir.Module) !void {
    try ir_mem2reg.run(m);
    var vd: ir_verify.Diag = .{};
    ir_verify.verifyDiag(m, &vd) catch {
        std.debug.print("internal error: invalid IR after mem2reg: {s}\n", .{vd.what});
        std.process.exit(1);
    };
}

fn emitFromIr(gpa: std.mem.Allocator, path: []const u8, out_path: []const u8, out: IrOut, opt: bool) !void {
    const src = std.fs.cwd().readFileAlloc(gpa, path, 1 << 30) catch |err| {
        std.debug.print("error reading {s}: {}\n", .{ path, err });
        std.process.exit(1);
    };
    defer gpa.free(src);
    var pdiag: ir_parse.Diag = .{};
    var m = ir_parse.parse(gpa, src, &pdiag) catch |err| {
        std.debug.print("{s}:{d}: error: {s} ({s})\n", .{ path, pdiag.line, pdiag.what, @errorName(err) });
        std.process.exit(1);
    };
    defer m.deinit();
    ir.verify(&m) catch {
        std.debug.print("{s}: error: invalid IR (block edges / ret types)\n", .{path});
        std.process.exit(1);
    };
    if (opt) try runPasses(&m);
    try writeIr(gpa, &m, out, out_path);
}

/// `iface`: リンク集合の全 package の `.sobi`（language.md 29 節）とリンク表を書く
fn cmdIface(gpa: std.mem.Allocator, args: *std.process.ArgIterator) !void {
    const entry = args.next() orelse {
        std.debug.print("error: 'iface' requires a source file or a package directory\n", .{});
        std.process.exit(1);
    };
    var out_dir: ?[]const u8 = null;
    var only: ?[]const u8 = null;
    while (args.next()) |flag| {
        const val = args.next() orelse {
            std.debug.print("error: {s} requires an argument\n", .{flag});
            std.process.exit(1);
        };
        if (std.mem.eql(u8, flag, "-o")) {
            out_dir = val;
        } else if (std.mem.eql(u8, flag, "--pkg")) {
            only = val;
        } else {
            std.debug.print("error: unknown flag {s}\n", .{flag});
            std.process.exit(1);
        }
    }
    if ((out_dir == null) == (only == null)) {
        std.debug.print("error: 'iface' takes exactly one of -o <dir> or --pkg <path>\n", .{});
        std.process.exit(1);
    }

    var loaded = loadOrExit(gpa, entry);
    defer loaded.deinit();
    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();
    const a = arena.allocator();

    var found = false;
    for (loaded.program.pkgs) |pkg| {
        if (only) |p| if (!std.mem.eql(u8, p, pkg.path)) continue;
        found = true;
        var idiag: iface.Diag = .{};
        const text = iface.emitPkg(a, &loaded.program, pkg, &idiag) catch |err| {
            reportAt(loaded.program.srcmap, idiag.pos, @errorName(err), idiag.what);
            std.process.exit(1);
        };
        if (out_dir) |dir| {
            const path = try std.fmt.allocPrint(a, "{s}/{s}.sobi", .{ dir, pkg.path });
            try writeFileMkdir(path, text);
        } else {
            var buf: [4096]u8 = undefined;
            var stdout = std.fs.File.stdout().writer(&buf);
            try stdout.interface.writeAll(text);
            try stdout.interface.flush();
        }
    }
    if (!found) {
        std.debug.print("error: package {s} is not in the link set\n", .{only.?});
        std.process.exit(1);
    }
    if (out_dir) |dir| {
        const path = try std.fmt.allocPrint(a, "{s}/link.txt", .{dir});
        try writeFileMkdir(path, try iface.linkTable(a, &loaded.program));
    }
}

fn writeFileMkdir(path: []const u8, text: []const u8) !void {
    if (std.fs.path.dirname(path)) |d| try std.fs.cwd().makePath(d);
    const file = try std.fs.cwd().createFile(path, .{});
    defer file.close();
    try file.writeAll(text);
}

/// `check`: 脱糖して Lean 製型検査器（sober-check）に渡し、判定を relay する。
/// --core-json なら脱糖後のコア AST JSON を出力して終わる（検査器なしで動く）
fn cmdCheck(gpa: std.mem.Allocator, args: *std.process.ArgIterator) !void {
    const entry = args.next() orelse {
        std.debug.print("error: 'check' requires a source file or a package directory\n", .{});
        std.process.exit(1);
    };

    var core_json_only = false;
    var pkg_json: ?[]const u8 = null;
    var pkg_check: ?[]const u8 = null;
    var iface_dir: ?[]const u8 = null;
    while (args.next()) |flag| {
        if (std.mem.eql(u8, flag, "--core-json")) {
            core_json_only = true;
        } else if (std.mem.eql(u8, flag, "--core-json-pkg") or std.mem.eql(u8, flag, "--iface") or std.mem.eql(u8, flag, "--pkg")) {
            const val = args.next() orelse {
                std.debug.print("error: {s} requires an argument\n", .{flag});
                std.process.exit(1);
            };
            switch (flag[2]) {
                'c' => pkg_json = val,
                'i' => iface_dir = val,
                else => pkg_check = val,
            }
        } else {
            std.debug.print("error: unknown flag '{s}'\n", .{flag});
            std.process.exit(1);
        }
    }
    if (iface_dir != null and pkg_json == null and pkg_check == null) {
        std.debug.print("error: --iface needs --core-json-pkg <path> or --pkg <path>\n", .{});
        std.process.exit(1);
    }

    // package 単位の検査（V5-6 = I-3）: P の Def だけを本体つき・他は署名だけで sober-check に渡す。
    // 受理の合成（全 package の受理 ⇒ 全体の DefsOk）は Split.lean の defsOk_of_parts
    if (pkg_check) |target| {
        var loaded = if (iface_dir) |dir| blk: {
            var ldiag: loader.Diag = .{};
            break :blk loader.loadIface(gpa, entry, std_table, dir, target, &ldiag) catch |err| {
                srcpos.printDiag(ldiag.loc, ldiag.msg, @errorName(err));
                std.process.exit(1);
            };
        } else loadOrExit(gpa, entry);
        defer loaded.deinit();
        var ddiag: desugar.Diag = .{};
        var core = desugar.desugarOpts(gpa, &loaded.program, .{ .only = target, .view = target }, &ddiag) catch |err| {
            reportAt(loaded.program.srcmap, ddiag.pos, @errorName(err), ddiag.what);
            std.process.exit(1);
        };
        defer core.deinit();
        if (core_json_only) {
            // --sigs 相当: 名前付き関数の署名表（視点間の突き合わせ用 — SigEq の仮定）
            const sigs = try desugar.toSigsJson(gpa, core, core.n_named);
            defer gpa.free(sigs);
            var buf: [4096]u8 = undefined;
            var stdout = std.fs.File.stdout().writer(&buf);
            try stdout.interface.writeAll(sigs);
            try stdout.interface.flush();
            return;
        }
        const json = try desugar.toPartsJson(gpa, core, std.mem.eql(u8, target, loader.main_pkg_path));
        defer gpa.free(json);
        return runChecker(gpa, json);
    }

    // 一致検証の比較専用出力（V5-5）: package P の Def 群を記号名つきで。--iface なら P 以外を .sobi から読む
    if (pkg_json) |target| {
        var loaded = if (iface_dir) |dir| blk: {
            var ldiag: loader.Diag = .{};
            break :blk loader.loadIface(gpa, entry, std_table, dir, target, &ldiag) catch |err| {
                srcpos.printDiag(ldiag.loc, ldiag.msg, @errorName(err));
                std.process.exit(1);
            };
        } else loadOrExit(gpa, entry);
        defer loaded.deinit();
        var ddiag: desugar.Diag = .{};
        var core = desugar.desugarOpts(gpa, &loaded.program, .{ .only = if (iface_dir != null) target else null, .view = target }, &ddiag) catch |err| {
            reportAt(loaded.program.srcmap, ddiag.pos, @errorName(err), ddiag.what);
            std.process.exit(1);
        };
        defer core.deinit();
        const text = try desugar.toPkgJson(gpa, core, target);
        defer gpa.free(text);
        var buf: [4096]u8 = undefined;
        var stdout = std.fs.File.stdout().writer(&buf);
        try stdout.interface.writeAll(text);
        try stdout.interface.flush();
        return;
    }

    var loaded = loadOrExit(gpa, entry);
    defer loaded.deinit();

    // analyzer（受理の定義に含む層 — docs/design-dev.md 層の線引き）。--core-json は脱糖の出力だけを見る開発用なので走らせない
    if (!core_json_only) {
        var aarena = std.heap.ArenaAllocator.init(gpa);
        defer aarena.deinit();
        const findings = try analyzer.analyze(aarena.allocator(), &loaded.program);
        for (findings) |f| reportAt(loaded.program.srcmap, f.pos, "Analyzer", f.what);
        if (findings.len > 0) std.process.exit(1);
    }

    var ddiag: desugar.Diag = .{};
    var core = desugar.desugar(gpa, &loaded.program, &ddiag) catch |err| {
        reportAt(loaded.program.srcmap, ddiag.pos, @errorName(err), ddiag.what);
        std.process.exit(1);
    };
    defer core.deinit();

    const json = try desugar.toJson(gpa, core);
    defer gpa.free(json);

    if (core_json_only) {
        var buf: [4096]u8 = undefined;
        var stdout = std.fs.File.stdout().writer(&buf);
        const w = &stdout.interface;
        try w.writeAll(json);
        try w.writeAll("\n");
        try w.flush();
        return;
    }

    const checker = findChecker(gpa) orelse {
        std.debug.print("error: sober-check not found (set $SOBER_CHECK, put it in PATH, or `lake build` in lean/)\n", .{});
        std.process.exit(1);
    };
    defer gpa.free(checker);

    var child = std.process.Child.init(&.{checker}, gpa);
    child.stdin_behavior = .Pipe;
    child.stdout_behavior = .Pipe;
    try child.spawn();
    try child.stdin.?.writeAll(json);
    child.stdin.?.close();
    child.stdin = null;
    const verdict = try child.stdout.?.readToEndAlloc(gpa, 1 << 20);
    defer gpa.free(verdict);
    const term = try child.wait();

    var buf: [4096]u8 = undefined;
    var stdout = std.fs.File.stdout().writer(&buf);
    const w = &stdout.interface;
    try w.writeAll(verdict);
    try w.flush();
    switch (term) {
        .Exited => |code| std.process.exit(code),
        else => std.process.exit(1),
    }
}

/// 検査器に JSON を渡し、判定を relay して終了コードで終わる
fn runChecker(gpa: std.mem.Allocator, json: []const u8) !void {
    const checker = findChecker(gpa) orelse {
        std.debug.print("error: sober-check not found (set $SOBER_CHECK, put it in PATH, or `lake build` in lean/)\n", .{});
        std.process.exit(1);
    };
    defer gpa.free(checker);
    var child = std.process.Child.init(&.{checker}, gpa);
    child.stdin_behavior = .Pipe;
    child.stdout_behavior = .Pipe;
    try child.spawn();
    try child.stdin.?.writeAll(json);
    child.stdin.?.close();
    child.stdin = null;
    const verdict = try child.stdout.?.readToEndAlloc(gpa, 1 << 20);
    defer gpa.free(verdict);
    const term = try child.wait();
    var buf: [4096]u8 = undefined;
    var stdout = std.fs.File.stdout().writer(&buf);
    try stdout.interface.writeAll(verdict);
    try stdout.interface.flush();
    switch (term) {
        .Exited => |code| std.process.exit(code),
        else => std.process.exit(1),
    }
}

/// 検査器バイナリの探索: $SOBER_CHECK → PATH の sober-check → lean/.lake/build/bin/sober-check
fn findChecker(gpa: std.mem.Allocator) ?[]const u8 {
    if (std.process.getEnvVarOwned(gpa, "SOBER_CHECK")) |p| return p else |_| {}
    if (std.process.getEnvVarOwned(gpa, "PATH")) |path_env| {
        defer gpa.free(path_env);
        var it = std.mem.splitScalar(u8, path_env, ':');
        while (it.next()) |dir| {
            if (dir.len == 0) continue;
            const candidate = std.fs.path.join(gpa, &.{ dir, "sober-check" }) catch return null;
            if (std.fs.cwd().access(candidate, .{})) |_| return candidate else |_| gpa.free(candidate);
        }
    } else |_| {}
    const fallback = "lean/.lake/build/bin/sober-check";
    if (std.fs.cwd().access(fallback, .{})) |_| {
        return gpa.dupe(u8, fallback) catch null;
    } else |_| return null;
}

/// lower / desugar の診断を srcmap で解決して報告する（loader と同じ 1 行形 — srcpos.printDiag）
fn reportAt(map: srcpos.SourceMap, pos: srcpos.Pos, err: []const u8, what: []const u8) void {
    var buf: [512]u8 = undefined;
    var w: std.Io.Writer = .fixed(&buf);
    srcpos.writeLoc(&w, map, pos, "") catch {};
    srcpos.printDiag(w.buffered(), what, err);
}
