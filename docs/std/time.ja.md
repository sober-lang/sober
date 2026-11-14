# std/time

日本語

`import "std/time"`

時刻: 壁時計の Time（UNIX 時刻 — 秒 + ns・UTC）と経過を測る Instant（単調時計）を別の型で持つ（壁時計の差で期限を測る事故を型で消す）。壁時計を読むインターフェースはNowの1か所だけ — 時刻を使うstdのインターフェース（x509の検証・クッキーの期限など）はTimeを値で受ける（決定的・テストは値を渡す）。書式は RFC 3339（UTC か固定のオフセット）と HTTP の日付（IMF-fixdate — 読みは RFC 9110 5.6.7 の旧い 2 形も）。地域の時刻の規則（tzdata）は Zone

```sober
t := time.Now()
s := time.FormatRFC3339(t, 0)          // "2026-11-05T09:15:00Z"
u, _ := time.ParseHTTP("Sun, 06 Nov 1994 08:49:37 GMT")
start := time.Mono()
…
took := time.Since(start)                // ns
```

## FormatRFC3339

```sober
@effects()
func FormatRFC3339(t Time, offset int) string
```

t の RFC 3339（`YYYY-MM-DDThh:mm:ssZ`・オフセットが 0 でなければ末尾が `+hh:mm` の形・端数の秒があれば末尾の 0 を落として最大 9 桁）。offset は秒（東が正 — 分の単位に切り捨て・±23:59 まで）。年は 0000〜9999 の範囲で

## ParseRFC3339

```sober
@errors(Bad)
@effects()
func ParseRFC3339(s string) (Time, error?)
```

s（RFC 3339 の date-time — `T` / `t`・`Z` / `z` / ±hh:mm・端数の秒は 1〜9 桁）の時刻

