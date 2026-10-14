// bench/extsort の入力の生成（決定的 — 線形合同法・シード 42）: 第 1 引数のバイト数に達するまで、`[a-z]` の 8〜32 文字（長さも中身も一様）の
// 行を第 2 引数のファイルへ書く（各行は改行で終わる — 最後の行も）
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

var seed = uint64(42)

func next() uint64 {
	seed = seed*6364136223846793005 + 1442695040888963407
	return seed >> 33
}

func main() {
	if len(os.Args) != 3 {
		fmt.Fprintln(os.Stderr, "usage: gen <bytes> <out>")
		os.Exit(2)
	}
	n, err := strconv.ParseInt(os.Args[1], 10, 64)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(2)
	}
	f, err := os.Create(os.Args[2])
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	w := bufio.NewWriterSize(f, 1<<20)
	line := make([]byte, 0, 40)
	var total int64
	for total < n {
		k := 8 + int(next()%25)
		line = line[:0]
		for i := 0; i < k; i++ {
			line = append(line, byte('a'+next()%26))
		}
		line = append(line, '\n')
		w.Write(line)
		total += int64(len(line))
	}
	if err := w.Flush(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	f.Close()
}
