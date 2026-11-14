# 言語仕様

日本語

Soberの言語仕様です。何が受理され、何が拒否され、受理されたプログラムがどう振る舞うかを、話題の順に規則として並べます。

## 文書の層

| 層 | 文書 | 書いてあること |
|---|---|---|
| 仕様 | `docs/spec/`（この文書群） | 今成り立つ規則だけ。経緯・棄てた案・未実装は書かない |
| 文法 | [syntax.md](../syntax.md) | 字句と文法（Go仕様のEBNFからの差分）。パーサが従う正 |
| 設計ノート | [design-notes/](../design-notes/) | 「なぜXでなくYか」— 利用者の問いの形の答え |
| 決定の記録 | [language.md](../language.md) | 決定の全経緯（決定した順・節番号つき）。棄てた案と理由もここ |

規則の「なぜ」は、各規則の末尾の「決定: language.md N節」から決定の記録へたどります。

## 目次

1. [字句と構文](01-lexical.ja.md) — 字句の要点（文法の正は [syntax.md](../syntax.md)）
2. [型](02-types.ja.md) — 基本型・`T?`・slice・map・struct・union・nominal
3. [値と束縛](03-values.ja.md) — const既定・シャドーイングなし・mut引数・freeze
4. [式](04-expressions.ja.md) — if / switchは式・多値・パイプと穴・型推論・評価の順・defer
5. [関数](05-functions.ja.md) — メソッドなし・ラムダと展開・関数値とクロージャ・借り・ジェネリクス・名前つき引数
6. [for](06-for.ja.md) — ジェネレータと文形のfor・生成元
7. [エラーとpanic](07-errors.ja.md) — error型・`?`・`catch`・`@errors`・網羅・panicの範囲
8. [package](08-packages.ja.md) — import・可視性・フィールドの書き・std/internal
9. [メモリ](09-memory.ja.md) — region・境界のコピー・appendと部分列・上限・Pool
10. [並行](10-concurrency.ja.md) — scopeとtask・Join / Try・チャネル・決定性・予算と期限・lease
11. [io](11-io.ja.md) — 読み書き・開いた資源・ストリーム・ネットワーク・期限と壊れ方
12. [アノテーション](12-annotations.ja.md) — 知られた注釈・@embed・@layout・analyzerの規則・秘密の値
13. [テスト](13-testing.ja.md) — `sober test`・assert

## 用語

- 受理 / 拒否 — コンパイラ（`sober check` / `sober build`）がプログラムを通すか、診断を出して止めるか。拒否はコンパイル時に起きる。checkの型の誤りは `type error at <path>:<行>:<列>` の位置つきの1行で出る。buildの拒否のうちcheckも同じトップレベル宣言の中で拒否するものはcheckと同じ行で出る（[language.md 38節](../language.md)）
- check / build — `sober check` は型検査・脱糖・analyzer（ラベル集合の導出・網羅・`@errors` の照合など）まで走らせて判定する。`sober build` は実行ファイルを作り、analyzerを走らせない。仕様の「拒否」はcheckの拒否を指す
- panic — 実行時の死。終了コード101（到達 = バグ）か102（資源の上限）で終わる（[7章](07-errors.ja.md)）
- ゼロ値 — `T{}` が作る値（[2章](02-types.ja.md)）。ゼロ値を持たない型もある
- imm / mut — 値が不変か可変か。コンテナ（slice・map）はimmが既定で、可変にするには `mut` を書く
- ラベル — errorラベル（`type L error{…}`）とpanicラベル（`type L panic{…}`）。どちらも型宣言の形で名前を作る
- std — 標準ライブラリ（`src/std/`）。`import "std/<名前>"` で使う

## 規則の書き方（この文書群の規約）

1. 1規則 = 1段落。段落は規則番号とピリオドで始める（`T-1.`）— 番号は章ごとの接頭辞と通し番号（2章は `T-1, T-2, …`・7章は `E-1, …`）。番号は付け替えない（規則を消したら欠番にする）
2. 段落の末尾に、その規則を示す実物の例と、決定の記録へのリンクを置く:
   - `例:` — 受理される例（`examples/` のファイル）
   - `拒否:` — 拒否される例（`examples/` のファイル。拒否の診断の文面は `testdata/checkverdict/` のゴールデンに固定されている）
   - `決定:` — `language.md N 節`（複数可）
3. 例は `examples/` の実物だけ。コードブロックで引くときは、ブロックの1行目を `// examples/<名前>.sober` にし、残りをファイルの中身と同じにする（出力は直後の「出力:」のブロック、拒否の診断は「拒否:」のブロック）。examplesに無い形を例にしたいときは、先にexamplesを足す
4. 経緯・棄てた案・日付・作業の記録は書かない — 決定の記録へのリンクで代える
5. 未実装・未決は書かない（決定の記録の「未決」とROADMAPの側）
6. 新しい決定はlanguage.mdに書き、この文書群の該当章も同じコミットで直す

## 検査一式

`scripts/docsync.sh`（`scripts/gates.sh` のdocsync）が次を照合します:

- コードブロック ≡ `examples/` の実物（「出力:」のブロック ≡ `.out`・「拒否:」のブロック ≡ checkの拒否の診断）
- 規則の段落ごとに: `例:` / `拒否:` が1本以上あること・ファイルが実在すること・`例:` はcheckが受理し `拒否:` はcheckが拒否すること（`testdata/checkverdict/` のゴールデンの終了コード）
- `決定:` の `language.md N 節` のNがlanguage.mdに、`syntax.md 決定 N` のNがsyntax.mdに実在すること
- 規則の番号が章の中で重複せず、接頭辞が章で1つであること
- `例:` / `拒否:` / `決定:` の行を持つ段落が規則番号（`T-1.` の形）で始まること（番号の崩れで照合を素通りさせない）
