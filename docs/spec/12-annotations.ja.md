# 12. アノテーション

日本語

[目次](README.ja.md)

アノテーション `@名前(引数)` は宣言に付ける。受理されたプログラムの意味を変えず、拒否を起こすか、宣言の形を決めるだけ。コンパイル時の計算（comptime）は無い。

A-1. 言語が知るアノテーションは `@errors`（7章）・`@layout`・`@embed`・`@noinline`・`@exhaustive`・`@secret`・`@bless`・`@credential`・`@shared`・`@effects`・`@const`・`@replaces`・`@doubles`（13章）の閉じた集合（interfaceファイル `.sobi` にだけ書く `@expand` を除く）。知らないアノテーションは拒否する。
例: [`examples/errval.sober`](../../examples/errval.sober)・[`examples/layout_elf.sober`](../../examples/layout_elf.sober)・[`examples/embed_demo.sober`](../../examples/embed_demo.sober)・[`examples/noinline.sober`](../../examples/noinline.sober)
拒否: [`examples/annot_neg_unknown.sober`](../../examples/annot_neg_unknown.sober)
決定: [language.md 10節](../language.md)

A-2. `@noinline` はmut仮引数を持ち関数型の仮引数を持たない関数に付く。付けても外しても出力は同じ（呼び方が変わるだけ）。
例: [`examples/noinline.sober`](../../examples/noinline.sober)
拒否: [`examples/noinline_neg_target.sober`](../../examples/noinline_neg_target.sober)
決定: [language.md 26節](../language.md)

## 12.1 @embed

A-3. `@embed("パターン") const Name = map[string]string{}` は、パターンに合うファイルの中身をビルドの時点で「パス → 内容」のconstにする。パターンはルート相対で `**`（0個以上のディレクトリ）・`*`・`?` を使え、並びはパスのバイト順。受け皿は空の `map[string]string{}` のconstだけ。中身はUTF-8でなければならない。合うファイルが無ければ拒否する。
例: [`examples/embed_demo.sober`](../../examples/embed_demo.sober)
拒否: [`examples/embed_neg_nomatch.sober`](../../examples/embed_neg_nomatch.sober)
決定: [language.md 20節](../language.md)

## 12.2 @layout

A-4. `@layout` を付けたstructは、フィールドの型の位置に幅の語を書く: `u8` `u16le` `u32le` `u64le` `i8` `i16le` `i32le` `i64le` とBE版（`u16be` …）— そのフィールドのSoberの型はint。固定長配列 `[N]u8`（型は `[]byte`）・`[N]u16le` 等（型は `[]int`）もフィールドに書ける。フィールドは書いた順・書いた幅で詰める（暗黙のpaddingは無い）。幅の語・固定長配列は @layoutのstructのフィールドの外では書けず、@layoutはstructにだけ付き、フィールドを1つ以上持ち型パラメータを持たない。
例: [`examples/layout_elf.sober`](../../examples/layout_elf.sober)・[`examples/layout_widths.sober`](../../examples/layout_widths.sober)
拒否: [`examples/layout_neg_width.sober`](../../examples/layout_neg_width.sober)・[`examples/layout_neg_array.sober`](../../examples/layout_neg_array.sober)・[`examples/layout_neg_field.sober`](../../examples/layout_neg_field.sober)・[`examples/layout_neg_union.sober`](../../examples/layout_neg_union.sober)・[`examples/layout_neg_empty.sober`](../../examples/layout_neg_empty.sober)
決定: [language.md 36節](../language.md)

A-5. 読み書きはstd/layoutの変換のAPIで、型引数に @layoutのstructを書く: `layout.Decode[T](b, off) T?`・`layout.DecodeAt[T](b, off, i) T?`（N連のi番目）・`layout.Encode[T](mut out, v)`（`builder.Builder[byte]` の末尾へ）・`layout.Size[T]`（静的な大きさの定数 — 呼ばない）。読みでバイトが足りなければnil。符号つきの幅は符号拡張して読む。
例: [`examples/layout_elf.sober`](../../examples/layout_elf.sober)・[`examples/layout_widths.sober`](../../examples/layout_widths.sober)
拒否: [`examples/layout_neg_form.sober`](../../examples/layout_neg_form.sober)・[`examples/layout_neg_target.sober`](../../examples/layout_neg_target.sober)
決定: [language.md 36節](../language.md)

