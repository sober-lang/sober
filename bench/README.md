# Sober vs Go — 現在地

- 逐次 9 題材（対 Go・cycles・±5% を互角）: 勝ち 6・互角 3（spectral-norm 0.99×・mandelbrot 1.03×・fannkuch-redux 1.05×）・負け 0。最も差が大きいのは binary-trees 0.26× <!-- benchsync:bench-go -->
- RSS は 9 題材中 8 題材で Go 以下（0.002×〜0.92×）。上回るのは mandelbrot（1.05×） <!-- benchsync:bench-rss-go -->
- 対 Rust の双子（逐次 9 題材・2026-10-19）: Sober の 3 勝・4 互角・2 敗（負けは reverse-complement 1.48×・n-body 1.17× — 下の「Rust の双子との比較」） <!-- benchsync:bench-rust -->
- 並列: Skynet（111 万 task）は Go の 5 倍速く、binary-trees 並列は W8 で 2.5 倍速い。RSS は 1/17〜1/500（Skynet — 2026-10-10 取り直し）。メモリの天井を細めても死なず、逐次の速さまで滑らかに落ちる（[par/README.md](par/README.md)）

最終更新 2026-10-19（逐次 = 木 39ec63a8 — `bench/seqperf.sh -n 5 --rust`・raw = out/bench/seqperf-20261019-174016.tsv・数字の正 = [data/official.tsv](data/official.tsv)。並列 = 2026-10-08〜10 の取り直しのまま — 日付は [par/README.md](par/README.md) の各節）。生データと測り方は [par/README.md](par/README.md)（並列）と本ファイルの末尾（逐次）。 <!-- benchsync:bench-updated -->

## 1. 逐次 9 題材

<!-- benchsync:begin bench-seq -->
| 題材（規模） | cycles:u G Sober / Go | 比 | wall 中央 s Sober / Go | 比 | 最大 RSS MB Sober / Go | 比 |
|---|---|---|---|---|---|---|
| 1BRC（1,000 万行）※ | 1.10 / 1.54 | 0.71× | 0.25 / 0.48 | 0.51× | 0.4 / 237 | 0.002× |
| binary-trees（18） | 2.09 / 8.03 | 0.26× | 0.54 / 1.79 | 0.30× | 17 / 50 | 0.34× |
| fannkuch-redux（11） | 9.73 / 9.30 | 1.05× | 2.08 / 2.00 | 1.04× | 0.2 / 1.8 | 0.11× |
| fasta（250 万） | 0.84 / 1.32 | 0.64× | 0.20 / 0.31 | 0.64× | 0.2 / 1.8 | 0.11× |
| reverse-complement | 0.15 / 0.22 | 0.68× | 0.07 / 0.08 | 0.81× | 24 / 26 | 0.92× |
| k-nucleotide | 3.66 / 13.08 | 0.28× | 0.87 / 2.86 | 0.30× | 53 / 75 | 0.70× |
| n-body（500 万） | 0.88 / 1.32 | 0.67× | 0.19 / 0.29 | 0.65× | 0.2 / 1.8 | 0.11× |
| spectral-norm（2000） | 0.67 / 0.67 | 0.99× | 0.15 / 0.16 | 0.94× | 0.2 / 2.0 | 0.10× |
| mandelbrot（4000） | 3.45 / 3.35 | 1.03× | 0.73 / 0.72 | 1.02× | 1.9 / 1.8 | 1.05× |
<!-- benchsync:end bench-seq -->

<!-- benchsync:begin bench-method -->
1 つの論理 CPU に固定し、Sober → Go → Rust の交互で 5 回測った。cycles は最小、wall は中央、RSS は最大をとり、命令数は決定的な値（wall を中央にするのは、EPOCHREALTIME の差が WSL2 で壊れた値〔0.1 s 級の飛び〕を含むことがあるため — 2026-10-14）。数字の正は [data/official.tsv](data/official.tsv) で、表と要約の行は `scripts/benchsync.sh` が生成する（gates の benchsync が文書との一致を見る）。出力は毎回 Sober ≡ Go で、fasta / revcomp / k-nucleotide / n-body / spectral-norm / mandelbrot は benchmarks game の公式の期待出力とも一致する。再現: `scripts/bench.sh -n 5`（実行ファイルと入力を置く）→ `bench/seqperf.sh -n 5 --rust`。
<!-- benchsync:end bench-method -->

