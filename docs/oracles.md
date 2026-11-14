# オラクル計画（2026-09-17）

sqlshapeの形を全層に適用する: 静的な主張に対して、別経路の真実を機械的に用意し、差分を取る。期待値を手で書くテストは最小にし、「オラクルと食い違う入力を探す」を唯一のテスト形式にする。docs/formal.md「実装との照合」（Leanを型検査器と評価器のオラクルにする）はこの計画の一部。

## オラクルの3種類

| 種類 | 意味 | 例 |
|---|---|---|
| 外部の確立したツール | Sober側の実装量ゼロで真実が手に入る。ビルドには使わずテストだけで使うのでLLVM非依存の方針と矛盾しない | llvm-mc、QEMU、clang、wasm仕様インタプリタ、PostgreSQL |
| 自前の参照実装 | 証明対象であると同時に実行可能。正は1つ | Leanの型検査器とsmall-step評価器、`-O0` ビルド |
| 実行時計測 | 静的な主張を動かして観測し、観測 ⊆ 導出を確認する。analyzerの健全性を実行で検証する唯一の手段 | 計装ランタイムのエフェクトの記録、スタック高水位、Pool未返却カウンタ |

## 層ごとのオラクル

| 層 | オラクル | 種類 | Phase |
|---|---|---|---|
| パーサ | parse → print → parseの不動点。加えて同じPEGからtree-sitterで生成した第2パーサとの差分 | 自己整合 + 外部 | 0〜1 |
| 命令エンコーダ（x86_64 / ARM / RISC-V） | `llvm-mc`（無ければGNU as）。命令列を生成して自前エンコードのバイト列とアセンブラ出力を比較 | 外部 | 0〜1 |
| 脱糖器（Zig） | Lean側のコアASTパースが毎回「体系の項か」を検査（formal.md）。等価性は直接のオラクルが無く、末端の差分実行で捕まえる。緩和は「脱糖は構文変換で小さく保つ」 | 参照実装 | 2 |
| 型検査器 | Lean製（本番 → Zig再実装後はオラクル。formal.md順序5） | 参照実装 | 2 |
| codegen（全バックエンド） | Leanのsmall-step評価器で走らせた結果vsネイティブ実行の結果。ARM / RISC-VはQEMUで実行。全バックエンドがLeanと一致し、互いにも一致する | 参照実装 + 外部 | 1〜、6 |
| 最適化器 | `-O0` ビルドとの差分実行。意味が最適化器に依存しない決定（design-dev.md「決め方の型」4）により差分は純粋 | 自己整合 | 1〜 |
| regionのescape | 解放したregionをpoisonし、debugビルドでdanglingを検出。Leanのregion木（formal.mdの段階2の計装付き評価器）との差分 | 計測 + 参照実装 | 2 |
| ランタイム5a / 5b | Lean意味論のトレース照合、TLA+（チャネル / join）、決定的シミュレーション（design-dev.md Phase 5） | 参照実装 | 5 |
| スタック上界 | debugビルドでスタックを塗り、高水位 ≤ リンク時に計算した上界 | 計測 | 5 |
| analyzer: エフェクトの導出 | 計装ランタイムで実際のsyscall / ブロッキングを記録し、観測 ⊆ 導出。導出が漏らしたら不健全 | 計測 | 4 |
| analyzer: エラーラベル導出 | fuzzで実際に返ったラベルを記録し、観測 ⊆ 導出 | 計測 | 4 |
| analyzer: acquire / release | debugビルドのPool未返却カウンタ | 計測 | 3〜4 |
| `@layout(c)` / `@export(c)` | clang。同じstructをCで宣言して `offsetof` / `sizeof` を比較、export関数をCハーネスから呼ぶ | 外部 | 6 |
| wasm → x86_64 AOT | WebAssembly公式の仕様インタプリタ（OCaml）と公式テストスイート | 外部 | 6 |
| std/strings（2026-09-26〜） | Goのstringsパッケージ。scripts/strings_oracle.tsが1つのケース表からSoberのexampleと比較用のGoの実装を生成し、Goの出力を .outにする | 外部 | 随時回収 |
| builtin clone（2026-10-11〜） | Goのslices.Clone / maps.Clone。scripts/clone_oracle.tsが1つのケース表からexamples/clone_stdと比較用のGoの実装を生成し、Goの出力を .outにする（コピーした後に元を書き換えてもコピーが変わらないこと・mapの列挙の順はSober側が自分で照合） | 外部 | 随時回収 |
| std/rand（2026-10-02〜） | 参照実装（xoshiro128 — Blackman / Vigna）をuint32のwrapで移植した比較用のGoの実装scripts/oracles/rand_xoshiro.goがexamples/rand_xoshiro.outを作る（移植は公開の既知の列 = 状態 {1,2,3,4} から11520 0 5927040 … で確認 — 標準エラーに出す）。std/randはintの上で32 bitの算術を桁に分けて書くので、uint32と一致すればよい | 外部 | 随時回収 |
| std/hash・std/hex（2026-10-02〜） | Goのcrypto/sha256（16進はencoding/hex）を使う比較用の実装scripts/oracles/hash_sha256.goがexamples/hash_sha256.outを作る。NISTの公式ベクタ（FIPS 180-2付録Bの "abc"・448 bit・100万個の 'a' + 896 bit・空入力）の期待値を比較用の実装に固定し、crypto/sha256と照合（標準エラー — 食い違いはexit 1）。例はブロック境界（55/56/57/63/64/65/119/120/127/128/129バイト）と100003バイトの長入力も通す | 外部 | 随時回収 |
| `Value` 変換の生成物 | round trip + 既存JSON実装（wasm経由）との差分 | 自己整合 + 外部 | Webアプリ題材 |
| SoberSQL | PostgreSQL本体（sqlshapeの構成そのまま） | 外部 | SoberSQL題材 |

## 共通の駆動部

ジェネレータは1本。formal.mdの段階2の `plausible` ジェネレータがSoberコアの小プログラムをJSONテストベクタとして吐き、パーサからcodegenまで同じプログラム集合を流す。敵対的テスト（sqlshape）と同じで、ジェネレータの分布を「オラクルと食い違いそうな形」に寄せていく。

## 運用

- Phaseごとに「そのPhaseのオラクル」を先に用意し、実装はオラクルに対する差分ゼロで完了とする（dandoriの全行トレースと同じ受理条件）
- オラクルの側が間違っていた場合（外部ツールのバグ、Leanの未証明部分）は記録して、差分を「既知の食い違い」として明示的に除外する。黙って合わせない
- 用意できない場所は上表に「直接のオラクルが無い」と書く（現状は脱糖器の等価性だけ）
