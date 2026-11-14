# 最初のプログラム

[English](first-program.md) | 日本語

標準入力の行・語・バイトを数える小さな `wc` を書いて、ビルドして走らせ、packageに分けてテストを書くところまでを通します。

## 入力を読んで数える

```sober
// examples/wc.sober
package main

import "std/io"

// wc: count lines, words and bytes of standard input (docs/guide/first-program.md)

func isSpace(c byte) bool {
    return c == ' ' || c == '\n' || c == '\t' || c == '\r'
}

func main() int {
    b := io.ReadStdin() catch return 1
    mut lines := 0
    mut words := 0
    mut inWord := false
    for c <- b {
        if c == '\n' {
            lines += 1
        }
        if isSpace(c) {
            inWord = false
        } else if !inWord {
            inWord = true
            words += 1
        }
    }
    println("${lines} ${words} ${len(b)}")
    return 0
}
```

```sh
sober build examples/wc.sober -o wc
printf 'Sober is a minimal language.\nIt is fast, safe and plain.\n\nThe end\n' | ./wc
```

```
4 13 66
```

読みどころ:

- `io.ReadStdin() catch return 1` — `ReadStdin` は `([]byte, error?)` を返します。`catch` は「エラーならこうする」を書く場所で、ここでは終了コード1で抜けます。エラーは `catch` で扱うか、`?` で呼び手へ返すか、`err` を受けて調べます。
- `mut` — 変える束縛だけに `mut` を付けます。`b`（読んだバイト列）は付けていないので、以後は変わりません。
- `for c <- b { … }` — sliceの走査。`c` は `byte` です。
- 文字リテラル `' '` はASCIIの1バイト（`byte`）です。
- `"${lines} ${words} ${len(b)}"` — 文字列の補間。

## packageに分ける

ディレクトリがpackageです。名前が大文字で始まるものだけが外から見えます（Goと同じ）。

```
proj/
  mathx/
    mathx.sober
    mathx_test.sober
  app/
    main.sober
```

```sober
// proj/mathx/mathx.sober
package mathx

// a と b の最大公約数
func Gcd(a int, b int) int {
    mut x := a
    mut y := b
    while y != 0 {
        t := x % y
        x = y
        y = t
    }
    return x
}
```

```sober
// proj/app/main.sober
package main

import "mathx"

func main() int {
    println(mathx.Gcd(84, 36))
    return 0
}
```

importのパスはルート（ビルドの起点のディレクトリ — `sober` を実行するディレクトリで、ここでは `proj/`）からの相対です。起点より上のディレクトリは探しません。修飾子はパスの全要素を `.` でつないだものです（`import "util/strings"` なら `util.strings.X` — `std/` だけは落として `import "std/json"` は `json.X`）。起点に `sober.mod` を置くと、モジュールの名前とローカルの依存を宣言できます（下の「[モジュールと依存](#モジュールと依存)」）。

```sh
cd proj
sober build app/main.sober -o gcd && ./gcd    # 12
sober check app/main.sober                     # 型検査と解析器だけ — 結果は JSON の 1 行
```

型の誤りがあると、JSONの行（`"ok":false`）の前に、標準エラーへ `sober: type error at app/main.sober:4:14` の形で位置を1行出します。

## テストを書く

packageの中の `*_test.sober` の `func TestXxx()` がテストです。`assert` はテストのファイルの中だけで使えます。

```sober
// proj/mathx/mathx_test.sober
package mathx

func TestGcd() {
    assert(Gcd(12, 18) == 6)
    assert(Gcd(7, 13) == 1)
}
```

```sh
sober test mathx
```

```
ok   mathx.TestGcd
1 passed, 0 failed
```

`assert` は失敗すると、式の部分ごとの値（power assert）と、失敗した `assert` の位置を出します（5行目を `== 2` にしたとき）:

```
assert failed: Gcd(7, 13) == 2
  Gcd(7, 13) = 1
panic: testing.AssertFailed{} at mathx/mathx_test.sober:5:5
```

## モジュールと依存

別のディレクトリにある木（自分のライブラリや、隣に置いた他人のコード）を使うときは、ビルドの起点に `sober.mod` を置きます。下は `examples/mod/` の2つのモジュールで、`text` は文字列の小さなライブラリ、`hello` はそれを依存（dep）として使うプログラムです。

```
examples/mod/
  text/                 module "example.com/text"
    sober.mod
    text.sober          package text
    pad/pad.sober       package pad
  hello/                module "example.com/hello"（起点）
    sober.mod
    main.sober          package main
    greet/greet.sober   package greet
```

使われる側の `sober.mod` は名前だけを宣言します。

```sober
// examples/mod/text/sober.mod
// a library module: other modules use it as a dep (module text — its packages are text and text/pad)
module "example.com/text"
```

```sober
// examples/mod/text/text.sober
package text

import "std/strings"

// s in capitals, with an exclamation mark
func Shout(s string) string {
    return "${strings.ToUpper(s)}!"
}
```

```sober
// examples/mod/text/pad/pad.sober
package pad

// s padded with dots on the left up to n bytes
func Left(s string, n int) string {
    mut out := s
    while len(bytes(out)) < n {
        out = ".${out}"
    }
    return out
}
```

使う側の `sober.mod` は自分の名前とdepを宣言します。

```sober
// examples/mod/hello/sober.mod
// the app's module: its own package greet, and the module next to it as the dep text
module "example.com/hello"

dep "../text"
```

```sober
// examples/mod/hello/greet/greet.sober
package greet

import "text"

// a greeting for name
func Hello(name string) string {
    return text.Shout("hello, ${name}")
}
```

```sober
// examples/mod/hello/main.sober
package main

import "greet"
import "text/pad"

func main() int {
    println(greet.Hello("sober"))
    println(text.pad.Left("42", 6))
    return 0
}
```

- `module` の行はモジュールのパスで、最後の要素が名前です（`example.com/text` なら `text`）。この名前が、使う側の木での既定の名前になります。名前を変えると使う側の参照の綴りが全部変わるので、版を跨いで変えないでください
- `dep "../text"` は起点からの相対のローカルパスです。importパスは出所ではなく木での名前から書きます（`import "text"` → `text.Shout`・`import "text/pad"` → `text.pad.Left`）。出所を書くのは `sober.mod` だけなので、置き場所を移しても直すのはこの1行です
- 自分の木のpackage（`greet`）からも、depを同じ綴りでimportします

起点（`examples/mod/hello`）で走らせます。

```sh
$ sober check main.sober
```

出力:

```
{"ok":true,"ty":{"k":"int"}}
```

```sh
$ sober run main.sober
```

出力:

```
HELLO, SOBER!
....42
```

importパスの根の要素（stdの根の `json`・`http` …、depの名前、起点の木の根のディレクトリ）は1つの名前空間に住みます。名前が重なるとどちらも優先せずに拒否し、解消は `sober.mod` の行で行います: 自分の木に `json/` があって `std/json` も使うなら `alias stdjson "std/json"`（`std/json` の修飾子が `stdjson` になる）、depどうしなら `dep text2 "../other/text"`（木での名前を `text2` に付け替える）。ファイルごとの別名のimportでは解消しません。

この版のdepはローカルパスだけです（版の指定・他の出所・depのdepは専用の診断で拒否します）。規則の全文は [言語仕様8 package](../spec/08-packages.ja.md) のP-9、Goのgo.modとの違いは [language.md 20節](../language.md) の表にあります。

次へ: [言語ツアー](tour.ja.md)
