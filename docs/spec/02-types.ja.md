# 2. 型

日本語

[目次](README.ja.md)

基本型（int・bool・byte・float・string）・`T?`・ゼロ値とリテラル・slice・map・struct・union・型宣言のnominalを扱う。関数型とジェネリクスは5章、regionを持つ値の寿命は9章。

## 2.1 基本型と変換

T-1. 基本型は `int`（64ビット符号つき整数）・`bool`・`byte`・`float`・`string` の5つ。基本型どうしの暗黙の変換は無い — intとbool・intとbyte・intとfloatは交わらず、混ぜた式は型エラーになる。変換は明示して書く: `int(b)`・`byte(n)`・`float(i)`・`int(f)`（各型の節を参照）。
例: [`examples/bool.sober`](../../examples/bool.sober)・[`examples/float_basic.sober`](../../examples/float_basic.sober)
拒否: [`examples/byte_mix.sober`](../../examples/byte_mix.sober)・[`examples/float_neg_mix.sober`](../../examples/float_neg_mix.sober)
決定: [language.md 23節・33節・37節](../language.md)

## 2.2 bool

T-2. 比較（`==` `!=` `<` `<=` `>` `>=`・`x == nil`）の結果はbool。`if` / `while` / subjectの無い `switch` の条件と、`&&` `||` `!` の被演算子はboolに限る。算術とビット演算はintに限る。boolどうしの `==` / `!=` があり、boolのsubjectのswitchは `case true:` / `case false:` で照合する。
例: [`examples/bool.sober`](../../examples/bool.sober)
拒否: [`examples/byte_cond.sober`](../../examples/byte_cond.sober)
決定: [language.md 23節](../language.md)

T-3. `true` / `false` はキーワードでなく事前宣言の識別子で、再束縛できない。パターンの位置でも束縛でなく定数として読む。`println` はboolを `true` / `false` と綴る。
例: [`examples/bool.sober`](../../examples/bool.sober)
拒否: [`examples/builtin_rebind.sober`](../../examples/builtin_rebind.sober)
決定: [language.md 23節](../language.md)

## 2.3 int

T-4. シフトの量はint。量が64以上なら `<<` は0、`>>` は0か -1（符号）になる。量が負ならpanic（終了コード101）。
例: [`examples/shift.sober`](../../examples/shift.sober)・[`examples/panic_shift.sober`](../../examples/panic_shift.sober)
決定: [language.md 23節・27節](../language.md)

## 2.4 byte

T-5. `byte` は格納の単位のスカラーで、値は0〜255、ゼロ値は0。比較は `==` `!=` と順序比較（符号なしの値の順）を持つ。算術・ビット演算・シフトは型エラーで、計算は `int(b)` でintへ戻して書く。条件の位置にも置けない（`b != 0` と書く）。
例: [`examples/bytes_packed.sober`](../../examples/bytes_packed.sober)
拒否: [`examples/byte_arith.sober`](../../examples/byte_arith.sober)・[`examples/byte_compound.sober`](../../examples/byte_compound.sober)・[`examples/byte_unary.sober`](../../examples/byte_unary.sober)・[`examples/byte_cond.sober`](../../examples/byte_cond.sober)
決定: [language.md 33節](../language.md)

T-6. `byte(n)`（int → byte）は値が範囲外ならpanic（終了コード101）。定数が範囲外ならコンパイルエラー。`int(b)` は値を変えない。
例: [`examples/panic_byte.sober`](../../examples/panic_byte.sober)
拒否: [`examples/byte_range.sober`](../../examples/byte_range.sober)・[`examples/byte_range_conv.sober`](../../examples/byte_range_conv.sober)・[`examples/byte_setidx_range.sober`](../../examples/byte_setidx_range.sober)
決定: [language.md 33節](../language.md)

T-7. 整数リテラル・const・文字リテラルはbyteの文脈（代入・引数・戻り・比較の相手・フィールド・sliceリテラルの要素・定数パターン）に置ける。文字リテラル `'a'` はASCII限定の型の無い整数定数（値 = 文字コード）で、escapeは `\n` `\t` `\r` `\0` `\\` `\'`。ASCIIでない文字リテラルは拒否する。
例: [`examples/char_lit.sober`](../../examples/char_lit.sober)
拒否: [`examples/char_lit_nonascii.sober`](../../examples/char_lit_nonascii.sober)
決定: [language.md 33節](../language.md)

