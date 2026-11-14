// std/http/clientの相互接続の相手（scripts/httpinterop.shが起動する）: Goのnet/httpのサーバを平文・TLS 1.3・TLS 1.2だけの3本、127.0.0.1の空きのportで開く。
// 証明書は毎回作る試験用の CA（ECDSA P-256）が署名した葉（SAN = localhost / 127.0.0.1）。<dir>/ca.pem と <dir>/ports（`名前 port` の行）を書いてから <dir>/ready を作る
//   go run ./scripts/oracles/httpserver <dir>
//
// パス: /len（Content-Length）・/chunked（Flushを挟んで3回書く — chunked）・/echo（本文をそのまま）・/auth（受けたAuthorizationの値）・
// /redirect?to=<url>（302）・/see-other（303 → /method）・/method（受けた method）・/head（HEAD でも GET と同じ頭）。
// 加えて forward proxy を平文（proxy）・TLS（sproxy — 同じ葉）・認証つき（authproxy — Proxy-Authorization: Basic dTpw〔u:p〕が要る・無ければ 407）の 3 本:
// 絶対URIのリクエストは転送し（Via: sober-test-proxyを足す）、CONNECTは行き先へTCPを張って双方向にコピーする
package main

import (
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/rand"
	"crypto/tls"
	"crypto/x509"
	"crypto/x509/pkix"
	"encoding/pem"
	"fmt"
	"io"
	"math/big"
	"net"
	"net/http"
	"os"
	"path/filepath"
	"time"
)

func must(err error) {
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}

func mux() *http.ServeMux {
	m := http.NewServeMux()
	m.HandleFunc("/len", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Length", "5")
		io.WriteString(w, "hello")
	})
	m.HandleFunc("/chunked", func(w http.ResponseWriter, r *http.Request) {
		f := w.(http.Flusher)
		for _, s := range []string{"one,", "two,", "three"} {
			io.WriteString(w, s)
			f.Flush()
		}
	})
	m.HandleFunc("/echo", func(w http.ResponseWriter, r *http.Request) {
		b, _ := io.ReadAll(r.Body)
		w.Write(b)
	})
	m.HandleFunc("/auth", func(w http.ResponseWriter, r *http.Request) {
		io.WriteString(w, "auth="+r.Header.Get("Authorization"))
	})
	m.HandleFunc("/redirect", func(w http.ResponseWriter, r *http.Request) {
		http.Redirect(w, r, r.URL.Query().Get("to"), http.StatusFound)
	})
	m.HandleFunc("/see-other", func(w http.ResponseWriter, r *http.Request) {
		http.Redirect(w, r, "/method", http.StatusSeeOther)
	})
	m.HandleFunc("/method", func(w http.ResponseWriter, r *http.Request) {
		b, _ := io.ReadAll(r.Body)
		io.WriteString(w, r.Method+":"+string(b))
	})
	return m
}

// forward proxy（auth = 要る Proxy-Authorization の値 — "" なら見ない）
func proxy(auth string) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if auth != "" && r.Header.Get("Proxy-Authorization") != auth {
			w.WriteHeader(http.StatusProxyAuthRequired)
			return
		}
		if r.Method == http.MethodConnect {
			dst, err := net.Dial("tcp", r.Host)
			if err != nil {
				w.WriteHeader(http.StatusBadGateway)
				return
			}
			hj, _ := w.(http.Hijacker)
			src, buf, err := hj.Hijack()
			if err != nil {
				dst.Close()
				return
			}
			src.Write([]byte("HTTP/1.1 200 Connection established\r\n\r\n"))
			go func() {
				if buf.Reader.Buffered() > 0 {
					b, _ := buf.Reader.Peek(buf.Reader.Buffered())
					dst.Write(b)
				}
				io.Copy(dst, src)
				dst.Close()
			}()
			io.Copy(src, dst)
			src.Close()
			return
		}
		if !r.URL.IsAbs() {
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		out, err := http.NewRequest(r.Method, r.URL.String(), r.Body)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		out.Header = r.Header.Clone()
		out.Header.Del("Proxy-Authorization")
		res, err := http.DefaultTransport.RoundTrip(out)
		if err != nil {
			w.WriteHeader(http.StatusBadGateway)
			return
		}
		defer res.Body.Close()
		for k, vs := range res.Header {
			for _, v := range vs {
				w.Header().Add(k, v)
			}
		}
		w.Header().Set("Via", "sober-test-proxy")
		w.WriteHeader(res.StatusCode)
		io.Copy(w, res.Body)
	})
}

