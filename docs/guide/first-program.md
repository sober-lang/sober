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

// the greatest common divisor of a and b
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

Import paths are relative to the root (the directory the build starts from — the one you run `sober` in, here `proj/`). Directories above the root are never searched. The qualifier is every segment of the path joined with `.` (`import "util/strings"` gives `util.strings.X`; only `std/` is dropped, so `import "std/json"` gives `json.X`). A `sober.mod` at the root declares the module's name and its local dependencies (see [Modules and dependencies](#modules-and-dependencies) below).

```sh
cd proj
sober build app/main.sober -o gcd && ./gcd    # 12
sober check app/main.sober                     # type checking and the analyzer only — the result is one line of JSON
```

When there is a type error, a line with its position, such as `sober: type error at app/main.sober:4:14`, goes to standard error before the JSON line (`"ok":false`).

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

When an `assert` fails, it prints the value of each part of the expression (power assert) and the position of the failing `assert` (here with line 5 changed to `== 2`):

```
assert failed: Gcd(7, 13) == 2
  Gcd(7, 13) = 1
panic: testing.AssertFailed{} at mathx/mathx_test.sober:5:5
```

## Modules and dependencies

To use a tree in another directory (your own library, or someone else's code placed next to yours), put a `sober.mod` at the build root. Below are the two modules in `examples/mod/`: `text` is a small string library, and `hello` is a program that uses it as a dependency (dep).

```
examples/mod/
  text/                 module "example.com/text"
    sober.mod
    text.sober          package text
    pad/pad.sober       package pad
  hello/                module "example.com/hello" — the root
    sober.mod
    main.sober          package main
    greet/greet.sober   package greet
```

The used module's `sober.mod` declares only its name.

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

The using module's `sober.mod` declares its own name and its dep.

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

- The `module` line is the module's path, and its last segment is the name (`text` for `example.com/text`). That name becomes the default name in the using module's tree. Changing it changes the spelling of every reference in the using code, so keep it stable across versions
- `dep "../text"` is a local path relative to the root. Import paths are written from the name in the tree, not from the origin (`import "text"` → `text.Shout`, `import "text/pad"` → `text.pad.Left`). Only `sober.mod` mentions the origin, so moving the dep means editing this one line
- Packages in your own tree (`greet`) import the dep with the same spelling

Run from the root (`examples/mod/hello`):

```sh
$ sober check main.sober
```

Output:

```
{"ok":true,"ty":{"k":"int"}}
```

```sh
$ sober run main.sober
```

Output:

```
HELLO, SOBER!
....42
```

The root segments of import paths (std roots such as `json` and `http`, dep names, and the root directories of the starting tree) live in one namespace. When names collide, neither wins: the build is rejected, and the fix goes in `sober.mod`. If your tree has `json/` and you also use `std/json`, write `alias stdjson "std/json"` (the qualifier of `std/json` becomes `stdjson`); for two deps, `dep text2 "../other/text"` renames one of them to `text2` in your tree. A per-file import alias does not resolve a collision.

In this version a dep must be a local path (versions, other origins and deps of deps are rejected by name). The full rules are P-9 in [language spec 8 Packages](../spec/08-packages.ja.md) (Japanese), and how this differs from Go's go.mod is tabulated in [language.md section 20](../language.md) (Japanese).

Next: [Language tour](tour.md)
