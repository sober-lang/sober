// 1BRC の Go の双子（同じアルゴリズム — 素直な形: 全体を読んで行ごとに分割・map[string] で集計・気温は ×10 の整数）。
// 平均は floor((2 × 和 + 件数) / (2 × 件数)) — 0.5 は正の方向へ丸める（Java の Math.round と同じ）。出力は名前のバイト順
package main

import (
	"bufio"
	"os"
	"sort"
	"strconv"
)

type stat struct{ min, max, sum, count int }

func floorDiv(a, b int) int {
	q := a / b
	if (a%b != 0) && ((a < 0) != (b < 0)) {
		q--
	}
	return q
}

func fmt10(out []byte, v int) []byte {
	if v < 0 {
		out = append(out, '-')
		v = -v
	}
	out = strconv.AppendInt(out, int64(v/10), 10)
	return append(out, '.', byte('0'+v%10))
}

func main() {
	b, err := os.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	m := map[string]*stat{}
	i := 0
	for i < len(b) {
		s := i
		for b[i] != ';' {
			i++
		}
		name := string(b[s:i])
		i++
		neg := false
		if b[i] == '-' {
			neg = true
			i++
		}
		t := 0
		for b[i] != '\n' {
			if b[i] != '.' {
				t = t*10 + int(b[i]-'0')
			}
			i++
		}
		i++
		if neg {
			t = -t
		}
		st := m[name]
		if st == nil {
			m[name] = &stat{t, t, t, 1}
		} else {
			if t < st.min {
				st.min = t
			}
			if t > st.max {
				st.max = t
			}
			st.sum += t
			st.count++
		}
	}
	names := make([]string, 0, len(m))
	for k := range m {
		names = append(names, k)
	}
	sort.Strings(names)
	out := []byte{'{'}
	for j, k := range names {
		if j > 0 {
			out = append(out, ',', ' ')
		}
		st := m[k]
		out = append(out, k...)
		out = append(out, '=')
		out = fmt10(out, st.min)
		out = append(out, '/')
		out = fmt10(out, floorDiv(2*st.sum+st.count, 2*st.count))
		out = append(out, '/')
		out = fmt10(out, st.max)
	}
	out = append(out, '}', '\n')
	w := bufio.NewWriter(os.Stdout)
	w.Write(out)
	w.Flush()
}
