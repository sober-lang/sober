// examples/hash_sha256.sober の Go の双子（std/hash の差分オラクル — docs/oracles.md）。
// crypto/sha256 で同じ入力の値を出す。加えて NIST の公式テストベクタ（FIPS 180-2 付録 B.1〜B.3 = "abc"・448 bit・100 万個の 'a' と
// CAVP SHA256ShortMsg の Len = 0）の期待値をここに固定し、crypto/sha256 の値と照合する（食い違いは標準エラーに出して exit 1）。再生成:
//   go run scripts/oracles/hash_sha256.go > examples/hash_sha256.out
package main

import (
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"os"
	"strings"
)

func pattern(n int) []byte {
	b := make([]byte, n)
	for i := range b {
		b[i] = byte((i*31 + 7) % 256)
	}
	return b
}

func sum(b []byte) string {
	s := sha256.Sum256(b)
	return hex.EncodeToString(s[:])
}

var nist = []struct{ name, msg, want string }{
	{"empty", "", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"},
	{"abc", "abc", "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"},
	{"448bit", "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq", "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1"},
	{"896bit", "abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu", "cf5b16a778af8380036ce59e7b0492370b249b11e8f07a51afac45037afee9d1"},
	{"million-a", strings.Repeat("a", 1000000), "cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0"},
}

func main() {
	bad := false
	for _, v := range nist {
		got := sum([]byte(v.msg))
		if got != v.want {
			fmt.Fprintf(os.Stderr, "NIST mismatch %s: got %s want %s\n", v.name, got, v.want)
			bad = true
		}
		fmt.Println(v.name, got)
	}
	for _, n := range []int{1, 55, 56, 57, 63, 64, 65, 119, 120, 127, 128, 129} {
		fmt.Println("pattern", n, sum(pattern(n)))
	}
	fmt.Println("pattern", 100003, sum(pattern(100003)))
	s := sha256.Sum256([]byte("abc"))
	fmt.Println(len(s), s[0], s[31])
	if bad {
		os.Exit(1)
	}
	fmt.Fprintln(os.Stderr, "NIST vectors ok (5)")
}
