# std の凍結した写し（stage1 の焼き込み用）

build.zig の stdEmbedModule は、stage1（凍結した Zig 版）に std を焼き込むとき、`std/` でなくここを読む（鍵の名前は `std/…` のまま）。
中身は byte の段 S4（string = imm []byte・std の API の []byte 化）の直前の `std/` の写し。

- stage1 は凍結物なので、その入力（Zig のソース + 焼き込む std）も凍結物にする。ここは以後変えない
- 使う場所: stage1 → boot₀（鎖の先頭 — scripts/boot.commit の 1 行目の compiler/ を stage1 が建てる）・凍結コーパスの Zig 側（obs_zig・selfhost_* の Zig 側・hermetic_zig）
- boot₁ 以降と stage2 は、それぞれのコミットの std を自分の焼き込み（@embed）に持つ — ここは読まない
