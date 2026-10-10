// bench/jsondecode の入力の生成（決定的 — 線形合同法）: 引数 N 件のレコードの JSON の配列を標準出力へ
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	w := bufio.NewWriter(os.Stdout)
	defer w.Flush()
	seed := uint64(42)
	next := func() uint64 {
		seed = seed*6364136223846793005 + 1442695040888963407
		return seed >> 33
	}
	words := []string{"alpha", "beta", "gamma", "delta", "epsilon", "zeta", "eta", "theta", "iota", "kappa"}
	w.WriteString("[\n")
	for i := 0; i < n; i++ {
		if i > 0 {
			w.WriteString(",\n")
		}
		fmt.Fprintf(w, `{"id": %d, "name": "user-%d", "active": %t, "score": %d.%02d, "pos": {"x": %d, "y": -%d}, "tags": [`,
			i, next()%100000, next()%2 == 0, next()%1000, next()%100, next()%10000, next()%10000)
		k := int(next() % 5)
		for j := 0; j < k; j++ {
			if j > 0 {
				w.WriteString(", ")
			}
			fmt.Fprintf(w, `"%s"`, words[next()%10])
		}
		w.WriteString("]")
		if next()%3 == 0 {
			fmt.Fprintf(w, `, "note": "n%d"`, next()%1000)
		}
		w.WriteString(`, "extra": {"ignored": [1, 2, 3]}}`)
	}
	w.WriteString("\n]\n")
}
