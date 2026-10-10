// routing の Rust の双子（素直縛り — std だけ）: Sober / Go 版と同じ手書きの線形照合（登録順の最初の一致）。区間は split('/') の Vec<&str>・
// パラメータとクエリは HashMap<&str, String>。出力は Sober 版とバイト一致
use std::collections::HashMap;
use std::fs;
use std::io::{self, Write};

const TABLE: [&str; 40] = [
    "GET /",
    "GET /healthz",
    "GET /api/v1/users",
    "POST /api/v1/users",
    "GET /api/v1/users/me",
    "GET /api/v1/users/:id",
    "PUT /api/v1/users/:id",
    "DELETE /api/v1/users/:id",
    "GET /api/v1/users/:id/orders",
    "POST /api/v1/users/:id/orders",
    "GET /api/v1/users/:id/orders/:oid",
    "DELETE /api/v1/users/:id/orders/:oid",
    "GET /api/v1/users/:id/followers",
    "GET /api/v1/products",
    "POST /api/v1/products",
    "GET /api/v1/products/featured",
    "GET /api/v1/products/:sku",
    "PUT /api/v1/products/:sku",
    "GET /api/v1/products/:sku/reviews",
    "POST /api/v1/products/:sku/reviews",
    "GET /api/v1/products/:sku/reviews/:rid",
    "GET /api/v1/categories",
    "GET /api/v1/categories/:slug",
    "GET /api/v1/categories/:slug/products",
    "GET /api/v1/search",
    "GET /api/v1/orders/:oid",
    "POST /api/v1/orders/:oid/cancel",
    "GET /api/v1/orders/:oid/items/:iid",
    "GET /api/v2/users/:id",
    "GET /api/v2/products/:sku",
    "POST /api/v2/checkout",
    "GET /blog",
    "GET /blog/:slug",
    "GET /blog/:slug/comments",
    "GET /admin",
    "GET /admin/stats",
    "GET /admin/users/:id",
    "POST /admin/users/:id/ban",
    "GET /static/*path",
    "GET /favicon.ico",
];

struct Route {
    method: &'static str,
    segs: Vec<&'static str>,
}

fn split<'a>(s: &'a str, sep: char) -> Vec<&'a str> {
    if s.is_empty() {
        Vec::new()
    } else {
        s.split(sep).collect()
    }
}

fn matches<'a>(r: &'a Route, segs: &[&str], ps: &mut HashMap<&'a str, String>) -> bool {
    let n = r.segs.len();
    let wild = n > 0 && r.segs[n - 1].starts_with('*');
    if wild {
        if segs.len() < n {
            return false;
        }
    } else if segs.len() != n {
        return false;
    }
    for (k, p) in r.segs.iter().enumerate() {
        if wild && k == n - 1 {
            ps.insert(&p[1..], segs[k..].join("/"));
        } else if p.starts_with(':') {
            ps.insert(&p[1..], segs[k].to_string());
        } else if *p != segs[k] {
            return false;
        }
    }
    true
}

fn atoi(s: &str) -> i64 {
    s.parse().unwrap_or(0)
}

fn fnv(h: &mut u64, s: &str) {
    for &c in s.as_bytes() {
        *h = (*h ^ c as u64).wrapping_mul(1099511628211);
    }
}

fn main() {
    let routes: Vec<Route> = TABLE
        .iter()
        .map(|spec| {
            let sp = spec.find(' ').unwrap();
            Route { method: &spec[..sp], segs: split(&spec[sp + 2..], '/') }
        })
        .collect();
    let path = std::env::args().nth(1).expect("usage: routing <file>");
    let data = fs::read_to_string(&path).expect("read");
    let mut hits = vec![0usize; routes.len()];
    let (mut n, mut nf, mut na, mut num_sum, mut str_bytes, mut page_sum) = (0, 0, 0, 0i64, 0usize, 0i64);
    let mut h: u64 = 14695981039346656037;
    for line in data.lines() {
        n += 1;
        let sp = line.find(' ').unwrap();
        let (method, target) = (&line[..sp], &line[sp + 1..]);
        let (path, query) = target.split_once('?').unwrap_or((target, ""));
        let segs = split(&path[1..], '/');
        let mut qs: HashMap<&str, &str> = HashMap::new();
        for kv in split(query, '&') {
            let (k, v) = kv.split_once('=').unwrap_or((kv, ""));
            qs.insert(k, v);
        }
        let mut ps = HashMap::new();
        let found = routes.iter().position(|r| r.method == method && matches(r, &segs, &mut ps));
        let Some(fi) = found else {
            if routes.iter().any(|r| matches(r, &segs, &mut HashMap::new())) {
                na += 1;
                fnv(&mut h, "405\n");
            } else {
                nf += 1;
                fnv(&mut h, "404\n");
            }
            continue;
        };
        hits[fi] += 1;
        fnv(&mut h, &fi.to_string());
        for p in &routes[fi].segs {
            if p.starts_with(':') || p.starts_with('*') {
                let name = &p[1..];
                if let Some(x) = ps.get(name) {
                    fnv(&mut h, "|");
                    fnv(&mut h, x);
                    if name == "sku" || name == "slug" || name == "path" {
                        str_bytes += x.len();
                    } else {
                        num_sum += atoi(x);
                    }
                }
            }
        }
        if let Some(pg) = qs.get("page") {
            page_sum += atoi(pg);
        }
        fnv(&mut h, "\n");
    }
    let out = io::stdout();
    let mut w = io::BufWriter::new(out.lock());
    writeln!(w, "requests {}", n).unwrap();
    for (k, c) in hits.iter().enumerate() {
        writeln!(w, "route {} {}", k, c).unwrap();
    }
    writeln!(w, "404 {}\n405 {}\nnum_sum {}\nstr_bytes {}\npage_sum {}\nhash {}", nf, na, num_sum, str_bytes, page_sum, h as i64).unwrap();
}
