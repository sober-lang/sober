// fannkuch-redux の Rust の双子（Go の双子 bench/fannkuch/go の逐語訳 — 同じアルゴリズム・逐次・境界検査はそのまま）
use std::env;

fn main() {
    let n: usize = env::args().nth(1).map(|s| s.parse().unwrap()).unwrap_or(7);
    let mut perm1: Vec<usize> = (0..n).collect();
    let mut perm = vec![0usize; n];
    let mut count = vec![0usize; n];
    let (mut max_flips, mut checksum, mut perm_count, mut r) = (0i64, 0i64, 0i64, n);
    loop {
        while r != 1 {
            count[r - 1] = r;
            r -= 1;
        }
        perm.copy_from_slice(&perm1);
        let mut flips = 0i64;
        let mut k = perm[0];
        while k != 0 {
            let (mut lo, mut hi) = (0, k);
            while lo < hi {
                perm.swap(lo, hi);
                lo += 1;
                hi -= 1;
            }
            flips += 1;
            k = perm[0];
        }
        if flips > max_flips {
            max_flips = flips;
        }
        if perm_count % 2 == 0 {
            checksum += flips;
        } else {
            checksum -= flips;
        }
        loop {
            if r == n {
                println!("{}\nPfannkuchen({}) = {}", checksum, n, max_flips);
                return;
            }
            let p0 = perm1[0];
            for i in 0..r {
                perm1[i] = perm1[i + 1];
            }
            perm1[r] = p0;
            count[r] -= 1;
            if count[r] > 0 {
                break;
            }
            r += 1;
        }
        perm_count += 1;
    }
}
