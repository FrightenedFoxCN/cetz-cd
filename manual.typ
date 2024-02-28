#import "src/cetz-cd.typ": *

#import "src/snipets.typ": *

This is currently more examples than manual.

#cetz-cd(```
    $...$ ar[r] & $C_(n + 1)$ ar[r] ar[d] ar[ld] & $C_n$ ar[r] ar[d] ar[ld] & $C_(n - 1)$ ar[r] ar[d] ar[ld] & $...$ ar[ld];
    $...$ ar[r] & $D_(n + 1)$ ar[r] & $D_n$ ar[r] & $D_(n - 1)$ ar[r] & $...$
```)

#cetz-cd(```
$A$ ar[r, $g$] ar[rd, $f$, swapped] & $B$ ar[d];
& $D$
```)

// #to-table(```
//     $H_* (A)$ ar[r] ar[d] & $H_*^cal(A) (X)$ ar[r] ar[d] & $H_* (S_*^cA (X \/ S_* (A)))$ ar[r] ar[d] & $H_* (A)$ ar[r] ar[d] & $0$ ar[d] ;
//     $H_* (A)$ ar[r] & $H_* (X)$ ar[r] & $H_* (X, A)$ ar[r] & $H_* (A)$ ar[r] & $0$
// ```.text)

#cetz-cd(```
    $H_* (A)$ ar[r] ar[d] & $H_*^cal(A) (X)$ ar[r] ar[d] & $H_* (S_*^cal(A) (X \/ S_* (A)))$ ar[r] ar[d] & $H_* (A)$ ar[r] ar[d] & $0$ ar[d];
    $H_* (A)$ ar[r] & $H_* (X)$ ar[r] & $H_* (X, A)$ ar[r] & $H_* (A)$ ar[r] & $0$
```)