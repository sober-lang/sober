# Sober vs Go — 現在地

- 逐次 9 題材（対 Go・CPU 時間〔task-clock〕・±5% を互角）: 勝ち 6・互角 3（spectral-norm 0.98×・fannkuch-redux 1.03×・mandelbrot 1.03×）・負け 0。最も差が大きいのは binary-trees 0.31× <!-- benchsync:bench-go -->
- RSS は 9 題材中 9 題材で Go 以下（0.002×〜0.82×）。上回る題材は無い <!-- benchsync:bench-rss-go -->
- 対 Rust の双子（逐次 9 題材・2026-10-25）: Sober の 4 勝・3 互角・2 敗（負けは reverse-complement 1.47×・n-body 1.17× — 下の「Rust の双子との比較」） <!-- benchsync:bench-rust -->
- 並列: Skynet（111 万 task）は Go の 5 倍速く、binary-trees 並列は W8 で 2.5 倍速い。RSS は 1/17〜1/500（Skynet — 2026-10-10 取り直し）。メモリの天井を細めても死なず、逐次の速さまで滑らかに落ちる（[par/README.md](par/README.md)）

最終更新 2026-10-25（逐次 = 木 a8bfbd8a — GitHub Actions linux-x64-16vcpu（AMD EPYC 9V45 96-Core Processor・kernel 6.17.0-1022-azure・run 40160907459） で `bench/seqperf.sh -n 5 --rust`・raw = bench/data/raw/2026-10-25-40160907459/seqperf.tsv・数字の正 = [data/official.tsv](data/official.tsv)。並列 = 2026-10-08〜10 の手元の取り直しのまま — 日付は [par/README.md](par/README.md) の各節）。生データと測り方は [par/README.md](par/README.md)（並列）と本ファイルの末尾（逐次）。 <!-- benchsync:bench-updated -->

## 1. 逐次 9 題材

<!-- benchsync:begin bench-seq -->
| 題材（規模） | CPU 時間 中央 s Sober / Go | 比 | wall 中央 s Sober / Go | 比 | 最大 RSS MB Sober / Go | 比 |
|---|---|---|---|---|---|---|
| 1BRC（1,000 万行）※ | 0.241 / 0.372 | 0.65× | 0.25 / 0.38 | 0.66× | 0.4 / 240 | 0.002× |
| binary-trees（18） | 0.510 / 1.679 | 0.31× | 0.52 / 1.69 | 0.31× | 17 / 51 | 0.34× |
| fannkuch-redux（11） | 2.149 / 2.078 | 1.03× | 2.16 / 2.09 | 1.03× | 0.3 / 5.7 | 0.05× |
| fasta（250 万） | 0.193 / 0.306 | 0.63× | 0.22 / 0.33 | 0.67× | 0.3 / 3.5 | 0.07× |
| reverse-complement | 0.047 / 0.060 | 0.79× | 0.06 / 0.07 | 0.86× | 24 / 30 | 0.82× |
| k-nucleotide | 0.825 / 2.681 | 0.31× | 0.84 / 2.69 | 0.31× | 53 / 78 | 0.67× |
| n-body（500 万） | 0.196 / 0.295 | 0.67× | 0.20 / 0.30 | 0.67× | 0.3 / 5.7 | 0.05× |
| spectral-norm（2000） | 0.148 / 0.151 | 0.98× | 0.16 / 0.16 | 0.99× | 0.3 / 5.7 | 0.04× |
| mandelbrot（4000） | 0.773 / 0.746 | 1.03× | 0.78 / 0.76 | 1.04× | 1.9 / 5.7 | 0.33× |
<!-- benchsync:end bench-seq -->

<!-- benchsync:begin bench-method -->
GitHub Actions linux-x64-16vcpu（AMD EPYC 9V45 96-Core Processor・kernel 6.17.0-1022-azure・run 40160907459） の 1 つの vCPU（最後の vCPU）に固定し、Sober → Go → Rust の交互で 5 周測った（準備の後に loadavg が 1.5 を割るまで待ってから）。物差しは CPU 時間（task-clock — カーネルの時間を含む）で、比は同じ周の対（Sober の周 i / 相手の周 i）の比の 5 周の中央をとる（周ごとに全実装に同時に乗る箱の揺れが打ち消される — 同じ箱で 3 run の比の幅は最大 3.7%・report-922）。表の CPU 時間と wall は中央、RSS は最大。GitHub Actions の VM はハードウェアのカウンタを出さないので cycles と命令数は無い（命令数の規律は gates のラチェットが見る）。数字の正は [data/official.tsv](data/official.tsv) で、表と要約の行は `scripts/benchsync.sh` が生成する（gates の benchsync が文書との一致を見る）。出力は毎回 Sober ≡ Go ≡ Rust で、fasta / revcomp / k-nucleotide / n-body / spectral-norm / mandelbrot は benchmarks game の公式の期待出力とも一致する。公式の再現: `.github/workflows/bench-official.yml`（workflow_dispatch）→ `scripts/benchfetch.sh <run-id>`。手元: `scripts/bench.sh -n 5`（実行ファイルと入力を置く）→ `bench/seqperf.sh -n 5 --rust`。
<!-- benchsync:end bench-method -->

