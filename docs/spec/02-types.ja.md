# 2. 型

日本語

[目次](README.ja.md)

基本型（int・bool・byte・float・string）・`T?`・ゼロ値とリテラル・slice・map・struct・union・型宣言の nominal を扱う。関数型とジェネリクスは 5 章、region を持つ値の寿命は 9 章。

## 2.1 基本型と変換

T-1. 基本型は `int`（64 ビット符号つき整数）・`bool`・`byte`・`float`・`string` の 5 つ。基本型どうしの暗黙の変換は無い — int と bool・int と byte・int と float は交わらず、混ぜた式は型エラーになる。変換は名指しで書く: `int(b)`・`byte(n)`・`float(i)`・`int(f)`（各型の節を参照）。
例: [`examples/bool.sober`](../../examples/bool.sober)・[`examples/float_basic.sober`](../../examples/float_basic.sober)
拒否: [`examples/byte_mix.sober`](../../examples/byte_mix.sober)・[`examples/float_neg_mix.sober`](../../examples/float_neg_mix.sober)
決定: [language.md 23 節・33 節・37 節](../language.md)

## 2.2 bool

T-2. 比較（`==` `!=` `<` `<=` `>` `>=`・`x == nil`）の結果は bool。`if` / `while` / subject の無い `switch` の条件と、`&&` `||` `!` の被演算子は bool に限る。算術とビット演算は int に限る。bool どうしの `==` / `!=` があり、bool の subject の switch は `case true:` / `case false:` で照合する。
例: [`examples/bool.sober`](../../examples/bool.sober)
拒否: [`examples/byte_cond.sober`](../../examples/byte_cond.sober)
決定: [language.md 23 節](../language.md)

T-3. `true` / `false` はキーワードでなく事前宣言の識別子で、再束縛できない。パターンの位置でも束縛でなく定数として読む。`println` は bool を `true` / `false` と綴る。
例: [`examples/bool.sober`](../../examples/bool.sober)
拒否: [`examples/builtin_rebind.sober`](../../examples/builtin_rebind.sober)
決定: [language.md 23 節](../language.md)

## 2.3 int

T-4. シフトの量は int。量が 64 以上なら `<<` は 0、`>>` は 0 か -1（符号）になる。量が負なら panic（終了コード 101）。
例: [`examples/shift.sober`](../../examples/shift.sober)・[`examples/panic_shift.sober`](../../examples/panic_shift.sober)
決定: [language.md 23 節・27 節](../language.md)

## 2.4 byte

T-5. `byte` は格納の単位のスカラーで、値は 0〜255、ゼロ値は 0。比較は `==` `!=` と順序比較（符号なしの値の順）を持つ。算術・ビット演算・シフトは型エラーで、計算は `int(b)` で int へ戻して書く。条件の位置にも置けない（`b != 0` と書く）。
例: [`examples/bytes_packed.sober`](../../examples/bytes_packed.sober)
拒否: [`examples/byte_arith.sober`](../../examples/byte_arith.sober)・[`examples/byte_compound.sober`](../../examples/byte_compound.sober)・[`examples/byte_unary.sober`](../../examples/byte_unary.sober)・[`examples/byte_cond.sober`](../../examples/byte_cond.sober)
決定: [language.md 33 節](../language.md)

T-6. `byte(n)`（int → byte）は値が範囲外なら panic（終了コード 101）。定数が範囲外ならコンパイルエラー。`int(b)` は値を変えない。
例: [`examples/panic_byte.sober`](../../examples/panic_byte.sober)
拒否: [`examples/byte_range.sober`](../../examples/byte_range.sober)・[`examples/byte_range_conv.sober`](../../examples/byte_range_conv.sober)・[`examples/byte_setidx_range.sober`](../../examples/byte_setidx_range.sober)
決定: [language.md 33 節](../language.md)

T-7. 整数リテラル・const・文字リテラルは byte の文脈（代入・引数・戻り・比較の相手・欄・slice リテラルの要素・定数パターン）に置ける。文字リテラル `'a'` は ASCII 限定の型の無い整数定数（値 = 文字コード）で、escape は `\n` `\t` `\r` `\0` `\\` `\'`。ASCII でない文字リテラルは拒否する。
例: [`examples/char_lit.sober`](../../examples/char_lit.sober)
拒否: [`examples/char_lit_nonascii.sober`](../../examples/char_lit_nonascii.sober)
決定: [language.md 33 節](../language.md)

