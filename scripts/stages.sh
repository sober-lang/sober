#!/usr/bin/env bash
# ブートストラップ固定点のランナー（selfhost の R35 — 暫定固定点の正式化）。
#
#   scripts/stages.sh            stage1 → stage2 → stage3 → stage4を組み、固定点を検証し、続けてscripts/selfhost_cli.sh（stage2のCLIの差分オラクル）を回す
#   scripts/stages.sh --no-cli   固定点まで
#
# stage の定義（docs/design-dev.md selfhost 項の番号づけ）:
#   stage0  Zig ツールチェーン（zig build・zig cc）
#   stage1  Zig 製の sober（src/stage1/zig-out/bin/sober）— 信頼の根。恒久維持
#   boot    scripts/boot.commitの各行のコミットのcompiler/appを順にビルドしたもの（1行目はstage1で — ブートストラップチェーン、reaudit round 3、決定 (a)。
#           compiler/ が凍結した Zig の範囲を越えた言語で書けるようにする）
#   stage2  Sober で書いたコンパイラ（compiler/app — CLI）を最後の boot が正規バックエンドで ELF にしたもの（scripts/stage2.sh が作り、
#           out/stage2/ に置いて bin/sober・gates と共有する。2026-10-02 から .ll → zig cc を通らない — SOBER_O1 の列だけ zig cc -O1）
#   stage3  同じソースを stage2 が Sober の正規バックエンドで ELF にしたもの（`build --emit=elf --passes` — bin/sober の既定の形。B-5）
#   stage4  同じソースを stage3 が ELF にしたもの
# 固定点（B-5 2026-10-02 — バイナリ一致へ昇格。決定 (b) = 次の 2 つを常備）:
#   ① stage3 の ELF ≡ stage4 の ELF（Sober の系列の固定点）
#   ② stage3のELF ≡ stage1（凍結したZigの正規バックエンド）が同じIRテキスト（stage2の `--emit=ir --passes`）からビルドしたELF（独立な系列との交差照合 —
#      バグ分離の検査。elfeqの3形のpasses形をコンパイラ自身に掛けたもの）
# あわせて .llの固定点（stage2が吐く .ll ≡ stage3が吐く .ll — B-5までの暫定形）も残す（LLVM経路はstage2自身のビルドの手順 = scripts/stage2.shが使う）。
# おまけ（要求しない — 成り立てば強い）: 最後のbootがビルドしたstage2のELF ≡ stage2がビルドしたstage3のELF（起点から今までのlower / バックエンドの変更が
# コンパイラ自身のソースの出力を変えていない）。ブートストラップチェーンの前は「stage1 ≡ stage2」で必須だったが、lowerの正当な変更で崩れうるので表示だけにした。
# zig cc のELF（SOBER_O1の列のstage2・rawcheckの掛けない道具）は比べない（-O0のデバッグ情報が .llのファイル名を持つ）。比べるELFはSoberの正規バックエンドがビルドしたものだけ。
#
# ビルドの起点（仮決め R35-1）: compiler/ の package は compiler/ 相対で import し合い（ルート = cwd — 20 節）、std は `@embed("std/**/*.sober")`
# （ルート相対）で焼き込む。そこで作業ディレクトリにcompiler/* とリポジトリのstd/ のコピーを並べた木を組み、そこをcwdにしてbuildする
# （`std/` のimportは常にコンパイラの焼き込みから引かれる — コピーのstd/ は @embedの素材としてだけ読まれる）。
# あわせてstdの焼き込みと配置先が同じ中身を与えることを検証する（manifestのフェーズ — compiler/appの loader JSON と代表例のraw .ll。2026-10-04までは
# compiler/app 全体の raw .ll〔stage3raw.ll ≡ lldump〕）。
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
source scripts/gatelib.sh
# buildのキャッシュ（既定on）は無効のパスに固定（単体で回してもinst / RSSの上限値が温の値に化けない）
export SOBER_BUILD_CACHE=${SOBER_BUILD_CACHE:-0}
export SOBER_CHECK_CACHE=${SOBER_CHECK_CACHE:-0}
# lowerの分割（席A — 既定はW ≥ 2で分割）は直のパスに固定（W8の上限値とゴールデンを動かさない。既定のパスの検査はselfparがオプションを外して試す）
export SOBER_LOWER_SPLIT=${SOBER_LOWER_SPLIT:-1}

