# std/io

日本語

`import "std/io"`

ファイル・標準ストリーム・ディレクトリの読み書き（[language.md 28 節](../language.md)）と根の下の開き（OpenRoot / OpenUnder）。どの関数も同期の形で、バイト列は []byte で受け渡す。失敗は errno を写したラベル（NotFound・Denied・Timeout・Other）か、囲む task.Run の期限が尽きた後の Expired で返る。text として読むなら `s := string(io.ReadFile(p)?)?`（UTF-8 の検査つき）

## NotFound

```sober
type NotFound error
```

ファイルかディレクトリが無い（errno の ENOENT / ENOTDIR）

## Denied

```sober
type Denied error
```

許可が無い（errno の EACCES / EPERM / EROFS）

## Timeout

```sober
type Timeout error
```

相手の事情のタイムアウト（errno の ETIMEDOUT〔110〕— connect の不達・TCP の再送の尽き）: リトライの余地がある側。自分の期限（deadline:）が尽きたのは Expired — 呼び手の行動が違うのでラベルを分ける（[language.md 28 節](../language.md)「壊れ方の規律」）

## Expired

```sober
type Expired error
```

自分の期限が尽きた（[language.md 28 節](../language.md)「デッドライン」）: 囲む task.Run の deadline: が過ぎた後に I/O 呼び出しを行った。走っていた io は完了まで待つ — 期限の後に「次に呼んだ」I/O 関数がこれを返す（待ちの上限であって実行時間の上限ではない）。同じ期限の中でリトライしても無駄 — 上へ抜けるのが正

## Closed

```sober
type Closed error
```

相手がもういない（[language.md 28 節](../language.md)の net — 送信の EPIPE / ECONNRESET・受信の RST・接続の拒否を 1 本で。受信の FIN は失敗でなく列の終わり）

## Other

```sober
type Other error {
    errno int
}
```

上のラベルに当たらない errno の開いたバケツ（[language.md 13 節](../language.md)「正直な宣言」）。EISDIR・EINVAL（path に NUL）・ENAMETOOLONG など

## Stream

```sober
type Stream struct {
    fd int
    seal streamSeal
}
```

標準ストリーム（[language.md 28 節](../language.md)「標準ストリーム」— Stdin / Stdout / Stderr の 3 つだけ）。プロセスの寿命で開いていて Close が無く、コピーしても害が無い値の型（同一性なし — Open が返す同一性の型 io.File とは別の型）。fd の番号は値にしない — 非公開の型の封の欄 seal があるので外からは欄つきで書けず（utf8.View と同じ形）、int と Stream の間の変換の関数は無い。番号は std と rt の中にだけある。ゼロ値 `io.Stream{}` は番号 0（Writer の欄としては標準出力へ読み替える — 下の Writer）

## Stdin

```sober
const Stdin = Stream{fd: 0, seal: streamSeal{}}
```

標準ストリーム（開いている fd 0 / 1 / 2）

## Stdout

```sober
const Stdout = Stream{fd: 1, seal: streamSeal{}}
```

標準ストリーム（開いている fd 0 / 1 / 2）

## Stderr

```sober
const Stderr = Stream{fd: 2, seal: streamSeal{}}
```

標準ストリーム（開いている fd 0 / 1 / 2）

## File

```sober
type File struct {
    fd int
    seal fileSeal
}
```

Open で開いたファイル（[language.md 28 節](../language.md)「資源とストリーム」— 同一性を持つ型: 作る関数は Open だけ・後始末は同じブロックの`defer io.Close(f)`・写せない・外へ出せない・give: では渡せない — 子は path から自分で開く。desugar/filecheck の規則）。fd の番号は封の欄の中で、std と rt の外に出ない。標準ストリームの Stream とは別の型（Stream はプロセスの寿命・Close なし・写して害なし）

## Open

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func Open(path string) (File, error?)
```

path のファイルを読むために開く（O\_RDONLY）。開いたら同じブロックの直後の文で `defer io.Close(f)` を書く

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## Close

```sober
func Close(f File)
```

f を閉じる（Open の直後の defer でだけ書ける — desugar/filecheck。閉じる失敗は返さない: 読むためだけに開いた fd の close の失敗に打つ手は無い）

## Root

```sober
type Root struct {
    fd int
    seal rootSeal
}
```

根として開いたディレクトリ（[language.md 28 節](../language.md)「根の下の開き」— File と同じ同一性の型: 作る関数は OpenRoot だけ・後始末は同じブロックの`defer io.CloseRoot(r)`・写せない・外へ出せない・give: では渡せない）。OpenUnder の根になる capability で、中身は O\_PATH の fd（読み書きの口は無い）。ディレクトリの項目の種類 EntryKind の Dir とは別物

## OpenRoot

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func OpenRoot(path string) (Root, error?)
```

