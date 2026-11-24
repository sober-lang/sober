#!/usr/bin/env bash
# acceptretry: net.Serve の受け付けのループが accept の一時的な失敗で止まらないこと（language.md 28節 — EMFILE・ENFILE・ENOBUFS・ENOMEM は待って受け直す・
# ECONNABORTED は待たずに受け直す・それ以外は今どおり返る）。
#   ① testdata/acceptretry/main.sober を fd の soft の上限 64 で走らせ、testdata/acceptretry/check.ts が 100本を同時に張って GET を送る。
#      fd が尽きて一部が受けられない（answered ≥ 10・pending ≥ 10 — EMFILE が起きた）のに Serve が返らず、答えた接続を 20本閉じると、待ち行列に
#      残っていた接続が受けられて答え（late ≥ 1）、全部を閉じた後の新しい接続が 200 で答える（fresh = 1）。Ledger の acceptRetry > 0・
#      stderr の診断の文（EMFILE）がちょうど1行。ワーカー2 × 経路 {自動〔ring〕, SOBER_IO=1〔epoll〕}
#   ② 自己点検: ミュータント125（一時的な失敗でもループを終える — 直す前の形）では Serve が返り、late = 0・fresh = 0
#   scripts/acceptretry.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
SP=
trap '[ -n "$SP" ] && kill $SP 2>/dev/null; rm -rf "$W"' EXIT
fail=0
"$S2" build testdata/acceptretry/main.sober --emit=elf --passes -o "$W/ok" > "$W/b.log" 2>&1 || { echo "acceptretry: FAIL build ($(head -c 200 "$W/b.log"))"; exit 1; }
"$S2" build testdata/acceptretry/main.sober --emit=elf --passes --rt-mutant=125 -o "$W/m125" > "$W/b.log" 2>&1 || { echo "acceptretry: FAIL build mutant 125"; exit 1; }
# run <bin> [env…] → "answered A pending P late L fresh F retry R diag D returned X"
run() {
    local bin=$1 port="" out
    shift
    (ulimit -Sn 64; exec env SOBER_WORKERS=2 "$@" "$bin" > "$W/srv.out" 2> "$W/srv.err") &
    SP=$!
    for _ in $(seq 100); do port=$(sed -n 's/^ready //p' "$W/srv.out"); [ -n "$port" ] && break; sleep 0.1; done
    out=$([ -n "$port" ] && timeout 60 node --experimental-strip-types --no-warnings testdata/acceptretry/check.ts "$port" 100 20)
    sleep 0.3
    kill $SP 2> /dev/null; wait $SP 2> /dev/null; SP=
    echo "$out retry $(sed -n 's/^retry //p' "$W/srv.out" | tail -1) diag $(grep -c '^net.Serve: accept failed: too many open files (EMFILE)' "$W/srv.err") returned $(grep -c '^serve returned' "$W/srv.out")"
}
for io in "" 1; do
    got=$(run "$W/ok" ${io:+SOBER_IO=$io})
    read -r _ an _ pe _ la _ fr _ re _ dg _ rt <<< "$got"
    if [ -z "${rt:-}" ] || [ "$an" -lt 10 ] || [ "$pe" -lt 10 ] || [ "$la" -lt 1 ] || [ "$fr" != 1 ] || [ "${re:-0}" -lt 1 ] || [ "$dg" != 1 ] || [ "$rt" != 0 ]; then
        echo "acceptretry: FAIL SOBER_IO=${io:-auto}: $got (want answered ≥ 10, pending ≥ 10, late ≥ 1, fresh 1, retry ≥ 1, diag 1, returned 0)"; sed 's/^/  stderr: /' "$W/srv.err" | head -5; fail=1
    fi
    echo "  SOBER_IO=${io:-auto}: $got" >> "$W/sum"
done
got=$(run "$W/m125")
read -r _ an _ pe _ la _ fr _ re _ dg _ rt <<< "$got"
if [ "${fr:-1}" != 0 ] || [ "${la:-1}" != 0 ]; then
    echo "acceptretry: FAIL mutant 125 was not caught: $got"; fail=1
fi
echo "acceptretry: $(tr '\n' ' ' < "$W/sum")· mutant 125: $got, fail=$fail"
exit $fail