T-8. `println(b)` は byte を 10 進で印字する。byte は文字列補間 `${…}` の穴にも map のキーにも置けない（`${int(b)}` と書く）。
例: [`examples/bytes_packed.sober`](../../examples/bytes_packed.sober)
拒否: [`examples/byte_interp.sober`](../../examples/byte_interp.sober)・[`examples/byte_mapkey.sober`](../../examples/byte_mapkey.sober)
決定: [language.md 33 節](../language.md)

## 2.5 float

T-9. `float` は IEEE 754 binary64 の 1 本だけ。リテラルは 10 進で、小数点か指数（または両方）を持つ（`1.5`・`2.0`・`1e9`・`1.5e-3`）。小数点の両側に数字が要る（`1.` と `.5` は無い）。リテラルは最近接・偶数への丸めで 1 回だけ丸める。丸めて ±Inf になるリテラルは拒否する。
例: [`examples/float_basic.sober`](../../examples/float_basic.sober)・[`examples/float_clinger.sober`](../../examples/float_clinger.sober)
決定: [language.md 37 節](../language.md)

T-10. int と float は交わらない — 整数リテラルも float の文脈には置けない（`x * 2.0` と書く）。変換は `float(i)`（最近接・偶数への丸め）と `int(f)`（0 方向への切り捨て。NaN・±Inf・int の範囲外は panic・終了コード 101）だけ。byte との直接の変換は無い。
例: [`examples/float_toint_panic.sober`](../../examples/float_toint_panic.sober)
拒否: [`examples/float_neg_mix.sober`](../../examples/float_neg_mix.sober)
決定: [language.md 37 節](../language.md)

T-11. float の演算は `+` `-` `*` `/` と単項 `-`（`-0.0` を作る）。`%`・ビット演算・シフトは無い。丸めは IEEE 754 の既定（最近接・偶数）で、ゼロ除算は panic せず IEEE の値（±Inf・NaN）になる。比較は IEEE の比較（NaN は `!=` だけが真・`-0.0 == 0.0`）。最適化は結合の付け替え・FMA の融合をしない（最適化の有無で結果のビットが変わらない）。
例: [`examples/float_basic.sober`](../../examples/float_basic.sober)
決定: [language.md 37 節](../language.md)

T-12. float は map のキーにできない。float を subject にした定数パターンの switch も無い。
拒否: [`examples/float_neg_mapkey.sober`](../../examples/float_neg_mapkey.sober)
決定: [language.md 37 節](../language.md)

## 2.6 string

T-13. `string` は UTF-8 検査済みのバイト列を表す不透明な型。`len`・添字・スライス・`append` は持たない。string 直の演算は `==` `!=` `+` と文字列補間だけ。
例: [`examples/strings_ops.sober`](../../examples/strings_ops.sober)
拒否: [`examples/len_string.sober`](../../examples/len_string.sober)
決定: [language.md 24 節](../language.md)

T-14. 文字列補間 `"…${e}…"` の穴に置けるのは int・string・bool の 3 型（bool は `true` / `false`）。穴の型が型パラメータなら、インスタンスの型引数が 3 型のどれかのときだけ受理する。
例: [`examples/interp.sober`](../../examples/interp.sober)・[`examples/interp_tparam.sober`](../../examples/interp_tparam.sober)
拒否: [`examples/interp_tparam_named.sober`](../../examples/interp_tparam_named.sober)・[`examples/byte_interp.sober`](../../examples/byte_interp.sober)
決定: [language.md 24 節](../language.md)

T-15. string の中身は見方を名指して読む: `bytes(s)` は同じバイト列の imm `[]byte` で、コピーしない。string と `[]byte` は交わらない（相互の代入・引数渡しは不可）。戻し `string(b)` は imm `[]byte` を受け、UTF-8 を検査して `(string, error?)` を返す（壊れていれば `strings.InvalidUtf8{pos}` — pos は最初の不正なシーケンスの先頭）。mut の `[]byte` は `string(freeze(b))` と書く。
例: [`examples/utf8_std.sober`](../../examples/utf8_std.sober)・[`examples/slice.sober`](../../examples/slice.sober)
決定: [language.md 24 節・27 節・33 節](../language.md)

