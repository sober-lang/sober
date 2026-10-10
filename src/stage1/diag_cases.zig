//! 拒否ケースの表。lower_diag.test が IR 経路（load + lower）で回し、desugar.test が check（desugar + Lean）にも通す（check_ok で既知の差を持つ）。
//! 由来: codegen.test.zig の expectError 群（B-8.5）と、codegen の fail 地点の 3 経路分類（B-9a）。codegen は B-9b で退役 — 足すときはここに足す。
//! lower_err は退役前に direct と lower で error 名が割れていたケースの記録（lower はその名で拒否する）
pub const Case = struct {
    err: anyerror,
    src: [:0]const u8,
    /// lower が別の error 名で拒否するとき（null = err と同じ）
    lower_err: ?anyerror = null,
    /// check（desugar + Lean）は受理する — build だけが拒否する既知の差（desugar.test が照合する）。原因の多くはコアが型の射影であること:
    /// println → unit（引数を捨てる）、1 フィールドの struct はフィールドの型そのもの（名前的な区別が消える）、多値は pair。B-9a 報告の相談に一覧
    check_ok: bool = false,
};

pub const cases = [_]Case{
    // ── const 式の負のシフト量（load で拒否）
    .{ .err = error.LoadError, .src = "package main\nconst K = 1 << -1\nfunc main() { println(K) }\n" },
    // ── 意味の誤り全般
    // main から届かない関数の本体の誤り（codegen は全関数を下ろす・lower は checkUnreached で使い捨てに下ろす — B-9a）
    .{ .err = error.TypeMismatch, .src = "package main\nfunc unused() int { return true }\nfunc main() { println(1) }\n" },
    // ローカル束縛とトップレベル名の衝突（loader で拒否 — desugar と共有の規則）
    .{ .err = error.LoadError, .src = "package main\nconst K = 1\nfunc main() { K := 5\n println(K) }\n" },
    .{ .err = error.LoadError, .src = "package main\nfunc g() int { return 1 }\nfunc main() { g := 2\n println(g) }\n" },
    // パターン位置の裸の func 名は束縛でなく比較（int subject とは型が合わない）
    .{ .err = error.TypeMismatch, .src = "package main\nfunc g() int { return 1 }\nfunc main() { println(switch 1 { case g: 1\n default: 0 }) }\n" },
    .{ .err = error.UndefinedName, .src = "package main\nfunc main() { println(x) }\n" },
    .{ .err = error.Immutable, .src = "package main\nfunc main() { x := 1\n x = 2 }\n" },
    .{ .err = error.UndefinedFunction, .src = "package main\nfunc main() { f() }\n" },
    .{ .err = error.ArityMismatch, .src = "package main\nfunc f(a int) int { return a }\nfunc main() { println(f()) }\n" },
    .{ .err = error.OutsideLoop, .src = "package main\nfunc main() { break }\n" },
    .{ .err = error.MissingMain, .src = "package main\nfunc f() {}\n" },
    .{ .err = error.ResultCountMismatch, .src = "package main\nfunc f() (int, int) { return 1, 2 }\nfunc main() { println(f()) }\n", .check_ok = true },
    .{ .err = error.ResultCountMismatch, .src = "package main\nfunc f() (int, int) { return 1, 2 }\nfunc main() { x := f()\n println(x) }\n", .check_ok = true },
    .{ .err = error.ResultCountMismatch, .src = "package main\nfunc f() (int, int) { return 1 }\nfunc main() { f() }\n" },
    .{ .err = error.ResultCountMismatch, .src = "package main\nfunc f() int { return 1, 2 }\nfunc main() { f() }\n" },
    .{ .err = error.ResultCountMismatch, .src = "package main\nfunc f() int { return 1 }\nfunc main() { x, y := f()\n println(x, y) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\ntype P struct { x int }\nfunc main() { p := P{1}\n println(p + 1) }\n", .check_ok = true },
    // bool と int は交わらない（暗黙変換なし）: int の条件、bool の算術、int の論理演算、bool を int へ代入
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { println(if 1 { 2 } else { 3 }) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { println((1 < 2) + 1) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { println(!0, 1 && true) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc f() int { return 1 == 1 }\nfunc main() { println(f()) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { mut n := 0\n while n { n += 1 } }\n" },
    // 関数値（V3-3 3a）: 関数でない値は呼べない / 展開される関数（関数型引数を持つ）は値にならない /
    // シグネチャ違いの関数値はフィールドに入らない
    .{ .err = error.TypeMismatch, .src = "package main\ntype D struct { x int }\nfunc main() { d := D{1}\n println(d.x(1)) }\n" },
    .{ .err = error.Unsupported, .src = "package main\ntype D struct { f func(int) int }\nfunc ap(g func(int) int) int { return g(1) }\nfunc main() { d := D{f: ap}\n println(d.f(1)) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\ntype D struct { f func(int) int }\nfunc b(x int) bool { return x > 0 }\nfunc main() { d := D{f: b}\n println(d.f(1)) }\n", .check_ok = true },
    // ジェネリクス（V3-3 3b）: 推論できない型パラメータ / 推論の衝突 / region を持つ型引数 は拒否
    .{ .err = error.TypeMismatch, .src = "package main\nfunc k[T](x int) int { return x }\nfunc main() { println(k(1)) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc pick[T](c bool, x T, y T) T { return if c { x } else { y } }\nfunc main() { println(pick(true, 1, false)) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc id[T](x T) T { return x }\nfunc main() { println(id(\"a\")) }\n" },
    // 辞書のラムダの明示 return は拒否（check と揃える — ラムダの return は囲みの名前付き関数から）
    .{ .err = error.Unsupported, .src = "package main\ntype D struct { f func(int) int }\nfunc main() { d := D{f: (x) => { return x }}\n println(d.f(1)) }\n" },
    // 辞書のラムダ（V3-3 3c）は外側の変数を捕捉できない
    .{ .err = error.Unsupported, .src = "package main\ntype D struct { f func(int) bool }\nfunc main() { k := 1\n d := D{f: (x) => x < k}\n println(d.f(0)) }\n" },
    // string は不透明な型: imm []int とは交わらない（== / println / 引数渡し）
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { println([]int{1} == []int{1}) }\n" },
    .{ .err = error.Unsupported, .src = "package main\nfunc main() { println([]int{104, 105}) }\n", .check_ok = true },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc f(s string) int { return 0 }\nfunc main() { println(f([]int{1})) }\n", .check_ok = true },
    .{ .err = error.TypeMismatch, .src = "package main\ntype P struct { x int }\nfunc f(p P) int { return p.x }\nfunc main() { println(f(1)) }\n", .check_ok = true },
    .{ .err = error.TypeMismatch, .src = "package main\ntype P struct { x int }\nfunc main() { mut p := P{1}\n p = 2 }\n", .check_ok = true },
    .{ .err = error.TypeMismatch, .src = "package main\ntype P struct { x int }\nfunc f() P { return 1 }\nfunc main() { f() }\n", .check_ok = true },
    .{ .err = error.UndefinedField, .src = "package main\ntype P struct { x int }\nfunc main() { p := P{1}\n println(p.z) }\n" },
    .{ .err = error.UndefinedType, .src = "package main\nfunc main() { p := Q{1}\n println(p) }\n" },
    .{ .err = error.Immutable, .src = "package main\ntype P struct { x int }\nfunc main() { p := P{1}\n p.x = 2 }\n" },
    .{ .err = error.Unsupported, .src = "package main\ntype P struct { x int\n q Q }\ntype Q struct { p P }\nfunc main() {}\n", .check_ok = true },
    .{ .err = error.ArityMismatch, .src = "package main\ntype P struct { x, y int }\nfunc main() { p := P{1}\n println(p.x) }\n" },
    .{ .err = error.Unsupported, .src = "package main\ntype P struct { x, y int }\nfunc main() { p := P{1, y: 2}\n println(p.x) }\n" },
    .{ .err = error.Unsupported, .src = "package main\nfunc r(n int, f func(int)) { r(n, f) }\nfunc main() { r(1, x => println(x)) }\n" },
    .{ .err = error.ArityMismatch, .src = "package main\nfunc ap(f func(int) int) int { return f(1) }\nfunc main() { println(ap((a, b) => a)) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc ap(f func(int) int) int { return f(1) }\nfunc main() { println(ap(1)) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\ntype P struct { x int }\nfunc ap(f func(int) int) int { return f(1) }\nfunc main() { println(ap(a => P{a})) }\n", .check_ok = true },
    .{ .err = error.Unsupported, .src = "package main\nfunc main() { f := x => x\n println(f(1)) }\n" },
    .{ .err = error.OutsideLoop, .src = "package main\nfunc ap(f func()) { f() }\nfunc main() { mut i := 0\n while i < 3 { ap(() => { break }) \n i += 1 } }\n" },
    .{ .err = error.Unsupported, .src = "package main\nfunc ap(x int, f func(int) int) int { return f(x) }\nfunc main() { x := 1\n println(ap(2, x => x)) }\n", .check_ok = true },
    .{ .err = error.TypeMismatch, .src = "package main\ntype U union { A { v int } }\ntype V union { B {} }\nfunc main() { u := A{1}\n println(switch u {\ncase B{}: 1\ndefault: 0\n}) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\ntype U union { A { v int } }\nfunc main() { u := A{1}\n println(u.v) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\ntype U union { A { v int } }\nfunc main() { u := A{1}\n println(switch u {\ncase 1: 1\ndefault: 0\n}) }\n" },
    .{ .err = error.Redeclared, .src = "package main\ntype U union { A {} }\ntype A struct { x int }\nfunc main() {}\n", .check_ok = true },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { x := nil\n println(1) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { x := 1\n println(x == nil) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc f(v int?) int { return v }\nfunc main() { println(f(7)) }\n" },
    .{ .err = error.UndefinedField, .src = "package main\ntype U union { A { v int } }\nfunc main() { u := A{1}\n println(switch u {\ncase A{w}: w\n}) }\n" },
    .{ .err = error.UndefinedType, .src = "package main\ntype U union { A { v int } }\nfunc f(a A) int { return 1 }\nfunc main() {}\n" },
    .{ .err = error.HoleCountMismatch, .src = "package main\nfunc f(a, b int) int { return a }\nfunc main() { println(1 |> f(_, _)) }\n", .check_ok = true },
    .{ .err = error.HoleCountMismatch, .src = "package main\nfunc g() (int, int) { return 1, 2 }\nfunc f(a, b int) int { return a }\nfunc main() { println(g() |> f(_, 1)) }\n" },
    .{ .err = error.HoleCountMismatch, .src = "package main\nfunc g() (int, int) { return 1, 2 }\nfunc f(a, b, c int) int { return a }\nfunc main() { println(g() |> f(1)) }\n" },
    .{ .err = error.Unsupported, .src = "package main\nfunc f(a, b int) int { return a }\nfunc g(a int) int { return a }\nfunc main() { println(1 |> f(g(_))) }\n" },
    .{ .err = error.Unsupported, .src = "package main\nfunc main() { println(_) }\n" },
    .{ .err = error.PatternCountMismatch, .src = "package main\nfunc main() { println(switch 1, 2 {\ncase 1: 0\ndefault: 1\n}) }\n" },
    .{ .err = error.PatternCountMismatch, .src = "package main\nfunc main() { println(switch {\ncase 1, 2: 0\ndefault: 1\n}) }\n" },
    // 多値呼び出しの subject: case の項数は結果の個数と一致が要る（desugar と同じ拒否）
    .{ .err = error.PatternCountMismatch, .src = "package main\nfunc g() (int, int) { return 1, 2 }\nfunc main() { println(switch g() {\ncase 1: 0\ndefault: 1\n}) }\n" },
    .{ .err = error.ResultCountMismatch, .src = "package main\nfunc f() {}\nfunc main() { println(switch f() {\ndefault: 1\n}) }\n", .check_ok = true },
    // ── string は不透明（len / 添字 / [a:b] / append は bytes(s) を名指しさせる）・mut slice の [a:b]
    // string は不透明: len / 添字 / [a:b] / append は bytes(s) を名指しさせる
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { println(len(\"ab\")) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { s := \"ab\"\n println(s[0]) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { s := \"ab\"\n println(s[0:1]) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { s := append(\"ab\", 99)\n println(s) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() { println(len(bytes([]int{1}))) }\n" },
    // mut slice の [a:b] はコンパイルエラー（imm 限定）
    .{ .err = error.Immutable, .src = "package main\nfunc main() {\n    mut xs := mut []int{}\n    xs = append(xs, 1)\n    println(len(xs[0:1]))\n}" },
    // ── 辞書 const: ラムダは宣言の文脈で解決・const の中の呼び出しは拒否
    .{ .err = error.UndefinedName, .src = "package main\ntype Ord struct { less func(int, int) bool }\n" ++ "const O = Ord{less: (a, b) => a < k}\nfunc main() { k := 1\n println(O.less(1, 2)) }\n" },
    .{ .err = error.LoadError, .src = "package main\ntype Ord struct { less func(int, int) bool }\n" ++ "func mk() int { return 1 }\ntype R struct { n int }\nconst D = R{n: mk()}\nfunc main() { println(D.n) }\n" },
    // ── B-9a: codegen の fail 地点のうち表に無かったもの（3 経路分類 — direct と lower がともに拒否。行番号は退役前の codegen.zig）
    // codegen.zig:583 bogus
    .{ .err = error.UndefinedPackage, .src = "package main\nfunc f(x bogus.T) int { return 0 }\nfunc main() { println(0) }\n", .lower_err = error.UndefinedName },
    // codegen.zig:720 Bogus
    .{ .err = error.UndefinedType, .src = "package main\nfunc main() { p := Bogus[int]{1}\n println(p) }\n" },
    // codegen.zig:721 type argument count
    .{ .err = error.ArityMismatch, .src = "package main\ntype Pair[T] struct { a, b T }\nfunc main() { p := Pair[int, int]{1, 2}\n println(p.a) }\n" },
    // codegen.zig:725 a type argument must be a value type — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\ntype Box[T] struct { x T }\nfunc main() { b := Box[func(int) int]{x: pick}\n println(b.x(1)) }\nfunc pick(n int) int { return n }\n", .check_ok = true },
    // codegen.zig:815 pick
    .{ .err = error.ArityMismatch, .src = "package main\nfunc pick[T](x T, y T) T { return x }\nfunc main() { println(pick(1)) }\n" },
    // codegen.zig:821 explicit type arguments (only f[T](...) with one type parameter)
    .{ .err = error.ArityMismatch, .src = "package main\nfunc pair2[T, U](x T, y U) T { return x }\nfunc main() { println(pair2[int](1, true)) }\n" },
    // codegen.zig:834 cannot infer type parameter T of k; write k[T](...)
    .{ .err = error.TypeMismatch, .src = "package main\nfunc k[T](x int) int { return x }\nfunc main() { println(k(1)) }\n" },
    // codegen.zig:836 a type argument of a generic function called as a Def cannot contain regions or channels (V3-2; inline-expanded generics and generic structs may — R1)
    .{ .err = error.TypeMismatch, .src = "package main\nfunc pick[T](x T, y T) T { return x }\nfunc main() { a := []int{1}\n b := []int{2}\n println(pick(a, b)[0]) }\n" },
    // codegen.zig:857 ap
    .{ .err = error.ArityMismatch, .src = "package main\nfunc ap[T](x T, g func(T) T) T { return g(x) }\nfunc inc(n int) int { return n + 1 }\nfunc main() { println(ap(1)) }\n" },
    // codegen.zig:862 explicit type arguments (only f[T](...) with one type parameter)
    .{ .err = error.ArityMismatch, .src = "package main\nfunc ap2[T, U](x T, y U, g func(T) T) T { return g(x) }\nfunc inc(n int) int { return n + 1 }\nfunc main() { println(ap2[int](1, true, inc)) }\n" },
    // codegen.zig:900 cannot infer type parameter T of ap; write ap[T](...)
    .{ .err = error.TypeMismatch, .src = "package main\nfunc ap[T](g func(T) T) T { return g(1) }\nfunc main() { println(ap((x) => x)) }\n" },
    // codegen.zig:949 P — check は受理（B-9a 報告の相談）
    .{ .err = error.Redeclared, .src = "package main\ntype P struct { x int }\ntype P struct { y int }\nfunc main() { println(0) }\n", .check_ok = true },
    // codegen.zig:967 A — check は受理（B-9a 報告の相談）
    .{ .err = error.Redeclared, .src = "package main\ntype U union {\n    A { x int }\n    A { y int }\n}\nfunc main() { println(0) }\n", .check_ok = true },
    // codegen.zig:984 K — check は受理（B-9a 報告の相談）
    .{ .err = error.Redeclared, .src = "package main\nconst K = 1\nconst K = 2\nfunc main() { println(K) }\n", .check_ok = true },
    // codegen.zig:1009 f — check は受理（B-9a 報告の相談）
    .{ .err = error.Redeclared, .src = "package main\nfunc f() int { return 1 }\nfunc f() int { return 2 }\nfunc main() { println(f()) }\n", .check_ok = true },
    // codegen.zig:1027 function-typed result
    .{ .err = error.Unsupported, .src = "package main\nfunc inc(n int) int { return n + 1 }\nfunc f() func(int) int { return inc }\nfunc main() { println(f()(1)) }\n" },
    // codegen.zig:1136 recursive union — check は受理（B-9a 報告の相談）
    .{ .err = error.Unsupported, .src = "package main\ntype U union {\n    A { u U }\n}\nfunc main() { println(0) }\n", .check_ok = true },
    // codegen.zig:1166 x — check は受理（B-9a 報告の相談）
    .{ .err = error.Redeclared, .src = "package main\ntype P struct { x int\n x int }\nfunc main() { println(0) }\n", .check_ok = true },
    // codegen.zig:1203 Bogus
    .{ .err = error.UndefinedType, .src = "package main\nfunc f(x Bogus) int { return 0 }\nfunc main() { println(0) }\n" },
    // codegen.zig:1231 map key type must be int or string
    .{ .err = error.Unsupported, .src = "package main\nfunc f(x map[bool]int) int { return 0 }\nfunc main() { println(0) }\n" },
    // codegen.zig:1247 optional of an optional — check は受理（B-9a 報告の相談）
    .{ .err = error.Unsupported, .src = "package main\ntype Box[T] struct { x T? }\nfunc main() { b := Box[int?]{x: 1}\n println(b.x) }\n", .check_ok = true },
    // codegen.zig:1748 a — check は受理（B-9a 報告の相談）
    .{ .err = error.Redeclared, .src = "package main\nfunc f(a int, a int) int { return a }\nfunc main() { println(f(1, 2)) }\n", .check_ok = true },
    // codegen.zig:1947 a mut parameter takes `mut x` (a mut local) at the call site
    .{ .err = error.TypeMismatch, .src = "package main\ntype Counter struct { n int }\nfunc bump(c mut Counter, by int) { c.n = c.n + by }\nfunc main() { c := Counter{0}\n c |> bump(1) }\n" },
    // codegen.zig:1949 a mut parameter takes `mut x` (a mut local) at the call site
    .{ .err = error.TypeMismatch, .src = "package main\ntype Counter struct { n int }\nfunc bump(c mut Counter) { c.n = c.n + 1 }\nfunc main() { c := Counter{0}\n bump(c) }\n" },
    // codegen.zig:1950 <dyn> e.mut_arg.name
    .{ .err = error.UndefinedName, .src = "package main\ntype C struct { n int }\nfunc bump(c mut C) { c.n = c.n + 1 }\nfunc main() {\n    mut c := C{0}\n    bump(mut zzz)\n    println(c.n)\n}\n" },
    // codegen.zig:1951 `mut x` needs a mut local
    .{ .err = error.Immutable, .src = "package main\ntype C struct { n int }\nfunc bump(c mut C) { c.n = c.n + 1 }\nfunc main() {\n    c := C{0}\n    bump(mut c)\n    println(c.n)\n}\n" },
    // codegen.zig:2070 binding an expression without a value — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\ntype Bad error {\n    code int\n}\nfunc check(ok bool) error? {\n    if ok { return nil }\n    return Bad{code: 1}\n}\nfunc wrapper() error? {\n    x := check(true)?\n    println(x)\n    return nil\n}\nfunc main() {\n    show := wrapper()\n    println(show == nil)\n}\n", .check_ok = true },
    // codegen.zig:2072 binding a function value
    .{ .err = error.Unsupported, .src = "package main\nfunc apply(f func(int) int, x int) int {\n    g := f\n    return g(x)\n}\nfunc main() {\n    println(apply((n) => n * 2, 3))\n}\n", .lower_err = error.TypeMismatch },
    // codegen.zig:2153 forwarded result type differs from the signature
    .{ .err = error.TypeMismatch, .src = "package main\nfunc pair() (int, bool) {\n    return 1, true\n}\nfunc f() (int, int) {\n    return pair()\n}\nfunc main() {\n    a, b := f()\n    println(a, b)\n}\n" },
    // codegen.zig:2157 forwarded result type differs from the signature — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\nfunc pair() (int, bool) {\n    return 1, true\n}\nfunc g(cb func(int) int) (int, int) {\n    return pair()\n}\nfunc main() {\n    a, b := g((n) => n + 1)\n    println(a, b)\n}\n", .check_ok = true },
    // codegen.zig:2227 interpolation takes int, string or bool
    .{ .err = error.TypeMismatch, .src = "package main\ntype P struct { x int }\nfunc main() {\n    p := P{1}\n    println(\"${p}\")\n}\n" },
    // codegen.zig:2295 compound assignment to a slice element
    .{ .err = error.Unsupported, .src = "package main\nfunc main() {\n    mut xs := mut []int{1, 2, 3}\n    xs[0] += 1\n    println(xs[0])\n}\n" },
    // codegen.zig:2296 slice element assignment
    .{ .err = error.ResultCountMismatch, .src = "package main\nfunc main() {\n    mut xs := mut []int{1, 2, 3}\n    xs[0] = 1, 2\n    println(xs[0])\n}\n" },
    // codegen.zig:2300 compound multi-value assignment
    .{ .err = error.Unsupported, .src = "package main\nfunc main() {\n    mut a := 1\n    mut b := 2\n    a, b += 1, 2\n    println(a, b)\n}\n" },
    // codegen.zig:2311 compound assignment to _
    .{ .err = error.NotAssignable, .src = "package main\nfunc main() {\n    _ += 1\n    println(1)\n}\n" },
    // codegen.zig:2388 continue
    .{ .err = error.OutsideLoop, .src = "package main\nfunc main() {\n    continue\n}\n" },
    // codegen.zig:2400 expression without a value — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\ntype Bad error {\n    code int\n}\nfunc check(ok bool) error? {\n    if ok { return nil }\n    return Bad{code: 1}\n}\nfunc wrapper() error? {\n    a, b := check(true)?, 1\n    println(a, b)\n    return nil\n}\nfunc main() {\n    show := wrapper()\n    println(show == nil)\n}\n", .check_ok = true },
    // codegen.zig:2456 <dyn> id.name
    .{ .err = error.UndefinedName, .src = "package main\nfunc main() {\n    zzz = 1\n    println(1)\n}\n" },
    // codegen.zig:2457 <dyn> id.name
    .{ .err = error.Immutable, .src = "package main\nfunc main() {\n    x := 1\n    x = 2\n    println(x)\n}\n" },
    // codegen.zig:2462 field of _
    .{ .err = error.NotAssignable, .src = "package main\nfunc main() {\n    _.x = 1\n    println(1)\n}\n" },
    // codegen.zig:2467 assignment target must be a name or a field
    .{ .err = error.NotAssignable, .src = "package main\nfunc main() {\n    1 = 2\n    println(1)\n}\n" },
    // codegen.zig:2475 field access on a non-struct value
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n    x := 1\n    println(x.y)\n}\n" },
    // codegen.zig:2477 <dyn> name
    .{ .err = error.UndefinedField, .src = "package main\ntype P struct { x int }\nfunc main() {\n    p := P{1}\n    println(p.zzz)\n}\n" },
    // codegen.zig:2524 ? applies to a function call
    .{ .err = error.Unsupported, .src = "package main\ntype Bad error {\n    code int\n}\nfunc wrapper() error? {\n    x := 1\n    y := x?\n    println(y)\n    return nil\n}\nfunc main() {\n    show := wrapper()\n    println(show == nil)\n}\n" },
    // codegen.zig:2539 ? needs the enclosing function to return error? as its last result
    .{ .err = error.TypeMismatch, .src = "package main\ntype Bad error {\n    code int\n}\nfunc check(ok bool) error? {\n    if ok { return nil }\n    return Bad{code: 1}\n}\nfunc plain() int {\n    n := check(true)?\n    return n\n}\nfunc main() {\n    println(plain())\n}\n" },
    // codegen.zig:2542 ? needs zero values for the other results of the enclosing function (not a function value or union)
    .{ .err = error.TypeMismatch, .src = "package main\ntype Shape union {\n    Circle { r int }\n    Empty {}\n}\ntype Bad error {\n    code int\n}\nfunc check(ok bool) error? {\n    if ok { return nil }\n    return Bad{code: 1}\n}\nfunc f() (Shape, error?) {\n    n := check(true)?\n    println(n)\n    return Circle{r: 1}, nil\n}\nfunc main() {\n    s, e := f()\n    println(e == nil)\n}\n" },
    // codegen.zig:2547 ? needs a call whose last result is error?
    .{ .err = error.TypeMismatch, .src = "package main\nfunc plainCall() int { return 1 }\ntype Bad error {\n    code int\n}\nfunc wrapper() error? {\n    n := plainCall()?\n    println(n)\n    return nil\n}\nfunc main() {\n    show := wrapper()\n    println(show == nil)\n}\n" },
    // codegen.zig:2578 an error wrap `? L{...}` needs an error label
    .{ .err = error.TypeMismatch, .src = "package main\ntype Bad error {\n    code int\n}\ntype NotLabel struct {\n    n int\n}\nfunc check(ok bool) error? {\n    if ok { return nil }\n    return Bad{code: 1}\n}\nfunc wrapper() error? {\n    n := check(true)? NotLabel{n: 1}\n    println(n)\n    return nil\n}\nfunc main() {\n    show := wrapper()\n    println(show == nil)\n}\n" },
    // codegen.zig:2626 value count differs from the number of names
    .{ .err = error.ResultCountMismatch, .src = "package main\nfunc pair() (int, int) { return 1, 2 }\nfunc main() {\n    a, b, c := pair(), 3\n    println(a, b, c)\n}\n" },
    // codegen.zig:2717 `mut x` marks only an argument of a mut parameter
    .{ .err = error.TypeMismatch, .src = "package main\nfunc f(n int) int { return n }\nfunc main() {\n    mut y := 1\n    println(f(mut y))\n}\n" },
    // codegen.zig:2726 ? leaves several values (decompose them with `a, b := f()?`)
    .{ .err = error.ResultCountMismatch, .src = "package main\ntype Bad error {\n    code int\n}\nfunc pair(ok bool) (int, int, error?) {\n    if ok { return 1, 2, nil }\n    return 0, 0, Bad{code: 1}\n}\nfunc wrapper() error? {\n    n := pair(true)? + 1\n    println(n)\n    return nil\n}\nfunc main() {\n    show := wrapper()\n    println(show == nil)\n}\n" },
    // codegen.zig:2755 slice element type — check は受理（B-9a 報告の相談）
    .{ .err = error.Unsupported, .src = "package main\nfunc main() {\n    xs := []func(int) int{}\n    println(len(xs))\n}\n", .check_ok = true },
    // codegen.zig:2799 map key type must be int or string
    .{ .err = error.Unsupported, .src = "package main\nfunc main() {\n\tm := map[bool]int{true: 1}\n\tprintln(m[true])\n}\n" },
    // codegen.zig:2802 map value type
    .{ .err = error.Unsupported, .src = "package main\nfunc main() {\n\tm := map[int]func(){}\n\tprintln(m[0]())\n}\n" },
    // codegen.zig:2857 indexing a non-slice value
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n\tx := 5\n\tprintln(x[0])\n}\n" },
    // codegen.zig:2877 slicing a non-slice value
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n\tx := 5\n\tprintln(x[0:1])\n}\n" },
    // codegen.zig:2934 undefinedVar
    .{ .err = error.UndefinedName, .src = "package main\nfunc main() {\n\tprintln(undefinedVar)\n}\n" },
    // codegen.zig:2963 hasPrefixAt
    .{ .err = error.Unexported, .src = "package main\nimport \"std/strings\"\nfunc main() {\n\tprintln(strings.hasPrefixAt)\n}\n" },
    // codegen.zig:2971 NotAThing
    .{ .err = error.UndefinedName, .src = "package main\nimport \"std/strings\"\nfunc main() {\n\tprintln(strings.NotAThing)\n}\n" },
    // codegen.zig:3005 a for expression is consumed only as an Iter argument (an escaping Iter is outside the fragment)
    .{ .err = error.Unsupported, .src = "package main\nfunc main() {\n\txs := []int{1, 2, 3}\n\tx := for i <- xs yield i\n\tprintln(x)\n}\n" },
    // codegen.zig:3014 call has no value — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\nfunc f() {\n}\nfunc main() {\n\tprintln(f())\n}\n", .lower_err = error.Unsupported, .check_ok = true },
    // codegen.zig:3051 Foo
    .{ .err = error.UndefinedType, .src = "package main\nfunc main() {\n\tx := Foo{1, 2}\n\tprintln(x)\n}\n" },
    // codegen.zig:3071 x
    .{ .err = error.Redeclared, .src = "package main\ntype P struct {\n\tx int\n}\nfunc main() {\n\tp := P{x: 1, x: 2}\n\tprintln(p.x)\n}\n" },
    // codegen.zig:3073 y
    .{ .err = error.UndefinedField, .src = "package main\ntype P struct {\n\tx int\n}\nfunc main() {\n\tp := P{y: 1}\n\tprintln(p.x)\n}\n" },
    // codegen.zig:3110 a zero-value literal T{} needs every field to have a zero value (not a function value or union)
    .{ .err = error.TypeMismatch, .src = "package main\ntype U union {\n\tA {}\n\tB {}\n}\ntype S struct {\n\tu U\n}\nfunc main() {\n\ts := S{}\n\tprintln(s.u)\n}\n" },
    // codegen.zig:3182 switch arms have different types
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n\tx := 1\n\ty := switch x {\n\tcase 1: 1\n\tdefault: true\n\t}\n\tprintln(y)\n}\n" },
    // codegen.zig:3201 v
    .{ .err = error.UndefinedName, .src = "package main\nfunc main() {\n\tx := switch {\n\tcase v: 1\n\tdefault: 0\n\t}\n\tprintln(x)\n}\n" },
    // codegen.zig:3224 type pattern in a switch without subject
    .{ .err = error.TypeMismatch, .src = "package main\ntype Shape union {\n\tCircle { r int }\n}\nfunc main() {\n\tx := switch {\n\tcase Circle{r}: r\n\tdefault: 0\n\t}\n\tprintln(x)\n}\n" },
    // codegen.zig:3227 type pattern on a non-union value — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\ntype Shape union {\n\tCircle { r int }\n}\nfunc main() {\n\tn := 1\n\tx := switch n {\n\tcase Circle{r}: r\n\tdefault: 0\n\t}\n\tprintln(x)\n}\n", .check_ok = true },
    // codegen.zig:3235 bogus
    .{ .err = error.UndefinedField, .src = "package main\ntype Shape union {\n\tCircle { r int }\n}\nfunc main() {\n\ts := Circle{r: 5}\n\tx := switch s {\n\tcase Circle{bogus}: bogus\n\tdefault: 0\n\t}\n\tprintln(x)\n}\n" },
    // codegen.zig:3289 comparing nil with nil
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n\tprintln(nil == nil)\n}\n" },
    // codegen.zig:3373 string operator on a non-string value
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n\ts := \"a\"\n\tprintln(s == 1)\n}\n" },
    // codegen.zig:3521 map key must be a string
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n\tmut m := mut map[string]int{}\n\tm[1] = 2\n\tprintln(m[\"a\"])\n}\n" },
    // codegen.zig:3679 append
    .{ .err = error.ArityMismatch, .src = "package main\nfunc main() {\n\tmut xs := mut []int{1, 2}\n\txs = append(xs)\n\tprintln(xs)\n}\n" },
    // codegen.zig:3684 append to a non-slice value
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n\tx := 5\n\tprintln(append(x, 1))\n}\n" },
    // codegen.zig:3783 assignment to an entry of an immutable map
    .{ .err = error.Immutable, .src = "package main\nfunc main() {\n\tm := map[string]int{\"a\": 1}\n\tm[\"a\"] = 2\n\tprintln(m[\"a\"])\n}\n" },
    // codegen.zig:3784 map assignment target must be a mut binding
    .{ .err = error.Immutable, .src = "package main\nfunc main() {\n\tm := mut map[string]int{}\n\tm[\"a\"] = 1\n\tprintln(m[\"a\"])\n}\n" },
    // codegen.zig:3794 map assignment target must be a mut binding
    .{ .err = error.Unsupported, .src = "package main\ntype S struct {\n\tm mut map[string]int\n}\nfunc main() {\n\ts := S{m: mut map[string]int{}}\n\ts.m[\"a\"] = 1\n\tprintln(s.m[\"a\"])\n}\n" },
    // codegen.zig:3797 indexing a non-slice value
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n\tmut x := 5\n\tx[0] = 1\n\tprintln(x)\n}\n" },
    // codegen.zig:3799 assignment to an element of an immutable slice
    .{ .err = error.Immutable, .src = "package main\nfunc main() {\n\txs := []int{1, 2, 3}\n\txs[0] = 5\n\tprintln(xs[0])\n}\n" },
    // codegen.zig:3860 lambda parameter type differs from the function type — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\nfunc apply(n int, f func(int)) {\n\tf(n)\n}\nfunc main() {\n\tapply(3, (x string) => {\n\t\tprintln(x)\n\t})\n}\n", .check_ok = true },
    // codegen.zig:3917 function value call
    .{ .err = error.ArityMismatch, .src = "package main\nfunc f(a int) int { return a }\nfunc main() {\n    g := f\n    println(g(1, 2))\n}\n" },
    // codegen.zig:3959 len
    .{ .err = error.ArityMismatch, .src = "package main\nfunc main() {\n    println(len(1, 2))\n}\n" },
    // codegen.zig:3985 len of a non-slice value
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n    println(len(1))\n}\n" },
    // codegen.zig:4001 bytes
    .{ .err = error.ArityMismatch, .src = "package main\nfunc main() {\n    println(bytes(\"a\", \"b\"))\n}\n" },
    // codegen.zig:4008 freeze
    .{ .err = error.ArityMismatch, .src = "package main\nfunc main() {\n    x := freeze([]int{1}, 2)\n    println(len(x))\n}\n" },
    // codegen.zig:4013 freeze of a non-container value
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n    println(freeze(1))\n}\n" },
    // codegen.zig:4019 delete
    .{ .err = error.ArityMismatch, .src = "package main\nfunc main() {\n    delete(1)\n}\n" },
    // codegen.zig:4021 delete on a non-map value
    .{ .err = error.TypeMismatch, .src = "package main\nfunc main() {\n    delete(1, 2)\n}\n" },
    // codegen.zig:4023 delete on an immutable map
    .{ .err = error.Immutable, .src = "package main\nfunc main() {\n    m := map[int]int{1: 2}\n    delete(m, 1)\n}\n" },
    // codegen.zig:4038 calling a local value
    .{ .err = error.Unsupported, .src = "package main\nfunc main() {\n    x := 1\n    println(x())\n}\n" },
    // codegen.zig:4051 call target must be a function name
    .{ .err = error.Unsupported, .src = "package main\nfunc main() {\n    println((1)())\n}\n" },
    // codegen.zig:4055 type arguments to a non-generic function
    .{ .err = error.TypeMismatch, .src = "package main\nfunc f(a int) int { return a }\nfunc main() {\n    println(f[int](1))\n}\n" },
    // codegen.zig:4056 nosuch
    .{ .err = error.UndefinedFunction, .src = "package main\nfunc main() {\n    nosuch()\n}\n" },
    // codegen.zig:4057 f
    .{ .err = error.ArityMismatch, .src = "package main\nfunc f(a int) int { return a }\nfunc main() {\n    println(f(1, 2))\n}\n" },
    // codegen.zig:4092 mut argument type differs from the parameter
    .{ .err = error.TypeMismatch, .src = "package main\nfunc inc(a mut int) { a = a + 1 }\nfunc main() {\n    mut b := true\n    inc(mut b)\n}\n" },
    // codegen.zig:4152 function-typed argument type differs from the parameter — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\nfunc run(g func(int) bool, x int) bool { return g(x) }\nfunc apply(f func(int) int, x int) int {\n    println(run(f, x))\n    return f(x)\n}\nfunc main() {\n    println(apply((n) => n + 1, 1))\n}\n", .check_ok = true },
    // codegen.zig:4165 a for expression with several generators (V3-4 covers a single generator)
    .{ .err = error.Unsupported, .src = "package main\nfunc each(n int, f func(int)) {}\nfunc main() {\n    xs := []int{1, 2}\n    ys := []int{3, 4}\n    each(1, for x <- xs; y <- ys yield x)\n}\n" },
    // codegen.zig:4218 lambda parameter type differs from the function type — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\nfunc each(n int, f func(int)) {}\nfunc main() {\n    each(1, (x bool) => { println(x) })\n}\n", .check_ok = true },
    // codegen.zig:4237 yield values of different types — check は受理（B-9a 報告の相談）
    .{ .err = error.TypeMismatch, .src = "package main\nfunc Consume[T](it func(func(T))) {}\nfunc main() {\n    xs := []int{1, 2}\n    Consume(for x <- xs { if x > 1 { yield 1 } else { yield true } })\n}\n", .check_ok = true },
    // codegen.zig:4242 lambda argument count
    .{ .err = error.ArityMismatch, .src = "package main\nfunc each(n int, f func(int)) { f(1, 2) }\nfunc main() {\n    each(1, (x) => println(x))\n}\n" },
    // codegen.zig:4243 lambda with multiple results
    .{ .err = error.Unsupported, .src = "package main\nfunc each(n int, f func(int) (int, int)) { println(f(1)) }\nfunc main() {\n    each(1, (x) => x)\n}\n" },
    // codegen.zig:4312 a for expression is one value (one hole)
    .{ .err = error.HoleCountMismatch, .src = "package main\nfunc each(a int, b int, f func(int)) {}\nfunc main() {\n    xs := []int{1, 2}\n    (for x <- xs yield x) |> each(_, _)\n}\n" },
    // codegen.zig:4320 pipe left side has no value
    .{ .err = error.HoleCountMismatch, .src = "package main\nfunc f(a int) int { return a }\nfunc main() {\n    println(println(1) |> f())\n}\n" },
    // ── check（正）が拒否し、direct（退役した codegen）は受理していた入力（B-9a — 受理範囲を check に揃えた分）
    // switch の網羅（desugar unionSwitch / Lean の def error）
    .{ .err = error.TypeMismatch, .src = "package main\ntype U union { A { x int }; B { y int } }\nfunc f(u U) int { return switch u { case A{x}: x } }\nfunc main() { println(f(A{1})) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\ntype U union { A { x int }; B { y int } }\nfunc f(u U) { switch u { case A{x}: println(x) } }\nfunc main() { f(A{1}) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc f(x int) int { return switch x { case 1: 10 } }\nfunc main() { println(f(2)) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc f(b bool) int { return switch b { case true: 1\n case false: 0 } }\nfunc main() { println(f(true)) }\n" },
    .{ .err = error.TypeMismatch, .src = "package main\nfunc f(x int) int { return switch { case x > 1: 1 } }\nfunc main() { println(f(3)) }\n" },
};
