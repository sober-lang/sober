# Sober vs Go — 現在地

- 逐次 9 題材: cycles で 7 題材が Go より少なく、mandelbrot は互角（1.03×）。負けは fannkuch（1.06×）だけ。binary-trees は 0.21×、1BRC は UTF-8 を全量検査したうえで 0.64×
- RSS は 9 題材中 7 題材で Go を下回る（0.07〜0.56 倍）。上回るのは revcomp（1.63×）と k-nucleotide（1.08× — Go の RSS は回ごとに揺れる）
- 対 Rust の双子（逐次 9 題材・2026-10-12）: Sober の 5 勝・2 互角・2 敗（負けは n-body 1.18×・1BRC 1.12× — 下の「Rust の双子との比較」）
- 並列: Skynet（111 万 task）は Go の 5 倍速く、binary-trees 並列は W8 で 2.5 倍速い。RSS は 1/17〜1/500（Skynet — 2026-10-10 取り直し）。メモリの天井を細めても死なず、逐次の速さまで滑らかに落ちる（[par/README.md](par/README.md)）

最終更新 2026-10-12（逐次 = v0.5.3 の木 — `bench/seqperf.sh -n 5 --rust`・raw = out/bench/seqperf-20261012-192207.tsv。並列 = 2026-10-08〜10 の取り直しのまま — 日付は [par/README.md](par/README.md) の各節）。生データと測り方は [par/README.md](par/README.md)（並列）と本ファイルの末尾（逐次）。

## 1. 逐次 9 題材

| 題材（規模） | cycles:u Sober / Go | 比 | wall 最小 s Sober / Go | 比 | 命令 比 | 最大 RSS MB Sober / Go | 比 |
|---|---|---|---|---|---|---|---|
| 1BRC（1,000 万行） | 1.59 / 2.49 G | 0.64× | 0.51 / 0.80 | 0.64× | 0.77× | 134 / 240 | 0.56× |
| binary-trees（18） | 2.95 / 14.32 | 0.21× | 1.05 / 4.31 | 0.24× | 0.34× | 16 / 49 | 0.33× |
| fannkuch-redux（11） | 8.85 / 8.39 | 1.06× | 2.42 / 2.55 | 0.95× | 1.13× | 0.4 / 5.7 | 0.07× |
| fasta（250 万） | 0.89 / 1.44 | 0.62× | 0.28 / 0.53 | 0.53× | 0.67× | 0.4 / 5.6 | 0.07× |
| reverse-complement | 0.20 / 0.43 | 0.46× | 0.11 / 0.16 | 0.67× | 0.73× | 49 / 30 | 1.63× |
| k-nucleotide | 7.13 / 17.32 | 0.41× | 2.07 / 5.27 | 0.39× | 0.64× | 87 / 80 | 1.08× |
| n-body（500 万） | 0.88 / 1.32 | 0.67× | 0.25 / 0.38 | 0.66× | 0.81× | 0.4 / 5.7 | 0.07× |
| spectral-norm（2000） | 0.67 / 0.67 | 0.99× | 0.20 / 0.20 | 1.01× | 1.21× | 0.4 / 5.7 | 0.07× |
| mandelbrot（4000） | 3.46 / 3.35 | 1.03× | 1.09 / 1.04 | 1.04× | 1.17× | 2.0 / 5.7 | 0.34× |

1 つの論理 CPU に固定し、Sober → Go → Rust の交互で 5 回測った。cycles と wall は最小、RSS は最大をとり、命令数は決定的な値。出力は毎回 Sober ≡ Go で、fasta / revcomp / k-nucleotide / n-body / spectral-norm / mandelbrot は benchmarks game の公式の期待出力とも一致する。再現: `scripts/bench.sh -n 5`（実行ファイルと入力を置く）→ `bench/seqperf.sh -n 5 --rust`。