cli=1
[ "${1:-}" = "--no-cli" ] && cli=0
STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
ZIG=${ZIG:-zig}
[ -x "$STAGE1" ] || { echo "stages: $STAGE1 not found (zig build)"; exit 1; }
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
ll_cc() { "$ZIG" cc -target x86_64-linux-none -nostdlib -static -Wno-override-module -O0 "$1" -o "$2"; }
now() { date +%s.%N; }
dt() { awk -v a="$1" -v b="$2" 'BEGIN { printf "%.1f", b - a }'; }
T0=$(now)

# ── ビルドの木（compiler/* + std/ のコピー）──
B=$W/root
mkdir -p "$B"
cp -r src/compiler/. "$B/"
cp -r src/std "$B/std"

fail=0
# stage2: 共有の stage2（scripts/stage2.sh — 唯一の作り手。compiler/ + std/ + stage1 のハッシュが同じなら作り直さない — 主役交代 R39）
t=$(now)
S2=$(STAGE1=$STAGE1 scripts/stage2.sh) || { echo "stages: FAIL scripts/stage2.sh"; exit 1; }
cp "$S2" "$W/stage2"
echo "stage2: scripts/stage2.sh $(dt "$t" "$(now)")s (ELF $(stat -c %s "$W/stage2") bytes)"

# stage3: stage2 が正規バックエンドで ELF に（固定点の左辺）+ .ll（暫定形の固定点の左辺）
t=$(now)
(cd "$B" && "$W/stage2" build app --emit=elf --passes -o "$W/stage3") || { echo "stages: FAIL stage2 build of src/compiler/app (exit $?)"; exit 1; }
t1=$(now)
(cd "$B" && "$W/stage2" build app --emit=ll --passes -o "$W/stage3.ll") || { echo "stages: FAIL stage2 build of src/compiler/app (.ll)"; exit 1; }
t2=$(now)
echo "stage3: stage2 → ELF $(dt "$t" "$t1")s ($(stat -c %s "$W/stage3") bytes), → .ll $(dt "$t1" "$t2")s"
# 交差照合の相手: stage2のIRテキスト → stage1のbuild x.ir（背景で — 約5 s）。照合するstage2の側はコピーのバックエンド（--backend=copy —
# 性能投資 M4 の両持ち。既定の stage3 は最適化のバックエンドで stage1 は追えない）
( (cd "$B" && "$W/stage2" build app --emit=ir --passes -o "$W/stage3.ir") && "$STAGE1" build "$W/stage3.ir" -o "$W/stage3z" \
    && (cd "$B" && "$W/stage2" build app --emit=elf --passes --backend=copy -o "$W/stage3c") ) > "$W/cross.log" 2>&1 &
crosspid=$!
# 掛けない版（raw — 設計整合パスなし）: 同じstage2が掛けた / 掛けないの2通りにビルドしたcheckの経路の道具（sobercheck・desugardump）の出力の突き合わせ
# （scripts/rawcheck.sh — 背景で並べる・約 3.5 分）。STAGES_RAW=1（gates --all と単体実行）のときだけ回す
# （決定2026-09-29でELF化とコアASTを --all に回し、2026-10-04の決定でmanifestの相手からも外した — 下のmanifestのフェーズ）。
# 2026-10-19まではcompiler/app全体をrawでビルドしたstage3rawの `check --core-json` ≡ stage3だったが、rawの .llが6.1 GBに育ってclangの
# 4 GiB上限を越えた（report-891 / 893）→ 決定 (C2) 2026-10-20: checkの経路（loader + desugar + checker）の道具に縮めた（report-898 — テストの強さの差もそこに）
STAGES_RAW=${STAGES_RAW:-1}
if [ "$STAGES_RAW" != 0 ]; then
    scripts/rawcheck.sh "$W/stage2" "$B" "$W/raw" > "$W/raw.log" 2>&1 &
    rawpid=$!
