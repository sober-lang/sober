// logagg の Go の双子（素直形 — Sober 版と同じ手書きの規則）: bufio.Scanner で行 → 手のバイトループで語に割る（引用符の中の空白は割らない・
// 引用符の中の \ は次の 1 バイトを守る）→ 鍵と値 → 欄を名前で引く → ts（RFC 3339 の部分集合）を手書きで epoch 秒に → 1 分の固定窓 × svc の
// 配列に集計・ユーザーは map[string]int。時刻の parse は 3 言語同じ手書き（time.Parse は使わない — report-448 裁定 A）。出力は Sober 版とバイト一致
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

const W = 1442 // 分の窓の数（起点の 1 分前から 24 時間 + 1 分）
const H = 24   // 遅延のヒストグラムの箱（log2）

var svcs = []string{"api", "auth", "orders", "payments", "search", "catalog", "users", "static"}
var levels = []string{"debug", "info", "warn", "error"}

func fnv(h int64, s string) int64 {
	for i := 0; i < len(s); i++ {
		h = (h ^ int64(s[i])) * 1099511628211
	}
	return h
}

// num は s[a:a+n] の 10 進（数でない byte があれば -1）
func num(s string, a int, n int) int {
	v := 0
	for i := a; i < a+n; i++ {
		c := s[i]
		if c < '0' || c > '9' {
			return -1
		}
		v = v*10 + int(c-'0')
	}
	return v
}

func atoi(s string) int {
	if len(s) == 0 {
		return -1
	}
	return num(s, 0, len(s))
}

func leap(y int) bool { return y%4 == 0 && (y%100 != 0 || y%400 == 0) }

func dim(y int, m int) int {
	if m == 2 {
		if leap(y) {
			return 29
		}
		return 28
	}
	if m == 4 || m == 6 || m == 9 || m == 11 {
		return 30
	}
	return 31
}

// days は 1970-01-01 からの日数（Howard Hinnant の days_from_civil）
func days(y int, m int, d int) int {
	if m <= 2 {
		y -= 1
	}
	yy := y
	if yy < 0 {
		yy -= 399
	}
	era := yy / 400
	yoe := y - era*400
	doy := (153*((m+9)%12)+2)/5 + d - 1
	doe := yoe*365 + yoe/4 - yoe/100 + doy
	return era*146097 + doe - 719468
}

// parseTs は `YYYY-MM-DDTHH:MM:SS[.f{1,9}](Z|±HH:MM)` を (ok, epoch 秒, ナノ秒) に
func parseTs(s string) (bool, int, int) {
	n := len(s)
	if n < 20 || s[4] != '-' || s[7] != '-' || s[10] != 'T' || s[13] != ':' || s[16] != ':' {
		return false, 0, 0
	}
	y, mo, d := num(s, 0, 4), num(s, 5, 2), num(s, 8, 2)
	hh, mi, ss := num(s, 11, 2), num(s, 14, 2), num(s, 17, 2)
	if y < 0 || mo < 1 || mo > 12 || d < 1 || d > dim(y, mo) || hh < 0 || hh > 23 || mi < 0 || mi > 59 || ss < 0 || ss > 59 {
		return false, 0, 0
	}
	i := 19
	ns := 0
	if s[i] == '.' {
		i++
		k := 0
		for i < n && s[i] >= '0' && s[i] <= '9' && k < 9 {
			ns = ns*10 + int(s[i]-'0')
			i++
			k++
		}
		if k == 0 {
			return false, 0, 0
		}
		for ; k < 9; k++ {
			ns *= 10
		}
	}
	off := 0
	if i < n && s[i] == 'Z' {
		i++
	} else if i+6 <= n && (s[i] == '+' || s[i] == '-') && s[i+3] == ':' {
		oh, om := num(s, i+1, 2), num(s, i+4, 2)
		if oh < 0 || oh > 23 || om < 0 || om > 59 {
			return false, 0, 0
		}
		off = oh*3600 + om*60
		if s[i] == '-' {
			off = -off
		}
		i += 6
	} else {
		return false, 0, 0
	}
	if i != n {
		return false, 0, 0
	}
	return true, days(y, mo, d)*86400 + hh*3600 + mi*60 + ss - off, ns
}

// unq は値の引用符を外したときのバイト数（\ は次の 1 バイトを守る）
func unq(v string) int {
	if len(v) < 2 || v[0] != '"' {
		return len(v)
	}
	k := 0
	for i := 1; i < len(v)-1; i++ {
		if v[i] == '\\' {
			i++
		}
		k++
	}
	return k
}

