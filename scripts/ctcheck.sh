#!/usr/bin/env bash
# ctcheck（定数時間の静的な網 — report-790 / 791）: std/crypto の定数時間の関数を既定の build（x86 の最適化のバックエンド・--passes）で建て、
# 関数ごとの条件分岐の列（j* — jmp を除く）と DIV / IDIV の数を黄金 testdata/ctcheck/expect.txt と照合する。最適化が mask の選択を分岐に変えたり、
# 秘密に触る形に分岐が足されたりすると列が変わって赤になる（命令の網・出力の網では鳴らない退行のクラス）。黄金の分岐はどれも公開の値（長さ・
# ループの添字・境界の検査）に依る — 黄金を書き直すときは差分の分岐が公開の値に依ることを機械語で確かめてから（--regen）。
# neg* は規律を破った見本（秘密で if・早く抜ける比較・可変時間の rt.matchlen の呼び出し）で、網が分岐を数えられること・可変時間の呼び出しを捕まえることの負例として黄金に載る
#   scripts/ctcheck.sh [--regen]
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
D=testdata/ctcheck
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
OD=$(command -v objdump || ls -d /nix/store/*binutils*/bin/objdump | head -n1)
# 照合する関数 = testdata/ctcheck/funcs.txt（導出の表 T〔testdata/secretdump/std.txt — secretdump のゲートが木と同期〕+ 手書きの残置 + 負例）。
# 同期の照合: `@std…` と `-@…` の和 ≡ T・`+@…` ∩ T = ∅（funcs.txt が導出とずれたら赤）
T=$(grep ': secret ' testdata/secretdump/std.txt | sed 's/.*: secret /@/' | sort)
L=$(grep -E '^-?@std/' $D/funcs.txt | awk '{ print $1 }' | sed 's/^-//' | sort)
if [ "$T" != "$L" ]; then
    echo "ctcheck: FAIL — $D/funcs.txt と導出の表 T（testdata/secretdump/std.txt）がずれた:"; diff <(echo "$T") <(echo "$L") | head -20; exit 1
fi
for f in $(grep '^+@' $D/funcs.txt | awk '{ print $1 }' | sed 's/^+//'); do
    echo "$T" | grep -qxF -- "$f" && { echo "ctcheck: FAIL — 手書きの残置 $f が T に入った（funcs.txt の \`+@\` を \`@\` へ）"; exit 1; }
done
mapfile -t FUNCS < <(grep -E '^\+?@' $D/funcs.txt | awk '{ print $1 }' | sed 's/^+//')
"$S2" build $D/app.sober --emit=elf --passes -o "$W/app" > /dev/null || { echo "ctcheck: FAIL build"; exit 1; }
"$S2" build $D/app.sober --emit=syms -o "$W/syms" > /dev/null || { echo "ctcheck: FAIL syms"; exit 1; }
# 最後の記号の終わり = 実行の LOAD の終わり（後ろに読み出し専用のデータが続きうるので、最後の関数だけ逆アセンブルを「ret / syscall の直後の nop の詰め・0 のバイト〔add [rax],al〕」で切る。
# 他の関数は次の記号まで — 全関数に切りを掛けると、関数の途中の ret の直後にループの頭の整列の nop が来た関数が途中で切れていた: report-858）
# 可変時間の rt（最初の食い違いで止まる — rt.matchlen〔binary.MatchLen・SIMD の核 段 1〕）の番地: 照合する関数の機械語がこれを呼んだら赤
# （analyzer は秘密の値が binary.MatchLen に届く呼び出しを拒否する — その静的な保証の機械語の側の照合）
# （直の呼び出しと、展開されなかった std/binary.MatchLen への呼び出しの両方 — 番地の並び）
VT=$(awk '$2 == "@rt.matchlen" || $2 == "@std/binary.MatchLen" { printf " 0x%x", strtonum("0x" $1) }' "$W/syms")
: > "$W/vt"
end=$(readelf -lW "$W/app" | awk '$1 == "LOAD" && $NF == "0x1000" && $(NF-1) == "E" { printf "%016x", strtonum($3) + strtonum($5); exit }')
{ sort -k1,1 "$W/syms"; echo "$end ~end"; } | awk 'NR > 1 { print pa, $1, pn } { pa = $1; pn = $2 }' | while read -r a b n; do
    printf '%s\n' "${FUNCS[@]}" | grep -qxF -- "$n" || continue
    "$OD" -D -b binary -m i386:x86-64 -M intel --adjust-vma=0x400000 --start-address=0x$a --stop-address=0x$b "$W/app" | sed -n '8,$p' | cut -f3 \
        | awk -v last="$([ "$b" = "$end" ] && echo 1)" 'last && ($1 == "nop" || $0 ~ /^add +BYTE PTR \[rax\],al/) && (p == "ret" || p == "syscall") { exit } NF { print; p = $1 }' > "$W/dis"
    jcc=$(awk '$1 ~ /^j/ && $1 != "jmp" { printf " %s", $1 }' "$W/dis")
    div=$(awk '$1 == "div" || $1 == "idiv" { n++ } END { print n + 0 }' "$W/dis")
    [ -n "$VT" ] && awk -v t="$VT " '$1 == "call" && index(t, " " $2 " ") { f = 1 } END { exit !f }' "$W/dis" && echo "$n" >> "$W/vt"
    echo "$n:${jcc:- -} | div=$div"
done | sort > "$W/got"
# 載るはずの関数が ELF に無い（名前の変更・消えた）なら赤
for f in "${FUNCS[@]}"; do grep -q "^$f:" "$W/got" || { echo "ctcheck: FAIL — $f not in the ELF"; exit 1; }; done
# 負例 @main.negPrefix（可変時間の rt.matchlen を呼ぶ見本）は捕まること・それ以外の関数は呼ばないこと
grep -qxF "@main.negPrefix" "$W/vt" || { echo "ctcheck: FAIL — the variable-time call check did not catch @main.negPrefix"; exit 1; }
if grep -vxF "@main.negPrefix" "$W/vt" | grep -q .; then echo "ctcheck: FAIL — constant-time functions call the variable-time rt.matchlen:"; grep -vxF "@main.negPrefix" "$W/vt"; exit 1; fi
n=$(wc -l < "$W/got")
if [ "${1:-}" = --regen ]; then cp "$W/got" $D/expect.txt; echo "ctcheck: regen $n functions"; exit 0; fi
if ! diff -u $D/expect.txt "$W/got"; then echo "ctcheck: FAIL — conditional branches / DIV of constant-time functions changed ($n functions)"; exit 1; fi
echo "ctcheck: $n functions — conditional branches / DIV ≡ $D/expect.txt"
