// extsort の Rust の双子（素直縛り — std だけ）: Sober / Go 版と同じアルゴリズム。run = 入力を 64 KiB ずつ読んで窓 W に達するまで 1 本の Vec<u8> に積み、
// 完全な行の部分列を sort_unstable で並べて fs::write で `<dir>/run-<i>` へ全量書く。マージ = run ごとに BufReader（64 KiB）を持ち、
// 頭の行が最小の run を線形の走査で選んで BufWriter（64 KiB）で標準出力へ。出力は Sober 版とバイト一致
use std::env;
use std::fs::{self, File};
use std::io::{self, BufRead, BufReader, BufWriter, Read, Write};

fn make_runs(path: &str, dir: &str, w: usize) -> io::Result<usize> {
    let mut f = File::open(path)?;
    let mut tail: Vec<u8> = Vec::new();
    let mut k = 0;
    let mut chunk = vec![0u8; 65536];
    let mut eof = false;
    while !eof {
        let mut buf = tail.clone();
        eof = true;
        loop {
            let n = f.read(&mut chunk)?;
            if n == 0 {
                break;
            }
            buf.extend_from_slice(&chunk[..n]);
            if buf.len() >= w {
                eof = false;
                break;
            }
        }
        let e = buf.iter().rposition(|&c| c == b'\n').map_or(0, |i| i + 1);
        tail = buf[e..].to_vec();
        let mut lines: Vec<&[u8]> = buf[..e].split_inclusive(|&c| c == b'\n').collect();
        if lines.is_empty() {
            continue;
        }
        lines.sort_unstable_by(|a, b| a[..a.len() - 1].cmp(&b[..b.len() - 1]));
        let mut out = Vec::with_capacity(e);
        for l in &lines {
            out.extend_from_slice(l);
        }
        fs::write(format!("{}/run-{}", dir, k), &out)?;
        k += 1;
    }
    if !tail.is_empty() {
        return Err(io::Error::new(io::ErrorKind::InvalidData, "no final newline"));
    }
    Ok(k)
}

fn merge_runs(dir: &str, k: usize, w: &mut impl Write) -> io::Result<()> {
    let mut rs = Vec::new();
    let mut heads: Vec<Vec<u8>> = Vec::new();
    for r in 0..k {
        let mut rd = BufReader::with_capacity(65536, File::open(format!("{}/run-{}", dir, r))?);
        let mut h = Vec::new();
        rd.read_until(b'\n', &mut h)?;
        rs.push(rd);
        heads.push(h);
    }
    loop {
        let mut m: Option<usize> = None;
        for r in 0..k {
            let h = &heads[r];
            if !h.is_empty() {
                if let Some(j) = m {
                    let g = &heads[j];
                    if h[..h.len() - 1] < g[..g.len() - 1] {
                        m = Some(r);
                    }
                } else {
                    m = Some(r);
                }
            }
        }
        let Some(m) = m else { return Ok(()) };
        w.write_all(&heads[m])?;
        heads[m].clear();
        rs[m].read_until(b'\n', &mut heads[m])?;
    }
}

fn main() {
    let a: Vec<String> = env::args().collect();
    if a.len() != 3 && a.len() != 4 {
        std::process::exit(2);
    }
    let mib: usize = if a.len() == 4 { a[3].parse().unwrap_or(64) } else { 64 };
    let k = match make_runs(&a[1], &a[2], mib << 20) {
        Ok(k) => k,
        Err(_) => std::process::exit(1),
    };
    let out = io::stdout();
    let mut w = BufWriter::with_capacity(65536, out.lock());
    if merge_runs(&a[2], k, &mut w).is_err() || w.flush().is_err() {
        std::process::exit(1);
    }
}
