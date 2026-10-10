//! パッケージローダ（language.md 20 節「名前解決の最小形」）。
//!
//! - 単一モジュール前提。import パスは**プロジェクトルート（カレントディレクトリ）相対**
//! - `std/` で始まる import パスは予約。ルートでなくコンパイラに焼き込まれた std 表から引く
//! - package 名 = ディレクトリ名を強制（main のみ例外）
//! - 循環 import は拒否
//! - トップレベル const（決定 14: const 式のみ）をロード時に畳む
//! - ローカル束縛とトップレベル名の衝突を拒否（localnames.zig）
//! - 純粋な式の式文を拒否（exprstmt.zig — 呼び出しの結果は捨ててよい、Go 同型）
//!
//! ディスク IO（load）と結合（link）を分離してある — テストは link にソースを直接渡す。
const std = @import("std");
const Lexer = @import("lexer.zig");
const grammar = @import("grammar.zig");
const cst = @import("cst.zig");
const cst_to_ast = @import("cst_to_ast.zig");
const ast = @import("ast.zig");
const localnames = @import("localnames.zig");
const exprstmt = @import("exprstmt.zig");
const srcpos = @import("srcpos.zig");
const embed = @import("embed.zig");

pub const Error = error{ LoadError, Unsupported, Malformed } || std.mem.Allocator.Error;

pub const Diag = struct {
    /// 問題のあったファイル（またはパッケージパス）。pos が解決できればそちらの path が優先
    path: []const u8 = "",
    what: []const u8 = "",
    /// 問題の座標（srcpos.zig — 全ソース通しのトークン番号）。座標の無い失敗（IO・循環等）は null
    pos: ?srcpos.Pos = null,
    /// 表示用に写した座標と説明。load / link が失敗して返る直前に render が埋める —
    /// path / what が指す arena は失敗時に解放されうるので、ここへ写して切り離す
    loc: []const u8 = "",
    msg: []const u8 = "",
    rendered: bool = false,
    buf: [512]u8 = undefined,

    fn render(self: *Diag, map: srcpos.SourceMap) void {
        if (self.rendered) return;
        self.rendered = true;
        var w: std.Io.Writer = .fixed(&self.buf);
        srcpos.writeLoc(&w, map, self.pos, self.path) catch {};
        const n = w.end;
        w.writeAll(self.what) catch {};
        self.loc = self.buf[0..n];
        self.msg = self.buf[n..w.end];
    }
};

pub const SrcFile = struct {
    /// パッケージパス（ルート相対。main package は "main"）
    pkg_path: []const u8,
    /// 表示用のファイル名
    name: []const u8,
    source: [:0]const u8,
};

pub const Loaded = struct {
    arena: std.heap.ArenaAllocator,
    program: ast.Program,

    pub fn deinit(self: *Loaded) void {
        self.arena.deinit();
    }
};

/// main package のパス（合成名。ディレクトリ名一致の例外）
pub const main_pkg_path = "main";

/// 予約 prefix。これで始まる import は std 表から解決する（ユーザーの std/ ディレクトリより優先）
pub const std_prefix = "std/";

/// コンパイラに焼き込まれた std のソース表（ファイル名 → ソース）。
/// paths[i] は "std/strings/strings.sober" の形、sources[i] がその中身。
/// 焼き込みの手段（Zig なら build.zig の生成モジュール）は loader の関心外
pub const StdTable = struct {
    paths: []const []const u8 = &.{},
    sources: []const [:0]const u8 = &.{},
};

pub fn isStdPath(pkg_path: []const u8) bool {
    return std.mem.startsWith(u8, pkg_path, std_prefix);
}

/// entry（.sober ファイルか ディレクトリ）から main package を読み、import を辿って Program を組む
pub fn load(gpa: std.mem.Allocator, entry: []const u8, std_table: StdTable, diag: *Diag) Error!Loaded {
    return loadIn(gpa, entry, std_table, diag) catch |err| {
        diag.render(.{});
        return err;
    };
}

fn loadIn(gpa: std.mem.Allocator, entry: []const u8, std_table: StdTable, diag: *Diag) Error!Loaded {
    var arena = std.heap.ArenaAllocator.init(gpa);
    errdefer arena.deinit();
    // 失敗時は arena を解放する前に表示を写す（diag.path / what は arena の文字列を指しうる —
    // 例: 存在しない package の import の dir_path。errdefer は逆順なので arena.deinit より先に走る）
    errdefer diag.render(.{});
    const a = arena.allocator();

    var files: std.ArrayListUnmanaged(SrcFile) = .empty;
    defer files.deinit(gpa);
    try readEntry(gpa, a, entry, &files, diag);
    const program = try linkLoop(gpa, a, &files, std_table, .fs, diag);
    return .{ .arena = arena, .program = program };
}

/// main package を entry（.sober ファイルか ディレクトリ）から積む
fn readEntry(gpa: std.mem.Allocator, a: std.mem.Allocator, entry: []const u8, files: *std.ArrayListUnmanaged(SrcFile), diag: *Diag) Error!void {
    const is_dir = blk: {
        var d = std.fs.cwd().openDir(entry, .{}) catch break :blk false;
        d.close();
        break :blk true;
    };
    if (is_dir) {
        try readPkgDir(gpa, a, entry, main_pkg_path, files, diag);
    } else {
        const src = readFileZ(a, entry) catch {
            diag.* = .{ .path = entry, .what = "cannot read file" };
            return error.LoadError;
        };
        try files.append(gpa, .{ .pkg_path = main_pkg_path, .name = entry, .source = src });
    }
}