- 物差しは CPU 時間（task-clock）。2026-10-19 までの手元（WSL2）の cycles:u は利用者の空間だけを数えたが、task-clock はカーネルの時間（ファイルの読み・ページフォールト）も含む — 入力を読む題材（1BRC・Web 3 本）は比が動く。wall は参考 <!-- benchsync:bench-metric-note -->
- 物差しの切り替え（2026-10-25）: 逐次・外部ソートの表は手元（WSL2）の cycles:u から GitHub Actions の CPU 時間（task-clock — 同じ周の対の比の中央）へ移った。2026-10-19 の手元の表と数字を並べて比べることはできない（機械も物差しも違う）。勝敗の分類は対 Go で同じ（勝ち 6・互角 3）・対 Rust は 1BRC が互角 0.96× → 勝ち 0.90× に動いた
- 再現性（同じ木 a8bfbd8a の 2 run — 2026-10-25 の run 40158674652 と 40160907459・同じ型番の箱）: 26 本の比（9 題材 + Web 3 本 + 外部ソートの対 Go / 対 Rust）のうち 21 本は 2 run の幅 ±3% 以内で、勝敗の分類は 26 本とも一致した。**1BRC・binary-trees・logagg の 3 題材は日ごとに ±10% 動く**（Go と Rust の同じバイナリ同士の比も別の日の run で 6〜13% 動いた — 箱の揺れ）。**外部ソート 1 GiB と k-nucleotide の対 Rust は ±3〜4%**（2 run で 3.0% / 3.1%）。この 5 本の比は幅を込みで読むこと
- ※ 1BRC は 2026-10-13 に実装を差し替えた（`io.ReadFile` で全体を読む形 → `io.Chunks` で 64 KiB の切片を写さずに借りて回す形。アルゴリズム・UTF-8 の全量検査は同じ）。以下は 2026-10-19 までの手元（WSL2・cycles:u）の分析:
  旧の形は cycles 1.48 G（対 Rust 1.04×）・命令 3.84 G・wall 0.50 s・RSS 134 MB で、**cycles は差し替えで 6〜7% 悪くなった**（8 配置 × 3 周の中央 +6.4%・命令 +4.8% —
  行のループの利用者の空間の仕事が増えた。切り分けは積み）。一方 wall は 0.50 → 0.47 s（Rust 0.47 s と同等）・RSS は 134 → 0.6 MB（カーネル込みの task-clock は中央で同じ・最小 −3.5%）。物差しの偏り: cycles:u は利用者の空間だけを数え、旧の形が払っていたカーネルの写し（ファイル 136 MB を
  region へ読む read と、そのページを初めて触るフォールト）を数えない — 差し替えで消えたのはその分。今の物差しの task-clock はこのカーネルの分も数える
- RSS の 0.4 MB は静的リンクの最小の常駐分。bench.sh の表の RSS（2 MB）は taskset 由来の床を含む（[par/README.md](par/README.md) の環境の節）

### ビルドの時間（同じ走り・中央値）

| | Sober | Go 冷（空の GOCACHE） | Go 温 |
|---|---|---|---|
| 題材 1 本の build | 0.19〜0.24 s | 2.1〜2.3 s | 0.07〜0.08 s |

Sober は std を焼き込んだ単一バイナリなので、冷 / 温の区別がほぼない。Go の温（runtime / std がキャッシュ済み）は Sober より 2.5〜3 倍速い。

<!-- benchsync:begin bench-rust-table -->
### Rust の双子との比較（2026-10-25 — 木 a8bfbd8a）

| 題材 | CPU 時間 中央 s Sober / Go / Rust | Sober / Rust | Go / Rust | wall 中央 s Sober / Go / Rust | 最大 RSS MB Sober / Go / Rust |
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

