// examples/float_try_zero の Go の双子（`?` の脱出のゼロ値 = Go の return M{}, err）
package main

import (
	"errors"
	"fmt"
)

type M struct {
	name string
	v    float64
}

func get(ok bool) (float64, error) {
	if !ok {
		return 0.0, errors.New("bad")
	}
	return 2.5, nil
}

func load(ok bool) (M, error) {
	v, err := get(ok)
	if err != nil {
		return M{}, err
	}
	return M{name: "m", v: v}, nil
}

func main() {
	a, ea := load(true)
	b, eb := load(false)
	z := M{}
	fmt.Println(a.v, ea == nil, b.v, eb == nil, z.v)
}
