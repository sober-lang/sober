# std/cli

日本語

`import "std/cli"`

コマンド行の解析と使い方の文書: フラグ・位置引数・環境変数・コマンドを const の表で宣言し（BoolFlag・StrFlag・IntFlag・ChoiceFlag・ListFlag・Positional・Env・Command・App）、Main が引数の解析・`--help`・`--version`・誤用の印字・コマンドへの振り分けを持つ。値は宣言の const を把手にして引く（Str・Bool・Int・Choice・List・Pos — 綴りの誤りはコンパイルで落ち、値の型は把手の型で決まる）。綴りの規則: 長い名前は `--name`（値は `--name=v` か `--name v`）・1 文字の名前と short は `-x`（値は `-x v` — 束ね `-abc` は受けない）・`--` の後は全部位置引数・フラグと位置引数は混ぜてよい。予約の綴り = `--help` `-h` `--help=dev` `--version` `--cli-spec`（表を JSON で標準出力へ）。使い方の誤りの終了コードは 2（処理の失敗の 1 と分ける）。例: examples/cli\_wc.sober

## Handler

```sober
type Handler func(r Parsed) int
```

コマンドの本体（Main が解析の後に呼ぶ — 戻り値が終了コード）

## BoolFlag

```sober
type BoolFlag struct {
    name string
    short string
    help string
    dev bool
}
```

値を取らないフラグ（`--name` が出れば true）。name が 1 文字なら `-x`・short は `-x` の別名。dev は `--help=dev` にだけ出す（受理は同じ）

## StrFlag

```sober
type StrFlag struct {
    name string
    short string
    arg string
    help string
    def string?
    env string?
    opt bool
    dev bool
}
```

文字列の値のフラグ。arg は `--help` の値の綴り（空なら `<value>`）・def は無いときの値・env は無いときに読む環境変数の名前（def より先）。def も env の値も無いときは、opt なら StrOpt が nil を返し、opt でなければ Parse が Missing で落とす

## IntFlag

```sober
type IntFlag struct {
    name string
    short string
    arg string
    help string
    def int?
    min int?
    max int?
    allow []int
    env string?
    opt bool
    dev bool
}
```

整数の値のフラグ（10 進）。min / max は両端を含む範囲・allow が空でなければ許す値の表。他の欄は StrFlag と同じ（arg の既定は `<n>`）

## ChoiceFlag

```sober
type ChoiceFlag struct {
    name string
    arg string
    help string
    choices []string
    dev []string
    def string?
    opt bool
}
```

選択肢のどれかを取るフラグ。dev は `--help=dev` にだけ出す選択肢（受理は同じ — choices が空なら フラグごと dev）。arg の既定は `<name>`

## ListFlag

```sober
type ListFlag struct {
    name string
    short string
    arg string
    help string
    dev bool
}
```

繰り返して出せる文字列の値のフラグ（List は出た順の列 — 出なければ空）

## Positional

```sober
type Positional struct {
    name string
    help string
    many bool
    optional bool
}
```

位置引数。宣言の順に埋まる。many は残りを全部受ける（最後の 1 つだけ）・optional は無くてもよい

## Env

```sober
type Env struct {
    name string
    help string
    dev bool
}
```

プログラムが読む環境変数の宣言（文書だけ — 読むのは利用者のコード）

## Command

```sober
type Command struct {
    name string
    summary string
    help string
    bools []BoolFlag
    strs []StrFlag
    ints []IntFlag
    choices []ChoiceFlag
    lists []ListFlag
    pos []Positional
    env []Env
    run Handler?
    rest bool
    dev bool
}
```

コマンド 1 つ。name の空白はサブコマンドの区切り（`"cache gc"` = `prog cache gc`）・空の name はコマンドの無いツールの既定のコマンド（App にそれ 1 つだけ置く）。summary は一覧の 1 行・help は `--help` の説明（空なら summary）。rest なら、many でない位置引数が埋まった後（many でない位置引数が無ければ many の最初の引数から）の引数を全部（直後の `--` を除いて）many の位置引数へ素通しする（フラグとして読まない）。dev なら一覧は `--help=dev` にだけ出す

## App

```sober
type App struct {
    name string
    version string
    summary string
    help string
    commands []Command
    env []Env
}
```

プログラム全体の表（Main の入口）。env は全コマンドに共通の環境変数（`prog --help` に出る）

## Parsed

```sober
type Parsed struct {
    cmd string
    found bool
    bn []string
    bv []bool
    sn []string
    sv []string
    sh []bool
    inames []string
    iv []int
    ih []bool
    cn []string
    cv []string
    ch []bool
    ln []string
    lk []int
    lv []string
    pn []string
    pk []int
    pv []string
    seal sealed
}
```

解析の結果（当たったコマンドと値の表）。作れるのは Parse だけ（非公開の型の封の欄 — 外からは composite に書けない）。値は把手で引く

## UnknownFlag

```sober
type UnknownFlag error {
    arg int
    word string
    near string?
}
```

表に無いフラグ（near = 編集距離 2 以内の最寄りの綴り — dev のフラグも含む）

## UnknownCommand

```sober
type UnknownCommand error {
    arg int
    word string
    near string?
}
```

表に無いコマンド（near は UnknownFlag と同じ）

## MissingValue

```sober
type MissingValue error {
    arg int
    flag string
}
```

値を取るフラグが末尾にあって値が無い

## BadValue

```sober
type BadValue error {
    arg int
    flag string
    word string
    want string
}
```