/// interface 視点のロード（V5-5 — 裁定 X1 / M3）: リンク表 `<iface_dir>/link.txt` の順に、target だけをソースから、
/// 他の全 package を `<iface_dir>/<path>.sobi` から読む。import の発見ループは回さない（ロード順はリンク表 = リンカの知識）
pub fn loadIface(gpa: std.mem.Allocator, entry: []const u8, std_table: StdTable, iface_dir: []const u8, target: []const u8, diag: *Diag) Error!Loaded {
    return loadIfaceIn(gpa, entry, std_table, iface_dir, target, diag) catch |err| {
        diag.render(.{});
        return err;
    };
}

fn loadIfaceIn(gpa: std.mem.Allocator, entry: []const u8, std_table: StdTable, iface_dir: []const u8, target: []const u8, diag: *Diag) Error!Loaded {
    var arena = std.heap.ArenaAllocator.init(gpa);
    errdefer arena.deinit();
    // 失敗時は arena を解放する前に表示を写す（diag.path / what は arena の文字列を指しうる —
    // 例: 存在しない package の import の dir_path。errdefer は逆順なので arena.deinit より先に走る）
    errdefer diag.render(.{});
    const a = arena.allocator();
    const table_path = try std.fs.path.join(a, &.{ iface_dir, "link.txt" });
    const table = readFileZ(a, table_path) catch {
        diag.* = .{ .path = table_path, .what = "cannot read the link table" };
        return error.LoadError;
    };
    var files: std.ArrayListUnmanaged(SrcFile) = .empty;
    defer files.deinit(gpa);
    var found = false;
    var lines = std.mem.tokenizeScalar(u8, table, '\n');
    while (lines.next()) |pkg_path| {
        if (!std.mem.eql(u8, pkg_path, target)) {
            const path = try std.fmt.allocPrint(a, "{s}/{s}.sobi", .{ iface_dir, pkg_path });
            const src = readFileZ(a, path) catch {
                diag.* = .{ .path = path, .what = "cannot read the interface" };
                return error.LoadError;
            };
            try files.append(gpa, .{ .pkg_path = pkg_path, .name = path, .source = src });
            continue;
        }
        found = true;
        if (std.mem.eql(u8, pkg_path, main_pkg_path)) {
            try readEntry(gpa, a, entry, &files, diag);
        } else if (isStdPath(pkg_path)) {
            try addStdPkg(gpa, std_table, pkg_path, &files, diag);
        } else {
            try readPkgDir(gpa, a, pkg_path, pkg_path, &files, diag);
        }
    }
    if (!found) {
        diag.* = .{ .path = target, .what = "package is not in the link table" };
        return error.LoadError;
    }
    const program = try link(gpa, a, files.items, diag, .{});
    return .{ .arena = arena, .program = program };
}

/// ディスクを読まずに link する（テスト用）。未ロードの import は std 表からだけ読み足す
pub fn linkWithStd(
    gpa: std.mem.Allocator,
    a: std.mem.Allocator,
    files: []const SrcFile,
    std_table: StdTable,
    diag: *Diag,
) Error!ast.Program {
    var list: std.ArrayListUnmanaged(SrcFile) = .empty;
    defer list.deinit(gpa);
    try list.appendSlice(gpa, files);
    return linkLoop(gpa, a, &list, std_table, .none, diag) catch |err| {
        diag.render(.{});
        return err;
    };
}

/// import の収集は AST が要るので link に任せ、link が返す「未ロードの import」を
/// 読み足しては link し直す。std/ prefix は std 表から、他は fs ならディレクトリ
/// （ルート相対 = cwd 相対）から
fn linkLoop(
    gpa: std.mem.Allocator,
    a: std.mem.Allocator,
    files: *std.ArrayListUnmanaged(SrcFile),
    std_table: StdTable,
    fallback: enum { fs, none },
    diag: *Diag,
) Error!ast.Program {
    var pending: std.ArrayListUnmanaged([]const u8) = .empty;
    defer pending.deinit(gpa);
    var seen: std.StringHashMapUnmanaged(void) = .empty;
    defer seen.deinit(gpa);

    var loaded = try link(gpa, a, files.items, diag, .{ .missing = &pending, .seen = &seen });
    while (pending.items.len > 0) {
        const need = try pending.toOwnedSlice(gpa);
        defer gpa.free(need);
        for (need) |pkg_path| {
            if (seen.contains(pkg_path)) continue;
            try seen.put(gpa, pkg_path, {});
            if (isStdPath(pkg_path)) {
                try addStdPkg(gpa, std_table, pkg_path, files, diag);
            } else switch (fallback) {
                .fs => try readPkgDir(gpa, a, pkg_path, pkg_path, files, diag),
                .none => {
                    diag.* = .{ .path = pkg_path, .what = "imported package is not loaded" };
                    return error.LoadError;
                },
            }
        }
        loaded = try link(gpa, a, files.items, diag, .{ .missing = &pending, .seen = &seen });
    }
    return loaded;
}

/// std 表から pkg_path 直下（dirname 一致）のファイルを積む
fn addStdPkg(
    gpa: std.mem.Allocator,
    std_table: StdTable,
    pkg_path: []const u8,
    files: *std.ArrayListUnmanaged(SrcFile),
    diag: *Diag,
) Error!void {
    var found = false;
    for (std_table.paths, std_table.sources) |path, source| {
        const dir = std.fs.path.dirname(path) orelse continue;
        if (!std.mem.eql(u8, dir, pkg_path)) continue;
        try files.append(gpa, .{ .pkg_path = pkg_path, .name = path, .source = source });
        found = true;
    }
    if (!found) {
        diag.* = .{ .path = pkg_path, .what = "no such std package" };
        return error.LoadError;
    }
}

fn readFileZ(a: std.mem.Allocator, path: []const u8) ![:0]const u8 {
    const content = try std.fs.cwd().readFileAlloc(a, path, 1 << 20);
    const z = try a.dupeZ(u8, content);
    return z;
}

