-- Featherweight Sober（docs/formal.md）。段 2a: region（immutable 参照）つき断片。
-- 定理 3（型健全性）+ 定理 1（領域安全。progress に吸収）を機械（Machine.lean）上で証明済み。
import FeatherweightSober.Syntax
import FeatherweightSober.Typing
import FeatherweightSober.Checker
import FeatherweightSober.TcEq
import FeatherweightSober.Machine
import FeatherweightSober.Fam
import FeatherweightSober.Leaf
import FeatherweightSober.Kahn
import FeatherweightSober.MachineTy
import FeatherweightSober.Substitution
import FeatherweightSober.Shift
import FeatherweightSober.TSubst
import FeatherweightSober.Soundness
import FeatherweightSober.Split
import FeatherweightSober.Examples
import FeatherweightSober.Ren
import FeatherweightSober.UniqFreeze
