# buildscale: ビルドの速さを行数のスケーリングで比べる

同じ構造のプログラムを Sober・Go・Rust の3つの言語で生成し、規模（1千〜100万行）ごとのビルド時間を測る。生成したプログラムはコミットしない。

## 使い方

```sh
# 生成（--fns = 関数の数。行数はおよそ fns × 22〔Sober〕）
node bench/buildscale/gen.ts --fns 470 --out /tmp/bs/10k
# 同じ計算をすることの確認（3つの言語の出力が同じ検査和を印字する）
node bench/buildscale/run.ts --dir /tmp/bs/10k --lang sober --cores 8 --scene cold --reps 1
# 計測（時間に依るので排他の枠で。1回の呼び出し = 1つの(言語, コア数, 場面)）
.pair/tools/gq.sh --excl <名前> node bench/buildscale/run.ts --dir /tmp/bs/10k --lang go --cores 8 --scene cold --reps 3 --tsv /tmp/bs/out.tsv
```

- 言語: `sober`・`go`・`rust`（`cargo build --release`）・`rustdebug`（`cargo build`）
- 場面: `cold`（置き場・GOCACHE・targetを空にしてから）・`coldapp`（空にした後、標準ライブラリだけを使う小さいプログラムを先にビルドしてから。GoとSoberの標準ライブラリの分を外す）・`leaf`（誰もimportしないmoduleの関数の本体の定数を1つ変える）・`root`（層0のmodule m000で同じことをする）
- コア数: Sober = `SOBER_WORKERS`・Go = `GOMAXPROCS` と `-p`・Rust = `-j`（codegen-unitsは既定のまま）
- Soberは `out/stage2/sober2 build app/main.sober --emit=elf --passes`（`bin/sober build` の既定と同じ形）を直に呼ぶ（`--sober` で差し替え）
- 記録: wall・user・sys・peak RSS（GNU timeの `%M`。子孫のうち最大の1プロセスの値で、合計ではない）・出力のバイナリの大きさ
- 表にする: `node bench/buildscale/summary.ts <results.tsv>`（規模 × 言語 × コア数 × 場面の中央値・両対数の傾き）

## ほかの道具

- `treesweep.sh <dir> "<言語…>" "<コア数…>"`: 冷えたビルドのプロセスの木のRSSの合計の最大（`treerss.ts` が20 msごとに標本化する）。go build・cargoはプロセスを並べるので、GNU timeの `%M` は合計より小さく出る。標本化の負荷でwallは伸びるので、wallはこの道具では読まない
- `stages.ts --dir <dir> --cores N --scene cold|leaf|root`: Soberのbuildの段（`SOBER_STAGES=1` の印）ごとの時刻とVmRSS。`stagediff.ts a.tsv b.tsv [--lines a,b]` で段ごとの時間を並べ、規模に対する傾きを出す
- `bisect.sh <作業のdir> <通る関数の数> <落ちる関数の数>`: 既定の上限（`SOBER_REGION_MB` なし）で通る最大の規模の二分探索
- `measure.ts src/compiler`: パラメータの元になる分布

## 生成するプログラムの構造

- module（Soberのpackage・Goのpackage・Rustのcrate）を層に並べ、各moduleは下の層のmoduleを平均3つimportする（1つは直下の層から。層の数は最大8）
- moduleごとに8ファイル・約200関数。関数は `f(n, d int) int`。先頭で `d <= 0` なら定数を返し、呼び出しには `d - 1` を渡す（実行の時間を小さく保つ）
- 関数の本体は次のブロックを並べたもの: 算術・分岐・sliceの追加と走査・mapの追加と参照・同じmoduleの関数の呼び出し・他のmoduleの公開関数の呼び出し・structの生成と参照・union（Rust = enum・Go = interfaceと型switch）の生成と網羅のswitch・総称関数の呼び出し（intとstructの2つの型で）
- すべての関数が使われるように、各関数は1つ前の関数を必ず呼ぶ。各moduleの `Entry` が公開関数を呼び、mainが全moduleの `Entry` を呼んで検査和を印字する
- 値はすべて `% 1000003` に保つ（あふれない。3つの言語で同じ結果）。mapは参照だけを使い、走査の順に依らない

## パラメータの根拠（src/compiler の実測・2026-11-17）

測り方: `node bench/buildscale/measure.ts src/compiler`。`_test.sober` を除く256ファイル・30 package・134,543行（空行とコメントを除く）・6,245関数。

| 量 | 実測 | 採った値 |
|---|---|---|
| 関数の行数 | 中央値10・平均20.5・p90 45・p99 159 | 対数正規（中央値10・p90 45）・上限300 |
| 利用者の関数の呼び出し / 行 | 0.56（同じpackage 65,665本・他package 9,090本） | 0.55 |
| 他packageへの呼び出しの割合 | 12% | 12% |
| 1 packageあたりの関数 | 208 | 200 |
| 1 packageあたりのファイル | 平均8.53（中央値1・p90 41） | 8 |
| 1 packageがimportするpackage | 3.17 | 平均3 |
| 依存の深さ | 最大7 | 層は最大8（深さ7） |
| 公開する関数の割合 | 10.1% | 10% |
| 型の宣言 / 関数 | struct 227 / 6,245 | 28関数に1つ |
| unionの割合 | compiler/は0（std は 11/201） | 型の1/4（題材にunionを含めるため） |
| 総称関数の割合 | compiler/は3/6,245（0.05%） | std の 59/2,371（2.5%）。`--generic` で倍率 |

- compiler/ はブートストラップの制約で総称関数とunionをほとんど使わないので、この2つは std の割合か題材の網羅を優先した
- 行数の比（同じ構造）: 1万行で Sober 1 : Go 1.13 : Rust 1.11。100万行で Sober 1 : Go 1.18 : Rust 1.13（Goはunionをinterfaceと型switchで書く分が長い）

## 測り方の注意（公平さ）

- この題材は外部のクレートを使わない。Rustに有利な条件。実際のRustのプロジェクトのビルド時間は、依存のクレートのビルドと手続きマクロの展開が大半を占めることが多い
- 生成したコードはトレイトの解決が単純で、総称関数の割合も小さい。総称を多用するRustらしいコードより、単相化の負荷が軽く出る可能性がある（`--generic 2` / `--generic 4` で感度を測る）
- 最適化つきのビルドはRustに不利な条件。開発の往復はふつうデバッグビルドなので、`rustdebug` を必ず並べる
- 標準ライブラリ: Soberは毎回stdをビルドする。Goは GOCACHE を空にすると標準ライブラリもビルドし直す。Rustの標準ライブラリはビルド済みで配られる。`coldapp` の場面がその分を外した数字
