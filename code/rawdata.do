//2002
clear all
infile using c:\hrs2002\stata\H02N_R.dct
egen hhidpn=concat(HHID PN)
order hhidpn
drop HHID PN
destring *, replace
rename *, lower
keep hhidpn hn175 hn176
save c:\hrs2002\stata\H02N_R_m.dta, replace

***2004***
clear all
infile using c:\hrs2004\stata\H04N_R.dct
egen hhidpn=concat(HHID PN)
order hhidpn
drop HHID PN
destring *, replace
rename *, lower
keep hhidpn jn175 jn176
save c:\hrs2004\stata\H04N_R_m.dta, replace

*** 2006 ***
clear all
infile using c:\hrs2006\stata\H06N_R.dct
egen hhidpn=concat(HHID PN)
order hhidpn
drop HHID PN
destring *, replace
rename *, lower
keep hhidpn kn175 kn176
save c:\hrs2006\stata\H06N_R_m.dta, replace



*** 2008 ***
clear all
infile using c:\hrs2008\stata\H08N_R.dct
egen hhidpn=concat(HHID PN)
order hhidpn
drop HHID PN
destring *, replace
rename *, lower
keep hhidpn ln175 ln176
save c:\hrs2008\stata\H08N_R_m.dta, replace


//2010
clear all
infile using c:\hrs2010\stata\H10N_R.dct
egen hhidpn=concat(HHID PN)
order hhidpn
drop HHID PN
destring *, replace
rename *, lower
keep hhidpn mn175 mn176
save c:\hrs2010\stata\H10N_R_m.dta, replace