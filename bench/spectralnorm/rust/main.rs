// spectral-norm の Rust の双子（Go の双子 bench/spectralnorm/go と同じアルゴリズム・同じ演算の順 — 素直な添字のループ・境界検査はそのまま）
use std::env;

fn eval_a(i: usize, j: usize) -> f64 {
    1.0 / (((i + j) * (i + j + 1) / 2 + i + 1) as f64)
}

fn times(v: &mut [f64], u: &[f64]) {
    for i in 0..v.len() {
        let mut a = 0.0;
        for j in 0..u.len() {
            a += eval_a(i, j) * u[j];
        }
        v[i] = a;
    }
}

fn times_transp(v: &mut [f64], u: &[f64]) {
    for i in 0..v.len() {
        let mut a = 0.0;
        for j in 0..u.len() {
            a += eval_a(j, i) * u[j];
        }
        v[i] = a;
    }
}

fn a_times_transp(v: &mut [f64], u: &[f64], x: &mut [f64]) {
    times(x, u);
    times_transp(v, x);
}

fn main() {
    let n: usize = env::args().nth(1).map(|s| s.parse().unwrap()).unwrap_or(100);
    let mut u = vec![1.0; n];
    let mut v = vec![0.0; n];
    let mut x = vec![0.0; n];
    for _ in 0..10 {
        a_times_transp(&mut v, &u, &mut x);
        a_times_transp(&mut u, &v, &mut x);
    }
    let mut vbv = 0.0;
    let mut vv = 0.0;
    for i in 0..n {
        vbv += u[i] * v[i];
        vv += v[i] * v[i];
    }
    println!("{:.9}", (vbv / vv).sqrt());
}
