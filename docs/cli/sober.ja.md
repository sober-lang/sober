<!-- `sober doc --cli` が std/cli の表から生成 — 手で直さない。英語版 sober.md が正で、この頁は訳表 sober.ja.json の訳（usage の塊は実行ファイルの英語のまま） -->

# sober

Sober のコンパイラ

## コマンド

| コマンド | 概要 |
| --- | --- |
| [`sober build`](#sober-build) | 実行ファイルをビルドする |
| [`sober run`](#sober-run) | ビルドして実行する |
| [`sober check`](#sober-check) | ビルドせずに型検査と解析だけをする |
| [`sober test`](#sober-test) | package の *_test.sober の TestXxx() 関数を実行する |
| [`sober fuzz`](#sober-fuzz) | テストの std/quick のプロパティを期限まで回し続ける |
| [`sober watch`](#sober-watch) | 変更のたびに check し直す |
| [`sober fmt`](#sober-fmt) | 整形したソースを印字する |
| [`sober iface`](#sober-iface) | package のインターフェース（.sobi）を印字する |
| [`sober fix`](#sober-fix) | 導出した @effects / @errors の宣言を書き込む |
| [`sober doc`](#sober-doc) | プログラムの文書を生成する |
| [`sober outline`](#sober-outline) | ソースファイルの宣言を行の範囲つきで印字する |
| [`sober cache info`](#sober-cache-info) | ビルドキャッシュの中身を一覧する |
| [`sober cache gc`](#sober-cache-gc) | 上限を超えた古い世代を捨てる |

## 環境変数

| 変数 | 意味 |
| --- | --- |
| `SOBER_BUILD_CACHE` | 0 でビルドキャッシュを切る（既定は入り） |
| `SOBER_CACHE` | キャッシュのディレクトリ（既定は $XDG_CACHE_HOME/sober） |
| `SOBER_CACHE_MAX` | キャッシュの大きさの上限（MiB） |
| `SOBER_CACHE_GENS` | 残すキャッシュの世代の数 |
| `SOBER_WATCH_MS` | watch が更新を見に行く間隔（ミリ秒） |
| `SOBER_WATCH_QUIET` | watch が編集の静止を待つ時間（ミリ秒・既定 200） |
| `SOBER_WATCH_BUILD` | 0 で watch のビルドキャッシュの温めを止める |
| `SOBER_WATCH_TEST` | 0 で watch が見張っている package のテストを裏で走らせるのを止める（結果の再生のため） |
| `SOBER_LOWER_SPLIT` | 0 で lower の並列を切る |
| `SOBER_CHECK_CACHE` | 0 で check のキャッシュを切る（既定は入り） |

## sober build

実行ファイルをビルドする

```text
usage: sober build [flags] <entry>

build an executable

arguments:
  <entry>  a .sober file or a main package directory

flags:
  --emit=<form>  output form (default an executable): elf, ll, ir
  --no-opt       skip the IR passes
  -o <file>      write the output to <file> (default a.out for an executable,
                 else the standard output)
  --passes       run the IR passes on --emit=ll / ir

environment:
  SOBER_BUILD_CACHE  0 turns the build cache off (default on)
  SOBER_CACHE        the cache directory (default $XDG_CACHE_HOME/sober)
  SOBER_LOWER_SPLIT  0 turns the parallel lowering off

run 'sober build --help=dev' for the development flags
```

効果: `block, io, panic, nondet`

## sober run

ビルドして実行する

```text
usage: sober run <entry> [[--] <args>...]

build and run

arguments:
  <entry>    a .sober file or a main package directory
  <args>...  arguments for the program

environment:
  SOBER_BUILD_CACHE  0 turns the build cache off (default on)
  SOBER_CACHE        the cache directory (default $XDG_CACHE_HOME/sober)

run 'sober run --help=dev' for the development flags
```

効果: `block, io, panic, nondet`

## sober check

ビルドせずに型検査と解析だけをする

```text
usage: sober check [flags] <entry>

type-check and analyze without building

arguments:
  <entry>  a .sober file or a main package directory

flags:
  --core-json  print the desugared core as JSON
  --test       include the *_test.sober files

environment:
  SOBER_CHECK_CACHE  0 turns the check cache off (default on)
  SOBER_CACHE        the cache directory (default $XDG_CACHE_HOME/sober)

run 'sober check --help=dev' for the development flags
```

効果: `block, io, panic, nondet`

## sober test

package の *_test.sober の TestXxx() 関数を実行する

```text
usage: sober test [flags] <package>...

run the TestXxx() functions in the packages' *_test.sober

arguments:
  <package>...  package directories

flags:
  --cover                 measure branch coverage of the tested package and
                          report the arms no test took
  --cover-out <file>      write every coverage point to <file> (LCOV if it ends
                          in .lcov, else one `file:line:col kind hit` line per
                          point); implies --cover
  --cover-pkg <patterns>  measure these packages instead of the tested one
                          (comma-separated; p/... = p and the packages below it;
                          std is never measured); implies --cover
  --fresh                 run the tests again instead of replaying the
                          remembered result of a package that passed
  --mutate                mutation testing: run the tests against every mutant
                          of the tested package and report the mutants no test
                          killed (<package>/testdata/mutate.ignore lists mutants
                          to skip, as the first two columns of --mutate-out
                          lines; cannot be combined with --cover)
  --mutate-out <file>     write every mutant to <file> (one
                          `file:line:col<TAB>mutation<TAB>result<TAB>killing
                          test` line per mutant); implies --mutate
  --run <prefix>          run only the tests whose names start with <prefix>
  -v                      print every test
  --work <dir>            build the runner in <dir> (default a directory in the
                          cache)
```

効果: `block, io, panic, nondet`

## sober fuzz

テストの std/quick のプロパティを期限まで回し続ける: 失敗（プロパティの偽・panic・ハング）はシュリンク（縮小）して報告し、<package>/testdata/fuzz/<TestXxx>/ へ書く（`sober test` がこれを先に再生する。終了コード 1 = 見つけた・0 = 見つからない）

```text
usage: sober fuzz [flags] <package>

run the std/quick properties of a test until a deadline: a failure (a false
property, a panic or a hang) is shrunk, reported and written to
<package>/testdata/fuzz/<TestXxx>/, which `sober test` replays first (exit 1 =
found, 0 = none found)

arguments:
  <package>  the package directory

flags:
  --check <n>      fuzz only the n-th quick.Check of the test (0 = the first;
                   default all in turn)
  --hang <dur>     a trial running longer than this is a hang (default 1s)
  --no-guide       do not guide the trials by coverage (the test build is not
                   instrumented)
  --run <TestXxx>  the test whose std/quick properties to fuzz
  --sched          also vary the std/task schedule: one trial per process with
                   its own SOBER_SCHED_SEED (one worker)
  --time <dur>     how long to fuzz each property (500ms, 30s, 2m) (default 30s)
```

効果: `block, io, panic, nondet`

## sober watch

変更のたびに check し直す

```text
usage: sober watch <entry>

re-check on every change

arguments:
  <entry>  a .sober file or a main package directory

environment:
  SOBER_WATCH_MS     the polling interval of watch in milliseconds
  SOBER_WATCH_QUIET  how long watch waits for the edits to settle, in
                     milliseconds (default 200)
  SOBER_WATCH_BUILD  0 stops watch from warming the build cache
  SOBER_WATCH_TEST   0 stops watch from running the tests of the watched
                     packages in the background (to replay their results)
  SOBER_CHECK_CACHE  0 turns the check cache off (default on)
```

効果: `block, io, panic, nondet`

## sober fmt

整形したソースを印字する

```text
usage: sober fmt <file>

print the formatted source

arguments:
  <file>  a .sober file
```

効果: `io, panic, nondet`

## sober iface

package のインターフェース（.sobi）を印字する

```text
usage: sober iface [flags] <entry> [<dir>]

print package interfaces (.sobi)

arguments:
  <entry>  a .sober file or a main package directory
  <dir>    with --view: the interface directory

flags:
  --pkg <path>  print only this package

run 'sober iface --help=dev' for the development flags
```

効果: `block, io, panic, nondet`

## sober fix

std の外の公開の関数に、導出した @effects / @errors の宣言を書き込む（どちらのフラグも無ければ両方）

```text
usage: sober fix [flags] <entry>

write derived @effects / @errors declarations to the public functions outside
std (both when neither flag is given)

arguments:
  <entry>  a .sober file or a main package directory

flags:
  --effects    write @effects
  --errors     write @errors
  --std <dir>  also write the std files under <dir>
```

効果: `block, io, panic, nondet`

## sober doc

プログラムの文書を生成する: --cli ならコマンド行（std/cli）の Markdown の頁 — コマンドごとの使い方と、run の関数の効果

```text
usage: sober doc [flags] <entry>

generate documents of a program: with --cli, the Markdown page of its command
line (std/cli) — the usage of each command and the effects of its run function

arguments:
  <entry>  a .sober file or a main package directory

flags:
  --cli         the page of the command line of the program (its std/cli table)
  --ja <table>  write the Japanese page with the translation table <table>
                (JSON)
  -o <file>     write the page to <file> (default the standard output)

run 'sober doc --help=dev' for the development flags
```

効果: `block, io, panic, nondet`

## sober outline

ソースファイルの package・import・宣言（型・関数・定数）を行の範囲つきで印字する — ソースだけを読み、注釈は書かれたまま

```text
usage: sober outline [flags] <path>

print the package, the imports and the declarations (types, functions,
constants) of source files with their line ranges — read from the source only,
with the annotations as written

arguments:
  <path>  a .sober file or a directory

flags:
  --depth <n>      with a directory: how many levels to read (1 = the directory
                   itself) (default 1)
  --format=<form>  output form: text (default), json
  --no-test        skip the *_test.sober files
  --public         only the public declarations
```

効果: `io, panic, nondet`

## sober cache info

ビルドキャッシュの中身を一覧する

```text
usage: sober cache info

list the build cache

environment:
  SOBER_CACHE  the cache directory (default $XDG_CACHE_HOME/sober)
```

効果: `io, panic, nondet`

## sober cache gc

上限を超えた古い世代を捨てる

```text
usage: sober cache gc

drop old generations over the limits

environment:
  SOBER_CACHE       the cache directory (default $XDG_CACHE_HOME/sober)
  SOBER_CACHE_MAX   the size limit of the cache in MiB
  SOBER_CACHE_GENS  the number of cache generations to keep

run 'sober cache gc --help=dev' for the development flags
```

効果: `io, panic, nondet`
