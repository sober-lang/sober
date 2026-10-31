#!/usr/bin/env bash
# 再 build の bench（report-1183 段 0 — インクリメンタルの波の物差し・editbench.sh の build 版）: 固定のコンパイラ（今の stage2）で、
# 自己適用（compiler/app の写し）に決まった編集を当てて build（--emit=elf --passes）を測る。
#   whole = 置き場なし（SOBER_CACHE 空・build のキャッシュ off）・warm = 編集前の木で温めた置き場の写し（check の C2 + build の後段の関数キャッシュ
#   〔段 3 — SOBER_BUILD_CACHE=1〕）・alt = 同じ温めた置き場を別パスの写し（長いパス + 絶対パスの entry）で当てる（段 3 の鍵と成果物のパス非依存 —
#   report-1194 5.2）・cold = 空の置き場（1 周目だけ）
# 温 / 別パス / 冷の ELF は whole の ELF とバイトで比べる（elf=same / DIFF）。外れ = 段 3 の切り口ごとの外れの数（α/β1/β2/γ/P — SOBER_CACHE_STAT）・
# 置き場 = build の後の build のキャッシュの根の大きさ（KB）。最後に中央値の表（編集 × 種類 × W）を出す
# 編集（editbench と同じ — std はコンパイラに焼き込みなので std の代役に ast〔ほぼ全 package が import〕を使う）:
#   none / lower-body / desugar-body / ast-body（.sobi に載らない本体）/ ast-sig（.sobi が変わる — ast に依る全 package が外れる）
# 使い方: scripts/rebuildbench.sh [回数（既定 3）] [W の列（既定 "1 8"）]・scripts/rebuildbench.sh --fnhash（関数ごとの成果物のハッシュの stray の網 — 下）・--tyhash（package の区画のハッシュと鍵の網 — 下） — 出力 = 1 行 1 計測（編集 種類 W 秒 RSS-KB 外れ elf 置き場-KB）+ 中央値の表。長い — 背景で回して出力をファイルで読む
set -uo pipefail
# 答えの再生は切る（この網は関数単位キャッシュの当否を見る）
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
ROOT=$PWD
N=${1:-3}
WS=${2:-"1 8"}
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
export SOBER_SELF_KEY=$(cat "$(dirname "$STAGE2")/.key") SOBER_HASH_SEED=0
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
mkdir -p "$W/base"
cp -r src/compiler "$W/base/compiler"
cp -r src/std "$W/base/compiler/std"
ulimit -s unlimited
# --fnhash（段 2 R2 の網 — report-1188 3.3 / report-1191）: 関数ごとの成果物のハッシュ（`build --emit=fnhash`）が、無関係な編集で
# 編集した関数（とその持ち主の下 — `/K` `/L` `#p` `#s`）と L 類の合成 rt（全体の数から組む本体 — FH_SYNTH）の外で変わらないこと（stray = 0）。
# 列: W1 ≡ W8・別パスの写し（1183 6 節の条件 2 — 成果物にパス由来のバイトが入らない）・panic-add（app の main に panic の点 1 つ — 後ろの点の
# 番号が全部ずれる）・lambda-add（loader の checksPar に task.Map のラムダ 1 つ — 子の関数と spawn の点の番号がずれる。自己には持ち上がるラムダ
# 〔lambda#〕が無い — 全部展開・融合）
if [ "${1:-}" = "--fnhash" ]; then
    FH_SYNTH="@rt.panic @rt.pcap_init @rt.pstat_dump"
    fh() { # $1 = 木の compiler/・$2 = W・$3 = 出力
        ( cd "$1" && SOBER_WORKERS=$2 "$STAGE2" build app --emit=fnhash -o "$3" > /dev/null 2>&1 ) || { echo "rebuildbench: fnhash build failed ($1 W$2)" >&2; exit 1; }
    }
    judge() { # $1 = 名前・$2 = 基準・$3 = 比べる側・$4 = 編集した関数の鍵（空 = 何も変わらないこと）
        node -e '
const fs = require("fs");
const [name, a0, b0, ed, synth] = process.argv.slice(1);
const r = p => new Map(fs.readFileSync(p, "utf8").trim().split("\n").map(l => l.split(" ")));
const a = r(a0), b = r(b0);
const ch = [];
for (const [k, v] of b) if (a.get(k) !== v) ch.push(k);
for (const k of a.keys()) if (!b.has(k)) ch.push(k);
const syn = new Set(synth.split(" "));
const ok = k => ed !== "" && (k === ed || k.startsWith(ed + "/") || k.startsWith(ed + "#")) || syn.has(k);
const stray = ch.filter(k => !(ed !== "" && ok(k)));
console.log(`fnhash ${name} fns=${b.size} changed=${ch.length} allowed=${ch.length - stray.length} stray=${stray.length}` + (stray.length ? " — " + stray.slice(0, 10).join(" ") : ""));
process.exit(stray.length ? 1 : 0);' "$1" "$2" "$3" "$4" "$FH_SYNTH"
    }
    bad=0
    fh "$W/base/compiler" 1 "$W/b1.h"
    fh "$W/base/compiler" 8 "$W/b8.h"
    judge W8 "$W/b1.h" "$W/b8.h" "" || bad=1
    mkdir -p "$W/alt/a/much/longer/path/than/before"
    cp -r "$W/base/compiler" "$W/alt/a/much/longer/path/than/before/compiler"
    fh "$W/alt/a/much/longer/path/than/before/compiler" 1 "$W/alt.h"
    judge other-path "$W/b1.h" "$W/alt.h" "" || bad=1
    for e in panic-add lambda-add; do
        rm -rf "$W/tree"; mkdir -p "$W/tree"; cp -r "$W/base/compiler" "$W/tree/compiler"
        case "$e" in
            panic-add)
                sed -i '/^func main() int {$/a\    a20, e20 := os.Args()\n    if e20 == nil \&\& len(a20) > 20 \&\& 100 / (len(a20) - 21) == 1 {\n        return 3\n    }' "$W/tree/compiler/app/main.sober"
                ed=@main.main ;;
            lambda-add)
                sed -i '/^    rs, cerr := task.Map(finFiles(n), (f) => checksOne(cx, pp, ixs, pnames, f, die))$/a\    if n < 0 {\n        xs0, e0 := task.Map(finFiles(0), (f) => f + 1)\n        if e0 != nil || len(xs0) > 99 {\n            return noHit(), false\n        }\n    }' "$W/tree/compiler/loader/finpar.sober"
                ed=@loader.checksPar ;;
        esac
        diff -rq "$W/base/compiler" "$W/tree/compiler" > /dev/null && { echo "rebuildbench: edit $e did not apply" >&2; exit 1; }
        fh "$W/tree/compiler" 1 "$W/e.h"
        judge "$e" "$W/b1.h" "$W/e.h" "$ed" || bad=1
    done
    exit $bad