- 物差しは cycles。命令数は 3 題材で Sober の方が多いが、cycles では互角かそれ以下に収まる（1 命令あたりの仕事が軽い — 依存の鎖・メモリ待ちで律速する形）。wall は同居の負荷（今回の loadavg 1.2〜1.9）で揺れるので参考 <!-- benchsync:bench-metric-note -->
- 前回（2026-10-12 — v0.5.3 の木）からの動き: 逐次 9 題材の cycles は ±2% の内（ベンチマークのコードは 1BRC 以外変えていない）。RSS は k-nucleotide が 86.5 → 75.6 MB（map の索引の巻き戻し）。1BRC は実装を差し替えた（下の※）
- ※ 1BRC は 2026-10-13 に実装を差し替えた（`io.ReadFile` で全体を読む形 → `io.Chunks` で 64 KiB の切片を写さずに借りて回す形。アルゴリズム・UTF-8 の全量検査は同じ）。
  旧の形は cycles 1.48 G（対 Rust 1.04×）・命令 3.84 G・wall 0.50 s・RSS 134 MB で、**cycles は差し替えで 6〜7% 悪くなった**（8 配置 × 3 周の中央 +6.4%・命令 +4.8% —
  行のループの利用者の空間の仕事が増えた。切り分けは積み）。一方 wall は 0.50 → 0.47 s（Rust 0.47 s と同等）・RSS は 134 → 0.6 MB（カーネル込みの task-clock は中央で同じ・最小 −3.5%）。物差しの偏り: cycles:u は利用者の空間だけを数え、旧の形が払っていたカーネルの写し（ファイル 136 MB を
  region へ読む read と、そのページを初めて触るフォールト）を数えない — 差し替えで消えたのはその分
- RSS の 0.4 MB は静的リンクの最小の常駐分。bench.sh の表の RSS（2 MB）は taskset 由来の床を含む（[par/README.md](par/README.md) の環境の節）

### ビルドの時間（同じ走り・中央値）

| | Sober | Go 冷（空の GOCACHE） | Go 温 |
|---|---|---|---|
| 題材 1 本の build | 0.19〜0.24 s | 2.1〜2.3 s | 0.07〜0.08 s |

Sober は std を焼き込んだ単一バイナリなので、冷 / 温の区別がほぼない。Go の温（runtime / std がキャッシュ済み）は Sober より 2.5〜3 倍速い。

<!-- benchsync:begin bench-rust-table -->
### Rust の双子との比較（2026-10-19 — 木 39ec63a8）

| 題材 | cycles:u G Sober / Go / Rust | Sober / Rust | Go / Rust | wall 中央 s Sober / Go / Rust | 最大 RSS MB Sober / Go / Rust |
|---|---|---|---|---|---|
| 1BRC ※ | 1.10 / 1.54 / 1.14 | 0.96× | 1.35× | 0.25 / 0.48 / 0.33 | 0.4 / 237 / 136 |
| binary-trees | 2.09 / 8.03 / 2.97 | 0.70× | 2.71× | 0.54 / 1.79 / 0.68 | 17 / 50 / 34 |
| fannkuch-redux | 9.73 / 9.30 / 10.01 | 0.97× | 0.93× | 2.08 / 2.00 / 2.13 | 0.2 / 1.8 / 2.1 |
| fasta | 0.84 / 1.32 / 1.12 | 0.76× | 1.18× | 0.20 / 0.31 / 0.26 | 0.2 / 1.8 / 2.4 |
| reverse-complement | 0.15 / 0.22 / 0.10 | 1.48× | 2.16× | 0.07 / 0.08 / 0.09 | 24 / 26 / 26 |
| k-nucleotide | 3.66 / 13.08 / 5.61 | 0.65× | 2.33× | 0.87 / 2.86 / 1.26 | 53 / 75 / 51 |
| n-body | 0.88 / 1.32 / 0.75 | 1.17× | 1.76× | 0.19 / 0.29 / 0.16 | 0.2 / 1.8 / 2.1 |
| spectral-norm | 0.67 / 0.67 / 0.65 | 1.03× | 1.04× | 0.15 / 0.16 / 0.14 | 0.2 / 2.0 / 2.1 |
| mandelbrot | 3.45 / 3.35 / 3.43 | 1.00× | 0.97× | 0.73 / 0.72 / 0.72 | 1.9 / 1.8 / 2.1 |
<!-- benchsync:end bench-rust-table -->