fi
# manifest（stdの焼き込み〔stage2の @embed〕と配置先〔Manifest暫定 — std/ を読む〕が同じ中身を与えること — 1対の事実の確認）: 2つで見る（背景で）
#   ① compiler/app の loader JSON（stage2 `parse --loader-json` ≡ loaderdump）— std 13 package 全部の package・関数・呼び先の構造
#   ② std を使う代表例の raw .ll（stage2 `build` ≡ lldump — std の関数の本体まで。各 std package を 1 本以上が触る）
# 2026-10-04まで = compiler/app全体のraw .ll（stage3raw.ll ≡ lldump — 1.6 GB × 2本・約2分）。落ちたテストの強さ = compiler/appから届くstdの関数のうち
# 代表例が触らないものの本体の差（① は構造まで）と、boot の lower と stage2 の lower の同じ入力への出力の一致（巨大な入力での差分照合 — 固定点
# stage3 ≡ stage4 と elfeq が別の形で持つ）
MREPS="examples/hash_sha256.sober examples/layout_elf.sober examples/os_fs.sober examples/pool.sober examples/rand_xoshiro.sober examples/strings_std.sober examples/bytes_scalar.sober examples/parser_b.sober examples/errparse_file.sober"
(
    tool_bin loaderdump "$W/loaderdump" || exit 1
    tool_bin lldump "$W/lldump" || exit 1
    # Manifestの形（loaderdumpと同じ）: 1行目entry、2行目stdの配置先（std/ を含むディレクトリ）、以降cwd相対のファイル一覧（ファイル名順）
    (cd "$B" && { echo app; echo .; { find . -name '*.sober' -type f -not -path './std/*' | sed 's|^\./||'; find std -name '*.sober' -type f; } | LC_ALL=C sort; } > "$W/manifest.txt")
    (cd "$B" && "$W/stage2" parse --loader-json app) > "$W/manifest.embed.json" 2> "$W/manifest.err"
    (cd "$B" && "$W/loaderdump" < "$W/manifest.txt") > "$W/manifest.disk.json" 2>> "$W/manifest.err"
    : > "$W/manifest.ll.log"
    # 配置先の根は「stdとexamplesを並べた木」（src/ への移動の後 — 根の名前がpanicの位置の表〔rt.psites〕のファイルの番号に入るので、
    # 焼き込みと同じ std/… の綴りになる根を symlink で組む）
    mkdir -p "$W/mroot" && ln -sfn "$ROOT/src/std" "$W/mroot/std" && ln -sfn "$ROOT/examples" "$W/mroot/examples"
    for e in $MREPS; do
        k=$(basename "$e" .sober)
        (cd "$W/mroot" && { echo "$e"; echo .; { echo "$e"; find -L std -name '*.sober' -type f; } | LC_ALL=C sort; }) > "$W/m.$k.txt"
        (cd "$W/mroot" && "$W/stage2" build "$e" --emit=ll -o "$W/m.$k.embed.ll") 2>> "$W/manifest.err"
        (cd "$W/mroot" && "$W/lldump" < "$W/m.$k.txt") > "$W/m.$k.disk.ll" 2>> "$W/manifest.err"
        if [ -s "$W/m.$k.embed.ll" ] && cmp -s "$W/m.$k.embed.ll" "$W/m.$k.disk.ll"; then echo "ok $k" >> "$W/manifest.ll.log"; else echo "DIFF $k" >> "$W/manifest.ll.log"; fi
    done
    exit 0
) &
manpid=$!

# コンパイラ自身の型検査（Lean の判定 = stage2 の脱糖したコア AST を sober-check へ・stage2 = Sober 版の検査器 — 同じ判定 JSON で受理）。
# ブートストラップチェーンの前はstage1の脱糖 → Leanだったが、compiler/ はstage1の範囲を越えうるのでstage2の脱糖に替えた
SOBER_CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
t=$(now)
(cd "$B" && "$W/stage2" check app --core-json > "$W/core.json" && "$SOBER_CHECK" < "$W/core.json") > "$W/check1" 2> /dev/null
c1=$?
(cd "$B" && "$W/stage2" check app) > "$W/check2" 2> /dev/null
c2=$?
echo "time: check of src/compiler/app (stage2 core JSON → Lean + stage2 check) $(dt "$t" "$(now)")s"
if [ "$c1" = 0 ] && [ "$c2" = 0 ] && cmp -s "$W/check1" "$W/check2"; then
    echo "check: src/compiler/app は Lean でも stage2 の検査器でも受理（$(cat "$W/check2")）"
