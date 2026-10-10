//! IR で書いたランタイム（backend-drafts「ランタイムは IR で書く」）。両バックエンドが普通の関数として下ろす。
//! 中身は codegen.zig の手書き asm ランタイム（runtime / emitRegionEnter）と同じアルゴリズム。
//!
//! メタ領域はグローバル @rt.meta（語の配列）。番地は観測されないので codegen の固定番地 0x600000 は写さない。
//! 配置（語）: [0] 深度、[1 + d] 深度 d の bump、FD、ERRNO、LINE_LEN、SLOTS（アリーナ基底）、LINE（行バッファのバイト列）、
//! ACC + d（--mem-trace: 深度 d で閉じた region の割り当て総量 — codegen の META_ACC と同じ意味）、ARGV（入口の初期 rsp — std/os.Args の原本）
//! アリーナは入口で mmap（NORESERVE の仮想予約のみ）するスロット × MAX_DEPTH。深度 d のスロットは SLOTS + d * スロット から
//! （codegen の ARENA_SLOTS と同じ構成。番地は mmap に任せる）。スロットの大きさは実行時に決まり、meta の SLOT_SIZE に置く:
//! 既定 DEFAULT_SLOT_MB、環境変数 SOBER_REGION_MB（MiB の 10 進、1〜MAX_SLOT_MB）で上書き。予約が断られたら（overcommit 2 等）
//! スロットを半分にして 1MiB まで再試行する — 上限に届けば exit 102 の契約は同じ（language.md 27 節）。容量だけが変わり、深度の上限は 1024 のまま
const std = @import("std");
const ir = @import("ir.zig");
const ir_rt_io = @import("ir_rt_io.zig");

pub const MAX_DEPTH: i64 = 1024;
/// スロットの既定 4GiB（× 1024 深度 = 4TiB の仮想予約 — 47bit のユーザー空間 128TiB に収まる）。旧 64MiB 固定
pub const DEFAULT_SLOT_MB: i64 = 4096;
/// SOBER_REGION_MB の上限 64GiB（× 1024 = 64TiB）。越える値・0・数字以外は無視して既定を使う
pub const MAX_SLOT_MB: i64 = 65536;
pub const ENV_KEY = "SOBER_REGION_MB=";
pub const LINE_CAP: i64 = 4096;

pub const W_DEPTH: i32 = 0;
pub const W_BUMP: i32 = 1;
pub const W_FD: i32 = W_BUMP + @as(i32, @intCast(MAX_DEPTH)) + 1;
pub const W_ERRNO: i32 = W_FD + 1;
pub const W_LINE_LEN: i32 = W_ERRNO + 1;
pub const W_SLOTS: i32 = W_LINE_LEN + 1;
pub const W_SLOT_SIZE: i32 = W_SLOTS + 1;
pub const W_LINE: i32 = W_SLOT_SIZE + 1;
pub const W_ACC: i32 = W_LINE + @as(i32, @intCast(@divExact(LINE_CAP, 8)));
pub const W_ARGV: i32 = W_ACC + @as(i32, @intCast(MAX_DEPTH)) + 1;
const META_WORDS: u32 = @intCast(W_ARGV + 1);

/// panic の exit code（language.md 27 節）
pub const PANIC: u8 = 101;
pub const PANIC_MEM: u8 = 102;

/// ランタイム関数の id（lowering が call する）
pub const Rt = struct {
    print_char: ir.FuncId,
    print_int: ir.FuncId,
    flush: ir.FuncId,
    /// copy(dst, src, n): n 語を前から写す
    copy: ir.FuncId,
    /// str_eq(a, b): 2 つの 3 語ヘッダが指すセル列が等しいか（長さ + 全セル）
    str_eq: ir.FuncId,
    /// map_find(hdr, key, cellw, strkey): キーが一致する最初のセルのアドレス（不在は 0）。key は int 1 語か string ヘッダの置き場
    map_find: ir.FuncId,
    /// print_str(hdr): セルごとに print_char
    print_str: ir.FuncId,
    /// read_file / write_file / read_args / read_dir / write_fd（ir_rt_io.zig — std/ の sys* 組み込み）
    io: ir_rt_io.Io,
    /// --mem-trace のときだけ: 入口が main の後・exit の前に呼ぶ（深度別の割り当て総量を stderr へ）
    memtrace: ?ir.FuncId = null,
};