fi
# --tyhash（段 4 R3 の網 — report-1226）: package の区画の正準形のハッシュ（`build --emit=tyhash`）と鍵（`--emit=tykeys`）。
# 列: W1 ≡ W8・別パスの写し・package の順の撹拌（SOBER_TYORDER=pkgrev — 区画は依存の区画と自分の入力だけで決まる）で何も変わらない・
# ast-body（ast の関数の本体の編集）で ast の外のハッシュと鍵が変わらない（ast の鍵は変わる — ソースの要約）・ast-decl（ast に関数を 1 つ足す —
# 宣言の編集）で ast と、ast に依存する package（parser）の鍵が変わり、std の鍵は変わらない。tyhash の行の扉の数（door / body / xents）は全部 0。
# 段 5 R1（report-1230）: 型付けの前の鍵 K1（`--emit=tykeys0` — 推移の import の閉包で組む）も同じ列（+ 種 7・撹拌 rev / shuf:7）で不変・
# 行の監査の欄（post = 事後の鍵との食い違い・dmis = 宣言の要約の食い違い・door・yfa）が全部 0・編集で K1 の変わる package ⊇ tyhash の変わる
# package（sup — 鍵の外の変化を見落とさない）。K1 と参照表の鍵（tykeys — K2 の形）の変わる数の差を印字する（外れの差 — K1 / K2 の判定）
if [ "${1:-}" = "--tyhash" ]; then
    th() { # $1 = 木の compiler/・$2 = W・$3 = tyhash / tykeys・$4 = 出力・$5 = 追加の env
        ( cd "$1" && env ${5:-} SOBER_WORKERS=$2 "$STAGE2" build app --emit=$3 -o "$4" > /dev/null 2>&1 ) || { echo "rebuildbench: $3 build failed ($1 W$2)" >&2; exit 1; }
    }
    tj() { # $1 = 名前・$2 = 基準・$3 = 比べる側・$4 = 変わってよい package の形（正規表現 — 空 = 何も）・$5 = 変わるべき package（空白区切り）
        node -e '
const fs = require("fs");
const [name, a0, b0, allow, want] = process.argv.slice(1);
const r = p => new Map(fs.readFileSync(p, "utf8").trim().split("\n").map(l => l.split(" ")).map(w => [w[0], w]));
const a = r(a0), b = r(b0);
const ch = [];
for (const [k, w] of b) if (!a.has(k) || a.get(k)[1] !== w[1]) ch.push(k);
const re = allow === "" ? null : new RegExp("^(" + allow + ")$");
const stray = ch.filter(k => !(re && re.test(k)));
const miss = want === "" ? [] : want.split(" ").filter(k => !ch.includes(k));
const doors = [...b.values()].filter(w => w.slice(2).some(x => /^(door|body|xents|post|dmis|yfa|vh)=/.test(x) && !/=0$/.test(x))).map(w => w[0]);
console.log(`tyhash ${name} pkgs=${b.size} changed=${ch.length} stray=${stray.length} missing=${miss.length} doors=${doors.length}` +
    (stray.length ? " — stray " + stray.slice(0, 8).join(" ") : "") + (miss.length ? " — missing " + miss.join(" ") : "") + (doors.length ? " — doors " + doors.join(" ") : ""));
process.exit(stray.length || miss.length || doors.length ? 1 : 0);' "$1" "$2" "$3" "$4" "$5"
    }
    sup() { # $1 = 名前・$2 / $3 = 基準と比べる側の tyhash・$4 / $5 = tykeys0・$6 / $7 = tykeys — K1 の変わる ⊇ tyhash の変わる
        node -e '
const fs = require("fs");
const [name, h0, h1, k0, k1, r0, r1] = process.argv.slice(1);
const r = p => new Map(fs.readFileSync(p, "utf8").trim().split("\n").map(l => l.split(" ")).map(w => [w[0], w[1]]));
const ch = (a0, b0) => { const a = r(a0), b = r(b0); return [...b.keys()].filter(k => a.get(k) !== b.get(k)); };
const th = ch(h0, h1), k1c = new Set(ch(k0, k1)), k2c = ch(r0, r1);
const miss = th.filter(k => !k1c.has(k));
const k2s = new Set(k2c), ex = [...k1c].filter(k => !k2s.has(k));
console.log(`tykeys0 ${name} tyhash-changed=${th.length} k1-changed=${k1c.size} k2-changed=${k2c.length} extra=${ex.length}` + (ex.length ? " (" + ex.join(" ") + ")" : "") + (miss.length ? " — NOT COVERED " + miss.join(" ") : ""));
process.exit(miss.length ? 1 : 0);' "$@"
    }
    bad=0
    for kind in tyhash tykeys tykeys0; do
        th "$W/base/compiler" 1 $kind "$W/b1.$kind"
        th "$W/base/compiler" 8 $kind "$W/b8.$kind"
        tj "$kind-W8" "$W/b1.$kind" "$W/b8.$kind" "" "" || bad=1
        th "$W/base/compiler" 1 $kind "$W/pr.$kind" SOBER_TYORDER=pkgrev
        tj "$kind-pkgrev" "$W/b1.$kind" "$W/pr.$kind" "" "" || bad=1
    done
    for kind in tyhash tykeys0; do
        th "$W/base/compiler" 1 $kind "$W/v.$kind" SOBER_HASH_SEED=7
        tj "$kind-seed7" "$W/b1.$kind" "$W/v.$kind" "" "" || bad=1
    done
    # package の中の順の撹拌（rev / shuf:7）は区画の記録の序数を動かす（読み戻しは序数で引く）— 口の値は K1 のコンパイラの設定の側に入る。
    # 網 = 撹拌で tyhash の変わる package ⊆ K1 の変わる package
    for v in rev shuf:7; do
        for kind in tyhash tykeys tykeys0; do
            th "$W/base/compiler" 1 $kind "$W/v.$kind" SOBER_TYORDER=$v
        done
        sup "order-$v" "$W/b1.tyhash" "$W/v.tyhash" "$W/b1.tykeys0" "$W/v.tykeys0" "$W/b1.tykeys" "$W/v.tykeys" || bad=1
    done
    mkdir -p "$W/alt/a/much/longer/path/than/before"
    cp -r "$W/base/compiler" "$W/alt/a/much/longer/path/than/before/compiler"
    for kind in tyhash tykeys tykeys0; do
        th "$W/alt/a/much/longer/path/than/before/compiler" 1 $kind "$W/alt.$kind"
        tj "$kind-other-path" "$W/b1.$kind" "$W/alt.$kind" "" "" || bad=1
    done
    for e in ast-body ast-decl lower-body; do
        rm -rf "$W/tree"; mkdir -p "$W/tree"; cp -r "$W/base/compiler" "$W/tree/compiler"
        case "$e" in
            ast-body) sed -i 's|^    return t.data\[l + 1 + i\]$|    return t.data[1 + l + i]|' "$W/tree/compiler/ast/ast.sober" ;;
            ast-decl) printf '\n// rebuildbench --tyhash の宣言の編集\nfunc TyBenchExtra(x int) int {\n    return x + 1\n}\n' >> "$W/tree/compiler/ast/ast.sober" ;;
            lower-body) sed -i 's|^    return kn + 2$|    return 2 + kn|' "$W/tree/compiler/lower/gvn.sober" ;;
        esac
        diff -rq "$W/base/compiler" "$W/tree/compiler" > /dev/null && { echo "rebuildbench: edit $e did not apply" >&2; exit 1; }
        th "$W/tree/compiler" 1 tyhash "$W/e.tyhash"
        th "$W/tree/compiler" 1 tykeys "$W/e.tykeys"
        th "$W/tree/compiler" 1 tykeys0 "$W/e.tykeys0"
        case "$e" in
            ast-body)
                tj "$e-tyhash" "$W/b1.tyhash" "$W/e.tyhash" "ast" "" || bad=1
                tj "$e-tykeys" "$W/b1.tykeys" "$W/e.tykeys" "ast" "ast" || bad=1
                tj "$e-tykeys0" "$W/b1.tykeys0" "$W/e.tykeys0" "ast" "ast" || bad=1 ;;
            ast-decl)
                tj "$e-tyhash" "$W/b1.tyhash" "$W/e.tyhash" "[a-z0-9]+" "ast" || bad=1
                tj "$e-tykeys" "$W/b1.tykeys" "$W/e.tykeys" "[a-z0-9]+" "ast parser" || bad=1
                tj "$e-tykeys0" "$W/b1.tykeys0" "$W/e.tykeys0" "[a-z0-9/]+" "ast parser" || bad=1 ;;
            lower-body)
                tj "$e-tykeys0" "$W/b1.tykeys0" "$W/e.tykeys0" "[a-z0-9/]+" "lower" || bad=1 ;;
        esac
        sup "$e" "$W/b1.tyhash" "$W/e.tyhash" "$W/b1.tykeys0" "$W/e.tykeys0" "$W/b1.tykeys" "$W/e.tykeys" || bad=1
    done
    exit $bad
