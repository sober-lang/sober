# 1. 字句と構文

日本語

[目次](README.ja.md)

字句と文法の正は [syntax.md](../syntax.md)（Go仕様のEBNFからの差分）。この章はそこから、書き手が最初に当たる字句の規則だけを抜き出す。ここに無い字句と文法はsyntax.mdを読む。

L-1. 整数リテラルは10進と、接頭辞 `0x` / `0o` / `0b`（小文字だけ）のn進。値はintに収まる範囲。桁区切りの `_` は無い。先頭が0の10進（`010`）は拒否する — 8進は `0o10` と書く。
例: [`examples/radix_lit.sober`](../../examples/radix_lit.sober)
拒否: [`examples/lit_leading_zero.sober`](../../examples/lit_leading_zero.sober)・[`examples/lit_int_range.sober`](../../examples/lit_int_range.sober)
決定: [syntax.md決定18](../syntax.md)

L-2. 浮動小数のリテラルは10進だけで、小数点の両側に数字が要る（`1.` と `.5` は無い）。文字リテラル `'a'` はASCIIだけ。規則の詳細は2章（T-7・T-9）。
例: [`examples/float_basic.sober`](../../examples/float_basic.sober)・[`examples/char_lit.sober`](../../examples/char_lit.sober)
拒否: [`examples/char_lit_nonascii.sober`](../../examples/char_lit_nonascii.sober)
決定: [language.md 33節・37節](../language.md)

L-3. 文字列リテラル `"…"` の中の `${式}` は補間（2章T-14）。穴の中の式は囲む関数の文脈で読む — 呼び出しも `?` も書ける。
例: [`examples/interp.sober`](../../examples/interp.sober)・[`examples/interp_holes.sober`](../../examples/interp_holes.sober)
決定: [language.md 24節](../language.md)

L-4. セミコロンは自動で挿入する（Goと同じ）。行末が識別子・リテラル・`)` `]` `}` に加えて後置の `?` のときも挿入する。だから `f()? L{…}` は同じ行にあれば包み替え（7章E-8）、`?` で改行すれば伝播だけ。
例: [`examples/try_wrap.sober`](../../examples/try_wrap.sober)・[`examples/try_prop.sober`](../../examples/try_prop.sober)
決定: [syntax.md決定5](../syntax.md)

L-5. 組み込みの名前 `len` `shape` `println` `await` `freeze` `keys` `bytes` `true` `false` `append` `delete` は再束縛できない — ローカルの束縛・型パラメータ・トップレベルの宣言の名前のどれにも使えない。
拒否: [`examples/builtin_rebind.sober`](../../examples/builtin_rebind.sober)・[`examples/builtin_decl.sober`](../../examples/builtin_decl.sober)・[`examples/builtin_rebind_append.sober`](../../examples/builtin_rebind_append.sober)・[`examples/builtin_rebind_delete.sober`](../../examples/builtin_rebind_delete.sober)・[`examples/builtin_rebind_fn.sober`](../../examples/builtin_rebind_fn.sober)
決定: [syntax.md決定16](../syntax.md)

L-6. GoにあってSoberに無い構文は、文法の段階で拒否する — メソッド宣言（レシーバ）・`var`・`x++`・3節の `for`・`goto` / `fallthrough`・`go` / `chan` / `select`・`&x` / `*p`・`iota`・名前付き戻り値・if / switchの初期化文・型エイリアス・`init()`・旧8進など（一覧はsyntax.md 2節）。
拒否: [`examples/func_neg_method.sober`](../../examples/func_neg_method.sober)・[`examples/lit_leading_zero.sober`](../../examples/lit_leading_zero.sober)
決定: [syntax.md決定11・決定12・決定14・決定15](../syntax.md)