/// ディレクトリの全 *.sober を pkg_path のファイルとして読む
fn readPkgDir(
    gpa: std.mem.Allocator,
    a: std.mem.Allocator,
    dir_path: []const u8,
    pkg_path: []const u8,
    files: *std.ArrayListUnmanaged(SrcFile),
    diag: *Diag,
) Error!void {
    var dir = std.fs.cwd().openDir(dir_path, .{ .iterate = true }) catch {
        diag.* = .{ .path = dir_path, .what = "cannot open package directory" };
        return error.LoadError;
    };
    defer dir.close();
    // ファイル名順に読む（ファイル順 = 宣言順 = 関数表と error タグの順。fs の列挙順に依らせない — hermetic）
    var names: std.ArrayListUnmanaged([]const u8) = .empty;
    defer names.deinit(gpa);
    var it = dir.iterate();
    while (it.next() catch {
        diag.* = .{ .path = dir_path, .what = "cannot read package directory" };
        return error.LoadError;
    }) |entry| {
        if (entry.kind != .file or !std.mem.endsWith(u8, entry.name, ".sober")) continue;
        try names.append(gpa, try a.dupe(u8, entry.name));
    }
    std.mem.sort([]const u8, names.items, {}, lessStr);
    for (names.items) |name| {
        const full = try std.fs.path.join(a, &.{ dir_path, name });
        const src = readFileZ(a, full) catch {
            diag.* = .{ .path = full, .what = "cannot read file" };
            return error.LoadError;
        };
        try files.append(gpa, .{ .pkg_path = pkg_path, .name = full, .source = src });
    }
    if (names.items.len == 0) {
        diag.* = .{ .path = dir_path, .what = "package directory has no .sober files" };
        return error.LoadError;
    }
}

fn lessStr(_: void, x: []const u8, y: []const u8) bool {
    return std.mem.lessThan(u8, x, y);
}

const LinkOpts = struct {
    /// 非 null なら、未ロードの import パスをここへ積んで LoadError にしない（load の反復用）
    missing: ?*std.ArrayListUnmanaged([]const u8) = null,
    seen: ?*std.StringHashMapUnmanaged(void) = null,
};

/// ソース群から Program を組む（純粋。ディスク IO なし）。
/// AST・Pkg・文字列は a（arena）に置く
pub fn link(
    gpa: std.mem.Allocator,
    a: std.mem.Allocator,
    files: []const SrcFile,
    diag: *Diag,
    opts: LinkOpts,
) Error!ast.Program {
    var map: srcpos.SourceMap = .{};
    return linkIn(gpa, a, files, diag, opts, &map) catch |err| {
        diag.render(map);
        return err;
    };
}

fn linkIn(
    gpa: std.mem.Allocator,
    a: std.mem.Allocator,
    files: []const SrcFile,
    diag: *Diag,
    opts: LinkOpts,
    map: *srcpos.SourceMap,
) Error!ast.Program {
    var pkg_map: std.StringHashMapUnmanaged(*ast.Pkg) = .empty;
    defer pkg_map.deinit(gpa);
    var pkg_list: std.ArrayListUnmanaged(*ast.Pkg) = .empty;

    // parse + package ごとに束ねる
    for (files) |f| {
        const parsed = try parseOne(gpa, a, f, map, diag);
        const gop = try pkg_map.getOrPut(gpa, f.pkg_path);
        if (!gop.found_existing) {
            const p = try a.create(ast.Pkg);
            p.* = .{ .path = f.pkg_path, .name = parsed.package, .files = &.{} };
            gop.value_ptr.* = p;
            try pkg_list.append(a, p);
        }
        const pkg = gop.value_ptr.*;
        // package 名の一致（ファイル間、およびディレクトリ名と — language.md 20 節）
        const want: []const u8 = if (std.mem.eql(u8, f.pkg_path, main_pkg_path))
            "main"
        else
            std.fs.path.basename(f.pkg_path);
        if (!std.mem.eql(u8, parsed.package, want)) {
            diag.* = .{ .path = f.name, .what = "package name must match the directory name" };
            return error.LoadError;
        }
        const grown = try a.alloc(*ast.File, pkg.files.len + 1);
        @memcpy(grown[0..pkg.files.len], pkg.files);
        grown[pkg.files.len] = parsed;
        pkg.files = grown;
    }

    const main_pkg = pkg_map.get(main_pkg_path) orelse {
        diag.* = .{ .path = main_pkg_path, .what = "no main package" };
        return error.LoadError;
    };

    // ローカル束縛とトップレベル名の衝突（syntax.md 決定 13 の延長）。package 内で閉じるので import 解決より前
    for (pkg_list.items) |pkg| {
        if (localnames.check(pkg)) |hit| {
            diag.* = .{ .path = pkg.path, .what = hit.what(), .pos = hit.tok };
            return error.LoadError;
        }
        if (exprstmt.check(pkg)) |hit| {
            diag.* = .{ .path = pkg.path, .what = hit.what(), .pos = hit.tok };
            return error.LoadError;
        }
    }

    // import 表（参照名 → pkg path）と未ロード検出
    var missing_any = false;
    for (pkg_list.items) |pkg| {
        for (pkg.files) |file| {
            for (file.imports) |imp| {
                if (pkg_map.get(imp.path) == null) {
                    if (opts.missing) |m| {
                        const already = if (opts.seen) |sn| sn.contains(imp.path) else false;
                        if (!already) try m.append(gpa, try a.dupe(u8, imp.path));
                        missing_any = true;
                        continue;
                    }
                    diag.* = .{ .path = imp.path, .what = "imported package is not loaded" };
                    return error.LoadError;
                }
                const ref = imp.alias orelse std.fs.path.basename(imp.path);
                const gop = try pkg.imports.getOrPut(a, ref);
                if (gop.found_existing) {
                    if (!std.mem.eql(u8, gop.value_ptr.*, imp.path)) {
                        diag.* = .{ .path = pkg.path, .what = "import reference name collides (use an alias)" };
                        return error.LoadError;
                    }
                } else gop.value_ptr.* = imp.path;
            }
        }
    }
    if (missing_any) return .{ .pkgs = try pkg_list.toOwnedSlice(a), .main = main_pkg, .srcmap = map.* };

    // 循環 import の検査（DFS）
    var states: std.StringHashMapUnmanaged(u8) = .empty; // 1 = 訪問中, 2 = 完了
    defer states.deinit(gpa);
    for (pkg_list.items) |pkg| try checkCycle(gpa, &pkg_map, &states, pkg, diag);

    // 名前付き関数型（`type Iter[T] func(func(T))`）を使用点の型式で関数型に展開する。
    // nominal 検査は断片外（language.md 14 節）— 下流は構造的な関数型だけを見る
    for (pkg_list.items) |pkg| try expandFuncTypes(a, pkg, &pkg_map, diag);
    for (pkg_list.items) |pkg| try markMutDefs(a, pkg, diag);

    const errors = try collectErrors(a, pkg_list.items, diag);

    // `@embed("glob")` の const を「パス → 内容」の map リテラルに置き換える（以降は辞書 const — 参照点で展開）
    for (pkg_list.items) |pkg| {
        for (pkg.files) |file| {
            for (file.consts) |c| if (c.embed) |pat| try embedConst(gpa, a, pkg, c, pat, diag);
        }
    }

    // const を畳む
    for (pkg_list.items) |pkg| {
        for (pkg.files) |file| {
            for (file.consts) |c| try resolveConst(pkg, c, &pkg_map, diag, 32);
        }
    }

    return .{ .pkgs = try pkg_list.toOwnedSlice(a), .main = main_pkg, .srcmap = map.*, .errors = errors };
}