- 対 Rust（CPU 時間〔task-clock〕・小数 2 桁で 0.95〜1.05× を互角）: Sober の 4 勝（k-nucleotide・binary-trees・fasta・1BRC）・3 互角（fannkuch-redux・mandelbrot・spectral-norm）・2 敗（reverse-complement 1.47×・n-body 1.17×）。Go は Rust に対して 1 勝（fannkuch-redux）・2 互角（mandelbrot・spectral-norm）・6 敗 <!-- benchsync:bench-rust-tally -->
- Rust の双子は `bench/<題材>/rust/main.rs`（Go の双子の逐語訳 — --release の既定・明示 SIMD / unsafe / 依存の crate なし）。測り方は上の表と同じ物差しで `bench/rust/build.sh` → `bench/seqperf.sh -n 5 --rust`（Sober → Go → Rust の交互・出力の一致を毎回）
- 取り方の恣意が残る題材: fasta / revcomp / mandelbrot は Go の 1 バイト書き（WriteByte）の鏡として `BufWriter` へ 1 バイトずつ書く（Rust の素直な書き方としては行単位のほうが多い — fasta の Rust は 1 バイト書きの値札を含む）。binary-trees は Go の「節ごとに new」の鏡として `Box`（benchmarks game の Rust は型つきアリーナ）。k-nucleotide と 1BRC の鍵は切片を借りる（Go の `m[string(b)]` が割り当てない形の鏡）
- 負けの帰属（2026-10-19 までの手元の cycles の分析 — CPU 時間の物差しでは取り直していない）: n-body は sqrt / div の鎖とスカラーに残る z の成分（SSE2 の 2 番地形では水平の和に得が無い）。reverse-complement は未切り分け。1BRC は手元の cycles では互角（0.96×）で、map の引きと名前の UTF-8 の検査・切片の形の行のループの命令 +4.8% を帰属としていた — CPU 時間ではカーネルの読みの分を Sober が払わない形で勝ちに入った

<!-- benchsync:begin bench-extsort -->
### 外部ソート（2026-10-25 — 木 a8bfbd8a・`bench/extsort.sh -n 6`・入力 1 GiB・窓 64 MiB・W1・warm・交互 6 回）

| 実装 | wall 中央 s | CPU 時間 中央 s | 最大 RSS MB | CPU 時間 対 Rust素 |
|---|---|---|---|---|
| Sober | 33.6 | 33.6 | 176.9 | 2.09× |
| Go | 24.0 | 24.0 | 536.9 | 1.50× |
| Rust素 | 16.1 | 16.1 | 180.1 | 1.00× |
| GNU sort | 17.6 | 17.6 | 67.3 | 1.09× |
<!-- benchsync:end bench-extsort -->

- 看板 = メモリの約束: Sober の RSS は入力の大きさ（256 MiB〜4 GiB）に依らず窓の約 2.8 倍で一定（Rust素と同じ水準・Go の 1/2〜1/3 — 入力の大きさを振った図は 2026-10-25 の run 40160907459: Sober 176.9 / 176.9 / 176.9 MB・Go 346.7 / 418.5 / 536.9・Rust素 179.8 / 179.1 / 179.9・GNU sort 67.2 / 67.3 / 67.3 MB〔256 MiB / 1 GiB / 4 GiB〕）。run を 1 回の関数の呼び出しで組んで region ごと捨て、マージは k 本の枠を 1 本の mut のバイト列に持つ
- 速さは負け（CPU 時間で Rust素の 2.1 倍・Go の 1.4 倍 — 2026-10-25）。手元の wall の経過（2026-10-13〜14）: 107.5 s（2026-10-13 — std/sort へ差し替えた直後）→ 91.7 s（for の append の一括の写し — compiler の copyloop）→ 84.2 s（Writer への写しの一括化）→ 76.4 s（2026-10-14 01:39 — wall 最小。run の並べ替えを std/sort の `OrderUnstable` — pdqsort・作業域なし — へ。双子の Rust も `sort_unstable`。等しい行はバイト列ごと同じなので順は出力に現れない）。残りの帰属: 行の比較 `less`（1 バイトずつの比べのループ — 双子は memcmp）が最大
- 書き方の注: マージの 1 切片の読み（mut の引数を持つ関数）は式ブロックで包む。包まないと io.ChunksAt の 1 回ごとの読みの枠（2 × 64 KiB）が region 透過の鎖を通ってマージの間ずっと積もる（RSS が入力の約 2 倍）
- 4 GiB の wall（1 回 — 2026-10-25 の run 40160907459）: Sober 188.8 s・Go 131.7 s・Rust素 146.8 s・GNU sort 77.5 s。raw = `bench/data/raw/2026-10-25-40160907459/extsort.tsv`

