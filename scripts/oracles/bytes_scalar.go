// examples/bytes_scalar.sober の Go の双子（byte スカラーの差分オラクル — docs/oracles.md）。
// Go の byte（= uint8）で同じ計算をし、その出力が examples/bytes_scalar.out。再生成:
//   go run scripts/oracles/bytes_scalar.go > examples/bytes_scalar.out
// Sober の byte は算術を持たないので、Sober 側の int(b) の計算は Go でも int へ戻して書く（byte のまま足すと wrap の意味論が混ざる）。
// println の書式（空白区切り・bool は true / false・byte は 10 進）は fmt.Println と同じ
package main

import "fmt"

type Tok struct {
	c byte
	n int
}

const Quote = 34

func isDigit(c byte) bool { return c >= '0' && c <= '9' }

func upper(c byte) byte {
	if c >= 'a' && c <= 'z' {
		return byte(int(c) - 32)
	}
	return c
}

func classify(c byte) int {
	switch c {
	case ' ', '\t', '\n':
		return 0
	case 'a', 'e', 'i', 'o', 'u':
		return 1
	case Quote:
		return 2
	default:
		if isDigit(c) {
			return 3
		}
		return 4
	}
}

func pick(first bool, c byte) byte {
	if first {
		return c
	}
	return 0
}

func findSep(s []byte) *byte {
	if len(s) > 2 {
		v := byte(44)
		return &v
	}
	return nil
}

func orZero(v *byte) byte {
	if v != nil {
		return *v
	}
	return 0
}

// toByte は Sober の byte(n)（範囲外は panic — ここの入力は全部範囲内）
func toByte(n int) byte {
	if n < 0 || n > 255 {
		panic("byte out of range")
	}
	return byte(n)
}

func main() {
	b := byte(65)
	fmt.Println(b)
	fmt.Println(int(b) + 1)
	c := b
	c = 'z'
	fmt.Println(c, upper(c), upper('Q'), upper('3'))
	fmt.Println(b == 65, b != 'A', b < c, c <= 'z', c > b, b >= 66)
	fmt.Println(isDigit('7'), isDigit(b))
	fmt.Println(classify(' '), classify('e'), classify(34), classify('5'), classify('#'))
	t := Tok{c: '+', n: 1}
	fmt.Println(t.c, t.n)
	z := Tok{}
	fmt.Println(z.c)
	xs := []byte{}
	xs = append(xs, 'h')
	xs = append(xs, 105)
	xs = append(xs, b)
	fmt.Println(len(xs), xs[0], xs[1], xs[2])
	ys := []byte{'o', 'k', 255}
	fmt.Println(ys[2], int(ys[0])-int(ys[1]))
	fmt.Println(pick(true, 'x'), pick(false, 'x'))
	o := findSep(ys)
	if o != nil {
		fmt.Println(*o)
	}
	fmt.Println(orZero(findSep(ys[0:2])), orZero(findSep(xs)))
	n := 0
	for i := 0; i < 3; i++ {
		n = n + int(toByte(i*100))
	}
	fmt.Println(n)
	fmt.Println(toByte(255), toByte(0), byte(b))
	bb := []byte{}
	bb = append(bb, 'a')
	bb = append(bb, c)
	fmt.Println(len(bb), bb[0], bb[1])
	tb := []byte{}
	tb = append(tb, 7)
	tb[0] = 200
	fmt.Println(tb[0], len(tb))
}
