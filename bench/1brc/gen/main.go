// 1BRC の入力生成（決定的 — 自前の xorshift。公式の weather_stations.csv は使わず、413 個の合成の観測所名と平均気温を作る）。
// 使い方: go run ./1brc/gen <行数> <出力>   行 = "<名前>;<気温>"（気温は -99.9〜99.9・小数 1 桁）
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

type rng struct{ s uint64 }

func (r *rng) next() uint64 {
	r.s ^= r.s << 13
	r.s ^= r.s >> 7
	r.s ^= r.s << 17
	return r.s
}

func (r *rng) intn(n int) int { return int(r.next() % uint64(n)) }

var sylls = []string{"ka", "lo", "mi", "ra", "no", "sé", "tü", "va", "be", "zo", "an", "ri", "東", "京", "ma", "do", "ño", "el", "us", "qi"}

func stations(r *rng) ([]string, []int) {
	seen := map[string]bool{}
	var names []string
	var means []int
	for len(names) < 413 {
		n := 2 + r.intn(4)
		s := ""
		for i := 0; i < n; i++ {
			s += sylls[r.intn(len(sylls))]
		}
		if seen[s] {
			continue
		}
		seen[s] = true
		names = append(names, s)
		means = append(means, r.intn(500)-200) // 平均 -20.0〜29.9（×10）
	}
	return names, means
}

func main() {
	if len(os.Args) != 3 {
		fmt.Fprintln(os.Stderr, "usage: gen <rows> <out>")
		os.Exit(2)
	}
	rows, err := strconv.Atoi(os.Args[1])
	if err != nil {
		panic(err)
	}
	f, err := os.Create(os.Args[2])
	if err != nil {
		panic(err)
	}
	w := bufio.NewWriterSize(f, 1<<20)
	r := &rng{s: 0x9e3779b97f4a7c15}
	names, means := stations(r)
	buf := make([]byte, 0, 64)
	for i := 0; i < rows; i++ {
		k := r.intn(len(names))
		// 平均 ± 和 4 本の一様（-20.0〜+20.0 の山形）
		t := means[k] + r.intn(101) + r.intn(101) + r.intn(101) + r.intn(101) - 200
		if t > 999 {
			t = 999
		}
		if t < -999 {
			t = -999
		}
		buf = append(buf[:0], names[k]...)
		buf = append(buf, ';')
		if t < 0 {
			buf = append(buf, '-')
			t = -t
		}
		buf = strconv.AppendInt(buf, int64(t/10), 10)
		buf = append(buf, '.', byte('0'+t%10), '\n')
		w.Write(buf)
	}
	if err := w.Flush(); err != nil {
		panic(err)
	}
	f.Close()
}