else
    echo "FAIL: check of src/compiler/app — Lean exit $c1 $(head -c 80 "$W/check1") / stage2 exit $c2 $(head -c 80 "$W/check2")"; fail=1
fi

# hermetic: std/ の無いcwdでstdをimportするプログラムをstage2がbuild / checkできる（keysmのフェーズ — stdの一覧も焼き込みの表のキーから）。
# 実行の出力が期待どおりであること（byteのステージS4まで = .llがZig版とバイト一致。S4でstringの表現が凍結Zigと分かれたので実行の照合へ — S5）
H=$W/nostd
mkdir -p "$H"
printf 'package main\n\nimport "std/strings"\n\nfunc main() {\n    x := 7\n    println("v=${x}")\n    println(strings.Index("hello", "ll"))\n}\n' > "$H/p.sober"
if (cd "$H" && "$W/stage2" build p.sober --emit=ll -o "$W/nostd2.ll") && ll_cc "$W/nostd2.ll" "$W/nostd2" \
    && [ "$("$W/nostd2")" = "$(printf 'v=7\n2')" ] && (cd "$H" && "$W/stage2" check p.sober > /dev/null); then
    echo "hermetic: std/ の無い cwd で stage2 が std を import して build / check（実行の出力が期待どおり）"
else
    echo "FAIL: hermetic — stage2 は std/ の無い cwd で std を引けない"; fail=1
fi

# stage4: stage3 で ELF と .ll（固定点の右辺）。ELF の build は出荷の形（IR の検証器は最後に 1 回 — gates が export する SOBER_VERIFY=each を外す）で
# ビルドする: 下のRSSのラチェットはbench.shのself/buildと同じ形で測る（ステージごとの検証器は自己buildのpeakを約60 MB押し上げ、ラチェットの際で
# 揺れていた — 段階6 P6-4。同じソースのステージごとの検証はstage3のbuild〔stage2 → stage3〕が掛けている）
# 同じ build を perf stat で包んで命令数（instructions:u — 決定的）も取る: 下の inst のラチェット（report-780 / 781 — inst は検問の外で
# 734 以降 20 本強のコミットの間 +4.3 G 超過したまま誰も見ていなかった）。ワーカー 1・種 0 を明示（gates の export と同じ — 単体で回しても同じ値）。
# perf が無い・使えない環境では命令数だけ飛ばす（RSS は従来どおり）
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2> /dev/null | head -n 1)}
INSTP=()
if [ -n "$PERF" ] && "$PERF" stat -x, -e instructions:u -o /dev/null true > /dev/null 2>&1; then
    INSTP=("$PERF" stat -x, -e instructions:u -o "$W/stage4.inst")
fi
t=$(now)
(cd "$B" && env -u SOBER_VERIFY SOBER_WORKERS=1 SOBER_HASH_SEED=0 "$W/stage3" build app --emit=elf --passes -o "$W/stage4") || { echo "stages: FAIL stage3 build of src/compiler/app"; exit 1; }
t1=$(now)
(cd "$B" && "$W/stage3" build app --emit=ll --passes -o "$W/stage4.ll") || { echo "stages: FAIL stage3 build of src/compiler/app (.ll)"; exit 1; }
echo "stage4: stage3 → ELF $(dt "$t" "$t1")s, → .ll $(dt "$t1" "$(now)")s"
# ラチェットの基準（self/build3 inst / rss — ユーザー承認2026-10-18・report-789）: compiler/appはstdの全部を `@embed` で自分に焼き込むので、
# compilerが使わないstdを足すだけで自己buildの仕事が伸びる（≈ 10.7 M命令 / KB — report-791 3 節）。上限値の目的（コンパイラの退行の検出）に合わせ、
# 測りは「compilerのimportが推移的に依存するstdのpackageだけを残した木」の自己build（同じstage3・同じ形）にする。推移的に依存するstd（iter / table / strings …）と
# compiler自身の仕事・計算量の退行はそのまま鳴り、推移的な依存の外のstdの伸び（焼き込みのオーバーヘッドだけ）は鳴らない。stage4の固定点は全部の木のまま
M=$W/meas
t=$(now)
mkdir -p "$M"
tar -C "$B" --exclude=./std -cf - . | tar -C "$M" -xf - || { echo "stages: FAIL meas tree"; exit 1; }
for p in $( (cd "$B" && "$W/stage3" parse --loader-json app) | grep -o '"path": "std/[^"]*"' | sed 's/.*"\(std\/[^"]*\)"/\1/' | sort -u); do
    mkdir -p "$M/$p" && find "$B/$p" -maxdepth 1 -type f -exec cp {} "$M/$p/" \;
