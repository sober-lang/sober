# DNS

[English](dns.md) · [準拠文書](README.ja.md)

## 範囲

`std/net` の名前の解決（スタブリゾルバ — `net.Dial` が IPv4 の綴りでないホストを受けたとき）。libc の getaddrinfo を使わない。再帰のリゾルバ・権威サーバは持たない。

## 対応

<!-- confsync:begin claims dns-resolver yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| スタブリゾルバ（libc を使わない）: /etc/hosts → /etc/resolv.conf の nameserver（3 本まで・期限つき・attempts） | 対応 | `std/net.TestResolvConf`<br>`std/net.TestHosts`<br>相互接続 dns: 7（2026-11-06） |
| search / ndots の候補の順（resolv.conf(5)） | 対応 | `std/net.TestCandidates` |
| 切り詰め（TC）は TCP で問い直す・CNAME の鎖（8 段まで） | 対応 | `std/net.TestParseAnswer`<br>相互接続 dns: 7（2026-11-06） |
| 偽装への備え: txid は getrandom・応答の txid と問いの名前と型の一致を確かめる・名前の圧縮の輪を断つ | 対応 | `std/net.TestParseAnswer`<br>相互接続 dns: 7（2026-11-06） |
| A と AAAA を読む（Dial は IPv4 だけ） | 一部 | `std/net.TestParseAnswer`<br>`std/net.TestDialLocalhost` |
<!-- confsync:end claims dns-resolver yes,partial -->

## 意図して外したこと

<!-- confsync:begin claims dns-resolver intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| 非 ASCII のホスト名（IDN は URL の層の仕事 — 名指しで拒否） | 意図して非対応 | `std/net.TestNameCheck` |
| DNSSEC の検証（スタブは上流のリゾルバを信頼する） | 意図して非対応 | — |
| DoH / DoT・キャッシュ（OS や上流の役） | 意図して非対応 | — |
<!-- confsync:end claims dns-resolver intentional -->

## 未実装

<!-- confsync:begin claims dns-resolver planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| EDNS0（今は 512 バイトを超える応答が TCP へ倒れる） | 0.8 圏 | — |
| IPv6 の nameserver と IPv6 への Dial | 0.8 圏 | — |
<!-- confsync:end claims dns-resolver planned -->

## 証拠 — 相互接続

<!-- confsync:begin interop-dns -->
最終確認: 2026-11-06（木 8314196f0ed4 (dirty) — scripts/dnsinterop.sh・偽の DNS サーバ 7 題材: CNAME の鎖・TC → TCP・txid の偽装・search・NXDOMAIN・期限切れ）
<!-- confsync:end interop-dns -->
