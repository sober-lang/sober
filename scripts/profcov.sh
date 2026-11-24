#!/usr/bin/env bash
# 熱さのプロファイルの効いている割合（lower/profile.sober）: bench/httparena/main.prof の行のうち、今のコンパイラで関数の鍵と指紋が合う行の割合が
# PROFCOV_MIN（既定 90%）以上であること。指紋の合わない関数にはプロファイルを使わない（静的な判定に戻る）ので、ソースやコンパイラの変更で
# プロファイルが黙って効かなくなる — 下回ったら取り直す（scripts/profgen.sh bench/httparena/main.prof）。
# あわせて、`--blkmap` のELFがプロファイルなしのELFとバイト一致すること（表を出すだけでコードを変えない）と、プロファイルつきのビルドが
# W1 ≡ 並列でバイト一致すること、後段の関数キャッシュの有無でバイト一致すること（プロファイルの切片はβ2の鍵 — 下の4相）を見る。
# 公開の引数としての形: --emit の無い `build --profile` ≡ --emit=elf --passes の形・答えの再生（2回目は当たり・プロファイルの編集で外れる）・
# 読めない / 形の崩れたファイルは理由の1文で止まる・指紋の合う関数が無ければ警告の1文でプロファイルなしと同じELF（再生で警告が消えない）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
P=bench/httparena/main.prof
MIN=${PROFCOV_MIN:-90}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
[ -f "$P" ] || { echo "profcov: FAIL — $P が無い"; exit 1; }
"$S2" build bench/httparena/main.sober --emit=elf --passes -o "$W/base" > "$W/err" 2>&1 || { echo "profcov: FAIL build: $(tail -c 300 "$W/err")"; exit 1; }
SOBER_WORKERS=1 "$S2" build bench/httparena/main.sober --emit=elf --passes --blkmap -o "$W/map" > "$W/blkmap" 2> "$W/err" || { echo "profcov: FAIL --blkmap: $(tail -c 300 "$W/err")"; exit 1; }
SOBER_WORKERS=1 "$S2" build bench/httparena/main.sober --emit=elf --passes --profile="$P" --blkmap -o "$W/p1" > "$W/pmap" 2> "$W/err" || { echo "profcov: FAIL --profile: $(tail -c 300 "$W/err")"; exit 1; }
"$S2" build bench/httparena/main.sober --emit=elf --passes --profile="$P" -o "$W/pn" > "$W/err" 2>&1 || { echo "profcov: FAIL --profile（並列）: $(tail -c 300 "$W/err")"; exit 1; }
fail=0
# 後段の関数キャッシュ（プロファイルの切片はβ2の鍵へ）: 空の格納場所をプロファイルなしのビルドで温めてから、プロファイルつき（温まっていない切片の関数は外れる）・
# もう一度プロファイルつき（全部当たりうる）・プロファイルなし（プロファイルの項目が混ざらない）を順に建て、どれも格納場所なしのビルドとバイト一致すること
C=$W/cache   # ゲートは SOBER_BUILD_CACHE=0・SOBER_VERIFY=each で回る（gates.sh）— 格納場所の相は両方を明示する（VERIFY=each のプロファイルなしのbuildは格納場所を通らない）
mkdir -p "$C"
SOBER_BUILD_CACHE=0 "$S2" build bench/httparena/main.sober --emit=elf --passes --profile="$P" -o "$W/pnc" > "$W/err" 2>&1 || { echo "profcov: FAIL --profile（格納場所なし）: $(tail -c 300 "$W/err")"; exit 1; }
cmp -s "$W/pnc" "$W/pn" || { echo "FAIL: プロファイルつきのELFが格納場所の有無で違う（既定の格納場所）"; fail=$((fail + 1)); }
packs() { find "$C" -name "*.pack" | wc -l; }
SOBER_BUILD_CACHE=1 SOBER_VERIFY=last SOBER_CACHE=$C "$S2" build bench/httparena/main.sober --emit=elf --passes -o "$W/c0" > "$W/err" 2>&1 || { echo "profcov: FAIL 温め: $(tail -c 300 "$W/err")"; exit 1; }
k0=$(packs)
SOBER_BUILD_CACHE=1 SOBER_VERIFY=last SOBER_CACHE=$C "$S2" build bench/httparena/main.sober --emit=elf --passes --profile="$P" -o "$W/c1" > "$W/err" 2>&1 || { echo "profcov: FAIL 格納場所つき1: $(tail -c 300 "$W/err")"; exit 1; }
k1=$(packs)
SOBER_BUILD_CACHE=1 SOBER_VERIFY=last SOBER_CACHE=$C "$S2" build bench/httparena/main.sober --emit=elf --passes --profile="$P" -o "$W/c2" > "$W/err" 2>&1 || { echo "profcov: FAIL 格納場所つき2: $(tail -c 300 "$W/err")"; exit 1; }
SOBER_BUILD_CACHE=1 SOBER_VERIFY=last SOBER_CACHE=$C "$S2" build bench/httparena/main.sober --emit=elf --passes -o "$W/c3" > "$W/err" 2>&1 || { echo "profcov: FAIL 格納場所つき3: $(tail -c 300 "$W/err")"; exit 1; }
cmp -s "$W/c0" "$W/base" || { echo "FAIL: 温めのELFがプロファイルなしのELFと違う"; fail=$((fail + 1)); }
cmp -s "$W/c1" "$W/pnc" || { echo "FAIL: プロファイルつきのELF（プロファイルなしで温めた格納場所）が格納場所なしと違う"; fail=$((fail + 1)); }
cmp -s "$W/c2" "$W/pnc" || { echo "FAIL: プロファイルつきのELF（温まった格納場所）が格納場所なしと違う"; fail=$((fail + 1)); }
cmp -s "$W/c3" "$W/base" || { echo "FAIL: プロファイルなしのELF（プロファイルの項目のある格納場所）が格納場所なしと違う"; fail=$((fail + 1)); }
[ "$k1" -gt "$k0" ] || { echo "FAIL: プロファイルつきのビルドが格納場所に書いていない（パック $k0 → $k1）"; fail=$((fail + 1)); }
cmp -s "$W/base" "$W/map" || { echo "FAIL: --blkmap のELFがプロファイルなしのELFと違う"; fail=$((fail + 1)); }
cmp -s "$W/p1" "$W/pn" || { echo "FAIL: プロファイルつきのELFが W1 と並列で違う"; fail=$((fail + 1)); }
read -r hit rows < <(awk '$1 == "pfhit" { print $2, $3; exit }' "$W/pmap")
[ -n "${rows:-}" ] && [ "$rows" -gt 0 ] || { echo "profcov: FAIL — pfhit の行が無い・プロファイルが空"; exit 1; }
pct=$((100 * hit / rows))
[ "$pct" -ge "$MIN" ] || { echo "FAIL: 指紋の合う行 $hit / $rows（$pct%）< $MIN% — scripts/profgen.sh $P で取り直す"; fail=$((fail + 1)); }
# 公開の形: --emit の無い build（既定 = 最適化つきのELF）
"$S2" build bench/httparena/main.sober --profile="$P" -o "$W/pub" > "$W/err" 2>&1 || { echo "profcov: FAIL --emit なしの --profile: $(tail -c 300 "$W/err")"; exit 1; }
cmp -s "$W/pub" "$W/pnc" || { echo "FAIL: --emit なしの build --profile のELFが --emit=elf --passes の形と違う"; fail=$((fail + 1)); }
# 答えの再生: プロファイルのパスは鍵・中身は読んだ入力（写しを編集して外れることを見る）。ゲートの既定は再生を切る（SOBER_CHECK_REPLAY=0・SOBER_VERIFY=each）ので、相は明示する
C2=$W/cache2
mkdir -p "$C2"
cp "$P" "$W/rp.prof"
rbuild() { # rbuild <出力> → 再生の当たりの表示（1/1・0/1）
    SOBER_BUILD_CACHE=1 SOBER_CHECK_REPLAY=1 SOBER_VERIFY=last SOBER_CACHE=$C2 SOBER_CACHE_STAT=1 "$S2" build bench/httparena/main.sober --profile="$W/rp.prof" -o "$1" 2> "$W/rerr" > /dev/null || { echo "?"; return; }
    awk '$2 == "build-replay" { print $3 }' "$W/rerr"
}
r1=$(rbuild "$W/r1"); r2=$(rbuild "$W/r2")
[ "$r1" = 0/1 ] && [ "$r2" = 1/1 ] || { echo "FAIL: 答えの再生が1回目 0/1・2回目 1/1 でない（$r1・$r2）"; fail=$((fail + 1)); }
cmp -s "$W/r1" "$W/pnc" && cmp -s "$W/r2" "$W/pnc" || { echo "FAIL: 再生の相のELFが格納場所なしと違う"; fail=$((fail + 1)); }
big=$(awk 'NR > 1 { print NR, $4 }' "$W/rp.prof" | sort -k2 -n -r | head -1 | cut -d' ' -f1)
sed -i "${big}d" "$W/rp.prof"
r3=$(rbuild "$W/r3")
[ "$r3" = 0/1 ] || { echo "FAIL: プロファイルを編集しても答えの再生が外れない（$r3）"; fail=$((fail + 1)); }
cmp -s "$W/r3" "$W/pnc" && { echo "FAIL: 冷たいブロックの最も多い行を消してもELFが変わらない"; fail=$((fail + 1)); }
# 診断: 読めない・1行目が違う・崩れた行は理由の1文で止まる
diag() { # diag <プロファイル> <stderr に要る文字列>
    if "$S2" build bench/httparena/main.sober --profile="$1" -o "$W/x" > /dev/null 2> "$W/derr"; then
        echo "FAIL: $1 のビルドが通った（止まるはず）"; fail=$((fail + 1))
    elif ! grep -qF -- "$2" "$W/derr"; then
        echo "FAIL: $1 の診断に「$2」が無い: $(head -c 300 "$W/derr")"; fail=$((fail + 1))
    fi
}
diag "$W/none.prof" "cannot read the profile"
printf 'sober-profile 2\n' > "$W/hd.prof"; diag "$W/hd.prof" "not a profile, because the first line is not"
printf 'sober-profile 1\nf 1 2 3 4 5 @k\n' > "$W/ln.prof"; diag "$W/ln.prof" "ln.prof:2: not a profile line"
# 指紋の合う関数が無い: 警告の1文・終了0・プロファイルなしと同じELF。格納場所つきの2回目も警告を出す（答えを覚えない）。
# 格納場所はプロファイルつきのビルド1回だけで温めたもの（束の鍵がプロファイルの中身を含むことを見る — 束を書くのはK0の外れたビルドなので、
# プロファイルなしで温めた上の4相のCでは、束がプロファイルなしの中身のまま残り、取りこぼしが見えない）
C3=$W/cache3
mkdir -p "$C3"
SOBER_BUILD_CACHE=1 SOBER_VERIFY=last SOBER_CACHE=$C3 "$S2" build bench/httparena/main.sober --emit=elf --passes --profile="$P" -o "$W/mw" > "$W/err" 2>&1 || { echo "profcov: FAIL 全外れの相の温め: $(tail -c 300 "$W/err")"; exit 1; }
# 鍵の末尾の桁を文字列で替える（awkの数は倍精度 — 2^53を超える鍵に1を足すと、丸めで元の値に戻ることがある）
awk 'NR == 1 { print; next } { d = substr($2, length($2)); $2 = substr($2, 1, length($2) - 1) ((d + 1) % 10); print }' "$P" > "$W/miss.prof"
nw=0
for i in 1 2; do
    SOBER_BUILD_CACHE=1 SOBER_CHECK_REPLAY=1 SOBER_VERIFY=last SOBER_CACHE=$C3 "$S2" build bench/httparena/main.sober --profile="$W/miss.prof" -o "$W/m$i" > /dev/null 2> "$W/merr" || { echo "FAIL: 指紋の合わないプロファイルでビルドが止まった: $(head -c 300 "$W/merr")"; fail=$((fail + 1)); }
    grep -qF "no function of this build matches a fingerprint in the profile" "$W/merr" && nw=$((nw + 1))
    cmp -s "$W/m$i" "$W/base" || { echo "FAIL: 指紋の合わないプロファイルのELF（$i 回目）がプロファイルなしと違う"; fail=$((fail + 1)); }
done
[ "$nw" = 2 ] || { echo "FAIL: 指紋の合わないプロファイルの警告が2回とも出ない（$nw 回）"; fail=$((fail + 1)); }
echo "profcov: 指紋の合う行 $hit / $rows（$pct%・下限 $MIN%）・--blkmap ≡ プロファイルなし・W1 ≡ 並列・格納場所の4相 ≡ 格納場所なし（パック $k0 → $k1）・公開の形・再生 $r1 / $r2 / $r3・診断 3 + 警告 $nw, fail=$fail"
[ "$fail" = 0 ]
