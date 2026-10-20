// examples/crypto_x25519.sober の Go の双子（std/crypto/x25519 の差分オラクル — report-794）。crypto/ecdh の X25519 で同じ値を出し、
// RFC 7748 5.2（反復 1 / 1000 回 — Sober の例は 100 回の値を出す）/ 6.1 の期待値をここに固定して照合する（食い違いは標準エラーに出して exit 1）。再生成:
//   go run scripts/oracles/crypto_x25519.go > examples/crypto_x25519.out
package main

import (
	"crypto/ecdh"
	"encoding/hex"
	"fmt"
	"os"
)

var fails = 0

func want(name, got, w string) {
	if got != w {
		fmt.Fprintf(os.Stderr, "%s: got %s want %s\n", name, got, w)
		fails++
	}
}

func unhex(s string) []byte {
	b, err := hex.DecodeString(s)
	if err != nil {
		panic(err)
	}
	return b
}

func shared(k, u []byte) []byte {
	priv, err := ecdh.X25519().NewPrivateKey(k)
	if err != nil {
		panic(err)
	}
	// crypto/ecdh は u の最上位のビットを捨てる（RFC 7748）
	pub, err := ecdh.X25519().NewPublicKey(u)
	if err != nil {
		panic(err)
	}
	s, err := priv.ECDH(pub)
	if err != nil {
		panic(err)
	}
	return s
}

func base(k []byte) []byte {
	priv, err := ecdh.X25519().NewPrivateKey(k)
	if err != nil {
		panic(err)
	}
	return priv.PublicKey().Bytes()
}

func key(i int) []byte {
	out := make([]byte, 32)
	x := uint64(i)*2654435761 + 12345
	for j := range out {
		x = x*6364136223846793005 + 1442695040888963407
		out[j] = byte((x >> 33) & 0xff)
	}
	return out
}

func h(b []byte) string { return hex.EncodeToString(b) }

func main() {
	r1 := h(shared(unhex("a546e36bf0527c9d3b16154b82465edd62144c0ac1fc5a18506a2244ba449ac4"), unhex("e6db6867583030db3594c1a424b15f7c726624ec26b3353b10a903a6d0ab1c4c")))
	want("rfc7748 5.2 #1", r1, "c3da55379de9c6908e94ea4df28d084f32eccf03491c71f754b4075577a28552")
	fmt.Println("rfc1", r1)
	fmt.Println("rfc2", h(shared(unhex("4b66e9d4d1b4673c5ad22691957d6af5c11b6421e0ea01d42ca4169e7918ba0d"), unhex("e5210f12786811d3f4b7959d0538ae2c31dbe7106fc03c3efc4cd549c715a493"))))
	var k100 []byte
	k := unhex("0900000000000000000000000000000000000000000000000000000000000000")
	u := k
	for i := 0; i < 1000; i++ {
		r := shared(k, u)
		u = k
		k = r
		if i == 99 {
			k100 = append([]byte{}, k...)
		}
		if i == 0 {
			want("rfc7748 iter1", h(k), "422c8e7a6227d7bca1350b3e2bb7279f7897b87bb6854b783c60e80311ae3079")
			fmt.Println("iter1", h(k))
		}
	}
	want("rfc7748 iter1000", h(k), "684cf59ba83309552800ef566f2f4d3c1c3887c49360e3875f2eb94d99532c51")
	fmt.Println("iter100", h(k100))
	ap := unhex("77076d0a7318a57d3c16c17251b26645df4c2f87ebc0992ab177fba51db92c2a")
	bp := unhex("5dab087e624a8a4b79e17f8b83800ee66f3bb1292618b6fd1c2f8b27ff88e0eb")
	want("rfc7748 6.1 alice", h(base(ap)), "8520f0098930a754748b7ddcb43ef75a0dbf3a0d26381af4eba4a98eaa9b4e6a")
	want("rfc7748 6.1 bob", h(base(bp)), "de9edb7d7b7dc1b4d35b61c2ece435373f8343c85b78674dadfc7e146f882b4f")
	want("rfc7748 6.1 shared", h(shared(ap, base(bp))), "4a5d9d5ba4ce2de1728e3bf480350f25e07e21c947d19e3376f09b3c1e161742")
	fmt.Println("alice", h(base(ap)))
	fmt.Println("bob", h(base(bp)))
	fmt.Println("shared", h(shared(ap, base(bp))), h(shared(bp, base(ap))))
	for i := 0; i < 16; i++ {
		a := key(2 * i)
		b := key(2*i + 1)
		if i%4 == 0 {
			fmt.Println("pair", i, h(base(a)), h(shared(a, base(b))))
		}
	}
	fmt.Println("symmetric", 16)
	if fails > 0 {
		os.Exit(1)
	}
}