- 対 Rust（cycles・小数 2 桁で 0.95〜1.05× を互角）: Sober の 3 勝（k-nucleotide・binary-trees・fasta）・4 互角（1BRC・fannkuch-redux・mandelbrot・spectral-norm）・2 敗（reverse-complement 1.48×・n-body 1.17×）。Go は Rust に対して 1 勝（fannkuch-redux）・2 互角（mandelbrot・spectral-norm）・6 敗 <!-- benchsync:bench-rust-tally -->
- Rust の双子は `bench/<題材>/rust/main.rs`（Go の双子の逐語訳 — --release の既定・明示 SIMD / unsafe / 依存の crate なし）。測り方は上の表と同じ物差しで `bench/rust/build.sh` → `bench/seqperf.sh -n 5 --rust`（Sober → Go → Rust の交互・出力の一致を毎回）
- 取り方の恣意が残る題材: fasta / revcomp / mandelbrot は Go の 1 バイト書き（WriteByte）の鏡として `BufWriter` へ 1 バイトずつ書く（Rust の素直な書き方としては行単位のほうが多い — fasta の Rust は 1 バイト書きの値札を含む）。binary-trees は Go の「節ごとに new」の鏡として `Box`（benchmarks game の Rust は型つきアリーナ）。k-nucleotide と 1BRC の鍵は切片を借りる（Go の `m[string(b)]` が割り当てない形の鏡）
- 負けの帰属: 1BRC は map の引きと名前の UTF-8 の検査・切片の形の行のループの命令 +4.8%（2026-10-13 の差し替え — 未切り分け）・n-body は sqrt / div の鎖とスカラーに残る z の成分（SSE2 の 2 番地形では水平の和に得が無い）

<!-- benchsync:begin bench-extsort -->
### 外部ソート（2026-10-19 — 木 39ec63a8・`bench/extsort.sh -n 6`・入力 1 GiB・窓 64 MiB・W1・warm・交互 6 回）

| 実装 | wall 中央 s | task-clock 中央 s | cycles:u G | 最大 RSS MB | wall 対 Rust素 |
|---|---|---|---|---|---|
| Sober | 43.6 | 43.6 | 185.8 | 176.8 | 2.20× |
| Go | 29.5 | 29.1 | 126.1 | 533.2 | 1.49× |
| Rust素 | 19.8 | 19.7 | 82.7 | 179.2 | 1.00× |
| GNU sort | 21.8 | 21.5 | 83.5 | 67.3 | 1.10× |
<!-- benchsync:end bench-extsort -->

- 看板 = メモリの約束: Sober の RSS は入力の大きさ（256 MiB〜4 GiB）に依らず窓の約 2.8 倍で一定（Rust素と同じ水準・Go の 1/3 — 入力の大きさを振った図は 2026-10-14 01:39 の走り: Sober 177.0 / 177.0 / 177.0 MB・Go 454.8 / 538.4 / 536.9・Rust素 179.7 / 180.1 / 180.7・GNU sort 67.2 MB〔256 MiB / 1 GiB / 4 GiB〕）。run を 1 回の関数の呼び出しで組んで region ごと捨て、マージは k 本の枠を 1 本の mut のバイト列に持つ
- 速さは負け（wall で Rust素の 1.7 倍・Go の 1.7 倍）。経過: 107.5 s（2026-10-13 — std/sort へ差し替えた直後）→ 91.7 s（for の append の一括の写し — compiler の copyloop）→ 84.2 s（Writer への写しの一括化）→ 76.4 s（2026-10-14 01:39 — wall 最小。run の並べ替えを std/sort の `OrderUnstable` — pdqsort・作業域なし — へ。双子の Rust も `sort_unstable`。等しい行はバイト列ごと同じなので順は出力に現れない）。残りの帰属: 行の比較 `less`（1 バイトずつの比べのループ — 双子は memcmp）が最大
- 書き方の注: マージの 1 切片の読み（mut の引数を持つ関数）は式ブロックで包む。包まないと io.ChunksAt の 1 回ごとの読みの枠（2 × 64 KiB）が region 透過の鎖を通ってマージの間ずっと積もる（RSS が入力の約 2 倍）
- 4 GiB の wall（1 回）: Sober 384 s・Go 239 s・Rust素 312 s・GNU sort 147 s。raw = `out/bench/extsort-20261014-013908.tsv`

## 2. 並列（要約 — 詳細は [par/README.md](par/README.md)）

計測環境: 手元（AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10 の取り直しの当時）・Go 1.26.1・perf 7.2.6）。詳細は 6 節 <!-- benchsync:bench-env-local -->

