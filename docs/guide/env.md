# Environment variables

English | [日本語](env.ja.md)

Environment variables come in three layers. This page lists the second and the third: **the variables a Sober program reads at run time**.

1. **Read by the compiler (`sober`)** — such as `SOBER_BUILD_CACHE`. They are in `sober --help` (the development ones in `sober --help=dev`) and in [the CLI document](../cli/sober.md)
2. **Read by the runtime of a generated executable** — every program written in Sober reads them (the compiler too, being a Sober program). The table below
3. **Read by the standard library** — the table below

Declare the variables your own program reads in a [std/env](../std/env.ja.md) table: the checks on reading (required, ranges, bool spellings) and the listing (`env.Spec`) come from that table. See [examples/env_table.sober](../../examples/env_table.sober).

## Read by the runtime

| Variable | Meaning |
| --- | --- |
| `SOBER_WORKERS` | the number of workers (default the number of cores). Standard output stays byte-for-byte the same when it changes |
| `SOBER_PIN` | pin the workers to CPUs (1 forces, 0 turns off; by default only for Serve-shaped programs with enough allowed CPUs) |
| `SOBER_REGION_MB` | the size limit of the main region (MiB, default 4096) |
| `SOBER_TASK_REGION_MB` | the size limit of a task's region (MiB — never above main's) |
| `SOBER_MADV_MB` | when returning the pages of a dropped region to the OS, the amount kept touched from the start (MiB, 0 = return all) |
| `SOBER_COVER` | the file a coverage-instrumented executable (`sober build --cover`) writes its marks to when it ends (nothing is written without it) |
| `SOBER_BUDGET_MB` | fix the memory ceiling (for tests — by default from the cgroup's memory.max and the installed memory) |
| `SOBER_HASH_SEED` | the hash seed of maps (decimal — for reproduction) |
| `SOBER_IO` | choose the io path (1 / 2 read synchronously without io_uring — for comparison) |
| `SOBER_NET` | 1 fixes the network to the epoll path (for comparison) |
| `SOBER_IO_TRACE` | 1 prints each worker's io_uring check to standard error |
| `SOBER_FLIGHT` | the path of the flight record (rt events are recorded only when set) |
| `SOBER_FLIGHT_EV` | the size of the flight record ring (log2, 8–24, default 16) |
| `SOBER_SCHED` | how a single worker orders the tasks (for tests) |
| `SOBER_SCHED_SEED` | the seed of the delays injected into the scheduler (for tests) |
| `SOBER_SCHED_TRACE` | 1 prints the scheduler events to standard error |
| `SOBER_CHAOS_SEED` | the seed of the failures injected into network sends, receives and accepts (for tests, 0 = none) |
| `SOBER_PAR_STATS` | 1 counts the usage of each task and prints it to standard error |
| `SOBER_DEPTH_REPORT` | when true, print the region depth measurement to standard error at main's normal exit |
| `SOBER_NOAES` / `SOBER_NOCLMUL` / `SOBER_NOMULX` | 1 falls back from the CPU's AES-NI / PCLMULQDQ / MULX (for comparison) |

## Read by the standard library

| Variable | Package | Meaning |
| --- | --- | --- |
| `SOBER_NOAES` | std/crypto/aesgcm | the same as the runtime's (no AES-NI) |
| `SOBER_DUDECT` | std/internal/dudect | the number of constant-time statistical measurements (none when unset — for tests) |
| `SOBER_QUICK_SEED` | std/quick | the seed of property-based tests (decimal — New / Named mix it in; 0 when unset. Change it to widen the search) |
| `SOBER_QUICK_TRIALS` | std/quick | the number of trials per Check (1 or more — falls back to Check's trials:, default 100) |
| `SOBER_TLS_TRACE_LIVE` | std/tls tests | the case name when retaking the TLS golden traces (for tests) |
