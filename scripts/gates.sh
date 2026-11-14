#!/usr/bin/env bash
# 常備ゲートの一括実行（ビルドは 1 回だけ・独立なゲートは並列・変更範囲で絞れる）。各ゲートの本体は既存の scripts/*.sh のまま（ここは呼ぶだけ）。
#
#   scripts/gates.sh                 = --full
#   scripts/gates.sh --full          全ゲート（タグ zig の Zig 単体のゲートを除く — 主役交代 R39: src/ は凍結）
#   scripts/gates.sh --all           全ゲート + タグ zig（src/ を触ったとき）+ stages の重い照合（STAGES_RAW — 掛けた / 掛けないの check の経路の道具の出力 — scripts/rawcheck.sh）
#   scripts/gates.sh --fast TAG...   タグに関係するゲートだけ（タグ: lex parse fmt load desugar check lower backend lean zig all — 下の表）
#   scripts/gates.sh --gate NAME...  名前で指定したゲートだけ（M2のscripts/gatemut.sh・監査のscripts/gateaudit.shが使う）
#   scripts/gates.sh --auto          作業木の変更ファイル（git status）からタグを推定（推定できない変更があれば --full、src/ の変更は --all）
#   オプション: -j G（同時に走らせるゲートの数、既定8 — 2026-10-27に6から: フェーズ3の検査4本で -j 6の詰めの下限がゲート秒の和 / 6 ≈ 657 sになり、
#   24コアのマシンで -j 8 = 592 s。--fullのwallの上限値は10分〔旧8分〕— ナビ決定・report-1204 3 節）・--jobs J（ゲートの中の並列、既定 = CPU数 / 同時ゲート数、最低4）・--no-cache（差分スキップ・toolの再利用を切る）
#   --budget S（起動から S 秒で打ち切り — 新しいゲートを始めず、走行中のゲートは止めて「未走」に。PASS / FAIL / 未走の三分類と、未走を走らせる
#   `scripts/gates.sh --gate …` の行を印字する。PASS は記録に残るので、同じコマンドの再走は HIT で飛ばして続きから走る = 分割実行）
#   --fail-fast（最初の FAIL で打ち切る — 新しいゲートを始めず、走行中のゲートは止めて「未走」に。--budget と同じ三分類と未走の行を印字する。
#   短くて失敗を検出した実績のあるゲート〔FAILFAST_FIRST〕を先頭に回す。memguard に止められた FAIL は環境なので打ち切りの合図にしない。既定は従来どおり全件）
# 走行の状態は out/gates-status.json（GATES_STATUS で差し替え）に常に書く: phase（build / gates / retry / done / aborted）・走行中のゲート・済んだゲートの
# 終了コードと秒・done のとき結果の要約と終了コード。完了の検知は通知でなくこのファイルの phase で
#
# フェーズ:
#   1. 共有ビルド: `zig build`（stage1）→ scripts/stage2.sh（stage2 — 古ければ作り直す。bin/sober と共有）→ compiler/tools/* を主の sober（stage2）で並列に
#      ビルドして $SELFHOST_BIN へ（各 selfhost スクリプトは自分でビルドしない）。$SOBER = bin/sober（主の sober）・$STAGE1 = src/stage1/zig-out/bin/sober を export
#   2. toolcheck: compiler/tools/* を主の `sober check`（Sober の analyzer + 検査器）で検査（各 selfhost スクリプトの「tool 自身の check」をここに集める — SELFHOST_TOOLCHECKED=1）
#   3. ゲート: 長いものから並列に。ログは scripts/.gatecache/logs/<gate>.log、末尾に PASS / FAIL / SKIP と所要秒の一覧
# 差分スキップ（ゴールデン照合系astjson / loaderjson / corejson）: 入力（soberバイナリ・スクリプト・examples / testdata / std）の内容ハッシュが
# 前回の成功時と同じなら照合を飛ばして SKIP（キャッシュ = scripts/.gatecache/、gitignore 済み）
# 記録の再利用（ゲートの高速化タスクR1 — report-1221・既定on = report-1223 — M2の中身と並びのミューテーションの全ゲート一巡で宣言漏れ0を見てから）: ゲートごとの鍵
# （共通の成分 ‖ scripts/gatedeps.txt の宣言の内容ハッシュ — scripts/gatememo.ts）が前回の PASS の記録と同じなら走らせずに HIT（PASS とは別の状態・
# 記録のコミットと日時つき・@nondetの札は「非決定の札」のマーク）。MISSは最初にずれた成分を特定する。--no-cacheかSOBER_GATES_COLD=1で切れる
# （従来どおりの全走）。--memo は互換のため受け付ける（既定と同じ）
# 偽緑の検査（R2 — report-1222）: 抜き打ち = --memo の回ごとにHITから1本（記録の秒 ≤ 60・@nondetでない・最も長く検証していないもの）を走らせ、
# 赤ならFAIL（偽緑）。--verify = HITも全部走らせて、記録が緑なのに赤のものをFAILで特定（Jを変えた --verify で「JOBSは鍵に入れない」も確認する）。
# 宣言の網羅の主たる検査 = scripts/gatemut.sh（M2 — 節目の明示のインターフェース）・監査 = scripts/gateaudit.sh（strace — 開発時だけ）
set -uo pipefail
# mapのハッシュのシードを固定（既定は乱数 — 探査の長さが揺れて命令・cyclesが揺れる。出力はシードに依らない）
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
cd "$(dirname "$0")/.."
ROOT=$PWD
# ゴールデン = ワーカー1（協調形）の観測（段階6 P4-4 — 既定のワーカー数はコア数。M:Nはschedfuzz / seqparがSOBER_WORKERSを明示して掛ける。
# ゲートの中で例を並列に走らせるので、ワーカー数 × 同時数の過負荷も避ける）
export SOBER_WORKERS=1
# buildのキャッシュ（段階3 / 5 — 既定on）は切のパスに固定（stagesのinstの上限値・ゴールデン・計測が温の値に化けない。キャッシュの検査〔incrbuild等〕はSOBER_BUILD_CACHE=1を明示する）
export SOBER_BUILD_CACHE=${SOBER_BUILD_CACHE:-0}
export SOBER_CHECK_CACHE=${SOBER_CHECK_CACHE:-0}
# 答えの再生（check / buildの丸ごとの当たり）も切る — キャッシュの検査は関数単位の当否を見る。再生の検査（watchcheck・incrcheckのdefault相）は外して試す
export SOBER_CHECK_REPLAY=${SOBER_CHECK_REPLAY:-0}
# lowerの分割（席A — 既定はW ≥ 2で分割）は直のパスに固定（W8の上限値とゴールデンを動かさない。既定のパスの検査はselfparがオプションを外して試す）
export SOBER_LOWER_SPLIT=${SOBER_LOWER_SPLIT:-1}

