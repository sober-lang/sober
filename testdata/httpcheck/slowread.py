# slowread.py <port> [rounds=5] [n=600] [items=50] [rcvbuf=2048] — fusecheck の遅い読み手の題材（送り置きの短い送りの後に眠りが滞らないこと）: keep-alive の接続 1 本で、
# /json/<items>（≈8 KB）の要求 n−1 本を 1 回の書きで送り（束 → 同期の送りでサーバの送りのバッファを満たす）、読まずに 100 ms 待ってから
# 最後の 1 本を単独で送る（束 1 本 = 送り置き — 送りのバッファが満ちていれば短い送りになる）。それから全部の応答を速く読み切る。
# SINGLES=k なら、その後に「要求 1 本を送る → READ バイト（既定 64 KB）読む → 2 ms 眠る」を k 回（読みが作りより遅い — 送りのバッファが満ちたまま 1 本ずつの送り置き）。
# 1 行 = 周ごとの「読み始めてから読み切るまで」の ms。滞りがあれば保険の timeout（100 ms）の分だけ伸びる。
# Python なのは SO_RCVBUF を connect の前に置くため（node の net は置けない）
import os, socket, sys, time
singles = int(os.environ.get('SINGLES', '0')); rd = int(os.environ.get('READ', '65536'))
a = sys.argv[1:] + [None] * 5
port = int(a[0]); rounds = int(a[1] or 5); n = int(a[2] or 600); items = int(a[3] or 50); rcv = int(a[4] or 2048)
s = socket.socket(); s.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, rcv); s.connect(("127.0.0.1", port))
req = f"GET /json/{items} HTTP/1.1\r\nHost: x\r\n\r\n".encode()
out = []
for r in range(rounds):
    s.sendall(req * (n - 1)); time.sleep(0.1); s.sendall(req); time.sleep(0.05)
    buf = b""; got = 0; pos = 0
    def take(lim):
        global buf, got, pos
        d = s.recv(lim)
        if not d: raise SystemExit("eof")
        buf += d
        while True:
            e = buf.find(b"\r\n\r\n", pos)
            if e < 0: break
            h = buf[pos:e]
            cl = int([l.split(b":")[1] for l in h.split(b"\r\n") if l.lower().startswith(b"content-length")][0])
            if len(buf) < e + 4 + cl: break
            pos = e + 4 + cl; got += 1
        buf = buf[pos:]; pos = 0
    for k in range(singles):
        s.sendall(req); take(rd); time.sleep(0.002)
    t0 = time.monotonic()
    while got < n + singles:
        d = s.recv(1 << 20)
        if not d: raise SystemExit("eof")
        buf += d
        while True:
            e = buf.find(b"\r\n\r\n", pos)
            if e < 0: break
            h = buf[pos:e]
            cl = int([l.split(b":")[1] for l in h.split(b"\r\n") if l.lower().startswith(b"content-length")][0])
            if len(buf) < e + 4 + cl: break
            pos = e + 4 + cl; got += 1
        buf = buf[pos:]; pos = 0
    out.append((time.monotonic() - t0) * 1000)
print("read ms: " + " ".join(f"{x:.1f}" for x in out))
