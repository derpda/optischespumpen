reset
set bars 0.3
set terminal svg size 1920,1080 fname 'Verdana' fsize 10
set output '../results/HFS_fit.svg'

############################################## first 2 peaks
f1(x)=a1*exp(-(x-x01)**2/(2*s1**2))+a2*exp(-(x-x02)**2/(2*s2**2))+b*x+c
x01=0.000108
x02=0.00013
a1=0.5
s1=0.00003
a2=0.1
s2=0.00003
b=0.05/0.0001
c=-0.73

xl1=0.000085
xh1=0.00016

fit [xl1:xh1] f1(x) "../data/HFSspektrum3_add.tab" u 1:2:(0.8*10**-3/sqrt(12)) yerror \
	via x01,x02,a1,a2,s1,s2,b,c
plot "../data/HFSspektrum3_add.tab" u 1:2:(0.04e-01/sqrt(12)) w yerrorbars\
	lt rgb "#7F7F7F" pt 0 ps 1, [xl1:xh1] f1(x) lt rgb "#800000"