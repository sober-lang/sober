#!/usr/bin/env bash
# 常備ゲートの一括実行（ビルドは 1 回だけ・独立なゲートは並列・変更範囲で絞れる）。各ゲートの本体は既存の scripts/*.sh のまま（ここは呼ぶだけ）。
#
# チェックレベル（数字が大きいほど網が細かい・gatedeps.txt の置き場所の表と一対一）:
#   --level 1  変更の検証（枝の組 = branch）: 枝の変更だけで値が決まる保証。枝の取り込みの前の契約
#   --level 2  合成の検証（列車の組 = train・--from=<基点>:<枝の先端>,… が要る）: 合成で初めて値が決まる保証（@place train）を走らせ、レベル1の結果は持ち越す。push前
#   --level 3  包括の網（夜 = nightly）: 全部を冷で（@place nightly を含む）。実行時間の線の FAIL はここから。1日1回
#   --level 4  リリース（release）: レベル3 + タグ release のゲート。冷
#   旧名（移行の別名 — 警告を1行出す）: --full = --level 1・--carry=<引数> = --level 2 --from=<引数>・--nightly = --level 3・--release = --level 4
#
#   scripts/gates.sh                 = --level 1
#   scripts/gates.sh --level 1       枝の組: 全ゲートから、タグ zig の Zig 単体のゲート（主役交代 R39: src/ は凍結）と、置き場所の表（gatedeps.txt の @place）で
#                                    train・nightly に置いたゲートを除く。枝の取り込みの前の契約（contractok.sh）
#   scripts/gates.sh --level 2 --from=<基点>:<枝の先端>,…   列車の組（push前）: 枝の組 + @place train。枝の組は scripts/carry.ts の条件の下で枝の全件の結果を持ち越し（CARRY・
#                                    抜き打ちで1本だけ走らせる）、@place train だけを走らせる。条件が崩れたら全部を走らせる。契約 = contractok.sh --from=…
#   scripts/gates.sh --level 4      リリースの組: レベル3の全部 + タグ release のゲート（取り込みのたびのレベル1から外した検査 — splitcache・cachekey）。
#                                    記録の再利用は切る（--no-cache と同じ）。結果は記録の表（下の「実行の記録」）に残り、scripts/releaseok.sh が公開の同期の前に読む
#   scripts/gates.sh --level 3      夜の冷の全件: レベル1の組に置き場所の表の train・nightly の札のゲートを足した全部（持ち越しの外れの見張りと、日中に確かめないゲート）・記録の再利用は切る。実行時間の線（下の「実行時間の線」）を FAIL で見る（レベル4も同じ）。
#                                    ほかの組（レベル1・2・--part）では、実行時間の線は WARN と記録だけ（並走の負荷で wall が ×1.35〜2.27 に膨らむため）
#   scripts/gates.sh --level 1 --part i/N   選んだゲートを決まった形で N 個に割り、i 番目だけを回す（取り込みの前の検査 = 契約。.pair/tools/gqfull.sh が
#                                    記録の再利用ありで part を順に並べ、scripts/contractok.sh が実行の記録から全 part の ALL PASS を確かめる）。割り方は ORDER（長い順）を
#                                    往復の順（1..N, N..1, 1..N …）で配る — 時間の記録に依らないので、どの機械でも同じ割り方になる
#   scripts/gates.sh --list ...      選んだゲート（--part があれば割った後）の名前を1行ずつ出して、回さずに終わる
#   scripts/gates.sh --all           全ゲート + タグ zig（src/ を触ったとき）+ stages の重い照合（STAGES_RAW — 掛けた / 掛けないの check の経路の道具の出力 — scripts/rawcheck.sh）
#   scripts/gates.sh --fast TAG...   タグに関係するゲートだけ（タグ: lex parse fmt load desugar check lower backend lean zig all — 下の表）
#   scripts/gates.sh --gate NAME...  名前で指定したゲートだけ（M2のscripts/gatemut.sh・監査のscripts/gateaudit.shが使う）
#   scripts/gates.sh --auto          作業木の変更ファイル（git status）からタグを推定（推定できない変更があれば --level 1、src/ の変更は --all）
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
#      （FAIL のログは scripts/.gatecache/failed/<gate>.<日時>.<pid>.log にも写す — 次の実行で消えない。ゲートごとに新しい5本）
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
# HTTPのDateの時計を固定（例の.outとゴールデンに今の時刻が入る。値はRFC 9110の例の時刻。httpcheckは外して実の時計で見る）
export SOBER_DATE_SEC=${SOBER_DATE_SEC:-784111777}
# 文字の並び順と分類を固定（sort・ugrepの結果がロケールで変わり、ゴールデンを比べるゲートがen_US.UTF-8の環境で落ちる）。外から渡された値も上書きする
export LC_ALL=C.UTF-8
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
part=
listonly=0
nightly=0
carry=
level=
while [ $# -gt 0 ]; do
    case "$1" in
        --level) level=$2; shift ;;
        --level=*) level=${1#--level=} ;;
        --from=*) carry=${1#--from=} ;;
        --full) level=1; echo "gates: --full は --level 1 の旧名（移行の別名）" >&2 ;;
        --fast) mode=fast; shift; while [ $# -gt 0 ] && [ "${1#-}" = "$1" ]; do tags+=("$1"); shift; done; continue ;;
        --auto) mode=auto ;;
        --gate) mode=list; shift; while [ $# -gt 0 ] && [ "${1#-}" = "$1" ]; do tags+=("$1"); shift; done; continue ;;
        --all) mode=full; withzig=1 ;;
        --release) level=4; echo "gates: --release は --level 4 の旧名（移行の別名）" >&2 ;;
        --nightly) level=3; echo "gates: --nightly は --level 3 の旧名（移行の別名）" >&2 ;;
        --carry=*) level=2; carry=${1#--carry=}; echo "gates: --carry=<引数> は --level 2 --from=<引数> の旧名（移行の別名）" >&2 ;;
        -j) G=$2; shift ;;
        --jobs) J=$2; shift ;;
        --no-cache) cache=0 ;;
        --memo) memo=1 ;;
        --verify) memo=1; verify=1 ;;
        --budget) BUDGET=$2; shift ;;
        --fail-fast) failfast=1 ;;
        --part) part=$2; shift ;;
        --list) listonly=1 ;;
        *) echo "gates: unknown argument $1"; exit 2 ;;
    esac
    shift