pub fn install(m: *ir.Module, mem_trace: bool) !Rt {
    m.rt.meta = try m.addGlobal("rt.meta", META_WORDS);
    const flush = try m.addFunc("rt.flush", &.{}, null);
    const print_char = try m.addFunc("rt.print_char", &.{.i64}, null);
    const print_int = try m.addFunc("rt.print_int", &.{.i64}, null);
    m.rt.region_enter = try m.addFunc("rt.region_enter", &.{}, null);
    m.rt.region_alloc = try m.addFunc("rt.region_alloc", &.{ .i64, .i64 }, .ptr);
    m.rt.region_relocate = try m.addFunc("rt.region_relocate", &.{ .ptr, .i64, .i64 }, null);
    const copy = try m.addFunc("rt.copy", &.{ .ptr, .ptr, .i64 }, null);
    const str_eq = try m.addFunc("rt.str_eq", &.{ .ptr, .ptr }, .i64);
    const map_find = try m.addFunc("rt.map_find", &.{ .ptr, .ptr, .i64, .i64 }, .i64);
    const print_str = try m.addFunc("rt.print_str", &.{.ptr}, null);
    try buildFlush(m, flush);
    try buildPrintChar(m, print_char, flush);
    try buildPrintInt(m, print_int, print_char);
    try buildRegionEnter(m, m.rt.region_enter, mem_trace);
    try buildRegionAlloc(m, m.rt.region_alloc);
    try buildCopy(m, copy);
    try buildRelocate(m, m.rt.region_relocate, copy);
    try buildStrEq(m, str_eq);
    try buildMapFind(m, map_find, str_eq);
    try buildPrintStr(m, print_str, print_char);
    const io = try ir_rt_io.install(m, flush);
    var memtrace: ?ir.FuncId = null;
    if (mem_trace) {
        const id = try m.addFunc("rt.memtrace", &.{}, null);
        try buildMemTrace(m, id, print_int, print_char);
        memtrace = id;
    }
    return .{ .print_char = print_char, .print_int = print_int, .flush = flush, .copy = copy, .str_eq = str_eq, .map_find = map_find, .print_str = print_str, .io = io, .memtrace = memtrace };
}

/// 入口 sober_entry(sp): アリーナを予約し、深度 0・出力 fd 1 で main を呼び、exit(0)（flush しない — 行は改行で flush 済み）。
/// `func main() int` なら戻り値が終了コード（0〜255 の外は panic 101 — exit_group(code)）。
/// sp は _start の初期 rsp（[argc, argv…, 0, envp…, 0]）— 環境変数 SOBER_REGION_MB を読み、W_ARGV に置く（read_args が読む）。
/// 予約の失敗（1MiB のスロットでも断られる）は exit 102（codegen の mmap_fail_at と同じ）
pub fn buildEntry(m: *ir.Module, main_fn: ir.FuncId, main_int: bool, memtrace: ?ir.FuncId) !ir.FuncId {
    const id = try m.addFunc("sober_entry", &.{.ptr}, null);
    m.funcs.items[id].exported = true;
    var b = try ir.Builder.begin(m, id);
    const sp = m.funcs.items[id].params[0];
    const meta = try b.globaladdr(m.rt.meta);
    const mb = try envSlotMb(&b, sp);
    // reserve(mb): mmap(NULL, mb MiB * MAX_DEPTH, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0)
    const reserve = try b.newBlock();
    const cur = try b.param(reserve, .i64);
    const shrink = try b.newBlock();
    const fail = try b.newBlock();
    const ok = try b.newBlock();
    try b.br(reserve, &.{mb});
    b.cur = reserve;
    const slot = try b.bin(.shl, cur, try b.iconst(20));
    const base = try b.syscall(&.{ try b.iconst(9), try b.iconst(0), try b.bin(.mul, slot, try b.iconst(MAX_DEPTH)), try b.iconst(3), try b.iconst(0x4022), try b.iconst(-1), try b.iconst(0) });
    // 失敗は -4095..-1（符号なしで最上位の 4095 個）
    try b.condbr(try b.cmp(.uge, base, try b.iconst(-4095)), shrink, &.{}, ok, &.{});
    b.cur = shrink;
    try b.condbr(try b.cmp(.gt, cur, try b.iconst(1)), reserve, &.{try b.bin(.sar, cur, try b.iconst(1))}, fail, &.{});
    b.cur = fail;
    b.exit(PANIC_MEM);
    b.cur = ok;
    try b.store(meta, W_SLOTS, base);
    try b.store(meta, W_SLOT_SIZE, slot);
    try b.store(meta, W_DEPTH, try b.iconst(0));
    try b.store(meta, W_FD, try b.iconst(1));
    try b.store(meta, W_ARGV, try b.ptoi(sp));
    const code = try b.call(main_fn, &.{});
    if (memtrace) |f| _ = try b.call(f, &.{});
    if (main_int) {
        const bad = try b.newBlock();
        const good = try b.newBlock();
        try b.condbr(try b.cmp(.uge, code.?, try b.iconst(256)), bad, &.{}, good, &.{});
        b.cur = bad;
        b.exit(PANIC);
        b.cur = good;
        _ = try b.syscall(&.{ try b.iconst(231), code.? });
    }
    b.exit(0);
    return id;
}

