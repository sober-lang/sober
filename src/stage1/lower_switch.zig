//! lower の switch: subject の評価、case の順次照合（定数・束縛・`_`・型パターン）、腕の合流。
const std = @import("std");
const ast = @import("ast.zig");
const ir = @import("ir.zig");
const lower = @import("lower.zig");
const types = @import("lower_types.zig");
const cont = @import("lower_cont.zig");
const Lowerer = lower.Lowerer;
const Error = lower.Error;
const Val = lower.Val;
const Results = lower.Results;
const ArmEnd = lower.ArmEnd;
const never_results = lower.never_results;
const isNever = lower.isNever;
const baseName = types.baseName;
const findField = types.findField;
const Type = types.Type;

/// パターン位置の裸の識別子が束縛か（codegen isBindingPattern と同じ規則）
fn isBindingPattern(self: *Lowerer, name: []const u8) bool {
    return self.lookup(name) == null and !std.mem.eql(u8, name, "true") and !std.mem.eql(u8, name, "false") and
        !self.cur_pkg.hasTopName(name);
}

fn hasWildcard(alts: []const *ast.Expr) bool {
    for (alts) |alt| if (alt.* == .ident and std.mem.eql(u8, alt.ident.name, "_")) return true;
    return false;
}

const PatBind = struct { name: []const u8, v: Val };

/// switch（定数パターン・束縛・`_`・型パターン・subject 無し・多値 subject）。subject は 1 回だけ評価する。
/// case は上から順に照合し、不一致は次の case へ。default 無しで全部外れたら値はゼロ（codegen は不定値）。
/// 網羅の規則は check に揃える（B-9a — codegen は検査しない）: union の型パターンの switch は全 variant を覆うか `_` / default を持つ
/// （desugar unionSwitch）。それ以外で default も全域の case（`_`・束縛）も無い switch は、値が unit でなければ拒否（Lean の def error）。
/// 多値 subject（error ラベルの switch）は対象外
pub fn switchExpr(self: *Lowerer, sw: ast.Switch) Error!Val {
    const subj: Results = if (sw.subjects.len == 1) try self.evalMulti(sw.subjects[0]) else blk: {
        const vs = try self.a().alloc(Val, sw.subjects.len);
        for (sw.subjects, vs) |e, *v| {
            v.* = try self.expr(e);
            if (v.t == .never) break :blk never_results;
        }
        break :blk vs;
    };
    if (isNever(subj)) return Val.never;
    if (sw.subjects.len > 0 and subj.len == 0) return self.fail(error.ResultCountMismatch, sw.tok, "switch subject has no value");

    var ends: std.ArrayListUnmanaged(ArmEnd) = .empty;
    defer ends.deinit(self.gpa);
    var binds: std.ArrayListUnmanaged(PatBind) = .empty;
    defer binds.deinit(self.gpa);
    var t: ?Type = null;
    for (sw.cases) |c| {
        if (c.patterns.len != @max(subj.len, 1)) return self.fail(error.PatternCountMismatch, c.tok, "pattern count differs from the switch subject");
        binds.clearRetainingCapacity();
        const next = try self.b.newBlock();
        for (c.patterns, 0..) |p, i| {
            if (self.b.cur == null) break;
            try matchPattern(self, p, if (subj.len == 0) null else subj[i], next, &binds);
        }
        try self.pushScope();
        for (binds.items) |bd| try self.declareNew(bd.name, .{ .val = bd.v }, c.tok);
        const v = try self.armTail(c.body);
        self.popScope();
        t = try self.joinType(t, if (self.b.cur == null) .never else v.t, c.tok);
        if (self.b.cur) |blk| try ends.append(self.gpa, .{ .blk = blk, .v = v });
        self.b.cur = next;
    }
    if (sw.subjects.len <= 1 and sw.default_ == null) try checkCover(self, sw, if (subj.len != 1) .none else if (types.isErr(self, subj[0].t)) .{ .union_ = self.errors } else subj[0].t, t);
    if (sw.default_) |d| {
        const v = try self.armValue(d);
        t = try self.joinType(t, if (self.b.cur == null) .never else v.t, sw.tok);
        if (self.b.cur) |blk| try ends.append(self.gpa, .{ .blk = blk, .v = v });
    } else {
        const rt = t orelse .none;
        const zero: Val = if (rt.isScalar()) .{ .t = rt, .v = try self.b.iconst(0) } else if (rt.isAggregate()) .{ .t = rt, .v = try self.newAgg(rt) } else Val.none;
        try ends.append(self.gpa, .{ .blk = self.b.cur.?, .v = zero });
    }
    return self.joinArms(ends.items, t orelse .none);
}

