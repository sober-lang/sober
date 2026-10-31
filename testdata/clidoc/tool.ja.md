<!-- `sober doc --cli` が std/cli の表から生成 — 手で直さない。英語版 tool.md が正で、この頁は訳表 tool.ja.json の訳（usage の塊は実行ファイルの英語のまま） -->

# tool

ファイルをまとめて数える

## コマンド

| コマンド | 概要 |
| --- | --- |
| [`tool pack`](#tool-pack) | ファイルをまとめる |
| [`tool count`](#tool-count) | バイトを数える |
| [`tool remote add`](#tool-remote-add) | リモートを足す |
| [`tool plan`](#tool-plan) | 計画を印字する（run はまだ無い） |

## 環境変数

| 変数 | 意味 |
| --- | --- |
| `TOOL_HOME` | ホームディレクトリ \| 既定 |

## tool pack

ソースのファイルを 1 つのアーカイブにまとめる

```text
usage: tool pack [flags] <src>

pack the source file into one archive

arguments:
  <src>  the source file

flags:
  -o <file>      write to <file> (default out.txt)
  -v, --verbose  print every step

environment:
  TOOL_HOME  the home directory | the default
```

効果: `io, panic, nondet`

## tool count

バイトを数える

```text
usage: tool count <src>

count the bytes

arguments:
  <src>  the source file
```

効果: `panic`

## tool remote add

リモートを足す

```text
usage: tool remote add

add a remote
```

効果: `(lambda)`

## tool plan

計画を印字する（run はまだ無い）

```text
usage: tool plan

print the plan (no run yet)
```
