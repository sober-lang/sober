#!/usr/bin/env bash
# dudect（定数時間の統計の検査 — effect のマイルストーン 段階3d・report-981 3 節 / 985）: std/internal/dudectの題材（_test.soberのTestXxx）を `sober test` の経路でビルドして
# 1 本ずつ直列に走らせ、各回の (クラス, cycles) を Welch の t で集計する（scripts/dudect.ts — 上位の切りつき・判定は |t| の最大値 > 4.5 で漏れ）。
# 名前がneg_ の題材は負例（早く抜ける比較 — 漏れを捕まえることが検査の証明）: 漏れと出なければ赤。
# 運用: gatesに入れない（時間の揺れで偽赤が出る検査は常設にしない — wave.shの前例）。暗号のタスクの仕上げ（ctcheck / cryptocheckの後）に手で回す。
#   scripts/dudect.sh [回数（既定 1000000）] [--run <接頭辞>]
#   DUDECT_RUN="<接頭辞> <接頭辞>…" scripts/dudect.sh [回数]   複数の接頭辞（題材の TestXxx の名前の頭 — 1 つずつ `sober test --run` で走らせて繋ぐ）
# 記録: DUDECT_TSV=<書く先>（bench/data/dudect.tsvの形 — 1題材1行を追記）・DUDECT_ENV=<マシンの名>（既定wsl2）。日付と木のコミットはここで埋める
# 生の記録: DUDECT_RAW=<書く先.gz>（「<名前> <クラス> <cycles>」を呼び出しの順に1行ずつgzip — 分位点ごとの解析〔比が一定 = 周波数の形 / 差が一定 = 命令の形〕を手元で読むインターフェース・report-1026）
# 名前が exp_ の題材は対照実験（scripts/dudect.ts が判定を印字するが失敗にしない — report-1026）
# 題材のpackage: DUDECT_PKGS（既定 = std/internal/dudect〔公開のインターフェース・負例・対照〕+ std/crypto/poly1305〔Sumの段割り — white-boxの _test・report-1028〕+
# std/crypto/rsa〔ウィンドウの表引きmmsel・2乗のチャンクmontsqr — white-boxの _test〕+ std/internal/record〔0埋めの剥がしstrip — white-boxの _test〕+
# std/crypto/password〔PBKDF2 の核 — white-box の _test〕+ std/session〔Open のタグの比較と鍵 — white-box の _test〕+ std/internal/p256〔ECDHE のスカラー倍 — white-box の _test〕）
# マシンの名: TSVのenvの列は「<DUDECT_ENV>/<CPUの型番の短縮>」（例: gha-linux-x64-16vcpu/EPYC-9V74 — GHAのマシンはCPUの世代が混ざる・report-1027）。
# 型番はDUDECT_CPU（lscpuの Model name の文字列 — workflowがenvの記録から渡す）か、無ければこのマシンのlscpu
set -uo pipefail
cd "$(dirname "$0")/.."
N=${1:-1000000}
shift || true
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
PKGS=${DUDECT_PKGS:-std/internal/dudect std/crypto/poly1305 std/crypto/rsa std/internal/record std/crypto/password std/session std/internal/p256}
if [ -n "${DUDECT_RUN:-}" ]; then
    : > "$W/out"
    for p in $DUDECT_RUN; do
        SOBER_DUDECT=$N bin/sober test $PKGS --run "$p" >> "$W/out" || { grep -v '^dudect' "$W/out"; echo "dudect: FAIL run ($p)"; exit 1; }
    done
else
    SOBER_DUDECT=$N bin/sober test $PKGS "$@" > "$W/out" || { grep -v '^dudect' "$W/out"; echo "dudect: FAIL run"; exit 1; }
fi
CPU=${DUDECT_CPU:-$(lscpu 2> /dev/null | sed -n 's/^Model name: *//p' | head -n 1)}
CPU=$(echo "$CPU" | sed -E 's/\((R|TM)\)//g; s/^(AMD|Intel) +//; s/ +[0-9]+-Core Processor.*//; s/ +(w\/|CPU @).*//; s/ +Processor$//; s/ +$//; s/ +/-/g')
[ -n "${DUDECT_RAW:-}" ] && awk '$1 == "dudect" && NF == 4 { print $2, $3, $4 }' "$W/out" | gzip -c > "$DUDECT_RAW"
DUDECT_ENV=${DUDECT_ENV:-wsl2}/${CPU:-unknown} DUDECT_DATE=$(date +%Y-%m-%d) DUDECT_COMMIT=$(git rev-parse --short=8 HEAD)$(git diff --quiet HEAD -- src scripts || echo +) node --experimental-strip-types scripts/dudect.ts < "$W/out"
