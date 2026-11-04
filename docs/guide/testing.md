# Writing tests

English | [日本語](testing.ja.md)

This page takes a small package, `kv`, and adds tests to it in six steps. Sections 7 and 8 replace a dependency with a double in the tests of a package that uses `kv`. Each step is "write → run → read the output". Every output shown here is real: the repository's checks (guidetest in `scripts/gates.sh`) runs the same commands every time and checks them.

Before this page: [Your first program](first-program.md) (`*_test.sober` and `sober test`) and sections 1–5 of the [Language tour](tour.md).

There are five techniques, stacked from the bottom up (the right column is where each one is in Sober).

```
fuzzing                  sober fuzz
mutation testing         sober test --mutate
coverage                 sober test --cover
property-based testing   std/quick
unit tests               assert
```

## 0. The subject — `kv`

A package that reads and writes one line of `key=value;key=value`. `;`, `=` and `\` inside a key or a value are escaped with `\`.

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

The intermediate states of the subject are in `examples/guide/`. If you type along in your own package, compare with the state at the end of each section.

| Directory | State |
| --- | --- |
| `kvbug` | before the fixes (three bugs; sections 1, 2 and 4 find one each) |
| `kv2` | the end of section 2 (three tests) |
| `kv3` | the end of section 3 (four tests) |
| `kv` | the end (everything) |

The start of the test file:

```sober
// examples/guide/kv/kv_test.sober (excerpt)
package kv

import "std/iter"
import "std/quick"
```

## 1. Unit tests — assert

A test is a `func TestXxx()` in a `*_test.sober` file. `assert` takes a plain expression: no message and no vocabulary like `expect(...).toBe(...)`.

```sober
// examples/guide/kv/kv_test.sober (excerpt)
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

Run it (`--run` selects tests by name prefix):

```sh
$ sober test examples/guide/kv2 --run TestParse
```

Output:

```
ok   examples/guide/kv2.TestParse
1 passed, 0 failed
```

On `kvbug`, the version before the fixes, the same test fails, and `assert` prints the value of each part of the expression. `Parse` read none of the two pairs on the line (the loop condition is `<=` instead of `<`, so it tries to read one more piece after the trailing `;` and fails):

```sh
$ sober test examples/guide/kvbug --run TestParse
```

Output:

```
assert failed: len(ps) == 2
  len(ps) = 0
panic: testing.AssertFailed{} at examples/guide/kvbug/kv_test.sober:10:5
FAIL examples/guide/kvbug.TestParse (exit 101)
0 passed, 1 failed
```

An `assert` per condition, rather than conditions joined with `&&`, tells you with values where it failed.

The position on the `panic:` line is the line of the failing `assert`. When one `assert` runs over the rows of a table, pass a label as the second argument and it appears in the heading (`assert(e, "case ${name}")` → `assert failed (case …): e`). The label is evaluated only when the assert fails.

## 2. Property-based testing — std/quick

A case written by hand tries only the inputs its author thought of. With std/quick you write what holds for any input (a property) and let generators make the inputs. The property of `kv` is the round trip: for any list of pairs, `Format` then `Parse` gives the pairs back.

```sober
// examples/guide/kv/kv_test.sober (excerpt)
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

The seed of `quick.New()` is decided by the test's name, so every run draws the same inputs. Run it on `kvbug`, before the fixes:

```sh
$ sober test examples/guide/kvbug --run TestRoundTrip
```

Output:

```
quick: falsified at trial 49 of 100 (seed 392200337, 92 shrink runs)
  Slice:
    String = ""
    String = ";"
  (1 items)
