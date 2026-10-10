//! IR → LLVM テキスト（.ll）。開発時専用の差分オラクル経路（docs/design-dev.md「バックエンド戦略」）。
//! 下ろすのは `zig cc -target x86_64-linux-none -nostdlib -static x.ll`（scripts / テストだけが呼ぶ — sober は子プロセスを起動しない）。
//!
//! UB 遮断（backend-drafts の規約）:
//! - add / sub / mul に nsw / nuw を付けない（wrap が定義された意味）
//! - div / rem は b == 0 → exit 101、b == -1 → 0 - a / 0（最小値 / -1 を sdiv に渡さない）、その先で初めて sdiv / srem。
//!   b が 0 でも -1 でもない定数ならガードを省く
//! - unreachable は exit の syscall の直後にだけ置く。mustprogress 等の属性は付けない（無限ループを UB にしない）
//! - 全関数に "no-builtins"（-O2 のループ認識が memset / memcpy の libcall を作らない — -nostdlib で未定義になる）
//!
//! ブロック引数は φ に下ろす。φ の前任は IR ブロックの末尾ラベル（div ガード等でブロック内にラベルが増えるため）。
//! condbr の辺は中継ブロックを通す（同じブロックへの 2 辺でも φ の前任が割れる）。
//! 呼び出し規約は LLVM の既定（ccc）— 自前規約は移植しない（ABI を揃えない裁定）。
//! 入力は ir_rtlower を通した IR（region op を含まない — 呼び手が emit の前に rtlower.run する）。
const std = @import("std");
const ir = @import("ir.zig");
const rt = @import("ir_rt.zig");

const Writer = std.Io.Writer;
const Error = Writer.Error || std.mem.Allocator.Error;

pub fn emit(gpa: std.mem.Allocator, m: *const ir.Module) Error![]u8 {
    var out: Writer.Allocating = .init(gpa);
    errdefer out.deinit();
    const w = &out.writer;
    try w.writeAll(
        \\; 生成物（sober build --emit=ll）
        \\target triple = "x86_64-unknown-linux-none"
        \\
        \\module asm ".globl _start"
        \\module asm "_start:"
        \\module asm "  movq %rsp, %rdi"
        \\module asm "  andq $-16, %rsp"
        \\module asm "  call sober_entry"
        \\module asm "  ud2"
        \\
        \\attributes #0 = { nounwind "no-builtins" "frame-pointer"="all" }
        \\
        \\
    );
    for (m.globals.items) |g| {
        if (g.init) |ws| {
            try w.print("@\"{s}\" = internal constant [{d} x i64] ", .{ g.name, g.words });
            if (ws.len == 0) try w.writeAll("zeroinitializer") else {
                try w.writeAll("[");
                for (ws, 0..) |x, i| try w.print("{s}i64 {d}", .{ if (i > 0) ", " else "", x });
                try w.writeAll("]");
            }
            try w.writeAll("\n");
        } else try w.print("@\"{s}\" = internal global [{d} x i64] zeroinitializer\n", .{ g.name, g.words });
    }
    for (m.funcs.items) |f| {
        var fe: FuncEmitter = .{ .gpa = gpa, .m = m, .f = f };
        defer fe.deinit();
        try fe.run(w);
    }
    return out.toOwnedSlice();
}

const Incoming = struct { from_label: []const u8, args: []const ir.Value };

