# ログ — print.Log

[English](logs.md) | 日本語

`print.Log` は構造化ログに対応しています。プログラムが何をしたかを、1回の呼び出しにつき1件のレコードとして、JSON Linesの1行で書きます。ログの出力で本体が止まったり死んだりしないことを優先した設計です。読み手が詰まって書き切れないレコードは捨てて、待ちません。捨てた件数は、直後に出る `{"$dropped":{"n":N}}` の行と、`task.Ledger().logs` の `dropped` に残ります。

## レコードを書く

`print.Log(v)` は、structの値 `v` を1件のレコードとしてログへ書きます。レコードの型は `v` の型から推論します。

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

標準出力:

```
200
404
```

標準エラー（ログ）:

```
{"ts":"1994-11-06T08:49:37.000Z","Visit":{"path":"/","status":200,"took":0.25,"tags":["web"],"user":null}}
{"ts":"1994-11-06T08:49:37.000Z","Visit":{"path":"/missing","status":404,"took":0.25,"tags":["web"],"user":null}}
```

- 行の頭は時刻 `ts`（RFC3339のUTC・ミリ秒）で、print.Logを呼んだ時点の時刻です。続くレコードの型の名前のキーが、レコードの分類になります（jqなら `select(.Visit)`）。
- フィールドの型はjson.Encodeと同じ範囲（int・float・bool・string・入れ子のstruct・`[]T`・`T?`）です。floatのNaNと±Infは `null` と書きます。
- 型引数を明示した `print.Log[Visit](v)` も同じ呼び出しです（[examples/print_log_infer.sober](../../examples/print_log_infer.sober)）。書き手はレコードの型ごとに作るので、ジェネリック関数の中で型パラメータの値をprint.Logに渡すことはできません（[examples/print_log_neg_tparam.sober](../../examples/print_log_neg_tparam.sober) は拒否されます）。
- print.Logは結果を返さず、panicしません。だからdomainの本体のような、待ちもioも許さない場所でも書けます。エフェクトは `obs` で、`@effects` の宣言は常に `obs` を許します。外したいときだけ `@effects(!obs)` と書きます。
- 秘密の値（`@secret`）がフィールドに届くレコードは、checkが拒否します。

## ログの行き先

既定はstderrです。main packageのファイルのpackage節の前に `@logs(stdout)` と書くと、stdoutへ出ます。そのプログラムでは、結果を `println` で出すとcheckが拒否します（結果とログが混ざるため）。

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

出力:

```
{"ts":"1994-11-06T08:49:37.000Z","Tick":{"n":0,"ok":true}}
{"ts":"1994-11-06T08:49:37.000Z","Tick":{"n":1,"ok":false}}
{"ts":"1994-11-06T08:49:37.000Z","Tick":{"n":2,"ok":true}}
```

## 書き切れないレコード

レコードはワーカーごとのバッファ（64 KiB）に積んでから、まとめて書きます。読み手が詰まってバッファに入らないレコードと、1件で32 KiBを越えるレコードは、書かずに捨てます。捨てた件数は2か所に残ります。捨てたレコードの並びの直後に出る `{"ts":…,"$dropped":{"n":N}}` の1行（Nが件数）と、`task.Ledger().logs` の `dropped`（プロセスの開始からの合計）です。

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

標準出力:

```
written 2 dropped 1
```

- 1つのワーカーの中のレコードは、呼んだ順に出ます。ワーカーの間の順は約束しません。並べるには `ts` を使います。
- 4,096バイト以下のレコードの行は、パイプの上でも他の行と混ざりません。
- バッファは、正常終了・panicの死（死因の前）・SIGTERMとSIGINTで書き出します。std/taskを使わないプログラムは、次にprint.Logを呼んだときか終了まで書き出さないことがあります。
- 捨てずに全部残す用途（監査の記録など）は、ファイルへ書く別の関数の仕事です。