## 2.7 `T?`

T-16. 型 `T` は常に値を持ち、`nil` は `T?` にだけ住める。slice・map・string の空は nil でなく空の値。期待型の無い位置（束縛の右辺の if の腕など）の `nil` は型が決まらないので拒否する。
例: [`examples/opt.sober`](../../examples/opt.sober)
拒否: [`examples/nil_untyped.sober`](../../examples/nil_untyped.sober)
決定: [language.md 15 節](../language.md)

T-17. `T?` の値は絞り込んでから `T` として使う（flow typing）。`if x != nil { … }` の本体で x は `T`。else の無い if の `A && x != nil && B` では `B` と本体で x は `T`。`if x == nil || A { 脱出 }`（then が return / break / continue の 1 文）の後ろと、`if x == nil { 脱出 }` の後ろの文で x は `T`。
例: [`examples/opt.sober`](../../examples/opt.sober)・[`examples/flow_chain.sober`](../../examples/flow_chain.sober)
決定: [language.md 15 節](../language.md)

T-18. `T?` と `T` の値の `==` / `!=` は無い — 絞り込んでから比べる。`println` も `T?` を受けない。
拒否: [`examples/opt_compare.sober`](../../examples/opt_compare.sober)・[`examples/println_opt.sober`](../../examples/println_opt.sober)
決定: [language.md 15 節](../language.md)

T-19. `T?` の単値の subject の switch には `case nil:` の腕を書ける。意味は `if x != nil { switch x { 残りの腕 } } else { nil の腕 }` と同じ。nil の腕は 1 つだけで、名前のパターン（`_`・束縛・const）より前に置き、`nil | …` の選択にはできず、nil の腕のほかに腕か default が要る。
例: [`examples/switch_nil.sober`](../../examples/switch_nil.sober)
拒否: [`examples/switch_nil_twice.sober`](../../examples/switch_nil_twice.sober)・[`examples/switch_nil_catchall.sober`](../../examples/switch_nil_catchall.sober)・[`examples/switch_nil_alt.sober`](../../examples/switch_nil_alt.sober)・[`examples/switch_nil_only.sober`](../../examples/switch_nil_only.sober)
決定: [language.md 15 節](../language.md)

## 2.8 ゼロ値とリテラル

T-20. `T{}` は全部の欄をゼロ値にした値: int・byte は 0、bool は false、float は 0.0、`T?` は nil、slice・map・string は空、struct は欄ごと。union と関数型はゼロ値を持たず、それを（欄として）含む型の `T{}` は拒否する。
例: [`examples/zero.sober`](../../examples/zero.sober)・[`examples/zero_lit_fields.sober`](../../examples/zero_lit_fields.sober)
決定: [language.md 15 節](../language.md)

T-21. struct のリテラルは、位置で全部の欄を書くか、名前つきで書く。名前つきでは一部の欄だけ書いてよく、省いた欄はゼロ値になる（部分リテラル）。ゼロ値を持たない欄は省けない — 省けるようにしたい関数型の欄は `T?` で宣言する。位置と名前の混在・同じ欄の 2 回書きは拒否する。欄の値は欄の宣言の型を持ち、書いた順に評価する。
例: [`examples/partial_lit.sober`](../../examples/partial_lit.sober)・[`examples/composite_order.sober`](../../examples/composite_order.sober)
拒否: [`examples/partial_lit_nozero.sober`](../../examples/partial_lit_nozero.sober)・[`examples/composite_mixed.sober`](../../examples/composite_mixed.sober)・[`examples/composite_dup.sober`](../../examples/composite_dup.sober)・[`examples/composite_field_ty.sober`](../../examples/composite_field_ty.sober)
決定: [language.md 15 節・27 節](../language.md)

T-22. 封の型（欄の型に、宣言した package の非公開の型を持つ struct — 例: `utf8.View`・`json.Doc`）は、宣言した package の外では欄つきのリテラル（部分・全部とも）で作れない。ゼロ値 `T{}` は作れる。
拒否: [`examples/utf8_view_neg.sober`](../../examples/utf8_view_neg.sober)・[`examples/json_doc_forge.sober`](../../examples/json_doc_forge.sober)
決定: [language.md 15 節](../language.md)

