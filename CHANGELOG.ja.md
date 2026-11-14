# 変更履歴

このファイルは公開リリースごとの利用者向けの変更点を記録する。形式は [Keep a Changelog](https://keepachangelog.com/ja/1.1.0/) に倣う。バージョンは [Semantic Versioning](https://semver.org/lang/ja/) に従う（0.x の間は後方互換を約束しない）。

## v0.7.3（2026-11-14）

待ってから返すレスポンスの送り方を変えた版。あわせて、値指向の考え方を軸に文書を組み直した。言語の規則は変わっていない。

### std

- `std/http/server`: `http.server.Delayed(ms, r)` のレスポンスを、待ち時間が満了した時点でランタイムが直接送る。前は、満了でtaskを起こし、起きたtaskが送っていた。手元の計測（async・24,000接続）で、リクエスト1件のユーザー側のcyclesが46%減り、p99が141 msから73 msに縮んだ。待ち時間の下限（`ms` より早く送らない）は変わらない
- 上の変更で、サーバが飽和しているときの送る順が変わる。前は新しく満了したものから送っていた。今は満了した順に送る。中央値は少し遅く、遅い側は短くなる
- `std/http/server`: リクエストのmethod・path・queryを、ASCIIの区切りの位置で切る。前は切り出すたびにUTF-8の検査をしていた
- `std/convert`: 整数を10進の文字列にする処理を速くした。`ParseInt` に18桁以下の高速パスを足した

### コンパイラ

- 大きな不変の値の仮引数を、番地1ワードで渡す。対象は、8ワードを超える不変のstruct・union・`T?` のうち、mapを含まない型。前は値をコピーして渡していた。プログラムの意味は変わらない
- const仮引数の診断の文言を直した（"is a const seat" → "is a const parameter"）

### 文書

- 値指向の文書を足した（[docs/value-oriented.ja.md](docs/value-oriented.ja.md)・英語版は [docs/value-oriented.md](docs/value-oriented.md)）。Soberの中心にある考え方を1本で説明する
- READMEの冒頭を、値指向の説明に差し替えた。柱の節を「値指向から導かれる性質」と「4本の柱」に組み直した
- 言語仕様F-16の文面を直した。mutの束縛を捕捉できないのは、展開されないラムダ（値の位置のラムダと、値の呼び出しの借りの実引数のラムダ）。呼び出し点へ展開されるラムダは捕捉できる。実装は前からこの形で、文面が追随していなかった
- 古くなっていた説明を直した: 再帰の型宣言が通れる経路（`T?` の中身と関数型を含む）・SQL injection（`std/pg` ではSQLの文面がconstに限られるので書けない）・`std/pool` の形（参照を返さず、値をコピーする）・ランタイムが読む環境変数の一覧
- セキュリティのガイドのデータ競合の節に、domainの説明を足した
- 標準ライブラリのリファレンスの見出し「欄:」を「フィールド:」に、CLIの文書の「効果」を「エフェクト」に直した

### 計測

本家のHttpArenaに近い構成（EC2 c6a.metal・サーバ64ワーカー）で、v0.7.2と比べたrps（6周の中央値）:

| 種目 | v0.7.2比 |
|---|---|
| async（32,000接続） | +10.7% |
| baseline（4,096接続） | +1.8% |
| limited-conn | +1.4% |
| json-comp | −1.2% |

レート固定の遅延の種目（latency-10k・latency-1m・8gbit）のp99と平均は、周ごとの幅の内で変わらない。json-compが少し下がった原因は調べている。

## v0.7.2（2026-11-13）

HTTP サーバの要求 1 件の固定費を削った版。v0.6.6 から v0.7.1 にかけて増えていた固定費を v0.6.6 より下まで戻した（手元の pipelined で、要求 1 件の命令は v0.7.1 比 −27%・cycles は −33%）。domain は待っている task が多くても、次の 1 つを起こす手間が増えないようにした。PostgreSQL への接続がプールより多い負荷でも、処理量が落ちなくなった。std/pg は行を 1 回の走査で受け、文のキャッシュとプールの後始末を軽くした。サーバのワーカーの CPU の固定の既定は v0.7.0 までの形へ戻した。

### 言語

- 新しく受理する形（前は check と build の片方か両方が拒否していた — どれも両方が受理する形にそろえた）:
  - 関数値（関数型の欄・局所の変数に束ねたラムダ）を呼んだ結果の欄や要素の欄の読み（`s := r.f(x); s.ok`・`xs := r.f(x); xs[0].ok`・`t := r.f(x)?; t.ok`）— 前は check が拒否
  - byte や named scalar の値を期待する位置（戻り値・実引数・append・slice / map のリテラルの要素）に置いた、腕が型なしの定数の if 式（`if v { 1 } else { 0 }`）— 前は build が拒否
  - struct の欄に置いた同じ形の if 式（`T{b: if v { 1 } else { 0 }}`・`U{p: if v { 80 } else { 443 }}`）— 前は check と build が拒否
  - byte の欄に置いた型なしの数の const と文字リテラル（`T{b: K, c: 'a'}`）— 前は check が拒否
  - `mut map` の仮引数への `delete(m, k)`（ほかの仮引数も持つ関数の本体で）— 前は check が拒否
  - 定数の式（`1 + 2`）は今までどおり byte の文脈に置けない（check と build がそろって拒否する）

### std

- `std/compress/gzip` / `std/compress/flate`（記録つきの符号化 — std/http/server の gzip の応答）: 記録の木を選ぶときの見積もりと正準の符号の作り直しの固定費を削った（出力のバイトは同じ）。手元の bench/httparena の json-comp で 1 要求の cycles −1.7%（8 つのコード配置の中央値・8/8 で減）
- `std/pg`: `pg.ColJsonText(r, i) (string, error?)` — json / jsonb の列の字句を string で読む。`json.Put(mut o, pg.ColJsonText(row, i)?)` で応答へそのまま積める（`string(pg.ColJson(row, i)?)` と書く必要がない）
- `std/pg`: json / jsonb の列も、行を受けた時点で UTF-8 を確かめる（text の列と同じ扱い）。不正なバイト列を含む行は受けた時点で `Protocol` の誤りになる（前は利用者が string へ変えたときに初めて誤りになった）。text / json の列を string で読むときは確かめ直さない
- `std/task`: `task.Ledger()` に `late`（待ちの上限 D を越えて走った task の数の累計）と `maxLate`（越えた量〔待ち − D〕の最大 — ns・読むと 0 に戻る）
- `std/task`: `task.Ledger()` に `parkShallow` / `parkDeep` / `parkDeepWin` / `parkSwap`（接続の task が浅く寝た・ワーカーの区画を持って寝た・浅く寝られる点で区画の窓に中身があって深く寝た〔受けの region に途中の要求を持って待つ等〕・深い待ちの後の受けで浅く寝る直前に区画をワーカーと交換した回数の累計）
- `std/net`: `net.Serve` の `maxWait:` を accept の輪も継ぐ。前は輪だけ既定の 100 ms のままで、接続の張り直しの多い負荷では 100 ms より短い `maxWait:` が効かなかった（輪が積みの底に残り、その上の期限切れの task を救えない）
- `std/time`: `time.Now` / `time.Mono` / `time.Since` が時計を vDSO（`__vdso_clock_gettime`）で読む。前は 1 回ごとに clock_gettime の syscall だった（手元の WSL2 で 1 回 ≈300 ns → ≈25 ns）。vDSO の無い環境では今までどおり syscall。`std/pg` の期限・`std/http/client` の経過・`std/uuid` の V7 など時刻を読む std の口はすべてこの道を通る。clock を使わないプログラムの起動は変わらない（vDSO の番地は最初に時計を読むときに引く）
- `std/pg`: プールが借り手の死んだ接続を探す走査を、どこかの借り手が死んだときだけ行う。前は `pg.With` を呼ぶたびにプールの全部の枠を見ていた（1 枠あたり 336 命令 — プールの大きさに比例していた）

### ランタイム

- std/net の Serve の接続の task の機械スタックを 2 つに分けた: 接続の本体の枠は task の塊の頂上に残し、それより下の呼び出しはワーカーごとの積みの区画の上で走る。task が寝るときは走っていた区画を持って眠り、ワーカーは task の区画を受け取って次に使う — 走っている間に触る積みの頁がワーカーの温かい区画に寄る。本体の枠が塊の頂上の余白に入らない接続は今までの連続の形で走る。接続あたりのメモリは変わらない（async 24,000 接続で RSS とページテーブルは前の形と同じ水準）。次の要求の受けを待つ点では本体より下の枠を捨て、区画を持たずに寝る（浅い待ち）— 寝ている keep-alive の接続の常駐は 12 → 8 KB / 接続。handler の中で寝た（Sleep 等）接続は、次の受けで寝る前に持っている区画をワーカーの区画と交換する。ローカルの bench/httparena（12 ワーカー・8 通りのコード配置の中央値）で baseline 4,096 接続の cycles / 要求 −7.6%・DRAM からの読み込み −29%・張り直しの多い limited-conn −18%・async 24,000 接続は同等（+0.2%）。次の要求の受けで寝る接続は、要求ごとの region の窓もワーカーの区画に付けた（区画の窓 — 深く寝る接続は区画ごと持って眠る）— 寝ている keep-alive の接続の常駐は 8 → 4 KB / 接続。8 通りのコード配置の中央値で cycles は baseline ±0%・pipelined +0.7%・async −0.3%・json +0.3%・limited-conn −6.4%、RSS は baseline 71 → 55 MB・json 126 → 112 MB
- サーバの形（std/net の Serve・`SOBER_WORKERS` なし）のワーカーの CPU の固定の既定を、v0.7.1 の「L3 キャッシュを共有する CPU の群」から CPU 1 つ（v0.7.0 までの形）へ戻した。HttpArena の Zen 2 の箱で latency-1m の p99 が v0.7.0 の約 20 倍になったため（他の箱では再現せず、原因は確定していない）。L3 の群は `SOBER_PIN=1` で選べる（`2` = CPU 1 つ・`0` = 切る）
- 飽和下の待ちの上限 D の約束の文面を改めた: 「D を過ぎた task は、期限の順に、まだ期限の来ていない task より先に走る。D を越えて走った数と越えた量は `task.Ledger()` の `late` / `maxLate` で読める」。前の文面（走れるようになった task は D 以内に走る）は、task が自分で譲るまで走り、走れる task が他のワーカーへ移らない作りの上では守れない場合があった。実装の順序は変わらない
- domain の `Await` の待ちの列を「眠っている待ち手の列」と「起こされ済みの印」に分けた。本体を終えた task が次の待ち手を起こすとき、起こされたがまだ走っていない待ち手を 1 人ずつ確かめていた（lock を持ったまま — 1,024 接続・プール 250 本で 1 要求あたり約 1,150 回）。今は列の頭の 1 人を起こすだけになった。来た順・待ちの上限・毒の意味は変わらない
- keep-alive の HTTP（平文）の応答の送りを、送りの完了を待って眠る形（畳み）から、ワーカーの送り場へ写して眠らずに次の要求の受けへ進む形（送り置き）に変えた。起こしは今までどおり 1 要求 1 回で、受けを待つ点の積みが 304 B 浅くなり、待っている間に応答の作業域を持たない。読むのが遅い相手への送り残しはカーネルが送り切る（その接続も他の接続も眠りが滞らない）。送りの誤りは同じ接続の次の受けが返す（`http.server.ServeConn` の返すラベルは同じ）。公開の `net.Send` は今までどおり同期。手元の HttpArena の種目で処理量・分位点は変わらない（rps 比 0.99〜1.03）。`SOBER_NET_FUSE=0` で送り置きしない

### コンパイラ

- region の省略を広げた: 関数が自分の region を開かずに済む条件に、確保が呼び手の region へのものだけの関数と、呼び先の確保が失敗の戻りの道にしかない関数を足した。何も写さない relocate（行き先が関数の入口の深度のもの）は消す。HTTP サーバの要求 1 件の命令の削減の約 4 割はここから（手元の callgrind・pipelined・1 ワーカー: 5,996 → 5,343）。コンパイラ自身にも効き、コンパイラが自分を build する命令は 0.37 G（0.3%）減り、出力は 125 KB 小さくなった
- `return g(…)` の形で、g の結果の型が自分の結果と同じなら、自分の結果の置き場をそのまま g に渡し、結果の写しを省く。bench/httparena の `/pipeline` で要求 1 件あたり −123 命令、ヘッダ 8 行の要求で −228 命令
- 大域の番地を、枠に置いて持ち回らずに使う点で作り直す（輪の外で定義して輪の中で使う番地は、作り直さずレジスタに乗せる）。添字が定数 0 の番地の計算を基の番地へ畳む
- スロットの共有（枠の中の置き場の使い回し）を、置き場の合計が 128 語に満たない関数にも掛ける。bench/httparena の全関数の枠の合計が −12%（sret の転送と合わせて）。コンパイルの仕事は +0.6%
- region の省略の判定を、省ける関数が増えなくなるまで繰り返す。前は 1 回の判定で落ちた関数の呼び手が、その関数が後で省けるようになっても落ちたままだった。bench/asyncdb で要求 1 件あたり −1,456 命令
- バイト列の走査（`while i < n && b[i] != c` の形と UTF-8 の検査）の端数を、最後の 16 バイトを重ねて 1 回読む形にした。前は 16 バイトに満たない残りを 1 バイトずつ見ていた。bench/httparena の `/pipeline` で要求 1 件あたり −85 命令、ヘッダ 8 行の要求で −59 命令
- 走査の塊を含む関数が、入口で退避する xmm レジスタを、その塊が実際に書く分だけにした（要求 1 件あたり −24 命令）
- build が lower の段で落ちたときに、別のトップレベル宣言の check の誤りを出していた（本当に落ちた位置が隠れる）。check の誤りが同じ宣言の中にあるときだけ check の行を出し、それ以外は lower の位置を出す

### ツール

- 文書: 並行のガイド（docs/guide/concurrency）の domain の節を広げた — 定義と使い分け・`Update` / `Read` / `Await` の例・待ちの順と期限と観測・毒・書けない形とその理由・std/pg のプール
- `bench/pgstub`: PostgreSQL の wire protocol だけを話す代役（平文・trust・拡張問い合わせ・固定の表）。PostgreSQL の CPU を除いて、サーバの側の費用を測るのに使う

### 修理

- 再現可能な build（v0.6.5 から）: 8 バイトの語に詰めると同じで長さだけ違う 2 つの string のリテラル（`"/"` と `"/\0"`）が、build の置き場で同じ鍵を持つ別々の読み出し専用のデータになり、置き場を使って lower を並列に走らせる build でその参照が入れ替わることがあった。プログラムの振る舞いは同じ（読むバイトが同じ）だが、実行ファイルが置き場なしの build と違いうる。こうしたリテラルは 1 つのデータを共有する
- 誤コンパイル（メモリ安全・v0.5.0 から）: 最適化のバックエンドがベクトル化するバイトの走査のループ（`while i < n && b[i] != ';' { i += 1 }` など）が、始点の符号を見ずに 16 バイトの塊を読んでいた。負の始点（ループは最初の反復で panic する）から始めると slice の前を読み、そこに止まるバイトが無ければ 0 以上の位置から続けて panic が消えた（例: `scan(b, -8, 40)` が 40 を返した）。int の最大値から 16 以内の始点では始点 + 16 があふれ、slice の遠く外を読んだ。どちらも最適化なしと同じ位置で panic するようにした
- メモリ安全（v0.7.1 から）: 状態に slice か map を持つ domain で `task.Await` が実際に待つと、起こされた後に状態が呼んだ task の region へ写され、以後その写しが domain の状態になっていた。写しの置き場は呼び出しの後に回収されるので、本体が返した値（状態の clone・文字列）と他の task の `Update` の書きが同じ置き場を共有し、受け取った値が後の書きに化けた（ワーカー 2 以上で確率的に・本体の後に文字列を作る形はワーカー 1 でも）。待たない `Await`・`Update`・`Read` は正しかった。状態は待った後も domain の置き場にとどまるようにした
- 誤コンパイル: 大きな struct（128 語以上の置き場を持つ関数で）を返す関数が `defer` の中で mut の仮引数に書き、呼び手がその実引数を呼び出しの後で読まないとき、返した値に defer の書きが混ざった（例: `func g(x mut R) R { defer bump(mut x); return R{…} }` を `r := g(mut x)` と呼ぶ）。関数型の欄を通した間接の呼び出しでも同じ。既定のバックエンド（x86-64）だけで、`--via=ll` は正しかった。返す値の置き場と mut の実引数の置き場を、呼び出しの間は重ねないようにした
- std/http/server が gzip で圧縮した応答（1 KB 以上の本文で圧縮の効く Content-Type、または長さの分からないストリームを、gzip を受けるクライアントへ返すとき）で `Set-Cookie` を落としていた。応答の頭は本文を圧縮するかどうかに依らなくなった
- region の省略の判定の見落とし 2 件: ある形の関数（宛先へ直に値を組む関数の結果を受ける呼び出しなど）を呼ぶたびに、呼び手の region に一時の確保（24 B など）が残っていた。メモリ安全の問題ではないが、呼び手の region を抜けるまで回収されなかった

### 性能

- HTTP — bench/httparena（自前の物差し: HttpArena の負荷発生器と要求のファイルを使うが、HttpArena の公式の結果ではない）。16 vCPU の GitHub Actions の箱（AMD EPYC 9V74）で、サーバに 8 CPU を与え、v0.7.1 と同じジョブの中で周ごとに交互に計測（全種目・5 周の中央値・4,096 接続）。サーバは `SOBER_WORKERS` なしで起動（ワーカー数は許可された CPU の数から・CPU の固定は既定）:

  | 種目 | 要求/秒（v0.7.1 比） | CPU/要求（v0.7.1 比） | peak RSS（v0.7.1 → この版） |
  |---|---|---|---|
  | pipelined | **+26.2%** | −20.8% | 79 → 96 MB |
  | baseline | **+7.2%** | −6.9% | 64 → 50 MB |
  | async | +2.8% | −1.1% | 401 → 401 MB |
  | json-tls | +0.9% | +1.3% | 239 → 234 MB |
  | json-comp | +0.7% | −0.6% | 81 → 81 MB |
  | json-comp-16k | −0.4% | +0.6% | 277 → 276 MB |
  | json | −1.5% | +1.4% | 104 → 90 MB |
  | limited-conn | −6.7% | −2.7% | 73 → 73 MB |
  | 8gbit | （率は固定） | −7.4% | 73 → 61 MB |
  | latency-10k | （率は固定） | −6.7% | 27 → 23 MB |
  | latency-1m | （率は固定） | −4.8% | 27 → 26 MB |
  | latency-500k-8cpu | （率は固定） | −4.7% | 28 → 27 MB |

  - limited-conn の −6.7% は、負荷発生器（gcannon 8 スレッド）の CPU が律速の相の現象で、サーバの退行ではない。サーバの CPU/要求は −2.7%・p99 は 102 → 9.8 ms。サーバのワーカーが手すきになって眠る回数が増えると、起こす費用が負荷発生器の側の CPU に乗る。手元で負荷の側の CPU を増やすと、差の向きは逆転する（サーバが軽い側が +6.3%）
  - メモリ: baseline・json は peak RSS が減る（寝ている keep-alive の接続の常駐が 1 接続 12 → 4 KB）。pipelined は peak RSS が +17 MB（ページテーブルは 37 → 24 MB に減る）・json-tls はページテーブルが 62 → 77 MB に増える。この 2 つの出どころは未特定で、次の版で調べる
  - 表の計測の後に入った変更（build の置き場の鍵の修理）は、サーバのコードを変えない

- pipelined の要求 1 件の費用 — 手元（WSL2・AMD Zen 5）。サーバ 8 ワーカー（CPU 0〜7・`SOBER_WORKERS=8` なので CPU の固定は掛からない）・負荷は別の 8 CPU（4,096 接続・16 本ずつ pipeline）。コードの配置を変えた 8 通りのビルドを交互に 4 周測り、配置ごとの中央値の中央値:

  | | v0.6.6 | v0.7.1 | この版 |
  |---|---|---|---|
  | 命令/要求 | 5,371 | 5,791 | **4,200** |
  | cycles/要求 | 2,283 | 2,792 | **1,878** |
  | 要求/秒 | 5.05M | 4.48M | **5.52M** |
  | 要求のたびに実行されるコードの大きさ（要求 1 件に 0.5 回以上走る 64 B の行の合計） | 23.9 KiB | 27.3 KiB | **22.4 KiB** |

  - v0.6.6 から v0.7.1 にかけて、要求 1 件の命令は +7.8%・cycles は +22% 増えていた。cycles の増え方が命令より大きかったのは、要求のたびに実行されるコードが L1 命令キャッシュ（32 KiB）の際まで膨らみ、命令キャッシュの miss が増えたため。この版で両方とも v0.6.6 より下へ戻した
  - 削ったもの: 要求の頭の走査を 8 バイトずつに・ヘッダの位置の表を 1 本 2 語に・応答の頭を出力の列へ直に積む・`Response` を値で回さない・`utf8.Check` に短い全 ASCII の入力の早道・コンパイラの region の省略（上の節）

- async-db（PostgreSQL）— 手元（WSL2・AMD Zen 5・24 CPU の 1 台に PostgreSQL 18 も同居）。サーバ 12 CPU・負荷 8 スレッド・プール 250 本:
  - 1,024 接続（プールより多い）の要求/秒: domain の直しの前後で 23〜25K → 50〜57K。260 接続（≈ 55K）と同じ水準になった。1 要求あたりの lock の待ちは 230〜540 µs → 1〜2 µs
  - サーバの user CPU/要求: std/pg の直し（行の受け・文のキャッシュ・プールの後始末・UTF-8 の確かめ）の前後で 75〜99 µs → 35〜50 µs。この箱の要求/秒は PostgreSQL の CPU（1 要求あたり 160〜270 µs）で頭打ちになるので、サーバの側の削減は要求/秒には現れにくい
  - Go の pgx（本家の go-stdlib の entry の写し）と同じ箱で交互に測ると、要求/秒は 1.6〜2.25 倍（1 組は Go が上回った）。応答時間の中央値は Go より短いが、p99 は Go より長い

## v0.7.1（2026-11-11）

長命の共有状態 domain と PostgreSQL のクライアントの版。多くの task から 1 つの状態（接続のプール・数え口など）を更新する形を、lock を書かずに書けるようになった（`task.NewDomain` / `Update` / `Read` / `Await` — 本体は直列に走り、待たない・io なしの約束で lock の順序のデッドロックが書けない）。std/pg は wire protocol 3.0 の上に TLS 1.3 + SCRAM-SHA-256-PLUS を既定にした PostgreSQL のクライアントで、トランザクションと接続のプールを持つ。HTTP サーバの JSON の応答の組み立てを二段の符号器に変え、要求 1 件の固定費を削った。v0.7.0 の limited-conn の退行（64 ワーカーの箱で −11.5%）を直した。

### 言語

- domain — 直列化された共有状態（spec 10.8 節・[並行ガイド](docs/guide/concurrency.ja.md) 5 節）: `task.NewDomain(s, init, wait:)` が scope `s` の中に状態を 1 つ持つ domain を作り、`task.Update`（書く）・`task.Read`（読む）・`task.Await`（`when:` が真になるまで来た順に待つ・待ちの上限 `wait:` を越えたら `io.Expired`）が本体を 1 つずつ当てる
  - 本体の約束: 待たない・io なし・別の domain を呼ばない・明示の panic なし。lock を持ったまま待つ形が無いので、lock の順序で起きるデッドロックは書けない
  - どの task が先に入るかは、ファイルやネットワークの入力と同じ「録られる入力」として決定性の約束の表に載る（順を固定すれば結果はスケジュールに依らない — Lean の Kahn の定理をオラクルつきに拡張して証明）
  - 本体が死んだ domain は毒になり、以後の呼び出しは `task.Poisoned{}` で呼び手を死なせる（半端に書かれた状態で進まない）
  - d は捕獲でき、関数の実引数にできる（struct の欄に入れて渡すのも）。scope の値・task の結果・チャネルのペイロード・関数の戻り値にはできない（作った scope の出口で状態ごと消える）
  - 状態は mut の器（mut slice / mut map — 入れ子も）を持てる。初期値は domain へ写して入れ、本体の値も呼び手へ写して返すので、状態の器は domain の外から書けない
  - 本体の書きの規則は検査が名指しで拒み、書き換えの形を出す: 状態に region を持つ値を足す（append 等 — 状態の別名を経た書きも）・domain を作った scope より長く生きる場所への格納・状態を mut の実引数に渡す（呼び先が本体と同じ規則で書くと呼び先の本体から導けるときは渡せる）
- const の席 `@const(p, …)`: 付けた仮引数への実引数は、ビルド時に文面の決まる文字列（補間の無いリテラル・const・それらの `+`）か、呼び手自身の `@const` の仮引数だけ。std/pg の SQL の文面はこの席なので、利用者の値を SQL の文面へ連結する形（SQL injection）は書けない（値は引数で渡す）
- 新しく受理する形（前は check が文面なしで落としていた — build は受理）: 関数の中で組む union の variant（region を持つペイロードを含む）・外の package の型つきの const（`http.OK`）を `T?` の仮引数や `check --split` の読み戻しで使う形・mut の仮引数を持つ関数の展開の中の slice の読み

### std

- `std/pg`（新）: PostgreSQL のクライアント（wire protocol 3.0・extended query）
  - 接続: `pg.Open(url, k, policy:)`（k が接続 `Conn` を受け、返ったら閉じる）。TLS 1.3 + SCRAM-SHA-256-PLUS（チャネルバインディングつき）が既定で、証明書の鎖は常に検証する。緩める欄は `dangerously…` の 3 本だけ。パスワードは `@secret`
  - 文: `pg.Exec` / `pg.Script`・行は `for r <- pg.Query(c, sql, args: …)? { … }`（本体を ? / return / break で抜けても残りの行を読み捨てて接続を保つ）。SQL の文面は const の席・引数は `pg.Value` の 12 variant をサーバの型に合わせて符号化・文の準備は接続ごと・文面ごとに 1 回
  - 行の読み: `Col` / `ColInt` / `ColString` / `ColTime` / `ColUuid` / `ColJson` / `ColNumeric`（`Scaled`）ほか・`IsNull`・`Width`
  - 失敗のラベル: `Server`（SQLSTATE・hint つき）・`Auth`・`Tls`・`Dns`・`Closed`・`Protocol`・`BadUrl` ほか
  - トランザクション: `pg.Tx(c, k, isolation:, readOnly:)` — k が普通に終われば COMMIT・k の中の ? で抜ければ ROLLBACK。入れ子は一様に SAVEPOINT。k の中で文の誤りを握りつぶして普通に終わったら、巻き戻して `Aborted` を返す。自動の再試行はしない
  - 接続のプール: `pg.OpenPool(url, k, size:, wait:)` と `pg.With(p, k)`。型 `pg.Pool` は domain と預かり所の組で、名前つきのハンドラに実引数で渡せる。預け直すのは k が普通に返り、トランザクションの外で読み残しがない接続だけ（それ以外は閉じる）。借り手の task が死んだ接続はプールが回収する。`OpenPool` の名は、関数 `Pool` が型 `Pool` と衝突するため（`Open` → `Conn` と同じ対の形）
  - 実 PostgreSQL 17 / 18（TLS / 平文）との往復を `scripts/pgoracle.sh` が照合する
- `std/task`: domain の 4 つの口と `Domain[S]`・`task.Ledger()` に `domains`（全 domain の合計の行 `DomainView{waiting, maxWait, expired, poisoned}`）・`pin` / `pinGroups`（ワーカーの CPU の固定の形）
- `std/http/server`: `Delayed(ms, r)` — 待ってから返す応答。待つ間、接続の task はハンドラの積みと要求の region を持たない（ハンドラの中で `os.Sleep` してから返すのと送る時刻は同じで、足跡は keep-alive の接続と同じ）。pipelined の順は変わらない
- `std/http/server`: `Cache` に `Unstated{}` — Cache-Control の行を書かない（保存の可否を受け手に任せるので共有されうる側 `@shared` — ルートの行でだけ書ける）。既定の `private` は変わらない
- TLS クライアント（http/client と pg）: 鍵共有に secp256r1（P-256）を足した。X25519 を優先し、サーバが HelloRetryRequest で P-256 を求めたら応じる（PostgreSQL 17 以前の既定の設定は P-256 だけを受ける）
- analyzer: std の `dangerously…` の欄に字面の false 以外を与える構築を、毎回 warning にする（受理は変えない・抑止の口なし — 安全な設定に戻すと消える）

### ランタイム

- サーバの形（std/net の Serve・`SOBER_WORKERS` なし）のワーカーの CPU の固定を「CPU 1 つ」から「L3 キャッシュを共有する CPU の群 ∩ 許可の集合」へ。群は sysfs から読み、読めなければ CPU 1 つに縮退する。`SOBER_PIN=0` で固定を切る・`1` = 群・`2` = CPU 1 つ（比較の口）
- 期限の待ちの鎖を双方向にし（取り外し O(1)）、期限の走査に下界を持たせた。期限つきの接続が多いときの O(n²) の崖が消えた（16,000 接続・W12・期限つきの Serve: 45〜49K → 453〜475K 要求/秒 — 手元。期限の無い本番形の命令数は不変）
- domain の `Await` の待ちの列: 同じ `when:`（捕獲のない字面のラムダ）で偽と分かった待ち手は、状態が変わるまで起こさない。待ち手が多いときの起こしの連鎖（1 回の出口で待ち手の数に比例する起こし）が消えた（1 つの domain に 1,024 本の待ち手・W1: 1 取得あたり 596K → 6.3K 命令 — 手元）。来た順・待ちの上限・毒の意味は変わらない
- error の値の表現をタグ + ラベルの列の 4 語に固定した。プログラムの中で最も大きい欄を持つラベルが、全関数の error の置き場を広げなくなった（std/pg を import しても HTTP の接続 task の最深の枠は 2,112 B のまま — 前の表現では 2,688 B）。欄つきのラベルは失敗の道でだけ確保する
- task の積みの頂上の余白を 2 → 3 KiB に。HTTP サーバの keep-alive の要求 1 件の最深の積みが旧の予算に 16 B しか余っていなかった（越えると接続ごとに常駐 +4 KB）。最深は新しいゲート stackcheck が見張る

### ツール

- 文書: 並行のガイド（docs/guide/concurrency — task・チャネル・domain）と PostgreSQL のガイド（docs/guide/postgres — 接続・文・行・失敗・トランザクション・プール）
- `bench/httparena`: `perf.sh json-tls`（json-tls の perf の帰属）・`local.sh` の `WRK_THREADS`（json-tls の wrk のスレッド数 — 既定は負荷側の CPU 数・本家は 64）と負荷側の CPU の busy の欄
- `bench/httparena`: 本家の entry と同じ起動の形（`SOBER_WORKERS` なし = CPU の固定 on）で測る口 `SOBER_UPSTREAM_FORM=1`

### 修理

- v0.7.0 の limited-conn の退行（HttpArena の 64 ワーカーの箱で −11.5%）: 接続を張り直すたびに、窓の頁を返す madvise が TLB の撃ち落としを全ワーカーの CPU へ飛ばしていた。返しを task の塊ごとに初回の 1 回だけにした（手元 W8 の page fault 36,004〜45,919 → 91〜114）
- TLS クライアントが HelloRetryRequest の後の 2 番目の ClientHello で random を作り直していた（RFC 8446 4.1.2 違反 — Go の crypto/tls のサーバは拒否する）
- 関数の中で組む union の variant・外の package の型つきの const・展開の中の slice の読みを、check が文面なしで落としていた（build は受理 — 言語の節の「新しく受理する形」）

### 性能

- HTTP — bench/httparena（自前の物差し: HttpArena の負荷発生器と要求のファイルを使うが、HttpArena の公式の結果ではない）。16 vCPU の GitHub Actions の箱（AMD EPYC 9V74）で、サーバに 8 CPU を与え、v0.7.0 と同じジョブの中で周ごとに交互に計測（5 周の中央値・4,096 接続）。今回は 1 世代の箱での同箱 A/B:

  | 種目 | 要求/秒（v0.7.0 比） | CPU/要求（v0.7.0 比） |
  |---|---|---|
  | json-comp | +12.2% | −10.8% |
  | json-comp-16k | +10.2% | −8.9% |
  | async | +3.9% | −3.6% |
  | baseline | +2.3% | −2.2% |
  | pipelined | 同等 | 同等 |

  - json-comp の伸びは JSON の応答の二段の符号器（上界を見積もって 1 本だけ確保し、位置で書く）から。同じ符号器は TLS の経路の JSON 応答にも効く
  - async のメモリ（cgroup）: ピーク 847 → 670 MB・pagetables 153 → 66 MB — 待ってから返す応答（`Delayed`）は待つ間ハンドラの積みと要求の region を持たないので、寝ている接続の足跡が keep-alive の接続と同じになった
  - baseline の伸びは要求 1 件の固定費の削減（Query の 1 回走査・ヘッダの位置の表と応答の頭を呼び手の列へ）から
  - 表の計測の後に入った 2 つ（domain の `Await` の待ちの列・error の表現）は、同じ 16 vCPU の箱で前後を交互に測る A/B で 12 種目すべて ±2% 以内（退行なし）
  - json-tls はこの 16 vCPU の箱で v0.7.0 比 −19% と出るが、サーバが速くなって負荷発生器（wrk 8 スレッド × 4,096 接続）が律速に移る相の現象で、サーバの退行ではない。本家と同じ形（wrk 64 スレッド）で 64 CPU のサーバ（EC2 c6a.metal・AMD EPYC 7R13）を測ると、JSON の符号器が入る前の版と比べて要求/秒 +1.9%・CPU/要求 −10%

## v0.7.0（2026-11-08）

import の体系を刷新した版。修飾子は import パスの全段（`std/http/server` → `http.server.Serve`）になり、ビルドの起点の `sober.mod` でモジュールの名前とローカルの依存を宣言できるようになった。std は Web アプリに欠けていた部品を揃えた: パスワードハッシュ・暗号用の乱数と UUID・時刻とタイムゾーン・cookie・世代つきのセッション・DNS のスタブリゾルバ・証明書の鎖を常に検証する HTTP クライアント。std/http はサーバ（std/http/server）・クライアント（std/http/client）・共有の語彙（std/http）に分けた。deflate は似た本文の続く接続で Huffman の木を作り直さない記録を持ち、HTTP サーバの gzip の応答が速くなった。実行時は起動で W^X を固定する（Linux 6.6 以上）。

破壊的変更が多い版なので、0.6.7 から上げるときは下の「移行」の節から読むこと。

### 移行

0.6.7 のコードを 0.7.0 に上げる手順:

1. 修飾子をパスの全段にする。`import "std/compress/gzip"` の参照は `gzip.Encode` → `compress.gzip.Encode`、自分の木の `import "util/strings"` は `strings.X` → `util.strings.X`。`std/` は落とす（`import "std/json"` は `json.X` のまま）。1 段のパスは変わらない。長い修飾子はファイル局所の別名 `import gz "std/compress/gzip"` で短くできる
2. HTTP サーバのコードを `import "std/http/server"` に移し、`http.X` → `http.server.X` にする（`http.server.ServeConn`・`http.server.Request`・`http.server.Text` …）。`std/http` に残るのは共有の語彙（`Field`・`BadHeader`・`StatusCode` と `http.OK` などの const）だけ
3. `ServeConn` / `ServeWith` の名前付き引数 `compress:` → `compression:`
4. 改名を追う（下の「破壊的変更」の一覧）。ラベルの改名は `catch` / `switch` の腕にも及ぶ
5. 応答に Set-Cookie を任意ヘッダで書いていたら `Response.cookies`（`[]http.server.SetCookie`）へ移す（任意ヘッダの Set-Cookie は `panic(BadHeader)`）
6. gzip の応答の本文を要求の本文だけで決めたい（内容アドレスのキャッシュなど）なら `compression: http.server.Gzip{fresh: true}`（既定は接続ごとの記録を使う — 下記）

### 破壊的変更

- 修飾子 = import パスの全段（`std/` だけ落とす）。パスの最後の段だけで参照する旧綴りは受理しない。パスの段はどれも小文字の識別子でキーワードでないこと。修飾子の根の段（`http.server` の `http`）と同名の局所の束縛はエラー
- std/http を三分割: サーバの API は `std/http/server` へ（`http.Serve…` → `http.server.Serve…`・`http.Stream` → `http.server.Stream` ほか全部）。`std/http` は共有の語彙だけ
- `http.server.ServeConn` / `ServeWith` の `compress:` → `compression:`（`std/compress` の根の段と衝突するため）
- 形の誤りのラベルを `Bad…` に揃えた: `convert.InvalidInt` / `InvalidFloat` / `InvalidBool` → `BadInt` / `BadFloat` / `BadBool`・`json.InvalidJson` → `BadJson`・`strings.InvalidUtf8` / `env.InvalidUtf8` → `BadUtf8`
- 範囲外のラベルを `…OutOfRange` に揃えた: `json.IntRange` → `json.IntOutOfRange`
- `compress.flate.Prepare` → `compress.flate.NewWork`
- `crypto.chacha20.XorKeyStreamAt` の位置の仮引数 `at` → `off`（位置で渡す呼び手は無変更）
- `std/tls/record` を公開面から外した（`std/internal/record`）
- `crypto.rsa.MontSelfCheck` / `crypto.rsa.SelSelfCheck` / `crypto.sha256.ShaSelfCheck` / `crypto.x25519.FeSelfCheck` を公開面から外した（各 package のテストへ）
- Set-Cookie は `Response.cookies` の型の欄でだけ書ける。任意ヘッダの Set-Cookie は `panic(BadHeader{name: "Set-Cookie"})`
- 外の package の struct の、mut の中身（mut の slice / map）を持つ欄は、composite の構築でも値を与えられない（読み・書きは前から不可）。外のリテラルではその欄を省く（ゼロ値の空の中身）。この形で std の不変の約束（`table.Freeze`・`strings.Clone` の結果）を外から壊せた穴を塞いだ
- 関数値の option（`F?` — 欄・map の読み・`[]F?` の要素）を絞らずに呼ぶ形を check / build とも名指しで拒否する（build は受理して nil なら落ちていた）
- 結果を持つ func の本体の末尾が、panic 以外の呼び出しの式文で終わる形を拒否する（check は末尾の値を戻り値として受けていた）

### 言語

- import と package（言語仕様 8 章）: 修飾子 = import パスの全段。別名の import は修飾子を丸ごと置き換える。import パスの根の段は「木での名前」の 1 つの名前空間（std の根・dep の名前・起点の木の根のディレクトリ）に住み、衝突はどちらも優先せず拒否する
- `sober.mod`: ビルドの起点（cwd）に置く任意の 1 枚のモジュールの宣言。`module "example.com/app"`（最後の段が名前）・`dep "../kv"` / `dep kv2 "../kv"`（ローカルパスの依存 — import パスは木での名前から書き、出所は sober.mod にだけ書く）・`alias stdjson "std/json"`（std の根の付け替え — 衝突の解消）。起点より上のディレクトリは探さない。この版の dep はローカルパスだけで、版の指定・他の出所・dep の dep は名指しで拒否する
- Go との違い（修飾子・出所の置き場・根の決め方・衝突の解き方）と命名規約（package 名は 1 語の小文字・仮引数と欄は名詞）は language.md 20 節に表で置いた
- 名前付き関数型への変換 `W(e)`: ラムダ・名前付き関数・W の値を W の値の位置に置く。値の呼び出しの実引数に名前付き関数を渡せる
- 名前付き引数つきの呼び出しを for の生成元に置ける: `for x <- g(a, n: v)? { … }`
- 新しく受理する形（今まで check か build の片方が拒否していた）: struct の mut map 欄への格納 `s.m[k] = v`・列の要素への複合代入 `xs[i] op= v`・欄の改名束縛 `case A{e: inner}`・variant 1 つの union（再帰・総称も）・cell に再帰型の値を置く・総称の名前付き関数型へ名前付き関数を渡す
- 文面なしだった拒否を名指しにした: `string?` と string の比較・Def として呼ぶジェネリックの region を持つ型引数・局所に束縛した名前付き関数を値の位置へ・ゼロ値の無い型の欄を部分リテラルで省く
- 他 package の名前の診断の表示を修飾子で出す

### std

- `std/http/client`（新）: HTTP/1.1 のクライアント。`http.client.Request(url, method:, headers:, body:, cookies:, policy:)`・本文を切片で受ける `Stream`・接続を束ねる `Open` / `Session` / `Send`。TLS は 1.3 が既定（1.2 は `dangerouslyAllowTls12` の明示でだけ）で、証明書の鎖は常に検証する（検証を切る欄は無い）。信頼の起点は焼き込みの Mozilla NSS のストアと `Policy` の `extraRoots`（`tls.ParseRoots`）。焼き込みの起点で止まる鎖の leaf には CA/B Forum の Baseline Requirements の規則を掛ける。リダイレクト（origin が変われば Authorization / Cookie を落とす）・proxy（http は絶対 URI・https は CONNECT — `ParseProxy`）・cookie は `CookieValue` で取り出して次の要求に載せるデータ（jar は持たない）。設定は状態の無い `Policy` 1 型
- `std/http/server`: 応答の `cookies []SetCookie`。省いた欄のゼロ値が安全な側（Secure・HttpOnly・SameSite=Lax・Path=/）で、緩める欄は `dangerouslyAllowHttp` / `dangerouslyScriptReadable` の綴りだけ。属性の規則（`__Host-` / `__Secure-` ほか）を破れば panic
- `std/http/server`: gzip の応答は接続ごとに直近の動的 Huffman の木を記録し、似た本文が続く接続では木を作らずに使う（接続あたり 4 KB・圧縮しない接続は 0 B）。圧縮した本文は接続の要求の列で決まり（同じ列なら同じバイト列）、大きさは記録を使ったブロックで記録なしの 1.03 倍まで。`Gzip{fresh: true}` で記録を持たない（0.6.7 までの、本文だけで決まる道）
- `std/http/server`: `Dispatch` の方針（`cache:`）の無いルートは handler の応答をそのまま返す（写しが 1 回減る）
- `std/session`（新）: 世代つきのセッショントークン（HMAC-SHA256 の封・サーバ側にセッションの表を持たない）。照合は `Open` → `Subject` → `Check` の二段で、パスワードの変更などで世代を上げると古いトークンは `Stale`。読みは `Who` / `Of`（ゼロ値の `Claims` は検証済みとして読めない）。脅威モデル（備えるもの・守らないもの）を doc に載せた
- `std/crypto/password`（新）: Argon2id・bcrypt・PBKDF2-HMAC-SHA256 と、PHC 文字列の `Verify` / `NeedsRehash`。費用は省略可の名前付き引数で、省くと OWASP Password Storage Cheat Sheet の推奨の下限（Argon2id 19456 KiB・2・1 / bcrypt cost 10 / PBKDF2 600000 回）。既定の改訂は std の版で行い、この変更履歴に載せる。`Policy` の `UseDefault` は方式も費用も std の版に任せる
- `std/crypto`: `RandIntn`（暗号用の乱数の一様な整数）
- `std/uuid`（新）: `NewV4`・`NewV7`・`Format` / `Parse`・`Equal`
- `std/time`（新）: 壁時計の `Time` と単調時計の `Instant` を別の型で持つ（壁時計の差で期限を測る事故を型で防ぐ）。RFC 3339 / HTTP-date の書式と読み・暦（`Civil`）・IANA tzdata 2026f の焼き込み（`LoadZone`・`ToCivilIn` / `FromCivilIn`）
- `std/net`: 名前の解決（スタブリゾルバ — libc を使わない）。`net.Dial` がホスト名を受ける（/etc/hosts → /etc/resolv.conf の DNS）
- `std/url`: `FormatQuery`（`ParseQuery` と往復）
- `std/compress/flate` / `gzip`: 動的の木の記録 `History` と `EncodeHistory` / `EncodeWithHistory`（出力は (data, level, 記録の値) で決まる）
- `std/binary`: `AppendWord`（値の下位 k バイトを末尾に積む）
- `std/pool`: 狭い語の生のアクセサ `LoadRaw16` / `StoreRaw16` / `LoadRaw32` / `StoreRaw32`
- 焼き込みの外の事実の表（信頼ストア・tzdata）は、生成のスクリプト・照合のゲート・定期の更新（GitHub Actions）を同じ型で持つ。使わないプログラムには表が入らない（ゲート datadce で見張る）
- 誤りの語の定義を docs/terms.md に: `TooLong`（渡した値が上限を超える）・`TooLarge`（走りながら積もった量が上限を超える）

### ランタイム

下の `SOBER_MDWE=0`・`SOBER_NET_FUSE=0`・`SOBER_TASK_WIN=0` は、問題の切り分けと一時的な退避のための口です。既定のまま使うことを勧めます。

- 起動で実行可能メモリを放棄する（`PR_SET_MDWE` — Linux 6.6 以上）。以後プロセスは W+X の頁を作れず、実行できない頁に実行を足せない。処理系にバグがあってもコード注入への昇格路が無い。`os.Run` で起動する子には引き継がない。動的計装（valgrind など）と同居させるときは `SOBER_MDWE=0`
- keep-alive の HTTP（平文）で、応答の送りと次の要求の受けの待ちを 1 回の眠りに畳む（1 要求あたりの io_uring_enter ≈1.7 → ≈1.0 回）。`SOBER_NET_FUSE=0` で畳まない
- 接続の task の浅い 4 深度の region を、task の塊の末尾の頁から始める（溢れたら今までの小さいスロットへ移す）。接続を張るたびに触る頁が減り、ページテーブルの消費が接続あたり ≈8.8 → ≈2.1 KB（手元）。region 1 つの上限は `region:` ちょうどのまま。窓を組むのは std/net の Serve を持つプログラムだけ。`SOBER_TASK_WIN=0` で窓を張らない
- 暇なワーカーの盗みと眠りの手前の見直しが、空でないかもしれない列だけを読む（列ごとの印のビット集合）。低い負荷でワーカー数に比例して乗っていた要求ごとの線の読みが消える（手元・W64 で 1 要求 −4〜4.7K cycles）

### ツール

- `sober` は起点の `sober.mod` を読む（check / build の答えの再生の照合にも入る）
- 文書: Web サーバ（docs/guide/web-server）と Web クライアント（docs/guide/web-client）のガイド・準拠文書（docs/conformance — std の通信プロトコルと暗号の規格への準拠。表と数はテストの実物から生成し、ゲート confsync が照合する）

### 修理

- `freeze` の解析が、局所の束縛のラムダの呼び出しの結果を新しい値とみなしていた。`g := () => m; im := freeze(g()); m[0] = 9` が check も build も通り、凍った値が書き換わっていた（形式モデルは拒否していた — 実装だけの穴）
- imm の欄に、暗黙の freeze の点にならない mut のコンテナ（呼び出しの結果）を置く形を、check は受理し build は文面なしで落としていた。両方で名指しの拒否に
- 外の package の composite で mut の中身を持つ欄に別名を与え、std の不変の約束を壊せた穴（上の破壊的変更）
- 関数値の option を絞らずに呼ぶと build の出力が nil で落ちていた（上の破壊的変更）

### 性能

- HTTP — bench/httparena（自前の物差し。HttpArena の負荷発生器と要求のファイルを使うが、HttpArena の公式の結果ではない）。GitHub Actions の 16 vCPU の箱で、サーバに 8 CPU を割り当て、同じジョブで v0.6.7 と周ごとに交互に走らせた（5 周の中央値）。箱の CPU が 2 世代（AMD EPYC 9V45 = Zen 5・7763 = Zen 3）に分かれたので、両方の箱で同じ向きに出た差だけを数で載せる:

  | 題材 | 要求 / 秒（対 v0.6.7） | CPU / 要求（対 v0.6.7） |
  |---|---|---|
  | json-comp | +12〜13% | −11〜12% |
  | json-comp-16k | +9〜11% | −8〜10% |
  | latency-1m | 同等（レートを保つ） | — （p99 464 → 402 µs 級 — 両箱で改善） |
  | latency-10k | 同等（レートを保つ） | — （p99 は 9V45 で 181 → 93 µs・7763 は同等） |
  | json-tls・8gbit・latency-500k-8cpu | 同等 | 同等 |
  | baseline・pipelined・limited-conn・async | 同等圏（箱の世代により ±数%） | — |

  - baseline・pipelined・limited-conn・async は箱によって −6%〜+12% の幅に出た。Zen 5 の箱（9V45）では改善、Zen 3 の箱（7763）では数 % の退行の向きで、1 つの数にまとめられない
  - json-comp の得は deflate の記録（上の std）と、記号の記録・ビット出力・鎖とハッシュの表の 16 ビット化など圧縮器の核の書き直しによる。記録の値札は圧縮する接続あたり 4 KB で、json-comp の最大 RSS は +13〜61 MB（接続数による）
  - カーネル側のメモリ（cgroup の pagetables — 9V45）: baseline 30.8 → 8.9 MB・json-comp 47 → 9 MB・async 283 → 154 MB。接続の task の浅い region の窓（上のランタイム）による構造的な削減
  - 全題材で 2xx 以外の応答なし

## v0.6.7（2026-11-05）

言語の波の版。素直に書いた再帰の型宣言（`type L struct { v int; next L? }` や `type Value union { Array { items []Value }; … }` のような形）を受理するようになり、std/json は値そのものを再帰の木として持つ `json.Value` / `json.Tree` を手に入れた。浮動小数点は補間・定数式・`std/math` の語彙・リテラルの範囲検査が揃って整備を終えた。言語では局所の束縛のラムダと、状態を呼び手が持ち運ぶ「関数型の mut 仮引数」を足し、絞り（narrowing）は mut への代入やループの条件をまたいでも規則が一様になった。0.6.6 以前から潜んでいた誤コンパイルを 1 件、`freeze` の見落としを 2 件直した。

### 破壊的変更

- `http.Stream` の署名が変わった: `func(out mut Out, emit func(out mut Out, b []byte) error?) error?`。送り先の状態（圧縮器・合計・chunked かどうか）は不透明な `Out` が持ち、呼び手は `emit` へ `out` をそのまま渡す（借りのラムダが `mut` の状態を捕まえる形は廃止 — 下記）
- 借りのラムダ（`(p) => { … }` の形）が `mut` の束縛を捕まえる書き方（L1）を廃止した。状態を持つクロージャは「関数型の mut 仮引数」（`func(st mut S, …)`）で書く
- `std/json` の既存のビュー型は `json.View`（variant も同系の名前）に改名した。木そのものを指す名前 `Value` は新顔の再帰の union に割り当てた

### 言語

- **再帰の型宣言を受理する**（iso-recursive）。対象は 2 形: 関数型をまたぐ閉路（S）と、slice / map の要素を経由する閉路（D — ジェネリックの型引数も含む）。union の self-reference（`next L?` のような optional 経由の自己参照）も、内部では 1 セルの箱として表現しつつ、書いた型どおり `L?` として扱えるようになった。値が作れない閉路（union の variant が自分を直に値で持つ形など、無限の大きさになる形）は今までどおり拒否し、診断の文面を「値の大きさが無限」に整理した
- 深い再帰の値を組み立てる構築（cons のような鎖を関数の戻り値として積み上げる形）で、戻り先への追記として組み立てるようコンパイラが書き換えるようになった。節点ごとに親の深さ分コピーしていた分が消え、深い木の構築は節点数に比例する時間で済み、作業領域の消費も深さの 2 乗から線形になった（下記「性能」）
- 浮動小数点の整備を完了:
  - 文字列補間 `"${x}"` に float を渡せるようになった（int / float / string / bool の 4 型）
  - 定数式での四則演算・単項マイナス（`-1.5` 等）を型つきの IEEE 754 演算として組み立て時に畳むようになった
  - `std/math` に `Trunc` / `Floor` / `Ceil` / `Min` / `Max` を追加（ビット操作と比較だけ・決定的・libm 不使用）
  - 範囲外のリテラル（整数の桁あふれ・float で ±Inf に丸まる値）を名指しで拒否する診断に直した（今までは一般的な構文エラーの文面だった）
- **局所の束縛のラムダ** `f := (n int) => n + k` を受理する。値として持ち運べる関数値ではなく、呼ぶたび・匿名の関数型の仮引数へ渡すたびにその場へ展開される束縛で、`mut` の束縛を本数の制限なしに捕まえられる。値として使う・値の位置へ渡す・本体内での `return` / `?` / 外側の `break`・前方参照・同時束縛は名指しで拒否する
- **関数型の mut 仮引数** `func(st mut S, ev int)` を、名前付き関数・匿名の関数型（値・欄・ジェネリックの型引数）・借りの仮引数・展開（高階関数への受け渡し）・局所の束縛のラムダのどの位置でも受理する。状態は呼び手が持ち、呼ぶたびに `mut` で明示して渡す形に揃えた。これに伴い、今まであった 2 本の制約（「`mut` 仮引数を持つ関数は関数値になれない」「ラムダの `mut` 仮引数は借りの窓の中でしか使えない」）を撤去した
- **絞り（narrowing）の規則を整理した**: 絞った `mut` の変数に書く文（代入・複合代入・`mut` での呼び出し）の後ろでは、その名前は元の `T?` 型に戻る。これにより `while c != nil { s += c.v; c = c.next }` のような鎖を辿るループが書けるようになった（絞った変数の**欄**への書き `x.f = v` は、書きの時点で名前が `T?` に戻るため引き続き型エラー — 欄を書くなら別名に束縛してから書き戻す）。`while` の条件の `x != nil` も、周を回るたびに頭で絞り直すようになった（今まで `while` は絞らなかった）
- check と build の判定の食い違いを直した: 列の要素の欄への複合代入（`xs[i].f op= v`）など

### ツール

- `sober build --mem-report`: 関数ごとのメモリ使用量の上界（region に積む論理バイト数の高水位）と、スタックフレームの上界を報告する開発者向けの口。上界を出せない形（再帰・外部入力依存・間接呼び出しなど）は理由つきで名指しする

### std

- `std/json`: 値そのものを木として持つ `Value`（再帰の union）・`Tree`・`Encode[json.Value]` / `Decode[json.Value]` を追加。既存のビュー型は `View` に改名（破壊的変更・上記）
- `std/math`: `Trunc` / `Floor` / `Ceil` / `Min` / `Max` を追加
- `rand.Float`（`[0, 1)` を 2^-53 刻みで一様に生成）・`quick.Float`（境界値・小さい 2 進の分数・任意のビット列を生成する PBT 向け生成器）を追加

### 修理

- 境界コピー（値をある場所から別の場所へ移す最適化）が、元の場所を後で読む経路（チャネルの送信・`cell` の `Set` / `Get`）で元の値を書き換えてしまう誤コンパイルを直した。入れ子の slice や string を持つ値を送受信・保存すると、送り手の値や `cell` の内容が後から化けることがあった（0.6.6 以前からの不具合）
- `freeze` の検査に 2 つの見落としがあった: ① 局所の束縛のラムダの本体を、束縛した時点で検査していたため、`freeze` の後にラムダ経由で書き込む形を見逃していた ② 関数値を実引数に取る呼び出しが、実引数に渡した値を書き換えうることを見落としていた。どちらも検査が通した形で実際に凍結後の値が書き換わりうる穴だったため直した

### 性能

再帰型の構築を線形化した（手元 Zen 5 の実測）:

- 深い再帰の値の構築を、戻り先への追記として組み立てる形に書き換え、節点ごとに親の深さ分コピーしていた分を消した。手で書いた入れ子の型と比べた差（idiomgap）は、深さ 2 / 4 / 6 で +35 / +71 / +108% あった命令数の超過が、+11.0 / +10.8 / +10.5% まで縮んだ（残りは深さに依らない定数分 — rt の再配置 1 節点あたりの固定費）
- 深さ `n` の鎖を戻り先への追記で組む題材: 90 → 900 段で、作業域の RSS が 1.7 → 135 MB（2 乗・旧）から 0.4 → 3.8 MB（線形）に
- 再配置の作業スタックの置き場を直し、ループで鎖を組む形（cons の反復）の RSS を 10 万節点で 158 MB → 3 MB に減らした

## v0.6.6（2026-11-03）

性能の版。HTTP サーバは受けのバッファの環を増分消費に替え、要求あたりの CPU を減らした。TLS は握手（RSA の署名・x25519・SHA-256）と AES-GCM の record を速くし、deflate の lv6 は圧縮率を数 % 譲って速くした。言語では、テストの構成で package を代役に差し替える `@replaces` / `@doubles`（ビルド時 DI）と、状態を貯める fake の置き場 std/testing/cell を足した。assert は失敗の位置を利用者の行で出し、ラベルを取れるようになった。check と build の判定の食い違いも多数直した。

### 言語

- テストの構成の差し替え（ビルド時 DI）: double は `_double.sober` だけのディレクトリで、各ファイルの package 節の前に `@replaces("相手のパス")` を書く。テストの package の `_test.sober` の package 節の前に `@doubles("double のパス", …)` を書くと、そのテストのビルドでは相手を import する全部のファイル（他の package も）が double を読む。本番の build と check は `_double.sober` を読まない。double と相手の公開の名前は契約として照合する（関数の署名・型の共通の欄・const・`@errors` ⊆・相手の `@effects` の宣言）。本物に無い効果を持つ double は拒否する。`sober check <double のディレクトリ>` は契約だけを検査する
- `assert` の失敗の panic は、利用者が assert を書いた行を指すようになった（今までは std/testing の中を指していた）。第 2 引数に任意のラベル `assert(e, label)` を取れる。ラベルは失敗したときだけ評価し、見出しは `assert failed (<label>): <式>`
- 期待型の無い位置の if / switch の式で、腕の型が T と T? に分かれる形（`r := if c { 4 } else { q }`・絞った腕と絞らない腕）、または腕の一つが nil で終わる形は、式の型を T? にする。nil の腕と error のラベルの腕の合流は error? になる
- `&&` / `||` の右の項での nil の絞りが、式の位置（else つき if の条件・return・束縛・assert）によらず効くようになった。`if A && x != nil { … } else { … }` の本体でも x は絞られる
- 絞った mut の束縛への代入（`if x != nil { x = 5 }` など）は今までどおり拒否する。診断は的の名前・絞った if の位置・回避の形（別の名前に束縛する）を名指すようになった
- yield 形の for の本体の `return` を正式に受理する（文書の禁止を外した — 実装は今までも受理していた）
- `give:` に渡せる値をチャネルの端点（std/task の Sender / Receiver）に限り、それ以外は名指しで拒否する（今までは build が受理し、実行時に落ちていた）。値は捕獲で渡す
- check と build の判定の食い違いを直した（どれも、今までは片方だけが拒否していた形）:
  - 外の region の値を局所の slice / map へ足す・写す形（`append` の要素・リテラルの要素）、mut の成分を持つ struct の初期値と欄への `append`
  - 期待型を、文つきのブロックの末尾・ラムダのブロックの本体・switch の腕まで届ける（`byte?` の腕の `{ g(); 44 }`・`return string(b) catch nil` など）
  - ジェネリックの struct の欄の読み・ジェネリックの関数の結果の欄の読み
  - 多値を穴へ順に落とすパイプ `divmod(17, 5) |> add(_, _)`
  - panic で終わる scope の本体（`task.Run((s) => { panic(Boom{}) })`）
  - string を for の生成元に直に置く形 `for c <- s` は check でも名指しで拒否する（`for c <- bytes(s)` を案内する）
  - build の内部段だけが拒否する形は、check が同じ形を拒否するなら check と同じ診断を出す

### テスト

- std/testing/cell（新）: fake が呼ばれた記録・書かれた値を貯める置き場。`Cell[T]` は const の宣言でだけ作り、`Get` / `Set` / `Update` で読み書きする（効果は io）。import できるのは `_test.sober` と `_double.sober` だけ。std/quick は試行ごとに置き場を空にする
- `sober test --wiring`: テストのビルドを読み（走らせない）、double ごとに `<テストの package>: <相手> <= <double>` を印字する
- double は計器の外: `--cover` は double のファイルに計器を打たず、`--mutate` も変異を打たない。double の中の panic の位置は double の実パスで印字する
- power assert の値の行が、関数型の実引数・`mut` の実引数・`catch` を含む式でも出るようになった

### ツール

- `sober watch` は温めのテストが読んだファイル（`_test.sober`・double・契約で読んだ相手）も見張る
- check のキャッシュの直し: 素の `error` を返す関数が、他の package の error の payload の型の変化で無効化されないことがあった

### std

- std/crypto/aesgcm: `Open` / `OpenAt` は復号しながら GHASH を畳み、最後に tag を照合する形になった（今までは照合してから復号）。tag が合わなければ、書いた平文を `crypto.Wipe` で 0 に消して `Auth` を返す（平文は呼び手に渡らない）
- std/compress（deflate）: lv6（`compress:` の既定）の設定を速さ寄りにした（鎖 128 → 64・nice 128 → 96・lazy の閾値 12 → 10）。出力のバイト列が変わる。JSON の本文の圧縮率は zlib の lv6 比で 1.6〜2.6% 大きい（今までは 1% 以内）。率を重く見るなら lv7〜9。lv4 / 5 / 7〜9 は変わらない
- std/crypto/sha256: SHA-NI のある CPU では命令の塊で圧縮する（1 MiB の Sum256 34.9 → 2.04 cycles / B — 手元 Zen 5）。無い CPU は今までの形

### ランタイム

- 受けのバッファの環を増分消費（IOU_PBUF_RING_INC — Linux 6.12 以上）にした。16 KiB のバッファをワーカーの全接続で区間ずつ分け合う。接続が多いと環が空になって read(2) に倒れ続けていた道が消える。環の大きさは全ワーカーの和で最大約 16 MiB。6.12 より前のカーネルでは今までの固定スロットの環で動く
- io_uring の ring の fd を登録し（Linux 5.18 以上）、接続の送りを固定のファイル表（ring ごとに 4,096 枠）から出す。SQE ごとのファイルの参照の取り外しが省ける。枠が尽きた接続は今までの fd で動く
- 次に走る候補の task の TCB とスタックを先読みする（飽和して run queue が深いときに効く — 手元 W12 で async 16,000 接続の cycles / 要求 −18〜20%）。先読みするのは run queue で 2^22 TSC（≈1.4 ms）以上待った候補だけで、判定は run queue の枠に持つ積んだ時刻で決まる（候補の TCB を読まない）。今から走る task の TCB は常に先読みする。sleep の満了で起こす task の TCB も先読みする
- 実行の順・待ちの上限 D・観測できる値はどれも変わらない

### 性能

- HTTP — bench/httparena（自前の物差し。HttpArena の負荷発生器と要求のファイルを使うが、HttpArena の公式の結果ではない）。GitHub Actions の 16 vCPU の箱（AMD EPYC 9V74）で、サーバに 8 CPU を割り当て、同じジョブで v0.6.6・v0.6.5・Go の net/http を周ごとに交互に走らせた（5 周の中央値）:

  | 題材 | 要求 / 秒（対 v0.6.5） | CPU / 要求（対 v0.6.5） | 対 Go 要求 / 秒 v0.6.5 | 対 Go 要求 / 秒 v0.6.6 |
  |---|---|---|---|---|
  | baseline | +9.2% | −8.7% | 2.76× | 3.02× |
  | pipelined | −1.9% | +2.2% | 12.6× | 12.4× |
  | limited-conn ※ | −4.8% | +4.6% | 2.47× | — |
  | json | +9.0% | −8.5% | 3.03× | 3.31× |
  | json-comp | +19.7% | −16.4% | 1.66× | 1.98× |
  | json-comp-16k | +17.0% | −14.6% | 1.58× | 1.85× |
  | json-tls | +29.8% | −23.2% | 2.19× | 2.85× |
  | 8gbit | +0.8% | −8.5% | 0.99× | 1.00× |
  | async | +3.7% | −5.0% | 1.82× | 1.89× |

  ※ limited-conn（数要求ごとに接続を張り直す形）の行は、先読みの修理（上のランタイムの節 — 温かい task の候補を先読みしない形）の後の別の run の値（同じ箱の型・同じジョブで v0.6.5 と交互）。この題材の同じ箱の比較は 1 run で ±2.5〜3% 揺れ、箱と run により v0.6.5 比 −5〜+3% の同等圏に入る（EPYC 9V74 −4.8%・9V45 −2.5%〜同等・Xeon 同等）。同じ run の baseline は +9.6%・async は +4.2%。対 Go の比はこの run で取っていない

  - 8gbit は帯域で頭打ちの題材で、CPU / 要求で読む。latency 系（一定レート）は両版ともレートを保ち、CPU / 要求は −0.1〜−2.2%
  - 全題材で 2xx 以外の応答なし
- TLS の握手: RSA の署名の窓の表引きと Montgomery の 2 乗、x25519 の体の積、SHA-256 を命令の塊にした。握手 1 回のサーバの user cycles 4.61 → 3.20 M（−31% — 手元 Zen 5・1 ワーカー）
- AES-GCM: GHASH を 8 ブロック束ねて還元を 1 回にし、CTR と GHASH を 1 回の走査に縫い合わせた（GHASH は Karatsuba）。鍵の表と record ごとの状態を分け、record ごとの 384 B の写しを消した。16 KiB の record で Seal 1.08 → 0.63・Open 1.09 → 0.64 cycles / B、64 B の record の命令は Seal −51%・Open −47%（手元 Zen 5）
- コンパイラ: 境界検査の熱い道を分岐の落ちる側に保つ（冷たい区画への辺の写しを関数の末尾へ出す）、葉の極小関数の展開を写した本体の中まで広げる、同じ値どうしの比較を畳む、ほか。サーバの json-comp で cycles / 要求 −6.6%（8 配置 × 3 周 — 手元）、逐次の routing −7.7%・jsonapi −1.7%
- 逐次の題材の Go の双子との比（CPU 時間〔task-clock〕の同じ周の対の比の 5 周の中央・範囲は周ごとの比の最小〜最大・GitHub Actions の 16 vCPU〔AMD EPYC 9V74〕で 1 コアに固定）:

  | 題材 | Sober / Go | 範囲 |
  |---|---:|---|
  | binary-trees（18） | 0.37× | 0.36〜0.38 |
  | k-nucleotide | 0.37× | 0.36〜0.38 |
  | 1BRC（1,000 万行） | 0.55× | 0.54〜0.56 |
  | reverse-complement | 0.63× | 0.62〜0.63 |
  | fasta（250 万） | 0.64× | 0.63〜0.64 |
  | jsonapi（10 万） | 0.74× | 0.74〜0.76 |
  | n-body（500 万） | 0.81× | 0.81〜0.82 |
  | logagg（50 万） | 0.96× | 0.94〜0.98 |
  | fannkuch-redux（11） | 0.97× | 0.97〜0.98 |
  | mandelbrot（4000） | 0.98× | 0.98〜0.98 |
  | spectral-norm（2000） | 1.00× | 0.99〜1.02 |
  | routing（50 万） | 1.15× | 1.15〜1.22 |

  前回の公式（2026-10-25）は AMD EPYC 9V45 の箱で、型番が違うので並べて比べられない。

## v0.6.5（2026-10-31）

テストの版。std/quick のプロパティベーステスト、`sober fuzz`、`sober test --cover`（カバレッジ）、`sober test --mutate`（ミューテーションテスト）の 4 つの検証の道具を足し、テストの書き方のガイドを付けた。`sober check` / `sober build` / `sober test` は前回と同じ問い合わせの答えを覚えて返すようになり、`sober watch` は保存の後に build とテストを裏で温める。CLI は宣言の表（新しい std/cli）に置き換え、使い方の誤りは終了コード 2 になった（**破壊的変更** — `-run` → `--run` ほか）。

### 破壊的変更

- CLI の長い名前のフラグは `--` で始める: `sober test -run <prefix>` は `sober test --run <prefix>`（1 本ダッシュの長い名前は unknown flag の誤りになり、近い綴りを示す）。コマンド行の使い方の誤り（未知のフラグ・値の欠け・組めない組み合わせ）は終了コード 2（今までは 1）
- 多値を既存の名前へ代入する形（`a, b = f()`・`_, b = f()`・`s.x, b = f()`）を拒否する（今までは build が受理し、check が内部の誤りで落ちていた）。新しい名前で受ける（`a, b := f()`）か、全部捨てる（`_, _ = f()`）。右辺が複数の並べた代入（`a, b = b, a`）は今までどおり
- build のキャッシュが既定で on になった（下の「ツール」）。キャッシュの置き場を作りたくない環境では `SOBER_BUILD_CACHE=0`

### 言語

- 組み立ての const: トップレベルの `const` に、string / float（負を含む）/ true・false / struct（部分リテラル）/ imm の slice とその入れ子を書ける（int の const は今までどおり畳む・それ以外は参照する点で組み立てる）。葉に書けるのは int の const 式・閉じたラムダ・名前付き関数の参照・他の const の参照・欄の値の位置の nil
- 別 package の名前付き関数型を、関数の結果・仮引数・struct の欄・ジェネリックの型引数に書けるようになった（今までは check が UnknownName・build が UndefinedType で落ちていた）
- `sober check` の型の拒否が位置を出す: `sober: type error at <path>:<行>:<列>`（判定の JSON は今までどおり）

### テスト（検証の 4 点セット）

- std/quick — プロパティベーステスト: 選択の源から値を引き（`quick.Int` / `Bool` / `Pick` / `Elem` / `Bytes` / `String` / `Runes` / `Slice`）、`quick.Check` がプロパティを試行ごとに呼ぶ。偽になったら選択の列をシュリンク（縮小）して最小の反例を印字する。シードはテストの名前で決まり、同じコードなら何度走らせても同じ試行・同じ反例になる。`*_test.sober` では、プロパティの最後の式が偽になった反例を `assert` と同じ形（部分式の値つき）で印字する
- `sober fuzz <package> --run TestXxx`: テストの `quick.Check` を期限（`--time`）まで回し続ける。偽・panic・ハング（`--hang`）を見つけたらシュリンクして報告し、選択の列を `<package>/testdata/fuzz/` に書く — `sober test` はそれを先に再生する。既定でカバレッジに誘導される（新しい分岐を開いた試行の列をミューテーションして使う — 手元の題材で、入れ子の 4 バイトの魔法値を誘導なしでは 1,400 万試行で 0/10、誘導ありでは 9 万試行で 10/10 見つけた）。`--sched` は std/task のスケジュールも試行ごとに振る
- `sober test --cover`: テストした package の分岐（関数の本体・if の両側・switch の各腕・ループの本体・`&&` / `||` の右辺・catch の腕 — 出力では arm）を、どれかのテストが通ったかで数え、未到達の分岐を位置の順に出す。`--cover-out` でテキストか LCOV
- `sober test --mutate`: テストした package にミュータント（比較の境界と否定・算術とビットの演算子の入れ替え・`&&` ↔ `||`・`!` の除去・条件の固定・文の削除）を織り込んだテストのビルドを 1 本作り、ミュータントごとにそれに届いたテストだけを並列に走らせて kill / 生き残り / 未到達を数える。`--mutate-out` で 1 行 1 ミュータント・`<package>/testdata/mutate.ignore` で等価ミュータントを除く
- テストの結果の再生: `sober test` は全部通った package の印字を覚え、ソース・testdata・テストが読む環境変数のどれも変わっていなければ、建てずに走らせずに返す（手元で 4〜15 ms）。`--fresh` で必ず走らせる

### ツール

- 答えの再生: `sober check` / `sober build` は前回と同じ問い合わせ（読んだファイルの中身・ディレクトリの .sober の並び・@embed の入力・効く環境変数が全部同じ）の答えを覚えて返す。コンパイラ自身の `sober check` で冷 4.4 s → 0.05 s
- 関数単位の check のキャッシュ（既定 on・`SOBER_CHECK_CACHE=0` で切る）と build のキャッシュ（既定 on・`SOBER_BUILD_CACHE=0`）: 編集の後は変わった関数と package だけを検査し直し・作り直す。置き場は worktree の外の共有ストア（複数の worktree で共有）・`sober cache info` / `sober cache gc`
- `sober watch`: 保存 → check の答えが 0.05 s 前後。受理の回の後に build とテストを裏で温める（`nice 19`・ワーカーの 1/4）ので、続けて打つ素の `sober build` / `sober test` が 1 回目から当たる（手元で build 0.27 s）。編集が 200 ms 静まるのを待ってから回す（`SOBER_WATCH_QUIET`）
- build の lower を関数単位に分けて並列に（ワーカーが 2 本以上のとき既定 on・出力はバイト一致）
- `sober doc --cli`: CLI のリファレンスを実行ファイル自身から Markdown で（docs/cli/sober.md はこの生成物）
- `sober outline <file>`: ソースファイルの宣言の一覧と行の範囲（text / json）
- `sober --help` / `<command> --help` / `--version` は std/cli から出る（80 桁）

### std

- std/cli（新）: CLI を const の宣言の表（フラグ・位置引数・環境変数・サブコマンド）で書き、`cli.Main` が解析・使い方・誤用の診断（終了 2）・`--help` を出す
- std/env（新）: 環境変数を const の表で宣言し、`env.Load` が入場で 1 回だけ全部を読んで検査する（Missing・BadValue・InvalidUtf8）
- std/quick（新）: 上のテストの項
- std/os: `RunTo`（子の標準出力 / 標準エラーをファイルへ）・`AppendFile`・`Remove` / `RemoveDir`
- std/table: `Read`
- std/task: `task.Run(…, backlog: K)`（下のランタイム）・`task.Ledger()` に `backlog` / `backlogYield`
- std/net: `net.Serve(…, backlog: K)`

### ランタイム

- 未着手の子の上限: spawn した子のうち、まだ走り始めていない子はワーカーあたり 255 本まで。越えると生んだ task が譲り、子をその場で先に走らせる（値・出力は変わらない）。子を生み続けるループ（accept の形）で、生む速さが CPU の取り合いで掃く速さを上回っても peak RSS が伸びない（手元で、4 コアを忙しいループと取り合わせて 200 万 spawn: 47〜77 MB → 1.7 MB）。`task.Run(…, backlog: K)` / `net.Serve(…, backlog: K)` で 1〜255 に下げられ、子の task は継ぐ。観測は `task.Ledger().backlog`（今の未着手の数）・`backlogYield`（譲った回数）
- 凍らせた map を子の task が引いたとき、番地 0 への書きで落ちる・`task.Map` の結果が黙って 0 になる・値渡しのたびに索引を作り直して region を食い尽くす、の 3 つの不具合を直した
- 書いた実行ファイルを直後に実行すると、まれに ETXTBSY（Text file busy）で失敗した不具合を直した（std/task を使うプログラムのファイルの書きを同期の write に）

### 文書

- テストの書き方のガイド（docs/guide/testing.ja.md / testing.md）: 小さな題材で、assert → std/quick → `--cover` / `--mutate` → `sober fuzz` の順に進む。出力は全部実物
- 抽象化のガイド（docs/guide/abstraction.ja.md / abstraction.md）: interface の代わりに — 名前付き関数型とクロージャ・関数の欄の struct（辞書）・union と型パターンの switch・他の言語からの対応表
- 環境変数のガイド（docs/guide/env.ja.md / env.md）: コンパイラ・ランタイム・std が読む環境変数の表
- 用語: テストの語を業界の通り名に（プロパティ・シュリンク・ミュータント・分岐・シード・ジェネレータ）・effect の訳を「エフェクト」に

## v0.6.4（2026-10-26）

accept をワーカーごとにした版。`net.Serve` はワーカーの数だけ同じ番地の listener を持ち、各ワーカーが自分で accept して、受けた接続をそのワーカーで走らせる。そのため `net.Listen` は SO_REUSEPORT を立てるようになった（性質の変更 — 下の std の項と安全性ガイド）。言語には省略可の匿名関数型の仮引数が入り、`http.ServeFlushed` は `http.ServeWith(…, put:)` に畳んだ（**破壊的変更**）。あわせて、故障の時に rt が何をしていたかを残す飛行記録（既定は off）を足した。

### 破壊的変更

- `http.ServeFlushed` を削除した。同じことは `http.ServeWith(recv, send, route, …, put: (b) => tls.Put(c, b))` で書く（下の言語の項の省略可の仮引数）。put を渡さない `ServeWith` / `ServeConn` の呼び出しは今までと同じコードになる
- `net.Listen` が SO_REUSEPORT を立てる。同じ uid で動く別のプロセスは同じ番地に bind でき、届く接続をカーネルの振り分けで分け合う。**同じ番地での 2 つ目の起動は「使用中」（EADDRINUSE）で失敗せず、黙って接続の一部を受ける**。別の uid のプロセスは bind できない。二重起動を起動の失敗で検出していた運用は、別の手段（pid ファイル・systemd の単一起動など）に替える必要がある

### 言語

- 省略可の匿名関数型の仮引数 `p (func(…) R)?`: func 宣言の仮引数にだけ書ける。呼び手は nil・省略・ラムダ・関数の名前・囲む関数の同じ形の仮引数を渡せる。本体では `if p != nil { p(…) }` の腕の中でだけ呼べる（格納・return・束縛は拒否）。有無は呼び出し点ごとに字面で決まり、渡さない呼び出し点のコードは、その仮引数が無い関数と同じになる。裸の `func(…) R?` は「結果が省略可の関数」と紛れるので拒否し、括弧の形へ誘導する。省略可の関数を格納したいときは名前付き関数型の option `F?` を使う

### 性能

- HTTP（bench/httparena — HttpArena の負荷発生器と要求のファイル・GitHub Actions の 64 vCPU でサーバ 32 コア・Go の net/http と比べた自前のハーネスで、HttpArena の公式の結果ではない）: Sober / Go の比は v0.6.3 の run と比べて baseline 3.2 → 3.5×・pipelined 15.9 → 15.7×・limited-conn 9.2 → 11.1×・json 3.4 → 3.6×・json-comp 1.8 → 1.8×・json-comp-16k 1.7 → 1.6×・json-tls 2.8 → 2.8×・async 2.4 → 2.3×。v0.6.3 の run は EPYC 9V45（Zen 5）、v0.6.4 の run は EPYC 9V74（Zen 4）で CPU の世代が違い、型の差で比が数 % 動く（特に limited-conn は 9V74 で高めに出る）。latency-1m は目標の速さを保ち、p99 は 0.21 → 0.14 ms。non-2xx は全種目で 0
- accept をワーカーごとに: 今までは accept 専任のワーカー 1 本が受けて各ワーカーへ配っていたので、接続の出入りが激しい負荷ではそこが天井になっていた。今は `net.Serve` がワーカーの数だけ同じ番地の listener を足し、ワーカー k が自分の listener で受けた接続をそのまま自分の走れる積みへ置く（配りの起こしを通らない）。配分はカーネルの 4-tuple のハッシュで決まる。手元の 12 ワーカー・4096 接続（15 秒の交互）で、毎要求で接続を張り直す負荷は rps +0.6%・p99 104〜109 → 52〜76 ms・p99.9 207〜239 → 143〜156 ms、keep-alive は rps +1.6〜2.2%。計測用の計器を入れた build（接続ごとの rt の固定費が重い形 — 利用者の build の数字ではない）では、毎要求の張り直しの rps が約 3 倍になった（114〜138K → 383〜425K）。accept 専任のワーカーが無くなり、Serve のプログラムのスレッドの数はワーカーの数と同じになった。一斉に到着した接続の最初の要求は、飽和下では待ちの上限 D（既定 100 ms）近くまで待つことがある（D で有界）
- 走れる task の積みをワーカーごとの配列の環にした（4096 枠・溢れは今までの鎖へ）。押し込みと取り出しが他の task の TCB に書かなくなり、飽和下の待ちの上限 D の守りが正確になった。手元の keep-alive 4096 接続で、走れるようになってから走るまでの待ちの最長は 113.7 → 103.0 ms、100 ms を越えて待った task は 1,969 → 14 本。飽和しない負荷の CPU/要求は変わらない
- ワーカーの CPU の固定: Serve のプログラムで、ワーカーの数が許可された CPU の数以下のとき（ワーカーの数を CPU の affinity と cgroup から決める既定の形では常に成り立つ）、ワーカーを許可された CPU へ 1 対 1 で固定する。走れるワーカーが同じ CPU に重なって時間片を待つ形が無くなる。Serve を使わないプログラム（コンパイラ自身を含む）は固定しない。`SOBER_PIN=0` で固定を切れる
- 偽共有の直し: ワーカーが眠る前に全ワーカーの積みの状態を読む道で、持ち主が周ごとに書く語が同じキャッシュ行に乗っていた。持ち主だけの行へ移した。手元の 12 ワーカーで latency-1m の縮小形の CPU/要求 −0.4〜2.4%・keep-alive 4096 接続の rps +2.4%
- JSON の文字列の書き出し: `json.quote` が、エスケープの要らない区間を 16 バイトずつ（SSE2 — 短い文字列は重ねた 2 回の読み）で探す。全部エスケープの要らない文字列は引用符ごと 1 回で積む。手元の 12 ワーカー・4096 接続で json の cycles/要求 −6.9%・json-comp −2.8%

### std

- `builder.PushBetween(b, open, xs, close)`: xs を open と close で挟んで末尾に積む（`Push(b, open)`・`PushAll(b, xs)`・`Push(b, close)` と同じ結果 — 空きの検査は 1 回）
- `http.ServeWith` に省略可の `put:`: 渡すと、受けた切片 1 つ分の応答の列を put で積み、stream の応答だけを send で送る（TLS の接続向け — v0.6.3 の `http.ServeFlushed` の置き換え）
- `net.Listen` / `net.Serve`: 上の破壊的変更と性能の項（SO_REUSEPORT・accept はワーカーごと）

### ランタイム

- 飛行記録（`SOBER_FLIGHT=<path>` — 既定は off）: rt がワーカーごとの環に出来事（accept・spawn・走らせ・fd の待ちと起こし・送り / 受けの頼んだ長さと結果・閉じ・眠り・task の終わり・panic）を固定長で書く。環は <path> の共有写像なので、panic・外からの kill・ハングのどれでもファイルが残り、正常終了では消える。読み手は `scripts/flight.ts`（接続ごとの一生 `--conn <port>`・時刻の前後 `--around`・異常の検出 `--anomaly`）。値札は off で命令 +0.17%・on で cycles +3.3%

### テスト

- 開発用の変異 `--rt-mutant=30`（カオス）: epoll の道の送り・受け・accept に偽の EAGAIN と短い書き / 読みを、眠りに受け皿の縮めと sched_yield を注入する（種は `SOBER_CHAOS_SEED`）。通常の build のコードは変わらない
- `scripts/httpprobe.sh` と workflow httpprobe: 低い確率でしか出ない httpcheck の赤を、1 ワーカーの構成で通常 / カオスを交互に時間の許す限り回して捕まえる網。落ちた回の飛行記録と、クライアントの失敗の理由（cause・接続の手元の port・時刻）を残す

### 文書

- 安全性のガイド（`docs/guide/security.ja.md` / `security.md`）の「守らないもの」に、同じ uid のプロセスとの port の共有（SO_REUSEPORT の性質）を足した

## v0.6.3（2026-10-25）

性能の版。接続の多いサーバで、io_uring の完了の取り込みを小刻みにして多接続の崖を消し、飽和した負荷でも走れるようになった task が待つ時間に上限を置いた。要求ごと・接続ごとのメモリを減らし、TLS の送りと圧縮の符号化を速くした。あわせて std の公開関数が `@effects` の宣言を持つようになり、rt の深度の不変条件の検査が常設になった。

### 性能

- HTTP（bench/httparena — HttpArena の負荷発生器と要求のファイル・GitHub Actions の 64 vCPU でサーバ 32 コア・Go の net/http と比べた自前のハーネスで、HttpArena の公式の結果ではない）: Sober / Go の比は v0.6.1 の run と比べて limited-conn 7.2 → 9.2×・async 1.9 → 2.4×・json-tls 2.3 → 2.8×・json 3.1 → 3.4×・baseline 3.0 → 3.2×・pipelined 16 → 15.9×・json-comp 1.3 → 1.8×。latency-500k-8cpu と latency-1m は目標の速さを保つ（p99 0.37 ms / 0.21 ms）。non-2xx は全種目で 0
- 完了の取り込み（net の ring）: 今までは走れる task が尽きたときだけ io_uring に入って完了をまとめて取り込んでいたので、接続が多いと 1 回に取り込む束が深くなり、作業集合がキャッシュから溢れていた。未提出の SQE が 8 本溜まったら、眠らずに提出・取り込み・タイマーの満了を済ませ、取り込んだ task は熱いうちに先に走る。そのままでは飽和した負荷で古い起こしが積みの底に沈んで秒単位で走らない接続が出るので、**走れるようになった task は飽和下でも待ちの上限 D（既定 100 ms — 下の `maxWait:`）以内に走る**ようにした（底から 1 本ずつ拾う）。手元の 12 ワーカーで keep-alive 4096 接続の要求あたりの cycles は 2.3 分の 1（256 接続の 2.5 倍あった崖が消えた）で、全接続を D 以内に回したまま、頭の取り込みを外した公平な形より rps +17%・async 24000 接続の CPU/要求 −7〜9%。飽和下の p99 ≈ D（既定 100 ms）は設計 — 全接続が D 以内に回る（直前に動いた接続を熱いうちに回し、待ちが D に達した接続を拾う）。飽和しない負荷では上限の簿記の分だけ CPU/要求が +3% 前後
- メモリ:
  - 戻り値へ流れるだけの関数（自分の region に積むものが全部戻り値から辿れる関数）は region に入らず、呼び手の region へ直に積む。std/http の Dispatch を含め、要求ごとの region の深度が減る。async 24000 接続の VmHWM −21 MB（−5%）
  - 小さいスロットのワーカーごとの手元の列の上限と、受けのバッファの環（PBUF_RING）のスロットの数を、ワーカー数で割る。ワーカーが多いほど寝かせておく予備が増えていた分を減らす。async 24000 接続の VmHWM は 12 ワーカーで約 −20 MB・24 ワーカーで約 −44 MB。受けの環が小さく熱くなり、64 KiB の POST の echo は cycles −11%
  - task が待ちに入るとき、使っていない深い region のスロットを手放し、起きたときに取り直す。送りの待ちの間に空のスロットを抱えなくなり、async 24000 接続の cycles/要求 −11%・RSS −19%・json-tls 4096 接続の cycles/要求 −4%
- TLS:
  - 送りを 2 段にした（`tls.Put` = record に暗号化して束に積む・`tls.Flush` = 送る。`tls.Send` は今までどおり Put + Flush）。`tls.Recv` の受けの口は受けた切片 1 つ分を配り終えるたびに Flush する。送りの待ちで応答の作業域を抱えなくなり、json-tls 4096 接続で働く接続 1 本あたりのメモリ −23%・cycles/要求 −9%・rps +7%
  - 送りの鍵の展開を接続に 1 回に（record ごとの鍵の素材の写しが消える）・AES-GCM の record 1 つの作業域を 1 本に（tag の計算を AES の塊の中へ）。json-tls の cycles/要求 −4% 前後
- 圧縮（flate / gzip）:
  - level 4〜6（`http.Gzip{}` の既定 6 を含む）で、長い一致の中の位置をハッシュ鎖に足さない。lv6 の符号化は json の本文で 24〜29% 速く、json-comp の形のサーバの応答は手元で +23%。代わりに圧縮率はわずかに下がる（json の本文で +1% 前後・短い一致が主の入力で +10% 前後）。率を優先するなら level 7 以上（今までと同じ探し方）を選ぶ
  - 一致の長さの比較を 16 バイトずつ（SSE2）に。符号化は json の本文で 6〜9% 速く（level 3〜9）、json-comp のサーバの cycles/要求 −5.9%
  - 符号化ごと・ブロックごとの固定費を減らした（符号の表をその都度組み立てない・符号長を決めるソートを頻度の数え上げに）。符号化の命令 −8〜13%・json-comp のサーバの cycles/要求 −7.5〜8.4%。出力のバイト列は変わらない
- x86 の最適化のバックエンド: 定数（非冪）での `/` と `%` を乗算に置き換える・短いメモリの写し（32 バイト以下）を重ねた読み書き 2 本で済ませる。json の数の書き出しと応答の組み立てが速くなり、json / json-tls の 256 接続で cycles/要求 −4〜5%
- `net.Listen` が listener に TCP_NODELAY を付ける（受けた接続へ継承する）。小さい応答が Nagle のアルゴリズムで待たされない

### std

- 本体のある std の公開関数は全部 `@effects` の宣言を持つ（`docs/std` にも出る）。宣言は導出と一致することを stage2 が建つときに照合する
- `net.Serve(…, maxWait:)` / `tls.Serve(…, maxWait:)`: 飽和下の待ちの上限 D の宣言（既定 100 ms）。接続の task とその子は、走れるようになってから D 以内に走る（同じワーカーに違う D の task が混ざると、上限は混ざった中の最大）。飽和しない負荷では効かない
- `task.Ledger()` に `maxWait`（走れるようになってから走るまでの待ちの最大 — ns・読むと 0 に戻る）と `aged`（上限が効いた回数 = 飽和の印）。運用での読み: aged が増えていれば飽和・maxWait が D を大きく越えていれば異常
- `http.ServeFlushed`: ServeWith の送りを 2 段にした形（受けた切片 1 つ分の応答を put で積み、まとめて送る — TLS の接続向け）。`tls.Put` / `tls.Flush`（上の TLS の項）
- `binary.MatchLen(b, i, j, n)`: b[i:i+n] と b[j:j+n] の先頭からの一致の長さ。秘密の値を渡すと analyzer が拒否する（比較は可変時間）
- `builder.PushWord(b, w, k)`: 語 w の下の k バイトを下のバイトから積む（`Push` と `w >>= 8` を k 回と同じ結果）

### ツール

- `sober fix --effects --std <dir>`: 焼き込みの std を読んで、宣言の要る公開関数に導出した `@effects` を書く（std の保守向け）

### ランタイム

- rt の深度の不変条件（task が深度を飛ばして region に入らない）の検査を常設にした。v0.6.2 で直した類の穴は、黙った値の誤りでなく `panic: RegionDepthSkipped{} (runtime invariant broken in rt.slot_new — please report)` と終了コード 81 の定義された死になる。値札は計測の揺れの内

### 文書

- 安全性のガイド（`docs/guide/security.ja.md` / `security.md`）: 言語と std が防ぐもの・防がないもの・利用者の手番を 12 節で。冒頭に「成立しない / 定義された死に変わる / 残る」の 3 分類の早見表と、実世界の脆弱性（Node.js の Brotli 展開の境界外書き込み）を Sober で書いたときの帰結。コード例は `examples/security_*` の実物
- 公開 README のベンチの数字とグラフを GitHub Actions の 16 vCPU（AMD EPYC 9V45）で取り直した。物差しは手元の cycles から CPU 時間（task-clock — 同じ周の対の比の中央）に変わった。同じ木の 2 run で 26 本の比のうち 21 本は ±3% 以内・勝敗の分類は全部一致。1BRC・binary-trees・logagg の 3 題材は日ごとに ±10%、外部ソートと k-nucleotide の対 Rust は ±3〜4% 動くので、`bench/README.md` にその注を付けた

## v0.6.2（2026-10-23）

v0.6.1 の hotfix。あわせて analyzer に関数の効果の最初の部分が入った。

### 言語

- 関数の効果 `@effects`（`sober check` が見る — build の受理は変えない）: analyzer は各関数の効果を呼び先から導出する。語彙は `block`（待ちに入りうる — task の待ち・チャネルの操作）・`io`（プロセスの外と出入りする）・`panic`（明示の `panic(…)`）・`nondet`（入力を固定しても揺れる値 — 時刻・タイミング）。宣言は導出への主張で、関数の前置 `@effects(io)` / `@effects(!block)` と名前付き関数型の後置 `type F func(…) R @effects(…)` に書く。列挙は全部が正か全部が否定で、`@effects()` は効果なし。導出が宣言の外の効果を持てば宣言の位置で拒否し、持ち込んだ最初の呼び出しを名指す。名前付き関数型の値はその型の契約と照合する。宣言は今は任意
- `sober check <entry> --effects-dump` で導出した効果を印字する

### ツール

- `sober fix [--effects] [--errors] <entry>`: 宣言の無い公開関数に、導出した `@effects` / `@errors` の宣言を書く。語だけの列挙が導出より広ければ縮める。否定形・関数型の名前を含む列挙・内部関数・導出が宣言を越えるものは触らない

### analyzer

- lease の窓の性能の lint は、自前の判定でなく導出した効果（`block`）を使う。関数値を通した待ちも見えるので、警告の出方が変わりうる

### 修理

- std/task を 2 つ以上のワーカーで走らせ、io_uring が使える構成（多コアの機械の既定 — Docker の既定の seccomp のように io_uring を塞ぐ環境は除く）で、`main` 以外の task が `io.ReadFile` を呼んで読みが待ちに入ると、rt がまだ使っている region を手放し、2 つの task が同じメモリを共有しうる穴を塞いだ。症状は黙った値の誤りか予期しない panic。v0.6.1 で入った穴

### テスト

- ゲート `scripts/nextgen.sh` を新設: 今の rt（rt の不変条件の検査つき）でコンパイラを建て、その自己の並列の build / check をワーカー 1・2・8 で回す。rt の変更を、ブートストラップの段に入る前にコンパイラ自身で通す

## v0.6.1（2026-10-23）

Web の版の続き: HTTP の口が静的ファイル・条件付き GET・chunked と SSE・multipart・圧縮つきの stream まで広がり、std にエンコーディングと復号の部品が入った。analyzer には effect の面の最初の 3 つ（関数型の `@errors`・秘密の値の流れ `@secret`・認証由来の応答と共有キャッシュの出会い）が入った。接続の多いサーバのメモリとアドレス空間の使い方を直し、48000 同時接続で死んでいた形が消えた。

### 言語

- 型の別名 `type A = B`: A は B と同じ型の別の名前で、どこでも区別しない（代入・型引数・閉包・lease）。右辺は型宣言の名前 1 つ（`N` / `ref.N`）。組み込みの型・合成の型・型引数つきの名前は置けない。総称の型の別名は、使う側で型引数を書く（`type Box = lib.Box` → `Box[int]`）。欄の書き・封の型などの「どの package の型か」は実体の宣言で決まる
- 借りの閉包の mut 捕捉: 値の呼び出しの借りの位置に置いたラムダ（`st((p) => …)` の形）は mut の束縛（mut のローカル・mut の仮引数）を捕捉できる。捕捉は写しでなく束縛そのもので、寿命は呼び出しの内側に限る。1 つの呼び出しの借りのラムダが捕捉する mut の束縛は、合わせて 1 つまで。値の位置の閉包（逃げうる側）は今までどおり拒否する
- `@errors` を名前付きの関数型に後置できる: `type Stream func(…) error? @errors(emit, io.NotFound, …)`。その型の値になるラムダは、宣言の外のラベルを返すと拒否される。関数型の値の呼び出しの失敗の集合は宣言から導出する
- `@exhaustive`: 付けた関数の中の switch は、subject の閉じた集合（union の全 variant・1 つの package の error のラベル・named scalar の型つきの const）を全部 case に名指す。欠けは名指して拒否する（check だけ）
- 型つきの const: `const OK = Status(200)` は型 `Status` を持つ
- `@secret`（check だけ — build の受理は変えない）: 仮引数・struct の欄・const を秘密の源と宣言すると、analyzer は秘密の値が分岐の条件・添字・除算に届く形を拒否する。std/crypto と std/tls の鍵の材料には印が付き、生成した機械語に秘密依存の分岐が無いことはゲート（ctcheck）と定数時間の統計の計測（dudect）が見る
- 出所の検査（check だけ）: 認証由来の値（`http.Authorization` / `http.Cookie` とその上に組んだ値）が、共有キャッシュに置かれうる応答（`http.Cache` の共有の方針）と出会う形を拒否する
- mut の仮引数を持たない関数が mut の値（mut の slice / map を含む型）を返す形は、build も check と同じ文面で拒否する（今までは build だけ通っていた）
- `io.Root`・`net.Listener`・`net.Conn`・`tls.Conn` のゼロ値（`io.Root{}` など）は拒否する。今までは fd 0 を指す偽物が作れた
- 関数でない宣言（type / const）に付けた前置の `@errors` は文法の誤りになった。今までは黙って捨てていた

### 標準ライブラリ

- net / tls: `net.Serve` / `tls.Serve` に名前付き引数 `region:`。接続の task の region 1 つあたりの上限で、既定は 128 MiB。超えた接続はその task だけが死に、Serve が吸収する（`task.Ledger()` の died に数える）。接続ごとに確保するアドレス空間が 1/4 になり、48000 同時接続で `RegionExceeded{cause: va_exhausted}` で死んでいた形が消えた（下の「修理」）
- http — 静的ファイル: `http.Static(prefix, root, precompressed:, cache:)`。根の外へは出ない（カーネルの保証 — 下の io）。`precompressed:` は `.br` / `.gz` の変種を Accept-Encoding で選んで素通しする。弱い ETag・Last-Modified・前提条件（If-Match / If-None-Match / If-Modified-Since / If-Unmodified-Since → 304 / 412）に対応した
- http — キャッシュの方針: `Response.cache` / `Route.cache`（`http.Cache` = `Revalidate` / `Fresh{maxAge, immutable}` / `Private{maxAge}` / `NoStore`）。方針の無い応答は `Cache-Control: private`
- http — 応答の枠: 長さの分からない stream の応答（`Response.length` は `int?` に — nil = 長さ不定）は HTTP/1.1 では `Transfer-Encoding: chunked` で送る。HTTP/1.0 の要求には `Connection: close` で閉じて区切る
- http — 圧縮つきの stream: `Response{stream:}` も `compress:` の対象になる。受ける要求には gzip の chunked で、受けない要求には平文の chunked と `Vary` で返す
- http — SSE: `http.Event` / `http.FormatEvent`。data の改行は行に割り、event / id の改行は panic（`BadEvent`）にする。`text/event-stream` は圧縮しない
- http — `http.Multipart(r)`（multipart/form-data — RFC 7578）・`http.Authorization(r)`・`http.Cookie(r, name)`・`http.StatusCode` 型と型つきの const（`http.OK` …）
- io: `io.OpenRoot` / `io.CloseRoot` / `io.OpenUnder`（openat2 + RESOLVE_BENEATH — `..`・絶対パス・外を指す symlink はカーネルが拒否する）、`io.Stat`（size・modTime・kind）
- compress: `flate.Decode` / `gzip.Decode`（`maxSize:` で展開爆弾を封じる）
- base64（新設 — 標準 / URL 安全の字母・厳格な復号）・url（新設 — `Escape` / `Unescape` / `ParseQuery`）
- strings: `Split` / `Fields` / `TrimSpace` / `TrimSuffix` / `ToLower` / `ToUpper` / `EqualFold` / `Replace` / `LastIndex`（Go に揃えた署名・空白と大小は ASCII だけ）。convert: `ParseBool` / `FormatBool`
- crypto: `SealTo` に位置引数 `tail` を足した（平文 = pt ‖ tail — aesgcm / chacha20poly1305。写し 1 回を省く口）
- コンテナの init（PID 1）として走るときだけ、SIGTERM / SIGINT で exit 143 / 130 で止まる。今までは `docker stop` / `podman stop` の猶予の後に SIGKILL されていた。tini / `--init` は要らない

### 破壊的変更

- `http.Response.status` と `http.Status(code)` は `http.StatusCode` 型に（整数のリテラルは今までどおり書ける）
- `http.Response.length` は `int?` に（nil = 長さ不定 → chunked）
- `crypto` の `SealTo(…)` は最後に `tail` を取る（無ければ `[]byte{}`）
- 任意ヘッダの `Cache-Control`・`CDN-Cache-Control`・`Surrogate-Control`・`ETag`・`Last-Modified` は panic（`BadHeader`）にする。方針は `cache:` で書く（ETag / Last-Modified は `http.Static` が付ける）
- `http.Header(r, …)` は `Authorization`・`Proxy-Authorization`・`Cookie` に nil を返す。`http.Authorization` / `http.Cookie` を使う
- 方針の無い応答に `Cache-Control: private` が付く（404 / 405 / 誤りも）
- 1xx・204・304 の応答に `Content-Length` を書かない（RFC 9110 8.6 — 204 の `Content-Length: 0` は違反だった）
- 上の「言語」の 3 つの拒否（mut を返す形・同一性の型のゼロ値・関数でない宣言の `@errors`）
- `compress:` の level 6（既定）の出力のバイト列が変わる（lazy の閾値 16 → 12 — 圧縮率は zlib と同等の線の中）

### 性能

- HTTP（bench/httparena — HttpArena の負荷発生器と要求のファイル・GitHub Actions の 64 vCPU でサーバ 32 コア・Go の net/http と比べた自前のハーネスで、HttpArena の公式の結果ではない）: Sober / Go の比は baseline 3.0×・pipelined 16×・limited-conn 7.2×・json 3.1×・json-tls 2.3×・json-comp 1.3×・async 1.9×。latency-500k-8cpu は 50 万 req/s の目標を保ち p99 0.28 ms（Go は速さに遅れて p99 が秒に伸びる）。latency-1m は 99.8 万 req/s で p99 0.13 ms。non-2xx は全種目で 0
- メモリ: サーバの RSS は、この版の開発の途中（下の 2 つの直しの前）の run と比べて baseline 321 → 140 MB・latency-10k 254 → 89 MB・json-comp 432 → 191 MB・json-tls 637 → 388 MB・async 898 → 814 MB。主に 2 つの直しによる
  - 透過的 huge page が always の箱で、region の頁を huge page にしない
  - 待ちに入った task が、死んだ深度の region を手放す
- 接続数: async（32000 接続）は 5 周を通してエラー・再接続 0。手元で 48000 接続も再接続 0（以前は va_exhausted で死んだ）
- タイマー: `os.Sleep` の待ちを、ワーカーごとの時計の表（io_uring に 1 件ずつ積まない）で管理する。async の Go 比が 1.7× → 1.9×（GHA の前後の run）・手元の async で CPU/要求 −13〜16%・16000 接続で rps +17%
- コンパイラ: 間接呼び出しの結果の受け皿の穴（関数値の呼び出しが余計な零初期化を払っていた — 手元の HTTP の keep-alive で cycles −5〜6%）、フレームのスロットと spill の枠の彩色、戻らない呼び出しの終端化、deflate の level 6 の調整（json-comp の命令 −5%）など
- HTTP の要求の頭を 1 回だけなめる・応答の頭の早道・Accept-Encoding を読むのは圧縮しうる応答のときだけ

### 修理

- 48000 同時接続の `RegionExceeded{cause: va_exhausted}`（接続ごとのアドレス空間 — 上の `region:`）
- コンテナの PID 1 として SIGTERM で止まらなかった（上）
- 204 の応答に `Content-Length: 0` を書いていた
- `sober check` と `sober build` の食い違い 5 形（片方だけが受理していた形 — `T?` を期待する位置の if の腕・nil 判定で絞った値を捕捉する閉包・ブロック本体のラムダの末尾の nil・値の位置の閉包の `g(x)?`・mut を返す形）
- `sober check std/<pkg> --test` がテストの本体を検査していなかった
- std/tls と std/crypto の定数時間の 3 か所（x25519 の全 0 の検査を定数時間の比べへ・record の 0 埋めの長い道の早期脱出・RSA-PSS の自己検証）。どれも `@secret` の検査が見つけた

### 配布

- タグごとに ghcr.io/sober-lang/sober のツールチェーンのイメージを publish する（alpine + sober・リリースの tarball と byte 同一）。`FROM ghcr.io/sober-lang/sober:0.6.1` で build できる

## v0.6.0（2026-10-20）

Web の版: ネットワーク・HTTP/1.1 のサーバ・TLS 1.3 とその下の暗号が、Sober で書いた std に入った。言語には閉包が入り、std の API は命名の総再審を通った（破壊的変更 — 下の「改名」）。言語仕様は規則として書き起こし（docs/spec）、std のリファレンスはソースから生成する。

### 言語

- 閉包: 値の位置 — 名前つき関数型の仮引数・結果、struct の関数型の欄、その option `F?` — に置いたラムダは閉包になる。作成点の imm の値を写して捕捉し、実引数・結果・欄として関数の境界を越えられる。mut の束縛と同一性の型（task の scope と handle・チャネルの端点・`net.Conn` など）の捕捉は拒否し、本体に `return` は書けない（作った関数より長く生きうる）。匿名の関数型の仮引数は従来どおり展開する（生成コードは変わらない）
- 借りの関数型仮引数: `type Stream func(emit func([]byte) error?) error?` のような名前つき関数型の匿名の関数型の仮引数（`emit`）は借り。呼ぶ・別の借りの位置へ渡す・展開されるラムダや for の本体に捕捉する、だけができ、束縛・格納・return・閉包や子 task への捕捉は拒否する。借りの位置のラムダは `net.Conn` などの同一性の型を捕捉してよい
- 関数型の値が `error?` を返せる（`func(net.Conn) error?`）。`f(x)?` が使え、関数型の期待の位置に名前つきの関数を渡せる
- 関数型の仮引数の呼び出しで for を回せる: `for b <- recv(k)? { … }`
- `@errors` に関数型の仮引数の名前を書ける（`@errors(Bad, recv, send)`）— その仮引数の失敗のラベルは呼び出し点ごとに実引数から取る
- `std/internal/…` の package は std の中からだけ import できる
- analyzer の初めての警告（受理は変えない）: lease の窓の中の待ち・同じ `task.Local` の窓の入れ子
- 位置も理由も出ていなかった拒否 3 形（string の値の switch・`T?` と値の比較・実引数の数の不一致）に何が誤りかの文面

### 標準ライブラリ

- net（新設）: `Listen` / `Accept` / `Dial` / `Recv` / `Send` / `Port` — 抜けたら閉じる for の生成元。`net.Serve(l, handle, budget:, conns:, reject:)` は接続 1 本に task 1 本で、接続の失敗と死を吸収し、上限を超えた接続には利用者のコードを走らせずに `reject:` のバイト列を返す。rt はワーカーごとの io_uring（multishot の accept / recv と provided buffers — カーネル ≥ 6.1）を使い、io_uring が使えなければ自動で epoll に倒れる。出力は backend に依らない
- http（新設）: HTTP/1.1 のサーバ — `http.ServeConn(c, route, maxHead:, maxBody:, compress:, work:)`（keep-alive とパイプライン・chunked の要求本文・413 / 431 の上限）。ルーターは平らな表（`[]http.Route` と `Mount` / `Merge` / `Dispatch` / `Param` — 優先順は表の並びに依らず 静的 > `:param` > `*rest`・405 と `Allow`）と before / after のミドルウェア。応答のヘッダ・`Form`・`JsonDoc`・本文のストリーム（長さ既知の `Response{stream: …}`）・gzip の応答（`compress: http.Gzip{level: …}`・`Vary`・`Accept-Encoding`）。`http.ServeWith(recv, send, …)` は任意の転送路の上で動く（TLS はこれを使う）
- tls（新設）: TLS 1.3 のサーバ — `tls.Serve(addr, cfg, k)` は handshake を終えた接続だけを `k` に渡す。PEM の証明書と鍵の `tls.Load` / `tls.Parse`・ALPN。X25519・AES-128-GCM と ChaCha20-Poly1305・RSA-PSS の証明書。`tls.Recv` / `tls.Send` は net と同じ形。エラーは `tls.HandshakeFailed` / `tls.BadRecord` / `tls.Closed`。サーバ側のみ・resumption と 0-RTT なし
- crypto（新設）: SHA-256・HMAC-SHA256・HKDF-SHA256・ChaCha20・Poly1305・ChaCha20-Poly1305・AES-128-GCM（AES-NI + PCLMULQDQ）・X25519・RSA-PSS の署名と検証（MULX / ADX の Montgomery 乗算）・PKCS#8 の DER と PEM・定数時間の部品（`crypto.Equal` / `Select` / `Wipe`）と OS の乱数。RFC と Wycheproof のベクタで照合し、秘密に依る分岐が無いことをゲートが検査する
- compress/flate・compress/gzip・hash/crc32（新設）: deflate の level 0〜9（zlib と同じ設定・動的 Huffman・圧縮率は zlib と同等）・gzip の枠・PCLMULQDQ の道つきの CRC-32
- binary（新設）: `binary.Load64` — 範囲の検査 1 回の 8 バイトの little-endian の読み
- pool: `pool.Scratch` — 世代印つきの固定容量の作業域（ワーカー局所の lease と組む）
- io: 期限切れを独立のラベル `io.Expired` に（以前は `io.Timeout`）
- os: `os.Sleep` は task のプログラムではワーカーを譲り、scope の期限で早く返る。`os.SleepExpired` は早く返ったかを返す

### 並行（std/task）

- 期限: `task.Run(body, deadline: 500 * task.MS)` は scope の相対の期限で、子孫が継ぐ（入れ子は早い方）。期限は待ちの上限で計算の上限ではない — 期限の後の io の口は `io.Expired` を返し、ネットワークの待ちは切れる
- `task.Run(body, wait: true)`: 予算に入らない直接の子は逐次に走らず、空くまで待つ
- 予算に入らず逐次に走る子も台帳に数える。`task.Ledger()` はプールごとの失敗と死の数を返し、`task.MarkFailed(pool)` は境界の失敗を数える
- ワーカー局所の lease: `task.NewLocal` / `task.Lease` は窓の中でワーカーごとの作業域を貸す。窓のたびに新しい値なので使い回しは観測に出ない。接続ごとのメモリを接続の数に依らなくする（http の gzip の作業域）
- task が死ぬと、その下で io を待つ子孫の待ちは `io.Expired` で切れる（期限の無い scope の下では永遠に眠りえた）
- handle を捨てた子（`_ = task.Spawn(…)`）は、返らない scope（`net.Serve` の accept のループなど）にメモリを残さない
- 子 task の region のスロットの大きさは task ごと: `budget:` の無い子は 512 MiB・宣言のある子は宣言以上の 2 の冪（main は `SOBER_REGION_MB` のまま）。`budget:` の無い子が region 1 つにそれを超えて積むと `RegionExceeded{cause: slot_capacity}` で死ぬ — 大きい作業域には `budget:` を書く。アドレス空間の枯渇は `RegionExceeded{cause: va_exhausted}`（以前は `slot_capacity` の誤名乗り）。これで `net.Serve` が 16k の同時接続を持てる

### 改名（API の総再審 — 旧名は残さない）

0.6.0 の API の総再審で、略語と仮決めの名前を命名規則（language.md 34 節）に揃えた。旧名は非推奨にせず消した:

| package | 旧名 | 新名 |
|---|---|---|
| json | `Value` の variant `Num` / `Str` / `Arr` | `Number` / `String` / `Array` |
| json | `DupKey`（`InvalidJson` の種類） | `DuplicateKey` |
| json | `DecString` / `DecBool` / `DecInt` / `DecFloat` | `ParseString` / `ParseBool` / `ParseInt` / `ParseFloat` |
| json | `Object`（関数）/ `Value` の variant `Obj` | `NeedObject` / `Object` |
| builder | `PushStr` | `PushString` |
| compress/flate | `Prep` | `Prepare` |
| http | `Request.hdrs` / `Response.hdrs`（欄） | `headers` |
| http | `Response.ctype`（欄） | `contentType` |
| http | `Route.h` / `Route.mw`（欄） | `handler` / `middleware` |
| os | `SleepCut` | `SleepExpired` |
| crypto | `Eq` | `Equal` |
| crypto/pem | `Decode` | `Parse` |
| hex | `Encode` / `Decode` | `Format` / `Parse` |
| strings | `FormatInt` | `convert.FormatInt`（std/convert へ移動 — 数と文字列の変換は convert） |
| utf8 | `Valid` / `IndexInvalid` / `InvalidUtf8`（誤りのラベル） | `strings.Valid` / `strings.IndexInvalid` / `strings.InvalidUtf8`（文字列の妥当性は strings） |
| utf8 | `Parse` | 削除 — `string(b)` を書く（裏方は std の実装の詳細へ） |
| std/floatfmt（package） | `floatfmt.…` | 削除 — `std/convert` の `FormatFloat` / `FormatFixed` / `ParseFloat` と `std/math` の `Bits` / `FromBits` を使う |
| std/conv（package） | `conv.…` | `std/convert` — `convert.…` |
| std/par（package） | `par.…` | `std/task` — `task.…`。中の改名: `Scope`（関数）→ `Run`・`S`（型）→ `Scope`・`Task[T]` → `Handle[T]`・`Tx` / `Rx` → `Sender` / `Receiver`・`NewChan` → `NewChannel`・`TaskDied` → `ChildDied`・`Fail` → `MarkFailed`・`LeaseBlk` → `LeaseBlock`（他は同じ名前） |

意図して片方だけの対（`OpenTo` の無い `SealTo` 等）は、関数を足さずに宣言の注記で断る形にした。

`std/internal/…` の package は std の実装の詳細になり、std の外のファイルからは import できない（std/floatfmt・`string(b)` の裏方・tls の handshake の状態機械 std/tls/hs〔→ std/internal/hs〕はここへ移った）。std/utf8 は検査済みの見方（`Check` / `View` / `Str` / `Bytes`）の package として残る。

### その他の破壊的変更

- 期限切れは `io.Expired` で、`io.Timeout` ではなくなった（タイムアウトをまとめて扱っていたなら両方を受ける）
- `sober build -o <path>` は `<path>.tmp` に書いてから rename で置く（`go build -o` と同じ）: 出力の inode は毎回新しくなり、ハードリンクは切れ、前のファイルの所有者とモードは引き継がない
- `budget:` の無い子 task は region 1 つ 512 MiB まで（上記）

### ドキュメント

- docs/spec: 言語仕様を規則として — 13 章・165 規則。各規則は examples/ の受理例・拒否例にリンクし、ゲートがそれを走らせる（現在は日本語のみ）
- docs/std: std の全 package のリファレンスをソースの doc コメントから生成。ゲートがソースとの一致を照合し、doc コメントを lint する（現在は日本語のみ）

### 性能

- HTTP: bench/httparena のハーネス（HttpArena の負荷生成器と要求のファイル・GitHub Actions で両サーバとも 32 vCPU・Go の net/http と比較）で、走らせている全種目で勝ちか同等 — baseline 2.8×・pipelined 15×・limited-conn 7.3×・json-comp 1.3×・json-tls 1.6×・async 1.6×。8gbit はレートの上限で同等・CPU は 2.6 分の 1。latency-1m は 1M req/s の目標のうち 998K を保ち p99 0.16 ms（Go はレートについていけず p99 が秒の桁になる）。これは自前のハーネスの数字で、HttpArena の公式の結果ではない
- 暗号: RSA-2048 の PSS 署名は 1,200 万命令（最初の版の 2.2 億命令から）で Go の crypto/rsa と同水準。AES-128-GCM は record 層で約 2.6 命令/バイト。X25519 は最初の版の 7 倍速い
- コンパイラ（ベンチ一式・2026-10-19 の公式計測 — README のグラフ）: メモリ — revcomp の RSS 48.6 → 24.4 MB（Rust 以下に）・knucleotide 75.6 → 52.7 MB（Rust との差 2 MB 以内）。速さ — 語単位の読みと写し・部分インラインの拡大・戻らない関数のまわりの region の扱いの軽量化。対 Rust で逐次 9 題材のうち 7 つが 1.03× 以下、nbody 1.17×・revcomp 1.48×（比が計測の窓で大きく動く題材）。Web 系の jsonapi / routing / logagg は 1.22× / 1.13× / 1.16×
- 自己 build: 関数ごとの仕事の多くを並列の lower の段へ移し、loader のファイルごとの検査を並列にした

### 修正

- ループの中の展開される呼び出し（mut か関数型の仮引数を持つ関数）の結果を外の region に作り、反復ごとに積もっていたメモリの漏れを直した。同じ種類の漏れ 2 件を全数検査で見つけて直した
- 呼び手の深度から算術で作る region の深度を持つ関数で region.enter を消していた誤コンパイルを直した
- ループの中で作ったチャネルの記録を反復の region に置き、上書きしていたのを直した
- `sober check` と `sober build` の判定が割れる（片方が受理し片方が拒否する）形をいくつか直した

## v0.5.4（2026-10-14）

### 言語

- 失敗しうる for: 失敗しうる生成元の呼び出しで for を回せる（`for chunk <- io.Chunks(f)? { … }`）— 失敗は for 自身が返す
- scope のエラー: par の scope の本体の中の `?` は失敗を scope の失敗として記録する。出口では回収されていない子のエラーが優先する
- 部分リテラル: `T{a: 1}` は名前で一部の欄を書き、残りをゼロ値で埋める。封印された型（と、推移的に同一性の型）の欄は対象外 — 証人を偽造させない。`panic` のラベルも同じ規則
- 同一性の型のゼロ値は拒否する（欄を通した推移も含む）
- 破壊的変更: `ReadFd` / `SetFd` を消した — 標準ストリームは値 `io.Stdin` / `io.Stdout` / `io.Stderr`（差し替えは `io.SetFile`）。`EntryKind` の `File` は `Regular` に改名
- 暗黙の freeze が for の生成元にも掛かる

### 標準ライブラリ

- io: 開いたファイル（`Open` / `Close` / `ReadAll`）とゼロコピーのストリームの読み — `for c <- io.Chunks(f)? { … }` は反復ごとに見方を貸す（`Lines` / `Bytes` / `Raw`・`ChunksAt` はオフセットから読む）。400 MB のファイルを RSS 420 KB で走査する。rt はファイルの読み書きを io_uring で出すようになった（ワーカーごとに ring 1 本・暇なワーカーは ring で眠る）
- sort（新設）: `sort.Order(n, less)` は安定な順の添字を返す。`sort.OrderUnstable` は決定的な不安定版（pdqsort 級・乱数なし — 同じ入力なら同じ順。ゲートが検査する）
- json: decode と encode を速くした（下）

### 性能

v0.5.3 から、対 Rust の jsonapi の cycles −15%。見出しはメモリ: routing の RSS 110.9 → 16.2 MB・jsonapi 33.7 → 26.2 MB（両方 Rust の双子以下）・knucleotide 88.5 → 75.6 MB・1brc 134 → 0.6 MB（この題材は素の `io.Chunks` のループに書き直した — cycles +5% は書き直しの正直な値札）。それ以外のベンチマークのコードは変えていない:

- region の軽量化のループ本体の範囲のバグを直した: 内側のループで走査が止まり、外側のループの反復ごとの region の enter を誤って省いて、反復ごとの値が関数の region に漏れていた。約束（「ループの本体は scope」）を戻したのが routing / jsonapi の RSS の回復の正体。logagg はその代わりに命令 +0.4%
- 一括の写しの認識: 要素を append するループ・範囲の写し・`io.Writer` への範囲の書き・定数で埋めるループを、1 回の伸長 + 写し / 埋めに下ろす
- map の伸長は、索引が region の先端にあれば確保の位置を巻き戻し、死んだ索引の世代を積まない（knucleotide の RSS −11 MB・logagg の cycles −8%）
- json: 重複キーの検査と欄の引きはバイト列を直接比べ、int は出力へ直に書き、Encode は型ごとに特殊化してエスケープ済みの定数のキーの片を使う
- 新しいベンチマーク: 外部ソート（bench/extsort）— 版の間に wall が Rust の 2.33× → 1.7×・RSS は 256 MiB〜4 GiB の入力で 177 MB で平ら（Rust 180 MB・Go 500 MB）
- README のベンチマークの数字は `bench/data/official.tsv` から生成し、ゲートで照合するようになった（計測と文の乖離がもう出ない）

## v0.5.3（2026-10-12）

### 性能

対 Rust の cycles 比で v0.5.2 から routing −23%・knucleotide −18%・logagg −13%・jsonapi −10%・nbody −7%・1brc −6%。ベンチマークのコードは変えていない（全部コンパイラの改善）。逐次 9 題材の対 Rust は勝ち 5・互角 2・負け 2 に:

- packed f64 と SLP の束ね: 隣り合う 2 語への同じ形の浮動小数点の演算を SSE2 の packed 命令 1 本にまとめる（木の形をそのまま写すので演算の結合の順は変わらない）。境界検査の消去と合わせて nbody の命令 −33%・cycles −7%
- 境界検査の消去を広げた: 大きい定数添字の検査が通っていれば小さい定数添字の検査を省く。定数添字の検査が多数並ぶ関数は、入口の 1 回の判定で検査なしの版と元の版に分ける（範囲外のときは元の版がそのまま走るので、panic の位置と出力は変わらない）
- ループの region の要約の修正: ループの中の呼び出しを数え違えて region の出入りを省けていなかった形を直した（routing の cycles −16%）
- mut slice の仮引数のヘッダ（番地・長さ）をループの外へ出し、region の確保の上限の計算もループの外へ出した（ループの中の append 1 回ごとに数命令が消える）
- 写しの転送: 写した直後の読みを写し元から読むようにして、使われなくなった写しを消す
- インライン展開の後の定数の分岐の畳み
- レジスタ割り当て: ループを跨いで運ばれる値の生存区間を細かく切り、溢れたときの追い出しの対象を選び直した（写しの往復の削減）
- 命令選択の小さい改善（定数倍の 3 番地形の imul・可換の演算の被演算子の入れ替え・書いた直後の読み直しの省略）。struct を返す呼び出しの結果の置き場を他の呼び出しと共用しないようにした（共用するとインライン展開の後もレジスタへ昇格できなかった）
- 退行: mandelbrot の cycles +3.6%（命令は −8%）。ループの戻り辺の写しを消した形が、この題材では遅く走る

## v0.5.2（2026-10-11）

### 言語

- 組み込み clone(x) を追加: slice / map の浅い写しを mut で返す（freeze の双対 — 「読むだけのつもりで渡したら凍った」の直し方）。Lean の型付け規則と健全性の証明ごと入れた
- 欄の私有（健全性の修理・非互換の変更）: 他の package で宣言された struct の欄は、外からは書けない（代入・添字や map への格納・delete・mut 渡し）。mut の中身を持つ欄は外からは読めない。型の不変条件（utf8.View の封・std/table の内部など）を外から壊せた穴を閉じた
- freeze の一意性の規則の取りこぼしを修理: `freeze(if …)` / `freeze(append(…))` の後の書き・par の子が imm の束縛越しに mut のコンテナを捕獲する形を拒否するようになった

### 性能

対 Rust の cycles 比で v0.5.1 から routing −48%・jsonapi −31%・knucleotide −17%・logagg −14%。ベンチマークのコードは変えていない（全部コンパイラの改善）:

- 関数入口のスロット零初期化を、読む前に必ず書かれる語について省き、小さい残りは store の列に、早期 return の道では本体側へ沈めた（rep stosq の microcode の立ち上がりが消える）
- 展開後の最適化パスの並びの穴を 2 つ修理（刈り込まれない φ の環・region の省略の掛け直し）
- region の軽量化の判定のバグ修理（relocate の深度の引数の読み違え — ループ周回ごとの region の出入りが大幅に減少）
- SROA が定数の gep を透過するようになり、値渡しの struct の仮引数の丸写しが消えた
- spill 先の合流と定義直後の読み直しの省略（レジスタ割り当ての写しの削減）
- 自己ビルド: 型付けの表の共有ほかで約 3% 短縮・コンパイラのバイナリ −7%

## v0.5.1（2026-10-11）

### 言語

- 暗黙の freeze: imm のコンテナが期待される位置（実引数・return・欄への代入・composite の欄・リテラルの要素・append の要素・添字や map への格納・imm への代入・チャネルの送信）に mut のコンテナを置くと、暗黙に freeze される。束縛 `x := m` では起こさない（今までどおり別名になる）。明示の freeze はそのまま使える。詳細は docs/language.md 17 節
- freeze の一意性を静的に強制（健全性の修理）: freeze の後に古い mut の別名から凍結済みの中身を書き換えられる穴を塞いだ。一意と証明できない freeze は検査器が拒否する（規則 U1〜U3 — Lean の述語 uniqFreeze と照合）。暗黙の freeze にも同じ規則が掛かる
- mut の仮引数の中身は呼び先から逃げない（U3）が言語の約束になった

### 標準ライブラリ

- std/strings に Cut / CutLast / TrimPrefix を追加。切った片は UTF-8 の検査をし直さずに string で返る

### 性能

- UTF-8 の境界検査の消去: ASCII と証明できる境界の検査は機械語から消える（1brc の命令 −3.5%）
- 呼び出し規約の改善（冷たい呼び出しを跨ぐ値の退避の削減）とインライン展開の予算の配り直し（routing の cycles −9%）
- 自己ビルド: 型付けの二重計算を解消（ビルド約 3.6% 短縮・検査の RSS −41 MB）

### 修正

- `sober run` / `sober test` が freeze の一意性の規則を飛ばしていた穴を閉じた
- par の子が imm の束縛越しに mut のコンテナを捕獲できた穴を閉じた（freeze してから Spawn する）

## v0.5.0（2026-10-10）

最初の公開リリース。

- 言語・コンパイラ・標準ライブラリ・ベンチマーク・文書の一式
- ソースからのブートストラップ: Zig 0.15.2 が stage1（凍結したコンパイラ）を建て、bootstrap/ の鎖が現行のコンパイラを建てる
- x86-64 Linux の静的バイナリを生成（libc 非依存）
