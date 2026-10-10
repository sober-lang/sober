// reverse-complement の Go の双子（Benchmarks Game の仕様 — 素直な形: 全体を読み、記録〔'>' の見出し行 + 配列の行〕ごとに
// 見出しはそのまま・配列は改行を除いて逆順の相補にして 1 行 60 文字で書く）。入力はファイル（fasta の出力 — bench.sh が作る）
package main

import (
	"bufio"
	"os"
)

func main() {
	b, err := os.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	var comp [256]byte
	for i := range comp {
		comp[i] = byte(i)
	}
	from := "ACBDGHKMNSRUTWVYacbdghkmnsrutwvy"
	to := "TGVHCDMKNSYAAWBRTGVHCDMKNSYAAWBR"
	for i := 0; i < len(from); i++ {
		comp[from[i]] = to[i]
	}
	out := bufio.NewWriterSize(os.Stdout, 1<<16)
	defer out.Flush()
	i := 0
	for i < len(b) {
		s := i
		for b[i] != '\n' {
			i++
		}
		i++
		out.Write(b[s:i])
		hs := i
		for i < len(b) && b[i] != '>' {
			i++
		}
		col := 0
		for k := i - 1; k >= hs; k-- {
			c := b[k]
			if c != '\n' {
				out.WriteByte(comp[c])
				col++
				if col == 60 {
					out.WriteByte('\n')
					col = 0
				}
			}
		}
		if col > 0 {
			out.WriteByte('\n')
		}
	}
}
