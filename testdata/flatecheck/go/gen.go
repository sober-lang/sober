//go:build ignore

// flatecheck の Go の双子（report-1021）: Go の compress/flate・compress/gzip が符号化した列を固定の資料として書く（Go の符号器は zlib と別の実装 —
// BestSpeed の専用の符号器・HuffmanOnly・gzip の頭の欄〔Name・Comment・Extra〕と複数メンバ）。Sober の flate.Decode / gzip.Decode が解いて、
// check.ts が node:zlib で解いた結果と照合する。作り直し（Go の版で符号は変わりうる — 照合は内容でするので作り直さなくても網は保つ）:
//   cd testdata/flatecheck/go && go run gen.go
package main

import (
	"bytes"
	"compress/flate"
	"compress/gzip"
	"fmt"
	"os"
	"strings"
)

func words(n int) []byte {
	vocab := strings.Fields("the of and to in is was that for on are with as his they be at one have this from or had by word compression deflate huffman window distance length literal symbol block")
	var b bytes.Buffer
	x := uint64(88172645463325252)
	for b.Len() < n {
		x ^= x << 13
		x ^= x >> 7
		x ^= x << 17
		b.WriteString(vocab[x%uint64(len(vocab))])
		if x%11 == 0 {
			b.WriteByte('\n')
		} else {
			b.WriteByte(' ')
		}
	}
	return b.Bytes()[:n]
}

func rnd(n int) []byte {
	b := make([]byte, n)
	x := uint64(2463534242)
	for i := range b {
		x ^= x << 13
		x ^= x >> 7
		x ^= x << 17
		b[i] = byte(x >> 11)
	}
	return b
}

func must(err error) {
	if err != nil {
		panic(err)
	}
}

func raw(data []byte, level int) []byte {
	var b bytes.Buffer
	w, err := flate.NewWriter(&b, level)
	must(err)
	_, err = w.Write(data)
	must(err)
	must(w.Close())
	return b.Bytes()
}

func gz(data []byte, level int, hdr bool) []byte {
	var b bytes.Buffer
	w, err := gzip.NewWriterLevel(&b, level)
	must(err)
	if hdr {
		w.Name = "sober.txt"
		w.Comment = "flatecheck twin"
		w.Extra = []byte{'S', 'b', 3, 0, 1, 2, 3}
	}
	_, err = w.Write(data)
	must(err)
	must(w.Close())
	return b.Bytes()
}

func main() {
	ds, err := os.ReadFile("../../httpcheck/dataset.json")
	must(err)
	inputs := map[string][]byte{"dataset": ds, "words": words(20000), "rnd": rnd(9000), "zeros": make([]byte, 50000), "empty": {}}
	for name, data := range inputs {
		for _, lv := range []int{flate.HuffmanOnly, flate.NoCompression, flate.BestSpeed, 5, flate.BestCompression} {
			if lv == flate.NoCompression && len(data) > 20000 {
				continue
			}
			must(os.WriteFile(fmt.Sprintf("%s.%d.z", name, lv), raw(data, lv), 0o644))
			must(os.WriteFile(fmt.Sprintf("%s.%d.gz", name, lv), gz(data, lv, lv == 5), 0o644))
		}
	}
	// 複数メンバ（gzip(1) の cat a.gz b.gz の形）
	multi := append(gz(words(3000), 6, true), gz(rnd(500), 1, false)...)
	must(os.WriteFile("multi.gz", multi, 0o644))
}
