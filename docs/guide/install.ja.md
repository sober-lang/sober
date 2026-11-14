# インストール

[English](install.md) | 日本語

Soberのコンパイラは、凍結したZig製の最初の版（stage1）から、`bootstrap/` にあるソースのスナップショットを順にビルドして作ります。Zigとソースだけで全部をビルドできます。各[リリース](https://github.com/sober-lang/sober/releases)にはx86-64 Linux用のビルド済みの静的バイナリ（`sober-v<版>-x86_64-linux.tar.gz`）も付いています — CIが同じブートストラップでビルドしたもので、展開すれば `sober` をそのまま使えます（ビルドする手順は要りません）。

## 必要なもの

- x86-64のLinux（今はこれだけ — macOS・Windows・他のCPUは今後）
- [Zig 0.15.2](https://ziglang.org/download/)（stage1をビルドするのと、ブートストラップチェーンの前半のステージの `.ll` を機械語にするのに使う）
- git

## ビルドする

```sh
git clone <this repository> sober
cd sober
(cd src/stage1 && zig build)   # stage1 — src/stage1/zig-out/bin/sober
scripts/stage2.sh              # bootstrap/ のステージを順にビルドし、最後のステージが今のコンパイラ（stage2）をビルドする
```

`scripts/stage2.sh` の初回は数分かかります（ステージごとの結果は `out/stage2/` にキャッシュされ、2回目以降はソースが変わったときだけ作り直します）。

## 使う

`bin/sober` が入口です（stage2が古ければ自動でビルドし直します）。PATHに入れておくと便利です。

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
| `sober build <file.sober> -o <out>` | 実行ファイル（静的なELF）を作る |
| `sober check <file.sober>` | 型検査と解析器だけを掛ける（実行ファイルを作らない） |
| `sober test <package>` | packageの `*_test.sober` のテストを走らせる |

コマンドとフラグの一覧は `sober --help`、コマンドごとのフラグは `sober <command> --help` で出ます。使い方の誤り（知らないフラグ・値の誤り）の終了コードは2です。

`sober build` は中間生成物を `~/.cache/sober`（`SOBER_CACHE` か `XDG_CACHE_HOME` があればそちら）にキャッシュし、2回目以降は変わった所だけを作り直します。出力の実行ファイルはキャッシュの有無で変わりません。切るには `SOBER_BUILD_CACHE=0`、格納場所の一覧と掃除は `sober cache info` / `sober cache gc` です。

## サーバを走らせる

std/net（したがってstd/http/serverとstd/tls）を使うプログラムは、環境に3つのことを求めます:

- io_uring: Dockerの既定のseccompのプロファイル（とgVisor）はio_uringを塞ぎます。そのときSoberは自動でepollにフォールバックします — 動きますが遅くなります。本来の速さには `io_uring_setup` / `io_uring_enter` / `io_uring_register` を許すプロファイルで走らせてください（例: `docker run --security-opt seccomp=unconfined …`）。io_uringのネットワークのパスはLinux 6.1以降が要ります
- memlock: ワーカーごとにio_uringのringを1本持ち、古いカーネルはringのメモリをユーザー全体の `RLIMIT_MEMLOCK` で数えます。ringの作成がENOMEMで失敗すると上と同じくフォールバックして遅くなるので、上限を上げてください（`ulimit -l unlimited`・systemdなら `LimitMEMLOCK=infinity`・Dockerなら `--ulimit memlock=-1`）。Linux 5.12以降はcgroupで数えるので、ほぼ問題になりません
- nofile: 接続1本がファイル記述子1つです。systemdや多くのシェルのsoftの上限は既定で1024 — 見込む接続の数以上に上げてください（`ulimit -n`・`LimitNOFILE=`・`--ulimit nofile=…`）

コンテナのinit（PID 1）として走らせてもSIGTERM / SIGINTで止まります（終了コード143 / 130）— tiniや `--init` は要りません。止まるのは即座で、処理中の接続は切れます（接続を流し切る優雅な停止はまだありません）。

## 開発者向け: 検査一式を回す

コンパイラ自身に手を入れるときは、`scripts/gates.sh --full` が全部の検査を回します。入力が前回PASSしたときと同じ検査は、その記録を再利用します（`--no-cache` を付けると全部を走らせます）。検査一式には追加で次が要ります:
[Lean 4](https://lean-lang.org/)（`lean/lean-toolchain` の版 — `cd lean && lake build`）、Go（独立のオラクルとbenchの比較用の実装）、Rust（benchの比較用の実装）、Node.js（一部の道具）、`perf`（bench）、GNU as（命令のエンコーダの照合）。

次へ: [最初のプログラム](first-program.ja.md)
