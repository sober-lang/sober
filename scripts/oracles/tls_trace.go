// src/std/internal/hs_trace_test.soberの比較用のGoの実装（std/internal/hsの差分オラクル — TLSのタスクR3・report-811 0 節C / 828）。Goのcrypto/tlsのクライアントが
// Soberのテストのliveのパス（TestTraceLive — 場合の名前は環境変数SOBER_TLS_TRACE_LIVE）（127.0.0.1のTCPで待ち受ける子プロセス — 待ち受けのportは子の標準出力の1行目）とTLS 1.3のhandshake → "ping" → "echo:ping" → close_notifyまで往復する。
// 乱数の源は固定（下の //go:debug cryptocustomrand=1 で Config.Rand が効き、走りごとに同じ ClientHello）。Go の検証（証明書の署名〔CertificateVerify〕・
// Finished・recordの保護）を通った往復だけをゴールデンにする: クライアントが送ったバイト列をtestdata/tls/trace-<場合>.hexに、受けたバイト列のSHA-256・
// KeyLogWriterの4つのsecret・受けた平文を標準出力（= testdata/tls/trace.goldenの形）に書く。InsecureSkipVerifyは証明書チェーンの検証だけを外す
// （HttpArena の自己署名の試験用の対 — CertificateVerify の署名は Go が葉の公開鍵で検証する）。再生成:
//   out/stage2/sober2 test std/tls --run TestTraceLive --work /tmp/tt && (cd scripts/oracles && go run tls_trace.go /tmp/tt/t) > testdata/tls/trace.golden
//   （記録が変わったら `sober test std/tls --run TestTrace` で照合 — trace-*.hexとゴールデンはテストに @embedで焼き込まれる）。hrrの場合は openssl s_client の中継（viaOpenSSL）
//
//go:debug cryptocustomrand=1
package main

import (
	"bufio"
	"bytes"
	"crypto/sha256"
	"crypto/tls"
	"encoding/hex"
	"fmt"
	"io"
	"net"
	"os"
	"os/exec"
	"strings"
	"time"
)

// recConn は TCP の接続の両方向のバイト列を記録する net.Conn
type recConn struct {
	net.Conn
	c2s bytes.Buffer
	s2c bytes.Buffer
}

func (p *recConn) Read(b []byte) (int, error) {
	n, err := p.Conn.Read(b)
	p.s2c.Write(b[:n])
	return n, err
}
func (p *recConn) Write(b []byte) (int, error) {
	p.c2s.Write(b)
	return p.Conn.Write(b)
}

// fixedRand は決定的な乱数（カウンタの SHA-256 の列）
type fixedRand struct {
	seed string
	n    int
	buf  []byte
}

func (f *fixedRand) Read(b []byte) (int, error) {
	for len(f.buf) < len(b) {
		h := sha256.Sum256([]byte(fmt.Sprintf("%s/%d", f.seed, f.n)))
		f.n++
		f.buf = append(f.buf, h[:]...)
	}
	copy(b, f.buf)
	f.buf = f.buf[len(b):]
	return len(b), nil
}

// liveはSoberのテストの実行ファイルのliveのパス（TestTraceLive）の子プロセス
func live(bin, name string) *exec.Cmd {
	cmd := exec.Command(bin, "TestTraceLive")
	cmd.Env = append(os.Environ(), "SOBER_TLS_TRACE_LIVE="+name)
	return cmd
}

func one(bin, name string) {
	cmd := live(bin, name)
	out, _ := cmd.StdoutPipe()
	var serr bytes.Buffer
	cmd.Stderr = &serr
	if err := cmd.Start(); err != nil {
		panic(err)
	}
	line, err := bufio.NewReader(out).ReadString('\n')
	if err != nil {
		panic(err)
	}
	tc, err := net.DialTimeout("tcp", "127.0.0.1:"+strings.TrimSpace(strings.TrimPrefix(line, "port ")), 5*time.Second)
	if err != nil {
		panic(err)
	}
	tc.SetDeadline(time.Now().Add(20 * time.Second))
	pc := &recConn{Conn: tc}
	var keylog bytes.Buffer
	cfg := &tls.Config{
		Rand:               &fixedRand{seed: "go-client-" + name},
		InsecureSkipVerify: true,
		NextProtos:         []string{"http/1.1"},
		MinVersion:         tls.VersionTLS13,
		KeyLogWriter:       &keylog,
		CurvePreferences:   []tls.CurveID{tls.X25519},
		ServerName:         "localhost",
	}
	c := tls.Client(pc, cfg)
	fail := func(what string, err error) {
		fmt.Fprintf(os.Stderr, "%s: %s: %v\nsober stderr:\n%s", name, what, err, serr.String())
		os.Exit(1)
	}
	if err := c.Handshake(); err != nil {
		fail("handshake", err)
	}
	st := c.ConnectionState()
	if _, err := c.Write([]byte("ping")); err != nil {
		fail("write", err)
	}
	buf := make([]byte, 64)
	n, err := c.Read(buf)
	if err != nil {
		fail("read", err)
	}
	reply := string(buf[:n])
	c.CloseWrite()
	io.Copy(io.Discard, c)
	tc.Close()
	cmd.Wait()
	// 4 つの secret（KeyLogWriter の CLIENT_HANDSHAKE_TRAFFIC_SECRET 等 — 3 列目）
	sec := map[string]string{}
	sc := bufio.NewScanner(&keylog)
	for sc.Scan() {
		f := strings.Fields(sc.Text())
		if len(f) == 3 {
			sec[f[0]] = f[2]
		}
	}
	if err := os.WriteFile("../../testdata/tls/trace-"+name+".hex", []byte(hex.EncodeToString(pc.c2s.Bytes())), 0o644); err != nil {
		panic(err)
	}
	suite := 0x1301
	if st.CipherSuite == tls.TLS_CHACHA20_POLY1305_SHA256 {
		suite = 0x1303
	}
	s2c := sha256.Sum256(pc.s2c.Bytes())
	for _, size := range []int{65536, 7} {
		fmt.Printf("== %s (chunk %d)\n", name, size)
		fmt.Printf("secrets %s %s %s %s\n", sec["CLIENT_HANDSHAKE_TRAFFIC_SECRET"], sec["SERVER_HANDSHAKE_TRAFFIC_SECRET"], sec["CLIENT_TRAFFIC_SECRET_0"], sec["SERVER_TRAFFIC_SECRET_0"])
		fmt.Printf("alpn %s suite %d\n", st.NegotiatedProtocol, suite)
		fmt.Printf("app ping\n")
		fmt.Printf("closed 0\n")
		fmt.Printf("s2c %s\n", hex.EncodeToString(s2c[:]))
	}
	if reply != "echo:ping" {
		fail("reply", fmt.Errorf("got %q", reply))
	}
}

