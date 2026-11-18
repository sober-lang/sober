# ゲートの小道具（scripts/*.sh が source する — 単体で実行しない）。
#
# 1. 並列の仕事（par_*）: ループの 1 回分を背景で走らせ、同時数を $JOBS（既定 1 = 従来どおり直列）で抑える。
#    各仕事の stdout は番号つきのファイルに受け、par_wait で番号順に吐く（出力の順は直列と同じ）。
#    仕事は自分専用の作業ディレクトリ（par_run が $PAR_W に入れて渡す）だけを使うこと
# 2. 差分スキップ（cache_*）: 入力の内容ハッシュが前回の成功時と同じなら照合を飛ばす。$GATECACHE が空なら何もしない
#    （単体実行の既定は従来どおり毎回照合 — scripts/gates.sh が GATECACHE を立てる）
# 3. 共有ビルド（tool_bin）: $SELFHOST_BIN に gates.sh が 1 回だけビルドした compiler/tools/* があればそれを使い、無ければ自分でビルドする（主の sober = stage2 で —
#    compiler/ は凍結したZigの範囲を越えうる。ブートストラップチェーンの決定 reaudit round 3〜4）
# 4. 起点の木（boot_src）: scripts/boot.commitのコミットのcompiler/ とstd/ を展開した格納場所。compiler/ を入力にするZig ≡ Soberの照合は
#    ここのcompiler/ を入力にする（凍結コーパスと同じ考え方 — 起点はstage1がビルドできるのでZig版が読める。決定2026-09-28）
#    展開した木には scripts/alpha16.ts を掛ける: 局所名 keys の α 改名（決定 16 の導入のため。意味不変 — 決定 2026-09-30、ユーザー確認待ち）

# 5. ゲートの環境（gate_env）: gates.shがexportする既定を、まだ値の無い変数にだけ入れる（LC_ALLだけは、gates.shと同じく上書きする）。W1を前提にするスクリプト（obs・optdiff・elfeq）を
#    単独で呼んでも、gates.sh経由と同じ結果にする。値はgates.shの冒頭とSOBER_VERIFYの行に合わせる。ワーカー数を自分で掛けるスクリプトは呼ばない
# 6. 照合できない条件（cant・need_perf・need_valgrind・need_nofile）: 道具・権限・CPUの機能・CPUの数が足りず照合できないゲートは、明示して外さない限りFAIL。
#    外すのはSOBER_GATES_ALLOW_SKIP（条件の名前を空白区切り。例: "perf cpus"）。外した照合は `SKIP[条件] ゲート: 照合しなかったもの` の行を出し、
#    gates.shの要約はALL PASSではなくPASS with N skippedと、外したゲートと条件の名前を出す。条件の名前の一覧はgateenv.shのCONDS

GATELIB_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

# 照合できない条件 $2の扱いを決める（$1 = ゲート名・$3 = 照合しなかったもの〔英語の短い句〕）。SOBER_GATES_ALLOW_SKIPに $2があれば
# SKIPの行を出して0（呼び手はその照合を飛ばす）。無ければFAILの行を出して1（呼び手はFAILにする）
cant() {
    case " ${SOBER_GATES_ALLOW_SKIP:-} " in
        *" $2 "*) echo "SKIP[$2] $1: $3"; return 0 ;;
    esac
    echo "$1: FAIL: $2 is not available, so $3 cannot be checked (set SOBER_GATES_ALLOW_SKIP=$2 to skip it explicitly)"
    return 1
}

# perfを探してPERFに入れる（PERF → PATH → /nix/store）。0 = 使える・1 = 外した（SKIPの行を出した）・2 = 使えない（FAILの行を出した）
need_perf() { # $1 = ゲート名・$2 = 照合しなかったもの（省略時the instruction ratchets）
    PERF=${PERF:-$(command -v perf || ls -d /nix/store/*-perf-linux-*/bin/perf 2> /dev/null | sort -V | tail -n 1)}
    if [ -n "$PERF" ] && "$PERF" stat -x, -e instructions:u -o /dev/null -- true > /dev/null 2>&1; then
        return 0
    fi
    cant "$1" perf "${2:-the instruction ratchets}" && return 1
    return 2
}

# valgrindを探してVGに入れる（VALGRIND → PATH → /nix/store）。戻り値はneed_perfと同じ
need_valgrind() { # $1 = ゲート名・$2 = 照合しなかったもの
    VG=${VALGRIND:-$(command -v valgrind || ls -d /nix/store/*-valgrind-[0-9]*/bin/valgrind 2> /dev/null | sort -V | tail -n 1)}
    if [ -n "$VG" ] && "$VG" --version > /dev/null 2>&1; then
        return 0
    fi
    cant "$1" valgrind "${2:-the instruction ratchets}" && return 1
    return 2
}