done
[ -d "$M/std" ] || { echo "stages: FAIL meas tree (no std package in the import closure)"; exit 1; }
(cd "$M" && env -u SOBER_VERIFY SOBER_WORKERS=1 SOBER_HASH_SEED=0 /usr/bin/time -f %M -o "$W/stage4.rss" "${INSTP[@]}" "$W/stage3" build app --emit=elf --passes -o "$W/stage4m") || { echo "stages: FAIL stage3 build of the meas tree"; exit 1; }
echo "time: meas tree + stage3 build of it $(dt "$t" "$(now)")s"
echo "meas: $(cd "$M" && find std -name '*.sober' | wc -l) std files in the import closure ($(cd "$B" && find std -name '*.sober' | wc -l) in the tree)"

# RSSのラチェット（bench/ratchet.txtのself/build3 rss — 推移的に依存するstdだけの木の自己buildのpeak RSS〔上の基準〕。stage3 = 今のソースを今の最適化でビルドしたコンパイラ。
# self/build rssはbench.shの基準〔stage2 × 全部の木 — stdの焼き込みを含む〕で、stagesは照合しない）
rlim=$(awk '$1 == "self/build3" && $2 == "rss" { print $3 }' "$ROOT/bench/ratchet.txt")
rss=$(( $(cat "$W/stage4.rss") / 1024 ))
if [ -n "$rlim" ] && [ "$rss" -gt "$rlim" ]; then
    echo "FAIL: ratchet — stage3 の自己 build の peak RSS ${rss} MB > ${rlim} MB（bench/ratchet.txt）"; fail=1
else
    echo "ratchet: stage3 の自己 build の peak RSS ${rss} MB ≤ ${rlim} MB"
fi
# 命令数のラチェット（bench/ratchet.txt の self/build3 inst — stage3 の自己 build の instructions:u・G。bench.sh の self/build inst は
# out/stage2〔bootがビルドしたもの〕の基準で約0.8 G多い — 2本立てで残し、照合はこちら。鳴ったらscripts/inst/ の2×2で木の仕事と退行を分ける）
ilim=$(awk '$1 == "self/build3" && $2 == "inst" { print $3 }' "$ROOT/bench/ratchet.txt")
if [ "${#INSTP[@]}" = 0 ]; then
    echo "SKIP inst ratchet — perf が無いか使えない（PERF で perf の実行ファイルを指す）: 自己 build の命令数は照合していない"
elif [ -n "$ilim" ]; then
    inst=$(awk -F, '/instructions/ { printf "%.3f", $1 / 1e9 }' "$W/stage4.inst")
    if awk -v v="$inst" -v l="$ilim" 'BEGIN { exit !(v > l) }'; then
        echo "FAIL: ratchet — stage3 の自己 build の命令 ${inst} G > ${ilim} G（bench/ratchet.txt — scripts/inst/README.md の 2×2 で切り分け）"; fail=1
    else
        echo "ratchet: stage3 の自己 build の命令 ${inst} G ≤ ${ilim} G"
    fi
fi
# ELFの大きさのラチェット（bench/ratchet.txtのself/elf size — 推移的に依存するstdだけの木の自己buildのELF〔stage4m — 上の命令 / RSSと同じ基準。
# 推移的な依存の外のstdの焼き込みは鳴らない — report-827〕・MB = 10^6バイト。展開の膨張の検査 — report-465）
elim=$(awk '$1 == "self/elf" && $2 == "size" { print $3 }' "$ROOT/bench/ratchet.txt")
esz=$(stat -c %s "$W/stage4m")
if [ -n "$elim" ] && awk -v v="$esz" -v l="$elim" 'BEGIN { exit !(v > l * 1000000) }'; then
    echo "FAIL: ratchet — 閉包の木の自己 build の ELF ${esz} バイト > ${elim} MB（bench/ratchet.txt）"; fail=1
