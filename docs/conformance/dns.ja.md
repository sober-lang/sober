# DNS

[English](dns.md) · [準拠文書](README.ja.md)

## 範囲

`std/net` の名前の解決（スタブリゾルバ — `net.Dial` がIPv4の綴りでないホストを受けたとき）。libcのgetaddrinfoを使わない。再帰のリゾルバ・権威サーバは持たない。

## 対応

<!-- confsync:begin claims dns-resolver yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| スタブリゾルバ（libcを使わない）: /etc/hosts → /etc/resolv.confのnameserver（3本まで・期限つき・attempts） | 対応 | `std/net.TestResolvConf`<br>`std/net.TestHosts`<br>相互接続dns: 7（2026-11-06） |
| search / ndotsの候補の順（resolv.conf(5)） | 対応 | `std/net.TestCandidates` |
| 切り詰め（TC）はTCPで問い直す・CNAMEのチェーン（深さ8まで） | 対応 | `std/net.TestParseAnswer`<br>相互接続dns: 7（2026-11-06） |
| 偽装への備え: txidはgetrandom・レスポンスのtxidと問いの名前と型の一致を確認する・名前の圧縮のループを断つ | 対応 | `std/net.TestParseAnswer`<br>相互接続dns: 7（2026-11-06） |
| AとAAAAを読む（DialはIPv4だけ） | 一部 | `std/net.TestParseAnswer`<br>`std/net.TestDialLocalhost` |
<!-- confsync:end claims dns-resolver yes,partial -->

## 意図して外したこと

<!-- confsync:begin claims dns-resolver intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| 非ASCIIのホスト名（IDNはURLの層の仕事 — 専用の診断で拒否） | 意図して非対応 | `std/net.TestNameCheck` |
| DNSSECの検証（スタブは上流のリゾルバを信頼する） | 意図して非対応 | — |
| DoH / DoT・キャッシュ（OSや上流の役） | 意図して非対応 | — |
<!-- confsync:end claims dns-resolver intentional -->

## 未実装

<!-- confsync:begin claims dns-resolver planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| EDNS0（今は512バイトを超えるレスポンスがTCPへフォールバックする） | 0.8圏 | — |
| IPv6のnameserverとIPv6へのDial | 0.8圏 | — |
<!-- confsync:end claims dns-resolver planned -->

## 証拠 — 相互接続

<!-- confsync:begin interop-dns -->
最終確認: 2026-11-06（木8314196f0ed4 (dirty) — scripts/dnsinterop.sh・偽のDNSサーバ7題材: CNAMEのチェーン・TC → TCP・txidの偽装・search・NXDOMAIN・期限切れ）
<!-- confsync:end interop-dns -->