# 開けるfdの数（RLIMIT_NOFILE）のsoftの値を、$2以上にする（hardの範囲で上げる）。戻り値はneed_perfと同じ（条件の名前はnofile）。
# 足りないと、io_uringの固定ファイルの表（4096枠）の登録が失敗して表を使わない経路に落ち、多数の接続を張る題材はdialが失敗する。どちらも黙って結果が変わる
pinn() { # $1 = CPUの数。peak RSS を測るコマンドの前置き（taskset -c <許されたCPUの最初のn個>）。カーネルのRSSの計数はCPUごとに差分を持ち、
    # peak（ru_maxrss）はその近似の読みで記録される — CPUの間を移ると、触ったCPUの数に比例して数 MB 低めに揺れる。1つのCPUに縛れば、
    # 同じ仕事の peak は毎回同じ値になる（W1）。n個に縛れば、揺れは n個の分（1つあたり 256 KB）までに収まる
    echo "taskset -c $(taskset -pc $$ | sed 's/.*: //' | tr ',' '\n' | awk -F- '{ if (NF == 2) for (i = $1; i <= $2; i++) print i; else print $1 }' | head -n "$1" | paste -sd,)"
}
pin1() { pinn 1; }
need_nofile() { # $1 = ゲート名・$2 = 要る数
    local cur hard
    cur=$(ulimit -Sn); hard=$(ulimit -Hn)
    [ "$cur" = unlimited ] && return 0
    [ "$cur" -ge "$2" ] && return 0
    if [ "$hard" = unlimited ] || [ "$hard" -ge "$2" ]; then
        ulimit -Sn "$2" && return 0
    fi
    cant "$1" nofile "the gate (RLIMIT_NOFILE soft=$cur hard=$hard < $2)" && return 1
    return 2
}

gate_env() {
    export LC_ALL=C.UTF-8
    export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
    export SOBER_DATE_SEC=${SOBER_DATE_SEC:-784111777}
    export SOBER_WORKERS=${SOBER_WORKERS:-1}
    export SOBER_BUILD_CACHE=${SOBER_BUILD_CACHE:-0}
    export SOBER_CHECK_CACHE=${SOBER_CHECK_CACHE:-0}
    export SOBER_CHECK_REPLAY=${SOBER_CHECK_REPLAY:-0}
    export SOBER_LOWER_SPLIT=${SOBER_LOWER_SPLIT:-1}
    export SOBER_VERIFY=${SOBER_VERIFY:-each}
}

# ── 並列 ──

par_init() { # $1 = 作業の親ディレクトリ
    PAR_DIR=$1/par
    mkdir -p "$PAR_DIR"
    PAR_N=0
    PAR_MAX=${JOBS:-1}
}

par_run() { # 残り = 実行するコマンド（関数でよい）。$PAR_W に専用の作業ディレクトリ
    while [ "$(jobs -rp | wc -l)" -ge "$PAR_MAX" ]; do wait -n || true; done
    PAR_N=$((PAR_N + 1))
    local k
    k=$(printf '%06d' "$PAR_N")
    mkdir -p "$PAR_DIR/w$k"
    # 仕事が途中で落ちた（set -e 等）ら、結果の行が無いまま終わるので fail を足す
    ( PAR_W=$PAR_DIR/w$k; "$@" || { echo "FAIL: job exited $?: $*"; echo "@@ fail"; } ) > "$PAR_DIR/o$k" 2>&1 &
}

par_wait() { # 全部待って、出力を番号順に吐く（出力のファイルは消す — 次の par_run の組に備える）
    wait || true
    local f
    for f in "$PAR_DIR"/o*; do
        [ -e "$f" ] || continue
        cat "$f"
        rm -f "$f"
    done
    rm -rf "$PAR_DIR"/w*
}

# par_count TAG ファイル: 仕事が吐いた「@@ TAG」行の数（集計用 — 各仕事は結果を @@ ok / @@ rej / @@ fail 等の 1 行で吐く）
par_count() {
    grep -c "^@@ $1\$" "$2" || true
}

# ── 差分スキップ ──

cache_key() { # 引数 = 入力のファイル / ディレクトリ。内容ハッシュ（パスと中身）
    find "$@" -type f -not -path '*/.gatecache/*' 2> /dev/null | LC_ALL=C sort | xargs -d '\n' sha256sum | sha256sum | cut -d' ' -f1
}

