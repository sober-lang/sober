#!/usr/bin/env bash
# 常備ゲートの一括実行（ビルドは 1 回だけ・独立なゲートは並列・変更範囲で絞れる）。各ゲートの本体は既存の scripts/*.sh のまま（ここは呼ぶだけ）。
#
#   scripts/gates.sh                 = --full
#   scripts/gates.sh --full          全ゲート（タグ zig の Zig 単体のゲートを除く — 主役交代 R39: src/ は凍結）
#   scripts/gates.sh --all           全ゲート + タグ zig（src/ を触ったとき）+ stages の重い照合（STAGES_RAW — 掛けた / 掛けないの check の経路の道具の出力 — scripts/rawcheck.sh）
#   scripts/gates.sh --fast TAG...   タグに関係するゲートだけ（タグ: lex parse fmt load desugar check lower backend lean zig all — 下の表）
#   scripts/gates.sh --auto          作業木の変更ファイル（git status）からタグを推定（推定できない変更があれば --full、src/ の変更は --all）
#   オプション: -j G（同時に走らせるゲートの数、既定 6）・--jobs J（ゲートの中の並列、既定 = CPU 数 / 同時ゲート数、最低 4）・--no-cache（差分スキップ・tool の再利用を切る）
#
# 段:
#   1. 共有ビルド: `zig build`（stage1）→ scripts/stage2.sh（stage2 — 古ければ作り直す。bin/sober と共有）→ compiler/tools/* を主の sober（stage2）で並列に
#      ビルドして $SELFHOST_BIN へ（各 selfhost スクリプトは自分でビルドしない）。$SOBER = bin/sober（主の sober）・$STAGE1 = src/stage1/zig-out/bin/sober を export
#   2. toolcheck: compiler/tools/* を主の `sober check`（Sober の analyzer + 検査器）で検査（各 selfhost スクリプトの「tool 自身の check」をここに集める — SELFHOST_TOOLCHECKED=1）
#   3. ゲート: 長いものから並列に。ログは scripts/.gatecache/logs/<gate>.log、末尾に PASS / FAIL / SKIP と所要秒の一覧
# 差分スキップ（黄金照合系 astjson / loaderjson / corejson）: 入力（sober バイナリ・スクリプト・examples / testdata / std）の内容ハッシュが
# 前回の成功時と同じなら照合を飛ばして SKIP（キャッシュ = scripts/.gatecache/、gitignore 済み）
set -uo pipefail
# map のハッシュの種を固定（既定は乱数 — 探査の長さが揺れて命令・cycles が揺れる。出力は種に依らない）
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
cd "$(dirname "$0")/.."
ROOT=$PWD
# 黄金 = ワーカー 1（協調形）の観測（段 6 P4-4 — 既定のワーカー数はコア数。M:N は schedfuzz / seqpar が SOBER_WORKERS を明示して掛ける。
# ゲートの中で例を並列に走らせるので、ワーカー数 × 同時数の過負荷も避ける）
export SOBER_WORKERS=1

mode=full
withzig=0
tags=()
G=6
J=
cache=1
while [ $# -gt 0 ]; do
    case "$1" in
        --full) mode=full ;;
        --fast) mode=fast; shift; while [ $# -gt 0 ] && [ "${1#-}" = "$1" ]; do tags+=("$1"); shift; done; continue ;;
        --auto) mode=auto ;;
        --all) mode=full; withzig=1 ;;
        -j) G=$2; shift ;;
        --jobs) J=$2; shift ;;
        --no-cache) cache=0 ;;
        *) echo "gates: unknown argument $1"; exit 2 ;;
    esac
    shift
done