fn checkCover(self: *Lowerer, sw: ast.Switch, st: Type, t: ?Type) Error!void {
    for (sw.cases) |c| for (c.patterns) |p| switch (p) {
        .const_ => |alts| if (hasWildcard(alts) or (alts.len == 1 and alts[0].* == .ident and isBindingPattern(self, alts[0].ident.name))) return,
        .type_ => {},
    };
    if (st == .union_) {
        var typed = false;
        for (st.union_.variants) |v| {
            var hit = false;
            for (sw.cases) |c| if (c.patterns.len == 1 and c.patterns[0] == .type_) {
                typed = true;
                if (std.mem.eql(u8, baseName(c.patterns[0].type_.variant), v.name)) hit = true;
            };
            if (typed and !hit) return self.fail(error.TypeMismatch, sw.tok, "switch does not cover every variant");
        }
        if (typed) return;
    }
    const rt = t orelse return;
    if (rt != .none and rt != .never) return self.fail(error.TypeMismatch, sw.tok, "a switch used as a value needs a default (or a case covering every value)");
}

/// パターン 1 つを値 subj に照合する。不一致なら next へ跳び、一致なら続きのブロックを cur にする。
/// subj が null なら subject 無し switch の bool 条件
fn matchPattern(self: *Lowerer, p: ast.Pattern, subj: ?Val, next: ir.BlockId, binds: *std.ArrayListUnmanaged(PatBind)) Error!void {
    switch (p) {
        .const_ => |alts| {
            if (hasWildcard(alts)) return;
            // 裸の識別子でスコープに無い名前は値の束縛。既存の名前は比較
            if (alts.len == 1 and alts[0].* == .ident and isBindingPattern(self, alts[0].ident.name)) {
                const sv = subj orelse return self.fail(error.UndefinedName, alts[0].tok(), alts[0].ident.name);
                try binds.append(self.gpa, .{ .name = alts[0].ident.name, .v = sv });
                return;
            }
            if (subj) |sv| if (!sv.t.isScalar()) return self.fail(error.TypeMismatch, alts[0].tok(), "constant pattern on a non-int value");
            const ok = try self.b.newBlock();
            for (alts, 0..) |alt, i| {
                const av = try self.expr(alt);
                if (av.t == .never) return;
                const c = if (subj) |sv| blk: {
                    if (!av.t.eql(sv.t)) return self.fail(error.TypeMismatch, alt.tok(), "constant pattern type differs from the subject");
                    break :blk try self.b.cmp(.eq, sv.v, av.v);
                } else blk: {
                    try self.want(av, .bool_, alt.tok());
                    break :blk av.v;
                };
                const miss = if (i + 1 < alts.len) try self.b.newBlock() else next;
                try self.b.condbr(c, ok, &.{}, miss, &.{});
                self.b.cur = miss;
            }
            self.b.cur = ok;
        },
        // 型パターン `[x] Variant{f, g: p}`: タグを比べ、フィールドを束縛か下位パターンで照合する
        .type_ => |tp| {
            const sv0 = subj orelse return self.fail(error.TypeMismatch, tp.tok, "type pattern in a switch without subject");
            // error（K1''）: 先頭ラベル（語 0 から — 同じアドレス）で照合し、`cause` は鎖から作る 1 つ内側の error?
            const is_err = types.isErr(self, sv0.t);
            const sv: Val = if (is_err) .{ .t = .{ .union_ = self.errors }, .v = sv0.v } else sv0;
            const u = switch (sv.t) {
                .union_ => |u| u,
                else => return self.fail(error.TypeMismatch, tp.tok, "type pattern on a non-union value"),
            };
            const v = u.variant(baseName(tp.variant)) orelse return self.fail(error.TypeMismatch, tp.tok, "variant does not belong to the switched union");
            const ok = try self.b.newBlock();
            const tagv = try self.b.load(sv.v, 0);
            try self.b.condbr(try self.b.cmp(.eq, tagv, try self.b.iconst(v.tag)), ok, &.{}, next, &.{});
            self.b.cur = ok;
            if (tp.bind) |name| try binds.append(self.gpa, .{ .name = name, .v = sv0 });
            for (tp.fields) |fp| {
                const fv = if (findField(v.fields, fp.name)) |f|
                    try self.loadVal(sv.v, 1 + f.offset, f.t)
                else if (is_err and std.mem.eql(u8, fp.name, "cause"))
                    try cont.causeOf(self, sv0.v, sv0.t, sv.t)
                else
                    return self.fail(error.UndefinedField, fp.tok, fp.name);
                if (fp.sub) |sub| {
                    try matchPattern(self, sub.*, fv, next, binds);
                    if (self.b.cur == null) return;
                } else if (!std.mem.eql(u8, fp.name, "_")) {
                    try binds.append(self.gpa, .{ .name = fp.name, .v = fv });
                }
            }
        },
    }
}
