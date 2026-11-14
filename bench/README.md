# Sober vs Go — 現在地

- 逐次9題材（対Go・CPU時間〔task-clock〕・±5%を互角）: 勝ち6・互角3（spectral-norm 0.98×・fannkuch-redux 1.03×・mandelbrot 1.03×）・負け0。最も差が大きいのはbinary-trees 0.31× <!-- benchsync:bench-go -->
- RSSは9題材中9題材でGo以下（0.002×〜0.82×）。上回る題材は無い <!-- benchsync:bench-rss-go -->
- 対Rustの比較用の実装（逐次9題材・2026-10-25）: Soberの4勝・3互角・2敗（負けはreverse-complement 1.47×・n-body 1.17× — 下の「Rustの実装との比較」） <!-- benchsync:bench-rust -->
- 並列: Skynet（111万task）はGoの5倍速く、binary-trees並列はW8で2.5倍速い。RSSは1/17〜1/500（Skynet — 2026-10-10取り直し）。メモリの上限を下げても死なず、逐次の速さまで滑らかに落ちる（[par/README.md](par/README.md)）

最終更新2026-10-25（逐次 = 木a8bfbd8a — GitHub Actions linux-x64-16vcpu（AMD EPYC 9V45 96-Core Processor・kernel 6.17.0-1022-azure・run 40160907459） で `bench/seqperf.sh -n 5 --rust`・raw = bench/data/raw/2026-10-25-40160907459/seqperf.tsv・数字の正 = [data/official.tsv](data/official.tsv)。並列 = 2026-10-08〜10の手元の取り直しのまま — 日付は [par/README.md](par/README.md) の各節）。生データと測り方は [par/README.md](par/README.md)（並列）と本ファイルの末尾（逐次）。 <!-- benchsync:bench-updated -->

## 1. 逐次9題材

<!-- benchsync:begin bench-seq -->
| 題材（規模） | CPU時間 中央s Sober / Go | 比 | wall中央s Sober / Go | 比 | 最大RSS MB Sober / Go | 比 |
|---|---|---|---|---|---|---|
| 1BRC（1,000万行）※ | 0.241 / 0.372 | 0.65× | 0.25 / 0.38 | 0.66× | 0.4 / 240 | 0.002× |
| binary-trees（18） | 0.510 / 1.679 | 0.31× | 0.52 / 1.69 | 0.31× | 17 / 51 | 0.34× |
| fannkuch-redux（11） | 2.149 / 2.078 | 1.03× | 2.16 / 2.09 | 1.03× | 0.3 / 5.7 | 0.05× |
| fasta（250万） | 0.193 / 0.306 | 0.63× | 0.22 / 0.33 | 0.67× | 0.3 / 3.5 | 0.07× |
| reverse-complement | 0.047 / 0.060 | 0.79× | 0.06 / 0.07 | 0.86× | 24 / 30 | 0.82× |
| k-nucleotide | 0.825 / 2.681 | 0.31× | 0.84 / 2.69 | 0.31× | 53 / 78 | 0.67× |
| n-body（500万） | 0.196 / 0.295 | 0.67× | 0.20 / 0.30 | 0.67× | 0.3 / 5.7 | 0.05× |
| spectral-norm（2000） | 0.148 / 0.151 | 0.98× | 0.16 / 0.16 | 0.99× | 0.3 / 5.7 | 0.04× |
| mandelbrot（4000） | 0.773 / 0.746 | 1.03× | 0.78 / 0.76 | 1.04× | 1.9 / 5.7 | 0.33× |
<!-- benchsync:end bench-seq -->

