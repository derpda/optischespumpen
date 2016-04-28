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

#key options
set key right top
set key box lt 2 lw 2 lc rgb "#000000"

set xlabel "Time [s]"
set ylabel "Photo diode voltage [V]"

#bin widths to calculate error via variance of equal distribution
binw1=0.0002
binw2=0.02


################################################## Plots							 #####################################################
#read in data
datalist=system('dir /B ..\\data')
Ndata=words(datalist)


do for [i = 9:9] {
	data=word(datalist,i)
	len=strlen(data)-4
	set terminal svg size 1024,576 fname 'Verdana' fsize 18
	set output '../results/'.data[:len].'.svg'
	plot [0:0.00006]'../data/'.data u 1:2:(1/sqrt(12)*binw1) w yerrorbars pt 0 ps 1 lc rgb '#dd181f' title "Data points"
	set terminal wxt i
	set output
	replot
}

#time differences read out from the plots
time1="2.0 1.85 2.01 1.74 1.93 2.12 1.80 2.08 4.25 4.52 5.37 5.38 4.74 5.45 14.4 16.5 15.0 19.6 21.9"#*10**(-5)
time2="2.5 2.2 2.42 2.18 2.42 2.63 2.38 2.68 5.00 5.32 7.23 7.23 7.10 8.03 17.8 29.4 20.2 27.8 27.8"#*10**(-5)
etime="0.1 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.04 0.04 0.05 0.06 0.08 0.12 0.12 0.13 0.18 0.45"#*10**(-5)
#for 14 (5.37 and 7.23) 2 periods
# 14 is 11 in the lower loop


#prepare fit parameter output
set fit errorvariables
system('DEL "..\\results\\timediffresults.txt"')
set print '../results/timediffresults.txt'
print "Time differences read from the graphs.\n"
print "vCurrent [A]\t td [10^-5s] \t e_td [10^-5s]"

Npoints=words(time1)

do for [i = 1:Npoints]{
	data=word(datalist,i+3)
	len=strlen(data)-12
	vtime1=word(time1,i)
	vtime2=word(time2,i)
	vetime=word(etime,i)
	if (i<11) {
		td=vtime2-vtime1
		etd=sqrt(2)*vetime
	}else{
		td=(vtime2-vtime1)/2
		etd=(1/sqrt(2))*vetime
	}
	if (i>16) {
		td=vtime2-vtime1
		etd=sqrt(2)*vetime
	}
	print data[2:len],"\t\t",td,"\t\t",etd
}
