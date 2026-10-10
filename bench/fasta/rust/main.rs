// fasta の Rust の双子（Go の双子 bench/fasta/go の逐語訳 — float の乱数・累積確率の線形探索・1 バイトずつ BufWriter へ・境界検査はそのまま）
use std::env;
use std::io::{self, BufWriter, Write};

const IM: i64 = 139968;
const IA: i64 = 3877;
const IC: i64 = 29573;
const WIDTH: usize = 60;

const ALU: &[u8] = b"GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG\
GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA\
CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT\
ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA\
GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG\
AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC\
AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA";

struct Rng { last: i64 }

impl Rng {
    fn random(&mut self, max: f64) -> f64 {
        self.last = (self.last * IA + IC) % IM;
        max * self.last as f64 / IM as f64
    }
}

struct Acid { prob: f64, sym: u8 }

fn accumulate(genes: &mut [Acid]) {
    for i in 1..genes.len() {
        genes[i].prob += genes[i - 1].prob;
    }
}

fn repeat_fasta<W: Write>(out: &mut W, s: &[u8], mut count: usize) {
    let mut pos = 0;
    while count > 0 {
        let line = WIDTH.min(count);
        for _ in 0..line {
            out.write_all(&[s[pos]]).unwrap();
            pos += 1;
            if pos == s.len() {
                pos = 0;
            }
        }
        out.write_all(b"\n").unwrap();
        count -= line;
    }
}

fn random_fasta<W: Write>(out: &mut W, rng: &mut Rng, genes: &[Acid], mut count: usize) {
    while count > 0 {
        let line = WIDTH.min(count);
        for _ in 0..line {
            let r = rng.random(1.0);
            let mut i = 0;
            while genes[i].prob < r {
                i += 1;
            }
            out.write_all(&[genes[i].sym]).unwrap();
        }
        out.write_all(b"\n").unwrap();
        count -= line;
    }
}

fn main() {
    let n: usize = env::args().nth(1).map(|s| s.parse().unwrap()).unwrap_or(1000);
    let stdout = io::stdout();
    let mut out = BufWriter::with_capacity(1 << 16, stdout.lock());
    let a = |p: f64, s: u8| Acid { prob: p, sym: s };
    let mut iub = vec![
        a(0.27, b'a'), a(0.12, b'c'), a(0.12, b'g'), a(0.27, b't'),
        a(0.02, b'B'), a(0.02, b'D'), a(0.02, b'H'), a(0.02, b'K'),
        a(0.02, b'M'), a(0.02, b'N'), a(0.02, b'R'), a(0.02, b'S'),
        a(0.02, b'V'), a(0.02, b'W'), a(0.02, b'Y'),
    ];
    let mut homosapiens = vec![
        a(0.3029549426680, b'a'), a(0.1979883004921, b'c'), a(0.1975473066391, b'g'), a(0.3015094502008, b't'),
    ];
    accumulate(&mut iub);
    accumulate(&mut homosapiens);
    let mut rng = Rng { last: 42 };
    out.write_all(b">ONE Homo sapiens alu\n").unwrap();
    repeat_fasta(&mut out, ALU, 2 * n);
    out.write_all(b">TWO IUB ambiguity codes\n").unwrap();
    random_fasta(&mut out, &mut rng, &iub, 3 * n);
    out.write_all(b">THREE Homo sapiens frequency\n").unwrap();
    random_fasta(&mut out, &mut rng, &homosapiens, 5 * n);
    out.flush().unwrap();
}
