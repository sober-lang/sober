//! lower の型表: 型（Type）とレイアウト（struct / union / T? の語オフセット）、名前と型式の解決。
//! メモリ形は codegen と同一（lower.zig 冒頭）。キーは "pkg_path.Name"（codegen program の型登録と同じ）。
const std = @import("std");
const ast = @import("ast.zig");
const ir = @import("ir.zig");
const lower = @import("lower.zig");
const Lowerer = lower.Lowerer;
const Error = lower.Error;

pub const Type = union(enum) {
    none,
    int,
    bool_,
    /// 到達しない（脱出で終わる腕）。合流では相手の型に従う
    never,
    /// `nil` の仮の型。T? の期待がある sink（coerce）で実体化する
    nil_,
    struct_: *StructInfo,
    /// 語 0 がタグ、以降が最大ペイロード。組み込み error も 1 つの union
    union_: *UnionInfo,
    /// `T?`: 語 0 がタグ（0 = nil / 1 = some）、以降がペイロード
    opt: *const OptInfo,
    /// slice / string: ヘッダ 3 語 (ptr, len, region 深度)。本体は region アリーナのセル列（セル = 要素の語数）。
    /// string は imm の 1 語セル列（1 文字 1 語）で、[]int とは型が交わらない
    slice_: *const SliceInfo,
    /// map: ヘッダ 3 語 (ptr, len, 深度)。セルは [key][tag][value]（tag 0 = 墓石）の挿入列
    map_: *const MapInfo,
    /// 関数型の仮引数（inline 展開の閉包 — 値ではない。語 0）
    func_: *const FnType,
    /// 関数値（struct の関数型フィールド・名前付き関数の参照）: コードアドレス 1 語（i64）
    fnv: *const FnType,

    pub fn words(t: Type) u32 {
        return switch (t) {
            .none, .never, .nil_, .func_ => 0,
            .int, .bool_, .fnv => 1,
            .struct_ => |s| s.words,
            .union_ => |u| u.words,
            .opt => |o| o.words,
            .slice_, .map_ => 3,
        };
    }

    pub fn eql(a: Type, b: Type) bool {
        return switch (a) {
            .none, .int, .bool_, .never, .nil_ => std.meta.activeTag(a) == std.meta.activeTag(b),
            .struct_ => |s| b == .struct_ and b.struct_ == s,
            .union_ => |u| b == .union_ and b.union_ == u,
            .opt => |o| b == .opt and o.payload.eql(b.opt.payload),
            .slice_ => |x| b == .slice_ and x.mut == b.slice_.mut and x.str == b.slice_.str and x.elem.eql(b.slice_.elem),
            .map_ => |x| b == .map_ and x.mut == b.map_.mut and x.key.eql(b.map_.key) and x.value.eql(b.map_.value),
            .func_ => |f| b == .func_ and f.eql(b.func_),
            .fnv => |f| b == .fnv and f.eql(b.fnv),
        };
    }

    /// 1 語の値（SSA の i64 で持つ）: int / bool / 関数値
    pub fn isScalar(t: Type) bool {
        return t == .int or t == .bool_ or t == .fnv;
    }

    pub fn isAggregate(t: Type) bool {
        return t == .struct_ or t == .union_ or t == .opt or t == .slice_ or t == .map_;
    }

    pub fn isString(t: Type) bool {
        return t == .slice_ and t.slice_.str;
    }

    /// slice / map を（入れ子含め）どこかに含むか（codegen containsSlice — relocate の断片外判定）
    pub fn containsSlice(t: Type) bool {
        return switch (t) {
            .slice_, .map_ => true,
            .opt => |o| o.payload.containsSlice(),
            .struct_ => |st| for (st.fields) |f| {
                if (f.t.containsSlice()) break true;
            } else false,
            .union_ => |u| blk: {
                for (u.variants) |v| for (v.fields) |f| if (f.t.containsSlice()) break :blk true;
                break :blk false;
            },
            else => false,
        };
    }

    /// 値として IR に乗るときの型（値なしは null）
    pub fn irTy(t: Type) ?ir.Ty {
        if (t.isScalar()) return .i64;
        if (t.isAggregate()) return .ptr;
        return null;
    }
};

