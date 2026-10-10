// reverse-complement の Rust の双子（Go の双子 bench/revcomp/go の逐語訳 — 全体を読み、記録ごとに見出しはそのまま・配列は改行を除いて逆順の相補を
// 1 行 60 文字で。Go の bufio.Writer〔64 KiB〕の WriteByte の鏡として BufWriter〔64 KiB〕へ 1 バイトずつ write_all）
use std::env;
use std::fs;
use std::io::{self, BufWriter, Write};

fn main() {
    let b = fs::read(env::args().nth(1).unwrap()).unwrap();
    let mut comp = [0u8; 256];
    for i in 0..256 {
        comp[i] = i as u8;
    }
    let from = b"ACBDGHKMNSRUTWVYacbdghkmnsrutwvy";
    let to = b"TGVHCDMKNSYAAWBRTGVHCDMKNSYAAWBR";
    for i in 0..from.len() {
        comp[from[i] as usize] = to[i];
    }
    let stdout = io::stdout();
    let mut out = BufWriter::with_capacity(1 << 16, stdout.lock());
    let mut i = 0;
    while i < b.len() {
        let s = i;
        while b[i] != b'\n' {
            i += 1;
        }
        i += 1;
        out.write_all(&b[s..i]).unwrap();
        let hs = i;
        while i < b.len() && b[i] != b'>' {
            i += 1;
        }
        let mut col = 0;
        let mut k = i;
        while k > hs {
            k -= 1;
            let c = b[k];
            if c != b'\n' {
                out.write_all(&[comp[c as usize]]).unwrap();
                col += 1;
                if col == 60 {
                    out.write_all(b"\n").unwrap();
                    col = 0;
                }
            }
        }
        if col > 0 {
            out.write_all(b"\n").unwrap();
        }
    }
    out.flush().unwrap();
}
