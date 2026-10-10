// k-nucleotide の Go の双子（Benchmarks Game の仕様 — 素直な形: fasta の出力から ">THREE" の配列を大文字で取り出し、長さ k の部分列ごとの
// 出現数を map で数える。k = 1, 2 は頻度の降順〔同数はキーの昇順〕に百分率〔小数 3 桁〕・指定の 5 本は出現数）。入力はファイル
package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
	"sort"
)

// frequencies は seq の長さ k の部分列ごとの出現数
func frequencies(seq []byte, k int) map[string]int {
	m := map[string]int{}
	for i := 0; i+k <= len(seq); i++ {
		m[string(seq[i:i+k])]++
	}
	return m
}

func main() {
	b, err := os.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	i := 0
	for !bytes.HasPrefix(b[i:], []byte(">THREE")) {
		for b[i] != '\n' {
			i++
		}
		i++
	}
	for b[i] != '\n' {
		i++
	}
	i++
	seq := []byte{}
	for i < len(b) && b[i] != '>' {
		c := b[i]
		if c != '\n' {
			if c >= 'a' && c <= 'z' {
				c -= 32
			}
			seq = append(seq, c)
		}
		i++
	}
	out := bufio.NewWriter(os.Stdout)
	defer out.Flush()
	for k := 1; k <= 2; k++ {
		m := frequencies(seq, k)
		keys := make([]string, 0, len(m))
		for key := range m {
			keys = append(keys, key)
		}
		sort.Slice(keys, func(x, y int) bool {
			if m[keys[x]] != m[keys[y]] {
				return m[keys[x]] > m[keys[y]]
			}
			return keys[x] < keys[y]
		})
		total := len(seq) - k + 1
		for _, key := range keys {
			fmt.Fprintf(out, "%s %.3f\n", key, 100*float64(m[key])/float64(total))
		}
		out.WriteString("\n")
	}
	for _, s := range []string{"GGT", "GGTA", "GGTATT", "GGTATTTTAATT", "GGTATTTTAATTTATAGT"} {
		m := frequencies(seq, len(s))
		fmt.Fprintf(out, "%d\t%s\n", m[s], s)
	}
}
