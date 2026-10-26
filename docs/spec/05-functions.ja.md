# 5. 関数

日本語

[目次](README.ja.md)

関数は自由関数だけ（メソッドは無い）。振る舞いを渡すときは関数型の仮引数か、関数型の欄を持つ struct（辞書）を明示して渡す。

## 5.1 関数とラムダ

F-1. メソッド（レシーバつきの func）・interface・型クラスは無い。ドット記法の代わりに `|>`、ディスパッチの代わりに関数型の欄を持つ struct（辞書）を明示して渡す。
例: [`examples/fnvalue.sober`](../../examples/fnvalue.sober)・[`examples/constdict.sober`](../../examples/constdict.sober)
拒否: [`examples/func_neg_method.sober`](../../examples/func_neg_method.sober)
決定: [language.md 3 節](../language.md)

F-2. 結果を持つ func の本体は `return` で値を返す — 本体の末尾の式は戻り値にならない。結果の無い func の本体の末尾の式文の値は捨てる。
例: [`examples/stmt_tail_call.sober`](../../examples/stmt_tail_call.sober)
拒否: [`examples/func_neg_noreturn.sober`](../../examples/func_neg_noreturn.sober)
決定: [syntax.md 決定 9](../syntax.md)

F-3. ラムダは `x => e`・`(x, y) => e`・`(x T, y U) => e`・`() => e` の形で、本体は式かブロック（最後の式が値）。結果の型は書かない（期待型から決まる）。関数リテラル `func(x int) int { … }` は無い。
例: [`examples/inline.sober`](../../examples/inline.sober)・[`examples/generic_infer_lambda.sober`](../../examples/generic_infer_lambda.sober)
決定: [syntax.md 決定 1](../syntax.md)

F-4. 匿名の関数型の仮引数（`f func(int) int`）を持つ関数は、呼び出し点に展開される。そこに渡したラムダの本体の `return` は、ラムダを書いた名前つきの関数から戻る（非局所の return）。ラムダの本体の `break` / `continue` はラムダの外へ届かない。
例: [`examples/inline.sober`](../../examples/inline.sober)・[`examples/for_stmt.sober`](../../examples/for_stmt.sober)
決定: [language.md 8 節](../language.md)

F-5. 匿名の関数型の仮引数を持つ関数は、直接にも相互にも再帰できない。
拒否: [`examples/func_neg_recursive_fnparam.sober`](../../examples/func_neg_recursive_fnparam.sober)
決定: [language.md 8 節](../language.md)

F-6. 匿名の関数型の仮引数には名前つきの関数も渡せる（同じ数の仮引数のラムダとして扱う）。仮引数の数の違う関数・mut 仮引数を持つ関数は渡せない。
例: [`examples/fnval_err.sober`](../../examples/fnval_err.sober)
拒否: [`examples/fnarg_arity.sober`](../../examples/fnarg_arity.sober)・[`examples/fnarg_mut.sober`](../../examples/fnarg_mut.sober)
決定: [language.md 25 節](../language.md)

## 5.2 関数値と閉包

F-7. 関数型の欄を持つ struct は辞書で、欄の関数値を `d.f(x)` と呼ぶ（間接呼び出し）。欄には名前つきの関数もラムダも置ける。
例: [`examples/fnvalue.sober`](../../examples/fnvalue.sober)
決定: [language.md 3 節・25 節](../language.md)

F-8. トップレベルの const に辞書を置ける（`const IntOrd = Ord[int]{less: (a, b) => a < b}`）。欄には閉じたラムダと名前つきの関数の参照・入れ子の辞書を置ける。const 式の中で関数は呼べない（ラムダの本体は呼ばれたときに走るので呼べる）。辞書は参照するたびに作り直す — 同一性（アドレスの比較）は保証しない。
例: [`examples/constdict.sober`](../../examples/constdict.sober)・[`examples/closure_const_field.sober`](../../examples/closure_const_field.sober)
拒否: [`examples/const_neg_call.sober`](../../examples/const_neg_call.sober)
決定: [language.md 25 節](../language.md)

F-9. 値の位置 — 名前つき関数型の仮引数・結果、struct の関数型の欄、その option（`F?`）の欄 — に置いたラムダは閉包になる。匿名の関数型の欄の閉包を値の呼び出しの借りの実引数へそのまま渡すと、ラムダ `(…) => x.f(…)` に写して渡す。閉包は作成点の imm の値を写して捕捉する（後で元の変数が変わっても見えない）。閉包は仮引数・結果・欄として関数の境界を越えられる。
例: [`examples/closure_field_capture.sober`](../../examples/closure_field_capture.sober)・[`examples/closure_param.sober`](../../examples/closure_param.sober)・[`examples/closure_result.sober`](../../examples/closure_result.sober)・[`examples/closure_field_opt.sober`](../../examples/closure_field_opt.sober)・[`examples/closure_def_capture.sober`](../../examples/closure_def_capture.sober)・[`examples/closure_anon_field.sober`](../../examples/closure_anon_field.sober)・[`examples/borrow_anon_field_eta.sober`](../../examples/borrow_anon_field_eta.sober)
決定: [language.md 25 節](../language.md)

