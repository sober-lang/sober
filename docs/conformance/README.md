# Conformance

[日本語](README.ja.md)

Statements of how the protocols and cryptography implemented by Sober's std conform to their standards. Every chapter has the same layout, and **the tables and numbers are not written by hand: they are generated from the tests themselves and checked by a gate (confsync)**. The gate fails when a test fails, when a statement has no evidence, or when a statement a test makes is not used by the documents.

## Layout

Each chapter has the same sections:

1. **Scope** — which standard, in which role
2. **Supported** — supported items and their evidence (passing tests, numbers of passing vectors, goldens, interop records)
3. **Not supported by design** — items we decided not to have, with the reason
4. **Not yet** — items that do not exist yet, with the planned release line
5. **Evidence** — numbers per external oracle (Wycheproof, NIST CAVP / PKITS, x509-limbo, …) and the classified known deviations

The point of the layout is that nothing is left as "not written = unknown". Unsupported items are in the tables too, with a reason or a release line.

The four statuses:

| Status | Meaning |
|---|---|
| Supported | Implemented, and the tests, vectors and records in the evidence column pass |
| Partial | Implemented with a limited scope (the limit is in the item text) |
| Not supported (by design) | Decided not to have (the reason is in the item text) |
| Not yet (planned: release) | Does not exist yet; planned for that release line |

## Chapters

<!-- confsync:begin summary -->
| Chapter | Supported | Partial | By design | Not yet |
|---|---:|---:|---:|---:|
| [tls](tls.md) | 17 | 2 | 6 | 6 |
| [x509](x509.md) | 7 | 1 | 4 | 3 |
| [crypto](crypto.md) | 6 | 1 | 2 | 2 |
| [http](http.md) | 20 | 1 | 5 | 7 |
| [dns](dns.md) | 4 | 1 | 3 | 2 |
<!-- confsync:end summary -->

## Kinds of evidence

- **Tests** (`std/….TestXxx`) — tests that pass under `sober test`. Numeric statements come from the `conf:` lines a test prints after it has passed
- **Goldens** (`testdata/…`, `examples/*.out`) — files checked by gates
- **Interop** — suites run by hand against Go's implementations (crypto/tls, net/http, a fake DNS server) (`scripts/{tls,http,dns}interop.sh`). They need the Go toolchain, so they are outside the gates; the documents show the date and tree commit of the last run
- **Sources of the external oracles**: Wycheproof (C2SP — Apache-2.0), NIST CAVP / PKITS (public domain), x509-limbo (C2SP — Apache-2.0), Mozilla NSS certdata.txt (MPL-2.0), and values from Go's standard library and golang.org/x/crypto (BSD-3-Clause). The origin and commit of each copy is in the `testdata/*/README.md` files

## Regenerating and checking

```
scripts/confsync.sh           # rewrite the generated blocks
scripts/confsync.sh --check   # the gate (generated ≡ committed, evidence exists, no unused statements)
```

The claims table is `testdata/conformance/claims.tsv`, the English reasons are `testdata/conformance/en.tsv`, and the interop records are in `testdata/conformance/interop/`. New protocols (HTTP/2 with h2spec, QUIC with quic-interop-runner) fit the same layout by adding a chapter and a line for their external oracle.
