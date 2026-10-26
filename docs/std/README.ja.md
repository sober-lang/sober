# std リファレンス

日本語

Sober の標準ライブラリ（`src/std/`）の公開の宣言の一覧です。このページと各 package のページは、ソースの doc コメント（宣言の直前の `//` の行）から `scripts/stdref.sh --regen` が生成します。直すときはソースの doc コメントを直してください。

## 名前の付け方

目指すもの: あるだろうと思った名前が、その名前で実在すること（guessability）。下の 5 つの規則はそのための道具で、規則どおりの名前が推測に外れるなら、規則の側を直す。

1. 動詞の閉集合 — 公開関数の名前は決まった語で始まる（問い合わせ `Has…`・`Contains`・`Index…`、変換 `Format…` / `Parse…`、容器 `Push`・`Get`・`Need`、入出力 `Read…` / `Write…` ほか）
2. 対称性 — 対になる語は両方を埋めるか、片方だけの理由を宣言の注記に書く（各宣言の「対の X は実需まで足さない」の行）
3. subject 第一 — 第 1 引数は操作の対象。mut で渡す容器は常に第 1 引数
4. 戻りの形は族ごとに 1 つ — 位置の族は「無ければ -1」・`Parse…` は `(T, error?)`
5. 借用語・省略形・別名の禁止 — `Itoa` のような省略を使わない・同じものに 2 つの名前を置かない

語彙の全体と決定の経緯は [language.md 34 節](../language.md)。

## package

| package | 概要 |
|---|---|
| [std/base64](base64.ja.md) | base64（RFC 4648）の符号化と復号: 標準の字母（RFC 4648 4 節 — 詰め '=' つき）の Encode ⇄ Decode と、URL・ファイル名に安全な字母（RFC 4648 5 節 — '-' '\_'・詰めなし）のEncodeUrl ⇄ DecodeUrl。 |
| [std/binary](binary.ja.md) | バイト列の語単位の読み（1 バイトずつの読みを 1 回の検査 + 1 回の load に）。 |
| [std/builder](builder.ja.md) | コピーせずに成長する可変長の列 Builder[T]（積んでから Build で 1 本の slice にする — 添字で読み書きする大きな表なら std/table） |
| [std/compress/flate](compress-flate.ja.md) | DEFLATE（RFC 1951）の符号化（Encode）と復号（Decode — inflate.sober） |
| [std/compress/gzip](compress-gzip.ja.md) | gzip（RFC 1952）の符号化と復号（中身は std/compress/flate） |
| [std/convert](convert.ja.md) | 数値と文字列の変換（[language.md 37 節](../language.md)・[language.md 34 節](../language.md)の Format… / Parse…）。 |
| [std/crypto](crypto.ja.md) | 暗号プリミティブの集約パッケージ。 |
| [std/crypto/aesgcm](crypto-aesgcm.ja.md) | AES-128-GCM（NIST SP 800-38D — 鍵 16 バイト・nonce 12 バイト・tag 16 バイト）。 |
| [std/crypto/chacha20](crypto-chacha20.ja.md) | ChaCha20（RFC 8439 2.3〜2.4 — 鍵 32 バイト・nonce 12 バイト・32 bit のブロック番号）。 |
| [std/crypto/chacha20poly1305](crypto-chacha20poly1305.ja.md) | AEAD\_CHACHA20\_POLY1305（RFC 8439 2.8 — 鍵 32 バイト・nonce 12 バイト・tag 16 バイト）。 |
| [std/crypto/hkdf](crypto-hkdf.ja.md) | HKDF-SHA256（RFC 5869）。 |
| [std/crypto/hmac](crypto-hmac.ja.md) | HMAC-SHA256（RFC 2104 / FIPS 198-1）。 |
| [std/crypto/pem](crypto-pem.ja.md) | PEM（RFC 7468 — "-----BEGIN \<label>-----" 〜 "-----END \<label>-----" の間の base64）の読み。 |
| [std/crypto/poly1305](crypto-poly1305.ja.md) | Poly1305 の一回の MAC（RFC 8439 2.5 — 鍵 32 バイト = r ‖ s・tag 16 バイト）。 |
| [std/crypto/rsa](crypto-rsa.ja.md) | RSA の秘密鍵の読み（PKCS#8 の DER）と RSASSA-PSS（RFC 8017 8.1 — SHA-256・MGF1-SHA256）の署名と検証。 |
| [std/crypto/sha256](crypto-sha256.ja.md) | SHA-256（FIPS 180-4）のインクリメンタル API。 |
| [std/crypto/x25519](crypto-x25519.ja.md) | X25519（RFC 7748 5 節 — Curve25519 の Montgomery ladder）。 |
| [std/hash](hash.ja.md) | ワンショット API のハッシュ（Sha256）。 |
| [std/hash/crc32](hash-crc32.ja.md) | CRC-32（IEEE 802.3 の多項式）の検査和 |
| [std/hex](hex.ja.md) | バイト列の小文字の 16 進表記（Format）と、その逆向きの読み（Parse） |
| [std/http](http.ja.md) | HTTP/1.1 のサーバの最小形: 接続 1 本の要求を順に route へ渡し、応答を書く。 |
| [std/io](io.ja.md) | ファイル・標準ストリーム・ディレクトリの読み書き（[language.md 28 節](../language.md)）と根の下の開き（OpenRoot / OpenUnder）。 |
| [std/iter](iter.ja.md) | push 型の生産者 Iter[T] と、for 式の生成元（Slice・Range）・消費（Each・Count・Sum） |
| [std/json](json.ja.md) | JSON（RFC 8259）の読みと決定的な印字（[language.md 16 節](../language.md)）。 |
| [std/layout](layout.ja.md) | @layout（[language.md 36 節](../language.md)）の裏方: 利用者は `layout.Decode[T](b, off)`・`layout.DecodeAt[T](b, off, i)`・`layout.Encode[T](mut out, v)`・`layout.Size[T]` を書き、loader の固定テンプレート（compiler/loader/layout.sober）が @layout の struct ごとの写しの関数（普通の Sober）を合成してその呼び出しに写す。 |
| [std/math](math.ja.md) | float の数学（[language.md 37 節](../language.md)）: 基本演算で書けないものだけを組み込みで（sqrtsd・ビット列の読み替え）。 |
| [std/net](net.ja.md) | TCP のリスナーと接続（[language.md 28 節](../language.md)の net）: 寿命は for の本体で言う（閉じる関数は無い）。 |
| [std/os](os.ja.md) | プロセスと OS の API: 引数（Args）・子プロセス（Run）・環境変数（Getenv）・ファイルの属性と名前（WriteMode・Mkdir・Rename・ModTime）・眠り（Sleep） |
| [std/pool](pool.ja.md) | スロットを使い回す資源のプール Pool[T]（region-domain-pool.md 2・4 節の最小形）。 |
| [std/rand](rand.ja.md) | シードを明示する決定的な擬似乱数 Rand（暗号用途には使わない — 鍵は crypto.Rand） |
| [std/sort](sort.ja.md) | 並べ替え（[language.md 34 節](../language.md)「並べ替え」の族）。 |
| [std/strings](strings.ja.md) | Go の strings パッケージが仕様のオラクル。 |
| [std/table](table.ja.md) | 添字で読み書きできる可変長の列 Table[T]（大きな表を O(1) で読み書きする — 小さな列を積んで Build するなら std/builder） |
| [std/task](task.ja.md) | structured concurrency の表層（[language.md 11 節](../language.md)「表層」）。 |
| [std/testing](testing.ja.md) | テストの語彙の裏方: `_test.sober` の `assert(e)` は loader の固定テンプレート（compiler/loader/assert.sober）が「部分式を束縛 → 偽なら Fail」に写す。 |
| [std/tls](tls.ja.md) | TLS 1.3 のサーバ（RFC 9846 — X25519・AES-128-GCM / ChaCha20-Poly1305・RSA-PSS の証明書・resumption / 0-RTT なし）。 |
| [std/tls/record](tls-record.ja.md) | TLS 1.3 の record 層（RFC 9846 5 節 — 8446bis）。 |
| [std/url](url.ja.md) | URL の部品の符号化: percent-encoding（RFC 3986 2.1）の Escape ⇄ Unescape と、クエリ文字列（application/x-www-form-urlencoded — `k=v&…`）の全部の組を読む ParseQuery。 |
| [std/utf8](utf8.ja.md) | 検査済みの UTF-8 のビュー（View — 全体を 1 回検査すれば、文字境界で切った部分列は検査し直さずに string にできる）。 |

## 索引

