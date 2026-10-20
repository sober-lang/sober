// examples/crypto_hmac_hkdf.sober の Go の双子（std/crypto の sha256 / hmac / hkdf の差分オラクル — report-792）。
// crypto/hmac・crypto/hkdf・crypto/sha256 で同じ入力の値を出し、RFC 4231 の 1・2 例と RFC 5869 A.1 の期待値をここに固定して照合する
// （食い違いは標準エラーに出して exit 1）。再生成:
//   go run scripts/oracles/crypto_hmac_hkdf.go > examples/crypto_hmac_hkdf.out
package main

import (
	"bytes"
	"crypto/hkdf"
	"crypto/hmac"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"os"
)

func rep(b byte, n int) []byte { return bytes.Repeat([]byte{b}, n) }

func seq(from, to int) []byte {
	var out []byte
	for i := from; i <= to; i++ {
		out = append(out, byte(i))
	}
	return out
}

func pattern(n int) []byte {
	b := make([]byte, n)
	for i := range b {
		b[i] = byte((i*31 + 7) % 256)
	}
	return b
}

func mac(k, m []byte) []byte {
	h := hmac.New(sha256.New, k)
	h.Write(m)
	return h.Sum(nil)
}

func h(b []byte) string { return hex.EncodeToString(b) }

var fails = 0

func want(name, got, w string) {
	if got != w {
		fmt.Fprintf(os.Stderr, "%s: got %s want %s\n", name, got, w)
		fails++
	}
}

func expand(prk, info []byte, n int) []byte {
	b, err := hkdf.Expand(sha256.New, prk, string(info), n)
	if err != nil {
		panic(err)
	}
	return b
}

func extract(salt, ikm []byte) []byte {
	b, err := hkdf.Extract(sha256.New, ikm, salt)
	if err != nil {
		panic(err)
	}
	return b
}

func main() {
	m1 := h(mac(rep(0x0b, 20), []byte("Hi There")))
	want("rfc4231 1", m1, "b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7")
	m2 := h(mac([]byte("Jefe"), []byte("what do ya want for nothing?")))
	want("rfc4231 2", m2, "5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843")
	fmt.Println("hmac 1", m1)
	fmt.Println("hmac 2", m2)
	fmt.Println("hmac 3", h(mac(rep(0xaa, 20), rep(0xdd, 50))))
	fmt.Println("hmac 4", h(mac(seq(1, 25), rep(0xcd, 50))))
	fmt.Println("hmac 5", h(mac(rep(0x0c, 20), []byte("Test With Truncation"))[:16]))
	fmt.Println("hmac 6", h(mac(rep(0xaa, 131), []byte("Test Using Larger Than Block-Size Key - Hash Key First"))))
	fmt.Println("hmac 7", h(mac(rep(0xaa, 131), []byte("This is a test using a larger than block-size key and a larger than block-size data. The key needs to be hashed before being used by the HMAC algorithm."))))
	p1 := extract(seq(0, 12), rep(0x0b, 22))
	o1 := expand(p1, seq(0xf0, 0xf9), 42)
	want("rfc5869 A.1 prk", h(p1), "077709362c2e32df0ddc3f0dc47bba6390b6c73bb50f9c3122ec844ad7c2b3e5")
	want("rfc5869 A.1 okm", h(o1), "3cb25f25faacd57a90434f64d0362f2a2d2d0a90cf1a5a4c5db02d56ecc4c5bf34007208d5b887185865")
	fmt.Println("hkdf 1 prk", h(p1))
	fmt.Println("hkdf 1 okm", h(o1))
	p2 := extract(seq(0x60, 0xaf), seq(0, 0x4f))
	fmt.Println("hkdf 2 prk", h(p2))
	fmt.Println("hkdf 2 okm", h(expand(p2, seq(0xb0, 0xff), 82)))
	p3 := extract(nil, rep(0x0b, 22))
	fmt.Println("hkdf 3 prk", h(p3))
	fmt.Println("hkdf 3 okm", h(expand(p3, nil, 42)))
	fmt.Println("hkdf max", len(expand(p1, nil, 8160)), true)
	fmt.Println("hkdf over", true)
	fmt.Println("incremental", 201*70, 0)
	s := sha256.Sum256([]byte("abc"))
	fmt.Println("snapshot", h(s[:]), true)
	t := sha256.Sum256(append([]byte("abc"), pattern(100)...))
	fmt.Println("snapshot2", h(t[:]))
	if fails > 0 {
		os.Exit(1)
	}
}