/// 組み込み `error` = 全 package の error ラベルをロード順 × 宣言順に並べた閉じた union（V4-4a — 裁定 E1）。
/// desugar（入れ子の位置）と codegen（タグ）が同じこの列を読むので、両者の順序の一致は構成的。
/// ラベルのフィールドに error / error? は書けない（cause と同じく再帰型になる — V4 は cause を持たない）。
/// region を持つ型（string / slice / map）のフィールドは書ける（R0 で L1 の暫定制約を解除 — 戻り値の relocate が
/// opt / union の中へタグで分岐して写し、Lean の relocR も値ラッパの中まで締める）
fn collectErrors(a: std.mem.Allocator, pkgs: []const *ast.Pkg, diag: *Diag) Error!*const ast.TypeDecl {
    var labels: std.ArrayListUnmanaged(ast.Variant) = .empty;
    for (pkgs) |pkg| {
        for (pkg.files) |file| {
            for (file.types) |t| {
                const fields = switch (t.body) {
                    .error_ => |fs| fs,
                    else => continue,
                };
                for (fields) |f| {
                    const inner = if (f.type == .opt) f.type.opt.* else f.type;
                    if (inner == .name and std.mem.eql(u8, inner.name, "error")) {
                        diag.* = .{ .path = pkg.path, .what = "an error label cannot hold an error (recursive type; cause is not in V4)", .pos = f.tok };
                        return error.LoadError;
                    }
                }
                try labels.append(a, .{ .name = t.name, .fields = fields, .tok = t.tok, .pkg = pkg });
            }
        }
    }
    const d = try a.create(ast.TypeDecl);
    d.* = .{ .name = "error", .body = .{ .union_ = try labels.toOwnedSlice(a) }, .tok = 0 };
    return d;
}

fn parseOne(gpa: std.mem.Allocator, a: std.mem.Allocator, f: SrcFile, map: *srcpos.SourceMap, diag: *Diag) Error!*ast.File {
    const tokens = Lexer.tokenize(gpa, f.source) catch return error.OutOfMemory;
    defer gpa.free(tokens);
    const base = try map.add(a, f.name, f.source, tokens);
    var m = grammar.Matcher.init(gpa, tokens);
    defer m.deinit();
    const root = (m.parse("source_file") catch return error.OutOfMemory) orelse {
        diag.* = .{ .path = f.name, .what = "source does not match the v0 grammar", .pos = base + @as(srcpos.Pos, @intCast(m.farthest)) };
        return error.LoadError;
    };
    var cdiag: cst_to_ast.Diag = .{};
    // arena の上に arena が乗る形（内側の deinit は不要 — 外側が一括で回収する）
    const iface = std.mem.endsWith(u8, f.name, ".sobi");
    const tree = cst_to_ast.convertOpts(a, cst.Tree.fromMatcher(&m, f.source, root), base, .{ .iface = iface }, &cdiag) catch |err| {
        diag.* = .{ .path = f.name, .what = cdiag.what, .pos = cdiag.tok };
        return switch (err) {
            error.OutOfMemory => error.OutOfMemory,
            error.Unsupported => error.Unsupported,
            error.Malformed => error.Malformed,
        };
    };
    return tree.file;
}

fn checkCycle(
    gpa: std.mem.Allocator,
    pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg),
    states: *std.StringHashMapUnmanaged(u8),
    pkg: *ast.Pkg,
    diag: *Diag,
) Error!void {
    if (states.get(pkg.path)) |st| {
        if (st == 1) {
            diag.* = .{ .path = pkg.path, .what = "import cycle" };
            return error.LoadError;
        }
        return;
    }
    try states.put(gpa, pkg.path, 1);
    var it = pkg.imports.valueIterator();
    while (it.next()) |path| {
        if (pkg_map.get(path.*)) |dep| try checkCycle(gpa, pkg_map, states, dep, diag);
    }
    try states.put(gpa, pkg.path, 2);
}