A-6. 書き込みでフィールドの値が幅に収まらない・固定長配列の長さが違うとpanic（終了コード101）。@layoutのstructのリテラルのフィールドに直に書いた整数リテラルが幅に収まらなければコンパイルエラー。
例: [`examples/layout_panic_width.sober`](../../examples/layout_panic_width.sober)・[`examples/layout_panic_signed.sober`](../../examples/layout_panic_signed.sober)・[`examples/layout_panic_length.sober`](../../examples/layout_panic_length.sober)
拒否: [`examples/layout_neg_literal.sober`](../../examples/layout_neg_literal.sober)
決定: [language.md 36節](../language.md)

## 12.3 analyzerの規則

A-7. std/poolの `h := pool.Acquire(mut p, v)` の直後の文は、同じpとhの `defer pool.Release(mut p, h)` でなければならない（返し忘れ・早すぎる返却・二重の返却を形で防ぐ）。検査は `sober check` のanalyzerが行う。
例: [`examples/pool.sober`](../../examples/pool.sober)・[`examples/pool_string.sober`](../../examples/pool_string.sober)
拒否: [`examples/pool_neg_nodefer.sober`](../../examples/pool_neg_nodefer.sober)
決定: [language.md 30節](../language.md)

A-8. `@exhaustive` を付けた関数の中のswitchは、subjectが閉じた集合なら、その集合の全員をcaseに列挙しなければならない（欠けた一員を特定して拒否する）。閉じた集合は、unionなら全variant・errorならcaseに書いたラベルの宣言元のpackageが1つのときそのpackageの全ラベル（2つ以上に跨るswitch・ラベルを明示しないswitchは対象外）・下地intのnamed scalarなら型つきのconst（T-36）のうち型の宣言と同じpackageのものの全部。`default` と `_` の分岐は集合の外の値だけを受ける — 全variantを列挙したunionのswitchの `default` は到達しないとして拒否する。この関数の中のerrorのswitchでは、閉じた集合のラベルの分岐は「導出集合の外の到達しない分岐」（E-14）として拒否しない。検査は `sober check` のanalyzerが行う。
例: [`examples/exhaustive_table.sober`](../../examples/exhaustive_table.sober)・[`examples/exhaustive_error_mixed.sober`](../../examples/exhaustive_error_mixed.sober)
拒否: [`examples/exhaustive_neg_union.sober`](../../examples/exhaustive_neg_union.sober)・[`examples/exhaustive_neg_union_default.sober`](../../examples/exhaustive_neg_union_default.sober)・[`examples/exhaustive_neg_error.sober`](../../examples/exhaustive_neg_error.sober)・[`examples/exhaustive_neg_scalar.sober`](../../examples/exhaustive_neg_scalar.sober)
決定: [language.md 13節の補](../language.md)

A-18. stdの外のコードがstdのstructの `dangerously` で始まるフィールドに字面の `false` 以外の値を与える構築（compositeの要素）は、`sober check` のanalyzerが毎回warningを出す（受理は変えない・抑止のオプションは無い — 安全な設定に戻すと消える）。字面の `false` とフィールドの省略（ゼロ値 = 安全な側）・stdの外のstructの同名のフィールドは鳴らない。
例: [`examples/dangerously_warn.sober`](../../examples/dangerously_warn.sober)（警告のゴールデン = testdata/analyzer_neg/dangerously_warn.warn）
決定: [language.md 12節](../language.md)

A-19. `@const(p, …)`（関数の前置 — 名前は仮引数・列は空にしない）を付けた仮引数はconst仮引数で、型はstring・mutでないものに限る。const仮引数に渡す実引数は、補間の無い文字列リテラル・constの名前・それらの `+`・括弧と、呼び出しを含む関数自身の `@const` の仮引数だけ（推論の伝播は無い）。`@const` を持つ関数は呼び出しのcalleeの位置にだけ書ける（関数値として取り出せない）。検査は `sober check` のanalyzerが行う。
例: [`examples/const_param.sober`](../../examples/const_param.sober)
拒否: [`examples/const_param_neg.sober`](../../examples/const_param_neg.sober)（ゴールデン = testdata/analyzer_neg/const_neg_param.err・const_neg_prop.err・const_neg_annot.err）
決定: [language.md 12節](../language.md)

## 12.4 秘密の値