# ゲート → タグ（どの変更で走らせるか）。all は --full だけ。zig は --all / --fast zig / src/ の変更（--auto）だけ — --full には入らない
# 凍結コーパスの Zig ≡ Sober（selfhost_* — 入力は scripts/frozen/*.list）と、主の sober の自己オラクル（stages・obs・hermetic・黄金・Lean 照合）が主線
# 退役: selfhost_desugar（脱糖器の Zig ≡ Sober — F-17 案 2α で mut struct の束縛のコアの形と型が変わった。reaudit round 5。脱糖器は第 3 黄金・Lean 照合が見る）
declare -A GTAG=(
    [zigtest]="zig"
    [obs_zig]="zig"
    [hermetic_zig]="zig"
    [ir_roundtrip]="zig"
    [obs]="lex parse load desugar lower backend"
    [astjson]="lex parse"
    [loaderjson]="load"
    [corejson]="desugar"
    [irtext]="backend lower"
    [lltext]="backend lower"
    [selfhost_ll]="lex parse load lower backend"
    [selfhost_lower]="lex parse load lower backend"
    [toolcheck]="lex parse fmt load desugar check lower"
    [selfhost_lex]="lex"
    [selfhost_parse]="lex parse"
    [selfhost_fmt]="lex parse fmt"
    [selfhost_load]="lex parse load"
    [selfhost_e2e]="lex parse load desugar check lean"
    [selfhost_check]="check lean"
    [pkgcheck]="backend desugar lean"
    [hermetic]="lex parse load desugar lower backend"
    [io_args]="backend"
    [passes]="lower backend"
    [regionbound]="desugar lower"
    [checkverdict]="load desugar check analyzer"
    [checksplit]="load desugar check analyzer"
    [cachekey]="load desugar check"
    [panicmsg]="lower backend"
    [optdiff]="lower backend"
    [cachesplit]="load desugar check analyzer"
    [stages]="lex parse load desugar check lower backend"
    [corevec]="lean check"
    [extract]="lean check"
    [leanbatch]="lean"
    [typerdiff]="desugar lower"
    [pool_oracle]="load desugar analyzer"
    [errtrace]="load desugar analyzer lower backend"
    [analyzer_neg]="parse load desugar analyzer"
    [secretdump]="load desugar analyzer"
    [effectsdump]="load desugar analyzer"
    [efftrace]="load desugar analyzer lower backend"
    [fixcheck]="load desugar analyzer"
    [uniqfreeze]="desugar analyzer lean"
    [implicitfreeze]="desugar analyzer lower backend"
    [sobertest]="load lower backend"
    [jsonsuite]="load lower backend"
    [unittest]="lex parse load desugar check lower backend"
    [x86enc]="backend"
    [trapprobe]="lower backend"
    [seqpar]="lower backend"
    [lparcfg]="lower"
    [schedvec]="lower backend"
    [schedfuzz]="lower backend"
    [parbudget]="lower backend"
    [cutstat]="lower backend"
    [mapfuse]="lower"
    [partinl]="lower"
    [docsync]="docs"
    [benchsync]="docs"
    [maprepr]="lower"
    [streq]="lower"
    [ubfstat]="lower"
    [framestat]="lower"
    [sortcheck]="lower backend"
    [matchlencheck]="lower backend"
    [flatecheck]="lower backend"
    [ctcheck]="lower backend analyzer"
    [cryptocheck]="lower backend"
    [tlsfsm]="lean lower backend"
    [iterregion]="lower backend"
    [llcheck]="lower backend"
    [fitcheck]="lower backend"
    [iouring]="lower backend"
    [httpcheck]="lower backend"
    [pid1stop]="lower backend"
    [vaslot]="lower backend"
    [starve]="lower backend"
    [selfpar]="check desugar load"
    [nextgen]="lower backend"
    [elfeq]="lex parse load desugar lower backend"
    [sobi]="lex parse fmt load desugar check"
    [refs]="lex parse load"
    [stdref]="docs"
)
# 長いものから（並列の詰め順）
ORDER=(zigtest stages selfpar nextgen selfhost_ll selfhost_e2e leanbatch sobi selfhost_check selfhost_lower selfhost_fmt selfhost_load toolcheck pkgcheck selfhost_parse hermetic obs elfeq io_args errtrace passes regionbound checkverdict checksplit cachesplit cachekey panicmsg optdiff typerdiff corejson irtext lltext llcheck astjson loaderjson selfhost_lex pool_oracle analyzer_neg secretdump effectsdump efftrace fixcheck uniqfreeze implicitfreeze sobertest jsonsuite unittest x86enc trapprobe seqpar lparcfg schedvec schedfuzz parbudget cutstat mapfuse partinl docsync benchsync maprepr streq ubfstat framestat sortcheck matchlencheck flatecheck ctcheck cryptocheck tlsfsm iterregion fitcheck iouring httpcheck starve pid1stop vaslot refs stdref corevec extract obs_zig hermetic_zig ir_roundtrip)

