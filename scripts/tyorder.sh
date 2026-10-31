#!/usr/bin/env bash
# 型付けの撹拌の網（インクリ + 並列の波 段 4 R0 — report-1216 / 1217）: build の判定と機械語が、表層型検査器（desugar.TypeAll）の
# 関数の順にも、Init / TypeAll の後のヒープの番地にも依らないこと（段 4 の区画化 — 型の表を package ごとの区画へ移す — の前提）。
# 口 = `SOBER_TYORDER` rev / pkgrev / shuf:<種>（typer.sober の tyPlan — Init と TypeAll の package の順〔依存の後順の中の選び方〕と
# package の中の関数・const・ファイルの順・証人 `#tyorder typed=… ord=…`）と
# `SOBER_TYPADA` / `SOBER_TYPADB`（lower.sober の tyPad — Init の後 / TypeAll の後にヒープへ 0 を積む・証人 `#typad`）。
# 判定 = 既定の順と 4 つの変種（rev・pkgrev・shuf:7・下駄 777 / 333）で、終了コード・stderr（`#` の証人の行を除く）・ELF がバイト一致。
# pkgrev / shuf は段 4 R2（Init / TypeAll の package 単位の分割 — 区画の中身が package の順で変わる）で戻した（report-1225）
# 母集団: 自己 build（compiler/ + std/ の木 — 口の証人も見る: rev の ord が出ている・#typad が 2 行）+ bench の題材 + examples
# （既定は 4 本に 1 本 — 並びの添字 mod 4 = 0・拒否の例も含む・`--every` で全数）。gates では desugar / lower の範囲の網（--full には入れない —
# --full の wall を決める selfpar と CPU を取り合い、線 10 分を越えた — report-1217 4.1 節）
# 宣言の相の監査（R2 — 全部の build に SOBER_TYAUDIT=1）: typed の点で late = 0・rout = 0・扉の監査（R3 — tycanon.sober）door = body = xents = 0（audit）
# 変異 3 つ（網が名指しすること）: m1 = 宣言の相を外し、呼び出しの結果の型の memo（yFnResults）を最初の呼び手の package の文脈で求める（順で値が変わる）・
# m2 = 口を効かなくする（tyPlan が口を読まない — 証人が出ず、健全なコンパイラの rev の ord と食い違う）・m3 = 宣言の相を外すだけ
# （出力は変わらない — 監査の late が名指しする）
# 使い方: scripts/tyorder.sh [--every] [--no-mutants]
set -uo pipefail
# 答えの再生は切る（この網は関数単位キャッシュの当否を見る）
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
ROOT=$PWD
every=0
mutants=1
for a in "$@"; do
    case "$a" in
        --every) every=1 ;;
        --no-mutants) mutants=0 ;;
        *) echo "tyorder: unknown argument $a" >&2; exit 2 ;;
    esac
