// jsonapi の Go の双子（素直形）: bufio.Scanner で行 → encoding/json の Unmarshal を struct へ（必須欄の有無はポインタの欄の nil で見る）→
// 検証 → 小計・割引・税 → json.Marshal でレスポンス。出力は Sober 版とバイト一致
package main

import (
	"bufio"
	"encoding/json"
	"errors"
	"fmt"
	"os"
)

type Item struct {
	Sku   string `json:"sku"`
	Qty   int    `json:"qty"`
	Price int    `json:"price"`
}

type Req struct {
	ID       *int    `json:"id"`
	User     *string `json:"user"`
	Currency *string `json:"currency"`
	Items    *[]Item `json:"items"`
	Coupon   *string `json:"coupon"`
	Note     *string `json:"note"`
}

type OkResp struct {
	ID       int    `json:"id"`
	Status   string `json:"status"`
	Items    int    `json:"items"`
	Total    int    `json:"total"`
	Currency string `json:"currency"`
}

type ErrResp struct {
	ID     *int   `json:"id"`
	Status string `json:"status"`
	Code   string `json:"code"`
}

var codes = []string{"json", "missing:id", "missing:user", "missing:currency", "missing:items", "type", "range:items", "range:qty", "currency"}

func taxRate(cur string) int {
	switch cur {
	case "JPY":
		return 10
	case "USD":
		return 8
	case "EUR":
		return 20
	}
	return -1
}

func check(r *Req) string {
	switch {
	case r.ID == nil:
		return "missing:id"
	case r.User == nil:
		return "missing:user"
	case r.Currency == nil:
		return "missing:currency"
	case r.Items == nil:
		return "missing:items"
	}
	if len(*r.Items) == 0 {
		return "range:items"
	}
	for _, it := range *r.Items {
		if it.Qty < 1 || it.Qty > 100 {
			return "range:qty"
		}
	}
	if taxRate(*r.Currency) < 0 {
		return "currency"
	}
	return ""
}

func total(r *Req) int {
	sub := 0
	for _, it := range *r.Items {
		sub += it.Qty * it.Price
	}
	disc := 0
	if r.Coupon != nil {
		switch *r.Coupon {
		case "SAVE10":
			disc = sub / 10
		case "FLAT500":
			disc = min(sub, 500)
		}
	}
	after := sub - disc
	return after + after*taxRate(*r.Currency)/100
}

func main() {
	f, err := os.Open(os.Args[1])
	if err != nil {
		os.Exit(1)
	}
	defer f.Close()
	sc := bufio.NewScanner(f)
	sc.Buffer(make([]byte, 1<<20), 1<<20)
	n, ok, jpy, usd, eur, noteBytes := 0, 0, 0, 0, 0, 0
	errs := make(map[string]int)
	h := uint64(14695981039346656037)
	for sc.Scan() {
		n++
		var r Req
		var resp []byte
		code := ""
		if err := json.Unmarshal(sc.Bytes(), &r); err != nil {
			var te *json.UnmarshalTypeError
			if errors.As(err, &te) {
				code = "type"
			} else {
				code = "json"
				r.ID = nil
			}
		} else {
			code = check(&r)
		}
		if code != "" {
			errs[code]++
			resp, _ = json.Marshal(ErrResp{ID: r.ID, Status: "error", Code: code})
		} else {
			t := total(&r)
			ok++
			switch *r.Currency {
			case "JPY":
				jpy += t
			case "USD":
				usd += t
			default:
				eur += t
			}
			if r.Note != nil {
				noteBytes += len(*r.Note)
			}
			resp, _ = json.Marshal(OkResp{ID: *r.ID, Status: "ok", Items: len(*r.Items), Total: t, Currency: *r.Currency})
		}
		for _, c := range resp {
			h = (h ^ uint64(c)) * 1099511628211
		}
		h = (h ^ '\n') * 1099511628211
	}
	w := bufio.NewWriter(os.Stdout)
	defer w.Flush()
	fmt.Fprintf(w, "requests %d\nok %d\n", n, ok)
	for _, c := range codes {
		fmt.Fprintf(w, "error %s %d\n", c, errs[c])
	}
	fmt.Fprintf(w, "total JPY %d\ntotal USD %d\ntotal EUR %d\nnote_bytes %d\nhash %d\n", jpy, usd, eur, noteBytes, int64(h))
}