- Skynet: task の生成と合流の費用と、細かい粒度（葉 ≤ 1 µs）の並列の数字は [par/README.md](par/README.md) の 1〜2 節
- binary-trees 並列: W8 で Go の 2.5 倍速く、RSS は 0.40 倍。並列版の W1 税は 6%
- 劣化曲線: 天井を細めると Sober は並列だけを畳んで逐次に落ちる（user ≈ wall・値は不変）。Go は GC が回り続けて wall 4〜8 倍・user 最大 10 s
- 負けている軸: 1BRC 並列は W8 で Go が 1.2 倍速い（W4 はほぼ互角の 1.06 倍・W2 以下は Sober が速い — 前回は W8 1.16 倍・W4 1.5 倍）。葉の太い task（≥ 3 µs）も Go が速い（葉の機械語の差 — -O2 水準レーン 6.5 の席）

## 3. コンパイラ自身

計測環境: 手元（AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10 の取り直しの当時）・Go 1.26.1・perf 7.2.6）。詳細は 6 節 <!-- benchsync:bench-env-local -->

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

- fannkuch 1.05×（cycles・対 Go — 2026-10-14・前回 1.06× の負け）: 互角の際。予測ミスが配置で二峰に割れる族（同一機械語で配置だけが決める）。関数の先頭 64 B の整列で「ほかの関数の変化」による峰の行き来は止めたが、予測器の索引の衝突そのものは規則にできていない。mandelbrot 1.03× は互角圏
- reverse-complement の RSS 1.74×（対 Go — Rust素 に対しても 1.84×）: 出力を全部溜めてから 1 回で書く素直形のため。io の書きバッファ（ストリーム形）のピン待ち
- 命令数そのもの（spectral-norm 1.21×・mandelbrot 1.17×・fannkuch 1.13× — 対 Go）: 命令の質の伸び代として残っている
- イディオムギャップ（下の表）: 交互の append は回避形の 3 倍の命令（崖は消えて定数倍だけ残った形）。シリアライザは入れ子が深いほど合成の写しが効く（d6 で +33%）
- Go の温のビルドが 2.5 倍速い（題材 1 本で 0.09 vs 0.23 s）

### イディオムギャップ（素直形 (b) / 回避形 (a) − 1 — 0 に近いほど「綺麗な書き方 = 速い書き方」）

計測環境: 手元（AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2（kernel 5.15 — 2026-10-08〜10 の取り直しの当時）・Go 1.26.1・perf 7.2.6）。詳細は 6 節 <!-- benchsync:bench-env-local -->

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
- 逐次・外部ソート（[data/official.tsv](data/official.tsv) — 2026-10-19）: 手元 AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2（kernel 6.18）・Go 1.26.1・Rust 1.89.0・perf 7.2.6。1 つの論理 CPU（最後のコア）に固定。loadavg は 2〜5 で同居の負荷があり、wall は ±50% 揺れるので主の物差しは cycles:u とした
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
### 逐次の生データ（2026-10-19 — 木 39ec63a8）

bench/seqperf.sh -n 5 --rust（raw = out/bench/seqperf-20261019-174016.tsv・RSS は最大・wall は中央）:

| 題材 | wall 中央 s Sober / Go | cycles:u G Sober / Go | 最大 RSS MB Sober / Go |
|---|---|---|---|
| 1brc | 0.246 / 0.483 | 1.10 / 1.54 | 0.4 / 236.7 |
| binarytrees | 0.541 / 1.791 | 2.09 / 8.03 | 17.0 / 49.9 |
| fannkuch | 2.075 / 1.996 | 9.73 / 9.30 | 0.2 / 1.8 |
| fasta | 0.197 / 0.307 | 0.84 / 1.32 | 0.2 / 1.8 |
| revcomp | 0.065 / 0.080 | 0.15 / 0.22 | 24.4 / 26.4 |
| knucleotide | 0.869 / 2.860 | 3.66 / 13.08 | 52.7 / 75.1 |
| nbody | 0.190 / 0.292 | 0.88 / 1.32 | 0.2 / 1.8 |
| spectralnorm | 0.147 / 0.157 | 0.67 / 0.67 | 0.2 / 2.0 |
| mandelbrot | 0.735 / 0.720 | 3.45 / 3.35 | 1.9 / 1.8 |
<!-- benchsync:end bench-raw -->

主の物差しは cycles（命令数は決定的な値だが表からは外した — 命令数の規律は gates のラチェット〔bench/ratchet.txt〕が見る）。wall は 5 回の中央（EPOCHREALTIME の差 — 同居の負荷で揺れ、壊れた値を含むことがある）。 <!-- benchsync:bench-raw-note -->
