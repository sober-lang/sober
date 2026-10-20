#!/usr/bin/env bash
# cryptocheck（AES-GCM の塊の道の格子 — report-796）: std/crypto/aesgcm の例を {既定の build（--passes）, --no-opt} × {SOBER_NOAES 無し, =1} と
# 写しのバックエンド（塊を持たない — cpuaes = 0）で走らせる。塊の道は .out（Go の双子の値）と一致・倒れ先（NOAES=1 / 写し）は NoHardware の印字だけ
# （ソフトの AES は無い — 倒れ先は TLS の suite の選択で ChaCha20-Poly1305 — ユーザー裁定 2）。塊の無い機械では塊の道の照合を飛ばす（SKIP を印字）
#   scripts/cryptocheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
fail=0; n=0
hw=1
grep -qw aes /proc/cpuinfo && grep -qw pclmulqdq /proc/cpuinfo && grep -qw ssse3 /proc/cpuinfo || hw=0
for ex in crypto_aesgcm crypto_wycheproof_aesgcm; do
    src=examples/$ex.sober
    "$S2" build "$src" --emit=elf --passes -o "$W/$ex.p" > /dev/null || { echo "FAIL build $ex"; fail=$((fail + 1)); continue; }
    "$S2" build "$src" --emit=elf -o "$W/$ex.n" > /dev/null || { echo "FAIL build --no-opt $ex"; fail=$((fail + 1)); continue; }
    "$S2" build "$src" --emit=elf --passes --backend=copy -o "$W/$ex.c" > /dev/null || { echo "FAIL build copy $ex"; fail=$((fail + 1)); continue; }
    chmod +x "$W/$ex.p" "$W/$ex.n" "$W/$ex.c"
    for v in p n; do
        if [ $hw = 1 ]; then
            n=$((n + 1))
            timeout 60 "$W/$ex.$v" > "$W/out" 2>&1; e=$?
            if [ $e != 0 ] || ! cmp -s "$W/out" examples/$ex.out; then echo "FAIL $ex [$v] hw path differs from .out (exit $e)"; fail=$((fail + 1)); fi
        else
            echo "SKIP $ex [$v] hw path (no AES-NI / PCLMULQDQ / SSSE3)"
        fi
        n=$((n + 1))
        SOBER_NOAES=1 timeout 60 "$W/$ex.$v" > "$W/out" 2>&1; e=$?
        if [ $e != 0 ] || ! head -n 1 "$W/out" | grep -q '^no hardware'; then echo "FAIL $ex [$v] SOBER_NOAES=1 did not fall back (exit $e)"; fail=$((fail + 1)); fi
    done
    n=$((n + 1))
    timeout 60 "$W/$ex.c" > "$W/out" 2>&1; e=$?
    if [ $e != 0 ] || ! head -n 1 "$W/out" | grep -q '^no hardware'; then echo "FAIL $ex [copy] the copy backend should have no AES path (exit $e)"; fail=$((fail + 1)); fi
done
# 多倍長の塊（MULX — RSA の続き report-864）: RSA の例は倒れ先（SOBER_NOMULX=1・--no-opt・写しのバックエンド — Sober の montMulS）も .out と同じ値
# （RSA は TLS に必須なので NoHardware の逃げは無い — 塊と倒れ先が同じ結果であることを格子で照合。crypto_montmul は塊 ≡ montMulS の乱数の全数照合）
mx=1
grep -qw bmi2 /proc/cpuinfo || mx=0
for ex in crypto_montmul crypto_rsa crypto_wycheproof_pss; do
    src=examples/$ex.sober
    "$S2" build "$src" --emit=elf --passes -o "$W/$ex.p" > /dev/null || { echo "FAIL build $ex"; fail=$((fail + 1)); continue; }
    "$S2" build "$src" --emit=elf -o "$W/$ex.n" > /dev/null || { echo "FAIL build --no-opt $ex"; fail=$((fail + 1)); continue; }
    "$S2" build "$src" --emit=elf --passes --backend=copy -o "$W/$ex.c" > /dev/null || { echo "FAIL build copy $ex"; fail=$((fail + 1)); continue; }
    chmod +x "$W/$ex.p" "$W/$ex.n" "$W/$ex.c"
    for v in p n c; do
        for nm in 0 1; do
            if [ $nm = 0 ] && [ $v = p ] && [ $mx = 0 ]; then echo "SKIP $ex [$v] MULX path (no BMI2)"; continue; fi
            n=$((n + 1))
            if [ $nm = 1 ]; then SOBER_NOMULX=1 timeout 120 "$W/$ex.$v" > "$W/out" 2>&1; else timeout 120 "$W/$ex.$v" > "$W/out" 2>&1; fi; e=$?
            if [ $e != 0 ] || ! cmp -s "$W/out" examples/$ex.out; then echo "FAIL $ex [$v NOMULX=$nm] differs from .out (exit $e)"; fail=$((fail + 1)); fi
        done
    done
done
echo "cryptocheck: $n runs — AES-GCM hw path ≡ .out / NOAES and copy backend fall back to NoHardware・RSA の MULX の塊 ≡ 倒れ先 ≡ .out, fail=$fail"
[ $fail = 0 ]
