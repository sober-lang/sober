// k-nucleotideの比較用のRustの実装（比較用のGoの実装bench/knucleotide/goの逐語訳 — ">THREE" の配列を大文字で取り出し、長さkの部分列ごとの出現数を
// HashMap〔既定のハッシュ〕で数える。鍵は配列の切片を借りる〔Goのm[string(seq[i:i+k])]++ の鏡 — 1brcの比較用の実装と同じ取り方〕）
use std::collections::HashMap;
use std::env;
use std::fs;
use std::io::{self, BufWriter, Write};

fn frequencies(seq: &[u8], k: usize) -> HashMap<&[u8], i64> {
    let mut m = HashMap::new();
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