- 物差しは cycles。命令数は 3 題材で Sober の方が多いが、cycles では互角かそれ以下に収まる（1 命令あたりの仕事が軽い — 依存の鎖・メモリ待ちで律速する形）。wall は同居の負荷（今回の loadavg 1.4〜2.3）で揺れるので参考
- 前回（2026-10-08）からの動き: k-nucleotide −48%・n-body −32%・binary-trees −24%・1BRC −21%（cycles — ベンチマークのコードは変えずコンパイラの改善だけ。中身は [CHANGELOG](../CHANGELOG.ja.md) の v0.5.1〜v0.5.3）。fasta / revcomp / spectral-norm は ±1% の内、mandelbrot +4%・fannkuch +2% は配置で揺れる族（命令はそれぞれ −8%・−2%）
- RSS の 0.4 MB は静的リンクの最小の常駐分。bench.sh の表の RSS（2 MB）は taskset 由来の床を含む（[par/README.md](par/README.md) の環境の節）

### ビルドの時間（同じ走り・中央値）

| | Sober | Go 冷（空の GOCACHE） | Go 温 |
|---|---|---|---|
| 題材 1 本の build | 0.19〜0.24 s | 2.1〜2.3 s | 0.07〜0.08 s |

Sober は std を焼き込んだ単一バイナリなので、冷 / 温の区別がほぼない。Go の温（runtime / std がキャッシュ済み）は Sober より 2.5〜3 倍速い。

### Rust の双子との比較（2026-10-12 — v0.5.3 の木）

| 題材 | cycles:u G Sober / Go / Rust | Sober / Rust | Go / Rust | 命令 Sober / Rust | wall 最小 s Sober / Go / Rust | 最大 RSS MB Sober / Go / Rust |
|---|---|---|---|---|---|---|
| 1BRC | 1.59 / 2.49 / 1.43 | 1.12× | 1.74× | 0.88× | 0.51 / 0.80 / 0.42 | 134 / 240 / 136 |
| binary-trees | 2.95 / 14.32 / 4.16 | 0.71× | 3.44× | 0.73× | 1.05 / 4.31 / 1.19 | 16 / 49 / 34 |
| fannkuch-redux | 8.85 / 8.39 / 9.02 | 0.98× | 0.93× | 1.37× | 2.42 / 2.55 / 2.72 | 0.4 / 5.7 / 2.2 |
| fasta | 0.89 / 1.44 / 1.15 | 0.78× | 1.25× | 1.32× | 0.28 / 0.53 / 0.50 | 0.4 / 5.6 / 2.3 |
| reverse-complement | 0.20 / 0.43 / 0.25 | 0.81× | 1.74× | 1.43× | 0.11 / 0.16 / 0.13 | 49 / 30 / 26 |
| k-nucleotide | 7.13 / 17.32 / 8.10 | 0.88× | 2.14× | 0.79× | 2.07 / 5.27 / 2.59 | 87 / 80 / 52 |
| n-body | 0.88 / 1.32 / 0.75 | 1.18× | 1.77× | 1.50× | 0.25 / 0.38 / 0.22 | 0.4 / 5.7 / 2.3 |
| spectral-norm | 0.67 / 0.67 / 0.64 | 1.03× | 1.04× | 1.37× | 0.20 / 0.20 / 0.21 | 0.4 / 5.7 / 2.4 |
| mandelbrot | 3.46 / 3.35 / 3.44 | 1.00× | 0.97× | 1.19× | 1.09 / 1.04 / 0.97 | 2.0 / 5.7 / 2.4 |

