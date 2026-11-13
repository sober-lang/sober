# hold.py <port> [n=900] [gap_ms=3] [hold_s=20] — fusecheck の留める相手: 受けの窓 2 KB の keep-alive の接続 1 本で /json/50（≈8 KB）を gap_ms ずつ n 本送り、一切読まずに hold_s 秒保つ
# （送りのバッファが満ちた後の送り置きが未完のまま留まる — 送り場の留めの題材。Python なのは SO_RCVBUF を connect の前に置くため）
import socket, sys, time
a = sys.argv[1:] + [None] * 4
port = int(a[0]); n = int(a[1] or 900); gap = float(a[2] or 3) / 1000; hold = float(a[3] or 20)
s = socket.socket(); s.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 2048); s.connect(("127.0.0.1", port))
req = b"GET /json/50 HTTP/1.1\r\nHost: x\r\n\r\n"
for i in range(n):
    s.sendall(req); time.sleep(gap)
time.sleep(hold)