path のディレクトリを OpenUnder の根として開く（openat の O\_PATH | O\_DIRECTORY）。開いたら同じブロックの直後の文で `defer io.CloseRoot(r)` を書く。ディレクトリでなければ NotFound（ENOTDIR）

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## CloseRoot

```sober
func CloseRoot(r Root)
```

r を閉じる（OpenRoot の直後の defer でだけ書ける — desugar/filecheck）

## OpenUnder

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func OpenUnder(r Root, rel string) (File, error?)
```

r の下の rel のファイルを読むために開く（openat2 の RESOLVE\_BENEATH | RESOLVE\_NO\_MAGICLINKS）。開いたら同じブロックの直後の文で `defer io.Close(f)` を書く。r の外へ出ないのはカーネルの保証: `..`・絶対パス・r の外を指す symlink は解決の途中で拒否されて Denied（EXDEV）— rel を文字列として検査しない。r の中を指す symlink は辿る。fifo などを開いても塞がない（O\_NONBLOCK — 通常のファイルの読みには効かない）。openat2 の無いカーネルではOther{errno: 38}（openat へ倒れない — 倒れると根の外へ出ない保証が消える）

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## FileInfo

```sober
type FileInfo struct {
    size int
    modTime int
    kind EntryKind?
}
```

Stat が返す開いた File の属性（fstat 1 回 — 開いたその実体を見て path を引き直さない。kind に Symlink は来ない — 開くときに辿る）

欄:

- `size` — 大きさ（バイト — st\_size。通常のファイル以外は意味を持たない）
- `modTime` — 更新時刻（st\_mtim — Unix エポック〔1970 年 1 月 1 日 UTC〕からの ns。std/os の ModTime と同じ値）
- `kind` — 種類（Regular・Dir・Irregular〔fifo・socket・デバイス〕— Stat は必ず入れる。option にしてあるのは FileInfo にゼロ値を持たせるため〔union はゼロ値を持たない — `(FileInfo, error?)` を返す関数の `?` の早期 return が FileInfo{} を要る〕）

## Stat

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func Stat(f File) (FileInfo, error?)
```

f の属性（fstat(2) の大きさ・更新時刻・種類 — 通常のファイルでなくても誤りにしない: 判定は kind で呼び手が）

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## ReadAll

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func ReadAll(f File) ([]byte, error?)
```

f を今の位置から EOF まで全部読む（ReadFile の開いた File 版）。途中で失敗したら error（読めた分は捨てる）

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

対の `WriteAll` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## Bytes

```sober
type Bytes struct {
    b []byte
    seal bytesSeal
}
```

読むだけのバイト列の View（Chunks / Lines の切片 — [language.md 28 節](../language.md)「読みのストリーム」）。作れるのは std/io だけ（封 — utf8.View と同じ形）。中身は rt のスロット（貸出中の pool — region-domain-pool.md 4c 節）を指し、for の 1 反復の間だけ有効: 反復の外の変数への代入・return・送りは境界の写しになる（region の規則 — 外へは写してしか出せない）。書きの関数は無い

## Raw

```sober
func Raw(v Bytes) []byte
```

v のバイト列（読むだけ — 同じ反復の中の View）

## Chunks

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func Chunks(f File, k func(Bytes)) error?
```

f を今の位置から EOF まで切片ずつ k へ渡す（失敗しうる生成元 — `for c <- io.Chunks(f)? { … }`）。切片は 1 回の読みの分（通常のファイルは最後以外 64 KiB）。次の切片の読みは前の切片を渡している間に先に出す（ダブルバッファ）。読みの失敗は errno のラベル

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## ChunksAt

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func ChunksAt(f File, off int, k func(Bytes)) error?
```

f の off バイト目から EOF まで切片ずつ k へ渡す（Chunks と同じ切片・先読み — 読みは pread の形で f の位置を動かさない。off が EOF 以上なら空の列・off \< 0 は Other{errno: 22}）

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## Lines

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func Lines(f File, k func(Bytes)) error?
```

f の行を順に k へ渡す（区切り = '\n'・行末の '\r' は落とす・最後の行は改行が無くても渡す — Go の bufio.ScanLines と同じ）。行は切片の部分 View で、切片をまたぐ行だけ std の中で写す

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## ReadFile

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func ReadFile(path string) ([]byte, error?)
```

path のファイルを全部読む

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## WriteFile

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func WriteFile(path string, b []byte) error?
```

