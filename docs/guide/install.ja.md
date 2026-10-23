# インストール

[English](install.md) | 日本語

Sober のコンパイラは、凍結した Zig 製の最初の版（stage1）から、`bootstrap/` にあるソースのスナップショットを順に建てて作ります。Zig とソースだけで全部が建ちます。各[リリース](https://github.com/sober-lang/sober/releases)には x86-64 Linux 用の建て済みの静的バイナリ（`sober-v<版>-x86_64-linux.tar.gz`）も付いています — CI が同じブートストラップで建てたもので、展開すれば `sober` をそのまま使えます（建てる手順は要りません）。

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

## サーバを走らせる

std/net（したがって std/http と std/tls）を使うプログラムは、環境に 3 つのことを求めます:

- io_uring: Docker の既定の seccomp のプロファイル（と gVisor）は io_uring を塞ぎます。そのとき Sober は自動で epoll に倒れます — 動きますが遅くなります。本来の速さには `io_uring_setup` / `io_uring_enter` / `io_uring_register` を許すプロファイルで走らせてください（例: `docker run --security-opt seccomp=unconfined …`）。io_uring のネットワークの道は Linux 6.1 以降が要ります
- memlock: ワーカーごとに io_uring の ring を 1 本持ち、古いカーネルは ring のメモリをユーザー全体の `RLIMIT_MEMLOCK` で数えます。ring の作成が ENOMEM で失敗すると上と同じく倒れて遅くなるので、上限を上げてください（`ulimit -l unlimited`・systemd なら `LimitMEMLOCK=infinity`・Docker なら `--ulimit memlock=-1`）。Linux 5.12 以降は cgroup で数えるので、ほぼ問題になりません
- nofile: 接続 1 本がファイル記述子 1 つです。systemd や多くのシェルの soft の上限は既定で 1024 — 見込む接続の数以上に上げてください（`ulimit -n`・`LimitNOFILE=`・`--ulimit nofile=…`）

コンテナの init（PID 1）として走らせても SIGTERM / SIGINT で止まります（終了コード 143 / 130）— tini や `--init` は要りません。止まるのは即座で、処理中の接続は切れます（接続を流し切る優雅な停止はまだありません）。

## 開発者向け: 検査の網を回す

コンパイラ自身に手を入れるときは、`scripts/gates.sh --full` が全部の検査を回します。網には追加で次が要ります:
[Lean 4](https://lean-lang.org/)（`lean/lean-toolchain` の版 — `cd lean && lake build`）、Go（独立のオラクルと bench の双子）、Rust（bench の双子）、Node.js（一部の道具）、`perf`（bench）、GNU as（命令のエンコーダの照合）。

次へ: [最初のプログラム](first-program.ja.md)