# rel_key: cache_key と同じ。ただし木の中のパスは木のルートからの相対で数える — 中身が同じなら worktree が違っても同じ値（木の外のパスは絶対のまま）
rel_key() {
    local a args=()
    for a in "$@"; do case "$a" in "$GATELIB_ROOT"/*) args+=("${a#"$GATELIB_ROOT"/}") ;; *) args+=("$a") ;; esac; done
    (cd "$GATELIB_ROOT" && cache_key "${args[@]}")
}

cache_hit() { # $1 = ゲート名、残り = 入力。一致なら 0（呼び手は SKIP を出して抜ける）。キーは $CACHE_KEY に残す
    [ -n "${GATECACHE:-}" ] || return 1
    local name=$1
    shift
    CACHE_KEY=$(cache_key "$@")
    CACHE_FILE=$GATECACHE/$name.key
    [ -f "$CACHE_FILE" ] && [ "$(cat "$CACHE_FILE")" = "$CACHE_KEY" ]
}

cache_store() { # 成功時に呼ぶ（cache_hit の後）
    [ -n "${GATECACHE:-}" ] && [ -n "${CACHE_KEY:-}" ] || return 0
    mkdir -p "$GATECACHE"
    echo "$CACHE_KEY" > "$CACHE_FILE"
}

# ── 共有ビルド ──

tool_bin() { # $1 = tool名（src/compiler/tools/<name>）、$2 = 格納場所。主のsober（bin/sober = stage2 + 正規バックエンド）でビルド（$SELFHOST_BINにあればそれをコピーする）
    if [ -n "${SELFHOST_BIN:-}" ] && [ -x "$SELFHOST_BIN/$1" ]; then
        cp "$SELFHOST_BIN/$1" "$2"
        return 0
    fi
    (cd "$GATELIB_ROOT/src/compiler" && "$GATELIB_ROOT/bin/sober" build "tools/$1/main.sober" -o "$2")
}

slot_eq() { # $1 = Zig 版（使い回し前）、$2 = Sober 版の IR / .ll。スロットの宣言と番号を除いて一致なら 0（S-1 — lower のスロットの使い回し。
    # Zig ≡ Sober のバイト照合はスロットの分だけずれる設計 — 照合の中身は scripts/slotmap.ts の冒頭）
    node "$GATELIB_ROOT/scripts/slotmap.ts" "$1" "$2"
}

boot_commit() { grep -v '^#' "$GATELIB_ROOT/bootstrap/chain.txt" | awk 'NF { print $1; exit }'; }   # ブートストラップチェーンの1ステージ目（bootstrap/<ステージ> — 公開準備便 ①）

boot_src() { # 起点のコミットの木（<格納場所>/compiler・<格納場所>/std）を展開して格納場所を出す。起点ごとに1回だけ展開（並行に呼ばれても壊れない — 展開してからmv）
    local c d t
    c=$(boot_commit)
    d=$GATELIB_ROOT/out/stage2/boot/src-$c-a16
    if [ ! -d "$d" ]; then
        mkdir -p "$GATELIB_ROOT/out/stage2/boot"
        t=$(mktemp -d "$GATELIB_ROOT/out/stage2/boot/.src.XXXXXX")
        cp -r "$GATELIB_ROOT/bootstrap/$c/compiler" "$GATELIB_ROOT/bootstrap/$c/std" "$t/" || { rm -rf "$t"; echo "boot_src: bootstrap/$c not found" >&2; return 1; }
        # 局所名 keys の α 改名（決定 16 の導入のため — 起点は keys が組み込みになる前の木。意味は不変・Zig と Sober に同じ改名済みの入力を渡す）
        node --experimental-strip-types "$GATELIB_ROOT/scripts/alpha16.ts" "$t" > /dev/null || { rm -rf "$t"; echo "boot_src: alpha16 failed" >&2; return 1; }
        mv -T "$t" "$d" 2> /dev/null || rm -rf "$t"
    fi
    echo "$d"
}

# ── Lean のバッチ（sober-check --batch — 1 行 1 入力の NDJSON、出力も 1 行ずつ）──
# 1 件ずつ sober-check を起動する代わりに、入力を集めて $JOBS 本のバッチに分けて流す。出力の各行は 1 件ずつの実行の stdout と
# バイト一致する（scripts/leanbatch.sh が回帰検査）。入力の改行は空白へ（JSON では同じ値・parse error の位置もずれない）

lean_key() { # 入力ファイルのパス → 出力の格納場所のキー
    printf '%s' "$1" | sha1sum | cut -c1-16
}

# LEAN_BIG（バイト — 既定 64 MiB）を超える入力は Lean の sober-check が 1 本で数 GB を食う（338 MB の入力で 7 GB — Json の木とコアの項）。
# 大物どうしが別のチャンクで同時に走ると山が足し算になる（memguard の kill の常連だった）ので、大物は専用のチャンク 1 本に集めて直列に流す
lean_big() { # $1 = 入力ファイル。LEAN_BIG を超えれば 0
    [ "$(stat -c %s "$1")" -gt "${LEAN_BIG:-67108864}" ]
}

lean_batch() { # $1 = 入力ファイルの一覧（1行1パス）、$2 = 出力の格納場所。各入力の判定を $2/<lean_key>.outへ（1件ずつのstdoutと同じ形）。
    # LEAN_MODE（既定 --batch）でバッチのモードを替える（--shape-batch = 形の検査）
    local list=$1 out=$2 k=${JOBS:-1} c f chk=${SOBER_CHECK:-$GATELIB_ROOT/lean/.lake/build/bin/sober-check}
    mkdir -p "$out/.chunk"
    : > "$out/.chunk/big.list"
    : > "$out/.chunk/small.list"
    while IFS= read -r f; do
        if lean_big "$f"; then echo "$f" >> "$out/.chunk/big.list"; else echo "$f" >> "$out/.chunk/small.list"; fi
    done < "$list"
    local n
    n=$(wc -l < "$out/.chunk/small.list")
    [ "$k" -le "$n" ] || k=$n
    local chunks=()
    for c in $(seq 0 $((k - 1))); do
        awk -v k="$k" -v c="$c" 'NR % k == c' "$out/.chunk/small.list" > "$out/.chunk/$c.list"
        chunks+=("$c")
    done
    if [ -s "$out/.chunk/big.list" ]; then
        mv "$out/.chunk/big.list" "$out/.chunk/big0.list"
        chunks+=(big0)
    fi
    for c in "${chunks[@]}"; do
        (
            while IFS= read -r f; do tr '\n' ' ' < "$f"; echo; done < "$out/.chunk/$c.list" | "$chk" "${LEAN_MODE:---batch}" > "$out/.chunk/$c.res"
        ) &
    done
    wait
    for c in "${chunks[@]}"; do
        paste -d '\n' "$out/.chunk/$c.list" "$out/.chunk/$c.res" | while IFS= read -r f && IFS= read -r r; do
            printf '%s\n' "$r" > "$out/$(lean_key "$f").out"
        done
    done
    rm -rf "$out/.chunk"
}

lean_result() { # $1 = 入力ファイル、$2 = lean_batchの格納場所（空なら1件ずつ起動 — 単体実行の従来経路）。判定をstdoutへ
    if [ -n "${2:-}" ] && [ -f "$2/$(lean_key "$1").out" ]; then
        cat "$2/$(lean_key "$1").out"
    else
        "${SOBER_CHECK:-$GATELIB_ROOT/lean/.lake/build/bin/sober-check}" < "$1" || true
    fi
}

lean_stub() { # $1 = 格納場所。`sober check` に渡すSOBER_CHECKの差し替え: Zigが検査器へ渡すJSONを $LEANCAPへコピーし、仮の判定を返す
    printf '#!/usr/bin/env bash\ncat > "$LEANCAP"\necho "{\\"pending\\":true}"\n' > "$1/lean-stub"
    chmod +x "$1/lean-stub"
    echo "$1/lean-stub"
}

# ── 主役交代（R39）: 主の sober と stage1 ──
# $SOBER  = 主のsober（bin/sober — stage2 のフロントエンド〜lower ＋ 凍結した Zig の正規バックエンド）。「コンパイラとして使う」側とゴールデンの生成元
# $STAGE1 = 凍結した Zig 版（src/stage1/zig-out/bin/sober）。「Zig を正として Sober と比べる」側（凍結コーパスの差分）と Zig にしか無い機能の側
# 既定は各スクリプトが `SOBER=${SOBER:-$ROOT/bin/sober}` / `STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}` で立てる

stage2_key() { # stage2を新しくして（古ければ作り直す）、その入力ハッシュのファイルのパスを出す（ゴールデンの差分スキップの鍵に混ぜる）
    "$GATELIB_ROOT/scripts/stage2.sh" --quiet >&2 || return 1
    echo "$GATELIB_ROOT/out/stage2/.key"
}

# ── テキストのゴールデン（irtext・lltext・corejson — docs/golden.md）: 表は testdata/<ゲート>/、全文は out/gold/<ir|ll|core>/（gitの外） ──
# 表 = scripts/goldtab.ts（題材ごとに関数の名前・ハッシュ・行数・バイト数。1行目は全文のハッシュ）。全文を入力に読むゲート（llcheck・leanbatchなど）は
# `scripts/<ゲート>.sh --gen` で全文を最新にしてから gold_rlock を取って out/gold/<種類>/ を読む。全文の鍵が合っていれば作り直さない

gold_key() { # $1 = 生成のスクリプト。全文の鍵 = stage2・bin/sober・スクリプト・入力の木（ゴールデンの表を除く）・出力に効く環境
    local s2
    s2=$(stage2_key) || return 1
    {
        cat "$s2"
        sha256sum "$GATELIB_ROOT/bin/sober" "$1" | cut -d' ' -f1
        (cd "$GATELIB_ROOT" && find examples testdata src/std -type f -not -path 'testdata/irtext/*' -not -path 'testdata/lltext/*' \
            -not -path 'testdata/corejson/*' -not -path 'testdata/astjson/*' | LC_ALL=C sort | xargs -d '\n' sha256sum)
        env | grep -E '^SOBER_(DATE_SEC|HASH_SEED)=' | LC_ALL=C sort
    } | sha256sum | cut -d' ' -f1
}

gold_rlock() { # $1 = ir / ll / core。全文を読む間、置き換えを待たせる（fd 8 の共有ロック — 呼び手のプロセスが終われば外れる）
    mkdir -p "$GATELIB_ROOT/out/gold"
    exec 8> "$GATELIB_ROOT/out/gold/.$1.lock"
    flock -s 8
}

gold_publish() { # $1 = ir / ll / core、$2 = 生成した全文のdir（out/gold の下）、$3 = 鍵。原子的に置き換える
    local d=$GATELIB_ROOT/out/gold/$1
    echo "$3" > "$2/.key"
    (
        flock 9
        rm -rf "$d.old"
        [ -e "$d" ] && mv "$d" "$d.old"
        mv "$2" "$d"
        rm -rf "$d.old"
    ) 9> "$GATELIB_ROOT/out/gold/.$1.lock"
}

# gold_text_main <ir|ll|core> <ゲートの名前> <スクリプト> [--regen|--list|--gen]: irtext.sh・lltext.sh・corejson.sh の本体
#   引数なし = 全題材を2回生成して決定性を確かめ、全文を out/gold/ に置き、表を testdata/<ゲート> と比べる
#   --regen = 同じく生成して、表を testdata/<ゲート> に書く・--gen = 全文が古ければ作り直すだけ（読み手のゲートが呼ぶ）
# 呼び手が定義する関数: gold_emit <entry> <出力> = 1題材の全文を書く（必須）。gold_job_check <entry> <全文> = 題材ごとの追加の検査（FAIL: の行を出す）・
# gold_post <全文のdir> = 全題材の後の追加の検査（失敗で非0）。後の2つは無くてよく、--gen では呼ばない
gold_text_main() {
    local kind=$1 gate=$2 self=$3 mode=${4:-}
    local GOLDEN=testdata/$gate ext=$1
    [ "$kind" = core ] && ext=json
    gold_entries() {
        ls examples/*.sober
        for d in testdata/*/app; do echo "$d"; done
        ls testdata/pool/*.sober
    }
    if [ "$mode" = --list ]; then
        gold_entries
        return 0
    fi
    [ -x "$SOBER" ] || { echo "error: $SOBER not found"; return 1; }
    if [ -z "$mode" ] && cache_hit "$gate" "$SOBER" "$(stage2_key)" "$self" examples testdata src/std; then
        echo "SKIP: inputs unchanged since the last pass (scripts/.gatecache/$gate.key)"
        return 0
    fi
    local key full tmp lk
    key=$(gold_key "$self") || return 1
    mkdir -p "$GATELIB_ROOT/out/gold"
    if [ "$mode" = --gen ]; then
        # 生成の間は排他（並んで呼ばれても1回だけ作る）。取った後にもう一度鍵を見る
        exec 7> "$GATELIB_ROOT/out/gold/.$kind.gen"
        flock 7
        if [ -f "$GATELIB_ROOT/out/gold/$kind/.key" ] && [ "$(cat "$GATELIB_ROOT/out/gold/$kind/.key")" = "$key" ]; then
            exec 7>&-
            return 0
        fi
    fi
    full=$(mktemp -d "$GATELIB_ROOT/out/gold/.$kind.XXXXXX")
    tmp=$(mktemp -d)
    # shellcheck disable=SC2064
    trap "rm -rf '$tmp' '$full'" EXIT
    : > "$full/EXCLUDED.txt"
    local fail=0 n
    JOBS=${JOBS:-$(nproc)}
    par_init "$tmp"
    gold_job() { # $1 = entry
        local e=$1 k
        k=$(echo "$e" | tr '/' '_')
        k=${k%.sober}
        if ! gold_emit "$e" "$full/$k.$ext" 2> "$PAR_W/err"; then
            rm -f "$full/$k.$ext"
            echo "@@ excl $e: $(head -n 1 "$PAR_W/err")"
            return 0
        fi
        if [ "$mode" != --gen ]; then
            gold_emit "$e" "$PAR_W/again"
            cmp -s "$full/$k.$ext" "$PAR_W/again" || echo "FAIL: $e: output is not deterministic"
            if declare -F gold_job_check > /dev/null; then gold_job_check "$e" "$full/$k.$ext"; fi
        fi
        echo "@@ ok"
    }
    # testdata/golden_skip.txtのentryはゴールデンを作らない（--listは絞らない — 他のゲートが全entryを読む）
    while IFS= read -r e; do par_run gold_job "$e"; done < <(gold_entries | grep -vxF -f <(grep -v "^#" testdata/golden_skip.txt))
    par_wait > "$tmp/res"
    grep '^@@ excl ' "$tmp/res" | sed 's/^@@ excl //' > "$full/EXCLUDED.txt" || true
    if grep '^FAIL' "$tmp/res"; then fail=1; fi
    n=$(grep -c '^@@ ok' "$tmp/res" || true)
    # 除外の理由の列はゴールデンの文面を保つ（生成元の診断文 — excluded_keep）
    excluded_keep "$full/EXCLUDED.txt" "$GOLDEN/EXCLUDED.txt" ": "
    mkdir -p "$tmp/tab"
    # 表は題材を分けて並列に作る（コアJSONは1プロセスで約90秒）
    (cd "$full" && ls | grep "\.$ext\$") | xargs -r -n 40 -P "$JOBS" node "$GATELIB_ROOT/scripts/goldtab.ts" tab "$kind" "$full" "$tmp/tab" > /dev/null || fail=1
    cp "$full/EXCLUDED.txt" "$tmp/tab/"
    if [ "$mode" != --gen ] && declare -F gold_post > /dev/null; then gold_post "$full" || fail=1; fi
    [ "$fail" = 0 ] || return 1
    gold_publish "$kind" "$full" "$key"
    if [ "$mode" = --gen ]; then
        exec 7>&-
        return 0
    fi
    if [ "$mode" = --regen ]; then
        rm -rf "$GOLDEN"
        mkdir -p "$GOLDEN"
        cp -r "$tmp/tab/." "$GOLDEN/"
        echo "regenerated $GOLDEN ($n entries, $(wc -l < "$GOLDEN/EXCLUDED.txt") excluded; full text in out/gold/$kind)"
        return 0
    fi
    [ -d "$GOLDEN" ] || { echo "error: $GOLDEN not found (--regen)"; return 1; }
    if ! diff -r "$GOLDEN" "$tmp/tab" > "$tmp/diff"; then
        echo "FAIL: $kind text differs from $GOLDEN（表の差の題材 $(grep -c '^diff -r\|^Only in' "$tmp/diff")）"
        echo "  (生成元のどこかが変わった。意図した変更なら --regen。変わった関数の全文の差分 = scripts/golddiff.sh HEAD $kind <題材>)"
        head -n 40 "$tmp/diff"
        return 1
    fi
    [ -z "$mode" ] && cache_store
    echo "OK: $n entries match $GOLDEN (deterministic, $(wc -l < "$GOLDEN/EXCLUDED.txt") excluded)"
}

frozen_list() { # $1 = scripts/frozen/<name>.list の name。コメントと空行を除き、消えたパスの行を飛ばして出す（飛ばした数は stderr へ）。
    # compiler/ の行は起点の木（boot_src）の中の絶対パスに読み替える — compiler/ は凍結後の言語で書かれうるので、凍結の入力は起点の中身
    local f=$GATELIB_ROOT/scripts/frozen/$1.list p gone=0 bs=""
    while IFS= read -r p; do
        case "$p" in '#'*|'') continue ;; esac
        case "$p" in compiler/*) [ -n "$bs" ] || bs=$(boot_src); p=$bs/$p ;; esac
        if [ -e "$GATELIB_ROOT/$p" ] || [ -e "$p" ]; then echo "$p"; else gone=$((gone + 1)); fi
    done < "$f"
    [ "$gone" = 0 ] || echo "frozen/$1.list: $gone entries no longer exist (skipped)" >&2
}

frozen_lower() { # $1 = frozen_list の name。lower 側のゲート用: scripts/frozen/lower-retired.list の entry を除いて出す（退役の理由はリストのコメント）
    local r=$GATELIB_ROOT/scripts/frozen/lower-retired.list
    frozen_list "$1" | grep -vxF -f <(grep -v '^#' "$r" | grep -v '^$')
}

check_retired() { # $1 = entry。scripts/frozen/check-retired.list に載っていれば 0（check 側の Zig ≡ Sober の照合を飛ばす）
    grep -qxF "$1" "$GATELIB_ROOT/scripts/frozen/check-retired.list"
}

tool_retired() { # $1 = tool 名。scripts/frozen/lower-retired.list に compiler/tools/<名前> があれば 0（lower 側の道具の自己適用の照合を飛ばす）
    grep -qxF "compiler/tools/$1" "$GATELIB_ROOT/scripts/frozen/lower-retired.list"
}

beyond_stage1() { # $1 = IRテキスト。stage1（凍結したZig）のIRの語彙を越えるop（floatの段階2026-10-04 — fadd… / feq… / fsqrt / fofint / ftoint）を
    # 含めば 0。その entry の stage1 との照合（elfeq / passes / errtrace）を飛ばす — 凍結以来はじめて IR テキストの語彙が増えた。新しい語彙の entry は
    # obs・optdiff・Sober生成のゴールデン（irtext / lltext）・Goの比較用の実装が見る（「Zig ≡ Soberの差分は凍結コーパスだけで見る」の規約どおり）
    # 段階6 P3a-2aで2度目の拡張: taskの罠（`= trap ` と `unwind` — compiler/lower/trap.sober）
    # 段階6 P3b-1で3度目: taskの切替（`tswitch` / `tstart` — compiler/lower/task.sober）
    # 段階6 P4-3 / P4-4で4度目: %fsの番地・不可分の命令・スレッドの生成（`fsaddr` / `atomic.*` / `fence` / `pause` / `clone`）— 段階6 P6-1で
    # 5度目（ハッシュタスク2026-10-09）: 積の上位 `mulhi`（mapのハッシュmum — string鍵のmapを使うentryは全部この語彙の外になる）
    # compiler/ 自身が std/task を使い始めて、コンパイラ自身の IR がこの語彙を越えた（stages の cross・errtrace の自己適用が踏んだ）
    # 6度目（TLSタスク796）: AES-GCMのチャンク（`aes.cpu` / `aes.key` / `aes.ctr` / `aes.ghash` — compiler/lower/aes.sober）
    # 7度目（RSAの続き — report-864）: 多倍長のチャンク（`mm.cpu` / `mm.mul` — compiler/lower/mulx.sober）
    # 8度目（deflate v2）: 狭いワードの読み書き（`load16` / `store16` / `load32` / `store32` — pool.ScratchのLoadRaw16等）
    grep -qE '= (fadd|fsub|fmul|fdiv|fsqrt|fofint|ftoint|feq|fne|flt|fle|fgt|fge|trap|fsaddr|atomic\.[a-z]+|clone|mulhi|aes\.[a-z]+|mm\.[a-z]+|load16|load32) |^ *(unwind|tswitch |tstart |fence|pause|fsaddr |atomic\.|clone |store16 |store32 )' "$1"
}

neg_beyond_stage1() { # $1 = 負例のentry（testdata/loader_neg/<名前>/app）。その負例の格納場所にマークbeyond_stage1（中身 = 理由）があれば0 —
    # stage1（凍結した Zig）が持たない拒否の規則（mut 実引数の排他 2026-10-05 — stage1 は受理する）の負例。stage1 との照合はせず、Sober が拒否することだけを見る
    [ -f "$(dirname "$1")/beyond_stage1" ]
}

obs_frozen() { # 凍結 entries（scripts/frozen/entries.list）のうち obs の期待値（.out）を持つものを obs.sh の名前で出す（examples/X.sober → X、testdata/D/app → そのまま）
    local e
    frozen_list entries 2>/dev/null | while IFS= read -r e; do
        case "$e" in
            examples/*.sober) [ -f "${e%.sober}.out" ] && basename "$e" .sober ;;
            */app) [ -f "$e.out" ] && echo "$e" ;;
        esac
    done
}