path に b を書く（作成 / 切り詰め、0644）。/dev/stdout への追記には使わない（切り詰める）— WriteStdout を使う

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## WriteStdout

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func WriteStdout(b []byte) error?
```

開いている標準出力（fd 1）へ b を書く（open しないので切り詰めない）。println の行バッファに残りがあれば先に出す（出る順 = 呼んだ順。ただし std/task の task の中では println の行は spawn の木の先行順で出る〔溜まりうる〕ので、直書きとの順は約束しない — [language.md 11 節](../language.md)）

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## ReadStdin

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func ReadStdin() ([]byte, error?)
```

標準入力（fd 0）を EOF まで全部読む（同期 — Unix フィルタの入口。text なら `string(io.ReadStdin()?)?`）。途中で失敗したら error（読めた分は捨てる）

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## WriteStderr

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func WriteStderr(b []byte) error?
```

開いている標準エラー（fd 2）へ b を書く（WriteStdout と同じ規則）

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)

## EntryKind

```sober
type EntryKind union {
    Regular {}
    Dir {}
    Symlink {}
    Irregular {}
}
```

ディレクトリの項目の種類（getdents64 の d\_type）。Regular = 通常のファイル・Irregular = 上の 3 つ以外（fifo・socket・デバイス・DT\_UNKNOWN）

## DirEntry

```sober
type DirEntry struct {
    Name string
    Kind EntryKind
}
```

ReadDir が返すディレクトリの項目 1 つ（名前と種類）

## ReadDir

```sober
@errors(NotFound, Denied, Other, Timeout, Expired, strings.InvalidUtf8)
func ReadDir(path string) ([]DirEntry, error?)
```

path の項目を名前のバイト順で返す（`.` / `..` は含めない — Go の os.ReadDir と同じ）。並びはファイルシステムの列挙順に依らない（loader の決定性 — [language.md 29 節](../language.md)）。名前が 1 つでも不正な UTF-8 なら全体が strings.InvalidUtf8

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)・`strings.InvalidUtf8`

## Writer

```sober
type Writer struct {
    to Stream
    buf mut []byte
    n int
    err int
}
```

書きバッファ（定常メモリで流す — 64 KiB のバッファを添字で使い回し、満杯で書き出す。溜め込んで最後に 1 回書く形の RSS の回避）:

```sober
mut w := io.Writer{}            // ゼロ値は標準出力へ書く（欄 to のゼロ値 = 番号 0 は標準出力へ読み替える — 標準入力へは書かない）。標準エラーへは io.SetFile(mut w, io.Stderr)
io.WriteString(mut w, "hello\n")
io.WriteByte(mut w, 'x')
err := io.Flush(mut w)          // 残りを書き出す — 最後に Flush しないとバッファに残った分は書かれない
```

書き出しの失敗は err に貯め（以後の書き出しはしない — 失敗の後に書いたバイトは捨てられる）、Flush が返す（bufio と同じ「後で返す」）。Flush が失敗を返すと貯めた失敗は消え、次の書き出しから再び書く。構築の関数（WriterOf）を持たないのは、mut の欄を持つ struct を関数から返す形を check が受けないため（[language.md 26 節](../language.md) G3）— ゼロ値 + SetFile の形にした

## SetFile

```sober
func SetFile(w mut Writer, f Stream)
```

書き出す先を f に変える（io.Stdout / io.Stderr — 番号は Stream の中に閉じる）

## WriteByte

```sober
func WriteByte(w mut Writer, c byte)
```

1 バイト書く（速い道 = 空きがあれば書いて進めるだけ — 呼び手に展開される大きさに保つ。満杯・初回は writerByteSlow）

## WriteBytes

```sober
func WriteBytes(w mut Writer, b []byte)
```

バイト列を書く（バッファの空きの分ずつ — 内側は添字の写しの形で、最適化のバックエンドが一括の写しにする）

## WriteString

```sober
func WriteString(w mut Writer, s string)
```

文字列を書く

## Flush

```sober
@errors(NotFound, Denied, Other, Timeout, Expired)
func Flush(w mut Writer) error?
```

バッファに残った分を書き出し、それまでの書き出しの失敗を返す（返したら失敗は消える）

失敗のラベル: [`NotFound`](#notfound)・[`Denied`](#denied)・[`Other`](#other)・[`Timeout`](#timeout)・[`Expired`](#expired)