done
# チェックレベル → 組。--gate と並べたときは名前で選んだゲートのまま、そのレベルの判定（冷・実行時間の線）だけを掛ける
case "$level" in
    "") ;;
    1) [ "$mode" = list ] || mode=full ;;
    2) [ "$mode" = list ] || mode=train
       [ -n "$carry" ] || { echo "gates: --level 2 には --from=<基点>:<枝の先端>,… が要る（レベル1の結果を持ち越す枝）"; exit 2; } ;;
    3) [ "$mode" = list ] || mode=full; nightly=1; cache=0 ;;
    4) [ "$mode" = list ] || mode=release; cache=0 ;;
    *) echo "gates: --level は 1〜4（1 = 変更の検証・2 = 合成の検証・3 = 包括の網・4 = リリース）"; exit 2 ;;
esac
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
    [cachekey]="load desugar check release"
    [panicmsg]="lower backend"
    [optdiff]="lower backend"
    [cachesplit]="load desugar check analyzer"
    [pkgfin]="load"
    [splitcache]="load desugar check release"
    [stages]="lex parse load desugar check lower backend"
    [corevec]="lean check"
    [kindwit]="desugar check lean"
    [kindbuild]="desugar check lower"
    [kindexpand]="desugar check lean"
    [writeform]="desugar check"
    [kindinfer]="desugar check lean"
    [genmono]="lower"
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
    [xpar]="lower backend"
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
    [keepcheck]="lower backend"
    [jcleancheck]="lower backend"
    [jsonmark]="lower backend load"
    [flatecheck]="lower backend"
    [ctcheck]="lower backend analyzer"
    [cryptocheck]="lower backend"
    [tlsfsm]="lean lower backend"
    [tlsfuzz]="lower backend"
    [tls12interop]="lower backend"
    [h2spec]="lower backend"
    [iterregion]="lower backend"
    [rflowmeter]="lower backend"
    [llcheck]="lower backend"
    [fitcheck]="lower backend"
    [profcov]="lower backend"
    [numpert]="all"
    [cacheaudit]="all"
    [incrbuild_self]="all"
    [incrbuild_ex]="all"
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
    [fdcap]="lower backend"
    [mapcap]="lower backend"
    [parkres]="lower backend"
    [acceptretry]="lower backend"
    [slowcheck]="lower backend"
    [signprobe]="lower backend"
    [pid1stop]="lower backend"
    [logcheck]="lower backend"
    [mdwecheck]="lower backend"
    [vaslot]="lower backend"
    [starve]="lower backend"
    [tschain]="lower backend"
    [fusecheck]="lower backend"
    [wincheck]="lower backend"
    [stackcheck]="lower backend"
    [segvcheck]="lower backend"
    [areacheck]="lower backend"
    [pincheck]="lower backend"
    [oversub]="lower backend"
    [laypin]="lower backend"
    [selfpar]="check desugar load"
    [gatememo]="all"
    [gateenv]="all"
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
ORDER=(incrmut zigtest incrbuild_self incrbuild_ex leanbatch hermetic implicitfreeze cachesplit pkgfin splitcache selfhost_check stages nextgen elfeq incrrace iouring selfpar xpar incrcheck_self incrcheck_ex watchcheck testreplay quickfuzz cover mutate guidetest fnpkg modcheck a1oracle memcheck errtrace typerdiff efftrace cachekey streq strix fitcheck profcov numpert sobi obs cacheaudit tyorder selfhost_ll selfhost_e2e selfhost_lower selfhost_fmt selfhost_load toolcheck pkgcheck selfhost_parse io_args passes regionbound checkverdict checksplit checkpos panicmsg optdiff corejson irtext lltext llcheck astjson loaderjson selfhost_lex pool_oracle analyzer_neg secretdump effectsdump fixcheck uniqfreeze sobertest doubles jsonsuite unittest x86enc trapprobe seqpar lparcfg schedvec schedfuzz parbudget cutstat vecchk mapfuse partinl docsync clidoc outline doclead benchsync confsync maprepr ubfstat framestat reqinst ringinst sortcheck matchlencheck keepcheck jcleancheck jsonmark flatecheck ctcheck cryptocheck tlsfsm tlsfuzz tls12interop h2spec iterregion rflowmeter fnhash tyhash gatememo gateenv httpcheck fdcap mapcap parkres acceptretry slowcheck signprobe starve tschain fusecheck wincheck stackcheck segvcheck areacheck pincheck oversub laypin pid1stop logcheck mdwecheck vaslot refs stdref rootsync tzsync datadce corevec kindwit kindbuild kindexpand kindinfer writeform genmono extract axes obs_zig hermetic_zig ir_roundtrip)

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
            scripts/pkgfin.sh) echo load ;;
            scripts/a1oracle.sh|testdata/a1/*|src/compiler/tools/a1dump/*) echo desugar ;;
            scripts/doubles.sh|testdata/doubles/*|testdata/cells/*|testdata/cells.expect|testdata/celldie/*) echo load ;;
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
            scripts/nextgen.sh|scripts/xpar.sh) echo lower ;;
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
            scripts/selfhost_lower.sh|scripts/lparcfg.sh|scripts/lparcfg.ts|scripts/trapprobe.sh|testdata/trapprobe/*|scripts/seqpar.sh|scripts/seqpar.list|scripts/schedvec.sh|scripts/schedvec.ts|scripts/schedvec.list|scripts/schedfuzz.sh|scripts/schedfuzz.list|testdata/readyspill/*|scripts/parbudget.sh|testdata/parbudget/*|scripts/cutstat.sh|scripts/vecchk.sh|scripts/mapfuse.sh|scripts/partinl.sh|scripts/maprepr.sh|scripts/streq.sh|scripts/strix.sh|scripts/sortcheck.sh|scripts/matchlencheck.sh|testdata/matchlen/*|scripts/keepcheck.sh|testdata/keepcheck/*|scripts/jcleancheck.sh|testdata/jclean/*|scripts/jsonmark.sh|testdata/jsonmark/*|scripts/iterregion.sh|scripts/rflowmeter.sh|testdata/sortcheck/*|scripts/flatecheck.sh|testdata/flatecheck/*|scripts/ctcheck.sh|testdata/ctcheck/*|scripts/cryptocheck.sh|scripts/ubfstat.sh|scripts/ubfstat.list|scripts/framestat.sh|scripts/framestat.list|scripts/reqinst.sh|scripts/reqinst.ts|scripts/ringinst.sh|scripts/fitcheck.sh|scripts/profcov.sh|scripts/profgen.*|scripts/numpert.sh|scripts/tyorder.sh|scripts/cacheaudit.sh|scripts/incrbuild.sh|scripts/incrmut.sh|scripts/incrrace.sh|scripts/iouring.sh|testdata/dlchain/*|scripts/httpcheck.sh|scripts/fdcap.sh|testdata/fdcap/*|scripts/mapcap.sh|scripts/mapcap.ts|testdata/mapcap/*|scripts/parkres.sh|testdata/parkres/*|scripts/acceptretry.sh|testdata/acceptretry/*|testdata/httpcheck/*|scripts/slowcheck.sh|scripts/signprobe.sh|testdata/slowcheck/*|scripts/pid1stop.*|testdata/pid1stop/*|scripts/logcheck.*|testdata/logcheck/*|scripts/mdwecheck.sh|testdata/mdwe/*|scripts/vaslot.sh|testdata/vaslot/*|scripts/starve.sh|testdata/starve/*|scripts/tschain.sh|testdata/delaylat/*|scripts/fusecheck.sh|scripts/wincheck.sh|scripts/stackcheck.*|scripts/segvcheck.sh|testdata/segvcheck/*|scripts/areacheck.*|testdata/areacheck/*|scripts/pincheck.sh|testdata/pin/*|scripts/oversub.sh|testdata/oversub/*|scripts/laypin.*|testdata/wincheck/*|testdata/cutstat/*|scripts/optdiff.sh|scripts/typerdiff.sh|scripts/irtext.sh|scripts/lltext.sh|scripts/llcheck.sh|scripts/selfhost_ll.sh|scripts/stages.sh|scripts/selfhost_cli.sh|scripts/passes.sh|scripts/regionbound.sh|scripts/memcheck.sh|testdata/memcheck/*) echo lower ;;
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
            scripts/tlsfuzz.sh|scripts/tlsfuzz-fetch.sh|testdata/tlsfuzz/*) echo lower ;;
            scripts/tls12interop.sh|testdata/tls12/*) echo lower ;;
            scripts/h2spec.sh|scripts/h2spec-fetch.sh|testdata/h2spec/*) echo lower ;;
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

declare -A PLACE=()
for pl in train nightly; do
    while IFS= read -r g; do [ -n "$g" ] && PLACE[$g]=$pl; done < <(NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts place "$pl")
done
sel=()
for g in "${ORDER[@]}"; do
    # --gate NAME…（名前で指定 — gatemut.sh / gateaudit.shのインターフェース）
    if [ "$mode" = list ]; then
        [ -n "${TAG[$g]:-}" ] && sel+=("$g")
        continue
    fi
    # releaseというマーク = リリースの組だけ（--release と --gate の名指し。--full・--fast・--auto には入れない）
    if [ "$mode" != release ]; then
        case " ${GTAG[$g]} " in *" release "*) continue ;; esac
    fi
    if [ "$mode" = full ] || [ "$mode" = release ] || [ "$mode" = train ]; then
        # rangeというマーク = 範囲の検査だけ（--fullには入れない — tyorder・report-1217 4.1 節）
        case " ${GTAG[$g]} " in *" range "*) continue ;; esac
        # 置き場所: 枝の組は train / nightly の札のゲートを除く（夜の冷 --nightly は全部）・列車の組は nightly の札のゲートを除く
        [ "$mode" = full ] && [ "$nightly" != 1 ] && [ -n "${PLACE[$g]:-}" ] && continue
        [ "$mode" = train ] && [ "${PLACE[$g]:-}" = nightly ] && continue
        if [ "${GTAG[$g]}" != zig ] || [ "$withzig" = 1 ]; then sel+=("$g"); fi
        continue
    fi
    for t in "${tags[@]}"; do
        case " ${GTAG[$g]} " in *" $t "*) sel+=("$g"); break ;; esac
    done
done
[ "${#sel[@]}" -gt 0 ] || { echo "gates: no gate matches: ${tags[*]}"; exit 2; }
# --part i/N: 選んだゲート（ORDER の順 = 長い順）を往復の順で N 個に配り、i 番目だけを残す
if [ -n "$part" ]; then
    pi=${part%/*}; pn=${part#*/}
    case "$pi/$pn" in *[!0-9/]*|/*|*/) echo "gates: --part は i/N の形（例 1/3）"; exit 2 ;; esac
    { [ "$pn" -ge 1 ] && [ "$pi" -ge 1 ] && [ "$pi" -le "$pn" ]; } || { echo "gates: --part $part — 1 ≤ i ≤ N"; exit 2; }
    psel=()
    for k in "${!sel[@]}"; do
        r=$(( k / pn )); q=$(( k % pn ))
        [ $(( r % 2 )) = 1 ] && q=$(( pn - 1 - q ))
        [ $(( q + 1 )) = "$pi" ] && psel+=("${sel[$k]}")
    done
    sel=("${psel[@]}")
    [ "${#sel[@]}" -gt 0 ] || { echo "gates: --part $part — この part に入るゲートが無い"; exit 2; }
