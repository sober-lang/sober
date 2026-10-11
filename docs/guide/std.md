# Standard library guide

English | [日本語](std.ja.md)

A map of the packages you use with `import "std/<name>"`. For the exact form of each function, the public declarations (names starting with an upper-case letter) in the source (`src/std/<name>/`) are authoritative.

## I/O and environment

| Package | Purpose | Main items |
|---|---|---|
| `std/io` | Files, standard I/O, directories | `ReadFile`, `WriteFile`, `ReadStdin`, `WriteStdout`, `WriteStderr`, `ReadDir`, the buffered `Writer` (`WriteString` / `WriteByte` / `Flush`). Error labels are `NotFound`, `Denied`, `Other` |
| `std/os` | Processes and the environment | `Args`, `Getenv`, `Run` (child processes), `Mkdir`, `Rename`, `ModTime`, `WriteMode`, `Sleep` |

## Text

| Package | Purpose | Main items |
|---|---|---|
| `std/utf8` | UTF-8 validation and substrings | `Check` (validate the whole input once and get a `View`), `Str` (take a substring from a validated view without copying), `Parse`, `Valid`, `IndexInvalid` |
| `std/strings` | String operations | `Contains`, `HasPrefix`, `HasSuffix`, `Index`, `IndexByte`, `Count`, `Cut`, `CutLast`, `TrimPrefix`, `Join`, `FormatInt`, `Clone` (the pieces `Cut` and friends return are not re-validated — a position that matches a separator is always a character boundary) |
| `std/builder` | Building sequences | push onto a `Builder[T]` with `Push`, `PushAll`, `PushStr`, and take the result with `Build` |
| `std/conv` | Converting between numbers and strings | `ParseFloat`, `FormatFloat`, `FormatFixed` |
| `std/hex` | Hexadecimal | `Encode` |

`string` is immutable text, and `bytes(s)` views it as a byte sequence (`[]byte`). String interpolation is `"x = ${x}"`.

## Data structures

| Package | Purpose | Main items |
|---|---|---|
| `std/iter` | The lazy sequence `Iter[T]` | `Range`, `Slice`, `Each`, `Count`, `Sum` (consume the result of `for … yield` through a pipe) |
| `std/table` | Large tables (a sequence of fixed-size chunks — growing never copies) | `Push`, `Get`, `Set`, `Len` on a `Table[T]`, and `Freeze` into an immutable `Frozen[T]` |
| `std/pool` | A lending pool looked up by handle | `Acquire`, `Release`, `Get`, `Set` |
| `std/json` | Reading and writing JSON | `Parse` gives a document `Doc`, read with `Get` / `Items` / `Dec*` and write with `Put*`; mapping to and from types is `json.Decode[T]` / `json.Encode[T]` |

Slices (`[]T`) and maps (`map[K]V`) are built into the language (`append`, `len`, `freeze`, `clone` [a shallow copy, returned as mut], and a lookup `m[k]` is `T?`).

## Parallelism

| Package | Purpose | Main items |
|---|---|---|
| `std/par` | Structured concurrency | `Map`, `Scope` + `Spawn` + `Join` / `Gather` / `Try`, channels `NewChan` / `Send` / `Recv` / `Close`, `Pool` (`NewPool` / `SpawnIn`) |

Only immutable values and channels can be passed to a child task. The output is the same regardless of the number of workers ([language tour, section 7](tour.md#7-parallelism--structured-concurrency-channels)).

## Numbers and randomness

| Package | Purpose | Main items |
|---|---|---|
| `std/math` | Floating-point basics | `Sqrt`, `Abs`, `Bits` / `FromBits` |
| `std/rand` | Deterministic pseudo-random numbers | `New` (from a seed), `Intn`, `Int62`, `Bool`, `Split` (split per parallel task) |
| `std/hash` | Hashing | `Sha256` |

## Other

| Package | Purpose |
|---|---|
| `std/testing` | Test helpers (labels for `assert` failures) |
| `std/layout` | Helpers for declaring binary layouts (`@layout`) |
| `std/floatfmt` | Internals of floating-point formatting (used by `std/conv`) |

Floating point (`float` formatting, math functions) is still being filled in as of v0.5.0.
