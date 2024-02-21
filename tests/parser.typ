#import "../src/parser.typ": *

#parse-item(`$S$ ar[rd, swapped]`.text)

// multiple arrows

#parse-item(`$T$ ar[r, swapped, $g$] ar[d, bent: 45, offset: 2]`.text)

#parser(```
$A$ ar[r] ar[rd, $f$, swapped] & $B$ ar[d] \
& $C$
```.text)