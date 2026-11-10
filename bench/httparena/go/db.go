// /async-db（本家 go-stdlib の asyncDb・queryItems・loadPgPool の写し — pgx の pool・pool の大きさ = min(DATABASE_MAX_CONN − 8, NumCPU × 4)）。
// DATABASE_URL が無い・繋がらないときは本家と同じく {"items":[],"count":0}
package main

import (
	"context"
	"encoding/json"
	"net/http"
	"os"
	"runtime"
	"strconv"

	"github.com/jackc/pgx/v5/pgxpool"
)

var pgPool *pgxpool.Pool

const itemColumns = "id, name, category, price, quantity, active, tags, rating_score, rating_count"

const emptyItems = `{"items":[],"count":0}`

func loadPgPool() {
	url := os.Getenv("DATABASE_URL")
	if url == "" {
		return
	}
	cfg, err := pgxpool.ParseConfig(url)
	if err != nil {
		return
	}
	budget := 256
	if v := os.Getenv("DATABASE_MAX_CONN"); v != "" {
		if n, err := strconv.Atoi(v); err == nil && n > 0 {
			budget = n
		}
	}
	maxConns := budget - 8
	if m := runtime.NumCPU() * 4; m < maxConns {
		maxConns = m
	}
	if maxConns < 1 {
		maxConns = 1
	}
	cfg.MaxConns = int32(maxConns)
	pool, err := pgxpool.NewWithConfig(context.Background(), cfg)
	if err != nil {
		return
	}
	pgPool = pool
}

func queryItems(ctx context.Context, sql string, args ...any) ([]DatasetItem, error) {
	rows, err := pgPool.Query(ctx, sql, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []DatasetItem{}
	for rows.Next() {
		var it DatasetItem
		var tags []byte
		if err := rows.Scan(&it.ID, &it.Name, &it.Category, &it.Price, &it.Quantity,
			&it.Active, &tags, &it.Rating.Score, &it.Rating.Count); err != nil {
			continue
		}
		json.Unmarshal(tags, &it.Tags)
		if it.Tags == nil {
			it.Tags = []string{}
		}
		items = append(items, it)
	}
	return items, nil
}

func queryInt(r *http.Request, name string, fallback int) int {
	if v := r.URL.Query().Get(name); v != "" {
		if n, err := strconv.Atoi(v); err == nil {
			return n
		}
	}
	return fallback
}

func clamp(v, lo, hi int) int {
	if v < lo {
		return lo
	}
	if v > hi {
		return hi
	}
	return v
}

func writeRaw(w http.ResponseWriter, status int, body []byte) {
	h := w.Header()
	h.Set("Content-Type", "application/json")
	h.Set("Content-Length", strconv.Itoa(len(body)))
	w.WriteHeader(status)
	w.Write(body)
}

func asyncDb(w http.ResponseWriter, r *http.Request) {
	if pgPool == nil {
		writeRaw(w, http.StatusOK, []byte(emptyItems))
		return
	}
	items, err := queryItems(r.Context(),
		"SELECT "+itemColumns+" FROM items WHERE price BETWEEN $1 AND $2 LIMIT $3",
		queryInt(r, "min", 10), queryInt(r, "max", 50), clamp(queryInt(r, "limit", 50), 1, 50))
	if err != nil {
		writeRaw(w, http.StatusOK, []byte(emptyItems))
		return
	}
	body, _ := json.Marshal(map[string]any{"items": items, "count": len(items)})
	writeRaw(w, http.StatusOK, body)
}
