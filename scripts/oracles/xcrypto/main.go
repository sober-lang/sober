// std/crypto/passwordのwhite-boxテストの比較用の実装（golang.org/x/crypto — 標準ライブラリに無い方式だけ。版はgo.modで固定）。
// 方式ごとに格子の値を 1 行 1 例で出す（入力は pat(長さ, k) = (i*31 + k*13 + 7) mod 256 — password の _test の pat と同じ）。再生成:
//   cd scripts/oracles/xcrypto && go run . blake2b > ../../../testdata/crypto/blake2b.txt
//   cd scripts/oracles/xcrypto && go run . argon2id > ../../../testdata/crypto/argon2id.txt
//   cd scripts/oracles/xcrypto && go run . bcrypt > ../../../testdata/crypto/bcrypt.txt   （塩は毎回乱数 — 再生成すると値が変わるが、各行は塩を含む文字列なので照合の意味は同じ）
package main

import (
	"encoding/hex"
	"fmt"
	"os"

	"golang.org/x/crypto/argon2"
	"golang.org/x/crypto/bcrypt"
	"golang.org/x/crypto/blake2b"
)

func pat(n, k int) []byte {
	b := make([]byte, n)
	for i := range b {
		b[i] = byte((i*31 + k*13 + 7) % 256)
	}
	return b
}

func main() {
	switch os.Args[1] {
	case "blake2b":
		// 行 = `入力の長さ 出力の長さ 値`
		for _, l := range []int{0, 1, 3, 127, 128, 129, 255, 256, 257, 1024, 1500} {
			for _, n := range []int{1, 32, 33, 63, 64} {
				h, _ := blake2b.New(n, nil)
				h.Write(pat(l, 3))
				fmt.Printf("%d %d %s\n", l, n, hex.EncodeToString(h.Sum(nil)))
			}
		}
	case "argon2id":
		// 行 = `pw の長さ 塩の長さ t m（KiB） p 出力の長さ 値`
		type c struct{ pl, sl, t, m, p, n int }
		cs := []c{
			{0, 8, 1, 8, 1, 32}, {1, 16, 1, 8, 1, 32}, {32, 16, 1, 64, 1, 32}, {32, 16, 2, 64, 1, 32}, {32, 16, 3, 64, 1, 32},
			{32, 16, 1, 64, 2, 32}, {32, 16, 2, 64, 4, 32}, {32, 16, 3, 33, 4, 32}, {32, 16, 1, 1024, 1, 32}, {32, 16, 3, 1024, 2, 32},
			{16, 16, 2, 4096, 1, 32}, {16, 16, 1, 300, 3, 32}, {16, 16, 1, 64, 1, 4}, {16, 16, 1, 64, 1, 64}, {16, 16, 1, 64, 1, 65},
			{16, 16, 1, 64, 1, 100}, {16, 16, 1, 64, 1, 1024}, {100, 64, 2, 128, 2, 48}, {16, 16, 2, 19456, 1, 32},
		}
		for _, x := range cs {
			k := argon2.IDKey(pat(x.pl, 1), pat(x.sl, 2), uint32(x.t), uint32(x.m), uint8(x.p), uint32(x.n))
			fmt.Printf("%d %d %d %d %d %d %s\n", x.pl, x.sl, x.t, x.m, x.p, x.n, hex.EncodeToString(k))
		}
	case "bcrypt":
		// 行 = `pw の長さ cost 文字列（$2a$ — 72 バイト以下の pw では $2b$ と同じ値）`
		for _, cost := range []int{4, 5, 6} {
			for _, l := range []int{0, 1, 8, 55, 71, 72} {
				h, err := bcrypt.GenerateFromPassword(pat(l, 1), cost)
				if err != nil {
					fmt.Fprintln(os.Stderr, err)
					os.Exit(1)
				}
				fmt.Printf("%d %d %s\n", l, cost, h)
			}
		}
	default:
		fmt.Fprintln(os.Stderr, "unknown:", os.Args[1])
		os.Exit(1)
	}
}
