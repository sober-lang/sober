// logagg の Rust の双子（素直縛り — std だけ）: Sober / Go 版と同じ手書きの規則（語の分割・RFC 3339 の部分集合の時刻・1 分の固定窓 × svc の配列・
// 5 分の滑り窓）。行は lines()・語は &str の部分列・ユーザーは HashMap<&str, i64>。出力は Sober 版とバイト一致
use std::collections::HashMap;
use std::fs;
use std::io::{self, Write};

const W: usize = 1442; // 分の窓の数（起点の 1 分前から 24 時間 + 1 分）
const H: usize = 24; // 遅延のヒストグラムの箱（log2）
const SVCS: [&str; 8] = ["api", "auth", "orders", "payments", "search", "catalog", "users", "static"];
const LEVELS: [&str; 4] = ["debug", "info", "warn", "error"];

fn fnv(mut h: i64, s: &str) -> i64 {
    for &c in s.as_bytes() {
        h = (h ^ c as i64).wrapping_mul(1099511628211);
    }
    h
}

// num は s[a..a+n] の 10 進（数でない byte があれば -1）
fn num(s: &[u8], a: usize, n: usize) -> i64 {
    let mut v = 0i64;
    for &c in &s[a..a + n] {
        if !c.is_ascii_digit() {
            return -1;
        }
        v = v * 10 + (c - b'0') as i64;
    }
    v
}

fn atoi(s: &str) -> i64 {
    if s.is_empty() {
        return -1;
    }
    num(s.as_bytes(), 0, s.len())
}

fn leap(y: i64) -> bool {
    y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)
}

fn dim(y: i64, m: i64) -> i64 {
    match m {
        2 => {
            if leap(y) {
                29
            } else {
                28
            }
        }
        4 | 6 | 9 | 11 => 30,
        _ => 31,
    }
}

// days は 1970-01-01 からの日数（Howard Hinnant の days_from_civil）
fn days(y0: i64, m: i64, d: i64) -> i64 {
    let y = if m <= 2 { y0 - 1 } else { y0 };
    let era = (if y < 0 { y - 399 } else { y }) / 400;
    let yoe = y - era * 400;
    let doy = (153 * ((m + 9) % 12) + 2) / 5 + d - 1;
    let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
    era * 146097 + doe - 719468
}

// parse_ts は `YYYY-MM-DDTHH:MM:SS[.f{1,9}](Z|±HH:MM)` を (epoch 秒, ナノ秒) に
fn parse_ts(ts: &str) -> Option<(i64, i64)> {
    let s = ts.as_bytes();
    let n = s.len();
    if n < 20 || s[4] != b'-' || s[7] != b'-' || s[10] != b'T' || s[13] != b':' || s[16] != b':' {
        return None;
    }
    let (y, mo, d) = (num(s, 0, 4), num(s, 5, 2), num(s, 8, 2));
    let (hh, mi, ss) = (num(s, 11, 2), num(s, 14, 2), num(s, 17, 2));
    if y < 0 || mo < 1 || mo > 12 || d < 1 || d > dim(y, mo) || hh < 0 || hh > 23 || mi < 0 || mi > 59 || ss < 0 || ss > 59 {
        return None;
    }
    let mut i = 19;
    let mut ns = 0i64;
    if s[i] == b'.' {
        i += 1;
        let mut k = 0;
        while i < n && s[i].is_ascii_digit() && k < 9 {
            ns = ns * 10 + (s[i] - b'0') as i64;
            i += 1;
            k += 1;
        }
        if k == 0 {
            return None;
        }
        while k < 9 {
            ns *= 10;
            k += 1;
        }
    }
    let mut off = 0;
    if i < n && s[i] == b'Z' {
        i += 1;
    } else if i + 6 <= n && (s[i] == b'+' || s[i] == b'-') && s[i + 3] == b':' {
        let (oh, om) = (num(s, i + 1, 2), num(s, i + 4, 2));
        if oh < 0 || oh > 23 || om < 0 || om > 59 {
            return None;
        }
        off = oh * 3600 + om * 60;
        if s[i] == b'-' {
            off = -off;
        }
        i += 6;
    } else {
        return None;
    }
    if i != n {
        return None;
    }
    Some((days(y, mo, d) * 86400 + hh * 3600 + mi * 60 + ss - off, ns))
}

