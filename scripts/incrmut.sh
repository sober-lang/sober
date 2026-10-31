#!/usr/bin/env bash
# 後段の関数キャッシュの鍵の変異の網（段 3 R3-c — report-1194 6 節 3・report-1202）: 鍵の成分を 1 つずつ落とした壊したコンパイラを木の写しから
# stage2 で建て、網が名指しで鳴ること（鳴らなければ FAIL）。
#   m1 = 呼び先の記録の事実（ckFact — 戻りの型・mut 仮引数の印・ワーカーの大域か）を落とす（ckOpnd）
#   m2 = cfg を落とす（ckTab の c1 / c2）
#   m3 = cutInsert の 2 bit を落とす（ckBeta）
#   m4 = 番地を取られる bit を落とす（ckBeta — 自分と呼び先）
#   m5 = 番号の定数の点の鍵から序数を落とす（ckTab — 持ち主の中の点が全部同じ鍵）
#   m6 = コンパイラの鍵（世代）を落とす（app の buildCacheGen — 定数の世代）
# 切り口 γ（TypeAll の package の区画 — 段 5 R3・report-1228 4.5 の 5 本 + 1）:
#   m7 = 鍵 K1 から閉包の宣言の要約を落とす（tyK1）           — 鳴らす編集 dep-decl（依存の宣言の相の記録の序数がずれる）
#   m8 = 鍵 K1 からソースの要約（tcSrc）を落とす（tyK1）        — listat-sem（本体の編集）・optfn-site（ソースの変わらない package の脱糖後の木）
#   （m9 = 合成の節の引き直しを落とす〔trNode — PRSYN の lo〕は同値の変異で外した: γ の値の合成の節の参照は当たりの道で引かれない —
#    参照されるのは総称の名前付き関数型の展開〔関数宣言・仮引数〕だけで、例題 142 本の計測・lo = 12 の題材でも出力 / 検証が不変〔report-1242 1 節〕）
#   m10 = 当たりの nimpl の足し込みを落とす（tyRead）            — none（全部当たり — 暗黙の freeze の点が消える）
#   m11 = 検査の飛ばしで DeadlineUse を足さない（ParCheckTyped）— 例題 task_sleep_deadline / net_deadline_spawn の温（題材だけの口）
#   m12 = 検査の飛ばしを外れにも掛ける（CheckSkip）             — 拒否の段（rej-par / rej-freeze — 温が受理する）
# 切り口 P（parse のファイル単位の木 — 段 5 R4・loader/pcache.sober）:
#   m13 = 鍵からソースの中身を落とす（pcKey — 長さだけの鍵）     — listat-sem（長さの同じ本体の編集 — 古い木が当たる）
#   m14 = 符号から欄 c を落とす（pcEnc / pcDec の両方 — 自分とは整合する欠けた符号）— none の検証（読み戻しの照合 `cache: parse readback mismatch`）
# γ / P の変異は check の道（便 2 R4 — analyzer の全部の型付けが γ を読む・check が parse の木を読み書きする）でも incrcheck の自己の鎖で鳴らす:
#   m7 = dep-decl（検証 =1 — `cache: stale entry gamma`）・m8 = optfn-def / optfn-site（読み戻しの食い違い）・m12 = frz（freeze の違反の指摘が落ちる）・
#   m13 = listat-sem（検証 =1 — `cache: stale entry parse`）・m14 = none（検証 — `cache: parse readback mismatch`）。m10 / m11 は check の道では同値
#   （nimpl と DeadlineUse は build の検査の歩きだけが読む — m10 は base bld aerr bld frz none の鎖で鳴らないことを確かめた）
# 切り口 D（check の関数単位の判定 — 便 2 R2・checker/defcache.sober）— 鳴らす網は scripts/incrcheck.sh の自己の鎖（短い列・温の check の出力の割れ）:
#   m15 = インスタンスの memo の当たりで使いの辺を積まない（luEdge）        — inst inst-drop（作り手が離れて当たりの使い手が落ちを運ばない）
#   （m16 = 鍵の閉包からジェネリックの本体を落とす〔dkGraph の辺 ②〕は同値の変異で外した: インスタンス化する呼び出しは呼び先の仮引数に型パラメータの
#    値を渡すので、辺 ④〔mut の Def でない呼び先へ mut を含みうる値 — 型パラメータは張る側〕が同じ本体へ必ず張る。mut 仮引数のジェネリック
#    〔incrcheck の inst2〕でも ④ が張られることを --def-graph で確かめた — report-1263）
#   m17 = 鍵の閉包から展開される関数の本体を落とす（dkGraph）                — exp exp-rej（スカラーの mut 仮引数 2 つの展開される関数 — ④ が張られない形）
#   m18 = 落ちの位置を項目の頭からの相対でなく絶対の字句で持つ（CkRel / CkAbs）— body rej rej-pad（前に字句を足すと古い位置。コメントだけの行は字句を動かさない）
#   m19 = 鍵から参照の辺（署名・const・型）を落とす（dkGraph）               — callee callee-sig（呼び先の署名の編集で呼び手が古い受理のまま当たる）
#   m20 = 当たりの脱糖の拒否の値を再生しない（受理扱い — 便 2 R3）            — dlen dlen-pad（拒否の Def が当たりのとき受理を出す）
#   m21 = 拒否の 2 つ目の位置（NonExhaustive の missing）を値に書かない        — dnex dnex-pad（再生の文面から `(missing: …)` が落ちる）
#   （m22 = const の初期化式のラムダでも capLive が mainReach を遅延で作る〔report-1271〕は m23 の便で同値の変異になったので外した: 区間の子は
#   親の届く印を受けるので capLive の近道を外しても mainReach を作らない。遅延で作る道の検出は m23 が持つ）
#   m23 = 区間の子が親の届く印（PlanDefs の rok / reach）を使わず capLive が mainReach を遅延で作る（report-1272 — 関数の中の値の位置のラムダ）
#         — 扉の監査（=2）の examples/closure_field_def.sober が `cache: door outside` で落ちる
# 鳴らす網: m1 / m2 = 扉の監査の鍵の感度の検査（SOBER_CACHE_VERIFY=2 の ckSens — `cache: insensitive key …`）。呼び手の IR は呼び先の署名と
# cfg に追従して変わる（呼び先の戻りの型・mut 仮引数が変われば呼び手の呼び出しの形が変わる）ので、編集の列では鍵の冗長に隠れて鳴らない —
# 成分が鍵に混ざっていることを直に見る。m3〜m6 = incrbuild の自己の鎖（scripts/incrbuild.sh — 当てる編集だけの短い列・温の ELF の割れか
# 検証モードの `cache: stale entry … @<関数>`）
# 使い方: scripts/incrmut.sh [m1 … m6]（既定は全部）・INCR_PAR = 同時に回す変異の数（既定 2）
set -uo pipefail
# 答えの再生は切る（この網は関数単位キャッシュの当否を見る）
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
ulimit -s unlimited
# gates の SOBER_VERIFY=each（段ごとの IR の検証器）はキャッシュの道に入らない — 網はキャッシュの道そのものを見るので外す
unset SOBER_SELF_KEY SOBER_VERIFY
MS=("$@")
[ "${#MS[@]}" = 0 ] && MS=(m1 m2 m3 m4 m5 m6 m7 m8 m10 m11 m12 m13 m14 m15 m17 m18 m19 m20 m21 m23)
fail=0
# 変異を当てる（$1 = 変異・$2 = 木の compiler/）。当たらなければ 1
mutate() {
    local T=$2 f
    case "$1" in
        m1) f=$T/lower/ckey.sober; sed -i 's|^        rt := st.ckt.rs\[i\]$|        rt := 0|' "$f" ;;
        m2) f=$T/lower/ckey.sober; sed -i 's|c1: h\[0\], c2: h\[1\]|c1: 0, c2: 0|' "$f" ;;
        m3) f=$T/lower/ckey.sober; sed -i 's|^            cb := ckIdx(cuts, fr\[k\]) + 1$|            cb := 0|' "$f" ;;
        m4) f=$T/lower/ckey.sober; sed -i 's|, cb), st.xAddr\[k\]), r|, cb), 0), r|; s|^                bit := st.xAddr\[xIndex(fr, table.Get(mut st.ckk, j))\]$|                bit := 0|' "$f" ;;
        m5) f=$T/lower/ckey.sober; sed -i 's|, pass), xs\[k + 1\]))$|, pass), 0))|' "$f" ;;
        m6) f=$T/app/main.sober; sed -i 's|^    gen := string(k\[0:16\]) catch return ""$|    gen := "0000000000000000"|' "$f" ;;
        m7) f=$T/desugar/tycanon.sober; sed -i '/^func tyK1(/,/^}$/{s|^            tcW(mut st, hget(mut st, dl + 1 + d \* 2))$|            tcW(mut st, 0)|; s|^            tcW(mut st, hget(mut st, dl + 2 + d \* 2))$|            tcW(mut st, 0)|}' "$f" ;;
        m8) f=$T/desugar/tycanon.sober; sed -i '/^func tyK1(/,/^}$/{s|^    tcW(mut st, s1)$|    tcW(mut st, 0)|; s|^    tcW(mut st, s2)$|    tcW(mut st, 0)|}' "$f" ;;
        m10) f=$T/desugar/tycache.sober; sed -i 's|^    st.nimpl += dnimpl$|    st.nimpl += 0|' "$f" ;;
        m11) f=$T/desugar/parcheck.sober; sed -i 's|^    if gcDlAny(mut st) {$|    if false \&\& gcDlAny(mut st) {|' "$f" ;;
        m12) f=$T/desugar/tycache.sober; sed -i 's|^    return st.ty.kst != 0 \&\& ksAt(mut st, KSGC, pk) \& (GC_SKIP \| GC_AUD) == GC_SKIP$|    return st.ty.kst != 0|' "$f" ;;
        m13) f=$T/loader/pcache.sober; sed -i '/^func pcKey(/,/^}$/{s|^        w := binary.Load64(src, i)$|        w := 0|; s|^        w := int(src\[i\])$|        w := 0|}' "$f" ;;
        m14) f=$T/loader/pcache.sober; sed -i 's|^        ws\[q + 4\] = x.c - p.c$|        ws[q + 4] = 0|; s|p.c + ws\[q + 4\]|0 + ws[q + 4]|' "$f" ;;
        m15) f=$T/desugar/call.sober; sed -i 's|^                luEdge(mut st, hget(mut st, r + 2) - st.ndef)$|                _ = 0|' "$f" ;;
        m17) f=$T/desugar/defkey.sober; sed -i 's/(fnExpands(mut st, g) || lenL(mut st, fnTParams(mut st, g)) > 0)/(false || lenL(mut st, fnTParams(mut st, g)) > 0)/' "$f" ;;
        m18) f=$T/desugar/defcache.sober; sed -i 's|c.ih2\[e\], p.tok - c.slo\[e\]}|c.ih2[e], p.tok}|; s|c.slo\[e\] + off < c.shi\[e\]|off >= 0|; s|tok: c.slo\[e\] + off}|tok: off}|' "$f" ;;
        m20) f=$T/checker/defcache.sober; sed -i 's/if stt\[i\] == 1 \&\& (fl\[i\] \& CF_REJ) != 0 { 2 } else { 1 }/if stt[i] == 1 \&\& (fl[i] \& CF_REJ) != 0 { 1 } else { 1 }/' "$f" ;;
        m23) f=$T/desugar/core_out.sober; sed -i 's|^    if rng.plan.rok != 0 {$|    if false {|' "$f" ;;
        m21) f=$T/checker/defcache.sober; sed -i 's/fl\[rd\] = CF_REJ | (if o.recs\[4\] != 0 { CF_RMISS } else { 0 })/fl[rd] = CF_REJ/' "$f" ;;
        m19) f=$T/desugar/defkey.sober; sed -i '/^                if g >= 0 \&\& g != o {$/{n;n;s|^                    dst = append(dst, g)$|                    dst = append(dst, o)|}' "$f" ;;
    esac
    ! cmp -s "$f" "$W/orig/${f#"$T"/}"
}
mkdir -p "$W/orig"
cp -r src/compiler/. "$W/orig/"
# 変異 1 本（$1）を $W/<変異>/ の中だけで回して判定の行を $W/<変異>.out へ・FAIL なら $W/<変異>.fail を置く（変異どうしは互いに独立 —
# INCR_PAR 本ずつ並べて回す。既定 2: --full の中の長い札を縮める〔R4 — report-1204 3 節〕）
one() {
    local m=$1 D=$W/$1 ec n hit st1 ed vf
    mkdir -p "$D/t"
    cp -r src/compiler/. "$D/t/"
    cp -r src/std "$D/t/std"
    if ! mutate "$m" "$D/t"; then echo "incrmut: FAIL $m: the mutation did not apply (update scripts/incrmut.sh)"; return 1; fi
    ( cd "$D/t" && SOBER_WORKERS=8 "$S2" build app --emit=elf --passes -o "$D/$m" > /dev/null 2> "$D/b.err" ) || { echo "incrmut: FAIL $m: build: $(head -c 300 "$D/b.err")"; return 1; }
    # 建てた直後の実行ファイルは別の inode に写してから走らせる（並列の stage2 が書いた直後の同じパスの exec が ETXTBSY で 126 になることがある）
    chmod +x "$D/$m" && cp "$D/$m" "$D/$m.x" && mv -f "$D/$m.x" "$D/$m"
    case "$m" in
        m1|m2)
            ( cd "$D/t" && SOBER_CACHE=$D/c SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=2 SOBER_WORKERS=1 SOBER_HASH_SEED=0 "$D/$m" build app --emit=elf --passes -o "$D/o.elf" > /dev/null 2> "$D/r.err" )
            ec=$?
            n=$(grep -c 'cache: insensitive key' "$D/r.err")
            if [ "$ec" != 0 ] && [ "$n" != 0 ]; then echo "incrmut: $m caught — $(grep -m1 'cache: insensitive key' "$D/r.err") (+$((n - 1)) more lines)"
            else echo "incrmut: FAIL $m was not caught (exit $ec, insensitive lines $n)"; return 1; fi
            ;;
        m23)
            rm -rf "$D/c"
            SOBER_CACHE=$D/c SOBER_CHECK_CACHE=1 SOBER_CACHE_VERIFY=2 "$D/$m" check examples/closure_field_def.sober > /dev/null 2> "$D/r.err"
            ec=$?
            n=$(grep -c 'cache: door outside' "$D/r.err")
            if [ "$ec" != 0 ] && [ "$n" != 0 ]; then echo "incrmut: $m caught — $(grep -m1 'cache: door outside' "$D/r.err") (+$((n - 1)) more lines)"
            else echo "incrmut: FAIL $m was not caught (exit $ec, door lines $n)"; return 1; fi
            ;;
        m15|m17|m18|m19|m20|m21)
            case "$m" in
                m15) ed="base inst inst-drop" ;;
                m17) ed="base exp exp-rej" ;;
                m18) ed="base body rej rej-pad" ;;
                m19) ed="base callee callee-sig" ;;
                m20) ed="base dlen dlen-pad" ;;
                m21) ed="base dnex dnex-pad" ;;
            esac
            INCR_COMPILER=$D/$m INCR_EDITS="$ed" INCR_VFY="" INCR_SELF_ONLY=1 scripts/incrcheck.sh > "$D/r.out" 2>&1
            ec=$?
            hit=$(grep -E 'warm=DIFF|cache: stale entry' "$D/r.out" | head -2 | tr '\n' ' ')
            if [ "$ec" != 0 ] && [ -n "$hit" ]; then echo "incrmut: $m caught — $hit"
            else echo "incrmut: FAIL $m was not caught (exit $ec)"; sed 's/^/  /' "$D/r.out" | head -20; return 1; fi
            ;;
        *)
            local rj="" fs=""
            case "$m" in
                m3) ed="lambda-add pure-flip"; vf="pure-flip" ;;
                m4) ed="addr-add fnval"; vf="fnval" ;;
                m5) ed="panic-add none"; vf="none" ;;
                m6) ed=""; vf="" ;;
                m7) ed="dep-decl"; vf="dep-decl" ;;
                m8) ed="listat-sem optfn-def optfn-site"; vf="listat-sem optfn-site" ;;
                m10) ed="none"; vf="none" ;;
                m11) ed=""; vf=""; fs="examples/task_sleep_deadline.sober examples/net_deadline_spawn.sober" ;;
                m12) ed="none"; vf=""; rj="rej-par rej-freeze" ;;
                m13) ed="listat-sem"; vf="listat-sem" ;;
                m14) ed="none"; vf="none" ;;
            esac
            INCR_COMPILER=$D/$m INCR_SRC=$D/t INCR_EDITS="$ed" INCR_VFY="$vf" INCR_REJECTS="$rj" INCR_ONLY_FILES="$fs" INCR_SWAP=$([ "$m" = m6 ] && echo 1 || echo 0) INCR_SELF_ONLY=1 \
                scripts/incrbuild.sh > "$D/r.out" 2>&1
            ec=$?
            hit=$(grep -E 'warm=DIFF|warm=EXIT|vfy=DIFF|stale=[1-9]|cache: stale entry|cache: bad gamma|cache: parse readback|diag=DIFF|warm=exit0|FAIL examples/' "$D/r.out" | head -2 | tr '\n' ' ')
            st1=$(grep -m1 'cache: stale entry' "$D/r.out" | sed 's/^ *//')
            if [ "$ec" != 0 ] && [ -n "$hit" ]; then echo "incrmut: $m caught — $hit${st1:+ | $st1}"
            else echo "incrmut: FAIL $m was not caught (exit $ec)"; sed 's/^/  /' "$D/r.out" | head -20; return 1; fi
            # check の道（便 2 R4 — analyzer の全部の型付けが γ を読む・check が parse の木を読み書きする）でも鳴ること: incrcheck の自己の鎖
            # （bld = 置き場へ build して γ を書く）。m10 / m11 は check の道では同値（nimpl と DeadlineUse は build の検査の歩きだけが読む）
            ed=""
            case "$m" in
                m7) ed="base bld dep-decl"; vf="dep-decl" ;;
                m8) ed="base bld optfn-def bld optfn-site"; vf="optfn-site" ;;
                m12) ed="base bld frz"; vf="base" ;;
                m13) ed="base listat-sem"; vf="listat-sem" ;;
                m14) ed="base none"; vf="none" ;;
            esac
            if [ -n "$ed" ]; then
                INCR_COMPILER=$D/$m INCR_EDITS="$ed" INCR_VFY="$vf" INCR_AUD=- INCR_SELF_ONLY=1 scripts/incrcheck.sh > "$D/c.out" 2>&1
                ec=$?
                hit=$(grep -E 'warm=DIFF|cache: stale entry|readback' "$D/c.out" | head -2 | tr '\n' ' ')
                if [ "$ec" != 0 ] && [ -n "$hit" ]; then echo "incrmut: $m caught on check — $hit"
                else echo "incrmut: FAIL $m was not caught on check (exit $ec)"; sed 's/^/  /' "$D/c.out" | head -20; return 1; fi
            fi
            ;;
    esac
    rm -rf "$D"
}
PAR=${INCR_PAR:-2}
for m in "${MS[@]}"; do
    while [ "$(jobs -rp | wc -l)" -ge "$PAR" ]; do wait -n || true; done
    { one "$m" > "$W/$m.out" 2>&1 || touch "$W/$m.fail"; } &
done
wait
for m in "${MS[@]}"; do
    cat "$W/$m.out"
    [ -e "$W/$m.fail" ] && fail=1
done
echo "incrmut: ${#MS[@]} mutants, fail=$fail"
exit $fail