F-10. 値の位置のラムダは mut の束縛と同一性の型（task の Scope・Handle・端点、net.Conn など）を捕捉できず、本体に `return` を書けない（定義した関数より長く生きうる）。
拒否: [`examples/closure_field_cap_mut.sober`](../../examples/closure_field_cap_mut.sober)・[`examples/closure_field_cap_identity.sober`](../../examples/closure_field_cap_identity.sober)・[`examples/closure_field_return.sober`](../../examples/closure_field_return.sober)
決定: [language.md 8 節・25 節](../language.md)

F-11. 値の位置に置けるのは、ラムダ・名前つきの関数・同じ型の閉包の値だけ。局所に束縛した名前つきの関数（`f := dbl; R{g: f}`）は置けない。
例: [`examples/closure_param.sober`](../../examples/closure_param.sober)
拒否: [`examples/closure_bound_named_fn.sober`](../../examples/closure_bound_named_fn.sober)・[`examples/closure_bound_named_fn_nocap.sober`](../../examples/closure_bound_named_fn_nocap.sober)・[`examples/closure_anon_field_bound.sober`](../../examples/closure_anon_field_bound.sober)
決定: [language.md 25 節](../language.md)

F-12. 名前つき関数型（`type Fetcher func(int) string`）は nominal — 形の同じ別の名前つき関数型どうしは互換でない（2 章 T-34）。関数型の仮引数の名前は型の同一性に入らない。
拒否: [`examples/nominal_fn.sober`](../../examples/nominal_fn.sober)
決定: [language.md 14 節・32 節](../language.md)

## 5.3 借りの関数型仮引数

F-13. 値にできる名前つき関数型（`type Stream func(emit func([]byte) error?) error?`）の匿名の関数型の仮引数（emit）は「借り」。借りの値はその呼び出しの間だけ使える — 呼ぶ・借りの位置（展開される関数の匿名の関数型の仮引数・値の呼び出しの借りの実引数）へ渡す・展開のラムダや文形 for の本体に捕捉する、だけ。束縛・欄への格納・return・値の位置のラムダへの捕捉・子 task への捕捉は拒否する。
例: [`examples/borrow_stream.sober`](../../examples/borrow_stream.sober)・[`examples/borrow_forward.sober`](../../examples/borrow_forward.sober)・[`examples/borrow_cross_f.sober`](../../examples/borrow_cross_f.sober)
拒否: [`examples/borrow_neg_bind.sober`](../../examples/borrow_neg_bind.sober)・[`examples/borrow_neg_store.sober`](../../examples/borrow_neg_store.sober)・[`examples/borrow_neg_return.sober`](../../examples/borrow_neg_return.sober)・[`examples/borrow_neg_valcap.sober`](../../examples/borrow_neg_valcap.sober)・[`examples/borrow_neg_spawn.sober`](../../examples/borrow_neg_spawn.sober)
決定: [language.md 25 節](../language.md)

F-14. 借りの位置のラムダは同一性の型を捕捉してよい（寿命が呼び出しの内側に収まる）。借りの位置かどうかは呼び先の本体で決まる — 仮引数を呼ぶ・借りの位置へ渡すだけの関数の仮引数は借りの位置で、子 task へ渡す仮引数（`net.Serve` の handler）は借りの位置でない。
例: [`examples/borrow_inline_conn.sober`](../../examples/borrow_inline_conn.sober)
拒否: [`examples/borrow_neg_spawn_callee.sober`](../../examples/borrow_neg_spawn_callee.sober)・[`examples/borrow_pkg_neg.sober`](../../examples/borrow_pkg_neg.sober)
決定: [language.md 25 節](../language.md)

F-15. 借りの位置のラムダの中では、囲む展開される関数の匿名の関数型の仮引数を呼べる。流れてくる実引数はラムダ（名前つきの関数を含む）か、囲む関数の同じ種類の仮引数の転送に限り、その実引数のラムダが mut を捕捉していれば拒否する。値の位置の閉包の中では呼べない。
例: [`examples/borrow_pend.sober`](../../examples/borrow_pend.sober)
拒否: [`examples/borrow_pend_mut.sober`](../../examples/borrow_pend_mut.sober)・[`examples/borrow_pend_value.sober`](../../examples/borrow_pend_value.sober)
決定: [language.md 25 節](../language.md)

