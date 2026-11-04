// float_interp.go — examples/float_interp.sober の Go の双子（go run scripts/oracles/float_interp.go > examples/float_interp.out）。
// 綴りは strconv.FormatFloat(f, 'g', -1, 64)・0.1 + 0.2 は変数を経て実行時の加算にする（Go の定数の正確な算術を避ける）
package main

import (
	"fmt"
	"math"
	"strconv"
)

func g(f float64) string { return strconv.FormatFloat(f, 'g', -1, 64) }

func main() {
	a, b := 0.1, 0.2
	px, py := a+b, -2.0
	fmt.Printf("x=%s p=(%s, %s) sum=%s\n", g(1.5), g(px), g(py), g(px+py))
	fmt.Printf("big=%s small=%s tiny=%s max=%s\n", g(1e21), g(1e-7), g(5e-324), g(1.7976931348623157e308))
	zero := 0.0
	inf := 1.0 / zero
	fmt.Printf("inf=%s ninf=%s nan=%s negz=%s z=%s\n", g(inf), g(zero-inf), g(zero/zero), g(math.Copysign(0, -1)), g(0))
	fmt.Println("f="+g(2.5), "i=7", "e="+g(6.02e23))
	acc := ""
	v := 1.0
	for k := 0; k < 4; k++ {
		acc += g(v) + ";"
		v = v / 3.0
	}
	fmt.Println(acc)
}