fi
if [ "$listonly" = 1 ]; then printf '%s\n' "${sel[@]}"; exit 0; fi
if [ -z "$J" ]; then
    conc=$(( ${#sel[@]} < G ? ${#sel[@]} : G ))
    J=$(( $(nproc) / conc ))
    [ "$J" -ge 4 ] || J=4
fi

CACHE=$ROOT/scripts/.gatecache
LOGS=$CACHE/logs
# 落ちたゲートのログの置き場（LOGS は実行ごとに消すので、その外。サマリが写す）
FAILED=$CACHE/failed
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
    # 線との比較の実測（gatelib.sh の ratchet_cmp が足す）と本体の緑の印 — 記録に残し、線の値だけが変わったら記録の実測で再判定する（gatememo.ts）
    export GATE_MEAS=$W/meas/$g
    # ミュータント単位の記録（scripts/incrmut.sh — 柱3 R1）: 記録の再利用が有効な回だけ置き場を渡す（冷のレベル3・4と --no-cache では渡さない）
    # 置き場は gatememo の記録と同じ場所（GATEMEMO_SHARED か git の共通ディレクトリの gatememo/ — git の外の木では木の scripts/.gatecache/memo）
    # HIT から走らせ直す回（抜き打ち・--verify）は記録を使わない（ゲートの鍵の網羅を見る回なので、ミュータントも全部走らせる）
    if [ "$memo" = 1 ] && [ ! -f "$LOGS/$g.hit" ]; then
        local gc
        gc=$(git rev-parse --path-format=absolute --git-common-dir 2> /dev/null)
        export INCRMUT_MEMO_DIR=${GATEMEMO_SHARED:-$([ -n "$gc" ] && echo "$gc/gatememo" || echo "$ROOT/scripts/.gatecache/memo")}/incrmut
    else
        unset INCRMUT_MEMO_DIR
    fi
    mkdir -p "$W/meas"
    : > "$GATE_MEAS"
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
        # G-e（3'' M3）: 小分けのcheck（`check --split`）の出力 ≡ 一括のゴールデン（testdata/checkverdict）。全数はsplitcacheの冷の相（格納場所に書く小分け — リリースの組）が覆うので、
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
        # incrbuild も同じ形で2本に（柱3 — 例題・testdata・bench だけのコミットでは自己のチェーンが記録に当たる）
        incrbuild_self) scripts/incrbuild.sh --self > "$LOGS/$g.log" 2>&1 || ec=$? ;;
        incrbuild_ex) scripts/incrbuild.sh --ex > "$LOGS/$g.log" 2>&1 || ec=$? ;;
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
checkhit=()
if [ "$memo" = 1 ]; then
    # 鍵はゲートを走らせる前に計算する（木はゲートの間は変えない規律）。HIT のゲートは結果のファイルを HIT で書いて飛ばす
    s=$(date +%s)
    rm -rf scripts/.gatecache/memo/rejudge
    if GATEMEMO_TKEY="$tkey" NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts check "${sel[@]}" > "$W/memo" 2> "$LOGS/gatememo-check.log"; then
        run=()
        hits=()
        rejudged=()
        for g in "${sel[@]}"; do
            line=$(grep -m1 "^[A-Z]* $g " "$W/memo")
            case "$line" in
                "HIT $g "*) echo "$line" > "$LOGS/$g.hit"; hits+=("$g") ;;
                # 記録の実測がいまの線を越えた（線を下げた・線の行が消えた）: 走らせずに FAIL（ログ = 再判定の行）
                "REJUDGE $g "*) cp scripts/.gatecache/memo/rejudge/$g.log "$LOGS/$g.log"; echo "1 0" > "$W/res/$g"; rejudged+=("$g") ;;
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
        memonote="memo: $(( ${#hits[@]} - ${#checkhit[@]} )) hit / ${#run[@]} run (${#checkhit[@]} of them HIT re-run: ${checkhit[*]:-none})${rejudged[*]:+ / ${#rejudged[@]} re-judged red against the lines: ${rejudged[*]}} ($(( $(date +%s) - s ))s — misses in scripts/.gatecache/logs/memo-miss.log)"
    else
        memonote="memo: check failed — all gates run (see $LOGS/gatememo-check.log)"
    fi
    echo "gates: $memonote"
