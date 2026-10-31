# Install

English | [日本語](install.ja.md)

The Sober compiler is made by starting from stage1, a frozen first compiler written in Zig, and building the source snapshots in `bootstrap/` in order. Everything builds from Zig and source alone. Each [release](https://github.com/sober-lang/sober/releases) also carries a prebuilt static binary for x86-64 Linux (`sober-v<version>-x86_64-linux.tar.gz`), built by the same bootstrap in CI — unpack it and use `sober` directly, no build needed.

## Requirements

- x86-64 Linux (the only platform for now — macOS, Windows and other CPUs will come later)
- [Zig 0.15.2](https://ziglang.org/download/) (used to build stage1 and to turn the `.ll` of the early stages of the chain into machine code)
- git

## Build

```sh
git clone <this repository> sober
cd sober
(cd src/stage1 && zig build)   # stage1 — src/stage1/zig-out/bin/sober
scripts/stage2.sh              # build the 25 stages of bootstrap/ in order; the last stage builds the current compiler (stage2)
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

`sober --help` lists the commands and flags, and `sober <command> --help` shows the flags of one command. A usage error (an unknown flag, a bad value) exits with 2.

`sober build` caches intermediate results in `~/.cache/sober` (or under `SOBER_CACHE` / `XDG_CACHE_HOME` when set), and later builds redo only what changed. The output executable is the same with or without the cache. Set `SOBER_BUILD_CACHE=0` to turn it off; `sober cache info` / `sober cache gc` list and clean the cache.

## Running servers

Programs that use std/net (and so std/http and std/tls) need three things from the environment:

- io_uring: Docker's default seccomp profile (and gVisor) block io_uring. Sober then falls back to epoll automatically — it works, but slower. For full speed, run with a seccomp profile that allows `io_uring_setup` / `io_uring_enter` / `io_uring_register` (for example `docker run --security-opt seccomp=unconfined …`). The network path on io_uring needs Linux 6.1 or later
- memlock: each worker owns an io_uring ring, and older kernels charge ring memory to `RLIMIT_MEMLOCK` for the whole user. When ring setup fails with ENOMEM, Sober falls back as above (slower); raise the limit (`ulimit -l unlimited`, `LimitMEMLOCK=infinity` under systemd, `--ulimit memlock=-1` under Docker). From Linux 5.12 the memory is charged to the cgroup instead and this rarely matters
- nofile: one connection is one file descriptor. systemd and many shells default to a soft limit of 1024 — raise it to at least the number of connections you expect (`ulimit -n`, `LimitNOFILE=`, `--ulimit nofile=…`)

Run as a container's init (PID 1), a Sober program still stops on SIGTERM / SIGINT (exit codes 143 / 130) — no tini or `--init` is needed. The stop is immediate and in-flight connections are cut (there is no graceful drain yet).

## For developers: running the verification net

When you work on the compiler itself, `scripts/gates.sh --full` runs every check. A check whose inputs are the same as when it last passed reuses that record (`--no-cache` runs everything). The net additionally needs:
[Lean 4](https://lean-lang.org/) (the version in `lean/lean-toolchain` — `cd lean && lake build`), Go (independent oracles and the benchmark twins), Rust (the benchmark twins), Node.js (some tools), `perf` (benchmarks), and GNU as (checking the instruction encoder).

Next: [Your first program](first-program.md)
