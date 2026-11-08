// std/net の名前の解決の送受の網の相手（scripts/dnsinterop.sh が起こす — 標準ライブラリだけの偽の DNS サーバ）: 127.0.0.1 の空きの port で UDP と TCP を受け、
// 決めた名前に決めた応答を返す — a.test（A 10.0.0.1）・alias.test（CNAME a.test + A）・big.test（UDP は TC を立てて空・TCP は A 10.0.0.2）・nx.test（NXDOMAIN）・
// spoof.test（先に txid の違う応答・次に A 10.0.0.3）・slow.test（答えない）・svc.corp.test（A 10.0.0.4 — search で引く名前）。<dir>/port を書いてから <dir>/ready
//   go run scripts/oracles/dnsserver/main.go <dir>
package main

import (
	"encoding/binary"
	"fmt"
	"io"
	"net"
	"os"
	"path/filepath"
	"strings"
	"time"
)

func qname(b []byte) (string, int) {
	var parts []string
	i := 12
	for i < len(b) && b[i] != 0 {
		l := int(b[i])
		parts = append(parts, strings.ToLower(string(b[i+1:i+1+l])))
		i += 1 + l
	}
	return strings.Join(parts, "."), i + 1
}

func wire(n string) []byte {
	var o []byte
	for _, l := range strings.Split(n, ".") {
		o = append(o, byte(len(l)))
		o = append(o, l...)
	}
	return append(o, 0)
}

func rr(name []byte, t uint16, data []byte) []byte {
	o := append([]byte{}, name...)
	o = binary.BigEndian.AppendUint16(o, t)
	o = append(o, 0, 1, 0, 0, 0, 60)
	o = binary.BigEndian.AppendUint16(o, uint16(len(data)))
	return append(o, data...)
}

// q への応答（tcp = TCP で来た・ok = 返すか）
func answer(q []byte, tcp bool) ([][]byte, bool) {
	name, end := qname(q)
	head := func(id uint16, flags byte, rcode byte, an int, body []byte) []byte {
		o := []byte{byte(id >> 8), byte(id), 0x81 | flags, 0x80 | rcode, 0, 1, 0, byte(an), 0, 0, 0, 0}
		o = append(o, q[12:end+4]...)
		return append(o, body...)
	}
	id := binary.BigEndian.Uint16(q)
	ptr := []byte{0xc0, 12}
	switch name {
	case "a.test":
		return [][]byte{head(id, 0, 0, 1, rr(ptr, 1, []byte{10, 0, 0, 1}))}, true
	case "alias.test":
		return [][]byte{head(id, 0, 0, 2, append(rr(ptr, 5, wire("a.test")), rr(wire("a.test"), 1, []byte{10, 0, 0, 1})...))}, true
	case "big.test":
		if !tcp {
			return [][]byte{head(id, 0x02, 0, 0, nil)}, true
		}
		return [][]byte{head(id, 0, 0, 1, rr(ptr, 1, []byte{10, 0, 0, 2}))}, true
	case "spoof.test":
		return [][]byte{head(id^1, 0, 0, 1, rr(ptr, 1, []byte{6, 6, 6, 6})), head(id, 0, 0, 1, rr(ptr, 1, []byte{10, 0, 0, 3}))}, true
	case "slow.test":
		return nil, false
	case "svc.corp.test":
		return [][]byte{head(id, 0, 0, 1, rr(ptr, 1, []byte{10, 0, 0, 4}))}, true
	}
	return [][]byte{head(id, 0, 3, 0, nil)}, true
}

func main() {
	dir := os.Args[1]
	udp, err := net.ListenPacket("udp", "127.0.0.1:0")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	port := udp.LocalAddr().(*net.UDPAddr).Port
	tcp, err := net.Listen("tcp", fmt.Sprintf("127.0.0.1:%d", port))
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	go func() {
		buf := make([]byte, 512)
		for {
			n, a, err := udp.ReadFrom(buf)
			if err != nil {
				return
			}
			rs, ok := answer(append([]byte{}, buf[:n]...), false)
			if ok {
				for _, r := range rs {
					udp.WriteTo(r, a)
				}
			}
		}
	}()
	go func() {
		for {
			c, err := tcp.Accept()
			if err != nil {
				return
			}
			go func(c net.Conn) {
				defer c.Close()
				var l [2]byte
				if _, err := io.ReadFull(c, l[:]); err != nil {
					return
				}
				q := make([]byte, binary.BigEndian.Uint16(l[:]))
				if _, err := io.ReadFull(c, q); err != nil {
					return
				}
				rs, ok := answer(q, true)
				if ok {
					r := rs[len(rs)-1]
					c.Write(append(binary.BigEndian.AppendUint16(nil, uint16(len(r))), r...))
				}
			}(c)
		}
	}()
	os.WriteFile(filepath.Join(dir, "port"), []byte(fmt.Sprint(port)), 0o644)
	os.WriteFile(filepath.Join(dir, "ready"), nil, 0o644)
	time.Sleep(5 * time.Minute)
}
