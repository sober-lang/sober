# 変更履歴

このファイルは公開リリースごとの利用者向けの変更点を記録する。形式は [Keep a Changelog](https://keepachangelog.com/ja/1.1.0/) に倣う。バージョンは [Semantic Versioning](https://semver.org/lang/ja/) に従う（0.x の間は後方互換を約束しない）。

## v0.6.0 — 2026-10-20

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

## v0.5.4 — 2026-10-14

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

## v0.5.3 — 2026-10-12

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

## v0.5.2 — 2026-10-11

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

## v0.5.1 — 2026-10-11

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

## v0.5.0 — 2026-10-10

最初の公開リリース。

- 言語・コンパイラ・標準ライブラリ・ベンチマーク・文書の一式
- ソースからのブートストラップ: Zig 0.15.2 が stage1（凍結したコンパイラ）を建て、bootstrap/ の鎖が現行のコンパイラを建てる
- x86-64 Linux の静的バイナリを生成（libc 非依存）
