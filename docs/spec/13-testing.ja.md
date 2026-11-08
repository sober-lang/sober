# 13. テスト

日本語

[目次](README.ja.md)

`sober test` は package の `*_test.sober` の `func TestXxx()` を見つけて、1 テストずつ別のプロセスで走らせる。失敗は 0 以外の終了コード（panic なら 101）。通常のビルドは `*_test.sober` を読まない。

S-1. `assert(e)` と `assert(e, label)` は `*_test.sober` だけの語彙で、他のファイルに書くと拒否する。偽なら `assert failed: <式>`（ラベルがあれば `assert failed (<label>): <式>`）と部分式・式の中の名前の値を標準エラーへ書いて、その `assert` の位置で panic する。label は string で、偽のときだけ評価する。
例: testdata/sobertest/asserts（ラベル・位置）
拒否: [`examples/assert_outside.sober`](../../examples/assert_outside.sober)
決定: [language.md 35 節](../language.md)

S-2. std/quick を import する `*_test.sober` では、`quick.Check(mut q, () => …)` のプロパティのラムダ（仮引数なし）の最後の式が偽のとき、シュリンク（縮小）した反例の再生でだけ `assert` と同じ形（`assert failed: <式>` と部分式の値）で印字して落ちる。プロパティのラムダの中の `assert` は拒否する。`quick.New()` のシードは囲む関数の名前で決まる。
例: [`examples/quick_shrink.sober`](../../examples/quick_shrink.sober)（プロパティの形 — 写しが掛かるのは `*_test.sober`: testdata/sobertest/props）
拒否: testdata/sobertest/propsbad（プロパティの中の assert）
決定: [language.md 35 節](../language.md)

S-3. `sober fuzz <package> --run TestXxx` は、そのテストの `quick.Check` を期限（`--time` — Check 1 つあたり）まで回し続ける。プロパティの偽・プロパティの中の panic・期限（`--hang`）を超えた試行を見つけたら、シュリンクした反例を報告し、選択の列を `<package>/testdata/fuzz/<TestXxx>/<Check の番号>-<16 桁>` に書いて終了コード 1 で止まる。見つからなければ 0。`--sched` は試行ごとに std/task のスケジュール（SOBER_SCHED_SEED）も振り、見つけた列のファイルに `sched <シード>` の行を持たせる。既定でカバレッジに誘導される（新しい分岐を開いた試行の選択の列をミューテーションして次の試行に使う — シードはキャッシュに置き、コーパスには書かない）。`--no-guide` は誘導しない。
例: [`examples/quick_fuzz.sober`](../../examples/quick_fuzz.sober)（駆動役の仕組み — 稀な panic を見つけてシュリンクする）・testdata/quickfuzz（ハング・偽・スケジュール・誘導）・testdata/sobertest/propsfuzz
決定: [language.md 35 節](../language.md)

S-4. `sober test` は、各 `quick.Check` の試行の前に `<package>/testdata/fuzz/<TestXxx>/` の、その Check の番号の列を名前の順に再生する。偽になる列があれば試行を回さずにシュリンクして報告する。プロパティの中で panic して死んだテストは、同じ Check を走らせ直してシュリンクした反例の報告に置き換える。`sober test` はコーパスに書かない。
例: [`examples/quick_shrink.sober`](../../examples/quick_shrink.sober)（シュリンクの形）・testdata/sobertest/propsfuzz（手書きのコーパスの列・panic のシュリンクし直し — `*_test.sober` の掛け戻し）
決定: [language.md 35 節](../language.md)

S-5. `sober test --cover` は、テストした package の非テストのファイルの分岐（関数の本体・if の両側・switch の各腕・ループの本体・`&&` / `||` の右辺・catch の腕 — 出力では分岐を arm と呼ぶ）を、どれかのテストが踏んだかで数え、結果の行の下に `cover: <package> <割合>% of <分岐の数> arms (fn <呼ばれた関数>/<関数>)` と未到達の分岐を位置の順に 20 本まで印字する。どのテストも呼ばない関数も数える。`--cover-pkg=<p,q/...>` は数える package を替え（`q/...` は q とその下）、std は数えない。task を使わないテストの結果はワーカー数に依らない。
例: [`examples/cover_basic.sober`](../../examples/cover_basic.sober)（点の種類の全部 — `sober build --cover`）・testdata/cover/shapes（テストごとに別の腕・101 / 102 で死ぬテスト）
決定: [language.md 39 節](../language.md)

S-6. `--cover-out=<file>` は数えた点を全部書く。`<file>` が `.lcov` で終われば LCOV、他は 1 行 1 点の `<path>:<行>:<列> <種類> <0|1>`（位置の順）。計器つきの実行ファイル（`sober build --cover`）は、環境変数 SOBER_COVER のファイルへ見出し `sober cover v1 <鍵>` と点の数のバイト列を、main の戻り・panic・region の超過・Deadlock のどれで終わっても書く。計器なしのビルドは点を持たず、std/quick を使わないプログラムの出力は変わらない。
例: [`examples/cover_basic.sober`](../../examples/cover_basic.sober)
決定: [language.md 39 節](../language.md)

