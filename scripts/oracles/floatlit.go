// floatlit.go — 浮動小数リテラルの差分オラクル（float の段 — language.md 37 節）: 境界 38 本 + 乱択 N 本のリテラルを書いた Sober ファイル lits.sober と、
// Go の strconv.ParseFloat のビット列（i64 で読んだ値）want.txt を作る。照合は AST JSON の "bits" と比べる:
//   go run scripts/oracles/floatlit.go 20000 && out/stage2/sober2 parse --ast-json lits.sober | grep -o '"bits": *-\?[0-9]*' | sed 's/.*: *//' | diff - want.txt
// （溢れ〔Go が Inf〕は Sober が構文で拒否するので出さない — 拒否は lexer_test / 例の負例が見る）
package main

import (
	"fmt"
	"math"
	"math/rand"
	"os"
	"strconv"
	"strings"
)

func lit(r *rand.Rand) string {
	nd := 1 + r.Intn(25)
	var sb strings.Builder
	for i := 0; i < nd; i++ {
		d := r.Intn(10)
		if i == 0 && d == 0 {
			d = 1 + r.Intn(9)
		}
		sb.WriteByte(byte('0' + d))
	}
	ds := sb.String()
	// 小数点の位置
	var s string
	if r.Intn(3) > 0 && nd > 1 {
		p := 1 + r.Intn(nd-1)
		s = ds[:p] + "." + ds[p:]
	} else if r.Intn(2) == 0 {
		s = "0." + ds
	} else {
		s = ds + ".0"
	}
	if r.Intn(2) == 0 {
		e := r.Intn(680) - 350
		s += fmt.Sprintf("e%d", e)
	}
	return s
}

func main() {
	r := rand.New(rand.NewSource(int64(len(os.Args[1]))))
	n, _ := strconv.Atoi(os.Args[1])
	edges := []string{"0.0", "1.0", "0.1", "0.2", "0.3", "1e23", "8.98846567431158e307", "1.7976931348623157e308", "1.7976931348623158e308",
		"2.2250738585072011e-308", "2.2250738585072012e-308", "2.2250738585072014e-308", "4.9406564584124654e-324", "4.9e-324", "2.4703282292062327e-324",
		"2.4703282292062328e-324", "1e-400", "9007199254740993.0", "9007199254740995.0", "9007199254740992.0", "123456789012345678901234567890.0",
		"0.000001", "1e0", "3.0e-0", "1E10", "1e+10", "6.02214076e23", "2.718281828459045", "3.141592653589793238462643383279",
		"0.30000000000000004", "1.00000000000000011102230246251565404236316680908203125", "1.00000000000000011102230246251565404236316680908203124",
		"1.00000000000000011102230246251565404236316680908203126", "7.0e-10", "5e-324", "1e308", "1.5", "100000000000000000000000.0"}
	src, _ := os.Create("lits.sober")
	want, _ := os.Create("want.txt")
	fmt.Fprintln(src, "package main\n\nfunc main() int {")
	k := 0
	emit := func(s string) {
		f, err := strconv.ParseFloat(s, 64)
		if err != nil || math.IsInf(f, 0) {
			return
		}
		fmt.Fprintf(src, "    x%d := %s\n", k, s)
		fmt.Fprintln(want, int64(math.Float64bits(f)))
		k++
	}
	for _, e := range edges {
		emit(e)
	}
	for i := 0; i < n; i++ {
		emit(lit(r))
	}
	fmt.Fprintln(src, "    return 0\n}")
}
