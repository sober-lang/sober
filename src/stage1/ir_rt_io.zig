//! IR で書いた io ランタイム（codegen ioRuntime の後継 — 同じアルゴリズム）。std/ の中だけで呼べる組み込み
//! sysReadFile / sysWriteFile / sysArgs / sysReadDir / sysWriteFd の下ろし先。errno はメタ領域の W_ERRNO に置く（sysErrno が読む）。
//! path は NUL 終端のバイト列に詰めて io バッファ（@rt.iobuf、IO_BUF バイト）へ — 4095 バイトまで、超えたら ENAMETOOLONG、
//! NUL か 255 超のセルは EINVAL。読み書きは IO_BUF バイトずつのチャンクで、EINTR は再試行する
const std = @import("std");
const ir = @import("ir.zig");
const rt = @import("ir_rt.zig");

pub const IO_BUF: i64 = 4096;

const O_RDONLY_CLOEXEC: i64 = 0x80000;
/// O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC
const O_WRITE: i64 = 0x80241;
/// O_RDONLY | O_DIRECTORY | O_CLOEXEC
const O_DIR: i64 = 0x90000;
const AT_FDCWD: i64 = -100;
const EINTR: i64 = -4;
const ENAMETOOLONG: i64 = 36;
const EINVAL: i64 = 22;

pub const Io = struct { read_file: ir.FuncId, write_file: ir.FuncId, read_args: ir.FuncId, read_dir: ir.FuncId, write_fd: ir.FuncId };

pub fn install(m: *ir.Module, flush: ir.FuncId) !Io {
    const buf = try m.addGlobal("rt.iobuf", @intCast(@divExact(IO_BUF, 8)));
    const cstr = try m.addFunc("rt.cstr", &.{ .ptr, .ptr }, .i64);
    const write_all = try m.addFunc("rt.write_all", &.{ .i64, .ptr }, .i64);
    const read_file = try m.addFunc("rt.read_file", &.{ .ptr, .ptr }, null);
    const write_file = try m.addFunc("rt.write_file", &.{ .ptr, .ptr }, .i64);
    const read_args = try m.addFunc("rt.read_args", &.{.ptr}, null);
    const read_dir = try m.addFunc("rt.read_dir", &.{ .ptr, .ptr }, null);
    const write_fd = try m.addFunc("rt.write_fd", &.{ .i64, .ptr }, .i64);
    try buildCstr(m, cstr);
    try buildWriteAll(m, write_all, buf);
    try buildReadFile(m, read_file, cstr, buf);
    try buildWriteFile(m, write_file, cstr, write_all, buf);
    try buildReadArgs(m, read_args);
    try buildReadDir(m, read_dir, cstr, buf);
    try buildWriteFd(m, write_fd, flush, write_all);
    return .{ .read_file = read_file, .write_file = write_file, .read_args = read_args, .read_dir = read_dir, .write_fd = write_fd };
}

/// out（3 語ヘッダ）を現在深度の region 先端・長さ 0 で初期化し、深度を返す（read_file / read_args / read_dir の共通の冒頭）
fn initOut(b: *ir.Builder, out: ir.Value) !ir.Value {
    const meta = try b.globaladdr(b.m.rt.meta);
    const depth = try b.load(meta, rt.W_DEPTH);
    try b.store(out, 0, try b.ptoi(try b.regionBump(depth)));
    try b.store(out, 1, try b.iconst(0));
    try b.store(out, 2, depth);
    return depth;
}

/// C 文字列 s（NUL 終端）の長さ
fn strLen(b: *ir.Builder, s: ir.Value) !ir.Value {
    const loop = try b.newBlock();
    const j = try b.param(loop, .i64);
    const body = try b.newBlock();
    const done = try b.newBlock();
    const res = try b.param(done, .i64);
    try b.br(loop, &.{try b.iconst(0)});
    b.cur = loop;
    try b.condbr(try b.cmp(.eq, try b.load8(try b.gepByte(s, j), 0), try b.iconst(0)), done, &.{j}, body, &.{});
    b.cur = body;
    try b.br(loop, &.{try b.bin(.add, j, try b.iconst(1))});
    b.cur = done;
    return res;
}