fi
# 列車の組（--level 2）: 走らせる列のうち、scripts/carry.ts が持ち越しを認めたゲートを CARRY にする（走らせない）。抜き打ちでそのうち1本を走らせ、
# 赤なら持ち越しの偽緑として FAIL。carry.ts が断ったら（理由を出す）、全部を走らせる
carried=()
carrynote=""
if [ "$mode" = train ]; then
    if NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/carry.ts "$carry" > "$W/carry" 2> "$LOGS/carry.log"; then
        declare -A CAR=()
        while read -r k g; do [ "$k" = CARRY ] && CAR[$g]=1; done < "$W/carry"
        rest=()
        for g in "${run[@]}"; do
            if [ -n "${CAR[$g]:-}" ] && [ -z "${CHK[$g]:-}" ]; then carried+=("$g"); else rest+=("$g"); fi
        done
        cspot=""
        [ "${#carried[@]}" -gt 0 ] && cspot=$(NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts pick 60 "${carried[@]}")
        run=("${rest[@]}")
        for g in "${carried[@]}"; do
            if [ "$g" = "$cspot" ]; then
                run+=("$g"); echo "CARRY $g from $carry" > "$LOGS/$g.carry"
            else
                echo "CARRY from $carry" > "$LOGS/$g.log"; echo "carry 0" > "$W/res/$g"
            fi
        done
        [ -n "$cspot" ] && checkhit+=("$cspot")
        carrynote="carry: ${#carried[@]} carried from $carry (re-run 1 of them: ${cspot:-none})"
    else
        carrynote="carry: refused — all gates run ($(grep -m1 '^NOCARRY' "$W/carry" | cut -c9- | cut -c1-140))"
        cat "$W/carry" >> "$LOGS/carry.log"
    fi
    echo "gates: $carrynote"
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
# 並べ方（report-gates-7）: 実行の時間の記録（gitの共通ディレクトリの gates-times.tsv — ゲート・wall秒・CPU秒・日時。PASS の回だけを、ゲートごとに
# 最後の値で上書きする）が、走らせるゲートの全部にあれば、wall の長い順に並べ、走っているゲートの幅（前回の CPU秒 ÷ wall・最低1）の和が
# CPU の数 × 1.25 を越えない範囲で次を始める（-j は上限のまま）。記録が1本でも無い・読めない・--fail-fast・GATES_SCHED=0 なら、今までどおり
# ORDER の順に -j 本ずつ（並べ方だけが変わり、走らせるゲートの集合は変わらない）
TIMES=${GATES_TIMES:-$(git rev-parse --path-format=absolute --git-common-dir 2> /dev/null)/gates-times.tsv}
sched=order
declare -A TW=() TC=() WD=()
if [ "$failfast" = 0 ] && [ "${GATES_SCHED:-1}" != 0 ] && [ -f "$TIMES" ] && [ "${#run[@]}" -gt 0 ]; then
    while IFS=$'\t' read -r tg tw tc _; do
        [[ "$tw" =~ ^[0-9]+$ ]] && [[ "$tc" =~ ^[0-9]+$ ]] && [ "$tw" -ge 1 ] || continue
        TW[$tg]=$tw; TC[$tg]=$tc
    done < "$TIMES"
    sched=time
    for g in "${run[@]}"; do [ -n "${TW[$g]:-}" ] || { sched=order; break; }; done