<!-- benchsync:begin bench-method -->
GitHub Actions linux-x64-16vcpu（AMD EPYC 9V45 96-Core Processor・kernel 6.17.0-1022-azure・run 40160907459） の1つのvCPU（最後のvCPU）に固定し、Sober → Go → Rustの交互で5周測った（準備の後にloadavgが1.5を割るまで待ってから）。指標はCPU時間（task-clock — カーネルの時間を含む）で、比は同じ周の対（Soberの周i / 相手の周i）の比の5周の中央をとる（周ごとに全実装に同時に乗るマシンの揺れが打ち消される — 同じマシンで3 runの比の幅は最大3.7%・report-922）。表のCPU時間とwallは中央、RSSは最大。GitHub ActionsのVMはハードウェアのカウンタを出さないのでcyclesと命令数は無い（命令数の規律はgatesのラチェットが見る）。数字の正は [data/official.tsv](data/official.tsv) で、表と要約の行は `scripts/benchsync.sh` が生成する（gatesのbenchsyncが文書との一致を見る）。出力は毎回Sober ≡ Go ≡ Rustで、fasta / revcomp / k-nucleotide / n-body / spectral-norm / mandelbrotはbenchmarks gameの公式の期待出力とも一致する。公式の再現: `.github/workflows/bench-official.yml`（workflow_dispatch）→ `scripts/benchfetch.sh <run-id>`。手元: `scripts/bench.sh -n 5`（実行ファイルと入力を置く）→ `bench/seqperf.sh -n 5 --rust`。
<!-- benchsync:end bench-method -->

- 指標はCPU時間（task-clock）。2026-10-19までの手元（WSL2）のcycles:uは利用者の空間だけを数えたが、task-clockはカーネルの時間（ファイルの読み込み・ページフォールト）も含む — 入力を読む題材（1BRC・Web 3本）は比が動く。wallは参考 <!-- benchsync:bench-metric-note -->
- 指標の切り替え（2026-10-25）: 逐次・外部ソートの表は手元（WSL2）のcycles:uからGitHub ActionsのCPU時間（task-clock — 同じ周の対の比の中央）へ移った。2026-10-19の手元の表と数字を並べて比べることはできない（機械も指標も違う）。勝敗の分類は対Goで同じ（勝ち6・互角3）・対Rustは1BRCが互角0.96× → 勝ち0.90× に動いた
- 再現性（同じ木a8bfbd8aの2 run — 2026-10-25のrun 40158674652と40160907459・同じ型番のマシン）: 26本の比（9題材 + Web 3本 + 外部ソートの対Go / 対Rust）のうち21本は2 runの幅 ±3%以内で、勝敗の分類は26本とも一致した。**1BRC・binary-trees・logaggの3題材は日ごとに ±10%動く**（GoとRustの同じバイナリ同士の比も別の日のrunで6〜13%動いた — マシンの揺れ）。**外部ソート1 GiBとk-nucleotideの対Rustは ±3〜4%**（2 runで3.0% / 3.1%）。この5本の比は幅を込みで読むこと
- ※ 1BRCは2026-10-13に実装を差し替えた（`io.ReadFile` で全体を読む形 → `io.Chunks` で64 KiBの切片をコピーせずに借りて回す形。アルゴリズム・UTF-8の全量検査は同じ）。以下は2026-10-19までの手元（WSL2・cycles:u）の分析:
  旧の形はcycles 1.48 G（対Rust 1.04×）・命令3.84 G・wall 0.50 s・RSS 134 MBで、**cyclesは差し替えで6〜7%悪くなった**（8配置 × 3周の中央 +6.4%・命令 +4.8% —
  行のループの利用者の空間の仕事が増えた。切り分けは保留）。一方wallは0.50 → 0.47 s（Rust 0.47 sと同等）・RSSは134 → 0.6 MB（カーネル込みのtask-clockは中央で同じ・最小 −3.5%）。指標の偏り: cycles:uは利用者の空間だけを数え、旧の形が払っていたカーネルのコピー（ファイル136 MBを
  regionへ読むreadと、そのページを初めて触るフォールト）を数えない — 差し替えで消えたのはその分。今の指標のtask-clockはこのカーネルの分も数える
- RSSの0.4 MBは静的リンクの最小の常駐分。bench.shの表のRSS（2 MB）はtaskset由来の下限を含む（[par/README.md](par/README.md) の環境の節）

### ビルドの時間（同じ走り・中央値）

| | Sober | Go冷（空のGOCACHE） | Go温 |
|---|---|---|---|
| 題材1本のbuild | 0.19〜0.24 s | 2.1〜2.3 s | 0.07〜0.08 s |

