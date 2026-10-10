// fasta の Go の双子（Benchmarks Game の仕様 — 素直な形: ALU の繰り返し・線形合同法の乱数で 2 つの表から選ぶ。1 行 60 文字）。
// 乱数は max * last / IM の浮動小数・表は累積確率（Sober 側は float が無いので同じ選択を整数の閾値で — bench/fasta/main.sober）
package main

import (
	"bufio"
	"os"
	"strconv"
)

const (
	IM    = 139968
	IA    = 3877
	IC    = 29573
	WIDTH = 60
)

var last = 42

func random(max float64) float64 {
	last = (last*IA + IC) % IM
	return max * float64(last) / IM
}

type acid struct {
	prob float64
	sym  byte
}

const alu = "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" +
	"GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
	"CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
	"ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
	"GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
	"AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
	"AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"

var iub = []acid{
	{0.27, 'a'}, {0.12, 'c'}, {0.12, 'g'}, {0.27, 't'},
	{0.02, 'B'}, {0.02, 'D'}, {0.02, 'H'}, {0.02, 'K'},
	{0.02, 'M'}, {0.02, 'N'}, {0.02, 'R'}, {0.02, 'S'},
	{0.02, 'V'}, {0.02, 'W'}, {0.02, 'Y'},
}

var homosapiens = []acid{
	{0.3029549426680, 'a'}, {0.1979883004921, 'c'}, {0.1975473066391, 'g'}, {0.3015094502008, 't'},
}

func accumulate(genes []acid) {
	for i := 1; i < len(genes); i++ {
		genes[i].prob += genes[i-1].prob
	}
}

var out *bufio.Writer

func repeatFasta(s string, count int) {
	pos := 0
	for count > 0 {
		line := min(WIDTH, count)
		for j := 0; j < line; j++ {
			out.WriteByte(s[pos])
			pos++
			if pos == len(s) {
				pos = 0
			}
		}
		out.WriteByte('\n')
		count -= line
	}
}

func randomFasta(genes []acid, count int) {
	for count > 0 {
		line := min(WIDTH, count)
		for j := 0; j < line; j++ {
			r := random(1.0)
			i := 0
			for genes[i].prob < r {
				i++
			}
			out.WriteByte(genes[i].sym)
		}
		out.WriteByte('\n')
		count -= line
	}
}

func main() {
	n := 1000
	if len(os.Args) > 1 {
		n, _ = strconv.Atoi(os.Args[1])
	}
	out = bufio.NewWriterSize(os.Stdout, 1<<16)
	defer out.Flush()
	accumulate(iub)
	accumulate(homosapiens)
	out.WriteString(">ONE Homo sapiens alu\n")
	repeatFasta(alu, 2*n)
	out.WriteString(">TWO IUB ambiguity codes\n")
	randomFasta(iub, 3*n)
	out.WriteString(">THREE Homo sapiens frequency\n")
	randomFasta(homosapiens, 5*n)
}