## 2. 並列（要約 — 詳細は [par/README.md](par/README.md)）

計測環境: 手元（AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10 の取り直しの当時）・Go 1.26.1・perf 7.2.6） — 逐次の表〔GitHub Actions〕とは別の機械。詳細は 6 節 <!-- benchsync:bench-env-local -->

- Skynet: task の生成と合流の費用と、細かい粒度（葉 ≤ 1 µs）の並列の数字は [par/README.md](par/README.md) の 1〜2 節
- binary-trees 並列: W8 で Go の 2.5 倍速く、RSS は 0.40 倍。並列版の W1 税は 6%
- 劣化曲線: 天井を細めると Sober は並列だけを畳んで逐次に落ちる（user ≈ wall・値は不変）。Go は GC が回り続けて wall 4〜8 倍・user 最大 10 s
- 負けている軸: 1BRC 並列は W8 で Go が 1.2 倍速い（W4 はほぼ互角の 1.06 倍・W2 以下は Sober が速い — 前回は W8 1.16 倍・W4 1.5 倍）。葉の太い task（≥ 3 µs）も Go が速い（葉の機械語の差 — -O2 水準レーン 6.5 の席）

## 3. コンパイラ自身

計測環境: 手元（AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10 の取り直しの当時）・Go 1.26.1・perf 7.2.6） — 逐次の表〔GitHub Actions〕とは別の機械。詳細は 6 節 <!-- benchsync:bench-env-local -->

| | ワーカー 1 | W8（物理 8 コア固定） | peak RSS W1 / W8 |
|---|---|---|---|
| `sober check`（自分のソース一括） | 12.7 s | 3.4 s | 285 / 911 MB |
| `sober check --split` 温（変更なし） | — | 1.8 s（既定ワーカー・固定なし） | 231 MB |
| `sober build`（自分の ELF） | 5.6 s | 3.5 s | 245 / 652 MB |

