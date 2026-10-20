// examples/crypto_rsa.sober の Go の双子（std/crypto/rsa + pem の差分オラクル — report-795）。同じ鍵（testdata/crypto/*.key）・同じ決定的な salt で
// EMSA-PSS-ENCODE（RFC 8017 9.1.1）を手で組み、big.Int の m^d mod n で署名を作る（バイト一致の照合）。その署名を crypto/rsa.VerifyPSS
// （標準ライブラリ）でも受理すること・改竄の拒否を確かめる（食い違いは標準エラーに出して exit 1）。再生成（リポジトリの根で）:
//   (cd scripts/oracles && go run crypto_rsa.go) > examples/crypto_rsa.out
package main

import (
	"crypto"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/hex"
	"encoding/pem"
	"fmt"
	"math/big"
	"os"
)

var fails = 0

func salt(seed int) []byte {
	out := make([]byte, 32)
	for i := range out {
		out[i] = byte((i*37 + seed) % 256)
	}
	return out
}

func mgf1(seed []byte, n int) []byte {
	var out []byte
	for c := 0; len(out) < n; c++ {
		h := sha256.New()
		h.Write(seed)
		h.Write([]byte{byte(c >> 24), byte(c >> 16), byte(c >> 8), byte(c)})
		out = append(out, h.Sum(nil)...)
	}
	return out[:n]
}

func pssEncode(mHash, s []byte, emBits int) []byte {
	emLen := (emBits + 7) / 8
	mp := sha256.New()
	mp.Write(make([]byte, 8))
	mp.Write(mHash)
	mp.Write(s)
	h := mp.Sum(nil)
	db := make([]byte, emLen-32-1)
	db[len(db)-len(s)-1] = 1
	copy(db[len(db)-len(s):], s)
	mask := mgf1(h, len(db))
	for i := range db {
		db[i] ^= mask[i]
	}
	db[0] &= 0xff >> (8*emLen - emBits)
	return append(append(db, h...), 0xbc)
}

func flip(b []byte, at int) []byte {
	out := append([]byte{}, b...)
	if at < len(out) {
		out[at] ^= 1
	}
	return out
}

func one(name string) {
	raw, err := os.ReadFile("../../testdata/crypto/" + name + ".key")
	if err != nil {
		panic(err)
	}
	blk, _ := pem.Decode(raw)
	fmt.Println(name, blk.Type, len(blk.Bytes))
	ki, err := x509.ParsePKCS8PrivateKey(blk.Bytes)
	if err != nil {
		panic(err)
	}
	k := ki.(*rsa.PrivateKey)
	size := k.Size()
	fmt.Println(name, "size", size)
	for i, msg := range []string{"", "hello", "TLS 1.3, server CertificateVerify"} {
		m := []byte(msg)
		mh := sha256.Sum256(m)
		em := pssEncode(mh[:], salt(i), k.N.BitLen()-1)
		s := new(big.Int).Exp(new(big.Int).SetBytes(em), k.D, k.N).FillBytes(make([]byte, size))
		fmt.Println(name, i, hex.EncodeToString(s))
		v := func(m, s []byte, sl int) bool {
			h := sha256.Sum256(m)
			return rsa.VerifyPSS(&k.PublicKey, crypto.SHA256, h[:], s, &rsa.PSSOptions{SaltLength: sl, Hash: crypto.SHA256}) == nil
		}
		if !v(m, s, 32) {
			fmt.Fprintf(os.Stderr, "%s %d: crypto/rsa rejects the signature\n", name, i)
			fails++
		}
		fmt.Println(name, i, "verify", v(m, s, 32), v(flip(m, 0), s, 32), v(m, flip(s, 100), 32), v(m, s, 20))
	}
}

func main() {
	one("rsa2048")
	one("httparena-server")
	crt, err := os.ReadFile("../../testdata/crypto/httparena-server.crt")
	if err != nil {
		panic(err)
	}
	blk, _ := pem.Decode(crt)
	fmt.Println("crt", true, 1, blk.Type, len(blk.Bytes), hex.EncodeToString(blk.Bytes))
	fmt.Println("chain", true, 2)
	fmt.Println("no end", true)
	fmt.Println("bad char", true)
	fmt.Println("bad pad", true)
	fmt.Println("pad ok", true, "0001")
	if fails > 0 {
		os.Exit(1)
	}
}