/// バイト列 src[0..n] を 1 バイト 1 語で dst[0..n] へ
fn widen(b: *ir.Builder, dst: ir.Value, src: ir.Value, n: ir.Value) !void {
    const loop = try b.newBlock();
    const i = try b.param(loop, .i64);
    const body = try b.newBlock();
    const done = try b.newBlock();
    try b.br(loop, &.{try b.iconst(0)});
    b.cur = loop;
    try b.condbr(try b.cmp(.lt, i, n), body, &.{}, done, &.{});
    b.cur = body;
    try b.store(try b.gepWord(dst, i), 0, try b.load8(try b.gepByte(src, i), 0));
    try b.br(loop, &.{try b.bin(.add, i, try b.iconst(1))});
    b.cur = done;
}

/// read_args(out): argv を「各引数のバイト（1 バイト 1 語）+ 0」の連結で out に置く（std/os が 0 で割る）。
/// argv の原本は入口が W_ARGV に置いた初期 rsp（[argc, argv…]）。引数ごとに region.alloc で先端を進める（隙間なく並ぶ）
fn buildReadArgs(m: *ir.Module, id: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const out = m.funcs.items[id].params[0];
    const depth = try initOut(&b, out);
    const sp = try b.itop(try b.load(try b.globaladdr(m.rt.meta), rt.W_ARGV));
    const argc = try b.load(sp, 0);
    const loop = try b.newBlock();
    const k = try b.param(loop, .i64);
    const body = try b.newBlock();
    const done = try b.newBlock();
    try b.br(loop, &.{try b.iconst(0)});
    b.cur = loop;
    try b.condbr(try b.cmp(.lt, k, argc), body, &.{}, done, &.{});
    b.cur = body;
    const s = try b.itop(try b.load(try b.gepWord(sp, try b.bin(.add, k, try b.iconst(1))), 0));
    const n = try strLen(&b, s);
    const dst = try b.regionAlloc(depth, try b.bin(.add, n, try b.iconst(1)));
    try widen(&b, dst, s, n);
    try b.store(try b.gepWord(dst, n), 0, try b.iconst(0));
    try b.store(out, 1, try b.bin(.add, try b.load(out, 1), try b.bin(.add, n, try b.iconst(1))));
    try b.br(loop, &.{try b.bin(.add, k, try b.iconst(1))});
    b.cur = done;
    b.ret(null);
}

/// read_dir(path, out): ディレクトリの項目を「d_type 1 語 + 名前のバイト（1 バイト 1 語）+ 0」の連結で out に置く（失敗は空 + errno）。
/// getdents64 の並び順のまま・`.` / `..` も含む（除外・ソート・種類の解釈は std/io の Sober）。
/// linux_dirent64: d_ino 8B・d_off 8B・d_reclen 2B（@16、LE）・d_type 1B（@18）・d_name（@19、NUL 終端）
fn buildReadDir(m: *ir.Module, id: ir.FuncId, cstr: ir.FuncId, buf_g: ir.GlobalId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const path = ps[0];
    const out = ps[1];
    const buf = try b.globaladdr(buf_g);
    const depth = try initOut(&b, out);
    const e = (try b.call(cstr, &.{ path, buf })).?;
    const named = try branchIf(&b, try b.cmp(.ne, e, try b.iconst(0)));
    try setErrno(&b, e);
    b.ret(null);
    b.cur = named;
    const fd = try b.syscall(&.{ try b.iconst(257), try b.iconst(AT_FDCWD), try b.ptoi(buf), try b.iconst(O_DIR), try b.iconst(0) });
    const opened = try branchIf(&b, try b.cmp(.lt, fd, try b.iconst(0)));
    try setErrno(&b, try b.bin(.sub, try b.iconst(0), fd));
    b.ret(null);
    b.cur = opened;
    const loop = try b.newBlock();
    const close = try b.newBlock();
    const err = try b.param(close, .i64);
    try b.br(loop, &.{});
    b.cur = loop;
    const n = try b.syscall(&.{ try b.iconst(217), fd, try b.ptoi(buf), try b.iconst(IO_BUF) });
    const not_intr = try branchIf(&b, try b.cmp(.eq, n, try b.iconst(EINTR)));
    try b.br(loop, &.{});
    b.cur = not_intr;
    const not_end = try branchIf(&b, try b.cmp(.eq, n, try b.iconst(0)));
    try b.br(close, &.{try b.iconst(0)});
    b.cur = not_end;
    const got = try branchIf(&b, try b.cmp(.lt, n, try b.iconst(0)));
    try b.br(close, &.{try b.bin(.sub, try b.iconst(0), n)});
    b.cur = got;
    // レコードの走査（pos < n）
    const rl = try b.newBlock();
    const pos = try b.param(rl, .i64);
    const rbody = try b.newBlock();
    try b.br(rl, &.{try b.iconst(0)});
    b.cur = rl;
    try b.condbr(try b.cmp(.lt, pos, n), rbody, &.{}, loop, &.{});
    b.cur = rbody;
    const rec = try b.gepByte(buf, pos);
    const reclen = try b.bin(.or_, try b.load8(rec, 16), try b.bin(.shl, try b.load8(rec, 17), try b.iconst(8)));
    const name = try b.gepByte(rec, try b.iconst(19));
    const len = try strLen(&b, name);
    const dst = try b.regionAlloc(depth, try b.bin(.add, len, try b.iconst(2)));
    try b.store(dst, 0, try b.load8(rec, 18));
    try widen(&b, try b.gepWord(dst, try b.iconst(1)), name, len);
    try b.store(try b.gepWord(dst, try b.bin(.add, len, try b.iconst(1))), 0, try b.iconst(0));
    try b.store(out, 1, try b.bin(.add, try b.load(out, 1), try b.bin(.add, len, try b.iconst(2))));
    try b.br(rl, &.{try b.bin(.add, pos, reclen)});
    b.cur = close;
    _ = try b.syscall(&.{ try b.iconst(3), fd });
    try setErrno(&b, err);
    b.ret(null);
}

