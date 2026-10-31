# std/os

日本語

`import "std/os"`

プロセスと OS の API: 引数（Args）・子プロセス（Run・RunTo・RunToEnv）・環境変数（Getenv）・ファイルの属性と名前（WriteMode・Mkdir・Rename・Remove・RemoveDir・ModTime）・眠り（Sleep）・期限（Alarm）・単調時計（Monotonic）

## Args

```sober
@errors(strings.InvalidUtf8)
@effects(io)
func Args() ([]string, error?)
```

プログラムの引数（0 番 = プログラム名 — Go の os.Args と同じ並び）。呼ぶたびに呼び手の region へ写す。string は UTF-8 検査済みなので、不正な UTF-8 の引数が 1 つでもあれば全体が strings.InvalidUtf8（入力次第で起きる = error — [language.md 27 節](../language.md)）

失敗のラベル: `strings.InvalidUtf8`

## Run

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(block, io)
func Run(path string, args []string) (int, error?)
```

path のプログラムを args（argv[1:] — argv[0] は path）で子プロセスとして走らせ、終了を待って終了コードを返す（シグナルで死んだら 128 + 番号 — シェルと同じ）。標準入出力と環境変数は親のまま継ぐ。PATH は探さない（path はそのまま execve に渡す）。exec に失敗した子は 127 で終わる（error でなく終了コード — 子の中の失敗は親から区別しない）。fork / wait の失敗は io の errno のラベル。引数に NUL を含めば io.Other{errno: 22}（テスト基盤のランナーの最小面。fork + execve + wait4 の同期の直呼び）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## RunTo

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(block, io)
func RunTo(path string, args []string, out string, errOut string) (int, error?)
```

Run と同じで、子の標準出力を out・標準エラーを errOut のファイルへ書く（どちらも無ければ 0644 で作り、あれば空にしてから — 同じ path を渡せば 2 本の流れが 1 つのファイルに書いた順で混ざる）。ファイルを開けなければ子を走らせずに io の errno のラベル（出力を捕まえて後で見せる・覚える口 — `sober test` の結果の再生）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## RunToEnv

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(block, io)
func RunToEnv(path string, args []string, env []string, out string, errOut string) (int, error?)
```

RunTo と同じで、子の環境を「env（`NAME=値` の列）→ 親の環境のうち env に無い名前」にする（同名は env が勝つ。env の中の同名は先の 1 つ）。親の同名を後ろに残さないのは、getenv(3) は同名の最初を・/bin/sh は最後を採るため — 除いて渡すのがどちらの読み手でも同じ値になる唯一の形。env の要素に NUL を含めば io.Other{errno: 22}

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## WriteMode

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(io)
func WriteMode(path string, mode int) error?
```

path のファイルの許可の bit（mode — chmod(2) の 12 bit: 0o755 = 493 等）を書く。失敗は io の errno のラベル（無い・権限・その他）。path は std/io と同じく C 文字列に写す（NUL を含む・長すぎる path は io.Other）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

対の `ReadMode` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## Mkdir

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(io)
func Mkdir(path string) error?
```

path のディレクトリを作る（mkdir(2) — 許可の bit は 0o755。親は作らない — mkdir -p は呼び手が親から順に）。既にあれば io.Other{errno: 17}（EEXIST — ラベルは足さない: 呼び手が「あってもよい」を errno で見る）。他の失敗は io の errno のラベル

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## Rename

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(io)
func Rename(from string, to string) error?
```

from を to へ付け替える（rename(2) — 同じファイルシステムの中では原子的で、to が既にあれば置き換える）。一時ファイルに書いてからRename で公開すると、読み手は書きかけを見ない（キャッシュのディレクトリの書き込みの形）。失敗は io の errno のラベル

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## Remove

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(io)
func Remove(path string) error?
```

path のファイルを消す（unlink(2) — ディレクトリは消さない: io.Other{errno: 21}〔EISDIR〕。シンボリックリンクはリンク自身を消す）。開いている読み手は閉じるまで中身を読める。失敗は io の errno のラベル（build のキャッシュの置き場の掃除が第一顧客）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## RemoveDir

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(io)
func RemoveDir(path string) error?
```

path の空のディレクトリを消す（rmdir(2) — 中身があれば io.Other{errno: 39}〔ENOTEMPTY〕。中身ごと消す口は持たない — 呼び手が Remove で空にしてから）。失敗は io の errno のラベル

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## ModTime

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(io)
func ModTime(path string) (int, error?)
```

path の更新時刻（stat(2) の st\_mtim — Unix エポック〔1970 年 1 月 1 日 UTC〕からの ns。シンボリックリンクは辿る。開いた File の同じ値は io.Stat の modTime）。失敗は io の errno のラベル（sober watch の mtime ポーリング・http.Static の Last-Modified）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`

## Sleep

```sober
@effects(block)
func Sleep(ms int)
```

ms ミリ秒眠る（負の値は 0 と同じ）。std/task のプログラムでは眠る間ワーカーを譲り、期限つきの scope（task.Run の deadline:）の中なら期限が来た時点でエラーなしで早く返る（デッドライン = 待ちの上限 — [language.md 28 節](../language.md)。起きた時刻は io の入力）。逐次のプログラムは nanosleep(2)

## SleepExpired

```sober
@effects(block)
func SleepExpired(ms int) bool
```

Sleep と同じで、期限で早く起きたら true（どの待ちが期限で切れたかを観測する関数）

## Alarm

```sober
@effects(io)
func Alarm(ms int)
```

ms ミリ秒後に SIGALRM でプロセスを終わらせる（既定の動作のまま — 親から見た終了コードは 128 + 14 = 142。setitimer(2) の ITIMER\_REAL）。張り直すと前の期限を置き換え、0 以下で解除する。std/task のプログラムでもどのワーカーに届いてもプロセスごと終わる（試行ごとの期限 — std/quick の fuzz のハング）

## Monotonic

```sober
@effects(io)
func Monotonic() int
```

単調時計の値（ns — 起点は不定で、同じプロセスの中の 2 点の差だけに意味がある。clock\_gettime(2) の CLOCK\_MONOTONIC — 壁時計の調整で戻らない）

## Getenv

```sober
@errors(strings.InvalidUtf8)
@effects(io)
func Getenv(name string) (string?, error?)
```

環境変数 name の値（無ければ nil — 空の値 `NAME=` は "" で、無いのと区別する）。値が不正な UTF-8 なら strings.InvalidUtf8（Args と同じ — 入力次第で起きる = error）。同名が複数あれば最初の 1 つ（getenv(3) と同じ）

失敗のラベル: `strings.InvalidUtf8`

## AppendFile

```sober
@errors(io.NotFound, io.Denied, io.Other)
@effects(io)
func AppendFile(path string, b []byte) error?
```

path の末尾に b を書き足す（open(2) の O\_WRONLY | O\_CREAT | O\_APPEND | O\_CLOEXEC — 無ければ 0644 で作る）。write(2) が途中で止まれば（部分書き・EINTR）残りを書き続ける。大きな出力を塊ごとに書き出して、全体を 1 本の列に写さずに済ませる口（build のキャッシュの置き場の書き出し）。失敗は io の errno のラベル（書けなかった分は書き足されていないとは限らない — 一時ファイルに書いて Rename する形で使う）

失敗のラベル: `io.NotFound`・`io.Denied`・`io.Other`