/// 環境変数 SOBER_REGION_MB の値（MiB）。無い・空・0・数字以外を含む・MAX_SLOT_MB を越えるなら DEFAULT_SLOT_MB。
/// 最初に現れた SOBER_REGION_MB= だけを見る。戻ると b.cur は値が決まったブロック
fn envSlotMb(b: *ir.Builder, sp: ir.Value) !ir.Value {
    const argc = try b.load(sp, 0);
    const envp = try b.gepWord(sp, try b.bin(.add, argc, try b.iconst(2)));
    const scan = try b.newBlock();
    const e = try b.param(scan, .ptr);
    const done = try b.newBlock();
    const res = try b.param(done, .i64);
    const got = try b.newBlock();
    const next = try b.newBlock();
    try b.br(scan, &.{envp});

    // scan(e): *e == 0 なら既定、そうでなければ鍵の接頭辞を 1 バイトずつ照合（鍵は定数なので展開）
    b.cur = scan;
    const sv = try b.load(e, 0);
    const chk = try b.newBlock();
    try b.condbr(try b.cmp(.eq, sv, try b.iconst(0)), done, &.{try b.iconst(DEFAULT_SLOT_MB)}, chk, &.{});
    b.cur = chk;
    const str = try b.itop(sv);
    for (ENV_KEY, 0..) |c, i| {
        const c_ok = try b.newBlock();
        const ch = try b.load8(try b.gepByte(str, try b.iconst(@intCast(i))), 0);
        try b.condbr(try b.cmp(.eq, ch, try b.iconst(c)), c_ok, &.{}, next, &.{});
        b.cur = c_ok;
    }
    try b.br(got, &.{});

    // next: 次の環境変数
    b.cur = next;
    try b.br(scan, &.{try b.gepWord(e, try b.iconst(1))});

    // got: 値の 10 進（val(n, i)）。終わり（NUL）で n が 1〜MAX_SLOT_MB なら採用、それ以外は既定
    b.cur = got;
    const val = try b.newBlock();
    const n = try b.param(val, .i64);
    const i = try b.param(val, .i64);
    try b.br(val, &.{ try b.iconst(0), try b.iconst(ENV_KEY.len) });
    b.cur = val;
    const ch = try b.load8(try b.gepByte(str, i), 0);
    const end = try b.newBlock();
    const dig = try b.newBlock();
    const dig2 = try b.newBlock();
    const acc = try b.newBlock();
    const use = try b.newBlock();
    const dflt = try b.iconst(DEFAULT_SLOT_MB);
    try b.condbr(try b.cmp(.eq, ch, try b.iconst(0)), end, &.{}, dig, &.{});
    b.cur = end;
    try b.condbr(try b.cmp(.gt, n, try b.iconst(0)), use, &.{}, done, &.{dflt});
    b.cur = use;
    try b.br(done, &.{n});
    b.cur = dig;
    try b.condbr(try b.cmp(.ge, ch, try b.iconst('0')), dig2, &.{}, done, &.{dflt});
    b.cur = dig2;
    try b.condbr(try b.cmp(.le, ch, try b.iconst('9')), acc, &.{}, done, &.{dflt});
    b.cur = acc;
    const n2 = try b.bin(.add, try b.bin(.mul, n, try b.iconst(10)), try b.bin(.sub, ch, try b.iconst('0')));
    const more = try b.newBlock();
    try b.condbr(try b.cmp(.gt, n2, try b.iconst(MAX_SLOT_MB)), done, &.{dflt}, more, &.{});
    b.cur = more;
    try b.br(val, &.{ n2, try b.bin(.add, i, try b.iconst(1)) });

    b.cur = done;
    return res;
}

