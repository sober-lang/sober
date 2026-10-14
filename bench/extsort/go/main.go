// extsort の Go の双子（素直縛り — 標準ライブラリだけ）: Sober 版と同じアルゴリズム。run = 入力を 64 KiB ずつ読んで窓 W に達するまで 1 本のバイト列に積み、
// 完全な行の部分列を slices.SortFunc（bytes.Compare）で並べて os.WriteFile で `<dir>/run-<i>` へ全量書く。マージ = run ごとに開いたファイルと
// bufio.Reader（64 KiB）を持ち、頭の行が最小の run を線形の走査で選んで bufio.Writer（64 KiB）で標準出力へ。出力は Sober 版とバイト一致
package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
	"slices"
	"strconv"
)

func main() {
	if len(os.Args) != 3 && len(os.Args) != 4 {
		os.Exit(2)
	}
	mib := 64
	if len(os.Args) == 4 {
		mib, _ = strconv.Atoi(os.Args[3])
	}
	k, err := makeRuns(os.Args[1], os.Args[2], mib<<20)
	if err != nil {
		os.Exit(1)
	}
	w := bufio.NewWriterSize(os.Stdout, 65536)
	if mergeRuns(os.Args[2], k, w) != nil || w.Flush() != nil {
		os.Exit(1)
	}
}

func makeRuns(path, dir string, w int) (int, error) {
	f, err := os.Open(path)
	if err != nil {
		return 0, err
	}
	defer f.Close()
	var tail []byte
	k := 0
	chunk := make([]byte, 65536)
	for eof := false; !eof; {
		buf := append([]byte{}, tail...)
		eof = true
		for {
			n, err := f.Read(chunk)
			buf = append(buf, chunk[:n]...)
			if err == io.EOF || (n == 0 && err == nil) {
				break
			}
			if err != nil {
				return 0, err
			}
			if len(buf) >= w {
				eof = false
				break
			}
		}
		e := bytes.LastIndexByte(buf, '\n') + 1
		tail = append([]byte{}, buf[e:]...)
		var lines [][]byte
		for s := 0; s < e; {
			i := s + bytes.IndexByte(buf[s:e], '\n')
			lines = append(lines, buf[s:i+1])
			s = i + 1
		}
		if len(lines) == 0 {
			continue
		}
		slices.SortFunc(lines, func(a, b []byte) int { return bytes.Compare(a[:len(a)-1], b[:len(b)-1]) })
		out := make([]byte, 0, e)
		for _, l := range lines {
			out = append(out, l...)
		}
		if err := os.WriteFile(fmt.Sprintf("%s/run-%d", dir, k), out, 0o644); err != nil {
			return 0, err
		}
		k++
	}
	if len(tail) > 0 {
		return 0, fmt.Errorf("no final newline")
	}
	return k, nil
}

func mergeRuns(dir string, k int, w *bufio.Writer) error {
	rs := make([]*bufio.Reader, k)
	heads := make([][]byte, k)
	for r := 0; r < k; r++ {
		f, err := os.Open(fmt.Sprintf("%s/run-%d", dir, r))
		if err != nil {
			return err
		}
		defer f.Close()
		rs[r] = bufio.NewReaderSize(f, 65536)
		heads[r], _ = rs[r].ReadSlice('\n')
	}
	for {
		m := -1
		for r := 0; r < k; r++ {
			if len(heads[r]) > 0 && (m < 0 || bytes.Compare(heads[r][:len(heads[r])-1], heads[m][:len(heads[m])-1]) < 0) {
				m = r
			}
		}
		if m < 0 {
			return nil
		}
		w.Write(heads[m])
		var err error
		heads[m], err = rs[m].ReadSlice('\n')
		if err != nil && err != io.EOF {
			return err
		}
	}
}