/// region 多相の裁定 R2（K-a）: mut 引数だけが展開の理由の関数（関数型引数は無い）のうち、
/// package 内の呼び出しグラフで自分へ戻れるもの（再帰する / 再帰の輪に入る）を Def として呼ぶ（mut_def、anchor つき callM）。
/// それ以外の mut 引数の関数（Keep / Push / Acquire 等）は従来どおり呼び出し点に展開する — どちらになるかは
/// 呼び出しグラフで決まる実装戦略で、意味論は観測等価（関数型引数の展開と同じ非可視の基準）。
/// 本体なし宣言（`.sobi` の署名）は、書き出した側が展開しなかった = Def なので mut_def。
/// 循環は import の DAG 上 package の中に閉じる（package を越える呼び出しは循環を作れない）
/// `@noinline`は mut_def の経路に合流する: 付けてよいのは mut 引数を持ち関数型引数を持たない関数だけ
/// （関数型引数の展開は生成方式の本体 — language.md 8 節）。再帰する関数への付与は冗長だが受理する（もともと Def）
fn markMutDefs(a: std.mem.Allocator, pkg: *const ast.Pkg, diag: *Diag) Error!void {
    var funcs: std.ArrayListUnmanaged(*const ast.FuncDecl) = .empty;
    defer funcs.deinit(a);
    for (pkg.files) |file| try funcs.appendSlice(a, file.funcs);
    const seen = try a.alloc(bool, funcs.items.len);
    defer a.free(seen);
    for (funcs.items) |f| {
        var has_mut = false;
        var has_func = false;
        for (f.params) |p| {
            if (p.mutable) has_mut = true;
            if (p.type == .func) has_func = true;
        }
        const fm = @constCast(f);
        if (f.no_inline) {
            if (!has_mut or has_func) {
                diag.* = .{ .path = pkg.path, .what = "@noinline applies to a function with mut parameters and no function-typed parameters", .pos = f.tok };
                return error.LoadError;
            }
            fm.mut_def = true;
            fm.expands = false;
            continue;
        }
        if (!has_mut or has_func) continue;
        if (f.bodiless) {
            fm.mut_def = true;
            fm.expands = false;
            continue;
        }
        @memset(seen, false);
        if (reachesSelf(funcs.items, f, f, seen)) {
            fm.mut_def = true;
            fm.expands = false;
        }
    }
}

/// from の本体から呼び出しを辿って target に戻れるか（同じ package の裸の名前だけを辿る）
fn reachesSelf(funcs: []const *const ast.FuncDecl, from: *const ast.FuncDecl, target: *const ast.FuncDecl, seen: []bool) bool {
    for (from.callees) |name| {
        for (funcs, 0..) |g, i| {
            if (!std.mem.eql(u8, g.name, name)) continue;
            if (g == target) return true;
            if (seen[i]) continue;
            seen[i] = true;
            if (reachesSelf(funcs, g, target, seen)) return true;
        }
    }
    return false;
}

fn expandFuncTypes(a: std.mem.Allocator, pkg: *const ast.Pkg, pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg), diag: *Diag) Error!void {
    for (pkg.files) |file| {
        for (file.funcs) |f| {
            const fm = @constCast(f);
            const params = try a.dupe(ast.Param, f.params);
            for (params) |*p| p.type = try expandTE(a, pkg, p.type, pkg_map, diag, 16);
            fm.params = params;
            const results = try a.dupe(ast.TypeExpr, f.results);
            for (results) |*r| r.* = try expandTE(a, pkg, r.*, pkg_map, diag, 16);
            fm.results = results;
            // 関数型の引数を持つ関数は呼び出し点に展開する（名前付き関数型の引数もここで分かる）
            for (params) |p| {
                if (p.type == .func) fm.expands = true;
            }
        }
        for (file.types) |t| {
            switch (t.body) {
                .struct_ => |fields| @constCast(t).body = .{ .struct_ = try expandFields(a, pkg, fields, pkg_map, diag) },
                .union_ => |variants| {
                    const vs = try a.dupe(ast.Variant, variants);
                    for (vs) |*v| v.fields = try expandFields(a, pkg, v.fields, pkg_map, diag);
                    @constCast(t).body = .{ .union_ = vs };
                },
                .error_ => |fields| @constCast(t).body = .{ .error_ = try expandFields(a, pkg, fields, pkg_map, diag) },
                .func_ => {},
            }
        }
    }
}

fn expandFields(a: std.mem.Allocator, pkg: *const ast.Pkg, fields: []const ast.Field, pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg), diag: *Diag) Error![]const ast.Field {
    const out = try a.dupe(ast.Field, fields);
    for (out) |*f| f.type = try expandTE(a, pkg, f.type, pkg_map, diag, 16);
    return out;
}

/// 型式の名前（"N" / "ref.N"）→ 型宣言
fn lookupTypeDecl(pkg: *const ast.Pkg, name: []const u8, pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg)) ?*const ast.TypeDecl {
    var from = pkg;
    var base = name;
    if (std.mem.indexOfScalar(u8, name, '.')) |dot| {
        const path = pkg.imports.get(name[0..dot]) orelse return null;
        from = pkg_map.get(path) orelse return null;
        base = name[dot + 1 ..];
    }
    for (from.files) |file| {
        for (file.types) |t| {
            if (std.mem.eql(u8, t.name, base)) return t;
        }
    }
    return null;
}