Soberはstdを焼き込んだ単一バイナリなので、冷 / 温の区別がほぼない。Goの温（runtime / stdがキャッシュ済み）はSoberより2.5〜3倍速い。

<!-- benchsync:begin bench-rust-table -->
### Rustの実装との比較（2026-10-25 — 木a8bfbd8a）

| 題材 | CPU時間 中央s Sober / Go / Rust | Sober / Rust | Go / Rust | wall中央s Sober / Go / Rust | 最大RSS MB Sober / Go / Rust |
|---|---|---|---|---|---|
| 1BRC ※ | 0.241 / 0.372 / 0.269 | 0.90× | 1.38× | 0.25 / 0.38 / 0.28 | 0.4 / 240 / 135 |
| binary-trees | 0.510 / 1.679 / 0.717 | 0.73× | 2.37× | 0.52 / 1.69 / 0.73 | 17 / 51 / 34 |
| fannkuch-redux | 2.149 / 2.078 / 2.216 | 0.97× | 0.93× | 2.16 / 2.09 / 2.23 | 0.3 / 5.7 / 2.2 |
| fasta | 0.193 / 0.306 / 0.254 | 0.76× | 1.20× | 0.22 / 0.33 / 0.27 | 0.3 / 3.5 / 2.2 |
| reverse-complement | 0.047 / 0.060 / 0.032 | 1.47× | 1.85× | 0.06 / 0.07 / 0.04 | 24 / 30 / 26 |
| k-nucleotide | 0.825 / 2.681 / 1.227 | 0.67× | 2.19× | 0.84 / 2.69 / 1.24 | 53 / 78 / 53 |
| n-body | 0.196 / 0.295 / 0.168 | 1.17× | 1.76× | 0.20 / 0.30 / 0.18 | 0.3 / 5.7 / 2.1 |
| spectral-norm | 0.148 / 0.151 / 0.144 | 1.03× | 1.05× | 0.16 / 0.16 / 0.15 | 0.3 / 5.7 / 2.3 |
| mandelbrot | 0.773 / 0.746 / 0.768 | 1.01× | 0.98× | 0.78 / 0.76 / 0.78 | 1.9 / 5.7 / 2.2 |
<!-- benchsync:end bench-rust-table -->

- 対Rust（CPU時間〔task-clock〕・小数2桁で0.95〜1.05× を互角）: Soberの4勝（k-nucleotide・binary-trees・fasta・1BRC）・3互角（fannkuch-redux・mandelbrot・spectral-norm）・2敗（reverse-complement 1.47×・n-body 1.17×）。GoはRustに対して1勝（fannkuch-redux）・2互角（mandelbrot・spectral-norm）・6敗 <!-- benchsync:bench-rust-tally -->
- 比較用のRustの実装は `bench/<題材>/rust/main.rs`（比較用のGoの実装の逐語訳 — --releaseの既定・明示SIMD / unsafe / 依存のcrateなし）。測り方は上の表と同じ指標で `bench/rust/build.sh` → `bench/seqperf.sh -n 5 --rust`（Sober → Go → Rustの交互・出力の一致を毎回）
- 取り方の恣意が残る題材: fasta / revcomp / mandelbrotはGoの1バイト書き（WriteByte）の鏡として `BufWriter` へ1バイトずつ書く（Rustの素直な書き方としては行単位のほうが多い — fastaのRustは1バイト書きのコストを含む）。binary-treesはGoの「節ごとにnew」の鏡として `Box`（benchmarks gameのRustは型つきアリーナ）。k-nucleotideと1BRCの鍵は切片を借りる（Goの `m[string(b)]` が割り当てない形の鏡）
- 負けの内訳（2026-10-19までの手元のcyclesの分析 — CPU時間の指標では取り直していない）: n-bodyはsqrt / divの依存チェーンとスカラーに残るzの成分（SSE2の2番地形では水平の和に得が無い）。reverse-complementは未切り分け。1BRCは手元のcyclesでは互角（0.96×）で、mapの引きと名前のUTF-8の検査・切片の形の行のループの命令 +4.8%を要因としていた — CPU時間ではカーネルの読み込みの分をSoberが払わない形で勝ちに入った

