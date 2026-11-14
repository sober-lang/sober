# 9. メモリ

日本語

[目次](README.ja.md)

GCは無い。値はregion（スコープごとのアリーナ）に置かれ、スコープを出ると一括で返る。regionの境界を出る値は、残る側へコピーされる — 書き手はどこでコピーされるかをソースの境界で読める。

## 9.1 region

M-1. ブロックごとにregionがある — 関数の本体・式ブロック `{ … }`・if / switchの分岐・whileと文形forの本体（反復ごとに新しいregion）。値は今いるregionに置かれ、ブロックを出るとregionごと返る。ループの中で作った値は、反復を越えて残すものだけが外へコピーされる（反復の数に比例して積もらない）。
例: [`examples/block_escape.sober`](../../examples/block_escape.sober)・[`examples/iter_region_inner.sober`](../../examples/iter_region_inner.sober)・[`examples/iter_region_outer_assign.sober`](../../examples/iter_region_outer_assign.sober)
決定: [language.md 21節](../language.md)

M-2. 値がregionの境界を出るとき — 関数のreturn・`?` / 早期return / breakの脱出・式ブロックの普通の出口 — 捨てるregionにあるimmのコンテナ（string・slice・map）は、中身まで型に沿って残る側のregionへコピーされる（struct・`T?`・union・errorの中も）。だから関数やブロックの中で作ったstringや入れ子のsliceを返せる。コピーの費用はコピーするものの量に比例する。
例: [`examples/block_escape.sober`](../../examples/block_escape.sober)・[`examples/deep_return.sober`](../../examples/deep_return.sober)・[`examples/errlabel.sober`](../../examples/errlabel.sober)
決定: [language.md 21節・31節](../language.md)

M-3. 外の可変の場所への代入・格納（外のmutの束縛・フィールド・添字・map）は、値を行き先のregionへコピーする。新しいmutのコンテナを外の場所に置くときは、行き先のregionに作る（mutのコンテナは同一性を持つのでコピーできない）。
例: [`examples/loop_reassign_mutslice.sober`](../../examples/loop_reassign_mutslice.sober)・[`examples/lambda_region.sober`](../../examples/lambda_region.sober)・[`examples/nested.sober`](../../examples/nested.sober)
決定: [language.md 21節](../language.md)

## 9.2 sliceの伸長と部分列

M-4. sliceのヘッダは（先頭の番地, 長さ）の2ワードで、容量（cap）は無い。`append` は、mutのsliceの末尾がそのregionの先端と一致するときだけその場で伸ばし、そうでなければ今のregionへ新しくコピーする。immのsliceへのappendはいつもコピーする。同じsliceから2回appendすると2回目は必ずコピーになり、2つの結果は独立する（片方の書きが他方に見えない）。先端で伸ばし続けるループはコピーが起きない。
例: [`examples/slice.sober`](../../examples/slice.sober)・[`examples/concat_tip_alias.sober`](../../examples/concat_tip_alias.sober)・[`examples/concat_loop.sober`](../../examples/concat_loop.sober)
決定: [language.md 21節](../language.md)

M-5. 部分列 `xs[a:b]` は同じセル列を指す新しいヘッダ（コピーしない）で、型はimmのslice — mutのsliceから取っても書けない。`a ≤ b ≤ len(xs)` を外れるとpanic（終了コード101）。stringは部分列を持たない（`bytes(s)[a:b]` と見方を明示する）。
例: [`examples/strings_ops.sober`](../../examples/strings_ops.sober)・[`examples/panic_slice.sober`](../../examples/panic_slice.sober)
拒否: [`examples/slice_neg_sub_write.sober`](../../examples/slice_neg_sub_write.sober)・[`examples/string_neg_slice.sober`](../../examples/string_neg_slice.sober)
決定: [language.md 21節・24節](../language.md)

## 9.3 上限

M-6. regionの資源が尽きるとpanic（終了コード102 — `RegionExceeded{cause, depth}`）: region 1つの容量（mainのtaskは既定4 GiB・環境変数 `SOBER_REGION_MB` で変えられる）を超える・入れ子の深さが上限に届く・予約が取れない。関数の呼び出しとブロックは深さを1レベル使うので、無限の再帰は102で止まる。
例: [`examples/panic_depth.sober`](../../examples/panic_depth.sober)・[`examples/task_depth.sober`](../../examples/task_depth.sober)
決定: [language.md 27節](../language.md)

## 9.4 PoolとHandle

M-7. 長く生きて更新され続ける構造はstd/poolの `Pool[T]` に置く。`pool.Acquire` は世代つきの `Handle` を返し、`pool.Get(mut p, h)` は `T?` で読む — 返却された・再利用されたスロットの古いHandleはnilになる（宙吊りの参照の代わりに分岐）。取り出しの直後の文は `defer pool.Release(mut p, h)`（12章A-7）。
例: [`examples/pool.sober`](../../examples/pool.sober)・[`examples/pool_string.sober`](../../examples/pool_string.sober)
拒否: [`examples/pool_neg_nodefer.sober`](../../examples/pool_neg_nodefer.sober)
決定: [language.md 30節](../language.md)
