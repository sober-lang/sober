// bench/jsonencode の Go の双子（encoding/json.Marshal — 同じ木・同じ綴り。長さと FNV-1a で Sober の出力と照合）
package main

import (
	"encoding/json"
	"fmt"
	"os"
)

type N0 struct {
	ID    int     `json:"id"`
	Name  string  `json:"name"`
	Score float64 `json:"score"`
	Kids  []N1 `json:"kids"`
}

type N1 struct {
	ID    int     `json:"id"`
	Name  string  `json:"name"`
	Score float64 `json:"score"`
	Kids  []N2 `json:"kids"`
}

type N2 struct {
	ID    int     `json:"id"`
	Name  string  `json:"name"`
	Score float64 `json:"score"`
	Kids  []N3 `json:"kids"`
}

type N3 struct {
	ID    int     `json:"id"`
	Name  string  `json:"name"`
	Score float64 `json:"score"`
	Kids  []N4 `json:"kids"`
}

type N4 struct {
	ID    int     `json:"id"`
	Name  string  `json:"name"`
	Score float64 `json:"score"`
	Kids  []N5 `json:"kids"`
}

type N5 struct {
	ID    int     `json:"id"`
	Name  string  `json:"name"`
	Score float64 `json:"score"`
}

func mkN0(id, f int) N0 {
	ks := make([]N1, 0, f)
	for i := 0; i < f; i++ {
		ks = append(ks, mkN1(id*f+i, f))
	}
	return N0{ID: id, Name: fmt.Sprintf("n%d", id%1000), Score: float64(id%4000) * 0.25, Kids: ks}
}

func mkN1(id, f int) N1 {
	ks := make([]N2, 0, f)
	for i := 0; i < f; i++ {
		ks = append(ks, mkN2(id*f+i, f))
	}
	return N1{ID: id, Name: fmt.Sprintf("n%d", id%1000), Score: float64(id%4000) * 0.25, Kids: ks}
}

func mkN2(id, f int) N2 {
	ks := make([]N3, 0, f)
	for i := 0; i < f; i++ {
		ks = append(ks, mkN3(id*f+i, f))
	}
	return N2{ID: id, Name: fmt.Sprintf("n%d", id%1000), Score: float64(id%4000) * 0.25, Kids: ks}
}

func mkN3(id, f int) N3 {
	ks := make([]N4, 0, f)
	for i := 0; i < f; i++ {
		ks = append(ks, mkN4(id*f+i, f))
	}
	return N3{ID: id, Name: fmt.Sprintf("n%d", id%1000), Score: float64(id%4000) * 0.25, Kids: ks}
}

func mkN4(id, f int) N4 {
	ks := make([]N5, 0, f)
	for i := 0; i < f; i++ {
		ks = append(ks, mkN5(id*f+i, f))
	}
	return N4{ID: id, Name: fmt.Sprintf("n%d", id%1000), Score: float64(id%4000) * 0.25, Kids: ks}
}

func mkN5(id, f int) N5 {
	return N5{ID: id, Name: fmt.Sprintf("n%d", id%1000), Score: float64(id%4000) * 0.25}
}

func fnv(b []byte) int64 {
	h := uint64(14695981039644321037)
	for _, c := range b {
		h = (h ^ uint64(c)) * 1099511628211
	}
	return int64(h)
}

func main() {
	d := os.Args[1]
	var b []byte
	switch d {
	case "2":
		f := 550
		xs := make([]N4, 0, f)
		for i := 0; i < f; i++ {
			xs = append(xs, mkN4(i, f))
		}
		b, _ = json.Marshal(xs)
	case "4":
		f := 24
		xs := make([]N2, 0, f)
		for i := 0; i < f; i++ {
			xs = append(xs, mkN2(i, f))
		}
		b, _ = json.Marshal(xs)
	default:
		f := 8
		xs := make([]N0, 0, f)
		for i := 0; i < f; i++ {
			xs = append(xs, mkN0(i, f))
		}
		b, _ = json.Marshal(xs)
	}
	fmt.Println(len(b), fnv(b))
}
