# テストの書き方

[English](testing.md) | 日本語

小さなpackage `kv` を題材に、テストを6段階で足していきます。7・8節では、`kv` を使うpackageのテストで依存をdoubleに差し替えます。各段階は「書く → 走らせる → 出力を見る」の順です。ここに載せた出力はすべて実物で、リポジトリの検査（`scripts/gates.sh` のguidetest）が毎回同じコマンドを走らせて照合しています。

前提: [最初のプログラム](first-program.ja.md#テストを書く)（`*_test.sober` と `sober test`）と [言語ツアー](tour.ja.md) の1〜5節。

使う技法は5つで、下から順に積み上がります（右の列がSoberでの入口です）。

```
ファジング              sober fuzz
ミューテーションテスト  sober test --mutate
カバレッジ              sober test --cover
プロパティベーステスト  std/quick
単体テスト              assert
```

## 0. 題材 — `kv`

`key=value;key=value` の1行を読み書きするpackageです。キーや値の中の `;`・`=`・`\` は `\` でエスケープします。

```sober
// examples/guide/kv/kv.sober
package kv

// Reads and writes one line of `key=value;key=value` (the subject of docs/guide/testing.md).
// `;`, `=` and `\` inside a key or a value are escaped with `\`.

import "std/iter"
import "std/task"

type Pair struct {
    key string
    value string
}

// a piece without `=` at byte `at`
type BadPiece error {
    at int
}

@errors(BadPiece)
func Parse(s string) ([]Pair, error?) {
    b := bytes(s)
    mut out := mut []Pair{}
    mut i := 0
    while i < len(b) {
        k, j := field(b, i, '=')
        if j >= len(b) {
            return []Pair{}, BadPiece{at: i}
        }
        v, e := field(b, j + 1, ';')
        out = append(out, Pair{key: k, value: v})
        i = e + 1
    }
    return freeze(out), nil
}

// b[i:] up to `sep` or the end, unescaped; also the index of `sep` (or len(b))
func field(b []byte, i int, sep byte) (string, int) {
    mut out := mut []byte{}
    mut j := i
    while j < len(b) && b[j] != sep {
        if b[j] == '\\' && j + 1 < len(b) {
            j += 1
        }
        out = append(out, b[j])
        j += 1
    }
    return string(freeze(out)) catch "", j
}

func Format(ps []Pair) string {
    mut out := mut []byte{}
    for i <- iter.Range(0, len(ps)) {
        if i > 0 {
            out = append(out, ';')
        }
        escape(mut out, ps[i].key)
        out = append(out, '=')
        escape(mut out, ps[i].value)
    }
    return string(freeze(out)) catch ""
}

// appends s to out with `;`, `=` and `\` escaped
func escape(out mut []byte, s string) {
    b := bytes(s)
    for i <- iter.Range(0, len(b)) {
        if b[i] == ';' || b[i] == '=' || b[i] == '\\' {
            out = append(out, '\\')
        }
        out = append(out, b[i])
    }
}

// the number of pairs on each line (-1 for a line that does not parse), the lines read in parallel
func CountAll(lines []string) []int {
    ns, err := task.Map(lines, (l string) => count(l), budget: 1 * task.MB)
    return if err != nil { []int{} } else { ns }
}

func count(l string) int {
    ps := Parse(l) catch return -1
    return len(ps)
}
```

題材の途中の状態は `examples/guide/` に置いてあります。自分のpackageに写経しながら進めるときは、各節の終わりの状態と見比べてください。`examples/guide/` は `sober.mod`（`module "example.com/guide"`）を持つ1つのモジュールで、このガイドのコマンドはそこを起点に走らせます（`cd examples/guide`）。packageのimportパスと修飾子はモジュールの根からの全要素です（`import "kvstore"` → `kvstore.Load`・`import "kvstore/mem"` → `kvstore.mem.Empty`）。

| ディレクトリ | 状態 |
| --- | --- |
| `kvbug` | 直す前（バグが3つある。1・2・4節で1つずつ見つかる） |
| `kv2` | 2節の終わり（テスト3本） |
| `kv3` | 3節の終わり（テスト4本） |
| `kv` | 最後（全部） |

テストのファイルの先頭は次のとおりです。

```sober
// examples/guide/kv/kv_test.sober（抜粋）
package kv

import "std/iter"
import "std/quick"
```

## 1. 単体テスト — assert

テストは `*_test.sober` の `func TestXxx()` です。`assert` には素の式を書きます。メッセージも、`expect(...).toBe(...)` のような専用の語彙も要りません。

```sober
// examples/guide/kv/kv_test.sober（抜粋）
// 1. assert: one case, written by hand

func TestParse() {
    ps := Parse("a=1;b=2;") catch []Pair{}
    assert(len(ps) == 2)
    assert(ps[1].key == "b" && ps[1].value == "2")
}

func TestFormat() {
    ps := []Pair{Pair{key: "a", value: "1"}, Pair{key: "b", value: "2"}}
    assert(Format(ps) == "a=1;b=2")
}
```

走らせます（`--run` は名前の接頭辞で絞ります）。

```sh
$ sober test kv2 --run TestParse
```

出力:

```
ok   kv2.TestParse
1 passed, 0 failed
```

直す前の `kvbug` で同じテストを走らせると、落ちた `assert` の部分式の値が出ます。`Parse` が2つ読むはずの行から1つも読めていません（ループの条件の `<` が `<=` になっていて、末尾の `;` の後ろをもう1片として読もうとして失敗します）。

```sh
$ sober test kvbug --run TestParse
```

出力:

```
assert failed: len(ps) == 2
  len(ps) = 0
panic: testing.AssertFailed{} at kvbug/kv_test.sober:10:5
FAIL kvbug.TestParse (exit 101)
0 passed, 1 failed
```

`assert` は `&&` で繋ぐより1つの条件ずつ書くと、どこで落ちたかが値つきで読めます。

`panic:` の行の位置は落ちた `assert` を書いた行です。同じ `assert` をテーブルの行ごとに回すときは、第2引数にラベルを渡すと見出しに出ます（`assert(e, "case ${name}")` → `assert failed (case …): e`）。ラベルは落ちたときだけ評価されます。

## 2. プロパティベーステスト — std/quick

手で書いた例は、書いた人が思いついた入力しか試しません。std/quickでは「どんな入力でも成り立つこと」（プロパティ）を書き、入力はジェネレータに作らせます。`kv` のプロパティは往復です。どんな組の列でも、`Format` してから `Parse` すると元に戻るはずです。

```sober
// examples/guide/kv/kv_test.sober（抜粋）
// 2. a property: Format then Parse gives the pairs back, for any pairs

func TestRoundTrip() {
    mut q := quick.New()
    quick.Check(mut q, () => {
        ps := quick.Slice(mut q, 4, () => Pair{key: quick.String(mut q, 4), value: quick.String(mut q, 4)})
        back := Parse(Format(ps)) catch []Pair{}
        same(back, ps)
    })
}

// the same pairs in the same order
func same(a []Pair, b []Pair) bool {
    if len(a) != len(b) {
        return false
    }
    for i <- iter.Range(0, len(a)) {
        if a[i].key != b[i].key || a[i].value != b[i].value {
            return false
        }
    }
    return true
}
```

`quick.New()` のシードはテストの名前で決まるので、何度走らせても同じ入力が出ます。直す前の `kvbug` で走らせます。

```sh
$ sober test kvbug --run TestRoundTrip
```

出力:

```
quick: falsified at trial 49 of 100 (seed 392200337, 92 shrink runs)
  Slice:
    String = ""
    String = ";"
  (1 items)
assert failed: same(back, ps)
panic: testing.AssertFailed{} at kvbug/kv_test.sober:26:13
FAIL kvbug.TestRoundTrip (exit 101)
0 passed, 1 failed
```

100回の試行の49回目でプロパティが偽になり、反例をシュリンク（縮小）した結果が出ています。値が `";"` のPairが1つです。直す前の `Format` は `;` をエスケープしないので `"=;"` と書き出し、`Parse` が値を `;` のところで切ってしまいます。シュリンクはジェネレータが引いた選択の列を短く・小さくして探すので、型ごとのシュリンクの方法を書く必要はありません。

何度走らせても、同じ試行で同じ反例が出ます。テストの名前とシード（`seed 392200337`）が同じなら、ジェネレータが作る入力の列も同じだからです。落ちたテストは直した後にそのまま走らせ直せば確認できます。

`escape` で `;` と `=` もエスケープするように直し、1節のループの条件も `<` に直すと、2節の終わりの状態（`kv2`）になります（3つ目のバグはまだ残っていて、4節で見つけます）。

```sh
$ sober test kv2
```

出力:

```
ok   kv2.TestParse
ok   kv2.TestFormat
ok   kv2.TestRoundTrip
3 passed, 0 failed
```

## 3. カバレッジとミューテーションテスト — `--cover` と `--mutate`

テストが全部通っても、テストが十分とは限りません。2つの基準で測ります。

まず `--cover` で、どの分岐をどのテストも通っていないかを見ます（出力では分岐の片側ずつをarmと呼びます）。

```sh
$ sober test kv2 --cover
```

出力:

```
ok   kv2.TestParse
ok   kv2.TestFormat
ok   kv2.TestRoundTrip
cover: kv2 69.2% of 26 arms (fn 4/6)
  kv2/kv.sober:26:9   then   never taken
  kv2/kv.sober:47:32  catch  never taken
  kv2/kv.sober:60:32  catch  never taken
  kv2/kv.sober:75:6   fn     never called  (CountAll)
  kv2/kv.sober:77:12  then   never taken
  kv2/kv.sober:77:12  else   never taken
  kv2/kv.sober:80:6   fn     never called  (count)
  kv2/kv.sober:81:20  catch  never taken
3 passed, 0 failed
```

`kv.sober:26:9` の `then` は、`Parse` が `=` の無い片を見つけて `BadPiece` を返す分岐です。どのテストもエラーの経路を通っていません。`CountAll` と `count` は5節で使うのでまだ呼ばれていません。`catch` の分岐のうち `string(...) catch ""` の2つは、正しいUTF-8しか作らないので通りません（全部を100%にする必要はありません）。

次に `--mutate` で、テストが通っている所を本当に見ているかを測ります。コードを少しずつ壊した版（ミュータント）を全部1本の実行ファイルに入れ、ミュータントごとにそのミュータントに届いたテストを走らせます。どれかのテストが落ちればkill、全部通れば生存です。

```sh
$ sober test kv2 --mutate
```

出力:

```
ok   kv2.TestFormat
ok   kv2.TestParse
ok   kv2.TestRoundTrip
mutate: kv2 94.4% killed (34 of 36 reached) · 0 unreached · 2 timeout
  kv2/kv.sober:26:9        cond → false       survived  (reached by TestParse, TestRoundTrip)
  kv2/kv.sober:26:14       >= → >             survived  (reached by TestParse, TestRoundTrip)
3 passed, 0 failed
```

割合は「killした数 / テストが届いた数」です。生き残ったミュータントが「通っているのに見ていない」所です。ここでは2体とも `BadPiece` を返す条件（`26:9` の条件を偽に固定・`26:14` の `>=` を `>` に）で、壊しても誰も気づきません。カバレッジで通っていなかった分岐と同じ穴です。

穴を埋めるテストを足します。

```sober
// examples/guide/kv/kv_test.sober（抜粋）
// 3. the arm --cover and --mutate showed no test reached: a piece without `=`

func TestBadPiece() {
    assert(badAt("a=1;b") == 4 && badAt("a=1") == -1)
}

// where Parse reports a piece without `=` (-1 if it does not)
func badAt(s string) int {
    _, err := Parse(s)
    if err != nil {
        switch err {
        case BadPiece{at}: return at
        }
    }
    return -1
}
```

```sh
$ sober test kv3 --mutate
```

出力:

```
ok   kv3.TestBadPiece
ok   kv3.TestFormat
ok   kv3.TestParse
ok   kv3.TestRoundTrip
mutate: kv3 100.0% killed (36 of 36 reached) · 0 unreached · 2 timeout
4 passed, 0 failed
```

2体ともkillに変わりました。`timeout` は、ミュータントでループが終わらなくなり期限で止めた数です（killに数えます）。

生き残ったミュータントの中には、どう書いても殺せないもの（元と同じ振る舞いになる等価ミュータント）もあります。そのときは `<package>/testdata/mutate.ignore` に `--mutate-out=<file>` の行の先頭の2つのフィールド（位置とミュータント）を貼ると、走らせずに数から外せます。

## 4. ファジングで穴を埋める — `sober fuzz`

`Format` が作った行だけでなく、どんな行でも `Parse` がpanicしないこと、をプロパティにします。

```sober
// examples/guide/kv/kv_test.sober（抜粋）
// 4. for sober fuzz: Parse never panics, whatever the line

func TestAnyLine() {
    mut q := quick.New()
    quick.Check(mut q, () => {
        s := quick.String(mut q, 12)
        n := len(Parse(s) catch []Pair{})
        n >= 0
    })
}
```

`sober test` はこのプロパティを100回試します。直す前の `kvbug` でも100回では見つかりません。`sober fuzz` は同じプロパティを期限まで回し続け、カバレッジを手がかりに新しい分岐を開く入力を育てます。

```sh
$ sober fuzz kvbug --run TestAnyLine --time 5s
```

出力:

```
quick: fuzz: panic at trial 122 (seed 516221799, 43 shrink runs)
  String = "\\"
panic: index out of range at kvbug/kv.sober:44:28
quick: wrote kvbug/testdata/fuzz/TestAnyLine/0-6285beb84c4f3dee
panic: quick.Crashed{exit: 101} at std/quick/fuzz.sober:232:10
```

`"\\"`（`\` 1文字の行）で `field` が範囲の外を読んでいました。`Format` が作る行は最後が1つだけの `\` にならないので、往復のプロパティでは届かない入力です。見つけた反例はシュリンクして `testdata/fuzz/TestAnyLine/` に書かれます。以後は普通の `sober test` が試行の前にこのファイルを再生するので、同じバグが戻ってくれば毎回落ちます。

```sh
$ sober test kvbug --run TestAnyLine
```

出力:

```
quick: panic in the corpus case kvbug/testdata/fuzz/TestAnyLine/0-6285beb84c4f3dee (seed 516221799, 20 shrink runs)
  String = "\\"
panic: index out of range at kvbug/kv.sober:44:28
panic: quick.Crashed{exit: 101} at std/quick/fuzz.sober:232:10
FAIL kvbug.TestAnyLine (exit 101)
0 passed, 1 failed
```

`field` のエスケープの条件に `j + 1 < len(b)` を足して直すと、最後の状態（`kv`）です。直した条件の分だけミュータントも増えますが、このプロパティが全部殺します。

```sh
$ sober test kv --mutate
```

出力:

```
ok   kv.TestAnyLine
ok   kv.TestBadPiece
ok   kv.TestCountAll
ok   kv.TestFormat
ok   kv.TestParse
ok   kv.TestRoundTrip
mutate: kv 100.0% killed (40 of 40 reached) · 0 unreached · 3 timeout
6 passed, 0 failed
```

## 5. 並行のテスト — `--sched`

`CountAll` は行をtaskで並べて数えます。並べた結果が1行ずつ数えた結果と同じ、をプロパティにします。

```sober
// examples/guide/kv/kv_test.sober（抜粋）
// 5. lines read in parallel count the same as one by one (sober fuzz --sched shuffles the schedule)

func TestCountAll() {
    mut q := quick.New()
    quick.Check(mut q, () => {
        lines := quick.Slice(mut q, 6, () => quick.String(mut q, 8))
        ns := CountAll(lines)
        mut ok := len(ns) == len(lines)
        for i <- iter.Range(0, len(ns)) {
            ok = ok && ns[i] == count(lines[i])
        }
        ok
    })
}
```

`sober fuzz --sched` は試行ごとにtaskのスケジュール（どの順に走らせるか）もシードで振ります。順番に依る失敗が見つかれば、そのシードで何度でも同じ交互配置を再現できます。

```sh
$ sober fuzz kv --run TestCountAll --sched --time 2s
```

出力:

```
quick: fuzz: <n> trials, no failure (check 0, seed 45306338)
```

試行の数は期限に依るので、ここでは `<n>` と書いています。Soberのtaskは可変の状態を共有しないので、この `CountAll` に順番に依る失敗はありません。チャネルや共有の表を使うコードで効く道具です。taskを使うテストも、`SOBER_SCHED_SEED` を固定すれば `sober test` の結果はワーカー数に依らず同じです。

## 6. 保存するたびに — `sober watch`

`sober watch <entry>`（entryは `kv` を使うプログラムのmain package）は、ファイルを保存するたびにcheckをやり直し、裏でbuildとテストを走らせて結果を覚えます。通ったpackageの `sober test` はビルドせずに走らせずに覚えた結果を返します（数ms）。自分で `sober test` を打つ頃には、テストがもう終わっています。

watchは立てたら忘れてかまいません。普段どおり `sober check` / `build` / `test` を打てば、温めた結果に当たって速く返ります。watchの出力を見るのは、不具合を疑ったときだけで足ります。

```sh
sober watch app
```

（この出力は時刻に依るので、ここでは載せません。）

## 7. 本物の代わりにdoubleを読む — `@doubles`

`kv` を使って設定を読み書きするpackage `settings` を考えます。設定はファイルに1行ずつ置き、ファイルの読み書きはpackage `kvstore` が受け持ちます。

```sober
// examples/guide/kvstore/kvstore.sober
package kvstore

// Keeps one line of text per name, as files under a directory (the subject of section 7 of docs/guide/testing.md).

import "std/io"

type Dir struct {
    path string
}

// no file called name
type Missing error {
    name string
}

// the file could not be written
type Denied error {}

func Open(path string) Dir {
    return Dir{path: path}
}

@effects(io, nondet)
@errors(Missing)
func Load(d Dir, name string) (string, error?) {
    b := io.ReadFile(d.path + "/" + name) catch return "", Missing{name: name}
    return string(b) catch "", nil
}

@effects(io, nondet)
@errors(Denied)
func Store(d Dir, name string, line string) error? {
    err := io.WriteFile(d.path + "/" + name, bytes(line))
    return if err != nil { Denied{} } else { nil }
}
```

```sober
// examples/guide/settings/settings.sober
package settings

// Settings kept as one `key=value;key=value` line per file in a kvstore directory.

import "kv"
import "kvstore"

// the value of key in the file name, or def when the file or the key is missing
func Value(d kvstore.Dir, name string, key string, def string) string {
    line := kvstore.Load(d, name) catch return def
    ps := kv.Parse(line) catch return def
    mut i := 0
    while i < len(ps) {
        if ps[i].key == key {
            return ps[i].value
        }
        i += 1
    }
    return def
}

// sets key = value in the file name (creating the file) and writes the file back
@errors(kvstore.Denied)
func Set(d kvstore.Dir, name string, key string, value string) error? {
    line := kvstore.Load(d, name) catch ""
    ps := kv.Parse(line) catch []kv.Pair{}
    mut out := mut []kv.Pair{}
    mut found := false
    mut i := 0
    while i < len(ps) {
        if ps[i].key == key {
            out = append(out, kv.Pair{key: key, value: value})
            found = true
        } else {
            out = append(out, ps[i])
        }
        i += 1
    }
    if !found {
        out = append(out, kv.Pair{key: key, value: value})
    }
    return kvstore.Store(d, name, kv.Format(freeze(out)))
}
```

`settings` は `kvstore` を直にimportして呼んでいます。interfaceもコンストラクタへの注入もありません。それでも `settings` のテストはディスクに触らずに書けます。テストのビルドの中でだけ、`kvstore` を代役（double）に丸ごと差し替えるからです。

doubleは差し替える相手の下のディレクトリに置き、ファイル名は `_double.sober` で終えます。package節の前の `@replaces` で相手を名乗り、package名は相手と同じにします。

```sober
// examples/guide/kvstore/mem/mem_double.sober
@replaces("kvstore")
package kvstore

// A double of kvstore: the files live in a cell instead of on disk, and a directory from Failing refuses every write.

import "std/testing/cell"

type Dir struct {
    failing bool
}

type File struct {
    name string
    line string
}

type Missing error {
    name string
}

type Denied error {}

// the files written so far, in the order of the writes
const Files = testing.cell.Cell[[]File]{}

func Empty() Dir {
    return Dir{failing: false}
}

func Failing() Dir {
    return Dir{failing: true}
}

@errors(Missing)
func Load(d Dir, name string) (string, error?) {
    fs := testing.cell.Get(Files)
    mut i := len(fs) - 1
    while i >= 0 {
        if fs[i].name == name {
            return fs[i].line, nil
        }
        i -= 1
    }
    return "", Missing{name: name}
}

@errors(Denied)
func Store(d Dir, name string, line string) error? {
    if d.failing {
        return Denied{}
    }
    testing.cell.Update(Files, (fs []File) => append(fs, File{name: name, line: line}))
    return nil
}
```

ファイルの代わりに、std/testing/cellの格納場所 `Files` に書いた行を貯めます。格納場所はテストのプロセスに1つで、テストごとに空から始まります。`Empty` と `Failing` はdoubleにだけある名前で、テストが状態の初期値と書きの誤りの注入を選ぶAPIです。

テストのpackageは、`_test.sober` のpackage節の前の `@doubles` で使うdoubleを明示します。

```sober
// examples/guide/settings/settings_test.sober
@doubles("kvstore/mem")
package settings

import "kvstore/mem"
import "std/testing/cell"

func TestSetThenValue() {
    d := kvstore.mem.Empty()
    assert(Set(d, "app", "port", "80") == nil)
    assert(Set(d, "app", "host", "a=b") == nil)
    assert(Set(d, "app", "port", "8080") == nil)
    assert(Value(d, "app", "port", "") == "8080")
    assert(Value(d, "app", "host", "") == "a=b")
    assert(Value(d, "app", "user", "-") == "-")
    files := testing.cell.Get(kvstore.mem.Files)
    assert(files[len(files) - 1].line == "port=8080;host=a\\=b")
}

func TestMissingFile() {
    assert(Value(kvstore.mem.Empty(), "app", "port", "8080") == "8080")
}

func TestDenied() {
    assert(Set(kvstore.mem.Failing(), "app", "port", "80") != nil)
    assert(len(testing.cell.Get(kvstore.mem.Files)) == 0)
}
```

```sh
$ sober test settings
```

出力:

```
ok   settings.TestSetThenValue
ok   settings.TestMissingFile
ok   settings.TestDenied
3 passed, 0 failed
```

そのテストのビルドでは、`kvstore` をimportするファイルが全部doubleを読みます（`settings.sober` も）。本番のbuildとcheckは `_double.sober` を読みません。どのテストがどのdoubleで走るかは `--wiring` で一覧できます（ビルドするだけで走らせません）。

```sh
$ sober test settings --wiring
```

出力:

```
settings: kvstore <= kvstore/mem
```

doubleは本物と食い違えません。doubleと本物の両方にある名前は、関数の署名・型のフィールドの型・`@errors` が照合され、doubleのエフェクト（analyzerが導く）は本物の `@effects` の内側でなければなりません。本物に無いエフェクト（panic・本物がioを持たないのにio）を持つdoubleは拒否されます。本物にあってdoubleに無い名前は書かなくてかまいません。テストが使う分だけ書けば足ります。

## 8. その儀式は要らない

他の言語で `settings` をディスクなしでテストするには、たいてい次の手順を踏みます。

1. `kvstore` の操作をinterface（`Store`）に切り出す
2. 本番の実装と、テスト用の実装（モック）を1つずつ書く
3. `settings` の関数かコンストラクタに `Store` の引数を足し、呼ぶ側全部で本番の実装を渡す（DIコンテナを使うこともある）
4. 層を分ける規約（「ドメインはインフラに依存しない」）を守るため、依存の向きをinterfaceで逆にする

Soberではどれも要りません。差し替えはテストのビルドの中のimportの解決先の付け替えで済み（7節）、本番のコードは本物を直に呼ぶ形のままです。差し替えのためのinterfaceも引数も層も持ち込みません。

モックが本物と乖離する心配は、契約の照合（署名・型・エフェクト）が塞ぎます。依存の向きはimportのグラフに全部出ていて、閉じた世界の中で静的に見えます。

やらないことの一覧:

- 実装が1つしかないinterfaceを、テストのために作らない（振る舞いを差し替える必要が本番にあるときは [抽象化](abstraction.ja.md) の関数値とstructで）
- テストのために関数の引数を増やさない
- モックのライブラリやDIコンテナを使わない
- 差し替えのためだけに層を分けない

いまはstdのpackage（時計・ネットワーク・ファイル）を直に差し替える仕組みはありません。stdを相手にした差し替えは、自分のpackageで包んでそのpackageを差し替えます（この節の `kvstore` の形）。

## まとめ

1. 単発の例を `assert` で書く
2. プロパティをstd/quickで書く（反例は最小形で出て、シード1つで再現できる）
3. `--cover` で通っていない分岐を、`--mutate` で通っているのに見ていない所を見つける
4. `sober fuzz` でファジングし、見つけた反例は `testdata/fuzz` に残って回帰テストになる
5. taskを使うコードは `--sched` でスケジュールも振る
6. 依存は `@doubles` でテストのビルドの中だけdoubleに差し替える（interfaceも注入も要らない）

どの段階でも、同じコードと同じシードなら結果は毎回同じでした（2節の反例・3節の割合・4節のfuzzが見つけた試行）。だから失敗はシード1つで再現でき、通った結果は覚えておいて再生でき（6節）、ミュータントごとの判定も1回走らせれば決まります。

正確な定義は [言語仕様13章](../spec/13-testing.ja.md)、決定の経緯は [決定の記録](../language.md) の35・39・40・41節にあります。