- [`aesgcm.Auth`](crypto-aesgcm.ja.md#auth) — tag が合わない
- [`aesgcm.Available`](crypto-aesgcm.ja.md#available) — この機械で Seal / Open が使えるか
- [`aesgcm.BadSize`](crypto-aesgcm.ja.md#badsize) — 鍵・nonce の長さが違う・暗号文が tag より短い・切片の外を指す
- [`aesgcm.Key`](crypto-aesgcm.ja.md#key) — 展開した鍵（Prepare の結果 — 鍵の展開 11 段と GHASH の H^1〜H^4 を持つ ctx のテンプレート。
- [`aesgcm.KeySize`](crypto-aesgcm.ja.md#keysize) — 長さの定数（バイト）
- [`aesgcm.NoHardware`](crypto-aesgcm.ja.md#nohardware) — この機械で AES-GCM の専用命令の実装を使えない（AES-NI / PCLMULQDQ / SSSE3 が無い・SOBER\_NOAES=1・x86 の最適化のバックエンド以外の出力）
- [`aesgcm.NonceSize`](crypto-aesgcm.ja.md#noncesize) — 長さの定数（バイト）
- [`aesgcm.Open`](crypto-aesgcm.ja.md#open) — Seal の逆（tag を crypto.Equal で照合してから復号する）
- [`aesgcm.OpenAt`](crypto-aesgcm.ja.md#openat) — b[off, off + n)（暗号文 ‖ tag）を写さずに tag を照合してから復号した平文。
- [`aesgcm.Overhead`](crypto-aesgcm.ja.md#overhead) — 長さの定数（バイト）
- [`aesgcm.Prepare`](crypto-aesgcm.ja.md#prepare) — key を展開した Key（専用命令の有無と鍵の長さはここで見る）
- [`aesgcm.Seal`](crypto-aesgcm.ja.md#seal) — pt を暗号化して tag を付けたもの（暗号文 ‖ tag）。
- [`aesgcm.SealInto`](crypto-aesgcm.ja.md#sealinto) — SealTo の宛先を呼び手の列 dst[at:] にした形（head ‖ 暗号文 ‖ tag を dst へ書いて、書いたバイト数を返す — 入らなければ −1・nonce の長さが違えば −1）。
- [`aesgcm.SealTo`](crypto-aesgcm.ja.md#sealto) — head ‖ 暗号文 ‖ tag（平文 = pt ‖ tail — tail は TLS 1.3 の内側の型と詰め物のような後ろの数バイトを、呼び手が pt に繋いで写さずに渡す口。
- [`base64.Bad`](base64.ja.md#bad) — Decode / DecodeUrl の入力が綴りの規則に合わない（字母の外の文字・長さ・詰めの位置と数・最後の文字の使わない bit が 0 でない — RFC 4648 3.3・3.5）
- [`base64.Decode`](base64.ja.md#decode) — 標準の字母の base64 の s のバイト列（長さは 4 の倍数・'=' の詰めは端の 1〜2 文字だけ — Encode の綴りだけを受ける）
- [`base64.DecodeUrl`](base64.ja.md#decodeurl) — URL・ファイル名に安全な字母の base64 の s のバイト列（詰めの '=' は受けない — EncodeUrl の綴りだけを受ける）
- [`base64.Encode`](base64.ja.md#encode) — b の標準の字母の base64（4 文字ずつ・端は '=' で詰める — Go の base64.StdEncoding.EncodeToString と同じ綴り）
- [`base64.EncodeUrl`](base64.ja.md#encodeurl) — b の URL・ファイル名に安全な字母の base64（'+' '/' の代わりに '-' '\_'・詰めの '=' を書かない — Go の base64.RawURLEncoding と同じ綴り）
- [`binary.Load64`](binary.ja.md#load64) — b[i]〜b[i + 7] の 8 バイトを little-endian で読んだ int（b[i] が最下位のバイト）。
- [`binary.MatchLen`](binary.ja.md#matchlen) — b[i:i+n] と b[j:j+n] の先頭からの一致の長さ（0〜n — 最初に食い違うバイトの位置・全部一致なら n）。
- [`binary.OutOfRange`](binary.ja.md#outofrange) — Load64 / MatchLen の読みが b の外にはみ出した（呼び手の契約違反 — panic ラベル。
- [`builder.Build`](builder.ja.md#build) — 積んだ要素を連続した imm slice にして返す（現在の最内 region へ 1 回コピー）。
- [`builder.Builder`](builder.ja.md#builder) — コピーせずに成長する可変長の列（[language.md 21 節](../language.md)の緩和策 2）。
- [`builder.Get`](builder.ja.md#get) — i 番目（0 起点）に積んだ要素。
- [`builder.Len`](builder.ja.md#len) — 積んだ要素の個数
- [`builder.Push`](builder.ja.md#push) — x を末尾に積む（速い道 = 今の chunk に空きがある — 呼び出し点に展開される大きさに保つ。
- [`builder.PushAll`](builder.ja.md#pushall) — xs の要素を順に末尾に積む（Push を要素ごとに呼ぶのと同じ結果 — chunk の空きへまとめて写す: 呼び出しと chunk の出し入れが要素ごとでなく chunk ごと。
- [`builder.PushBetween`](builder.ja.md#pushbetween) — xs を open と close で挟んで末尾に積む（Push(b, open)・PushAll(b, xs)・Push(b, close) と同じ結果 — 今の chunk に len(xs) + 2 の空きがあれば空きの検査と chunk の出し入れは 1 回だけ。
- [`builder.PushString`](builder.ja.md#pushstring) — s のバイト列を末尾に積む（PushAll(b, bytes(s))）
- [`builder.PushWord`](builder.ja.md#pushword) — w の下の k バイトを下のバイトから順に末尾に積む（Push(b, byte(w & 255)) と w = w >> 8 を k 回くり返すのと同じ結果）。
- [`chacha20.Block`](crypto-chacha20.ja.md#block) — 鍵 key・nonce・ブロック番号 counter の鍵ストリームの 1 ブロック（64 バイト）。
- [`chacha20.XorKeyStream`](crypto-chacha20.ja.md#xorkeystream) — src を鍵ストリーム（ブロック番号 counter から）と xor したもの（暗号化 = 復号）。
- [`chacha20.XorKeyStreamAt`](crypto-chacha20.ja.md#xorkeystreamat) — src[at, at + n) を鍵ストリームと xor したもの（写さずに読む — record 層向けの API）。
- [`chacha20poly1305.Auth`](crypto-chacha20poly1305.ja.md#auth) — tag が合わない（暗号文・ad・nonce・鍵のどれかが違う）
- [`chacha20poly1305.BadSize`](crypto-chacha20poly1305.ja.md#badsize) — 鍵・nonce の長さが違う・暗号文が tag より短い
- [`chacha20poly1305.Key`](crypto-chacha20poly1305.ja.md#key) — 鍵（Prepare の結果 — ChaCha20 は鍵の展開を持たないので鍵そのもの）
- [`chacha20poly1305.KeySize`](crypto-chacha20poly1305.ja.md#keysize) — 長さの定数（バイト）
- [`chacha20poly1305.NonceSize`](crypto-chacha20poly1305.ja.md#noncesize) — 長さの定数（バイト）
- [`chacha20poly1305.Open`](crypto-chacha20poly1305.ja.md#open) — Seal の逆（tag を照合してから復号する）
- [`chacha20poly1305.OpenAt`](crypto-chacha20poly1305.ja.md#openat) — b[off, off + n)（暗号文 ‖ tag）を写さずに tag を照合してから復号した平文。
- [`chacha20poly1305.Overhead`](crypto-chacha20poly1305.ja.md#overhead) — 長さの定数（バイト）
- [`chacha20poly1305.Prepare`](crypto-chacha20poly1305.ja.md#prepare) — key の Key（鍵の長さはここで見る）
- [`chacha20poly1305.Seal`](crypto-chacha20poly1305.ja.md#seal) — pt を暗号化して tag を付けたもの（暗号文 ‖ tag）。
- [`chacha20poly1305.SealInto`](crypto-chacha20poly1305.ja.md#sealinto) — SealTo の宛先を呼び手の列 dst[at:] にした形（aesgcm.SealInto と同じ口 — 書いたバイト数・入らなければ / nonce の長さが違えば −1）。
- [`chacha20poly1305.SealTo`](crypto-chacha20poly1305.ja.md#sealto) — head ‖ 暗号文 ‖ tag（平文 = pt ‖ tail — tail は呼び手が pt に繋いで写さずに渡す後ろの数バイト。
- [`convert.FloatOutOfRange`](convert.ja.md#floatoutofrange) — ParseFloat の溢れ（値は ±Inf — Go の ErrRange と同じ）
- [`convert.FormatBool`](convert.ja.md#formatbool) — b の綴り "true" / "false"（Go の strconv.FormatBool と同じ — ParseBool の対・補間 `${b}` と同じ綴り）
- [`convert.FormatFixed`](convert.ja.md#formatfixed) — f を小数点以下 prec 桁で（Go の strconv.FormatFloat(f, 'f', prec, 64)・fmt の %.\<prec>f と同じ綴り — 正確な値を最近接・偶数へ丸める）
- [`convert.FormatFloat`](convert.ja.md#formatfloat) — f の最短の往復表現（読み戻すと同じビットになる最短の 10 進 — Go の strconv.FormatFloat(f, 'g', -1, 64) と同じ綴り・println と同じ）
- [`convert.FormatInt`](convert.ja.md#formatint) — n の 10 進表記（Go の strconv.Itoa と同じ — ParseInt の対）。
- [`convert.IntOutOfRange`](convert.ja.md#intoutofrange) — ParseInt の溢れ（int〔64 ビット〕の範囲の外 — Go の ErrRange と同じ。
- [`convert.InvalidBool`](convert.ja.md#invalidbool) — ParseBool の構文の違い（受ける綴りの外 — Go の strconv.ErrSyntax と同じ）
- [`convert.InvalidFloat`](convert.ja.md#invalidfloat) — ParseFloat の構文の違い（10 進の数字・小数点・指数、または inf / infinity / nan でない）
- [`convert.InvalidInt`](convert.ja.md#invalidint) — ParseInt の構文の違い（[+-]? と 10 進の数字の列でない — 空・空白・\_・16 進は受けない）
- [`convert.ParseBool`](convert.ja.md#parsebool) — s の真偽（Go の strconv.ParseBool と同じ受け方 — 真 = "1" "t" "T" "TRUE" "true" "True"・偽 = "0" "f" "F" "FALSE" "false" "False"。
- [`convert.ParseFloat`](convert.ja.md#parsefloat) — s の値（10 進の正確な値を 1 回だけ最近接・偶数へ丸める — 浮動小数のリテラルと同じ算法。
- [`convert.ParseInt`](convert.ja.md#parseint) — s の 10 進の値（Go の strconv.Atoi と同じ受け方 — `[+-]? 数字+`）
- [`crc32.Sum`](hash-crc32.ja.md#sum) — data の CRC-32（IEEE 802.3 の多項式 — 反転形 0xedb88320・初期値と終わりの反転 0xffffffff。
- [`crypto.Equal`](crypto.ja.md#equal) — a と b のバイト列が等しいか。
- [`crypto.NoEntropy`](crypto.ja.md#noentropy) — getrandom が乱数を返せない（カーネル 3.17 未満 = ENOSYS など — 乱数なしで鍵を作らないための panic ラベル。
- [`crypto.NonZero`](crypto.ja.md#nonzero) — x が 0 なら 0、それ以外なら -1（全ビット 1）の mask（x | -x の最上位のビットを算術シフトで広げる — 分岐なし）
- [`crypto.Rand`](crypto.ja.md#rand) — OS の暗号論的な乱数 n バイト（getrandom — 呼ぶのはこの 1 か所だけ。
- [`crypto.Select`](crypto.ja.md#select) — m が -1 なら a、0 なら b（m は NonZero などで作った mask だけ — 他の値は契約違反で結果は不定）
- [`crypto.Wipe`](crypto.ja.md#wipe) — b の全バイトを 0 にする（用済みの鍵の後始末）
- [`flate.Bad`](compress-flate.ja.md#bad) — Decode の入力が DEFLATE の列でない（ブロックの型 3・stored の LEN と NLEN の不一致・Huffman の符号の長さの表が過剰 / 不完全・使えない記号〔長さ 286 / 287・距離 30 / 31〕・出力の頭より前を指す距離・最後のブロックの前で入力が尽きた〔切り詰め〕・最後のブロックの後に余りのバイト）
- [`flate.BadLevel`](compress-flate.ja.md#badlevel) — Encode の level が 0〜9 の外（呼び手の契約違反 — panic ラベル。
- [`flate.Decode`](compress-flate.ja.md#decode) — DEFLATE（RFC 1951 — 頭も検査和もない生の圧縮列。
- [`flate.Encode`](compress-flate.ja.md#encode) — data を DEFLATE（RFC 1951 — 頭も検査和もない生の圧縮列）に符号化する。
- [`flate.EncodeWith`](compress-flate.ja.md#encodewith) — Encode と同じ符号化を作業域 w で行う（w の中身は入口で捨てる — 結果は w に依らず Encode(data, level) と同じバイト列）
- [`flate.Prepare`](compress-flate.ja.md#prepare) — w を最大の入力（窓 32 KiB の鎖・2^15 のハッシュの表・ブロック 1 つの記号）の容量に整える（task.NewLocal の整え方）
- [`flate.TooLarge`](compress-flate.ja.md#toolarge) — Decode の出力が maxSize バイトを越える（展開爆弾の封 — 越える書きの手前で止める。
- [`flate.Work`](compress-flate.ja.md#work) — 符号器の作業域（ハッシュ鎖と記号の溜め — 8 KiB の本文で ≈ 150 KB・最大 ≈ 650 KB）。
- [`gzip.Bad`](compress-gzip.ja.md#bad) — Decode の入力の gzip の包みが違う（ID が 1f 8b でない・CM が 8 でない・FLG の予約ビット・頭の欄の途中で尽きた・FHCRC の不一致・末尾の CRC-32 / 長さ〔ISIZE〕が中身と合わない・メンバの後に余りのバイト）。
- [`gzip.Decode`](compress-gzip.ja.md#decode) — gzip（RFC 1952）の data を復号したバイト列（Encode の対）。
- [`gzip.Encode`](compress-gzip.ja.md#encode) — data を gzip（RFC 1952 — 1 個のメンバ）に符号化する: 10 バイトの頭（ID 1f 8b・CM 8 = deflate・FLG 0・MTIME 0・XFL・OS 255 = 不明）+ flate.Encode(data, level) + CRC-32 + 長さ（mod 2^32）の 8 バイト（どちらも little endian）。
- [`gzip.EncodeWith`](compress-gzip.ja.md#encodewith) — Encode と同じ符号化を flate の作業域 w で行う（flate.EncodeWith と同じ API — ワーカー局所の lease で借りた w を渡す。
- [`hash.Sha256`](hash.ja.md#sha256) — data の SHA-256 の値（32 バイト — FIPS 180-4）。
- [`hex.Bad`](hex.ja.md#bad) — Parse の入力が 16 進の綴りでない（奇数の長さ・0-9 a-f A-F 以外の文字）
- [`hex.Format`](hex.ja.md#format) — b の小文字の 16 進表記（1 バイト 2 桁 — Go の hex.EncodeToString・sha256sum の出力と同じ綴り）。
- [`hex.Parse`](hex.ja.md#parse) — 16 進の綴り s のバイト列（大文字・小文字とも受ける — 暗号のテストベクタの読み）
- [`hkdf.Expand`](crypto-hkdf.ja.md#expand) — OKM の先頭 n バイト（T(i) = HMAC(prk, T(i-1) ++ info ++ i) を繋ぐ — RFC 5869 2.3）。
- [`hkdf.Extract`](crypto-hkdf.ja.md#extract) — PRK = HMAC-SHA256(salt, ikm)（salt が空なら 32 バイトの 0 — RFC 5869 2.2）
- [`hkdf.TooLong`](crypto-hkdf.ja.md#toolong) — Expand の長さが RFC の上限（255 × 32 バイト）を超えた（または負）
- [`hmac.Sum256`](crypto-hmac.ja.md#sum256) — key で msg の HMAC-SHA256（32 バイト）。
- [`http.After`](http.ja.md#after) — ハンドラの後に走るコールバック（内側が返した応答 w を受けて応答を返す）
- [`http.Authorization`](http.ja.md#authorization) — r の Authorization ヘッダの値（認証の源 — 最初の行。
- [`http.BadEvent`](http.ja.md#badevent) — Event の event / id に CR・LF・NUL がある（呼び手の契約違反 — イベントの差し込みの封: 行の区切りを値に書けると、受け手に別のイベントや欄を足せる。
- [`http.BadHeader`](http.ja.md#badheader) — Response の headers の 1 本が書けない（名前が空か tchar でない・値に CR / LF / NUL・std/http が書く名前 — 呼び手の契約違反。
- [`http.BadLevel`](http.ja.md#badlevel) — Gzip の level が 0〜9 の外（呼び手の契約違反 — panic ラベル。
- [`http.BadMultipart`](http.ja.md#badmultipart) — Multipart が読めない本文（Content-Type が multipart/form-data でない・boundary が無いか形が違う・境界の行や部分の頭の形の誤り・閉じの境界が無い・部分の数か部分の頭の大きさが上限を超える）。
- [`http.BadRequest`](http.ja.md#badrequest) — 400 Bad Request（要求の頭が読めない）
- [`http.Before`](http.ja.md#before) — ハンドラの前に走るコールバック（nil = 続ける・応答を返すと short-circuit — 内側の middleware とハンドラは走らない）
- [`http.Cache`](http.ja.md#cache) — 保存の方針（Cache-Control の値）。
- [`http.Coded`](http.ja.md#coded) — 応答の本文が要求の Accept-Encoding で選ばれたこと（encoding = 選んだ符号化〔"br" / "gzip"〕・"" = 候補を見たが元のまま）。
- [`http.ContentTooLarge`](http.ja.md#contenttoolarge) — 413 Content Too Large（本文が上限を超える）
- [`http.Cookie`](http.ja.md#cookie) — r の Cookie ヘッダの name の値（認証の源 — RFC 6265 5.4 の `name=value; name2=value2` を `;` で切り、前後の空白を除いて名前がちょうど等しい〔大文字小文字を区別する〕最初の組の値。
- [`http.Created`](http.ja.md#created) — 201 Created
- [`http.Dispatch`](http.ja.md#dispatch) — routes から r に一致する行を選んで middleware とハンドラを走らせる。
- [`http.Event`](http.ja.md#event) — Server-Sent Events のイベント 1 つ（WHATWG HTML 9.2 の text/event-stream — FormatEvent で組んで stream の emit に渡す）。
- [`http.Field`](http.ja.md#field) — 任意ヘッダの 1 本
- [`http.Forbidden`](http.ja.md#forbidden) — 403 Forbidden
- [`http.Form`](http.ja.md#form) — 本文（Content-Type が application/x-www-form-urlencoded のとき）の key の値（Query と同じ切り方 — `k=v&…` の最初の一致・デコードしない。
- [`http.FormatEvent`](http.ja.md#formatevent) — e の text/event-stream の 1 イベント（`event:`・`id:`・`retry:`・`data:` の行と、終わりの空行）。
- [`http.Found`](http.ja.md#found) — 302 Found
- [`http.Gzip`](http.ja.md#gzip) — ServeConn の compress: の値（応答の gzip — RFC 1952。
- [`http.HTTPVersionNotSupported`](http.ja.md#httpversionnotsupported) — 505 HTTP Version Not Supported
- [`http.Handler`](http.ja.md#handler) — 要求 1 件の処理（ルートの表の行が持つ）
- [`http.Header`](http.ja.md#header) — r のヘッダ name の値（名前は大文字小文字を区別しない — 最初の一致。
- [`http.Headers`](http.ja.md#headers) — 任意ヘッダの列（Response の欄を option の包みにしてあるのは、欄を持たない応答〔大半〕の道に空の列の確保と region の付け替えを積まないため）
- [`http.InternalServerError`](http.ja.md#internalservererror) — 500 Internal Server Error（handler の失敗）
- [`http.Json`](http.ja.md#json) — 200・application/json の応答（s は組み上がった JSON — std/json の Put… / Done）
- [`http.JsonDoc`](http.ja.md#jsondoc) — 本文を JSON として読んだ表（std/json の Doc — 型へは `json.Decode[T](d, json.Root(d))`。
- [`http.Merge`](http.ja.md#merge) — a と b を繋いだ表
- [`http.MethodNotAllowed`](http.ja.md#methodnotallowed) — 405 Method Not Allowed（Dispatch — Allow を付ける）
- [`http.Middleware`](http.ja.md#middleware) — ルートの前後に挟む処理（before と after の組 — どちらも省ける）。
- [`http.Mount`](http.ja.md#mount) — routes の各行の path の前に prefix を付け、mw を各行の middleware の列の頭に足した表（純関数 — 足した mw は元の行の mw より外側で走る）。
- [`http.MovedPermanently`](http.ja.md#movedpermanently) — 301 Moved Permanently
- [`http.Multipart`](http.ja.md#multipart) — r の本文（Content-Type が multipart/form-data — boundary つき）の部分の列（本文の順）。
- [`http.NoContent`](http.ja.md#nocontent) — 204 No Content（本文なし・Content-Length を書かない）
- [`http.NotFound`](http.ja.md#notfound) — 404 Not Found（Dispatch の一致なし・Static のファイルなし）
- [`http.NotImplemented`](http.ja.md#notimplemented) — 501 Not Implemented（知らない Transfer-Encoding）
- [`http.NotModified`](http.ja.md#notmodified) — 304 Not Modified（条件付き GET の一致 — 本文なし）
- [`http.OK`](http.ja.md#ok) — 200 OK
- [`http.Param`](http.ja.md#param) — r のパターンの :key / \*key の値（Dispatch が一致させたパターンと path を並べて歩く — パターンに key が無い・ルーターを通らない要求は nil）
- [`http.Part`](http.ja.md#part) — multipart/form-data の部分 1 つ（Multipart の結果 — 本文の順）
- [`http.PreconditionFailed`](http.ja.md#preconditionfailed) — 412 Precondition Failed（If-Match / If-Unmodified-Since の不一致）
- [`http.Query`](http.ja.md#query) — r の query の key の値（`k=v&…` の最初の一致・= の無い項目は値 ""・デコードしない。
- [`http.Request`](http.ja.md#request) — 要求 1 件（この反復の region — route が返ったら消える。
- [`http.RequestHeaderFieldsTooLarge`](http.ja.md#requestheaderfieldstoolarge) — 431 Request Header Fields Too Large（要求の頭が上限を超える）
- [`http.Response`](http.ja.md#response) — 応答（status・Content-Type〔"" なら書かない〕・本文）。
- [`http.Route`](http.ja.md#route) — ルートの表の 1 行（method + path のパターン → ハンドラ・ルート単位の middleware）。
- [`http.ServeConn`](http.ja.md#serveconn) — c の要求を順に route に渡して応答を書く（keep-alive）。
- [`http.ServeWith`](http.ja.md#servewith) — ServeConn の核を転送路の受信コールバック recv（`for chunk <- recv()? { … }` の生成元 — net.Recv / tls.Recv の形）と送信コールバック send に一般化したもの（ServeConn は net の 1 行の包み・TLS の接続は `http.ServeWith((k) => tls.Recv(c, k), (b) => tls.Send(c, b), route, put: (b) => tls.Put(c, b))`）。
- [`http.ServiceUnavailable`](http.ja.md#serviceunavailable) — 503 Service Unavailable
- [`http.Static`](http.ja.md#static) — prefix の下の GET を root の下のファイルで返すルートの表（1 行 — `GET <prefix>/*path` — Mount / Merge で合成する。
- [`http.Status`](http.ja.md#status) — 本文なしの応答（http.NotFound / http.MethodNotAllowed …）
- [`http.StatusCode`](http.ja.md#statuscode) — 応答の状態の番号（RFC 9110 15 節）。
- [`http.Stream`](http.ja.md#stream) — 応答の本文の供給（emit は借り — 呼ぶ・借りの位置へ渡すだけ。
- [`http.Text`](http.ja.md#text) — 200・text/plain の応答
- [`http.Unauthorized`](http.ja.md#unauthorized) — 401 Unauthorized
- [`http.Validators`](http.ja.md#validators) — 応答の検証子（ETag と Last-Modified — Static が作る。
- [`http.WorkNoCompress`](http.ja.md#worknocompress) — ServeConn の work: を compress: なしで渡した（作業域は圧縮の符号器のもの — 呼び手の契約違反。
- [`io.Bytes`](io.ja.md#bytes) — 読むだけのバイト列の View（Chunks / Lines の切片 — [language.md 28 節](../language.md)「読みのストリーム」）。
- [`io.Chunks`](io.ja.md#chunks) — f を今の位置から EOF まで切片ずつ k へ渡す（失敗しうる生成元 — `for c <- io.Chunks(f)? { … }`）。
- [`io.ChunksAt`](io.ja.md#chunksat) — f の off バイト目から EOF まで切片ずつ k へ渡す（Chunks と同じ切片・先読み — 読みは pread の形で f の位置を動かさない。
- [`io.Close`](io.ja.md#close) — f を閉じる（Open の直後の defer でだけ書ける — desugar/filecheck。
- [`io.CloseRoot`](io.ja.md#closeroot) — r を閉じる（OpenRoot の直後の defer でだけ書ける — desugar/filecheck）
- [`io.Closed`](io.ja.md#closed) — 相手がもういない（[language.md 28 節](../language.md)の net — 送信の EPIPE / ECONNRESET・受信の RST・接続の拒否を 1 本で。
- [`io.Denied`](io.ja.md#denied) — 許可が無い（errno の EACCES / EPERM / EROFS）
- [`io.DirEntry`](io.ja.md#direntry) — ReadDir が返すディレクトリの項目 1 つ（名前と種類）
- [`io.EntryKind`](io.ja.md#entrykind) — ディレクトリの項目の種類（getdents64 の d\_type）。
- [`io.Expired`](io.ja.md#expired) — 自分の期限が尽きた（[language.md 28 節](../language.md)「デッドライン」）: 囲む task.Run の deadline: が過ぎた後に I/O 呼び出しを行った。
- [`io.File`](io.ja.md#file) — Open で開いたファイル（[language.md 28 節](../language.md)「資源とストリーム」— 同一性を持つ型: 作る関数は Open だけ・後始末は同じブロックの`defer io.Close(f)`・写せない・外へ出せない・give: では渡せない — 子は path から自分で開く。
- [`io.FileInfo`](io.ja.md#fileinfo) — Stat が返す開いた File の属性（fstat 1 回 — 開いたその実体を見て path を引き直さない。
- [`io.Flush`](io.ja.md#flush) — バッファに残った分を書き出し、それまでの書き出しの失敗を返す（返したら失敗は消える）
- [`io.Lines`](io.ja.md#lines) — f の行を順に k へ渡す（区切り = '\n'・行末の '\r' は落とす・最後の行は改行が無くても渡す — Go の bufio.ScanLines と同じ）。
- [`io.NotFound`](io.ja.md#notfound) — ファイルかディレクトリが無い（errno の ENOENT / ENOTDIR）
- [`io.Open`](io.ja.md#open) — path のファイルを読むために開く（O\_RDONLY）。
- [`io.OpenRoot`](io.ja.md#openroot) — path のディレクトリを OpenUnder の根として開く（openat の O\_PATH | O\_DIRECTORY）。
- [`io.OpenUnder`](io.ja.md#openunder) — r の下の rel のファイルを読むために開く（openat2 の RESOLVE\_BENEATH | RESOLVE\_NO\_MAGICLINKS）。
- [`io.Other`](io.ja.md#other) — 上のラベルに当たらない errno の開いたバケツ（[language.md 13 節](../language.md)「正直な宣言」）。
- [`io.Raw`](io.ja.md#raw) — v のバイト列（読むだけ — 同じ反復の中の View）
- [`io.ReadAll`](io.ja.md#readall) — f を今の位置から EOF まで全部読む（ReadFile の開いた File 版）。
- [`io.ReadDir`](io.ja.md#readdir) — path の項目を名前のバイト順で返す（`.` / `..` は含めない — Go の os.ReadDir と同じ）。
- [`io.ReadFile`](io.ja.md#readfile) — path のファイルを全部読む
- [`io.ReadStdin`](io.ja.md#readstdin) — 標準入力（fd 0）を EOF まで全部読む（同期 — Unix フィルタの入口。
- [`io.Root`](io.ja.md#root) — 根として開いたディレクトリ（[language.md 28 節](../language.md)「根の下の開き」— File と同じ同一性の型: 作る関数は OpenRoot だけ・後始末は同じブロックの`defer io.CloseRoot(r)`・写せない・外へ出せない・give: では渡せない）。
- [`io.SetFile`](io.ja.md#setfile) — 書き出す先を f に変える（io.Stdout / io.Stderr — 番号は Stream の中に閉じる）
- [`io.Stat`](io.ja.md#stat) — f の属性（fstat(2) の大きさ・更新時刻・種類 — 通常のファイルでなくても誤りにしない: 判定は kind で呼び手が）
- [`io.Stderr`](io.ja.md#stderr) — 標準ストリーム（開いている fd 0 / 1 / 2）
- [`io.Stdin`](io.ja.md#stdin) — 標準ストリーム（開いている fd 0 / 1 / 2）
- [`io.Stdout`](io.ja.md#stdout) — 標準ストリーム（開いている fd 0 / 1 / 2）
- [`io.Stream`](io.ja.md#stream) — 標準ストリーム（[language.md 28 節](../language.md)「標準ストリーム」— Stdin / Stdout / Stderr の 3 つだけ）。
- [`io.Timeout`](io.ja.md#timeout) — 相手の事情のタイムアウト（errno の ETIMEDOUT〔110〕— connect の不達・TCP の再送の尽き）: リトライの余地がある側。
- [`io.WriteByte`](io.ja.md#writebyte) — 1 バイト書く（速い道 = 空きがあれば書いて進めるだけ — 呼び手に展開される大きさに保つ。
- [`io.WriteBytes`](io.ja.md#writebytes) — バイト列を書く（バッファの空きの分ずつ — 内側は添字の写しの形で、最適化のバックエンドが一括の写しにする）
- [`io.WriteFile`](io.ja.md#writefile) — path に b を書く（作成 / 切り詰め、0644）。
- [`io.WriteStderr`](io.ja.md#writestderr) — 開いている標準エラー（fd 2）へ b を書く（WriteStdout と同じ規則）
- [`io.WriteStdout`](io.ja.md#writestdout) — 開いている標準出力（fd 1）へ b を書く（open しないので切り詰めない）。
- [`io.WriteString`](io.ja.md#writestring) — 文字列を書く
- [`io.Writer`](io.ja.md#writer) — 書きバッファ（定常メモリで流す — 64 KiB のバッファを添字で使い回し、満杯で書き出す。
- [`iter.Count`](iter.ja.md#count) — 要素の個数
- [`iter.Each`](iter.ja.md#each) — 要素ごとに f を呼ぶ
- [`iter.Iter`](iter.ja.md#iter) — push 型の生産者（Go 1.23 の iter.Seq と同形 — [language.md 7 節](../language.md)）。
- [`iter.Range`](iter.ja.md#range) — 整数の半開区間 [lo, hi) を昇順に回す。
- [`iter.Slice`](iter.ja.md#slice) — slice の走査。
- [`iter.Sum`](iter.ja.md#sum) — int の要素の和
- [`json.At`](json.ja.md#at) — ノード n を 1 段開く
- [`json.BadUtf8`](json.ja.md#badutf8) — InvalidJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）
- [`json.Decode`](json.ja.md#decode) — ノード n を struct T に読む。
- [`json.DecodeWith`](json.ja.md#decodewith) — Decode の欄名の対応つき版（rename = 欄名 → JSON のキー・入れ子の struct の欄にも同じ辞書が掛かる・対応の無い欄は欄名のまま）
- [`json.Doc`](json.ja.md#doc) — 読んだ文書: ノードの表（番号 = 添字。
- [`json.Done`](json.ja.md#done) — 積んだバイト列の string
- [`json.DuplicateKey`](json.ja.md#duplicatekey) — InvalidJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）
- [`json.Encode`](json.ja.md#encode) — v の JSON（空白なし・欄は宣言の順・`U?` の nil は null）。
- [`json.EncodeWith`](json.ja.md#encodewith) — Encode の欄名の対応つき版（rename は DecodeWith と同じ辞書 — 同じ辞書で両方向に使える）
- [`json.Format`](json.ja.md#format) — ノード n の決定的な JSON（空白なし・欄はソースの順・数は字句のまま・文字列は '"' '\\' と制御文字だけをエスケープ）
- [`json.Get`](json.ja.md#get) — オブジェクトのノード n の欄 key の値のノード（n がオブジェクトでない・欄が無ければ nil）
- [`json.GetAt`](json.ja.md#getat) — Get に手掛かりの位置 hint を足したもの: hint 番目の欄のキーを先に見て、外れたら線形に探す（shape[T] の写しの関数は欄の宣言の位置を渡す — 宣言と同じ順の JSON なら 1 回の比較で当たる）キーの比較は手で展開してある（Doc の欄を局所に取ってから回す — 旧 keyIs は Doc を値で渡す呼び出しを欄ごとに払っていた）。
- [`json.IntRange`](json.ja.md#intrange) — int の欄の数が int に収まらない（小数・指数を含む数は WrongType{want: "int"}）
- [`json.InvalidJson`](json.ja.md#invalidjson) — 読めなかった位置（src 上のバイトオフセット）と種類（Syntax・BadUtf8・TooDeep・DuplicateKey）
- [`json.IsNull`](json.ja.md#isnull) — ノード n が null か
- [`json.Items`](json.ja.md#items) — 配列 n の要素のノード（配列でなければ WrongType）
- [`json.KeyOf`](json.ja.md#keyof) — 欄 field の JSON のキー（rename の対応が無ければ欄名のまま。
- [`json.MaxDepth`](json.ja.md#maxdepth) — 入れ子の深さの上限（配列とオブジェクトの開き — 防御の上限。
- [`json.Missing`](json.ja.md#missing) — T? でない欄 field が無い（pos = オブジェクトの位置）
- [`json.Need`](json.ja.md#need) — オブジェクト n の欄 key の値のノード（無ければ Missing）
- [`json.NeedAt`](json.ja.md#needat) — Need に手掛かりの位置 hint を足したもの（GetAt と同じ — 写しの関数は欄の宣言の位置を渡す）
- [`json.NeedObject`](json.ja.md#needobject) — ノード n がオブジェクトなら n（でなければ WrongType）
- [`json.NotFinite`](json.ja.md#notfinite) — JSON に書けない float（NaN・±Inf）を Encode に渡した
- [`json.Parse`](json.ja.md#parse) — b 全体を 1 つの JSON の値として読む（前後の空白は可・後ろに何か残れば Syntax）
- [`json.ParseBool`](json.ja.md#parsebool) — true / false
- [`json.ParseFloat`](json.ja.md#parsefloat) — 数を binary64 に（最近接・偶数への丸め — convert.ParseFloat。
- [`json.ParseInt`](json.ja.md#parseint) — 整数の字句（小数点・指数なし）の数を int に（範囲外は IntRange）
- [`json.ParseString`](json.ja.md#parsestring) — 文字列 n の中身
- [`json.Pos`](json.ja.md#pos) — ノード n の src 上の位置（値の先頭のバイト）
- [`json.Put`](json.ja.md#put) — s のバイト列をそのまま積む（Put… / Done で JSON を手で組み立てる例: examples/json\_put.sober）
- [`json.PutBool`](json.ja.md#putbool) — b を true / false の綴りで積む
- [`json.PutFloat`](json.ja.md#putfloat) — f の最短の往復表現（NaN・±Inf は panic — field = 欄名）
- [`json.PutInt`](json.ja.md#putint) — n の 10 進を builder へ直に積む（FormatInt の string を経ない）。
- [`json.PutKey`](json.ja.md#putkey) — 欄の頭（2 つ目以降は ','・キーの文字列・':'）
- [`json.PutString`](json.ja.md#putstring) — s を JSON の文字列（引用符つき — `"` `\` と制御文字だけをエスケープ）として積む
- [`json.Root`](json.ja.md#root) — 根のノード
- [`json.Syntax`](json.ja.md#syntax) — InvalidJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）
- [`json.TooDeep`](json.ja.md#toodeep) — InvalidJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）
- [`json.Value`](json.ja.md#value) — ノード 1 つのビュー（子はノードの番号 — json.At で開く）
- [`json.WrongType`](json.ja.md#wrongtype) — ノードの種類が欄の型に合わない（want = 期待した JSON の種類: object・array・string・number・int・bool）
- [`layout.Decode`](layout.ja.md#decode) — b の off バイト目から T を 1 つ読む。
- [`layout.DecodeAt`](layout.ja.md#decodeat) — b の off バイト目から並ぶ T の i 番目を読む（間隔 = Size[T]）。
- [`layout.Encode`](layout.ja.md#encode) — v を out の末尾に書く。
- [`layout.FailLength`](layout.ja.md#faillength) — 固定長配列の長さ違い: 欄 field の長さが want でなく got
- [`layout.FailWidth`](layout.ja.md#failwidth) — 書き込みの幅あふれ: 欄 field の値 v が幅 width に収まらない
- [`layout.LengthMismatch`](layout.ja.md#lengthmismatch) — 固定長配列の長さ違い: 欄 field の長さが want でなく got
- [`layout.Size`](layout.ja.md#size) — T の静的な大きさ（バイト — 欄の幅の和）。
- [`layout.WidthOverflow`](layout.ja.md#widthoverflow) — 書き込みの幅あふれ: 欄 field の値 value が幅 width に収まらない
- [`math.Abs`](math.ja.md#abs) — x の絶対値（符号ビットを落とす — NaN の符号も落ちる・-0 は +0）
- [`math.Bits`](math.ja.md#bits) — x の IEEE 754 のビット列（i64 で読んだ値 — 変換でなく同じビットの読み替え）
- [`math.FromBits`](math.ja.md#frombits) — ビット列 b の float（±Inf・NaN もこれで作る）
- [`math.Sqrt`](math.ja.md#sqrt) — x の平方根（IEEE 754 の sqrt — 正しく丸めた値・負は NaN・-0 は -0）
- [`net.Accept`](net.ja.md#accept) — l の接続を受けるたびに k に渡し、k が返ったら閉じる（列は終わらない — 本体の break か失敗で止まる。
- [`net.Bad`](net.ja.md#bad) — addr の形の誤り（"a.b.c.d:port" — IPv4 の 4 つ組と 0〜65535 の port）
- [`net.Conn`](net.ja.md#conn) — 接続（同一性の型 — Listener と同じ規則。
- [`net.Dial`](net.ja.md#dial) — addr へ接続した Conn を 1 回だけ k に渡し、k が返ったら閉じる
- [`net.Listen`](net.ja.md#listen) — addr で listen した Listener を 1 回だけ k に渡し（SO\_REUSEADDR・SO\_REUSEPORT・TCP\_NODELAY・backlog 65535 — somaxconn へ詰める・Go と同じ）、k が返ったら閉じる。
- [`net.Listener`](net.ja.md#listener) — listen している socket（同一性の型 — 写せない・外へ出せない・give: で渡せない。
- [`net.Port`](net.ja.md#port) — l が bind している port（"…:0" で listen したときの割り当ての読み — getsockname）
- [`net.Recv`](net.ja.md#recv) — c の受信を切片ずつ k へ渡す（失敗しうる生成元 — `for chunk <- net.Recv(c)? { … }`）。
- [`net.Send`](net.ja.md#send) — b を全部 c へ送る（同期 — 短い書きは続きから・MSG\_NOSIGNAL で相手が閉じた後の書きは io.Closed）
- [`net.Serve`](net.ja.md#serve) — l の接続を受けるたびに接続 1 本 = task 1 本で h を走らせる（accept の輪は std が持つ — ワーカーごとに 1 本・l と同じ番地に SO\_REUSEPORT で足した listener で受ける）。
- [`os.Args`](os.ja.md#args) — プログラムの引数（0 番 = プログラム名 — Go の os.Args と同じ並び）。
- [`os.Getenv`](os.ja.md#getenv) — 環境変数 name の値（無ければ nil — 空の値 `NAME=` は "" で、無いのと区別する）。
- [`os.Mkdir`](os.ja.md#mkdir) — path のディレクトリを作る（mkdir(2) — 許可の bit は 0o755。
- [`os.ModTime`](os.ja.md#modtime) — path の更新時刻（stat(2) の st\_mtim — Unix エポック〔1970 年 1 月 1 日 UTC〕からの ns。
- [`os.Rename`](os.ja.md#rename) — from を to へ付け替える（rename(2) — 同じファイルシステムの中では原子的で、to が既にあれば置き換える）。
- [`os.Run`](os.ja.md#run) — path のプログラムを args（argv[1:] — argv[0] は path）で子プロセスとして走らせ、終了を待って終了コードを返す（シグナルで死んだら 128 + 番号 — シェルと同じ）。
- [`os.Sleep`](os.ja.md#sleep) — ms ミリ秒眠る（負の値は 0 と同じ）。
- [`os.SleepExpired`](os.ja.md#sleepexpired) — Sleep と同じで、期限で早く起きたら true（どの待ちが期限で切れたかを観測する関数）
- [`os.WriteMode`](os.ja.md#writemode) — path のファイルの許可の bit（mode — chmod(2) の 12 bit: 0o755 = 493 等）を書く。
- [`pem.Bad`](crypto-pem.ja.md#bad) — PEM の形が違う（BEGIN と END が対にならない・base64 の綴りが違う）
- [`pem.Block`](crypto-pem.ja.md#block) — 1 つの PEM の塊（label = BEGIN の後ろの名前・der = 中身）
- [`pem.Parse`](crypto-pem.ja.md#parse) — text の中の PEM の塊の全部（塊の外の行は無視 — RFC 7468 の説明文の扱い）
- [`poly1305.Sum`](crypto-poly1305.ja.md#sum) — key（32 バイト — 1 回だけ使う鍵。
- [`poly1305.SumAead`](crypto-poly1305.ja.md#sumaead) — AEAD の MAC の入力（ad ‖ 0 埋め ‖ msg[off, off + n) ‖ 0 埋め ‖ len(ad) ‖ n — 長さは各 64 bit の小さい端・RFC 8439 2.8）の tag。
- [`pool.Acquire`](pool.ja.md#acquire) — v を空きスロット（無ければ末尾に足す）に置き、そのスロットの Handle を返す
- [`pool.BadScratch`](pool.ja.md#badscratch) — Store の値が 0〜2^32−1 の外（呼び手の契約違反 — panic ラベル）
- [`pool.Cap`](pool.ja.md#cap) — s の項目の数（NewScratch の n）
- [`pool.Get`](pool.ja.md#get) — h のスロットの中身。
- [`pool.Handle`](pool.ja.md#handle) — Pool のスロットを指すハンドル（index + 世代）。
- [`pool.LeaseAttach`](pool.ja.md#leaseattach) — task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: 窓の w の i 番目の Scratch の欄 s を、ストレージ blk の区画 at に付ける（at = −1 = 倒れ: 新しい割り当て）。
- [`pool.Len`](pool.ja.md#len) — 未返却（Acquire したが Release していない）の個数
- [`pool.Load`](pool.ja.md#load) — s の i 番目の値（今の世代で Store していなければ 0）
- [`pool.LoadRaw`](pool.ja.md#loadraw) — s の i 番目の語をそのまま読む（生のアクセサ — 世代に触れない。
- [`pool.NewScratch`](pool.ja.md#newscratch) — 容量 0 の s を容量 n・全部 0 にする（容量は 1 回だけ — 容量のある s に呼ぶと panic(ScratchSized{}): lease の窓の中でストレージを作り直すと、新しい列が task の region に取られて長命のストレージから宙吊りになる — region-domain-pool.md 4d 節）。
- [`pool.Pool`](pool.ja.md#pool) — スロットを使い回す資源のプール（ゼロ値 `pool.Pool[T]{}` が空の Pool）
- [`pool.Release`](pool.ja.md#release) — h のスロットを空きに戻す。
- [`pool.Renew`](pool.ja.md#renew) — s の全部の項目を 0 に戻す（世代を 1 つ進める — 2^32 回目の一周だけ本当に消す）
- [`pool.RenewDense`](pool.ja.md#renewdense) — s の先頭 n 項目を本当に 0 に書く（生のアクセサ版の Renew — O(n)。
- [`pool.Scratch`](pool.ja.md#scratch) — 世代印つきの固定容量の作業域（region-domain-pool.md 4d 節 — ワーカー局所の lease のストレージに置ける容器）。
- [`pool.ScratchSized`](pool.ja.md#scratchsized) — NewScratch を容量のある Scratch に呼んだ（容量は 1 回だけ — 呼び手の契約違反）
- [`pool.Set`](pool.ja.md#set) — h のスロットを v で置き換える。
- [`pool.Store`](pool.ja.md#store) — s の i 番目を v にする。
- [`pool.StoreRaw`](pool.ja.md#storeraw) — s の i 番目を v にする（生のアクセサ — 世代に触れず、値の範囲の制限も無い。
- [`rand.Bool`](rand.ja.md#bool) — 真偽を 1 つ
- [`rand.Int62`](rand.ja.md#int62) — [0, 2^62) の値（Next 2 回 — 上位 30 bit + 下位 32 bit）
- [`rand.Intn`](rand.ja.md#intn) — [0, n) の値（n は 1 以上 — 0 以下は panic(NonPositiveBound{n})）。
- [`rand.New`](rand.ja.md#new) — シード seed（任意の int — 負でもよい）の Rand。
- [`rand.Next`](rand.ja.md#next) — 次の 32 bit の値（[0, 2^32)）
- [`rand.NonPositiveBound`](rand.ja.md#nonpositivebound) — Intn の上限 n が 1 未満（呼び手の契約違反 — panic ラベル。
- [`rand.Rand`](rand.ja.md#rand) — シードを明示する決定的な擬似乱数（`xoshiro128**` — Blackman / Vigna。
- [`rand.Split`](rand.ja.md#split) — r から独立した列の Rand を作る（r も 1 歩進む — 生成器の部分木に別のシードを配る用途）
- [`record.AesGcm`](tls-record.ja.md#aesgcm) — cipher suite の番号（RFC 9846 B.4 — v1 は 2 つ・どちらも SHA-256）
- [`record.Alert`](tls-record.ja.md#alert) — record 層の誤り（desc = 相手へ送る alert の番号）
- [`record.AlertBadMac`](tls-record.ja.md#alertbadmac) — alert の番号（RFC 9846 6）
- [`record.AlertDecode`](tls-record.ja.md#alertdecode) — alert の番号（RFC 9846 6）
- [`record.AlertInternal`](tls-record.ja.md#alertinternal) — alert の番号（RFC 9846 6）
- [`record.AlertOverflow`](tls-record.ja.md#alertoverflow) — alert の番号（RFC 9846 6）
- [`record.AlertUnexpected`](tls-record.ja.md#alertunexpected) — alert の番号（RFC 9846 6）
- [`record.At`](tls-record.ja.md#at) — b[off, off + n) を枠に（std/tls の handshake の組み立て — 呼び手が頭の長さを検査した後）
- [`record.ChaCha`](tls-record.ja.md#chacha) — cipher suite の番号（RFC 9846 B.4 — v1 は 2 つ・どちらも SHA-256）
- [`record.CtAlert`](tls-record.ja.md#ctalert) — record の内容の型（RFC 9846 5.1）
- [`record.CtApp`](tls-record.ja.md#ctapp) — record の内容の型（RFC 9846 5.1）
- [`record.CtCcs`](tls-record.ja.md#ctccs) — record の内容の型（RFC 9846 5.1）
- [`record.CtHandshake`](tls-record.ja.md#cthandshake) — record の内容の型（RFC 9846 5.1）
- [`record.Dir`](tls-record.ja.md#dir) — 1 方向の traffic の鍵と seq
- [`record.ExpandLabel`](tls-record.ja.md#expandlabel) — HKDF-Expand-Label(secret, label, context, n)（RFC 9846 7.1 — info = 長さ 2 バイト ‖ "tls13 " ‖ label ‖ context の長さ付き）
- [`record.Frame`](tls-record.ja.md#frame) — 受けた record の枠 1 つ = b[off, off + n)（頭 5 バイト込み）。
- [`record.Frames`](tls-record.ja.md#frames) — 転送路の受信コールバック recv から record の枠を順に k へ渡す（呼び出し形の生成元 — `for r <- record.Frames(recv)? { … }`）。
- [`record.HeadSize`](tls-record.ja.md#headsize) — record の大きさ（RFC 9846 5.1 / 5.2）
- [`record.MaxCipher`](tls-record.ja.md#maxcipher) — record の大きさ（RFC 9846 5.1 / 5.2）
- [`record.MaxPlain`](tls-record.ja.md#maxplain) — record の大きさ（RFC 9846 5.1 / 5.2）
- [`record.NeedUpdate`](tls-record.ja.md#needupdate) — 送りの鍵を進めるべきか（AES-GCM の使用上限の手前 — ChaCha20-Poly1305 は seq の上限〔2^64〕まで来ない）
- [`record.NewDir`](tls-record.ja.md#newdir) — suite と traffic secret の Dir（key = ExpandLabel(secret, "key", "", 16 / 32)・iv = ExpandLabel(secret, "iv", "", 12)・seq 0）
- [`record.Open`](tls-record.ja.md#open) — 枠 r（外側の内容の型 = application\_data）を d の鍵で検証・復号して、内側の内容の型と中身（0 埋めを剥がした平文）を返す。
- [`record.Pack`](tls-record.ja.md#pack) — d の語の列（[suite, seq, 秘密の長さ, 秘密 …, iv の長さ, iv …, 鍵の素材の長さ, 鍵の素材 …] — バイト列は 8 バイト / 語。
- [`record.Plain`](tls-record.ja.md#plain) — 暗号化していない record（handshake の最初の flight・互換の CCS）の内容の型と中身（枠 r の頭の後ろ — 写さない部分列）
- [`record.Seal`](tls-record.ja.md#seal) — 内容の型 ctype の平文 pt を record の列にしたもの（2^14 バイトずつ・各 record の内側の末尾に 0 埋め pad バイト〔0 = 埋めない〕）。
- [`record.SealInto`](tls-record.ja.md#sealinto) — Seal の宛先を呼び手の列 dst[at:] にした形（record 1 つ — pt が MaxPlain を越える・dst に入らなければ −1。
- [`record.Seq`](tls-record.ja.md#seq) — d の seq（std/tls がストレージの seq の語だけを書き戻す）
- [`record.Transport`](tls-record.ja.md#transport) — 転送路の受信コールバックが失敗した（相手の切断・期限など — 元の誤りは関数値越しでラベルを導出できないので包み替える。
- [`record.Unpack`](tls-record.ja.md#unpack) — Pack の逆（w[at:] から）
- [`record.Update`](tls-record.ja.md#update) — KeyUpdate（secret' = ExpandLabel(secret, "traffic upd", "", 32) — RFC 9846 7.2・key / iv を作り直して seq を 0 に）
- [`record.WithSeq`](tls-record.ja.md#withseq) — d の seq を seq に差し替えた Dir（鍵の素材は d と共有 — std/tls が展開済みの送りの方向に置き場の seq の語を当てる）
- [`rsa.BadKey`](crypto-rsa.ja.md#badkey) — 鍵の DER の形が違う（PKCS#8 の RSA でない・長さが合わない）
- [`rsa.BadSize`](crypto-rsa.ja.md#badsize) — salt の長さや鍵の大きさが PSS に足りない
- [`rsa.Fault`](crypto-rsa.ja.md#fault) — 署名の自己検証が合わなかった（計算の故障 — 署名を捨てた）
- [`rsa.MontSelfCheck`](crypto-rsa.ja.md#montselfcheck) — 専用命令の montMul と Sober の montMulS の照合（検証の網の API — 利用者は使わない: examples/crypto\_montmul と cryptocheck の格子が叩く）。
- [`rsa.NewPublic`](crypto-rsa.ja.md#newpublic) — 大きい端のバイト列の n と e の公開鍵（検証の網の API）
- [`rsa.ParsePKCS8`](crypto-rsa.ja.md#parsepkcs8) — PKCS#8 の DER（PEM の中身を base64 で戻したもの）の RSA の秘密鍵
- [`rsa.PrivateKey`](crypto-rsa.ja.md#privatekey) — RSAPrivateKey の成分（RFC 8017 A.1.2 — d は使わない・CRT の p, q〔の Montgomery の文脈 mp, mq〕, dp, dq, qinv）
- [`rsa.Public`](crypto-rsa.ja.md#public) — k の公開鍵
- [`rsa.PublicKey`](crypto-rsa.ja.md#publickey) — 法 n と公開の指数 e（limb の列）・k = n のバイト長・bits = n のビット長・mt = n の Montgomery の文脈（鍵を読むときに 1 回）
- [`rsa.SignPSS`](crypto-rsa.ja.md#signpss) — msg の RSASSA-PSS の署名（k バイト）。
- [`rsa.Size`](crypto-rsa.ja.md#size) — pub の法のバイト長（署名の長さ）
- [`rsa.VerifyPSS`](crypto-rsa.ja.md#verifypss) — sig が pub で msg の RSASSA-PSS の署名（salt 長 sLen）か
- [`sha256.BlockSize`](crypto-sha256.ja.md#blocksize) — 長さの定数（バイト）
- [`sha256.New`](crypto-sha256.ja.md#new) — 空の入力の状態
- [`sha256.Size`](crypto-sha256.ja.md#size) — 長さの定数（バイト）
- [`sha256.State`](crypto-sha256.ja.md#state) — 途中の状態（h = 8 語の連鎖値・tail = まだ畳んでいない 64 バイト未満の端・n = これまでに書いた長さ）
- [`sha256.Sum`](crypto-sha256.ja.md#sum) — s に書いた全体の値（32 バイト）。
- [`sha256.Sum256`](crypto-sha256.ja.md#sum256) — data の SHA-256 の値（ワンショット API）
- [`sha256.Write`](crypto-sha256.ja.md#write) — data を続けて書く（64 バイトのブロックが揃った分だけ畳み、端は tail に残す）
- [`sort.Order`](sort.ja.md#order) — 0..n−1 を less の順に並べた添字の列を返す（安定 — less で前後の付かない添字は小さい順のまま）。
- [`sort.OrderUnstable`](sort.ja.md#orderunstable) — 0..n−1 を less の順に並べた添字の列を返す（不安定 — less で前後の付かない添字の順は約束しない。
- [`strings.Arena`](strings.ja.md#arena) — string のコピー先の region を表す（region 多相の seed の慣用句）。
- [`strings.Clone`](strings.ja.md#clone) — s のバイト列を a の region へコピーした string を返す（コピーのコストはソースに見える — 境界コピー = 明示イディオム）
- [`strings.Contains`](strings.ja.md#contains) — substr が s に含まれるかを返す（空の substr は常に含まれる）
- [`strings.Count`](strings.ja.md#count) — s に含まれる substr の重ならない出現数を返す。
- [`strings.Cut`](strings.ja.md#cut) — s を最初の sep の前と後に割る（Go の strings.Cut — 無ければ s・""・false）。
- [`strings.CutLast`](strings.ja.md#cutlast) — s を最後の sep の前と後に割る（無ければ s・""・false — Cut の最後の出現版。
- [`strings.EqualFold`](strings.ja.md#equalfold) — s と t が ASCII の大文字小文字を同一視して等しいか（Go の strings.EqualFold の ASCII の部分 — 非 ASCII のバイトは完全一致で比べる。
- [`strings.Fields`](strings.ja.md#fields) — s を ASCII の空白の連なりで割った空でない片の列（Go の strings.Fields — 空白だけ / 空なら空の列）。
- [`strings.HasPrefix`](strings.ja.md#hasprefix) — s が prefix で始まるかを返す
- [`strings.HasSuffix`](strings.ja.md#hassuffix) — s が suffix で終わるかを返す
- [`strings.Index`](strings.ja.md#index) — substr が s に最初に現れる位置を bytes(s) 上のバイトオフセットで返す。
- [`strings.IndexByte`](strings.ja.md#indexbyte) — c が s に最初に現れる位置を bytes(s) 上のバイトオフセットで返す。
- [`strings.IndexInvalid`](strings.ja.md#indexinvalid) — 最初の不正なシーケンスの位置、妥当なら -1
- [`strings.InvalidUtf8`](strings.ja.md#invalidutf8) — 不正な UTF-8（pos = 最初の不正なシーケンスの先頭バイトのオフセット）
- [`strings.Join`](strings.ja.md#join) — ps を sep で繋いだ string（Go の strings.Join と同じ）。
- [`strings.LastIndex`](strings.ja.md#lastindex) — substr が s に最後に現れる位置を bytes(s) 上のバイトオフセットで返す。
- [`strings.Replace`](strings.ja.md#replace) — s の old の重ならない出現を前から n 個 new に置き換えた string（Go の strings.Replace — n \< 0 なら全部・n == 0 なら s）。
- [`strings.Split`](strings.ja.md#split) — s を sep の出現ごとに割った片の列（Go の strings.Split と同じ）。
- [`strings.ToLower`](strings.ja.md#tolower) — s の ASCII の大文字（'A'..'Z'）を小文字にした string（Go の strings.ToLower の ASCII の部分 — 非 ASCII の文字はそのまま。
- [`strings.ToUpper`](strings.ja.md#toupper) — s の ASCII の小文字（'a'..'z'）を大文字にした string（Go の strings.ToUpper の ASCII の部分 — 非 ASCII の文字はそのまま。
- [`strings.TrimPrefix`](strings.ja.md#trimprefix) — s が prefix で始まればそれを外した残り、でなければ s（Go の strings.TrimPrefix — 残りは prefix の末尾から始まるので文字の頭）
- [`strings.TrimSpace`](strings.ja.md#trimspace) — s の頭と尻の ASCII の空白を外した残り（Go の strings.TrimSpace — Unicode の空白は外さない）
- [`strings.TrimSuffix`](strings.ja.md#trimsuffix) — s が suffix で終わればそれを外した残り、でなければ s（Go の strings.TrimSuffix — 残りは suffix の頭で終わるので文字の境目）
- [`strings.Valid`](strings.ja.md#valid) — b 全体が有効な UTF-8 か（IndexInvalid(b) \< 0 と同じ）
- [`table.At`](table.ja.md#at) — 凍った表の i 番目（0 起点）の要素。
- [`table.CHUNK`](table.ja.md#chunk) — 表現の定数: chunk 1 本の要素数 CHUNK（= 1 \<\< CHUNK\_BITS）と、初回の Push で積む chunk ヘッダの本数 DIR0
- [`table.CHUNK_BITS`](table.ja.md#chunk_bits) — 表現の定数: chunk 1 本の要素数 CHUNK（= 1 \<\< CHUNK\_BITS）と、初回の Push で積む chunk ヘッダの本数 DIR0
- [`table.DIR0`](table.ja.md#dir0) — 表現の定数: chunk 1 本の要素数 CHUNK（= 1 \<\< CHUNK\_BITS）と、初回の Push で積む chunk ヘッダの本数 DIR0
- [`table.Freeze`](table.ja.md#freeze) — t の中身を写さずに凍らせて返し、t を空の表に戻す（取り出し形 — [language.md 17 節](../language.md)の bottom-up 凍結の Table 版:中身のある chunk を 1 本ずつ取り出して表の欄を空の seed に差し替えてから freeze する。
- [`table.Frozen`](table.ja.md#frozen) — Freeze が返す凍った表（imm — 書く関数が無い。
- [`table.FrozenLen`](table.ja.md#frozenlen) — 凍った表の要素の個数
- [`table.Get`](table.ja.md#get) — i 番目（0 起点）の要素。
- [`table.Len`](table.ja.md#len) — 積んだ要素の個数
- [`table.Push`](table.ja.md#push) — x を末尾に積む
- [`table.PushAll`](table.ja.md#pushall) — xs を順に末尾に積む（Push を要素ごとに呼ぶのと同じ結果 — chunk ごとにまとめて書く）
- [`table.Set`](table.ja.md#set) — i 番目（0 起点）の要素を x にする。
- [`table.Table`](table.ja.md#table) — 添字で読み書きできる可変長の列（[language.md 21 節](../language.md)の緩和策 2 の添字版）。
- [`task.Cause`](task.ja.md#cause) — 子の死因（不透明 — 中身は実装が運ぶ実行時の値。
- [`task.ChildDied`](task.ja.md#childdied) — scope の err: 本体は完走したが死んだ子がいた
- [`task.Close`](task.ja.md#close) — 送り端を閉じる（以後の Send は panic・二度目の Close も panic。
- [`task.GB`](task.ja.md#gb) — 予算の単位（バイト — `budget: 64 * MB`）
- [`task.Gather`](task.ja.md#gather) — handle の列を生んだ順（正準順）で待って結果を集める fan-in（死んだ子があれば呼び手も死ぬ: Join と同じ）。
- [`task.Handle`](task.ja.md#handle) — 子の task の handle（task.Spawn が返す）
- [`task.Join`](task.ja.md#join) — 子の結果（死んでいたら呼び手も死ぬ — この子の死は私の死）
- [`task.KB`](task.ja.md#kb) — 予算の単位（バイト — `budget: 64 * MB`）
- [`task.Lease`](task.ja.md#lease) — lp の今のワーカーのストレージを窓 body に貸す: `z := task.Lease(gzw, (w mut flate.Work) => flate.EncodeWith(mut w, b, 6))`。
- [`task.LeaseBlock`](task.ja.md#leaseblock) — task.NewLocal / task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: ストレージの列（pool.LeaseAttach へ渡す）
- [`task.LeaseGive`](task.ja.md#leasegive) — task.NewLocal / task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: LeaseTake で取った区画 at を返す（−1 なら何もしない）
- [`task.LeaseTake`](task.ja.md#leasetake) — task.NewLocal / task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: T の指紋 fp を照合し、今のワーカーの区画の位置を返す（使用中なら −1 = 倒れ）
- [`task.Ledger`](task.ja.md#ledger) — 台帳の今の値（io の効果 — 読んだ値は時刻に依る: 時計と同じ扱い）
- [`task.LedgerView`](task.ja.md#ledgerview) — 台帳の read-only のビュー（[language.md 11 節](../language.md)「メトリクス」）: 根 = プロセスの天井と計上中の量・縮退 / 天井を超えた入場 /宣言超過 / shed の数・ワーカー数、と名前つきプールのノード（作った順）
- [`task.Local`](task.ja.md#local) — ワーカーローカルストレージのハンドル（region-domain-pool.md 4d 節 — task.NewLocal が作る）: ワーカーごとに T を 1 つ持ち、task.Lease の窓に貸す。
- [`task.LocalNew`](task.ja.md#localnew) — task.NewLocal / task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: T の指紋 fp と Scratch の欄の容量の列 caps からストレージを作る（ワーカーの数だけの区画を今の region に先取り — 全部 0）
- [`task.LocalType`](task.ja.md#localtype) — NewLocal と違う T の窓で Lease した（ストレージの T の指紋が合わない）
- [`task.MB`](task.ja.md#mb) — 予算の単位（バイト — `budget: 64 * MB`）
- [`task.MS`](task.ja.md#ms) — 期限の単位（1 ミリ秒 — `deadline: 500 * MS`。
- [`task.Map`](task.ja.md#map) — xs の各要素に f を並列に（要素ごとに 1 task）適用し、結果を添字の順に返す（[language.md 11 節](../language.md): `([]U, error?)`。
- [`task.MarkFailed`](task.ja.md#markfailed) — プール p の失敗を 1 つ記帳する（Ledger の fail — 境界の API が「受けた仕事が error で終わった」を数える: net.Serve の handler の失敗）
- [`task.NewChannel`](task.ja.md#newchannel) — 容量 cap（1 以上の整数の字面）の有界のチャネルの端点の組
- [`task.NewLocal`](task.ja.md#newlocal) — T のストレージをワーカーの数だけ作る: `gzw := task.NewLocal((w mut flate.Work) => { pool.NewScratch(mut w.head, 1 << 15) … })`。
- [`task.NewPool`](task.ja.md#newpool) — 天井 budget バイトのプール（parent があればその下のノード — 入場は自分のノードから根のノードまで全部の天井を見る）
- [`task.NotLowered`](task.ja.md#notlowered) — 呼び出し点の写しが外れた柵（到達しない）
- [`task.Outcome`](task.ja.md#outcome) — task.Try の結果（死を値で見る — 監督の API）。
- [`task.Pool`](task.ja.md#pool) — 名前つきプール（テナント・エンドポイント — [language.md 11 節](../language.md)「天井の木」）のハンドル: task.SpawnIn の第 2 実引数。
- [`task.PoolLimit`](task.ja.md#poollimit) — プールのノードの表が尽きた（NewPool を POOL\_MAX 回より多く呼んだ）
- [`task.PoolView`](task.ja.md#poolview) — 台帳のプールのノードの 1 行（id = 作った順の番号・parent = 親の id〔-1 = 無し〕・used / tasks = 計上中のバイト / task の数）
- [`task.Receiver`](task.ja.md#receiver) — チャネルの受け端（Sender の対 — NewChannel が組で返す。
- [`task.Recv`](task.ja.md#recv) — 次の値（空なら待つ。
- [`task.RecvAll`](task.ja.md#recvall) — `for l <- task.Recv(rx) { … }` の写し先（loader が呼び先を付け替える — 閉じて空になるまで受けて k へ渡す）
- [`task.Run`](task.ja.md#run) — region を 1 段開き、本体 f をハンドルで走らせる。
- [`task.Scope`](task.ja.md#scope) — scope のハンドル（task.Run の本体の仮引数）
- [`task.Send`](task.ja.md#send) — v を送る（満杯なら待つ）
- [`task.Sender`](task.ja.md#sender) — Sender / Receiver はチャネルの端点（送り端・受け端 — 単一の task が持つ。
- [`task.Shed`](task.ja.md#shed) — task.SpawnIn の失敗: プール（か祖先のプール）の天井に入れなかった — 受けられない、という値（io の入力 — 兄弟の予算の返却時刻に依る）
- [`task.Spawn`](task.ja.md#spawn) — 子の task を生む（g の捕獲は imm のデータだけ・結果は scope の region へ写る）。
- [`task.SpawnGive`](task.ja.md#spawngive) — `Spawn(s, give: ep, (ep) => …)` の写し先（loader が呼び先を付け替える — 端点 ep をちょうど 1 つの子へ移す。
- [`task.SpawnIn`](task.ja.md#spawnin) — プール pool の天井に入れれば子の task を生む（handle, nil）・入れなければ (nil, Shed{})（縮退しない — shed を望む境界の API ・[language.md 11 節](../language.md)「shed」）。
- [`task.Try`](task.ja.md#try) — 子の結果を Outcome で（死は値）
- [`testing.AssertFailed`](testing.ja.md#assertfailed) — assert の失敗（panic ラベル — 欄なし: 式と部分式の値は Fail が前置で印字する。
- [`testing.Fail`](testing.ja.md#fail) — assert の失敗: `assert failed: <式>` と部分式の値を 1 行ずつ標準エラーへ書いて panic(AssertFailed{}) する（exit 101 — [language.md 27 節](../language.md)の panic の契約）
- [`tls.Alpn`](tls.ja.md#alpn) — 受ける ALPN をサーバの好みの順 alpn に替えた Config（空 = ALPN を使わない。
- [`tls.BadRecord`](tls.ja.md#badrecord) — 受けた record が壊れている（改竄・形の誤り・想定外のメッセージ — 相手へ alert を送って閉じた）
- [`tls.Closed`](tls.ja.md#closed) — 接続が閉じている（相手の切断・相手の alert・転送路の失敗・途中で抜けた後の Recv）
- [`tls.Config`](tls.ja.md#config) — サーバの設定（Load / Parse が作る — 証明書の鎖・葉の鍵・受ける ALPN）
- [`tls.Conn`](tls.ja.md#conn) — handshake の済んだ接続（同一性の型 — net.Conn と同じ規則。
- [`tls.Flush`](tls.ja.md#flush) — c の送りの束に積んだ record を送る（無ければ何もしない）
- [`tls.Handler`](tls.ja.md#handler) — handshake の済んだ接続 1 本の処理（名前つきの関数型 — 値として接続の task へ渡る。
- [`tls.HandshakeFailed`](tls.ja.md#handshakefailed) — handshake が失敗した（alert = 送った alert の番号 — RFC 9846 6）
- [`tls.Load`](tls.ja.md#load) — Parse のファイル版（certPath / keyPath を読む）
- [`tls.Overflow`](tls.ja.md#overflow) — 方向の語の列が席に入らない（std の内部の約束違反 — panic ラベル）
- [`tls.Parse`](tls.ja.md#parse) — PEM の証明書の鎖（CERTIFICATE が 1 つ以上 — 葉が先頭）と PKCS#8 の RSA の鍵の Config（ALPN の既定 = http/1.1 — 変えるなら Alpn）
- [`tls.Put`](tls.ja.md#put) — b を application の record にして c の送りの束に積む（送らない — Flush か、tls.Recv の k が戻ったときか、束に入らない次の Put か、Serve の出口が送る。
- [`tls.Recv`](tls.ja.md#recv) — c の受けた application の平文を k に順に渡す（呼び出し形の生成元 — `for b <- tls.Recv(c)? { … }`）。
- [`tls.Send`](tls.ja.md#send) — b を application の record にして c へ送る（空の b は送らない — Put + Flush）。
- [`tls.Serve`](tls.ja.md#serve) — addr で待ち受け、接続ごとに handshake を済ませてから k を走らせる（接続 1 本 = task 1 本 — net.Serve と同じ admission・k の失敗と死は吸収）。
- [`url.Bad`](url.ja.md#bad) — Unescape / ParseQuery の入力が読めない（'%' の後が 16 進の 2 桁でない・復号したバイト列が UTF-8 でない）
- [`url.Escape`](url.ja.md#escape) — s の percent-encoding（RFC 3986 2.3 の unreserved = 英数字と '-' '.' '\_' '~' はそのまま・他のバイトは "%XX" — 16 進は大文字 2.1。
- [`url.Pair`](url.ja.md#pair) — クエリの 1 組（ParseQuery の結果 — 書かれた順・同じ key も別の組）
- [`url.ParseQuery`](url.ja.md#parsequery) — クエリ文字列 s（先頭の '?' は含めない）の全部の組（'&' で切る・空の項目は飛ばす・'=' の無い項目は値 ""・key と value は '+' を空白に読んでからUnescape と同じ復号 — WHATWG URL の application/x-www-form-urlencoded の読み）。
- [`url.Unescape`](url.ja.md#unescape) — s の "%XX"（16 進は大小どちらも）を 1 バイトに戻した文字列（'+' はそのまま — 空白に読むのは ParseQuery だけ）
- [`utf8.Bytes`](utf8.ja.md#bytes) — View のバイト列（読むだけ）
- [`utf8.CHECK_GRAIN`](utf8.ja.md#check_grain) — 大きい入力の Check を区間に割って並列に検査するときの大きさ（バイト）。
- [`utf8.CHECK_PAR_MIN`](utf8.ja.md#check_par_min) — 大きい入力の Check を区間に割って並列に検査するときの大きさ（バイト）。
- [`utf8.Check`](utf8.ja.md#check) — b 全体を検査して View にする（不正なら最初の不正なシーケンスの位置の InvalidUtf8 — string(b) と同じ位置）
- [`utf8.Str`](utf8.ja.md#str) — v の [s, i) を検査し直さずに string にする。
- [`utf8.View`](utf8.ja.md#view) — 中身が有効な UTF-8 と検査済みのバイト列（型つき証人）。
- [`x25519.Base`](crypto-x25519.ja.md#base) — 秘密鍵 k（32 バイト — 短ければ添字の境界の panic・長い分は読まない）の公開鍵 = k × 9
- [`x25519.Shared`](crypto-x25519.ja.md#shared) — 秘密鍵 k（32 バイト — 内部で RFC 7748 の clamp を掛ける）と相手の u 座標（32 バイト — 最上位のビットは無視）の X25519。
