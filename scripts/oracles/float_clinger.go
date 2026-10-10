// examples/float_clinger の Go の答え（strconv.ParseFloat のビット列と状態 — 1 行 1 本の入力の順）: go run scripts/oracles/float_clinger.go > want
package main

import (
	"errors"
	"fmt"
	"math"
	"strconv"
)

func main() {
	xs := []string{"9007199254740992", "9007199254740993", "9007199254740991", "-9007199254740993", "9007199254740993e0",
		"1e22", "1e23", "123456789e22", "1e-22", "1e-23", "4503599627370497.5", "9007199254740993e-22", "0.000000000000000000001",
		"1.7976931348623157e22", "8.98846567431158e22", "123.456e-20", "-0", "-0.0e5", "0e23", "00000000000000000000000000001",
		"3.0000000000000004", "2.2250738585072014e-22", "7e22", "7e-22", "9.007199254740993", "900719925474099.3e1"}
	for _, s := range xs {
		f, err := strconv.ParseFloat(s, 64)
		st := 0
		if err != nil {
			if errors.Is(err, strconv.ErrRange) {
				st = 2
			} else {
				st = 1
			}
		}
		fmt.Println(int64(math.Float64bits(f)), st)
	}
}