GATES_ARGS="${*//\"/}"
mode=full
withzig=0
tags=()
G=8
J=
cache=1
memo=1
verify=0
BUDGET=
failfast=0
while [ $# -gt 0 ]; do
    case "$1" in
        --full) mode=full ;;
        --fast) mode=fast; shift; while [ $# -gt 0 ] && [ "${1#-}" = "$1" ]; do tags+=("$1"); shift; done; continue ;;
        --auto) mode=auto ;;
        --gate) mode=list; shift; while [ $# -gt 0 ] && [ "${1#-}" = "$1" ]; do tags+=("$1"); shift; done; continue ;;
        --all) mode=full; withzig=1 ;;
        -j) G=$2; shift ;;
        --jobs) J=$2; shift ;;
        --no-cache) cache=0 ;;
        --memo) memo=1 ;;
        --verify) memo=1; verify=1 ;;
        --budget) BUDGET=$2; shift ;;
        --fail-fast) failfast=1 ;;
        *) echo "gates: unknown argument $1"; exit 2 ;;
    esac
    shift
done
[ "${SOBER_GATES_COLD:-}" = 1 ] && cache=0
[ "$cache" = 1 ] || memo=0

# ゲート → タグ（どの変更で走らせるか）。all は --full だけ。range は範囲（--fast / --auto）だけで --full には入らない。zig は --all / --fast zig / src/ の変更（--auto）だけ — --full には入らない
# 凍結コーパスのZig ≡ Sober（selfhost_* — 入力はscripts/frozen/*.list）と、主のsoberの自己オラクル（stages・obs・hermetic・ゴールデン・Lean照合）が主線
# 退役: selfhost_desugar（脱糖器のZig ≡ Sober — F-17案2α で mut struct の束縛のコアの形と型が変わった。reaudit round 5。脱糖器は第3ゴールデン・Lean照合が見る）
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
    [checkpos]="load desugar check"
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
    [doubles]="load desugar analyzer lower backend"
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
    [vecchk]="lower backend"
    [mapfuse]="lower"
    [partinl]="lower"
    [docsync]="docs"
    [clidoc]="docs lower"
    [outline]="parse docs"
    [doclead]="docs"
    [benchsync]="docs"
    [confsync]="docs lower backend"
    [maprepr]="lower"
    [streq]="lower"
    [strix]="lower"
    [ubfstat]="lower"
    [framestat]="lower"
    [reqinst]="lower backend"
    [ringinst]="lower backend"
    [sortcheck]="lower backend"
    [matchlencheck]="lower backend"
    [jcleancheck]="lower backend"
    [flatecheck]="lower backend"
    [ctcheck]="lower backend analyzer"
    [cryptocheck]="lower backend"
    [tlsfsm]="lean lower backend"
    [iterregion]="lower backend"
    [rflowmeter]="lower backend"
    [llcheck]="lower backend"
    [fitcheck]="lower backend"
    [numpert]="all"
    [cacheaudit]="all"
    [incrbuild]="all"
    [incrmut]="all"
    [incrcheck_self]="check desugar load"
    [incrcheck_ex]="check desugar load"
    [watchcheck]="check desugar load"
    [testreplay]="all"
    [quickfuzz]="lower backend"
    [cover]="load lower backend"
    [mutate]="load lower backend"
    [guidetest]="load lower backend docs"
    [fnpkg]="load desugar lower backend"
    [modcheck]="load lower backend"
    [a1oracle]="desugar lower backend"
    [memcheck]="lower backend"
    [incrrace]="all"
    [fnhash]="all"
    [tyhash]="desugar lower"
    [tyorder]="desugar lower range"
    [iouring]="lower backend"
    [httpcheck]="lower backend"
    [pid1stop]="lower backend"
    [mdwecheck]="lower backend"
    [vaslot]="lower backend"
    [starve]="lower backend"
    [tschain]="lower backend"
    [fusecheck]="lower backend"
    [wincheck]="lower backend"
    [stackcheck]="lower backend"
    [areacheck]="lower backend"
    [pincheck]="lower backend"
    [selfpar]="check desugar load"
    [gatememo]="all"
    [axes]="all"
    [nextgen]="lower backend"
    [elfeq]="lex parse load desugar lower backend"
    [sobi]="lex parse fmt load desugar check"
    [refs]="lex parse load"
    [stdref]="docs"
    [rootsync]="docs"
    [tzsync]="docs"
    [datadce]="lower backend"
)
# 長いものから（並列の詰め順 — 2026-10-27にR1の実測の札で並べ直した: selfparの並列化〔R0〕で最長の札がincrbuild / leanbatch / hermeticの群に移った）。フェーズ3のキャッシュの検査4本（incrmut / incrbuild / incrrace / cacheaudit — 3〜4分ずつ）はstagesの直後に置く —
# 後ろに置くと最後に長い札が重なって --full の wall が伸びる（R3 の 766 s — report-1204 3 節）
# incrmut は単独で最長の札（冷の --full で 900 s 級）— 13 番目に置くと開始が 5 分近く遅れて臨界路になるので先頭に置く
ORDER=(incrmut zigtest incrbuild leanbatch hermetic implicitfreeze cachesplit selfhost_check stages nextgen elfeq incrrace iouring selfpar incrcheck_self incrcheck_ex watchcheck testreplay quickfuzz cover mutate guidetest fnpkg modcheck a1oracle memcheck errtrace typerdiff efftrace cachekey streq strix fitcheck numpert sobi obs cacheaudit tyorder selfhost_ll selfhost_e2e selfhost_lower selfhost_fmt selfhost_load toolcheck pkgcheck selfhost_parse io_args passes regionbound checkverdict checksplit checkpos panicmsg optdiff corejson irtext lltext llcheck astjson loaderjson selfhost_lex pool_oracle analyzer_neg secretdump effectsdump fixcheck uniqfreeze sobertest doubles jsonsuite unittest x86enc trapprobe seqpar lparcfg schedvec schedfuzz parbudget cutstat vecchk mapfuse partinl docsync clidoc outline doclead benchsync confsync maprepr ubfstat framestat reqinst ringinst sortcheck matchlencheck jcleancheck flatecheck ctcheck cryptocheck tlsfsm iterregion rflowmeter fnhash tyhash gatememo httpcheck starve tschain fusecheck wincheck stackcheck areacheck pincheck pid1stop mdwecheck vaslot refs stdref rootsync tzsync datadce corevec extract axes obs_zig hermetic_zig ir_roundtrip)

