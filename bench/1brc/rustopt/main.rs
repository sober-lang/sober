// 慣用版 — 許す技法: FxHash 手書き・entry/capacity・split_at_mut 等、性能を意識する Rust 使いが
// 普通に使う安全な定石。禁止: unsafe・明示 SIMD intrinsics・別アルゴリズム（rust/ の素直版と同じ解法を保つ）
//
// 1BRC の慣用チューニング版（bench/1brc/rust/main.rs の素直版をベースに、性能を意識する
// Rust 使いが普通に使う技法だけを足す。アルゴリズムは変えない）
//
// 施した技法:
//   1. FxHash（rustc-hash crate 相当をインライン実装）— 既定の SipHash は短い地名の鍵を
//      大量にハッシュするこのワークロードには過剰品質。1BRC の実チューニング競技でも定番
//   2. HashMap::entry API 1 回で参照を得て更新（素直版の get_mut→None 分岐で insert の
//      二度引きを避ける — Rust の教科書どおりのイディオム）
//   3. HashMap::with_capacity で事前サイズ（地名は高々数百種 — rehash を避ける）
//   4. 出力は Vec<u8> へ直接 extend（素直版も同じ）
use std::collections::HashMap;
use std::env;
use std::fs;
use std::io::{self, Write};

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

struct Stat {
    min: i64,
    max: i64,
    sum: i64,
    count: i64,
}

fn floor_div(a: i64, b: i64) -> i64 {
    let mut q = a / b;
    if a % b != 0 && ((a < 0) != (b < 0)) {
        q -= 1;
    }
    q
}

fn fmt10(out: &mut Vec<u8>, mut v: i64) {
    if v < 0 {
        out.push(b'-');
        v = -v;
    }
    out.extend_from_slice((v / 10).to_string().as_bytes());
    out.push(b'.');
    out.push(b'0' + (v % 10) as u8);
}

fn main() {
    let path = env::args().nth(1).unwrap();
    let b = fs::read(path).unwrap();
    let mut m: FxHashMap<&[u8], Stat> =
        HashMap::with_capacity_and_hasher(1024, FxBuildHasher::default());
    let mut i = 0;
    while i < b.len() {
        let s = i;
        while b[i] != b';' {
            i += 1;
        }
        let name = &b[s..i];
        i += 1;
        let mut neg = false;
        if b[i] == b'-' {
            neg = true;
            i += 1;
        }
        let mut t: i64 = 0;
        while b[i] != b'\n' {
            if b[i] != b'.' {
                t = t * 10 + (b[i] - b'0') as i64;
            }
            i += 1;
        }
        i += 1;
        if neg {
            t = -t;
        }
        match m.entry(name) {
            std::collections::hash_map::Entry::Vacant(e) => {
                e.insert(Stat { min: t, max: t, sum: t, count: 1 });
            }
            std::collections::hash_map::Entry::Occupied(mut e) => {
                let st = e.get_mut();
                if t < st.min {
                    st.min = t;
                }
                if t > st.max {
                    st.max = t;
                }
                st.sum += t;
                st.count += 1;
            }
        }
    }
    let mut names: Vec<&[u8]> = m.keys().copied().collect();
    names.sort();
    let mut out = vec![b'{'];
    for (j, k) in names.iter().enumerate() {
        if j > 0 {
            out.extend_from_slice(b", ");
        }
        let st = &m[k];
        out.extend_from_slice(k);
        out.push(b'=');
        fmt10(&mut out, st.min);
        out.push(b'/');
        fmt10(&mut out, floor_div(2 * st.sum + st.count, 2 * st.count));
        out.push(b'/');
        fmt10(&mut out, st.max);
    }
    out.extend_from_slice(b"}\n");
    io::stdout().write_all(&out).unwrap();
}
