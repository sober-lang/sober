# 最初のプログラム

[English](first-program.md) | 日本語

標準入力の行・語・バイトを数える小さな `wc` を書いて、建てて走らせ、package に分けてテストを書くところまでを通します。

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

- `io.ReadStdin() catch return 1` — `ReadStdin` は `([]byte, error?)` を返します。`catch` は「エラーならこうする」を書く場所で、ここでは終了コード 1 で抜けます。エラーは `catch` で扱うか、`?` で呼び手へ返すか、`err` を受けて調べます。
- `mut` — 変える束縛だけに `mut` を付けます。`b`（読んだバイト列）は付けていないので、以後は変わりません。
- `for c <- b { … }` — slice の走査。`c` は `byte` です。
- 文字リテラル `' '` は ASCII の 1 バイト（`byte`）です。
- `"${lines} ${words} ${len(b)}"` — 文字列の補間。

## package に分ける

ディレクトリが package です。名前が大文字で始まるものだけが外から見えます（Go と同じ）。

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

// Gcd は a と b の最大公約数
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

import のパスはビルドするディレクトリ（ここでは `proj/`）からの相対です。

```sh
cd proj
sober build app/main.sober -o gcd && ./gcd    # 12
sober check app/main.sober                     # 型検査と解析器だけ — 結果は JSON の 1 行
```

型の誤りがあると、JSON の行（`"ok":false`）の前に、標準エラーへ `sober: type error at app/main.sober:4:14` の形で位置を 1 行出します。

## テストを書く

package の中の `*_test.sober` の `func TestXxx()` がテストです。`assert` はテストのファイルの中だけで使えます。

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

`assert` は失敗すると式の部分ごとの値を出します（power assert）:

```
assert failed: Gcd(7, 13) == 2
  Gcd(7, 13) = 1
```

次へ: [言語ツアー](tour.ja.md)
