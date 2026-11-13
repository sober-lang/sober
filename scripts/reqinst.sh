#!/usr/bin/env bash
# reqinst（要求 1 件の固定費の網）: bench/httparena/main.sober を今の木の stage2 で建て、題材ごとに callgrind で
# 「命令/要求」（ireq）と「熱い 64 B 行の数」（hot64 — 要求あたり 0.45 回以上実行された命令を含む 64 B の行・熱い道のコードの足跡 = L1i の物差し）を測り、
# bench/ratchet.txt の `srv/<題材> ireq <上限>` / `srv/<題材> hot64 <上限>` と照合する。機能を足す便でも、全要求の道の固定費が増えたら赤になる
# （1 便ずつの増分は GHA の A/B の分解能〔±2.5〜3%〕の下に隠れるので、線は揺れの幅だけの余白で引く — × 1.005 の余白では 1 便 +20 命令/要求が素通りする）。
#   scripts/reqinst.sh          照合。越えたら赤 — 正当な増えなら ireq は実測 + 2、hot64 は実測で引き直し、報告とコミットに明記して事後追認。
#                               ireq が 0.5% 以上・hot64 が 1 行でも下がったら締め直しの note
#   scripts/reqinst.sh --mut    網の自己検査: 変異 2 本を焼いたコンパイラをそれぞれ自己 build で建て（1 本約 15 秒）、それで建てたサーバが赤になることを確かめる
#                               （両方赤 = 終了 0）。dispatch = std/http/server の Dispatch（全要求の道）に要求ごとの写しと分岐〔約 +5 命令/要求〕・
#                               pgrow = std/pg の rowOf（DataRow の受け — 行ごと）に同じ形の写しと分岐（asyncdb の線だけで照合）
# 題材 asyncdb は別のサーバ（bench/asyncdb — async-db の 20 行を std/pg のプールから読む）を、PostgreSQL の代役（bench/pgstub — 決まった表を返す）を相手に測る。
# callgrind に掛けるのはサーバだけで、代役は別の CPU で素のまま走らせる（代役は束ごとの応答を 1 回の送りで返す — サーバの recv の切れ目を揺らさない）。
# 代役は変異の便でも今の木の stage2 で建てる（変異はサーバの側にだけ当てる）
# 計器 = callgrind（W1・SOBER_IO=2〔epoll の道 — ring は callgrind で測れない〕・SOBER_HASH_SEED=0）。束 20 と 220（× 16 要求）の 2 本の差 ÷ 3,200 =
# 起動・接続・終了を除いた要求 1 件の命令。同じ ELF の揺れ = ireq ±0.8・hot64 0。perf stat の instructions:u は揺れ（±数命令/要求 — 起動と終了が混ざる）と
# 権限（perf_event_paranoid）が要り、足跡（番地ごとの回数）も取れない。
# valgrind は VALGRIND → PATH → /nix/store の順に探す。無ければ SKIP（緑 — GHA・利用者の箱）。題材の足し方 = scripts/reqinst.ts の冒頭
set -uo pipefail
export SOBER_HASH_SEED=0
cd "$(dirname "$0")/.."
R=$PWD
S2=${STAGE2:-out/stage2/sober2}
case "$S2" in /*) ;; *) S2=$R/$S2 ;; esac
mut=0
[ "${1:-}" = --mut ] && mut=1
VG=${VALGRIND:-$(command -v valgrind || ls -d /nix/store/*-valgrind-[0-9]*/bin/valgrind 2> /dev/null | sort -V | tail -n 1)}
if [ -z "$VG" ] || ! "$VG" --version > /dev/null 2>&1; then
    echo "SKIP reqinst — valgrind が無い（VALGRIND で valgrind の実行ファイルを指す）: 要求 1 件の命令数と足跡は照合していない"
    exit 0
fi
# 客とサーバを別の CPU に 1 つずつ固定する（affinity の最後の 2 つ・asyncdb の代役は最後から 3 つ目 — 3 つ無ければ asyncdb だけ SKIP）— 固定しないと 1 束あたりの空読みの周回が客との競り合いで変わり ±2.5% 揺れる
# （同じ CPU に置く形は空き CPU では決定的〔−97 命令/要求の別の値〕だが、他のプロセスと CPU を分け合うと揺れる）
mapfile -t cpus < <(taskset -pc $$ | sed 's/.*: //' | tr ',' '\n' | awk -F- '{ if (NF == 2) for (i = $1; i <= $2; i++) print i; else print $1 }')
if [ "${#cpus[@]}" -lt 2 ]; then
    echo "SKIP reqinst — 使える CPU が 2 つ未満（客とサーバを別の CPU に固定する計器）: 要求 1 件の命令数と足跡は照合していない"
    exit 0