assert failed: same(back, ps)
panic: testing.AssertFailed{} at examples/guide/kvbug/kv_test.sober:26:13
FAIL examples/guide/kvbug.TestRoundTrip (exit 101)
0 passed, 1 failed
```

The property became false at trial 49 of 100, and the counterexample was shrunk (minimized): a single Pair whose value is `";"`. The `Format` before the fixes does not escape `;`, so it writes out `"=;"` and `Parse` cuts the value at the `;`. Shrinking works on the list of choices the generators drew, making it shorter and smaller, so you never write a shrinker per type.

Run it again and the same trial gives the same counterexample: the same test name and seed (`seed 392200337`) make the generators draw the same inputs. Once you fix the bug, running the same test again confirms it.

Escape `;` and `=` too in `escape`, and fix the loop condition of section 1 back to `<`: that is the state at the end of section 2 (`kv2`; the third bug is still there, and section 4 finds it).

```sh
$ sober test examples/guide/kv2
```

Output:

```
ok   examples/guide/kv2.TestParse
ok   examples/guide/kv2.TestFormat
ok   examples/guide/kv2.TestRoundTrip
3 passed, 0 failed
```

## 3. Coverage and mutation testing — `--cover` and `--mutate`

All tests passing does not mean the tests are enough. Two measures.

First, `--cover` shows which branches no test took (the output calls each side of a branch an arm):

```sh
$ sober test examples/guide/kv2 --cover
```

Output:

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

The `then` at `kv.sober:26:9` is the branch where `Parse` finds a piece without `=` and returns `BadPiece`: no test takes the error path. `CountAll` and `count` are used in section 5 and are not called yet. Two of the `catch` arms (`string(...) catch ""`) are never taken because the code only builds valid UTF-8 (you do not need 100%).

Next, `--mutate` measures whether the tests really look at what they pass through. Every small breakage of the code (a mutant) goes into one executable, and for each mutant the tests that reach it run. If a test fails the mutant is killed; if all pass it survived.

```sh
$ sober test examples/guide/kv2 --mutate
```

Output:

```
ok   examples/guide/kv2.TestFormat
ok   examples/guide/kv2.TestParse
ok   examples/guide/kv2.TestRoundTrip
mutate: examples/guide/kv2 94.4% killed (34 of 36 reached) · 0 unreached · 2 timeout
  examples/guide/kv2/kv.sober:26:9 cond → false       survived  (reached by TestParse, TestRoundTrip)
  examples/guide/kv2/kv.sober:26:14 >= → >             survived  (reached by TestParse, TestRoundTrip)
3 passed, 0 failed
```

The percentage is "killed / reached". A surviving mutant is a place the tests pass through without looking. Here both are the condition that returns `BadPiece` (the condition at `26:9` fixed to false, `>=` at `26:14` turned into `>`): break it and nobody notices. It is the same hole as the branch coverage showed untaken.

Add a test that fills it:

```sober
// examples/guide/kv/kv_test.sober (excerpt)
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

Output:

```
ok   examples/guide/kv3.TestBadPiece
ok   examples/guide/kv3.TestFormat
ok   examples/guide/kv3.TestParse
ok   examples/guide/kv3.TestRoundTrip
mutate: examples/guide/kv3 100.0% killed (36 of 36 reached) · 0 unreached · 2 timeout
4 passed, 0 failed
```

Both are killed now. `timeout` counts the mutants whose loop never ended and were stopped at the deadline (counted as killed).

Some surviving mutants cannot be killed however you write the tests (equivalent mutants — they behave like the original). Put the first two columns (position and mutation) of their `--mutate-out=<file>` lines into `<package>/testdata/mutate.ignore` and they are not run and not counted.

## 4. Filling holes with fuzzing — `sober fuzz`

Make a property that `Parse` never panics, for any line — not only the lines `Format` makes.

```sober
// examples/guide/kv/kv_test.sober (excerpt)
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

`sober test` tries the property 100 times, which does not find the bug even on `kvbug`. `sober fuzz` runs the same property until a deadline and grows inputs that open new branches, guided by coverage:

```sh
$ sober fuzz examples/guide/kvbug --run TestAnyLine --time 5s
```

Output:

```
quick: fuzz: panic at trial 122 (seed 516221799, 43 shrink runs)
  String = "\\"
