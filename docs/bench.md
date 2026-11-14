# bench — 性能の基準値（ロードマップ4）

最適化に手を付ける前（ロードマップ5の性能投資の前）のSoberの数字を固定し、以後の変更をこの表との差で追う。
比較用のGoの実装は言語比較のためでなく追跡の基準（同じアルゴリズム・同じ機械・同じ走りの中で測った参照点）。

## 題材

| 題材 | 中身 | 何の指標か |
|---|---|---|
| bench/1brc（代表） | `<名前>;<気温>` の行を観測所ごとにmin / mean / maxで集計し、名前のバイト順に印字（気温は ×10の整数・平均はfloor((2 × 和 + 件数) / (2 × 件数))） | 入出力・バイト列の走査・map[string]・stringの構築（UTF-8検査込み） |
| bench/binarytrees | 深さdの完全二分木を作っては数えて捨てる（benchmarks game） | 確保と回収 — Soberは木1本のarena（`mut []int`）を作って数える関数のregionごと捨てる・Goはポインタの木とGC |
| bench/fannkuch | fannkuch-reduxの逐次版 | 整数の配列の添字アクセスとループ（境界検査の消去・ループ最適化） |
| bench/fasta | ALUの繰り返しと線形合同法の乱数による記号の選択を1行60文字で書く（benchmarks game）。累積確率を整数の閾値に前計算（書いた時点ではSoberにfloatが無かった — floatの実装後も、推移の表と比べられるよう固定小数点のまま） | 出力の構築と書き出し（書き出しのチャンクごとに関数のregionを捨てる） |
| bench/revcomp | fastaの出力を読み、記録ごとに配列を逆順の相補にして書く（reverse-complement） | 長い区間のバイト走査（scanbのターゲット）・表引き・出力の構築 |
| bench/knucleotide | fastaの出力の ">THREE" の配列の長さkの部分列をmap[string]intで数える（k-nucleotide） | map（stdのmapの索引）の計測・イディオムの書き方の対（(b) 作って返す ↔ (a) mut out — 下の「イディオムギャップ」） |
| bench/extsort（2026-10-13 — 実証のタスク その2） | 1行1キー（`[a-z]` 8〜32文字）のテキストをウィンドウW（既定64 MiB）より大きくても辞書順に並べる外部ソート（runをウィンドウの中で並べてio.WriteFile・k本のrunをio.ChunksAtで1切片ずつ引いてマージ・io.Writerで標準出力へ） | 読み + 書き + ウィンドウに縛られたメモリ（RSSが入力の大きさに比例しない）。相手 = GNU sort（`LC_ALL=C sort -S W --parallel=1`）とGo / Rustの比較用の実装。測り方 = `bench/extsort.sh`（seqperfの外 — 引数3つ・GNU sortの列・RSSの図） |

各題材の比較用のGoの実装は `bench/<題材>/go`（同じアルゴリズムの素直な形）。逐次9題材には比較用のRustの実装 `bench/<題材>/rust/main.rs` もある（2026-10-09 — 比較用のGoの実装の逐語訳。--releaseの既定のまま・明示SIMD / unsafe / 依存のcrateなし。ワークスペースは `bench/rust/Cargo.toml`・ビルド方法 `bench/rust/build.sh` → `out/rust/release/`・測り方 `bench/seqperf.sh --rust`。Goと同じく追跡の基準 — 取り方の恣意が残る題材〔fasta / revcomp / mandelbrotの1バイト書き・binary-treesのBox〕はREADMEに注記）。fasta / revcomp / k-nucleotideはbenchmarks gameの公式のn = 1000の期待出力（`bench/<題材>/expect-1000.txt`）ともbench.shの準備の段階で照合する（入力はファイル — 公式は標準入力）。1BRCの入力は `bench/1brc/gen`（決定的 — 自前のxorshift・413個の合成の観測所名〔多バイトの名前を含む〕。公式のweather_stations.csvは使わない）。

## 計測の様式（scripts/bench.sh）

