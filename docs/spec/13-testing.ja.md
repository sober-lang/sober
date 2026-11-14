# 13. テスト

日本語

[目次](README.ja.md)

`sober test` はpackageの `*_test.sober` の `func TestXxx()` を見つけて、1テストずつ別のプロセスで走らせる。失敗は0以外の終了コード（panicなら101）。通常のビルドは `*_test.sober` を読まない。

S-1. `assert(e)` と `assert(e, label)` は `*_test.sober` だけの語彙で、他のファイルに書くと拒否する。偽なら `assert failed: <式>`（ラベルがあれば `assert failed (<label>): <式>`）と部分式・式の中の名前の値を標準エラーへ書いて、その `assert` の位置でpanicする。labelはstringで、偽のときだけ評価する。
例: testdata/sobertest/asserts（ラベル・位置）
拒否: [`examples/assert_outside.sober`](../../examples/assert_outside.sober)
決定: [language.md 35節](../language.md)

S-2. std/quickをimportする `*_test.sober` では、`quick.Check(mut q, () => …)` のプロパティのラムダ（仮引数なし）の最後の式が偽のとき、シュリンク（縮小）した反例の再生でだけ `assert` と同じ形（`assert failed: <式>` と部分式の値）で印字して落ちる。プロパティのラムダの中の `assert` は拒否する。`quick.New()` のシードは囲む関数の名前で決まる。
例: [`examples/quick_shrink.sober`](../../examples/quick_shrink.sober)（プロパティの形 — ASTの書き換えが適用されるのは `*_test.sober`: testdata/sobertest/props）
拒否: testdata/sobertest/propsbad（プロパティの中のassert）
決定: [language.md 35節](../language.md)

S-3. `sober fuzz <package> --run TestXxx` は、そのテストの `quick.Check` を期限（`--time` — Check 1つあたり）まで回し続ける。プロパティの偽・プロパティの中のpanic・期限（`--hang`）を超えた試行を見つけたら、シュリンクした反例を報告し、選択の列を `<package>/testdata/fuzz/<TestXxx>/<Check の番号>-<16 桁>` に書いて終了コード1で止まる。見つからなければ0。`--sched` は試行ごとにstd/taskのスケジュール（SOBER_SCHED_SEED）も振り、見つけた列のファイルに `sched <シード>` の行を持たせる。既定でカバレッジに誘導される（新しい分岐を開いた試行の選択の列をミューテーションして次の試行に使う — シードはキャッシュに置き、コーパスには書かない）。`--no-guide` は誘導しない。
例: [`examples/quick_fuzz.sober`](../../examples/quick_fuzz.sober)（駆動役の仕組み — 稀なpanicを見つけてシュリンクする）・testdata/quickfuzz（ハング・偽・スケジュール・誘導）・testdata/sobertest/propsfuzz
決定: [language.md 35節](../language.md)

S-4. `sober test` は、各 `quick.Check` の試行の前に `<package>/testdata/fuzz/<TestXxx>/` の、そのCheckの番号の列を名前の順に再生する。偽になる列があれば試行を回さずにシュリンクして報告する。プロパティの中でpanicして死んだテストは、同じCheckを走らせ直してシュリンクした反例の報告に置き換える。`sober test` はコーパスに書かない。
例: [`examples/quick_shrink.sober`](../../examples/quick_shrink.sober)（シュリンクの形）・testdata/sobertest/propsfuzz（手書きのコーパスの列・panicのシュリンクし直し — `*_test.sober` の掛け戻し）
決定: [language.md 35節](../language.md)

S-5. `sober test --cover` は、テストしたpackageの非テストのファイルの分岐（関数の本体・ifの両側・switchの各分岐・ループの本体・`&&` / `||` の右辺・catchの分岐 — 出力では分岐をarmと呼ぶ）を、どれかのテストが実行したかで数え、結果の行の下に `cover: <package> <割合>% of <分岐の数> arms (fn <呼ばれた関数>/<関数>)` と未到達の分岐を位置の順に20本まで印字する。どのテストも呼ばない関数も数える。`--cover-pkg=<p,q/...>` は数えるpackageを替え（`q/...` はqとその下）、stdは数えない。taskを使わないテストの結果はワーカー数に依らない。
例: [`examples/cover_basic.sober`](../../examples/cover_basic.sober)（点の種類の全部 — `sober build --cover`）・testdata/cover/shapes（テストごとに別の分岐・101 / 102で死ぬテスト）
決定: [language.md 39節](../language.md)

S-6. `--cover-out=<file>` は数えた点を全部書く。`<file>` が `.lcov` で終わればLCOV、他は1行1点の `<path>:<行>:<列> <種類> <0|1>`（位置の順）。計装つきの実行ファイル（`sober build --cover`）は、環境変数SOBER_COVERのファイルへ見出し `sober cover v1 <鍵>` と点の数のバイト列を、mainの戻り・panic・regionの超過・Deadlockのどれで終わっても書く。計装なしのビルドは点を持たず、std/quickを使わないプログラムの出力は変わらない。
例: [`examples/cover_basic.sober`](../../examples/cover_basic.sober)
決定: [language.md 39節](../language.md)

