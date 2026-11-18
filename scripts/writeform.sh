#!/usr/bin/env bash
# writeform: 同じ意味の書き方は同じ判定になることの検査（本体は scripts/writeform.ts・題材は testdata/writeform/）。
#   scripts/writeform.sh [--show]
set -uo pipefail
cd "$(dirname "$0")/.."
export STAGE2=${STAGE2:-$PWD/out/stage2/sober2}
exec node --experimental-strip-types scripts/writeform.ts "$@"