// unq は値の引用符を外したときのバイト数（\ は次の 1 バイトを守る）
fn unq(x: &str) -> i64 {
    let v = x.as_bytes();
    if v.len() < 2 || v[0] != b'"' {
        return v.len() as i64;
    }
    let mut k = 0;
    let mut i = 1;
    while i < v.len() - 1 {
        if v[i] == b'\\' {
            i += 1;
        }
        k += 1;
        i += 1;
    }
    k
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let data = fs::read_to_string(&args[1]).expect("read");
    let base = days(2026, 10, 10) * 86400;
    let mut cnt = vec![0i64; W * 8];
    let mut c4 = vec![0i64; W * 8];
    let mut c5 = vec![0i64; W * 8];
    let mut dsum = vec![0i64; W * 8];
    let mut dmax = vec![0i64; W * 8];
    let mut hist = vec![0i64; 8 * H];
    let mut lv = [0i64; 4];
    let mut users: HashMap<&str, i64> = HashMap::new();
    let (mut lines, mut b_quote, mut b_noeq, mut b_nots, mut b_ts, mut b_status, mut b_svc, mut b_range) = (0, 0, 0, 0, 0, 0, 0, 0);
    let (mut msg_bytes, mut path_bytes, mut ns_sum) = (0i64, 0i64, 0i64);
    for line in data.lines() {
        lines += 1;
        let b = line.as_bytes();
        let e = b.len();
        let (mut ts, mut level, mut svc, mut status, mut dur, mut user, mut msg, mut path) = ("", "", "", "", "", "", "", "");
        let (mut has_ts, mut has_user) = (false, false);
        let mut bad = 0; // 1 閉じない引用符・2 = の無い語
        let mut pos = 0;
        while pos < e && bad == 0 {
            let mut j = pos;
            let mut inq = false;
            let mut eq: Option<usize> = None;
            while j < e {
                let c = b[j];
                if inq {
                    if c == b'\\' {
                        j += 2;
                        continue;
                    }
                    if c == b'"' {
                        inq = false;
                    }
                } else {
                    if c == b' ' {
                        break;
                    }
                    if c == b'"' {
                        inq = true;
                    } else if c == b'=' && eq.is_none() {
                        eq = Some(j);
                    }
                }
                j += 1;
            }
            if inq {
                bad = 1;
            } else if let Some(q) = eq {
                let k = &line[pos..q];
                let x = &line[q + 1..j];
                match k {
                    "ts" => {
                        ts = x;
                        has_ts = true;
                    }
                    "level" => level = x,
                    "svc" => svc = x,
                    "status" => status = x,
                    "dur_us" => dur = x,
                    "user" => {
                        user = x;
                        has_user = true;
                    }
                    "msg" => msg = x,
                    "path" => path = x,
                    _ => {}
                }
            } else {
                bad = 2;
            }
            pos = j + 1;
        }
        if bad == 1 {
            b_quote += 1;
            continue;
        }
        if bad == 2 {
            b_noeq += 1;
            continue;
        }
        if !has_ts {
            b_nots += 1;
            continue;
        }
        let Some((sec, ns)) = parse_ts(ts) else {
            b_ts += 1;
            continue;
        };
        let st = atoi(status);
        if st < 0 {
            b_status += 1;
            continue;
        }
        let Some(si) = SVCS.iter().position(|&s| s == svc) else {
            b_svc += 1;
            continue;
        };
        let rel = sec - base + 60;
        if rel < 0 || rel >= (W * 60) as i64 {
            b_range += 1;
            continue;
        }
        let c = rel as usize / 60 * 8 + si;
        cnt[c] += 1;
        if (400..500).contains(&st) {
            c4[c] += 1;
        }
        if (500..600).contains(&st) {
            c5[c] += 1;
        }
        let d = atoi(dur);
        dsum[c] += d;
        if d > dmax[c] {
            dmax[c] = d;
        }
        let mut bk = 0;
        while bk < H - 1 && d >> bk > 0 {
            bk += 1;
        }
        hist[si * H + bk] += 1;
        if let Some(k) = LEVELS.iter().position(|&l| l == level) {
            lv[k] += 1;
        }
        if has_user {
            *users.entry(user).or_insert(0) += 1;
        }
        msg_bytes += unq(msg);
        path_bytes += path.len() as i64;
        ns_sum += ns;
    }
    let mut out = io::BufWriter::new(io::stdout().lock());
    writeln!(out, "lines {}", lines).unwrap();
    writeln!(out, "bad quote {} noeq {} nots {} ts {} status {} svc {} range {}", b_quote, b_noeq, b_nots, b_ts, b_status, b_svc, b_range).unwrap();
    for k in 0..4 {
        writeln!(out, "level {} {}", LEVELS[k], lv[k]).unwrap();
    }
    for si in 0..8 {
        let (mut n, mut n4, mut n5, mut ds, mut dm) = (0i64, 0i64, 0i64, 0i64, 0i64);
        for m in 0..W {
            let c = m * 8 + si;
            n += cnt[c];
            n4 += c4[c];
            n5 += c5[c];
            ds += dsum[c];
            dm = dm.max(dmax[c]);
        }
        // p99 の箱: 累積が 99% に届く最初の箱
        let (mut p99, mut cum) = (0, 0i64);
        for bk in 0..H {
            cum += hist[si * H + bk];
            if cum * 100 >= n * 99 {
                p99 = bk;
                break;
            }
        }
        // 滑り窓: 直近 5 分の 5xx が 5% を超えた分の数
        let mut alarms = 0;
        for m in 4..W {
            let (mut wn, mut w5) = (0i64, 0i64);
            for k in m - 4..=m {
                wn += cnt[k * 8 + si];
                w5 += c5[k * 8 + si];
            }
            if wn > 0 && w5 * 100 > wn * 5 {
                alarms += 1;
            }
        }
        writeln!(out, "svc {} {} 4xx {} 5xx {} dur_sum {} dur_max {} p99_bucket {} alarms {}", SVCS[si], n, n4, n5, ds, dm, p99, alarms).unwrap();
    }
    let (mut umax, mut uh) = (0i64, 0i64);
    for (u, &c) in &users {
        umax = umax.max(c);
        uh = uh.wrapping_add(fnv(fnv(fnv(-3750763034362895579, u), "="), &c.to_string()));
    }
    writeln!(out, "users {} max {} hash {}", users.len(), umax, uh).unwrap();
    writeln!(out, "msg_bytes {}", msg_bytes).unwrap();
    writeln!(out, "path_bytes {}", path_bytes).unwrap();
    writeln!(out, "ns_sum {}", ns_sum).unwrap();
    let mut h: i64 = -3750763034362895579;
    for m in 0..W {
        for si in 0..8 {
            let c = m * 8 + si;
            if cnt[c] > 0 {
                h = fnv(h, &format!("{} {} {} {} {} {}\n", m, si, cnt[c], c5[c], dsum[c], dmax[c]));
            }
        }
    }
    writeln!(out, "hash {}", h).unwrap();
}
