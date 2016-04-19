#this script should determine the darktime and according

#del old fit log
system("DEL fit.log")

################################################## Settings							 #####################################################

#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 12
set border linewidth 1.5
set bars 0.4
set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 3
pointtitle="Data points"
set fit errorvariables

#key options
set key right bottom
set key box lt 2 lw 2 lc rgb "#000000"

#prepare fit parameter output
system('DEL "..\\results\\fitresults.txt"')
set print '../results/fitresults.txt'
print "#Result of the added fermi and exponential fits to the data.\n"
print "Chopper Voltage [V] \t Par B [V] \t Error [V] \t "

################################################## Plot function					 #####################################################

#Fermie curve
F(x)=A/(1+exp((mu-x)/sig))

#exponential for dent
E(x)=x>mu-sig*log(99) ? B*(1-exp(-lam*(x-(mu-sig*log(99))))) : 0

#step function
S(x)=x>mu ? A : 0

#exponential for dent used with step function
E2(x)=x>mu ? B*(1-exp(-lam*(x-mu))) : 0


#fit functions
fit(x)=F(x) + E(x) + U
fit2(x)=S(x) + E2(x) + U

################################################## Main loop						 #####################################################

filelist=system('dir /B ..\\data\\main')
Nfiles=words(filelist)

do for [i = 1:Nfiles] {
	file=word(filelist,i)
	voltage=strlen(file)-5
	set output '../results/'.file[:voltage].'.svg'
	plot '../data/main/'.file u 1:2
}


#fit for U=3.90
A=0.645
B=0.08
U=-0.31
mu=0.0035
sig=10*10**(-6)
lam=1000

file=word(filelist,1)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [0.000348:0.008] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.002:0.008]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.008] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err




#fit for U=4.00
A=0.7
B=0.08
U=-0.34
mu=0.005
sig=17*10**(-6)
lam=1000

file=word(filelist,2)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.008] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.002:0.01]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.002:0.01] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err


	 

#fit for U=5.00
A=0.7
B=0.08
U=-0.34
mu=0.0051
sig=17*10**(-6)
lam=1000

file=word(filelist,3)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.008] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.003:0.008]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.008] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err





#fit for U=5.98
A=0.7
B=0.08
U=-0.34
mu=0.0026
sig=17*10**(-6)
lam=1000

file=word(filelist,4)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.006] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.001:0.006]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.006] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err

	 



#fit for U=7.02
A=0.7
B=0.08
U=-0.34
mu=0.0025
sig=17*10**(-6)
lam=1000

file=word(filelist,5)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.006] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.001:0.006]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.006] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err




	 
#fit for U=8.02
A=0.7
B=0.08
U=-0.34
mu=0.0026
sig=17*10**(-6)
lam=1000

file=word(filelist,6)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.006] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.001:0.005]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.006] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err





#fit for U=9.05
A=0.59
B=0.08
U=-0.33
mu=0.0014
sig=17*10**(-6)
lam=1000


file=word(filelist,7)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.004] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.004]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.004] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err




#fit for U=10.03
A=0.6
B=0.01
U=-0.34
mu=0.00135
sig=7*10**(-6)
lam=500


file=word(filelist,8)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.003] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.003]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.003] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err

#fit for U=11.04
A=0.6
B=0.01
U=-0.34
mu=0.00135
sig=7*10**(-6)
lam=500


file=word(filelist,9)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.003] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.003]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.003] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err



#fit for U=12.04
A=0.6
B=0.01
U=-0.34
mu=0.00135
sig=7*10**(-6)
lam=500


file=word(filelist,10)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.003] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.003]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.003] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err


#fit for U=13.05
A=0.6
B=0.01
U=-0.34
mu=0.00135
sig=7*10**(-6)
lam=500


file=word(filelist,11)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.003] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.003]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.003] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err


#fit for U=14.00
A=0.6
B=0.01
U=-0.34
mu=0.00135
sig=7*10**(-6)
lam=500


file=word(filelist,12)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.003] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.003]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.003] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err


#fit for U=15.04
A=0.6
B=0.01
U=-0.34
mu=0.00135
sig=7*10**(-6)
lam=500


file=word(filelist,13)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.003] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.003]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.003] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err


#fit for U=16.06
A=0.6
B=0.01
U=-0.34
mu=0.00135
sig=7*10**(-6)
lam=500


file=word(filelist,14)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.003] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.003]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.003] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err


#fit for U=17.03
A=0.6
B=0.02
U=-0.34
mu=0.00135
sig=7*10**(-6)
lam=500


file=word(filelist,15)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.0025] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.0025]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.0025] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err


#fit for U=18.06
A=0.6
B=0.01
U=-0.34
mu=0.00135
sig=7*10**(-6)
lam=3000


file=word(filelist,16)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [0.001:0.0022] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.0025]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.0016] fit(x) w lines ls 1
print file[:voltage],"\t",B,"\t",B_err



################################################## Print end results					 #####################################################

set output '../results/fitresults.svg'
plot '../results/fitresults.txt' u 1:2:3 w yerrorbars pt 1 ps 1 lc rgb '#dd181f'