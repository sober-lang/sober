// samp — ptrace の簡易サンプラ（perf の無い環境で -O0 の Sober バイナリを測る道具。gates には組み込まない）
// 使い方:
//   zig cc -O2 scripts/prof/samp.c -o /tmp/samp                       # 建てる
//   (ulimit -s unlimited; /tmp/samp out.txt ./sober_x check tools/sobercheck/main.sober)   # 2 ms ごとに RIP + rbp の鎖を 1 行ずつ
//   node --experimental-strip-types scripts/prof/sym.ts ./sober_x out.txt 30               # self / inclusive（under.ts は関数を指定して内訳と呼び手）
// 前提: フレームポインタが残るバイナリ（zig cc -O0）・シンボルあり（nm）。子の stdout は /dev/null へ捨てる
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/user.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <fcntl.h>
int main(int argc, char **argv) {
  FILE *out = fopen(argv[1], "w");
  pid_t p = fork();
  if (p == 0) { ptrace(PTRACE_TRACEME, 0, 0, 0); int fd = open("/dev/null", 1); dup2(fd,1); execv(argv[2], argv + 2); _exit(127); }
  int st; waitpid(p, &st, 0);
  ptrace(PTRACE_SETOPTIONS, p, 0, PTRACE_O_EXITKILL);
  ptrace(PTRACE_CONT, p, 0, 0);
  struct timespec ts = {0, 2000000};
  for (;;) {
    nanosleep(&ts, 0);
    if (kill(p, SIGSTOP) != 0) break;
    int r = waitpid(p, &st, 0);
    if (r < 0 || WIFEXITED(st) || WIFSIGNALED(st)) break;
    if (WIFSTOPPED(st) && WSTOPSIG(st) == SIGSTOP) {
      struct user_regs_struct rg; ptrace(PTRACE_GETREGS, p, 0, &rg);
      fprintf(out, "%llx", rg.rip);
      unsigned long bp = rg.rbp;
      for (int i = 0; i < 400 && bp; i++) {
        errno = 0;
        long ret = ptrace(PTRACE_PEEKDATA, p, bp + 8, 0); if (errno) break;
        long nbp = ptrace(PTRACE_PEEKDATA, p, bp, 0); if (errno) break;
        fprintf(out, " %lx", ret);
        if ((unsigned long)nbp <= bp) break;
        bp = nbp;
      }
      fprintf(out, "\n");
      ptrace(PTRACE_CONT, p, 0, 0);
    } else {
      ptrace(PTRACE_CONT, p, 0, WIFSTOPPED(st) ? WSTOPSIG(st) : 0);
    }
  }
  fclose(out); return 0;
}
