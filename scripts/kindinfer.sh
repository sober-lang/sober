#!/usr/bin/env bash
# kindinfer: コンパイラの kind の推論と、Lean の推論の手順（inferTc — inferK と同じ結果を返す計算できる形）の照合。
# examples のうち型パラメータを持つ Def があるものについて、kind を全部旗なしにした形（`check --emit=kindshape`）を
# Lean の `sober-check --infer-batch` に渡し、成分ごとに推論した kind が `check --core-json` の Def の kinds と一致することを見る。
# Lean が型付かない成分を見つけたときは、`--core-json` を Lean の検査器が拒否することを見る（拒否も一致）。
#   FAIL: kind が違う・Lean が推論できないのに検査器が受理する・道具の失敗
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
[ -x "$CHECK" ] || { echo "error: $CHECK not found (cd lean && lake build sober-check)"; exit 1; }
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/j"
# 例ごとに: コアの JSON の Def の kinds（jq で取り出す — 全部の例のコアの JSON は大きすぎて 1 つの文字列にできない）と、形の JSON
ls examples/*.sober | xargs -P "${JOBS:-8}" -I{} sh -c '
    f={}; k=$(basename "$f" .sober)
    "$1" check --core-json "$f" 2> /dev/null > "$2/j/$k.core" || true
    if grep -q "\"kinds\":\[{" "$2/j/$k.core"; then
        jq -c "[(.defs // [])[] | (.kinds // [])]" "$2/j/$k.core" > "$2/j/$k.want"
        "$1" check --emit=kindshape "$f" 2> /dev/null | tr -d "\n" > "$2/j/$k.shape" || true
    else
        rm -f "$2/j/$k.core"
    fi
' _ "$STAGE2" "$tmp"
: > "$tmp/keys"
: > "$tmp/want"
: > "$tmp/shape"
for f in "$tmp"/j/*.core; do
    [ -e "$f" ] || continue
    k=$(basename "$f" .core)
    [ -s "$tmp/j/$k.shape" ] || { echo "FAIL $k: --core-json succeeded but --emit=kindshape did not"; exit 1; }
    echo "$k" >> "$tmp/keys"
    cat "$tmp/j/$k.want" >> "$tmp/want"
    { cat "$tmp/j/$k.shape"; echo; } >> "$tmp/shape"
done
"$CHECK" --infer-batch < "$tmp/shape" > "$tmp/inf"
n=$(wc -l < "$tmp/keys")
[ "$n" = "$(wc -l < "$tmp/inf")" ] || { echo "FAIL: sober-check returned $(wc -l < "$tmp/inf") results for $n inputs"; exit 1; }
# Lean が型付かない成分を見つけた例は、コアの JSON の判定（Lean の検査器）も拒否であること
: > "$tmp/ver"
paste -d' ' "$tmp/keys" "$tmp/inf" | while read -r k j; do
    case "$j" in
        '{"kinds":null,"def"'*)
            v=$(tr -d '\n' < "$tmp/j/$k.core" | "$CHECK" | head -c 10)
            echo "$k $v" >> "$tmp/ver" ;;
    esac
done
node -e '
const fs = require("fs")
const rd = f => fs.readFileSync(f, "utf8").split("\n").slice(0, -1)
const [keys, want, inf, ver] = process.argv.slice(1).map(rd)
const verdict = new Map(ver.map(l => [l.split(" ")[0], l.slice(l.indexOf(" ") + 1)]))
const kstr = l => l.map(k => ["rf", "mf", "cf", "cov", "kf"].filter(x => k[x]).join("+") || "-").join(",")
let fail = 0, defs = 0, rej = 0
keys.forEach((k, i) => {
    const w = JSON.parse(want[i])
    const got = JSON.parse(inf[i])
    if (got.kinds === null) {
        if (got.why !== undefined) { console.log(`FAIL ${k}: infer-batch failed (${got.why})`); fail++; return }
        if (verdict.get(k).startsWith("{\"ok\":true")) { console.log(`FAIL ${k}: Lean finds no consistent kind for the component of Def ${got.def} but accepts the core JSON`); fail++; return }
        rej++; return
    }
    if (got.kinds.length !== w.length) { console.log(`FAIL ${k}: ${got.kinds.length} Defs from infer-batch, ${w.length} in the core JSON`); fail++; return }
    w.forEach((ks, j) => {
        if (ks.length === 0) return
        defs++
        if (kstr(ks) !== kstr(got.kinds[j])) { console.log(`FAIL ${k}: Def ${j} kinds ${kstr(ks)} (compiler) vs ${kstr(got.kinds[j])} (Lean)`); fail++ }
    })
})
console.log(`kindinfer: ${keys.length} examples with generic Defs, ${defs} Defs compared, ${rej} rejected by both, fail=${fail}`)
process.exit(fail ? 1 : 0)
' "$tmp/keys" "$tmp/want" "$tmp/inf" "$tmp/ver"
