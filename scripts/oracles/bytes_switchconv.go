// examples/bytes_switchconv.sober の Go の双子（docs/oracles.md）。再生成:
//   go run scripts/oracles/bytes_switchconv.go > examples/bytes_switchconv.out
package main

import "fmt"

func unescape(e byte) int {
	switch e {
	case 110:
		return 10
	case 116:
		return 9
	case 48:
		return 0
	case 92:
		return 92
	}
	return -1
}

func main() {
	src := []byte("ntx0\\")
	out := []byte{}
	for i := 0; i < len(src); i++ {
		esc := 0
		switch int(src[i]) {
		case 120:
			esc = 88
		default:
			esc = unescape(src[i])
		}
		if esc >= 0 {
			out = append(out, byte(esc))
		}
	}
	fmt.Println(len(out))
	for i := 0; i < len(out); i++ {
		fmt.Println(out[i])
	}
}
