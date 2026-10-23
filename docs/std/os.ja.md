# std/os

日本語

`import "std/os"`

プロセスと OS の API: 引数（Args）・子プロセス（Run）・環境変数（Getenv）・ファイルの属性と名前（WriteMode・Mkdir・Rename・ModTime）・眠り（Sleep）

## Args

```sober
@errors(strings.InvalidUtf8)
func Args() ([]string, error?)
```

プログラムの引数（0 番 = プログラム名 — Go の os.Args と同じ並び）。呼ぶたびに呼び手の region へ写す。string は UTF-8 検査済みなので、不正な UTF-8 の引数が 1 つでもあれば全体が strings.InvalidUtf8（入力次第で起きる = error — [language.md 27 節](../language.md)）

失敗のラベル: `strings.InvalidUtf8`

## Run

```sober
@errors(io.NotFound, io.Denied, io.Other)
func Run(path string, args []string) (int, error?)
```

path のプログラムを args（argv[1:] — argv[0] は path）で子プロセスとして走らせ、終了を待って終了コードを返す（シグナルで死んだら 128 + 番号 — シェルと同じ）。標準入出力と環境変数は親のまま継ぐ。PATH は探さない（path はそのまま execve に渡す）。exec に失敗した子は 127 で終わる（error でなく終了コード — 子の中の失敗は親から区別しない）。fork / wait の失敗は io の errno のラベル。引数に NUL を含めば io.Other{errno: 22}（テスト基盤のランナーの最小面。fork + execve + wait4 の同期の直呼び）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## WriteMode

```sober
@errors(io.NotFound, io.Denied, io.Other)
func WriteMode(path string, mode int) error?
```

path のファイルの許可の bit（mode — chmod(2) の 12 bit: 0o755 = 493 等）を書く。失敗は io の errno のラベル（無い・権限・その他）。path は std/io と同じく C 文字列に写す（NUL を含む・長すぎる path は io.Other）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

対の `ReadMode` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## Mkdir

```sober
@errors(io.NotFound, io.Denied, io.Other)
func Mkdir(path string) error?
```

path のディレクトリを作る（mkdir(2) — 許可の bit は 0o755。親は作らない — mkdir -p は呼び手が親から順に）。既にあれば io.Other{errno: 17}（EEXIST — ラベルは足さない: 呼び手が「あってもよい」を errno で見る）。他の失敗は io の errno のラベル（3'' 第 2 段 C0 — キャッシュのディレクトリ）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## Rename

```sober
@errors(io.NotFound, io.Denied, io.Other)
func Rename(from string, to string) error?
```

from を to へ付け替える（rename(2) — 同じファイルシステムの中では原子的で、to が既にあれば置き換える）。一時ファイルに書いてからRename で公開すると、読み手は書きかけを見ない（キャッシュのディレクトリの書き込みの形）。失敗は io の errno のラベル

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## ModTime

```sober
@errors(io.NotFound, io.Denied, io.Other)
func ModTime(path string) (int, error?)
```

path の更新時刻（stat(2) の st\_mtim — Unix エポック〔1970 年 1 月 1 日 UTC〕からの ns。シンボリックリンクは辿る。開いた File の同じ値は io.Stat の modTime）。失敗は io の errno のラベル（sober watch の mtime ポーリング・http.Static の Last-Modified）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## Sleep

```sober
func Sleep(ms int)
```

ms ミリ秒眠る（負の値は 0 と同じ）。std/task のプログラムでは眠る間ワーカーを譲り、期限つきの scope（task.Run の deadline:）の中なら期限が来た時点でエラーなしで早く返る（デッドライン = 待ちの上限 — [language.md 28 節](../language.md)。起きた時刻は io の入力）。逐次のプログラムは nanosleep(2)

## SleepExpired

```sober
func SleepExpired(ms int) bool
```

Sleep と同じで、期限で早く起きたら true（どの待ちが期限で切れたかを観測する関数）

## Getenv

```sober
@errors(strings.InvalidUtf8)
func Getenv(name string) (string?, error?)
```

環境変数 name の値（無ければ nil — 空の値 `NAME=` は "" で、無いのと区別する）。値が不正な UTF-8 なら strings.InvalidUtf8（Args と同じ — 入力次第で起きる = error）。同名が複数あれば最初の 1 つ（getenv(3) と同じ）

失敗のラベル: `strings.InvalidUtf8`