pub const FnType = struct {
    params: []const Type,
    results: []const Type,

    pub fn eql(a: *const FnType, b: *const FnType) bool {
        if (a.params.len != b.params.len or a.results.len != b.results.len) return false;
        for (a.params, b.params) |x, y| if (!x.eql(y)) return false;
        for (a.results, b.results) |x, y| if (!x.eql(y)) return false;
        return true;
    }

    /// 結果が int / bool / 関数値 1 個以外なら sret（IR の第 0 引数が結果スロット — FnInfo.sret と同じ規則）
    pub fn sret(f: *const FnType) bool {
        return sretOf(f.results);
    }
};

pub fn sretOf(results: []const Type) bool {
    return results.len > 1 or (results.len == 1 and !results[0].isScalar());
}

/// 型パラメータの束縛（ジェネリクスの単相化中の `T ↦ int`）
pub const TypeBind = struct { name: []const u8, t: Type };
pub const GenericTy = struct { decl: *const ast.TypeDecl, pkg: *const ast.Pkg };

pub const SliceInfo = struct { elem: Type, mut: bool, str: bool = false };

pub const MapInfo = struct {
    /// int か string（codegen と同じ二択）
    key: Type,
    value: Type,
    mut: bool,

    pub fn cellWords(m: MapInfo) u32 {
        return m.key.words() + 1 + m.value.words();
    }
    /// セル内のタグの語オフセット（値はその次から）
    pub fn tagOff(m: MapInfo) u32 {
        return m.key.words();
    }
};

pub const string_info: SliceInfo = .{ .elem = .int, .mut = false, .str = true };
pub const string_t: Type = .{ .slice_ = &string_info };

pub fn mkSlice(self: *Lowerer, elem: Type, mut: bool) Error!Type {
    const si = try self.a().create(SliceInfo);
    si.* = .{ .elem = elem, .mut = mut };
    return .{ .slice_ = si };
}

pub fn mkMap(self: *Lowerer, k: Type, value: Type, mut: bool) Error!Type {
    const mi = try self.a().create(MapInfo);
    mi.* = .{ .key = k, .value = value, .mut = mut };
    return .{ .map_ = mi };
}

pub const FieldInfo = struct { name: []const u8, t: Type, offset: u32 };

pub fn findField(fields: []const FieldInfo, name: []const u8) ?*const FieldInfo {
    for (fields) |*f| if (std.mem.eql(u8, f.name, name)) return f;
    return null;
}

pub const LayoutState = enum { pending, laying, done };

pub const StructInfo = struct {
    decl: *const ast.TypeDecl,
    pkg: *const ast.Pkg,
    /// 型表のキー（"pkg_path.Name"、インスタンスは "pkg_path.Name[型…]"）— typeKey の綴り（決定的 — 実体のアドレスは使わない）
    key: []const u8,
    /// ジェネリック struct のインスタンス: 型引数の束縛と具体型引数（単一化用）。非ジェネリックは空
    env: []const TypeBind = &.{},
    targs: []const Type = &.{},
    fields: []const FieldInfo = &.{},
    words: u32 = 0,
    state: LayoutState = .pending,
};

/// variant のフィールドの offset はペイロード先頭（語 1）からの語数
pub const VariantInfo = struct { name: []const u8, tag: u32, fields: []const FieldInfo };

pub const UnionInfo = struct {
    decl: *const ast.TypeDecl,
    pkg: *const ast.Pkg,
    variants: []const VariantInfo = &.{},
    words: u32 = 0,
    state: LayoutState = .pending,

    pub fn variant(self: *const UnionInfo, name: []const u8) ?*const VariantInfo {
        for (self.variants) |*v| if (std.mem.eql(u8, v.name, name)) return v;
        return null;
    }
};

pub const VariantRef = struct { u: *UnionInfo, index: usize };

pub const OptInfo = struct { payload: Type, words: u32 };

pub fn baseName(name: []const u8) []const u8 {
    if (std.mem.indexOfScalar(u8, name, '.')) |dot| return name[dot + 1 ..];
    return name;
}