- 対 Rust（cycles・1.00〜1.05× を互角）: Sober の 5 勝（binary-trees・fasta・revcomp・k-nucleotide・fannkuch）・2 互角（mandelbrot・spectral-norm）・2 敗（n-body 1.18×・1BRC 1.12×）。Go は Rust に対して 2 勝（fannkuch・mandelbrot）・1 互角（spectral-norm）・6 敗
- Rust の双子は `bench/<題材>/rust/main.rs`（Go の双子の逐語訳 — --release の既定・明示 SIMD / unsafe / 依存の crate なし）。測り方は上の表と同じ物差しで `bench/rust/build.sh` → `bench/seqperf.sh -n 5 --rust`（Sober → Go → Rust の交互・出力の一致を毎回）
- 取り方の恣意が残る題材: fasta / revcomp / mandelbrot は Go の 1 バイト書き（WriteByte）の鏡として `BufWriter` へ 1 バイトずつ書く（Rust の素直な書き方としては行単位のほうが多い — fasta の Rust は 1 バイト書きの値札を含む）。binary-trees は Go の「節ごとに new」の鏡として `Box`（benchmarks game の Rust は型つきアリーナ）。k-nucleotide と 1BRC の鍵は切片を借りる（Go の `m[string(b)]` が割り当てない形の鏡）
- 負けの帰属: 1BRC は map の引きと名前の UTF-8 の検査・n-body は sqrt / div の鎖とスカラーに残る z の成分（SSE2 の 2 番地形では水平の和に得が無い）

## 2. 並列（要約 — 詳細は [par/README.md](par/README.md)）

- Skynet: W8 で 0.064 s vs Go 0.27 s。task 1 つは 649 cycles vs 2,825。細かい粒度（葉 ≤ 1 µs）の並列は Sober が 2〜3 倍速い
- binary-trees 並列: W8 で Go の 2.5 倍速く、RSS は 0.40 倍。並列版の W1 税は 6%
- 劣化曲線: 天井を細めると Sober は並列だけを畳んで逐次に落ちる（user ≈ wall・値は不変）。Go は GC が回り続けて wall 4〜8 倍・user 最大 10 s
- 負けている軸: 1BRC 並列は W8 で Go が 1.2 倍速い（W4 はほぼ互角の 1.06 倍・W2 以下は Sober が速い — 前回は W8 1.16 倍・W4 1.5 倍）。葉の太い task（≥ 3 µs）も Go が速い（葉の機械語の差 — -O2 水準レーン 6.5 の席）

## 3. コンパイラ自身

| | ワーカー 1 | W8（物理 8 コア固定） | peak RSS W1 / W8 |
|---|---|---|---|
| `sober check`（自分のソース一括） | 12.7 s | 3.4 s | 285 / 911 MB |
| `sober check --split` 温（変更なし） | — | 1.8 s（既定ワーカー・固定なし） | 231 MB |
| `sober build`（自分の ELF） | 5.6 s | 3.5 s | 245 / 652 MB |