fn expandTE(a: std.mem.Allocator, pkg: *const ast.Pkg, te: ast.TypeExpr, pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg), diag: *Diag, fuel: u32) Error!ast.TypeExpr {
    if (fuel == 0) {
        diag.* = .{ .path = pkg.path, .what = "recursive named function type" };
        return error.LoadError;
    }
    switch (te) {
        .name => |n| {
            const td = lookupTypeDecl(pkg, n, pkg_map) orelse return te;
            if (td.body != .func_) return te;
            if (td.type_params.len != 0) {
                diag.* = .{ .path = pkg.path, .what = "a generic function type needs type arguments", .pos = td.tok };
                return error.LoadError;
            }
            return expandTE(a, pkg, .{ .func = try substFunc(a, pkg, td, &.{}, diag) }, pkg_map, diag, fuel - 1);
        },
        .generic => |g| {
            const args = try a.alloc(ast.TypeExpr, g.args.len);
            for (g.args, args) |x, *y| y.* = try expandTE(a, pkg, x, pkg_map, diag, fuel - 1);
            const td = lookupTypeDecl(pkg, g.name, pkg_map) orelse return .{ .generic = .{ .name = g.name, .args = args } };
            if (td.body != .func_) return .{ .generic = .{ .name = g.name, .args = args } };
            if (td.type_params.len != args.len) {
                diag.* = .{ .path = pkg.path, .what = "type argument count differs from the named function type", .pos = td.tok };
                return error.LoadError;
            }
            return expandTE(a, pkg, .{ .func = try substFunc(a, pkg, td, args, diag) }, pkg_map, diag, fuel - 1);
        },
        .func => |ft| {
            const params = try a.alloc(ast.TypeExpr, ft.params.len);
            for (ft.params, params) |x, *y| y.* = try expandTE(a, pkg, x, pkg_map, diag, fuel - 1);
            const results = try a.alloc(ast.TypeExpr, ft.results.len);
            for (ft.results, results) |x, *y| y.* = try expandTE(a, pkg, x, pkg_map, diag, fuel - 1);
            const out = try a.create(ast.FuncType);
            out.* = .{ .params = params, .results = results };
            return .{ .func = out };
        },
        .opt => |inner| {
            const p = try a.create(ast.TypeExpr);
            p.* = try expandTE(a, pkg, inner.*, pkg_map, diag, fuel - 1);
            return .{ .opt = p };
        },
        .slice_of => |sl| {
            const p = try a.create(ast.TypeExpr);
            p.* = try expandTE(a, pkg, sl.elem.*, pkg_map, diag, fuel - 1);
            return .{ .slice_of = .{ .elem = p, .mut = sl.mut } };
        },
        .map_of => |m| {
            const k = try a.create(ast.TypeExpr);
            k.* = try expandTE(a, pkg, m.key.*, pkg_map, diag, fuel - 1);
            const v = try a.create(ast.TypeExpr);
            v.* = try expandTE(a, pkg, m.value.*, pkg_map, diag, fuel - 1);
            return .{ .map_of = .{ .key = k, .value = v, .mut = m.mut } };
        },
    }
}

/// 名前付き関数型の本体に型引数を代入する。本体の型は宣言側 package で書かれているので、
/// 使用点へ持ち出せるのは型パラメータと組み込み型（int / bool / string）だけ（V3-4 の断片）
fn substFunc(a: std.mem.Allocator, pkg: *const ast.Pkg, td: *const ast.TypeDecl, args: []const ast.TypeExpr, diag: *Diag) Error!*const ast.FuncType {
    const ft = td.body.func_;
    const params = try a.alloc(ast.TypeExpr, ft.params.len);
    for (ft.params, params) |x, *y| y.* = try substTE(a, pkg, td, x, args, diag);
    const results = try a.alloc(ast.TypeExpr, ft.results.len);
    for (ft.results, results) |x, *y| y.* = try substTE(a, pkg, td, x, args, diag);
    const out = try a.create(ast.FuncType);
    out.* = .{ .params = params, .results = results };
    return out;
}

fn substTE(a: std.mem.Allocator, pkg: *const ast.Pkg, td: *const ast.TypeDecl, te: ast.TypeExpr, args: []const ast.TypeExpr, diag: *Diag) Error!ast.TypeExpr {
    switch (te) {
        .name => |n| {
            for (td.type_params, 0..) |p, i| {
                if (std.mem.eql(u8, p, n)) return args[i];
            }
            if (std.mem.eql(u8, n, "int") or std.mem.eql(u8, n, "bool") or std.mem.eql(u8, n, "string")) return te;
            diag.* = .{ .path = pkg.path, .what = "a named function type may refer only to its type parameters and builtin types (V3-4)", .pos = td.tok };
            return error.LoadError;
        },
        .func => |ft| {
            const params = try a.alloc(ast.TypeExpr, ft.params.len);
            for (ft.params, params) |x, *y| y.* = try substTE(a, pkg, td, x, args, diag);
            const results = try a.alloc(ast.TypeExpr, ft.results.len);
            for (ft.results, results) |x, *y| y.* = try substTE(a, pkg, td, x, args, diag);
            const out = try a.create(ast.FuncType);
            out.* = .{ .params = params, .results = results };
            return .{ .func = out };
        },
        .opt => |inner| {
            const p = try a.create(ast.TypeExpr);
            p.* = try substTE(a, pkg, td, inner.*, args, diag);
            return .{ .opt = p };
        },
        .slice_of => |sl| {
            const p = try a.create(ast.TypeExpr);
            p.* = try substTE(a, pkg, td, sl.elem.*, args, diag);
            return .{ .slice_of = .{ .elem = p, .mut = sl.mut } };
        },
        .map_of, .generic => {
            diag.* = .{ .path = pkg.path, .what = "a named function type may refer only to its type parameters and builtin types (V3-4)", .pos = td.tok };
            return error.LoadError;
        },
    }
}

