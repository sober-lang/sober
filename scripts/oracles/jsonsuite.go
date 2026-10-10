// JSONTestSuite の Go encoding/json の判定（scripts/jsonsuite.sh --go）: 引数のファイルごとに「<名前> ok|reject」
package main

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
)

func main() {
	for _, p := range os.Args[1:] {
		b, err := os.ReadFile(p)
		if err != nil {
			panic(err)
		}
		var v any
		r := "ok"
		if json.Unmarshal(b, &v) != nil {
			r = "reject"
		}
		fmt.Println(filepath.Base(p), r)
	}
}