// viaOpenSSL は hrr の場合: Go 1.24 以降の crypto/tls は CurvePreferences の順を無視して X25519 の key_share を出すので HelloRetryRequest を
// 起動できない — openssl s_client（-groups P-256:X25519 = key_shareはP-256だけ）を中継して記録する。opensslの乱数は決められないので
// 取り直すたびに記録は変わる（ゴールデンの資格 = opensslがhandshakeを受理し "echo:ping" を受けた・HRRが起きた〔ServerHello 2通〕・
// openssl の -keylogfile の 4 つの secret ≡ Sober の key schedule の値）
func viaOpenSSL(bin, name string) {
	cmd := live(bin, name)
	out, _ := cmd.StdoutPipe()
	var serr bytes.Buffer
	cmd.Stderr = &serr
	if err := cmd.Start(); err != nil {
		panic(err)
	}
	line, err := bufio.NewReader(out).ReadString('\n')
	if err != nil {
		panic(err)
	}
	sport := strings.TrimSpace(strings.TrimPrefix(line, "port "))
	ln, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		panic(err)
	}
	var c2s, s2c bytes.Buffer
	done := make(chan bool)
	go func() {
		cc, err := ln.Accept()
		if err != nil {
			panic(err)
		}
		sc, err := net.Dial("tcp", "127.0.0.1:"+sport)
		if err != nil {
			panic(err)
		}
		up := make(chan bool)
		go func() { io.Copy(io.MultiWriter(sc, &c2s), cc); sc.(*net.TCPConn).CloseWrite(); up <- true }()
		io.Copy(io.MultiWriter(cc, &s2c), sc)
		<-up
		cc.Close()
		sc.Close()
		done <- true
	}()
	kl, _ := os.CreateTemp("", "tls-trace-keylog")
	kl.Close()
	defer os.Remove(kl.Name())
	oc := exec.Command("openssl", "s_client", "-connect", ln.Addr().String(), "-tls1_3", "-groups", "P-256:X25519", "-alpn", "http/1.1", "-msg", "-keylogfile", kl.Name())
	stdin, _ := oc.StdinPipe()
	var oout bytes.Buffer
	oc.Stdout = &oout
	oc.Stderr = &oout
	if err := oc.Start(); err != nil {
		panic(err)
	}
	stdin.Write([]byte("ping"))
	time.Sleep(time.Second)
	stdin.Close()
	oc.Wait()
	<-done
	cmd.Wait()
	fail := func(what string) {
		fmt.Fprintf(os.Stderr, "%s: %s\nopenssl:\n%s\nsober stderr:\n%s", name, what, oout.String(), serr.String())
		os.Exit(1)
	}
	if !strings.Contains(oout.String(), "echo:ping") {
		fail("no echo:ping")
	}
	if strings.Count(oout.String(), "Handshake") == 0 || strings.Count(oout.String(), ", ServerHello") != 2 {
		fail("no HelloRetryRequest (want 2 ServerHello)")
	}
	kb, _ := os.ReadFile(kl.Name())
	sec := map[string]string{}
	for _, l := range strings.Split(string(kb), "\n") {
		f := strings.Fields(l)
		if len(f) == 3 {
			sec[f[0]] = f[2]
		}
	}
	want := fmt.Sprintf("secrets %s %s %s %s", sec["CLIENT_HANDSHAKE_TRAFFIC_SECRET"], sec["SERVER_HANDSHAKE_TRAFFIC_SECRET"], sec["CLIENT_TRAFFIC_SECRET_0"], sec["SERVER_TRAFFIC_SECRET_0"])
	log := serr.String()
	if !strings.Contains(log, want+"\n") {
		fail("secrets differ from openssl's keylog: " + want)
	}
	if err := os.WriteFile("../../testdata/tls/trace-"+name+".hex", []byte(hex.EncodeToString(c2s.Bytes())), 0o644); err != nil {
		panic(err)
	}
	sum := sha256.Sum256(s2c.Bytes())
	for _, size := range []int{65536, 7} {
		fmt.Printf("== %s (chunk %d)\n%ss2c %s\n", name, size, log, hex.EncodeToString(sum[:]))
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "usage: go run tls_trace.go <sober test std/tls の実行ファイル（--work の下の t）>")
		os.Exit(2)
	}
	for _, name := range []string{"aes", "chacha"} {
		one(os.Args[1], name)
	}
	viaOpenSSL(os.Args[1], "hrr")
}
