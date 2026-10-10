# ゲートの小道具（scripts/*.sh が source する — 単体で実行しない）。
#
# 1. 並列の仕事（par_*）: ループの 1 回分を背景で走らせ、同時数を $JOBS（既定 1 = 従来どおり直列）で抑える。
#    各仕事の stdout は番号つきのファイルに受け、par_wait で番号順に吐く（出力の順は直列と同じ）。
#    仕事は自分専用の作業ディレクトリ（par_run が $PAR_W に入れて渡す）だけを使うこと
# 2. 差分スキップ（cache_*）: 入力の内容ハッシュが前回の成功時と同じなら照合を飛ばす。$GATECACHE が空なら何もしない
#    （単体実行の既定は従来どおり毎回照合 — scripts/gates.sh が GATECACHE を立てる）
# 3. 共有ビルド（tool_bin）: $SELFHOST_BIN に gates.sh が 1 回だけビルドした compiler/tools/* があればそれを使い、無ければ自分でビルドする（主の sober = stage2 で —
#    compiler/ は凍結した Zig の範囲を越えうる。鎖の裁定 reaudit round 3〜4）
# 4. 起点の木（boot_src）: scripts/boot.commit のコミットの compiler/ と std/ を展開した置き場。compiler/ を入力にする Zig ≡ Sober の照合は
#    ここの compiler/ を入力にする（凍結コーパスと同じ考え方 — 起点は stage1 が建てられるので Zig 版が読める。決定 2026-09-28）
#    展開した木には scripts/alpha16.ts を掛ける: 局所名 keys の α 改名（決定 16 の導入のため。意味不変 — 決定 2026-09-30、ユーザー確認待ち）

GATELIB_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

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

