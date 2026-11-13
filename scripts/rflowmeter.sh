#!/usr/bin/env bash
# rflowmeter（C1 のゴミ計の網 — language.md の「戻り値へ流れる関数の region の省略」・lower/rflow.sober の rfMeter）: SOBER_RFLOW_METER=1 で
# コンパイラ自身を建てる（C1 に掛かる関数を書き換えずに残し、出口で「自分の深度に積んだバイト − 出口の relocate が写したバイト」が正なら
# 関数の名前とバイト数を stderr に出して exit 99）。そのコンパイラで
#   ① 自分自身（compiler/app）を build する
#   ② bench/httparena/main.sober を build する（std の広い面 — http・tls・json・utf8 の import 閉包を loader・lower が通る。
#      自己 build だけでは素通りした穴がある — 宛先構築の印が実引数の位置の呼び出しに立ち、C1 で消えた enter の外へ一時が残る形）
# のどちらも exit 0 であること。出力の照合はしない（判定はゴミ計の鳴りだけ）
set -uo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
# 判定されるのは建てる側（stage2）の印と C1 — RFLOWMETER_S2 は負例を確かめる試験の口（旧の stage2 で鳴ること）
S2=${RFLOWMETER_S2:-$ROOT/out/stage2/sober2}
[ -x "$S2" ] || { echo "rflowmeter: $S2 not found"; exit 1; }
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
mkdir -p "$W/root"
cp -r "$ROOT/src/compiler/." "$W/root/"
cp -r "$ROOT/src/std" "$W/root/std"
if ! (cd "$W/root" && SOBER_RFLOW_METER=1 "$S2" build app --emit=elf --passes -o "$W/meter" > "$W/build.log" 2>&1); then
    cat "$W/build.log"
    echo "rflowmeter: FAIL building the metered compiler"
    exit 1
fi
chmod +x "$W/meter"
fail=0
(cd "$W/root" && SOBER_WORKERS=1 "$W/meter" build app --emit=elf --passes -o "$W/self" > "$W/self.log" 2>&1)
ec=$?
if [ $ec != 0 ]; then
    echo "FAIL: self build exit $ec: $(grep 'rflow meter' "$W/self.log" | head -3)"
    fail=1
fi
(cd "$ROOT" && SOBER_WORKERS=1 "$W/meter" build bench/httparena/main.sober --emit=elf --passes -o "$W/srv" > "$W/srv.log" 2>&1)
ec=$?
if [ $ec != 0 ]; then
    echo "FAIL: bench/httparena build exit $ec: $(grep 'rflow meter' "$W/srv.log" | head -3)"
    fail=1
fi
echo "rflowmeter: metered compiler builds itself and bench/httparena — fail=$fail"
exit $fail