fi
if [ "$sched" = time ]; then
    mapfile -t run < <(for g in "${run[@]}"; do printf '%s\t%s\n' "${TW[$g]}" "$g"; done | sort -t$'\t' -k1,1nr -s | cut -f2)
    for g in "${run[@]}"; do w=$(( (TC[$g] + TW[$g] / 2) / TW[$g] )); [ "$w" -ge 1 ] || w=1; WD[$g]=$w; done
    BT=$(( $(nproc) * 5 / 4 ))
    echo "gates: schedule: longest recorded wall first, running width ≤ $BT threads (records: $TIMES)"
else
    echo "gates: schedule: ORDER, -j $G$( [ -f "$TIMES" ] || echo " (no time records yet)")"
fi
# 実行時間の線（柱4 — ユーザー決定2026-11-23）: ① gates.sh 1回の wall ≤ WALL_TOTAL 秒 ② ゲートごとの wall ≤ 予算。予算 = scripts/gatewall.txt の行（人間の承認つき）か、
# gates-times.tsv の5列目（PASS の wall の履歴 — gq の下で走らせた回だけ。1つ = `秒:木の印`）のうち、この木の直近5回の中央値 m から max(m × 1.5, m + 120)。
# 木の印 = 木のルートのパスのハッシュの頭8桁（記録の表は worktree の間で共有なので、別の木〔別のブランチ・別のコード〕の回を混ぜない。
# 印の無い古い形の項は使わない）。この木の履歴が3回未満のゲートは見ない。
# 超えたら --nightly と --release では FAIL、ほかの組では WARN。予算を超えた回の wall は履歴に入れない（回し直しで予算を通さない）
WALL_TOTAL=3600
wallgate=$([ "$nightly" = 1 ] || [ "$mode" = release ] || [ "$level" = 4 ] && echo 1 || echo 0)
declare -A WH=() WB=() WBW=()
if [ -f "$TIMES" ]; then
    while IFS=$'\t' read -r tg _ _ _ th; do [ -n "${th:-}" ] && WH[$tg]=$th; done < "$TIMES"
fi
if [ -f scripts/gatewall.txt ]; then
    while read -r tg tb tr; do case "$tg" in ''|'#'*) continue ;; esac; WB[$tg]=$tb; WBW[$tg]="scripts/gatewall.txt: ${tr:-}"; done < scripts/gatewall.txt
