#!/usr/bin/env bash
# Rust の双子（bench/<題材>/rust/main.rs）を out/rust/release/<題材> に建てる（素直縛り — Cargo.toml の注記。依存の crate なしなので --offline）。
# bench/<題材>/rustopt/main.rs がある題材（負け組だけの慣用チューニング版）は out/rust/release/<題材>-opt も同時に建つ。
# 測るのは bench/seqperf.sh --rust（先に scripts/bench.sh で Sober / Go の実行ファイルと入力を置く）
set -euo pipefail
cd "$(dirname "$0")"
cargo build --release --offline --quiet
echo "bench/rust/build.sh: $(cd ../../out/rust/release && ls 1brc 1brc-opt binarytrees fannkuch fasta revcomp knucleotide knucleotide-opt nbody nbody-opt spectralnorm mandelbrot jsonapi routing logagg | tr '\n' ' ')"
