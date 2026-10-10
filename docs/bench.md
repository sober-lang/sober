# bench — 性能の基準値（ロードマップ 4）

最適化に手を付ける前（ロードマップ 5 の性能投資の前）の Sober の数字を固定し、以後の変更をこの表との差で追う。
Go の双子は言語比較のためでなく追跡の物差し（同じアルゴリズム・同じ機械・同じ走りの中で測った参照点）。

## 題材

| 題材 | 中身 | 何の物差しか |
|---|---|---|
| bench/1brc（看板） | `<名前>;<気温>` の行を観測所ごとに min / mean / max で集計し、名前のバイト順に印字（気温は ×10 の整数・平均は floor((2 × 和 + 件数) / (2 × 件数))） | 入出力・バイト列の走査・map[string]・string の構築（UTF-8 検査込み） |
| bench/binarytrees | 深さ d の完全二分木を作っては数えて捨てる（benchmarks game） | 確保と回収 — Sober は木 1 本の arena（`mut []int`）を作って数える関数の region ごと捨てる・Go はポインタの木と GC |
| bench/fannkuch | fannkuch-redux の逐次版 | 整数の配列の添字アクセスとループ（境界検査の消去・ループ最適化） |
| bench/fasta | ALU の繰り返しと線形合同法の乱数による記号の選択を 1 行 60 文字で書く（benchmarks game）。Sober は float が無いので累積確率を整数の閾値に前計算 | 出力の構築と書き出し（書き出しの塊ごとに関数の region を捨てる） |
| bench/revcomp | fasta の出力を読み、記録ごとに配列を逆順の相補にして書く（reverse-complement） | 長い区間のバイト走査（scanb の的）・表引き・出力の構築 |
| bench/knucleotide | fasta の出力の ">THREE" の配列の長さ k の部分列を map[string]int で数える（k-nucleotide） | map（std の map の索引）の計器・イディオム双子（(b) 作って返す ↔ (a) mut out — 下の「イディオムギャップ」） |

各題材の Go の双子は `bench/<題材>/go`（同じアルゴリズムの素直な形）。逐次 9 題材には Rust の双子 `bench/<題材>/rust/main.rs` もある（2026-10-09 — Go の双子の逐語訳。--release の既定のまま・明示 SIMD / unsafe / 依存の crate なし。束ねは `bench/rust/Cargo.toml`・建て方 `bench/rust/build.sh` → `out/rust/release/`・測り方 `bench/seqperf.sh --rust`。Go と同じく追跡の物差し — 取り方の恣意が残る題材〔fasta / revcomp / mandelbrot の 1 バイト書き・binary-trees の Box〕は README に注記）。fasta / revcomp / k-nucleotide は benchmarks game の公式の n = 1000 の期待出力（`bench/<題材>/expect-1000.txt`）とも bench.sh の準備段で照合する（入力はファイル — 公式は標準入力）。1BRC の入力は `bench/1brc/gen`（決定的 — 自前の xorshift・413 個の合成の観測所名〔多バイトの名前を含む〕。公式の weather_stations.csv は使わない）。

## 計測の様式（scripts/bench.sh）

