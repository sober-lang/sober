# Sober

[English](README.md) | 日本語

ミニマル・高速・安全・平凡なプログラミング言語。

```sober
// examples/collatz_par.sober
package main

import "std/iter"
import "std/task"

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
    ks, err := task.Map(ns, (n) => steps(n) catch -1)
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

HTTP サーバも標準ライブラリだけで書けます（TLS 1.3 も std にあります）:

```sober
// examples/http_hello.sober
package main

import "std/http"
import "std/net"

func hello(r http.Request) http.Response {
    n := http.Param(r, "name")
    return http.Text("hello, ${if n != nil { n } else { "world" }}\n")
}

func app(c net.Conn) error? {
    rs := []http.Route{http.Route{method: "GET", path: "/hello/:name", handler: hello}}
    return http.ServeConn(c, (r) => http.Dispatch(rs, r))
}

func serve() error? {
    for l <- net.Listen("127.0.0.1:8080")? {
        net.Serve(l, app)?
    }
    return nil
}

func main() int {
    if serve() != nil {
        return 1
    }
    return 0
}
```

## 4 本の柱

### ミニマル

- 依存ゼロの単バイナリ。コンパイラは libc にも LLVM にも依らない静的な ELF 1 つで、出力の実行ファイルも同じく静的な ELF です。
- コンパイラは約 11 万行（約 112,000 行）。標準ライブラリは別に約 15,000 行です（テストを除くソース・コメントと空行を含む行数）。
- Zig とソースだけで完全ブートストラップ。凍結した Zig 製の stage1 から、`bootstrap/` のソースのスナップショットを順にビルドして今のコンパイラに至ります。種のバイナリはありません。

→ [なぜミニマルか](docs/design-notes/minimal.md)

### 高速

- Rust に匹敵する実行速度。同じアルゴリズムの素直な Rust と比べて、逐次 9 題材で勝ち 4・互角 3・負け 2（負けは reverse-complement 1.47×・n-body 1.17×）。Go には 6 勝 3 互角（負けなし）です。 <!-- benchsync:readme-speed-ja -->
- Rust 並みのメモリフットプリント。GC はありません。最大 RSS は 9 題材中 8 題材で Rust 以下です（上回るのは k-nucleotide）。 <!-- benchsync:readme-rss-ja -->
- 高い並列処理性能。しかも決定的。structured concurrency の task は軽く（2026-10-10 の計測で、Skynet の 111 万 task が Go の 5 倍速い）、ワーカー数を変えても出力はバイト単位で同じです。

→ [なぜ速いか](docs/design-notes/fast.md)

### 安全

- GC なし・借用検査なしで、メモリ安全かつデータ競合なし。寿命はスコープの入れ子に一致し（全ブロックが region）、並列スコープに渡せるのは不変値かチャネルだけです。
- エラーの取りこぼしを拒否する。解析器が呼び出しのグラフからエラーをラベルの集合として導出し、公開の境界では宣言を求めます。
- 学ぶのは「書けないこと」だけ。寿命の注釈も借用の規則もありません。書けない形（共有された可変・逃げる参照）がコンパイルエラーになるだけです。

→ [なぜ安全か](docs/design-notes/safe.md)

### 平凡

- 式指向のふつうの手続き型。if / switch / ブロック / for が値を持ち、メソッドも型クラスもマクロもありません。Go を読める人なら読めます。
- 速いコードを書くための作法は存在しない。素直に書いたコードが最速の形です。速さのための機構はランタイムとコンパイラの中にだけ置き、ベンチマークの Sober 側も素直な形に限っています。

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

速度とメモリのグラフは、[bench/data/official.tsv](bench/data/official.tsv) から `scripts/benchsync.sh` で生成しています。このページのベンチの数字はすべてこのファイルが出どころで、グラフと数字がこのファイルと一致することを gate が確かめます。数字は GitHub Actions（AMD EPYC 9V45 96-Core Processor）で `.github/workflows/bench-official.yml` が測った CPU 時間（task-clock）です。手元での再現: `scripts/bench.sh -n 3` → `bench/seqperf.sh -n 5 --rust`。各題材の Go と Rust の双子は `bench/<題材>/go`・`bench/<題材>/rust` にあります。計測の条件と規律は [docs/bench.md](docs/bench.md) に書いています。 <!-- benchsync:readme-repro-ja -->

## 検証がビルトイン

テストの道具は全部 `sober` に入っています。プロパティベーステスト（std/quick）・fuzzing（`sober fuzz`）・カバレッジ（`sober test --cover`）・ミューテーションテスト（`sober test --mutate`）に、別のツールやプラグインは要りません。

- ミューテーションテストは、全部のミュータントを 1 本のテストのビルドに織り込み、実行時に 1 体を選びます。ミュータントごとに走らせるのは、そのミュータントに届いたテストだけです。テストは決定的なので、判定は 1 回で決まります（揺れを疑って走らせ直すことがありません）。
- fuzzing はカバレッジに誘導されます。新しい分岐を開いた入力を元に、次の入力を作ります。
- 失敗は再現します。反例は最小の形にシュリンクされ、同じコードとシードなら何度走らせても同じ試行・同じ反例になります。`sober fuzz --sched` は並列のスケジュールも試行ごとに振るので、順番に依る失敗もシードで再現します。
- `sober watch` は保存のたびに check し、通ったら build とテストを裏で温めて結果を覚えます。続けて打つ `sober test` は、何も変わっていなければ覚えた結果を返すだけです。

道具の実際の出力は[テストの書き方](docs/guide/testing.ja.md)にあります（ページの出力はすべて実物と照合しています）。

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

コンパイラの変更は `scripts/gates.sh --full` の検査を全部通してから入ります: 自己コンパイルの固定点（stage3 ≡ stage4）・ゴールデンテスト・最適化あり / なしの観測の一致・凍結した Zig 版との照合・独立のオラクル（Go の UTF-8・GNU as）・Lean で型安全性と並列の合流性を証明した形式モデル（`lean/`）との照合。

## 文書

- [利用ガイド](docs/guide/README.ja.md) — インストールから言語ツアーまで
- [標準ライブラリのリファレンス](docs/std/README.ja.md) — 公開の宣言の署名と説明（ソースの doc コメントから生成。日本語が正。英語版は 1.0 までに用意する予定）
- [CLI リファレンス](docs/cli/sober.ja.md) — `sober` のコマンド・フラグ・環境変数（コマンドの表から `sober doc --cli` が生成。英語版 [sober.md](docs/cli/sober.md) が正）
- [DESIGN.md](DESIGN.ja.md) — 主要な設計判断（柱 5 本）
- [設計ノート（Q&A）](docs/design-notes/) — 「なぜ X でなく Y か」
- [言語仕様](docs/spec/README.ja.md) — 何が受理され、受理されたプログラムがどう振る舞うかの規則（規則だけ・例は examples の実物）
- 開発者向け: [決定の記録](docs/language.md)・[構文](docs/syntax.md)・[IR](docs/ir.md)・[形式化](docs/formal.md)・[オラクル](docs/oracles.md)

## 今あるもの

v0.6 時点で実装済みの表面の一覧です。規則の全文は[言語仕様](docs/spec/README.ja.md)、署名は [std リファレンス](docs/std/README.ja.md)にあります。

言語:

- 式指向: if / switch / ブロックが値を持つ。多値・パイプと穴・defer・型推論
- 型: slice・map・struct・union・nominal・optional（`T?`）・ジェネリクス
- 束縛: const が既定・可変は `mut` を明示・シャドーイングなし・freeze
- 関数: ラムダ・関数値とクロージャ・名前つき引数（メソッド・型クラス・マクロはなし）
- エラー: error 型・`?`・`catch`・analyzer によるラベル集合の導出と網羅検査（`@errors`）・panic との区別
- メモリ: region（寿命 = スコープの入れ子）・Pool・資源の上限の宣言（予算）
- 並行: structured concurrency（scope と task）・チャネル・決定的な並列・予算と期限・lease
- アノテーション: `@embed`・`@layout`・秘密の値の追跡 ほか
- テスト: `sober test` と assert（偽なら部分式の値を印字）・std/quick のプロパティベーステスト・`sober fuzz`・`--cover`（カバレッジ）・`--mutate`（ミューテーションテスト）

標準ライブラリ（全 29 package。署名と説明は [std リファレンス](docs/std/README.ja.md)）:

- 入出力と通信: io・os・net（TCP）・http（HTTP/1.1 サーバ・SSE・multipart）・tls（TLS 1.3）・url・cli（宣言の表の CLI）・env（環境変数の宣言の表）
- 暗号とハッシュ: crypto（AES-GCM・ChaCha20-Poly1305・SHA-256・HMAC・HKDF・X25519・RSA・PEM・定数時間演算）・hash（crc32・sha256）
- 符号化と変換: json・base64・hex・binary・convert・strings・utf8・compress（flate / gzip の圧縮側）
- データと計算: iter・sort・math・rand・table・builder・pool・layout
- 並列とテスト: task（決定的な並列 Map ほか）・testing・quick（プロパティベーステスト）

ツール（単バイナリ `sober` のサブコマンド）:

- `build`（`--emit=ll|ir|elf` の中間出力つき）・`run`・`check`（build せずに型検査 + analyzer）・`test`（`--cover`・`--mutate`）・`fuzz`・`watch`（保存のたびに check し、build とテストを裏で温める）・`fmt`・`iface`（package の公開面の印字）・`fix`（導出した `@effects` / `@errors` の書き込み）・`outline`（宣言の一覧と行の範囲）・`doc --cli`・`cache`
- `check`・`build`・`test` は前回と同じ問い合わせの答えを覚えて返し、編集の後は変わった関数と package だけをやり直す（キャッシュは既定 on）

## ロードマップ — まだ実装していないもの

コアの言語表面は安定しています。1.0 は「言語の約束の凍結」、つまり互換の約束の始まりで、それまでは破壊的変更がありえます。ここに挙げた項目にも 1.0 にも、時期の約束はしません。

標準ライブラリ（1.0 までに実装する機能）:

- [ ] 解凍（inflate / gunzip）と圧縮のアルゴリズムの拡充
- [ ] 暗号の拡充: ECDSA と、運用のための TLS の機能（証明書の差し替え・クライアント認証・セッションの再開）
- [ ] データベースのクライアント: PostgreSQL と MySQL
- [ ] HTTP クライアントと、HTTP/1.1 の網羅
- [ ] 対になる API のうち、片側しかないものの残り半分
- [ ] 正規表現（設計を検討中）
- [ ] std のテストのカバレッジの拡充

言語とコンパイラ:

- [ ] 浮動小数点の整備
- [ ] 再帰的なデータ型
- [ ] mut の束縛を捕捉するクロージャ
- [ ] 値の流れの合流（zip）
- [ ] analyzer の強化: 診断の改善と lint
- [ ] 効果の追跡（エフェクトシステム）: error・mut・同一性など点在する効果の語彙を一つの枠組みに統合する（設計を検討中）
- [x] インクリメンタルコンパイル
- [ ] Pure Sober ブートストラップ: 開発の歴史を写した多段のブートストラップ鎖を、小さな種コンパイラ + 数段の階段に畳み直し、Zig を介さず Sober だけでソースから建つ形にする
- [ ] クロスコンパイル（macOS・Windows・他の CPU）

ツール:

- [x] sober watch（保存するたびに check・build・テストを裏で温める開発ループ）
- [ ] パッケージ管理
- [ ] 言語サーバ（LSP）
- [ ] リファクタリングの支援
- [ ] プロファイラ
- [ ] ドキュメントの構造化と、言語仕様・std リファレンスの英語版

もっと先:

- [ ] WebAssembly
- [ ] GPU カーネル（言語のサブセットを SPIR-V へ）
- [ ] unikernel のターゲット
- [ ] 証明つきの最適化
- [ ] 型検査つきの SQL

## ライセンス

MIT または Apache-2.0 のどちらかを選べます（`LICENSE-MIT`・`LICENSE-APACHE`）。標準ライブラリとランタイムも同じで、生成した実行ファイルに制約は付きません。

## 謝辞

ベンチマークの題材は [The Computer Language Benchmarks Game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/) の問題の仕様と [The One Billion Row Challenge](https://github.com/gunnarmorling/1brc) に拠ります（実装は各言語とも仕様から素直な形で書いたもの）。JSON の検査は [JSONTestSuite](https://github.com/nst/JSONTestSuite)（MIT）を、暗号の検査は [Wycheproof](https://github.com/C2SP/wycheproof)（Apache-2.0）のテストベクタを使っています。HTTP サーバの検査と計測には [HttpArena](https://github.com/MDA2AV/HttpArena)（MIT）のデータ・試験用の証明書・負荷の形を使っています。このリポジトリに含まれる第三者のファイルは `NOTICE` に記しています。