/// write_fd(fd, data) → errno: 開いている fd（std/io の WriteStdout = 1 / WriteStderr = 2）へ直接書く — open しないので切り詰めない。
/// 先に println の行バッファを flush する（出る順 = 呼んだ順）
fn buildWriteFd(m: *ir.Module, id: ir.FuncId, flush: ir.FuncId, write_all: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    _ = try b.call(flush, &.{});
    const e = (try b.call(write_all, &.{ ps[0], ps[1] })).?;
    try setErrno(&b, e);
    b.ret(e);
}

/// 条件 c が真なら新しいブロックへ分岐して cur にし、偽側のブロックを返す（呼び手が後で cur にする）
fn branchIf(b: *ir.Builder, c: ir.Value) !ir.BlockId {
    const t = try b.newBlock();
    const e = try b.newBlock();
    try b.condbr(c, t, &.{}, e, &.{});
    b.cur = t;
    return e;
}

/// cstr(hdr, buf) → 0 / ENAMETOOLONG / EINVAL: string ヘッダのセル列を NUL 終端のバイト列に詰める
fn buildCstr(m: *ir.Module, id: ir.FuncId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const hdr = ps[0];
    const buf = ps[1];
    const n = try b.load(hdr, 1);
    const fits = try branchIf(&b, try b.cmp(.uge, n, try b.iconst(IO_BUF)));
    b.ret(try b.iconst(ENAMETOOLONG));
    b.cur = fits;
    const p = try b.itop(try b.load(hdr, 0));
    const loop = try b.newBlock();
    const i = try b.param(loop, .i64);
    try b.br(loop, &.{try b.iconst(0)});
    b.cur = loop;
    const more = try branchIf(&b, try b.cmp(.ge, i, n));
    try b.store8(try b.gepByte(buf, i), 0, try b.iconst(0));
    b.ret(try b.iconst(0));
    b.cur = more;
    const c = try b.load(try b.gepWord(p, i), 0);
    const not_nul = try branchIf(&b, try b.cmp(.eq, c, try b.iconst(0)));
    b.ret(try b.iconst(EINVAL));
    b.cur = not_nul;
    const byte = try branchIf(&b, try b.cmp(.uge, c, try b.iconst(256)));
    b.ret(try b.iconst(EINVAL));
    b.cur = byte;
    try b.store8(try b.gepByte(buf, i), 0, c);
    try b.br(loop, &.{try b.bin(.add, i, try b.iconst(1))});
}

fn setErrno(b: *ir.Builder, e: ir.Value) !void {
    try b.store(try b.globaladdr(b.m.rt.meta), rt.W_ERRNO, e);
}

