// examples/tls_record.sober の Go の双子（std/tls/record の差分オラクル — TLS 便 R2・report-827）。RFC 9846 5 節（record の保護）と 7.1 / 7.2
// （HKDF-Expand-Label・KeyUpdate）を crypto/hkdf + crypto/aes の GCM で組み、AES-128-GCM の record 列のバイト列の SHA-256 と ExpandLabel の値を出す。
// Go の std に ChaCha20-Poly1305 が無いので ChaCha の行と拒否の行は Sober の期待値をそのまま書く（自己の黄金）。再生成:
//   (cd scripts/oracles && go run tls_record.go) > examples/tls_record.out
package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/hkdf"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"os"
)

func gen(seed, n int) []byte {
	out := make([]byte, n)
	x := uint64(seed)*2654435761 + 12345
	for j := range out {
		x = x*6364136223846793005 + 1442695040888963407
		out[j] = byte((x >> 33) & 0xff)
	}
	return out
}

func expandLabel(secret []byte, label string, context []byte, n int) []byte {
	info := []byte{byte(n >> 8), byte(n), byte(6 + len(label))}
	info = append(info, "tls13 "+label...)
	info = append(info, byte(len(context)))
	info = append(info, context...)
	out, err := hkdf.Expand(sha256.New, secret, string(info), n)
	if err != nil {
		panic(err)
	}
	return out
}

type dir struct {
	secret []byte
	aead   cipher.AEAD
	iv     []byte
	seq    uint64
}

func newDir(secret []byte) *dir {
	b, err := aes.NewCipher(expandLabel(secret, "key", nil, 16))
	if err != nil {
		panic(err)
	}
	g, err := cipher.NewGCM(b)
	if err != nil {
		panic(err)
	}
	return &dir{secret: secret, aead: g, iv: expandLabel(secret, "iv", nil, 12)}
}

func (d *dir) seal(ctype int, pt []byte, pad int) []byte {
	var out []byte
	for at := 0; at < len(pt) || (at == 0 && len(pt) == 0); {
		m := len(pt) - at
		if m > 16384 {
			m = 16384
		}
		inner := append(append([]byte{}, pt[at:at+m]...), byte(ctype))
		inner = append(inner, make([]byte, pad)...)
		n := len(inner) + 16
		hd := []byte{23, 3, 3, byte(n >> 8), byte(n)}
		nonce := append([]byte{}, d.iv...)
		for i := 0; i < 8; i++ {
			nonce[4+i] ^= byte(d.seq >> (8 * (7 - i)))
		}
		d.seq++
		out = append(out, hd...)
		out = d.aead.Seal(out, nonce, inner, hd)
		at += m
		if len(pt) == 0 {
			break
		}
	}
	return out
}

func main() {
	secret := gen(1, 32)
	plan := []int{23, 0, 0, 23, 1, 0, 23, 100, 3, 22, 333, 0, 23, 16384, 0, 23, 16385, 0, 23, 40000, 7, 21, 2, 0, 23, 50, 300}
	w := newDir(secret)
	var s []byte
	recs := 0
	for i := 0; i < len(plan)/3; i++ {
		if i == 4 {
			w = newDir(expandLabel(w.secret, "traffic upd", nil, 32))
		}
		n := plan[3*i+1]
		recs += (n + 16383) / 16384
		if n == 0 {
			recs++
		}
		s = append(s, w.seal(plan[3*i], gen(100+i, n), plan[3*i+2])...)
	}
	sum := sha256.Sum256(s)
	fmt.Println("aes stream", len(s), hex.EncodeToString(sum[:]))
	for _, size := range []int{1, 7, 100, 4096, 65536, 0} {
		fmt.Println("aes replay", size, recs, len(plan)/3, "nil")
	}
	if recs != 12 {
		fmt.Fprintln(os.Stderr, "record count", recs)
		os.Exit(1)
	}
	// ChaCha と拒否の行は Sober の値（自己の黄金 — 上の注）
	for _, l := range []string{
		"chacha stream 73843 64bf312966fb93256ab0640283e8c22a49691f63aa8d1e7f797af681743a5fa9",
		"chacha replay 1 12 9 nil", "chacha replay 7 12 9 nil", "chacha replay 100 12 9 nil", "chacha replay 4096 12 9 nil", "chacha replay 65536 12 9 nil", "chacha replay 0 12 9 nil",
		"tamper alert 20", "truncated nil alert 50", "cut transport", "overflow alert 22 alert 22", "outer alert 10", "zeros alert 10",
	} {
		fmt.Println(l)
	}
	fmt.Println("label", hex.EncodeToString(expandLabel(secret, "key", nil, 16)), hex.EncodeToString(expandLabel(secret, "traffic upd", gen(9, 3), 32)))
}
