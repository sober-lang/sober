// routing の Go の双子（素直形 — Sober 版と同じ手書きの線形照合: 登録順の最初の一致）: bufio.Scanner で行 → strings.Split で区間 →
// map[string]string にパラメータとクエリ → ハンドラが名前で引く。出力は Sober 版とバイト一致
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var table = []string{
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

type Route struct {
	method string
	segs   []string
}

func split(s string, sep string) []string {
	if s == "" {
		return nil
	}
	return strings.Split(s, sep)
}

func match(r Route, segs []string, ps map[string]string) bool {
	n := len(r.segs)
	wild := n > 0 && strings.HasPrefix(r.segs[n-1], "*")
	if wild {
		if len(segs) < n {
			return false
		}
	} else if len(segs) != n {
		return false
	}
	for k, p := range r.segs {
		if wild && k == n-1 {
			ps[p[1:]] = strings.Join(segs[k:], "/")
		} else if strings.HasPrefix(p, ":") {
			ps[p[1:]] = segs[k]
		} else if p != segs[k] {
			return false
		}
	}
	return true
}

func atoi(s string) int {
	n, _ := strconv.Atoi(s)
	return n
}

func main() {
	var routes []Route
	for _, spec := range table {
		sp := strings.IndexByte(spec, ' ')
		routes = append(routes, Route{method: spec[:sp], segs: split(spec[sp+2:], "/")})
	}
	f, err := os.Open(os.Args[1])
	if err != nil {
		os.Exit(1)
	}
	defer f.Close()
	sc := bufio.NewScanner(f)
	hits := make([]int, len(routes))
	n, nf, na, numSum, strBytes, pageSum := 0, 0, 0, 0, 0, 0
	h := uint64(14695981039346656037)
	fnv := func(s string) {
		for i := 0; i < len(s); i++ {
			h = (h ^ uint64(s[i])) * 1099511628211
		}
	}
	for sc.Scan() {
		line := sc.Text()
		n++
		sp := strings.IndexByte(line, ' ')
		method, target := line[:sp], line[sp+1:]
		path, query, _ := strings.Cut(target, "?")
		segs := split(path[1:], "/")
		qs := map[string]string{}
		for _, kv := range split(query, "&") {
			k, v, _ := strings.Cut(kv, "=")
			qs[k] = v
		}
		found := -1
		ps := map[string]string{}
		for ri, r := range routes {
			if r.method == method && match(r, segs, ps) {
				found = ri
				break
			}
		}
		if found < 0 {
			any := false
			for _, r := range routes {
				if match(r, segs, map[string]string{}) {
					any = true
					break
				}
			}
			if any {
				na++
				fnv("405\n")
			} else {
				nf++
				fnv("404\n")
			}
			continue
		}
		hits[found]++
		fnv(strconv.Itoa(found))
		for _, p := range routes[found].segs {
			if strings.HasPrefix(p, ":") || strings.HasPrefix(p, "*") {
				name := p[1:]
				if x, ok := ps[name]; ok {
					fnv("|")
					fnv(x)
					if name == "sku" || name == "slug" || name == "path" {
						strBytes += len(x)
					} else {
						numSum += atoi(x)
					}
				}
			}
		}
		if pg, ok := qs["page"]; ok {
			pageSum += atoi(pg)
		}
		fnv("\n")
	}
	w := bufio.NewWriter(os.Stdout)
	defer w.Flush()
	fmt.Fprintf(w, "requests %d\n", n)
	for k, c := range hits {
		fmt.Fprintf(w, "route %d %d\n", k, c)
	}
	fmt.Fprintf(w, "404 %d\n405 %d\nnum_sum %d\nstr_bytes %d\npage_sum %d\nhash %d\n", nf, na, numSum, strBytes, pageSum, int64(h))
}
