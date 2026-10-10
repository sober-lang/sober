// jsonapi の Rust の双子（素直縛り — std だけ・crate なし）: serde が使えないので、汎用の値の木（enum Value）へ再帰下降で parse してから欄を引く
// （crate 無しの Rust で最初に書く形）。検証 → 小計・割引・税 → レスポンスは format! で直列化。出力は Sober 版とバイト一致
use std::fs;
use std::io::{self, Write};

#[allow(dead_code)] // Bool の中身は読まない（汎用の値の木として持つ）
enum Value {
    Null,
    Bool(bool),
    Num(String),
    Str(String),
    Arr(Vec<Value>),
    Obj(Vec<(String, Value)>),
}

struct Parser<'a> {
    b: &'a [u8],
    i: usize,
}

impl<'a> Parser<'a> {
    fn ws(&mut self) {
        while self.i < self.b.len() && matches!(self.b[self.i], b' ' | b'\t' | b'\n' | b'\r') {
            self.i += 1;
        }
    }

    fn value(&mut self) -> Option<Value> {
        self.ws();
        match *self.b.get(self.i)? {
            b'{' => {
                self.i += 1;
                let mut fs = Vec::new();
                self.ws();
                if self.b.get(self.i) == Some(&b'}') {
                    self.i += 1;
                    return Some(Value::Obj(fs));
                }
                loop {
                    self.ws();
                    let k = self.string()?;
                    self.ws();
                    if self.b.get(self.i) != Some(&b':') {
                        return None;
                    }
                    self.i += 1;
                    let v = self.value()?;
                    fs.push((k, v));
                    self.ws();
                    match self.b.get(self.i)? {
                        b',' => self.i += 1,
                        b'}' => {
                            self.i += 1;
                            return Some(Value::Obj(fs));
                        }
                        _ => return None,
                    }
                }
            }
            b'[' => {
                self.i += 1;
                let mut xs = Vec::new();
                self.ws();
                if self.b.get(self.i) == Some(&b']') {
                    self.i += 1;
                    return Some(Value::Arr(xs));
                }
                loop {
                    xs.push(self.value()?);
                    self.ws();
                    match self.b.get(self.i)? {
                        b',' => self.i += 1,
                        b']' => {
                            self.i += 1;
                            return Some(Value::Arr(xs));
                        }
                        _ => return None,
                    }
                }
            }
            b'"' => Some(Value::Str(self.string()?)),
            b't' => self.lit("true", Value::Bool(true)),
            b'f' => self.lit("false", Value::Bool(false)),
            b'n' => self.lit("null", Value::Null),
            b'-' | b'0'..=b'9' => {
                let s = self.i;
                self.i += 1;
                while self.i < self.b.len() && matches!(self.b[self.i], b'0'..=b'9' | b'.' | b'e' | b'E' | b'+' | b'-') {
                    self.i += 1;
                }
                Some(Value::Num(String::from_utf8(self.b[s..self.i].to_vec()).ok()?))
            }
            _ => None,
        }
    }

    fn lit(&mut self, w: &str, v: Value) -> Option<Value> {
        if self.b[self.i..].starts_with(w.as_bytes()) {
            self.i += w.len();
            Some(v)
        } else {
            None
        }
    }

    fn string(&mut self) -> Option<String> {
        if self.b.get(self.i) != Some(&b'"') {
            return None;
        }
        self.i += 1;
        let mut out = Vec::new();
        loop {
            let c = *self.b.get(self.i)?;
            self.i += 1;
            match c {
                b'"' => return String::from_utf8(out).ok(),
                b'\\' => {
                    let e = *self.b.get(self.i)?;
                    self.i += 1;
                    match e {
                        b'"' => out.push(b'"'),
                        b'\\' => out.push(b'\\'),
                        b'/' => out.push(b'/'),
                        b'b' => out.push(8),
                        b'f' => out.push(12),
                        b'n' => out.push(b'\n'),
                        b'r' => out.push(b'\r'),
                        b't' => out.push(b'\t'),
                        b'u' => {
                            let h = std::str::from_utf8(self.b.get(self.i..self.i + 4)?).ok()?;
                            let cp = u32::from_str_radix(h, 16).ok()?;
                            self.i += 4;
                            let ch = char::from_u32(cp)?;
                            let mut buf = [0u8; 4];
                            out.extend_from_slice(ch.encode_utf8(&mut buf).as_bytes());
                        }
                        _ => return None,
                    }
                }
                _ => out.push(c),
            }
        }
    }
}

fn parse(b: &[u8]) -> Option<Value> {
    let mut p = Parser { b, i: 0 };
    let v = p.value()?;
    p.ws();
    if p.i != b.len() {
        return None;
    }
    Some(v)
}

fn get<'v>(fs: &'v [(String, Value)], k: &str) -> Option<&'v Value> {
    fs.iter().find(|(n, _)| n == k).map(|(_, v)| v)
}

