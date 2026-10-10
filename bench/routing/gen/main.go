// bench/routing の入力の生成（決定的 — 線形合同法・シード 42）: 引数 N 行のリクエスト（`METHOD /path?query`）を第 2 引数のファイルへ。
// 約 85% は登録ルート（bench/routing/main.sober と同じ表）のどれかに当たる道、約 10% は 404（知らない区間・末尾の / ・深すぎる道）、
// 約 5% は 405（道は当たるがメソッド PATCH — PATCH のルートは無い）。約 30% にクエリ（page / limit / sort / expand から 1〜3 個）。
// 値は英数字と - _ . だけ（パーセントエンコーディングは入れない）
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var routes = []string{
	"GET /",
	"GET /healthz",
	"GET /api/v1/users",
	"POST /api/v1/users",
	"GET /api/v1/users/me",
	"GET /api/v1/users/:id",
	"PUT /api/v1/users/:id",
	"DELETE /api/v1/users/:id",
	"GET /api/v1/users/:id/orders",
	"POST /api/v1/users/:id/orders",
	"GET /api/v1/users/:id/orders/:oid",
	"DELETE /api/v1/users/:id/orders/:oid",
	"GET /api/v1/users/:id/followers",
	"GET /api/v1/products",
	"POST /api/v1/products",
	"GET /api/v1/products/featured",
	"GET /api/v1/products/:sku",
	"PUT /api/v1/products/:sku",
	"GET /api/v1/products/:sku/reviews",
	"POST /api/v1/products/:sku/reviews",
	"GET /api/v1/products/:sku/reviews/:rid",
	"GET /api/v1/categories",
	"GET /api/v1/categories/:slug",
	"GET /api/v1/categories/:slug/products",
	"GET /api/v1/search",
	"GET /api/v1/orders/:oid",
	"POST /api/v1/orders/:oid/cancel",
	"GET /api/v1/orders/:oid/items/:iid",
	"GET /api/v2/users/:id",
	"GET /api/v2/products/:sku",
	"POST /api/v2/checkout",
	"GET /blog",
	"GET /blog/:slug",
	"GET /blog/:slug/comments",
	"GET /admin",
	"GET /admin/stats",
	"GET /admin/users/:id",
	"POST /admin/users/:id/ban",
	"GET /static/*path",
	"GET /favicon.ico",
}

var seed = uint64(42)

func next() uint64 {
	seed = seed*6364136223846793005 + 1442695040888963407
	return seed >> 33
}

var words = []string{"news", "spring", "sale", "guide", "tips", "home", "garden", "tech", "food", "travel"}

func pick(xs []string) string { return xs[next()%uint64(len(xs))] }

func value(name string) string {
	switch name {
	case "sku":
		return fmt.Sprintf("%c-%04d", 'A'+rune(next()%6), next()%10000)
	case "slug":
		k := 1 + int(next()%3)
		ws := make([]string, k)
		for i := range ws {
			ws[i] = pick(words)
		}
		return strings.Join(ws, "-")
	case "path":
		k := 1 + int(next()%4)
		ws := make([]string, k)
		for i := range ws {
			ws[i] = pick(words)
		}
		ws[k-1] += []string{".css", ".js", ".png", ".v2.js"}[next()%4]
		return strings.Join(ws, "/")
	}
	return strconv.Itoa(1 + int(next()%999999))
}

// path は登録ルート r のパターンに値を詰めた道
func path(r string) (string, string) {
	sp := strings.IndexByte(r, ' ')
	segs := strings.Split(r[sp+2:], "/")
	if r[sp+2:] == "" {
		segs = nil
	}
	var out []string
	for _, s := range segs {
		if s != "" && (s[0] == ':' || s[0] == '*') {
			out = append(out, value(s[1:]))
		} else {
			out = append(out, s)
		}
	}
	return r[:sp], "/" + strings.Join(out, "/")
}

func query() string {
	if next()%10 >= 3 {
		return ""
	}
	k := 1 + int(next()%3)
	qs := make([]string, k)
	for i := range qs {
		switch next() % 4 {
		case 0:
			qs[i] = "page=" + strconv.Itoa(1+int(next()%500))
		case 1:
			qs[i] = "limit=" + strconv.Itoa(10*(1+int(next()%10)))
		case 2:
			qs[i] = "sort=" + pick([]string{"asc", "desc", "new"})
		case 3:
			qs[i] = "expand=" + pick([]string{"items", "reviews", "user"})
		}
	}
	return "?" + strings.Join(qs, "&")
}

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	f, err := os.Create(os.Args[2])
	if err != nil {
		panic(err)
	}
	w := bufio.NewWriterSize(f, 1<<20)
	for i := 0; i < n; i++ {
		m, p := path(routes[next()%uint64(len(routes))])
		switch r := next() % 100; {
		case r < 85:
		case r < 89:
			p = "/api/v3" + p // 知らない区間
		case r < 92:
			p += "/" // 末尾の /
		case r < 95:
			p += "/" + pick(words) + "/" + pick(words) // 深すぎる道（/static の下は当たる）
		default:
			m = "PATCH" // 405
		}
		fmt.Fprintf(w, "%s %s%s\n", m, p, query())
	}
	w.Flush()
	f.Close()
}
