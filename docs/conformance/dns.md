# DNS

[日本語](dns.ja.md) · [Conformance](README.md)

## Scope

Name resolution in `std/net`: a stub resolver, used when `net.Dial` gets a host that is not an IP address literal. It does not use libc's getaddrinfo. There is no recursive resolver and no authoritative server.

## Supported

<!-- confsync:begin claims dns-resolver yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| Stub resolver (no libc): /etc/hosts → /etc/resolv.conf nameservers (up to 3, with timeouts and attempts) | Supported | `std/net.TestResolvConf`<br>`std/net.TestHosts`<br>interop dns: 7 (2026-11-06) |
| search / ndots candidate order (resolv.conf(5)) | Supported | `std/net.TestCandidates` |
| Truncated (TC) answers retried over TCP; CNAME chains (up to 8) | Supported | `std/net.TestParseAnswer`<br>interop dns: 7 (2026-11-06) |
| Spoofing defenses: getrandom txid; the answer's txid, name and type must match; compression loops are cut | Supported | `std/net.TestParseAnswer`<br>interop dns: 7 (2026-11-06) |
| IPv6 nameservers and dialing IPv6 (each attempt except the last is cut after 2 seconds, the RFC 8305 5 upper bound) | Supported | `std/net.TestResolveBoth`<br>`std/net.TestEcho4And6`<br>`std/net.TestDialCap` |
| Queries A and AAAA at once from one UDP socket (one-sided answers, NXDOMAIN, NODATA on both, TCP retry for the truncated side only); answers ordered IPv6 first, alternating (RFC 8305 4); /etc/hosts reads IPv6 lines in file order | Supported | `std/net.TestResolveBoth`<br>`std/net.TestInterleave`<br>`std/net.TestHosts`<br>`std/net.TestParseAnswer` |
<!-- confsync:end claims dns-resolver yes,partial -->

## Not supported by design

<!-- confsync:begin claims dns-resolver intentional -->
| Item | Status | Evidence |
|---|---|---|
| Non-ASCII host names (IDN belongs to the URL layer — rejected by name) | Not supported (by design) | `std/net.TestNameCheck` |
| DNSSEC validation (a stub trusts its upstream resolver) | Not supported (by design) | none |
| DoH / DoT, caching (the job of the OS or the upstream) | Not supported (by design) | none |
<!-- confsync:end claims dns-resolver intentional -->

## Not yet

<!-- confsync:begin claims dns-resolver planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| EDNS0 (today answers over 512 bytes fall back to TCP) | 0.8 | none |
<!-- confsync:end claims dns-resolver planned -->

## Evidence — interop

<!-- confsync:begin interop-dns -->
Last run: 2026-11-06 (tree 8314196f0ed4 (dirty) — scripts/dnsinterop.sh; fake DNS server, 7 cases: CNAME chain, TC → TCP, spoofed txid, search, NXDOMAIN, timeout)
<!-- confsync:end interop-dns -->
