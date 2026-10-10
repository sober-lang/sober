// examples/rand_xoshiro.sober の Go の双子（std/rand の差分オラクル — docs/oracles.md）。
// xoshiro128**（Blackman / Vigna の参照実装の写し — uint32 の算術そのまま）と、std/rand と同じシードの拡散（SplitMix32 — fmix32）。
// std/rand は 32 bit の算術を int の上で桁に割って書くので、uint32 の wrap で書いたこちらと出力が一致すればよい。再生成:
//   go run scripts/oracles/rand_xoshiro.go > examples/rand_xoshiro.out
package main

import (
	"fmt"
	"os"
)

type Rand struct{ s [4]uint32 }

func fmix32(x uint32) uint32 {
	x = (x ^ (x >> 16)) * 0x85ebca6b
	x = (x ^ (x >> 13)) * 0xc2b2ae35
	return x ^ (x >> 16)
}

func rotl(x uint32, k uint) uint32 { return (x << k) | (x >> (32 - k)) }

func New(seed int64) Rand {
	lo := uint32(uint64(seed))
	hi := uint32(uint64(seed) >> 32)
	var g uint32 = 0x9e3779b9
	var r Rand
	r.s[0] = fmix32(lo + g)
	r.s[1] = fmix32((lo + 2*g) ^ hi)
	r.s[2] = fmix32(lo + 3*g)
	r.s[3] = fmix32((lo + 4*g) ^ fmix32(hi))
	if r.s[0]|r.s[1]|r.s[2]|r.s[3] == 0 {
		r.s = [4]uint32{1, 0, 0, 0}
	}
	return r
}

func (r *Rand) Next() uint32 {
	s := &r.s
	result := rotl(s[1]*5, 7) * 9
	t := s[1] << 9
	s[2] ^= s[0]
	s[3] ^= s[1]
	s[1] ^= s[2]
	s[0] ^= s[3]
	s[2] ^= t
	s[3] = rotl(s[3], 11)
	return result
}

func (r *Rand) Int62() int64 {
	hi := int64(r.Next() >> 2)
	lo := int64(r.Next())
	return hi<<32 | lo
}

func (r *Rand) Intn(n int64) int64 {
	lim := int64(1<<62) - int64(1<<62)%n
	v := r.Int62()
	for v >= lim {
		v = r.Int62()
	}
	return v % n
}

func (r *Rand) Bool() bool { return r.Next()&1 == 1 }

func (r *Rand) Split() Rand {
	a := int64(r.Next())
	b := int64(r.Next())
	return New((a << 30) ^ b)
}

func main() {
	// 写しの確かめ（標準エラーへ — .out には入れない）: 参照実装の既知の列 = 状態 {1, 2, 3, 4} から 11520 0 5927040 70819200 2031721883 1637235492
	ref := Rand{[4]uint32{1, 2, 3, 4}}
	for i := 0; i < 6; i++ {
		fmt.Fprintln(os.Stderr, ref.Next())
	}
	seeds := []int64{0, 1, 42, -1, -9223372036854775808, 9223372036854775807, 123456789}
	for _, sd := range seeds {
		r := New(sd)
		fmt.Println(sd, r.Next(), r.Next(), r.Next(), r.Int62(), r.Intn(10), r.Intn(1000003), r.Bool())
	}
	r := New(7)
	c := r.Split()
	fmt.Println(r.Next(), c.Next(), c.Intn(6))
	// 偏りの粗い見張り: 6 面のさいころ 60000 回の度数
	d := New(2026)
	var cnt [6]int
	for i := 0; i < 60000; i++ {
		cnt[d.Intn(6)]++
	}
	fmt.Println(cnt[0], cnt[1], cnt[2], cnt[3], cnt[4], cnt[5])
}
