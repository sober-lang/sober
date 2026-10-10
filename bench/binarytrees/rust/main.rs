// binary-trees の Rust の双子（Go の双子 bench/binarytrees/go の逐語訳 — 節ごとに Box で確保する木・逐次。benchmarks game の Rust は
// 型つきアリーナで確保をまとめるが、ここは Go の「節ごとに new」の鏡として Box〔既定のアロケータ〕のまま）
use std::env;

struct Node { l: Option<Box<Node>>, r: Option<Box<Node>> }

fn bottom_up(d: i64) -> Box<Node> {
    if d <= 0 {
        return Box::new(Node { l: None, r: None });
    }
    Box::new(Node { l: Some(bottom_up(d - 1)), r: Some(bottom_up(d - 1)) })
}

fn check(n: &Node) -> i64 {
    match (&n.l, &n.r) {
        (Some(l), Some(r)) => 1 + check(l) + check(r),
        _ => 1,
    }
}

fn main() {
    let n: i64 = env::args().nth(1).map(|s| s.parse().unwrap()).unwrap_or(10);
    let min_depth = 4;
    let max_depth = if min_depth + 2 > n { min_depth + 2 } else { n };
    let stretch = max_depth + 1;
    println!("stretch tree of depth {}\t check: {}", stretch, check(&bottom_up(stretch)));
    let long = bottom_up(max_depth);
    let mut d = min_depth;
    while d <= max_depth {
        let iters = 1i64 << (max_depth - d + min_depth);
        let mut c = 0;
        for _ in 0..iters {
            c += check(&bottom_up(d));
        }
        println!("{}\t trees of depth {}\t check: {}", iters, d, c);
        d += 2;
    }
    println!("long lived tree of depth {}\t check: {}", max_depth, check(&long));
}