fi
# 温めた置き場（編集前の木）
# 網の環境の SOBER_VERIFY（gates の =each）はキャッシュの道に入らない — 外す（report-1202 最終追記）
unset SOBER_VERIFY
mkdir -p "$W/warm"
( cd "$W/base/compiler" && SOBER_CACHE=$W/warm SOBER_BUILD_CACHE=1 "$STAGE2" build app --emit=elf --passes -o "$W/base.elf" > /dev/null 2>&1 ) || { echo "rebuildbench: base build failed" >&2; exit 1; }
ALT=$W/alt/a/much/longer/path/than/before
RES=$W/res.txt
: > "$RES"
edit() { # $1 = 編集・$2 = 木の compiler/
    case "$1" in
        none) ;;
        lower-body) sed -i '0,/^    return nil$/s//    _ = 0\n    return nil/' "$2/lower/lower.sober" ;;
        desugar-body) sed -i '0,/^    return nil$/s//    _ = 0\n    return nil/' "$2/desugar/surface.sober" ;;
        ast-body) sed -i 's|^    return t.data\[l + 1 + i\]$|    return t.data[1 + l + i]|' "$2/ast/ast.sober" ;;
        ast-sig) sed -i 's|^func ListLen(t Tree, l int) int {$|func ListLen(t Tree, n int) int {|; /^func ListLen/{n;s|    return t.data\[l\]|    return t.data[n]|}' "$2/ast/ast.sober" ;;
    esac
}
meas() { # $1 = 編集・$2 = 種類（whole / warm / alt / cold）・$3 = W
    local t=$W/t.txt tr=$W/tr.txt miss=- elf=- dir="" o=$W/$2.elf src=$W/tree/compiler entry=app bc="" store=-
    case "$2" in
        warm|alt) rm -rf "$W/c"; cp -r "$W/warm" "$W/c"; dir=$W/c; bc=1 ;;
        cold) rm -rf "$W/c"; dir=$W/c; bc=1 ;;
    esac
    if [ "$2" = alt ]; then
        rm -rf "$W/alt"; mkdir -p "$ALT"; cp -r "$W/tree/compiler" "$ALT/compiler"; src=$ALT/compiler; entry=$ALT/compiler/app
    fi
    ( cd "$src" && SOBER_CACHE=$dir SOBER_BUILD_CACHE=$bc SOBER_CACHE_STAT=$bc SOBER_WORKERS=$3 /usr/bin/time -o "$t" -f '%e %M' "$STAGE2" build "$entry" --emit=elf --passes -o "$o" > /dev/null 2> "$tr" ) || { echo "rebuildbench: FAIL $1 $2 W$3" >&2; cat "$tr" >&2; exit 1; }
    if [ "$2" != whole ]; then
        if cmp -s "$o" "$W/whole.elf"; then elf=same; else elf=DIFF; fi
        # 「cache: alpha a/n beta1 b/n beta2 c/n gamma d/n parse e/n …」→ 外れ α/β1/β2/γ/P（表示が無ければ NOCACHE — キャッシュの道に入っていない）
        miss=$(grep -m1 '^cache: alpha' "$tr" | awk '{ split($3, a, "/"); split($5, b, "/"); split($7, c, "/"); split($9, d, "/"); split($11, e, "/"); printf "%d/%d/%d/%d/%d", a[2] - a[1], b[2] - b[1], c[2] - c[1], d[2] - d[1], e[2] - e[1] }')
        [ -n "$miss" ] || miss=NOCACHE
        store=$(du -sk "$dir/sober-build-1" 2> /dev/null | awk '{ print $1 }')
    fi
    echo "$1 $2 W$3 $(tail -1 "$t") $miss $elf ${store:--}" | tee -a "$RES"
}
for r in $(seq 1 "$N"); do
    for e in none lower-body desugar-body ast-body ast-sig; do
        rm -rf "$W/tree"; mkdir -p "$W/tree"; cp -r "$W/base/compiler" "$W/tree/compiler"
        edit "$e" "$W/tree/compiler"
        if [ "$e" != none ] && diff -rq "$W/base/compiler" "$W/tree/compiler" > /dev/null; then echo "rebuildbench: edit $e did not apply" >&2; exit 1; fi
        for w in $WS; do
            meas "$e" whole "$w"
            meas "$e" warm "$w"
            meas "$e" alt "$w"
            if [ "$r" = 1 ]; then meas "$e" cold "$w"; fi
        done
    done