else
    echo "ratchet: 閉包の木の自己 build の ELF ${esz} バイト ≤ ${elim} MB（全部の木の stage3 = $(stat -c %s "$W/stage3") バイト — 参考）"
fi
if cmp -s "$W/stage3" "$W/stage4"; then
    echo "fixed point (binary): stage3 の ELF ≡ stage4 の ELF ($(stat -c %s "$W/stage3") bytes)"
else
    echo "NO FIXED POINT: stage3 の ELF ≠ stage4 の ELF ($(cmp "$W/stage3" "$W/stage4" 2>&1 | head -1))"; fail=1
fi
crossrc=0
t=$(now)
wait "$crosspid" || crossrc=$?
echo "time: waited for the cross-check builds (background) $(dt "$t" "$(now)")s"
if [ "$crossrc" != 0 ] && [ -s "$W/stage3.ir" ] && beyond_stage1 "$W/stage3.ir"; then
    # compiler/ 自身のIRがstage1のIRの語彙を越えた（段階6 P6-1 — compiler/ がstd/taskを使う）: stage1との交差照合はコンパイラ自身には掛からない。
    # コピーのバックエンドとstage1の一致はexamplesのelfeq（stage1の語彙の内のentry）が持つ（「Zig ≡ Soberの差分は凍結コーパスだけで見る」の規約どおり）
    echo "cross: skipped — compiler/ の IR が stage1 の語彙を越える（std/task — beyond_stage1）。写しのバックエンドの照合は elfeq が持つ"
elif [ "$crossrc" != 0 ]; then
    echo "FAIL: cross — stage1 が stage2 の IR テキストから ELF を建てられない: $(head -c 300 "$W/cross.log")"; fail=1
elif cmp -s "$W/stage3c" "$W/stage3z"; then
    echo "cross: stage3（--backend=copy）の ELF ≡ stage1 が同じ IR テキストから建てた ELF"
else
    echo "FAIL: cross — stage3（--backend=copy）の ELF ≠ stage1 の ELF ($(cmp "$W/stage3c" "$W/stage3z" 2>&1 | head -1))"; fail=1
fi
if cmp -s "$W/stage3.ll" "$W/stage4.ll"; then
    echo "fixed point: stage2 の .ll ≡ stage3 の .ll ($(stat -c %s "$W/stage3.ll") bytes)"
else
    echo "NO FIXED POINT: stage3.ll ≠ stage4.ll"; fail=1
fi
if cmp -s "$W/stage2" "$W/stage3"; then
    echo "bonus: 最後の boot が建てた stage2 の ELF ≡ stage3 の ELF（鎖 $(grep -v '^#' bootstrap/chain.txt | awk 'NF{print $1}' | tr -s '\n' ' ')）"
else
    echo "note: stage2 の ELF ≠ stage3 の ELF（起点からの lower / バックエンドの変更がコンパイラ自身の出力を変えた、または stage2 が zig cc の列 — 固定点は上の stage3 ≡ stage4 が正）"
fi

# 設計整合パスの守り: 掛けた / 掛けないの check の経路の道具が同じ出力を吐く（scripts/rawcheck.sh — 上で背景に起動）
if [ "$STAGES_RAW" = 0 ]; then
    echo "passes: 掛けた / 掛けないの check の経路の突き合わせは省略（STAGES_RAW=0 — gates --all と単体実行で回る）"
elif ! wait "$rawpid"; then
    echo "FAIL: passes — $(grep -a 'rawcheck: FAIL' "$W/raw.log" | head -c 300 || head -c 300 "$W/raw.log")"; fail=1
else
    echo "passes: $(tail -1 "$W/raw.log" | sed 's/^rawcheck: //')"
fi

