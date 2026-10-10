# インストール

[English](install.md) | 日本語

Sober のコンパイラは、凍結した Zig 製の最初の版（stage1）から、`bootstrap/` にあるソースのスナップショットを順に建てて作ります。配布用のバイナリはありません — Zig とソースだけで全部が建ちます。

## 必要なもの

- x86-64 の Linux（今はこれだけ — macOS・Windows・他の CPU は今後）
- [Zig 0.15.2](https://ziglang.org/download/)（stage1 を建てるのと、鎖の前半の段の `.ll` を機械語にするのに使う）
- git

## 建てる

```sh
git clone <this repository> sober
cd sober
(cd src/stage1 && zig build)   # stage1 — src/stage1/zig-out/bin/sober
scripts/stage2.sh              # bootstrap/ の 25 段を順に建て、最後の段が今のコンパイラ（stage2）を建てる
```

`scripts/stage2.sh` の初回は数分かかります（段ごとの結果は `out/stage2/` にキャッシュされ、2 回目以降はソースが変わったときだけ作り直します）。

## 使う

`bin/sober` が入口です（stage2 が古ければ自動で建て直します）。PATH に入れておくと便利です。

```sh
export PATH="$PWD/bin:$PATH"
sober build examples/hello.sober -o hello
./hello
```

```
Hello, Sober!
```

主なコマンド:

| コマンド | すること |
|---|---|
| `sober build <file.sober> -o <out>` | 実行ファイル（静的な ELF）を作る |
| `sober check <file.sober>` | 型検査と解析器だけを掛ける（実行ファイルを作らない） |
| `sober test <package>` | package の `*_test.sober` のテストを走らせる |

## 開発者向け: 検査の網を回す

コンパイラ自身に手を入れるときは、`scripts/gates.sh --full` が全部の検査（54 本）を回します。網には追加で次が要ります:
[Lean 4](https://lean-lang.org/)（`lean/lean-toolchain` の版 — `cd lean && lake build`）、Go（独立のオラクルと bench の双子）、Rust（bench の双子）、Node.js（一部の道具）、`perf`（bench）、GNU as（命令のエンコーダの照合）。

次へ: [最初のプログラム](first-program.ja.md)
