// mandelbrot の Go の双子（Benchmarks Game の仕様 — 素直な形・逐次: n × n の点を 50 回まで反復、|z|² ≤ 4 を 1 ビットで詰めた PBM（P4）を標準出力へ）
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	n := 200
	if len(os.Args) > 1 {
		n, _ = strconv.Atoi(os.Args[1])
	}
	out := bufio.NewWriter(os.Stdout)
	defer out.Flush()
	fmt.Fprintf(out, "P4\n%d %d\n", n, n)
	fn := float64(n)
	for y := 0; y < n; y++ {
		ci := 2.0*float64(y)/fn - 1.0
		bits := 0
		bitnum := 0
		for x := 0; x < n; x++ {
			cr := 2.0*float64(x)/fn - 1.5
			zr, zi, tr, ti := 0.0, 0.0, 0.0, 0.0
			i := 0
			for i < 50 && tr+ti <= 4.0 {
				zi = 2.0*zr*zi + ci
				zr = tr - ti + cr
				tr = zr * zr
				ti = zi * zi
				i++
			}
			bits <<= 1
			if tr+ti <= 4.0 {
				bits |= 1
			}
			bitnum++
			if bitnum == 8 {
				out.WriteByte(byte(bits))
				bits = 0
				bitnum = 0
			}
		}
		if bitnum > 0 {
			bits <<= 8 - bitnum
			out.WriteByte(byte(bits))
		}
	}
}
