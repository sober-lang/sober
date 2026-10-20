# 13. テスト

日本語

[目次](README.ja.md)

`sober test` は package の `*_test.sober` の `func TestXxx()` を見つけて、1 テストずつ別のプロセスで走らせる。失敗は 0 以外の終了コード（panic なら 101）。通常のビルドは `*_test.sober` を読まない。

S-1. `assert(e)` は `*_test.sober` だけの語彙で、他のファイルに書くと拒否する。偽なら `assert failed: <式>` と部分式・式の中の名前の値を標準エラーへ書いて panic する。
拒否: [`examples/assert_outside.sober`](../../examples/assert_outside.sober)
決定: [language.md 35 節](../language.md)