panic: index out of range at examples/guide/kvbug/kv.sober:44:28
quick: wrote examples/guide/kvbug/testdata/fuzz/TestAnyLine/0-6285beb84c4f3dee
panic: quick.Crashed{exit: 101} at std/quick/fuzz.sober:232:10
```

`field` read past the end on `"\\"` (a line of a single `\`). `Format` never ends a line with a lone `\`, so the round trip could not reach this input. The counterexample is shrunk and written to `testdata/fuzz/TestAnyLine/`. From now on a plain `sober test` replays that file before its trials, so if the bug comes back it fails every time:

```sh
$ sober test examples/guide/kvbug --run TestAnyLine
```

Output:

```
quick: panic in the corpus case examples/guide/kvbug/testdata/fuzz/TestAnyLine/0-6285beb84c4f3dee (seed 516221799, 20 shrink runs)
  String = "\\"
panic: index out of range at examples/guide/kvbug/kv.sober:44:28
panic: quick.Crashed{exit: 101} at std/quick/fuzz.sober:232:10
FAIL examples/guide/kvbug.TestAnyLine (exit 101)
0 passed, 1 failed
```

Add `j + 1 < len(b)` to the escape condition in `field` and you have the final state (`kv`). The fixed condition adds its own mutants, and this property kills them all:

```sh
$ sober test examples/guide/kv --mutate
```

Output:

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

## 5. Testing concurrent code — `--sched`

`CountAll` counts the lines in parallel tasks. The property: the parallel counts equal the counts line by line.

```sober
// examples/guide/kv/kv_test.sober (excerpt)
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

`sober fuzz --sched` also varies the task schedule (the order tasks run in) by a seed on each trial. A failure that depends on the order can be replayed with the same interleaving from that seed, any number of times.

```sh
$ sober fuzz examples/guide/kv --run TestCountAll --sched --time 2s
```

Output:

```
quick: fuzz: <n> trials, no failure (check 0, seed 45306338)
```

The number of trials depends on the deadline, so it is written `<n>` here. Sober tasks share no mutable state, so this `CountAll` has no order-dependent failure; the tool earns its keep on code with channels or shared tables. A test that uses tasks also gives the same `sober test` result for any number of workers once `SOBER_SCHED_SEED` is fixed.

## 6. On every save — `sober watch`

`sober watch <entry>` (the main package of a program that uses `kv`) re-checks on every save, and builds and runs the tests in the background, remembering the results. `sober test` on a package that passed returns the remembered result without building or running (a few ms). By the time you type `sober test`, the tests have already run.

Once watch is running you can forget about it. Keep typing `sober check` / `build` / `test` as usual, and they return fast because watch warmed their results. You only need to read watch's output when you suspect something is wrong.

```sh
sober watch app
```

(The output depends on time, so it is not shown here.)

## 7. Reading a double in place of the real package — `@doubles`

Take a package `settings` that uses `kv` to read and write settings. The settings live one line per file, and the package `kvstore` does the file reading and writing.

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

import "examples/guide/kv"
import "examples/guide/kvstore"

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

`settings` imports `kvstore` and calls it directly. There is no interface and nothing is injected through a constructor. The tests of `settings` can still be written without touching the disk: inside the test's build only, `kvstore` is replaced as a whole by a stand-in (a double).

A double lives in a directory under the package it replaces, and its file names end in `_double.sober`. The `@replaces` before the package clause names the package it stands in for, and the package name is the same as that package's.

```sober
// examples/guide/kvstore/mem/mem_double.sober
@replaces("examples/guide/kvstore")
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
const Files = cell.Cell[[]File]{}

func Empty() Dir {
    return Dir{failing: false}
}

func Failing() Dir {
    return Dir{failing: true}
}

@errors(Missing)
func Load(d Dir, name string) (string, error?) {
    fs := cell.Get(Files)
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
    cell.Update(Files, (fs []File) => append(fs, File{name: name, line: line}))
    return nil
}
```

Instead of files, it keeps the written lines in `Files`, a cell from std/testing/cell. A test process has one of each cell, and each test starts with it empty. `Empty` and `Failing` exist only in the double: they are how a test picks the starting state, or injects a failing write.

A test package names the doubles it uses with `@doubles` before the package clause of its `_test.sober`.

