use "C:\Users\user\Desktop\주혜\2021-2\패널데이터\statapractice\randhrs1992_2018v1.dta", clear
destring *, replace

merge 1:1 hhidpn using "c:\hrs2002\stata\H02N_R_m.dta"
drop _merge
merge 1:1 hhidpn using "c:\hrs2004\stata\H04N_R_m.dta"
drop _merge
merge 1:1 hhidpn using "c:\hrs2006\stata\H06N_R_m.dta"
drop _merge
merge 1:1 hhidpn using "c:\hrs2008\stata\H08N_R_m.dta"
drop _merge
merge 1:1 hhidpn using "c:\hrs2010\stata\H10N_R_m.dta"
drop _merge