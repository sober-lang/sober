# std/print

日本語

`import "std/print"`

結果・デバッグ出力・ログのAPI（[language.md 42 節](../language.md)）。今はログのLogだけ。

## Log

```sober
func Log[T](rec T) @effects(obs)
```

recを1行のJSON Lines（`{"ts":"<時刻>","<Tの型の名前>":<recのフィールド>}`）にして、ログの行き先（`@logs`・既定は標準エラー）へ書く。結果は無く、待たず、panicしない。書き出せないレコードは捨てる。捨てた件数は直後の `$dropped` の行と task.Ledger().logs の dropped に残る。Tはrecの型から推論する（print.Log(rec)。明示のprint.Log[T](rec)も同じ）。書き手を型ごとに合成するので、ジェネリック関数の中で型パラメータの値は渡せない。Tはstructで、フィールドの範囲はjson.Encodeと同じ（json.Valueを除く）。floatのNaNと±Infはnull。floatのフィールドは、値に依らない定数の大きさの作業域を使う

例:

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
