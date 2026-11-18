# テキストのゴールデン

irtext・lltext・corejson・astjsonのゴールデンは、関数ごとのハッシュの表だけをgitに置く。全文はゲートの中で生成し、gitの外の out/gold/ に置く。

| ゲート | 生成 | 表（git） | 全文（gitの外） |
|---|---|---|---|
| irtext | `sober build <entry> --emit=ir` | testdata/irtext/<題材>.irh | out/gold/ir/<題材>.ir |
| lltext | `sober build <entry> --emit=ll` | testdata/lltext/<題材>.llh | out/gold/ll/<題材>.ll |
| corejson | `sober check <entry> --core-json` | testdata/corejson/<題材>.coreh | out/gold/core/<題材>.json |
| astjson | `sober parse --ast-json <ソース>` | testdata/astjson/<ソースの相対パス>.asth | out/gold/ast/<ソースの相対パス>.json |

- 表を作る道具: scripts/goldtab.ts
- 題材の名前: entryの `/` を `_` にし、`.sober` を落としたもの（examples_fib・testdata_minic_app）。astjsonだけは、ソースの相対パスから `.sober` を落としたもの（examples/fib）
- 生成元が拒否した題材: 今までどおり EXCLUDED.txt に並べる

履歴に入った全文（移行の前のコミット）は残る。移行で止まるのは、これから増える分だけ。

## 表の形

1行はタブ区切りで、名前・ハッシュ・行数・バイト数の4列。ハッシュはsha256の先頭64ビット（16桁の16進）。

- 1行目は `@@full`。全文のハッシュで、正規化しない。全文が1バイトでも変われば、この行が必ず変わる。値は `sha256sum <全文> | cut -c1-16` と同じ
- 2行目からは関数ごとの行と、関数の外の行をまとめた `@globals`。名前の辞書順に並べる。どこが変わったかを読むための行
- 関数ごとの行は、通し番号を正規化してからハッシュを取る。番号のずれだけでは行が変わらない
  - 文字列の定数 `str.N` は、中身のハッシュに置き換える
  - 合成名（`lambda#N`・`kid#N`・`rt.rec_relocate#N`・`…$json…_N_N`）は、「元の名前 + `~` + 本体のハッシュの先頭8桁」に置き換える。本体が同じ合成の関数は同じ名前になるので、行が重複しうる
  - `rt.panic` に渡す点の番号（点の表 `rt.psites` の添字）は `PSITE` に伏せる。点を1つ足すと、後ろの関数の番号が全部ずれるため
- コアJSONの関数（`defs` の要素）は名前を持たず、番号で参照し合う（`call`・`fnref` の `f`）。行の名前は `def~` + 本体のハッシュの先頭8桁にする。本体の中の `f` を伏せてハッシュを取る。行のハッシュは、`f` を参照先の名前に置き換えた本体から取る。入口の式は `@main` の行
- 表層ASTのJSONは、宣言ごとに `type 名前`・`func 名前`・`const 名前` の行にし、ほか（package・importsなど）を `@head` の行にまとめる。位置のフィールド（`tok`・`span`・`sig_end`）は行のハッシュから外す。上に1行足すと後ろの全部の位置がずれるため

検出力は `@@full` の行が保つ。番号だけの変化と関数の並び順の変化は、関数ごとの行には出ず、`@@full` の行にだけ出る。

## 使い方

- 照合: `scripts/irtext.sh`・`scripts/lltext.sh`・`scripts/corejson.sh`・`scripts/astjson.sh`（ゲート）。全題材を2回生成して決定性を確かめ、全文を out/gold/ に置き、表を比べる
- 作り直し: `scripts/regen.sh`（または各スクリプトの `--regen`）。表を testdata/ に書き、全文を out/gold/ に置く
- 全文が要るゲート（llcheck・leanbatch・selfhost_check）は、`scripts/<ゲート>.sh --gen` で全文を最新にしてから読む。selfhost_cliとaxesは表の列を読む。selfhost_parse --all は表のファイルの一覧からソースの一覧を作る。鍵（stage2・入力の木・`SOBER_DATE_SEC`・`SOBER_HASH_SEED`）が合っていれば作り直さない
- 差の中身: `scripts/golddiff.sh <基点のrev> [ir|ll|core|ast] [<題材>…]`。表の行が変わった関数ごとに、全文のunified diffを出す。コアJSONは関数を整形して比べ、名前が片方にしかない関数を番号の順に組にする
  - 題材を省くと、基点と `@@full` の行が違う題材の全部
  - 基点が移行の前のコミットなら、基点のgitの全文と比べる
  - 移行の後のコミットなら、out/gold/base-wt に基点の作業木を作り、そのコンパイラで題材を生成する。生成した全文は out/gold/base/<コミット>/ に残して使い回す

## 古い形のゴールデンを持つbranchをmergeするとき

移行の前から分かれたbranchに、移行の後のmainをmergeする（または逆向き）と、testdata/irtext・testdata/lltext・testdata/corejson・testdata/astjson の全文のファイルが「片方で消され、片方で書き換えられた」の衝突になる。

1. 全文のファイルは、どちらの側で書き換えたものも、片方で足されたものも消す: `git ls-files -z 'testdata/irtext/*.ir' 'testdata/lltext/*.ll' 'testdata/corejson/*.json' 'testdata/astjson/*.json' | xargs -0 -r git rm -q -f --`（衝突の状態のファイルも消える。片方で新しく足された全文は index に載っているので `-f` が要る）
2. 表とEXCLUDED.txtは、どちらの側でもよい（古い形の側には表が無いので、ふつうは衝突しない）。衝突したらmainの側を取る: `git checkout --theirs -- testdata/irtext testdata/lltext testdata/corejson testdata/astjson`（mainをbranchへmergeするとき。向きが逆なら `--ours`）
3. `scripts/regen.sh` で表を作り直し、差を確かめてからmergeのコミットに入れる

衝突の解き方は、今までの「生成物はmainの側を取ってregenで作り直す」と同じ。違うのは、全文を残さず消すことだけ。