/// write(fd, LINE, len)。短い書き込みは続きから、EINTR は再試行、失敗は捨てる。最後に len = 0
fn buildFlush(m: *ir.Module, id: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const meta = try b.globaladdr(m.rt.meta);
    const loop = try b.newBlock();
    const done_w = try b.param(loop, .i64);
    const body = try b.newBlock();
    const done = try b.newBlock();
    try b.br(loop, &.{try b.iconst(0)});

    b.cur = loop;
    const len = try b.load(meta, W_LINE_LEN);
    const rest = try b.bin(.sub, len, done_w);
    try b.condbr(try b.cmp(.gt, rest, try b.iconst(0)), body, &.{}, done, &.{});

    b.cur = body;
    const off = try b.bin(.add, try b.iconst(W_LINE * 8), done_w);
    const buf = try b.ptoi(try b.gepByte(meta, off));
    const fd = try b.load(meta, W_FD);
    const r = try b.syscall(&.{ try b.iconst(1), fd, buf, rest });
    const retry = try b.newBlock();
    const not_intr = try b.newBlock();
    try b.condbr(try b.cmp(.eq, r, try b.iconst(-4)), retry, &.{}, not_intr, &.{});
    b.cur = retry;
    try b.br(loop, &.{done_w});
    b.cur = not_intr;
    const ok = try b.newBlock();
    try b.condbr(try b.cmp(.le, r, try b.iconst(0)), done, &.{}, ok, &.{});
    b.cur = ok;
    try b.br(loop, &.{try b.bin(.add, done_w, r)});

    b.cur = done;
    try b.store(meta, W_LINE_LEN, try b.iconst(0));
    b.ret(null);
}

/// 行バッファへ 1 バイト積む。改行か満杯で flush
fn buildPrintChar(m: *ir.Module, id: ir.FuncId, flush: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const c = m.funcs.items[id].params[0];
    const meta = try b.globaladdr(m.rt.meta);
    const len = try b.load(meta, W_LINE_LEN);
    const p = try b.gepByte(meta, try b.bin(.add, try b.iconst(W_LINE * 8), len));
    try b.store8(p, 0, c);
    const len1 = try b.bin(.add, len, try b.iconst(1));
    try b.store(meta, W_LINE_LEN, len1);
    const do_flush = try b.newBlock();
    const check_full = try b.newBlock();
    const done = try b.newBlock();
    try b.condbr(try b.cmp(.eq, c, try b.iconst('\n')), do_flush, &.{}, check_full, &.{});
    b.cur = check_full;
    try b.condbr(try b.cmp(.ge, len1, try b.iconst(LINE_CAP)), do_flush, &.{}, done, &.{});
    b.cur = do_flush;
    _ = try b.call(flush, &.{});
    try b.br(done, &.{});
    b.cur = done;
    b.ret(null);
}