T-8. `println(b)` はbyteを10進で印字する。byteは文字列補間 `${…}` の穴にもmapのキーにも置けない（`${int(b)}` と書く）。
例: [`examples/bytes_packed.sober`](../../examples/bytes_packed.sober)
拒否: [`examples/byte_interp.sober`](../../examples/byte_interp.sober)・[`examples/byte_mapkey.sober`](../../examples/byte_mapkey.sober)
決定: [language.md 33節](../language.md)

## 2.5 float

T-9. `float` はIEEE 754 binary64の1本だけ。リテラルは10進で、小数点か指数（または両方）を持つ（`1.5`・`2.0`・`1e9`・`1.5e-3`）。小数点の両側に数字が要る（`1.` と `.5` は無い）。リテラルは最近接・偶数への丸めで1回だけ丸める。丸めて ±Infになるリテラルは拒否する。
例: [`examples/float_basic.sober`](../../examples/float_basic.sober)・[`examples/float_clinger.sober`](../../examples/float_clinger.sober)
拒否: [`examples/float_neg_range.sober`](../../examples/float_neg_range.sober)
決定: [language.md 37節](../language.md)

T-10. intとfloatは交わらない — 整数リテラルもfloatの文脈には置けない（`x * 2.0` と書く）。変換は `float(i)`（最近接・偶数への丸め）と `int(f)`（0方向への切り捨て。NaN・±Inf・intの範囲外はpanic・終了コード101）だけ。byteとの直接の変換は無い。
例: [`examples/float_toint_panic.sober`](../../examples/float_toint_panic.sober)
拒否: [`examples/float_neg_mix.sober`](../../examples/float_neg_mix.sober)
決定: [language.md 37節](../language.md)

T-11. floatの演算は `+` `-` `*` `/` と単項 `-`（`-0.0` を作る）。`%`・ビット演算・シフトは無い。丸めはIEEE 754の既定（最近接・偶数）で、ゼロ除算はpanicせずIEEEの値（±Inf・NaN）になる。比較はIEEEの比較（NaNは `!=` だけが真・`-0.0 == 0.0`）。最適化は結合の付け替え・FMAの融合をしない（最適化の有無で結果のビットが変わらない）。
例: [`examples/float_basic.sober`](../../examples/float_basic.sober)
決定: [language.md 37節](../language.md)

T-12. floatはmapのキーにできない。floatをsubjectにした定数パターンのswitchも無い。
拒否: [`examples/float_neg_mapkey.sober`](../../examples/float_neg_mapkey.sober)
決定: [language.md 37節](../language.md)

## 2.6 string

T-13. `string` はUTF-8検査済みのバイト列を表す不透明な型。`len`・添字・スライス・`append` は持たない。string直の演算は `==` `!=` `+` と文字列補間だけ。
例: [`examples/strings_ops.sober`](../../examples/strings_ops.sober)
拒否: [`examples/len_string.sober`](../../examples/len_string.sober)
決定: [language.md 24節・37節](../language.md)

T-14. 文字列補間 `"…${e}…"` の穴に置けるのはint・float・string・boolの4型（floatは `println` と同じ最短の往復表現・boolは `true` / `false`）。穴の型が型パラメータなら、インスタンスの型引数が4型のどれかのときだけ受理する。
例: [`examples/interp.sober`](../../examples/interp.sober)・[`examples/interp_tparam.sober`](../../examples/interp_tparam.sober)・[`examples/float_interp.sober`](../../examples/float_interp.sober)
拒否: [`examples/interp_tparam_named.sober`](../../examples/interp_tparam_named.sober)・[`examples/byte_interp.sober`](../../examples/byte_interp.sober)
決定: [language.md 24節](../language.md)

