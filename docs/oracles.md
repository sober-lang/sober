# オラクル計画（2026-09-17）

sqlshape の形を全層に適用する: 静的な主張に対して、別経路の真実を機械的に用意し、差分を取る。期待値を手で書くテストは最小にし、「オラクルと食い違う入力を探す」を唯一のテスト形式にする。docs/formal.md「実装との照合」（Lean を型検査器と評価器のオラクルにする）はこの計画の一部。

## オラクルの 3 種類

| 種類 | 意味 | 例 |
|---|---|---|
| 外部の確立したツール | Sober 側の実装量ゼロで真実が手に入る。ビルドには使わずテストだけで使うので LLVM 非依存の方針と矛盾しない | llvm-mc、QEMU、clang、wasm 仕様インタプリタ、PostgreSQL |
| 自前の参照実装 | 証明対象であると同時に実行可能。正は 1 つ | Lean の型検査器と small-step 評価器、`-O0` ビルド |
| 実行時計測 | 静的な主張を動かして観測し、観測 ⊆ 導出を確認する。analyzer の健全性を実行で確かめる唯一の手段 | 計装ランタイムの効果記録、スタック高水位、Pool 未返却カウンタ |

## 層ごとのオラクル

| 層 | オラクル | 種類 | Phase |
|---|---|---|---|
| パーサ | parse → print → parse の不動点。加えて同じ PEG から tree-sitter で生成した第 2 パーサとの差分 | 自己整合 + 外部 | 0〜1 |
| 命令エンコーダ（x86_64 / ARM / RISC-V） | `llvm-mc`（無ければ GNU as）。命令列を生成して自前エンコードのバイト列とアセンブラ出力を比較 | 外部 | 0〜1 |
| 脱糖器（Zig） | Lean 側のコア AST パースが毎回「体系の項か」を検査（formal.md）。等価性は直接のオラクルが無く、末端の差分実行で捕まえる。緩和は「脱糖は構文変換で小さく保つ」 | 参照実装 | 2 |
| 型検査器 | Lean 製（本番 → Zig 再実装後はオラクル。formal.md 順序 5） | 参照実装 | 2 |
| codegen（全バックエンド） | Lean の small-step 評価器で走らせた結果 vs ネイティブ実行の結果。ARM / RISC-V は QEMU で実行。全バックエンドが Lean と一致し、互いにも一致する | 参照実装 + 外部 | 1〜、6 |
| 最適化器 | `-O0` ビルドとの差分実行。意味が最適化器に依存しない決定（design-dev.md「決め方の型」4）により差分は純粋 | 自己整合 | 1〜 |
| region の escape | 解放した region を poison し、debug ビルドで dangling を検出。Lean の region 木（formal.md 段 2 の計装付き評価器）との差分 | 計測 + 参照実装 | 2 |
| ランタイム 5a / 5b | Lean 意味論のトレース照合、TLA+（チャネル / join）、決定的シミュレーション（design-dev.md Phase 5） | 参照実装 | 5 |
| スタック上界 | debug ビルドでスタックを塗り、高水位 ≤ リンク時に計算した上界 | 計測 | 5 |
| analyzer: 効果導出 | 計装ランタイムで実際の syscall / ブロッキングを記録し、観測 ⊆ 導出。導出が漏らしたら不健全 | 計測 | 4 |
| analyzer: エラーラベル導出 | fuzz で実際に返ったラベルを記録し、観測 ⊆ 導出 | 計測 | 4 |
| analyzer: acquire / release | debug ビルドの Pool 未返却カウンタ | 計測 | 3〜4 |
| `@layout(c)` / `@export(c)` | clang。同じ struct を C で宣言して `offsetof` / `sizeof` を比較、export 関数を C ハーネスから呼ぶ | 外部 | 6 |
| wasm → x86_64 AOT | WebAssembly 公式の仕様インタプリタ（OCaml）と公式テストスイート | 外部 | 6 |
| std/strings（2026-09-26〜） | Go の strings パッケージ。scripts/strings_oracle.ts が 1 つのケース表から Sober の example と Go の双子を生成し、Go の出力を .out にする | 外部 | 随時回収 |
| std/rand（2026-10-02〜） | 参照実装（xoshiro128 — Blackman / Vigna）を uint32 の wrap で写した Go の双子 scripts/oracles/rand_xoshiro.go が examples/rand_xoshiro.out を作る（写しは公開の既知の列 = 状態 {1,2,3,4} から 11520 0 5927040 … で確かめ — 標準エラーに出す）。std/rand は int の上で 32 bit の算術を桁に割って書くので、uint32 と一致すればよい | 外部 | 随時回収 |
| std/hash・std/hex（2026-10-02〜） | Go の crypto/sha256（16 進は encoding/hex）を使う双子 scripts/oracles/hash_sha256.go が examples/hash_sha256.out を作る。NIST の公式ベクタ（FIPS 180-2 付録 B の "abc"・448 bit・100 万個の 'a' + 896 bit・空入力）の期待値を双子に固定し、crypto/sha256 と照合（標準エラー — 食い違いは exit 1）。例はブロック境界（55/56/57/63/64/65/119/120/127/128/129 バイト）と 100003 バイトの長入力も通す | 外部 | 随時回収 |
| `Value` 変換の生成物 | round trip + 既存 JSON 実装（wasm 経由）との差分 | 自己整合 + 外部 | Web アプリ題材 |
| SoberSQL | PostgreSQL 本体（sqlshape の構成そのまま） | 外部 | SoberSQL 題材 |

## 共通の駆動部

生成器は 1 本。formal.md 段 2 の `plausible` 生成器が Sober コアの小プログラムを JSON テストベクタとして吐き、パーサから codegen まで同じプログラム集合を流す。敵対的テスト（sqlshape）と同じで、生成器の分布を「オラクルと食い違いそうな形」に寄せていく。

## 運用

- Phase ごとに「その Phase のオラクル」を先に用意し、実装はオラクルに対する差分ゼロで完了とする（dandori の全行トレースと同じ受理条件）
- オラクルの側が間違っていた場合（外部ツールのバグ、Lean の未証明部分）は記録して、差分を「既知の食い違い」として明示的に除外する。黙って合わせない
- 用意できない場所は上表に「直接のオラクルが無い」と書く（現状は脱糖器の等価性だけ）
