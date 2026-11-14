#!/usr/bin/env bash
# sober-check のバッチ入力（`--batch` — lean/Main.lean）の回帰検査: バッチ出力の各行が、同じ入力の 1 件ずつの実行の stdout とバイト一致すること。
#
#   scripts/leanbatch.sh          第3ゴールデン・corevec・compiler/tools・端の入力（約400本）
#   scripts/leanbatch.sh --all    加えてミュータント（約1,000本 — 拒否の経路を厚く）
#
# 入力: 第3ゴールデンtestdata/corejson/*.json・corevec 300本・compiler/tools/* のコアAST（大きい入力）・scripts/checkmut.tsのミュータント（拒否の多い入力）・
# 端の入力（空・壊れた JSON・改行を含む整形済みの JSON・受理しない kind）。バッチは gatelib.sh の lean_batch（ゲートが使う経路そのもの）で流す。
# 前提: lean で lake build 済み（$SOBER_CHECK で差し替え可）・zig build 済み
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD
SOBER=${SOBER:-$ROOT/bin/sober}   # src/compiler/tools のコア AST は主の sober（Sober の脱糖器）が作る — 主役交代 R39
export SOBER_CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
[ -x "$SOBER_CHECK" ] || { echo "error: $SOBER_CHECK not found (cd lean && lake build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/in"

cp testdata/corejson/*.json "$tmp/in/"
python3 - testdata/corevec.jsonl "$tmp/in/corevec" <<'EOF'
import json, sys
for n, line in enumerate(open(sys.argv[1])):
    with open(f"{sys.argv[2]}.{n:04d}.json", "w") as f:
        f.write(json.dumps(json.loads(line)["e"], separators=(",", ":")))
EOF
# 外す tools（scripts/leanbatch_skip.txt）は照合の無い入力を外さない約束: 各行は ① selfhost_check の tools の一覧（scripts/selfhost_check_tools.txt）にある名前（同じ入力の Lean の判定を
# selfhost_check (ii) が Sober の checker と照合する）か ② `<t>=<代表>` — 代表が leanbatch に残り、両者のコア JSON の差が末尾の
# main の Def だけ（先頭の一致が全体の 99.99% 以上 — 他の Def は代表の入力で被覆）。どちらでもなければ赤
sc_tools=" $(cat scripts/selfhost_check_tools.txt) "
skip=()
reps=()
while IFS= read -r line; do
    line=${line%%#*}
    line=${line// /}
    [ -n "$line" ] || continue
    t=${line%%=*}
    skip+=("$t")
    if [ "$line" != "$t" ]; then reps+=("$t=${line#*=}"); continue; fi
    case "$sc_tools" in *" $t "*) echo "leanbatch: excluded tool_$t (Lean verdict cross-checked by selfhost_check (ii))" ;;
        *) echo "FAIL: scripts/leanbatch_skip.txt: $t is not in scripts/selfhost_check_tools.txt — nothing else cross-checks its Lean verdict"; exit 1 ;; esac
done < scripts/leanbatch_skip.txt
mkdir -p "$tmp/rep"
for t in src/compiler/tools/*/; do
    t=$(basename "$t")
    out=$tmp/in/tool_$t.json
    case " ${skip[*]} " in *" $t "*)
        case " ${reps[*]} " in *" $t="*) out=$tmp/rep/tool_$t.json ;; *) continue ;; esac ;; esac
    (cd src/compiler && "$SOBER" check "tools/$t/main.sober" --core-json) > "$out" &
