#!/usr/bin/env bash
# 別 package の名前付き関数型の網: 署名が宣言側の package の型を含む名前付き関数型（testdata/fnpkg/p の F・G[T]）を、別 package（app）の
# 値の位置（Def の結果・仮引数・struct の欄）とジェネリックの型引数つきで使う題材を、check が受理し・build した実行ファイルの出力が
# testdata/fnpkg/app.out と一致する（署名の型名を参照側の package で引くと、check は UnknownName・build は UndefinedType で割れていた）
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
"$SOBER" check testdata/fnpkg/app > "$W/c" 2>&1 || { echo "FAIL: check rejects testdata/fnpkg/app: $(tail -1 "$W/c")"; fail=1; }
for w in 1 8; do
    SOBER_WORKERS=$w "$SOBER" build testdata/fnpkg/app -o "$W/a$w" > "$W/b" 2>&1 || { echo "FAIL: build W$w: $(tail -1 "$W/b")"; fail=1; continue; }
    "$W/a$w" > "$W/o$w" 2>&1
    cmp -s "$W/o$w" testdata/fnpkg/app.out || { echo "FAIL: W$w output differs from testdata/fnpkg/app.out"; diff testdata/fnpkg/app.out "$W/o$w" | head -5; fail=1; }
done
[ "$fail" = 0 ] && echo "PASS: fnpkg (check + build of a named function type from another package)" || exit 1
