################################################## Settings							 #####################################################
reset
#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 18
set border linewidth 1.5
set bars 0.4
set tics font ",18"
set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 3
fittitle='Exponential fit'
pointtitle='Data points'

#key options
set key right bottom
set key box lt 2 lw 2 lc rgb "#000000"

#axes label options
set xlabel "Time [s]"
set ylabel "Photodiode signal [V]"

################################################## Plots							 #####################################################

# plot for the bend in the curve
set output '../results/bendincurve.svg'
plot [0:0.002]'../data/etalonsteigend.tab' u 1:2 pt 1 ps 0.5 lc rgb '#dd181f' title "Photo diode signal",\
	[0:0.002]'../data/etalonsteigend.tab' u 1:3 pt 1 ps 0.5 lc rgb '#0060ad' title "Diode current signal"

# plot for showing the effect of inversing and adding
set output '../results/addinverse.svg'
plot '../data/HFSspektrum3_add.tab' u 1:(-($2/5-$3)) pt 1 ps 0.5 lc rgb '#dd181f',\
	'../data/HFSspektrum3_add.tab' u 1:($3) pt 1 ps 0.5 lc rgb '#0060ad'