F-16. 値の呼び出しの借りの実引数のラムダ（とその本体の中の展開されるラムダ・文形 for）は、mut の束縛（mut ローカル・mut 仮引数）を捕捉できる。捕捉は作成点の写しでなく束縛そのもので、借りの呼び出しをまたいだ更新が呼び手に見える。1 つの値の呼び出しの借りの実引数のラムダが捕捉する mut の束縛は合わせて 1 つまで（同じ束縛を複数のラムダで捕捉するのは可 — 2 つ要るなら 1 つの struct にまとめる）。値の位置のラムダと、展開待ちの的へ流れるラムダ（F-15）の mut の捕捉は拒否し、借りの値をそのまま実引数に渡す呼び出しの借りのラムダの mut の捕捉も拒否する。借りの実引数のラムダは関数値（閉包）を持つ値も捕捉できる。freeze の規則（3 章 V-8・V-9）では、捕捉は作成点の呼び出しへの mut 実引数に数え、ラムダの本体の中では捕捉した束縛の中身を freeze できない。
例: [`examples/borrow_mut_count.sober`](../../examples/borrow_mut_count.sober)・[`examples/borrow_mut_state.sober`](../../examples/borrow_mut_state.sober)・[`examples/borrow_mut_deep.sober`](../../examples/borrow_mut_deep.sober)・[`examples/borrow_mut_union.sober`](../../examples/borrow_mut_union.sober)・[`examples/borrow_mut_param.sober`](../../examples/borrow_mut_param.sober)・[`examples/borrow_mut_shared.sober`](../../examples/borrow_mut_shared.sober)・[`examples/borrow_mut_store.sober`](../../examples/borrow_mut_store.sober)・[`examples/borrow_mut_anon_field.sober`](../../examples/borrow_mut_anon_field.sober)
拒否: [`examples/borrow_mut_neg_value.sober`](../../examples/borrow_mut_neg_value.sober)・[`examples/borrow_mut_neg_two.sober`](../../examples/borrow_mut_neg_two.sober)・[`examples/borrow_mut_neg_two_args.sober`](../../examples/borrow_mut_neg_two_args.sober)・[`examples/borrow_mut_neg_frozen.sober`](../../examples/borrow_mut_neg_frozen.sober)・[`examples/borrow_mut_neg_freeze_body.sober`](../../examples/borrow_mut_neg_freeze_body.sober)・[`examples/borrow_mut_neg_forward.sober`](../../examples/borrow_mut_neg_forward.sober)
決定: [language.md 17 節・25 節](../language.md)

F-22. func 宣言の仮引数は省略可の匿名関数型 `(func(…) R)?` を持てる。実引数は `nil`（省略を含む — F-18）・ラムダ・名前つきの関数・囲む関数の同じ種類の仮引数に限り、有る / 無いは呼び出し点ごとに字面で決まる。本体の中では、呼ぶことと省略可でない関数型の仮引数への転送を `if p != nil { … }` の腕（`if p == nil` の else）の中でだけ書け、その腕の中の p は匿名の関数型の仮引数（借り — F-13〜F-15）として扱う。nil と比べる・省略可の仮引数へ転送する以外の使用（束縛・格納・return）は書けない。p を渡さない呼び出し点のコードは、p の仮引数が無い関数と同じになる（`p != nil` の分岐は呼び出し点ごとに畳まれる）。省略可の匿名関数型は func 宣言の仮引数の外（名前つき関数型の中・struct の欄・結果・ラムダの仮引数）には書けず、括弧の無い `func(…) R?` は「結果が `R?` の関数」と紛れるので省略可の形としては拒否する。
例: [`examples/optfn.sober`](../../examples/optfn.sober)・[`examples/optfn_errors.sober`](../../examples/optfn_errors.sober)
拒否: [`examples/optfn_neg_bare.sober`](../../examples/optfn_neg_bare.sober)・[`examples/optfn_neg_field.sober`](../../examples/optfn_neg_field.sober)・[`examples/optfn_neg_fntype.sober`](../../examples/optfn_neg_fntype.sober)・[`examples/optfn_neg_arg.sober`](../../examples/optfn_neg_arg.sober)・[`examples/optfn_neg_unguarded.sober`](../../examples/optfn_neg_unguarded.sober)・[`examples/optfn_neg_forward.sober`](../../examples/optfn_neg_forward.sober)・[`examples/optfn_neg_bind.sober`](../../examples/optfn_neg_bind.sober)・[`examples/optfn_neg_store.sober`](../../examples/optfn_neg_store.sober)・[`examples/optfn_neg_return.sober`](../../examples/optfn_neg_return.sober)・[`examples/optfn_neg_valcap.sober`](../../examples/optfn_neg_valcap.sober)・[`examples/optfn_neg_spawn.sober`](../../examples/optfn_neg_spawn.sober)
決定: [language.md 25 節](../language.md)・[syntax.md 決定 7](../syntax.md)

