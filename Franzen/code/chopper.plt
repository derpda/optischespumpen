#script to analyse the chopper signal modification
reset

################################################## Settings							 #####################################################

#terminal options and styling
set terminal svg size 1024,576 fname 'Verdana' fsize 12
set border linewidth 1.5
#set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 3
#pointtitle="Data points"
#set fit errorvariables


#Fermie curve
F(x)=A/(1+exp((mu-x)/sig))+U

################################################## Main								 #####################################################

set output '../results/chopper/test.svg'

A=0.8
U=-0.3
mu=0.00128
sig=10*10**(-6)


fit [0.00125:] F(x) '../data/chopper/10.0V.tab' u ($1+0.00123):($2*0.45-0.05) via A,U,mu,sig
plot '../data/chopper/10.0V.tab' u ($1+0.00123):($2*0.45-0.05),F(x) #, '../data/main/10.03V.tab' u 1:2