値が受けられない（want = 受ける値の説明 — `an integer`・`one of elf, ll, ir`・`an integer in 1..32` 等）

## Missing

```sober
type Missing error {
    flag string
}
```

必須のフラグ・位置引数・コマンドが無い（flag = `--name`・`<name>`・`<command>`）

## Extra

```sober
type Extra error {
    arg int
    word string
}
```

位置引数の余り

## Duplicate

```sober
type Duplicate error {
    arg int
    flag string
    first int
}
```

繰り返しを受けないフラグが 2 回出た（first = 1 回目の添字）

## Request

```sober
type Request error {
    word string
}
```

予約の綴りの要求（`--help` `-h` `--help=dev` `--version` `--cli-spec` と `help` コマンド — word は要求の種類 `help` `help=dev` `version` `cli-spec`）。誤りでなく文書の要求なので、Main は Format の文面を標準出力へ書いて 0 で終わる

## Undeclared

```sober
type Undeclared panic {
    flag string
    why string
}
```

引いた把手が当たったコマンドの表に無い・値の無いことがある把手を値の要る引き（Str・Int・Choice・Pos）で引いた

## Misdeclared

```sober
type Misdeclared panic {
    flag string
    why string
}
```

表の宣言の誤り（予約の綴り・同じ綴りの 2 回の宣言・many でない位置引数が many の後・既定のコマンドと名前のあるコマンドの混在）

## Main

```sober
@effects(Handler, io, nondet, panic)
func Main(app App) int
```

app を os.Args で走らせる（Run と同じ — 引数が不正な UTF-8 なら印字して 2）

## Run

```sober
@effects(Handler, io, nondet, panic)
func Run(app App, args []string) int
```

app を args（0 番 = プログラム名）で走らせる: Parse → 文書の要求なら Format を標準出力へ書いて 0・使い方の誤りなら Format を標準エラーへ書いて 2・当たったコマンドの run の戻り値（run の無いコマンドは使い方を標準エラーへ書いて 2）

## Is

```sober
@effects()
func Is(r Parsed, c Command) bool
```

当たったコマンドが c か（Main を使わず Parse を直に呼ぶ人向け — Main は run で振り分ける）

## Bool

```sober
@effects(panic)
func Bool(r Parsed, f BoolFlag) bool
```

f が出たか

## Str

```sober
@effects(panic)
func Str(r Parsed, f StrFlag) string
```

f の値（出なければ env・def の順。どれも無い opt のフラグは panic — StrOpt で引く）

## StrOpt

```sober
@effects(panic)
func StrOpt(r Parsed, f StrFlag) string?
```

f の値（無ければ nil）

## Int

```sober
@effects(panic)
func Int(r Parsed, f IntFlag) int
```

f の値（Str と同じ規則 — 無い opt のフラグは panic — IntOpt で引く）

## IntOpt

```sober
@effects(panic)
func IntOpt(r Parsed, f IntFlag) int?
```

f の値（無ければ nil）

## Choice

```sober
@effects(panic)
func Choice(r Parsed, f ChoiceFlag) string
```

f の値（choices か dev のどれか。無い opt のフラグは panic — ChoiceOpt で引く）

## ChoiceOpt

```sober
@effects(panic)
func ChoiceOpt(r Parsed, f ChoiceFlag) string?
```

f の値（無ければ nil）

## List

```sober
@effects(panic)
func List(r Parsed, f ListFlag) []string
```

f の値の列（出た順 — 出なければ空）

## Pos

```sober
@effects(panic)
func Pos(r Parsed, p Positional) string
```

位置引数 p（many でない — 無い optional は panic — PosOpt で引く）

## PosOpt

```sober
@effects(panic)
func PosOpt(r Parsed, p Positional) string?
```

位置引数 p（無ければ nil）

## PosList

```sober
@effects(panic)
func PosList(r Parsed, p Positional) []string
```

many の位置引数 p の列（出た順）

## Usage

```sober
@effects()
func Usage(app App, name string, dev bool) string
```

name のコマンド（空なら App の全体・語の途中ならその下のサブコマンドの一覧）の使い方。dev なら dev の宣言も出す

## Format

```sober
@effects()
func Format(app App, r Parsed, e error) string
```

Parse の誤り e の文面（r = Parse が返した Parsed）。Request は要求された文書（使い方・版・表の JSON）、それ以外は「何が・どこが」の 1〜2 行と `--help` への誘導の 1 行

## Spec

```sober
@effects()
func Spec(app App) string
```

app の表の JSON（空白なし・宣言の順。フラグは種類つきの 1 本の列 — kind = bool / string / int / choice / list）

## Parse

```sober
@errors(UnknownFlag, UnknownCommand, MissingValue, BadValue, Missing, Extra, Duplicate, Request)
@effects(io, panic)
func Parse(app App, args []string) (Parsed, error?)
```

args（0 番 = プログラム名 — os.Args の並び）を app の表で読む。誤りのときも、そこまでに当たったコマンドの道を持つ Parsed を返す（Format が文面の頭に使う）。予約の綴りは error の Request で返す。表の宣言の誤りは panic(Misdeclared)

失敗のラベル: [`UnknownFlag`](#unknownflag)・[`UnknownCommand`](#unknowncommand)・[`MissingValue`](#missingvalue)・[`BadValue`](#badvalue)・[`Missing`](#missing)・[`Extra`](#extra)・[`Duplicate`](#duplicate)・[`Request`](#request)