done
# 中央値の表（秒・RSS は中央値・外れ / elf / 置き場は最後の計測 — 同じ編集なら周ごとに同じ）
echo
node -e '
const rows = require("fs").readFileSync(process.argv[1], "utf8").trim().split("\n").map(l => l.split(" "));
const g = new Map();
for (const r of rows) { const k = r.slice(0, 3).join(" "); if (!g.has(k)) g.set(k, []); g.get(k).push(r); }
const med = xs => { const s = xs.map(Number).sort((a, b) => a - b); return s[(s.length - 1) >> 1]; };
console.log("| 編集 | 種類 | W | 秒（中央値） | RSS MB | 外れ α/β1/β2/γ/P | elf | 置き場 MB | n |");
console.log("|---|---|---|---|---|---|---|---|---|");
for (const [k, rs] of g) {
  const last = rs[rs.length - 1];
  const st = last[7] === "-" ? "-" : (Number(last[7]) / 1024).toFixed(1);
  console.log(`| ${k.split(" ").join(" | ")} | ${med(rs.map(r => r[3])).toFixed(2)} | ${Math.round(med(rs.map(r => r[4])) / 1024)} | ${last[5]} | ${last[6]} | ${st} | ${rs.length} |`);
}' "$RES"
grep -q -E ' (DIFF|NOCACHE) ' "$RES" && { echo "rebuildbench: DIFF / NOCACHE above" >&2; exit 1; }
exit 0
