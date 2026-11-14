# inst — 自己buildの命令数の切り分け（report-780 / 781 / 782）

ratchetの `self/build3 inst`（stagesが照合）か `self/build inst`（bench.sh — 参考の2本目）が鳴ったら、2×2で「足したソースの仕事」と
「コンパイラの退行」を分ける。命令数は決定的（同じ組は小数3桁まで一致・パス長に鈍い）なので1回ずつで足りる。cyclesは使わない。
stagesの `self/build3 inst / rss` は「compilerのimportの推移的な依存のstdだけを残した木」の自己buildで測る（2026-10-18 — stdの焼き込みのコストを
上限値から切り離す・report-789）。m.shは全部の木で測るので、推移的な依存の外のstdを足した差はm.shには出てstagesには出ない。

    scripts/inst/mk.sh <旧コミット> old          # 旧のstage2と木
    scripts/inst/mk.sh <新コミット | 作業木> new   # 作業木はディレクトリ（compiler/* + stdを並べたもの）
    scripts/inst/m.sh old old; scripts/inst/m.sh old new; scripts/inst/m.sh new old; scripts/inst/m.sh new new

- 木の仕事 = (old × new) − (old × old)。足した行で割って ≈0.8〜0.9 M命令 / 行なら正直なコスト（受理）。大きく外れたら形を疑う
  （例: report-781 — Cxにstructのフィールドを足すとCxを受ける全関数のcompileが重くなり、80行で +0.25 G）
- コンパイラの退行 = (new × old) − (old × old)。0.1 Gを超えたら段階を切り分ける: `m.sh S T loader`（loader単体）・`build --emit=ir --passes`（lowerまで）。
  特定は置き換えで（疑わしい関数を早期returnにしたstage2をmk.shでビルドして差を見る — 自己buildのELFがバイト一致なら意味不変の置き換え）
- 節目が多いときは隣どうしの2×2を並べる（report-780 2節の表の形）
- callgrindは使えない（valgrindのアドレス空間の上限でregionの予約が縮みslot_capacityで落ちる）。perf recordは時間で間引かれて比に使えない
- 格納場所は $INST_WORK（既定out/inst — gitignore済み）
