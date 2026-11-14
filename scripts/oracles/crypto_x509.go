// std/internal/x509の証明書の読み（white-box — x509_test.sober）の比較用のGoの実装: testdata/x509/go/*.pem（Goのcrypto/x509のverify_test.goに埋め込まれた証明書）と
// testdata/x509/pkits/certs.txt（NIST PKITSの証明書 — 1行 = `ファイル名 DER の base64`）をcrypto/x509で読み、1証明書1行でフィールドを出す。再生成:
//   go run scripts/oracles/crypto_x509.go > testdata/x509/fields.txt
// 行 = `名前 v= sig= pub= nb= na= ca= pl= ku= eku= dns= ip= ski= aki= tbs= spki= iss= sub=`（ハッシュは SHA-256 の先頭 8 バイトの 16 進・列は , 区切りで整列・無いものは -）
package main

import (
	"crypto/ecdsa"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/base64"
	"encoding/hex"
	"encoding/pem"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"
)

func h8(b []byte) string {
	s := sha256.Sum256(b)
	return hex.EncodeToString(s[:8])
}

func opt(b []byte) string {
	if len(b) == 0 {
		return "-"
	}
	return hex.EncodeToString(b)
}

func list(xs []string) string {
	if len(xs) == 0 {
		return "-"
	}
	sort.Strings(xs)
	return strings.Join(xs, ",")
}

var ekuOID = map[x509.ExtKeyUsage]string{
	x509.ExtKeyUsageAny: "2.5.29.37.0", x509.ExtKeyUsageServerAuth: "1.3.6.1.5.5.7.3.1", x509.ExtKeyUsageClientAuth: "1.3.6.1.5.5.7.3.2",
	x509.ExtKeyUsageCodeSigning: "1.3.6.1.5.5.7.3.3", x509.ExtKeyUsageEmailProtection: "1.3.6.1.5.5.7.3.4", x509.ExtKeyUsageIPSECEndSystem: "1.3.6.1.5.5.7.3.5",
	x509.ExtKeyUsageIPSECTunnel: "1.3.6.1.5.5.7.3.6", x509.ExtKeyUsageIPSECUser: "1.3.6.1.5.5.7.3.7", x509.ExtKeyUsageTimeStamping: "1.3.6.1.5.5.7.3.8",
	x509.ExtKeyUsageOCSPSigning: "1.3.6.1.5.5.7.3.9", x509.ExtKeyUsageMicrosoftServerGatedCrypto: "1.3.6.1.4.1.311.10.3.3",
	x509.ExtKeyUsageNetscapeServerGatedCrypto: "2.16.840.1.113730.4.1", x509.ExtKeyUsageMicrosoftCommercialCodeSigning: "1.3.6.1.4.1.311.2.1.22",
	x509.ExtKeyUsageMicrosoftKernelCodeSigning: "1.3.6.1.4.1.311.61.1.1",
}

func line(name string, der []byte) string {
	c, err := x509.ParseCertificate(der)
	if err != nil {
		return name + " error"
	}
	pub := "other"
	switch k := c.PublicKey.(type) {
	case *ecdsa.PublicKey:
		pub = "ec-" + k.Curve.Params().Name
	case *rsa.PublicKey:
		pub = fmt.Sprintf("rsa-%d", k.N.BitLen())
	}
	ca, pl := "-", "-"
	if c.BasicConstraintsValid {
		ca = fmt.Sprint(c.IsCA)
		if c.MaxPathLen > 0 || c.MaxPathLenZero {
			pl = fmt.Sprint(c.MaxPathLen)
		}
	}
	var eku []string
	for _, e := range c.ExtKeyUsage {
		eku = append(eku, ekuOID[e])
	}
	for _, o := range c.UnknownExtKeyUsage {
		eku = append(eku, o.String())
	}
	var ips []string
	for _, ip := range c.IPAddresses {
		ips = append(ips, ip.String())
	}
	return fmt.Sprintf("%s v=%d sig=%s pub=%s nb=%d na=%d ca=%s pl=%s ku=%d eku=%s dns=%s ip=%s ski=%s aki=%s tbs=%s spki=%s iss=%s sub=%s",
		name, c.Version, c.SignatureAlgorithm, pub, c.NotBefore.Unix(), c.NotAfter.Unix(), ca, pl, int(c.KeyUsage), list(eku), list(c.DNSNames), list(ips),
		opt(c.SubjectKeyId), opt(c.AuthorityKeyId), h8(c.RawTBSCertificate), h8(c.RawSubjectPublicKeyInfo), h8(c.RawIssuer), h8(c.RawSubject))
}

func main() {
	gs, _ := filepath.Glob("testdata/x509/go/*.pem")
	for _, f := range gs {
		b, _ := os.ReadFile(f)
		p, _ := pem.Decode(b)
		fmt.Println(line("go/"+filepath.Base(f), p.Bytes))
	}
	pk, _ := os.ReadFile("testdata/x509/pkits/certs.txt")
	for _, l := range strings.Split(strings.TrimSpace(string(pk)), "\n") {
		f := strings.Fields(l)
		b, _ := base64.StdEncoding.DecodeString(f[1])
		fmt.Println(line("pkits/"+f[0], b))
	}
}
