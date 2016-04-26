
################################################## Settings	
reset
#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 18
set border linewidth 1.5
set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 3
pointtitle="Data points"
set fit errorvariables
set bars 0.4
set tics font ",18"
set output "../results/HFS_fit.svg"

#key options
set key right bottom
set key box lt 2 lw 2 lc rgb "#000000"

set xlabel "Time [s]"
set ylabel "Photo diode voltage [V]"


#prepare fit parameter output
system('DEL "..\\results\\fitresults.txt"')
set print '../results/fitresults.txt'
print "#Peak positions from fit results\n"
print "i","\t","x_i","\t","x_err\n"

################################################## first 2 peaks
f1(x)=a1*exp(-(x-x01)**2/(2*s1**2))+a2*exp(-(x-x02)**2/(2*s2**2))+b1*x+c1
x01=0.000108
x02=0.00013
a1=0.14
s1=0.00003
a2=0.075
s2=0.00003
b1=600
c1=-0.76

xl1=0.000085
xh1=0.00016

fit [xl1:xh1] f1(x) "../data/HFSspektrum3_add.tab" u 1:2:(0.8*10**-3/sqrt(12)) yerror \
	via x01,x02,a1,a2,s1,s2,b1,c1
print "1","\t",x01,"\t",x01_err
print "2","\t",x02,"\t",x02_err
################################################## 3rd peak

f2(x)=a3*exp(-(x-x03)**2/(2*s3**2))+b2*x+c2
x03=0.000215
a3=0.4
s3=0.000015
b2=600
c2=-0.76
xl2=0.00019
xh2=0.00025

fit [xl2:xh2] f2(x) "../data/HFSspektrum3_add.tab" u 1:2:(0.8*10**-3/sqrt(12)) yerror \
	via x03,a3,s3,b2,c2
print "3","\t",x03,"\t",x03_err
################################################## last 3 peaks

f3(x)=a4*exp(-(x-x04)**2/(2*s4**2))+a5*exp(-(x-x05)**2/(2*s5**2))+a6*exp(-(x-x06)**2/(2*s6**2))+b3*x+c3
x04=0.000335
x05=0.00037
x06=0.000401
s4=0.00002
s5=0.000008
s6=0.000019
a4=0.74
a5=0.147
a6=0.436551
b3=600
c3=-0.76

xl3=0.00031
xh3=0.00043
fit [xl3:xh3] f3(x) "../data/HFSspektrum3_add.tab" u 1:2:(0.8*10**-3/sqrt(12)) yerror \
	via x04,x05,x06,s4,s5,s6,a4,a5,a6,b3,c3
print "4","\t",x04,"\t",x04_err
print "5","\t",x05,"\t",x05_err
print "6","\t",x06,"\t",x06_err
################################################## plot
plot [0:0.0005]"../data/HFSspektrum3_add.tab" u 1:2:(0.04e-01/sqrt(12)) w yerrorbars\
	pt 0 ps 0.6 lc rgb '#dd181f' title "Data points",\
	 [xl1:xh1] f1(x) lw 2.5 title '1. and 2. Peak g_1(t)',\
	 [xl2:xh2] f2(x) lw 2.5 title '3. Peak g_2(t)',\
	 [xl3:xh3] f3(x) lw 2.5 title '4., 5. and 6. Peak g_3(t)'