T-15. stringの中身は見方を明示して読む: `bytes(s)` は同じバイト列のimm `[]byte` で、コピーしない。stringと `[]byte` は交わらない（相互の代入・引数渡しは不可）。戻し `string(b)` はimm `[]byte` を受け、UTF-8を検査して `(string, error?)` を返す（壊れていれば `strings.BadUtf8{pos}` — posは最初の不正なシーケンスの先頭）。mutの `[]byte` は `string(freeze(b))` と書く。
例: [`examples/utf8_std.sober`](../../examples/utf8_std.sober)・[`examples/slice.sober`](../../examples/slice.sober)
決定: [language.md 24節・27節・33節](../language.md)

## 2.7 `T?`

T-16. 型 `T` は常に値を持ち、`nil` は `T?` にだけ住める。slice・map・stringの空はnilでなく空の値。期待型の無い位置のif / switchの式で、分岐のどれかが `nil` で終わり他の分岐から型 `T` が読めるなら、式の型は `T?`（Tが `T?` ならそのまま・errorのラベルの分岐は `error?`）。分岐の型が `T` と `T?` に分かれるときも式の型は `T?`。型の読める分岐が無い位置の `nil` は型が決まらないので拒否する。
例: [`examples/opt.sober`](../../examples/opt.sober)・[`examples/nil_sibling.sober`](../../examples/nil_sibling.sober)・[`examples/nil_sibling_label.sober`](../../examples/nil_sibling_label.sober)・[`examples/opt_arm_join.sober`](../../examples/opt_arm_join.sober)
拒否: [`examples/nil_untyped.sober`](../../examples/nil_untyped.sober)
決定: [language.md 15節](../language.md)

T-17. `T?` の値は絞り込んでから `T` として使う（flow typing）。`if x != nil { … }` の本体でxは `T`。`A && x != nil && B` の `B` と `A || x == nil || B` の `B` でxは `T`（式の位置を問わない）。`if A && x != nil && B { … }` の本体と、`if A || x == nil || B { … } else { … }` のelseの分岐でxは `T`（elseの有無を問わない）。`if x == nil || A { 脱出 }`（thenがreturn / break / continueの1文）の後ろと、`if x == nil { 脱出 }` の後ろの文でxは `T`。`while A && x != nil && B { … }` の本体でxは `T`（周の頭で毎回絞り直す）。絞り込んだ領域で `mut` のxに書く文（`x = e`・`x op= e`・`f(mut x)`・`x.f = e`）の後ろではxは `T?` に戻る — 名前への代入の右辺は `T` のまま読む。書きがループの本体か式の位置（条件・値の中）にあれば、その文の頭から `T?`。`&&` の連鎖で判定より後ろの項がxに書くなら本体でxは `T?`。
例: [`examples/opt.sober`](../../examples/opt.sober)・[`examples/flow_chain.sober`](../../examples/flow_chain.sober)・[`examples/flow_body.sober`](../../examples/flow_body.sober)・[`examples/narrow_reassign.sober`](../../examples/narrow_reassign.sober)
拒否: [`examples/narrow_assign.sober`](../../examples/narrow_assign.sober)・[`examples/narrow_reassign_loop_neg.sober`](../../examples/narrow_reassign_loop_neg.sober)・[`examples/narrow_path_neg.sober`](../../examples/narrow_path_neg.sober)
決定: [language.md 15節](../language.md)

T-18. `T?` と `T` の値の `==` / `!=` は無い — 絞り込んでから比べる。`println` も `T?` を受けない。関数値のoption `F?` は絞り込んでから呼ぶ（フィールド・mapの読み・`[]F?` の要素を直に呼ぶ形を含む）。
例: [`examples/optfn_call.sober`](../../examples/optfn_call.sober)
拒否: [`examples/opt_compare.sober`](../../examples/opt_compare.sober)・[`examples/println_opt.sober`](../../examples/println_opt.sober)・[`examples/optfn_call_neg.sober`](../../examples/optfn_call_neg.sober)
決定: [language.md 15節](../language.md)

