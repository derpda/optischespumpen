#this script should determine the darktime and according

#del old fit log
system("DEL fit.log")

################################################## Settings							 #####################################################

#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 12
set border linewidth 1.5
set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 3
pointtitle="Data points"
set fit errorvariables



################################################## Plot function					 #####################################################

#Fermie curve
F(x)=A/(1+exp((mu-x)/sig))

#exponential for dent
E(x)=(1-exp(-lam*(x-(mu-sig*log(99)))))

#fit function
fit(x)=F(x)*E(x)+U


################################################## Main loop						 #####################################################

filelist=system('dir /B ..\\data\\main')
Nfiles=words(filelist)

do for [i = 1:Nfiles] {
	file=word(filelist,i)
	voltage=strlen(file)-5
	set output '../results/'.file[:voltage].'.svg'
	plot '../data/main/'.file u 1:2
}


#fit for U=3.9
A=0.645
U=-0.31
mu=0.0035
sig=10*10**(-6)
lam=5000

file=word(filelist,1)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
#fit [0.000348:0.008] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot '../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.008] fit(x) w lines ls 1,\
	[0.003:0.008] F(x), [0.0035:0.008] E(x)




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
plot '../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.003:0.01] fit(x) w lines ls 1


	 

#fit for U=5.00
A=0.7
B=0.08
U=-0.34
mu=0.005
sig=17*10**(-6)
lam=1000

file=word(filelist,3)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.008] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot '../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.008] fit(x) w lines ls 1





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
plot '../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.002:0.006] fit(x) w lines ls 1

	 



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
plot '../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.006] fit(x) w lines ls 1




	 
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
plot '../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.006] fit(x) w lines ls 1





#fit for U=9.05
A=0.59
B=0.08
U=-0.33
mu=0.0013
sig=10*10**(-6)
lam=4000


file=word(filelist,7)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
fit [:0.006] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot '../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.006] fit(x) w lines ls 1




#fit for U=10.03
A=0.7
B=0.01
U=-0.34
mu=0.0013
sig=17*10**(-6)
lam=2000


file=word(filelist,8)
voltage=strlen(file)-5
set output '../results/'.file[:voltage].'_test.svg'
#fit [:0.006] fit(x) '../data/main/'.file u 1:2 via A,B,U,mu,sig,lam
plot '../data/main/'.file u 1:2 pt 1 ps 1 lc rgb '#dd181f',\
	 [0.001:0.006] fit(x) w lines ls 1