# テストの書き方

[English](testing.md) | 日本語

小さな package `kv` を題材に、テストを 6 段で足していきます。各段は「書く → 走らせる → 出力を見る」の順です。ここに載せた出力はすべて実物で、リポジトリの検査（`scripts/gates.sh` の guidetest）が毎回同じコマンドを走らせて照合しています。

前提: [最初のプログラム](first-program.ja.md#テストを書く)（`*_test.sober` と `sober test`）と [言語ツアー](tour.ja.md) の 1〜5 節。

使う技法は 5 つで、下から順に積み上がります（右の列が Sober での入口です）。

```
ファジング              sober fuzz
ミューテーションテスト  sober test --mutate
カバレッジ              sober test --cover
プロパティベーステスト  std/quick
単体テスト              assert
```

## 0. 題材 — `kv`

`key=value;key=value` の 1 行を読み書きする package です。キーや値の中の `;`・`=`・`\` は `\` でエスケープします。

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

題材の途中の状態は `examples/guide/` に置いてあります。自分の package に写経しながら進めるときは、各節の終わりの状態と見比べてください。

| ディレクトリ | 状態 |
| --- | --- |
| `kvbug` | 直す前（バグが 3 つある。1・2・4 節で 1 つずつ見つかる） |
| `kv2` | 2 節の終わり（テスト 3 本） |
| `kv3` | 3 節の終わり（テスト 4 本） |
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
$ sober test examples/guide/kv2 --run TestParse
```

出力:

```
ok   examples/guide/kv2.TestParse
1 passed, 0 failed
```

直す前の `kvbug` で同じテストを走らせると、落ちた `assert` の部分式の値が出ます。`Parse` が 2 つ読むはずの行から 1 つも読めていません（ループの条件の `<` が `<=` になっていて、末尾の `;` の後ろをもう 1 片として読もうとして失敗します）。

```sh
$ sober test examples/guide/kvbug --run TestParse
```

出力:

```
assert failed: len(ps) == 2
  len(ps) = 0
panic: testing.AssertFailed{} at std/testing/testing.sober:25:10
FAIL examples/guide/kvbug.TestParse (exit 101)
0 passed, 1 failed
```

`assert` は `&&` で繋ぐより 1 つの条件ずつ書くと、どこで落ちたかが値つきで読めます。

## 2. プロパティベーステスト — std/quick

手で書いた例は、書いた人が思いついた入力しか試しません。std/quick では「どんな入力でも成り立つこと」（プロパティ）を書き、入力はジェネレータに作らせます。`kv` のプロパティは往復です。どんな組の列でも、`Format` してから `Parse` すると元に戻るはずです。

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
$ sober test examples/guide/kvbug --run TestRoundTrip
```

出力:

```
quick: falsified at trial 49 of 100 (seed 392200337, 92 shrink runs)
  Slice:
    String = ""
    String = ";"
  (1 items)
assert failed: same(back, ps)
panic: testing.AssertFailed{} at std/testing/testing.sober:25:10
FAIL examples/guide/kvbug.TestRoundTrip (exit 101)
0 passed, 1 failed
```

100 回の試行の 49 回目でプロパティが偽になり、反例をシュリンク（縮小）した結果が出ています。値が `";"` の Pair が 1 つです。直す前の `Format` は `;` をエスケープしないので `"=;"` と書き出し、`Parse` が値を `;` のところで切ってしまいます。シュリンクはジェネレータが引いた選択の列を短く・小さくして探すので、型ごとのシュリンクの方法を書く必要はありません。

何度走らせても、同じ試行で同じ反例が出ます。テストの名前とシード（`seed 392200337`）が同じなら、ジェネレータが作る入力の列も同じだからです。落ちたテストは直した後にそのまま走らせ直せば確かめられます。

`escape` で `;` と `=` もエスケープするように直し、1 節のループの条件も `<` に直すと、2 節の終わりの状態（`kv2`）になります（3 つ目のバグはまだ残っていて、4 節で見つけます）。

```sh
$ sober test examples/guide/kv2
```

出力:

```
ok   examples/guide/kv2.TestParse
ok   examples/guide/kv2.TestFormat
ok   examples/guide/kv2.TestRoundTrip
3 passed, 0 failed
```

## 3. カバレッジとミューテーションテスト — `--cover` と `--mutate`

テストが全部通っても、テストが十分とは限りません。2 つの物差しで測ります。

まず `--cover` で、どの分岐をどのテストも通っていないかを見ます（出力では分岐の片側ずつを arm と呼びます）。

```sh
$ sober test examples/guide/kv2 --cover
```

出力:

```
ok   examples/guide/kv2.TestParse
ok   examples/guide/kv2.TestFormat
ok   examples/guide/kv2.TestRoundTrip
cover: examples/guide/kv2 69.2% of 26 arms (fn 4/6)
  examples/guide/kv2/kv.sober:26:9   then   never taken
  examples/guide/kv2/kv.sober:47:32  catch  never taken
  examples/guide/kv2/kv.sober:60:32  catch  never taken
  examples/guide/kv2/kv.sober:75:6   fn     never called  (CountAll)
  examples/guide/kv2/kv.sober:77:12  then   never taken
  examples/guide/kv2/kv.sober:77:12  else   never taken
  examples/guide/kv2/kv.sober:80:6   fn     never called  (count)
  examples/guide/kv2/kv.sober:81:20  catch  never taken
3 passed, 0 failed
```

`kv.sober:26:9` の `then` は、`Parse` が `=` の無い片を見つけて `BadPiece` を返す分岐です。どのテストもエラーの経路を通っていません。`CountAll` と `count` は 5 節で使うのでまだ呼ばれていません。`catch` の腕のうち `string(...) catch ""` の 2 つは、正しい UTF-8 しか作らないので通りません（全部を 100% にする必要はありません）。

次に `--mutate` で、テストが通っている所を本当に見ているかを測ります。コードを少しずつ壊した版（ミュータント）を全部 1 本の実行ファイルに入れ、ミュータントごとにそのミュータントに届いたテストを走らせます。どれかのテストが落ちれば kill、全部通れば生存です。

```sh
$ sober test examples/guide/kv2 --mutate
```

出力:

```
ok   examples/guide/kv2.TestFormat
ok   examples/guide/kv2.TestParse
ok   examples/guide/kv2.TestRoundTrip
mutate: examples/guide/kv2 94.4% killed (34 of 36 reached) · 0 unreached · 2 timeout
  examples/guide/kv2/kv.sober:26:9 cond → false       survived  (reached by TestParse, TestRoundTrip)
  examples/guide/kv2/kv.sober:26:14 >= → >             survived  (reached by TestParse, TestRoundTrip)
3 passed, 0 failed
```

割合は「kill した数 / テストが届いた数」です。生き残ったミュータントが「通っているのに見ていない」所です。ここでは 2 体とも `BadPiece` を返す条件（`26:9` の条件を偽に固定・`26:14` の `>=` を `>` に）で、壊しても誰も気づきません。カバレッジで通っていなかった分岐と同じ穴です。

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
$ sober test examples/guide/kv3 --mutate
```

出力:

```
ok   examples/guide/kv3.TestBadPiece
ok   examples/guide/kv3.TestFormat
ok   examples/guide/kv3.TestParse
ok   examples/guide/kv3.TestRoundTrip
mutate: examples/guide/kv3 100.0% killed (36 of 36 reached) · 0 unreached · 2 timeout
4 passed, 0 failed
```

2 体とも kill に変わりました。`timeout` は、ミュータントでループが終わらなくなり期限で止めた数です（kill に数えます）。

生き残ったミュータントの中には、どう書いても殺せないもの（元と同じ振る舞いになる等価ミュータント）もあります。そのときは `<package>/testdata/mutate.ignore` に `--mutate-out=<file>` の行の先頭 2 欄（位置とミュータント）を貼ると、走らせずに数から外せます。

## 4. ファジングで穴を埋める — `sober fuzz`

`Format` が作った行だけでなく、どんな行でも `Parse` が panic しないこと、をプロパティにします。

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

`sober test` はこのプロパティを 100 回試します。直す前の `kvbug` でも 100 回では見つかりません。`sober fuzz` は同じプロパティを期限まで回し続け、カバレッジを手がかりに新しい分岐を開く入力を育てます。

```sh
$ sober fuzz examples/guide/kvbug --run TestAnyLine --time 5s
```

出力:

```
quick: fuzz: panic at trial 122 (seed 516221799, 43 shrink runs)
  String = "\\"
panic: index out of range at examples/guide/kvbug/kv.sober:44:28
quick: wrote examples/guide/kvbug/testdata/fuzz/TestAnyLine/0-6285beb84c4f3dee
panic: quick.Crashed{exit: 101} at std/quick/fuzz.sober:232:10
```

`"\\"`（`\` 1 文字の行）で `field` が範囲の外を読んでいました。`Format` が作る行は最後が 1 つだけの `\` にならないので、往復のプロパティでは届かない入力です。見つけた反例はシュリンクして `testdata/fuzz/TestAnyLine/` に書かれます。以後は普通の `sober test` が試行の前にこのファイルを再生するので、同じバグが戻ってくれば毎回落ちます。

```sh
$ sober test examples/guide/kvbug --run TestAnyLine
```

出力:

```
quick: panic in the corpus case examples/guide/kvbug/testdata/fuzz/TestAnyLine/0-6285beb84c4f3dee (seed 516221799, 20 shrink runs)
  String = "\\"
panic: index out of range at examples/guide/kvbug/kv.sober:44:28
panic: quick.Crashed{exit: 101} at std/quick/fuzz.sober:232:10
FAIL examples/guide/kvbug.TestAnyLine (exit 101)
0 passed, 1 failed
```

`field` のエスケープの条件に `j + 1 < len(b)` を足して直すと、最後の状態（`kv`）です。直した条件の分だけミュータントも増えますが、このプロパティが全部殺します。

```sh
$ sober test examples/guide/kv --mutate
```

出力:

```
ok   examples/guide/kv.TestAnyLine
ok   examples/guide/kv.TestBadPiece
ok   examples/guide/kv.TestCountAll
ok   examples/guide/kv.TestFormat
ok   examples/guide/kv.TestParse
ok   examples/guide/kv.TestRoundTrip
mutate: examples/guide/kv 100.0% killed (40 of 40 reached) · 0 unreached · 3 timeout
6 passed, 0 failed
```

## 5. 並行のテスト — `--sched`

`CountAll` は行を task で並べて数えます。並べた結果が 1 行ずつ数えた結果と同じ、をプロパティにします。

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

`sober fuzz --sched` は試行ごとに task のスケジュール（どの順に走らせるか）もシードで振ります。順番に依る失敗が見つかれば、そのシードで何度でも同じ交互配置を再現できます。

```sh
$ sober fuzz examples/guide/kv --run TestCountAll --sched --time 2s
```

出力:

```
quick: fuzz: <n> trials, no failure (check 0, seed 45306338)
```

試行の数は期限に依るので、ここでは `<n>` と書いています。Sober の task は可変の状態を共有しないので、この `CountAll` に順番に依る失敗はありません。チャネルや共有の表を使うコードで効く道具です。task を使うテストも、`SOBER_SCHED_SEED` を固定すれば `sober test` の結果はワーカー数に依らず同じです。

## 6. 保存するたびに — `sober watch`

`sober watch <entry>`（entry は `kv` を使うプログラムの main package）は、ファイルを保存するたびに check をやり直し、裏で build とテストを走らせて結果を覚えます。通った package の `sober test` は建てずに走らせずに覚えた結果を返します（数 ms）。自分で `sober test` を打つ頃には、テストがもう終わっています。

```sh
sober watch app
```

（この出力は時刻に依るので、ここでは載せません。）

## まとめ

1. 単発の例を `assert` で書く
2. プロパティを std/quick で書く（反例は最小形で出て、シード 1 つで再現できる）
3. `--cover` で通っていない分岐を、`--mutate` で通っているのに見ていない所を見つける
4. `sober fuzz` でファジングし、見つけた反例は `testdata/fuzz` に残って回帰テストになる
5. task を使うコードは `--sched` でスケジュールも振る

どの段でも、同じコードと同じシードなら結果は毎回同じでした（2 節の反例・3 節の割合・4 節の fuzz が見つけた試行）。だから失敗はシード 1 つで再現でき、通った結果は覚えておいて再生でき（6 節）、ミュータントごとの判定も 1 回走らせれば決まります。

正確な定義は [言語仕様 13 章](../spec/13-testing.ja.md)、決定の経緯は [決定の記録](../language.md) の 35・39・40 節にあります。
