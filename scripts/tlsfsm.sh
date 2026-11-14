#!/usr/bin/env bash
# tlsfsm（TLSタスクR6 — report-838 / 839）: std/internal/hsの状態機械 ≡ Leanのモデル（lean/FeatherweightSober/Tls.lean — 4定理つき）。
#   ① Leanの遷移表（sober-gen --tlsfsm）≡ testdata/tls/fsm.golden（モデルの表を変えたらゴールデンごと — 定理が通ることは lake build が見る）
#   ② std/tls の TestFsm（hs_fsm_test.sober — 抽象の状態ごとの具体の Hs に抽象の事象ごとの具体の record を 1 枚通した行）≡ testdata/tls/fsm.golden
#      （テストがゴールデンを @embedして照合する — 2026-10-20にexamples/tls_fsmから移した: hsはstdの内側の実装で、stdの外の例からはimportできない）
#   ③ TestFsmNonce = nonce の動的の証人（KeyUpdate を挟んだ送りの (鍵の指紋, seq) に重なりなし — dup=0）
# h1 の状態は AES-128-GCM の記録（HRR）を流すので、塊の無い機械では ② を飛ばす（テストが skipped の行を印字して通る — ここで SKIP を印字）
#   scripts/tlsfsm.sh            照合
#   scripts/tlsfsm.sh --regen    ゴールデンをLeanの表から作り直す（モデルを意図して変えたときだけ — 差分を見てからコミット）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
S2=${STAGE2:-out/stage2/sober2}
G=testdata/tls/fsm.golden
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
# sober-gen: gatesの下（GATES_LEANTOOLS=1）は共有のビルドのステージがビルドした — ここでビルドすると、並走するextractの lake build と競合してETXTBSYになる。
# 単発の実行ではビルドする（Leanのソースが変わった後に古い道具で照合しない）
if [ "${GATES_LEANTOOLS:-}" != 1 ]; then
    (cd lean && lake build sober-gen > "$W/lake.log" 2>&1) || { cat "$W/lake.log"; echo "FAIL: lake build sober-gen"; exit 1; }
fi
lean/.lake/build/bin/sober-gen --tlsfsm > "$W/lean.txt" || { echo "FAIL: sober-gen --tlsfsm"; exit 1; }
if [ "${1:-}" = "--regen" ]; then cp "$W/lean.txt" "$G"; echo "tlsfsm: regenerated $G ($(wc -l < "$G") rows)"; exit 0; fi
fail=0
if ! cmp -s "$W/lean.txt" "$G"; then echo "FAIL: the Lean table (sober-gen --tlsfsm) differs from $G"; diff "$G" "$W/lean.txt" | head -20; fail=1; fi
mkdir -p "$W/work"
"$S2" test std/tls --run TestFsm --work "$W/work" > "$W/out" 2>&1 || { cat "$W/out"; echo "FAIL: sober test std/tls --run TestFsm"; fail=1; }
grep -q '^ok   std/tls.TestFsm$' "$W/out" || { echo "FAIL: TestFsm did not pass"; fail=1; }
grep -q 'transition rows skipped' "$W/out" && echo "SKIP: transition rows (no AES-NI / PCLMULQDQ / SSSE3 — the h1 states replay an AES-128-GCM trace)"
nl=$(grep '^nonce ' "$W/out")
case "$nl" in
    *" dup=0") ;;
    *) echo "FAIL: nonce witness: ${nl:-<missing>}"; fail=1 ;;
esac
echo "tlsfsm: $(wc -l < "$G") transitions (Lean ≡ golden ≡ std/internal/hs) / ${nl:-no nonce line}, fail=$fail"
[ $fail = 0 ]
