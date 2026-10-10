// bench/jsondecode の Go の双子: 同じ入力を encoding/json で同じ struct の列へ Unmarshal し、同じ集計を印字する（Sober の json.Decode[Rec] との絶対値の物差し）。
// 規則の違い（Go は欠けた欄をゼロ値で黙って受け、重複キーは後勝ち）は入力が整っているので結果に出ない
package main

import (
	"encoding/json"
	"fmt"
	"os"
)

type Pos struct {
	X int `json:"x"`
	Y int `json:"y"`
}

type Rec struct {
	ID     int      `json:"id"`
	Name   string   `json:"name"`
	Active bool     `json:"active"`
	Score  float64  `json:"score"`
	Pos    Pos      `json:"pos"`
	Tags   []string `json:"tags"`
	Note   *string  `json:"note"`
}

func main() {
	b, err := os.ReadFile(os.Args[1])
	if err != nil {
		return
	}
	var xs []Rec
	if err := json.Unmarshal(b, &xs); err != nil {
		fmt.Println("parse error")
		return
	}
	ids, active, xy, tags, notes := 0, 0, 0, 0, 0
	score := 0.0
	for _, r := range xs {
		ids += r.ID
		if r.Active {
			active++
		}
		score += r.Score
		xy += r.Pos.X + r.Pos.Y
		tags += len(r.Tags)
		if r.Note != nil {
			notes++
		}
	}
	fmt.Println(len(xs), ids, active, fmt.Sprintf("%.2f", score), xy, tags, notes)
}
