# 9. メモリ

日本語

[目次](README.ja.md)

GC は無い。値は region（スコープごとのアリーナ）に置かれ、スコープを出ると一括で返る。region の境界を出る値は、残る側へ写される — 書き手はどこで写るかをソースの境界で読める。

## 9.1 region

M-1. ブロックごとに region がある — 関数の本体・式ブロック `{ … }`・if / switch の腕・while と文形 for の本体（反復ごとに新しい region）。値は今いる region に置かれ、ブロックを出ると region ごと返る。ループの中で作った値は、反復を越えて残すものだけが外へ写る（反復の数に比例して積もらない）。
例: [`examples/block_escape.sober`](../../examples/block_escape.sober)・[`examples/iter_region_inner.sober`](../../examples/iter_region_inner.sober)・[`examples/iter_region_outer_assign.sober`](../../examples/iter_region_outer_assign.sober)
決定: [language.md 21 節](../language.md)

M-2. 値が region の境界を出るとき — 関数の return・`?` / 早期 return / break の脱出・式ブロックの普通の出口 — 捨てる region にある imm のコンテナ（string・slice・map）は、中身まで型に沿って残る側の region へ写る（struct・`T?`・union・error の中も）。だから関数やブロックの中で作った string や入れ子の slice を返せる。写しの費用は写すものの量に比例する。
例: [`examples/block_escape.sober`](../../examples/block_escape.sober)・[`examples/deep_return.sober`](../../examples/deep_return.sober)・[`examples/errlabel.sober`](../../examples/errlabel.sober)
決定: [language.md 21 節・31 節](../language.md)

M-3. 外の可変の場所への代入・格納（外の mut の束縛・欄・添字・map）は、値を行き先の region へ写す。新しい mut のコンテナを外の場所に置くときは、行き先の region に作る（mut のコンテナは同一性を持つので写せない）。
例: [`examples/loop_reassign_mutslice.sober`](../../examples/loop_reassign_mutslice.sober)・[`examples/lambda_region.sober`](../../examples/lambda_region.sober)・[`examples/nested.sober`](../../examples/nested.sober)
決定: [language.md 21 節](../language.md)

## 9.2 slice の伸長と部分列

M-4. slice のヘッダは（先頭の番地, 長さ）の 2 語で、容量（cap）は無い。`append` は、mut の slice の末尾がその region の先端と一致するときだけその場で伸ばし、そうでなければ今の region へ新しく写す。imm の slice への append はいつも写す。同じ slice から 2 回 append すると 2 回目は必ず写しになり、2 つの結果は独立する（片方の書きが他方に見えない）。先端で伸ばし続けるループは写しが出ない。
例: [`examples/slice.sober`](../../examples/slice.sober)・[`examples/concat_tip_alias.sober`](../../examples/concat_tip_alias.sober)・[`examples/concat_loop.sober`](../../examples/concat_loop.sober)
決定: [language.md 21 節](../language.md)

M-5. 部分列 `xs[a:b]` は同じセル列を指す新しいヘッダ（写さない）で、型は imm の slice — mut の slice から取っても書けない。`a ≤ b ≤ len(xs)` を外れると panic（終了コード 101）。string は部分列を持たない（`bytes(s)[a:b]` と見方を名指す）。
例: [`examples/strings_ops.sober`](../../examples/strings_ops.sober)・[`examples/panic_slice.sober`](../../examples/panic_slice.sober)
拒否: [`examples/slice_neg_sub_write.sober`](../../examples/slice_neg_sub_write.sober)・[`examples/string_neg_slice.sober`](../../examples/string_neg_slice.sober)
決定: [language.md 21 節・24 節](../language.md)

## 9.3 上限

M-6. region の資源が尽きると panic（終了コード 102 — `RegionExceeded{cause, depth}`）: region 1 つの容量（main の task は既定 4 GiB・環境変数 `SOBER_REGION_MB` で変えられる）を超える・入れ子の深さが上限に届く・予約が取れない。関数の呼び出しとブロックは深さを 1 段使うので、無限の再帰は 102 で止まる。
例: [`examples/panic_depth.sober`](../../examples/panic_depth.sober)・[`examples/task_depth.sober`](../../examples/task_depth.sober)
決定: [language.md 27 節](../language.md)

## 9.4 Pool と Handle

M-7. 長く生きて更新され続ける構造は std/pool の `Pool[T]` に置く。`pool.Acquire` は世代つきの `Handle` を返し、`pool.Get(mut p, h)` は `T?` で読む — 返却された・再利用されたスロットの古い Handle は nil になる（宙吊りの参照の代わりに分岐）。取り出しの直後の文は `defer pool.Release(mut p, h)`（12 章 A-7）。
例: [`examples/pool.sober`](../../examples/pool.sober)・[`examples/pool_string.sober`](../../examples/pool_string.sober)
拒否: [`examples/pool_neg_nodefer.sober`](../../examples/pool_neg_nodefer.sober)
決定: [language.md 30 節](../language.md)
