// float_format.go — 浮動小数の印字の差分オラクル（float の段 — language.md 37 節）: 境界値 + 乱択のビット列（examples/float_format.in）と
// Go の strconv.FormatFloat(f, 'g', -1, 64)（examples/float_format.out）を作る。Sober 側は examples/float_format.sober（convert.FormatFloat + math.FromBits）。
//   go run scripts/oracles/float_format.go 5000 examples/float_format.in examples/float_format.out
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
	r := rand.New(rand.NewSource(3))
	in := bufio.NewWriter(must(os.Create(os.Args[2])))
	want := bufio.NewWriter(must(os.Create(os.Args[3])))
	defer in.Flush()
	defer want.Flush()
	emit := func(f float64) {
		fmt.Fprintln(in, int64(math.Float64bits(f)))
		fmt.Fprintln(want, strconv.FormatFloat(f, 'g', -1, 64))
	}
	for _, f := range []float64{0, math.Copysign(0, -1), 1, -1, 0.1, 0.2, 0.3, 1.0 / 3, 2.0 / 3, 1e6, 1e5, 123456, 1234567, 1e21, 1e20, 1e-4, 1e-5, 0.00012345,
		math.MaxFloat64, math.SmallestNonzeroFloat64, 2.2250738585072014e-308, 2.2250738585072009e-308, 5e-324, 1e23, 9007199254740993, 9007199254740992,
		math.Inf(1), math.Inf(-1), math.NaN(), 100, 1000, 12.5, 0.5, 3.0e-310, 1.7976931348623157e308, 4.9406564584124654e-324, 6.02214076e23, 2.718281828459045} {
		emit(f)
	}
	for i := 0; i < n; i++ {
		var f float64
		switch i % 4 {
		case 0:
			f = math.Float64frombits(r.Uint64())
		case 1:
			f = r.Float64() * math.Pow(10, float64(r.Intn(40)-20))
		case 2:
			f = float64(r.Int63n(1000000)) / float64(1+r.Intn(1000))
		default:
			f = math.Float64frombits(r.Uint64() & 0x000FFFFFFFFFFFFF) // 非正規
		}
		if math.IsNaN(f) {
			continue
		}
		emit(f)
	}
}

func must(f *os.File, err error) *os.File {
	if err != nil {
		panic(err)
	}
	return f
}