## 5.4 ジェネリクス

F-17. 関数と型は型パラメータを持てる — `func f[T](…)`・`type Ord[T] struct {…}`・`type Opt[T] union {…}`。型パラメータに制約は書かない（振る舞いは辞書で渡す — F-1）。関数の型引数は値の実引数の型と、ラムダの実引数の結果の型から推論し、決まらなければ拒否する。明示するときは `f[int](x)`（1 個まで）。ジェネリック union の variant のリテラルは型引数を明示し（`Some[int]{v: 3}`）、個数は宣言どおり。
例: [`examples/generic.sober`](../../examples/generic.sober)・[`examples/generic_infer.sober`](../../examples/generic_infer.sober)・[`examples/generic_infer_lambda.sober`](../../examples/generic_infer_lambda.sober)・[`examples/generic_union.sober`](../../examples/generic_union.sober)
拒否: [`examples/generic_union_arity.sober`](../../examples/generic_union_arity.sober)・[`examples/generic_union_noargs.sober`](../../examples/generic_union_noargs.sober)
決定: [language.md 3 節・25 節](../language.md)

## 5.5 名前つき引数

F-18. 呼び出しに名前つき引数を書ける（`f(x, sep: ",")`）— 位置の実引数が先・名前つきが後で、名前つきどうしは仮引数の宣言の順。省略できるのは型が `T?` の仮引数（省略可の匿名関数型 `(func(…) R)?` を含む — F-22）だけで、省略は `nil`。パイプの左辺の位置は穴 `_` で書く。名前つき引数を書けるのは func 宣言の直接の呼び出しと、仮引数名を持つ名前つき関数型の値の呼び出しだけ（辞書の欄の関数値・ラムダの値は位置だけ）。
例: [`examples/named_args.sober`](../../examples/named_args.sober)・[`examples/named_fn_args.sober`](../../examples/named_fn_args.sober)
拒否: [`examples/named_args_missing.sober`](../../examples/named_args_missing.sober)・[`examples/named_args_order.sober`](../../examples/named_args_order.sober)・[`examples/named_args_positional.sober`](../../examples/named_args_positional.sober)・[`examples/named_args_unknown.sober`](../../examples/named_args_unknown.sober)・[`examples/named_args_pipe.sober`](../../examples/named_args_pipe.sober)・[`examples/named_args_nonfunc.sober`](../../examples/named_args_nonfunc.sober)・[`examples/named_fn_args_field.sober`](../../examples/named_fn_args_field.sober)・[`examples/named_fn_args_nonames.sober`](../../examples/named_fn_args_nonames.sober)
決定: [syntax.md 決定 7](../syntax.md)

F-19. 関数型の仮引数の名前は、全部つけるか全部つけないか。
拒否: [`examples/named_fn_type_mixed.sober`](../../examples/named_fn_type_mixed.sober)
決定: [syntax.md 決定 7](../syntax.md)

## 5.6 公開の境界

F-20. 匿名の関数型の仮引数は、公開の関数でも書ける — 匿名の関数型の仮引数は借り（呼び出しの間だけ使い、格納も持ち出しもされない）なので契約の置き場が要らない。値として格納・返却する関数は名前つき関数型で宣言する（契約 — `@errors` など — はその宣言に集まる）。
例: [`examples/errors_param.sober`](../../examples/errors_param.sober)・[`examples/borrow_stream.sober`](../../examples/borrow_stream.sober)・[`examples/io_chunks.sober`](../../examples/io_chunks.sober)
決定: [language.md 14 節・25 節](../language.md)

F-21. mut の仮引数も関数型の仮引数も持たない関数は、結果の型に mut の中身（mut の slice / map — struct の欄・`T?` の中も、型引数を代入した後で）を持てない。mut の値は呼び手がゼロ値リテラルで作り、mut の実引数で渡す。check と build の両方が拒否する。
例: [`examples/fn_ret_mut.sober`](../../examples/fn_ret_mut.sober)
拒否: [`examples/fn_ret_mut_neg.sober`](../../examples/fn_ret_mut_neg.sober)
決定: [language.md 26 節](../language.md)