fi
TREEID=$(printf '%s' "$ROOT" | sha256sum | cut -c1-8)
budget_of() { # $1 = ゲート → 予算の秒（無ければ空）と出所を "秒 出所" で
    local g=$1
    if [ -n "${WB[$g]:-}" ]; then echo "${WB[$g]} ${WBW[$g]}"; return; fi
    [ -n "${WH[$g]:-}" ] || return 0
    tr ',' '\n' <<< "${WH[$g]}" | awk -F: -v t="$TREEID" '$2 == t { print $1 }' | tail -n 5 | sort -n | awk '{ a[NR] = $1 } END { if (NR < 3) exit; m = (NR % 2) ? a[(NR + 1) / 2] : (a[NR / 2] + a[NR / 2 + 1]) / 2; b = m * 1.5; if (m + 120 > b) b = m + 120; printf "%d median %d of %d runs\n", b, m, NR }'
}
# gq（.pair/tools/gq.sh — 同時2本の枠）の下で走っているか: 祖先のプロセスのコマンド行に gq.sh がある。枠の外の実行の wall は履歴に入れない
under_gq=0
p=$PPID
while [ -n "$p" ] && [ "$p" -gt 1 ] 2> /dev/null; do
    if tr '\0' ' ' < "/proc/$p/cmdline" 2> /dev/null | grep -q '/gq\.sh '; then under_gq=1; break; fi
    p=$(awk '{ print $4 }' "/proc/$p/stat" 2> /dev/null)
done
declare -A OVERB=()
declare -A RW=()
# 空いた幅（柱3 R2 — ゲートの中の並びを空いた CPU に合わせる札）: 並べ方が time のとき、走っているゲートの幅（記録の CPU秒 ÷ wall）の和を
# BT（CPU の数 × 1.25）から引いた値を $W/width に書く（ゲートを始めるたびと終わるたび）。ゲートの中で仕事を並べるスクリプト（incrmut.sh）は
# GATES_WIDTH_FILE を読み、自分の記録の幅に足して並びを増やす。判定は並びの数に依らない（ミュータントごとに独立）
WIDTH_FILE=$W/width
# ゲートが記録の幅を越えて借りた幅（$W/width.<ゲート> — 借りた側が書き、返したら 0 にする）の和。並べ方の判定と空いた幅の両方に足す
width_extra() { cat "$WIDTH_FILE".* 2> /dev/null | awk '{ s += $1 } END { print s + 0 }'; }
width_note() { # 走っているゲートの幅の和を数え直して書く
    local s pid alive
    s=$(width_extra)
    alive=" $(jobs -rp | tr '\n' ' ') "
    for pid in "${!RW[@]}"; do case "$alive" in *" $pid "*) s=$((s + RW[$pid])) ;; *) unset "RW[$pid]" ;; esac; done
    echo "$(( BT - s )) $(date +%s)" > "$WIDTH_FILE.tmp" && mv -f "$WIDTH_FILE.tmp" "$WIDTH_FILE"
}
[ "$sched" = time ] && export GATES_WIDTH_FILE=$WIDTH_FILE
for g in "${run[@]}"; do
    if [ "$sched" = time ]; then
        while :; do
            sum=0; n=0
            alive=" $(jobs -rp | tr '\n' ' ') "
            for pid in "${!RW[@]}"; do
                case "$alive" in *" $pid "*) sum=$((sum + RW[$pid])); n=$((n + 1)) ;; *) unset "RW[$pid]" ;; esac
            done
            sum=$((sum + $(width_extra)))
            { [ "$n" = 0 ] || { [ $((sum + WD[$g])) -le "$BT" ] && [ "$n" -lt "$G" ]; }; } && break
            wait -n || true
            width_note
        done
    else
        while [ "$(jobs -rp | wc -l)" -ge "$((G + 1))" ]; do wait -n || true; done
    fi
    if expired; then : > "$W/unrun/$g"; continue; fi
    run_gate "$g" &
    [ "$sched" = time ] && { RW[$!]=${WD[$g]}; width_note; }
