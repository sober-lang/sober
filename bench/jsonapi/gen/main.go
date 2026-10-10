// bench/jsonapi の入力の生成（決定的 — 線形合同法・シード 42）: 引数 N 行の NDJSON（1 行 = 注文の API のリクエスト 1 件）を第 2 引数のファイルへ。
// 約 8% は不正なリクエストで、1 行に欠陥は 1 つだけ（json / missing / type / range / currency — 3 言語で「どの誤りを先に報告するか」の差を持ち込まない）。
// 欄の順と空白は行ごとに揺らす。note はときどき JSON のエスケープ（\" \\ \n é）を含む。数は全部整数（最小単位の通貨）
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var seed = uint64(42)

func next() uint64 {
	seed = seed*6364136223846793005 + 1442695040888963407
	return seed >> 33
}

var words = []string{"gift", "rush", "fragile", "leave at door", "call first", "no bag", "weekend", "office"}

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	f, err := os.Create(os.Args[2])
	if err != nil {
		panic(err)
	}
	w := bufio.NewWriterSize(f, 1<<20)
	for i := 0; i < n; i++ {
		w.WriteString(line(i + 1))
		w.WriteByte('\n')
	}
	w.Flush()
	f.Close()
}

func sp() string {
	if next()%4 == 0 {
		return " "
	}
	return ""
}

func line(id int) string {
	// 欠陥の種類: 0 = なし（92%）・1 = json・2 = missing・3 = type・4 = range・5 = currency
	defect := 0
	if r := next() % 100; r < 8 {
		defect = 1 + int(r%5)
	}
	cur := []string{"JPY", "USD", "EUR"}[next()%3]
	if defect == 5 {
		cur = "GBP"
	}
	nItems := 1 + int(next()%8)
	if defect == 4 && next()%2 == 0 {
		nItems = 0 // range:items
	}
	badQty := -1 // range:qty の欠陥を入れる品目
	if defect == 4 && nItems > 0 {
		badQty = int(next() % uint64(nItems))
	}
	typeAt := -1 // type の欠陥（qty を文字列に）を入れる品目
	if defect == 3 {
		typeAt = int(next() % uint64(nItems))
	}
	var items []string
	for j := 0; j < nItems; j++ {
		qty := 1 + int(next()%20)
		if j == badQty {
			if next()%2 == 0 {
				qty = 0
			} else {
				qty = 101 + int(next()%50)
			}
		}
		price := 1 + int(next()%99999)
		sku := fmt.Sprintf("%c-%04d", 'A'+rune(next()%6), next()%10000)
		q := strconv.Itoa(qty)
		if j == typeAt {
			q = `"` + q + `"`
		}
		fs := []string{
			`"sku":` + sp() + `"` + sku + `"`,
			`"qty":` + sp() + q,
			`"price":` + sp() + strconv.Itoa(price),
		}
		shuffle(fs)
		items = append(items, "{"+strings.Join(fs, ","+sp())+"}")
	}
	fields := []string{
		`"id":` + sp() + strconv.Itoa(id),
		`"user":` + sp() + fmt.Sprintf(`"u%06d"`, next()%1000000),
		`"currency":` + sp() + `"` + cur + `"`,
		`"items":` + sp() + "[" + strings.Join(items, ","+sp()) + "]",
	}
	switch next() % 4 {
	case 0: // coupon なし（欄ごと省く）
	case 1:
		fields = append(fields, `"coupon":`+sp()+`null`)
	case 2:
		fields = append(fields, `"coupon":`+sp()+`"SAVE10"`)
	case 3:
		fields = append(fields, `"coupon":`+sp()+`"FLAT500"`)
	}
	if next()%3 != 0 {
		fields = append(fields, `"note":`+sp()+`"`+note()+`"`)
	}
	if defect == 2 {
		k := int(next() % 4) // id / user / currency / items のどれかを抜く
		fields = append(fields[:k], fields[k+1:]...)
	}
	shuffle(fields)
	s := "{" + sp() + strings.Join(fields, ","+sp()) + sp() + "}"
	if defect == 1 {
		s = s[:len(s)-1] // 閉じ括弧の欠け
	}
	return s
}

func note() string {
	var b strings.Builder
	k := 1 + int(next()%3)
	for j := 0; j < k; j++ {
		if j > 0 {
			b.WriteString(" ")
		}
		b.WriteString(words[next()%uint64(len(words))])
		switch next() % 10 {
		case 0:
			b.WriteString(`\"`)
		case 1:
			b.WriteString(`\\`)
		case 2:
			b.WriteString(`\n`)
		case 3:
			b.WriteString(`café`)
		}
	}
	return b.String()
}

func shuffle(xs []string) {
	for i := len(xs) - 1; i > 0; i-- {
		j := int(next() % uint64(i+1))
		xs[i], xs[j] = xs[j], xs[i]
	}
}
