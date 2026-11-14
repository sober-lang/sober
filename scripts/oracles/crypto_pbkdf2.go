// std/crypto/passwordのPBKDF2-HMAC-SHA256の核（white-box — pbkdf2_test.sober）の比較用のGoの実装: crypto/pbkdf2で長さ・反復の格子の値を出し、
// RFC 7914 11 節の 2 例をここに固定して照合する（食い違いは標準エラーに出して exit 1）。再生成:
//   go run scripts/oracles/crypto_pbkdf2.go > testdata/crypto/pbkdf2_sha256.txt
// 行の形 = `pw の長さ 塩の長さ 反復 出力の長さ 値（16 進）`。pw = pat(長さ, 1)・塩 = pat(長さ, 2)（pbkdf2_test.sober の pat と同じ）
package main

import (
	"bytes"
	"crypto/pbkdf2"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"os"
)

func pat(n, k int) []byte {
	b := make([]byte, n)
	for i := range b {
		b[i] = byte((i*31 + k*13 + 7) % 256)
	}
	return b
}

func key(pw, salt []byte, iters, n int) []byte {
	k, err := pbkdf2.Key(sha256.New, string(pw), salt, iters, n)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	return k
}

func main() {
	rfc := []struct {
		pw, salt string
		iters    int
		want     string
	}{
		{"passwd", "salt", 1, "55ac046e56e3089fec1691c22544b605f94185216dde0465e68b9d57c20dacbc49ca9cccf179b645991664b39d77ef317c71b845b1e30bd509112041d3a19783"},
		{"Password", "NaCl", 80000, "4ddcd8f60b98be21830cee5ef22701f9641a4418d04c0414aeff08876b34ab56a1d425a1225833549adb841b51c9b3176a272bdebba1d078478f62b397f33c8d"},
	}
	for _, c := range rfc {
		w, _ := hex.DecodeString(c.want)
		if !bytes.Equal(key([]byte(c.pw), []byte(c.salt), c.iters, 64), w) {
			fmt.Fprintln(os.Stderr, "RFC 7914 vector mismatch:", c.pw)
			os.Exit(1)
		}
	}
	for _, pl := range []int{0, 1, 63, 64, 65, 200} {
		for _, sl := range []int{0, 16, 61} {
			for _, it := range []int{1, 2, 1023, 1024, 1025, 2049} {
				for _, n := range []int{1, 32, 33, 100} {
					fmt.Printf("%d %d %d %d %s\n", pl, sl, it, n, hex.EncodeToString(key(pat(pl, 1), pat(sl, 2), it, n)))
				}
			}
		}
	}
}
