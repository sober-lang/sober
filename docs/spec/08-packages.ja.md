# 8. package

日本語

[目次](README.ja.md)

コンパイルと名前の単位は package。1 ディレクトリが 1 package で、公開は大文字。リンクの時点で世界は閉じる — 動的リンクは無い。

```sober
// examples/pkg_import.sober
package main

// package と import（language.md 20 節）: import パスはルート相対・修飾子はパスの全段・公開 = 大文字。
// 他 package の struct の欄は読める（書けない — pkg_neg_field_write）。別名の import は修飾子を短くする用（ファイル局所）

import "testdata/specpkg/shapes"
import sh "testdata/specpkg/shapes"

func main() {
    r := testdata.specpkg.shapes.Rect{w: 2, h: 3}
    println(testdata.specpkg.shapes.Area(r), sh.Area(r), r.w, testdata.specpkg.shapes.Unit)
    q, err := testdata.specpkg.shapes.Parse("circle")
    switch err {
    case nil: println(q.w)
    case testdata.specpkg.shapes.Unknown{name}: println("unknown", name)
    }
}
```

出力:

```
6 6 2 1
unknown circle
```

P-1. import パスはルート（ビルドの起点のディレクトリ）からの相対パス。パスの段はどれも小文字の識別子（a-z・0-9・_ — 数字始まりでない）でキーワードでない。package 名は最後の段（ディレクトリ名）と同じでなければならない（`main` だけは例外 — どこに置いてもよい）。パスに package が無ければ拒否する。
例: [`examples/pkg_import.sober`](../../examples/pkg_import.sober)
拒否: [`examples/pkg_neg_name.sober`](../../examples/pkg_neg_name.sober)・[`examples/pkg_neg_missing.sober`](../../examples/pkg_neg_missing.sober)・[`examples/import_neg_badpath.sober`](../../examples/import_neg_badpath.sober)
決定: [language.md 20 節](../language.md)

P-2. 修飾子 = パスの全段を `.` でつないだもの（`std/` は落とす — `std/http/server` → `http.server.Serve`・`std/json` → `json.Parse`）。別名の import `import srv "path"` は修飾子を丸ごと置き換える。修飾名は import の修飾子のうち綴りの頭に一致する最長のものと、続く名前に分かれる（段は小文字・公開の名前は大文字なので一意）。修飾子の根の段（`http.server` の `http`）は局所の束縛に使えず、根の段だけでは package を指さない。
例: [`examples/import_qualified.sober`](../../examples/import_qualified.sober)
拒否: [`examples/import_neg_rootonly.sober`](../../examples/import_neg_rootonly.sober)・[`examples/import_neg_rootlocal.sober`](../../examples/import_neg_rootlocal.sober)
決定: [language.md 20 節](../language.md)

P-3. import はファイルごと — 修飾名を書くファイルは、自分でその package を import していなければならない。import の循環は拒否する。
例: [`examples/pkg_import.sober`](../../examples/pkg_import.sober)
拒否: [`examples/pkg_neg_unimported.sober`](../../examples/pkg_neg_unimported.sober)・[`examples/pkg_neg_cycle.sober`](../../examples/pkg_neg_cycle.sober)
決定: [language.md 20 節](../language.md)

P-4. 公開 = 名前が大文字で始まる（型・関数・const・union の variant ごと）。他の package の非公開の名前は参照できない。
例: [`examples/pkg_import.sober`](../../examples/pkg_import.sober)
拒否: [`examples/pkg_neg_private.sober`](../../examples/pkg_neg_private.sober)
決定: [language.md 20 節](../language.md)

P-5. 他の package で宣言された struct の欄は外から書けない — 代入・複合代入・`mut` の実引数・`delete`・欄を経た添字や map への格納のどれも。読みとリテラルによる構築は書ける（封の型の例外は 2 章 T-22）。欄の型が mut の中身（mut の slice / map）を持つ欄は、外から読めず、リテラルで値を与えることもできない（外のリテラルではその欄を省く — ゼロ値の空の中身から始まる）。
例: [`examples/pkg_import.sober`](../../examples/pkg_import.sober)
拒否: [`examples/pkg_neg_field_write.sober`](../../examples/pkg_neg_field_write.sober)
決定: [language.md 20 節](../language.md)

P-6. `std/` で始まる import パスは標準ライブラリ（コンパイラに焼き込まれている）。ルートの下に `std/` があっても std が優先する。`std/internal/…` は std の実装の詳細で、std の外のファイルからは import できない。
例: [`examples/std_import.sober`](../../examples/std_import.sober)
拒否: [`examples/internal_import_neg.sober`](../../examples/internal_import_neg.sober)
決定: [language.md 20 節](../language.md)

P-7. プログラムには main package の `func main()` か `func main() int` が要る。
拒否: [`examples/no_main.sober`](../../examples/no_main.sober)
決定: [language.md 27 節](../language.md)

P-8. 公開の型の別名（`type Work = lib.Work`）は他の package の型を、別名を宣言した package の公開の名前で出す。公開は別名の名前の大小で決まり、公開の別名は非公開の型も指せる。std の公開の別名は `std/internal/…` の型を指してよい（import の検問はパスの字面の規則で、型の到達には掛からない）。利用者は別名の package だけを import すればよい。別名の右辺は宣言の場所から見える型に限る（他の package の非公開の型は指せない）。
例: [`examples/alias_pkg.sober`](../../examples/alias_pkg.sober)
決定: [language.md 32 節・20 節](../language.md)

P-9. ビルドの起点に `sober.mod` を置くと、モジュールのパス（最後の段が名前）・dep（木での名前 → ローカルパスの出所）・alias（std の根の付け替え）を宣言できる。import パスの根の段は「木での名前」— std の根・dep の名前・起点の木の根の段が 1 つの名前空間に住み、衝突は拒否（解消は sober.mod の行だけ）。dep の import パスは木での名前から（`import "kv/store"` → `kv.store.X`）書き、出所は sober.mod にだけ書く。起点の外の sober.mod は探さない。この版の dep はローカルパスだけ（版の指定・他の出所・dep の dep は拒否）。
例: `testdata/mod/project/`・`testdata/mod/renamed/`
拒否: `testdata/mod/neg_collide/`・`testdata/mod/neg_import/`・`testdata/mod/neg_remote/`・`testdata/mod/neg_aliastarget/`
決定: [language.md 20 節](../language.md)
