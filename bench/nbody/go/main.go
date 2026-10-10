// n-body の Go の双子（Benchmarks Game の仕様 — 素直な形: 5 天体〔太陽・木星・土星・天王星・海王星〕の重力の時間発展、前後のエネルギーを %.9f）。
// 定数の積（4π²・× 365.24）は変数で — Go の定数式は正確な算術で畳むので、Sober の型つきの演算（実行時と同じ丸め）と揃える
package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
)

type Body struct{ x, y, z, vx, vy, vz, mass float64 }

func main() {
	n := 1000
	if len(os.Args) > 1 {
		n, _ = strconv.Atoi(os.Args[1])
	}
	pi := math.Pi
	solarMass := 4.0 * pi * pi
	dpy := 365.24
	bodies := []Body{
		{0, 0, 0, 0, 0, 0, solarMass},
		{4.84143144246472090e+00, -1.16032004402742839e+00, -1.03622044471123109e-01, 1.66007664274403694e-03 * dpy, 7.69901118419740425e-03 * dpy, -6.90460016972063023e-05 * dpy, 9.54791938424326609e-04 * solarMass},
		{8.34336671824457987e+00, 4.12479856412430479e+00, -4.03523417114321381e-01, -2.76742510726862411e-03 * dpy, 4.99852801234917238e-03 * dpy, 2.30417297573763929e-05 * dpy, 2.85885980666130812e-04 * solarMass},
		{1.28943695621391310e+01, -1.51111514016986312e+01, -2.23307578892655734e-01, 2.96460137564761618e-03 * dpy, 2.37847173959480950e-03 * dpy, -2.96589568540237556e-05 * dpy, 4.36624404335156298e-05 * solarMass},
		{1.53796971148509165e+01, -2.59193146099879641e+01, 1.79258772950371181e-01, 2.68067772490389322e-03 * dpy, 1.62824170038242295e-03 * dpy, -9.51592254519715870e-05 * dpy, 5.15138902046611451e-05 * solarMass},
	}
	px, py, pz := 0.0, 0.0, 0.0
	for _, b := range bodies {
		px += b.vx * b.mass
		py += b.vy * b.mass
		pz += b.vz * b.mass
	}
	bodies[0].vx = -px / solarMass
	bodies[0].vy = -py / solarMass
	bodies[0].vz = -pz / solarMass
	fmt.Printf("%.9f\n", energy(bodies))
	for i := 0; i < n; i++ {
		advance(bodies, 0.01)
	}
	fmt.Printf("%.9f\n", energy(bodies))
}

func energy(bodies []Body) float64 {
	e := 0.0
	for i := range bodies {
		b := &bodies[i]
		e += 0.5 * b.mass * (b.vx*b.vx + b.vy*b.vy + b.vz*b.vz)
		for j := i + 1; j < len(bodies); j++ {
			b2 := &bodies[j]
			dx := b.x - b2.x
			dy := b.y - b2.y
			dz := b.z - b2.z
			e -= (b.mass * b2.mass) / math.Sqrt(dx*dx+dy*dy+dz*dz)
		}
	}
	return e
}

func advance(bodies []Body, dt float64) {
	for i := range bodies {
		bi := &bodies[i]
		for j := i + 1; j < len(bodies); j++ {
			bj := &bodies[j]
			dx := bi.x - bj.x
			dy := bi.y - bj.y
			dz := bi.z - bj.z
			dsq := dx*dx + dy*dy + dz*dz
			mag := dt / (dsq * math.Sqrt(dsq))
			bi.vx -= dx * bj.mass * mag
			bi.vy -= dy * bj.mass * mag
			bi.vz -= dz * bj.mass * mag
			bj.vx += dx * bi.mass * mag
			bj.vy += dy * bi.mass * mag
			bj.vz += dz * bi.mass * mag
		}
	}
	for i := range bodies {
		b := &bodies[i]
		b.x += dt * b.vx
		b.y += dt * b.vy
		b.z += dt * b.vz
	}
}
