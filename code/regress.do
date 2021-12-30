use "C:\Users\user\Desktop\주혜\2021-2\패널데이터\과제4\ass4.dta" ,clear

keep hhidpn wght5-empr10




reshape long wght wghth cesd cesds cover age male black nohisp hispanic highsc collg marr sd wid cendiv month disab retr unemp work incm med wealth hp empr, i(hhidpn) j(year)
sort hhidpn year


keep if (age>=60 & age <=70)


foreach v in age male black nohisp hispanic highsc collg marr sd wid cendiv  {
	drop if missing(`v')
}


drop if (med == 1 & age <65)




*** Treatment indicator ***
gen elig=(age>=65 & age!=.)

*** Intervention indicator ***
gen post=(year>=8 & year!=.)

*** DD term ***
gen elig_post=elig*post


gen ages = age^2


***table1***

tabstat cesd cover age male black nohisp hispanic highsc collg marr sd wid , by(elig) stat(mean semean) save

 
*** Year dummies ***
gen i2000=(year==5)
gen i2002=(year==6)
gen i2004=(year==7)
gen i2006=(year==8)
gen i2008=(year==9)
gen i2010=(year==10)


*** Treatment * year dummies ***
gen elig_2000=elig*i2000
gen elig_2002=elig*i2002
gen elig_2004=elig*i2004
gen elig_2006=elig*i2006
gen elig_2008=elig*i2008
gen elig_2010=elig*i2010




xtset hhidpn year
local fixed "i2000 i2002 i2004 i2008 i2010 cendiv5 cendiv6 cendiv7 cendiv9 cendiv10"
local covar "age ages male black nohisp hispanic highsc collg marr sd wid i.cendiv i.month"
local tt "elig_2000 elig_2002 elig_2004 elig_2006 elig_2008 elig_2010"
local ad "i.incm work retr unemp disab"




***table2***
reg cesd elig_post  elig post `covar'  , cluster(hhidpn)
outreg2 using reg2_as4, dec(3) word replace

reg cesd elig_post  elig post `covar' i.incm  , cluster(hhidpn)
outreg2 using reg2_as4_2, dec(3) word replace

reg cesd elig_post  elig post `covar' i.incm work retr unemp disab  , cluster(hhidpn)
outreg2 using reg2_as4_3, dec(3) word replace





***table3***


reg cesd i.elig##i.year `covar' , cluster(hhidpn)
outreg2 using reg3_as4, dec(3) word replace

reg cesd i.elig##i.year `covar' i.incm , cluster(hhidpn)
outreg2 using reg3_as4_2, dec(3) word replace

reg cesd i.elig##i.year `covar' i.incm work retr unemp disab  , cluster(hhidpn)
outreg2 using reg3_as4_3, dec(3) word replace
ttest elig_2004 == elig_2006
ttest elig_2004 == elig_2008
ttest elig_2004 == elig_2010


***table4***

reg cesds i.elig##i.year `covar' , cluster(hhidpn)
outreg2 using reg4_as4, dec(3) word replace

reg cesds i.elig##i.year `covar' i.incm, cluster(hhidpn)
outreg2 using reg4_as4_2, dec(3) word replace

reg cesds i.elig##i.year `covar' i.incm work retr unemp disab , cluster(hhidpn)
outreg2 using reg4_as4_3, dec(3) word replace




***table5***
reg cesd cover  elig post `covar'  , cluster(hhidpn)
outreg2 using reg5_as4, dec(3) word replace

reg cesd elig_post elig post `covar', cluster(hhidpn) first
outreg2 using reg5_as4_1, dec(3) word replace

ivreg2 y (cover = elig_post) elig post `covar', cluster(hhidpn) first
outreg2 using reg5_as4_2, dec(3) word replace



***table9***


gen post_we = post*wealth
gen post_inc = post*incm
gen post_work = post*work
gen post_unp = post*unemp
gen post_retr = post*retr
gen post_disa = post*disab
gen post_mar = post*marr
gen post_sd = post*sd
gen post_wid = post*wid
gen post_hp= post*hp
gen post_empr = post*empr


gen elig_we = elig*wealth
gen elig_inc = elig*incm
gen elig_work = elig*work
gen elig_unp = elig*unemp
gen elig_retr = elig*retr
gen elig_disa = elig*disab
gen elig_mar = elig*marr
gen elig_sd = elig*sd
gen elig_wid = elig*wid
gen elig_hp= elig*hp
gen elig_empr = elig*empr


local postva "post_disa post_inc post_mar post_retr post_sd post_unp post_we post_wid post_work post_hp post_empr"


local eligva "elig_disa elig_inc elig_mar elig_retr elig_sd elig_unp elig_we elig_wid elig_work elig_hp elig_empr"




reg cesd elig_post  elig post `covar'  , cluster(hhidpn)
reg cesd elig_post  elig post c.year `covar'  , cluster(hhidpn)
reg cesd elig_post  elig post c.year wealth `covar'  , cluster(hhidpn)
reg cesd elig_post  elig post c.year wealth `covar' empr hp  , cluster(hhidpn)
reg cesd elig_post  elig post c.year wealth `postva' `covar'  , cluster(hhidpn)
reg cesd elig_post  elig post c.year wealth `eligva' `covar'  , cluster(hhidpn)
