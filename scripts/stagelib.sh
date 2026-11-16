# stagelib: コンパイラ自身をビルドする手順の共通の部分（scripts/stage2.sh・scripts/stage3.sh・scripts/stages.shがsourceする）。
# 配るstage3（release）と、固定点を確かめるstage3（stages）を、同じ関数で作るために1か所に置く。
#
#   stage_tree <木>                    compiler/* とstd/を木に写す（compiler/appのimportは木のルートからの相対）
#   stage_l0 <コンパイラ> <木> <作業>   stdの全packageの.sobiを<木>/l0に書く（compiler/appが @embedで取り込むL0）
#   stage_build <コンパイラ> <木> <出力>  <木>のcompiler/appを正規バックエンドでELFに（bin/soberの既定の形）

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
