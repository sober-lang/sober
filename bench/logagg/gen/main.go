// bench/logagg の入力の生成（決定的 — 線形合同法・シード 42）: 引数 N 行のアクセスログ（logfmt — `key=value` を空白で区切る・引用符つきの値あり）を
// 第 2 引数のファイルへ。時刻は 2026-10-10T00:00:00Z からの 24 時間に単調に進め、行ごとに 0〜3 秒の後退の揺れを足す。
// 書式は RFC 3339 の部分集合（小数秒 無し / 3 / 6 / 9 桁・地域差 Z / +09:00 / -05:00 / +05:30）。ts は常に先頭・他の欄は 30% の行で順を回す。
// 約 2% は不正な行（1 行に欠陥 1 つ: ts 欠落・ts の値の不正・= の無い語・閉じない引用符・status が数でない）
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

var seed = uint64(42)

func next() uint64 {
	seed = seed*6364136223846793005 + 1442695040888963407
	return seed >> 33
}

func pick(xs []string) string { return xs[next()%uint64(len(xs))] }

var svcs = []string{"api", "auth", "orders", "payments", "search", "catalog", "users", "static"}
var methods = []string{"GET", "GET", "GET", "POST", "PUT", "DELETE"}
var msgs = []string{
	`"ok"`,
	`"order fetched"`,
	`"cache miss for key"`,
	`"user \"alice\" logged in"`,
	`"retrying upstream call"`,
	`"wrote C:\\tmp\\out.json"`,
	`"slow query: SELECT * FROM t WHERE a = \"x\""`,
	`"done"`,
}
var offs = []int{0, 9 * 3600, -5 * 3600, 5*3600 + 1800}

// ts は epoch 秒 t とナノ秒 ns を、地域差 off（秒）・小数秒の桁 digits で書く
func ts(t int64, ns int, off int, digits int) string {
	c := time.Unix(t+int64(off), 0).UTC()
	s := fmt.Sprintf("%04d-%02d-%02dT%02d:%02d:%02d", c.Year(), int(c.Month()), c.Day(), c.Hour(), c.Minute(), c.Second())
	if digits > 0 {
		f := fmt.Sprintf("%09d", ns)
		s += "." + f[:digits]
	}
	if off == 0 {
		return s + "Z"
	}
	sign := "+"
	if off < 0 {
		sign = "-"
		off = -off
	}
	return s + fmt.Sprintf("%s%02d:%02d", sign, off/3600, off/60%60)
}

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	f, err := os.Create(os.Args[2])
	if err != nil {
		panic(err)
	}
	w := bufio.NewWriterSize(f, 1<<20)
	base := time.Date(2026, 10, 10, 0, 0, 0, 0, time.UTC).Unix()
	for i := 0; i < n; i++ {
		t := base + int64(i)*86400/int64(n) - int64(next()%4)
		digits := []int{0, 3, 6, 9}[next()%4]
		ns := int(next() % 1000000000)
		switch digits {
		case 0:
			ns = 0
		case 3:
			ns -= ns % 1000000
		case 6:
			ns -= ns % 1000
		}
		off := offs[next()%uint64(len(offs))]
		si := int(next() % uint64(len(svcs)))
		svc := svcs[si]
		minute := int((t - base) / 60)
		// 5xx: 平常 1%・障害の山（payments 600〜609 分 35%・search 1200〜1214 分 25%）
		p5 := 10
		if (svc == "payments" && minute >= 600 && minute < 610) || (svc == "search" && minute >= 1200 && minute < 1215) {
			if svc == "payments" {
				p5 = 350
			} else {
				p5 = 250
			}
		}
		st := 200
		switch r := int(next() % 1000); {
		case r < p5:
			st = []int{500, 502, 503, 504}[next()%4]
		case r < p5+90:
			st = []int{400, 401, 403, 404, 429}[next()%5]
		default:
			st = []int{200, 200, 200, 201, 204, 304}[next()%6]
		}
		// dur_us: 対数で三角分布（100 × 2^(0..13) + 揺れ — 100〜1,638,399）
		dur := 100
		for k := next()%8 + next()%7; k > 0; k-- {
			dur = dur * 2
		}
		dur += int(next() % uint64(dur))
		fields := []string{
			"level=" + []string{"debug", "info", "info", "info", "info", "info", "info", "info", "warn", "error"}[next()%10],
			"svc=" + svc,
			"method=" + pick(methods),
			"path=/api/v1/" + svc + "/" + strconv.Itoa(int(next()%100000)),
			"status=" + strconv.Itoa(st),
			"dur_us=" + strconv.Itoa(dur),
		}
		if next()%100 >= 15 {
			r := next() % 50000
			fields = append(fields, fmt.Sprintf("user=u%06d", r*r/50000))
		}
		fields = append(fields, "msg="+pick(msgs))
		if next()%100 < 20 {
			fields = append(fields, fmt.Sprintf("trace=%016x", next()<<31|next()))
		}
		if next()%100 < 30 {
			k := int(next() % uint64(len(fields)))
			fields = append(fields[k:], fields[:k]...)
		}
		tsf := "ts=" + ts(t, ns, off, digits)
		// 不正な行（約 2% — 1 行に欠陥 1 つ）
		if next()%100 < 2 {
			switch next() % 5 {
			case 0: // ts 欠落
				tsf = ""
			case 1: // ts の値の不正
				bad := []string{"2026-13-10T09:00:00Z", "2026-10-32T09:00:00Z", "2026-02-29T09:00:00Z", "2026-10-10T24:00:00Z", "2026-10-10T09:12:3Z", "2026-10-10T09:12:34.Z", "2026-10-10 09:12:34Z", "2026-10-10T09:12:34+9:00"}
				tsf = "ts=" + pick(bad)
			case 2: // = の無い語
				k := int(next() % uint64(len(fields)+1))
				fields = append(fields[:k], append([]string{"oops"}, fields[k:]...)...)
			case 3: // 閉じない引用符（行末まで）
				fields = append(fields, `note="unterminated value`)
			case 4: // status が数でない
				for k := range fields {
					if strings.HasPrefix(fields[k], "status=") {
						fields[k] = "status=2x0"
					}
				}
			}
		}
		if tsf != "" {
			fields = append([]string{tsf}, fields...)
		}
		w.WriteString(strings.Join(fields, " "))
		w.WriteByte('\n')
	}
	w.Flush()
	f.Close()
}