A-9. `@secret` は3か所に書く: 関数の前置の `@secret(k, …)`（名前は仮引数 — 関数の中でその仮引数を秘密の値の源とする。名前の列は空にしない）・structのフィールドの後置の `@secret`（フィールドの読みは源）・constの前置の `@secret`（読みは源）。unionのvariant・error・panicのフィールド、型宣言、結果には書かない。`@bless`（関数の前置 — 結果を公開にする）はstdの宣言のためのアノテーション。
例: [`examples/secret_annot.sober`](../../examples/secret_annot.sober)
拒否: [`examples/secret_neg_type.sober`](../../examples/secret_neg_type.sober)・[`examples/secret_neg_func_bare.sober`](../../examples/secret_neg_func_bare.sober)・[`examples/secret_neg_empty.sober`](../../examples/secret_neg_empty.sober)・[`examples/secret_neg_variant.sober`](../../examples/secret_neg_variant.sober)
決定: [language.md 12節「秘密の値の宣言」](../language.md)

A-10. 秘密の値（`@secret` の仮引数・フィールド・constの読み、そこから算術・比較・シフト・変換・代入・関数の結果・mutの仮引数への書き込みで導いた値）は、if / whileの条件・switchのsubject・`&&` / `||` の左辺・forのガード・添字・sliceの端・mapの鍵・`/` と `%` の両辺に届いてはならない。`len` / `cap` の結果は公開・シフトの量と印字は対象外。仮引数をこれらに使う関数へ秘密の値を渡す呼び出しも拒否する（呼び先の位置を注記に示す）。検査は `sober check` のanalyzerが行う。
フィールドの秘密はフィールドの型と名前と値の出所で数える: 同じ型の値でも、秘密を書いた値のフィールドだけが秘密（mutの仮引数のフィールドへの書き込みは呼び手の実引数のフィールドへ戻り、`y := x` のフィールドはxのフィールド・値が返される・フィールドやリテラルへ入る所では型と名前ごとのフィールドへ移る）。
例: [`examples/secret_flow.sober`](../../examples/secret_flow.sober)・[`examples/secret_ctx.sober`](../../examples/secret_ctx.sober)
拒否: [`examples/secret_neg_ctxfield.sober`](../../examples/secret_neg_ctxfield.sober)・[`examples/secret_neg_alias.sober`](../../examples/secret_neg_alias.sober)・[`examples/secret_neg_escape.sober`](../../examples/secret_neg_escape.sober)・[`examples/secret_neg_branch.sober`](../../examples/secret_neg_branch.sober)・[`examples/secret_neg_switch.sober`](../../examples/secret_neg_switch.sober)・[`examples/secret_neg_andor.sober`](../../examples/secret_neg_andor.sober)・[`examples/secret_neg_index.sober`](../../examples/secret_neg_index.sober)・[`examples/secret_neg_div.sober`](../../examples/secret_neg_div.sober)・[`examples/secret_neg_call.sober`](../../examples/secret_neg_call.sober)
決定: [language.md 12節「秘密の値の宣言」](../language.md)

A-11. `@secret(…)` の名前は関数の仮引数の名前。`@bless` はstdの外では書けない。
例: [`examples/secret_annot.sober`](../../examples/secret_annot.sober)
拒否: [`examples/secret_neg_name.sober`](../../examples/secret_neg_name.sober)・[`examples/secret_neg_bless.sober`](../../examples/secret_neg_bless.sober)
決定: [language.md 12節「秘密の値の宣言」](../language.md)

A-12. `@credential` は関数の前置（結果は認証の源）とstructのフィールドの後置（フィールドの読みは認証の源）に、`@shared` はunionのvariantの後置（そのvariantの値は共有キャッシュも保存してよい方針）に、`@bless(origin)` は関数の前置（結果は認証の源に依らない）に書く。3つともstdの宣言のためのアノテーションで、stdの外では書けない。
例: [`examples/http_origin.sober`](../../examples/http_origin.sober)
拒否: [`examples/origin_neg_std.sober`](../../examples/origin_neg_std.sober)
決定: [language.md 12節「出所の依存」](../language.md)

