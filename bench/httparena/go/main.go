// Go の対照（net 4c — report-671）: HttpArena の go-stdlib エントリ（frameworks/go-stdlib/main.go — net/http・ServeMux）から
// baseline / pipelined / limited-conn / latency / async の端点（/baseline11・/pipeline・/delay/{ms}）と /json/{count}（json-comp の端点 —
// gzip の枝〔acceptsGzip・gzipPool〕も本家のまま — report-714）だけを写したもの（DB・TLS の依存を外す — 標準ライブラリだけで建つ）。
// ハンドラの本体は go-stdlib と同じ。使い方: go run . [port] [tls の port]（既定 8080 / 8081・dataset = DATASET_PATH か /data/dataset.json）。
// POST /echo（8gbit — report-848 / 855）も go-stdlib の echoBody のまま。json-tls（report-841 / 843）: 本家と同じく同じ mux を TLS の port の ListenAndServeTLS でも（証明書 = TLS_CERT / TLS_KEY か /certs/server.{crt,key} —
// 無ければ開かない。本家は /certs の固定の path — 手元と CI で証明書の置き場を変えるために環境変数だけ足した）
package main

import (
	"bytes"
	"compress/gzip"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
)

type Rating struct {
	Score int `json:"score"`
	Count int `json:"count"`
}

type DatasetItem struct {
	ID       int      `json:"id"`
	Name     string   `json:"name"`
	Category string   `json:"category"`
	Price    int      `json:"price"`
	Quantity int      `json:"quantity"`
	Active   bool     `json:"active"`
	Tags     []string `json:"tags"`
	Rating   Rating   `json:"rating"`
}

type ProcessedItem struct {
	DatasetItem
	Total int `json:"total"`
}

type ProcessResponse struct {
	Items []ProcessedItem `json:"items"`
	Count int             `json:"count"`
}

var dataset []DatasetItem

var bufPool = sync.Pool{New: func() any { return new(bytes.Buffer) }}

var gzipPool = sync.Pool{New: func() any {
	w, _ := gzip.NewWriterLevel(io.Discard, gzip.DefaultCompression)
	return w
}}

// The standard library has no compression middleware, so Accept-Encoding is
// parsed here: the gzip token counts only when its q value is above zero.
func acceptsGzip(header string) bool {
	for header != "" {
		part := header
		if i := strings.IndexByte(header, ','); i >= 0 {
			part, header = header[:i], header[i+1:]
		} else {
			header = ""
		}
		name, params, _ := strings.Cut(part, ";")
		if !strings.EqualFold(strings.TrimSpace(name), "gzip") {
			continue
		}
		for params != "" {
			var p string
			p, params, _ = strings.Cut(params, ";")
			p = strings.TrimSpace(p)
			if len(p) > 2 && strings.EqualFold(p[:2], "q=") {
				q, err := strconv.ParseFloat(p[2:], 64)
				return err != nil || q > 0
			}
		}
		return true
	}
	return false
}

// A missing or unreadable dataset leaves the list empty, the server still starts.
func loadDataset() {
	path := os.Getenv("DATASET_PATH")
	if path == "" {
		path = "/data/dataset.json"
	}
	data, err := os.ReadFile(path)
	if err != nil {
		return
	}
	json.Unmarshal(data, &dataset)
}

// echoBody は POST /echo（8gbit — go-stdlib の echoBody のまま: 読み切ってから書く）
func echoBody(w http.ResponseWriter, r *http.Request) {
	body, err := io.ReadAll(r.Body)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}
	w.Header().Set("Content-Type", "application/octet-stream")
	w.Header().Set("Content-Length", strconv.Itoa(len(body)))
	w.Write(body)
}

