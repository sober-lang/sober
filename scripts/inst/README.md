# inst — 自己 build の命令数の切り分け（report-780 / 781 / 782）

ratchet の `self/build3 inst`（stages が照合）か `self/build inst`（bench.sh — 参考の 2 本目）が鳴ったら、2×2 で「足したソースの仕事」と
「コンパイラの退行」を分ける。命令数は決定的（同じ組は小数 3 桁まで一致・パス長に鈍い）なので 1 回ずつで足りる。cycles は使わない。
stages の `self/build3 inst / rss` は「compiler の import 閉包の std だけを残した木」の自己 build で測る（2026-10-18 — std の焼き込みの値札を
線から切り離す・report-789）。m.sh は全部の木で測るので、閉包の外の std を足した差は m.sh には出て stages には出ない。

    scripts/inst/mk.sh <旧コミット> old          # 旧の stage2 と木
    scripts/inst/mk.sh <新コミット | 作業木> new   # 作業木はディレクトリ（compiler/* + std を並べたもの）
    scripts/inst/m.sh old old; scripts/inst/m.sh old new; scripts/inst/m.sh new old; scripts/inst/m.sh new new

- 木の仕事 = (old × new) − (old × old)。足した行で割って ≈0.8〜0.9 M 命令 / 行なら正直な値札（受理）。大きく外れたら形を疑う
  （例: report-781 — Cx に struct の欄を足すと Cx を受ける全関数の compile が重くなり、80 行で +0.25 G）
- コンパイラの退行 = (new × old) − (old × old)。0.1 G を超えたら段を切る: `m.sh S T loader`（loader 単体）・`build --emit=ir --passes`（lower まで）。
  名指しは置き換え（疑わしい関数を早期 return にした stage2 を mk.sh で建てて差を見る — 自己 build の ELF がバイト一致なら意味不変の置き換え）
- 節目が多いときは隣どうしの 2×2 を並べる（report-780 2 節の表の形）
- callgrind は使えない（valgrind のアドレス空間の上限で region の予約が縮み slot_capacity で落ちる）。perf record は時間で間引かれて比に使えない
- 置き場は $INST_WORK（既定 out/inst — gitignore 済み）
