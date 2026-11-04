// math_round.go — examples/math_round.sober の Go の双子（go run scripts/oracles/math_round.go > examples/math_round.out）。
// Go の math.Trunc / Floor / Ceil / Min / Max。印字は strconv 'g' -1（Sober の println と同じ綴り）・NaN は「NaN か」だけ（キー 1）
package main

import (
	"fmt"
	"math"
	"strconv"
)

func g(f float64) string { return strconv.FormatFloat(f, 'g', -1, 64) }

func key(f float64) int64 {
	if f != f {
		return 1
	}
	return int64(math.Float64bits(f))
}

func main() {
	zero := 0.0
	inf := 1.0 / zero
	edges := []float64{0.0, math.Copysign(0, -1), 0.5, -0.5, 1.0, -1.0, 1.5, -1.5, 2.5, -2.5, 0.49999999999999994, -0.49999999999999994,
		4503599627370495.5, -4503599627370495.5, 4503599627370496.0, 9007199254740993.0, 1.0e300, -1.0e-300, 5.0e-324, inf, zero - inf, zero / zero}
	for _, x := range edges {
		fmt.Println(g(x), g(math.Trunc(x)), g(math.Floor(x)), g(math.Ceil(x)))
	}
	for i := 0; i < 4; i++ {
		for j := 0; j < 4; j++ {
			fmt.Println(int64(math.Float64bits(math.Min(edges[i], edges[j]))), int64(math.Float64bits(math.Max(edges[i], edges[j]))))
		}
	}
	fmt.Println(g(math.Min(1.0, zero/zero)), g(math.Max(zero/zero, 1.0)), g(math.Min(inf, zero-inf)), g(math.Max(-3.0, 2.0)))
	h, l := int64(7), int64(99)
	var xt, xf, xc, xm int64
	prev := 0.0
	for k := 0; k < 3000; k++ {
		h = (h*1103515245 + 12345) & 2147483647
		l = (l*1103515245 + 12345) & 2147483647
		b := (h << 32) | l
		var f0 float64
		if k%2 == 0 {
			f0 = math.Float64frombits(uint64((b & 4503599627370495) | ((963 + (h % 121)) << 52)))
		} else {
			f0 = math.Float64frombits(uint64(b))
		}
		x := f0
		if l%3 == 0 {
			x = -f0
		}
		xt ^= key(math.Trunc(x))
		xf ^= key(math.Floor(x))
		xc ^= key(math.Ceil(x))
		xm ^= key(math.Min(x, prev)) ^ (key(math.Max(x, prev)) >> 1)
		prev = x
	}
	fmt.Println(xt, xf, xc, xm)
}
