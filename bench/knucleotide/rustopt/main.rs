// 慣用版 — 許す技法: FxHash 手書き・entry/capacity・split_at_mut 等、性能を意識する Rust 使いが
// 普通に使う安全な定石。禁止: unsafe・明示 SIMD intrinsics・別アルゴリズム（rust/ の素直版と同じ解法を保つ）
//
// k-nucleotide の慣用チューニング版（bench/knucleotide/rust/main.rs の素直版をベースに、
// 性能を意識する Rust 使いが普通に使う技法だけを足す。アルゴリズムは変えない）
//
// 施した技法:
//   1. FxHash（rustc-hash crate の手法を 20 行程度でインライン再実装）— デフォルトの
//      SipHash は DoS 耐性のための暗号学的ハッシュで、短いバイト列を大量に食わせる
//      ワークロード（k=1,2 の部分列・固定文字列 5 種）では過剰品質。性能志向の Rust
//      コードが HashMap のデフォルトを FxHash に差し替えるのは定番（rustc 自身がそう）
//   2. HashMap::with_capacity_and_hasher で事前サイズ（k=1: 4 種, k=2: 16 種 — rehash を回避）
//   3. その他は素直版と同一（アルゴリズム・出力フォーマットは逐語訳のまま）
use std::collections::HashMap;
use std::env;
use std::fs;
use std::io::{self, BufWriter, Write};

// --- FxHash（rustc-hash 相当。依存 crate なしでインライン実装） ---
const SEED64: u64 = 0x51_7c_c1_b7_27_22_0a_95;

#[derive(Default)]
struct FxHasher(u64);

impl FxHasher {
    #[inline]
    fn add(&mut self, w: u64) {
        self.0 = (self.0.rotate_left(5) ^ w).wrapping_mul(SEED64);
    }
}

impl std::hash::Hasher for FxHasher {
    #[inline]
    fn write(&mut self, mut bytes: &[u8]) {
        while bytes.len() >= 8 {
            self.add(u64::from_ne_bytes(bytes[..8].try_into().unwrap()));
            bytes = &bytes[8..];
        }
        if bytes.len() >= 4 {
            self.add(u32::from_ne_bytes(bytes[..4].try_into().unwrap()) as u64);
            bytes = &bytes[4..];
        } else if bytes.len() >= 2 {
            self.add(u16::from_ne_bytes(bytes[..2].try_into().unwrap()) as u64);
            bytes = &bytes[2..];
        }
        if let Some(&b) = bytes.first() {
            self.add(b as u64);
        }
    }
    #[inline]
    fn finish(&self) -> u64 {
        self.0
    }
}

type FxBuildHasher = std::hash::BuildHasherDefault<FxHasher>;
type FxHashMap<K, V> = HashMap<K, V, FxBuildHasher>;

fn frequencies(seq: &[u8], k: usize) -> FxHashMap<&[u8], i64> {
    let cap = 1usize << (2 * k).min(20); // 4^k 種類の上限で事前確保（k=1,2,3,4,6,12,18 でも暴走しない）
    let mut m: FxHashMap<&[u8], i64> =
        HashMap::with_capacity_and_hasher(cap.min(seq.len() + 1), FxBuildHasher::default());
    let mut i = 0;
    while i + k <= seq.len() {
        *m.entry(&seq[i..i + k]).or_insert(0) += 1;
        i += 1;
    }
    m
}

fn main() {
    let b = fs::read(env::args().nth(1).unwrap()).unwrap();
    let mut i = 0;
    while !b[i..].starts_with(b">THREE") {
        while b[i] != b'\n' {
            i += 1;
        }
        i += 1;
    }
    while b[i] != b'\n' {
        i += 1;
    }
    i += 1;
    let mut seq: Vec<u8> = Vec::new();
    while i < b.len() && b[i] != b'>' {
        let mut c = b[i];
        if c != b'\n' {
            if c >= b'a' && c <= b'z' {
                c -= 32;
            }
            seq.push(c);
        }
        i += 1;
    }
    let stdout = io::stdout();
    let mut out = BufWriter::new(stdout.lock());
    for k in 1..=2 {
        let m = frequencies(&seq, k);
        let mut keys: Vec<&[u8]> = m.keys().copied().collect();
        keys.sort_by(|x, y| m[y].cmp(&m[x]).then(x.cmp(y)));
        let total = (seq.len() - k + 1) as f64;
        for key in keys {
            writeln!(out, "{} {:.3}", std::str::from_utf8(key).unwrap(), 100.0 * m[key] as f64 / total).unwrap();
        }
        out.write_all(b"\n").unwrap();
    }
    for s in ["GGT", "GGTA", "GGTATT", "GGTATTTTAATT", "GGTATTTTAATTTATAGT"] {
        let m = frequencies(&seq, s.len());
        writeln!(out, "{}\t{}", m.get(s.as_bytes()).copied().unwrap_or(0), s).unwrap();
    }
    out.flush().unwrap();
}
