// atexit — 終了の瞬間のスタックを採る（ptrace の PTRACE_O_TRACEEXIT）。panic（exit 101 = 取り違え・範囲外 / 102 = region・再帰の上限）で
// 診断の位置が出ずに落ちたとき、どこで落ちたかを 1 回で知る道具（samp の標本は速く落ちるプログラムを捕まえられない）。gates には組み込まない
// 前提: フレームポインタとシンボルのあるバイナリ（zig cc -O0 で建てる — sober build の ELF はシンボルを落としている）
// 使い方:
//   zig cc -O2 scripts/prof/atexit.c -o /tmp/atexit
//   /tmp/atexit ./sober_x check examples/fib.sober > stack.txt     # stdout に RIP + rbp の鎖 1 行、stderr に終了コード
//   node --experimental-strip-types scripts/prof/stack.ts ./sober_x stack.txt                          # 関数名に直して連続の重複を畳む
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/user.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
int main(int argc, char **argv) {
  pid_t p = fork();
  if (p == 0) { ptrace(PTRACE_TRACEME, 0, 0, 0); int fd = open("/dev/null", 1); dup2(fd,1); execv(argv[1], argv + 1); _exit(127); }
  int st; waitpid(p, &st, 0);
  ptrace(PTRACE_SETOPTIONS, p, 0, PTRACE_O_TRACEEXIT | PTRACE_O_EXITKILL);
  ptrace(PTRACE_CONT, p, 0, 0);
  for (;;) {
    if (waitpid(p, &st, 0) < 0) break;
    if (WIFEXITED(st)) { fprintf(stderr, "exited %d\n", WEXITSTATUS(st)); break; }
    if (WIFSTOPPED(st) && (st >> 8) == (SIGTRAP | (PTRACE_EVENT_EXIT << 8))) {
      struct user_regs_struct rg; ptrace(PTRACE_GETREGS, p, 0, &rg);
      printf("%llx", rg.rip);
      unsigned long bp = rg.rbp;
      for (int i = 0; i < 2000 && bp; i++) {
        errno = 0;
        long ret = ptrace(PTRACE_PEEKDATA, p, bp + 8, 0); if (errno) break;
        long nbp = ptrace(PTRACE_PEEKDATA, p, bp, 0); if (errno) break;
        printf(" %lx", ret);
        if ((unsigned long)nbp <= bp) break;
        bp = nbp;
      }
      printf("\n");
      ptrace(PTRACE_CONT, p, 0, 0);
      continue;
    }
    ptrace(PTRACE_CONT, p, 0, WIFSTOPPED(st) ? WSTOPSIG(st) : 0);
  }
  return 0;
}