auto_tags() { # 変更ファイル → タグ（推定できない変更は all）
    local f
    git status --porcelain | cut -c4- | sed 's/.* -> //' | while IFS= read -r f; do
        case "$f" in
            src/stage1/*|build.zig|build.zig.zon) echo zig; echo all ;;
            bin/sober|scripts/stage2.sh|scripts/gatelib.sh|scripts/gates.sh|scripts/gatememo.*|scripts/gatedeps.txt) echo all ;;
            scripts/frozen/lex.list) echo lex ;;
            scripts/frozen/parse.list|scripts/frozen/parse-excluded.list) echo parse ;;
            scripts/frozen/fmt.list) echo fmt ;;
            scripts/frozen/load.list) echo load ;;
            scripts/frozen/entries.list) echo desugar; echo check; echo lower ;;
            scripts/frozen/lower.list) echo lower ;;
            scripts/ir_roundtrip.sh) echo zig ;;
            scripts/sobertest.sh|testdata/sobertest/*) echo load ;;
            scripts/a1oracle.sh|testdata/a1/*|src/compiler/tools/a1dump/*) echo desugar ;;
            scripts/doubles.sh|testdata/doubles/*|testdata/cells/*|testdata/cells.expect) echo load ;;
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
            scripts/selfhost_lower.sh|scripts/lparcfg.sh|scripts/lparcfg.ts|scripts/trapprobe.sh|testdata/trapprobe/*|scripts/seqpar.sh|scripts/seqpar.list|scripts/schedvec.sh|scripts/schedvec.ts|scripts/schedvec.list|scripts/schedfuzz.sh|scripts/schedfuzz.list|testdata/readyspill/*|scripts/parbudget.sh|testdata/parbudget/*|scripts/cutstat.sh|scripts/vecchk.sh|scripts/mapfuse.sh|scripts/partinl.sh|scripts/maprepr.sh|scripts/streq.sh|scripts/strix.sh|scripts/sortcheck.sh|scripts/matchlencheck.sh|testdata/matchlen/*|scripts/jcleancheck.sh|testdata/jclean/*|scripts/iterregion.sh|scripts/rflowmeter.sh|testdata/sortcheck/*|scripts/flatecheck.sh|testdata/flatecheck/*|scripts/ctcheck.sh|testdata/ctcheck/*|scripts/cryptocheck.sh|scripts/ubfstat.sh|scripts/ubfstat.list|scripts/framestat.sh|scripts/framestat.list|scripts/reqinst.sh|scripts/reqinst.ts|scripts/ringinst.sh|scripts/fitcheck.sh|scripts/numpert.sh|scripts/tyorder.sh|scripts/cacheaudit.sh|scripts/incrbuild.sh|scripts/incrmut.sh|scripts/incrrace.sh|scripts/iouring.sh|scripts/httpcheck.sh|testdata/httpcheck/*|scripts/pid1stop.*|testdata/pid1stop/*|scripts/mdwecheck.sh|testdata/mdwe/*|scripts/vaslot.sh|testdata/vaslot/*|scripts/starve.sh|testdata/starve/*|scripts/tschain.sh|testdata/delaylat/*|scripts/fusecheck.sh|scripts/wincheck.sh|scripts/stackcheck.*|scripts/areacheck.*|testdata/areacheck/*|scripts/pincheck.sh|testdata/pin/*|testdata/wincheck/*|testdata/cutstat/*|scripts/optdiff.sh|scripts/typerdiff.sh|scripts/irtext.sh|scripts/lltext.sh|scripts/llcheck.sh|scripts/selfhost_ll.sh|scripts/stages.sh|scripts/selfhost_cli.sh|scripts/passes.sh|scripts/regionbound.sh|scripts/memcheck.sh|testdata/memcheck/*) echo lower ;;
            scripts/checkverdict.sh|testdata/checkverdict/*) echo check; echo docs ;;
            scripts/checkpos.sh|scripts/checkpos.ts|scripts/incrcheck.sh|scripts/watchcheck.sh|testdata/watchcheck/*) echo check ;;
            scripts/refs.sh|scripts/alphacheck.sh|scripts/alphamap.ts|src/compiler/tools/refs/*|testdata/refs/*) echo load ;;
            scripts/stdref.sh|scripts/stdref/*|src/compiler/tools/docgen/*|testdata/stdref/*|docs/std/*) echo docs ;;
            scripts/rootsync.sh|scripts/rootstore.sh|scripts/nssroots.ts|testdata/x509/nss/*) echo docs ;;
            scripts/tzsync.sh|scripts/tzstore.sh|scripts/tzgen.ts|testdata/tz/*) echo docs ;;
            scripts/datadce.sh|testdata/datadce/*) echo lower; echo backend ;;
            scripts/clidoc.*|docs/cli/*|testdata/clidoc/*) echo docs ;;
            src/compiler/clidoc/*) echo docs; echo lower ;;
            scripts/outline.sh|testdata/outline/*|src/compiler/outline/*) echo parse ;;
            scripts/doclead.*) echo docs ;;
            lean/Main.lean|scripts/leanbatch.sh) echo lean ;;
            lean/FeatherweightSober/UniqFreeze.lean|scripts/uniqfreeze.sh|scripts/uniqfreeze.list) echo lean; echo analyzer ;;
            scripts/implicitfreeze.sh|scripts/implicitfreeze.ts) echo desugar; echo lower ;;
            lean/Extract/*|lean/ExtractMain.lean|lean/FeatherweightSober/TyVec.lean|scripts/extract.sh|lean/Extract/sober/*) echo lean ;;
            lean/FeatherweightSober/Tls.lean|scripts/tlsfsm.sh|testdata/tls/fsm.golden) echo lean ;;
            docs/conformance/*|scripts/confsync.*|scripts/confrecord.sh|testdata/conformance/*) echo docs ;;
            docs/guide/*|docs/spec/*|docs/design-notes/fast.md|docs/language.md|README.md|README.ja.md|scripts/docsync.*|bench/README.md|bench/data/*|scripts/benchsync.*|scripts/benchchart.ts|docs/assets/bench-*) echo docs ;;
            docs/*|*.md) ;;
            *) echo all ;;
        esac
    done | sort -u
}

if [ "$mode" = auto ]; then
    mapfile -t tags < <(auto_tags)
    if [ "${#tags[@]}" = 0 ]; then echo "gates: --auto: no gate-relevant change"; exit 0; fi
    for t in "${tags[@]}"; do
        [ "$t" = zig ] && withzig=1
        [ "$t" = all ] && mode=full
    done
    echo "gates: --auto → ${mode/auto/fast} ${tags[*]}"
    [ "$mode" = auto ] && mode=fast
fi
# 在籍の判定は連想配列で（pipefailの下の `printf | grep -q` はgrepが先に抜けるとprintfがSIGPIPEで落ち、名前で指定したゲートを黙って選ばない）
declare -A TAG=()
for t in "${tags[@]}"; do TAG[$t]=1; done
[ "$mode" = fast ] && [ -n "${TAG[all]:-}" ] && mode=full

sel=()
for g in "${ORDER[@]}"; do
    # --gate NAME…（名前で指定 — gatemut.sh / gateaudit.shのインターフェース）
    if [ "$mode" = list ]; then
        [ -n "${TAG[$g]:-}" ] && sel+=("$g")
        continue
    fi
    if [ "$mode" = full ]; then
        # rangeというマーク = 範囲の検査だけ（--fullには入れない — tyorder・report-1217 4.1 節）
        case " ${GTAG[$g]} " in *" range "*) continue ;; esac
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
T0=$(date +%s)
STATUS=${GATES_STATUS:-$ROOT/out/gates-status.json}
mkdir -p "$(dirname "$STATUS")" "$W/res" "$W/gpid" "$W/unrun"
status() { # $1 = phase、$2 = 結果の要約の JSON（done のときだけ）。済み = $W/res・走行中 = $W/gpid にあって res に無いもの・未走 = $W/unrun
    local tmpf="$STATUS.$BASHPID.tmp" g ec secs first=1 running=()
    [ -d "$W" ] || return 0   # gates が先に終わった（止められた）後に残りのゲートが書き戻さない
    for g in $(ls "$W/gpid" 2> /dev/null); do [ -f "$W/res/$g" ] || [ -f "$W/unrun/$g" ] || running+=("\"$g\""); done
    {
        printf '{"pid":%s,"started":%s,"updated":%s,"phase":"%s","args":"%s","budget":%s,"total":%s,"running":[%s],"done":{' \
            "$$" "$T0" "$(date +%s)" "$1" "$GATES_ARGS" "${BUDGET:-null}" "${#sel[@]}" "$(IFS=,; echo "${running[*]}")"
        for g in $(ls "$W/res" 2> /dev/null); do
            read -r ec secs < "$W/res/$g" 2> /dev/null || continue
            [ $first = 1 ] || printf ','
            first=0
            printf '"%s":{"ec":"%s","secs":%s}' "$g" "$ec" "${secs:-0}"
        done
        printf '},"unrun":[%s]' "$(ls "$W/unrun" 2> /dev/null | sed 's/.*/"&"/' | paste -sd,)"
        [ -n "${2:-}" ] && printf ',"result":%s' "$2"
        printf '}\n'
    } > "$tmpf" && mv -f "$tmpf" "$STATUS"
}
trap '[ "${STATUS_DONE:-0}" = 1 ] || status aborted; rm -rf "$W"' EXIT
status build