zig_frozen() { # obs_frozenからscripts/frozen/zig-excluded.listのentryを除く（タグzigの列 — stage1がビルドできる凍結コーパス。G1）
    local x
    x=$(grep -v '^#' "$GATELIB_ROOT/scripts/frozen/zig-excluded.list" | grep -v '^$')
    obs_frozen | grep -vxF -e "${x:-//}"
}

stdin_of() { # $1 = 例の .out を除いたパス → 実行の標準入力（例の .in があればそれ・無ければ /dev/null）
    if [ -f "$1.in" ]; then echo "$1.in"; else echo /dev/null; fi
}

zigtest_judge() { # $1 = zig build test のログ。赤のテスト名の集合が scripts/frozen/zigtest-expected-fail.list の宣言と一致すれば 0（G1）
    local want got
    want=$(grep -v '^#' "$GATELIB_ROOT/scripts/frozen/zigtest-expected-fail.list" | grep -v '^$' | sort -u)
    got=$(grep -oE "^error: '[^']+' failed" "$1" | sed -E "s/^error: '(.*)' failed$/\1/" | sort -u)
    if grep -qE '\.zig:[0-9]+:[0-9]+: error:' "$1"; then echo "zigtest: a compile step failed (not a test)"; return 1; fi
    if [ "$want" = "$got" ]; then echo "zigtest: $(echo "$got" | grep -c .) declared failures (scripts/frozen/zigtest-expected-fail.list), no others"; return 0; fi
    echo "zigtest: failures differ from scripts/frozen/zigtest-expected-fail.list"
    comm -13 <(echo "$want") <(echo "$got") | sed 's/^/  new failure: /'
    comm -23 <(echo "$want") <(echo "$got") | sed 's/^/  declared but passing (remove the line): /'
    return 1
}

