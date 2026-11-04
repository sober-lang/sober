// const_float.go — examples/const_float.sober の Go の双子（go run scripts/oracles/const_float.go > examples/const_float.out）。
// Go の const は正確な算術なので、Sober の型つきの IEEE の演算に合わせて変数を経て実行時に計算する
package main

import (
	"fmt"
	"strconv"
)

func g(f float64) string { return strconv.FormatFloat(f, 'g', -1, 64) }

func main() {
	pi := 3.141592653589793
	two, four := 2.0, 4.0
	twoPi := two * pi
	solar := four * pi * pi
	days := 365.24
	halfNeg := -(pi / two)
	a1, a2 := 0.1, 0.2
	sum := a1 + a2
	fmt.Println(g(twoPi), g(solar), g(halfNeg), g(sum))
	vx, m := 1.66007664274403694e-03, 9.54791938424326609e-04
	fmt.Println(g(0.0), g(solar))
	fmt.Println(g(vx*days), g(m*solar))
	a := 0.0
	for k := 0; k < 3; k++ {
		a = a + twoPi
	}
	fmt.Println(g(a), sum == 0.3)
}
