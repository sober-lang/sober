// mandelbrot の Rust の双子（Go の双子 bench/mandelbrot/go の逐語訳 — 逐次・n × n の点を 50 回まで反復・|z|² ≤ 4 を 1 ビットで詰めた PBM〔P4〕。
// Go の bufio.Writer の WriteByte の鏡として BufWriter へ 1 バイトずつ）
use std::env;
use std::io::{self, BufWriter, Write};

fn main() {
    let n: usize = env::args().nth(1).map(|s| s.parse().unwrap()).unwrap_or(200);
    let stdout = io::stdout();
    let mut out = BufWriter::new(stdout.lock());
    write!(out, "P4\n{} {}\n", n, n).unwrap();
    let fnn = n as f64;
    for y in 0..n {
        let ci = 2.0 * y as f64 / fnn - 1.0;
        let mut bits: u32 = 0;
        let mut bitnum = 0;
        for x in 0..n {
            let cr = 2.0 * x as f64 / fnn - 1.5;
            let (mut zr, mut zi, mut tr, mut ti) = (0.0f64, 0.0f64, 0.0f64, 0.0f64);
            let mut i = 0;
            while i < 50 && tr + ti <= 4.0 {
                zi = 2.0 * zr * zi + ci;
                zr = tr - ti + cr;
                tr = zr * zr;
                ti = zi * zi;
                i += 1;
            }
            bits <<= 1;
            if tr + ti <= 4.0 {
                bits |= 1;
            }
            bitnum += 1;
            if bitnum == 8 {
                out.write_all(&[bits as u8]).unwrap();
                bits = 0;
                bitnum = 0;
            }
        }
        if bitnum > 0 {
            bits <<= 8 - bitnum;
            out.write_all(&[bits as u8]).unwrap();
        }
    }
    out.flush().unwrap();
}