fn int(v: &Value) -> Option<i64> {
    match v {
        Value::Num(s) => s.parse().ok(),
        _ => None,
    }
}

fn tax_rate(cur: &str) -> i64 {
    match cur {
        "JPY" => 10,
        "USD" => 8,
        "EUR" => 20,
        _ => -1,
    }
}

struct Done {
    id: i64,
    items: usize,
    total: i64,
    currency: String,
    note: usize,
}

// handle は 1 リクエストの処理: Ok か（読めた id, 誤りの code）
fn handle(line: &[u8]) -> Result<Done, (Option<i64>, &'static str)> {
    let v = parse(line).ok_or((None, "json"))?;
    let fs = match &v {
        Value::Obj(fs) => fs,
        _ => return Err((None, "type")),
    };
    let id = get(fs, "id").and_then(int);
    let e = |c| Err((id, c));
    let (Some(idv), Some(user), Some(cur), Some(items)) = (get(fs, "id"), get(fs, "user"), get(fs, "currency"), get(fs, "items")) else {
        return e(if get(fs, "id").is_none() {
            "missing:id"
        } else if get(fs, "user").is_none() {
            "missing:user"
        } else if get(fs, "currency").is_none() {
            "missing:currency"
        } else {
            "missing:items"
        });
    };
    let (Some(idn), Value::Str(_), Value::Str(cur), Value::Arr(items)) = (int(idv), user, cur, items) else {
        return e("type");
    };
    let mut its = Vec::new();
    for it in items {
        let Value::Obj(f) = it else { return e("type") };
        let (Some(Value::Str(_)), Some(q), Some(p)) = (get(f, "sku"), get(f, "qty").and_then(int), get(f, "price").and_then(int)) else {
            return e("type");
        };
        its.push((q, p));
    }
    let coupon = match get(fs, "coupon") {
        None | Some(Value::Null) => None,
        Some(Value::Str(s)) => Some(s.as_str()),
        _ => return e("type"),
    };
    let note = match get(fs, "note") {
        None | Some(Value::Null) => 0,
        Some(Value::Str(s)) => s.len(),
        _ => return e("type"),
    };
    if its.is_empty() {
        return e("range:items");
    }
    if its.iter().any(|&(q, _)| q < 1 || q > 100) {
        return e("range:qty");
    }
    let rate = tax_rate(cur);
    if rate < 0 {
        return e("currency");
    }
    let sub: i64 = its.iter().map(|&(q, p)| q * p).sum();
    let disc = match coupon {
        Some("SAVE10") => sub / 10,
        Some("FLAT500") => sub.min(500),
        _ => 0,
    };
    let after = sub - disc;
    Ok(Done { id: idn, items: its.len(), total: after + after * rate / 100, currency: cur.clone(), note })
}

const CODES: [&str; 9] = ["json", "missing:id", "missing:user", "missing:currency", "missing:items", "type", "range:items", "range:qty", "currency"];

fn main() {
    let path = std::env::args().nth(1).expect("usage: jsonapi <file>");
    let data = fs::read(&path).expect("read");
    let (mut n, mut ok, mut jpy, mut usd, mut eur, mut note_bytes) = (0, 0, 0i64, 0i64, 0i64, 0usize);
    let mut errs = [0usize; 9];
    let mut h: u64 = 14695981039346656037;
    for line in data.split(|&c| c == b'\n') {
        if line.is_empty() {
            continue;
        }
        n += 1;
        let resp = match handle(line) {
            Ok(o) => {
                ok += 1;
                match o.currency.as_str() {
                    "JPY" => jpy += o.total,
                    "USD" => usd += o.total,
                    _ => eur += o.total,
                }
                note_bytes += o.note;
                format!(r#"{{"id":{},"status":"ok","items":{},"total":{},"currency":"{}"}}"#, o.id, o.items, o.total, o.currency)
            }
            Err((id, code)) => {
                errs[CODES.iter().position(|&c| c == code).unwrap()] += 1;
                let ids = id.map_or("null".to_string(), |x| x.to_string());
                format!(r#"{{"id":{},"status":"error","code":"{}"}}"#, ids, code)
            }
        };
        for &c in resp.as_bytes() {
            h = (h ^ c as u64).wrapping_mul(1099511628211);
        }
        h = (h ^ b'\n' as u64).wrapping_mul(1099511628211);
    }
    let out = io::stdout();
    let mut w = io::BufWriter::new(out.lock());
    writeln!(w, "requests {}\nok {}", n, ok).unwrap();
    for (i, c) in CODES.iter().enumerate() {
        writeln!(w, "error {} {}", c, errs[i]).unwrap();
    }
    writeln!(w, "total JPY {}\ntotal USD {}\ntotal EUR {}\nnote_bytes {}\nhash {}", jpy, usd, eur, note_bytes, h as i64).unwrap();
}
