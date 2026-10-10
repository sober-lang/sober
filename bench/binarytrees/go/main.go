// binary-trees の Go の双子（benchmarks game の定番の形 — ポインタの木と GC・逐次）
package main

import (
	"fmt"
	"os"
	"strconv"
)

type node struct{ l, r *node }

func bottomUp(d int) *node {
	if d <= 0 {
		return &node{}
	}
	return &node{bottomUp(d - 1), bottomUp(d - 1)}
}

func (n *node) check() int {
	if n.l == nil {
		return 1
	}
	return 1 + n.l.check() + n.r.check()
}

func main() {
	n := 10
	if len(os.Args) > 1 {
		n, _ = strconv.Atoi(os.Args[1])
	}
	minDepth := 4
	maxDepth := n
	if minDepth+2 > n {
		maxDepth = minDepth + 2
	}
	stretch := maxDepth + 1
	fmt.Printf("stretch tree of depth %d\t check: %d\n", stretch, bottomUp(stretch).check())
	long := bottomUp(maxDepth)
	for d := minDepth; d <= maxDepth; d += 2 {
		iters := 1 << (maxDepth - d + minDepth)
		c := 0
		for i := 0; i < iters; i++ {
			c += bottomUp(d).check()
		}
		fmt.Printf("%d\t trees of depth %d\t check: %d\n", iters, d, c)
	}
	fmt.Printf("long lived tree of depth %d\t check: %d\n", maxDepth, long.check())
}