# ── 1. 共有ビルド ──
s=$(date +%s)
# GATES_PREBUILT=1: ビルドするフェーズ（zig build・stage2.sh・道具）を飛ばして、木にある成果物をそのまま使う — 成果物ごとコピーした木（scripts/gatemut.shのM2）のインターフェース。
# コピーはパスが違うので鮮度の確認が外れてブートストラップチェーンからビルドし直しになる（248 s）。成果物は元の木で鮮度を確認済み
prebuilt=${GATES_PREBUILT:-0}
: > "$LOGS/build.log"
if [ "$prebuilt" = 0 ] && ! (cd src/stage1 && zig build) > "$LOGS/build.log" 2>&1; then echo "gates: FAIL zig build (see $LOGS/build.log)"; exit 1; fi
STAGE1=$ROOT/src/stage1/zig-out/bin/sober
export STAGE1
if [ "$prebuilt" = 0 ] && ! scripts/stage2.sh --quiet >> "$LOGS/build.log" 2>&1; then echo "gates: FAIL scripts/stage2.sh (see $LOGS/build.log)"; exit 1; fi
grep -q 'stage2 rebuilt' "$LOGS/build.log" && s2note="stage2 rebuilt" || s2note="stage2 cached"
SOBER=$ROOT/bin/sober
export SOBER
export SOBER_CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
[ -x "$SOBER_CHECK" ] || { echo "gates: $SOBER_CHECK not found (cd lean && lake build)"; exit 1; }
# Leanの道具（sober-gen — tlsfsm・corevec・selfhost_check・extract／sober-extract — extract）はここで1回ビルドする。ゲートの中でビルドすると、
# 並走する2本の lake build が実行中の道具を書き直してETXTBSYになり、ビルドしないゲートは順序次第で道具が無い（新しいworktreeの最初の --full）
if [ "$prebuilt" = 0 ] && ! (cd lean && lake build sober-gen sober-extract) >> "$LOGS/build.log" 2>&1; then echo "gates: FAIL lake build sober-gen sober-extract (see $LOGS/build.log)"; exit 1; fi
export GATES_LEANTOOLS=1   # tlsfsm・extractは、これがあれば自分でビルドしない
# tool は sober バイナリ・compiler/・std/ の内容ハッシュが前回と同じなら前回のビルドを使う（scripts/.gatecache/bin）
source scripts/gatelib.sh
BIN=$CACHE/bin
tkey="$(rel_key "$STAGE1" "$ROOT/out/stage2/sober2" src/compiler src/std) o1=${SOBER_O1:-}"   # 道具は主のsober（stage2 + stage1の正規バックエンド）でビルドする
# SOBER_O1=1は -O1 の列: stage2を zig cc -O1（scripts/stage2.sh）、道具をstage2の .ll → zig cc -O1（bin/sober --via=ll）でビルドする
tvia=""
[ -n "${SOBER_O1:-}" ] && tvia=--via=ll
if [ "$prebuilt" = 1 ] && [ -f "$BIN/.key" ]; then
    tools_note="tools prebuilt"