T-19. `T?` の単値のsubjectのswitchには `case nil:` の分岐を書ける。意味は `if x != nil { switch x { 残りの分岐 } } else { nil の分岐 }` と同じ。nilの分岐は1つだけで、名前のパターン（`_`・束縛・const）より前に置き、`nil | …` の選択にはできず、nilの分岐のほかに分岐かdefaultが要る。
例: [`examples/switch_nil.sober`](../../examples/switch_nil.sober)
拒否: [`examples/switch_nil_twice.sober`](../../examples/switch_nil_twice.sober)・[`examples/switch_nil_catchall.sober`](../../examples/switch_nil_catchall.sober)・[`examples/switch_nil_alt.sober`](../../examples/switch_nil_alt.sober)・[`examples/switch_nil_only.sober`](../../examples/switch_nil_only.sober)
決定: [language.md 15節](../language.md)

## 2.8 ゼロ値とリテラル

T-20. `T{}` は全部のフィールドをゼロ値にした値: int・byteは0、boolはfalse、floatは0.0、`T?` はnil、slice・map・stringは空、structはフィールドごと。unionと関数型はゼロ値を持たず、それを（フィールドとして）含む型の `T{}` は拒否する。
例: [`examples/zero.sober`](../../examples/zero.sober)・[`examples/zero_lit_fields.sober`](../../examples/zero_lit_fields.sober)
決定: [language.md 15節](../language.md)

T-21. structのリテラルは、位置で全部のフィールドを書くか、名前つきで書く。名前つきでは一部のフィールドだけ書いてよく、省いたフィールドはゼロ値になる（部分リテラル）。ゼロ値を持たないフィールドは省けない — 省けるようにしたい関数型のフィールドは `T?` で宣言する。位置と名前の混在・同じフィールドの2回書きは拒否する。フィールドの値はフィールドの宣言の型を持ち、書いた順に評価する。
例: [`examples/partial_lit.sober`](../../examples/partial_lit.sober)・[`examples/composite_order.sober`](../../examples/composite_order.sober)
拒否: [`examples/partial_lit_nozero.sober`](../../examples/partial_lit_nozero.sober)・[`examples/composite_mixed.sober`](../../examples/composite_mixed.sober)・[`examples/composite_dup.sober`](../../examples/composite_dup.sober)・[`examples/composite_field_ty.sober`](../../examples/composite_field_ty.sober)
決定: [language.md 15節・27節](../language.md)

T-22. 封の型（フィールドの型に、宣言したpackageの非公開の型を持つstruct — 例: `utf8.View`・`json.Doc`）は、宣言したpackageの外ではフィールドつきのリテラル（部分・全部とも）で作れない。ゼロ値 `T{}` は作れる。
拒否: [`examples/utf8_view_neg.sober`](../../examples/utf8_view_neg.sober)・[`examples/json_doc_forge.sober`](../../examples/json_doc_forge.sober)
決定: [language.md 15節](../language.md)

T-23. 同一性の型（std/taskの `Scope`・`Handle`・`Sender`・`Receiver`・`Pool`・`Local`、std/ioの `File`・`Root`、std/netの `Listener`・`Conn`、std/tlsの `Conn` — 作る関数だけが本物を作る型）のゼロ値はstdの外で作れない。型そのもののリテラル `T{}` と、同一性の型を（フィールド・型引数を通して推移的に）持つフィールドを省いたリテラルを拒否する。`T?` のフィールド・slice / mapのフィールドは省ける。
拒否: [`examples/identity_neg_tx.sober`](../../examples/identity_neg_tx.sober)・[`examples/identity_neg_field.sober`](../../examples/identity_neg_field.sober)・[`examples/identity_neg_nested.sober`](../../examples/identity_neg_nested.sober)・[`examples/identity_neg_generic.sober`](../../examples/identity_neg_generic.sober)・[`examples/identity_neg_root.sober`](../../examples/identity_neg_root.sober)・[`examples/identity_neg_conn.sober`](../../examples/identity_neg_conn.sober)・[`examples/identity_neg_listener.sober`](../../examples/identity_neg_listener.sober)・[`examples/identity_neg_tls_field.sober`](../../examples/identity_neg_tls_field.sober)
決定: [language.md 15節](../language.md)

## 2.9 slice

T-24. `[]T` はimm（不変）のslice、`mut []T` は可変のslice。リテラル `[]T{…}` はimmで作り、可変で作るなら `mut []T{…}` と前置する。immのslice（やmap）の要素へは書けない — 束縛が `mut` でも値がimmなら拒否する。
例: [`examples/slice.sober`](../../examples/slice.sober)
拒否: [`examples/imm_write.sober`](../../examples/imm_write.sober)
決定: [language.md 22節](../language.md)