S-7. `sober test --mutate` は、テストしたpackageの非テストのファイルのミュータント（比較の境界と否定・算術とビットの演算子の入れ替え・`&&` ↔ `||`・`!` の除去・ifの条件を真 / 偽に固定〔whileは偽〕・呼び出しの式文と代入文の削除）を全部1本のテストのビルドに入れ、ミュータントを選ばずに全部のテストが通ったときだけ、ミュータントごとにそのミュータントに届いたテストを名前の順に走らせ、どれかが0以外で終わればkillと数える。どのテストも届かないミュータントは走らせずに未到達。結果の行の下に `mutate: <package> <割合>% killed (<kill> of <到達> reached) · <未到達> unreached` と生き残ったミュータントを位置の順に20本まで印字する。`--mutate-out=<file>` は1行1ミュータント `<path>:<行>:<列>\t<ミュータント>\t<結果>\t<殺したテスト>` を書く。`<package>/testdata/mutate.ignore` の行（`--mutate-out` の行の頭の2つのフィールド）に当たるミュータントは走らせず `ignored` と数え（割合の分母に入れない）、当たらない行は警告する。`--cover` と同時には指定できない。
例: [`examples/mutate_basic.sober`](../../examples/mutate_basic.sober)（ミュータントの種類の全部 — `sober build --mutate` のベースラインは書き換えなしのbuildと同じ出力）・testdata/mutate/calc（未到達・生き残るミュータント・ハングするミュータント）
決定: [language.md 40節](../language.md)

## 13.1 テストの構成の差し替え

S-8. テストのpackageの `*_test.sober` のpackage節の前の `@doubles("パス", …)`（文字列のリテラル1つ以上・packageごとに高々1つ）が明示したディレクトリ（double — ファイルは全部 `*_double.sober` で、各ファイルはpackage節の前に同じ `@replaces("相手")` を持ち、package名は相手の名前）を、そのテストのビルドの中で相手のpackageとして読む。相手をimportする全部のファイルがdoubleを読む。doubleのパスのimportはそのビルドでは相手の別名で、`*_test.sober` と `*_double.sober` だけが書ける。doubleにだけある名前はdoubleのパス経由でだけ参照できる。本番のビルドは `*_double.sober` を読まない。
doubleの公開の名前のうち相手にもあるものは契約を満たす: 種類が同じ・関数の署名（型パラメータの数・仮引数のmutと型・結果）が同じ・constの値の式が同じ・struct / error / panicの型は両方にあるフィールドの型が同じ（フィールドの増減は自由）・unionと名前付き関数型は形ごと同じ・関数の `@errors` はdouble ⊆ 相手。相手の関数には `@effects`（errorを返すなら `@errors` も）が要る。doubleの関数のエフェクトの導出は相手の `@effects` の内側になければならない（doubleが自分の `@effects` を書くならその宣言も相手の内側）— エフェクトの照合はcheckのanalyzerの段階（`sober check <package> --test`・`sober check <double のディレクトリ>` — 後者はdoubleを相手として読んで契約だけを検査する）。
`sober test <package>… --wiring` はテストを走らせず、doubleごとに `<テストの package>: <相手> <= <double のディレクトリ>` を1行印字する。`--cover`（`--cover-pkg` を含む）と `--mutate` は `*_double.sober` に計装とミューテーションを打たない。doubleの中のpanicの位置はdoubleのファイルのパスで印字する。
例: testdata/doubles/handler（決め打ちのレスポンスと誤りの注入のdoubleで走るテスト）・testdata/doubles/app（本番の読み）・testdata/doubles/crashed（doubleの中のpanicの位置）
拒否: [`examples/doubles_neg_replaces.sober`](../../examples/doubles_neg_replaces.sober)（doubleの外の @replaces）・[`examples/doubles_neg_import.sober`](../../examples/doubles_neg_import.sober)（本番の読みからdoubleをimport）・testdata/doubles/neg（配置先・名乗り・表・import・契約の各項・エフェクトの漏れ）
決定: [language.md 41節](../language.md)

## 13.2 状態を貯めるfake

S-9. `std/testing/cell` は `*_test.sober` と `*_double.sober`（とstd）だけがimportできる。把手 `testing.cell.Cell[T]` はトップレベルのconstの宣言の右辺のリテラル `testing.cell.Cell[T]{…}`（フィールドは `init:` だけ — 省けばTのゼロ値）だけが作り、格納場所は宣言ごとに1つ。`testing.cell.Get(h) T` は格納場所の値（一度も書いていなければinit）を呼び手の最内のregionへコピーして返し、`testing.cell.Set(h, v)` はvを格納場所へコピーして置き、`testing.cell.Update(h, f)` は読み → f → 書きを他の書きと重ならずに行う。fはラムダのリテラル（仮引数1つ）でエフェクトを持たない。Tは関数値・mutの部分・同一性の値を持たない（再帰型は置ける — ゼロ値の無いT〔union〕は `init:` が要る）。Set / Updateのエフェクトは `io`、Getは `io, nondet`。格納場所の寿命はプロセスで、std/quickの試行（シュリンク・再生を含む）の頭で全部が空になる。
例: testdata/doubles/greet（spyのdoubleで走るテスト）・testdata/cells（読み書き・並行のUpdate・quickの試行ごとの空・再帰のunionの値）
拒否: [`examples/cell_neg_import.sober`](../../examples/cell_neg_import.sober)（テストの構成の外のimport）・testdata/doubles/neg/c01〜c04（importの配置先・constの外のリテラル・`key:`・ラムダでないf）・cfx（fのエフェクト）・cty（置けないT）・cset / cupd（値の型）
決定: [language.md 41節](../language.md)