func main() {
	dir := os.Args[1]
	caKey, err := ecdsa.GenerateKey(elliptic.P256(), rand.Reader)
	must(err)
	now := time.Now()
	caTmpl := &x509.Certificate{SerialNumber: big.NewInt(1), Subject: pkix.Name{CommonName: "sober http interop CA"}, NotBefore: now.Add(-time.Hour), NotAfter: now.Add(24 * time.Hour),
		IsCA: true, BasicConstraintsValid: true, KeyUsage: x509.KeyUsageCertSign | x509.KeyUsageDigitalSignature}
	caDer, err := x509.CreateCertificate(rand.Reader, caTmpl, caTmpl, &caKey.PublicKey, caKey)
	must(err)
	ca, err := x509.ParseCertificate(caDer)
	must(err)
	must(os.WriteFile(filepath.Join(dir, "ca.pem"), pem.EncodeToMemory(&pem.Block{Type: "CERTIFICATE", Bytes: caDer}), 0o644))
	k, _ := ecdsa.GenerateKey(elliptic.P256(), rand.Reader)
	tmpl := &x509.Certificate{SerialNumber: big.NewInt(2), Subject: pkix.Name{CommonName: "localhost"}, NotBefore: now.Add(-time.Hour), NotAfter: now.Add(24 * time.Hour),
		DNSNames: []string{"localhost"}, IPAddresses: []net.IP{net.ParseIP("127.0.0.1")}, ExtKeyUsage: []x509.ExtKeyUsage{x509.ExtKeyUsageServerAuth},
		KeyUsage: x509.KeyUsageDigitalSignature}
	der, err := x509.CreateCertificate(rand.Reader, tmpl, ca, &k.PublicKey, caKey)
	must(err)
	cert := tls.Certificate{Certificate: [][]byte{der, caDer}, PrivateKey: k}
	var ports string
	open := func(name string, cfg *tls.Config, h http.Handler) {
		ln, err := net.Listen("tcp", "127.0.0.1:0")
		must(err)
		ports += fmt.Sprintf("%s %d\n", name, ln.Addr().(*net.TCPAddr).Port)
		srv := &http.Server{Handler: h, TLSConfig: cfg}
		if cfg == nil {
			go srv.Serve(ln)
		} else {
			go srv.ServeTLS(ln, "", "")
		}
	}
	open("plain", nil, mux())
	open("tls13", &tls.Config{MinVersion: tls.VersionTLS13, Certificates: []tls.Certificate{cert}, NextProtos: []string{"http/1.1"}}, mux())
	open("tls12", &tls.Config{MinVersion: tls.VersionTLS12, MaxVersion: tls.VersionTLS12, Certificates: []tls.Certificate{cert}, NextProtos: []string{"http/1.1"},
		CipherSuites: []uint16{tls.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256}}, mux())
	open("proxy", nil, proxy(""))
	open("sproxy", &tls.Config{MinVersion: tls.VersionTLS13, Certificates: []tls.Certificate{cert}, NextProtos: []string{"http/1.1"}}, proxy(""))
	open("authproxy", nil, proxy("Basic dTpw"))
	must(os.WriteFile(filepath.Join(dir, "ports"), []byte(ports), 0o644))
	must(os.WriteFile(filepath.Join(dir, "ready"), nil, 0o644))
	select {}
}