A-13. 認証の源（`@credential` の関数の結果・stdの外での `@credential` のフィールドの読み）に届きうる関数値（源を呼ぶ・そういう関数を呼ぶ・そういう関数値を呼ぶ関数とラムダ）と、源から導いた値は、`@shared` のvariantの値と1つのstructの値の中で出会ってはならない（structのリテラルとフィールドの書き込み — slice・mapの要素の合併は出会いではない）。std/http/serverでは、共有キャッシュも保存してよい方針（`http.server.Fresh` / `http.server.Shared` / `http.server.Unstated`）を持つルートの行のハンドラ・middlewareが認証の源に届きうる形、`http.server.Mount` で共有の方針の行を源に届きうるmiddlewareの下に入れる形、stdの外でレスポンス1件の `cache` に共有の方針を書く形を拒否する。検査は `sober check` のanalyzerが行う。
例: [`examples/http_origin.sober`](../../examples/http_origin.sober)・[`examples/http_cache.sober`](../../examples/http_cache.sober)
拒否: [`examples/origin_neg_cookie.sober`](../../examples/origin_neg_cookie.sober)・[`examples/origin_neg_helper.sober`](../../examples/origin_neg_helper.sober)・[`examples/origin_neg_fnvalue.sober`](../../examples/origin_neg_fnvalue.sober)・[`examples/origin_neg_before.sober`](../../examples/origin_neg_before.sober)・[`examples/origin_neg_after.sober`](../../examples/origin_neg_after.sober)・[`examples/origin_neg_mount.sober`](../../examples/origin_neg_mount.sober)・[`examples/origin_neg_capture.sober`](../../examples/origin_neg_capture.sober)・[`examples/origin_neg_head.sober`](../../examples/origin_neg_head.sober)・[`examples/origin_neg_resp.sober`](../../examples/origin_neg_resp.sober)
決定: [language.md 12節「出所の依存」・13節の補3](../language.md)

## 12.5 関数のエフェクト

A-14. `@effects(…)` は関数の前置と、名前付き関数型の後置（`type F func(…) R @effects(…)` — Fの値の契約）に書く。項はエフェクトの語（`block`・`io`・`panic`・`nondet`）・否定の語（`!io`）・名前付き関数型の名前（その型の値のエフェクト）。項は全部が正か全部が否定で、否定できるのは語だけ。
例: [`examples/effects_annot.sober`](../../examples/effects_annot.sober)
拒否: [`examples/effects_neg_mixed.sober`](../../examples/effects_neg_mixed.sober)・[`examples/effects_neg_word.sober`](../../examples/effects_neg_word.sober)・[`examples/effects_neg_negtype.sober`](../../examples/effects_neg_negtype.sober)・[`examples/effects_neg_target.sober`](../../examples/effects_neg_target.sober)
決定: [language.md 12節「関数のエフェクトの宣言」](../language.md)

A-15. 関数のエフェクトは導出する: `block` = std/taskの待つ関数（Run・Join・Try・Send・Recv）と待つio、`io` = プロセスの外との入出力（`println` を含む）、`panic` = `panic(L{…})`、`nondet` = 時刻の読み。呼んだ関数のエフェクトは呼び手のエフェクト。匿名の関数型の仮引数の呼び出しは透過で、渡した実引数（ラムダ・関数）のエフェクトを呼び手が持つ。名前付き関数型の値の呼び出しは、その型の契約か、契約が無ければその型の値になりうる全部の関数・ラムダのエフェクトの合併。匿名の関数型のフィールド・局所の値の呼び出しは、プログラムの全部の関数値のエフェクトの合併。
例: [`examples/effects_annot.sober`](../../examples/effects_annot.sober)
拒否: [`examples/effects_neg_transparent.sober`](../../examples/effects_neg_transparent.sober)・[`examples/effects_neg_union.sober`](../../examples/effects_neg_union.sober)・[`examples/effects_neg_any.sober`](../../examples/effects_neg_any.sober)
決定: [language.md 12節「関数のエフェクトの宣言」](../language.md)

A-16. 導出したエフェクトは宣言の許容に含まれなければならない（正の列挙 = 書いた語と型の名前の項の値・否定形 = 否定した語の外の全部）。名前付き関数型の値になるラムダ・関数のエフェクトは、その型の契約に含まれなければならない。検査は `sober check` のanalyzerが行う。
例: [`examples/effects_annot.sober`](../../examples/effects_annot.sober)
拒否: [`examples/effects_neg_leak.sober`](../../examples/effects_neg_leak.sober)・[`examples/effects_neg_fnvalue.sober`](../../examples/effects_neg_fnvalue.sober)
決定: [language.md 12節「関数のエフェクトの宣言」](../language.md)

A-17. 標準ライブラリの本体のある公開関数（`internal` のpackageを除く）は `@effects` を持たなければならない。正の列挙は正規形 — 本体と名前の呼び出しから来る語と、値を呼ぶ名前付き関数型の名前 — と等しくなければならない。否定形はこの規則を満たす。利用者のpackageの宣言は任意で、正の列挙は上界の主張である。
例: [`examples/effects_std.sober`](../../examples/effects_std.sober)・[`src/std/hex/hex.sober`](../../src/std/hex/hex.sober)・[`src/std/http/http.sober`](../../src/std/http/http.sober)
決定: [language.md 12節「関数のエフェクトの宣言」](../language.md)