elif [ "$cache" = 1 ] && [ -f "$BIN/.key" ] && [ "$(cat "$BIN/.key")" = "$tkey" ]; then
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
# stage2は上のbuildのフェーズで確認した — 以降のbin/soberの呼び出しは鮮度の確認を飛ばす（ゲートの間は木を変えない規律）
export SOBER_STAGE2_CHECKED=1
# IRの検証器はステージごとに（既定のbuildは最後に1回 — ステージで崩れたらどのステージかをgatesが特定する。仕上げのタスク）
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
    echo "$BASHPID" > "$W/gpid/$g"   # メモリの番人がプロセスからゲートを引くインターフェース
    status gates
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
        # G-e（3'' M3）: 小分けのcheck（`check --split`）の出力 ≡ 一括のゴールデン（testdata/checkverdict）。全数はcachesplitの冷の相（格納場所に書く小分け）が覆うので、
        # ここは格納場所なしの小分けのパスの抜き取り
        checksplit) CV_SAMPLE=eighth scripts/checkverdict.sh --split > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        selfhost_check) scripts/selfhost_check.sh --fast > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        # corevec v2: golden の一致 + 被覆ラチェット + 全数を sober-check のバッチ経路で照合
        corevec) scripts/corevec.sh --binary > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        hermetic) scripts/hermetic.sh --stage2 > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        hermetic_zig) scripts/hermetic.sh $(zig_frozen) testdata/pkgdemo/app testdata/errpkg/app testdata/iface/app > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        ir_roundtrip) scripts/ir_roundtrip.sh $(zig_frozen | grep -v /) > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        # obs_zig は凍結コーパスの .out 持ちだけ（凍結後の例は stage1 の範囲外の言語で書かれうる — 正規バックエンド列の到達リスト化と同じ筋。決定 2026-09-29）
        obs_zig) SOBER=$STAGE1 scripts/obs.sh $(zig_frozen) > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        benchsync) scripts/benchsync.sh --check > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        confsync) scripts/confsync.sh --check > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        # リネーム道具（report-883）: loadcheck + 負例の期待 TSV + 仮決め名の未分類 0
        refs) scripts/refs.sh --selftest > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        # 段階2 R2（report-1191）: 関数ごとの成果物のハッシュのstrayの検査（W1 ≡ W8・別パス・panic-add・lambda-add）。numpertと同じく --full だけ（GTAGに無い）
        fnhash) scripts/rebuildbench.sh --fnhash > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        tyhash) scripts/rebuildbench.sh --tyhash > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        # incrcheckを2ゲートに切り分ける（report-1280 — 自己のブートストラップチェーンと例題の4相は格納場所が別で独立: 並走・例題だけの編集でブートストラップチェーンがHIT）
        incrcheck_self) scripts/incrcheck.sh --self > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        incrcheck_ex) scripts/incrcheck.sh --ex > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        *) "scripts/$g.sh" > "$LOGS/$g.log" 2>&1 || ec=$? ;;
    esac
    if [ -f "$W/memguard/$g" ]; then cat "$W/memguard/$g" >> "$LOGS/$g.log"; [ "$ec" = 0 ] && ec=137; fi
    echo "$ec $(( $(date +%s) - s ))" > "$W/res/$g"
    status gates
    # --fail-fast: 最初のFAIL（memguardの止めを除く）で $W/expiredを立て、走行中の他のゲートを「未走」に記して止める（--budgetと同じインターフェース）
    if [ "$failfast" = 1 ] && [ "$ec" != 0 ] && [ ! -f "$W/memguard/$g" ] && mkdir "$W/stopped" 2> /dev/null; then
        echo "$g" > "$W/stopped/by"
        : > "$W/expired"
        local o
        for o in $(ls "$W/gpid"); do
            [ "$o" = "$g" ] || [ -f "$W/res/$o" ] && continue
            : > "$W/unrun/$o"
            kill_tree "$(cat "$W/gpid/$o")"
        done
    fi
    # CPU秒（待った子孫のuser + sys — bashのtimesの2行目）。wallのゲート秒は並走で膨らむので、削るターゲットはCPU秒で選ぶ
    # （times は組み込みのままファイルへ — パイプや $(…) の子では子自身の値になる）
    times > "$W/cpu/$g.raw"
    awk 'NR == 2 { t = 0; for (i = 1; i <= 2; i++) { split($i, a, "m"); t += a[1] * 60 + a[2] } printf "%d\n", t + 0.5 }' "$W/cpu/$g.raw" > "$W/cpu/$g"
}
mkdir -p "$W/res" "$W/cpu"
run=("${sel[@]}")
memonote=""
if [ "$memo" = 1 ]; then
    # 鍵はゲートを走らせる前に計算する（木はゲートの間は変えない規律）。HIT のゲートは結果のファイルを HIT で書いて飛ばす
    s=$(date +%s)
    if GATEMEMO_TKEY="$tkey" NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts check "${sel[@]}" > "$W/memo" 2> "$LOGS/gatememo-check.log"; then
        run=()
        hits=()
        for g in "${sel[@]}"; do
            line=$(grep -m1 "^[A-Z]* $g " "$W/memo")
            case "$line" in
                "HIT $g "*) echo "$line" > "$LOGS/$g.hit"; hits+=("$g") ;;
                *) run+=("$g"); echo "${line:-MISS $g (no line)}" >> "$LOGS/memo-miss.log" ;;
            esac
        done
        # 検証するHIT（--verifyは全部・既定は抜き打ちの1本）— 走らせて、赤なら偽緑としてFAIL
        checkhit=()
        if [ "$verify" = 1 ]; then
            checkhit=("${hits[@]}")
        elif [ "${#hits[@]}" -gt 0 ]; then
            spot=$(NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts pick 60 "${hits[@]}")
            [ -n "$spot" ] && checkhit=("$spot")
        fi
        declare -A CHK=()
        for g in "${checkhit[@]}"; do CHK[$g]=1; done
        for g in "${hits[@]}"; do
            if [ -n "${CHK[$g]:-}" ]; then
                run+=("$g")
            else
                cp "$LOGS/$g.hit" "$LOGS/$g.log"; echo "hit 0" > "$W/res/$g"
            fi
        done
        memonote="memo: $(( ${#hits[@]} - ${#checkhit[@]} )) hit / ${#run[@]} run (${#checkhit[@]} of them HIT re-run: ${checkhit[*]:-none}) ($(( $(date +%s) - s ))s — misses in scripts/.gatecache/logs/memo-miss.log)"
    else
        memonote="memo: check failed — all gates run (see $LOGS/gatememo-check.log)"
    fi
    echo "gates: $memonote"
