#!/usr/bin/env bash
# flatecheck（std/compress/flate・gzip と std/hash/crc32 の往復の網 — report-712 / 713）: testdata/flatecheck を最適化のバックエンド（--passes）と最適化なし（--no-opt）で
# 建てて走らせ、入力の形 24 種 × level 0〜9 の符号化（生の DEFLATE と gzip）を外の zlib（node:zlib）で解いて入力とバイト一致・CRC-32 が zlib と一致・
# 大きさの黄金（testdata/flatecheck/sizes.golden — 名前 level 長さ 出力の CRC-32。決定的な符号器）と一致・2 つの建て方の出力が一致すること。
# 符号器を意図して変えたら --regen で黄金を書き直す（gates 緑の状態から — 往復の照合は regen でも掛かる）
# CRC-32 の 2 つの道の格子（report-774）: --passes の実行ファイルを SOBER_NOCLMUL=1（倒れ先の slicing へ強制）でも走らせて出力の一致・
# examples/crc32_sum を 2 つの建て方 × SOBER_NOCLMUL ∈ {0, 1} で走らせて .out と一致（PCLMULQDQ の無い機械では 0 も倒れ先 — 照合は同じ）
# 復号（report-1021）: twin.ts が node:zlib の符号化の形（level・戦略・窓・memLevel・gzip の頭の欄・複数メンバ）と testdata/flatecheck/go/（Go の符号化の固定の資料）を
# index に並べ、main.sober が flate.Decode / gzip.Decode で解き、check.ts が node:zlib の復号と照合する（自分の符号化の往復と maxSize の境目は main.sober の中）
# 逐次の符号器（段 8-4b — std/internal/deflate の Stream）: sober test std/internal/deflate を DEFLATE_DUMP つきで走らせ（単体の網 = 一括の復号で往復・emit の切り方の無作為・
# sync flush の接頭辞）、書かれた列を stream.ts が node:zlib（gunzipSync・接頭辞の inflateRawSync Z_SYNC_FLUSH・逐次の createGunzip）で照合する
#   scripts/flatecheck.sh [--regen]
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
regen=${1:-}
fail=0
"$S2" build testdata/flatecheck/main.sober --emit=elf --passes -o "$W/opt" > /dev/null || { echo "flatecheck: FAIL build (--passes)"; exit 1; }
"$S2" build testdata/flatecheck/main.sober --emit=elf --no-opt -o "$W/noopt" > /dev/null || { echo "flatecheck: FAIL build (--no-opt)"; exit 1; }
chmod +x "$W/opt" "$W/noopt"
mkdir -p "$W/d.opt" "$W/d.noopt" "$W/twin"
node --experimental-strip-types --no-warnings testdata/flatecheck/twin.ts "$W/twin" testdata/httpcheck/dataset.json testdata/flatecheck/go || { echo "flatecheck: FAIL twin.ts"; exit 1; }
for v in opt noopt; do
    timeout -s KILL 300 "$W/$v" testdata/httpcheck/dataset.json "$W/d.$v" "$W/twin/index" > "$W/$v.list" 2>&1 || { echo "FAIL run $v"; tail -3 "$W/$v.list"; fail=$((fail + 1)); }
done
cmp -s "$W/opt.list" "$W/noopt.list" || { echo "FAIL: --no-opt output differs from --passes (determinism)"; fail=$((fail + 1)); }
mkdir -p "$W/d.nc"
SOBER_NOCLMUL=1 timeout -s KILL 300 "$W/opt" testdata/httpcheck/dataset.json "$W/d.nc" "$W/twin/index" > "$W/nc.list" 2>&1 || { echo "FAIL run opt SOBER_NOCLMUL=1"; tail -3 "$W/nc.list"; fail=$((fail + 1)); }
cmp -s "$W/opt.list" "$W/nc.list" || { echo "FAIL: SOBER_NOCLMUL=1 output differs (crc32 の 2 つの道)"; fail=$((fail + 1)); }
for v in passes no-opt; do
    "$S2" build examples/crc32_sum.sober --emit=elf --$v -o "$W/cs.$v" > /dev/null && chmod +x "$W/cs.$v" || { echo "FAIL build crc32_sum --$v"; fail=$((fail + 1)); continue; }
    for nc in 0 1; do
        SOBER_NOCLMUL=$nc "$W/cs.$v" > "$W/cs.out" 2>&1
        cmp -s "$W/cs.out" examples/crc32_sum.out || { echo "FAIL: crc32_sum --$v SOBER_NOCLMUL=$nc"; diff "$W/cs.out" examples/crc32_sum.out | head -5; fail=$((fail + 1)); }
    done
done
mkdir -p "$W/stream"
DEFLATE_DUMP="$W/stream" "$S2" test std/internal/deflate > "$W/stream.log" 2>&1 || { echo "FAIL: sober test std/internal/deflate"; tail -5 "$W/stream.log"; fail=$((fail + 1)); }
node --experimental-strip-types --no-warnings testdata/flatecheck/stream.ts "$W/stream" || fail=$((fail + 1))
node --experimental-strip-types --no-warnings testdata/flatecheck/check.ts "$W/opt.list" "$W/d.opt" testdata/flatecheck/sizes.golden "$W/twin/index" $regen || fail=$((fail + 1))
[ $fail = 0 ]