done
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
J=${JOBS:-4}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
mkdir -p "$W/tree" "$W/r"
cp -r src/compiler/. "$W/tree/"
cp -r src/std "$W/tree/std"
entries=()
k=0
for f in examples/*.sober; do
    if [ "$every" = 1 ] || [ $((k % 4)) = 0 ]; then entries+=("$f"); fi
    k=$((k + 1))
done
for f in bench/*/main.sober; do entries+=("$f"); done
VARS=(rev pkgrev shuf:7 pad)
venv() { # $1 = 変種 — env の引数
    case "$1" in
        base) ;;
        pad) echo "SOBER_TYPADA=777 SOBER_TYPADB=333" ;;
        *) echo "SOBER_TYORDER=$1" ;;
    esac
}
# audit <err> <名前> <変種> — 宣言の相の監査（SOBER_TYAUDIT の typed の行 — R2）: 宣言の相の外で埋まった memo（late）が 0・区画の境が
# package の順に並ぶ（rout = 0）。load で落ちた題材は行が無い（見ない）
audit() {
    local l
    l=$(grep '^#tyaudit typed ' "$1" | head -1)
    [ -z "$l" ] && return 0
    case "$l" in
        *" door=0 body=0 xents=0 "*" late=0 "*" rout=0 "*) return 0 ;;
    esac
    echo "  $2: $3 — the declaration phase audit failed ($(echo "$l" | grep -o 'door=[0-9]* body=[0-9]* xents=[0-9]*\|late=[0-9]* regions=[0-9]* rout=[0-9]*' | tr '\n' ' '))"
    return 1
}
# one <cwd> <src> <名前> <コンパイラ> <作業の接頭> <追加フラグ> — 0 = 一致・1 = 割れた（行を出す）
one() {
    local cwd=$1 src=$2 name=$3 cc=$4 o=$5 fl=$6 v rc0 rc
    (cd "$cwd" && env SOBER_TYAUDIT=1 $(venv base) "$cc" build "$src" --emit=elf $fl -o "$o.base" > "$o.base.err" 2>&1)
    rc0=$?
    grep -v '^#' "$o.base.err" > "$o.base.msg"
    audit "$o.base.err" "$name" base || return 1
    for v in "${VARS[@]}"; do
        (cd "$cwd" && env SOBER_TYAUDIT=1 $(venv "$v") "$cc" build "$src" --emit=elf $fl -o "$o.v" > "$o.v.err" 2>&1)
        rc=$?
        grep -v '^#' "$o.v.err" > "$o.v.msg"
        audit "$o.v.err" "$name" "$v" || return 1
        if [ $rc != $rc0 ] || ! cmp -s "$o.base.msg" "$o.v.msg"; then
            echo "  $name: $v — the verdict differs (exit $rc0 → $rc: $(head -c 160 "$o.v.msg" | tr '\n' ' '))"
            return 1
        fi
        if [ $rc0 = 0 ] && ! cmp -s "$o.base" "$o.v"; then
            echo "  $name: $v — the ELF differs ($(cmp "$o.base" "$o.v" | head -1))"
            return 1
        fi
        [ "$v" = pad ] || grep '^#tyorder' "$o.v.err" | sed "s/^/$v /" >> "$o.wit"
        [ "$v" = pad ] && grep -c '^#typad' "$o.v.err" | sed 's/^/pad /' >> "$o.wit"
    done
    return 0
}
# 例題・bench は JOBS 本ずつ並べる（結果は 1 本ごとのファイル）
i=0
for e in "${entries[@]}"; do
    while [ "$(jobs -rp | wc -l)" -ge "$J" ]; do wait -n || true; done
    ( one . "$e" "$e" "$S2" "$W/r/$i" "" > "$W/r/$i.out"; echo $? > "$W/r/$i.rc" ) &
    i=$((i + 1))
done
wait
fail=0
n=$i
for ((x = 0; x < n; x++)); do
    if [ "$(cat "$W/r/$x.rc")" != 0 ]; then cat "$W/r/$x.out"; echo "FAIL: ${entries[$x]} depends on the typing order or heap addresses"; fail=$((fail + 1)); fi
done
# 自己 build + 口の証人
rm -f "$W/self.wit"
if one "$W/tree" app src/compiler/app "$S2" "$W/self" --passes > "$W/self.out"; then
    nd=$(grep '^[a-z:0-9]* #tyorder typed=[0-9]* ord=[0-9]' "$W/self.wit" | awk '{print $4}' | sort -u | wc -l)
    np=$(grep '^pad ' "$W/self.wit" | awk '{print $2}')
    [ "$nd" = 3 ] || { echo "FAIL: self build — the order ports did not take effect ($(tr '\n' ' ' < "$W/self.wit"))"; fail=$((fail + 1)); }
    [ "$np" = 2 ] || { echo "FAIL: self build — the heap pad ports did not take effect"; fail=$((fail + 1)); }
else
    cat "$W/self.out"; echo "FAIL: self build depends on the typing order or heap addresses"; fail=$((fail + 1))
