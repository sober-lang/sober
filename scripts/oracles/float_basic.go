// float_basic.go — examples/float_basic.sober の Go の双子（期待値 examples/float_basic.out の生成元: go run scripts/oracles/float_basic.go > examples/float_basic.out）。
// int へは int64(f)（範囲内だけ使う — Sober の int(f) と同じ 0 方向の切り捨て）・ビット列は int64(math.Float64bits(f))
package main

import (
	"fmt"
	"math"
)

type P struct{ x, y float64 }

func bits(f float64) int64 { return int64(math.Float64bits(f)) }
func b(x bool) string {
	if x {
		return "true"
	}
	return "false"
}
func norm(p P) float64 { return math.Sqrt(p.x*p.x + p.y*p.y) }
func sum(xs []float64) float64 {
	s := 0.0
	for _, x := range xs {
		s += x
	}
	return s
}

func main() {
	a := 0.1
	bb := 0.2
	fmt.Println(bits(a+bb), bits(0.3), b(a+bb == 0.3))
	one, three, two := 1.0, 3.0, 2.0
	fmt.Println(bits(one/three), bits(two/three-one/three))
	zero := 0.0
	inf := 1.0 / zero
	nan := zero / zero
	fmt.Println(bits(inf), bits(zero-inf), b(inf > 1.0e308))
	fmt.Println(b(nan == nan), b(nan != nan), b(nan < 1.0), b(nan >= 1.0), b(bits(nan) != 0))
	nz := math.Copysign(0, -1)
	fmt.Println(bits(nz), b(nz == 0.0), bits(zero-zero), bits(-zero), bits(1.0/nz))
	m3, f799, e18 := -3.0, 7.99, 1.0e18
	fmt.Println(int64(f799), int64(-f799), int64(m3/2.0), int64(e18), bits(float64(int64(9007199254740993))))
	fmt.Println(int64(float64(123456789) * 1000.0))
	two2, big, m1 := 2.0, 1.0e16, -1.0
	fmt.Println(bits(math.Sqrt(two2)), int64(math.Sqrt(big)), b(bits(math.Sqrt(m1)) != 0), bits(math.Sqrt(nz)))
	fmt.Println(bits(math.Abs(-2.5)), bits(math.Abs(nz)))
	p := P{3.0, 4.0}
	fmt.Println(int64(norm(p)), bits(norm(P{1.0, 1.0})))
	xs := []float64{}
	for i := 0; i < 10; i++ {
		xs = append(xs, float64(i)*0.1)
	}
	fmt.Println(bits(sum(xs)))
	acc := 1.0
	for i := 0; i < 60; i++ {
		acc *= 2.0
		acc -= 0.5
	}
	fmt.Println(bits(acc), bits(math.Float64frombits(4607182418800017408)+1.0))
	x, y := 1.5, 2.5
	fmt.Println(b(x < y), b(x <= y), b(x > y), b(x >= y), b(x == y), b(x != y), b(x <= 1.5), b(x >= 1.5))
}
