* Setup
sysuse auto.dta, clear

* For the numeric variable
levelsof2 rep78
levelsof2 rep78, missing
levelsof2 rep78, local(rep78_uni)
levelsof2 rep78, unique(rep78_uni)
levelsof2 rep78, unique(rep78_uni) frequency(rep78_freq)
return list

* For the string variable
levelsof2 make
levelsof2 make, missing
levelsof2 make, local(make_uni)
levelsof2 make, unique(make_uni)
levelsof2 make, unique(make_uni) frequency(make_freq)
return list

