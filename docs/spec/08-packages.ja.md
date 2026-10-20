# 8. package

日本語

[目次](README.ja.md)

コンパイルと名前の単位は package。1 ディレクトリが 1 package で、公開は大文字。リンクの時点で世界は閉じる — 動的リンクは無い。

```sober
// examples/pkg_import.sober
package main

// package と import（language.md 20 節）: import パスはルート相対・参照名はパスの末尾・公開 = 大文字。
// 他 package の struct の欄は読める（書けない — pkg_neg_field_write）。別名の import は末尾の衝突を避ける用

import "testdata/specpkg/shapes"
import sh "testdata/specpkg/shapes"

func main() {
    r := shapes.Rect{w: 2, h: 3}
    println(shapes.Area(r), sh.Area(r), r.w, shapes.Unit)
    q, err := shapes.Parse("circle")
    switch err {
    case nil: println(q.w)
    case shapes.Unknown{name}: println("unknown", name)
    }
}
```

出力:

```
6 6 2 1
unknown circle
```

P-1. import パスはルート（ビルドの起点のディレクトリ）からの相対パス。参照名はパスの末尾の要素で、package 名はディレクトリ名と同じでなければならない（`main` だけは例外 — どこに置いてもよい）。末尾が衝突するときだけ別名の import `import sh "path"` を使う。パスに package が無ければ拒否する。
例: [`examples/pkg_import.sober`](../../examples/pkg_import.sober)
拒否: [`examples/pkg_neg_name.sober`](../../examples/pkg_neg_name.sober)・[`examples/pkg_neg_missing.sober`](../../examples/pkg_neg_missing.sober)
決定: [language.md 20 節](../language.md)

P-2. import はファイルごと — 修飾名 `ref.N` を書くファイルは、自分で ref を import していなければならない。import の循環は拒否する。
例: [`examples/pkg_import.sober`](../../examples/pkg_import.sober)
拒否: [`examples/pkg_neg_unimported.sober`](../../examples/pkg_neg_unimported.sober)・[`examples/pkg_neg_cycle.sober`](../../examples/pkg_neg_cycle.sober)
決定: [language.md 20 節](../language.md)

P-3. 公開 = 名前が大文字で始まる（型・関数・const・union の variant ごと）。他の package の非公開の名前は参照できない。
例: [`examples/pkg_import.sober`](../../examples/pkg_import.sober)
拒否: [`examples/pkg_neg_private.sober`](../../examples/pkg_neg_private.sober)
決定: [language.md 20 節](../language.md)

P-4. 他の package で宣言された struct の欄は外から書けない — 代入・複合代入・`mut` の実引数・`delete`・欄を経た添字や map への格納のどれも。読みとリテラルによる構築は書ける（封の型の例外は 2 章 T-22）。欄の型が mut の中身（mut の slice / map）を持つ欄は外から読めない。
例: [`examples/pkg_import.sober`](../../examples/pkg_import.sober)
拒否: [`examples/pkg_neg_field_write.sober`](../../examples/pkg_neg_field_write.sober)
決定: [language.md 20 節](../language.md)

P-5. `std/` で始まる import パスは標準ライブラリ（コンパイラに焼き込まれている）。ルートの下に `std/` があっても std が優先する。`std/internal/…` は std の実装の詳細で、std の外のファイルからは import できない。
例: [`examples/std_import.sober`](../../examples/std_import.sober)
拒否: [`examples/internal_import_neg.sober`](../../examples/internal_import_neg.sober)
決定: [language.md 20 節](../language.md)

P-6. プログラムには main package の `func main()` か `func main() int` が要る。
拒否: [`examples/no_main.sober`](../../examples/no_main.sober)
決定: [language.md 27 節](../language.md)
