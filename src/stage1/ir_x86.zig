//! IR → x86_64 機械語 → 静的 ELF（正規バックエンド）。
//! 入力は ir_rtlower を通した IR（region op を含まない）。ランタイムは IR の関数としてほかと同じに下ろす。
//!
//! 呼び出し規約（自前 — ABI は揃えない裁定。direct の規約も LLVM の ccc も継がない）:
//! - 引数は全部スタック。呼び手が後ろから push し、callee は [rbp + 16 + 8k] で読む。call の後に呼び手が add rsp, 8n
//! - 戻り値は rax。sret は IR の第 0 引数の ptr にすぎず特別扱いしない
//! - 割り当て可能な 10 本（rbx, rsi, rdi, r8, r9, r10, r12〜r15）はすべて callee-saved。一時は rax / rcx / rdx / r11（割り当てない）
//! - 16 バイト整列は要らない（SSE も libc も使わない）。_start の and rsp, -16 は LLVM 経路と揃えるだけ
//!
//! フレーム: push rbp; mov rbp, rsp; sub rsp, F。[rbp - …] に IR スロット（入口で rep stosq のゼロ初期化 — LLVM 経路の alloca と同じ規約。
//! mem2reg の「定義前の読みは 0」がこれに依存する）と、レジスタに乗らない値の置き場を取る。
//! 値の置き場は Loc（reg | frame）で抽象にしてあり、割り当て器（ir_x86_ra — linear scan）が決める — 命令選択は置き場を問わない。
//! 命令選択はオペランドを全部読んでから結果を書く（割り当て器が同じ位置で終わる区間のレジスタを始まる区間へ渡す前提）。
//! 使った callee-saved は入口でフレームへ退避し、ret の前に戻す。辺の実引数と syscall の引数は並行コピー（循環は r11 で割る）。
//! 到達しないブロックは吐かない。ブロックは ir_live の順（後続を後ろから辿る逆後順）に並べる。
//!
//! 番地: 非 PIE の 0x400000 帯なので globaladdr / funcaddr は imm32 の絶対番地、call / jmp は rel32。すべて配置の後で fixup を埋める。
//! 関数は m.funcs の順に並べる（決定的 — hermetic）。
const std = @import("std");
const ir = @import("ir.zig");
const rt = @import("ir_rt.zig");
const Enc = @import("arch/x86_64.zig");
const Elf = @import("format/elf.zig");
const ra = @import("ir_x86_ra.zig");

const Reg = Enc.Register;
pub const Loc = ra.Loc;
pub const Kind = ra.Kind;

pub const Error = std.mem.Allocator.Error || error{EntryMissing};

const Fixup = struct {
    at: u32,
    kind: enum { call_rel, func_abs, global_abs },
    id: u32,
};

pub fn emit(gpa: std.mem.Allocator, m: *const ir.Module) Error![]u8 {
    return emitWith(gpa, m, .linear);
}

/// kind: 割り当て器（naive はテストが割り当て器のバグを切り分けるのに使う）
pub fn emitWith(gpa: std.mem.Allocator, m: *const ir.Module, kind: ra.Kind) Error![]u8 {
    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();
    const a = arena.allocator();

    // global の配置: init ありは rodata、無しは .bss（各 8 × words バイト）
    const goff = try a.alloc(u64, m.globals.items.len);
    var rodata: std.ArrayListUnmanaged(u8) = .empty;
    var bss: u64 = 0;
    for (m.globals.items, goff) |g, *o| {
        if (g.init) |ws| {
            o.* = rodata.items.len;
            for (0..g.words) |i| {
                var b: [8]u8 = undefined;
                std.mem.writeInt(i64, &b, if (i < ws.len) ws[i] else 0, .little);
                try rodata.appendSlice(a, &b);
            }
        } else {
            o.* = bss;
            bss += 8 * @as(u64, g.words);
        }
    }

    var e = Enc.init(a);
    var fixups: std.ArrayListUnmanaged(Fixup) = .empty;
    const fstart = try a.alloc(u32, m.funcs.items.len);

    // _start: mov rax, rsp; and rsp, -16; sub rsp, 8; push rax; call sober_entry; ud2
    // 初期 rsp（argc の位置）を sober_entry の引数 0 として積む（引数を持たない sober_entry は読まない — 整列は従来と同じ）
    const entry = for (m.funcs.items, 0..) |f, i| {
        if (std.mem.eql(u8, f.name, "sober_entry")) break i;
    } else return error.EntryMissing;
    try e.movRegReg(.rax, .rsp);
    try e.andRegImm(.rsp, -16);
    try e.subRegImm(.rsp, 8);
    try e.pushReg(.rax);
    try fixups.append(a, .{ .at = try e.callRel32(), .kind = .call_rel, .id = @intCast(entry) });
    try e.ud2();

    for (m.funcs.items, 0..) |f, i| {
        fstart[i] = e.here();
        var fe: FuncEmitter = .{ .a = a, .m = m, .f = f, .e = &e, .fixups = &fixups, .kind = kind };
        try fe.run();
    }

    const lay = Elf.layoutRw(e.getCode().len, rodata.items.len);
    for (fixups.items) |fx| switch (fx.kind) {
        .call_rel => e.patchRel32(fx.at, fstart[fx.id]),
        .func_abs => e.patchImm32(fx.at, @intCast(lay.code + fstart[fx.id])),
        .global_abs => {
            const g = m.globals.items[fx.id];
            const base = if (g.init != null) lay.rodata else lay.bss;
            e.patchImm32(fx.at, @intCast(base + goff[fx.id]));
        },
    };
    return Elf.writeExecutableRw(gpa, e.getCode(), rodata.items, @max(bss, 8));
}

