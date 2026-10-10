const std = @import("std");
const ast_json = @import("ast_json.zig");
const cst_to_ast = @import("cst_to_ast.zig");

fn emit(a: std.mem.Allocator, source: [:0]const u8) ![]u8 {
    var diag: cst_to_ast.Diag = .{};
    var t = try ast_json.parse(a, source, false, &diag);
    defer t.deinit();
    return ast_json.toOwned(a, t.file);
}

/// emit して JSON として読み直す（形の単体はキーを辿って確かめる）
fn emitValue(a: std.mem.Allocator, source: [:0]const u8) !std.json.Parsed(std.json.Value) {
    const text = try emit(a, source);
    defer a.free(text);
    return std.json.parseFromSlice(std.json.Value, a, text, .{});
}

fn get(v: std.json.Value, path: []const []const u8) std.json.Value {
    var cur = v;
    for (path) |p| {
        cur = switch (cur) {
            .object => |o| o.get(p).?,
            .array => |arr| arr.items[std.fmt.parseInt(usize, p, 10) catch unreachable],
            else => unreachable,
        };
    }
    return cur;
}

fn expectStr(v: std.json.Value, path: []const []const u8, want: []const u8) !void {
    try std.testing.expectEqualStrings(want, get(v, path).string);
}

test "整形: 2 スペース・1 キー 1 行・デフォルト値も出す・末尾改行" {
    const a = std.testing.allocator;
    const text = try emit(a,
        \\package p
        \\
        \\type P struct { x int }
        \\
    );
    defer a.free(text);
    try std.testing.expectEqualStrings(
        \\{
        \\  "package": "p",
        \\  "imports": [],
        \\  "types": [
        \\    {
        \\      "name": "P",
        \\      "type_params": [],
        \\      "body": {
        \\        "k": "struct",
        \\        "fields": [
        \\          {
        \\            "name": "x",
        \\            "type": {
        \\              "k": "name",
        \\              "name": "int"
        \\            },
        \\            "tok": 7
        \\          }
        \\        ]
        \\      },
        \\      "tok": 4,
        \\      "span": {
        \\        "start": 3,
        \\        "end": 11
        \\      }
        \\    }
        \\  ],
        \\  "funcs": [],
        \\  "consts": []
        \\}
        \\
    , text);
}

test "決定性: 同じ入力は同じバイト列" {
    const a = std.testing.allocator;
    const src =
        \\package main
        \\
        \\func main() {
        \\    x := 1 + 2
        \\    println(x)
        \\}
        \\
    ;
    const t1 = try emit(a, src);
    defer a.free(t1);
    const t2 = try emit(a, src);
    defer a.free(t2);
    try std.testing.expectEqualStrings(t1, t2);
}

test "union と型パターンの switch" {
    const a = std.testing.allocator;
    var p = try emitValue(a,
        \\package main
        \\
        \\type Shape union {
        \\    Circle { r int }
        \\    Rect { w, h int }
        \\}
        \\
        \\func area(s Shape) int {
        \\    return switch s {
        \\    case Circle{r}: r * r
        \\    case sq Rect{w, h: 2}: w
        \\    default: 0
        \\    }
        \\}
        \\
    );
    defer p.deinit();
    const v = p.value;
    try expectStr(v, &.{ "types", "0", "body", "k" }, "union");
    try expectStr(v, &.{ "types", "0", "body", "variants", "1", "name" }, "Rect");
    const sw = get(v, &.{ "funcs", "0", "body", "stmts", "0", "values", "0" });
    try expectStr(sw, &.{"k"}, "switch");
    try expectStr(sw, &.{ "cases", "0", "patterns", "0", "k" }, "type");
    try std.testing.expect(get(sw, &.{ "cases", "0", "patterns", "0", "bind" }) == .null);
    try expectStr(sw, &.{ "cases", "1", "patterns", "0", "bind" }, "sq");
    try std.testing.expect(get(sw, &.{ "cases", "1", "patterns", "0", "fields", "0", "sub" }) == .null);
    try expectStr(sw, &.{ "cases", "1", "patterns", "0", "fields", "1", "sub", "k" }, "const");
    try expectStr(sw, &.{ "default", "stmts", "0", "k" }, "expr");
}

test "定数パターンの選択と多 subject" {
    const a = std.testing.allocator;
    var p = try emitValue(a,
        \\package main
        \\
        \\func f(x int, y int) int {
        \\    return switch x, y {
        \\    case 1 | 2, _: 10
        \\    default: 0
        \\    }
        \\}
        \\
    );
    defer p.deinit();
    const sw = get(p.value, &.{ "funcs", "0", "body", "stmts", "0", "values", "0" });
    try std.testing.expectEqual(@as(usize, 2), get(sw, &.{"subjects"}).array.items.len);
    try std.testing.expectEqual(@as(usize, 2), get(sw, &.{ "cases", "0", "patterns", "0", "alts" }).array.items.len);
    try expectStr(sw, &.{ "cases", "0", "patterns", "1", "alts", "0", "name" }, "_");
}

