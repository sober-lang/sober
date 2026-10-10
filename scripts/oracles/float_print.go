// float_print.go — examples/float_print.sober の Go の双子（期待値の生成元: go run scripts/oracles/float_print.go > examples/float_print.out）
package main

import (
	"errors"
	"fmt"
	"math"
	"strconv"
)

func show(s string) {
	f, err := strconv.ParseFloat(s, 64)
	if err != nil {
		msg := "invalid"
		if errors.Is(err, strconv.ErrRange) {
			msg = "range"
		}
		if msg == "invalid" {
			f = 0
		}
		fmt.Println(s, msg, f)
	} else {
		fmt.Println(s, f)
	}
}

func main() {
	zero := 0.0
	// 0.1 + 0.2 は変数で（Go の定数式は正確な算術で 0.3 に畳む — Sober は型つきの演算で実行時と同じビット。language.md 37 節）
	a, b := 0.1, 0.2
	fmt.Println(0.0, math.Copysign(0, -1), 1.0, 0.1, a+b, 1.0/3.0, 100000.0, 1000000.0, 0.0001, 0.00001, 123456789.0, 1.0e21, 5.0e-324)
	fmt.Println(1.0/zero, -1.0/zero, zero/zero != 0.0, 1.7976931348623157e308, 2.5e-3, -12.75)
	x := 1.0
	for i := 0; i < 12; i++ {
		x = x * 7.0 / 3.0
		fmt.Println(i, x, strconv.FormatFloat(x*x, 'g', -1, 64))
	}
	for _, s := range []string{"3.14159", "-1e-5", "1e400", "abc", "inf", "NaN", ".5", "1e"} {
		show(s)
	}
}