T-23. 同一性の型（std/task の `Scope`・`Handle`・`Sender`・`Receiver`・`Pool`、std/io の `File` など — 作る関数だけが本物を作る型）のゼロ値は std の外で作れない。型そのもののリテラル `T{}` と、同一性の型を（欄・型引数を通して推移的に）持つ欄を省いたリテラルを拒否する。`T?` の欄・slice / map の欄は省ける。
拒否: [`examples/identity_neg_tx.sober`](../../examples/identity_neg_tx.sober)・[`examples/identity_neg_field.sober`](../../examples/identity_neg_field.sober)・[`examples/identity_neg_nested.sober`](../../examples/identity_neg_nested.sober)・[`examples/identity_neg_generic.sober`](../../examples/identity_neg_generic.sober)
決定: [language.md 15 節](../language.md)

## 2.9 slice

T-24. `[]T` は imm（不変）の slice、`mut []T` は可変の slice。リテラル `[]T{…}` は imm で作り、可変で作るなら `mut []T{…}` と前置する。imm の slice（や map）の要素へは書けない — 束縛が `mut` でも値が imm なら拒否する。
例: [`examples/slice.sober`](../../examples/slice.sober)
拒否: [`examples/imm_write.sober`](../../examples/imm_write.sober)
決定: [language.md 22 節](../language.md)

T-25. 添字 `xs[i]` の範囲外は panic（終了コード 101）。
例: [`examples/panic_index.sober`](../../examples/panic_index.sober)
決定: [language.md 27 節](../language.md)

T-26. `freeze(x)` は可変のコンテナを不変に（`mut []T → []T`・`mut map[K]V → map[K]V`）、`clone(x)` は浅い写しを可変で作る。期待型が imm のコンテナの位置（実引数・欄・要素・return など）に mut のコンテナを置くと `freeze` と同じ。束縛（期待型が無い）では起こさない。`clone` はスカラーや string を受けない。
例: [`examples/slice.sober`](../../examples/slice.sober)・[`examples/implicit_freeze.sober`](../../examples/implicit_freeze.sober)・[`examples/clone_std.sober`](../../examples/clone_std.sober)
拒否: [`examples/clone_neg_scalar.sober`](../../examples/clone_neg_scalar.sober)・[`examples/clone_neg_string.sober`](../../examples/clone_neg_string.sober)
決定: [language.md 22 節](../language.md)

## 2.10 map

T-27. map のキーは int・string・named int（下地の int として比べる）。byte・float は置けない。string のキーはバイト列の等値で比べる。
例: [`examples/map.sober`](../../examples/map.sober)・[`examples/map_str.sober`](../../examples/map_str.sober)
拒否: [`examples/byte_mapkey.sober`](../../examples/byte_mapkey.sober)・[`examples/float_neg_mapkey.sober`](../../examples/float_neg_mapkey.sober)
決定: [language.md 22 節・32 節](../language.md)

T-28. 読み `m[k]` の型は `V?` — キーが無ければ nil。V が `T?` なら `T??` になり、外側の nil はキーの不在・内側の nil は値の nil。`map[K]V` は imm、`mut map[K]V` が可変（slice と同じ — T-24）。`delete(m, k)` で消す。
例: [`examples/map.sober`](../../examples/map.sober)
決定: [language.md 22 節](../language.md)

T-29. map の値（ヘッダ）は値として写る — コピーした旧い map は、元の map が成長した後も旧い中身を見る。
例: [`examples/map_index.sober`](../../examples/map_index.sober)・[`examples/map_order.sober`](../../examples/map_order.sober)
決定: [language.md 22 節](../language.md)

T-30. 列挙の順は初回挿入の順で決定的。delete したキーを再び挿入すると元の位置に戻る（末尾へは移らない）。`keys(m)` は呼んだ時点のキー列の写しを imm slice で返し、以後の変更は列に影響しない。`for k <- m` は `keys(m)` の上を回る。出力は列挙順に依るだけでハッシュの種に依らない。
例: [`examples/map_keys.sober`](../../examples/map_keys.sober)・[`examples/map_order.sober`](../../examples/map_order.sober)
決定: [language.md 22 節](../language.md)

## 2.11 struct と union