done
while [ "$(jobs -rp | grep -vx "$GUARD_PID" | wc -l)" -gt 0 ]; do wait -n || true; [ "$sched" = time ] && width_note; done
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
        # 終了0 = 記録する。非0でも本体の緑の印（#body-ok）があれば渡す — gatememo.ts が「線だけ赤」かを確かめて記録する（判定は FAIL のまま）
        if [ "$ec" = 0 ] || grep -qx '#body-ok' "$W/meas/$g" 2> /dev/null; then
            NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts record "$g" "$secs" "$LOGS/$g.log" "$W/meas/$g" "$ec" >> "$LOGS/gatememo-record.log" 2>&1
        fi
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
walnote=()
echo "gates: summary (wall $(( $(date +%s) - T0 ))s, -j $G --jobs $J, logs in scripts/.gatecache/logs/)"
[ -z "$memonote" ] || echo "gates: $memonote"
[ -z "$carrynote" ] || echo "gates: $carrynote"
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
    if [ "$ec" = carry ]; then
        printf '  %-4s %-17s %4ss  %s\n' CARY "$g" - "$(cut -c1-140 "$LOGS/$g.log")"
        continue
    fi
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
    if [ "$ec" != 0 ] && [ -f "$LOGS/$g.carry" ]; then st=FAIL; fails=$((fails + 1)); last="持ち越しの偽緑（枝の全件では緑・列車の抜き打ちで赤）— $last"
    elif [ "$ec" != 0 ] && [ -f "$LOGS/$g.hit" ]; then st=FAIL; fails=$((fails + 1)); last="偽緑 — $last"
    elif [ "$ec" != 0 ]; then st=FAIL; fails=$((fails + 1)); elif grep -q '^SKIP' "$LOGS/$g.log"; then st=SKIP; else st=PASS; fi
    if [ "$st" = PASS ] && read -r bsec bwhy < <(budget_of "$g") && [ -n "$bsec" ] && [ "$secs" -gt "$bsec" ]; then
        OVERB[$g]=1
        if [ "$wallgate" = 1 ]; then
            st=FAIL; fails=$((fails + 1)); echo "1 $secs" > "$W/res/$g"
            last="wall budget: ${secs}s > ${bsec}s ($bwhy) — $last"
            echo "FAIL: wall budget — ${secs}s > ${bsec}s ($bwhy)。正当に遅くなったなら scripts/gatewall.txt に承認つきで予算を書く" >> "$LOGS/$g.log"
        else
            walnote+=("  WARN wall budget $g ${secs}s > ${bsec}s ($bwhy — FAIL only in --nightly / --release)")
        fi
    fi
    case " ${retried[*]} " in *" $g "*)
        if [ "$ec" = 0 ]; then last="(retried after memguard — PASS alone) $last"; else last="(memguard killed it again when run alone — environment: not enough memory) $last"; fi ;; esac
    printf '  %-4s %-17s %4ss  %s\n' "$st" "$g" "$secs" "$last"
    # 落ちたゲートのログは、次の実行で消えない場所（scripts/.gatecache/failed/<ゲート>.<日時>.<pid>.log）へ写して残す。
    # ゲートごとに新しい順で FAILED_KEEP 本（既定 5）だけ残す。揺れて1回だけ落ちたゲートも、後から読める
    if [ "$st" = FAIL ] && [ -f "$LOGS/$g.log" ]; then
        mkdir -p "$FAILED"
        fl="$g.$(date -d "@$T0" +%Y%m%d-%H%M%S).$$.log"
        cp "$LOGS/$g.log" "$FAILED/$fl"
        [ -f "$LOGS/$g.log.memguard" ] && cp "$LOGS/$g.log.memguard" "$FAILED/$fl.memguard"
        ls -1t "$FAILED/$g".*.log 2> /dev/null | tail -n +$(( ${FAILED_KEEP:-5} + 1 )) | while IFS= read -r old; do rm -f "$old" "$old.memguard"; done
        printf '  %-4s %-17s %5s  %s\n' "" "" "" "log kept: scripts/.gatecache/failed/$fl"
    fi
done
# 揺れる軸（WARN — FAILにしない・2026-10-04の決定〔wallは時間帯で揺れる〕）: ゲート秒の和・wallの前回比（×1.3かつ +60 s）・メモリの床（< 4 GB）
gsum=0
for g in "${sel[@]}"; do
    [ -f "$W/res/$g" ] || continue
    read -r ec secs < "$W/res/$g"
    { [ "$ec" = hit ] || [ "$ec" = carry ]; } && continue
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
# 実行の時間の記録を足す（PASS のゲートだけ・ゲートごとに最後の値で上書き。並べ方の目安にだけ使う — 結果には効かない）
if [ -n "${TIMES%/gates-times.tsv}" ] && [ -s "$LOGS/cpu.tsv" ]; then
    # 5列目 = wall の履歴（gq の下で走らせ、予算を超えなかった PASS の回だけ `秒:木の印` で足す — 実行時間の線の予算の元。木をまたいで直近16項）
    awk -F'\t' -v OFS='\t' -v t="$TREEID" -v d="$(date +%F_%T)" 'FILENAME == ARGV[1] { nw[$1] = ($3 + 0 >= 1 ? $3 + 0 : 1); nc[$1] = $2 + 0; if ($4 == 1) addh[$1] = 1; next }
        { if (!($1 in nw)) print; else hist[$1] = $5 }
        END { for (g in nw) { h = hist[g]; if (g in addh) { n = split(h, a, ","); h = ""; for (i = (n >= 16 ? n - 14 : 1); i <= n; i++) if (a[i] != "") h = h (h == "" ? "" : ",") a[i]; h = h (h == "" ? "" : ",") nw[g] ":" t }; print g, nw[g], nc[g], d, h } }' \
        <(for g in "${sel[@]}"; do [ -f "$W/res/$g" ] && read -r ec _ < "$W/res/$g" && [ "$ec" = 0 ] && grep -m1 "^$g	" "$LOGS/cpu.tsv" | awk -F'\t' -v OFS='\t' -v a="$([ "$under_gq" = 1 ] && [ -z "${OVERB[$g]:-}" ] && echo 1 || echo 0)" '{ print $0, a }'; done) "$( [ -f "$TIMES" ] && echo "$TIMES" || echo /dev/null)" > "$TIMES.tmp.$$" && mv -f "$TIMES.tmp.$$" "$TIMES"
fi
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
npass=0 nhit=0 nskip=0 ncarry=0
# 明示して外した照合（gatelib.shのcantの `SKIP[条件]` の行）: 通ったゲートのうち外したものの名前と条件。要約はALL PASSではなくPASS with N skipped
skipped=()
for g in "${sel[@]}"; do
    [ -f "$W/res/$g" ] && [ ! -f "$W/unrun/$g" ] || continue
    read -r ec secs < "$W/res/$g"
    if [ "$ec" = carry ]; then ncarry=$((ncarry + 1)); elif [ "$ec" = hit ]; then nhit=$((nhit + 1)); elif [ "$ec" = 0 ]; then
        if grep -q '^SKIP' "$LOGS/$g.log"; then nskip=$((nskip + 1)); else npass=$((npass + 1)); fi
        conds=$(sed -n 's/^SKIP\[\([^]]*\)\].*/\1/p' "$LOGS/$g.log" | sort -u | paste -sd, -)
        [ -n "$conds" ] && skipped+=("$g[$conds]")
    fi
