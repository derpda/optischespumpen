set terminal svg size 1920,1080 fname 'Verdana' fsize 10
set output "../results/v0.025Ah0.005A.svg"
plot "../data/v0.025Ah0.005A.tab" u 1:2 