fi
# 宣言なき軸のしきい値（report-1282 / 1283）: 前回の記録の秒（summaryのwallの前回比）・メモリの床の記録と番人
[ "$memo" = 1 ] && NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts last "${run[@]}" > "$W/last" 2> /dev/null
mkdir -p "$W/gpid" "$W/memguard" "$W/peak"
GUARD_MB=${GATES_MEMGUARD_MB:-1024}
memguard() { # 5 秒ごとに available を記録（$W/mem）。床 GUARD_MB を割ったら gates の子孫（自分の子孫は除く）で RSS 最大のプロセスを止め、
    # それを抱えるゲートをFAILにする（$W/memguard/<gate> — run_gateが読む）。gatesの子孫以外には手を出さない（PIDを直接指定するだけ）。
    # GATES_MEMGUARD_FAKE=<gate> = 床と無関係にそのゲートの最大のプロセスを1回だけ止める（自動補走の検査のインターフェース）
    local a t victim want fake=${GATES_MEMGUARD_FAKE:-}
    while :; do
        a=$(awk '/^MemAvailable:/ { print int($2 / 1024) }' /proc/meminfo)
        t=$(( $(date +%s) - T0 ))
        echo "$t $a" >> "$W/mem"
        # ゲートごとのメモリ（プロセスの木の RSS の和 — 共有のページは二重に数えるので多めに出る）のピークを $W/peak/<gate> に（A5 の材料・判定には使わない）
        ps -eo pid=,ppid=,rss= | awk -v root=$$ -v me=$BASHPID -v gdir="$W/gpid" '
            { pp[$1] = $2; rss[$1] = $3 }
            END {
                while ((("ls " gdir) | getline g) > 0) { getline gp < (gdir "/" g); gate[gp] = g }
                for (p in pp) {
                    q = p; gn = ""; under = 0; mine = 0
                    while (q != "" && q != 0 && q != 1) { if (q == me) mine = 1; if (gn == "" && (q in gate)) gn = gate[q]; if (q == root) { under = 1; break }; q = pp[q] }
                    if (under && !mine && gn != "") sum[gn] += rss[p]
                }
                for (g in sum) print g, int(sum[g] / 1024)
            }' | while read -r pg pm; do
                [ -f "$W/peak/$pg" ] && [ "$(cat "$W/peak/$pg")" -ge "$pm" ] || echo "$pm" > "$W/peak/$pg"
            done
        want=""
        if [ "$a" -lt "$GUARD_MB" ]; then want=any
        elif [ -n "$fake" ] && [ -f "$W/gpid/$fake" ] && [ ! -e "$W/memguard.faked" ]; then want=$fake
        fi
        if [ -n "$want" ]; then
            victim=$(ps -eo pid=,ppid=,rss=,comm= | awk -v root=$$ -v me=$BASHPID -v gdir="$W/gpid" -v want="$want" '
                { pp[$1] = $2; rss[$1] = $3; cm[$1] = $4 }
                END {
                    while ((("ls " gdir) | getline g) > 0) { getline gp < (gdir "/" g); gate[gp] = g }
                    for (p in pp) {
                        q = p; under = 0; mine = 0; gn = ""
                        while (q != "" && q != 0 && q != 1) { if (q == me) mine = 1; if (gn == "" && (q in gate)) gn = gate[q]; if (q == root) { under = 1; break } ; q = pp[q] }
                        if (under && !mine && p != root && gn != "" && (want == "any" || gn == want) && !(p in gate) && rss[p] > best) { best = rss[p]; bp = p; bg = gn }
                    }
                    if (bp != "") print bp, bg, best, cm[bp]
                }')
            if [ -n "$victim" ]; then
                read -r vp vg vr vc <<< "$victim"
                kill -9 "$vp" 2> /dev/null
                [ "$want" = any ] || { : > "$W/memguard.faked"; a="$a (fake)"; }
                echo "FAIL: memguard: killed $vp ($vc) rss=$(( vr / 1024 )) MB in gate $vg — available ${a} MB < ${GUARD_MB} MB at +${t}s" >> "$W/memguard/$vg"
                sleep 5
            fi
        fi
        sleep 5
    done
}
memguard &
GUARD_PID=$!
# 予算（--budget S）: 起動から S 秒で $W/expired を立て、走行中のゲートを「未走」に記してからプロセスの木ごと止める（結果は書かせない）
kill_tree() { # $1 = PID。子孫から先に止める
    local c
    for c in $(ps -o pid= --ppid "$1" 2> /dev/null); do kill_tree "$c"; done
    kill -9 "$1" 2> /dev/null
}
expired() { [ -e "$W/expired" ]; }
BUDGET_PID=
if [ -n "$BUDGET" ]; then
    (
        sleep $(( T0 + BUDGET - $(date +%s) > 0 ? T0 + BUDGET - $(date +%s) : 0 ))
        : > "$W/expired"
        for g in $(ls "$W/gpid"); do
            [ -f "$W/res/$g" ] && continue
            : > "$W/unrun/$g"
            kill_tree "$(cat "$W/gpid/$g")"
        done
    ) &
    BUDGET_PID=$!
    disown "$BUDGET_PID"
fi
# --fail-fast: 短くて失敗を検出した実績のあるゲート（report-gt-0 — P7 を止めた ctcheck・areacheck・cacheaudit など）を先頭へ。残りは従来の順
FAILFAST_FIRST=(gatememo loaderjson memcheck ctcheck secretdump areacheck cacheaudit)
if [ "$failfast" = 1 ]; then
    ff=()
    for g in "${FAILFAST_FIRST[@]}"; do case " ${run[*]} " in *" $g "*) ff+=("$g") ;; esac; done
    for g in "${run[@]}"; do case " ${FAILFAST_FIRST[*]} " in *" $g "*) ;; *) ff+=("$g") ;; esac; done
    run=("${ff[@]}")