T-31. union は名前つきの閉じた和型で、`type U union { A { 欄… }; B {} }` の宣言ブロックで宣言する（匿名の union は無い）。variant の名前は package のトップレベルの名前の中で一意（別の union の variant・error ラベル・他の宣言と重ならない）。
例: [`examples/switch_nested_seq.sober`](../../examples/switch_nested_seq.sober)・[`examples/generic_union.sober`](../../examples/generic_union.sober)
拒否: [`examples/variant_dup.sober`](../../examples/variant_dup.sober)・[`examples/variant_label_dup.sober`](../../examples/variant_label_dup.sober)
決定: [language.md 1 節・13 節](../language.md)

T-32. union の値は型パターンの switch（`case A{x}: …`）で分解する。switch は全 variant を（入れ子の欄まで）覆わなければならない — 覆わず default も `_` も無ければ拒否する。入れ子のパターンは上から順に最初に一致した腕を選び、前の腕に覆われる腕は拒否する。
例: [`examples/switch_nested_seq.sober`](../../examples/switch_nested_seq.sober)
拒否: [`examples/switch_nonexh_union.sober`](../../examples/switch_nonexh_union.sober)・[`examples/switch_nested_uncovered.sober`](../../examples/switch_nested_uncovered.sober)
決定: [language.md 1 節・13 節](../language.md)

T-33. 型は自分自身を含められない — 直接にも、`[]T`・`map[K]V`・`T?`・他の型宣言を通しても。木は平らな表と番号で持つ。
拒否: [`examples/type_recursive.sober`](../../examples/type_recursive.sober)・[`examples/type_recursive_mutual.sober`](../../examples/type_recursive_mutual.sober)
決定: [language.md 1 節](../language.md)

## 2.12 型宣言は nominal

T-34. 型宣言が作る型（struct・union・error ラベル・名前つき関数型・named scalar）は nominal — 形が同じでも別の型宣言どうしは互換でない。代入できるのは、同じ型宣言どうしか、片方が名前の無い型（ラムダ・名前つきでない関数型の値・トップレベルの関数など）のとき。
例: [`examples/named_scalar.sober`](../../examples/named_scalar.sober)
拒否: [`examples/nominal_struct_arg.sober`](../../examples/nominal_struct_arg.sober)・[`examples/nominal_struct_eq.sober`](../../examples/nominal_struct_eq.sober)・[`examples/nominal_struct_slice.sober`](../../examples/nominal_struct_slice.sober)・[`examples/nominal_fn.sober`](../../examples/nominal_fn.sober)
決定: [language.md 32 節](../language.md)

T-35. named scalar `type R int` / `type F bool` は下地 int / bool の値を区別する型。下地は int と bool に限り、型パラメータは持たない。演算は同じ named どうしの `==` / `!=` だけ — 算術・ビット演算・順序比較・論理演算・条件の位置には使えず、要るときは `int(x)` / `bool(x)` で下地へ戻す。
例: [`examples/named_scalar.sober`](../../examples/named_scalar.sober)
拒否: [`examples/named_scalar_arith.sober`](../../examples/named_scalar_arith.sober)・[`examples/named_scalar_order.sober`](../../examples/named_scalar_order.sober)・[`examples/named_scalar_cond.sober`](../../examples/named_scalar_cond.sober)・[`examples/named_scalar_under.sober`](../../examples/named_scalar_under.sober)
決定: [language.md 32 節](../language.md)

T-36. 整数リテラル・const は named int の文脈に、`true` / `false` は named bool の文脈に置ける（`n == -1` と書ける）。明示の変換 `X(e)` は e が下地の型か同じ下地の別の named のときだけで、値を変えない。named と下地・別の named どうしの暗黙の変換は無い。型引数の中でも区別する（`B[Meters]` と `B[int]` は別の型）。
例: [`examples/named_scalar.sober`](../../examples/named_scalar.sober)・[`examples/named_scalar_ifarm.sober`](../../examples/named_scalar_ifarm.sober)
拒否: [`examples/named_scalar_mix.sober`](../../examples/named_scalar_mix.sober)・[`examples/named_scalar_targ.sober`](../../examples/named_scalar_targ.sober)・[`examples/named_scalar_targ_union.sober`](../../examples/named_scalar_targ_union.sober)
決定: [language.md 32 節](../language.md)