- `scripts/bench.sh [--quick | --heavy] [-n 回数]` — 既定3回の中央値。表（markdown）を標準出力へ・生の値（項目wall user rss load）をout/bench/results-*.tsvへ
- 交互: 題材は1周ごとにSober → Goの順で回す。比べるのは同じ走りの中の数字だけ（自己適用のCPUは時間帯で ±50%動く）。各値にloadavgを添える
- 出力の一致（Sober ≡ Go）を毎回確認する（食い違えば落ちる）
- build: Soberは `bin/sober build`（stage2は温めてから — 作り直しは測らない・stdはL0の焼き込み）。Goは冷（空のGOCACHE — runtime / stdから）と温（同じGOCACHEでもう一度）の2列
- コンパイラ自身: stage2でsrc/compiler/appをbuild（`--emit=elf --passes`）・一括のcheck・`check --split` の冷（空の格納場所）と温（同じ格納場所でもう一度）。木はstage2.shのtree_ofと同じ形（compiler/* + std/）
- 規模: 既定 = 1BRC 10M行（138 MB）・binary-trees 18・fannkuch 11 / `--quick` = 1M・16・10（数秒 — 変更の当たりを付ける用）/ `--heavy` = 100M（1.4 GB）・21・12。
  1BRCの10億行: 逐次は2026-10-13に `io.Chunks`（切片ずつ・コピーしない — RSSは入力の大きさに依らない）の形へ差し替えたので測れる（1Bの規模の足し込みは保留）。並列版は全体を `io.ReadFile` で読む形のまま（区間を指して読むAPIが無い — 保留）

## 公式の数字の取り方（2026-10-20〜 — GitHub Actions・report-920〜923）

- 計測のworkflow（下のbench-official.ymlと、HttpArenaの形のhttparena.yml）は開発用のprivateリポジトリにだけあり、公開リポジトリには含まれない — 公開側で読めるのは結果（bench/data/official.tsvとbench/data/raw/）と、手元で同じ計測を回すscripts / benchの道具。
- 正はbench/data/official.tsv。README{,.ja}.md・bench/README.mdの数字の行・表・グラフは `scripts/benchsync.sh` の生成物（gatesのbenchsyncが照合）
- 計測 = `.github/workflows/bench-official.yml`（workflow_dispatch・linux-x64-16vcpu）: 版を固定（Go 1.26.1・Rust 1.89.0・zig 0.15.2）→ bootstrap → `BENCH_PREP=1 scripts/bench.sh -n 1`（入力と比較用の実装）→ loadavgが1.5を割るまで待つ → `bench/seqperf.sh -n 5 --rust` → `bench/extsort.sh` → rawとbench-env.txt（CPUの型番・カーネル・各版）をartifactに
- 指標 = task-clock（カーネルの時間を含むCPU時間）。このVMはハードウェアのカウンタを出さない（cycles / 命令はNA — report-921）。比は同じ周の対（Soberの周i / 相手の周i）の比の全周の中央（周ごとに全実装に乗るマシンの揺れを打ち消す — 同じマシンで3 runの幅は最大3.7%・report-922）。絶対値はrunごとに2〜9%動くので比だけで読む
- 取り込み = 手元で `scripts/benchfetch.sh <run-id>`: 型番の照合（ベースラインの `# env:` のcpuと違えば拒否 — 同じラベルでも9V45 / 9V74が来る）→ rawをbench/data/raw/<日付>-<run>/ へコピーし → `benchsync --import` → 文書の生成 → gatesのdocs範囲 → コミット（pushはユーザーの立ち会い）。下見は `--dry`（out/bench/gha-<run>/ に作るだけ）・run同士の再現性は `scripts/benchrepro.ts <official.tsv>...`（基準 = 比の幅 ±3%以内・±5%の勝敗の分類が一致）
- 手元（WSL2）のcyclesの計測は開発中の素振り・切り分けの道具として残る（本ファイルの以下の基準値とbench.shの規律）。並列（bench/par/）と自己buildの表は手元の数字のまま — bench/README.mdの各節に計測環境の記載がある

## 基準値（初回 — 2026-10-03・f49f7dbの木 + benchの追加）

機械: AMD Ryzen AI Max PRO 390（24スレッド）・31 GB・WSL2（5.15.167.4）・Go 1.26.1。`scripts/bench.sh -n 3`（既定の規模）の中央値。
loadavgが1.5〜6と高めの時間帯（別の作業と同居）— 比率を見ること（絶対値は時間帯で揺れる）。

| 項目 | wall s | user s | peak RSS MB | loadavg |
|---|---|---|---|---|
| build/sober/1brc | 0.24 | 0.21 | 129 | 3.16 |
| build/go-cold/1brc | 5.25 | 22.38 | 309 | 3.16 |
| build/go-warm/1brc | 0.09 | 0.08 | 25 | 3.30 |
| build/sober/binarytrees | 0.21 | 0.20 | 119 | 3.30 |
| build/go-cold/binarytrees | 5.57 | 20.79 | 326 | 3.30 |
| build/go-warm/binarytrees | 0.10 | 0.09 | 26 | 6.08 |
| build/sober/fannkuch | 0.23 | 0.20 | 131 | 6.08 |
| build/go-cold/fannkuch | 5.19 | 21.10 | 314 | 5.60 |
| build/go-warm/fannkuch | 0.21 | 0.15 | 26 | 5.60 |
| run/sober/1brc | 22.52 | 22.32 | 272 | 5.35 |
| run/go/1brc | 1.72 | 1.55 | 240 | 3.92 |
| run/sober/binarytrees | 6.16 | 6.08 | 23 | 3.92 |
| run/go/binarytrees | 4.90 | 7.38 | 41 | 3.85 |
| run/sober/fannkuch | 17.01 | 17.06 | 6 | 3.62 |
| run/go/fannkuch | 3.50 | 3.48 | 6 | 3.54 |
| self/build | 5.53 | 5.36 | 506 | 1.75 |
| self/check | 17.18 | 16.72 | 989 | 1.69 |
| self/check-split-cold | 29.05 | 28.48 | 700 | 1.51 |
| self/check-split-warm | 3.67 | 3.55 | 395 | 1.54 |

解釈:
- 実行の比（Sober / Goのwall）: 1BRC 13×・fannkuch 4.9×・binary-trees 1.26×（userでは0.82× — GoはGCの並行分を払う）。binary-treesのRSSはGoの0.56倍（regionのarenaは木ごと捨てる — GCのヘッドルームが無い）。
  1BRCとfannkuchの差は最適化前の正規バックエンド（彩色なし・境界検査の消去なし・ループ最適化なし）の素の値 — ロードマップ5の性能投資の対象。1BRCは1行ごとの `string(b[s:i])`（UTF-8検査 + コピー）とmapのstringキーの比較も乗る
- build: Soberの1本0.2 sはGoの温（0.1〜0.2 s）と同じ桁・Goの冷（runtime / stdから5 s）より20倍速い（stdはL0の焼き込み）
- コンパイラ自身: 自己build 5.5 s / 506 MB・一括check 17 s / 989 MB・小分けのcheckは冷29 s / 700 MB → 温3.7 s / 395 MB（L1の格納場所 — watchの1周の下限と同じ層）

## 推移

| 日付 | 段階 | 変化（命令数はquickの規模 — instructions:u・時間は既定の規模の中央値・同じ走りの交互） |
|---|---|---|
| 2026-10-03 | M0 mapの索引（rt.map_findの線形走査 → 開番地法） | 1BRC: 命令数16.34 G → 3.57 G（−78%）・wall 19.2 s → 3.7 s（Go 1.27 sの2.9×・RSS 279 MBで不変）。他の2題材はmapを使わない |
| 2026-10-03 | M1 SROA + GVN / CSE（+ ブートストラップチェーンの26行目） | 命令数（quick）: fannkuch 9.98 G → 7.60 G（−24%）・binary-trees 9.48 G → 8.50 G（−10%）・1BRC（M0後）3.57 G → 3.19 G（−11%）。wall（既定・3回の中央値・M0前のバイナリと交互）: fannkuch 12.1 → 11.0 s（Go 2.9 s）・binary-trees 4.6 → 2.7 s（Go 3.8 s — Soberが速い）・1BRC 15.2 → 3.2 s（Go 0.75 s）。自己build 10.0 → 8.0 s・check --split温3.0 → 2.1 s（チェーンの行の前後） |
| 2026-10-03 | M2深度の流れ（ループの頭のregion.setdepthを消す） | 命令数（quick）: fannkuch 7.60 G → 7.37 G（−3%）・binary-trees / 1BRCほぼ不変 |
| 2026-10-03 | M3分岐の畳み込み・境界検査の消去（証明級）+ LICM | 命令数（quick）: fannkuch 7.37 G → 6.76 G（−8% — mainのpanicの点30 → 23）・binary-trees 8.49 G・1BRC 3.16 G |
| 2026-10-03 | M4命令選択の融合（比較 → jcc直・結果レジスタへ直の算術 / load / lea・次のブロックへのjmpの省略）+ `--backend=copy` の両持ち（elfeq / stagesのcrossはcopyの側） | 命令数（quick）: fannkuch 6.76 G → 3.85 G（−43%）・binary-trees 8.49 G → 6.39 G（−25%）・1BRC 3.16 G → 2.24 G（−29%）。wall（既定・3回の中央値・copyと交互・loadavg 3〜4）: fannkuch 8.83 → 7.54 s（Go 2.8〜4.1 s）・binary-trees 3.56 → 3.43 s（Go 3.2〜3.7 s）・1BRC 3.0 → 3.1 s（Go 0.8〜1.1 s — 揺れの範囲）。自己buildは不変（8.3 s — バックエンドの費用は誤差・stage2自身への効果はチェーンの行で） |
| 2026-10-03 | M2の修理（深度の流れが同じ深度の別名を反復の中でも寄せる — M3の後に戻っていたループの頭のsetdepthを消す） | 命令数（quick）: fannkuch 3.85 G → 3.32 G（−14%）・binary-trees 6.39 G・1BRC 2.24 → 2.19 G |
| 2026-10-03 | M5割り当ての改良（linear scanのまま: 辺の仮引数の生存を前任の出口から外す + ヒント〔辺の実引数 ↔ 仮引数・死ぬ左の被演算子〕・spillの費用 = ループの深さの重み ÷ 区間の長さ・panicの点のブロックを末尾へ・imm32の定数は使う点で作り直す） | 命令数（quick）: fannkuch 3.32 G → 2.71 G（−18%）・binary-trees 6.39 G → 5.13 G（−20%）・1BRC 2.19 G → 1.74 G（−21%）。wall（既定・3回の中央値・copyと交互・loadavg 5〜7）: fannkuch 9.48 → 6.63 s（Go 2.9〜3.0 s）・binary-trees 3.28 → 2.79 s（Go 3.2〜4.6 s）・1BRC 2.70 → 1.92 s（Go 1.0〜1.2 s） |
| 2026-10-04 | M6 IRインライナー（rtlowerの後・最適化のバックエンドだけ — rt.region_enter / region_allocと小関数。≤ 8命令は常に・≤ 40命令は呼び手が400命令以下のときだけ400命令まで）+ spillの費用の長さを256で頭打ち | 命令数（quick）: fannkuch 2.71 G → 2.73 G（±0）・binary-trees 5.13 G → 3.99 G（−22%）・1BRC 1.74 G → 1.63 G（−6%）。wall（既定・copyと交互・loadavg 5〜8で揺れが大きい）: binary-trees 3.85 → 2.82 s（Go 3.2 s）・1BRC 3.61 → 2.48 s（Go 0.85〜1.1 s）・fannkuch 8.67 → 7.84 s（Go 2.8〜3.0 s）。src/compiler/appのELF 5.20 → 5.91 MB（+14%）・自己buildのRSS 690 → 830 MB |
| 2026-10-04 | フェーズ5の第1タスクの総括（M0〜M6 + チェーンの28行目 — scripts/bench.sh既定・loadavg 3〜8） | 実行（wall・Sober / Go）: 1BRC 22.5 → 2.19 s（13× → 2.3×）・binary-trees 6.16 → 2.98 s（1.26× → 0.76× — Goより速い）・fannkuch 17.0 → 6.80 s（4.9× → 2.4×）。命令数（quick）: fannkuch 9.98 → 2.73 G（-O1 1.65 Gの1.66×）・binary-trees 9.48 → 3.99 G・1BRC 16.34 → 1.63 G。コンパイラ自身: 自己build 5.53 → 6.86 s（+24%）/ RSS 506 → 815 MB・一括check 17.2 → 8.75 s・check --split冷29.1 → 10.1 s / 温3.67 → 1.13 s |
| 2026-10-04 | フェーズ5の仕上げのタスク（自己buildの予算）: パスの関数ごとの呼び出しを式ブロックで包む（mut引数の関数はregion透過 — 包まないと全関数の作業域がモジュールのループに積もる）・IRの検証器は既定で最後に1回（段階ごとはSOBER_VERIFY=each — gates）・ラチェット新設（bench/ratchet.txt: self/build wall ≤ 6.6 s・rss ≤ 660 MB — bench.shとstagesゲートが照合） | 自己build 6.86 s / 815 MB → 5.68 s / 483 MB（基準5.53 s / 506 MBの +3% / −5%）。一括check 10.35 s・check --split冷11.6 s / 温1.24 s（変わらず）。gatesの中の自己build（段階ごとの検証）565 MB |
| 2026-10-04 | 第2タスクM7 SIB（gepの使い道が同じブロックのload / storeの番地だけならgepを出さず [p + ix * 倍率 + 変位] で読み書き・定数の添字は変位へ。x86encにSIBの4形 × 全組み合わせ92,160行） | 命令数（quick）: fannkuch 2.73 → 2.63 G（−4%）・binary-trees 3.99 → 3.88 G（−3%）・1BRC 1.63 → 1.45 G（−11%） |
| 2026-10-04 | 第2タスクM8区間（死んだ仮引数の除去 + 直列のブロックの併合〔rtlower / inlineの後・optのみ — cfgclean.sober〕・融合した番地を生存解析でgepの被演算子の使用に数えて別ブロックの使用も融合・割り当てを費用の高い順の彩色に〔linear scanの局所の選び方 → 優先度〕） | 命令数（quick）: fannkuch 2.63 → 2.00 G（-O1の1.21×）・binary-trees 3.88 → 3.93 G（+1%）・1BRC 1.45 → 1.41 G |
| 2026-10-04 | 第2タスクM9軽いregion.enter（自分の深度で確保しないと構造で示せる関数 — 再帰のbottomUp / check — は深度 +1・上限の検査・bumpの初期化だけ〔rlight.sober〕）+ インライン後の定数畳み込み・GVN（cfgclean） | 命令数（quick）: fannkuch 2.00 → 1.91 G（-O1の1.16×）・binary-trees 3.93 → 2.99 G（−24%）・1BRC 1.41 G。wall（bench.sh既定・loadavg 3〜5）: fannkuch 3.25 s（Go 2.96）・binary-trees 1.50 s（Go 3.57 — 2.4倍速）・1BRC 2.01 s（Go 0.93）。自己build 6.64 s / 478 MB（チェーンの行の前 — stage2自身はM6まで） |
| 2026-10-04 | 第2タスクM10 2のべき乗の定数でのdiv / remをシフト列に（idivを消す — table.Getのchunkの番号）。table.Getへのインライン予算の指向は試して不採用（自己buildの命令 +5%・cycles +4%・ELF +33%） | 自己build（stage3のcycles:u・3回）: 17.4 G → 15.1 G（−12%）（命令数は +2.6% — idivの待ちが消える）。題材の命令数はほぼ不変（binary-trees 3.02 G — `len(a) / 2` が4命令 → 6命令だがidivなし） |
| 2026-10-04 | 第2タスクの後の正式計測（2606d4c・scripts/bench.sh既定・N=3・loadavg 3〜4） | 実行（wall・Sober / Go）: 1BRC 2.22 / 1.17 s（1.9×）・binary-trees 1.61 / 4.13 s（0.39× — 2.6倍速）・fannkuch 3.54 / 3.17 s（1.12× — 僅差）。RSS: binary-trees 23 / 41 MB。コンパイラ自身: 自己build 5.95 s / 465 MB（ラチェット6.6 / 660 ok）・一括check 9.38 s・check --split冷11.1 / 温1.52 s。buildの1本0.2〜0.4 s（Go温0.1〜0.2と同じ桁・Go冷3.4〜4.7 s） |
| 2026-10-04 | 第3タスクM11自動ベクトル化のスパイク（バイトの走査のループの前置きにscanb — SSE2・vec.sober）+ utf8の検査にASCIIの区間の素直なループ + && の合流の飛び越し（cfgclean） | 1BRC: 命令数（quick）1.41 → 1.06 G・cycles（既定）4.04 → 3.9 G（ベクトル化の版とスカラーの版は同じ — 名前が短く16レーンに満たない。改善はスカラーの側）・wall 2.10 s（Go 0.96 — 2.2×）。fannkuch / binary-trees不変。自己build 6.04 s / 487 MB（命令 +3.7% — うちベクトル化のパス1.7%）。DESIGNの収穫仮説 ①③④⑤ 立った・② 踏んだ（短い区間） |
| 2026-10-04 | 第3タスクM12 1BRCの残り（SIMDの外）: map_hashを8バイトのワードずつ・read_fileをregionの先端へ直に読む（iobuf 4096バイトからのコピーを消す）。utf8の検査のワード単位の読み込み（SWAR）・scanbの端数8バイトのSIMDのチャンク・str_eqのワード化は試して不採用（命令は減るがcyclesは +5% / +5% / ±0） | 1BRC: 命令数（quick）1.06 → 0.93 G・cycles（既定）3.9 → 3.5 G（Go 2.5 G）・wall 2.10 → 1.45 s（Go 0.96 — 1.5×）。fannkuch 1.92 G / binary-trees 3.02 G・自己build 6.08 s / 470 MB（不変） |
| 2026-10-04 | 第3タスクM13 ① UTF-8の型つき証人（utf8.Check / Str — 全体を1回検査・名前は境界の2バイトだけ）② map_findの速いパス（索引の持ち主 + 索引済みの数 == 長さの2ワードで引く — 作り直し・追いつきは書き換えの後の最初の引きだけ） | 1BRC: 命令数（quick）0.930 → 0.921 G・cycles（既定）3.54 → 3.36〜3.46 G（Go 2.5 G — 1.4×）。wallは計測の時間帯の負荷（loadavg 9）で揺れ — 1.71 s / Go 1.36 s。生成データの名前は非ASCIIが多く、全体の検査がseqLenの呼び出しで占められる（ASCIIの長い区間が無いのでscanbの本領が出ない） |
| 2026-10-04 | 第3タスクM14: (a) mapの索引の枠にハッシュの上位32ビットを同居（候補の上位が違えばセルとキーを読まない）(b) utf8.IndexInvalidの非ASCIIの速いパス（2バイト列・3バイト列の普通の形をseqLenの呼び出しなしで）・任意 = mapの挿入のO(n²) の修理（索引をセル列の後ろに確保していたので挿入ごとに全コピー — 挿入2万件でexit 102だった）。(c) 行の分割は既に1走査（`;` までと `\n` までは互いに素な区間）— 2走査目は全体のUTF-8検査そのもの | 1BRC（既定・cycles交互）: 3.70 → 3.50 G（Go 2.75 G — 1.27×）・命令8.98 → 8.66 G・wall 0.85 s（Go 0.59〜0.66）。保証の対価 = cycles 14.7%・命令18.7%・wall 16%（検査ゼロの診断ビルド2.98 G / 0.71 s — Goの1.08×・コミットしない）。自己build 3.70 s / 482 MB |
| 2026-10-04 | 第3タスクM15: 葉のregionの省略（自分の深度で確保せず、regionを使わない関数とrtだけを呼ぶ関数のenter / relocate / setdepthを消す — 深度の契約 = 再帰の資源の有界性の防御の解釈・language.md 27節） | 1BRC（既定・交互5回）: 命令8.67 → 8.03 G（−7.4%）・cycles 3.54 → 3.48 G（−1.7%）。出来たコンパイラの自己buildは命令 −0.09%（出力同一）。bench.shのself/build wall 6.84 / 7.66 sがラチェット6.6を超えたが同じ走りでGoのfannkuchも1.89 → 3.67 s（機械の遅い時間帯）— 省略の有無のstage2を交互に測ると同等（このパスはstage2自身のコードに効かない）・RSS 475 MB |
| 2026-10-04 | bench拡張（5.7）+ イディオムの書き方の対の計測ツール: fasta・reverse-complement・k-nucleotideの実装（Sober / Go・公式のn = 1000の期待出力と照合）・`scripts/idiomgap.sh` | 新3種目（既定 = fasta 2.5M・その出力を入力に・wall中央値 / Go）: fasta 0.48 s / 0.65（0.74×）・revcomp 0.24 / 0.23（1.04×）・k-nucleotide 6.54 / 7.01（0.93×・命令はGoの1.95×〔62.5 / 32.0 G〕— map_find 66%〔索引の枠のload 1本に19%〕・utf8.Str 14%・1つの更新で引きが2回〔`c := m[k]; m[k] = …` — Goの `m[k]++` は1回〕）。scanb: revcompは命令 −17%だがcycles +50%（掛かったのは見出しと `>` の走査で、副作用で熱い逆順のループのループ運搬値がスタックへ溢れた — store→load転送が反復ごとのクリティカルパスに・`--no-vec` 版はレジスタ）・k-nucleotide命令 −1.6%・fasta中立。既存: 1BRC 1.32 / 0.85・binary-trees 1.52 / 3.80・fannkuch 3.16 / 2.86・自己build 6.56 s / 488 MB（ラチェットok） |
| 2026-10-04 | M16: ① レジスタ割り当ての重みのループの深さを自然ループで数える（吐く順の区間の近似が冷えた経路まで深く数え、熱いループの運搬値をspillしていた）② mapの引きの融合（`c := m[k]; m[k] = …` の2回のmap_findを、支配と間の無害を確認して1回に — lower/mapfuse.sober・構文は足さない） | cycles（交互3回）: ① revcomp −39%（scanbあり版が --no-vec版と同等以上に）・fannkuch −11%・k-nucleotide −13% ② k-nucleotide命令62.5 → 41.7 G（Go比1.95× → 1.30×）。wall（bench.sh中央値 / Go）: revcomp 0.15 / 0.19・k-nucleotide 4.77 / 8.10（0.59×）・fasta 0.38 / 0.54・fannkuch 3.36 / 2.95・binary-trees 1.63 / 4.16・1BRC 1.82 / 0.97。自己build 5.23 s / 481 MB（ラチェットok） |
| 2026-10-04 | floatのフェーズ 第2タスク: floatの3種目と比較用の実装（n-body 5M・spectral-norm 2000・mandelbrot 4000 — 公式の期待出力と照合）+ optのバックエンドにxmmのレジスタクラス（xmm8〜15・callee-saved・費用順の彩色に同居・lt〜geの比較をcondbrと融合） | wall（既定・Sober / Go）— xmm前（floatを汎用レジスタで運び演算ごとにmovqの往復）→ 後: n-body 2.13 → 1.32 s / 0.36（cycles 7.9 → 3.7 G — Go 1.3 G。残りはint側: mut引数のsliceのヘッダの読み直し + 境界検査が添字ごとに6〜7命令）・spectral-norm 2.58 → 0.19 s / 0.18（1.06×）・mandelbrot 5.80 → 1.00 s / 1.01（0.99×）。既存: 1BRC 1.32 / 1.06・binary-trees 1.49 / 3.74・fannkuch 3.89 / 2.93・k-nucleotide 4.65 / 5.89。自己build 6.38 s / 487 MB（ラチェットok） |
| 2026-10-04 | JSONの第2タスク: conv.ParseFloatにClingerの速いパス + JSONデコードの比較用のGoの実装（bench/jsondecode/go — encoding/json.Unmarshalで同じstructへ） | 20万件（33.7 MB）・固定コア・3回: Sober前20.55 G命令 / 7.2 G cycles / 2.9 s CPU → 後12.37 G / 4.8 G / 2.2 s（−40% / −34%）・Go 5.96 G / 1.52 G / 0.69 s（Sober / Go = cycles 3.1×・RSS 789 MB / 110 MB）。残りの差 = 節の表のbuilder.Push・キーの線形の比較（json.Get）・RSS（文書全体の表 + 1件ごとのコピーが1つのregionに積もる） |
| 2026-10-04 | 絶対値の修理（std）: builder.PushAll / PushStr・floatの最短表現の速いパス（正確な10進展開 ≤ 15桁 — 多倍長なし）・strings.utoaの連結をやめる・strings.Join・jsonのキーの引き（フィールドの位置の手掛かり・バイト比較・重複の検査の長さの前判定）・jsonの節の表を上界で先に確保・mapのハッシュのFNVの初期値を標準値に | シリアライザ（命令 / Go）: d=2 builder 8.76 → 5.49 G / 1.34・d=4 7.28 → 3.53 / 1.53・d=6 6.40 → 3.16 / 1.29（2.1〜4.1×）・pieces 13.5 / 16.4 / 19.0 → 9.3 / 9.9 / 12.0 G（ギャップ +69% / +181% / +279% — 分母が縮んで深さの傾きがより鮮明）・json.Encode 3.86〜6.18 G。JSONデコード20万件: 命令12.37 → 8.85 G・cycles 4.8 → 3.37 G・RSS 789 → 457 MB（Go 5.95 G / 1.55 G / 110 MB — 1.49× / 2.2× / 4.2×） — 残りのRSS = Parseが自分のregionで作った表215 MBの戻りの境界コピー（宛先構築レーンの対象）。FNV: 1BRC 8.101 → 8.109 G・k-nucleotide 42.187 → 42.193 G（誤差）。自己build 49.0 G命令（213の47.6 G — 焼き込むstdのソースの増分）・wall 5.9〜6.8 s（loadavg 4〜5 — ラチェット6.6の際） |

## イディオムギャップ（scripts/idiomgap.sh — イディオムギャップ零化レーンの計測ツール）

同じ題材を (a) 回避術の形（速いが書き味を曲げた形）と (b) 素直な形（書きたい形）の2本で書き、命令数のギャップ = (b) / (a) − 1を追う（命令数が正・cyclesは参考 — 時間帯で揺れる）。
機構（宛先構築〔RVO〕・チャネル限定透過・先端一致concat …）を入れるたびに0へ近づくのを見る。0に届いた対から「回避術は不要」とdocsに数字で書ける。

| 書き方の対 | (a) 回避術 | (b) 素直 | 基準値（2026-10-04・既定 = fasta 2.5Mの入力・交互5回の中央値） |
|---|---|---|---|
| knucleotide/map-return | bench/knucleotide/mutout — 呼び手がmapを作って `mut` で渡す | bench/knucleotide — frequenciesがmapを作って返す（戻りで呼び手のregionへコピーされる） | 命令62.490 → 62.542 G（+0.08%）・cyclesは揺れの中（−5.5%）。`--quick`（250k）では +0.82% |
| jsondecode/struct-return（JSONの第1タスク） | bench/jsondecode/mutout — 手書きのパーサが呼び手の格納場所 `mut Rec` に書く（mut引数の関数はregion透過 — tagsのsliceも呼び手のregionに直に作られる） | bench/jsondecode — `json.Decode[Rec]` が作って返す（shape[T] の変換の関数 — 戻りのstructとtagsのsliceが呼び手のregionへコピーされる） | 20万件（33.7 MB）: 命令20.518 → 20.551 G（+0.16%）・cycles +0.8%。本物の仕事量（1件 = フィールド7・slice 1・入れ子1）でも返す形のコピーは誤差 — RVOの効果はこの題材では小さい。熱い所は別（builder.Push 20%・キーの比較text 23%・ParseFloatの多倍長20% — 速いパスが無い） |
| シリアライザ（JSONの第2タスク・宛先構築レーンの入口の計測） | bench/jsonencode/builder — mut builderを引き回して各節が直に積む | bench/jsonencode/pieces — 各節が自分のJSONの文字列を作って返し、親が子の片を繋ぐ（返るバイトが階層ごとにコピーされる） | 出力12.6〜14.5 MB（葉 ≈ 30万・入れ子の型N0〜N5の下からd階層・GoのMarshalと同じバイト列）。命令 (a) → (b): d=2 8.76 → 13.46 G（+54%）・d=4 7.28 → 16.40 G（+125%）・d=6 6.40 → 18.98 G（+197%）（cycles +43% / +106% / +171%）— ギャップは深さにほぼ比例（返る片が階層ごとにコピーされる量 ∝ 深さ — 効果 ∝ 返るバイト ÷ 仕事の仮説どおり。jsondecode / k-nucleotideの ±0.2%は返るバイトが小さい題材だった）。参考: json.Encode[T]（合成のbuilder形）は (a) の +5〜7%（フィールドごとの対応の辞書の引き）・GoのMarshalは1.25〜1.52 G命令（(a) の1/5〜1/7 — Sober側は1バイトずつのbuilder.Pushが主・まとめてコピーするAPIがstdに無い） |
| シリアライザの再帰形（再帰の型宣言D — 2026-11-04） | bench/jsonencode/builder（(a) と同じ — 入れ子の型N0〜N5） | bench/jsonencode/rec — 同じ書き方で型を再帰のstruct `N { …; kids []N }` 1本に（葉はkidsを書かない — 同じバイト列）。素直な形どうしの比はbench/jsonencode/pieces → recpieces | 命令（2026-11-04・HEADのstage2・perf stat 1回 — 上の行とは計測の版が違うので比だけを読む）(a) → rec: d=2 1.16 → 1.57 G（+35%）・d=4 1.43 → 2.44 G（+71%）・d=6 1.33 → 2.77 G（+108%）／pieces → recpieces: +34% / +65% / +91%。**再帰形の構築の深さ比例**（構築関数の返り境界ごとに部分木を呼び手のregionへコピーする — rec_relocate。O(節点 × 深さ)）— 宛先構築（再帰のループの構築関数を行き先で直に作る）で回収予定・この列がそのタスクのラチェットの対象 |
| map更新（M16 ②） | （Soberに回避術の綴りは無い — Goの `m[k]++` が基準: 引き1回） | `c := m[k]; m[k] = if c != nil { c + 1 } else { 1 }`（引き2回の綴り） | k-nucleotide（fasta 2.5M）の命令: 融合前62.5 G（Go 32.0 Gの1.95×）→ 融合後41.7 G（1.30×）。map-returnの書き方の対は融合後41.607 → 41.746 G（+0.33% — 分母が縮んだ分だけ比が上がった） |

- knucleotideのギャップが小さいのは題材の性質: fastaの乱数（線形合同法）の周期が139968なので、異なるキーの数が入力の長さによらず最大約14万に収まり、戻りのコピー（キーの数に比例）が数え上げ（入力の長さに比例）に対して小さい。規模を上げるほどギャップは薄まる（250kで +0.82% → 2.5Mで +0.08%）
- コピーが効く対象（作って返す値の大きさが仕事の大半に比例する題材 — JSONデコードの結果の木・部分列を集めて返す形）を次の書き方の対の候補にする

| 2026-10-04 | 夜間キャンペーン後の全種目計測（215 = FNV標準化・PushAll・数の印字の速いパスの後・scripts/bench.sh既定・N=3・taskset固定コア・loadavg 1.6〜3.4） | 実行（wall中央値・Sober / Go）: binary-trees 1.44 / 5.04（0.29×）・k-nucleotide 3.60 / 6.70（0.54×）・fasta 0.63 / 0.70（0.90×）・fannkuch 4.59 / 4.09（1.12×）・1BRC 1.37 / 1.06（1.29×）・mandelbrot 1.45 / 1.12・spectral-norm 0.36 / 0.27（float 2種は211時0.99×/1.06× から悪化 — loadavg 3.4の列・揺れの疑い・次の静かな計測で確認）・n-body 1.44 / 0.53（2.7× — int側LICMの対象）・revcompはwallが短すぎ雑音（minでは勝ち）。自己build 6.64 s / 487 MB — wallラチェット6.6超えは正当な仕事の増加（stdがjson/conv/Joinで +3.8%・命令 +3%）= wallが雑音と実増を区別できない実例 → 命令数の副ラチェットの採用根拠（クリーンアップEで実装） |
## 固定費の上限値（bench/ratchet.txt — gatesが照合）

- `srv/<題材> ireq` / `srv/<題材> hot64`（scripts/reqinst.sh — gatesのreqinst）: bench/httparena/main.soberのリクエスト1件の命令数と、リクエストごとに通る64 Bのコードの行の数（L1iに載るホットパスの大きさ）。callgrindで測るので同じELFなら揺れは1命令以下 — 上限値は揺れの幅だけ空けて引く。機能を足す変更でも、全リクエストのパスの固定費が増えれば赤になる（1回ずつの増分はGHAのA/Bの分解能 ±2.5〜3%の下に隠れ、積もってから気づくことになるため）
  - 題材 `asyncdb` だけは別のサーバ（bench/asyncdb — async-dbの20行をstd/pgのプールから読んでJSONに）を、PostgreSQLの代役（bench/pgstub — wire protocolだけを話し、決まった表を返す）を相手に測る。本物のPGの無いマシンでも、DBの客側（Bindの符号化・行の受け・JSONの組み立て）の1リクエストの命令を照合できる（代役と本物で1行あたりの命令は0.4命令の差）。代役はレスポンスの前に300 µs待たせ、サーバが毎回PGのレスポンスを待つパスを通る形にそろえる。それでもリクエストごとの待ちのパスが ±6命令揺れるので、この題材の余白は実測の最大 + 25。客・サーバ・代役でCPUを3つ使い、足りないマシンではasyncdbだけSKIP
- `self/check body`（scripts/selfpar.sh — gatesのselfpar）: 自己checkの検査器の本体（Defの脱糖の後から最後まで）の命令数。核の節の数に出ない検査器の遅さ（同じ節の数で3倍の時間）を拾う
- 越えたとき: 正当な増えなら、増えた理由を報告とコミットメッセージに書いて上限値を再設定する（事後承認）。下がったら下げて再設定する

## 追い方

- 性能に効く変更の前後で `scripts/bench.sh`（必要なら `--quick`）を同じ時間帯に回し、この表と比で比べる。基準値を差し替えるのは意図した改善を入れたとき（日付・コミット・loadavgを添えて表ごと）
- 棄てた案: hyperfine等の外部の計測器（依存を増やさない — `/usr/bin/time` とawkで足りる）・平均（外れ値に弱い — 中央値）・題材ごとに別々の時間帯で測る（時間帯の揺れが比に入る）
