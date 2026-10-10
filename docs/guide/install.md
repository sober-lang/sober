# Install

English | [日本語](install.ja.md)

The Sober compiler is made by starting from stage1, a frozen first compiler written in Zig, and building the source snapshots in `bootstrap/` in order. There are no distributed binaries — everything builds from Zig and source alone.

## Requirements

- x86-64 Linux (the only platform for now — macOS, Windows and other CPUs will come later)
- [Zig 0.15.2](https://ziglang.org/download/) (used to build stage1 and to turn the `.ll` of the early stages of the chain into machine code)
- git

## Build

```sh
git clone <this repository> sober
cd sober
(cd src/stage1 && zig build)   # stage1 — src/stage1/zig-out/bin/sober
scripts/stage2.sh              # build the 22 stages of bootstrap/ in order; the last stage builds the current compiler (stage2)
```

The first run of `scripts/stage2.sh` takes a few minutes (the result of each stage is cached in `out/stage2/`, and later runs rebuild only when the sources change).

## Use

`bin/sober` is the entry point (it rebuilds stage2 automatically when it is stale). Putting it on your PATH is convenient.

```sh
export PATH="$PWD/bin:$PATH"
sober build examples/hello.sober -o hello
./hello
```

```
Hello, Sober!
```

Main commands:

| Command | What it does |
|---|---|
| `sober build <file.sober> -o <out>` | Produce an executable (a static ELF) |
| `sober check <file.sober>` | Run only type checking and the analyzer (no executable) |
| `sober test <package>` | Run the tests in the package's `*_test.sober` files |

## For developers: running the verification net

When you work on the compiler itself, `scripts/gates.sh --full` runs every check (53 of them). The net additionally needs:
[Lean 4](https://lean-lang.org/) (the version in `lean/lean-toolchain` — `cd lean && lake build`), Go (independent oracles and the benchmark twins), Rust (the benchmark twins), Node.js (some tools), `perf` (benchmarks), and GNU as (checking the instruction encoder).

Next: [Your first program](first-program.md)