- `scripts/bench.sh [--quick | --heavy] [-n 回数]` — 既定 3 回の中央値。表（markdown）を標準出力へ・生の値（項目 wall user rss load）を out/bench/results-*.tsv へ
- 交互: 題材は 1 周ごとに Sober → Go の順で回す。比べるのは同じ走りの中の数字だけ（自己適用の CPU は時間帯で ±50% 動く）。各値に loadavg を添える
- 出力の一致（Sober ≡ Go）を毎回確かめる（食い違えば落ちる）
- build: Sober は `bin/sober build`（stage2 は温めてから — 作り直しは測らない・std は L0 の焼き込み）。Go は冷（空の GOCACHE — runtime / std から）と温（同じ GOCACHE でもう一度）の 2 列
- コンパイラ自身: stage2 で src/compiler/app を build（`--emit=elf --passes`）・一括の check・`check --split` の冷（空の置き場）と温（同じ置き場でもう一度）。木は stage2.sh の tree_of と同じ形（compiler/* + std/）
- 規模: 既定 = 1BRC 10M 行（138 MB）・binary-trees 18・fannkuch 11 / `--quick` = 1M・16・10（数秒 — 変更の当たりを付ける用）/ `--heavy` = 100M（1.4 GB）・21・12。
  1BRC の 10 億行は今は測れない: 入力 14 GB を `io.ReadFile` で一度に読む形しか無い（std に読みの口〔ReadFd の chunk 読み〕が無い — 開発スクリプトの波の「標準入力の最小形」と同じ積み）。読みの口が入ったら 1B を足す

## 基準値（初回 — 2026-10-03・f49f7db の木 + bench の追加）

機械: AMD Ryzen AI Max PRO 390（24 スレッド）・31 GB・WSL2（5.15.167.4）・Go 1.26.1。`scripts/bench.sh -n 3`（既定の規模）の中央値。
loadavg が 1.5〜6 と高めの時間帯（別の作業と同居）— 比率を見ること（絶対値は時間帯で揺れる）。

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

読み:
- 実行の比（Sober / Go の wall）: 1BRC 13×・fannkuch 4.9×・binary-trees 1.26×（user では 0.82× — Go は GC の並行分を払う）。binary-trees の RSS は Go の 0.56 倍（region の arena は木ごと捨てる — GC のヘッドルームが無い）。
  1BRC と fannkuch の差は最適化前の正規バックエンド（彩色なし・境界検査の消去なし・ループ最適化なし）の素の値 — ロードマップ 5 の性能投資の的。1BRC は 1 行ごとの `string(b[s:i])`（UTF-8 検査 + 写し）と map の string キーの比較も乗る
- build: Sober の 1 本 0.2 s は Go の温（0.1〜0.2 s）と同じ桁・Go の冷（runtime / std から 5 s）より 20 倍速い（std は L0 の焼き込み）
- コンパイラ自身: 自己 build 5.5 s / 506 MB・一括 check 17 s / 989 MB・小分けの check は冷 29 s / 700 MB → 温 3.7 s / 395 MB（L1 の置き場 — watch の 1 周の床と同じ層）

## 推移

| 日付 | 段 | 変化（命令数は quick の規模 — instructions:u・時間は既定の規模の中央値・同じ走りの交互） |
|---|---|---|
| 2026-10-03 | M0 map の索引（rt.map_find の線形走査 → 開番地法） | 1BRC: 命令数 16.34 G → 3.57 G（−78%）・wall 19.2 s → 3.7 s（Go 1.27 s の 2.9×・RSS 279 MB で不変）。他の 2 題材は map を使わない |
| 2026-10-03 | M1 SROA + GVN / CSE（+ 鎖 26 行目） | 命令数（quick）: fannkuch 9.98 G → 7.60 G（−24%）・binary-trees 9.48 G → 8.50 G（−10%）・1BRC（M0 後）3.57 G → 3.19 G（−11%）。wall（既定・3 回の中央値・M0 前のバイナリと交互）: fannkuch 12.1 → 11.0 s（Go 2.9 s）・binary-trees 4.6 → 2.7 s（Go 3.8 s — Sober が速い）・1BRC 15.2 → 3.2 s（Go 0.75 s）。自己 build 10.0 → 8.0 s・check --split 温 3.0 → 2.1 s（鎖の前後） |
| 2026-10-03 | M2 深度の流れ（ループの頭の region.setdepth を消す） | 命令数（quick）: fannkuch 7.60 G → 7.37 G（−3%）・binary-trees / 1BRC ほぼ不変 |
| 2026-10-03 | M3 分岐の畳み込み・境界検査の消去（証明級）+ LICM | 命令数（quick）: fannkuch 7.37 G → 6.76 G（−8% — main の panic の点 30 → 23）・binary-trees 8.49 G・1BRC 3.16 G |
| 2026-10-03 | M4 命令選択の融合（比較 → jcc 直・結果レジスタへ直の算術 / load / lea・次のブロックへの jmp の省略）+ `--backend=copy` の両持ち（elfeq / stages の cross は写しの側） | 命令数（quick）: fannkuch 6.76 G → 3.85 G（−43%）・binary-trees 8.49 G → 6.39 G（−25%）・1BRC 3.16 G → 2.24 G（−29%）。wall（既定・3 回の中央値・copy と交互・loadavg 3〜4）: fannkuch 8.83 → 7.54 s（Go 2.8〜4.1 s）・binary-trees 3.56 → 3.43 s（Go 3.2〜3.7 s）・1BRC 3.0 → 3.1 s（Go 0.8〜1.1 s — 揺れの範囲）。自己 build は不変（8.3 s — バックエンドの費用は誤差・stage2 自身への配当は鎖の行で） |
| 2026-10-03 | M2 の修理（深度の流れが同じ深度の別名を反復の中でも寄せる — M3 の後に戻っていたループの頭の setdepth を消す） | 命令数（quick）: fannkuch 3.85 G → 3.32 G（−14%）・binary-trees 6.39 G・1BRC 2.24 → 2.19 G |
| 2026-10-03 | M5 割り当ての改良（linear scan のまま: 辺の仮引数の生存を前任の出口から外す + ヒント〔辺の実引数 ↔ 仮引数・死ぬ左の被演算子〕・spill の費用 = ループの深さの重み ÷ 区間の長さ・panic の点のブロックを末尾へ・imm32 の定数は使う点で作り直す） | 命令数（quick）: fannkuch 3.32 G → 2.71 G（−18%）・binary-trees 6.39 G → 5.13 G（−20%）・1BRC 2.19 G → 1.74 G（−21%）。wall（既定・3 回の中央値・copy と交互・loadavg 5〜7）: fannkuch 9.48 → 6.63 s（Go 2.9〜3.0 s）・binary-trees 3.28 → 2.79 s（Go 3.2〜4.6 s）・1BRC 2.70 → 1.92 s（Go 1.0〜1.2 s） |
| 2026-10-04 | M6 IR インライナー（rtlower の後・最適化のバックエンドだけ — rt.region_enter / region_alloc と小関数。≤ 8 命令は常に・≤ 40 命令は呼び手が 400 命令以下のときだけ 400 命令まで）+ spill の費用の長さを 256 で頭打ち | 命令数（quick）: fannkuch 2.71 G → 2.73 G（±0）・binary-trees 5.13 G → 3.99 G（−22%）・1BRC 1.74 G → 1.63 G（−6%）。wall（既定・copy と交互・loadavg 5〜8 で揺れが大きい）: binary-trees 3.85 → 2.82 s（Go 3.2 s）・1BRC 3.61 → 2.48 s（Go 0.85〜1.1 s）・fannkuch 8.67 → 7.84 s（Go 2.8〜3.0 s）。src/compiler/app の ELF 5.20 → 5.91 MB（+14%）・自己 build の RSS 690 → 830 MB |
| 2026-10-04 | 段 5 第一便の総括（M0〜M6 + 鎖 28 行目 — scripts/bench.sh 既定・loadavg 3〜8） | 実行（wall・Sober / Go）: 1BRC 22.5 → 2.19 s（13× → 2.3×）・binary-trees 6.16 → 2.98 s（1.26× → 0.76× — Go より速い）・fannkuch 17.0 → 6.80 s（4.9× → 2.4×）。命令数（quick）: fannkuch 9.98 → 2.73 G（-O1 1.65 G の 1.66×）・binary-trees 9.48 → 3.99 G・1BRC 16.34 → 1.63 G。コンパイラ自身: 自己 build 5.53 → 6.86 s（+24%）/ RSS 506 → 815 MB・一括 check 17.2 → 8.75 s・check --split 冷 29.1 → 10.1 s / 温 3.67 → 1.13 s |
| 2026-10-04 | 段 5 の仕上げ便（自己 build の予算）: パスの関数ごとの呼び出しを式ブロックで包む（mut 引数の関数は region 透過 — 包まないと全関数の作業域がモジュールのループに積もる）・IR の検証器は既定で最後に 1 回（段ごとは SOBER_VERIFY=each — gates）・ラチェット新設（bench/ratchet.txt: self/build wall ≤ 6.6 s・rss ≤ 660 MB — bench.sh と stages ゲートが照合） | 自己 build 6.86 s / 815 MB → 5.68 s / 483 MB（基準 5.53 s / 506 MB の +3% / −5%）。一括 check 10.35 s・check --split 冷 11.6 s / 温 1.24 s（変わらず）。gates の中の自己 build（段ごと検証）565 MB |
| 2026-10-04 | 第二便 M7 SIB（gep の使い道が同じブロックの load / store の番地だけなら gep を出さず [p + ix * 倍率 + 変位] で読み書き・定数の添字は変位へ。x86enc に SIB の 4 形 × 全組み合わせ 92,160 行） | 命令数（quick）: fannkuch 2.73 → 2.63 G（−4%）・binary-trees 3.99 → 3.88 G（−3%）・1BRC 1.63 → 1.45 G（−11%） |
| 2026-10-04 | 第二便 M8 区間（死んだ仮引数の除去 + 直列のブロックの併合〔rtlower / inline の後・opt のみ — cfgclean.sober〕・融合した番地を生存解析で gep の被演算子の使用に数えて別ブロックの使用も融合・割り当てを費用の高い順の彩色に〔linear scan の局所の選び方 → 優先度〕） | 命令数（quick）: fannkuch 2.63 → 2.00 G（-O1 の 1.21×）・binary-trees 3.88 → 3.93 G（+1%）・1BRC 1.45 → 1.41 G |
| 2026-10-04 | 第二便 M9 軽い region.enter（自分の深度で確保しないと構造で示せる関数 — 再帰の bottomUp / check — は深度 +1・上限の検査・bump の初期化だけ〔rlight.sober〕）+ インライン後の定数畳み込み・GVN（cfgclean） | 命令数（quick）: fannkuch 2.00 → 1.91 G（-O1 の 1.16×）・binary-trees 3.93 → 2.99 G（−24%）・1BRC 1.41 G。wall（bench.sh 既定・loadavg 3〜5）: fannkuch 3.25 s（Go 2.96）・binary-trees 1.50 s（Go 3.57 — 2.4 倍速）・1BRC 2.01 s（Go 0.93）。自己 build 6.64 s / 478 MB（鎖の前 — stage2 自身は M6 まで） |
| 2026-10-04 | 第二便 M10 2 のべき乗の定数での div / rem をシフト列に（idiv を消す — table.Get の chunk の番号）。table.Get へのインライン予算の指向は試して不採用（自己 build の命令 +5%・cycles +4%・ELF +33%） | 自己 build（stage3 の cycles:u・3 回）: 17.4 G → 15.1 G（−12%）（命令数は +2.6% — idiv の待ちが消える）。題材の命令数はほぼ不変（binary-trees 3.02 G — `len(a) / 2` が 4 命令 → 6 命令だが idiv なし） |
| 2026-10-04 | 第二便後の正式計測（2606d4c・scripts/bench.sh 既定・N=3・loadavg 3〜4） | 実行（wall・Sober / Go）: 1BRC 2.22 / 1.17 s（1.9×）・binary-trees 1.61 / 4.13 s（0.39× — 2.6 倍速）・fannkuch 3.54 / 3.17 s（1.12× — 僅差）。RSS: binary-trees 23 / 41 MB。コンパイラ自身: 自己 build 5.95 s / 465 MB（ラチェット 6.6 / 660 ok）・一括 check 9.38 s・check --split 冷 11.1 / 温 1.52 s。build の 1 本 0.2〜0.4 s（Go 温 0.1〜0.2 と同じ桁・Go 冷 3.4〜4.7 s） |
| 2026-10-04 | 第三便 M11 自動ベクトル化のスパイク（バイトの走査のループの前置きに scanb — SSE2・vec.sober）+ utf8 の検査に ASCII の区間の素直なループ + && の合流の飛び越し（cfgclean） | 1BRC: 命令数（quick）1.41 → 1.06 G・cycles（既定）4.04 → 3.9 G（ベクトル化の版とスカラーの版は同じ — 名前が短く 16 レーンに満たない。改善はスカラーの側）・wall 2.10 s（Go 0.96 — 2.2×）。fannkuch / binary-trees 不変。自己 build 6.04 s / 487 MB（命令 +3.7% — うちベクトル化のパス 1.7%）。DESIGN の収穫仮説 ①③④⑤ 立った・② 踏んだ（短い区間） |
| 2026-10-04 | 第三便 M12 1BRC の残り（SIMD の外）: map_hash を 8 バイトの語ずつ・read_file を region の先端へ直に読む（iobuf 4096 バイトからの写しを消す）。utf8 の検査の語読み（SWAR）・scanb の端数 8 バイトの SIMD の塊・str_eq の語化は試して不採用（命令は減るが cycles は +5% / +5% / ±0） | 1BRC: 命令数（quick）1.06 → 0.93 G・cycles（既定）3.9 → 3.5 G（Go 2.5 G）・wall 2.10 → 1.45 s（Go 0.96 — 1.5×）。fannkuch 1.92 G / binary-trees 3.02 G・自己 build 6.08 s / 470 MB（不変） |
| 2026-10-04 | 第三便 M13 ① UTF-8 の型つき証人（utf8.Check / Str — 全体を 1 回検査・名前は境界の 2 バイトだけ）② map_find の速い道（索引の持ち主 + 索引済みの数 == 長さの 2 語で引く — 作り直し・追いつきは書き換えの後の最初の引きだけ） | 1BRC: 命令数（quick）0.930 → 0.921 G・cycles（既定）3.54 → 3.36〜3.46 G（Go 2.5 G — 1.4×）。wall は計測の時間帯の負荷（loadavg 9）で揺れ — 1.71 s / Go 1.36 s。生成データの名前は非 ASCII が多く、全体の検査が seqLen の呼び出しで占められる（ASCII の長い区間が無いので scanb の本領が出ない） |
| 2026-10-04 | 第三便 M14: (a) map の索引の枠にハッシュの上位 32 ビットを同居（候補の上位が違えばセルとキーを読まない）(b) utf8.IndexInvalid の非 ASCII の速い道（2 バイト列・3 バイト列の普通の形を seqLen の呼び出しなしで）・任意 = map の挿入の O(n²) の修理（索引をセル列の後ろに確保していたので挿入ごとに全コピー — 挿入 2 万件で exit 102 だった）。(c) 行の分割は既に 1 走査（`;` までと `\n` までは互いに素な区間）— 2 走査目は全体の UTF-8 検査そのもの | 1BRC（既定・cycles 交互）: 3.70 → 3.50 G（Go 2.75 G — 1.27×）・命令 8.98 → 8.66 G・wall 0.85 s（Go 0.59〜0.66）。保証の対価 = cycles 14.7%・命令 18.7%・wall 16%（検査ゼロの診断ビルド 2.98 G / 0.71 s — Go の 1.08×・コミットしない）。自己 build 3.70 s / 482 MB |
| 2026-10-04 | 第三便 M15: 葉の region の省略（自分の深度で確保せず、region を使わない関数と rt だけを呼ぶ関数の enter / relocate / setdepth を消す — 深度の契約 = 再帰の資源の有界性の防御の読み・language.md 27 節） | 1BRC（既定・交互 5 回）: 命令 8.67 → 8.03 G（−7.4%）・cycles 3.54 → 3.48 G（−1.7%）。出来たコンパイラの自己 build は命令 −0.09%（出力同一）。bench.sh の self/build wall 6.84 / 7.66 s がラチェット 6.6 を超えたが同じ走りで Go の fannkuch も 1.89 → 3.67 s（機械の遅い時間帯）— 省略の有無の stage2 を交互に測ると同等（このパスは stage2 自身のコードに効かない）・RSS 475 MB |
| 2026-10-04 | bench 拡張（5.7）+ イディオム双子の計器: fasta・reverse-complement・k-nucleotide の双子（Sober / Go・公式の n = 1000 の期待出力と照合）・`scripts/idiomgap.sh` | 新 3 種目（既定 = fasta 2.5M・その出力を入力に・wall 中央値 / Go）: fasta 0.48 s / 0.65（0.74×）・revcomp 0.24 / 0.23（1.04×）・k-nucleotide 6.54 / 7.01（0.93×・命令は Go の 1.95×〔62.5 / 32.0 G〕— map_find 66%〔索引の枠の load 1 本に 19%〕・utf8.Str 14%・1 つの更新で引きが 2 回〔`c := m[k]; m[k] = …` — Go の `m[k]++` は 1 回〕）。scanb: revcomp は命令 −17% だが cycles +50%（掛かったのは見出しと `>` の走査で、副作用で熱い逆順のループのループ運搬値がスタックへ溢れた — store→load 転送が反復ごとのクリティカルパスに・`--no-vec` 版はレジスタ）・k-nucleotide 命令 −1.6%・fasta 中立。既存: 1BRC 1.32 / 0.85・binary-trees 1.52 / 3.80・fannkuch 3.16 / 2.86・自己 build 6.56 s / 488 MB（ラチェット ok） |
| 2026-10-04 | M16: ① レジスタ割り当ての重みのループの深さを自然ループで数える（吐く順の区間の近似が冷えた経路まで深く数え、熱いループの運搬値を spill していた）② map の引きの融合（`c := m[k]; m[k] = …` の 2 回の map_find を、支配と間の無害を確かめて 1 回に — lower/mapfuse.sober・構文は足さない） | cycles（交互 3 回）: ① revcomp −39%（scanb あり版が --no-vec 版と同等以上に）・fannkuch −11%・k-nucleotide −13% ② k-nucleotide 命令 62.5 → 41.7 G（Go 比 1.95× → 1.30×）。wall（bench.sh 中央値 / Go）: revcomp 0.15 / 0.19・k-nucleotide 4.77 / 8.10（0.59×）・fasta 0.38 / 0.54・fannkuch 3.36 / 2.95・binary-trees 1.63 / 4.16・1BRC 1.82 / 0.97。自己 build 5.23 s / 481 MB（ラチェット ok） |
| 2026-10-04 | float の段 第二便: float の 3 種目の双子（n-body 5M・spectral-norm 2000・mandelbrot 4000 — 公式の期待出力と照合）+ opt のバックエンドに xmm のレジスタクラス（xmm8〜15・callee-saved・費用順の彩色に同居・lt〜ge の比較を condbr と融合） | wall（既定・Sober / Go）— xmm 前（float を汎用レジスタで運び演算ごとに movq の往復）→ 後: n-body 2.13 → 1.32 s / 0.36（cycles 7.9 → 3.7 G — Go 1.3 G。残りは int 側: mut 引数の slice のヘッダの読み直し + 境界検査が添字ごとに 6〜7 命令）・spectral-norm 2.58 → 0.19 s / 0.18（1.06×）・mandelbrot 5.80 → 1.00 s / 1.01（0.99×）。既存: 1BRC 1.32 / 1.06・binary-trees 1.49 / 3.74・fannkuch 3.89 / 2.93・k-nucleotide 4.65 / 5.89。自己 build 6.38 s / 487 MB（ラチェット ok） |
| 2026-10-04 | JSON 第二便: conv.ParseFloat に Clinger の速い道 + JSON デコードの Go の双子（bench/jsondecode/go — encoding/json.Unmarshal で同じ struct へ） | 20 万件（33.7 MB）・固定コア・3 回: Sober 前 20.55 G 命令 / 7.2 G cycles / 2.9 s CPU → 後 12.37 G / 4.8 G / 2.2 s（−40% / −34%）・Go 5.96 G / 1.52 G / 0.69 s（Sober / Go = cycles 3.1×・RSS 789 MB / 110 MB）。残りの差 = 節の表の builder.Push・キーの線形の比較（json.Get）・RSS（文書全体の表 + 1 件ごとの写しが 1 つの region に積もる） |
| 2026-10-04 | 絶対値の修理（std）: builder.PushAll / PushStr・float の最短表現の速い道（正確な 10 進展開 ≤ 15 桁 — 多倍長なし）・strings.utoa の連結をやめる・strings.Join・json のキーの引き（欄の位置の手掛かり・バイト比較・重複の検査の長さの前判定）・json の節の表を上界で先に確保・map のハッシュの FNV の初期値を標準値に | シリアライザ（命令 / Go）: d=2 builder 8.76 → 5.49 G / 1.34・d=4 7.28 → 3.53 / 1.53・d=6 6.40 → 3.16 / 1.29（2.1〜4.1×）・pieces 13.5 / 16.4 / 19.0 → 9.3 / 9.9 / 12.0 G（ギャップ +69% / +181% / +279% — 分母が縮んで深さの傾きがより鮮明）・json.Encode 3.86〜6.18 G。JSON デコード 20 万件: 命令 12.37 → 8.85 G・cycles 4.8 → 3.37 G・RSS 789 → 457 MB（Go 5.95 G / 1.55 G / 110 MB — 1.49× / 2.2× / 4.2×） — 残りの RSS = Parse が自分の region で作った表 215 MB の戻りの境界コピー（宛先構築レーンの的）。FNV: 1BRC 8.101 → 8.109 G・k-nucleotide 42.187 → 42.193 G（誤差）。自己 build 49.0 G 命令（213 の 47.6 G — 焼き込む std のソースの増分）・wall 5.9〜6.8 s（loadavg 4〜5 — ラチェット 6.6 の際） |

## イディオムギャップ（scripts/idiomgap.sh — イディオムギャップ零化レーンの計器）

同じ題材を (a) 回避術の形（速いが書き味を曲げた形）と (b) 素直な形（書きたい形）の 2 本で書き、命令数のギャップ = (b) / (a) − 1 を追う（命令数が正・cycles は参考 — 時間帯で揺れる）。
機構（宛先構築〔RVO〕・チャネル限定透過・先端一致 concat …）を入れるたびに 0 へ近づくのを見る。0 に届いた対から「回避術は不要」と docs に数字で書ける。

| 双子 | (a) 回避術 | (b) 素直 | 基準値（2026-10-04・既定 = fasta 2.5M の入力・交互 5 回の中央値） |
|---|---|---|---|
| knucleotide/map-return | bench/knucleotide/mutout — 呼び手が map を作って `mut` で渡す | bench/knucleotide — frequencies が map を作って返す（戻りで呼び手の region へ写る） | 命令 62.490 → 62.542 G（+0.08%）・cycles は揺れの中（−5.5%）。`--quick`（250k）では +0.82% |
| jsondecode/struct-return（JSON 第一便） | bench/jsondecode/mutout — 手書きの読みが呼び手の置き場 `mut Rec` に書く（mut 引数の関数は region 透過 — tags の slice も呼び手の region に直に作られる） | bench/jsondecode — `json.Decode[Rec]` が作って返す（shape[T] の写しの関数 — 戻りの struct と tags の slice が呼び手の region へ写る） | 20万件（33.7 MB）: 命令 20.518 → 20.551 G（+0.16%）・cycles +0.8%。本物の仕事量（1 件 = 欄 7・slice 1・入れ子 1）でも返す形の写しは誤差 — RVO の配当はこの題材では小さい。熱い所は別（builder.Push 20%・キーの比較 text 23%・ParseFloat の多倍長 20% — 速い道が無い） |
| シリアライザ（JSON 第二便・宛先構築レーンの入口の計測） | bench/jsonencode/builder — mut builder を引き回して各節が直に積む | bench/jsonencode/pieces — 各節が自分の JSON の文字列を作って返し、親が子の片を繋ぐ（返るバイトが段ごとに写る） | 出力 12.6〜14.5 MB（葉 ≈ 30 万・入れ子の型 N0〜N5 の下から d 段・Go の Marshal と同じバイト列）。命令 (a) → (b): d=2 8.76 → 13.46 G（+54%）・d=4 7.28 → 16.40 G（+125%）・d=6 6.40 → 18.98 G（+197%）（cycles +43% / +106% / +171%）— ギャップは深さにほぼ比例（返る片が段ごとに写る量 ∝ 深さ — 配当 ∝ 返るバイト ÷ 仕事の仮説どおり。jsondecode / k-nucleotide の ±0.2% は返るバイトが小さい題材だった）。参考: json.Encode[T]（合成の builder 形）は (a) の +5〜7%（欄ごとの対応の辞書の引き）・Go の Marshal は 1.25〜1.52 G 命令（(a) の 1/5〜1/7 — Sober 側は 1 バイトずつの builder.Push が主・まとめて写す口が std に無い） |
| map 更新（M16 ②） | （Sober に回避術の綴りは無い — Go の `m[k]++` が物差し: 引き 1 回） | `c := m[k]; m[k] = if c != nil { c + 1 } else { 1 }`（引き 2 回の綴り） | k-nucleotide（fasta 2.5M）の命令: 融合前 62.5 G（Go 32.0 G の 1.95×）→ 融合後 41.7 G（1.30×）。map-return の双子は融合後 41.607 → 41.746 G（+0.33% — 分母が縮んだ分だけ比が上がった） |

- knucleotide のギャップが小さいのは題材の性質: fasta の乱数（線形合同法）の周期が 139968 なので、異なるキーの数が入力の長さによらず最大約 14 万に収まり、戻りの写し（キーの数に比例）が数え上げ（入力の長さに比例）に対して小さい。規模を上げるほどギャップは薄まる（250k で +0.82% → 2.5M で +0.08%）
- 写しが効く的（作って返す値の大きさが仕事の大半に比例する題材 — JSON デコードの結果の木・部分列を集めて返す形）を次の双子の候補にする

| 2026-10-04 | 夜間キャンペーン後の全種目計測（215 = FNV 標準化・PushAll・数の印字の速い道の後・scripts/bench.sh 既定・N=3・taskset 固定コア・loadavg 1.6〜3.4） | 実行（wall 中央値・Sober / Go）: binary-trees 1.44 / 5.04（0.29×）・k-nucleotide 3.60 / 6.70（0.54×）・fasta 0.63 / 0.70（0.90×）・fannkuch 4.59 / 4.09（1.12×）・1BRC 1.37 / 1.06（1.29×）・mandelbrot 1.45 / 1.12・spectral-norm 0.36 / 0.27（float 2 種は 211 時 0.99×/1.06× から悪化 — loadavg 3.4 の列・揺れの疑い・次の静かな計測で確認）・n-body 1.44 / 0.53（2.7× — int 側 LICM の的）・revcomp は wall が短すぎ雑音（min では勝ち）。自己 build 6.64 s / 487 MB — wall ラチェット 6.6 超えは正当な仕事の増加（std が json/conv/Join で +3.8%・命令 +3%）= wall が雑音と実増を区別できない実例 → 命令数の副ラチェットの採用根拠（掃除枠 E で実装） |
## 追い方

- 性能に効く変更の前後で `scripts/bench.sh`（必要なら `--quick`）を同じ時間帯に回し、この表と比で比べる。基準値を差し替えるのは意図した改善を入れたとき（日付・コミット・loadavg を添えて表ごと）
- 棄てた案: hyperfine 等の外部の計測器（依存を増やさない — `/usr/bin/time` と awk で足りる）・平均（外れ値に弱い — 中央値）・題材ごとに別々の時間帯で測る（時間帯の揺れが比に入る）