fi
CS=${cpus[${#cpus[@]} - 1]}
CC=${cpus[${#cpus[@]} - 2]}
CP=$([ "${#cpus[@]}" -ge 3 ] && echo "${cpus[${#cpus[@]} - 3]}")
W=$(mktemp -d)
trap 'kill $(jobs -p) 2> /dev/null; rm -rf "$W"' EXIT
K1=20
K2=220

# ready <port> を出すまで待つ（出さずに死ぬか 120 秒で空）
ready() { # ready <出力のファイル> <pid>
    local i port=""
    for i in $(seq 1200); do
        port=$(awk '$1 == "ready" { print $2; exit }' "$1" 2> /dev/null)
        [ -n "$port" ] && break
        kill -0 "$2" 2> /dev/null || break
        sleep 0.1
    done
    echo "$port"
}

measure() { # measure <srv> <題材> <置き場の頭> [<環境>…] → 「ireq <x> hot64 <n>」
    local srv=$1 subj=$2 o=$3 K vp port
    shift 3
    for K in $K1 $K2; do
        env "$@" SOBER_WORKERS=1 SOBER_IO=2 SOBER_MDWE=0 TLS_CERT=/nonexistent TLS_KEY=/nonexistent \
            taskset -c $CS "$VG" --tool=callgrind --dump-instr=yes --callgrind-out-file="$o.$K" "$srv" 0 0 > "$o.srv.$K" 2>&1 &
        vp=$!
        port=$(ready "$o.srv.$K" $vp)
        [ -n "$port" ] || { echo "reqinst: サーバが ready を出さない（$subj）: $(tail -c 300 "$o.srv.$K")" >&2; kill $vp 2> /dev/null; return 1; }
        NODE_NO_WARNINGS=1 taskset -c $CC node --experimental-strip-types scripts/reqinst.ts cli "$port" $K "$subj" 2> "$o.cli.$K" \
            || { echo "reqinst: 客が失敗（$subj 束 $K）: $(cat "$o.cli.$K")" >&2; kill $vp 2> /dev/null; return 1; }
        kill -TERM $vp
        wait $vp 2> /dev/null
        [ -s "$o.$K" ] || { echo "reqinst: callgrind の出力が無い（$subj 束 $K）" >&2; return 1; }
    done
    NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/reqinst.ts acct "$o.$K1" "$o.$K2" $((K2 - K1))
}

# 変異のコンパイラを $W/mut-<名>/sober2 に建てる（std の 1 関数に写しと分岐 — sed の式は「当てた印」の行を足す）
mkmut() { # mkmut <名> <std の相対パス> <sed の式>
    local d=$W/mut-$1 f
    mkdir -p "$d/tree"
    cp -r src/compiler/. "$d/tree/"
    cp -r src/std "$d/tree/std"
    f=$d/tree/std/$2
    sed -i "$3" "$f"
    grep -q 'reqinst mutant' "$f" || { echo "reqinst --mut: FAIL — 変異 $1 を当てる行が $2 に見つからない"; return 1; }
    (cd "$d/tree" && SOBER_WORKERS=1 "$S2" build app -o "$d/sober2" > "$d/build.log" 2>&1) || { echo "reqinst --mut: FAIL — 変異 $1 のコンパイラが建たない: $(tail -c 400 "$d/build.log")"; return 1; }
}

mapfile -t subjs < <(awk '$1 ~ /^srv\// && $2 == "ireq" { sub(/^srv\//, "", $1); print $1 }' bench/ratchet.txt)
[ "${#subjs[@]}" -gt 0 ] || { echo "reqinst: FAIL — bench/ratchet.txt に srv/<題材> ireq の行が無い"; exit 1; }
has_db=0
for subj in "${subjs[@]}"; do [ "$subj" = asyncdb ] && has_db=1; done
PGP=""
if [ $has_db = 1 ] && [ -n "$CP" ]; then
    "$S2" build bench/pgstub --emit=elf --passes -o "$W/pgstub" > "$W/stub.log" 2>&1 || { echo "reqinst: FAIL build bench/pgstub: $(tail -c 400 "$W/stub.log")"; exit 1; }
    # 応答の前に 300 µs 待たせる: サーバが PG の応答を読みに行った時点では届いていない形（本物の PG と同じ）に揃え、サーバの待ちの回数を揃える
    # （待たせないと、読みに行った時点で届いているかが回ごとに変わり ±15 命令/要求揺れる。待たせても rt の待ちの道で ±7 残る — 線の余白は ratchet の注）
    taskset -c $CP "$W/pgstub" 0 300 > "$W/stub.out" 2>&1 &
    PGP=$(ready "$W/stub.out" $!)
    [ -n "$PGP" ] || { echo "reqinst: FAIL — 代役（bench/pgstub）が ready を出さない: $(tail -c 300 "$W/stub.out")"; exit 1; }
fi

fail=0
n=0
# run_all <コンパイラ> <題材の絞り（all か題材の名）> — 建てて測って線と照合し、fail / n を足す
run_all() {
    local cc=$1 only=$2 subj s got ireq hot col v lim srv
    "$cc" build bench/httparena/main.sober --emit=elf --passes -o "$W/srv" > "$W/build.log" 2>&1 || { echo "reqinst: FAIL build bench/httparena/main.sober: $(tail -c 400 "$W/build.log")"; fail=$((fail + 1)); return; }
    if [ $has_db = 1 ]; then
        "$cc" build bench/asyncdb --emit=elf --passes -o "$W/srv-asyncdb" > "$W/build-db.log" 2>&1 || { echo "reqinst: FAIL build bench/asyncdb: $(tail -c 400 "$W/build-db.log")"; fail=$((fail + 1)); return; }
    fi
    for subj in "${subjs[@]}"; do
        [ "$only" = all ] || [ "$only" = "$subj" ] || continue
        s=$(date +%s)
        if [ "$subj" = asyncdb ]; then
            if [ -z "$PGP" ]; then
                echo "SKIP srv/asyncdb — 使える CPU が 3 つ未満（客・サーバ・代役の PG を別の CPU に固定する）: async-db の要求 1 件は照合していない"
                continue
            fi
            # プールは 10 本（DATABASE_MAX_CONN 16 − 6）: 既定の 250 本は callgrind の下で起動時に RegionExceeded（slot_capacity）になる。測るのは 1 接続なので本数は数えに効かない
            got=$(measure "$W/srv-asyncdb" asyncdb "$W/cg-asyncdb" DATABASE_URL=postgres://bench:bench@127.0.0.1:$PGP/benchmark DATABASE_MAX_CONN=16) \
                || { echo "FAIL asyncdb: 計測できない"; fail=$((fail + 1)); continue; }
        else
            got=$(measure "$W/srv" "$subj" "$W/cg-$subj") || { echo "FAIL $subj: 計測できない"; fail=$((fail + 1)); continue; }
        fi
        read -r _ ireq _ hot <<< "$got"
        for col in ireq hot64; do
            v=$([ $col = ireq ] && echo "$ireq" || echo "$hot")
            lim=$(awk -v k="srv/$subj" -v c=$col '$1 == k && $2 == c { print $3; exit }' bench/ratchet.txt)
            n=$((n + 1))
            if [ -z "$lim" ]; then
                echo "FAIL srv/$subj $col = $v — bench/ratchet.txt に行が無い"; fail=$((fail + 1))
            elif awk -v v="$v" -v l="$lim" 'BEGIN { exit !(v > l) }'; then
                echo "FAIL srv/$subj $col = $v > $lim（bench/ratchet.txt — 全要求の道の固定費の増え。正当なら引き直して事後追認 — 冒頭の注）"; fail=$((fail + 1))
            elif awk -v v="$v" -v l="$lim" -v c=$col 'BEGIN { exit !(c == "ireq" ? v * 1.005 < l : v < l) }'; then
                echo "note srv/$subj $col = $v — 上限 $lim より下がった（bench/ratchet.txt を締め直す）"
            else
                echo "ok: srv/$subj $col = $v ≤ $lim"
            fi
        done
        echo "  ($subj: $(( $(date +%s) - s )) s)"
    done
}

if [ $mut = 1 ]; then
    bad=0
    # dispatch: Dispatch で要求の path の長さを mut の局所に写して読み戻し、分岐する（全要求の道に数命令）
    mkmut dispatch http/server/server.sober '/^func Dispatch(routes \[\]Route, r Request) Response {$/,/^}$/ s|^    pb := bytes(r.path)$|&\n    // reqinst mutant\n    mut mutw := len(pb)\n    mutw = mutw * 3 + len(routes)\n    if mutw == 9999991 {\n        return unrouted(routes, pb)\n    }|' || exit 1
    fail=0; n=0
    run_all "$W/mut-dispatch/sober2" all
    if [ $fail -gt 0 ]; then echo "reqinst --mut: caught dispatch — $fail / $n lines red"; else echo "reqinst --mut: FAIL — 変異 dispatch（Dispatch に要求ごとの写し）が鳴らない"; bad=1; fi
    # pgrow: rowOf（DataRow の受け）で列の数を mut の局所に写して読み戻し、分岐する（行ごとに数命令 — asyncdb の 20 行で約 +100 命令/要求）
    if [ -z "$PGP" ]; then
        echo "SKIP reqinst --mut pgrow — asyncdb を測れない（CPU が 3 つ未満か ratchet に srv/asyncdb が無い）"
    else
        mkmut pgrow pg/pg.sober '/^func rowOf(body \[\]byte, cols \[\]int, fmts \[\]int) (Row, error?) {$/,/^}$/ s|^    nc := internal.pgwire.RowLen(body)$|&\n    // reqinst mutant\n    mut mutw := nc\n    mutw = mutw * 3 + len(cols)\n    if mutw == 9999991 {\n        return emptyRow(), internal.pgwire.Protocol{}\n    }|' || exit 1
        fail=0; n=0
        run_all "$W/mut-pgrow/sober2" asyncdb
        if [ $fail -gt 0 ]; then echo "reqinst --mut: caught pgrow — $fail / $n lines red"; else echo "reqinst --mut: FAIL — 変異 pgrow（rowOf に行ごとの写し）が鳴らない"; bad=1; fi
    fi
    exit $bad
fi
run_all "$S2" all
echo "reqinst: $n lines (srv/* ireq / hot64 in bench/ratchet.txt), fail=$fail"
[ $fail = 0 ]
