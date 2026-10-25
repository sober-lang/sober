# 変更履歴

このファイルは公開リリースごとの利用者向けの変更点を記録する。形式は [Keep a Changelog](https://keepachangelog.com/ja/1.1.0/) に倣う。バージョンは [Semantic Versioning](https://semver.org/lang/ja/) に従う（0.x の間は後方互換を約束しない）。

## v0.6.3 — 2026-10-25

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

## v0.6.2 — 2026-10-23

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

## v0.6.1 — 2026-10-23

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
