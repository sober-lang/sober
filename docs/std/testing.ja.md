# std/testing

日本語

`import "std/testing"`

テストの語彙の裏方: `_test.sober` の `assert(e)` は loader の固定テンプレート（compiler/loader/assert.sober）が「部分式を束縛 → 偽ならReportしてassertの位置でpanic」に変換する。利用者はassertを書く（ここの関数を直接呼ばない）。値の印字は総称関数 Show[T] でなくテンプレートが組む補間 `"<式> = ${値}"`（int / bool / string — 補間の型の分岐をそのまま使う）。総称関数で書けないのは、T = string の Def が region を持つ型引数で拒否されるため — それが言語に入ったら Show[T] へ移す

## AssertFailed

```sober
type AssertFailed panic
```

assertの失敗（panicラベル — フィールドなし: 式と部分式の値はReportが前置で印字する。[language.md 27 節](../language.md)）

## Report

```sober
@effects(io, nondet)
func Report(expr string, label string, values []string)
```

assert の失敗の印字: `assert failed: <式>`（ラベルがあれば `assert failed (<ラベル>): <式>`）と部分式の値を 1 行ずつ標準エラーへ書く。panic(AssertFailed{}) はテンプレートが assert を書いた位置に置く（panic の位置 = 利用者の assert の行 — exit 101・[language.md 27 節](../language.md)）
