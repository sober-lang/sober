// std/internal/x509 の RSA-PSS の検証（VerifyRsaPss — TLS 1.3 の rsa_pss_rsae_sha256/384/512）の Go の双子: crypto/rsa の SignPSS（salt = ハッシュの長さ）で
// 2048 / 3072 bit の鍵 × SHA-256 / 384 / 512 の署名と、1 ビット変えた署名を出す。再生成（鍵は毎回新しい — 値は変わるが照合の意味は同じ）:
//   go run scripts/oracles/crypto_rsapss.go > testdata/crypto/rsapss.txt
// 行 = `bits n の 16 進 e の 16 進 hbits メッセージの 16 進 署名の 16 進 1/0（合う / 合わない）`
package main

import (
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/sha512"
	"encoding/hex"
	"fmt"
	"math/big"
	"os"
)

func main() {
	for _, bits := range []int{2048, 3072} {
		k, err := rsa.GenerateKey(rand.Reader, bits)
		if err != nil {
			fmt.Fprintln(os.Stderr, err)
			os.Exit(1)
		}
		n := hex.EncodeToString(k.N.Bytes())
		e := hex.EncodeToString(big.NewInt(int64(k.E)).Bytes())
		for _, hb := range []int{256, 384, 512} {
			for i := 0; i < 3; i++ {
				msg := []byte(fmt.Sprintf("tls13 certificate verify %d %d %d", bits, hb, i))
				var h []byte
				var hf crypto.Hash
				switch hb {
				case 256:
					s := sha256.Sum256(msg)
					h, hf = s[:], crypto.SHA256
				case 384:
					s := sha512.Sum384(msg)
					h, hf = s[:], crypto.SHA384
				default:
					s := sha512.Sum512(msg)
					h, hf = s[:], crypto.SHA512
				}
				sig, err := rsa.SignPSS(rand.Reader, k, hf, h, &rsa.PSSOptions{SaltLength: rsa.PSSSaltLengthEqualsHash})
				if err != nil {
					fmt.Fprintln(os.Stderr, err)
					os.Exit(1)
				}
				fmt.Printf("%d %s %s %d %s %s 1\n", bits, n, e, hb, hex.EncodeToString(msg), hex.EncodeToString(sig))
				bad := append([]byte{}, sig...)
				bad[len(bad)/2] ^= 1
				fmt.Printf("%d %s %s %d %s %s 0\n", bits, n, e, hb, hex.EncodeToString(msg), hex.EncodeToString(bad))
			}
		}
	}
}