/// `@embed("glob")`（language.md 20 節 — go:embed の意味論）: 受け皿は `map[string]string{}`（空・imm）に限る（型の拡張は将来 —
/// バイナリは byte 型の段で []byte の受け皿と一緒に）。パターンに合うファイル（ルート = cwd 相対、パスのバイト辞書順）を読み、
/// 受け皿を「パス → 内容」の map リテラルに置き換えて dict にする。内容は string なので UTF-8 検査（27 節 — 不正なら load error）。
/// 合うファイルが 1 つも無ければ load error（go:embed と同じ — 書き間違いを黙って空にしない）
fn embedConst(gpa: std.mem.Allocator, a: std.mem.Allocator, pkg: *const ast.Pkg, c: *ast.ConstDecl, pat: []const u8, diag: *Diag) Error!void {
    const ok_ty = c.expr.* == .maplit and c.expr.maplit.entries.len == 0 and !c.expr.maplit.mut and
        isName(c.expr.maplit.key, "string") and isName(c.expr.maplit.value, "string");
    if (!ok_ty) {
        diag.* = .{ .path = pkg.path, .what = "@embed needs the receiver `map[string]string{}` (empty, imm)", .pos = c.tok };
        return error.LoadError;
    }
    if (!embed.validPattern(pat)) {
        diag.* = .{ .path = pkg.path, .what = "invalid @embed pattern", .pos = c.tok };
        return error.LoadError;
    }
    const paths = embed.expand(gpa, a, pat) catch |err| switch (err) {
        error.OutOfMemory => return error.OutOfMemory,
        error.BadPattern => unreachable,
    };
    if (paths.len == 0) {
        diag.* = .{ .path = pkg.path, .what = "@embed pattern matches no file", .pos = c.tok };
        return error.LoadError;
    }
    const entries = try a.alloc(ast.MapEntry, paths.len);
    for (paths, entries) |p, *en| {
        if (!std.unicode.utf8ValidateSlice(p)) {
            diag.* = .{ .path = pkg.path, .what = "@embed path is not valid UTF-8", .pos = c.tok };
            return error.LoadError;
        }
        const content = std.fs.cwd().readFileAlloc(a, p, std.math.maxInt(u32)) catch {
            diag.* = .{ .path = p, .what = "@embed cannot read file" };
            return error.LoadError;
        };
        if (!std.unicode.utf8ValidateSlice(content)) {
            diag.* = .{ .path = p, .what = "@embed file is not valid UTF-8" };
            return error.LoadError;
        }
        const k = try a.create(ast.Expr);
        k.* = .{ .strlit = .{ .value = p, .tok = c.tok } };
        const v = try a.create(ast.Expr);
        v.* = .{ .strlit = .{ .value = content, .tok = c.tok } };
        en.* = .{ .key = k, .value = v };
    }
    const m = try a.create(ast.Expr);
    m.* = .{ .maplit = .{ .key = c.expr.maplit.key, .value = c.expr.maplit.value, .entries = entries, .mut = false, .tok = c.expr.maplit.tok } };
    c.expr = m;
    c.dict = true;
}

fn isName(te: ast.TypeExpr, name: []const u8) bool {
    return te == .name and std.mem.eql(u8, te.name, name);
}

/// トップレベル const の確定: struct リテラルなら辞書 const として検査し、他は int に畳む
fn resolveConst(
    pkg: *const ast.Pkg,
    c: *ast.ConstDecl,
    pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg),
    diag: *Diag,
    fuel: u32,
) Error!void {
    if (c.value != null or c.dict) return;
    if (fuel == 0) {
        diag.* = .{ .path = pkg.path, .what = "const definition cycle", .pos = c.tok };
        return error.LoadError;
    }
    if (c.expr.* == .composite) {
        try checkDict(pkg, c.expr, pkg_map, diag, fuel);
        c.dict = true;
    } else {
        _ = try foldConst(pkg, c, pkg_map, diag, fuel);
    }
}

/// トップレベル const の畳み込み（int の const 式のみ: リテラル・算術・単項・const 参照）
fn foldConst(
    pkg: *const ast.Pkg,
    c: *ast.ConstDecl,
    pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg),
    diag: *Diag,
    fuel: u32,
) Error!i64 {
    if (c.value) |v| return v;
    if (fuel == 0) {
        diag.* = .{ .path = pkg.path, .what = "const definition cycle", .pos = c.tok };
        return error.LoadError;
    }
    if (c.dict or c.expr.* == .composite) {
        diag.* = .{ .path = pkg.path, .what = "a dictionary const is not an int const expression", .pos = c.tok };
        return error.LoadError;
    }
    const v = try foldExpr(pkg, c.expr, pkg_map, diag, fuel);
    c.value = v;
    return v;
}

/// 辞書 const の検査（language.md 25 節）。struct リテラルの要素に許すのは
/// int const 式・閉じたラムダ・名前付き関数の参照・他の辞書 const・入れ子の struct リテラルだけ。
/// 関数呼び出しは拒否する（const 評価器は関数を呼ばない — 持つのは可・呼ぶのは不可）。
/// ラムダが外側を捕捉しないことは持ち上げ側が検査する（トップレベルに局所束縛は無い）
fn checkDict(
    pkg: *const ast.Pkg,
    e: *const ast.Expr,
    pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg),
    diag: *Diag,
    fuel: u32,
) Error!void {
    for (e.composite.elems) |el| try checkDictElem(pkg, el.value, pkg_map, diag, fuel);
}

