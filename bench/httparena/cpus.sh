# cpus.sh — CPU の割り当て（local.sh / perf.sh が source する）。SMT の兄弟を同じ側に置き、
# 物理コアの前半をサーバ・後半を負荷に。物理コアが 1 つ（SMT 兄弟しか無い VM 等）なら CPU 番号で
# 半分に割る（1 CPU なら共用）。$SERVER_CPUS / $LOAD_CPUS が両方あればそのまま使う。
if [ -z "${SERVER_CPUS:-}" ] || [ -z "${LOAD_CPUS:-}" ]; then
    mapfile -t cores < <(lscpu -p=CPU,CORE | grep -v '^#' | sort -t, -k2,2n -k1,1n)
    ncore=$(printf '%s\n' "${cores[@]}" | cut -d, -f2 | sort -un | wc -l)
    half=$((ncore / 2))
    SERVER_CPUS=$(printf '%s\n' "${cores[@]}" | awk -F, -v h=$half '$2 < h { print $1 }' | paste -sd,)
    LOAD_CPUS=$(printf '%s\n' "${cores[@]}" | awk -F, -v h=$half '$2 >= h { print $1 }' | paste -sd,)
    if [ -z "$SERVER_CPUS" ] || [ -z "$LOAD_CPUS" ]; then
        mapfile -t cpus < <(printf '%s\n' "${cores[@]}" | cut -d, -f1 | sort -n)
        ncpu=${#cpus[@]}
        if [ "$ncpu" -ge 2 ]; then
            chalf=$((ncpu / 2))
            SERVER_CPUS=$(printf '%s\n' "${cpus[@]:0:chalf}" | paste -sd,)
            LOAD_CPUS=$(printf '%s\n' "${cpus[@]:chalf}" | paste -sd,)
        else
            SERVER_CPUS=${cpus[0]:-0}
            LOAD_CPUS=$SERVER_CPUS
        fi
    fi
fi
nsrv=$(echo "$SERVER_CPUS" | tr ',' '\n' | wc -l)
nload=$(echo "$LOAD_CPUS" | tr ',' '\n' | wc -l)