test "for-yield と for のブロック本体" {
    const a = std.testing.allocator;
    var p = try emitValue(a,
        \\package main
        \\
        \\func f(xs []int) {
        \\    g(for x <- xs if x > 0 yield x * 2)
        \\    g(for x <- xs { yield x })
        \\}
        \\
    );
    defer p.deinit();
    const v = p.value;
    const f1 = get(v, &.{ "funcs", "0", "body", "stmts", "0", "expr", "args", "0" });
    try expectStr(f1, &.{"k"}, "for");
    try expectStr(f1, &.{ "gens", "0", "names", "0" }, "x");
    try expectStr(f1, &.{ "gens", "0", "guards", "0", "op" }, ">");
    try expectStr(f1, &.{ "body", "k" }, "yield");
    const f2 = get(v, &.{ "funcs", "0", "body", "stmts", "1", "expr", "args", "0" });
    try expectStr(f2, &.{ "body", "k" }, "block");
    try expectStr(f2, &.{ "body", "stmts", "0", "k" }, "yield");
    // for は std/iter の暗黙 import を足す（cst_to_ast の書き換えはそのまま出す — 裁定 C1）
    try expectStr(v, &.{ "imports", "0", "path" }, "std/iter");
    try std.testing.expectEqual(@as(i64, 0), get(v, &.{ "imports", "0", "tok" }).integer);
}

test "error ラベル・後置 ? と包み替え" {
    const a = std.testing.allocator;
    var p = try emitValue(a,
        \\package main
        \\
        \\type NotFound error { id int }
        \\
        \\func g() (int, error?) {
        \\    return 0, nil
        \\}
        \\
        \\func f() (int, error?) {
        \\    x := g()?
        \\    y := g()? NotFound{id: 1}
        \\    return x + y, nil
        \\}
        \\
    );
    defer p.deinit();
    const v = p.value;
    try expectStr(v, &.{ "types", "0", "body", "k" }, "error");
    try expectStr(v, &.{ "funcs", "0", "results", "1", "k" }, "opt");
    const t1 = get(v, &.{ "funcs", "1", "body", "stmts", "0", "values", "0" });
    try expectStr(t1, &.{"k"}, "try");
    try std.testing.expect(get(t1, &.{"wrap"}) == .null);
    const t2 = get(v, &.{ "funcs", "1", "body", "stmts", "1", "values", "0" });
    try expectStr(t2, &.{ "wrap", "type_name" }, "NotFound");
    try expectStr(t2, &.{ "wrap", "elems", "0", "key" }, "id");
    // loader 由来・導出可能なフラグは出さない（裁定 A1 / B1）
    const fo = get(v, &.{ "funcs", "1" }).object;
    try std.testing.expect(fo.get("has_try") == null);
    try std.testing.expect(fo.get("expands") == null);
    try std.testing.expect(fo.get("callees") == null);
    try std.testing.expect(fo.get("mut_def") == null);
}

test "補間: 定数部と穴・穴の tok は文字列リテラル・文字列の escape" {
    const a = std.testing.allocator;
    var p = try emitValue(a,
        \\package main
        \\
        \\func f(x int) {
        \\    println("a${x + 1}b\n\"\0")
        \\}
        \\
    );
    defer p.deinit();
    const v = p.value;
    const ip = get(v, &.{ "funcs", "0", "body", "stmts", "0", "expr", "args", "0" });
    try expectStr(ip, &.{"k"}, "interp");
    try expectStr(ip, &.{ "tmpl", "lits", "0" }, "a");
    try expectStr(ip, &.{ "tmpl", "lits", "1" }, "b\n\"\x00");
    const tok = get(ip, &.{"tok"}).integer;
    try std.testing.expectEqual(tok, get(ip, &.{ "tmpl", "holes", "0", "tok" }).integer);
    try std.testing.expectEqual(tok, get(ip, &.{ "tmpl", "holes", "0", "lhs", "tok" }).integer);
    try expectStr(v, &.{ "imports", "0", "path" }, "std/strings");

    // \0 は \u0000 で書く
    const text = try emit(a,
        \\package main
        \\
        \\const s = "\0"
        \\
    );
    defer a.free(text);
    try std.testing.expect(std.mem.indexOf(u8, text, "\"value\": \"\\u0000\"") != null);
}

test "演算子は綴り・複合代入・パイプの穴" {
    const a = std.testing.allocator;
    var p = try emitValue(a,
        \\package main
        \\
        \\func f(a int, b int) int {
        \\    mut x := a
        \\    x += b
        \\    x = x |> g(1, _)
        \\    return -x
        \\}
        \\
    );
    defer p.deinit();
    const st = get(p.value, &.{ "funcs", "0", "body", "stmts" });
    try std.testing.expect(get(st, &.{ "0", "mutable" }).bool);
    try expectStr(st, &.{ "1", "op" }, "+=");
    try expectStr(st, &.{ "2", "op" }, "=");
    try expectStr(st, &.{ "2", "values", "0", "k" }, "pipe");
    try std.testing.expect(get(st, &.{ "2", "values", "0", "args", "1" }) == .null);
    try expectStr(st, &.{ "3", "values", "0", "op" }, "-");
}