pub fn key(self: *Lowerer, path: []const u8, name: []const u8) Error![]const u8 {
    return std.fmt.allocPrint(self.a(), "{s}.{s}", .{ path, name });
}

pub fn registerTypes(self: *Lowerer) Error!void {
    self.errors = try self.a().create(UnionInfo);
    self.errors.* = .{ .decl = self.prog.errors, .pkg = self.prog.main };
    for (self.prog.pkgs) |pkg| for (pkg.files) |file| for (file.types) |t| {
        const k = try key(self, pkg.path, t.name);
        if (typeNameTaken(self, k, t.name) or self.generic_tys.contains(k)) return self.fail(error.Redeclared, t.tok, t.name);
        // ジェネリック型は使用点（`Ord[int]`）でインスタンス化する（codegen instStruct）
        if (t.type_params.len > 0) {
            try self.generic_tys.put(self.gpa, k, .{ .decl = t, .pkg = pkg });
            continue;
        }
        switch (t.body) {
            .struct_ => {
                const info = try self.a().create(StructInfo);
                info.* = .{ .decl = t, .pkg = pkg, .key = k };
                try self.structs.put(self.gpa, k, info);
            },
            .union_ => |vs| {
                const info = try self.a().create(UnionInfo);
                info.* = .{ .decl = t, .pkg = pkg };
                try self.unions.put(self.gpa, k, info);
                for (vs, 0..) |v, i| {
                    const vk = try key(self, pkg.path, v.name);
                    if (typeNameTaken(self, vk, v.name)) return self.fail(error.Redeclared, v.tok, v.name);
                    try self.variants.put(self.gpa, vk, .{ .u = info, .index = i });
                }
            },
            .func_ => {},
            // error ラベル: 組み込み error の variant（タグ = ラベル列の添字）
            .error_ => {
                const i = for (self.prog.errors.body.union_, 0..) |v, i| {
                    if (v.pkg == pkg and std.mem.eql(u8, v.name, t.name)) break i;
                } else unreachable;
                try self.variants.put(self.gpa, k, .{ .u = self.errors, .index = i });
            },
        }
    };
}

fn typeNameTaken(self: *Lowerer, k: []const u8, base: []const u8) bool {
    return std.mem.eql(u8, base, "int") or std.mem.eql(u8, base, "bool") or self.structs.contains(k) or self.unions.contains(k) or self.variants.contains(k);
}

/// 宣言の検査（codegen program の「レイアウトと関数シグネチャ」と同じ範囲 — B-8.5）: 全 package の非ジェネリックの型を
/// レイアウトし（再帰の拒否）、全関数の引数・結果の型を解決する（未定義の型・関数型の結果の拒否）。lower は main から到達する
/// 関数だけを下ろすので、これが無いと使われない宣言の誤りを受理してしまう。IR には何も足さない
pub fn checkDecls(self: *Lowerer) Error!void {
    const saved = self.cur_pkg;
    defer self.cur_pkg = saved;
    for (self.prog.pkgs) |pkg| {
        self.cur_pkg = pkg;
        try checkRedeclared(self, pkg);
        for (pkg.files) |file| {
            for (file.types) |t| {
                if (t.type_params.len > 0) continue;
                const k = try key(self, pkg.path, t.name);
                switch (t.body) {
                    .struct_ => try layoutStruct(self, self.structs.get(k).?),
                    .union_ => try layoutUnion(self, self.unions.get(k).?),
                    .func_, .error_ => {},
                }
            }
            for (file.funcs) |f| {
                if (f.type_params.len > 0) continue;
                for (f.params) |p| _ = try resolveType(self, p.type, f.tok);
                for (f.results) |r| if ((try resolveType(self, r, f.tok)) == .func_)
                    return self.fail(error.Unsupported, f.tok, "function-typed result");
            }
        }
    }
}

