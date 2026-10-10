// 1BRC の並列版の Go の双子（段 6 P4-6 — Sober の bench/1brcpar と同じ分け方: 行の切れ目で 64 区間・区間ごとに goroutine と自分の map・
// 生んだ順に合わせる）。公式が最初に教える形 = goroutine + sync.WaitGroup + 区間ごとの結果の欄（チューンしない）。並列度は GOMAXPROCS
package main

import (
	"bufio"
	"os"
	"sort"
	"strconv"
	"sync"
)

const nchunk = 64

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

func part(b []byte, lo, hi int) map[string]*stat {
	m := map[string]*stat{}
	i := lo
	for i < hi {
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
	return m
}

func main() {
	b, err := os.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	bounds := []int{0}
	for k := 1; k < nchunk; k++ {
		p := k * len(b) / nchunk
		if p < bounds[len(bounds)-1] {
			p = bounds[len(bounds)-1]
		}
		for p < len(b) && b[p-1] != '\n' {
			p++
		}
		bounds = append(bounds, p)
	}
	bounds = append(bounds, len(b))
	parts := make([]map[string]*stat, nchunk)
	var wg sync.WaitGroup
	for k := 0; k < nchunk; k++ {
		wg.Add(1)
		go func(k int) {
			defer wg.Done()
			parts[k] = part(b, bounds[k], bounds[k+1])
		}(k)
	}
	wg.Wait()
	m := map[string]*stat{}
	for _, pm := range parts {
		for name, ps := range pm {
			st := m[name]
			if st == nil {
				c := *ps
				m[name] = &c
			} else {
				if ps.min < st.min {
					st.min = ps.min
				}
				if ps.max > st.max {
					st.max = ps.max
				}
				st.sum += ps.sum
				st.count += ps.count
			}
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