/// 10 進で書く。負数は剰余を負のまま扱う（|最小値| を作らない — 符号反転のオーバーフローを踏まない）
fn buildPrintInt(m: *ir.Module, id: ir.FuncId, print_char: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const v = m.funcs.items[id].params[0];
    const buf = try b.slotaddr(try b.newSlot(4)); // 桁バッファ 32 バイト（末尾から前へ）
    const neg = try b.cmp(.lt, v, try b.iconst(0));
    // sgn = 1 - 2*neg（剰余 d に掛けて桁の絶対値にする）
    const sgn = try b.bin(.sub, try b.iconst(1), try b.bin(.mul, try b.iconst(2), neg));
    const ten = try b.iconst(10);

    const loop = try b.newBlock();
    const x = try b.param(loop, .i64);
    const pos = try b.param(loop, .i64);
    try b.br(loop, &.{ v, try b.iconst(32) });
    b.cur = loop;
    const digit = try b.bin(.add, try b.iconst('0'), try b.bin(.mul, try b.bin(.rem, x, ten), sgn));
    const pos1 = try b.bin(.sub, pos, try b.iconst(1));
    try b.store8(try b.gepByte(buf, pos1), 0, digit);
    const q = try b.bin(.div, x, ten);
    const after = try b.newBlock();
    const start = try b.param(after, .i64);
    try b.condbr(try b.cmp(.ne, q, try b.iconst(0)), loop, &.{ q, pos1 }, after, &.{pos1});

    b.cur = after;
    const minus = try b.newBlock();
    const emit = try b.newBlock();
    const i = try b.param(emit, .i64);
    try b.condbr(neg, minus, &.{}, emit, &.{start});
    b.cur = minus;
    const s1 = try b.bin(.sub, start, try b.iconst(1));
    try b.store8(try b.gepByte(buf, s1), 0, try b.iconst('-'));
    try b.br(emit, &.{s1});

    b.cur = emit;
    const body = try b.newBlock();
    const done = try b.newBlock();
    try b.condbr(try b.cmp(.lt, i, try b.iconst(32)), body, &.{}, done, &.{});
    b.cur = body;
    _ = try b.call(print_char, &.{try b.load8(try b.gepByte(buf, i), 0)});
    try b.br(emit, &.{try b.bin(.add, i, try b.iconst(1))});
    b.cur = done;
    b.ret(null);
}

/// 深度 + 1（上限で exit 102）、その深度の bump をスロット先頭へ。
/// mem_trace: 同深度の前回インスタンスの残高（旧 bump − スロット先頭）を ACC + d へ回収する（初回は bump が 0 — .bss）
fn buildRegionEnter(m: *ir.Module, id: ir.FuncId, mem_trace: bool) !void {
    var b = try ir.Builder.begin(m, id);
    const meta = try b.globaladdr(m.rt.meta);
    const d = try b.bin(.add, try b.load(meta, W_DEPTH), try b.iconst(1));
    const over = try b.newBlock();
    const ok = try b.newBlock();
    try b.condbr(try b.cmp(.ge, d, try b.iconst(MAX_DEPTH)), over, &.{}, ok, &.{});
    b.cur = over;
    b.exit(PANIC_MEM);
    b.cur = ok;
    try b.store(meta, W_DEPTH, d);
    const base = try b.load(meta, W_SLOTS);
    const bump = try b.bin(.add, base, try b.bin(.mul, d, try b.load(meta, W_SLOT_SIZE)));
    const dp = try b.gepWord(meta, d);
    if (mem_trace) try collect(&b, dp, bump);
    try b.store(dp, W_BUMP, bump);
    b.ret(null);
}

/// dp = meta + d 語。bump[d] が 0 でなければ acc[d] += bump[d] − head（head = 深度 d のスロット先頭）
fn collect(b: *ir.Builder, dp: ir.Value, head: ir.Value) !void {
    const old = try b.load(dp, W_BUMP);
    const add = try b.newBlock();
    const done = try b.newBlock();
    try b.condbr(try b.cmp(.ne, old, try b.iconst(0)), add, &.{}, done, &.{});
    b.cur = add;
    try b.store(dp, W_ACC, try b.bin(.add, try b.load(dp, W_ACC), try b.bin(.sub, old, head)));
    try b.br(done, &.{});
    b.cur = done;
}

