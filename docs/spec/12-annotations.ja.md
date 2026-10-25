# 12. アノテーション

日本語

[目次](README.ja.md)

アノテーション `@名前(引数)` は宣言に付ける。受理されたプログラムの意味を変えず、拒否を起こすか、宣言の形を決めるだけ。コンパイル時の計算（comptime）は無い。

A-1. 言語が知るアノテーションは `@errors`（7 章）・`@layout`・`@embed`・`@noinline`・`@exhaustive`・`@secret`・`@bless`・`@credential`・`@shared`・`@effects` の閉じた集合（interface ファイル `.sobi` にだけ書く `@expand` を除く）。知らないアノテーションは拒否する。
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

A-8. `@exhaustive` を付けた関数の中の switch は、subject が閉じた集合なら、その集合の全員を case に名指さなければならない（欠けた一員を名指して拒否する）。閉じた集合は、union なら全 variant・error なら case に書いたラベルの宣言元の package が 1 つのときその package の全ラベル（2 つ以上に跨る switch・ラベルを名指さない switch は対象外）・下地 int の named scalar なら型つきの const（T-36）のうち型の宣言と同じ package のものの全部。`default` と `_` の腕は集合の外の値だけを受ける — 全 variant を名指した union の switch の `default` は到達しないとして拒否する。この関数の中の error の switch では、閉じた集合のラベルの腕は「導出集合の外の到達しない腕」（E-14）として拒否しない。検査は `sober check` の analyzer が行う。
例: [`examples/exhaustive_table.sober`](../../examples/exhaustive_table.sober)・[`examples/exhaustive_error_mixed.sober`](../../examples/exhaustive_error_mixed.sober)
拒否: [`examples/exhaustive_neg_union.sober`](../../examples/exhaustive_neg_union.sober)・[`examples/exhaustive_neg_union_default.sober`](../../examples/exhaustive_neg_union_default.sober)・[`examples/exhaustive_neg_error.sober`](../../examples/exhaustive_neg_error.sober)・[`examples/exhaustive_neg_scalar.sober`](../../examples/exhaustive_neg_scalar.sober)
決定: [language.md 13 節の補](../language.md)

## 12.4 秘密の値

A-9. `@secret` は 3 か所に書く: 関数の前置の `@secret(k, …)`（名前は仮引数 — 関数の中でその仮引数を秘密の値の源とする。名前の列は空にしない）・struct の欄の後置の `@secret`（欄の読みは源）・const の前置の `@secret`（読みは源）。union の variant・error・panic の欄、型宣言、結果には書かない。`@bless`（関数の前置 — 結果を公開にする）は std の宣言のためのアノテーション。
例: [`examples/secret_annot.sober`](../../examples/secret_annot.sober)
拒否: [`examples/secret_neg_type.sober`](../../examples/secret_neg_type.sober)・[`examples/secret_neg_func_bare.sober`](../../examples/secret_neg_func_bare.sober)・[`examples/secret_neg_empty.sober`](../../examples/secret_neg_empty.sober)・[`examples/secret_neg_variant.sober`](../../examples/secret_neg_variant.sober)
決定: [language.md 12 節「秘密の値の宣言」](../language.md)

A-10. 秘密の値（`@secret` の仮引数・欄・const の読み、そこから算術・比較・シフト・変換・代入・関数の結果・mut の仮引数への書き込みで導いた値）は、if / while の条件・switch の subject・`&&` / `||` の左辺・for のガード・添字・slice の端・map の鍵・`/` と `%` の両辺に届いてはならない。`len` / `cap` の結果は公開・シフトの量と印字は対象外。仮引数をこれらに使う関数へ秘密の値を渡す呼び出しも拒否する（呼び先の位置を注に示す）。検査は `sober check` の analyzer が行う。
欄の秘密は欄の型と名前と値の出所で数える: 同じ型の値でも、秘密を書いた値の欄だけが秘密（mut の仮引数の欄への書き込みは呼び手の実引数の欄へ戻り、`y := x` の欄は x の欄・値が返される・欄やリテラルへ入る所では型と名前ごとの欄へ移る）。
例: [`examples/secret_flow.sober`](../../examples/secret_flow.sober)・[`examples/secret_ctx.sober`](../../examples/secret_ctx.sober)
拒否: [`examples/secret_neg_ctxfield.sober`](../../examples/secret_neg_ctxfield.sober)・[`examples/secret_neg_alias.sober`](../../examples/secret_neg_alias.sober)・[`examples/secret_neg_escape.sober`](../../examples/secret_neg_escape.sober)・[`examples/secret_neg_branch.sober`](../../examples/secret_neg_branch.sober)・[`examples/secret_neg_switch.sober`](../../examples/secret_neg_switch.sober)・[`examples/secret_neg_andor.sober`](../../examples/secret_neg_andor.sober)・[`examples/secret_neg_index.sober`](../../examples/secret_neg_index.sober)・[`examples/secret_neg_div.sober`](../../examples/secret_neg_div.sober)・[`examples/secret_neg_call.sober`](../../examples/secret_neg_call.sober)
決定: [language.md 12 節「秘密の値の宣言」](../language.md)

A-11. `@secret(…)` の名前は関数の仮引数の名前。`@bless` は std の外では書けない。
例: [`examples/secret_annot.sober`](../../examples/secret_annot.sober)
拒否: [`examples/secret_neg_name.sober`](../../examples/secret_neg_name.sober)・[`examples/secret_neg_bless.sober`](../../examples/secret_neg_bless.sober)
決定: [language.md 12 節「秘密の値の宣言」](../language.md)