/// read_file(path, out): out（3 語ヘッダ）に現在深度の region 先端から 1 バイト 1 語で積んだ中身を置く（失敗は空）。
/// チャンクごとに region.alloc で先端を進める（上限検査つき — 連続して取るので先端から隙間なく並ぶ）。close のエラーは捨てる（Go の ReadFile と同じ）
fn buildReadFile(m: *ir.Module, id: ir.FuncId, cstr: ir.FuncId, buf_g: ir.GlobalId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const path = ps[0];
    const out = ps[1];
    const meta = try b.globaladdr(m.rt.meta);
    const buf = try b.globaladdr(buf_g);
    const depth = try b.load(meta, rt.W_DEPTH);
    try b.store(out, 0, try b.ptoi(try b.regionBump(depth)));
    try b.store(out, 1, try b.iconst(0));
    try b.store(out, 2, depth);
    const e = (try b.call(cstr, &.{ path, buf })).?;
    const named = try branchIf(&b, try b.cmp(.ne, e, try b.iconst(0)));
    try setErrno(&b, e);
    b.ret(null);
    b.cur = named;
    const fd = try b.syscall(&.{ try b.iconst(257), try b.iconst(AT_FDCWD), try b.ptoi(buf), try b.iconst(O_RDONLY_CLOEXEC), try b.iconst(0) });
    const opened = try branchIf(&b, try b.cmp(.lt, fd, try b.iconst(0)));
    try setErrno(&b, try b.bin(.sub, try b.iconst(0), fd));
    b.ret(null);
    b.cur = opened;
    const loop = try b.newBlock();
    const close = try b.newBlock();
    const err = try b.param(close, .i64);
    try b.br(loop, &.{});
    b.cur = loop;
    const n = try b.syscall(&.{ try b.iconst(0), fd, try b.ptoi(buf), try b.iconst(IO_BUF) });
    const not_intr = try branchIf(&b, try b.cmp(.eq, n, try b.iconst(EINTR)));
    try b.br(loop, &.{});
    b.cur = not_intr;
    const not_eof = try branchIf(&b, try b.cmp(.eq, n, try b.iconst(0)));
    try b.br(close, &.{try b.iconst(0)});
    b.cur = not_eof;
    const got = try branchIf(&b, try b.cmp(.lt, n, try b.iconst(0)));
    try b.br(close, &.{try b.bin(.sub, try b.iconst(0), n)});
    b.cur = got;
    const dst = try b.regionAlloc(depth, n);
    const wl = try b.newBlock();
    const i = try b.param(wl, .i64);
    const wdone = try b.newBlock();
    try b.br(wl, &.{try b.iconst(0)});
    b.cur = wl;
    const wbody = try b.newBlock();
    try b.condbr(try b.cmp(.lt, i, n), wbody, &.{}, wdone, &.{});
    b.cur = wbody;
    try b.store(try b.gepWord(dst, i), 0, try b.load8(try b.gepByte(buf, i), 0));
    try b.br(wl, &.{try b.bin(.add, i, try b.iconst(1))});
    b.cur = wdone;
    try b.store(out, 1, try b.bin(.add, try b.load(out, 1), n));
    try b.br(loop, &.{});
    b.cur = close;
    _ = try b.syscall(&.{ try b.iconst(3), fd });
    try setErrno(&b, err);
    b.ret(null);
}

