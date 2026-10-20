// examples/crypto_aesgcm.sober の Go の双子（std/crypto/aesgcm の差分オラクル — report-796）。crypto/aes + cipher.NewGCM で同じ入力の値を出し、
// NIST の GCM の仕様の例 1〜4（AES-128）の期待値をここに固定して照合する（食い違いは標準エラーに出して exit 1）。再生成:
//   (cd scripts/oracles && go run crypto_aesgcm.go) > examples/crypto_aesgcm.out
package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"os"
)

var fails = 0

func unhex(s string) []byte {
	b, err := hex.DecodeString(s)
	if err != nil {
		panic(err)
	}
	return b
}

func gen(seed, n int) []byte {
	out := make([]byte, n)
	x := uint64(seed)*2654435761 + 12345
	for j := range out {
		x = x*6364136223846793005 + 1442695040888963407
		out[j] = byte((x >> 33) & 0xff)
	}
	return out
}

func seal(k, iv, ad, pt []byte) []byte {
	b, err := aes.NewCipher(k)
	if err != nil {
		panic(err)
	}
	g, err := cipher.NewGCM(b)
	if err != nil {
		panic(err)
	}
	return g.Seal(nil, iv, pt, ad)
}

func check(name, k, iv, ad, pt, want string) {
	got := hex.EncodeToString(seal(unhex(k), unhex(iv), unhex(ad), unhex(pt)))
	if want != "" && got != want {
		fmt.Fprintf(os.Stderr, "%s: got %s want %s\n", name, got, want)
		fails++
	}
	fmt.Println(name, got)
}

func main() {
	z16 := "00000000000000000000000000000000"
	z12 := "000000000000000000000000"
	check("nist1", z16, z12, "", "", "58e2fccefa7e3061367f1d57a4e7455a")
	check("nist2", z16, z12, "", z16, "0388dace60b6a392f328c2b971b2fe78ab6e47d42cec13bdf53a67b21257bddf")
	p3 := "d9313225f88406e5a55909c5aff5269a86a7a9531534f7da2e4c303d8a318a721c3c0c95956809532fcf0e2449a6b525b16aedf5aa0de657ba637b391aafd255"
	c3 := "42831ec2217774244b7221b784d0d49ce3aa212f2c02a4e035c17e2329aca12e21d514b25466931c7d8f6a5aac84aa051ba30b396a0aac973d58e091473f5985"
	check("nist3", "feffe9928665731c6d6a8f9467308308", "cafebabefacedbaddecaf888", "", p3, c3+"4d5c2af327cd64a62cf35abd2ba6fab4")
	check("nist4", "feffe9928665731c6d6a8f9467308308", "cafebabefacedbaddecaf888", "feedfacedeadbeeffeedfacedeadbeefabaddad2", p3[:120], c3[:120]+"5bc94fbc3221a5db94fae95ae7121a47")
	acc := sha256.New()
	adLens := []int{0, 13, 64}
	for n := 0; n <= 300; n++ {
		for a := 0; a < 3; a++ {
			acc.Write(seal(gen(3*n+a, 16), gen(7*n+a+1000, 12), gen(n+2000, adLens[a]), gen(n+3000, n)))
		}
	}
	fmt.Println("roundtrip", 903, hex.EncodeToString(acc.Sum(nil)))
	sb := sha256.Sum256(seal(gen(10, 16), gen(11, 12), gen(12, 5), gen(9, 10240+7)))
	fmt.Println("10k", hex.EncodeToString(sb[:]))
	fmt.Println("tamper", 64, true, true)
	record()
	if fails > 0 {
		os.Exit(1)
	}
}

func recHead(n int) []byte { return []byte{23, 3, 3, byte(n >> 8), byte(n)} }

func seqNonce(iv []byte, seq int) []byte {
	n := append([]byte{}, iv...)
	for i := 4; i < 12; i++ {
		n[i] ^= byte(uint64(seq) >> (8 * (11 - i)))
	}
	return n
}

// record は Sober の record()（Key の使い回し・SealTo の head ‖ 暗号文 ‖ tag）と同じ値
func record() {
	acc := sha256.New()
	key := gen(40, 16)
	iv := gen(41, 12)
	for seq := 0; seq <= 300; seq++ {
		n := seq
		if seq == 300 {
			n = 16384
		}
		hd := recHead(n + 16)
		acc.Write(append(append([]byte{}, hd...), seal(key, seqNonce(iv, seq), hd, gen(seq+4000, n))...))
	}
	fmt.Println("record", 301, hex.EncodeToString(acc.Sum(nil)))
	fmt.Println("record tamper", 48, true, true)
	fmt.Println("record badsize", true, true, true, true, true)
}

