# env.sh — wave.sh / layer.sh / layer4.shの共通の配置先（sourceして使う — report-680・681で .pair/tools/httpから移設）。計測ツールは環境変数で渡す:
#   HTTP_TOOLS  計測ツールの配置先（gcannon = $HTTP_TOOLS/gc/gcannon/gcannon・リクエストのraw = $HTTP_TOOLS/req — 無ければ $HTTP_TOOLS/arena-dl/req）
#   GCANNON / ARENA_REQ  個別に上書き（既定 = HTTP_TOOLSから。HTTP_TOOLSも無ければPATHのgcannon）。gcannonのビルド方法は
#               .github/workflows/httparena.yml の「Build gcannon」・raw は HttpArena の requests/*.raw（local.sh と同じ取得元）
#   HTTP_WORK   作業ファイル（サーバの出力・perfの数・waveの各回）の配置先（既定 = 使い捨てのmktemp -d）
S=${HTTP_TOOLS:-}
GC=${GCANNON:-$( [ -n "$S" ] && echo "$S/gc/gcannon/gcannon" || command -v gcannon)}
R=${ARENA_REQ:-$( [ -d "$S/req" ] && echo "$S/req" || echo "$S/arena-dl/req")}
[ -x "$GC" ] || { echo "$(basename "$0"): gcannon not found (${GC:-none}) — set HTTP_TOOLS or GCANNON（建て方は .github/workflows/httparena.yml の Build gcannon）" >&2; exit 2; }
[ -f "$R/get.raw" ] || { echo "$(basename "$0"): $R/get.raw not found — set HTTP_TOOLS or ARENA_REQ（HttpArena の requests/*.raw）" >&2; exit 2; }
W=${HTTP_WORK:-$(mktemp -d)}
mkdir -p "$W"
