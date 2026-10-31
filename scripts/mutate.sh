#!/usr/bin/env bash
# mutation testing（`sober test --mutate` — loader/mutx.sober・app/mutate.sober・std/internal/cover の Sel）の網:
#   - 例題全数を `build --mutate`（全部の変異を 1 本に織った schemata）で建てる: 変異なしで建つ例題が落ちたら演算子の「型を保つ」の除外の漏れ
#   - 例題 examples/mutate_basic.sober の schemata の基線（変異を選ばない実行）の出力が写しの無い build の黄金（.out）と同じ
#   - 題材 testdata/mutate/calc（抑止の行 1 本と当たらない行 1 本を持つ）の標準出力と --mutate-out が黄金 testdata/mutate/calc.{expect,txt} と一致・ワーカー 1 と 8 で同じ
#   - schemata ≡ 1 体だけの build: 題材の変異ごとに SOBER_MUTATE_ONE=k（選び口なしでその変異だけを写した build で全部のテスト）の結果が
#     schemata の結果と同じ（未到達 ≡ 生存・抑止〔testdata/mutate.ignore〕の行は飛ばす）
#   - 太り方が線形: 16 項の連鎖（testdata/mutate/chain.sober）の --mutate の ELF が変異なしの +32 KiB 以内（束縛しなければ 16 項で MB 級）
#   - 結果の再生: 2 回目が当たり、印字と --mutate-out が走らせた結果と同じ
#   - --mutate と --cover を同時に指定したら黙らずに拒否する
#   scripts/mutate.sh            照合
#   scripts/mutate.sh --regen    黄金を作り直す（差分を見てからコミット）
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
T=testdata/mutate/calc
regen=0
[ "${1:-}" = "--regen" ] && regen=1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
bad() { echo "FAIL: $*"; fail=$((fail + 1)); }
# stage2 を先に建てる（以降は直に叩く — 並列の build が建て直しを取り合わない）
"$SOBER" build examples/hello.sober -o "$W/h" > /dev/null 2>&1 || { echo "FAIL: build"; exit 1; }
S2=out/stage2/sober2
# 例題全数（落ちた例題だけ変異なしでも建てて比べる）
ls examples/*.sober | xargs -P 8 -I{} sh -c 'n=$(basename {} .sober); '"$S2"' build --mutate --emit=elf -o '"$W"'/x.$n {} > '"$W"'/x.$n.log 2>&1 || { '"$S2"' build --emit=elf -o '"$W"'/p.$n {} > /dev/null 2>&1 && echo "$n"; }' > "$W/exfail"
while read -r n; do bad "examples/$n.sober builds but not with --mutate: $(head -1 "$W/x.$n.log")"; done < "$W/exfail"
nex=$(ls examples/*.sober | wc -l)
"$W/x.mutate_basic" > "$W/mb.out" 2>&1 < /dev/null; cmp -s "$W/mb.out" examples/mutate_basic.out || bad "examples/mutate_basic: the baseline of the schemata differs from examples/mutate_basic.out"
# 題材（結果の再生を通さない — 走らせた結果を見る。再生は下で別に）
for w in 1 8; do
    SOBER_CHECK_REPLAY=0 SOBER_WORKERS=$w "$S2" test --mutate --mutate-out "$W/m$w.txt" --work "$W" "$T" > "$W/out$w" 2>&1 || bad "test W$w: exit $?"
done
cmp -s "$W/out1" "$W/out8" && cmp -s "$W/m1.txt" "$W/m8.txt" || bad "W1 and W8 differ"
if [ "$regen" = 1 ]; then
    cp "$W/out1" "$T.expect"
    cp "$W/m1.txt" "$T.txt"
    echo "regen: $T.{expect,txt} ($(wc -l < "$W/m1.txt") mutants)"
    exit 0
fi
diff "$T.expect" "$W/out1" > "$W/d" || { bad "differs from $T.expect"; head -20 "$W/d"; }
diff "$T.txt" "$W/m1.txt" > "$W/d" || { bad "differs from $T.txt"; head -20 "$W/d"; }
# schemata ≡ 1 体だけの build（点の番号 k = 写しの順 — --mutate-out の行は位置の順なので位置と変異で引く）
n=$(wc -l < "$W/m1.txt")
for k in $(seq 0 $((n - 1))); do
    l=$(SOBER_MUTATE_ONE=$k "$S2" test --mutate --work "$W" "$T" 2> /dev/null | tail -1)
    key=$(cut -f1-2 <<< "$l")
    s=$(grep -F "$key"$'\t' "$W/m1.txt" | head -1)
    [ -n "$s" ] || { bad "one $k: no schemata line for [$l]"; continue; }
    r=$(cut -f3-4 <<< "$s")
    [ "$(cut -f3 <<< "$s")" = unreached ] && r=$'survived\t-'
    [ "$(cut -f3 <<< "$s")" = ignored ] && continue
    [ "$(cut -f3-4 <<< "$l")" = "$r" ] || bad "one $k: [$l] but schemata [$s]"
done
# 太り方
"$S2" build --emit=elf -o "$W/c0" testdata/mutate/chain.sober > /dev/null 2>&1 && "$S2" build --mutate --emit=elf -o "$W/c1" testdata/mutate/chain.sober > /dev/null 2>&1 || bad "chain: build"
d=$(( $(stat -c %s "$W/c1") - $(stat -c %s "$W/c0") ))
[ "$d" -le 32768 ] || bad "chain: --mutate grows the ELF by $d bytes (operands bound? — want ≤ 32768)"
# 結果の再生（鍵に --mutate — 2 回目は建てずに走らせずに同じ印字と --mutate-out・当否は SOBER_CACHE_STAT）
for i in 1 2; do
    SOBER_CHECK_REPLAY=1 SOBER_CACHE="$W/cache" SOBER_BUILD_CACHE=1 SOBER_CACHE_STAT=1 "$S2" test --mutate --mutate-out "$W/r$i.txt" --work "$W" "$T" > "$W/ro$i" 2> "$W/re$i" || bad "replay $i: exit $?"
done
grep -q 'test-replay.*1/1\|cache: test 1/1' "$W/re2" || { bad "replay: the second run is not a hit"; head -3 "$W/re2"; }
cmp -s "$W/ro2" "$W/out1" && cmp -s "$W/r2.txt" "$W/m1.txt" || bad "replay: the replayed output differs"
# --cover と同時
"$S2" test --mutate --cover --work "$W" "$T" > /dev/null 2> "$W/both" && bad "--mutate --cover: accepted"
grep -q 'cannot be combined' "$W/both" || bad "--mutate --cover: no diagnostic"
[ "$fail" = 0 ] && echo "PASS: mutate ($nex examples woven · $n mutants · schemata ≡ one · chain +$d B)" || exit 1
