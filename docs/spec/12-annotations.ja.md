# 12. アノテーション

日本語

[目次](README.ja.md)

アノテーション `@名前(引数)` は宣言に付ける。受理されたプログラムの意味を変えず、拒否を起こすか、宣言の形を決めるだけ。コンパイル時の計算（comptime）は無い。

A-1. 言語が知るアノテーションは `@errors`（7 章）・`@layout`・`@embed`・`@noinline` の閉じた集合（interface ファイル `.sobi` にだけ書く `@expand` を除く）。知らないアノテーションは拒否する。
例: [`examples/errval.sober`](../../examples/errval.sober)・[`examples/layout_elf.sober`](../../examples/layout_elf.sober)・[`examples/embed_demo.sober`](../../examples/embed_demo.sober)・[`examples/noinline.sober`](../../examples/noinline.sober)
拒否: [`examples/annot_neg_unknown.sober`](../../examples/annot_neg_unknown.sober)
決定: [language.md 10 節](../language.md)

A-2. `@noinline` は mut 仮引数を持ち関数型の仮引数を持たない関数に付く。付けても外しても出力は同じ（呼び方が変わるだけ）。
例: [`examples/noinline.sober`](../../examples/noinline.sober)
拒否: [`examples/noinline_neg_target.sober`](../../examples/noinline_neg_target.sober)
決定: [language.md 26 節](../language.md)

## 12.1 @embed

A-3. `@embed("パターン") const Name = map[string]string{}` は、パターンに合うファイルの中身をビルドの時点で「パス → 内容」の const にする。パターンはルート相対で `**`（0 個以上のディレクトリ）・`*`・`?` を使え、並びはパスのバイト順。受け皿は空の `map[string]string{}` の const だけ。中身は UTF-8 でなければならない。合うファイルが無ければ拒否する。
例: [`examples/embed_demo.sober`](../../examples/embed_demo.sober)
拒否: [`examples/embed_neg_nomatch.sober`](../../examples/embed_neg_nomatch.sober)
決定: [language.md 20 節](../language.md)

## 12.2 @layout

A-4. `@layout` を付けた struct は、欄の型の位置に幅の語を書く: `u8` `u16le` `u32le` `u64le` `i8` `i16le` `i32le` `i64le` と BE 版（`u16be` …）— その欄の Sober の型は int。固定長配列 `[N]u8`（型は `[]byte`）・`[N]u16le` 等（型は `[]int`）も欄に書ける。欄は書いた順・書いた幅で詰める（暗黙の padding は無い）。幅の語・固定長配列は @layout の struct の欄の外では書けず、@layout は struct にだけ付き、欄を 1 つ以上持ち型パラメータを持たない。
例: [`examples/layout_elf.sober`](../../examples/layout_elf.sober)・[`examples/layout_widths.sober`](../../examples/layout_widths.sober)
拒否: [`examples/layout_neg_width.sober`](../../examples/layout_neg_width.sober)・[`examples/layout_neg_array.sober`](../../examples/layout_neg_array.sober)・[`examples/layout_neg_field.sober`](../../examples/layout_neg_field.sober)・[`examples/layout_neg_union.sober`](../../examples/layout_neg_union.sober)・[`examples/layout_neg_empty.sober`](../../examples/layout_neg_empty.sober)
決定: [language.md 36 節](../language.md)

A-5. 読み書きは std/layout の写しの口で、型引数に @layout の struct を書く: `layout.Decode[T](b, off) T?`・`layout.DecodeAt[T](b, off, i) T?`（N 連の i 番目）・`layout.Encode[T](mut out, v)`（`builder.Builder[byte]` の末尾へ）・`layout.Size[T]`（静的な大きさの定数 — 呼ばない）。読みでバイトが足りなければ nil。符号つきの幅は符号拡張して読む。
例: [`examples/layout_elf.sober`](../../examples/layout_elf.sober)・[`examples/layout_widths.sober`](../../examples/layout_widths.sober)
拒否: [`examples/layout_neg_form.sober`](../../examples/layout_neg_form.sober)・[`examples/layout_neg_target.sober`](../../examples/layout_neg_target.sober)
決定: [language.md 36 節](../language.md)

A-6. 書き込みで欄の値が幅に収まらない・固定長配列の長さが違うと panic（終了コード 101）。@layout の struct のリテラルの欄に直に書いた整数リテラルが幅に収まらなければコンパイルエラー。
例: [`examples/layout_panic_width.sober`](../../examples/layout_panic_width.sober)・[`examples/layout_panic_signed.sober`](../../examples/layout_panic_signed.sober)・[`examples/layout_panic_length.sober`](../../examples/layout_panic_length.sober)
拒否: [`examples/layout_neg_literal.sober`](../../examples/layout_neg_literal.sober)
決定: [language.md 36 節](../language.md)

## 12.3 analyzer の規則

A-7. std/pool の `h := pool.Acquire(mut p, v)` の直後の文は、同じ p と h の `defer pool.Release(mut p, h)` でなければならない（返し忘れ・早すぎる返却・二重の返却を形で防ぐ）。検査は `sober check` の analyzer が行う。
例: [`examples/pool.sober`](../../examples/pool.sober)・[`examples/pool_string.sober`](../../examples/pool_string.sober)
拒否: [`examples/pool_neg_nodefer.sober`](../../examples/pool_neg_nodefer.sober)
決定: [language.md 30 節](../language.md)
