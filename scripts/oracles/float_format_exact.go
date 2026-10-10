// float_format_exact.go — float の最短表現の速い道（正確な 10 進展開が 15 桁以下 — floatfmt.exactShort）を狙った値（整数・m / 2^k・m × 10^k・
// 4 分の 1 刻み・奇数の仮数 × 2^e）と乱択の値の Go の strconv.FormatFloat(f, 'g', -1, 64)。Sober 側は examples/float_format_exact.sober。
//   go run scripts/oracles/float_format_exact.go 3000 examples/float_format_exact.in examples/float_format_exact.out
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
	r := rand.New(rand.NewSource(5))
	n, _ := strconv.Atoi(os.Args[1])
	in, _ := os.Create(os.Args[2])
	want, _ := os.Create(os.Args[3])
	wi := bufio.NewWriter(in)
	ww := bufio.NewWriter(want)
	defer wi.Flush()
	defer ww.Flush()
	emit := func(f float64) {
		fmt.Fprintln(wi, int64(math.Float64bits(f)))
		fmt.Fprintln(ww, strconv.FormatFloat(f, 'g', -1, 64))
	}
	for i := 0; i < n; i++ {
		var f float64
		switch i % 6 {
		case 0:
			f = float64(r.Int63n(1 << 53))
		case 1:
			f = float64(r.Int63n(1<<20)) / float64(int64(1)<<uint(r.Intn(40)))
		case 2:
			f = float64(r.Int63n(100000)) * math.Pow(10, float64(r.Intn(30)))
		case 3:
			f = float64(r.Int63n(1000000)) * 0.25
		case 4:
			f = math.Ldexp(float64(r.Int63n(1<<53)|1), r.Intn(80)-60)
		default:
			f = r.Float64() * math.Pow(10, float64(r.Intn(40)-20))
		}
		if r.Intn(3) == 0 {
			f = -f
		}
		emit(f)
	}
	for _, f := range []float64{1e15, 1e16, 999999999999999, 1000000000000001, 9007199254740992, 0.5, 0.0001220703125, 123000, 1e21, 1e22, 5e-324, 2.5e-5} {
		emit(f)
	}
}