done
wait
for r in "${reps[@]}"; do
    t=${r%%=*} rep=${r#*=}
    a=$tmp/rep/tool_$t.json b=$tmp/in/tool_$rep.json
    [ -s "$a" ] && [ -s "$b" ] || { echo "FAIL: scripts/leanbatch_skip.txt: $t=$rep: missing core JSON (is $rep still in leanbatch?)"; exit 1; }
    sz=$(stat -c %s "$a")
    same=$( { cmp "$a" "$b" 2> /dev/null || true; } | sed -n 's/.* byte \([0-9]*\),.*/\1/p')

    same=$(( ${same:-$sz} - 1 ))
    if [ $((same * 10000)) -lt $((sz * 9999)) ]; then
        echo "FAIL: scripts/leanbatch_skip.txt: $t=$rep: core JSONs share only $same of $sz leading bytes (more than main's Def differs)"; exit 1
    fi
    echo "leanbatch: excluded tool_$t (represented by tool_$rep — $same/$sz leading bytes identical)"
done
if [ "${1:-}" = "--all" ]; then
    mkdir -p "$tmp/mut"
    node scripts/checkmut.ts "$tmp/mut" testdata/corejson/*.json > /dev/null
    cp "$tmp/mut"/*.json "$tmp/in/"
fi
# 端の入力
: > "$tmp/in/edge_empty.json"
printf '{"k":"lit","n":' > "$tmp/in/edge_truncated.json"
printf 'not json at all' > "$tmp/in/edge_garbage.json"
printf '{"k":"ref","m":true}\n' > "$tmp/in/edge_unknown_kind.json"
jq . testdata/corejson/examples_fib.json > "$tmp/in/edge_pretty_fib.json"
printf '{\n  "k": "lit",\n  "n": 1\n' > "$tmp/in/edge_pretty_truncated.json"
printf '{"k":"lit","n":1} {"k":"triv"}' > "$tmp/in/edge_two_values.json"

find "$tmp/in" -type f | LC_ALL=C sort > "$tmp/list"
n=$(wc -l < "$tmp/list")
# 入力の一致で省く（$GATECACHE — gates.sh が立てる。--no-cache では立たないので必ず走る）: 判定は sober-check と入力だけで決まる
# （コンパイラが効くのは tools のコア JSON だけ — それも入力に含めて比べる）。鍵 = sober-check の中身・このスクリプトと gatelib.sh（lean_batch）の中身・
# 入力の一覧（相対の名前 + 中身）。前回のPASSと同じ鍵なら照合せず、前回の要約の行にマークを付けて出す
LB_KEY=$( { sha256sum < "$SOBER_CHECK"; sha256sum < "$0"; sha256sum < scripts/gatelib.sh; (cd "$tmp/in" && find . -type f | LC_ALL=C sort | xargs -d '\n' sha256sum); } | sha256sum | cut -d' ' -f1)
LB_FILE=${GATECACHE:+$GATECACHE/leanbatch.inputs}
if [ -n "$LB_FILE" ] && [ -f "$LB_FILE" ] && [ "$(head -1 "$LB_FILE")" = "$LB_KEY" ]; then
    echo "SKIP: inputs unchanged since the last pass (sober-check + $n inputs — key $LB_KEY)"
    echo "$(sed -n 2p "$LB_FILE") — inputs identical to the last PASS, not re-run"
    exit 0
fi
JOBS=${JOBS:-8}
lean_batch "$tmp/list" "$tmp/batch"

# 1 件ずつ（並列 — 起動のコストは並べて吸う）
par_init "$tmp"
single() {
    local f=$1 want got
    want=$("$SOBER_CHECK" < "$f" || true)
    got=$(cat "$tmp/batch/$(lean_key "$f").out" 2> /dev/null || echo "<no batch output>")
    # 判定 JSON でない出力（検査器が起動しない・落ちる）は一致していても失敗
    if [ "${want:0:1}" != "{" ]; then echo "FAIL: $(basename "$f"): the single run printed no verdict: $(printf '%s' "$want" | head -c 100)"; echo "@@ fail"; return; fi
    if [ "$want" = "$got" ]; then echo "@@ ok"; else echo "FAIL: $(basename "$f"): single $(printf '%s' "$want" | head -c 100) / batch $(printf '%s' "$got" | head -c 100)"; echo "@@ fail"; fi
}
# 大物（lean_big）は 1 本の仕事で直列に — 同時に 2 本走ると数 GB ずつ山が重なる（lean_batch の大物のチャンクと同じ理由）
singles() { local f; for f in "$@"; do single "$f"; done; }
big=()
while IFS= read -r f; do if lean_big "$f"; then big+=("$f"); fi; done < "$tmp/list"
[ ${#big[@]} -gt 0 ] && par_run singles "${big[@]}"
while IFS= read -r f; do lean_big "$f" || par_run single "$f"; done < "$tmp/list"
par_wait > "$tmp/all"
grep -v '^@@ ' "$tmp/all" || true
ok=$(par_count ok "$tmp/all")
fail=$(par_count fail "$tmp/all")
echo "leanbatch: $n inputs, ok=$ok, fail=$fail"
[ "$fail" = 0 ] && [ "$ok" = "$n" ] || exit 1
if [ -n "$LB_FILE" ]; then
    mkdir -p "$GATECACHE"
    printf '%s\nleanbatch: %s inputs, ok=%s, fail=%s\n' "$LB_KEY" "$n" "$ok" "$fail" > "$LB_FILE.tmp" && mv "$LB_FILE.tmp" "$LB_FILE"
fi
