# env.sh — wave.sh / layer.sh / layer4.sh の共通の置き場（source して使う — report-680・681 で .pair/tools/http から移設）。計器は環境変数で渡す:
#   HTTP_TOOLS  計器の置き場（gcannon = $HTTP_TOOLS/gc/gcannon/gcannon・要求の raw = $HTTP_TOOLS/req — 無ければ $HTTP_TOOLS/arena-dl/req）
#   GCANNON / ARENA_REQ  個別に上書き（既定 = HTTP_TOOLS から。HTTP_TOOLS も無ければ PATH の gcannon）。gcannon の建て方は
#               .github/workflows/httparena.yml の「Build gcannon」・raw は HttpArena の requests/*.raw（local.sh と同じ取得元）
#   HTTP_WORK   作業ファイル（サーバの出力・perf の数・wave の各回）の置き場（既定 = 使い捨ての mktemp -d）
S=${HTTP_TOOLS:-}
GC=${GCANNON:-$( [ -n "$S" ] && echo "$S/gc/gcannon/gcannon" || command -v gcannon)}
R=${ARENA_REQ:-$( [ -d "$S/req" ] && echo "$S/req" || echo "$S/arena-dl/req")}
[ -x "$GC" ] || { echo "$(basename "$0"): gcannon not found (${GC:-none}) — set HTTP_TOOLS or GCANNON（建て方は .github/workflows/httparena.yml の Build gcannon）" >&2; exit 2; }
[ -f "$R/get.raw" ] || { echo "$(basename "$0"): $R/get.raw not found — set HTTP_TOOLS or ARENA_REQ（HttpArena の requests/*.raw）" >&2; exit 2; }
W=${HTTP_WORK:-$(mktemp -d)}
mkdir -p "$W"
