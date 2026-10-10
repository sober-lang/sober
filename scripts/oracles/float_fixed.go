// float_fixed.go — 浮動小数の固定桁の印字の差分オラクル（float の段 — conv.FormatFixed / std/floatfmt.FormatFixed）: 境界値 + 乱択のビット列と桁数
// （examples/float_fixed.in）と Go の strconv.FormatFloat(f, 'f', prec, 64)（examples/float_fixed.out）を作る
//   go run scripts/oracles/float_fixed.go 3000 examples/float_fixed.in examples/float_fixed.out
package main

import (
	"bufio"
	"fmt"
	"math"
	"math/rand"
	"os"
	"strconv"
)

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	r := rand.New(rand.NewSource(5))
	in := bufio.NewWriter(must(os.Create(os.Args[2])))
	want := bufio.NewWriter(must(os.Create(os.Args[3])))
	defer in.Flush()
	defer want.Flush()
	emit := func(f float64, p int) {
		fmt.Fprintln(in, int64(math.Float64bits(f)), p)
		fmt.Fprintln(want, strconv.FormatFloat(f, 'f', p, 64))
	}
	for _, f := range []float64{0, math.Copysign(0, -1), 0.5, 1.5, 2.5, -0.5, 0.125, 0.0625, 1e-10, -1e-10, 0.1, 1e300, 5e-324, math.Inf(1), math.Inf(-1), math.NaN(), -0.169075164, 1.274219991, 123.456, 0.0045, 0.0055} {
		for p := 0; p <= 12; p += 3 {
			emit(f, p)
		}
	}
	for i := 0; i < n; i++ {
		var f float64
		switch i % 3 {
		case 0:
			f = (r.Float64() - 0.5) * math.Pow(10, float64(r.Intn(30)-15))
		case 1:
			f = float64(r.Intn(100000)) / 1000.0 // 同点に近い値
		default:
			f = math.Float64frombits(r.Uint64())
			if math.IsNaN(f) || math.Abs(f) > 1e60 {
				f = 1.0 / 3.0
			}
		}
		emit(f, r.Intn(21))
	}
}

func must(f *os.File, err error) *os.File {
	if err != nil {
		panic(err)
	}
	return f
}