fn checkDictElem(
    pkg: *const ast.Pkg,
    e: *const ast.Expr,
    pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg),
    diag: *Diag,
    fuel: u32,
) Error!void {
    switch (e.*) {
        .composite => return checkDict(pkg, e, pkg_map, diag, fuel),
        .lambda => return,
        .call => {
            diag.* = .{ .path = pkg.path, .what = "a const expression cannot call a function", .pos = e.tok() };
            return error.LoadError;
        },
        .ident => |id| {
            if (lookupConst(pkg, id.name)) |c| return resolveConst(pkg, c, pkg_map, diag, fuel - 1);
            if (lookupFunc(pkg, id.name)) |f| return checkFuncRef(pkg, f, id.tok, diag);
            diag.* = .{ .path = pkg.path, .what = "const expression references a non-const name", .pos = id.tok };
            return error.LoadError;
        },
        .selector => |sel| {
            if (sel.base.* == .ident) {
                if (pkg.imports.get(sel.base.ident.name)) |dep_path| {
                    const dep = pkg_map.get(dep_path).?;
                    if (sel.field.len == 0 or !std.ascii.isUpper(sel.field[0])) {
                        diag.* = .{ .path = pkg.path, .what = "unexported const", .pos = sel.tok };
                        return error.LoadError;
                    }
                    if (lookupConst(dep, sel.field)) |c| return resolveConst(dep, c, pkg_map, diag, fuel - 1);
                    if (lookupFunc(dep, sel.field)) |f| return checkFuncRef(pkg, f, sel.tok, diag);
                    diag.* = .{ .path = pkg.path, .what = "const expression references a non-const name", .pos = sel.tok };
                    return error.LoadError;
                }
            }
            diag.* = .{ .path = pkg.path, .what = "expression outside the const fragment", .pos = sel.tok };
            return error.LoadError;
        },
        .int, .unary, .binary => _ = try foldExpr(pkg, e, pkg_map, diag, fuel),
        else => {
            diag.* = .{ .path = pkg.path, .what = "expression outside the const fragment", .pos = e.tok() };
            return error.LoadError;
        },
    }
}

/// 辞書に置ける関数参照は単相かつ非 inline（関数値になれるもの — language.md 25 節）
fn checkFuncRef(pkg: *const ast.Pkg, f: *const ast.FuncDecl, tok: u32, diag: *Diag) Error!void {
    if (f.type_params.len > 0 or f.expands) {
        diag.* = .{ .path = pkg.path, .what = "a generic or inline function is not a value in a const dictionary", .pos = tok };
        return error.LoadError;
    }
}

fn lookupFunc(pkg: *const ast.Pkg, name: []const u8) ?*const ast.FuncDecl {
    for (pkg.files) |file| {
        for (file.funcs) |f| {
            if (std.mem.eql(u8, f.name, name)) return f;
        }
    }
    return null;
}

fn lookupConst(pkg: *const ast.Pkg, name: []const u8) ?*ast.ConstDecl {
    for (pkg.files) |file| {
        for (file.consts) |c| {
            if (std.mem.eql(u8, c.name, name)) return c;
        }
    }
    return null;
}

fn foldExpr(
    pkg: *const ast.Pkg,
    e: *const ast.Expr,
    pkg_map: *std.StringHashMapUnmanaged(*ast.Pkg),
    diag: *Diag,
    fuel: u32,
) Error!i64 {
    switch (e.*) {
        .int => |n| return n.value,
        .ident => |id| {
            const c = lookupConst(pkg, id.name) orelse {
                diag.* = .{ .path = pkg.path, .what = "const expression references a non-const name", .pos = id.tok };
                return error.LoadError;
            };
            return foldConst(pkg, c, pkg_map, diag, fuel - 1);
        },
        .selector => |sel| {
            // 修飾参照 `pkg.N`（公開 = 大文字のみ）
            if (sel.base.* != .ident) {
                diag.* = .{ .path = pkg.path, .what = "const expression", .pos = sel.tok };
                return error.LoadError;
            }
            const dep_path = pkg.imports.get(sel.base.ident.name) orelse {
                diag.* = .{ .path = pkg.path, .what = "const expression references an unknown package", .pos = sel.tok };
                return error.LoadError;
            };
            const dep = pkg_map.get(dep_path).?;
            if (sel.field.len == 0 or !std.ascii.isUpper(sel.field[0])) {
                diag.* = .{ .path = pkg.path, .what = "unexported const", .pos = sel.tok };
                return error.LoadError;
            }
            const c = lookupConst(dep, sel.field) orelse {
                diag.* = .{ .path = pkg.path, .what = "const expression references a non-const name", .pos = sel.tok };
                return error.LoadError;
            };
            return foldConst(dep, c, pkg_map, diag, fuel - 1);
        },
        .unary => |u| {
            const v = try foldExpr(pkg, u.operand, pkg_map, diag, fuel);
            return switch (u.op) {
                .minus => -%v,
                .caret => ~v,
                else => {
                    diag.* = .{ .path = pkg.path, .what = "operator outside the const fragment", .pos = u.tok };
                    return error.LoadError;
                },
            };
        },
        .binary => |b| {
            const l = try foldExpr(pkg, b.lhs, pkg_map, diag, fuel);
            const r = try foldExpr(pkg, b.rhs, pkg_map, diag, fuel);
            switch (b.op) {
                .plus => return l +% r,
                .minus => return l -% r,
                .star => return l *% r,
                .slash, .percent => {
                    if (r == 0) {
                        diag.* = .{ .path = pkg.path, .what = "division by zero in a const expression", .pos = b.tok };
                        return error.LoadError;
                    }
                    return if (b.op == .slash) @divTrunc(l, r) else @rem(l, r);
                },
                .ampersand => return l & r,
                .pipe => return l | r,
                .caret => return l ^ r,
                // シフト（Go 準拠 — Lean の ArithOp.eval と同じ場合分け）。負の量は const の段で拒否
                .shl, .shr => {
                    if (r < 0) {
                        diag.* = .{ .path = pkg.path, .what = "negative shift count in a const expression", .pos = b.tok };
                        return error.LoadError;
                    }
                    if (b.op == .shl) return if (r >= 64) 0 else @bitCast(@as(u64, @bitCast(l)) << @intCast(r));
                    return l >> @intCast(@min(r, 63));
                },
                else => {
                    diag.* = .{ .path = pkg.path, .what = "operator outside the const fragment", .pos = b.tok };
                    return error.LoadError;
                },
            }
        },
        else => {
            diag.* = .{ .path = pkg.path, .what = "expression outside the const fragment", .pos = e.tok() };
            return error.LoadError;
        },
    }
}
