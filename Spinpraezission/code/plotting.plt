set terminal svg size 1920,1080 fname 'Verdana' fsize 10
set mxtics 10
set grid xtics mxtics lt 0 lw 2 lc rgb "#000000"
set output "../results/v0.000Ah0.005A.svg"
plot "../data/v0.000Ah0.005A.tab" u 1:2 