################################################## Settings	
reset
#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 18
set border linewidth 1.5
set tics font ",18"
set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 3
pointtitle="Data points"
set fit errorvariables
set bars 0.4
set output '../results/etalon_fit.svg'

#key options
set key left top
set key box lt 2 lw 2 lc rgb "#000000"

set xlabel "Time [s]"
set ylabel "Photo diode voltage [V]"

################################################## fit functions
f1(x)=a1*exp(-(x-x01)**2/(2*s1**2))+c1
f2(x)=a2*exp(-(x-x02)**2/(2*s2**2))+c2
f3(x)=a3*exp(-(x-x03)**2/(2*s3**2))+c3
f4(x)=a4*exp(-(x-x04)**2/(2*s4**2))+c4
f5(x)=a5*exp(-(x-x05)**2/(2*s5**2))+c5
g(x)=b*x+c
h(x)=f1(x)+f2(x)+f3(x)+f4(x)+f5(x)+g(x)
################################################## peak positions x0 
x01=0.00035
x02=0.00075
x03=0.00112
x04=0.0015
x05=0.00186

################################################## standard deviation s
s1=0.00006
s2=0.00006
s3=0.00006
s4=0.00006
s5=0.00018

################################################## peak height a
a1=0.032
a2=0.05
a3=0.07
a4=0.08
a5=0.91

################################################## offset c
c1=-0.0075
c2=-0.003
c3=0.001
c4=0.005
c5=-0.81
################################################## fit range
xl1=0.00025
xh1=0.00043

xl2=0.00065
xh2=0.00083

xl3=0.00105
xh3=0.00118

xl4=0.00142
xh4=0.00155

xl5=0.00181
xh5=0.00191
################################################## fit and plot
fit [xl1:xh1] f1(x) "../data/etalon3b.tab" u 1:2:(0.8*10**-3/sqrt(12)) yerror \
	via x01,s1,a1,c1
fit [xl2:xh2] f2(x) "../data/etalon3b.tab" u 1:2:(0.8*10**-3/sqrt(12)) yerror \
	via x02,s2,a2,c2
fit [xl3:xh3] f3(x) "../data/etalon3b.tab" u 1:2:(0.8*10**-3/sqrt(12)) yerror \
	via x03,s3,a3,c3
fit [xl4:xh4] f4(x) "../data/etalon3b.tab" u 1:2:(0.8*10**-3/sqrt(12)) yerror \
	via x04,s4,a4,c4
fit [xl5:xh5] f5(x) "../data/etalon3b.tab" u 1:2:(0.8*10**-3/sqrt(12)) yerror \
	via x05,s5,a5,c5
#fit [0.0001:0.00191] h(x) "../data/etalon3b.tab" \
	#u 1:2:(0.8*10**-3/sqrt(12)) yerror via x01,x02,x03,x04,x05,a1,a2,a3,a4,a5,s1,s2,s3,s4,s5,b,c
plot [0:0.002]"../data/etalon3b.tab" u 1:2:(0.8*10**-3/sqrt(12))\
 w yerrorbars pt 0 ps 0.6 lc rgb '#dd181f' title "Data points",\
	[xl1:xh1] f1(x) lw 2.5 title '1. Peak g_1(t)',\
	[xl2:xh2] f2(x) lw 2.5 title "2. Peak g_2(t)",\
	[xl3:xh3] f3(x) lw 2.5 title "3. Peak g_3(t)",\
	[xl4:xh4] f4(x) lw 2.5 title "4. Peak g_4(t)",\
	[xl5:xh5] f5(x) lw 2.5 title "5. Peak g_5(t)"

#################################################### Summe aller
#plot "../data/etalon3b.tab" u 1:2:(0.8*10**-3/sqrt(12))\
 #w yerrorbars lt rgb "#7F7F7F" pt 0 ps 1,\
 #[0.0001:0.0005] h(x) lt rgb "#800000",\
	#[0.0005:0.0008] h(x) lt rgb "#800000",\
	#[0.0008:0.0013] h(x) lt rgb "#800000",\
	#[0.0013:0.0017] h(x) lt rgb "#800000",\
	#[0.0017:0.00191] h(x) lt rgb "#800000"
