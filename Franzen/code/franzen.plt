#this script should determine the darktime and according

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

#key options
set key right bottom
set key box lt 2 lw 2 lc rgb "#000000"

#axes labels
set xlabel "Time [s]"
set ylabel "Photo diode voltage [V]"

#prepare fit parameter output
system('DEL "..\\results\\fitresults.txt"')
set print '../results/fitresults.txt'
print "#Result of the added fermi and exponential fits to the data.\n"
print "V_Ch [V] \t Par B [V] \t Error [V] \t\t Tdark [s] \t\t s_Tdark [s]"

################################################## Plot function					 #####################################################

#Fermie curve
F(x)=A/(1+exp((mu-x)/sig))

#exponential for dent
E(x)=x>mu-sig*log(99) ? B*(1-exp(-lam*(x-(mu-sig*log(99))))) : 0
#E(x)=x>mu ? B*(1-exp(-lam*(x-mu))) : 0

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



do for [i = 17:17] {
	file=word(filelist,i)
	voltage=strlen(file)-5
	set output '../results/'.file[:voltage].'.svg'
	plot '../data/main/'.file u 1:2
}

#### Dark times
dtime2="0.0116 0.0135 0.0116 0.00793 0.00709 0.00646 0.00467 0.00432 0.00403 0.00380 0.00359 0.00342 0.00325 0.00313 0.00300 0.00291 0.00282" #in milli seconds
edtime2="0.0001 0.0001 0.0001 0.00004 0.00004 0.00004 0.00003 0.00003 0.00003 0.00003 0.00003 0.00002 0.00002 0.00002 0.00002 0.00002 0.00002"


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
fit [0.0003:0.006] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.002:0.008]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.003:0.005] fit(x) w lines ls 1
dtime=word(dtime2,1)-mu
edtime=sqrt(mu_err**2+word(edtime2,1)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime

system("inkscape -D -z --file=../results/".file[:voltage]."_test.svg --export-pdf=../results/".file[:voltage].".pdf")
system('DEL "..\\results\\03.90_test.svg"')




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
fit [0.004:0.008] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.002:0.01]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f' title "Photo diode signal",\
	 [0.0045:0.007] fit(x) w lines ls 1 title "Fit function"
dtime=word(dtime2,2)-mu
edtime=sqrt(mu_err**2+word(edtime2,2)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime


	 

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
fit [0.004:0.008] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.004:0.008]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0045:0.0065] fit(x) w lines ls 1
dtime=word(dtime2,3)-mu
edtime=sqrt(mu_err**2+word(edtime2,3)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime





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
fit [0.002:0.006] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.001:0.006]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.002:0.0045] fit(x) w lines ls 1
dtime=word(dtime2,4)-mu
edtime=sqrt(mu_err**2+word(edtime2,4)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime

	 



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
fit [0.002:0.005] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.001:0.006]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.002:0.004] fit(x) w lines ls 1
dtime=word(dtime2,5)-mu
edtime=sqrt(mu_err**2+word(edtime2,5)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime




	 
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
fit [0.002:0.006] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.001:0.005]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.002:0.0035] fit(x) w lines ls 1
dtime=word(dtime2,6)-mu
edtime=sqrt(mu_err**2+word(edtime2,6)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime





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
	 [0.0005:0.0025] fit(x) w lines ls 1
dtime=word(dtime2,7)-mu
edtime=sqrt(mu_err**2+word(edtime2,7)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime



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
	 [0.0005:0.002] fit(x) w lines ls 1
dtime=word(dtime2,8)-mu
edtime=sqrt(mu_err**2+word(edtime2,8)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime

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
plot [0.001:0.003]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.002] fit(x) w lines ls 1
dtime=word(dtime2,9)-mu
edtime=sqrt(mu_err**2+word(edtime2,9)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime



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
plot [0.001:0.003]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.002] fit(x) w lines ls 1
dtime=word(dtime2,10)-mu
edtime=sqrt(mu_err**2+word(edtime2,10)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime


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
plot [0.001:0.0022]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.002] fit(x) w lines ls 1
dtime=word(dtime2,11)-mu
edtime=sqrt(mu_err**2+word(edtime2,11)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime


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
dtime=word(dtime2,12)-mu
edtime=sqrt(mu_err**2+word(edtime2,12)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime


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
dtime=word(dtime2,13)-mu
edtime=sqrt(mu_err**2+word(edtime2,13)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime


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
dtime=word(dtime2,14)-mu
edtime=sqrt(mu_err**2+word(edtime2,14)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime


#fit for U=17.03
A=0.6
B=0.02
U=-0.34
mu=0.00125
sig=7*10**(-6)
lam=500


file=word(filelist,15)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.0025] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.0025]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.0005:0.0025] fit(x) w lines ls 1
dtime=word(dtime2,15)-mu
edtime=sqrt(mu_err**2+word(edtime2,15)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime


#fit for U=18.06
A=0.6
B=0.01
U=-0.34
mu=0.00125
sig=7*10**(-6)
lam=3000


file=word(filelist,16)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [0.001:0.0022] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.0025]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.0016] fit(x) w lines ls 1
dtime=word(dtime2,16)-mu
edtime=sqrt(mu_err**2+word(edtime2,16)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime


#fit for U=18.06
A=0.6
B=0.01
U=-0.34
mu=0.00125
sig=7*10**(-6)
lam=3000


file=word(filelist,17)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [0.0005:0.0026] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot [0.0005:0.0025]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.0016] fit(x) w lines ls 1
dtime=word(dtime2,17)-mu
edtime=sqrt(mu_err**2+word(edtime2,17)**2)
print file[:voltage],"\t",B,"\t",B_err,"\t",dtime,"\t",edtime







#fit for U=29.0
#A=0.6
#B=0.01
#U=-0.34
#mu=0.0005
#sig=7*10**(-6)
#lam=3000


#file=word(filelist,27)
#voltage=strlen(file)-5
#set output '../results/'.file[:voltage].'_test.svg'
#fit [0.0003:0.0012] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
#plot [0.0003:0.0013]'../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
#	 [0.0004:0.001] fit(x) w lines ls 1
#print file[:voltage],"\t",B,"\t",B_err


################################################## Print end results					 #####################################################




set output '../results/fitresults.svg'
plot [2:12] '../results/fitresults.txt' u 1:2:3 w yerrorbars pt 1 ps 1 lc rgb '#dd181f' title "Fitresults"