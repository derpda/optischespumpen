#this script should determine the darktime and according as per the method given in the instructions

#del old fit log
system("DEL fit.log")

################################################## Settings							 #####################################################

#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 18
set border linewidth 1.5
set bars 0.4
set tics font ",18"
set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 3
pointtitle="Data points"
set fit errorvariables

#set labels
set xlabel "Dark time [ms]"
set ylabel "Fit parameter B [V]"

#key options
set key right bottom
set key box lt 2 lw 2 lc rgb "#000000"

################################################## Plot function					 #####################################################

I(x)=a+b*(1-exp(-x/TR))
Imax=0.089
Imin=0.133
TR=6.5

set output '../results/fitresults.svg'
fit [2:9] I(x) '../results/fitresults.txt' u ($4*1000):2:($5*1000):3 xyerror via a,b,TR
plot [2:9] '../results/fitresults.txt' u ($4*1000):2:($5*1000):3 w xyerrorbars pt 1 ps 1 lc rgb '#dd181f' title "Fitresults",I(x) ls 1 title "Fit function"