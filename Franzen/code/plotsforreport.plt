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
set key right bottom
set key box lt 2 lw 2 lc rgb "#000000"

set xlabel "Time [s]"
set ylabel "Photo diode voltage [V]"

binw=0.02

################################################## Plots							 #####################################################

set output '../results/chopper1.5V.svg'

plot [0:0.001]'../data/chopper/1.5V.tab' u 1:2:(1/sqrt(12)*binw) w yerrorbars pt 0 ps 1 lc rgb '#dd181f' title "Photo diode signal"