T-25. 添字 `xs[i]` の範囲外はpanic（終了コード101）。
例: [`examples/panic_index.sober`](../../examples/panic_index.sober)
決定: [language.md 27節](../language.md)

T-26. `freeze(x)` は可変のコンテナを不変に（`mut []T → []T`・`mut map[K]V → map[K]V`）、`clone(x)` は浅いコピーを可変で作る。期待型がimmのコンテナの位置（実引数・フィールド・要素・returnなど）にmutのコンテナを置くと `freeze` と同じ。束縛（期待型が無い）では起こさない。点になるのは局所の束縛を根に持つパス（`x`・`x.f`・`x[i]`）と `clone(x)` だけで、それ以外のmutのコンテナ（呼び出しの結果など）をimmの位置に置くと拒否。`clone` はスカラーやstringを受けない。
例: [`examples/slice.sober`](../../examples/slice.sober)・[`examples/implicit_freeze.sober`](../../examples/implicit_freeze.sober)・[`examples/clone_std.sober`](../../examples/clone_std.sober)
拒否: [`examples/clone_neg_scalar.sober`](../../examples/clone_neg_scalar.sober)・[`examples/clone_neg_string.sober`](../../examples/clone_neg_string.sober)
決定: [language.md 22節](../language.md)

## 2.10 map

T-27. mapのキーはint・string・named int（下地のintとして比べる）。byte・floatは置けない。stringのキーはバイト列の等値で比べる。
例: [`examples/map.sober`](../../examples/map.sober)・[`examples/map_str.sober`](../../examples/map_str.sober)
拒否: [`examples/byte_mapkey.sober`](../../examples/byte_mapkey.sober)・[`examples/float_neg_mapkey.sober`](../../examples/float_neg_mapkey.sober)
決定: [language.md 22節・32節](../language.md)

T-28. 読み `m[k]` の型は `V?` — キーが無ければnil。Vが `T?` なら `T??` になり、外側のnilはキーの不在・内側のnilは値のnil。`map[K]V` はimm、`mut map[K]V` が可変（sliceと同じ — T-24）。`delete(m, k)` で消す。
例: [`examples/map.sober`](../../examples/map.sober)
決定: [language.md 22節](../language.md)

T-29. mapの値（ヘッダ）は値としてコピーされる — コピーした旧いmapは、元のmapが成長した後も旧い中身を見る。
例: [`examples/map_index.sober`](../../examples/map_index.sober)・[`examples/map_order.sober`](../../examples/map_order.sober)
決定: [language.md 22節](../language.md)

T-30. 列挙の順は初回挿入の順で決定的。deleteしたキーを再び挿入すると元の位置に戻る（末尾へは移らない）。`keys(m)` は呼んだ時点のキー列のコピーをimm sliceで返し、以後の変更は列に影響しない。`for k <- m` は `keys(m)` の上を回る。出力は列挙順に依るだけでハッシュのシードに依らない。
例: [`examples/map_keys.sober`](../../examples/map_keys.sober)・[`examples/map_order.sober`](../../examples/map_order.sober)
決定: [language.md 22節](../language.md)

## 2.11 structとunion

T-31. unionは名前つきの閉じた和型で、`type U union { A { フィールド… }; B {} }` の宣言ブロックで宣言する（匿名のunionは無い）。variantの名前はpackageのトップレベルの名前の中で一意（別のunionのvariant・errorラベル・他の宣言と重ならない）。
例: [`examples/switch_nested_seq.sober`](../../examples/switch_nested_seq.sober)・[`examples/generic_union.sober`](../../examples/generic_union.sober)
拒否: [`examples/variant_dup.sober`](../../examples/variant_dup.sober)・[`examples/variant_label_dup.sober`](../../examples/variant_label_dup.sober)
決定: [language.md 1節・13節](../language.md)

