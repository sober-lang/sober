// fannkuch-redux の Go の双子（同じアルゴリズム — 逐次版）
package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	n := 7
	if len(os.Args) > 1 {
		n, _ = strconv.Atoi(os.Args[1])
	}
	perm1 := make([]int, n)
	perm := make([]int, n)
	count := make([]int, n)
	for i := range perm1 {
		perm1[i] = i
	}
	maxFlips, checksum, permCount, r := 0, 0, 0, n
	for {
		for r != 1 {
			count[r-1] = r
			r--
		}
		copy(perm, perm1)
		flips := 0
		for k := perm[0]; k != 0; k = perm[0] {
			for lo, hi := 0, k; lo < hi; lo, hi = lo+1, hi-1 {
				perm[lo], perm[hi] = perm[hi], perm[lo]
			}
			flips++
		}
		if flips > maxFlips {
			maxFlips = flips
		}
		if permCount%2 == 0 {
			checksum += flips
		} else {
			checksum -= flips
		}
		for {
			if r == n {
				fmt.Printf("%d\nPfannkuchen(%d) = %d\n", checksum, n, maxFlips)
				return
			}
			p0 := perm1[0]
			for i := 0; i < r; i++ {
				perm1[i] = perm1[i+1]
			}
			perm1[r] = p0
			count[r]--
			if count[r] > 0 {
				break
			}
			r++
		}
		permCount++
	}
}
