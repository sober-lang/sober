#!/usr/bin/env bash
# kindexpand: 総称関数の呼び出しの判定と、型引数を代入した単相の Def の判定の照合。
# examples のコアの JSON（`check --core-json`）のうち型引数つきの呼び出しを持つものを、Lean の `sober-check --expand-batch` に渡す。
# Lean は単相の文脈の call・fnref を、Def.inst（型引数を代入した単相の Def）を足してそれを指す形に置き換え、元と置き換え後の判定を返す。
# 受理する総称の呼び出しは、代入した単相の Def でも受理する（Lean の defsOk_inst）。このゲートは、脱糖器の出す形がこの前提に沿うことを見る。
#   FAIL: 元が受理で置き換え後が拒否・置き換えが上限を超えた（多相の再帰）・元が拒否で置き換え後が受理なのに testdata/kindexpand/known.txt に無い
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
[ -x "$CHECK" ] || { echo "error: $CHECK not found (cd lean && lake build sober-check)"; exit 1; }
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/j"
ls examples/*.sober | xargs -P "${JOBS:-8}" -I{} sh -c '
    f={}; k=$(basename "$f" .sober)
    "$1" check --core-json "$f" 2> /dev/null | tr -d "\n" > "$2/j/$k.json" || true
    grep -q "\"ts\":\[{" "$2/j/$k.json" || rm -f "$2/j/$k.json"
' _ "$STAGE2" "$tmp"
: > "$tmp/keys"
: > "$tmp/in"
for f in "$tmp"/j/*.json; do
    [ -e "$f" ] || continue
    basename "$f" .json >> "$tmp/keys"
    cat "$f" >> "$tmp/in"
    echo >> "$tmp/in"
done
"$CHECK" --expand-batch < "$tmp/in" > "$tmp/out"
n=$(wc -l < "$tmp/keys")
[ "$n" = "$(wc -l < "$tmp/out")" ] || { echo "FAIL: sober-check returned $(wc -l < "$tmp/out") results for $n inputs"; exit 1; }
paste -d' ' "$tmp/keys" "$tmp/out" | node -e '
const fs = require("fs")
const known = new Set(fs.readFileSync(process.argv[1], "utf8").split("\n").filter(l => l && !l.startsWith("#")).map(l => l.split(" ")[0]))
const lines = fs.readFileSync(0, "utf8").trim().split("\n")
let fail = 0, inst = 0, same = 0, narrow = []
for (const l of lines) {
    const i = l.indexOf(" "), k = l.slice(0, i), j = JSON.parse(l.slice(i + 1))
    const o = j.orig.ok === true
    if (j.exp === null) { console.log(`FAIL ${k}: expansion failed (${j.why})`); fail++; continue }
    const e = j.exp.ok === true
    inst += j.inst
    if (o === e) { same++; continue }
    if (o && !e) { console.log(`FAIL ${k}: the generic call is accepted but the instantiated Def is rejected (${JSON.stringify(j.exp)})`); fail++; continue }
    if (!known.has(k)) { console.log(`FAIL ${k}: the generic call is rejected but the instantiated Def is accepted (add to testdata/kindexpand/known.txt with the reason if the kind is narrower on purpose)`); fail++; continue }
    narrow.push(k)
}
for (const k of known) if (!narrow.includes(k)) { console.log(`FAIL ${k}: listed in known.txt but the verdicts now agree or the example is gone`); fail++ }
console.log(`kindexpand: ${lines.length} examples with generic call sites, ${inst} instantiated Defs, ${same} agree, ${narrow.length} narrower by the kind (${narrow.join(" ")}), fail=${fail}`)
process.exit(fail ? 1 : 0)
' testdata/kindexpand/known.txt
