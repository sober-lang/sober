# std/testing

日本語

`import "std/testing"`

テストの語彙の裏方: `_test.sober` の `assert(e)` は loader の固定テンプレート（compiler/loader/assert.sober）が「部分式を束縛 → 偽なら Fail」に写す。利用者は assert を書く（ここの関数を直接呼ばない）。値の印字は総称関数 Show[T] でなくテンプレートが組む補間 `"<式> = ${値}"`（int / bool / string — 補間の型の分岐をそのまま使う）。総称関数で書けないのは、T = string の Def が region を持つ型引数で拒否されるため — それが言語に入ったら Show[T] へ移す

## AssertFailed

```sober
type AssertFailed panic
```

assert の失敗（panic ラベル — 欄なし: 式と部分式の値は Fail が前置で印字する。[language.md 27 節](../language.md)）

## Fail

```sober
@effects(io, panic, nondet)
func Fail(expr string, values []string)
```

assert の失敗: `assert failed: <式>` と部分式の値を 1 行ずつ標準エラーへ書いて panic(AssertFailed{}) する（exit 101 — [language.md 27 節](../language.md)の panic の契約）
