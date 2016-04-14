set terminal svg size 1920,1080 fname 'Verdana' fsize 10
f(x)= Imax-dI*exp(-(x-x0)*a)
x0=5.4e-3 
#x0 ist KEIN fitparameter!
dI=0.2
Imax=0.035
a=1/0.002
#fit bereich am Minimum starten lassen (minmimum automatisch finden?)
fit  [5.4e-3:0.0145] f(x) "../data/Daten/00_nofilter.tab" u 1:2 via Imax,dI,a 
set output '../results/relaxation/00_nofilter.svg'
plot [5.2e-3:0.015] "../data/Daten/00_nofilter.tab" u 1:2, f(x)
fit  [5.31e-3:0.0145] f(x) "../data/Daten/16_066.tab" u 1:2 via Imax,dI,a
set output '../results/relaxation/16.svg
plot "../data/Daten/16_066.tab" u 1:2,f(x)