/// package 内の関数名・const 名の重複と、関数の仮引数名の重複（codegen の Redeclared と同じ範囲 — B-9a。loader / check は拒否しない）
fn checkRedeclared(self: *Lowerer, pkg: *const ast.Pkg) Error!void {
    var seen: std.StringHashMapUnmanaged(void) = .empty;
    defer seen.deinit(self.gpa);
    for (pkg.files) |file| for (file.funcs) |f| {
        if ((try seen.fetchPut(self.gpa, f.name, {})) != null) return self.fail(error.Redeclared, f.tok, f.name);
        for (f.params, 0..) |p, i| for (f.params[0..i]) |q| if (std.mem.eql(u8, p.name, q.name))
            return self.fail(error.Redeclared, f.tok, p.name);
    };
    seen.clearRetainingCapacity();
    for (pkg.files) |file| for (file.consts) |c| {
        if ((try seen.fetchPut(self.gpa, c.name, {})) != null) return self.fail(error.Redeclared, c.tok, c.name);
    };
}

/// 組み込み error の型（regionpoly K1'' — Lean・desugar と同じ表現）: (先頭ラベル, 鎖) の struct。
/// 先頭ラベルは全 error ラベルの union（self.errors — ラベルのリテラルの型）、鎖は内側の error を外側から積んだ imm の []ラベル
/// （包み替え `f()? W{…}` が (W{…}, append(鎖, 先頭)) を作る）。フィールド名は利用者の名前と交わらない `#top` / `#chain`。
/// 鎖の要素はラベル（鎖を持たない）なので型は再帰しない。ラベルの値は coerce で (L, 空の鎖) に包む
pub fn errType(self: *Lowerer) Error!Type {
    if (self.err_struct) |e| return .{ .struct_ = e };
    try layoutUnion(self, self.errors);
    const lt: Type = .{ .union_ = self.errors };
    const chain = try self.a().create(SliceInfo);
    chain.* = .{ .elem = lt, .mut = false };
    const fields = try self.a().alloc(FieldInfo, 2);
    fields[0] = .{ .name = "#top", .t = lt, .offset = 0 };
    fields[1] = .{ .name = "#chain", .t = .{ .slice_ = chain }, .offset = lt.words() };
    const e = try self.a().create(StructInfo);
    e.* = .{ .decl = self.prog.errors, .pkg = self.prog.main, .key = "error", .fields = fields, .words = lt.words() + 3, .state = .done };
    self.err_struct = e;
    return .{ .struct_ = e };
}

/// T? の型
pub fn optOf(self: *Lowerer, payload: Type) Error!Type {
    const o = try self.a().create(OptInfo);
    o.* = .{ .payload = payload, .words = 1 + payload.words() };
    return .{ .opt = o };
}

/// t が組み込み error（errType）か
pub fn isErr(self: *const Lowerer, t: Type) bool {
    return t == .struct_ and self.err_struct != null and t.struct_ == self.err_struct.?;
}

/// 参照名（"N" か "ref.N"）→ フラットキー "pkg_path.N"（codegen resolveName と同じ）
pub fn resolveName(self: *Lowerer, name: []const u8, tok: ast.Pos) Error![]const u8 {
    if (std.mem.indexOfScalar(u8, name, '.')) |dot| {
        const path = self.cur_pkg.imports.get(name[0..dot]) orelse return self.fail(error.UndefinedName, tok, name[0..dot]);
        const base = name[dot + 1 ..];
        if (base.len == 0 or !std.ascii.isUpper(base[0])) return self.fail(error.Unexported, tok, name);
        return key(self, path, base);
    }
    return key(self, self.cur_pkg.path, name);
}

pub fn resolveType(self: *Lowerer, te: ast.TypeExpr, tok: ast.Pos) Error!Type {
    return resolveTypeIn(self, te, tok, false);
}

