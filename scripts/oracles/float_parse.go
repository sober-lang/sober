// float_parse.go — 浮動小数の解析の差分オラクル（float の段 — language.md 37 節）: 境界・構文の負例 + 乱択の 10 進の文字列（examples/float_parse.in）と
// Go の strconv.ParseFloat のビット列と状態（0 = ok・1 = 構文・2 = 溢れ — examples/float_parse.out）を作る。Sober 側は examples/float_parse.sober
// （std/floatfmt.ParseBits）。Go が受けて Sober が受けない形（16 進・_）は出さない — Sober は 10 進だけ（docs 37 節）。
//   go run scripts/oracles/float_parse.go 5000 examples/float_parse.in examples/float_parse.out
package main

import (
	"bufio"
	"errors"
	"fmt"
	"math"
	"math/rand"
	"os"
	"strconv"
	"strings"
)

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	r := rand.New(rand.NewSource(9))
	in := bufio.NewWriter(must(os.Create(os.Args[2])))
	want := bufio.NewWriter(must(os.Create(os.Args[3])))
	defer in.Flush()
	defer want.Flush()
	emit := func(s string) {
		if strings.ContainsAny(s, "\n") {
			return
		}
		f, err := strconv.ParseFloat(s, 64)
		st := 0
		if err != nil {
			if errors.Is(err, strconv.ErrRange) {
				st = 2
			} else {
				st = 1
			}
		}
		b := int64(math.Float64bits(f))
		if st == 1 {
			b = 0
		}
		fmt.Fprintln(in, s)
		fmt.Fprintln(want, b, st)
	}
	for _, s := range []string{"0", "-0", "+0", "0.0", ".5", "5.", "1e5", "1E5", "1e+5", "1e-5", "+1.5", "-1.5", "000.1", "1e309", "-1e309", "1e-400", "4.9e-324", "2.4703282292062327e-324",
		"2.4703282292062328e-324", "1.7976931348623157e308", "1.7976931348623158e308", "1.7976931348623159e308", "inf", "Inf", "-inf", "+Infinity", "INFINITY", "infinityx", "infx", "nan", "NaN", "NAN",
		"+nan", "-NaN", "", "+", "-", ".", "e5", "1e", "1e+", "1.2.3", "0x10", " 1", "1 ", "--1", "1e5x", "..5", "9007199254740993", "0.1e1", "123456789012345678901234567890e-10"} {
		emit(s)
	}
	for i := 0; i < n; i++ {
		var sb strings.Builder
		if r.Intn(4) == 0 {
			sb.WriteByte("+-"[r.Intn(2)])
		}
		nd := r.Intn(30)
		dot := r.Intn(nd + 2)
		for j := 0; j < nd; j++ {
			if j == dot {
				sb.WriteByte('.')
			}
			sb.WriteByte(byte('0' + r.Intn(10)))
		}
		if r.Intn(2) == 0 {
			sb.WriteByte("eE"[r.Intn(2)])
			if r.Intn(2) == 0 {
				sb.WriteByte("+-"[r.Intn(2)])
			}
			sb.WriteString(strconv.Itoa(r.Intn(700)))
		}
		emit(sb.String())
	}
}

func must(f *os.File, err error) *os.File {
	if err != nil {
		panic(err)
	}
	return f
}
