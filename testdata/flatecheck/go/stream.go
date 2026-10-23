//go:build ignore

// 逐次の符号器の計測の Go の双子（段 8-4b — testdata/flatecheck/streambench.sh）: std/internal/deflate の TestStreamBench と同じ入力（text(1 MiB, 5) — 同じ LCG）・
// 同じ切り方で、応答ごとに gzip.NewWriterLevel・切片ごとに Write + Flush（sync flush — Sober の Feed と同じ 00 00 ff ff）・Close。
//   go run stream.go <切片のバイト数> <回数> [level]
package main

import (
	"bytes"
	"compress/gzip"
	"fmt"
	"os"
	"strconv"
)

func text(n int, seed int) []byte {
	w := []byte("sober deflate stream window sync flush huffman lazy greedy ")
	b := make([]byte, 0, n)
	x := seed
	for i := 0; i < n; i++ {
		x = (x*1103515245 + 12345) & 0x7fffffff
		if x%11 == 0 {
			b = append(b, byte((x>>8)&255))
		} else {
			b = append(b, w[(i+seed)%len(w)])
		}
	}
	return b
}

func main() {
	cut, _ := strconv.Atoi(os.Args[1])
	reps, _ := strconv.Atoi(os.Args[2])
	lv := 6
	if len(os.Args) > 3 {
		lv, _ = strconv.Atoi(os.Args[3])
	}
	d := text(1<<20, 5)
	total := 0
	var buf bytes.Buffer
	for r := 0; r < reps; r++ {
		buf.Reset()
		z, _ := gzip.NewWriterLevel(&buf, lv)
		for at := 0; at < len(d); at += cut {
			nx := min(at+cut, len(d))
			z.Write(d[at:nx])
			z.Flush()
		}
		z.Close()
		total += buf.Len()
	}
	if reps == 0 {
		reps = 1
	}
	fmt.Printf("bench cut %d reps %d level %d out %d\n", cut, reps, lv, total/reps)
}