/// in_container: slice / map の要素位置。ヘッダは 3 語で要素の語数に依らないので、
/// レイアウト中の struct / union（`type Node struct { kids []Node }` の自己参照）もそのまま受ける
fn resolveTypeIn(self: *Lowerer, te: ast.TypeExpr, tok: ast.Pos, in_container: bool) Error!Type {
    switch (te) {
        .name => |n| {
            for (self.type_env) |bnd| if (std.mem.eql(u8, bnd.name, n)) return bnd.t;
            if (std.mem.eql(u8, n, "int")) return .int;
            if (std.mem.eql(u8, n, "bool")) return .bool_;
            if (std.mem.eql(u8, n, "string")) return string_t;
            if (std.mem.eql(u8, n, "error")) return errType(self);
            const k = try resolveName(self, n, tok);
            if (self.structs.get(k)) |s| {
                if (!(in_container and s.state == .laying)) try layoutStruct(self, s);
                return .{ .struct_ = s };
            }
            if (self.unions.get(k)) |u| {
                if (!(in_container and u.state == .laying)) try layoutUnion(self, u);
                return .{ .union_ = u };
            }
            return self.fail(error.UndefinedType, tok, n);
        },
        .opt => |inner| {
            const payload = try resolveType(self, inner.*, tok);
            if (payload == .opt) return self.fail(error.Unsupported, tok, "optional of an optional");
            const o = try self.a().create(OptInfo);
            o.* = .{ .payload = payload, .words = 1 + payload.words() };
            return .{ .opt = o };
        },
        .slice_of => |sl| return mkSlice(self, try resolveTypeIn(self, sl.elem.*, tok, true), sl.mut),
        .map_of => |mp| {
            const k = try resolveType(self, mp.key.*, tok);
            if (k != .int and !k.isString()) return self.fail(error.Unsupported, tok, "map key type must be int or string");
            return mkMap(self, k, try resolveTypeIn(self, mp.value.*, tok, true), mp.mut);
        },
        .generic => |g| {
            const st = try instStruct(self, g.name, g.args, tok);
            if (!(in_container and st.state == .laying)) try layoutStruct(self, st);
            return .{ .struct_ = st };
        },
        .func => |ft| {
            const params = try self.a().alloc(Type, ft.params.len);
            for (ft.params, params) |pe, *t| t.* = try resolveType(self, pe, tok);
            const results = try self.a().alloc(Type, ft.results.len);
            for (ft.results, results) |re, *t| t.* = try resolveType(self, re, tok);
            const f = try self.a().create(FnType);
            f.* = .{ .params = params, .results = results };
            return .{ .func_ = f };
        },
    }
}

/// フィールド列を語オフセット付きで並べる（struct 本体と variant ペイロードで共用）。型は pkg の文脈で解決する
/// 型式は env（ジェネリック struct の束縛。他は空）で読む — レイアウトは遅延なので、下ろし中の関数の型環境を持ち込まない
pub fn layoutFields(self: *Lowerer, decl_fields: []const ast.Field, pkg: *const ast.Pkg, env: []const TypeBind) Error!struct { fields: []const FieldInfo, words: u32 } {
    const saved = self.cur_pkg;
    const saved_env = self.type_env;
    self.cur_pkg = pkg;
    self.type_env = env;
    defer {
        self.cur_pkg = saved;
        self.type_env = saved_env;
    }
    const fields = try self.a().alloc(FieldInfo, decl_fields.len);
    var off: u32 = 0;
    for (decl_fields, 0..) |df, i| for (decl_fields[0..i]) |prev| if (std.mem.eql(u8, prev.name, df.name))
        return self.fail(error.Redeclared, df.tok, df.name);
    for (decl_fields, fields) |df, *f| {
        var t = try resolveType(self, df.type, df.tok);
        // 関数型フィールドは関数値（閉じた関数のコードアドレス — codegen layoutFields）
        if (t == .func_) {
            const ft = t.func_;
            t = .{ .fnv = ft };
        }
        f.* = .{ .name = df.name, .t = t, .offset = off };
        off += t.words();
    }
    return .{ .fields = fields, .words = off };
}

pub fn layoutStruct(self: *Lowerer, s: *StructInfo) Error!void {
    switch (s.state) {
        .done => return,
        .laying => return self.fail(error.Unsupported, s.decl.tok, "recursive struct"),
        .pending => {},
    }
    s.state = .laying;
    const l = try layoutFields(self, s.decl.body.struct_, s.pkg, s.env);
    s.fields = l.fields;
    s.words = l.words;
    s.state = .done;
}

