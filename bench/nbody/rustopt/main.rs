// 慣用版 — 許す技法: FxHash 手書き・entry/capacity・split_at_mut 等、性能を意識する Rust 使いが
// 普通に使う安全な定石。禁止: unsafe・明示 SIMD intrinsics・別アルゴリズム（rust/ の素直版と同じ解法を保つ）
//
// n-body の慣用チューニング版（bench/nbody/rust/main.rs の素直版をベースに、性能を意識する
// Rust 使いが普通に使う技法だけを足す。アルゴリズムは変えない・unsafe / 明示 SIMD なし）
//
// 施した技法:
//   1. 添字の二重ループ（bodies[i] / bodies[j]）を split_at_mut + iter_mut に書き換え。
//      素直版は i, j の可変添字アクセスのたびに境界検査が入り、かつコンパイラは
//      bodies[i] と bodies[j] が別のメモリであることを証明できずエイリアシング保守的に
//      なる。split_at_mut は「後ろ半分」を独立した可変借用として切り出すので、
//      エイリアシングが型レベルで保証され、ループは iterator 形で境界検査も素直に
//      畳み込まれる — 性能志向の Rust コードでの定番パターン（例: itertools の
//      tuple_combinations や rayon の split_at_mut 系 API もこの形に依る）
//   2. energy() も同様に iter().enumerate() + 残りスライスの split_first に書き換え
//   3. 数式・定数・出力は素直版と同一
use std::env;

#[derive(Clone, Copy)]
struct Body {
    x: f64,
    y: f64,
    z: f64,
    vx: f64,
    vy: f64,
    vz: f64,
    mass: f64,
}

fn energy(bodies: &[Body]) -> f64 {
    let mut e = 0.0;
    let mut rest = bodies;
    while let Some((b, tail)) = rest.split_first() {
        e += 0.5 * b.mass * (b.vx * b.vx + b.vy * b.vy + b.vz * b.vz);
        for b2 in tail {
            let dx = b.x - b2.x;
            let dy = b.y - b2.y;
            let dz = b.z - b2.z;
            e -= (b.mass * b2.mass) / (dx * dx + dy * dy + dz * dz).sqrt();
        }
        rest = tail;
    }
    e
}

fn advance(bodies: &mut [Body], dt: f64) {
    let n = bodies.len();
    for i in 0..n {
        let (head, tail) = bodies.split_at_mut(i + 1);
        let bi = &mut head[i];
        for bj in tail.iter_mut() {
            let dx = bi.x - bj.x;
            let dy = bi.y - bj.y;
            let dz = bi.z - bj.z;
            let dsq = dx * dx + dy * dy + dz * dz;
            let mag = dt / (dsq * dsq.sqrt());
            let mj = bj.mass;
            let mi = bi.mass;
            bi.vx -= dx * mj * mag;
            bi.vy -= dy * mj * mag;
            bi.vz -= dz * mj * mag;
            bj.vx += dx * mi * mag;
            bj.vy += dy * mi * mag;
            bj.vz += dz * mi * mag;
        }
    }
    for b in bodies.iter_mut() {
        b.x += dt * b.vx;
        b.y += dt * b.vy;
        b.z += dt * b.vz;
    }
}

fn main() {
    let n: usize = env::args().nth(1).map(|s| s.parse().unwrap()).unwrap_or(1000);
    let pi = std::f64::consts::PI;
    let solar_mass = 4.0 * pi * pi;
    let dpy = 365.24;
    let mut bodies = vec![
        Body { x: 0.0, y: 0.0, z: 0.0, vx: 0.0, vy: 0.0, vz: 0.0, mass: solar_mass },
        Body { x: 4.84143144246472090e+00, y: -1.16032004402742839e+00, z: -1.03622044471123109e-01, vx: 1.66007664274403694e-03 * dpy, vy: 7.69901118419740425e-03 * dpy, vz: -6.90460016972063023e-05 * dpy, mass: 9.54791938424326609e-04 * solar_mass },
        Body { x: 8.34336671824457987e+00, y: 4.12479856412430479e+00, z: -4.03523417114321381e-01, vx: -2.76742510726862411e-03 * dpy, vy: 4.99852801234917238e-03 * dpy, vz: 2.30417297573763929e-05 * dpy, mass: 2.85885980666130812e-04 * solar_mass },
        Body { x: 1.28943695621391310e+01, y: -1.51111514016986312e+01, z: -2.23307578892655734e-01, vx: 2.96460137564761618e-03 * dpy, vy: 2.37847173959480950e-03 * dpy, vz: -2.96589568540237556e-05 * dpy, mass: 4.36624404335156298e-05 * solar_mass },
        Body { x: 1.53796971148509165e+01, y: -2.59193146099879641e+01, z: 1.79258772950371181e-01, vx: 2.68067772490389322e-03 * dpy, vy: 1.62824170038242295e-03 * dpy, vz: -9.51592254519715870e-05 * dpy, mass: 5.15138902046611451e-05 * solar_mass },
    ];
    let (mut px, mut py, mut pz) = (0.0, 0.0, 0.0);
    for b in &bodies {
        px += b.vx * b.mass;
        py += b.vy * b.mass;
        pz += b.vz * b.mass;
    }
    bodies[0].vx = -px / solar_mass;
    bodies[0].vy = -py / solar_mass;
    bodies[0].vz = -pz / solar_mass;
    println!("{:.9}", energy(&bodies));
    for _ in 0..n {
        advance(&mut bodies, 0.01);
    }
    println!("{:.9}", energy(&bodies));
}