T-32. unionの値は型パターンのswitch（`case A{x}: …`）で分解する。switchは全variantを（入れ子のフィールドまで）覆わなければならない — 覆わずdefaultも `_` も無ければ拒否する。入れ子のパターンは上から順に最初に一致した分岐を選び、前の分岐に覆われる分岐は拒否する。
例: [`examples/switch_nested_seq.sober`](../../examples/switch_nested_seq.sober)
拒否: [`examples/switch_nonexh_union.sober`](../../examples/switch_nonexh_union.sober)・[`examples/switch_nested_uncovered.sober`](../../examples/switch_nested_uncovered.sober)
決定: [language.md 1節・13節](../language.md)

T-33. 型宣言は自分自身を（他の型宣言を通しても）含めてよい — ただし自分に戻るどの閉路も `[]T` か `map[K]V` の要素の位置か、`T?` の中身か、関数型の仮引数・結果を通る（値の大きさが有限）。互いに参照し合う型宣言の組（強連結成分）は1つの再帰型で、組の成分の順は宣言順（packageのファイルの順 → ファイルの中の型宣言の順）。値はimmの木 — 下から組み、フィールドの読みとswitchで1階層ずつ開く。関数型の値（クロージャ）は作成点で組み、呼び出しで1階層開く。`T?` のフィールドの代入は新しい値を作る（元の木は変わらない）。拒否するのは、値で自分を含む閉路（直接・`[N]T`・値のフィールドだけを通る — 大きさが無限）・組の中の参照が型引数を変える形（`Nest[[]T]` — 型が正則でない）。
例: [`examples/type_recursive.sober`](../../examples/type_recursive.sober)・[`examples/type_recursive_tree.sober`](../../examples/type_recursive_tree.sober)・[`examples/type_recursive_mutual.sober`](../../examples/type_recursive_mutual.sober)・[`examples/type_recursive_group.sober`](../../examples/type_recursive_group.sober)・[`examples/type_recursive_generic.sober`](../../examples/type_recursive_generic.sober)・[`examples/type_recursive_state.sober`](../../examples/type_recursive_state.sober)・[`examples/type_recursive_mw.sober`](../../examples/type_recursive_mw.sober)・[`examples/type_recursive_gen.sober`](../../examples/type_recursive_gen.sober)・[`examples/type_recursive_fncycle.sober`](../../examples/type_recursive_fncycle.sober)・[`examples/type_recursive_opt.sober`](../../examples/type_recursive_opt.sober)・[`examples/type_recursive_opt_mutual.sober`](../../examples/type_recursive_opt_mutual.sober)
拒否: [`examples/type_recursive_neg_value.sober`](../../examples/type_recursive_neg_value.sober)・[`examples/type_recursive_neg_targs.sober`](../../examples/type_recursive_neg_targs.sober)
決定: [language.md 1節](../language.md)

## 2.12 型宣言はnominal

T-34. 型宣言が作る型（struct・union・errorラベル・名前つき関数型・named scalar）はnominal — 形が同じでも別の型宣言どうしは互換でない。代入できるのは、同じ型宣言どうしか、片方が名前の無い型（ラムダ・名前つきでない関数型の値・トップレベルの関数など）のとき。
例: [`examples/named_scalar.sober`](../../examples/named_scalar.sober)
拒否: [`examples/nominal_struct_arg.sober`](../../examples/nominal_struct_arg.sober)・[`examples/nominal_struct_eq.sober`](../../examples/nominal_struct_eq.sober)・[`examples/nominal_struct_slice.sober`](../../examples/nominal_struct_slice.sober)・[`examples/nominal_fn.sober`](../../examples/nominal_fn.sober)
決定: [language.md 32節](../language.md)

T-35. named scalar `type R int` / `type F bool` は下地int / boolの値を区別する型。下地はintとboolに限り（宣言の位置で検査する — 使わない宣言も拒否）、型パラメータは持たない。演算は同じnamedどうしの `==` / `!=` だけ — 算術・ビット演算・順序比較・論理演算・条件の位置には使えず、要るときは `int(x)` / `bool(x)` で下地へ戻す。
例: [`examples/named_scalar.sober`](../../examples/named_scalar.sober)
拒否: [`examples/named_scalar_arith.sober`](../../examples/named_scalar_arith.sober)・[`examples/named_scalar_order.sober`](../../examples/named_scalar_order.sober)・[`examples/named_scalar_cond.sober`](../../examples/named_scalar_cond.sober)・[`examples/named_scalar_under.sober`](../../examples/named_scalar_under.sober)・[`examples/defined_neg_struct.sober`](../../examples/defined_neg_struct.sober)
決定: [language.md 32節](../language.md)