fi
for g in "${run[@]}"; do
    while [ "$(jobs -rp | wc -l)" -ge "$((G + 1))" ]; do wait -n || true; done
    if expired; then : > "$W/unrun/$g"; continue; fi
    run_gate "$g" &
done
while [ "$(jobs -rp | grep -vx "$GUARD_PID" | wc -l)" -gt 0 ]; do wait -n || true; done
# 自動補走: memguard に止められたゲートは、他のゲートが全部終わってから available が GATES_RETRY_MB（既定 = 物理メモリの半分）に
# 戻るのを待って（最長 GATES_RETRY_WAIT 秒）1 本ずつ単独でもう 1 回だけ走らせる。補走の判定がそのゲートの結果
# （補走でも止められたら FAIL のまま・最初の走りのログは <gate>.log.memguard に残す）
RETRY_MB=${GATES_RETRY_MB:-$(awk '/^MemTotal:/ { print int($2 / 1024 / 2) }' /proc/meminfo)}
retried=()
status retry
for g in "${run[@]}"; do
    [ -f "$W/memguard/$g" ] || continue
    if expired; then : > "$W/unrun/$g"; rm -f "$W/res/$g"; continue; fi
    mv "$W/memguard/$g" "$W/memguard/$g.first"
    cp "$LOGS/$g.log" "$LOGS/$g.log.memguard"
    rs=$(date +%s)
    while a=$(awk '/^MemAvailable:/ { print int($2 / 1024) }' /proc/meminfo); [ "$a" -lt "$RETRY_MB" ] && [ $(( $(date +%s) - rs )) -lt "${GATES_RETRY_WAIT:-300}" ]; do sleep 5; done
    echo "gates: retry $g alone (memguard killed it: $(cut -d" " -f3-7 "$W/memguard/$g.first" | head -1); available ${a} MB)"
    run_gate "$g"
    retried+=("$g")
    {
        echo "retry: memguard killed the first run (log: $g.log.memguard) — re-ran alone with ${a} MB available"
        sed 's/^FAIL: memguard:/memguard (first run):/' "$W/memguard/$g.first"
        cat "$LOGS/$g.log"
    } > "$LOGS/$g.log.tmp" && mv "$LOGS/$g.log.tmp" "$LOGS/$g.log"
done
kill "$GUARD_PID" 2> /dev/null
wait "$GUARD_PID" 2> /dev/null || true
[ -n "$BUDGET_PID" ] && kill_tree "$BUDGET_PID"
rm -f "$STATUS".*.tmp
# 記録は PASS だけ（環境の SKIP を含むログは gatememo.ts が断る）
if [ "$memo" = 1 ]; then
    for g in "${run[@]}"; do
        [ -f "$W/res/$g" ] || continue
        read -r ec secs < "$W/res/$g"
        [ "$ec" = 0 ] && NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts record "$g" "$secs" "$LOGS/$g.log" >> "$LOGS/gatememo-record.log" 2>&1
        if [ -f "$LOGS/$g.hit" ]; then
            if [ "$ec" = 0 ]; then
                NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts verified "$g"
            else
                echo "FAIL: false green — gatememo had a passing record for this key ($(cut -d' ' -f3-5 "$LOGS/$g.hit")) but the re-run failed: an input is missing from the key (scripts/gatedeps.txt)" >> "$LOGS/$g.log"
            fi
        fi
    done
fi

# ── サマリ ──
fails=0
unrun=()
echo "gates: summary (wall $(( $(date +%s) - T0 ))s, -j $G --jobs $J, logs in scripts/.gatecache/logs/)"
[ -z "$memonote" ] || echo "gates: $memonote"
for g in "${sel[@]}"; do
    # 結果のファイルが無い（走らず HIT でもない）= FAIL — 表示のない緑を作らない
    ec=none secs=0
    if [ -f "$W/unrun/$g" ]; then
        unrun+=("$g")
        if [ -f "$W/stopped/by" ]; then why="fail-fast: stopped after $(cat "$W/stopped/by") failed"; else why="budget ${BUDGET}s expired before it finished"; fi
        printf '  %-4s %-17s %4ss  %s\n' UNRN "$g" - "$why"
        continue
    fi
    [ -f "$W/res/$g" ] && read -r ec secs < "$W/res/$g"
    if [ "$ec" = hit ]; then
        # HIT の行 = 鍵の頭・記録のコミット・日時・[非決定の札]・| 記録の最後の行
        printf '  %-4s %-17s %4ss  %s\n' HIT "$g" - "$(cut -d' ' -f3- "$LOGS/$g.log" | cut -c1-140)"
        continue
    fi
    if [ "$g" = zigtest ]; then
        last=$(grep -m1 'Build Summary' "$LOGS/$g.log" | cut -c1-110)
    else
        last=$(grep -v '^ok' "$LOGS/$g.log" 2> /dev/null | grep -v '^[[:space:]]*$' | tail -n 1 | cut -c1-110)
    fi
    if [ "$ec" != 0 ] && [ -f "$LOGS/$g.hit" ]; then st=FAIL; fails=$((fails + 1)); last="偽緑 — $last"
    elif [ "$ec" != 0 ]; then st=FAIL; fails=$((fails + 1)); elif grep -q '^SKIP' "$LOGS/$g.log"; then st=SKIP; else st=PASS; fi
    case " ${retried[*]} " in *" $g "*)
        if [ "$ec" = 0 ]; then last="(retried after memguard — PASS alone) $last"; else last="(memguard killed it again when run alone — environment: not enough memory) $last"; fi ;; esac
    printf '  %-4s %-17s %4ss  %s\n' "$st" "$g" "$secs" "$last"
