# Sober

[English](README.md) | 日本語

ミニマル・高速・安全・平凡なプログラミング言語。

```sober
// examples/collatz_par.sober
package main

import "std/iter"
import "std/par"

type TooLarge error {
    n int
}

// Collatz steps (expression-oriented: if has a value)
func steps(n int) (int, error?) {
    if n > 1000000000 {
        return 0, TooLarge{n: n}
    }
    mut x := n
    mut k := 0
    while x != 1 {
        x = if x % 2 == 0 { x / 2 } else { 3 * x + 1 }
        k += 1
    }
    return k, nil
}

func main() int {
    mut ns := mut []int{}
    for i <- iter.Range(1, 1000001) {
        ns = append(ns, i)
    }
    // a parallel Map — the output is the same for any number of workers
    ks, err := par.Map(ns, (n) => steps(n) catch -1)
    if err != nil {
        return 1
    }
    mut best := 0
    for k <- ks {
        if k > best {
            best = k
        }
    }
    println("longest: ${best}")
    return 0
}
```

> 現状: v0.5.0。コアの言語表面は安定しています。残る大物は浮動小数点の整備とプラットフォーム（macOS・Windows・クロスコンパイル）です。今は x86-64 Linux だけで動きます。1.0 は「言語の約束の凍結」を意味します — それまで細部は変わりえます。

## 4 本の柱

### ミニマル

- 依存ゼロの単バイナリ。コンパイラは libc にも LLVM にも依らない静的な ELF 1 つで、出力の実行ファイルも同じく静的な ELF です。
- コンパイラのコアは 10 万行未満。構文解析・脱糖・型検査・解析器・IR・最適化（ターゲット非依存）で 58,510 行。x86-64 / ELF / Linux のターゲット部は別会計で 11,441 行、標準ライブラリは 3,743 行です（注と空行を含む行数）。
- Zig とソースだけで完全ブートストラップ。凍結した Zig 製の stage1 から、`bootstrap/` のソースのスナップショットを順に建てて今のコンパイラに至ります。種のバイナリはありません。

→ [なぜミニマルか](docs/design-notes/minimal.md)

### 高速

- Rust に匹敵する実行速度。同じアルゴリズムの素直な Rust と比べて、逐次 9 題材で勝ち 4・互角 3・負け 2（負けは n-body 1.18×・1BRC 1.11×）。Go には 6 勝 3 互角（負けなし）です。 <!-- benchsync:readme-speed-ja -->
- Rust 並みのメモリフットプリント。GC はありません。最大 RSS は 9 題材中 7 題材で Rust 以下です（上回るのは reverse-complement と k-nucleotide）。 <!-- benchsync:readme-rss-ja -->
- 高い並列処理性能 — しかも決定的。structured concurrency の task は軽く（Skynet の 111 万 task が Go の 5 倍速い）、ワーカー数を変えても出力は同じバイトです。

→ [なぜ速いか](docs/design-notes/fast.md)

### 安全

- GC なし・借用検査なしで、メモリ安全とデータ競合自由。寿命はスコープの入れ子に一致し（全ブロックが region）、並列スコープに渡せるのは不変値かチャネルだけです。
- エラーの取りこぼしを拒否する。エラーはラベルの集合として解析器が呼び出しのグラフから導出し、公開の境界で宣言を求めます。
- 学ぶのは「書けないこと」だけ。寿命の注釈も借用の規則もありません。書けない形（共有された可変・逃げる参照）がコンパイルエラーになるだけです。

→ [なぜ安全か](docs/design-notes/safe.md)

### 平凡

- 式指向のふつうの手続き型。if / switch / ブロック / for が値を持ち、メソッドも型クラスもマクロもありません。Go を読める人なら読めます。
- 速く書くための作法は存在しない。素直に書いたコードが最速形です。速さのための機構はランタイムとコンパイラの中にだけ置き、ベンチマークの Sober 側も素直な形に限っています。

→ [なぜ平凡か](docs/design-notes/plain.md)

## ベンチマーク

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/assets/bench-speed-dark.svg">
  <img alt="9 題材の相対実行時間（Rust = 1.0）" src="docs/assets/bench-speed-light.svg">
</picture>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/assets/bench-rss-dark.svg">
  <img alt="9 題材の最大 RSS の相対値（Rust = 1.0・ラベルは MB）" src="docs/assets/bench-rss-light.svg">
</picture>

速度とメモリのグラフは、このページのベンチの数字の正である [bench/data/official.tsv](bench/data/official.tsv) から `scripts/benchsync.sh` で生成しています（グラフと数字がそれと一致することを gate が見ます）。再現: `scripts/bench.sh -n 3` → `bench/seqperf.sh -n 5 --rust`。各題材の Go と Rust の双子は `bench/<題材>/go`・`bench/<題材>/rust` にあります。計測の条件と規律は [docs/bench.md](docs/bench.md)。

## 試す

必要なもの: x86-64 Linux・[Zig 0.15.2](https://ziglang.org/download/)・git。

```sh
git clone <this repository> sober && cd sober
(cd src/stage1 && zig build)      # stage1（凍結した Zig 製のコンパイラ）
scripts/stage2.sh                 # bootstrap/ の鎖を建てて今のコンパイラ（stage2）を作る — 初回は数分
bin/sober build examples/hello.sober -o hello && ./hello
```

詳しくは [インストール](docs/guide/install.ja.md) → [最初のプログラム](docs/guide/first-program.ja.md) → [言語ツアー](docs/guide/tour.ja.md) → [標準ライブラリの案内](docs/guide/std.ja.md)。

## 検証の網

コンパイラの変更は `scripts/gates.sh --full` の 54 本の検査を全部通してから入ります: 自己コンパイルの固定点（stage3 ≡ stage4）・黄金のテスト・最適化あり / なしの観測の一致・凍結した Zig 版との照合・独立のオラクル（Go の UTF-8・GNU as）・Lean で証明した形式モデル（`lean/` — 型安全性と並列の合流性）との照合。

## 文書

- [利用ガイド](docs/guide/README.ja.md) — インストールから言語ツアーまで
- [DESIGN.md](DESIGN.ja.md) — 主要な設計判断（柱 5 本）
- [設計ノート（Q&A）](docs/design-notes/) — 「なぜ X でなく Y か」
- 開発者向け: [言語仕様](docs/language.md)・[構文](docs/syntax.md)・[IR](docs/ir.md)・[形式化](docs/formal.md)・[オラクル](docs/oracles.md)

## ライセンス

MIT または Apache-2.0 のどちらかを選べます（`LICENSE-MIT`・`LICENSE-APACHE`）。標準ライブラリとランタイムも同じで、生成した実行ファイルに制約は付きません。

## 謝辞

ベンチマークの題材は [The Computer Language Benchmarks Game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/) の問題の仕様と [The One Billion Row Challenge](https://github.com/gunnarmorling/1brc) に拠ります（実装は各言語とも仕様から素直な形で書いたもの）。JSON の検査は [JSONTestSuite](https://github.com/nst/JSONTestSuite)（MIT）を使っています。
