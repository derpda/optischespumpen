#this is supposed to do the exponential fits on the data and extract appropriate properties of said fits

################################################## Settings							 #####################################################

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


#prepare fit parameter output
set fit errorvariables
system('DEL "..\\results\\relaxation\\fitresults.txt"')
set print '../results/relaxation/ohnefoehn/fitresults.txt'
print "Results of exponential fits on the Dehmelt relaxation data.\n"
print "dataset \t Relative intensity \t error \t\t\tInverse relaxation time \t error"
padstring="          "


################################################## Get intensities					#####################################################

#read in data
translist=system('dir /B ..\\data\\Transmissionen')
Ntrans=words(translist)

#define constant functions to fit to nofilter and nolaser data
NL(x)=nolaser
NF(x)=nofilter

#get nolaser and nofilter values
fit NL(x) '../data/Transmissionen/'.word(translist,Ntrans) u 1:2:(1/sqrt(12)*0.008) yerror via nolaser
fit NF(x) '../data/Transmissionen/'.word(translist,1) u 1:2:(1/sqrt(12)*0.01) yerror via nofilter
nolaser_err=(0.004+1/sqrt(12)*0.008)
nofilter_err=(0.005+1/sqrt(12)*0.01)
binwtrans="0.01 0.01 0.008 0.008 0.008 0.008 0.008 0.008 0.008 0.008 0.008"

################################################## Fit functions and error lists	#####################################################

#exponential fit function for relaxation
f(x)=Imax-dI*exp(-a*(x-x0))
x0=0.0025
Imax=0.02
a=1200
dI=0.3


#constant fit function for filter intensities
I(x)=intensity


#bin widths to calculate error via variance of equal distribution
binw="0.002 0.002 0.0008 0.0008 0.0008 0.0004 0.0004 0.0004 0.0002 0.0002\
	 0.00008 0.00008 0.00004 0.00004 0.00004 0.00004 0.00004 0.00004 0.00004"



################################################## Main loop						#####################################################

#read in data
datalist=system('dir /B ..\\data\\ohnefoehn')
Ndata=words(datalist)

do for [i = 1:Ndata] {
	data=word(datalist,i)
	len=strlen(data)-4
	trans=word(translist,i)

	#get intensity
	if (i == 1) {
		rI=1
		intensity=nofilter
		intensity_err=(word(binwtrans,i)/2+1/sqrt(12)*word(binwtrans,i))
		srI= sqrt((1/(nofilter-nolaser))**2*intensity_err**2 + \
				((intensity-nolaser)*nofilter_err)**2/((nofilter-nolaser)**4)+\
				( (intensity-nolaser)/((nofilter-nolaser)**2) -1/(nofilter-nolaser))**2*nolaser_err**2  )
		rI = "1.000000000000000"
	}else {
		fit I(x) '../data/Transmissionen/'.trans u 1:2 via intensity
		intensity_err=(word(binwtrans,i)/2+1/sqrt(12)*word(binwtrans,i))
		rI=(intensity - nolaser)/(nofilter - nolaser)
		srI=sqrt((1/(nofilter-nolaser))**2*intensity_err**2 + \
				((intensity-nolaser)*nofilter_err)**2/((nofilter-nolaser)**4)+\
				( (intensity-nolaser)/((nofilter-nolaser)**2) -1/(nofilter-nolaser))**2*nolaser_err**2  )
	}

	#fit and plot
	set output '../results/relaxation/ohnefoehn/'.data[:len].'.svg'
	fit [0.0027:0.008] f(x) '../data/ohnefoehn/'.data u 1:2:(1/sqrt(12)*word(binw,i)) yerror via Imax,dI,a
	plot [0.002:0.0085]'../data/ohnefoehn/'.data u 1:2:(1/sqrt(12)*word(binw,i)) \
		title pointtitle w yerrorbars pt 0 ps 1 lc rgb '#dd181f',\
		[0.0027:] f(x) title fittitle w lines ls 1

	#output fit results to file
	print data[:len],padstring[:13-len],"\t",rI,"\t",srI,"\t",a," \t",a_err,"\t",intensity,"\t",intensity_err
}

################################################## Make final plot					#####################################################

#axes label options
set xlabel "Relative intensity"
set ylabel "Inverse orientation time [1/s]"


set output '../results/relaxation/ohnefoehn/linear_fit.svg'
g(x)=grad*x+1/Trelax
Trelax=0.0037
fit  g(x) '../results/relaxation/ohnefoehn/fitresults.txt' u 2:4:3:5 xyerror via grad,Trelax
plot [0:1.1]'../results/relaxation/ohnefoehn/fitresults.txt' u 2:4:3:5 w xyerrorbars title "Results from exponential fits"\
	pt 0 ps 1 lc rgb '#dd181f', [0:1.1] g(x) title "Linear fit" ls 1


intensity=nolaser
intensity_err=nolaser_err
srInolaser=sqrt((1/(nofilter-nolaser))**2*intensity_err**2 + \
				((intensity-nolaser)*nofilter_err)**2/((nofilter-nolaser)**4)+\
				( (intensity-nolaser)/((nofilter-nolaser)**2) -1/(nofilter-nolaser))**2*nolaser_err**2  )
print "no laser\t 0.0000000\t", srInolaser,"\t - \t - \t", nolaser,"\t",nolaser_err