const FuncEmitter = struct {
    a: std.mem.Allocator,
    m: *const ir.Module,
    f: *const ir.Func,
    e: *Enc,
    fixups: *std.ArrayListUnmanaged(Fixup),
    kind: ra.Kind,
    locs: []const Loc = &.{},
    alloc: ra.Alloc = undefined,
    /// 今の命令の位置（ir_live の番号 — syscall の周りで生きている値を引く）
    pos: u32 = 0,
    /// IR スロット s の先頭の rbp からの変位
    slot_disp: []i32 = &.{},
    /// 定数の値（div / rem のガード省略）
    consts: std.AutoHashMapUnmanaged(ir.Value, i64) = .empty,
    block_at: []u32 = &.{},
    /// ブロック内の jmp / jcc の rel32（関数の末尾で埋める）
    jumps: std.ArrayListUnmanaged(struct { at: u32, to: ir.BlockId }) = .empty,
    /// div / rem のゼロ除算（exit 101）への jcc
    div0: std.ArrayListUnmanaged(u32) = .empty,

    fn run(self: *FuncEmitter) Error!void {
        const f = self.f;
        for (f.blocks.items) |blk| for (blk.insts.items) |inst| switch (inst.op) {
            .iconst => |n| try self.consts.put(self.a, inst.res.?, n),
            else => {},
        };
        // スロット → フレームの先頭側、値の置き場はその下（割り当て器が frame の変位を決める）
        self.slot_disp = try self.a.alloc(i32, f.slots.items.len);
        var slot_words: i32 = 0;
        for (f.slots.items, self.slot_disp) |w, *d| {
            slot_words += @intCast(@max(w, 1));
            d.* = -8 * slot_words;
        }
        self.alloc = try ra.allocate(self.a, f, -8 * slot_words, self.kind);
        self.locs = self.alloc.locs;
        const frame: i32 = @intCast(std.mem.alignForward(u32, @intCast(-self.alloc.frame_bottom), 16));

        // prologue: フレーム → 使う callee-saved の退避 → スロットのゼロ初期化（rdi / rcx / rax を壊す）→ レジスタに載る引数
        try self.e.pushReg(.rbp);
        try self.e.movRegReg(.rbp, .rsp);
        if (frame > 0) try self.e.subRegImm(.rsp, frame);
        for (self.alloc.saves) |sv| try self.e.movMemReg(.rbp, sv.disp, sv.reg);
        if (slot_words > 0) {
            try self.e.leaRegMem(.rdi, .rbp, -8 * slot_words);
            try self.e.movRegImm32(.rcx, slot_words);
            try self.e.xorRegReg(.rax, .rax);
            try self.e.repStosq();
        }
        for (f.params, 0..) |p, k| switch (self.locs[p]) {
            .reg => |r| try self.e.movRegMem(r, .rbp, ra.paramDisp(k)),
            .frame => {},
        };

        // 到達するブロックだけを ir_live の順（番号の順）に吐く
        const live = &self.alloc.live;
        self.block_at = try self.a.alloc(u32, f.blocks.items.len);
        for (live.order) |bi| {
            const blk = f.blocks.items[bi];
            self.block_at[bi] = self.e.here();
            for (blk.insts.items, 0..) |inst, k| {
                self.pos = live.instPos(bi, k);
                try self.emitInst(inst);
            }
            try self.emitTerm(blk.term);
        }
        if (self.div0.items.len > 0) {
            const at = self.e.here();
            for (self.div0.items) |j| self.e.patchRel32(j, at);
            try self.exitSeq(rt.PANIC);
        }
        for (self.jumps.items) |j| self.e.patchRel32(j.at, self.block_at[j.to]);
    }

    // ── 値の出し入れ（置き場を問わない）──────────────────────────

    /// v をレジスタに載せる（置き場がレジスタならそれ、フレームなら scratch に読む）
    fn get(self: *FuncEmitter, v: ir.Value, scratch: Reg) !Reg {
        switch (self.locs[v]) {
            .reg => |r| return r,
            .frame => |d| {
                try self.e.movRegMem(scratch, .rbp, d);
                return scratch;
            },
        }
    }

    /// v を指定のレジスタへ（呼び出し・syscall の引数、除算）
    fn getInto(self: *FuncEmitter, v: ir.Value, dst: Reg) !void {
        switch (self.locs[v]) {
            .reg => |r| if (r != dst) try self.e.movRegReg(dst, r),
            .frame => |d| try self.e.movRegMem(dst, .rbp, d),
        }
    }

    /// src にある結果を v の置き場へ
    fn put(self: *FuncEmitter, v: ir.Value, src: Reg) !void {
        switch (self.locs[v]) {
            .reg => |r| if (r != src) try self.e.movRegReg(r, src),
            .frame => |d| try self.e.movMemReg(.rbp, d, src),
        }
    }

    fn emitInst(self: *FuncEmitter, in: ir.Inst) Error!void {
        const e = self.e;
        switch (in.op) {
            .iconst => |n| {
                const r = in.res.?;
                if (std.math.cast(i32, n)) |k| {
                    switch (self.locs[r]) {
                        .reg => |x| try e.movRegImm32(x, k),
                        .frame => |d| try e.movMemImm32(.rbp, d, k),
                    }
                } else {
                    try e.movRegImm64(.rax, @bitCast(n));
                    try self.put(r, .rax);
                }
            },
            .bin => |b| switch (b.op) {
                .div, .rem => try self.divRem(in.res.?, b.op, b.a, b.b),
                .shl, .sar => {
                    try self.getInto(b.a, .rax);
                    try self.getInto(b.b, .rcx);
                    if (b.op == .shl) try e.shlRegCl(.rax) else try e.sarRegCl(.rax);
                    try self.put(in.res.?, .rax);
                },
                else => {
                    try self.getInto(b.a, .rax);
                    const y = try self.get(b.b, .rcx);
                    switch (b.op) {
                        .add => try e.addRegReg(.rax, y),
                        .sub => try e.subRegReg(.rax, y),
                        .mul => try e.imulRegReg(.rax, y),
                        .and_ => try e.andRegReg(.rax, y),
                        .or_ => try e.orRegReg(.rax, y),
                        .xor => try e.xorRegReg(.rax, y),
                        .div, .rem, .shl, .sar => unreachable,
                    }
                    try self.put(in.res.?, .rax);
                },
            },
            .cmp => |c| {
                const x = try self.get(c.a, .rax);
                const y = try self.get(c.b, .rcx);
                try e.cmpRegReg(x, y);
                try e.setccAl(cond(c.op));
                try e.movzxRaxAl();
                try self.put(in.res.?, .rax);
            },
            .load => |l| {
                const p = try self.get(l.p, .rax);
                try e.movRegMem(.rax, p, 8 * l.off);
                try self.put(in.res.?, .rax);
            },
            .store => |s| {
                const p = try self.get(s.p, .rax);
                const v = try self.get(s.v, .rcx);
                try e.movMemReg(p, 8 * s.off, v);
            },
            .load8 => |l| {
                const p = try self.get(l.p, .rax);
                try e.movzxRegMem8(.rax, p, l.off);
                try self.put(in.res.?, .rax);
            },
            .store8 => |s| {
                const p = try self.get(s.p, .rax);
                const v = try self.get(s.v, .rcx);
                try e.movMem8Reg(p, s.off, v);
            },
            .gep => |g| {
                const p = try self.get(g.p, .rax);
                const i = try self.get(g.idx, .rcx);
                try e.leaRegSib(.rax, p, i, if (g.scale == .word) .x8 else .x1);
                try self.put(in.res.?, .rax);
            },
            .ptoi, .itop => |v| {
                const x = try self.get(v, .rax);
                try self.put(in.res.?, x);
            },
            .slotaddr => |s| {
                try e.leaRegMem(.rax, .rbp, self.slot_disp[s]);
                try self.put(in.res.?, .rax);
            },
            .globaladdr => |g| try self.absImm(in.res.?, .global_abs, g),
            .funcaddr => |fid| try self.absImm(in.res.?, .func_abs, fid),
            .call => |c| {
                try self.pushArgs(c.args);
                try self.fixups.append(self.a, .{ .at = try e.callRel32(), .kind = .call_rel, .id = c.f });
                try self.afterCall(in.res, c.args.len);
            },
            .call_indirect => |c| {
                try self.pushArgs(c.args);
                try self.getInto(c.callee, .r11);
                try e.callReg(.r11);
                try self.afterCall(in.res, c.args.len);
            },
            .syscall => |args| try self.syscall(in.res.?, args),
            .region_enter, .region_depth, .region_setdepth, .region_alloc, .region_bump, .region_relocate => unreachable,
        }
    }

    /// 番地の imm32（配置の後で埋める）
    fn absImm(self: *FuncEmitter, r: ir.Value, kind: @TypeOf(@as(Fixup, undefined).kind), id: u32) !void {
        switch (self.locs[r]) {
            .reg => |x| try self.e.movRegImm32(x, 0),
            .frame => |d| try self.e.movMemImm32(.rbp, d, 0),
        }
        try self.fixups.append(self.a, .{ .at = self.e.here() - 4, .kind = kind, .id = id });
    }

    fn pushArgs(self: *FuncEmitter, args: []const ir.Value) !void {
        var k = args.len;
        while (k > 0) {
            k -= 1;
            const x = try self.get(args[k], .rax);
            try self.e.pushReg(x);
        }
    }

    fn afterCall(self: *FuncEmitter, res: ?ir.Value, nargs: usize) !void {
        if (nargs > 0) try self.e.addRegImm(.rsp, @intCast(8 * nargs));
        if (res) |r| try self.put(r, .rax);
    }

    /// div / rem（IR の全域の意味: b == 0 → exit 101、b == -1 → div は 0 - a・rem は 0、それ以外は idiv）
    fn divRem(self: *FuncEmitter, r: ir.Value, op: ir.BinOp, a: ir.Value, b: ir.Value) !void {
        const e = self.e;
        try self.getInto(a, .rax);
        try self.getInto(b, .rcx);
        const kb = self.consts.get(b);
        var done: ?u32 = null;
        if (kb == null or kb.? == 0) {
            try e.cmpRegImm(.rcx, 0);
            try self.div0.append(self.a, try e.jccRel32(.e));
        }
        if (kb == null or kb.? == -1) {
            try e.cmpRegImm(.rcx, -1);
            const normal = try e.jccRel32(.ne);
            if (op == .div) try e.negReg(.rax) else try e.xorRegReg(.rax, .rax);
            done = try e.jmpRel32();
            e.patchRel32(normal, e.here());
        }
        try e.cqo();
        try e.idivReg(.rcx);
        if (op == .rem) try e.movRegReg(.rax, .rdx);
        if (done) |d| e.patchRel32(d, e.here());
        try self.put(r, .rax);
    }

    fn emitTerm(self: *FuncEmitter, t: ir.Term) Error!void {
        const e = self.e;
        switch (t) {
            .none => unreachable,
            .br => |edge| try self.jumpEdge(edge),
            .condbr => |c| {
                const x = try self.get(c.c, .rax);
                try e.cmpRegImm(x, 0);
                const to_else = try e.jccRel32(.e);
                try self.jumpEdge(c.t);
                e.patchRel32(to_else, e.here());
                try self.jumpEdge(c.e);
            },
            .ret => |v| {
                if (v) |x| try self.getInto(x, .rax);
                for (self.alloc.saves) |sv| try e.movRegMem(sv.reg, .rbp, sv.disp);
                try e.leave();
                try e.ret();
            },
            .exit => |code| try self.exitSeq(code),
        }
    }

    /// 辺の実引数を仮引数へ並行コピーして飛ぶ
    fn jumpEdge(self: *FuncEmitter, edge: ir.Edge) !void {
        const params = self.f.blocks.items[edge.to].params.items;
        var moves: std.ArrayListUnmanaged(Move) = .empty;
        for (params, edge.args) |p, v| try moves.append(self.a, .{ .dst = self.locs[p], .src = self.locs[v] });
        try self.parallelMove(&moves);
        try self.jumps.append(self.a, .{ .at = try self.e.jmpRel32(), .to = edge.to });
    }

    /// syscall: 引数レジスタ（rdi / rsi / r8〜r10）に載っていて syscall の後も生きている値を積んで退避し、
    /// 引数を並行コピーで番号 + 6 本へ入れる（rcx / r11 は syscall が壊すが割り当てていない）
    fn syscall(self: *FuncEmitter, res: ir.Value, args: []const ir.Value) !void {
        const regs = [_]Reg{ .rax, .rdi, .rsi, .rdx, .r10, .r8, .r9 };
        var saved: std.ArrayListUnmanaged(Reg) = .empty;
        for (self.locs, self.alloc.live.iv) |l, iv| {
            if (l != .reg or iv == null) continue;
            const x = iv.?;
            if (!(x.start < self.pos and x.end > self.pos)) continue;
            if (std.mem.indexOfScalar(Reg, regs[1..], l.reg) == null) continue;
            if (std.mem.indexOfScalar(Reg, saved.items, l.reg) != null) continue;
            try saved.append(self.a, l.reg);
        }
        for (saved.items) |r| try self.e.pushReg(r);
        var moves: std.ArrayListUnmanaged(Move) = .empty;
        for (args, 0..) |v, k| try moves.append(self.a, .{ .dst = .{ .reg = regs[k] }, .src = self.locs[v] });
        try self.parallelMove(&moves);
        try self.e.syscall_();
        var k = saved.items.len;
        while (k > 0) {
            k -= 1;
            try self.e.popReg(saved.items[k]);
        }
        try self.put(res, .rax);
    }

    const Move = struct { dst: Loc, src: Loc };

    /// 並行コピー: 書き先が他の移動の読み元でない移動から順に出す。全部が循環なら 1 つの書き先を r11 に逃がして
    /// その読み元を付け替える（循環は r11 を読む鎖になり、次の割り込みの前に流れきる）。フレーム同士は rax を中継
    fn parallelMove(self: *FuncEmitter, moves: *std.ArrayListUnmanaged(Move)) !void {
        var i: usize = 0;
        while (i < moves.items.len) {
            if (moves.items[i].dst.eql(moves.items[i].src)) _ = moves.orderedRemove(i) else i += 1;
        }
        while (moves.items.len > 0) {
            const ready = for (moves.items, 0..) |m, k| {
                const blocked = for (moves.items, 0..) |o, j| {
                    if (j != k and o.src.eql(m.dst)) break true;
                } else false;
                if (!blocked) break k;
            } else null;
            if (ready) |k| {
                try self.move(moves.items[k]);
                _ = moves.orderedRemove(k);
                continue;
            }
            const d = moves.items[0].dst;
            try self.move(.{ .dst = .{ .reg = .r11 }, .src = d });
            for (moves.items) |*o| if (o.src.eql(d)) {
                o.src = .{ .reg = .r11 };
            };
        }
    }

    fn move(self: *FuncEmitter, m: Move) !void {
        switch (m.dst) {
            .reg => |r| switch (m.src) {
                .reg => |s| try self.e.movRegReg(r, s),
                .frame => |d| try self.e.movRegMem(r, .rbp, d),
            },
            .frame => |dd| switch (m.src) {
                .reg => |s| try self.e.movMemReg(.rbp, dd, s),
                .frame => |d| {
                    try self.e.movRegMem(.rax, .rbp, d);
                    try self.e.movMemReg(.rbp, dd, .rax);
                },
            },
        }
    }

    fn exitSeq(self: *FuncEmitter, code: u8) !void {
        try self.e.movRegImm32(.rax, 60);
        try self.e.movRegImm32(.rdi, code);
        try self.e.syscall_();
    }
};

fn cond(op: ir.CmpOp) Enc.Cond {
    return switch (op) {
        .eq => .e,
        .ne => .ne,
        .lt => .l,
        .le => .le,
        .gt => .g,
        .ge => .ge,
        .ult => .b,
        .uge => .ae,
    };
}
