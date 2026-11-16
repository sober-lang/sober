#!/usr/bin/env bash
# xpar: バックエンドの関数の並列（compiler/lower/x86.soberのxParEmit）を、既定のワーカー数で試す。
# gatesは全体にSOBER_WORKERS=1をexportするので、ここだけSOBER_WORKERSを外す（既定 = コア数。コアが1つの機械ではW8）。
#   1. 題材ごとに、W1のELF ≡ 既定のワーカー数のELF ≡ 全部の群をやり直したELF（SOBER_XPAR_DIE=1で
#      群の子を頭で死なせる）。証人 = SOBER_PAR_STATSの `#x86 par groups=G retried=R`: 既定はG > 1かつR = 0、やり直しはR = G
#   2. 展開のオプション（SOBER_RAW_EXPAND=1・--no-opt）の大きい関数: 既定のワーカー数で見積もりが外れて子が死んでも、やり直しでW1と同じELF
#   3. ミューテーション: やり直しを外して子の死をpanicにしたコンパイラは、1のやり直しの形でビルドできない
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
S2=${STAGE2:-out/stage2/sober2}
S2=$(cd "$(dirname "$S2")" && pwd)/$(basename "$S2")
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
NW=()
[ "$(nproc)" -lt 2 ] && NW=(SOBER_WORKERS=8)
# 群が2つ以上になる題材（小さい例は群が1つで並列の経路を通らない）
EX=(examples/web_login.sober examples/http_arena.sober examples/http_delayed_cut.sober examples/web_server_tls.sober)
RAW=examples/web_server_tls.sober
FORCE=(SOBER_XPAR_DIE=1)

b() { # b <コンパイラ> <出力> <ログ> <env…> -- <buildの引数…>
    local c=$1 o=$2 l=$3
    shift 3
    local e=()
    while [ "$1" != -- ]; do e+=("$1"); shift; done
    shift
    env -u SOBER_WORKERS "${e[@]}" "$c" build "$@" -o "$o" > "$l" 2>&1
}
wit() { # wit <ログ> → "G R"（証人の行が無ければ空）
    sed -n 's/^#x86 par groups=\([0-9]*\) retried=\([0-9]*\)$/\1 \2/p' "$1" | tail -n 1
}

for e in "${EX[@]}"; do
    n=$(basename "$e" .sober)
    b "$S2" "$W/$n.w1" "$W/$n.l1" SOBER_WORKERS=1 -- "$e" --emit=elf --passes || { echo "FAIL: $n (W1): $(head -c 200 "$W/$n.l1")"; fail=$((fail + 1)); continue; }
    b "$S2" "$W/$n.wd" "$W/$n.ld" "${NW[@]}" SOBER_PAR_STATS=1 -- "$e" --emit=elf --passes || { echo "FAIL: $n (default workers): $(head -c 200 "$W/$n.ld")"; fail=$((fail + 1)); continue; }
    b "$S2" "$W/$n.wr" "$W/$n.lr" "${NW[@]}" "${FORCE[@]}" SOBER_PAR_STATS=1 -- "$e" --emit=elf --passes || { echo "FAIL: $n (retry): $(head -c 200 "$W/$n.lr")"; fail=$((fail + 1)); continue; }
    read -r g r <<< "$(wit "$W/$n.ld")"
    if [ -z "${g:-}" ] || [ "$g" -le 1 ] || [ "$r" != 0 ]; then echo "FAIL: $n (default workers) did not take the group children without retry: $(grep '^#x86' "$W/$n.ld")"; fail=$((fail + 1)); fi
    read -r g r <<< "$(wit "$W/$n.lr")"
    if [ -z "${g:-}" ] || [ "$g" -le 1 ] || [ "$r" != "$g" ]; then echo "FAIL: $n (retry) did not retry every group: $(grep '^#x86' "$W/$n.lr")"; fail=$((fail + 1)); fi
    cmp -s "$W/$n.w1" "$W/$n.wd" || { echo "FAIL: $n: the ELF of the default workers differs from W1"; fail=$((fail + 1)); }
    cmp -s "$W/$n.w1" "$W/$n.wr" || { echo "FAIL: $n: the ELF of the retried groups differs from W1"; fail=$((fail + 1)); }
done

n=raw
b "$S2" "$W/$n.w1" "$W/$n.l1" SOBER_WORKERS=1 SOBER_RAW_EXPAND=1 -- "$RAW" --emit=elf --no-opt || { echo "FAIL: $RAW (raw expand, W1): $(head -c 200 "$W/$n.l1")"; fail=$((fail + 1)); }
b "$S2" "$W/$n.wd" "$W/$n.ld" "${NW[@]}" SOBER_RAW_EXPAND=1 SOBER_PAR_STATS=1 -- "$RAW" --emit=elf --no-opt || { echo "FAIL: $RAW (raw expand, default workers): $(grep -v '^#' "$W/$n.ld" | head -c 200)"; fail=$((fail + 1)); }
if [ -s "$W/$n.w1" ] && [ -s "$W/$n.wd" ]; then
    cmp -s "$W/$n.w1" "$W/$n.wd" || { echo "FAIL: $RAW (raw expand): the ELF of the default workers differs from W1"; fail=$((fail + 1)); }
fi

# 3. ミューテーション: やり直しの代わりに子の死でpanicする
T=$W/tree
mkdir -p "$T"
cp -r "$ROOT/src/compiler/." "$T/"
cp -r "$ROOT/src/std" "$T/std"
grep -q '^    outs := if serr != nil { xParRetry(' "$T/lower/x86.sober" || { echo "FAIL: mutant: the retry was not found in lower/x86.sober"; fail=$((fail + 1)); }
sed -i 's/^    outs := if serr != nil { xParRetry(.*$/    outs := if serr != nil { panic(InvariantBroken{}) } else { outs0 }/' "$T/lower/x86.sober"
if (cd "$T" && "$S2" build app --emit=elf --passes -o "$W/mut" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut"
    e=${EX[0]}
    if b "$W/mut" "$W/mut.out" "$W/mut.l" "${NW[@]}" "${FORCE[@]}" -- "$e" --emit=elf --passes; then
        echo "FAIL: mutant (no retry) was not caught by the retried build of $e"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi

echo "xpar: ${#EX[@]} examples + raw expand, fail=$fail"
[ "$fail" = 0 ]
