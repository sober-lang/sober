# DNS

[日本語](dns.ja.md) · [Conformance](README.md)

## Scope

Name resolution in `std/net` (a stub resolver — used when `net.Dial` gets a host that is not an IPv4 literal). It does not use libc's getaddrinfo. There is no recursive resolver and no authoritative server.

## Supported

<!-- confsync:begin claims dns-resolver yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| Stub resolver (no libc): /etc/hosts → /etc/resolv.conf nameservers (up to 3, with timeouts and attempts) | Supported | `std/net.TestResolvConf`<br>`std/net.TestHosts`<br>interop dns: 7 (2026-11-06) |
| search / ndots candidate order (resolv.conf(5)) | Supported | `std/net.TestCandidates` |
| Truncated (TC) answers retried over TCP; CNAME chains (up to 8) | Supported | `std/net.TestParseAnswer`<br>interop dns: 7 (2026-11-06) |
| Spoofing defenses: getrandom txid; the answer's txid, name and type must match; compression loops are cut | Supported | `std/net.TestParseAnswer`<br>interop dns: 7 (2026-11-06) |
| Reads A and AAAA (Dial is IPv4-only) | Partial | `std/net.TestParseAnswer`<br>`std/net.TestDialLocalhost` |
<!-- confsync:end claims dns-resolver yes,partial -->

## Not supported by design

<!-- confsync:begin claims dns-resolver intentional -->
| Item | Status | Evidence |
|---|---|---|
| Non-ASCII host names (IDN belongs to the URL layer — rejected by name) | Not supported (by design) | `std/net.TestNameCheck` |
| DNSSEC validation (a stub trusts its upstream resolver) | Not supported (by design) | — |
| DoH / DoT, caching (the job of the OS or the upstream) | Not supported (by design) | — |
<!-- confsync:end claims dns-resolver intentional -->

## Not yet

<!-- confsync:begin claims dns-resolver planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| EDNS0 (today answers over 512 bytes fall back to TCP) | 0.8 | — |
| IPv6 nameservers and dialing IPv6 | 0.8 | — |
<!-- confsync:end claims dns-resolver planned -->

## Evidence — interop

<!-- confsync:begin interop-dns -->
Last run: 2026-11-06 (tree 8314196f0ed4 (dirty) — scripts/dnsinterop.sh; fake DNS server, 7 cases: CNAME chain, TC → TCP, spoofed txid, search, NXDOMAIN, timeout)
<!-- confsync:end interop-dns -->
