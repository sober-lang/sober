# Writing tests

English | [日本語](testing.ja.md)

This page takes a small package, `kv`, and adds tests to it in six steps. Each step is "write → run → read the output". Every output shown here is real: the repository's checks (guidetest in `scripts/gates.sh`) runs the same commands every time and checks them.

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
panic: testing.AssertFailed{} at std/testing/testing.sober:25:10
FAIL examples/guide/kvbug.TestParse (exit 101)
0 passed, 1 failed
```

An `assert` per condition, rather than conditions joined with `&&`, tells you with values where it failed.

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
panic: testing.AssertFailed{} at std/testing/testing.sober:25:10
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

```sh
sober watch app
```

(The output depends on time, so it is not shown here.)

## Summary

1. Write single cases with `assert`
2. Write properties with std/quick (the counterexample comes out minimal and replays from one seed)
3. Find the branches nothing takes with `--cover`, and the places the tests pass without looking with `--mutate`
4. Fuzz with `sober fuzz`; the counterexamples it finds stay in `testdata/fuzz` as regression tests
5. For code with tasks, vary the schedule too with `--sched`

At every step the same code and the same seed gave the same result (the counterexample in section 2, the percentages in section 3, the trial where fuzzing found the bug in section 4). That is why a failure replays from one seed, a passing result can be remembered and replayed (section 6), and one run is enough to judge each mutant.

The exact definitions are in [chapter 13 of the language specification](../spec/13-testing.ja.md), and the history of the decisions in sections 35, 39 and 40 of the [decision record](../language.md) (both in Japanese).