func main() {
	f, err := os.Open(os.Args[1])
	if err != nil {
		os.Exit(1)
	}
	sc := bufio.NewScanner(f)
	sc.Buffer(make([]byte, 1<<16), 1<<20)
	base := days(2026, 10, 10) * 86400
	cnt := make([]int, W*8)
	c4 := make([]int, W*8)
	c5 := make([]int, W*8)
	dsum := make([]int, W*8)
	dmax := make([]int, W*8)
	hist := make([]int, 8*H)
	lv := make([]int, 4)
	users := map[string]int{}
	var lines, bQuote, bNoeq, bNots, bTs, bStatus, bRange, bSvc, msgBytes, pathBytes, nsSum int
	for sc.Scan() {
		line := sc.Text()
		lines++
		e := len(line)
		var ts, level, svc, status, dur, user, msg, path string
		hasTs, hasUser := false, false
		bad := 0 // 1 quote 2 noeq
		pos := 0
		for pos < e && bad == 0 {
			j := pos
			inq := false
			eq := -1
			for j < e {
				c := line[j]
				if inq {
					if c == '\\' {
						j += 2
						continue
					}
					if c == '"' {
						inq = false
					}
				} else {
					if c == ' ' {
						break
					}
					if c == '"' {
						inq = true
					} else if c == '=' && eq < 0 {
						eq = j
					}
				}
				j++
			}
			if inq {
				bad = 1
			} else if eq < 0 {
				bad = 2
			} else {
				k := line[pos:eq]
				v := line[eq+1 : j]
				if k == "ts" {
					ts = v
					hasTs = true
				} else if k == "level" {
					level = v
				} else if k == "svc" {
					svc = v
				} else if k == "status" {
					status = v
				} else if k == "dur_us" {
					dur = v
				} else if k == "user" {
					user = v
					hasUser = true
				} else if k == "msg" {
					msg = v
				} else if k == "path" {
					path = v
				}
			}
			pos = j + 1
		}
		if bad == 1 {
			bQuote++
			continue
		}
		if bad == 2 {
			bNoeq++
			continue
		}
		if !hasTs {
			bNots++
			continue
		}
		ok, sec, ns := parseTs(ts)
		if !ok {
			bTs++
			continue
		}
		st := atoi(status)
		if st < 0 {
			bStatus++
			continue
		}
		si := -1
		for k := range svcs {
			if svcs[k] == svc {
				si = k
			}
		}
		if si < 0 {
			bSvc++
			continue
		}
		rel := sec - base + 60
		if rel < 0 || rel >= W*60 {
			bRange++
			continue
		}
		c := rel/60*8 + si
		cnt[c]++
		if st >= 400 && st < 500 {
			c4[c]++
		}
		if st >= 500 && st < 600 {
			c5[c]++
		}
		d := atoi(dur)
		dsum[c] += d
		if d > dmax[c] {
			dmax[c] = d
		}
		bk := 0
		for bk < H-1 && d>>bk > 0 {
			bk++
		}
		hist[si*H+bk]++
		for k := range levels {
			if levels[k] == level {
				lv[k]++
			}
		}
		if hasUser {
			users[user]++
		}
		msgBytes += unq(msg)
		pathBytes += len(path)
		nsSum += ns
	}
	out := bufio.NewWriter(os.Stdout)
	fmt.Fprintf(out, "lines %d\n", lines)
	fmt.Fprintf(out, "bad quote %d noeq %d nots %d ts %d status %d svc %d range %d\n", bQuote, bNoeq, bNots, bTs, bStatus, bSvc, bRange)
	for k := range levels {
		fmt.Fprintf(out, "level %s %d\n", levels[k], lv[k])
	}
	for si := range svcs {
		n, n4, n5, ds, dm := 0, 0, 0, 0, 0
		for m := 0; m < W; m++ {
			c := m*8 + si
			n += cnt[c]
			n4 += c4[c]
			n5 += c5[c]
			ds += dsum[c]
			if dmax[c] > dm {
				dm = dmax[c]
			}
		}
		// p99 の箱: 累積が 99% に届く最初の箱
		p99, cum := 0, 0
		for bk := 0; bk < H; bk++ {
			cum += hist[si*H+bk]
			if cum*100 >= n*99 {
				p99 = bk
				break
			}
		}
		// 滑り窓: 直近 5 分の 5xx が 5% を超えた分の数
		alarms := 0
		for m := 4; m < W; m++ {
			wn, w5 := 0, 0
			for k := m - 4; k <= m; k++ {
				wn += cnt[k*8+si]
				w5 += c5[k*8+si]
			}
			if wn > 0 && w5*100 > wn*5 {
				alarms++
			}
		}
		fmt.Fprintf(out, "svc %s %d 4xx %d 5xx %d dur_sum %d dur_max %d p99_bucket %d alarms %d\n", svcs[si], n, n4, n5, ds, dm, p99, alarms)
	}
	umax := 0
	var uh int64
	for u, c := range users {
		if c > umax {
			umax = c
		}
		uh += fnv(fnv(fnv(-3750763034362895579, u), "="), strconv.Itoa(c))
	}
	fmt.Fprintf(out, "users %d max %d hash %d\n", len(users), umax, uh)
	fmt.Fprintf(out, "msg_bytes %d\n", msgBytes)
	fmt.Fprintf(out, "path_bytes %d\n", pathBytes)
	fmt.Fprintf(out, "ns_sum %d\n", nsSum)
	h := int64(-3750763034362895579)
	for m := 0; m < W; m++ {
		for si := 0; si < 8; si++ {
			c := m*8 + si
			if cnt[c] > 0 {
				h = fnv(h, fmt.Sprintf("%d %d %d %d %d %d\n", m, si, cnt[c], c5[c], dsum[c], dmax[c]))
			}
		}
	}
	fmt.Fprintf(out, "hash %d\n", h)
	out.Flush()
}