func jsonItems(w http.ResponseWriter, r *http.Request) {
	count, _ := strconv.Atoi(r.PathValue("count"))
	if count < 0 {
		count = 0
	}
	if count > len(dataset) {
		count = len(dataset)
	}
	m, err := strconv.Atoi(r.URL.Query().Get("m"))
	if err != nil || m == 0 {
		m = 1
	}

	items := make([]ProcessedItem, count)
	for i := 0; i < count; i++ {
		d := dataset[i]
		items[i] = ProcessedItem{DatasetItem: d, Total: d.Price * d.Quantity * m}
	}

	buf := bufPool.Get().(*bytes.Buffer)
	buf.Reset()
	enc := json.NewEncoder(buf)
	if err := enc.Encode(ProcessResponse{Items: items, Count: count}); err != nil {
		bufPool.Put(buf)
		http.Error(w, "", http.StatusInternalServerError)
		return
	}
	body := bytes.TrimSuffix(buf.Bytes(), []byte("\n"))

	h := w.Header()
	h.Set("Content-Type", "application/json")
	if acceptsGzip(r.Header.Get("Accept-Encoding")) {
		out := bufPool.Get().(*bytes.Buffer)
		out.Reset()
		zw := gzipPool.Get().(*gzip.Writer)
		zw.Reset(out)
		_, werr := zw.Write(body)
		cerr := zw.Close()
		gzipPool.Put(zw)
		if werr == nil && cerr == nil {
			h.Set("Content-Encoding", "gzip")
			h.Set("Vary", "Accept-Encoding")
			h.Set("Content-Length", strconv.Itoa(out.Len()))
			w.Write(out.Bytes())
			bufPool.Put(out)
			bufPool.Put(buf)
			return
		}
		bufPool.Put(out)
	}
	h.Set("Content-Length", strconv.Itoa(len(body)))
	w.Write(body)
	bufPool.Put(buf)
}

func pipeline(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/plain")
	w.Write([]byte("ok"))
}

func delay(w http.ResponseWriter, r *http.Request) {
	ms, _ := strconv.Atoi(r.PathValue("ms"))
	if ms > 0 {
		time.Sleep(time.Duration(ms) * time.Millisecond)
	}
	w.Header().Set("Content-Type", "text/plain")
	w.Write([]byte(strconv.Itoa(ms)))
}

func baseline11(w http.ResponseWriter, r *http.Request) {
	sum := 0
	for _, values := range r.URL.Query() {
		for _, v := range values {
			if n, err := strconv.Atoi(v); err == nil {
				sum += n
			}
		}
	}
	if r.Method == http.MethodPost {
		body, err := io.ReadAll(r.Body)
		if err == nil {
			if n, err := strconv.Atoi(strings.TrimSpace(string(body))); err == nil {
				sum += n
			}
		}
	}
	w.Header().Set("Content-Type", "text/plain")
	w.Write([]byte(strconv.Itoa(sum)))
}

func main() {
	port := "8080"
	if len(os.Args) > 1 {
		port = os.Args[1]
	}
	tlsPort := "8081"
	if len(os.Args) > 2 {
		tlsPort = os.Args[2]
	}
	loadDataset()
	mux := http.NewServeMux()
	mux.HandleFunc("GET /pipeline", pipeline)
	mux.HandleFunc("GET /delay/{ms}", delay)
	mux.HandleFunc("GET /baseline11", baseline11)
	mux.HandleFunc("POST /baseline11", baseline11)
	mux.HandleFunc("GET /json/{count}", jsonItems)
	mux.HandleFunc("POST /echo", echoBody)
	cert, key := os.Getenv("TLS_CERT"), os.Getenv("TLS_KEY")
	if cert == "" {
		cert = "/certs/server.crt"
	}
	if key == "" {
		key = "/certs/server.key"
	}
	if _, err := os.Stat(cert); err == nil {
		if _, err := os.Stat(key); err == nil {
			go func() {
				tls := &http.Server{Addr: ":" + tlsPort, Handler: mux}
				tls.ListenAndServeTLS(cert, key)
			}()
		}
	}
	fmt.Println("ready " + port)
	if err := http.ListenAndServe(":"+port, mux); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