excluded_keep() { # $1 = 生成し直したEXCLUDED、$2 = ゴールデンのEXCLUDED、$3 = 区切り（タブか ': '）。
    # 除外の集合（パス）は生成元の判定を正とし、理由の列はゴールデンに同じパスがあればゴールデンの文面を保つ（理由は生成元の診断文 — ZigとSoberで文面が違う。
    # 集合が一致すればバイトも一致する）。結果を $1 に書き戻す
    [ -f "$2" ] || return 0
    awk -v sep="$3" 'NR == FNR { i = index($0, sep); if (i) old[substr($0, 1, i - 1)] = $0; next }
        { i = index($0, sep); k = i ? substr($0, 1, i - 1) : $0; print (k in old) ? old[k] : $0 }' "$2" "$1" > "$1.keep" && mv "$1.keep" "$1"
}

# omit_judge <ゲート名> <例外の一覧> <試した対象の一覧> <飛ばした対象の一覧>: check / build が失敗して飛ばした対象を照合する。
# 失敗してよいのは、testdata/checkverdict のゴールデン（entry ごとの check の出力と終了コード）で check が拒否する対象（exit≠0）だけ。
# ゴールデンの無い対象と exit=0 の対象の失敗は FAIL。例外は一覧のファイルに書く（1 行 1 対象・# から行末はコメント — 一覧にあるのに失敗しなかった・もう対象でない行も FAIL）。
# 拒否される対象の成功は FAIL にしない（check が拒否しても build は通る対象がある）。呼ぶゲートは testdata/checkverdict を宣言に含める
omit_judge() {
    local g=$1 list=$2 tried=$3 got=$4 w f=0 e gf
    w=$(mktemp -d)
    { [ -f "$list" ] && sed 's/#.*//; s/[[:space:]]*$//' "$list" | grep .; } | LC_ALL=C sort -u > "$w/want"
    LC_ALL=C sort -u "$got" > "$w/got"
    LC_ALL=C sort -u "$tried" > "$w/tried"
    : > "$w/rej"
    while read -r e; do
        gf=$GATELIB_ROOT/testdata/checkverdict/$(echo "$e" | tr '/' '_').txt
        [ -f "$gf" ] && ! grep -qx 'exit=0' "$gf" && echo "$e" >> "$w/rej"
    done < "$w/tried"
    LC_ALL=C sort -u "$w/rej" -o "$w/rej"
    LC_ALL=C sort -u "$w/rej" "$w/want" > "$w/allowed"
    while read -r e; do echo "FAIL: $g: check / build of $e failed (check accepts it in testdata/checkverdict, and it is not listed in $list)"; f=1; done < <(LC_ALL=C comm -13 "$w/allowed" "$w/got")
    while read -r e; do
        if grep -qxF "$e" "$w/tried"; then echo "FAIL: $g: $e is listed in $list but did not fail (remove it from the list)"
        else echo "FAIL: $g: $e is listed in $list but is no longer a target (remove it from the list)"; fi
        f=1
    done < <(LC_ALL=C comm -23 "$w/want" "$w/got")
    echo "$g: omitted $(wc -l < "$w/got") of $(wc -l < "$w/tried") targets whose check / build failed ($(LC_ALL=C comm -12 "$w/got" "$w/rej" | wc -l) of the $(wc -l < "$w/rej") targets rejected by check in testdata/checkverdict, $(LC_ALL=C comm -12 "$w/got" "$w/want" | wc -l) listed in $list)"
    rm -rf "$w"
    return $f
}
