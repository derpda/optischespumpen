#this is supposed to do the exponential fits on the data and extract appropriate properties of said fits

################################################## Settings							 #####################################################

#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 12
set border linewidth 1.5
set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 3
fittitle='Exponential fit'
pointtitle='Data points'

#key options
set key right bottom
set key box lt 2 lw 2 lc rgb "#000000"


#prepare fit parameter output
set fit errorvariables
system('DEL "..\\results\\relaxation\\fitresults.txt"')
set print '../results/relaxation/fitresults.txt'
print "Results of exponential fits on the Dehmelt relaxation data.\n"
print "dataset \t Relative intensity \tInverse relaxation time \t error"
padstring="          "


################################################## Get intensities					#####################################################

#read in data
translist=system('dir /B ..\\data\\Transmissionen')
Ntrans=words(translist)

#define constant functions to fit to nofilter and nolaser data
NL(x)=nolaser
NF(x)=nofilter

#get nolaser and nofilter values
fit NL(x) '../data/Transmissionen/'.word(translist,Ntrans) u 1:2 via nolaser
fit NF(x) '../data/Transmissionen/'.word(translist,1) u 1:2 via nofilter



################################################## Fit functions and error lists	#####################################################

#exponential fit function for relaxation
f(x)=Imax-dI*exp(-a*(x-x0))
x0=0.005
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
datalist=system('dir /B ..\\data\\Daten')
Ndata=words(datalist)

do for [i = 1:Ndata] {
	data=word(datalist,i)
	len=strlen(data)-4
	trans=word(translist,i)

	#get intensity
	if (i == 1) {
		rI = "1.000000000000000"
	}else {
		fit I(x) '../data/Transmissionen/'.trans u 1:2 via intensity
		rI=(intensity - nolaser)/(nofilter - nolaser)
	}

	#fit and plot
	set output '../results/relaxation/'.data[:len].'.svg'
	fit [0.0055:0.012] f(x) '../data/Daten/'.data u 1:2:(1/sqrt(12)*word(binw,i)) yerror via Imax,dI,a
	plot [0.004:0.014] '../data/Daten/'.data u 1:2:(1/sqrt(12)*word(binw,i)) \
		title pointtitle w yerrorbars pt 0 ps 1 lc rgb '#dd181f',\
		[0.0053:] f(x) title fittitle w lines ls 1

	#output fit results to file
	print data[:len],padstring[:13-len],"\t",rI,"\t",a," \t",a_err
}



################################################## Make final plot					#####################################################

set output '../results/relaxation/linear_fit.svg'
g(x)=grad*x+1/Trelax
Trelax=0.0037
fit [0:0.9] g(x) '../results/relaxation/fitresults.txt' u 2:3:4 yerror via grad,Trelax
plot '../results/relaxation/fitresults.txt' u 2:3:4 w yerrorbars, g(x)

