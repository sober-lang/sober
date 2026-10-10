// float_regs.go — examples/float_regs.sober の Go の双子（期待値の生成元: go run scripts/oracles/float_regs.go > examples/float_regs.out）
package main

import (
	"fmt"
	"math"
)

func mix(x, y float64) float64 {
	a := x*1.5 + y
	b := a*a - x
	c := math.Sqrt(b*b + 1.0)
	return c - a*0.25
}

func main() {
	a0, a1, a2, a3, a4, a5, a6, a7, a8, a9 := 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0
	for i := 0; i < 1000; i++ {
		t := a0
		a0 = a1 + 0.5
		a1 = a2 * 0.999
		a2 = a3 - 0.25
		a3 = a4
		a4 = mix(a5, a6)*0.001 + a4*0.5
		a5 = a6
		a6 = a7 + float64(i%7)
		a7 = a8 * 0.5
		a8 = a9
		a9 = t
	}
	fmt.Println(a0, a1, a2, a3, a4)
	fmt.Println(a5, a6, a7, a8, a9)
	s := 0.0
	k := 0
	for i := 0; i < 200; i++ {
		x := float64(i) / 7.0
		s = s*0.5 + mix(x, s*0.001)
		k = k + int(math.Float64bits(x)&255)
	}
	fmt.Println(s, k, int64(s*1000.0))
}
