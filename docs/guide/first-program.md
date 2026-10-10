# Your first program

English | [日本語](first-program.ja.md)

We write a small `wc` that counts the lines, words and bytes of standard input, build and run it, then split code into a package and write tests.

## Read input and count

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

Things to notice:

- `io.ReadStdin() catch return 1` — `ReadStdin` returns `([]byte, error?)`. `catch` is where you write "if it is an error, do this"; here it exits with code 1. An error is either handled with `catch`, returned to the caller with `?`, or received as `err` and inspected.
- `mut` — only bindings that change get `mut`. `b` (the bytes read) has none, so it never changes afterwards.
- `for c <- b { … }` — iterating over a slice. `c` is a `byte`.
- A character literal `' '` is a single ASCII byte (`byte`).
- `"${lines} ${words} ${len(b)}"` — string interpolation.

## Split into a package

A directory is a package. Only names that start with an upper-case letter are visible from outside (as in Go).

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

// Gcd is the greatest common divisor of a and b
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

Import paths are relative to the directory you build from (here `proj/`).

```sh
cd proj
sober build app/main.sober -o gcd && ./gcd    # 12
sober check app/main.sober                     # type checking and the analyzer only — the result is one line of JSON
```

## Write tests

Each `func TestXxx()` in a `*_test.sober` file inside a package is a test. `assert` can be used only in test files.

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

When an `assert` fails, it prints the value of each part of the expression (power assert):

```
assert failed: Gcd(7, 13) == 2
  Gcd(7, 13) = 1
```

Next: [Language tour](tour.md)
