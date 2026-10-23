#!/usr/bin/env bash
# dudect（定数時間の統計の網 — effect の波 段 3d・report-981 3 節 / 985）: std/internal/dudect の題材（_test.sober の TestXxx）を `sober test` の経路で建てて
# 1 本ずつ直列に走らせ、各回の (クラス, cycles) を Welch の t で集計する（scripts/dudect.ts — 上位の切りつき・判定は |t| の最大値 > 4.5 で漏れ）。
# 名前が neg_ の題材は負例（早く抜ける比較 — 漏れを捕まえることが網の証明）: 漏れと出なければ赤。
# 運用: gates に入れない（時間の揺れで偽赤が出る網は常設にしない — wave.sh の前例）。暗号の便の締め（ctcheck / cryptocheck の後）に手で回す。
#   scripts/dudect.sh [回数（既定 1000000）] [-run <接頭辞>]
#   DUDECT_RUN="<接頭辞> <接頭辞>…" scripts/dudect.sh [回数]   複数の接頭辞（題材の TestXxx の名前の頭 — 1 つずつ `sober test -run` で走らせて繋ぐ）
# 記録: DUDECT_TSV=<書く先>（bench/data/dudect.tsv の形 — 1 題材 1 行を追記）・DUDECT_ENV=<箱の名>（既定 wsl2）。日付と木のコミットはここで埋める
# 生の記録: DUDECT_RAW=<書く先.gz>（「<名前> <クラス> <cycles>」を呼び出しの順に 1 行ずつ gzip — 分位点ごとの解析〔比が一定 = 周波数の形 / 差が一定 = 命令の形〕を手元で読む口・report-1026）
# 名前が exp_ の題材は対照実験（scripts/dudect.ts が判定を印字するが失敗にしない — report-1026）
# 題材の package: DUDECT_PKGS（既定 = std/internal/dudect〔公開の口・負例・対照〕+ std/crypto/poly1305〔Sum の段割り — white-box の _test・report-1028〕）
# 箱の名: TSV の env の列は「<DUDECT_ENV>/<CPU の型番の短縮>」（例: gha-linux-x64-16vcpu/EPYC-9V74 — GHA の箱は CPU の世代が混ざる・report-1027）。
# 型番は DUDECT_CPU（lscpu の Model name の文字列 — workflow が env の記録から渡す）か、無ければこの箱の lscpu
set -uo pipefail
cd "$(dirname "$0")/.."
N=${1:-1000000}
shift || true
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
PKGS=${DUDECT_PKGS:-std/internal/dudect std/crypto/poly1305}
if [ -n "${DUDECT_RUN:-}" ]; then
    : > "$W/out"
    for p in $DUDECT_RUN; do
        SOBER_DUDECT=$N bin/sober test $PKGS -run "$p" >> "$W/out" || { grep -v '^dudect' "$W/out"; echo "dudect: FAIL run ($p)"; exit 1; }
    done
else
    SOBER_DUDECT=$N bin/sober test $PKGS "$@" > "$W/out" || { grep -v '^dudect' "$W/out"; echo "dudect: FAIL run"; exit 1; }
fi
CPU=${DUDECT_CPU:-$(lscpu 2> /dev/null | sed -n 's/^Model name: *//p' | head -n 1)}
CPU=$(echo "$CPU" | sed -E 's/\((R|TM)\)//g; s/^(AMD|Intel) +//; s/ +[0-9]+-Core Processor.*//; s/ +(w\/|CPU @).*//; s/ +Processor$//; s/ +$//; s/ +/-/g')
[ -n "${DUDECT_RAW:-}" ] && awk '$1 == "dudect" && NF == 4 { print $2, $3, $4 }' "$W/out" | gzip -c > "$DUDECT_RAW"
DUDECT_ENV=${DUDECT_ENV:-wsl2}/${CPU:-unknown} DUDECT_DATE=$(date +%Y-%m-%d) DUDECT_COMMIT=$(git rev-parse --short=8 HEAD)$(git diff --quiet HEAD -- src scripts || echo +) node --experimental-strip-types scripts/dudect.ts < "$W/out"