失敗のラベル: [`Bad`](#bad)

## FormatHTTP

```sober
@effects()
func FormatHTTP(t Time) string
```

t の HTTP の日付（IMF-fixdate — `Sun, 06 Nov 1994 08:49:37 GMT`・RFC 9110 5.6.7。端数の秒は落とす）

## ParseHTTP

```sober
@errors(Bad)
@effects()
func ParseHTTP(s string) (Time, error?)
```

s の HTTP の日付（IMF-fixdate と、受け手が読む旧い 2 形 — rfc850 `Sunday, 06-Nov-94 08:49:37 GMT`〔2 桁の年は 70 未満を 20YY〕・asctime `Sun Nov  6 08:49:37 1994`。曜日の綴りは見るが日付との一致は問わない — RFC 9110 5.6.7）

失敗のラベル: [`Bad`](#bad)

## Nanosecond

```sober
const Nanosecond = 1
```

長さ（ns の int — 経過・期限の値）

## Microsecond

```sober
const Microsecond = 1000
```

長さ（ns の int — 経過・期限の値）

## Millisecond

```sober
const Millisecond = 1000000
```

長さ（ns の int — 経過・期限の値）

## Second

```sober
const Second = 1000000000
```

長さ（ns の int — 経過・期限の値）

## Minute

```sober
const Minute = 60000000000
```

長さ（ns の int — 経過・期限の値）

## Hour

```sober
const Hour = 3600000000000
```

長さ（ns の int — 経過・期限の値）

## Time

```sober
type Time struct {
    sec int
    nsec int
}
```

壁時計の時刻（UNIX時刻の秒と0〜999999999のns・UTC。作るのはNow・Unix・Parse… — フィールドを直に書くならnsは範囲の中で）

## Instant

```sober
type Instant struct {
    ns int
}
```

単調時計の読み（ns — 起点は不定で、同じプロセスの中の 2 つの差だけに意味がある）

## Bad

```sober
type Bad error
```

RFC 3339 / HTTP の日付が読めない

## Now

```sober
@effects(io)
func Now() Time
```

今の壁時計（CLOCK\_REALTIME — 調整で戻ることがある。経過を測るのは Mono。読み方は Mono と同じ vDSO）

## Mono

```sober
@effects(io)
func Mono() Instant
```

今の単調時計（CLOCK\_MONOTONIC — vDSO の \_\_vdso\_clock\_gettime で読み、カーネルへの syscall を伴わない。vDSO の無い環境では clock\_gettime(2)）

## Since

```sober
@effects(io)
func Since(start Instant) int
```

start からの経過（ns）

## Elapsed

```sober
@effects()
func Elapsed(a Instant, b Instant) int
```

b - a（ns）

## Unix

```sober
@effects()
func Unix(sec int, nsec int) Time
```

UNIX 時刻 sec 秒 + nsec ns（nsec は範囲の外でも繰り上げ / 繰り下げる）

## UnixSec

```sober
@effects()
func UnixSec(t Time) int
```

t の UNIX 時刻の秒（端数は切り捨て — 1970 年より前は負）

## Nano

```sober
@effects()
func Nano(t Time) int
```

t の秒の端数（0〜999999999 ns）

## Add

```sober
@effects()
func Add(t Time, d int) Time
```

t + d（d は ns — 負も可）

## Sub

```sober
@effects()
func Sub(a Time, b Time) int
```

a - b（ns）

## Before

```sober
@effects()
func Before(a Time, b Time) bool
```

a が b より前か

## Equal

```sober
@effects()
func Equal(a Time, b Time) bool
```

a と b が同じ時刻か

## Civil

```sober
type Civil struct {
    year int
    month int
    day int
    hour int
    minute int
    second int
    nsec int
    weekday int
}
```

暦の上の日時（UTC からのオフセット offset 秒を足した壁の読み — weekday は 0 = 日曜〜6 = 土曜）

## ToCivil

```sober
@effects()
func ToCivil(t Time, offset int) Civil
```

t をオフセット offset 秒（東が正 — 日本は 9 × 3600）の暦の日時に

## FromCivil

```sober
@effects()
func FromCivil(c Civil, offset int) Time
```

暦の日時 c（オフセット offset 秒の壁の読み）の時刻。月日・時分秒の範囲は検査しない（呼び手の値 — 範囲の外は繰り上がる）

## UnknownZone

```sober
type UnknownZone error
```

ゾーンの名前が焼き込みの表に無い

## Zone

```sober
type Zone struct {
    name string
    offs []int
    dsts []bool
    abbrs []string
    times []int
    idx []int
    hasRule bool
    rule Rule
}
```

地域の時刻の規則

## Rule

```sober
type Rule struct {
    stdOff int
    stdAbbr string
    hasDst bool
    dstOff int
    dstAbbr string
    start RuleDate
    end RuleDate
}
```

POSIX TZ の規則（offset は UTC からの秒 — 東が正）

## RuleDate

```sober
type RuleDate struct {
    kind int
    n int
    m int
    w int
    d int
    secs int
}
```

規則の切り替えの日（kind 0 = Jn〔2 月 29 日を数えない 1〜365〕・1 = n〔0〜365〕・2 = Mm.w.d）と地方時のその日の中の秒

## UTC

```sober
@effects()
func UTC() Zone
```

UTC（遷移も夏時間も無い）

## ZoneName

```sober
@effects()
func ZoneName(z Zone) string
```

ゾーンの名前（IANA の名前 — 別名で読んだら正の名前）

## LoadZone

```sober
@errors(UnknownZone)
@effects()
func LoadZone(name string) (Zone, error?)
```

焼き込みの表のゾーン name（`Asia/Tokyo` の IANA の名前・別名〔`Japan` など〕も引ける。"UTC" は UTC）

失敗のラベル: [`UnknownZone`](#unknownzone)

## OffsetAt

```sober
@effects()
func OffsetAt(z Zone, t Time) int
```

t のゾーン z でのオフセット（秒 — 東が正）

## AbbrAt

```sober
@effects()
func AbbrAt(z Zone, t Time) string
```

t のゾーン z での略称（JST・PDT など — 略称の無い地域は `+09` の形）

## DstAt

```sober
@effects()
func DstAt(z Zone, t Time) bool
```

t がゾーン z で夏時間か

## ToCivilIn

```sober
@effects()
func ToCivilIn(t Time, z Zone) Civil
```

t のゾーン z での暦の日時

## FromCivilIn

```sober
@effects()
func FromCivilIn(c Civil, z Zone) Time
```

ゾーン z の壁の読み c の時刻。夏時間の切り替えで 2 回ある読みは前の方（切り替え前のオフセット）・無い読みは切り替え前のオフセットで読んだ時刻（壁の時計で後ろへずれる）