t=$(now)
wait "$manpid" || { echo "stages: FAIL build src/compiler/tools/loaderdump / lldump"; exit 1; }
echo "time: waited for the manifest builds (background) $(dt "$t" "$(now)")s"
if [ -s "$W/manifest.embed.json" ] && cmp -s "$W/manifest.embed.json" "$W/manifest.disk.json"; then
    echo "manifest: src/compiler/app の loader JSON — 焼き込みの std ≡ 置き場の std（$(stat -c %s "$W/manifest.embed.json") bytes）"
else
    echo "FAIL: manifest — src/compiler/app の loader JSON が焼き込み / 置き場で違う: $(head -c 200 "$W/manifest.err")"; fail=1
fi
if grep -q '^DIFF' "$W/manifest.ll.log" || [ "$(grep -c '^ok' "$W/manifest.ll.log")" != "$(echo $MREPS | wc -w)" ]; then
    echo "FAIL: manifest — 代表例の raw .ll が焼き込み / 置き場で違う: $(grep -v '^ok' "$W/manifest.ll.log" | tr '\n' ' ')"; fail=1
else
    echo "manifest: 代表例 $(grep -c '^ok' "$W/manifest.ll.log") 本の raw .ll — stage2（焼き込みの std）≡ lldump（置き場の std）"
fi
# 非干渉の検査（errnonint — report-1285 / 1286・PINSの「非干渉の検査」の最初の実装）: 組み込みerrorの先頭ラベルは閉世界の全ラベルのunionなので、
# stringフィールドのラベルを1つ足すだけで全部のerrorの境界コピーがその場でvariantごとに膨らんでいた（自己build +35% — std/cliの10個）。
# 題材（testdata/errnonint）と、同じpackageにstringフィールドのラベル1個（probe.sober.txt）を足した版をstage3でIRにし、両方にある利用者の関数の
# 境界コピー（region.relocate / rt.region_relocate8 / rt.err_relocate の呼び出し）の数が一致すること（rt.* は比べない — 補助の本体はラベルで伸びてよい）。
# 値の幅（unionの幅 = 最大のvariant）によるコピーの語数の差は対象外（表現の性質 — report-1286）
EN=$W/errnonint
t=$(now)
mkdir -p "$EN/a" "$EN/b"
cp testdata/errnonint/main.sober "$EN/a/" && cp testdata/errnonint/main.sober "$EN/b/" && cp testdata/errnonint/probe.sober.txt "$EN/b/probe.sober"
encnt() { awk '/^func /{ n = $2; sub(/\(.*/, "", n) } n !~ /^@rt\./ && /region\.relocate |call @rt\.region_relocate8|call @rt\.err_relocate/{ c[n]++ } END { for (k in c) print k, c[k] }' "$1" | sort; }
if (cd "$EN" && SOBER_WORKERS=1 "$W/stage3" build a --emit=ir --passes -o a.ir && SOBER_WORKERS=1 "$W/stage3" build b --emit=ir --passes -o b.ir); then
    encnt "$EN/a.ir" > "$EN/a.cnt"; encnt "$EN/b.ir" | grep -v '^@main\.probe ' > "$EN/b.cnt"
    if [ -s "$EN/a.cnt" ] && cmp -s "$EN/a.cnt" "$EN/b.cnt"; then
        echo "errnonint: $(wc -l < "$EN/a.cnt") functions — boundary copies unchanged by a string-field error label"
    else
        echo "FAIL: errnonint — string 欄の error ラベル 1 個で利用者の関数の境界コピーが変わった: $(diff "$EN/a.cnt" "$EN/b.cnt" | grep '^[<>]' | tr '\n' ' ')"; fail=1
    fi
else
    echo "FAIL: errnonint — 題材が建たない"; fail=1
fi
echo "time: errnonint $(dt "$t" "$(now)")s"
echo "stages: total $(dt "$T0" "$(now)")s"

if [ "$cli" = 1 ] && [ "$fail" = 0 ]; then
    t=$(now)
    STAGE2="$W/stage2" scripts/selfhost_cli.sh || fail=1
    echo "time: selfhost_cli $(dt "$t" "$(now)")s"
fi
[ "$fail" = 0 ] && echo "stages: ok" || echo "stages: FAIL"
exit $fail