tool_bin() { # $1 = tool 名（src/compiler/tools/<name>）、$2 = 置き場。主の sober（bin/sober = stage2 + 正規バックエンド）でビルド（$SELFHOST_BIN にあればそれを写す）
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

boot_commit() { grep -v '^#' "$GATELIB_ROOT/bootstrap/chain.txt" | awk 'NF { print $1; exit }'; }   # 鎖の 1 段目（bootstrap/<段> — 公開準備便 ①）

boot_src() { # 起点のコミットの木（<置き場>/compiler・<置き場>/std）を展開して置き場を出す。起点ごとに 1 回だけ展開（並行に呼ばれても壊れない — 展開してから mv）
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

lean_key() { # 入力ファイルのパス → 出力の置き場のキー
    printf '%s' "$1" | sha1sum | cut -c1-16
}

lean_batch() { # $1 = 入力ファイルの一覧（1 行 1 パス）、$2 = 出力の置き場。各入力の判定を $2/<lean_key>.out へ（1 件ずつの stdout と同じ形）
    local list=$1 out=$2 k=${JOBS:-1} c chk=${SOBER_CHECK:-$GATELIB_ROOT/lean/.lake/build/bin/sober-check}
    mkdir -p "$out/.chunk"
    local n
    n=$(wc -l < "$list")
    [ "$n" -gt 0 ] || return 0
    [ "$k" -le "$n" ] || k=$n
    for c in $(seq 0 $((k - 1))); do
        awk -v k="$k" -v c="$c" 'NR % k == c' "$list" > "$out/.chunk/$c.list"
        (
            while IFS= read -r f; do tr '\n' ' ' < "$f"; echo; done < "$out/.chunk/$c.list" | "$chk" --batch > "$out/.chunk/$c.res"
        ) &
    done
    wait
    for c in $(seq 0 $((k - 1))); do
        paste -d '\n' "$out/.chunk/$c.list" "$out/.chunk/$c.res" | while IFS= read -r f && IFS= read -r r; do
            printf '%s\n' "$r" > "$out/$(lean_key "$f").out"
        done
    done
    rm -rf "$out/.chunk"
}

lean_result() { # $1 = 入力ファイル、$2 = lean_batch の置き場（空なら 1 件ずつ起動 — 単体実行の従来経路）。判定を stdout へ
    if [ -n "${2:-}" ] && [ -f "$2/$(lean_key "$1").out" ]; then
        cat "$2/$(lean_key "$1").out"
    else
        "${SOBER_CHECK:-$GATELIB_ROOT/lean/.lake/build/bin/sober-check}" < "$1" || true
    fi
}

lean_stub() { # $1 = 置き場。`sober check` に渡す SOBER_CHECK の差し替え: Zig が検査器へ渡す JSON を $LEANCAP へ写し、仮の判定を返す
    printf '#!/usr/bin/env bash\ncat > "$LEANCAP"\necho "{\\"pending\\":true}"\n' > "$1/lean-stub"
    chmod +x "$1/lean-stub"
    echo "$1/lean-stub"
}

# ── 主役交代（R39）: 主の sober と stage1 ──
# $SOBER  = 主の sober（bin/sober — stage2 のフロントエンド〜lower ＋ 凍結した Zig の正規バックエンド）。「コンパイラとして使う」側と黄金の生成元
# $STAGE1 = 凍結した Zig 版（src/stage1/zig-out/bin/sober）。「Zig を正として Sober と比べる」側（凍結コーパスの差分）と Zig にしか無い機能の側
# 既定は各スクリプトが `SOBER=${SOBER:-$ROOT/bin/sober}` / `STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}` で立てる

stage2_key() { # stage2 を新しくして（古ければ作り直す）、その入力ハッシュのファイルのパスを出す（黄金の差分スキップの鍵に混ぜる）
    "$GATELIB_ROOT/scripts/stage2.sh" --quiet >&2 || return 1
    echo "$GATELIB_ROOT/out/stage2/.key"
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

beyond_stage1() { # $1 = IR テキスト。stage1（凍結した Zig）の IR の語彙を越える op（float の段 2026-10-04 — fadd… / feq… / fsqrt / fofint / ftoint）を
    # 含めば 0。その entry の stage1 との照合（elfeq / passes / errtrace）を飛ばす — 凍結以来はじめて IR テキストの語彙が増えた。新しい語彙の entry は
    # obs・optdiff・Sober 生成の黄金（irtext / lltext）・Go の双子が見る（「Zig ≡ Sober の差分は凍結コーパスだけで見る」の規約どおり）
    # 段 6 P3a-2a で 2 度目の拡張: task の罠（`= trap ` と `unwind` — compiler/lower/trap.sober）
    # 段 6 P3b-1 で 3 度目: task の切替（`tswitch` / `tstart` — compiler/lower/task.sober）
    # 段 6 P4-3 / P4-4 で 4 度目: %fs の番地・不可分の命令・スレッドの生成（`fsaddr` / `atomic.*` / `fence` / `pause` / `clone`）— 段 6 P6-1 で
    # 5 度目（ハッシュ便 2026-10-09）: 積の上位 `mulhi`（map のハッシュ mum — string 鍵の map を使う entry は全部この語彙の外になる）
    # compiler/ 自身が std/par を使い始めて、コンパイラ自身の IR がこの語彙を越えた（stages の cross・errtrace の自己適用が踏んだ）
    grep -qE '= (fadd|fsub|fmul|fdiv|fsqrt|fofint|ftoint|feq|fne|flt|fle|fgt|fge|trap|fsaddr|atomic\.[a-z]+|clone|mulhi) |^ *(unwind|tswitch |tstart |fence|pause|fsaddr |atomic\.|clone )' "$1"
}

neg_beyond_stage1() { # $1 = 負例の entry（testdata/loader_neg/<名前>/app）。その負例の置き場に印 beyond_stage1（中身 = 理由）があれば 0 —
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

zig_frozen() { # obs_frozen から scripts/frozen/zig-excluded.list の entry を除く（タグ zig の列 — stage1 が建てられる凍結コーパス。G1）
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

excluded_keep() { # $1 = 生成し直した EXCLUDED、$2 = 黄金の EXCLUDED、$3 = 区切り（タブか ': '）。
    # 除外の集合（パス）は生成元の判定を正とし、理由の列は黄金に同じパスがあれば黄金の文面を保つ（理由は生成元の診断文 — Zig と Sober で文面が違う。
    # 集合が一致すればバイトも一致する）。結果を $1 に書き戻す
    [ -f "$2" ] || return 0
    awk -v sep="$3" 'NR == FNR { i = index($0, sep); if (i) old[substr($0, 1, i - 1)] = $0; next }
        { i = index($0, sep); k = i ? substr($0, 1, i - 1) : $0; print (k in old) ? old[k] : $0 }' "$2" "$1" > "$1.keep" && mv "$1.keep" "$1"
}
