// binary-trees の並列版の Go の双子（benchmarks game の Go の並列の定番の形 — 深さごとに goroutine・ポインタの木と GC・結果は深さの順に印字）
package main

import (
	"fmt"
	"os"
	"strconv"
	"sync"
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
	out := make([]string, maxDepth+1)
	var wg sync.WaitGroup
	for d := minDepth; d <= maxDepth; d += 2 {
		wg.Add(1)
		go func(d int) {
			defer wg.Done()
			iters := 1 << (maxDepth - d + minDepth)
			c := 0
			for i := 0; i < iters; i++ {
				c += bottomUp(d).check()
			}
			out[d] = fmt.Sprintf("%d\t trees of depth %d\t check: %d\n", iters, d, c)
		}(d)
	}
	wg.Wait()
	for d := minDepth; d <= maxDepth; d += 2 {
		fmt.Print(out[d])
	}
	fmt.Printf("long lived tree of depth %d\t check: %d\n", maxDepth, long.check())
}