const FuncEmitter = struct {
    gpa: std.mem.Allocator,
    m: *const ir.Module,
    f: *const ir.Func,
    arena: std.heap.ArenaAllocator = undefined,
    /// ブロックごとの本体テキスト（φ は全ブロックを出した後に前へ付ける）
    bodies: []Writer.Allocating = &.{},
    incoming: []std.ArrayListUnmanaged(Incoming) = &.{},
    /// 定数の値（div のガード省略用）
    consts: std.AutoHashMapUnmanaged(ir.Value, i64) = .empty,
    cur_label: []const u8 = "",
    fresh: u32 = 0,

    fn deinit(self: *FuncEmitter) void {
        for (self.bodies) |*b| b.deinit();
        self.arena.deinit();
    }

    fn a(self: *FuncEmitter) std.mem.Allocator {
        return self.arena.allocator();
    }

    fn run(self: *FuncEmitter, w: *Writer) Error!void {
        self.arena = std.heap.ArenaAllocator.init(self.gpa);
        const n = self.f.blocks.items.len;
        self.bodies = try self.a().alloc(Writer.Allocating, n);
        for (self.bodies) |*b| b.* = .init(self.gpa);
        self.incoming = try self.a().alloc(std.ArrayListUnmanaged(Incoming), n);
        for (self.incoming) |*l| l.* = .empty;

        const linkage = if (self.f.exported) "" else "internal ";
        try w.print("\ndefine {s}{s} @\"{s}\"(", .{ linkage, retTy(self.f.ret), self.f.name });
        for (self.f.params, 0..) |p, i| {
            if (i > 0) try w.writeAll(", ");
            try w.print("{s} %v{d}", .{ tyName(self.f.tys.items[p]), p });
        }
        try w.writeAll(") #0 {\n");

        for (self.f.blocks.items, 0..) |blk, bi| {
            self.cur_label = try std.fmt.allocPrint(self.a(), "b{d}", .{bi});
            const bw = &self.bodies[bi].writer;
            if (bi == 0) {
                // スロットは入口で確保してゼロ初期化（未初期化読みの undef を塞ぐ）
                for (self.f.slots.items, 0..) |words, si| {
                    try bw.print("  %s{d} = alloca [{d} x i64], align 8\n", .{ si, words });
                    for (0..words) |k| {
                        try bw.print("  %s{d}.z{d} = getelementptr i64, ptr %s{d}, i64 {d}\n", .{ si, k, si, k });
                        try bw.print("  store i64 0, ptr %s{d}.z{d}\n", .{ si, k });
                    }
                }
            }
            for (blk.insts.items) |in| try self.inst(bw, in);
            try self.term(bw, blk.term);
        }

        for (self.f.blocks.items, 0..) |blk, bi| {
            try w.print("b{d}:\n", .{bi});
            for (blk.params.items, 0..) |p, pi| {
                try w.print("  %v{d} = phi {s} ", .{ p, tyName(self.f.tys.items[p]) });
                for (self.incoming[bi].items, 0..) |inc, k| {
                    if (k > 0) try w.writeAll(", ");
                    try w.print("[ %v{d}, %{s} ]", .{ inc.args[pi], inc.from_label });
                }
                try w.writeAll("\n");
            }
            try w.writeAll(self.bodies[bi].written());
        }
        try w.writeAll("}\n");
    }

    fn label(self: *FuncEmitter, tag: []const u8) Error![]const u8 {
        self.fresh += 1;
        return std.fmt.allocPrint(self.a(), "{s}.{s}{d}", .{ self.cur_label[0 .. std.mem.indexOfScalar(u8, self.cur_label, '.') orelse self.cur_label.len], tag, self.fresh });
    }

    fn startLabel(self: *FuncEmitter, w: *Writer, l: []const u8) Error!void {
        try w.print("{s}:\n", .{l});
        self.cur_label = l;
    }

    /// 1 命令。ポインタ演算は `%v<N>.p` の補助名を使う
    fn inst(self: *FuncEmitter, w: *Writer, i: ir.Inst) Error!void {
        const r = i.res;
        switch (i.op) {
            .iconst => |n| {
                try self.consts.put(self.a(), r.?, n);
                try w.print("  %v{d} = add i64 0, {d}\n", .{ r.?, n });
            },
            .bin => |b| switch (b.op) {
                .div, .rem => try self.divRem(w, r.?, b.op, b.a, b.b),
                // 量を 6 bit にマスクしてから（LLVM は量 ≥ 64 を poison にする — IR の意味は x86 のマスク）
                .shl, .sar => {
                    try w.print("  %v{d}.n = and i64 %v{d}, 63\n", .{ r.?, b.b });
                    try w.print("  %v{d} = {s} i64 %v{d}, %v{d}.n\n", .{ r.?, if (b.op == .shl) "shl" else "ashr", b.a, r.? });
                },
                else => try w.print("  %v{d} = {s} i64 %v{d}, %v{d}\n", .{ r.?, binName(b.op), b.a, b.b }),
            },
            .cmp => |c| {
                try w.print("  %v{d}.c = icmp {s} i64 %v{d}, %v{d}\n", .{ r.?, cmpName(c.op), c.a, c.b });
                try w.print("  %v{d} = zext i1 %v{d}.c to i64\n", .{ r.?, r.? });
            },
            .load => |l| {
                try w.print("  %v{d}.p = getelementptr i64, ptr %v{d}, i64 {d}\n", .{ r.?, l.p, l.off });
                try w.print("  %v{d} = load {s}, ptr %v{d}.p\n", .{ r.?, tyName(l.ty), r.? });
            },
            .store => |s| {
                const n = self.fresh;
                self.fresh += 1;
                try w.print("  %st{d} = getelementptr i64, ptr %v{d}, i64 {d}\n", .{ n, s.p, s.off });
                try w.print("  store {s} %v{d}, ptr %st{d}\n", .{ tyName(self.f.tys.items[s.v]), s.v, n });
            },
            .load8 => |l| {
                try w.print("  %v{d}.p = getelementptr i8, ptr %v{d}, i64 {d}\n", .{ r.?, l.p, l.off });
                try w.print("  %v{d}.b = load i8, ptr %v{d}.p\n", .{ r.?, r.? });
                try w.print("  %v{d} = zext i8 %v{d}.b to i64\n", .{ r.?, r.? });
            },
            .store8 => |s| {
                const n = self.fresh;
                self.fresh += 1;
                try w.print("  %st{d} = getelementptr i8, ptr %v{d}, i64 {d}\n", .{ n, s.p, s.off });
                try w.print("  %st{d}.b = trunc i64 %v{d} to i8\n", .{ n, s.v });
                try w.print("  store i8 %st{d}.b, ptr %st{d}\n", .{ n, n });
            },
            .gep => |g| try w.print("  %v{d} = getelementptr {s}, ptr %v{d}, i64 %v{d}\n", .{ r.?, if (g.scale == .word) "i64" else "i8", g.p, g.idx }),
            .ptoi => |v| try w.print("  %v{d} = ptrtoint ptr %v{d} to i64\n", .{ r.?, v }),
            .itop => |v| try w.print("  %v{d} = inttoptr i64 %v{d} to ptr\n", .{ r.?, v }),
            .slotaddr => |s| try w.print("  %v{d} = getelementptr i64, ptr %s{d}, i64 0\n", .{ r.?, s }),
            .globaladdr => |g| try w.print("  %v{d} = getelementptr i64, ptr @\"{s}\", i64 0\n", .{ r.?, self.m.globals.items[g].name }),
            .call => |c| try self.call(w, r, c.f, c.args),
            .funcaddr => |f| try w.print("  %v{d} = ptrtoint ptr @\"{s}\" to i64\n", .{ r.?, self.m.funcs.items[f].name }),
            .call_indirect => |c| {
                const n = self.fresh;
                self.fresh += 1;
                try w.print("  %fp{d} = inttoptr i64 %v{d} to ptr\n  ", .{ n, c.callee });
                if (r) |v| try w.print("%v{d} = ", .{v});
                try w.print("call {s} %fp{d}(", .{ retTy(c.ret), n });
                try self.argList(w, c.args);
            },
            .syscall => |args| {
                try w.print("  %v{d} = ", .{r.?});
                try syscallAsm(w, args);
            },
            // region op は ir_rtlower が手前で展開済み（両バックエンドが共有する境界）
            .region_enter, .region_depth, .region_setdepth, .region_alloc, .region_bump, .region_relocate => unreachable,
        }
    }

    fn call(self: *FuncEmitter, w: *Writer, r: ?ir.Value, f: ir.FuncId, args: []const ir.Value) Error!void {
        const callee = self.m.funcs.items[f];
        try w.writeAll("  ");
        if (r) |v| try w.print("%v{d} = ", .{v});
        try w.print("call {s} @\"{s}\"(", .{ retTy(callee.ret), callee.name });
        try self.argList(w, args);
    }

    fn argList(self: *FuncEmitter, w: *Writer, vs: []const ir.Value) Error!void {
        for (vs, 0..) |arg, k| {
            if (k > 0) try w.writeAll(", ");
            try w.print("{s} %v{d}", .{ tyName(self.f.tys.items[arg]), arg });
        }
        try w.writeAll(")\n");
    }

    /// Go の意味の div / rem（ファイル冒頭の UB 遮断）
    fn divRem(self: *FuncEmitter, w: *Writer, r: ir.Value, op: ir.BinOp, x: ir.Value, y: ir.Value) Error!void {
        const inst_name = if (op == .div) "sdiv" else "srem";
        if (self.consts.get(y)) |k| if (k != 0 and k != -1) {
            try w.print("  %v{d} = {s} i64 %v{d}, %v{d}\n", .{ r, inst_name, x, y });
            return;
        };
        const l_zero = try self.label("dz");
        const l_nz = try self.label("dnz");
        const l_m1 = try self.label("dm1");
        const l_op = try self.label("dop");
        const l_join = try self.label("dj");
        try w.print("  %v{d}.z = icmp eq i64 %v{d}, 0\n", .{ r, y });
        try w.print("  br i1 %v{d}.z, label %{s}, label %{s}\n", .{ r, l_zero, l_nz });
        try self.startLabel(w, l_zero);
        try exitSeq(w, rt.PANIC);
        try self.startLabel(w, l_nz);
        try w.print("  %v{d}.m = icmp eq i64 %v{d}, -1\n", .{ r, y });
        try w.print("  br i1 %v{d}.m, label %{s}, label %{s}\n", .{ r, l_m1, l_op });
        try self.startLabel(w, l_m1);
        if (op == .div) {
            try w.print("  %v{d}.n = sub i64 0, %v{d}\n", .{ r, x });
        } else {
            try w.print("  %v{d}.n = add i64 0, 0\n", .{r});
        }
        try w.print("  br label %{s}\n", .{l_join});
        try self.startLabel(w, l_op);
        try w.print("  %v{d}.q = {s} i64 %v{d}, %v{d}\n", .{ r, inst_name, x, y });
        try w.print("  br label %{s}\n", .{l_join});
        try self.startLabel(w, l_join);
        try w.print("  %v{d} = phi i64 [ %v{d}.n, %{s} ], [ %v{d}.q, %{s} ]\n", .{ r, r, l_m1, r, l_op });
    }

    fn term(self: *FuncEmitter, w: *Writer, t: ir.Term) Error!void {
        switch (t) {
            .none => unreachable, // verify 済み
            .br => |e| try self.jump(w, e),
            .condbr => |c| {
                const lt = try self.label("t");
                const le = try self.label("e");
                const from = self.cur_label;
                try w.print("  %c.{s} = icmp ne i64 %v{d}, 0\n", .{ from, c.c });
                try w.print("  br i1 %c.{s}, label %{s}, label %{s}\n", .{ from, lt, le });
                try self.startLabel(w, lt);
                try self.jump(w, c.t);
                try self.startLabel(w, le);
                try self.jump(w, c.e);
            },
            .ret => |v| if (v) |x|
                try w.print("  ret {s} %v{d}\n", .{ tyName(self.f.tys.items[x]), x })
            else
                try w.writeAll("  ret void\n"),
            .exit => |code| try exitSeq(w, code),
        }
    }

    fn jump(self: *FuncEmitter, w: *Writer, e: ir.Edge) Error!void {
        try self.incoming[e.to].append(self.a(), .{ .from_label = self.cur_label, .args = e.args });
        try w.print("  br label %b{d}\n", .{e.to});
    }
};

