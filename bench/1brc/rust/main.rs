// 1BRC の Rust の双子（Go の双子 bench/1brc/go の逐語訳 — 全体を読んで行ごとに走査・HashMap（既定のハッシュ）で集計・気温は ×10 の整数・
// 名前はバッファの切片を鍵に借りる〔Go の m[string(b[s:i])] が割り当てない形の鏡〕・境界検査はそのまま）
use std::collections::HashMap;
use std::env;
use std::fs;
use std::io::{self, Write};

struct Stat { min: i64, max: i64, sum: i64, count: i64 }

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
    let mut m: HashMap<&[u8], Stat> = HashMap::new();
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
        match m.get_mut(name) {
            None => {
                m.insert(name, Stat { min: t, max: t, sum: t, count: 1 });
            }
            Some(st) => {
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
