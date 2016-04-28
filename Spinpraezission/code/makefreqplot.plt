# script to make plots for the report

################################################## Settings							 #####################################################
reset
#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 18
set border linewidth 1.5
set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 2
pointtitle="Data points"
set fit errorvariables
set bars 0.4
set tics font ",18"

#key options
set key right top
set key box lt 2 lw 2 lc rgb "#000000"

set xlabel "Current [mA]"
set ylabel "Precession frequency [kHz]"


################################################## Plots							 #####################################################
#lin fit
f(x)=a*x+b


set output '../results/resultsreadout.svg'
fit f(x) '../results/timediffresults.txt' u ($1*10**(3)):(1/($2*10**(-5))*10**(-3)):($3/(($2*10**(-5)))*10**(-3) ) yerror via a,b
plot '../results/timediffresults.txt' u ($1*10**(3)):(1/($2*10**(-5))*10**(-3)):($3*10**(-5)/(($2*10**(-5))**2)*10**(-3) ) \
	title "Frequencies"	w yerrorbars pt 0 ps 1 lc rgb '#dd181f',f(x) ls 1 title "f(x)=a*x+b"