A-12. `@credential` は関数の前置（結果は認証の源）と struct の欄の後置（欄の読みは認証の源）に、`@shared` は union の variant の後置（その variant の値は共有キャッシュも保存してよい方針）に、`@bless(origin)` は関数の前置（結果は認証の源に依らない）に書く。3 つとも std の宣言のためのアノテーションで、std の外では書けない。
例: [`examples/http_origin.sober`](../../examples/http_origin.sober)
拒否: [`examples/origin_neg_std.sober`](../../examples/origin_neg_std.sober)
決定: [language.md 12 節「出所の依存」](../language.md)

A-13. 認証の源（`@credential` の関数の結果・std の外での `@credential` の欄の読み）に届きうる関数値（源を呼ぶ・そういう関数を呼ぶ・そういう関数値を呼ぶ関数とラムダ）と、源から導いた値は、`@shared` の variant の値と 1 つの struct の値の中で出会ってはならない（struct のリテラルと欄の書き込み — slice・map の要素の合併は出会いではない）。std/http では、共有キャッシュも保存してよい方針（`http.Fresh` / `http.Shared`）を持つルートの行のハンドラ・middleware が認証の源に届きうる形、`http.Mount` で共有の方針の行を源に届きうる middleware の下に入れる形、std の外で応答 1 件の `cache` に共有の方針を書く形を拒否する。検査は `sober check` の analyzer が行う。
例: [`examples/http_origin.sober`](../../examples/http_origin.sober)・[`examples/http_cache.sober`](../../examples/http_cache.sober)
拒否: [`examples/origin_neg_cookie.sober`](../../examples/origin_neg_cookie.sober)・[`examples/origin_neg_helper.sober`](../../examples/origin_neg_helper.sober)・[`examples/origin_neg_fnvalue.sober`](../../examples/origin_neg_fnvalue.sober)・[`examples/origin_neg_before.sober`](../../examples/origin_neg_before.sober)・[`examples/origin_neg_after.sober`](../../examples/origin_neg_after.sober)・[`examples/origin_neg_mount.sober`](../../examples/origin_neg_mount.sober)・[`examples/origin_neg_capture.sober`](../../examples/origin_neg_capture.sober)・[`examples/origin_neg_head.sober`](../../examples/origin_neg_head.sober)・[`examples/origin_neg_resp.sober`](../../examples/origin_neg_resp.sober)
決定: [language.md 12 節「出所の依存」・13 節の補 3](../language.md)

## 12.5 関数の効果

A-14. `@effects(…)` は関数の前置と、名前付き関数型の後置（`type F func(…) R @effects(…)` — F の値の契約）に書く。項は効果の語（`block`・`io`・`panic`・`nondet`）・否定の語（`!io`）・名前付き関数型の名前（その型の値の効果）。項は全部が正か全部が否定で、否定できるのは語だけ。
例: [`examples/effects_annot.sober`](../../examples/effects_annot.sober)
拒否: [`examples/effects_neg_mixed.sober`](../../examples/effects_neg_mixed.sober)・[`examples/effects_neg_word.sober`](../../examples/effects_neg_word.sober)・[`examples/effects_neg_negtype.sober`](../../examples/effects_neg_negtype.sober)・[`examples/effects_neg_target.sober`](../../examples/effects_neg_target.sober)
決定: [language.md 12 節「関数の効果の宣言」](../language.md)

A-15. 関数の効果は導出する: `block` = std/task の待つ口（Run・Join・Try・Send・Recv）と待つ io、`io` = プロセスの外との入出力（`println` を含む）、`panic` = `panic(L{…})`、`nondet` = 時刻の読み。呼んだ関数の効果は呼び手の効果。匿名の関数型の仮引数の呼び出しは透過で、渡した実引数（ラムダ・関数）の効果を呼び手が持つ。名前付き関数型の値の呼び出しは、その型の契約か、契約が無ければその型の値になりうる全部の関数・ラムダの効果の合併。匿名の関数型の欄・局所の値の呼び出しは、プログラムの全部の関数値の効果の合併。
例: [`examples/effects_annot.sober`](../../examples/effects_annot.sober)
拒否: [`examples/effects_neg_transparent.sober`](../../examples/effects_neg_transparent.sober)・[`examples/effects_neg_union.sober`](../../examples/effects_neg_union.sober)・[`examples/effects_neg_any.sober`](../../examples/effects_neg_any.sober)
決定: [language.md 12 節「関数の効果の宣言」](../language.md)

A-16. 導出した効果は宣言の許容に含まれなければならない（正の列挙 = 書いた語と型の名前の項の値・否定形 = 否定した語の外の全部）。名前付き関数型の値になるラムダ・関数の効果は、その型の契約に含まれなければならない。検査は `sober check` の analyzer が行う。
例: [`examples/effects_annot.sober`](../../examples/effects_annot.sober)
拒否: [`examples/effects_neg_leak.sober`](../../examples/effects_neg_leak.sober)・[`examples/effects_neg_fnvalue.sober`](../../examples/effects_neg_fnvalue.sober)
決定: [language.md 12 節「関数の効果の宣言」](../language.md)

A-17. 標準ライブラリの本体のある公開関数（`internal` の package を除く）は `@effects` を持たなければならない。正の列挙は正規形 — 本体と名前の呼び出しから来る語と、値を呼ぶ名前付き関数型の名前 — と等しくなければならない。否定形はこの規則を満たす。利用者の package の宣言は任意で、正の列挙は上界の主張である。
例: [`examples/effects_std.sober`](../../examples/effects_std.sober)・[`src/std/hex/hex.sober`](../../src/std/hex/hex.sober)・[`src/std/http/http.sober`](../../src/std/http/http.sober)
決定: [language.md 12 節「関数の効果の宣言」](../language.md)