```sober
// examples/guide/settings/settings_test.sober
@doubles("examples/guide/kvstore/mem")
package settings

import "examples/guide/kvstore/mem"
import "std/testing/cell"

func TestSetThenValue() {
    d := mem.Empty()
    assert(Set(d, "app", "port", "80") == nil)
    assert(Set(d, "app", "host", "a=b") == nil)
    assert(Set(d, "app", "port", "8080") == nil)
    assert(Value(d, "app", "port", "") == "8080")
    assert(Value(d, "app", "host", "") == "a=b")
    assert(Value(d, "app", "user", "-") == "-")
    files := cell.Get(mem.Files)
    assert(files[len(files) - 1].line == "port=8080;host=a\\=b")
}

func TestMissingFile() {
    assert(Value(mem.Empty(), "app", "port", "8080") == "8080")
}

func TestDenied() {
    assert(Set(mem.Failing(), "app", "port", "80") != nil)
    assert(len(cell.Get(mem.Files)) == 0)
}
```

```sh
$ sober test examples/guide/settings
```

Output:

```
ok   examples/guide/settings.TestSetThenValue
ok   examples/guide/settings.TestMissingFile
ok   examples/guide/settings.TestDenied
3 passed, 0 failed
```

In that test's build, every file that imports `kvstore` reads the double (`settings.sober` too). The production build and check never read `_double.sober`. `--wiring` lists which test runs with which double (it builds the tests but does not run them).

```sh
$ sober test examples/guide/settings --wiring
```

Output:

```
examples/guide/settings: examples/guide/kvstore <= examples/guide/kvstore/mem
```

A double cannot drift away from the real package. For each name both have, the function signatures, the types of struct fields and `@errors` are checked against each other, and the double's effects (derived by the analyzer) must lie within the real package's `@effects`. A double with an effect the real package does not have (a panic, or io where the real package has none) is rejected. Names the real package has and the double lacks can be left out: write only what the tests use.

## 8. The ceremony is not needed

To test `settings` without the disk in other languages, the usual steps are:

1. Pull the operations of `kvstore` out into an interface (`Store`)
2. Write a production implementation and a test implementation (a mock) of it
3. Add a `Store` parameter to the functions or the constructor of `settings`, and pass the production implementation from every caller (sometimes with a DI container)
4. To keep the layering rule ("the domain does not depend on infrastructure"), invert the dependency through the interface

None of these are needed in Sober. The replacement is a change in where an import resolves to, inside the test's build (section 7), and the production code keeps calling the real package directly. No interface, parameter or layer is added for the sake of replacing it.

The contract check (signatures, types, effects) keeps the mock from drifting away from the real package. The direction of the dependencies is all in the import graph, visible statically in a closed world.

What not to do:

- Do not create an interface with a single implementation just for tests (when production needs to swap behaviour, use the function values and structs of [Abstraction](abstraction.md))
- Do not add function parameters just for tests
- Do not use mock libraries or DI containers
- Do not split layers only to make things replaceable

There is no way yet to replace a std package (clocks, the network, files) directly. To replace one, wrap it in a package of your own and replace that package (the shape of `kvstore` in this section).

## Summary

1. Write single cases with `assert`
2. Write properties with std/quick (the counterexample comes out minimal and replays from one seed)
3. Find the branches nothing takes with `--cover`, and the places the tests pass without looking with `--mutate`
4. Fuzz with `sober fuzz`; the counterexamples it finds stay in `testdata/fuzz` as regression tests
5. For code with tasks, vary the schedule too with `--sched`
6. Replace a dependency with a double inside the test's build only, with `@doubles` (no interface, no injection)

At every step the same code and the same seed gave the same result (the counterexample in section 2, the percentages in section 3, the trial where fuzzing found the bug in section 4). That is why a failure replays from one seed, a passing result can be remembered and replayed (section 6), and one run is enough to judge each mutant.

The exact definitions are in [chapter 13 of the language specification](../spec/13-testing.ja.md), and the history of the decisions in sections 35, 39, 40 and 41 of the [decision record](../language.md) (both in Japanese).
