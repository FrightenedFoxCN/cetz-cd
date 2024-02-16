#import "src/cetz-cd.typ": *

#import "src/snipets.typ": *

#cetz-cd-raw(
    (($...$, $C_(n + 1)$, $C_n$, $C_(n - 1)$, $...$), ($...$, $D_(n + 1)$, $D_n$, $D_(n - 1)$, $...$)),
    "r & r, d, ld & r, d, ld & r, d, ld & ld \\ r & r & r & r &")

#cetz-cd-raw((($H_* (A)$, $H_*^A (X)$, $H_* (S_*^A (X \/ S_* (A)))$, $H_* (A)$, $0$), ($H_* (A)$, $H_* (X)$, $H_* (X, A)$, $H_* (A)$, $0$)), "r, d & r, d & r, d & r, d & d \\ r & r & r & r", width: 1.0)

#grid-rd(
    (($A$, $B$, $C$, $D$), ($E$, $F$, $G$, $H$))
)

#pushout(
    $U sect V$, $U$, $V$, $U union V$
)

#triangle-rd($U$, $V$, $V \/ U$)