compiler/ + std を写した木で測った（W 軸の詳細は [par/README.md](par/README.md) の 7 節）。再現: `scripts/bench.sh`（self/* の行 — `-par` の行は `SOBER_WORKERS=8` + 物理 8 コアの taskset で測る。既定ワーカー数〔この機は 24 論理 CPU〕だと束の子のヒープで RSS が機械のコア数に依存するため、2026-10-08 に物差しを揃えた）。

- 表の時間と RSS は 2026-10-08 の計測のまま

## 4. この数字が約束つきであること

- UTF-8: 文字列は常に有効な UTF-8。1BRC は入力の全バイトを検査し（切片の中の完全な行の範囲ごとに 1 回 — 改行で切るので文字の境界は割れない）、切り出しは定理で検査なしにしている — 「検査しない」で速いのではない
- 境界コピー: 関数・task・チャネルの境界を渡る値は写す意味論（別名による破壊が構造的にない）。速さは宛先構築など観測できない最適化で取り返している
- 決定性: 同じ版・同じ入力なら出力は同じバイト。並列の数字も W1 ≡ W8 のバイト一致の網（selfpar・schedfuzz・seqpar・parbudget）の下で測った
- GC なし: RSS は生きているデータの量に追従する（GC のヘッドルームがない）。Go の RSS には GOGC=100 のヘッドルームが含まれる

## 5. 負けている軸（帰属つき）

- 対 Go の負けは 0（2026-10-25 — CPU 時間）。互角の際に fannkuch-redux 1.03×・mandelbrot 1.03×（どちらも 2 run の幅 ±0.2% — 再現する差）。2026-10-14 の手元の cycles の分析: fannkuch は予測ミスが配置で二峰に割れる族（同一機械語で配置だけが決める）。関数の先頭 64 B の整列で「ほかの関数の変化」による峰の行き来は止めたが、予測器の索引の衝突そのものは規則にできていない
- 対 Rust の負け: reverse-complement 1.47×・n-body 1.17×（上の Rust の双子の節）・外部ソート 2.1×
- 命令数そのもの（spectral-norm 1.21×・mandelbrot 1.17×・fannkuch 1.13× — 対 Go・2026-10-19 までの手元の計測）: 命令の質の伸び代として残っている（GitHub Actions の箱はハードウェアのカウンタを出さないので、今の物差しでは取っていない）
- イディオムギャップ（下の表）: 交互の append は回避形の 3 倍の命令（崖は消えて定数倍だけ残った形）。シリアライザは入れ子が深いほど合成の写しが効く（d6 で +33%）
- Go の温のビルドが 2.5 倍速い（題材 1 本で 0.09 vs 0.23 s）

### イディオムギャップ（素直形 (b) / 回避形 (a) − 1 — 0 に近いほど「綺麗な書き方 = 速い書き方」）

計測環境: 手元（AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10 の取り直しの当時）・Go 1.26.1・perf 7.2.6） — 逐次の表〔GitHub Actions〕とは別の機械。詳細は 6 節 <!-- benchsync:bench-env-local -->

| 双子 | 命令 | cycles |
|---|---|---|
| k-nucleotide: map を作って返す vs mut out | +0.4% | +5.4% |
| JSON デコード: struct を返す vs mut out | −9.1% | −11.0% |
| シリアライザ: 片を返して合成 vs builder（深さ 2 / 4 / 6） | +0.1% / +15.7% / +32.9% | +2.7% / +14.0% / +29.4% |
| append の交互 vs 逐次 | +201% | +390% |
| map の交互の挿入 vs 逐次 | +9.3% | −17.4% |
| `s = s + x` のループ vs bytes の builder | −13.8% | +8.4% |
| io: ストリーム vs 溜め込み | +2.2% | +31.7% |

再現: `scripts/idiomgap.sh -n 3`（3 回の中央値・cycles は揺れる）。素直形の方が速い双子（JSON デコード・concat）もある。

## 6. 環境と再現

<!-- benchsync:begin bench-env -->
- 逐次・外部ソート（[data/official.tsv](data/official.tsv)）: GitHub Actions linux-x64-16vcpu（AMD EPYC 9V45 96-Core Processor・kernel 6.17.0-1022-azure・run 40160907459）・Go 1.26.1・Rust 1.89.0・perf 6.17.13。1 つの vCPU（最後の vCPU）に固定。同じラベルでも箱の CPU の型番が run で変わるので、公式に取り込むのは基線と同じ型番の run だけ（`scripts/benchfetch.sh` が照合）
- 並列・コンパイラ自身・イディオムギャップ（[par/README.md](par/README.md)・本ファイルの 2・3・5 節）: 手元 AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10 の取り直しの当時）・Go 1.26.1・perf 7.2.6。並列は物理コアごとに 1 論理 CPU の 8 つに固定した
- 逐次の表は `SOBER_WORKERS=1` で走らせる（std の内側の並列 — 大きい入力の utf8.Check の区間割り — を逐次の列に混ぜない。並列の配当は [par/README.md](par/README.md) の W 軸で見る）
<!-- benchsync:end bench-env -->
- Go 側は各題材の素直形（benchmarks game の定番か、公式が最初に教える形）。Sober 側も素直縛り（速く書くための作法を使わない — それが要るならイディオムギャップとして登録する）
- bench と gates は同時に回さない

```sh
scripts/bench.sh -n 5        # 逐次 9 題材（wall / RSS 中央値）+ ビルドの時間 + 自己 check / build + ラチェット
bench/seqperf.sh -n 5        # 同じ実行ファイルで cycles / 命令 / wall 最小 / RSS（床なし）
scripts/idiomgap.sh -n 3     # イディオムギャップ
# 並列は par/README.md の再現の節
```

<!-- benchsync:begin bench-raw -->
### 逐次の生データ（2026-10-25 — 木 a8bfbd8a・GitHub Actions linux-x64-16vcpu（AMD EPYC 9V45 96-Core Processor・kernel 6.17.0-1022-azure・run 40160907459））

bench/seqperf.sh -n 5 --rust（raw = bench/data/raw/2026-10-25-40160907459/seqperf.tsv・CPU 時間は task-clock の中央・RSS は最大・wall は中央）:

| 題材 | wall 中央 s Sober / Go | CPU 時間 中央 s Sober / Go | 最大 RSS MB Sober / Go |
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

物差しは CPU 時間（task-clock）の、同じ周の対の比の 5 周の中央。wall は 5 回の中央（参考）。cycles と命令数は GitHub Actions の VM では取れない（命令数の規律は gates のラチェット〔bench/ratchet.txt〕が見る）。 <!-- benchsync:bench-raw-note -->
