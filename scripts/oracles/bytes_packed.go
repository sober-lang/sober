// examples/bytes_packed.sober の Go の双子（[]byte の詰め表現の差分オラクル — docs/oracles.md）。再生成:
//   go run scripts/oracles/bytes_packed.go > examples/bytes_packed.out
// Sober の append は「先端一致なら伸長・他は全コピー」で cap を持たない（language.md 21 節）。同じセル列を指す 2 本のヘッダの 2 本目の append は
// 全コピーになる — Go では cap の余りを共有して同じセルに書くので、2 本目は明示の全長スライス（s[:len:len]）で全コピーを強制して Sober の意味に合わせる
package main

import "fmt"

type Rec struct {
	tag  int
	body []byte
}

func fill(n int, base int) []byte {
	b := []byte{}
	for i := 0; i < n; i++ {
		b = append(b, byte((base+i)%256))
	}
	return b
}

func sum(b []byte) int {
	s := 0
	for i := 0; i < len(b); i++ {
		s += int(b[i])
	}
	return s
}

func mkRec(t int) Rec { return Rec{tag: t, body: fill(t, 100)} }

func nested() [][]byte {
	out := [][]byte{}
	for i := 1; i < 4; i++ {
		out = append(out, fill(i*3, i))
	}
	return out
}

func main() {
	a := []byte{'s', 'o', 'b', 'e', 'r'}
	a[0] = 'S'
	fmt.Println(len(a), a[0], a[1], a[4])
	for i := 0; i < 20; i++ {
		a = append(a, byte(65+i))
	}
	fmt.Println(len(a), a[5], a[12], a[13], a[24])
	w := []int{}
	c := []byte{}
	for i := 0; i < 30; i++ {
		w = append(w, i*1000003)
		c = append(c, byte(i))
	}
	fmt.Println(len(w), w[0], w[17], w[29], len(c), c[0], c[17], c[29])
	p := a
	q := a
	p = append(p[:len(p):len(p)], 'p')
	q = append(q[:len(q):len(q)], 'q')
	fmt.Println(len(p), len(q), p[25], q[25], a[0], p[0], q[0])
	s := []byte{1, 2, 3, 4, 5, 6, 7, 8, 9}
	s2 := append(s[:len(s):len(s)], 10)
	mid := s2[3:7]
	fmt.Println(len(s), len(s2), s2[9], len(mid), mid[0], mid[3])
	f := fill(300, 250)
	fmt.Println(len(f), f[0], f[5], f[6], f[299], sum(f))
	r := mkRec(9)
	fmt.Println(r.tag, len(r.body), r.body[0], r.body[8])
	ns := nested()
	fmt.Println(len(ns), len(ns[0]), len(ns[2]), ns[2][8], sum(ns[1]))
	zs := []byte{}
	for i := 0; i < 70; i++ {
		zs = append(zs, byte(i*3%256))
	}
	fmt.Println(len(zs), zs[0], zs[33], zs[69], sum(zs))
}