done
# 揺れる軸（WARN — FAILにしない・2026-10-04の決定〔wallは時間帯で揺れる〕）: ゲート秒の和・wallの前回比（×1.3かつ +60 s）・メモリの床（< 4 GB）
gsum=0
for g in "${sel[@]}"; do
    [ -f "$W/res/$g" ] || continue
    read -r ec secs < "$W/res/$g"
    [ "$ec" = hit ] && continue
    gsum=$((gsum + secs))
    if [ -f "$W/last" ] && read -r _ ls lc < <(grep -m1 "^$g " "$W/last"); then
        if [ "$secs" -ge $((ls + 60)) ] && [ $((secs * 10)) -ge $((ls * 13)) ]; then
            echo "  WARN wall $g ${secs}s (×$(awk -v a="$secs" -v b="$ls" 'BEGIN { printf "%.2f", a / b }') vs ${ls}s @$lc)"
        fi
    fi
done
echo "gates: gate-seconds ${gsum}s (run gates only — /${G} = $((gsum / G))s)"
# CPU 秒の和と上位（表は logs/cpu.tsv — ゲート・CPU 秒・wall 秒）
: > "$LOGS/cpu.tsv"
for g in "${sel[@]}"; do
    [ -f "$W/cpu/$g" ] || continue
    read -r ec secs < "$W/res/$g"
    printf '%s\t%s\t%s\n' "$g" "$(cat "$W/cpu/$g")" "$secs" >> "$LOGS/cpu.tsv"
done
if [ -s "$LOGS/cpu.tsv" ]; then
    csum=$(awk -F'\t' '{ t += $2 } END { print t + 0 }' "$LOGS/cpu.tsv")
    echo "gates: cpu-seconds ${csum}s (user + sys of run gates — /${G} = $((csum / G))s)"
    echo "gates: cpu top: $(sort -t$'\t' -k2 -rn "$LOGS/cpu.tsv" | head -10 | awk -F'\t' '{ printf "%s%s %ds", (NR > 1 ? " · " : ""), $1, $2 }')"
fi
# ゲートごとのメモリのピーク（5 秒ごとの標本 — 表は logs/mem.tsv・履歴は scripts/.gatecache/memhist.tsv にゲートごとの直近 5 回）
: > "$LOGS/mem.tsv"
for g in $(ls "$W/peak" 2> /dev/null); do printf '%s\t%s\n' "$g" "$(cat "$W/peak/$g")" >> "$LOGS/mem.tsv"; done
if [ -s "$LOGS/mem.tsv" ]; then
    echo "gates: mem top (peak RSS of the gate's processes, MB): $(sort -t$'\t' -k2 -rn "$LOGS/mem.tsv" | head -10 | awk -F'\t' '{ printf "%s%s %d", (NR > 1 ? " · " : ""), $1, $2 }')"
    { cat "$CACHE/memhist.tsv" 2> /dev/null; awk -F'\t' -v t="$T0" '{ print t "\t" $1 "\t" $2 }' "$LOGS/mem.tsv"; } |
        sort -t$'\t' -k2,2 -k1,1rn | awk -F'\t' '++n[$2] <= 5' > "$CACHE/memhist.tsv.tmp" && mv "$CACHE/memhist.tsv.tmp" "$CACHE/memhist.tsv"
fi
if [ -s "$W/mem" ]; then
    read -r ft fa < <(sort -k2 -n "$W/mem" | head -1)
    echo "gates: mem floor ${fa} MB available at +${ft}s"
    [ "$fa" -lt 4096 ] && echo "  WARN mem floor ${fa} MB < 4096 MB"
fi
npass=0 nhit=0 nskip=0
for g in "${sel[@]}"; do
    [ -f "$W/res/$g" ] && [ ! -f "$W/unrun/$g" ] || continue
    read -r ec secs < "$W/res/$g"
    if [ "$ec" = hit ]; then nhit=$((nhit + 1)); elif [ "$ec" = 0 ]; then
        if grep -q '^SKIP' "$LOGS/$g.log"; then nskip=$((nskip + 1)); else npass=$((npass + 1)); fi
    fi
done
if [ "${#unrun[@]}" -gt 0 ]; then
    if [ -f "$W/stopped/by" ]; then stopnote="fail-fast (stopped after $(cat "$W/stopped/by") failed)"; else stopnote="budget ${BUDGET}s"; fi
    echo "gates: $stopnote — PASS $npass · HIT $nhit · SKIP $nskip · FAIL $fails · UNRUN ${#unrun[@]}"
    echo "gates: unrun: scripts/gates.sh --gate ${unrun[*]}"
fi
STATUS_DONE=1
ex=0
if [ "$fails" = 0 ] && [ "${#unrun[@]}" = 0 ]; then echo "gates: ALL PASS"
elif [ "$fails" = 0 ]; then echo "gates: NO FAIL (${#unrun[@]} unrun — budget)"; ex=3
else echo "gates: $fails FAILED"; ex=1
fi
status done "$(printf '{"exit":%s,"pass":%s,"hit":%s,"skip":%s,"fail":%s,"unrun":%s,"wall":%s}' "$ex" "$npass" "$nhit" "$nskip" "$fails" "${#unrun[@]}" "$(( $(date +%s) - T0 ))")"
exit "$ex"