S-7. `sober test --mutate` は、テストした package の非テストのファイルのミュータント（比較の境界と否定・算術とビットの演算子の入れ替え・`&&` ↔ `||`・`!` の除去・if の条件を真 / 偽に固定〔while は偽〕・呼び出しの式文と代入文の削除）を全部 1 本のテストのビルドに入れ、ミュータントを選ばずに全部のテストが通ったときだけ、ミュータントごとにそのミュータントに届いたテストを名前の順に走らせ、どれかが 0 以外で終われば kill と数える。どのテストも届かないミュータントは走らせずに未到達。結果の行の下に `mutate: <package> <割合>% killed (<kill> of <到達> reached) · <未到達> unreached` と生き残ったミュータントを位置の順に 20 本まで印字する。`--mutate-out=<file>` は 1 行 1 ミュータント `<path>:<行>:<列>\t<ミュータント>\t<結果>\t<殺したテスト>` を書く。`<package>/testdata/mutate.ignore` の行（`--mutate-out` の行の頭 2 欄）に当たるミュータントは走らせず `ignored` と数え（割合の分母に入れない）、当たらない行は警告する。`--cover` と同時には指定できない。
例: [`examples/mutate_basic.sober`](../../examples/mutate_basic.sober)（ミュータントの種類の全部 — `sober build --mutate` の基線は写しの無い build と同じ出力）・testdata/mutate/calc（未到達・生き残るミュータント・ハングするミュータント）
決定: [language.md 40 節](../language.md)

## 13.1 テストの構成の差し替え

S-8. テストの package の `*_test.sober` の package 節の前の `@doubles("パス", …)`（文字列のリテラル 1 つ以上・package ごとに高々 1 つ）が名指したディレクトリ（double — ファイルは全部 `*_double.sober` で、各ファイルは package 節の前に同じ `@replaces("相手")` を持ち、package 名は相手の名前）を、そのテストのビルドの中で相手の package として読む。相手を import する全部のファイルが double を読む。double のパスの import はそのビルドでは相手の別名で、`*_test.sober` と `*_double.sober` だけが書ける。double にだけある名前は double のパス経由でだけ参照できる。本番のビルドは `*_double.sober` を読まない。
double の公開の名前のうち相手にもあるものは契約を満たす: 種類が同じ・関数の署名（型パラメータの数・仮引数の mut と型・結果）が同じ・const の値の式が同じ・struct / error / panic の型は両方にある欄の型が同じ（欄の増減は自由）・union と名前付き関数型は形ごと同じ・関数の `@errors` は double ⊆ 相手。相手の関数には `@effects`（error を返すなら `@errors` も）が要る。double の関数の効果の導出は相手の `@effects` の内側になければならない（double が自分の `@effects` を書くならその宣言も相手の内側）— 効果の照合は check の analyzer の段（`sober check <package> --test`・`sober check <double のディレクトリ>` — 後者は double を相手として読んで契約だけを検査する）。
`sober test <package>… --wiring` はテストを走らせず、double ごとに `<テストの package>: <相手> <= <double のディレクトリ>` を 1 行印字する。`--cover`（`--cover-pkg` を含む）と `--mutate` は `*_double.sober` に計器と変異を打たない。double の中の panic の位置は double のファイルのパスで印字する。
例: testdata/doubles/handler（決め打ちの応答と誤りの注入の double で走るテスト）・testdata/doubles/app（本番の読み）・testdata/doubles/crashed（double の中の panic の位置）
拒否: [`examples/doubles_neg_replaces.sober`](../../examples/doubles_neg_replaces.sober)（double の外の @replaces）・[`examples/doubles_neg_import.sober`](../../examples/doubles_neg_import.sober)（本番の読みから double を import）・testdata/doubles/neg（置き場・名乗り・表・import・契約の各項・効果の漏れ）
決定: [language.md 41 節](../language.md)

## 13.2 状態を貯める fake

S-9. `std/testing/cell` は `*_test.sober` と `*_double.sober`（と std）だけが import できる。把手 `testing.cell.Cell[T]` はトップレベルの const の宣言の右辺のリテラル `testing.cell.Cell[T]{…}`（欄は `init:` だけ — 省けば T のゼロ値）だけが作り、置き場は宣言ごとに 1 つ。`testing.cell.Get(h) T` は置き場の値（一度も書いていなければ init）を呼び手の最内の region へ写して返し、`testing.cell.Set(h, v)` は v を置き場へ写して置き、`testing.cell.Update(h, f)` は読み → f → 書きを他の書きと重ならずに行う。f はラムダのリテラル（仮引数 1 つ）で効果を持たない。T は関数値・mut の部分・同一性の値を持たない（再帰型は置ける — ゼロ値の無い T〔union〕は `init:` が要る）。Set / Update の効果は `io`、Get は `io, nondet`。置き場の寿命はプロセスで、std/quick の試行（縮め・再生を含む）の頭で全部が空になる。
例: testdata/doubles/greet（spy の double で走るテスト）・testdata/cells（読み書き・並行の Update・quick の試行ごとの空・再帰の union の値）
拒否: [`examples/cell_neg_import.sober`](../../examples/cell_neg_import.sober)（テストの構成の外の import）・testdata/doubles/neg/c01〜c04（import の置き場・const の外のリテラル・`key:`・ラムダでない f）・cfx（f の効果）・cty（置けない T）・cset / cupd（値の型）
決定: [language.md 41 節](../language.md)
