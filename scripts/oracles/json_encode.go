// examples/json_encode の Go の双子（encoding/json.Marshal — 欄の順・null・エスケープ・float の綴りが同じこと。rename は欄のタグで）
package main

import (
	"encoding/json"
	"fmt"
)

type Point struct {
	X int `json:"x"`
	Y int `json:"y"`
}

type Shape struct {
	Name   string   `json:"name"`
	Closed bool     `json:"closed"`
	Scale  float64  `json:"scale"`
	Points []Point  `json:"points"`
	Tags   []string `json:"tags"`
	Note   *string  `json:"note"`
	Origin *Point   `json:"origin"`
}

type PointR struct {
	X int `json:"lon"`
	Y int `json:"lat"`
}

type ShapeR struct {
	Name   string   `json:"name"`
	Closed bool     `json:"closed"`
	Scale  float64  `json:"scale"`
	Points []PointR `json:"pts"`
	Tags   []string `json:"tags"`
	Note   *string  `json:"note"`
	Origin *PointR  `json:"origin"`
}

func main() {
	s := Shape{Name: "tri \"A\"", Closed: true, Scale: 1.5, Points: []Point{{0, 0}, {3, -4}}, Tags: []string{"a", "b\nc"}, Origin: &Point{7, 9}}
	b, _ := json.Marshal(s)
	fmt.Println(string(b))
	r := ShapeR{Name: s.Name, Closed: true, Scale: 1.5, Points: []PointR{{0, 0}, {3, -4}}, Tags: s.Tags, Origin: &PointR{7, 9}}
	b, _ = json.Marshal(r)
	fmt.Println(string(b))
	fmt.Println(true)
}