compiler/ + std を写した木で測った（W 軸の詳細は [par/README.md](par/README.md) の 7 節）。再現: `scripts/bench.sh`（self/* の行 — `-par` の行は `SOBER_WORKERS=8` + 物理 8 コアの taskset で測る。既定ワーカー数〔この機は 24 論理 CPU〕だと束の子のヒープで RSS が機械のコア数に依存するため、2026-10-08 に物差しを揃えた）。

- 表の時間と RSS は 2026-10-08 の計測のまま。自己 build の命令数は 2026-10-12 に 52.42 G（10-08 の 59.06 G から −11%）。ラチェット（bench/ratchet.txt）は 53.0 G

## 4. この数字が約束つきであること

- UTF-8: 文字列は常に有効な UTF-8。1BRC は入力の全量（136 MB）を 1 回検査し、切り出しは定理で検査なしにしている — 「検査しない」で速いのではない
- 境界コピー: 関数・task・チャネルの境界を渡る値は写す意味論（別名による破壊が構造的にない）。速さは宛先構築など観測できない最適化で取り返している
- 決定性: 同じ版・同じ入力なら出力は同じバイト。並列の数字も W1 ≡ W8 のバイト一致の網（selfpar・schedfuzz・seqpar・parbudget）の下で測った
- GC なし: RSS は生きているデータの量に追従する（GC のヘッドルームがない）。Go の RSS には GOGC=100 のヘッドルームが含まれる

## 5. 負けている軸（帰属つき）

- fannkuch 1.06×（cycles・対 Go）: 唯一の負け。予測ミスが配置で二峰に割れる族（同一機械語で配置だけが決める）。関数の先頭 64 B の整列で「ほかの関数の変化」による峰の行き来は止めたが、予測器の索引の衝突そのものは規則にできていない。mandelbrot 1.03× は互角圏
- reverse-complement の RSS 1.63×（対 Go）: 出力を全部溜めてから 1 回で書く素直形のため。io の書きバッファ（ストリーム形）のピン待ち
- 命令数そのもの（spectral-norm 1.21×・mandelbrot 1.17×・fannkuch 1.13× — 対 Go）: 命令の質の伸び代として残っている
- イディオムギャップ（下の表）: 交互の append は回避形の 3 倍の命令（崖は消えて定数倍だけ残った形）。シリアライザは入れ子が深いほど合成の写しが効く（d6 で +33%）
- Go の温のビルドが 2.5 倍速い（題材 1 本で 0.09 vs 0.23 s）

### イディオムギャップ（素直形 (b) / 回避形 (a) − 1 — 0 に近いほど「綺麗な書き方 = 速い書き方」）

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

- AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2（kernel 5.15）・Go 1.26.1・perf 7.2.6
- 逐次は 1 つの論理 CPU（最後のコア）に、並列は物理コアごとに 1 論理 CPU の 8 つに固定した。逐次の表は `SOBER_WORKERS=1` で走らせる（std の内側の並列 — 大きい入力の utf8.Check の区間割り — を逐次の列に混ぜない。並列の配当は [par/README.md](par/README.md) の W 軸で見る）。loadavg は 2〜5 で、同居の負荷がある。wall は ±50% 揺れるので、主の物差しは cycles:u / 命令数とした
- Go 側は各題材の素直形（benchmarks game の定番か、公式が最初に教える形）。Sober 側も素直縛り（速く書くための作法を使わない — それが要るならイディオムギャップとして登録する）
- bench と gates は同時に回さない

```sh
scripts/bench.sh -n 5        # 逐次 9 題材（wall / RSS 中央値）+ ビルドの時間 + 自己 check / build + ラチェット
bench/seqperf.sh -n 5        # 同じ実行ファイルで cycles / 命令 / wall 最小 / RSS（床なし）
scripts/idiomgap.sh -n 3     # イディオムギャップ
# 並列は par/README.md の再現の節
```

### 逐次の生データ（2026-10-12 — v0.5.3 の木）

bench/seqperf.sh -n 5 --rust（loadavg 1.4〜2.3・RSS は最大）:

| 題材 | wall 最小 s Sober / Go | cycles:u G Sober / Go | 命令 G Sober / Go | 最大 RSS MB Sober / Go |
|---|---|---|---|---|
| 1brc | 0.510 / 0.801 | 1.59 / 2.49 | 3.71 / 4.81 | 133.8 / 240.4 |
| binarytrees | 1.048 / 4.311 | 2.95 / 14.32 | 11.31 / 33.25 | 16.0 / 48.5 |
| fannkuch | 2.422 / 2.553 | 8.85 / 8.39 | 20.58 / 18.24 | 0.4 / 5.7 |
| fasta | 0.282 / 0.528 | 0.89 / 1.44 | 1.30 / 1.93 | 0.4 / 5.6 |
| revcomp | 0.110 / 0.165 | 0.20 / 0.43 | 1.02 / 1.39 | 48.6 / 29.9 |
| knucleotide | 2.070 / 5.265 | 7.13 / 17.32 | 21.12 / 33.11 | 86.5 / 79.8 |
| nbody | 0.253 / 0.384 | 0.88 / 1.32 | 3.06 / 3.78 | 0.4 / 5.7 |
| spectralnorm | 0.203 / 0.202 | 0.67 / 0.67 | 3.68 / 3.04 | 0.4 / 5.7 |
| mandelbrot | 1.085 / 1.045 | 3.46 / 3.35 | 8.92 / 7.63 | 2.0 / 5.7 |

主の物差しは cycles と命令数。wall は 5 回の最小（EPOCHREALTIME の差 — 同居の負荷で揺れる）。