<!-- benchsync:begin bench-extsort -->
### 外部ソート（2026-10-25 — 木a8bfbd8a・`bench/extsort.sh -n 6`・入力1 GiB・ウィンドウ64 MiB・W1・warm・交互6回）

| 実装 | wall中央s | CPU時間 中央s | 最大RSS MB | CPU時間 対Rust素 |
|---|---|---|---|---|
| Sober | 33.6 | 33.6 | 176.9 | 2.09× |
| Go | 24.0 | 24.0 | 536.9 | 1.50× |
| Rust素 | 16.1 | 16.1 | 180.1 | 1.00× |
| GNU sort | 17.6 | 17.6 | 67.3 | 1.09× |
<!-- benchsync:end bench-extsort -->

- 主な特長 = メモリの約束: SoberのRSSは入力の大きさ（256 MiB〜4 GiB）に依らずウィンドウの約2.8倍で一定（Rust素と同じ水準・Goの1/2〜1/3 — 入力の大きさを振った図は2026-10-25のrun 40160907459: Sober 176.9 / 176.9 / 176.9 MB・Go 346.7 / 418.5 / 536.9・Rust素179.8 / 179.1 / 179.9・GNU sort 67.2 / 67.3 / 67.3 MB〔256 MiB / 1 GiB / 4 GiB〕）。runを1回の関数の呼び出しで組んでregionごと捨て、マージはk本の枠を1本のmutのバイト列に持つ
- 速さは負け（CPU時間でRust素の2.1倍・Goの1.4倍 — 2026-10-25）。手元のwallの経過（2026-10-13〜14）: 107.5 s（2026-10-13 — std/sortへ差し替えた直後）→ 91.7 s（forのappendの一括のコピー — compilerのcopyloop）→ 84.2 s（Writerへのコピーの一括化）→ 76.4 s（2026-10-14 01:39 — wall最小。runの並べ替えをstd/sortの `OrderUnstable` — pdqsort・作業域なし — へ。比較用のRustの実装も `sort_unstable`。等しい行はバイト列ごと同じなので順は出力に現れない）。残りの内訳: 行の比較 `less`（1バイトずつの比べのループ — 比較用の実装はmemcmp）が最大
- 書き方の注記: マージの1切片の読み込み（mutの引数を持つ関数）は式ブロックで包む。包まないとio.ChunksAtの1回ごとの読み込みの枠（2 × 64 KiB）がregion透過のチェーンを通ってマージの間ずっと積もる（RSSが入力の約2倍）
- 4 GiBのwall（1回 — 2026-10-25のrun 40160907459）: Sober 188.8 s・Go 131.7 s・Rust素146.8 s・GNU sort 77.5 s。raw = `bench/data/raw/2026-10-25-40160907459/extsort.tsv`

## 2. 並列（要約 — 詳細は [par/README.md](par/README.md)）

計測環境: 手元（AMD Ryzen AI MAX PRO 390（12物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10の取り直しの当時）・Go 1.26.1・perf 7.2.6） — 逐次の表〔GitHub Actions〕とは別の機械。詳細は6節 <!-- benchsync:bench-env-local -->

- Skynet: taskの生成と合流の費用と、細かい粒度（葉 ≤ 1 µs）の並列の数字は [par/README.md](par/README.md) の1〜2節
- binary-trees並列: W8でGoの2.5倍速く、RSSは0.40倍。並列版のW1のオーバーヘッドは6%
- 劣化曲線: 上限を下げるとSoberは並列だけを畳んで逐次に落ちる（user ≈ wall・値は不変）。GoはGCが回り続けてwall 4〜8倍・user最大10 s
- 負けている軸: 1BRC並列はW8でGoが1.2倍速い（W4はほぼ互角の1.06倍・W2以下はSoberが速い — 前回はW8 1.16倍・W4 1.5倍）。葉の太いtask（≥ 3 µs）もGoが速い（葉の機械語の差 — -O2水準レーン6.5で扱う）

## 3. コンパイラ自身

計測環境: 手元（AMD Ryzen AI MAX PRO 390（12物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10の取り直しの当時）・Go 1.26.1・perf 7.2.6） — 逐次の表〔GitHub Actions〕とは別の機械。詳細は6節 <!-- benchsync:bench-env-local -->