/// write_all(fd, data) → errno（0 = 成功）: data（[]int — 各要素 0〜255、外れたら panic 101）を IO_BUF バイトずつ詰めて書く。短い書き込みは続きから、EINTR は再試行
fn buildWriteAll(m: *ir.Module, id: ir.FuncId, buf_g: ir.GlobalId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const fd = ps[0];
    const data = ps[1];
    const buf = try b.globaladdr(buf_g);
    const src = try b.itop(try b.load(data, 0));
    const len = try b.load(data, 1);
    // チャンクのループ: n = min(len - pos, IO_BUF)
    const chunk = try b.newBlock();
    const pos = try b.param(chunk, .i64);
    try b.br(chunk, &.{try b.iconst(0)});
    b.cur = chunk;
    const rest = try b.bin(.sub, len, pos);
    const has = try branchIf(&b, try b.cmp(.eq, rest, try b.iconst(0)));
    b.ret(try b.iconst(0));
    b.cur = has;
    const small = try b.newBlock();
    const pick = try b.newBlock();
    const n = try b.param(pick, .i64);
    try b.condbr(try b.cmp(.le, rest, try b.iconst(IO_BUF)), small, &.{}, pick, &.{try b.iconst(IO_BUF)});
    b.cur = small;
    try b.br(pick, &.{rest});
    b.cur = pick;
    const base = try b.gepWord(src, pos);
    const pl = try b.newBlock();
    const i = try b.param(pl, .i64);
    const pdone = try b.newBlock();
    try b.br(pl, &.{try b.iconst(0)});
    b.cur = pl;
    const pbody = try b.newBlock();
    try b.condbr(try b.cmp(.lt, i, n), pbody, &.{}, pdone, &.{});
    b.cur = pbody;
    const c = try b.load(try b.gepWord(base, i), 0);
    // 符号なし: 負も 255 超も（到達 = バグ類の panic — 27 節）
    const in_byte = try branchIf(&b, try b.cmp(.uge, c, try b.iconst(256)));
    b.exit(rt.PANIC);
    b.cur = in_byte;
    try b.store8(try b.gepByte(buf, i), 0, c);
    try b.br(pl, &.{try b.bin(.add, i, try b.iconst(1))});
    // write ループ（短い書き込みは続きから）
    b.cur = pdone;
    const xl = try b.newBlock();
    const done_w = try b.param(xl, .i64);
    try b.br(xl, &.{try b.iconst(0)});
    b.cur = xl;
    const left = try b.bin(.sub, n, done_w);
    const next_chunk = try b.newBlock();
    const xbody = try b.newBlock();
    try b.condbr(try b.cmp(.eq, left, try b.iconst(0)), next_chunk, &.{}, xbody, &.{});
    b.cur = next_chunk;
    try b.br(chunk, &.{try b.bin(.add, pos, n)});
    b.cur = xbody;
    const r = try b.syscall(&.{ try b.iconst(1), fd, try b.ptoi(try b.gepByte(buf, done_w)), left });
    const not_intr = try branchIf(&b, try b.cmp(.eq, r, try b.iconst(EINTR)));
    try b.br(xl, &.{done_w});
    b.cur = not_intr;
    const wrote = try branchIf(&b, try b.cmp(.lt, r, try b.iconst(0)));
    b.ret(try b.bin(.sub, try b.iconst(0), r));
    b.cur = wrote;
    try b.br(xl, &.{try b.bin(.add, done_w, r)});
}

/// write_file(path, data) → errno: 作成 / 切り詰めで開いて write_all。
/// close のエラーは返す（遅延書き込みの失敗がここで出る。先のエラーが優先）
fn buildWriteFile(m: *ir.Module, id: ir.FuncId, cstr: ir.FuncId, write_all: ir.FuncId, buf_g: ir.GlobalId) !void {
    var b = try ir.Builder.begin(m, id);
    const ps = m.funcs.items[id].params;
    const path = ps[0];
    const data = ps[1];
    const buf = try b.globaladdr(buf_g);
    const e = (try b.call(cstr, &.{ path, buf })).?;
    const named = try branchIf(&b, try b.cmp(.ne, e, try b.iconst(0)));
    try setErrno(&b, e);
    b.ret(e);
    b.cur = named;
    const fd = try b.syscall(&.{ try b.iconst(257), try b.iconst(AT_FDCWD), try b.ptoi(buf), try b.iconst(O_WRITE), try b.iconst(0o644) });
    const opened = try branchIf(&b, try b.cmp(.lt, fd, try b.iconst(0)));
    const oe = try b.bin(.sub, try b.iconst(0), fd);
    try setErrno(&b, oe);
    b.ret(oe);
    b.cur = opened;
    const err = (try b.call(write_all, &.{ fd, data })).?;
    // close(fd)
    const cr = try b.syscall(&.{ try b.iconst(3), fd });
    const final = try b.newBlock();
    const fe = try b.param(final, .i64);
    const cl_bad = try b.newBlock();
    try b.condbr(try b.cmp(.lt, cr, try b.iconst(0)), cl_bad, &.{}, final, &.{err});
    b.cur = cl_bad;
    const keep = try b.cmp(.ne, err, try b.iconst(0));
    const take = try b.newBlock();
    try b.condbr(keep, final, &.{err}, take, &.{});
    b.cur = take;
    try b.br(final, &.{try b.bin(.sub, try b.iconst(0), cr)});
    b.cur = final;
    try setErrno(&b, fe);
    b.ret(fe);
}
