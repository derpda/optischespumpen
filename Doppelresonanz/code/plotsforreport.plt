# script to make plots for the report

################################################## Settings							 #####################################################
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
set key right top
set key box lt 2 lw 2 lc rgb "#000000"

set xlabel "Time [s]"
set ylabel "Photo diode voltage [V]"

#bin widths to calculate error via variance of equal distribution
binw1=0.0008
binw2=0.008

################################################## Plots							 #####################################################
set output '../results/equaldistance.svg'

set yrange [-0.08:0.06]
plot [0:0.05]'../data/61.8mA34.3C130.2mA.tab' u 1:2:(1/sqrt(12)*binw1) title "Photo diode signal" w yerrorbars pt 0 ps 1 lc rgb '#dd181f',\
	[0:0.05]'../data/61.8mA34.3C130.2mA.tab' u 1:($3*0.1):(1/sqrt(12)*binw2*0.1) title "Voltage in coil 1 div. by 10" w yerrorbars pt 0 ps 1 lc rgb '#0060ad'