T-36. 整数リテラル・型の無いconstはnamed intの文脈に、`true` / `false` はnamed boolの文脈に置ける（`n == -1` と書ける）。明示の変換 `X(e)` はeが下地の型か同じ下地の別のnamedのときだけで、値を変えない。namedと下地・別のnamedどうしの暗黙の変換は無い。型引数の中でも区別する（`B[Meters]` と `B[int]` は別の型）。値の式が下地intのnamed scalarへの変換 `T(定数式)` のconst（`const OK = Status(200)`）は型Tを持つ型つきのconstで、Tの値として扱う（intの文脈には置けない）。変換はconstの値の式の一番外にだけ置け、型つきのconstは定数式の中で参照できない。
例: [`examples/named_scalar.sober`](../../examples/named_scalar.sober)・[`examples/named_scalar_ifarm.sober`](../../examples/named_scalar_ifarm.sober)・[`examples/named_scalar_typed_const.sober`](../../examples/named_scalar_typed_const.sober)
拒否: [`examples/named_scalar_mix.sober`](../../examples/named_scalar_mix.sober)・[`examples/named_scalar_targ.sober`](../../examples/named_scalar_targ.sober)・[`examples/named_scalar_targ_union.sober`](../../examples/named_scalar_targ_union.sober)・[`examples/named_scalar_typed_const_neg_int.sober`](../../examples/named_scalar_typed_const_neg_int.sober)・[`examples/named_scalar_typed_const_neg_arith.sober`](../../examples/named_scalar_typed_const_neg_arith.sober)・[`examples/named_scalar_typed_const_neg_constexpr.sober`](../../examples/named_scalar_typed_const_neg_constexpr.sober)
決定: [language.md 32節](../language.md)

T-37. 型の別名 `type A = B` のAはBと同じ型の別の名前で、どこでも区別しない（代入・nominalの照合・型引数の中）。Bは型宣言の名前（`N` か `ref.N` — struct・union・名前つき関数型・named scalar・別の別名）に限る — 組み込みの型・合成の型・型引数つきの名前・error / panicラベルは置けない。総称の宣言の別名は使う側で型引数を書く（`type B = Box` の `B[int]`）。別名は型パラメータを持たず、トップレベルだけに書ける。別名の別名は実体まで辿り、循環は拒否する。別名の名前はトップレベルの型の名前の1つ（ローカル束縛に使えず、同じpackageの名前と重ならない）。別名は宣言のpackageを変えない — フィールドの書き・封の型・同一性の型・unionのvariantの名前は実体のpackageの規則のまま。
例: [`examples/alias.sober`](../../examples/alias.sober)・[`examples/alias_expanded.sober`](../../examples/alias_expanded.sober)
拒否: [`examples/alias_neg_cycle.sober`](../../examples/alias_neg_cycle.sober)・[`examples/alias_neg_self.sober`](../../examples/alias_neg_self.sober)・[`examples/alias_neg_undefined.sober`](../../examples/alias_neg_undefined.sober)・[`examples/alias_neg_builtin.sober`](../../examples/alias_neg_builtin.sober)・[`examples/alias_neg_compound.sober`](../../examples/alias_neg_compound.sober)・[`examples/alias_neg_targs.sober`](../../examples/alias_neg_targs.sober)・[`examples/alias_neg_tparams.sober`](../../examples/alias_neg_tparams.sober)・[`examples/alias_neg_label.sober`](../../examples/alias_neg_label.sober)・[`examples/alias_neg_shadow.sober`](../../examples/alias_neg_shadow.sober)・[`examples/alias_neg_dup.sober`](../../examples/alias_neg_dup.sober)・[`examples/alias_neg_identity.sober`](../../examples/alias_neg_identity.sober)
決定: [language.md 32節](../language.md)・[syntax.md決定15](../syntax.md)
