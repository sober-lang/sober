// spectral-norm の Go の双子（Benchmarks Game の仕様 — 素直な形・逐次: A(i, j) = 1 / ((i+j)(i+j+1)/2 + i + 1)、AᵀA の冪乗法 10 回、√(vBv / vv) を %.9f）
package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
)

func evalA(i, j int) float64 { return 1.0 / float64((i+j)*(i+j+1)/2+i+1) }

func times(v, u []float64) {
	for i := range v {
		a := 0.0
		for j := range u {
			a += evalA(i, j) * u[j]
		}
		v[i] = a
	}
}

func timesTransp(v, u []float64) {
	for i := range v {
		a := 0.0
		for j := range u {
			a += evalA(j, i) * u[j]
		}
		v[i] = a
	}
}

func aTimesTransp(v, u, x []float64) {
	times(x, u)
	timesTransp(v, x)
}

func main() {
	n := 100
	if len(os.Args) > 1 {
		n, _ = strconv.Atoi(os.Args[1])
	}
	u := make([]float64, n)
	v := make([]float64, n)
	x := make([]float64, n)
	for i := range u {
		u[i] = 1.0
	}
	for i := 0; i < 10; i++ {
		aTimesTransp(v, u, x)
		aTimesTransp(u, v, x)
	}
	vBv, vv := 0.0, 0.0
	for i := range v {
		vBv += u[i] * v[i]
		vv += v[i] * v[i]
	}
	fmt.Printf("%0.9f\n", math.Sqrt(vBv/vv))
}