/// rt.memtrace（--mem-trace のときだけ）: 各深度の未回収残高を acc へ合流させてから、非ゼロの深度を "d bytes" 行で、
/// 総和を "0 total" 行で stderr に書く（以降の出力は fd 2 のまま — exit の直前なので戻さない。codegen rt_memtrace と同じ）
fn buildMemTrace(m: *ir.Module, id: ir.FuncId, print_int: ir.FuncId, print_char: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const meta = try b.globaladdr(m.rt.meta);
    try b.store(meta, W_FD, try b.iconst(2));
    const base = try b.load(meta, W_SLOTS);
    const slot = try b.load(meta, W_SLOT_SIZE);
    // pass 1: d = 1..MAX_DEPTH
    const l1 = try b.newBlock();
    const d1 = try b.param(l1, .i64);
    const b1 = try b.newBlock();
    const e1 = try b.newBlock();
    try b.br(l1, &.{try b.iconst(1)});
    b.cur = l1;
    try b.condbr(try b.cmp(.le, d1, try b.iconst(MAX_DEPTH)), b1, &.{}, e1, &.{});
    b.cur = b1;
    try collect(&b, try b.gepWord(meta, d1), try b.bin(.add, base, try b.bin(.mul, d1, slot)));
    try b.br(l1, &.{try b.bin(.add, d1, try b.iconst(1))});
    // pass 2: 出力
    b.cur = e1;
    const l2 = try b.newBlock();
    const d2 = try b.param(l2, .i64);
    const tot = try b.param(l2, .i64);
    const b2 = try b.newBlock();
    const pr = try b.newBlock();
    const next = try b.newBlock();
    const tot_n = try b.param(next, .i64);
    const e2 = try b.newBlock();
    try b.br(l2, &.{ try b.iconst(1), try b.iconst(0) });
    b.cur = l2;
    try b.condbr(try b.cmp(.le, d2, try b.iconst(MAX_DEPTH)), b2, &.{}, e2, &.{});
    b.cur = b2;
    const a = try b.load(try b.gepWord(meta, d2), W_ACC);
    try b.condbr(try b.cmp(.ne, a, try b.iconst(0)), pr, &.{}, next, &.{tot});
    b.cur = pr;
    try printPair(&b, print_int, print_char, d2, a);
    try b.br(next, &.{try b.bin(.add, tot, a)});
    b.cur = next;
    try b.br(l2, &.{ try b.bin(.add, d2, try b.iconst(1)), tot_n });
    b.cur = e2;
    try printPair(&b, print_int, print_char, try b.iconst(0), tot);
    b.ret(null);
}

fn printPair(b: *ir.Builder, print_int: ir.FuncId, print_char: ir.FuncId, x: ir.Value, y: ir.Value) !void {
    _ = try b.call(print_int, &.{x});
    _ = try b.call(print_char, &.{try b.iconst(' ')});
    _ = try b.call(print_int, &.{y});
    _ = try b.call(print_char, &.{try b.iconst('\n')});
}

/// region_alloc(d, n): 深度 d の bump を n 語進め、旧 bump を返す。スロット末尾（SLOTS + (d + 1) * SLOT_SIZE）を超えたら exit 102
/// （codegen emitBumpStore と同じ上限。codegen は書き込みの後に検査するが、観測は同じ — panic は terminal）
fn buildRegionAlloc(m: *ir.Module, id: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const d = ps[0];
    const n = ps[1];
    const meta = try b.globaladdr(m.rt.meta);
    const bp = try b.gepWord(meta, d);
    const old = try b.load(bp, W_BUMP);
    const new = try b.bin(.add, old, try b.bin(.mul, n, try b.iconst(8)));
    const limit = try b.bin(.add, try b.load(meta, W_SLOTS), try b.bin(.mul, try b.bin(.add, d, try b.iconst(1)), try b.load(meta, W_SLOT_SIZE)));
    const over = try b.newBlock();
    const ok = try b.newBlock();
    try b.condbr(try b.cmp(.gt, new, limit), over, &.{}, ok, &.{});
    b.cur = over;
    b.exit(PANIC_MEM);
    b.cur = ok;
    try b.store(bp, W_BUMP, new);
    b.ret(try b.itop(old));
}

fn buildCopy(m: *ir.Module, id: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const loop = try b.newBlock();
    const i = try b.param(loop, .i64);
    const body = try b.newBlock();
    const done = try b.newBlock();
    try b.br(loop, &.{try b.iconst(0)});
    b.cur = loop;
    try b.condbr(try b.cmp(.lt, i, ps[2]), body, &.{}, done, &.{});
    b.cur = body;
    try b.store(try b.gepWord(ps[0], i), 0, try b.load(try b.gepWord(ps[1], i), 0));
    try b.br(loop, &.{try b.bin(.add, i, try b.iconst(1))});
    b.cur = done;
    b.ret(null);
}