fn exitSeq(w: *Writer, code: u8) Error!void {
    try w.print(
        "  call i64 asm sideeffect \"syscall\", \"={{rax}},{{rax}},{{rdi}},~{{rcx}},~{{r11}},~{{memory}}\"(i64 60, i64 {d})\n  unreachable\n",
        .{code},
    );
}

fn syscallAsm(w: *Writer, args: []const ir.Value) Error!void {
    const regs = [_][]const u8{ "rax", "rdi", "rsi", "rdx", "r10", "r8", "r9" };
    try w.writeAll("call i64 asm sideeffect \"syscall\", \"={rax}");
    for (args, 0..) |_, k| try w.print(",{{{s}}}", .{regs[k]});
    try w.writeAll(",~{rcx},~{r11},~{memory}\"(");
    for (args, 0..) |arg, k| {
        if (k > 0) try w.writeAll(", ");
        try w.print("i64 %v{d}", .{arg});
    }
    try w.writeAll(")\n");
}

fn tyName(t: ir.Ty) []const u8 {
    return switch (t) {
        .i64 => "i64",
        .ptr => "ptr",
    };
}

fn retTy(t: ?ir.Ty) []const u8 {
    return if (t) |x| tyName(x) else "void";
}

fn binName(op: ir.BinOp) []const u8 {
    return switch (op) {
        .add => "add",
        .sub => "sub",
        .mul => "mul",
        .and_ => "and",
        .or_ => "or",
        .xor => "xor",
        .div, .rem, .shl, .sar => unreachable,
    };
}

fn cmpName(op: ir.CmpOp) []const u8 {
    return switch (op) {
        .eq => "eq",
        .ne => "ne",
        .lt => "slt",
        .le => "sle",
        .gt => "sgt",
        .ge => "sge",
        .ult => "ult",
        .uge => "uge",
    };
}