/// union: 各 variant のペイロードを語 1 から並べ、全体は 1 + 最大ペイロード
pub fn layoutUnion(self: *Lowerer, u: *UnionInfo) Error!void {
    switch (u.state) {
        .done => return,
        .laying => return self.fail(error.Unsupported, u.decl.tok, "recursive union"),
        .pending => {},
    }
    u.state = .laying;
    const dvs = u.decl.body.union_;
    const vs = try self.a().alloc(VariantInfo, dvs.len);
    var max: u32 = 0;
    for (dvs, vs, 0..) |dv, *v, i| {
        // error ラベルのフィールド型は宣言側 package で解決する
        const l = try layoutFields(self, dv.fields, dv.pkg orelse u.pkg, &.{});
        v.* = .{ .name = dv.name, .tag = @intCast(i), .fields = l.fields };
        max = @max(max, l.words);
    }
    u.variants = vs;
    u.words = 1 + max;
    u.state = .done;
}

// ── ジェネリクス（codegen V3-3 の instStruct / typeKey / unify と同じ） ──

/// 型引数として許される型（codegen tyArgOk）: region を持たない
pub fn tyArgOk(t: Type) bool {
    return switch (t) {
        .int, .bool_, .fnv => true,
        .opt => |o| tyArgOk(o.payload),
        .struct_ => |st| for (st.fields) |f| {
            if (!tyArgOk(f.t)) break false;
        } else true,
        .union_ => |u| blk: {
            for (u.variants) |v| for (v.fields) |f| if (!tyArgOk(f.t)) break :blk false;
            break :blk true;
        },
        .none, .func_, .nil_, .never, .slice_, .map_ => false,
    };
}

/// インスタンスのキーに使う型の綴り（struct / union は修飾名 — 型表のキーと同じく一意）
pub fn typeKey(self: *Lowerer, t: Type, out: *std.ArrayListUnmanaged(u8)) Error!void {
    const a = self.a();
    switch (t) {
        .int => try out.appendSlice(a, "int"),
        .bool_ => try out.appendSlice(a, "bool"),
        // 修飾名で綴る（codegen は実体のアドレスで綴るが、IR では関数名に出るので決定的にする — hermeticity）
        .struct_ => |st| try out.appendSlice(a, st.key),
        .union_ => |u| if (u == self.errors) try out.appendSlice(a, "error") else try out.print(a, "{s}.{s}", .{ u.pkg.path, u.decl.name }),
        .opt => |o| {
            try out.append(a, '?');
            try typeKey(self, o.payload, out);
        },
        .fnv, .func_ => |f| {
            try out.appendSlice(a, "fn(");
            for (f.params) |p| {
                try typeKey(self, p, out);
                try out.append(a, ',');
            }
            try out.append(a, ')');
            for (f.results) |r| try typeKey(self, r, out);
        },
        .slice_ => |sl| {
            try out.appendSlice(a, if (sl.mut) "mut[]" else "[]");
            try typeKey(self, sl.elem, out);
        },
        .map_ => |m| {
            try out.appendSlice(a, "map[");
            try typeKey(self, m.key, out);
            try out.appendSlice(a, "]");
            try typeKey(self, m.value, out);
        },
        .none, .nil_, .never => try out.appendSlice(a, "?"),
    }
}

/// `base[T1,T2]`
pub fn instKey(self: *Lowerer, base: []const u8, targs: []const Type) Error![]const u8 {
    var buf: std.ArrayListUnmanaged(u8) = .empty;
    try buf.appendSlice(self.a(), base);
    try buf.append(self.a(), '[');
    for (targs, 0..) |t, i| {
        if (i > 0) try buf.append(self.a(), ',');
        try typeKey(self, t, &buf);
    }
    try buf.append(self.a(), ']');
    return buf.items;
}

pub fn bindsOf(self: *Lowerer, names: []const []const u8, targs: []const Type) Error![]const TypeBind {
    const env = try self.a().alloc(TypeBind, names.len);
    for (names, targs, env) |n, t, *b| b.* = .{ .name = n, .t = t };
    return env;
}