/// region_relocate(hdr, cellw, floor): ヘッダ (ptr, len, depth) の depth が floor より深ければ、
/// len * cellw 語を深度 floor の先端へ写し、ptr と depth を付け替える（codegen emitRelocateHeader と同じ）
fn buildRelocate(m: *ir.Module, id: ir.FuncId, copy: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const hdr = ps[0];
    const floor = ps[2];
    const move = try b.newBlock();
    const done = try b.newBlock();
    try b.condbr(try b.cmp(.gt, try b.load(hdr, 2), floor), move, &.{}, done, &.{});
    b.cur = move;
    const n = try b.bin(.mul, try b.load(hdr, 1), ps[1]);
    const dst = (try b.call(m.rt.region_alloc, &.{ floor, n })).?;
    _ = try b.call(copy, &.{ dst, try b.itop(try b.load(hdr, 0)), n });
    try b.store(hdr, 0, try b.ptoi(dst));
    try b.store(hdr, 2, floor);
    try b.br(done, &.{});
    b.cur = done;
    b.ret(null);
}

fn buildStrEq(m: *ir.Module, id: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const n = try b.load(ps[0], 1);
    const pa = try b.itop(try b.load(ps[0], 0));
    const pb = try b.itop(try b.load(ps[1], 0));
    const ne = try b.newBlock();
    const loop = try b.newBlock();
    const i = try b.param(loop, .i64);
    try b.condbr(try b.cmp(.ne, n, try b.load(ps[1], 1)), ne, &.{}, loop, &.{try b.iconst(0)});
    b.cur = ne;
    b.ret(try b.iconst(0));
    b.cur = loop;
    const body = try b.newBlock();
    const eq = try b.newBlock();
    try b.condbr(try b.cmp(.lt, i, n), body, &.{}, eq, &.{});
    b.cur = body;
    const next = try b.newBlock();
    try b.condbr(try b.cmp(.ne, try b.load(try b.gepWord(pa, i), 0), try b.load(try b.gepWord(pb, i), 0)), ne, &.{}, next, &.{});
    b.cur = next;
    try b.br(loop, &.{try b.bin(.add, i, try b.iconst(1))});
    b.cur = eq;
    b.ret(try b.iconst(1));
}

/// 挿入列を先頭から走査する（codegen emitMapFind と同順 — 墓石のセルも一致する。値の有無はタグで見る）
fn buildMapFind(m: *ir.Module, id: ir.FuncId, str_eq: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const hdr = ps[0];
    const key = ps[1];
    const cellw = ps[2];
    const base = try b.load(hdr, 0);
    const step = try b.bin(.mul, cellw, try b.iconst(8));
    const end = try b.bin(.add, base, try b.bin(.mul, try b.load(hdr, 1), step));
    const loop = try b.newBlock();
    const cur = try b.param(loop, .i64);
    try b.br(loop, &.{base});
    b.cur = loop;
    const body = try b.newBlock();
    const absent = try b.newBlock();
    try b.condbr(try b.cmp(.eq, cur, end), absent, &.{}, body, &.{});
    b.cur = absent;
    b.ret(try b.iconst(0));
    b.cur = body;
    const cp = try b.itop(cur);
    const str_b = try b.newBlock();
    const int_b = try b.newBlock();
    const test_b = try b.newBlock();
    const hit = try b.param(test_b, .i64);
    try b.condbr(ps[3], str_b, &.{}, int_b, &.{});
    b.cur = str_b;
    try b.br(test_b, &.{(try b.call(str_eq, &.{ cp, key })).?});
    b.cur = int_b;
    try b.br(test_b, &.{try b.cmp(.eq, try b.load(cp, 0), try b.load(key, 0))});
    b.cur = test_b;
    const found = try b.newBlock();
    try b.condbr(hit, found, &.{}, loop, &.{try b.bin(.add, cur, step)});
    b.cur = found;
    b.ret(cur);
}

fn buildPrintStr(m: *ir.Module, id: ir.FuncId, print_char: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const hdr = m.funcs.items[id].params[0];
    const p = try b.itop(try b.load(hdr, 0));
    const n = try b.load(hdr, 1);
    const loop = try b.newBlock();
    const i = try b.param(loop, .i64);
    const body = try b.newBlock();
    const done = try b.newBlock();
    try b.br(loop, &.{try b.iconst(0)});
    b.cur = loop;
    try b.condbr(try b.cmp(.lt, i, n), body, &.{}, done, &.{});
    b.cur = body;
    _ = try b.call(print_char, &.{try b.load(try b.gepWord(p, i), 0)});
    try b.br(loop, &.{try b.bin(.add, i, try b.iconst(1))});
    b.cur = done;
    b.ret(null);
}
