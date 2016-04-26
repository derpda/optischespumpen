#this script extracts the intensities from the data and plots the characteristic curve of the diode


################################################## Settings							 #####################################################

#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 18
set border linewidth 1.5
pointtitle="Data points"
set fit errorvariables
set tics font ",18"

#key options
set key right bottom
set key box lt 2 lw 2 lc rgb "#000000"

#axes label options
set xlabel "Diode current [mA]"
set ylabel "Photodiode signal [V]"

#prepare output file
system("DEL ..\\results\\kennlinie.txt")
set print '../results/kennlinie.txt'
print "\#Intensities for set of diode currents"
print "Current [mA] \t Intensity [V] \t Error [V]"

#bin widths to calculate error via variance of equal distribution
binw=0.02

################################################## Extract intensities				 #####################################################

filelist=system('dir /B ..\\data')

f(x)=intensity

do for [file in filelist] {
	len=strlen(file)-4
	fit f(x) '../data/'.file u 1:2 via intensity
	print file[:len],"\t\t",intensity,"\t",intensity_err
}

set output '../results/kennlinie.svg'
plot '../results/kennlinie.txt' u 1:2:(1/sqrt(12)*binw) title pointtitle w yerrorbars pt 0 ps 1 lc rgb '#dd181f'