# Logs — print.Log

English | [日本語](logs.ja.md)

`print.Log` does structured logging: each call writes one record of what the program did, as one JSON Lines line. The design puts one thing first: writing logs never stops or kills the program. When the reader falls behind, records that cannot be written are thrown away instead of waited for. The number thrown away appears in the `{"$dropped":{"n":N}}` line right after them and in `dropped` of `task.Ledger().logs`.

## Writing a record

`print.Log(v)` writes the struct value `v` to the log as one record. The record type is the type of `v`.

```sober
// examples/print_log.sober
package main

// print.Log writes a record (a struct) as one JSON Lines line to the log (standard error unless @logs says otherwise).
// It returns nothing, never waits and never panics. The line is {"ts":"<time>","<type name>":<fields>}; the record type is the type of the argument

import "std/print"

type Visit struct {
    path string
    status int
    took float
    tags []string
    user string?
}

func handle(path string) int {
    status := if path == "/" { 200 } else { 404 }
    print.Log(Visit{path: path, status: status, took: 0.25, tags: []string{"web"}, user: nil})
    return status
}

func main() {
    println(handle("/"))
    println(handle("/missing"))
}
```

Standard output:

```
200
404
```

Standard error (the log):

```
{"ts":"1994-11-06T08:49:37.000Z","Visit":{"path":"/","status":200,"took":0.25,"tags":["web"],"user":null}}
{"ts":"1994-11-06T08:49:37.000Z","Visit":{"path":"/missing","status":404,"took":0.25,"tags":["web"],"user":null}}
```

- Each line starts with `ts` (RFC 3339, UTC, milliseconds), the time print.Log was called. The key that follows is the record type's name, which classifies the record (`select(.Visit)` in jq).
- Field types are those of json.Encode (int, float, bool, string, nested structs, `[]T`, `T?`). A float NaN or ±Inf is written as `null`.
- Writing the type argument, `print.Log[Visit](v)`, is the same call ([examples/print_log_infer.sober](../../examples/print_log_infer.sober)). The writer is generated per record type, so a generic function cannot pass a value of its type parameter to print.Log ([examples/print_log_neg_tparam.sober](../../examples/print_log_neg_tparam.sober) is rejected).
- print.Log returns nothing and never panics, so it can be called even where waiting and io are not allowed, such as the body of a domain call. Its effect is `obs`; an `@effects` declaration always allows `obs` unless it says `@effects(!obs)`.
- A record whose field holds a `@secret` value is rejected by check.

## Where the log goes

Standard error by default. `@logs(stdout)` before the package clause of a main package file sends it to standard output. Such a program must not print results with `println` (check rejects it), because results and log lines would mix.

```sober
// examples/logs_stdout.sober
@logs(stdout)
package main

// @logs(stdout), written once before the package clause of the main package, sends the log to standard output.
// The log must not mix with printed results, so this program does not use println

import "std/print"

type Tick struct {
    n int
    ok bool
}

func main() {
    mut i := 0
    while i < 3 {
        print.Log(Tick{n: i, ok: i % 2 == 0})
        i += 1
    }
}
```

Output:

```
{"ts":"1994-11-06T08:49:37.000Z","Tick":{"n":0,"ok":true}}
{"ts":"1994-11-06T08:49:37.000Z","Tick":{"n":1,"ok":false}}
{"ts":"1994-11-06T08:49:37.000Z","Tick":{"n":2,"ok":true}}
```

## Records that cannot be written

Records go into a per-worker buffer (64 KiB) and are written out in batches. A record that does not fit in the buffer because the reader is behind, and a single record over 32 KiB, are thrown away without being written. The number thrown away appears in two places: the `{"ts":…,"$dropped":{"n":N}}` line right after the records thrown away (N is the number), and `dropped` of `task.Ledger().logs` (the total since the process started).

```sober
// examples/print_log_drop.sober
package main

// print.Log never waits for the reader. A record it cannot write (here: one over the 32 KiB limit) is thrown away. The number thrown away
// appears in the {"ts":…,"$dropped":{"n":N}} line right after them and in dropped of task.Ledger().logs (written + dropped = calls)

import "std/os"
import "std/print"
import "std/task"

type Note struct {
    text string
}

func big(n int) string {
    mut s := "x"
    while len(bytes(s)) < n {
        s = s + s
    }
    return s
}

func main() {
    print.Log(Note{text: "before"})
    print.Log(Note{text: big(40000)})
    print.Log(Note{text: "after"})
    // let the buffer drain (a worker writes its buffer out before it sleeps)
    os.Sleep(20)
    l := task.Ledger().logs
    println("written ${l.written} dropped ${l.dropped}")
}
```

Standard output:

```
written 2 dropped 1
```

- Records from one worker come out in call order. There is no order between workers; sort by `ts`.
- A line of a record up to 4,096 bytes never mixes with other lines, even on a pipe.
- The buffers are written out at normal exit, at a panic (before the panic message) and on SIGTERM and SIGINT. A program that does not use std/task may hold a record until its next print.Log call or its exit.
- Keeping every record (an audit trail, say) is the job of a separate function that writes to a file.
