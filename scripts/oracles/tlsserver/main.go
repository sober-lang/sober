// std/internal/hscのクライアントの相互接続の相手（scripts/tlsinterop.shが起動する）: 試験用のCA（ECDSA P-256）と、そのCAが署名した葉
// （ECDSA P-256・ECDSA P-384・RSA-2048 — SAN = localhost / 127.0.0.1）を毎回作り、葉ごとに TLS 1.3（X25519 だけ）のサーバを 127.0.0.1 の空きの port で開く。
// 加えて TLS 1.2 だけのサーバ（名前に -12 — ECDSA / RSA × AES-128-GCM / ChaCha20・クライアント証明書を求める req）も開く。
// リクエストの頭（空行まで）を読んで `HTTP/1.1 200 OK` と本文 `ok-<葉の名前>` を返して閉じる。<dir>/ca.pemと <dir>/ports（`名前 port` の行）を書いてから <dir>/readyを作る
//   go run ./scripts/oracles/tlsserver <dir>
package main

import (
	"bufio"
	"crypto"
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/rand"
	"crypto/rsa"
	"crypto/tls"
	"crypto/x509"
	"crypto/x509/pkix"
	"encoding/pem"
	"fmt"
	"math/big"
	"net"
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

func main() {
	dir := os.Args[1]
	caKey, err := ecdsa.GenerateKey(elliptic.P256(), rand.Reader)
	must(err)
	now := time.Now()
	caTmpl := &x509.Certificate{SerialNumber: big.NewInt(1), Subject: pkix.Name{CommonName: "sober interop CA"}, NotBefore: now.Add(-time.Hour), NotAfter: now.Add(24 * time.Hour),
		IsCA: true, BasicConstraintsValid: true, KeyUsage: x509.KeyUsageCertSign | x509.KeyUsageDigitalSignature}
	caDer, err := x509.CreateCertificate(rand.Reader, caTmpl, caTmpl, &caKey.PublicKey, caKey)
	must(err)
	ca, err := x509.ParseCertificate(caDer)
	must(err)
	must(os.WriteFile(filepath.Join(dir, "ca.pem"), pem.EncodeToMemory(&pem.Block{Type: "CERTIFICATE", Bytes: caDer}), 0o644))
	type leaf struct {
		name   string
		key    crypto.Signer
		max    uint16
		suites []uint16
		req    bool
		curve  tls.CurveID
	}
	k256, _ := ecdsa.GenerateKey(elliptic.P256(), rand.Reader)
	k384, _ := ecdsa.GenerateKey(elliptic.P384(), rand.Reader)
	krsa, _ := rsa.GenerateKey(rand.Reader, 2048)
	var ports string
	// p256-ecdhe = 鍵共有を secp256r1 だけにしたサーバ（X25519 の key_share に HelloRetryRequest で secp256r1 を求める — PostgreSQL 17 以前の既定と同じ形）
	x := tls.X25519
	leaves := []leaf{{"p256", k256, tls.VersionTLS13, nil, false, x}, {"p384", k384, tls.VersionTLS13, nil, false, x}, {"rsa", krsa, tls.VersionTLS13, nil, false, x},
		{"p256-ecdhe", k256, tls.VersionTLS13, nil, false, tls.CurveP256},
		{"p256-12-gcm", k256, tls.VersionTLS12, []uint16{tls.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256}, false, x},
		{"p256-12-chacha", k256, tls.VersionTLS12, []uint16{tls.TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256}, false, x},
		{"rsa-12-gcm", krsa, tls.VersionTLS12, []uint16{tls.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256}, false, x},
		{"rsa-12-chacha", krsa, tls.VersionTLS12, []uint16{tls.TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256}, false, x},
		{"rsa-12-req", krsa, tls.VersionTLS12, []uint16{tls.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256}, true, x}}
	for i, l := range leaves {
		tmpl := &x509.Certificate{SerialNumber: big.NewInt(int64(10 + i)), Subject: pkix.Name{CommonName: "localhost"}, NotBefore: now.Add(-time.Hour), NotAfter: now.Add(24 * time.Hour),
			DNSNames: []string{"localhost"}, IPAddresses: []net.IP{net.ParseIP("127.0.0.1")}, ExtKeyUsage: []x509.ExtKeyUsage{x509.ExtKeyUsageServerAuth},
			KeyUsage: x509.KeyUsageDigitalSignature}
		der, err := x509.CreateCertificate(rand.Reader, tmpl, ca, l.key.Public(), caKey)
		must(err)
		cfg := &tls.Config{MinVersion: l.max, MaxVersion: l.max, CurvePreferences: []tls.CurveID{l.curve}, NextProtos: []string{"http/1.1"},
			CipherSuites: l.suites, Certificates: []tls.Certificate{{Certificate: [][]byte{der, caDer}, PrivateKey: l.key}}}
		if l.req {
			cfg.ClientAuth = tls.RequestClientCert
		}
		ln, err := tls.Listen("tcp", "127.0.0.1:0", cfg)
		must(err)
		ports += fmt.Sprintf("%s %d\n", l.name, ln.Addr().(*net.TCPAddr).Port)
		go func(name string, ln net.Listener) {
			for {
				c, err := ln.Accept()
				if err != nil {
					return
				}
				go func(c net.Conn) {
					defer c.Close()
					r := bufio.NewReader(c)
					for {
						s, err := r.ReadString('\n')
						if err != nil || s == "\r\n" {
							break
						}
					}
					fmt.Fprintf(c, "HTTP/1.1 200 OK\r\nContent-Length: %d\r\nConnection: close\r\n\r\nok-%s", 3+len(name), name)
				}(c)
			}
		}(l.name, ln)
	}
	must(os.WriteFile(filepath.Join(dir, "ports"), []byte(ports), 0o644))
	must(os.WriteFile(filepath.Join(dir, "ready"), nil, 0o644))
	time.Sleep(5 * time.Minute)
}