done
if [ "${#unrun[@]}" -gt 0 ]; then
    if [ -f "$W/stopped/by" ]; then stopnote="fail-fast (stopped after $(cat "$W/stopped/by") failed)"; else stopnote="budget ${BUDGET}s"; fi
    echo "gates: $stopnote — PASS $npass · HIT $nhit · SKIP $nskip · FAIL $fails · UNRUN ${#unrun[@]}"
    echo "gates: unrun: scripts/gates.sh --gate ${unrun[*]}"
fi
for l in "${walnote[@]}"; do echo "$l"; done
wall_all=$(( $(date +%s) - T0 ))
if [ "$wall_all" -gt "$WALL_TOTAL" ]; then
    if [ "$wallgate" = 1 ]; then echo "gates: FAIL — wall ${wall_all}s > ${WALL_TOTAL}s（1回の実行の総量の線 — 柱4）"; fails=$((fails + 1))
    else echo "gates: WARN — wall ${wall_all}s > ${WALL_TOTAL}s（1回の実行の総量の線 — FAIL は --nightly / --release だけ）"; fi
fi
STATUS_DONE=1
ex=0
if [ "$fails" = 0 ] && [ "${#unrun[@]}" = 0 ] && [ "${#skipped[@]}" -gt 0 ]; then echo "gates: PASS with ${#skipped[@]} skipped (SOBER_GATES_ALLOW_SKIP=${SOBER_GATES_ALLOW_SKIP:-}): ${skipped[*]}"
elif [ "$fails" = 0 ] && [ "${#unrun[@]}" = 0 ]; then echo "gates: ALL PASS"
elif [ "$fails" = 0 ]; then echo "gates: NO FAIL (${#unrun[@]} unrun — budget)"; ex=3
else echo "gates: $fails FAILED"; ex=1
fi
# 実行の記録（gitの共通ディレクトリの gates-runs.tsv — worktreeの間で共有）: 日時・コミット・作業木が綺麗か（clean / dirty — 変更のある木の結果はコミットの結果に
# しない）・組（lv=1 / lv=1+zig / lv=2 / lv=3 / lv=4 / fast / auto / list — 2026-11-23 までの行は full / all / train / nightly / release）・記録の再利用（cache / cold）・結果（ALL PASS / PASS with skipped / FAIL / UNRUN）・PASS・HIT・FAIL の数。
# scripts/releaseok.sh が、公開の同期の前に「そのコミットでリリースの組が ALL PASS」の行を探す（別の機械で回した行は scripts/gatesrun.sh で持ち込む）
runs=${GATES_RUNS:-$(git rev-parse --path-format=absolute --git-common-dir 2> /dev/null)/gates-runs.tsv}
if [ -n "${runs%/gates-runs.tsv}" ]; then
    rev=$(git rev-parse HEAD 2> /dev/null || echo none)
    clean=$([ -z "$(git status --porcelain --untracked-files=no 2> /dev/null)" ] && echo clean || echo dirty)
    res=$(if [ "$fails" = 0 ] && [ "${#unrun[@]}" = 0 ] && [ "${#skipped[@]}" -gt 0 ]; then echo "PASS with skipped"; elif [ "$fails" = 0 ] && [ "${#unrun[@]}" = 0 ]; then echo "ALL PASS"; elif [ "$fails" = 0 ]; then echo UNRUN; else echo FAIL; fi)
    # 組の欄 = チェックレベル（lv=1〜4・--all は lv=1+zig）。--fast / --auto / --gate は今までどおり fast / auto / list
    case "$mode" in
        full) setname=$([ "$nightly" = 1 ] && echo lv=3 || { [ "$withzig" = 1 ] && echo lv=1+zig || echo lv=1; }) ;;
        train) setname=lv=2 ;;
        release) setname=lv=4 ;;
        *) setname=$mode ;;
    esac
    [ -n "$part" ] && setname="$setname:$part"
    # 8列目以降: 選んだゲートの列のハッシュ（contractok.sh が割り方の一致を見る）・wall（秒）・落ちたゲート・回した木（落ちたログは <木>/scripts/.gatecache/failed/）・
    # HITから走らせ直したゲート（spot= — 抜き打ちの1本。--verify なら全部。記録の再利用を切った回は空）・13列目 carry=<--from の引数>:<持ち越した本数>（列車の組だけ。ほかは空）
    selhash=$(printf '%s\n' "${sel[@]}" | sha256sum | cut -c1-16)
    nfail=()
    for g in "${sel[@]}"; do [ -f "$W/res/$g" ] && read -r ec _ < "$W/res/$g" && [ "$ec" != 0 ] && [ "$ec" != hit ] && [ "$ec" != carry ] && nfail+=("$g"); done
    printf '%s\t%s\t%s\t%s\t%s\t%s\tpass=%s hit=%s fail=%s gates=%s\tsel=%s\twall=%s\tfails=%s\troot=%s\tspot=%s\tcarry=%s\n' "$(date +%F_%T)" "$rev" "$clean" "$setname" "$([ "$cache" = 1 ] && echo cache || echo cold)" "$res" "$npass" "$nhit" "$fails" "${#sel[@]}" "$selhash" "$(( $(date +%s) - T0 ))" "$(IFS=,; echo "${nfail[*]:-}")" "$ROOT" "$(IFS=,; echo "${checkhit[*]:-}")" "$([ "$mode" = train ] && echo "$carry:$ncarry")" >> "$runs"
fi
status done "$(printf '{"exit":%s,"pass":%s,"hit":%s,"skip":%s,"skipped":"%s","fail":%s,"unrun":%s,"wall":%s}' "$ex" "$npass" "$nhit" "$nskip" "${skipped[*]}" "$fails" "${#unrun[@]}" "$(( $(date +%s) - T0 ))")"
exit "$ex"