| | ワーカー1 | W8（物理8コア固定） | peak RSS W1 / W8 |
|---|---|---|---|
| `sober check`（自分のソース一括） | 12.7 s | 3.4 s | 285 / 911 MB |
| `sober check --split` 温（変更なし） | — | 1.8 s（既定ワーカー・固定なし） | 231 MB |
| `sober build`（自分のELF） | 5.6 s | 3.5 s | 245 / 652 MB |

compiler/ + stdをコピーした木で測った（W軸の詳細は [par/README.md](par/README.md) の7節）。再現: `scripts/bench.sh`（self/* の行 — `-par` の行は `SOBER_WORKERS=8` + 物理8コアのtasksetで測る。既定ワーカー数〔この機は24論理CPU〕だとバッチの子のヒープでRSSが機械のコア数に依存するため、2026-10-08に基準を揃えた）。

- 表の時間とRSSは2026-10-08の計測のまま

## 4. この数字が約束つきであること

- UTF-8: 文字列は常に有効なUTF-8。1BRCは入力の全バイトを検査し（切片の中の完全な行の範囲ごとに1回 — 改行で切るので文字の境界は割れない）、切り出しは定理で検査なしにしている — 「検査しない」で速いのではない
- 境界コピー: 関数・task・チャネルの境界を渡る値はコピーする意味論（別名による破壊が構造的にない）。速さは宛先構築など観測できない最適化で取り返している
- 決定性: 同じ版・同じ入力なら出力は同じバイト。並列の数字もW1 ≡ W8のバイト一致の検査一式（selfpar・schedfuzz・seqpar・parbudget）の下で測った
- GCなし: RSSは生きているデータの量に追従する（GCのヘッドルームがない）。GoのRSSにはGOGC=100のヘッドルームが含まれる

## 5. 負けている軸（内訳つき）

- 対Goの負けは0（2026-10-25 — CPU時間）。互角の際にfannkuch-redux 1.03×・mandelbrot 1.03×（どちらも2 runの幅 ±0.2% — 再現する差）。2026-10-14の手元のcyclesの分析: fannkuchは予測ミスが配置で二峰に分かれる種類の題材（同一機械語で配置だけが決める）。関数の先頭64 Bの整列で「ほかの関数の変化」による峰の行き来は止めたが、予測器の索引の衝突そのものは規則にできていない
- 対Rustの負け: reverse-complement 1.47×・n-body 1.17×（上のRustの実装との比較の節）・外部ソート2.1×
- 命令数そのもの（spectral-norm 1.21×・mandelbrot 1.17×・fannkuch 1.13× — 対Go・2026-10-19までの手元の計測）: 命令の質の改善の余地として残っている（GitHub Actionsのマシンはハードウェアのカウンタを出さないので、今の指標では取っていない）
- イディオムギャップ（下の表）: 交互のappendは回避形の3倍の命令（崖は消えて定数倍だけ残った形）。シリアライザは入れ子が深いほど合成のコピーが効く（d6で +33%）
- Goの温のビルドが2.5倍速い（題材1本で0.09 vs 0.23 s）

### イディオムギャップ（素直形 (b) / 回避形 (a) − 1 — 0に近いほど「綺麗な書き方 = 速い書き方」）

計測環境: 手元（AMD Ryzen AI MAX PRO 390（12物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10の取り直しの当時）・Go 1.26.1・perf 7.2.6） — 逐次の表〔GitHub Actions〕とは別の機械。詳細は6節 <!-- benchsync:bench-env-local -->

| 書き方の対 | 命令 | cycles |
|---|---|---|
| k-nucleotide: mapを作って返すvs mut out | +0.4% | +5.4% |
| JSONデコード: structを返すvs mut out | −9.1% | −11.0% |
| シリアライザ: 片を返して合成vs builder（深さ2 / 4 / 6） | +0.1% / +15.7% / +32.9% | +2.7% / +14.0% / +29.4% |
| appendの交互vs逐次 | +201% | +390% |
| mapの交互の挿入vs逐次 | +9.3% | −17.4% |
| `s = s + x` のループvs bytesのbuilder | −13.8% | +8.4% |
| io: ストリームvs一括の読み込み | +2.2% | +31.7% |

再現: `scripts/idiomgap.sh -n 3`（3回の中央値・cyclesは揺れる）。素直形の方が速い対（JSONデコード・concat）もある。

## 6. 環境と再現

<!-- benchsync:begin bench-env -->
- 逐次・外部ソート（[data/official.tsv](data/official.tsv)）: GitHub Actions linux-x64-16vcpu（AMD EPYC 9V45 96-Core Processor・kernel 6.17.0-1022-azure・run 40160907459）・Go 1.26.1・Rust 1.89.0・perf 6.17.13。1つのvCPU（最後のvCPU）に固定。同じラベルでもマシンのCPUの型番がrunで変わるので、公式に取り込むのはベースラインと同じ型番のrunだけ（`scripts/benchfetch.sh` が照合）
- 並列・コンパイラ自身・イディオムギャップ（[par/README.md](par/README.md)・本ファイルの2・3・5節）: 手元AMD Ryzen AI MAX PRO 390（12物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10の取り直しの当時）・Go 1.26.1・perf 7.2.6。並列は物理コアごとに1論理CPUの8つに固定した
- 逐次の表は `SOBER_WORKERS=1` で走らせる（stdの内側の並列 — 大きい入力のutf8.Checkの区間分割 — を逐次の列に混ぜない。並列の効果は [par/README.md](par/README.md) のW軸で見る）
<!-- benchsync:end bench-env -->
- Go側は各題材の素直形（benchmarks gameの定番か、公式が最初に教える形）。Sober側も素直縛り（速く書くための作法を使わない — それが要るならイディオムギャップとして登録する）
- benchとgatesは同時に回さない

```sh
scripts/bench.sh -n 5        # 逐次 9 題材（wall / RSS 中央値）+ ビルドの時間 + 自己 check / build + ラチェット
bench/seqperf.sh -n 5        # 同じ実行ファイルで cycles / 命令 / wall 最小 / RSS（床なし）
scripts/idiomgap.sh -n 3     # イディオムギャップ
# 並列は par/README.md の再現の節
```

<!-- benchsync:begin bench-raw -->
### 逐次の生データ（2026-10-25 — 木a8bfbd8a・GitHub Actions linux-x64-16vcpu（AMD EPYC 9V45 96-Core Processor・kernel 6.17.0-1022-azure・run 40160907459））

bench/seqperf.sh -n 5 --rust（raw = bench/data/raw/2026-10-25-40160907459/seqperf.tsv・CPU時間はtask-clockの中央・RSSは最大・wallは中央）:

| 題材 | wall中央s Sober / Go | CPU時間 中央s Sober / Go | 最大RSS MB Sober / Go |
|---|---|---|---|
| 1brc | 0.251 / 0.382 | 0.241 / 0.372 | 0.4 / 240.3 |
| binarytrees | 0.520 / 1.691 | 0.510 / 1.679 | 17.0 / 50.5 |
| fannkuch | 2.158 / 2.087 | 2.149 / 2.078 | 0.3 / 5.7 |
| fasta | 0.221 / 0.329 | 0.193 / 0.306 | 0.3 / 3.5 |
| revcomp | 0.061 / 0.071 | 0.047 / 0.060 | 24.4 / 29.9 |
| knucleotide | 0.838 / 2.692 | 0.825 / 2.681 | 52.6 / 78.3 |
| nbody | 0.204 / 0.303 | 0.196 / 0.295 | 0.3 / 5.7 |
| spectralnorm | 0.157 / 0.159 | 0.148 / 0.151 | 0.3 / 5.7 |
| mandelbrot | 0.783 / 0.755 | 0.773 / 0.746 | 1.9 / 5.7 |
<!-- benchsync:end bench-raw -->

指標はCPU時間（task-clock）の、同じ周の対の比の5周の中央。wallは5回の中央（参考）。cyclesと命令数はGitHub ActionsのVMでは取れない（命令数の規律はgatesのラチェット〔bench/ratchet.txt〕が見る）。 <!-- benchsync:bench-raw-note -->