fi
n=$((n + 1))
# 置き場の当たりを撹拌の中で混ぜる（段 5 R3 — 置き場の切り口 γ）: 変種ごとに空の置き場へ元の木を冷で建て、編集した木（elf に関数 1 つ —
# elf と elf に依存する package が外れ・残りは当たり）を温で建てる。温の ELF が編集した木のキャッシュなしの既定の順の build と一致し、γ に
# 当たりと外れが混ざること。pkgrev は当たりを別の package の順で読み戻す（鍵に入らない撹拌）・rev / shuf は鍵が分かれる（同じ変種の中で混ぜる）
rm -rf "$W/ed"; cp -r "$W/tree" "$W/ed"
printf '\nfunc TyOrderEdit(x int) int {\n    return x + 3\n}\n' >> "$W/ed/elf/elf.sober"
if (cd "$W/ed" && env -u SOBER_VERIFY -u SOBER_CACHE_VERIFY "$S2" build app --emit=elf --passes -o "$W/ed.ref" > "$W/ed.log" 2>&1); then
    for v in base "${VARS[@]}"; do
        rm -rf "$W/cm"
        (cd "$W/tree" && env -u SOBER_VERIFY -u SOBER_CACHE_VERIFY SOBER_CACHE="$W/cm" SOBER_BUILD_CACHE=1 $(venv "$v") "$S2" build app --emit=elf --passes -o "$W/cm.cold" > "$W/cm.log" 2>&1) || { echo "FAIL: cache mix $v: cold build: $(grep -v '^#' "$W/cm.log" | head -c 200)"; fail=$((fail + 1)); continue; }
        (cd "$W/ed" && env -u SOBER_VERIFY -u SOBER_CACHE_VERIFY SOBER_CACHE="$W/cm" SOBER_BUILD_CACHE=1 SOBER_CACHE_STAT=1 $(venv "$v") "$S2" build app --emit=elf --passes -o "$W/cm.warm" > "$W/cm.log" 2>&1) || { echo "FAIL: cache mix $v: warm build: $(grep -v '^#' "$W/cm.log" | head -c 200)"; fail=$((fail + 1)); continue; }
        g=$(sed -nE 's|^cache: alpha .* gamma ([0-9]+)/([0-9]+) .*|\1 \2|p' "$W/cm.log" | head -1)
        read -r ga gn <<< "${g:-0 0}"
        if ! cmp -s "$W/ed.ref" "$W/cm.warm"; then echo "FAIL: cache mix $v: the warm ELF differs from the uncached build"; fail=$((fail + 1))
        elif [ "$ga" -le 0 ] || [ "$ga" -ge "$gn" ]; then echo "FAIL: cache mix $v: gamma did not mix hits and misses (gamma $ga/$gn)"; fail=$((fail + 1))
        else echo "  cache mix $v: gamma $ga/$gn — ELF identical"; fi
    done
else
    echo "FAIL: cache mix: the edited tree did not build: $(head -c 200 "$W/ed.log")"; fail=$((fail + 1))
fi
nm=0
if [ "$mutants" = 1 ]; then
    # mutant <名前> <ファイル> <sed の式> <grep の形> — 変異のコンパイラで自己 build を回して割れる（判定・ELF・証人）なら捕まえた
    mutant() {
        local name=$1 file=$2 expr=$3 pat=$4
        rm -rf "$W/mt"; mkdir -p "$W/mt"; cp -r "$W/tree/." "$W/mt/"
        grep -q -- "$pat" "$W/mt/$file" || { echo "FAIL: mutant $name: the form was not found in $file"; fail=$((fail + 1)); return; }
        sed -i -- "$expr" "$W/mt/$file"
        cmp -s "$W/tree/$file" "$W/mt/$file" && { echo "FAIL: mutant $name: the edit did not apply to $file"; fail=$((fail + 1)); return; }
        (cd "$W/mt" && "$S2" build app --emit=elf --passes -o "$W/mc-$name" > "$W/mlog" 2>&1) || { echo "FAIL: mutant $name build: $(head -c 200 "$W/mlog")"; fail=$((fail + 1)); return; }
        chmod +x "$W/mc-$name"
        rm -f "$W/m.wit"
        if one "$W/tree" app src/compiler/app "$W/mc-$name" "$W/m" --passes > "$W/mout"; then
            if [ "$(grep '^rev ' "$W/m.wit" | awk '{print $4}')" = "$(grep '^rev ' "$W/self.wit" | awk '{print $4}')" ]; then
                echo "FAIL: mutant $name was not caught"; fail=$((fail + 1))
            else
                echo "  mutant $name caught by the witness: $(tr '\n' ' ' < "$W/m.wit")"
            fi
        else
            echo "  mutant $name caught by $(sed 's/^  //' "$W/mout" | head -1)"
        fi
        nm=$((nm + 1))
    }
    mutant m1-memo-context desugar/typer.sober 's/^            yDeclPre(mut st, hget(mut st, st.ty.ford + 1 + j))$/            _ = j/;s/yResults(mut st, yTeList(mut st, fnPkg(mut st, fi), -1, fnResults(mut st, fi)))/yResults(mut st, yTeList(mut st, if st.ypk >= 0 { st.ypk } else { fnPkg(mut st, fi) }, -1, fnResults(mut st, fi)))/' 'yTeList(mut st, fnPkg(mut st, fi), -1, fnResults'
    mutant m3-no-decl-phase desugar/typer.sober 's/^            yDeclPre(mut st, hget(mut st, st.ty.ford + 1 + j))$/            _ = j/' '^            yDeclPre(mut st, hget(mut st, st.ty.ford + 1 + j))$'
    mutant m2-port-off desugar/typer.sober 's/^    mode, seed := tyOrderMode()$/    mode, seed := 0, 0/' '^    mode, seed := tyOrderMode()$'
fi
echo "tyorder: $n entries × {rev, pkgrev, shuf:7, heap pad} — verdict and ELF identical, $nm mutants, fail=$fail"
[ "$fail" = 0 ]