/// 展開されるジェネリック・ジェネリック struct の型引数（R1 — codegen tyArgValueOk）: 値を持つ型なら string / slice / map を含んでよい
pub fn tyArgValueOk(t: Type) bool {
    return switch (t) {
        .int, .bool_, .fnv => true,
        .slice_ => |sl| tyArgValueOk(sl.elem),
        .map_ => |m| tyArgValueOk(m.key) and tyArgValueOk(m.value),
        .opt => |o| tyArgValueOk(o.payload),
        .struct_ => |st| for (st.fields) |f| {
            if (!tyArgValueOk(f.t)) break false;
        } else true,
        .union_ => |u| blk: {
            for (u.variants) |v| for (v.fields) |f| if (!tyArgValueOk(f.t)) break :blk false;
            break :blk true;
        },
        .none, .func_, .nil_, .never => false,
    };
}

/// ジェネリック struct の適用 `Name[args]`（型引数は呼び手の文脈で読む）。レイアウトは呼び手が済ませる
pub fn instStruct(self: *Lowerer, name: []const u8, args: []const ast.TypeExpr, tok: ast.Pos) Error!*StructInfo {
    const k = try resolveName(self, name, tok);
    const gt = self.generic_tys.get(k) orelse return self.fail(error.UndefinedType, tok, name);
    if (args.len != gt.decl.type_params.len) return self.fail(error.ArityMismatch, tok, "type argument count");
    const targs = try self.a().alloc(Type, args.len);
    for (args, targs) |ae, *t| {
        t.* = try resolveType(self, ae, tok);
        if (!tyArgValueOk(t.*)) return self.fail(error.TypeMismatch, tok, "a type argument must be a value type");
    }
    const ik = try instKey(self, k, targs);
    if (self.structs.get(ik)) |st| return st;
    if (gt.decl.body != .struct_) return self.fail(error.Unsupported, tok, "generic union");
    const info = try self.a().create(StructInfo);
    info.* = .{ .decl = gt.decl, .pkg = gt.pkg, .key = ik, .env = try bindsOf(self, gt.decl.type_params, targs), .targs = targs };
    try self.structs.put(self.gpa, ik, info);
    return info;
}

/// 単一化: 仮引数の型式 te（型パラメータ tparams を含む）と実引数の型 t から束縛を集める（codegen unify）。
/// 衝突は拒否。te は callee の package 文脈で読む（呼び手が cur_pkg を切り替えておく）
pub fn unify(self: *Lowerer, te: ast.TypeExpr, t: Type, tparams: []const []const u8, binds: []?Type, tok: ast.Pos) Error!void {
    switch (te) {
        .name => |n| for (tparams, 0..) |p, i| {
            if (!std.mem.eql(u8, p, n)) continue;
            if (t == .nil_ or t == .none) return;
            if (binds[i]) |b| {
                if (!b.eql(t)) return self.fail(error.TypeMismatch, tok, "conflicting inferences for a type parameter");
            } else binds[i] = t;
            return;
        },
        .generic => |g| {
            if (t != .struct_) return;
            const k = resolveName(self, g.name, tok) catch return;
            const gt = self.generic_tys.get(k) orelse return;
            if (t.struct_.decl != gt.decl or t.struct_.targs.len != g.args.len) return;
            for (g.args, t.struct_.targs) |ae, at| try unify(self, ae, at, tparams, binds, tok);
        },
        .slice_of => |sl| if (t == .slice_) try unify(self, sl.elem.*, t.slice_.elem, tparams, binds, tok),
        .opt => |inner| if (t == .opt) try unify(self, inner.*, t.opt.payload, tparams, binds, tok),
        .map_of => |m| if (t == .map_) try unify(self, m.value.*, t.map_.value, tparams, binds, tok),
        .func => |ft| {
            const tf: *const FnType = switch (t) {
                .fnv, .func_ => |x| x,
                else => return,
            };
            if (tf.params.len != ft.params.len or tf.results.len != ft.results.len) return;
            for (ft.params, tf.params) |pe, pt| try unify(self, pe, pt, tparams, binds, tok);
            for (ft.results, tf.results) |re, rt| try unify(self, re, rt, tparams, binds, tok);
        },
    }
}