auto_tags() { # 変更ファイル → タグ（推定できない変更は all）
    local f
    git status --porcelain | cut -c4- | sed 's/.* -> //' | while IFS= read -r f; do
        case "$f" in
            src/stage1/*|build.zig|build.zig.zon) echo zig; echo all ;;
            bin/sober|scripts/stage2.sh|scripts/gatelib.sh|scripts/gates.sh) echo all ;;
            scripts/frozen/lex.list) echo lex ;;
            scripts/frozen/parse.list|scripts/frozen/parse-excluded.list) echo parse ;;
            scripts/frozen/fmt.list) echo fmt ;;
            scripts/frozen/load.list) echo load ;;
            scripts/frozen/entries.list) echo desugar; echo check; echo lower ;;
            scripts/frozen/lower.list) echo lower ;;
            scripts/ir_roundtrip.sh) echo zig ;;
            scripts/sobertest.sh|testdata/sobertest/*) echo load ;;
            scripts/jsonsuite.sh|testdata/jsontestsuite/*|scripts/oracles/jsonsuite.go) echo backend ;;
            scripts/unittest.sh|src/compiler/*_test.sober) echo all ;;
            src/compiler/lexer/*|src/compiler/tools/lexdump/*) echo lex ;;
            src/compiler/parser/*|src/compiler/ast/*|src/compiler/tools/parsedump/*) echo parse ;;
            src/compiler/printer/*|src/compiler/tools/fmtdump/*) echo fmt ;;
            src/compiler/loader/*|src/compiler/tools/loaderdump/*) echo load ;;
            src/compiler/desugar/*|src/compiler/tools/desugardump/*) echo desugar ;;
            src/compiler/analyzer/*|scripts/pool_oracle.sh|scripts/errtrace.sh|scripts/analyzer_neg.sh|scripts/secretdump.sh|testdata/secretdump/*|scripts/effectsdump.sh|testdata/effectsdump/*|scripts/efftrace.sh|scripts/efftrace.ts|scripts/fixcheck.sh|testdata/fix/*|testdata/fixgold/*) echo analyzer ;;
            src/compiler/checker/*|src/compiler/tools/checkdump/*|src/compiler/tools/sobercheck/*) echo check ;;
            scripts/selfpar.sh|testdata/selfpar/*|scripts/checkstats.sh) echo check ;;
            scripts/nextgen.sh) echo lower ;;
            src/compiler/lower/*|src/compiler/tools/lowerdump/*|src/compiler/tools/lldump/*|src/compiler/app/*) echo lower ;;
            src/compiler/x86/*|src/compiler/elf/*|src/compiler/tools/x86encdump/*) echo backend ;;
            src/compiler/iface/*|scripts/sobi.sh|scripts/frozen/sobi_known.txt) echo fmt; echo load ;;
            scripts/selfhost_lex.sh) echo lex ;;
            scripts/selfhost_parse.sh|scripts/astjson.sh) echo parse ;;
            scripts/selfhost_fmt.sh) echo fmt ;;
            scripts/selfhost_load.sh|scripts/loaderjson.sh|scripts/loaderjson.list) echo load ;;
            scripts/selfhost_desugar.sh|scripts/corejson.sh) echo desugar ;;
            scripts/selfhost_check.sh|scripts/selfhost_e2e.sh|scripts/checkmut.ts|scripts/corevec.sh) echo check ;;
            scripts/obs.sh|scripts/hermetic.sh|scripts/pkgcheck.sh|scripts/io_args.sh|scripts/x86enc.sh|scripts/elfeq.sh|scripts/elfeq.list) echo backend ;;
            scripts/selfhost_lower.sh|scripts/lparcfg.sh|scripts/lparcfg.ts|scripts/trapprobe.sh|testdata/trapprobe/*|scripts/seqpar.sh|scripts/seqpar.list|scripts/schedvec.sh|scripts/schedvec.ts|scripts/schedvec.list|scripts/schedfuzz.sh|scripts/schedfuzz.list|scripts/parbudget.sh|testdata/parbudget/*|scripts/cutstat.sh|scripts/mapfuse.sh|scripts/partinl.sh|scripts/maprepr.sh|scripts/streq.sh|scripts/sortcheck.sh|scripts/matchlencheck.sh|testdata/matchlen/*|scripts/iterregion.sh|testdata/sortcheck/*|scripts/flatecheck.sh|testdata/flatecheck/*|scripts/ctcheck.sh|testdata/ctcheck/*|scripts/cryptocheck.sh|scripts/ubfstat.sh|scripts/ubfstat.list|scripts/framestat.sh|scripts/framestat.list|scripts/fitcheck.sh|scripts/iouring.sh|scripts/httpcheck.sh|testdata/httpcheck/*|scripts/pid1stop.*|testdata/pid1stop/*|scripts/vaslot.sh|testdata/vaslot/*|scripts/starve.sh|testdata/starve/*|testdata/cutstat/*|scripts/optdiff.sh|scripts/typerdiff.sh|scripts/irtext.sh|scripts/lltext.sh|scripts/llcheck.sh|scripts/selfhost_ll.sh|scripts/stages.sh|scripts/selfhost_cli.sh|scripts/passes.sh|scripts/regionbound.sh) echo lower ;;
            scripts/checkverdict.sh|testdata/checkverdict/*) echo check; echo docs ;;
            scripts/refs.sh|scripts/alphacheck.sh|scripts/alphamap.ts|src/compiler/tools/refs/*|testdata/refs/*) echo load ;;
            scripts/stdref.sh|scripts/stdref/*|src/compiler/tools/docgen/*|testdata/stdref/*|docs/std/*) echo docs ;;
            lean/Main.lean|scripts/leanbatch.sh) echo lean ;;
            lean/FeatherweightSober/UniqFreeze.lean|scripts/uniqfreeze.sh|scripts/uniqfreeze.list) echo lean; echo analyzer ;;
            scripts/implicitfreeze.sh|scripts/implicitfreeze.ts) echo desugar; echo lower ;;
            lean/Extract/*|lean/ExtractMain.lean|lean/FeatherweightSober/TyVec.lean|scripts/extract.sh|lean/Extract/sober/*) echo lean ;;
            lean/FeatherweightSober/Tls.lean|scripts/tlsfsm.sh|testdata/tls/fsm.golden) echo lean ;;
            docs/guide/*|docs/spec/*|docs/language.md|README.md|README.ja.md|scripts/docsync.*|bench/README.md|bench/data/*|scripts/benchsync.*|scripts/benchchart.ts|docs/assets/bench-*) echo docs ;;
            docs/*|*.md) ;;
            *) echo all ;;
        esac
    done | sort -u
}

if [ "$mode" = auto ]; then
    mapfile -t tags < <(auto_tags)
    if [ "${#tags[@]}" = 0 ]; then echo "gates: --auto: no gate-relevant change"; exit 0; fi
    if printf '%s\n' "${tags[@]}" | grep -qx zig; then withzig=1; fi
    if printf '%s\n' "${tags[@]}" | grep -qx all; then mode=full; fi
    echo "gates: --auto → ${mode/auto/fast} ${tags[*]}"
    [ "$mode" = auto ] && mode=fast
fi
[ "$mode" = fast ] && printf '%s\n' "${tags[@]}" | grep -qx all && mode=full

sel=()
for g in "${ORDER[@]}"; do
    if [ "$mode" = full ]; then
        if [ "${GTAG[$g]}" != zig ] || [ "$withzig" = 1 ]; then sel+=("$g"); fi
        continue
    fi
    for t in "${tags[@]}"; do
        case " ${GTAG[$g]} " in *" $t "*) sel+=("$g"); break ;; esac
    done
done
[ "${#sel[@]}" -gt 0 ] || { echo "gates: no gate matches: ${tags[*]}"; exit 2; }
if [ -z "$J" ]; then
    conc=$(( ${#sel[@]} < G ? ${#sel[@]} : G ))
    J=$(( $(nproc) / conc ))
    [ "$J" -ge 4 ] || J=4
fi

CACHE=$ROOT/scripts/.gatecache
LOGS=$CACHE/logs
rm -rf "$LOGS"
mkdir -p "$CACHE"
mkdir -p "$LOGS"
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
T0=$(date +%s)

# ── 1. 共有ビルド ──
s=$(date +%s)
if ! (cd src/stage1 && zig build) > "$LOGS/build.log" 2>&1; then echo "gates: FAIL zig build (see $LOGS/build.log)"; exit 1; fi
STAGE1=$ROOT/src/stage1/zig-out/bin/sober
export STAGE1
if ! scripts/stage2.sh --quiet >> "$LOGS/build.log" 2>&1; then echo "gates: FAIL scripts/stage2.sh (see $LOGS/build.log)"; exit 1; fi
grep -q 'stage2 rebuilt' "$LOGS/build.log" && s2note="stage2 rebuilt" || s2note="stage2 cached"
SOBER=$ROOT/bin/sober
export SOBER
export SOBER_CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
[ -x "$SOBER_CHECK" ] || { echo "gates: $SOBER_CHECK not found (cd lean && lake build)"; exit 1; }
# tool は sober バイナリ・compiler/・std/ の内容ハッシュが前回と同じなら前回のビルドを使う（scripts/.gatecache/bin）
source scripts/gatelib.sh
BIN=$CACHE/bin
tkey="$(cache_key "$STAGE1" "$ROOT/out/stage2/sober2" src/compiler src/std) o1=${SOBER_O1:-}"   # 道具は主の sober（stage2 + stage1 の正規バックエンド）で建てる
# SOBER_O1=1 は -O1 の列: stage2 を zig cc -O1（scripts/stage2.sh）、道具を stage2 の .ll → zig cc -O1（bin/sober --via=ll）で建てる
tvia=""
[ -n "${SOBER_O1:-}" ] && tvia=--via=ll
if [ "$cache" = 1 ] && [ -f "$BIN/.key" ] && [ "$(cat "$BIN/.key")" = "$tkey" ]; then
    tools_note="tools cached"
else
    rm -rf "$BIN"
    mkdir -p "$BIN"
    bfail=0
    for t in src/compiler/tools/*/; do
        t=$(basename "$t")
        (cd src/compiler && "$SOBER" build "tools/$t/main.sober" $tvia -o "$BIN/$t") >> "$LOGS/build.log" 2>&1 &
    done
    wait || true
    for t in src/compiler/tools/*/; do
        t=$(basename "$t")
        [ -x "$BIN/$t" ] || { echo "gates: FAIL build src/compiler/tools/$t (see $LOGS/build.log)"; bfail=1; }
    done
    [ "$bfail" = 0 ] || exit 1
    echo "$tkey" > "$BIN/.key"
    tools_note="tools built"
fi
export SELFHOST_BIN=$BIN SELFHOST_TOOLCHECKED=1 JOBS=$J
# stage2 は上の build の段で確かめた — 以降の bin/sober の呼び出しは鮮度の確認を飛ばす（ゲートの間は木を変えない規律）
export SOBER_STAGE2_CHECKED=1
# IR の検証器は段ごとに（既定の build は最後に 1 回 — 段で崩れたらどの段かを gates が名指す。仕上げ便）
export SOBER_VERIFY=each
[ "$cache" = 1 ] && export GATECACHE=$CACHE
# stages の「掛けた / 掛けないの check の経路の突き合わせ」（scripts/rawcheck.sh — 約 3.5 分・決定 (C2) 2026-10-20）は --all（タグ zig と同じ重い列）だけ。
# --full / --fast / --auto では省く（守りは残す — 単体の scripts/stages.sh も既定で回す）。決定 2026-09-29
export STAGES_RAW=$withzig
export GATES_ALL=$withzig   # selfhost_check の (i') 追加シード（corevec v2 — --all だけ）
echo "gates: build ($(( $(date +%s) - s ))s, $s2note, $tools_note${SOBER_O1:+, -O1}) — ${#sel[@]} gates: ${sel[*]}"

# ── 2. 3. ゲート ──
run_gate() { # $1 = ゲート名。終了コードと所要を $W/res/<gate> に
    local g=$1 s ec=0
    s=$(date +%s)
    case "$g" in
        # zigtest は凍結後に動いた入力（std/ の集合・examples/・Lean の sober-check）を読むテストが赤い — scripts/frozen/zigtest-expected-fail.list の
        # 宣言と赤の集合が一致すれば緑（新しい赤・宣言の古び（緑に戻った行）はどちらも赤。G1）
        zigtest) { (cd src/stage1 && zig build test --summary all) > "$LOGS/$g.log" 2>&1; zigtest_judge "$LOGS/$g.log" >> "$LOGS/$g.log"; } || ec=$? ;;
        toolcheck)
            local t
            mkdir -p "$W/tc"
            for t in src/compiler/tools/*/; do
                t=$(basename "$t")
                ( (cd src/compiler && "$SOBER" check "tools/$t/main.sober" > /dev/null 2>&1) && echo "ok: sober check src/compiler/tools/$t" || echo "FAIL: sober check src/compiler/tools/$t" ) > "$W/tc/$t" &
            done
            wait
            cat "$W/tc"/* > "$LOGS/$g.log"
            grep -q '^FAIL' "$LOGS/$g.log" && ec=1
            echo "toolcheck: $(ls src/compiler/tools | wc -l) tools, fail=$(grep -c '^FAIL' "$LOGS/$g.log")" >> "$LOGS/$g.log" ;;
        # G-e（3'' M3）: 小分けの check（`check --split`）の出力 ≡ 一括の黄金（testdata/checkverdict）
        checksplit) scripts/checkverdict.sh --split > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        selfhost_check) scripts/selfhost_check.sh --fast > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        # corevec v2: golden の一致 + 被覆ラチェット + 全数を sober-check のバッチ経路で照合
        corevec) scripts/corevec.sh --binary > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        hermetic) scripts/hermetic.sh --stage2 > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        hermetic_zig) scripts/hermetic.sh $(zig_frozen) testdata/pkgdemo/app testdata/errpkg/app testdata/iface/app > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        ir_roundtrip) scripts/ir_roundtrip.sh $(zig_frozen | grep -v /) > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        # obs_zig は凍結コーパスの .out 持ちだけ（凍結後の例は stage1 の範囲外の言語で書かれうる — 正規バックエンド列の到達リスト化と同じ筋。決定 2026-09-29）
        obs_zig) SOBER=$STAGE1 scripts/obs.sh $(zig_frozen) > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        benchsync) scripts/benchsync.sh --check > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        # リネーム道具（report-883）: loadcheck + 負例の期待 TSV + 仮決め名の未分類 0
        refs) scripts/refs.sh --selftest > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        *) "scripts/$g.sh" > "$LOGS/$g.log" 2>&1 || ec=$? ;;
    esac
    echo "$ec $(( $(date +%s) - s ))" > "$W/res/$g"
}
mkdir -p "$W/res"
for g in "${sel[@]}"; do
    while [ "$(jobs -rp | wc -l)" -ge "$G" ]; do wait -n || true; done
    run_gate "$g" &
done
wait || true

# ── サマリ ──
fails=0
echo "gates: summary (wall $(( $(date +%s) - T0 ))s, -j $G --jobs $J, logs in scripts/.gatecache/logs/)"
for g in "${sel[@]}"; do
    read -r ec secs < "$W/res/$g"
    if [ "$g" = zigtest ]; then
        last=$(grep -m1 'Build Summary' "$LOGS/$g.log" | cut -c1-110)
    else
        last=$(grep -v '^ok' "$LOGS/$g.log" | grep -v '^[[:space:]]*$' | tail -n 1 | cut -c1-110)
    fi
    if [ "$ec" != 0 ]; then st=FAIL; fails=$((fails + 1)); elif grep -q '^SKIP' "$LOGS/$g.log"; then st=SKIP; else st=PASS; fi
    printf '  %-4s %-17s %4ss  %s\n' "$st" "$g" "$secs" "$last"
done
if [ "$fails" = 0 ]; then echo "gates: ALL PASS"; else echo "gates: $fails FAILED"; fi
[ "$fails" = 0 ]
