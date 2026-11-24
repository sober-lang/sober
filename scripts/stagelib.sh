# stagelib: コンパイラ自身をビルドする手順の共通の部分（scripts/stage2.sh・scripts/stage3.sh・scripts/stages.shがsourceする）。
# 配るstage3（release）と、固定点を確かめるstage3（stages）を、同じ関数で作るために1か所に置く。
#
#   stage_tree <木>                    compiler/* とstd/を木に写す（compiler/appのimportは木のルートからの相対）
#   stage_l0 <コンパイラ> <木> <作業>   stdの全packageの.sobiを<木>/l0に書く（compiler/appが @embedで取り込むL0）
#   stage_build <コンパイラ> <木> <出力>  <木>のcompiler/appを正規バックエンドでELFに（bin/soberの既定の形）
#   stage_bake <コンパイラ> <木> <作業>  後段の関数キャッシュの値を<木>/bake/001.pack に（<コンパイラ>は<木>と同じソース・同じ鍵で建てた仮の形）

stage_tree() {
    mkdir -p "$1"
    cp -r "$ROOT/src/compiler/." "$1/"
    cp -r "$ROOT/src/std" "$1/std"
}

# stdの全package（入れ子のstd/hash/crc32なども。.soberのある全ディレクトリ）をimportする合成のmainをcheckさせ、.sobiを<木>/l0に置く。
# std/internal/… はstdの中からだけimportできる（language.md 20節。この合成のmainはstdの外）ので列挙から外す。internalのpackageは、使うstdのpackageを通して読まれる。
# std/testing/cellもテストの構成のファイルからだけimportできる（41節）ので外す。テストのビルドがソースから読む。
# 失敗したら、checkの出力（どこが落ちたか）と、def errorの位置を引く手順の結果を見せる
stage_l0() {
    local cc=$1 root=$2 w=$3 e=$3/l0all.sober d
    { echo "package main"; echo; for d in $(cd "$root" && find std -name '*.sober' ! -name '*_test.sober' ! -path 'std/internal/*' ! -path 'std/testing/cell/*' -printf '%h\n' | sort -u); do echo "import \"$d\""; done; echo; echo "func main() {"; echo "}"; } > "$e"
    SOBER_CACHE= SOBER_L0=0 "$cc" check "$e" --split --l0-out "$root/l0" > "$w/l0.out" 2>&1 || {
        echo "stagelib: FAIL L0 bake (std check):" >&2
        cat "$w/l0.out" >&2
        SOBER_CACHE= SOBER_L0=0 "$cc" check "$e" --def-index 2>&1 | tail -3 >&2
        return 1
    }
}

stage_build() {
    (cd "$2" && "$1" build app --emit=elf --passes -o "$3")
}

# 焼き込み（cold81）: 仮のコンパイラ（同じ木から L0 つきで建てたもの）で scripts/bake.list の例題を空の置き場へ順にビルドし、パックを1本にまとめて（索引を1か所に —
# 散ると読み込みで常駐が増える・report-cold-11）作業の木の bake/001.pack に置く。本番は同じソース・同じ鍵（selfkey）で建てるので、仮のコンパイラの値がそのまま当たる。
# 書くのは std と rt の関数・std のファイル・std の package の値だけ（SOBER_BAKE_STD=1 — 例題自身の値は利用者のプログラムにほとんど当たらない・report-cold-10）。
# 例題は検証モード（SOBER_CACHE_VERIFY=1 — 当たりでも作り直してバイトで比べる）でビルドし、どれかが落ちれば stage2.sh を落とす（検査を通らない値は焼き込まない）。
# ワーカー1・種0（パックの中身を決定的に）。SOBER_BAKE=0 で焼き込みの段を飛ばす（src の仮のファイルのまま）
stage_bake() {
    [ "${SOBER_BAKE:-1}" = 0 ] && return 0
    local cc=$1 root=$2 w=$3 bc=$3/bakecache e p n=0 last=""
    mkdir -p "$bc"
    rm -f "$root/bake/"*.pack
    while read -r e; do
        case "$e" in ''|'#'*) continue ;; esac
        (cd "$ROOT" && SOBER_CACHE="$bc" SOBER_BUILD_CACHE=1 SOBER_BAKE_STD=1 SOBER_CHECK_REPLAY=0 SOBER_CACHE_VERIFY=1 SOBER_WORKERS=1 SOBER_HASH_SEED=0 "$cc" build "$e" -o "$w/bake.out") > "$w/bake.log" 2>&1 || {
            echo "stagelib: FAIL bake build of $e:" >&2; tail -5 "$w/bake.log" >&2; return 1; }
        last=$e
    done < "$ROOT/scripts/bake.list"
    # パックを1本にまとめる（索引を1か所に — 最後の例題をもう1回ビルドすると全部当たり、終わりの併合が SOBER_CACHE_MERGE=1 で走る）
    (cd "$ROOT" && SOBER_CACHE="$bc" SOBER_BUILD_CACHE=1 SOBER_BAKE_STD=1 SOBER_CACHE_MERGE=1 SOBER_CHECK_REPLAY=0 SOBER_WORKERS=1 SOBER_HASH_SEED=0 "$cc" build "$last" -o "$w/bake.out") > "$w/bake.log" 2>&1 || {
        echo "stagelib: FAIL bake merge:" >&2; tail -5 "$w/bake.log" >&2; return 1; }
    for p in $(find "$bc" -name '*.pack' | LC_ALL=C sort); do
        n=$((n + 1))
        cp "$p" "$root/bake/$(printf '%03d' "$n").pack"
    done
    [ "$n" = 1 ] || { echo "stagelib: FAIL bake: $n packs after the merge (want 1)" >&2; return 1; }
}
