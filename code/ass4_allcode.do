***RAW DATA***

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


***MERGE***
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



***VARIABLE***

use "C:\Users\user\Desktop\주혜\2021-2\패널데이터\과제4\ass4.dta" ,clear


destring *, replace




***Coverage***

rename hn175 r6drug
rename jn175 r7drug
rename kn175 r8drug
rename ln175 r9drug
rename mn175 r10drug


rename hn176 r6cover
rename jn176 r7cover
rename kn176 r8cover
rename ln176 r9cover
rename mn176 r10cover



*** sampling weight ***
forv i=5/10 {
	gen wght`i'=r`i'wtresp
	gen wghth`i'=r`i'wthh
}



***CESD***

forv i=5/10{
	gen cesd`i' = r`i'cesd
	
}


***CESD4***

forv i=5/10{
	gen cesds`i' = .
	replace cesds`i' = 1 if(r`i'cesd >= 4)
	replace cesds`i' = 0 if(r`i'cesd < 4)
}



***coverage***


forv i =6/10{
	gen cover`i' = .
	replace cover`i' = 1 if (r`i'cover == 1 | r`i'cover ==2 |r`i'cover ==3)
	replace cover`i' = 0 if (r`i'cover == 5)
}


*** Age ***
forv i=5/10 {
	gen age`i'=r`i'agey_b
}



*** Gender ***
forv i=5/10 {
	gen male`i'=1 if(ragender==1)
	replace male`i'=0 if (ragender ==2)
}


***Non-Hispanic Black***
forv i=5/10{
	gen black`i' = 1 if (raracem == 2 & rahispan == 0)
	replace black`i' =0 if (raracem == 1 | raracem == 3 | rahispan ==1)
}


***Other non-Hispanic race ***
forv i=5/10{
	gen nohisp`i' =1 if (raracem ==3 & rahispan == 0)
	replace nohisp`i' = 0 if (rahispan == 1 | raracem ==1 | raracem ==2)
}



*** Hispanic ***
forv i=5/10{
	gen hispanic`i' = .
	replace hispanic`i' = 1 if (rahispan ==1)
	replace hispanic`i' = 0 if (rahispan ==0)
}


***Highschool graduate***

forv i=5/10{
	gen highsc`i' = 1 if(raeduc == 3)
	replace highsc`i' = 0 if (raeduc < 3 | raeduc > 3)
}


***College or higher***


forv i=5/10{
	gen collg`i' = 1 if (raeduc == 4 | raeduc ==5)
	replace collg`i' = 0 if (raeduc < 4)
}







***Marital status***
forv i=5/10{
	gen marr`i'=1 if (r`i'mstat == 1 )
	replace marr`i'=0 if (r`i'mstat > 1)
	gen sd`i'=1 if (r`i'mstat ==4 | r`i'mstat==5 | r`i'mstat ==6 )
	replace sd`i'=0 if (r`i'mstat < 4 | r`i'mstat >= 7 )
	gen wid`i'=1 if ( r`i'mstat==7)
	replace wid`i'=0 if  (r`i'mstat<7 |  r`i'mstat==8)

}




***cendiv***

forv i=5/10{
	gen cendiv`i' =r`i'cendiv
}

***interview month***

forv i=5/10{
	gen month`i' =r`i'iwendm
}






***labor force***

forv i=5/10{
	gen work`i' = 1 if (r`i'lbrf==1| r`i'lbrf ==2)
	replace work`i' =0 if (r`i'lbrf>2)
	gen retr`i'= 1 if (r`i'lbrf==4|r`i'lbrf==5)
	replace retr`i' = 0 if (r`i'lbrf<4 | r`i'lbrf >=5)
	gen unemp`i'=1 if(r`i'lbrf==3)
	replace unemp`i' =0 if (r`i'lbrf<3 | r`i'lbrf>3)
	gen disab`i'=1 if (r`i'lbrf ==6)
	replace disab`i' =0 if (r`i'lbrf <6 | r`i'lbrf ==7)
}








***income***

forv i=5/10{
	xtile incm`i' = h`i'itot, nq(5) 
}


***medicare***

forv i=5/10{
	gen med`i' =r`i'govmr
}






***total household wealth***
forv i=5/10{
	gen wealth`i' = h`i'atotb
}

***ROBUST***

use "C:\Users\user\Desktop\주혜\2021-2\패널데이터\과제4\ass4.dta" ,clear




local y5m01c1 127.63
local y5m02c1 127.63
local y5m03c1 129.38
local y5m04c1 130.85
local y5m05c1 132.49
local y5m06c1 134.31
local y5m07c1 135.04
local y5m08c1 135.97
local y5m09c1 137.56
local y5m10c1 139.42
local y5m11c1 140.03
local y5m12c1 141.81
local y6m01c1 160.66
local y6m02c1 162.67
local y6m03c1 162.83
local y6m04c1 165.88
local y6m05c1 167.32
local y6m06c1 169.79
local y6m07c1 172.6
local y6m08c1 173.61
local y6m09c1 174.9
local y6m10c1 176.88
local y6m11c1 178.99
local y6m12c1 179.94
local y7m01c1 201.04
local y7m02c1 202.33
local y7m03c1 203.39
local y7m04c1 205.89
local y7m05c1 207.48
local y7m06c1 210.56
local y7m07c1 212.44
local y7m08c1 213.94
local y7m09c1 216.07
local y7m10c1 217.65
local y7m11c1 217.71
local y7m12c1 220.15
local y8m01c1 232.64
local y8m02c1 233.22
local y8m03c1 232.65
local y8m04c1 231.8
local y8m05c1 231.92
local y8m06c1 231.29
local y8m07c1 230.37
local y8m08c1 229.78
local y8m09c1 228.31
local y8m10c1 227.98
local y8m11c1 228.47
local y8m12c1 227.44
local y9m01c1 220.43
local y9m02c1 221.7
local y9m03c1 218.27
local y9m04c1 216.59
local y9m05c1 213.92
local y9m06c1 213.62
local y9m07c1 212.36
local y9m08c1 210.65
local y9m09c1 209.35
local y9m10c1 209.71
local y9m11c1 206.66
local y9m12c1 206.39
local y10m01c1 203.01
local y10m02c1 201.7
local y10m03c1 202.56
local y10m04c1 200.63
local y10m05c1 202.14
local y10m06c1 201.46
local y10m07c1 200.88
local y10m08c1 201.87
local y10m09c1 200.35
local y10m10c1 200.93
local y10m11c1 199.99
local y10m12c1 198.63
local y5m01c2 119.03
local y5m02c2 118.42
local y5m03c2 119.54
local y5m04c2 120.57
local y5m05c2 121
local y5m06c2 121.91
local y5m07c2 122.62
local y5m08c2 123.2
local y5m09c2 124.75
local y5m10c2 125.16
local y5m11c2 126.44
local y5m12c2 127.46
local y6m01c2 140.51
local y6m02c2 141.68
local y6m03c2 143.2
local y6m04c2 144.51
local y6m05c2 146.23
local y6m06c2 147.03
local y6m07c2 148.73
local y6m08c2 150.33
local y6m09c2 151.5
local y6m10c2 153.05
local y6m11c2 153.9
local y6m12c2 156.32
local y7m01c2 174.2
local y7m02c2 176.85
local y7m03c2 177.13
local y7m04c2 179.77
local y7m05c2 181.65
local y7m06c2 183.49
local y7m07c2 185.01
local y7m08c2 186.09
local y7m09c2 187.53
local y7m10c2 190.6
local y7m11c2 192.31
local y7m12c2 194.32
local y8m01c2 214.25
local y8m02c2 213.73
local y8m03c2 215.53
local y8m04c2 216.11
local y8m05c2 216.1
local y8m06c2 216.63
local y8m07c2 214.92
local y8m08c2 216.59
local y8m09c2 216.08
local y8m10c2 216.49
local y8m11c2 216.62
local y8m12c2 215.69
local y9m01c2 215.1
local y9m02c2 214.7
local y9m03c2 214.04
local y9m04c2 212.02
local y9m05c2 212.09
local y9m06c2 210.13
local y9m07c2 209.32
local y9m08c2 208.22
local y9m09c2 208.87
local y9m10c2 205.51
local y9m11c2 205.27
local y9m12c2 202.96
local y10m01c2 201.1
local y10m02c2 202.44
local y10m03c2 200.72
local y10m04c2 199.07
local y10m05c2 199.63
local y10m06c2 199.85
local y10m07c2 198.7
local y10m08c2 197.28
local y10m09c2 196.97
local y10m10c2 198.54
local y10m11c2 197.41
local y10m12c2 195.78
local y5m01c3 150.21
local y5m02c3 149.33
local y5m03c3 150.76
local y5m04c3 151.46
local y5m05c3 151.84
local y5m06c3 152.89
local y5m07c3 153.59
local y5m08c3 153.97
local y5m09c3 154.44
local y5m10c3 154.86
local y5m11c3 155.37
local y5m12c3 156.38
local y6m01c3 164.37
local y6m02c3 164.55
local y6m03c3 165.35
local y6m04c3 165.67
local y6m05c3 166.26
local y6m06c3 167.12
local y6m07c3 167.52
local y6m08c3 168.09
local y6m09c3 168.9
local y6m10c3 169.33
local y6m11c3 170.57
local y6m12c3 170.72
local y7m01c3 178.87
local y7m02c3 180.37
local y7m03c3 180.67
local y7m04c3 181.24
local y7m05c3 181.89
local y7m06c3 182.69
local y7m07c3 183.38
local y7m08c3 184.03
local y7m09c3 184.24
local y7m10c3 185.16
local y7m11c3 185.94
local y7m12c3 186.45
local y8m01c3 192.69
local y8m02c3 192.65
local y8m03c3 192.54
local y8m04c3 193.53
local y8m05c3 193.06
local y8m06c3 192.57
local y8m07c3 192.73
local y8m08c3 192.38
local y8m09c3 192.39
local y8m10c3 191.97
local y8m11c3 191.22
local y8m12c3 192.14
local y9m01c3 182.45
local y9m02c3 182.18
local y9m03c3 181.3
local y9m04c3 179.52
local y9m05c3 177.83
local y9m06c3 177.37
local y9m07c3 176.26
local y9m08c3 175.21
local y9m09c3 172.44
local y9m10c3 172.23
local y9m11c3 169.25
local y9m12c3 169.3
local y10m01c3 165.47
local y10m02c3 164.89
local y10m03c3 164.86
local y10m04c3 164.99
local y10m05c3 165.06
local y10m06c3 163.3
local y10m07c3 162.51
local y10m08c3 162.96
local y10m09c3 161
local y10m10c3 163.26
local y10m11c3 162.28
local y10m12c3 160.23
local y5m01c4 151.18
local y5m02c4 152.24
local y5m03c4 152.7
local y5m04c4 154.05
local y5m05c4 154.38
local y5m06c4 155.03
local y5m07c4 155.8
local y5m08c4 156.55
local y5m09c4 157.31
local y5m10c4 158.34
local y5m11c4 158.41
local y5m12c4 159.29
local y6m01c4 170.03
local y6m02c4 170.34
local y6m03c4 171.48
local y6m04c4 172.18
local y6m05c4 172.83
local y6m06c4 173.96
local y6m07c4 174.39
local y6m08c4 175.33
local y6m09c4 176.12
local y6m10c4 176.83
local y6m11c4 177.63
local y6m12c4 179.28
local y7m01c4 190.08
local y7m02c4 190.68
local y7m03c4 191.39
local y7m04c4 191.53
local y7m05c4 193.24
local y7m06c4 193.9
local y7m07c4 194.56
local y7m08c4 195.6
local y7m09c4 196.22
local y7m10c4 197.12
local y7m11c4 198.69
local y7m12c4 198.75
local y8m01c4 209.93
local y8m02c4 209.75
local y8m03c4 210.24
local y8m04c4 210.53
local y8m05c4 210.76
local y8m06c4 211.08
local y8m07c4 211.65
local y8m08c4 212.01
local y8m09c4 211.63
local y8m10c4 211.62
local y8m11c4 212.82
local y8m12c4 211.33
local y9m01c4 209.4
local y9m02c4 208.24
local y9m03c4 208.62
local y9m04c4 207.44
local y9m05c4 205.44
local y9m06c4 205.41
local y9m07c4 204.35
local y9m08c4 204.18
local y9m09c4 202.5
local y9m10c4 202.26
local y9m11c4 198.1
local y9m12c4 200.33
local y10m01c4 197.34
local y10m02c4 198.22
local y10m03c4 198.07
local y10m04c4 199.21
local y10m05c4 200.07
local y10m06c4 198.22
local y10m07c4 194.55
local y10m08c4 196.1
local y10m09c4 194.61
local y10m10c4 193.87
local y10m11c4 193.14
local y10m12c4 193
local y5m01c5 133.33
local y5m02c5 133.68
local y5m03c5 134.31
local y5m04c5 135.38
local y5m05c5 136
local y5m06c5 136.89
local y5m07c5 137.62
local y5m08c5 137.97
local y5m09c5 138.87
local y5m10c5 139.37
local y5m11c5 140.16
local y5m12c5 180.14
local y6m01c5 152.46
local y6m02c5 153.96
local y6m03c5 154.41
local y6m04c5 155.43
local y6m05c5 156.51
local y6m06c5 157.4
local y6m07c5 158.36
local y6m08c5 159.1
local y6m09c5 160.92
local y6m10c5 161.71
local y6m11c5 162.8
local y6m12c5 164.12
local y7m01c5 180.13
local y7m02c5 181.09
local y7m03c5 183.12
local y7m04c5 184.91
local y7m05c5 187.16
local y7m06c5 188.95
local y7m07c5 191.39
local y7m08c5 193.43
local y7m09c5 195.49
local y7m10c5 197.45
local y7m11c5 199.15
local y7m12c5 201.74
local y8m01c5 233.53
local y8m02c5 233.29
local y8m03c5 235.02
local y8m04c5 235.75
local y8m05c5 236.12
local y8m06c5 236.39
local y8m07c5 236.55
local y8m08c5 237.82
local y8m09c5 237.95
local y8m10c5 239.17
local y8m11c5 240.28
local y8m12c5 240.45
local y9m01c5 227.84
local y9m02c5 224.47
local y9m03c5 223.3
local y9m04c5 219.95
local y9m05c5 215.31
local y9m06c5 213.45
local y9m07c5 210.92
local y9m08c5 207.55
local y9m09c5 204.18
local y9m10c5 203.01
local y9m11c5 197.23
local y9m12c5 194.75
local y10m01c5 190.77
local y10m02c5 187.44
local y10m03c5 188.06
local y10m04c5 188.58
local y10m05c5 186.58
local y10m06c5 186.36
local y10m07c5 184.03
local y10m08c5 183.63
local y10m09c5 180.88
local y10m10c5 181.05
local y10m11c5 180.97
local y10m12c5 180.14
local y5m01c6 144.09
local y5m02c6 144.35
local y5m03c6 144.49
local y5m04c6 145.56
local y5m05c6 145.48
local y5m06c6 145.86
local y5m07c6 146.57
local y5m08c6 146.11
local y5m09c6 146.2
local y5m10c6 146.65
local y5m11c6 147.28
local y5m12c6 146.68
local y6m01c6 152.61
local y6m02c6 151.99
local y6m03c6 153.63
local y6m04c6 153.17
local y6m05c6 153.7
local y6m06c6 153.99
local y6m07c6 154.24
local y6m08c6 155.54
local y6m09c6 155.17
local y6m10c6 156.52
local y6m11c6 156.86
local y6m12c6 157.18
local y7m01c6 164.46
local y7m02c6 165.84
local y7m03c6 165.56
local y7m04c6 166.34
local y7m05c6 166.98
local y7m06c6 168.53
local y7m07c6 169.42
local y7m08c6 169.9
local y7m09c6 170.2
local y7m10c6 170.81
local y7m11c6 171.07
local y7m12c6 173.41
local y8m01c6 188.08
local y8m02c6 188.08
local y8m03c6 189.67
local y8m04c6 190.25
local y8m05c6 191.46
local y8m06c6 191.78
local y8m07c6 192.5
local y8m08c6 193.28
local y8m09c6 193.77
local y8m10c6 194.26
local y8m11c6 195.2
local y8m12c6 196.8
local y9m01c6 196.38
local y9m02c6 197.91
local y9m03c6 197.99
local y9m04c6 197.32
local y9m05c6 196.96
local y9m06c6 195.74
local y9m07c6 194.63
local y9m08c6 193.72
local y9m09c6 192.81
local y9m10c6 192.1
local y9m11c6 190.93
local y9m12c6 190.29
local y10m01c6 187.63
local y10m02c6 185.88
local y10m03c6 185.5
local y10m04c6 185.96
local y10m05c6 186.15
local y10m06c6 183.26
local y10m07c6 183.91
local y10m08c6 183.37
local y10m09c6 182.63
local y10m10c6 181.97
local y10m11c6 182.89
local y10m12c6 179.06
local y5m01c7 139.04
local y5m02c7 138.94
local y5m03c7 140.05
local y5m04c7 140.69
local y5m05c7 141.24
local y5m06c7 141.83
local y5m07c7 142.43
local y5m08c7 142.95
local y5m09c7 143.64
local y5m10c7 144.11
local y5m11c7 145.03
local y5m12c7 144.88
local y6m01c7 150.83
local y6m02c7 151.87
local y6m03c7 152.59
local y6m04c7 152.73
local y6m05c7 153.29
local y6m06c7 153.62
local y6m07c7 153.88
local y6m08c7 154.19
local y6m09c7 155.01
local y6m10c7 155.51
local y6m11c7 155.86
local y6m12c7 156.76
local y7m01c7 161.54
local y7m02c7 162.55
local y7m03c7 163.62
local y7m04c7 164.05
local y7m05c7 164.39
local y7m06c7 165.27
local y7m07c7 165.19
local y7m08c7 166.04
local y7m09c7 166.83
local y7m10c7 166.88
local y7m11c7 168.43
local y7m12c7 168.54
local y8m01c7 181.75
local y8m02c7 182.84
local y8m03c7 183.39
local y8m04c7 183.5
local y8m05c7 185.36
local y8m06c7 185.72
local y8m07c7 186.35
local y8m08c7 187.54
local y8m09c7 188.51
local y8m10c7 189.2
local y8m11c7 190.74
local y8m12c7 191.16
local y9m01c7 196.04
local y9m02c7 196.24
local y9m03c7 195.28
local y9m04c7 195.16
local y9m05c7 194.97
local y9m06c7 195.78
local y9m07c7 195.42
local y9m08c7 193.72
local y9m09c7 195.89
local y9m10c7 193.65
local y9m11c7 190.88
local y9m12c7 192.36
local y10m01c7 194.02
local y10m02c7 193.42
local y10m03c7 193.03
local y10m04c7 194.03
local y10m05c7 195.98
local y10m06c7 193.11
local y10m07c7 193.02
local y10m08c7 193.63
local y10m09c7 190.93
local y10m10c7 190.43
local y10m11c7 190.42
local y10m12c7 189.85
local y5m01c8 164.78
local y5m02c8 165.23
local y5m03c8 166.06
local y5m04c8 166.67
local y5m05c8 167.22
local y5m06c8 168.52
local y5m07c8 169.04
local y5m08c8 169.56
local y5m09c8 169.87
local y5m10c8 171.15
local y5m11c8 172.23
local y5m12c8 172.94
local y6m01c8 182.84
local y6m02c8 183.96
local y6m03c8 184.31
local y6m04c8 184.92
local y6m05c8 185.54
local y6m06c8 186.01
local y6m07c8 186.97
local y6m08c8 188.56
local y6m09c8 188.44
local y6m10c8 190.26
local y6m11c8 190.91
local y6m12c8 192.41
local y7m01c8 208.49
local y7m02c8 209.18
local y7m03c8 210.98
local y7m04c8 214.31
local y7m05c8 215.55
local y7m06c8 219.14
local y7m07c8 221.47
local y7m08c8 222.85
local y7m09c8 227.01
local y7m10c8 227.81
local y7m11c8 230.84
local y7m12c8 233.02
local y8m01c8 276.43
local y8m02c8 278.8
local y8m03c8 280.76
local y8m04c8 280.84
local y8m05c8 283.43
local y8m06c8 283.53
local y8m07c8 283.75
local y8m08c8 284.93
local y8m09c8 285.06
local y8m10c8 288.28
local y8m11c8 289.61
local y8m12c8 290.45
local y9m01c8 273.66
local y9m02c8 274.43
local y9m03c8 271.62
local y9m04c8 266.09
local y9m05c8 263.46
local y9m06c8 259.78
local y9m07c8 255.9
local y9m08c8 252.4
local y9m09c8 249.81
local y9m10c8 243.36
local y9m11c8 238.39
local y9m12c8 239.25
local y10m01c8 221.93
local y10m02c8 219.78
local y10m03c8 219.37
local y10m04c8 219.92
local y10m05c8 217.29
local y10m06c8 213.68
local y10m07c8 212.38
local y10m08c8 211.68
local y10m09c8 208.97
local y10m10c8 209.94
local y10m11c8 205.76
local y10m12c8 205.5
local y5m01c9 122.4
local y5m02c9 121.36
local y5m03c9 123
local y5m04c9 123.86
local y5m05c9 124.99
local y5m06c9 125.99
local y5m07c9 127.02
local y5m08c9 128.21
local y5m09c9 129.51
local y5m10c9 130.97
local y5m11c9 132.49
local y5m12c9 133.69
local y6m01c9 147.97
local y6m02c9 149.2
local y6m03c9 150.97
local y6m04c9 152.43
local y6m05c9 154.62
local y6m06c9 156.67
local y6m07c9 158.76
local y6m08c9 160.52
local y6m09c9 161.81
local y6m10c9 164.2
local y6m11c9 165.27
local y6m12c9 166.98
local y7m01c9 197.36
local y7m02c9 199.1
local y7m03c9 203.2
local y7m04c9 206.03
local y7m05c9 211.05
local y7m06c9 215.83
local y7m07c9 219.68
local y7m08c9 222.7
local y7m09c9 225.99
local y7m10c9 228.91
local y7m11c9 233.43
local y7m12c9 237.62
local y8m01c9 279.15
local y8m02c9 281.13
local y8m03c9 280.96
local y8m04c9 281.11
local y8m05c9 281.54
local y8m06c9 280.79
local y8m07c9 279.07
local y8m08c9 279.06
local y8m09c9 277.9
local y8m10c9 275.65
local y8m11c9 276.81
local y8m12c9 276.02
local y9m01c9 239.49
local y9m02c9 232.99
local y9m03c9 225.55
local y9m04c9 221
local y9m05c9 215.78
local y9m06c9 212.56
local y9m07c9 207.93
local y9m08c9 203.91
local y9m09c9 200.06
local y9m10c9 197.39
local y9m11c9 192.88
local y9m12c9 191.82
local y10m01c9 186.02
local y10m02c9 187.31
local y10m03c9 187.03
local y10m04c9 187.13
local y10m05c9 188.03
local y10m06c9 183.58
local y10m07c9 183.41
local y10m08c9 181.88
local y10m09c9 180.97
local y10m10c9 178.98
local y10m11c9 179.14
local y10m12c9 177.85

	


		
forv j=5/10{
	gen hp`j'=.
			
	forv i=1/9{
		replace hp`j' = `y`j'm01c`i'' if (month`j' == 1)
		replace hp`j' = `y`j'm02c`i'' if (month`j' == 2)
		replace hp`j' = `y`j'm03c`i'' if (month`j' == 3)
		replace hp`j' = `y`j'm04c`i'' if (month`j' == 4)
		replace hp`j' = `y`j'm05c`i'' if (month`j' == 5)
		replace hp`j' = `y`j'm06c`i'' if (month`j' == 6)
		replace hp`j' = `y`j'm07c`i'' if (month`j' == 7)
		replace hp`j' = `y`j'm08c`i'' if (month`j' == 8)
		replace hp`j' = `y`j'm09c`i'' if (month`j' == 9)
		replace hp`j' = `y`j'm10c`i'' if (month`j' == 10)
		replace hp`j' = `y`j'm11c`i'' if (month`j' == 11)
		replace hp`j' = `y`j'm12c`i'' if (month`j' == 12)
	}
	

}
		
	



local ey5m01c1 3
local ey5m02c1 2.9
local ey5m03c1 2.8
local ey5m04c1 2.8
local ey5m05c1 2.8
local ey5m06c1 2.7
local ey5m07c1 2.7
local ey5m08c1 2.7
local ey5m09c1 2.7
local ey5m10c1 2.7
local ey5m11c1 2.7
local ey5m12c1 2.8
local ey6m01c1 4.4
local ey6m02c1 4.5
local ey6m03c1 4.6
local ey6m04c1 4.6
local ey6m05c1 4.7
local ey6m06c1 4.8
local ey6m07c1 4.8
local ey6m08c1 4.9
local ey6m09c1 5
local ey6m10c1 5.1
local ey6m11c1 5.2
local ey6m12c1 5.3
local ey7m01c1 5.2
local ey7m02c1 5.1
local ey7m03c1 5.1
local ey7m04c1 5
local ey7m05c1 5
local ey7m06c1 4.9
local ey7m07c1 4.8
local ey7m08c1 4.8
local ey7m09c1 4.7
local ey7m10c1 4.7
local ey7m11c1 4.7
local ey7m12c1 4.7
local ey8m01c1 4.6
local ey8m02c1 4.5
local ey8m03c1 4.5
local ey8m04c1 4.5
local ey8m05c1 4.5
local ey8m06c1 4.5
local ey8m07c1 4.5
local ey8m08c1 4.6
local ey8m09c1 4.6
local ey8m10c1 4.5
local ey8m11c1 4.5
local ey8m12c1 4.5
local ey9m01c1 4.6
local ey9m02c1 4.6
local ey9m03c1 4.7
local ey9m04c1 4.8
local ey9m05c1 5
local ey9m06c1 5.2
local ey9m07c1 5.4
local ey9m08c1 5.6
local ey9m09c1 5.8
local ey9m10c1 6
local ey9m11c1 6.3
local ey9m12c1 6.7
local ey10m01c1 8.8
local ey10m02c1 8.7
local ey10m03c1 8.7
local ey10m04c1 8.6
local ey10m05c1 8.5
local ey10m06c1 8.4
local ey10m07c1 8.3
local ey10m08c1 8.3
local ey10m09c1 8.3
local ey10m10c1 8.3
local ey10m11c1 8.3
local ey10m12c1 8.2
local ey5m01c2 4.4
local ey5m02c2 4.3
local ey5m03c2 4.2
local ey5m04c2 4.2
local ey5m05c2 4.2
local ey5m06c2 4.2
local ey5m07c2 4.2
local ey5m08c2 4.2
local ey5m09c2 4.2
local ey5m10c2 4.2
local ey5m11c2 4.2
local ey5m12c2 4.2
local ey6m01c2 5.8
local ey6m02c2 5.9
local ey6m03c2 6
local ey6m04c2 6
local ey6m05c2 5.9
local ey6m06c2 5.9
local ey6m07c2 5.8
local ey6m08c2 5.8
local ey6m09c2 5.8
local ey6m10c2 5.9
local ey6m11c2 6
local ey6m12c2 6
local ey7m01c2 5.8
local ey7m02c2 5.8
local ey7m03c2 5.8
local ey7m04c2 5.7
local ey7m05c2 5.6
local ey7m06c2 5.5
local ey7m07c2 5.4
local ey7m08c2 5.4
local ey7m09c2 5.3
local ey7m10c2 5.2
local ey7m11c2 5.1
local ey7m12c2 5
local ey8m01c2 4.8
local ey8m02c2 4.7
local ey8m03c2 4.7
local ey8m04c2 4.7
local ey8m05c2 4.7
local ey8m06c2 4.7
local ey8m07c2 4.7
local ey8m08c2 4.6
local ey8m09c2 4.5
local ey8m10c2 4.5
local ey8m11c2 4.4
local ey8m12c2 4.3
local ey9m01c2 4.7
local ey9m02c2 4.8
local ey9m03c2 4.8
local ey9m04c2 4.9
local ey9m05c2 5
local ey9m06c2 5.2
local ey9m07c2 5.3
local ey9m08c2 5.5
local ey9m09c2 5.7
local ey9m10c2 6
local ey9m11c2 6.3
local ey9m12c2 6.7
local ey10m01c2 9
local ey10m02c2 9
local ey10m03c2 9
local ey10m04c2 8.9
local ey10m05c2 8.8
local ey10m06c2 8.7
local ey10m07c2 8.6
local ey10m08c2 8.6
local ey10m09c2 8.6
local ey10m10c2 8.6
local ey10m11c2 8.6
local ey10m12c2 8.5
local ey5m01c3 3.8
local ey5m02c3 3.7
local ey5m03c3 3.8
local ey5m04c3 3.8
local ey5m05c3 3.9
local ey5m06c3 3.9
local ey5m07c3 3.9
local ey5m08c3 3.9
local ey5m09c3 3.9
local ey5m10c3 3.9
local ey5m11c3 4
local ey5m12c3 4.1
local ey6m01c3 5.9
local ey6m02c3 6
local ey6m03c3 6
local ey6m04c3 6
local ey6m05c3 6
local ey6m06c3 6
local ey6m07c3 5.9
local ey6m08c3 5.9
local ey6m09c3 5.8
local ey6m10c3 5.9
local ey6m11c3 5.9
local ey6m12c3 6
local ey7m01c3 6.1
local ey7m02c3 6.1
local ey7m03c3 6.1
local ey7m04c3 6.1
local ey7m05c3 6.1
local ey7m06c3 6.1
local ey7m07c3 6.1
local ey7m08c3 6.1
local ey7m09c3 6.1
local ey7m10c3 6.1
local ey7m11c3 6.1
local ey7m12c3 6.1
local ey8m01c3 5.5
local ey8m02c3 5.4
local ey8m03c3 5.4
local ey8m04c3 5.3
local ey8m05c3 5.3
local ey8m06c3 5.3
local ey8m07c3 5.4
local ey8m08c3 5.4
local ey8m09c3 5.4
local ey8m10c3 5.4
local ey8m11c3 5.4
local ey8m12c3 5.3
local ey9m01c3 5.7
local ey9m02c3 5.7
local ey9m03c3 5.8
local ey9m04c3 5.9
local ey9m05c3 6.1
local ey9m06c3 6.3
local ey9m07c3 6.6
local ey9m08c3 6.8
local ey9m09c3 7
local ey9m10c3 7.3
local ey9m11c3 7.8
local ey9m12c3 8.3
local ey10m01c3 11.3
local ey10m02c3 11.2
local ey10m03c3 11.1
local ey10m04c3 10.9
local ey10m05c3 10.7
local ey10m06c3 10.5
local ey10m07c3 10.3
local ey10m08c3 10.2
local ey10m09c3 10
local ey10m10c3 9.9
local ey10m11c3 9.8
local ey10m12c3 9.6
local ey5m01c4 2.9
local ey5m02c4 2.9
local ey5m03c4 3
local ey5m04c4 3
local ey5m05c4 3
local ey5m06c4 3.1
local ey5m07c4 3.1
local ey5m08c4 3.2
local ey5m09c4 3.3
local ey5m10c4 3.3
local ey5m11c4 3.4
local ey5m12c4 3.5
local ey6m01c4 4.5
local ey6m02c4 4.6
local ey6m03c4 4.6
local ey6m04c4 4.6
local ey6m05c4 4.6
local ey6m06c4 4.6
local ey6m07c4 4.5
local ey6m08c4 4.5
local ey6m09c4 4.5
local ey6m10c4 4.5
local ey6m11c4 4.5
local ey6m12c4 4.6
local ey7m01c4 4.9
local ey7m02c4 4.9
local ey7m03c4 4.9
local ey7m04c4 4.9
local ey7m05c4 4.9
local ey7m06c4 5
local ey7m07c4 5
local ey7m08c4 5
local ey7m09c4 4.9
local ey7m10c4 4.9
local ey7m11c4 4.9
local ey7m12c4 4.9
local ey8m01c4 4.2
local ey8m02c4 4.2
local ey8m03c4 4.1
local ey8m04c4 4.1
local ey8m05c4 4
local ey8m06c4 4.1
local ey8m07c4 4.1
local ey8m08c4 4.1
local ey8m09c4 4.1
local ey8m10c4 4.2
local ey8m11c4 4.2
local ey8m12c4 4.1
local ey9m01c4 4.4
local ey9m02c4 4.4
local ey9m03c4 4.4
local ey9m04c4 4.5
local ey9m05c4 4.7
local ey9m06c4 4.8
local ey9m07c4 4.9
local ey9m08c4 5.1
local ey9m09c4 5.2
local ey9m10c4 5.5
local ey9m11c4 5.8
local ey9m12c4 6.1
local ey10m01c4 7.5
local ey10m02c4 7.5
local ey10m03c4 7.4
local ey10m04c4 7.3
local ey10m05c4 7.2
local ey10m06c4 7.2
local ey10m07c4 7.1
local ey10m08c4 7.1
local ey10m09c4 7.2
local ey10m10c4 7.2
local ey10m11c4 7.1
local ey10m12c4 7.1
local ey5m01c5 3.5
local ey5m02c5 3.5
local ey5m03c5 3.5
local ey5m04c5 3.5
local ey5m05c5 3.6
local ey5m06c5 3.6
local ey5m07c5 3.6
local ey5m08c5 3.6
local ey5m09c5 3.6
local ey5m10c5 3.6
local ey5m11c5 3.6
local ey5m12c5 3.6
local ey6m01c5 5.5
local ey6m02c5 5.5
local ey6m03c5 5.5
local ey6m04c5 5.5
local ey6m05c5 5.4
local ey6m06c5 5.4
local ey6m07c5 5.3
local ey6m08c5 5.3
local ey6m09c5 5.3
local ey6m10c5 5.3
local ey6m11c5 5.3
local ey6m12c5 5.3
local ey7m01c5 4.9
local ey7m02c5 4.9
local ey7m03c5 4.9
local ey7m04c5 4.9
local ey7m05c5 4.9
local ey7m06c5 4.8
local ey7m07c5 4.8
local ey7m08c5 4.8
local ey7m09c5 4.8
local ey7m10c5 4.8
local ey7m11c5 4.8
local ey7m12c5 4.8
local ey8m01c5 4.1
local ey8m02c5 4.1
local ey8m03c5 4
local ey8m04c5 4
local ey8m05c5 4.1
local ey8m06c5 4.1
local ey8m07c5 4.1
local ey8m08c5 4.1
local ey8m09c5 4.1
local ey8m10c5 4.1
local ey8m11c5 4.1
local ey8m12c5 4
local ey9m01c5 4.6
local ey9m02c5 4.7
local ey9m03c5 4.8
local ey9m04c5 5
local ey9m05c5 5.2
local ey9m06c5 5.4
local ey9m07c5 5.7
local ey9m08c5 5.9
local ey9m09c5 6.2
local ey9m10c5 6.5
local ey9m11c5 7.2
local ey9m12c5 7.7
local ey10m01c5 10.2
local ey10m02c5 10.2
local ey10m03c5 10.1
local ey10m04c5 10
local ey10m05c5 9.9
local ey10m06c5 9.8
local ey10m07c5 9.8
local ey10m08c5 9.8
local ey10m09c5 9.8
local ey10m10c5 9.8
local ey10m11c5 9.8
local ey10m12c5 9.7
local ey5m01c6 4.4
local ey5m02c6 4.3
local ey5m03c6 4.3
local ey5m04c6 4.3
local ey5m05c6 4.4
local ey5m06c6 4.4
local ey5m07c6 4.4
local ey5m08c6 4.4
local ey5m09c6 4.4
local ey5m10c6 4.4
local ey5m11c6 4.4
local ey5m12c6 4.4
local ey6m01c6 5.9
local ey6m02c6 5.9
local ey6m03c6 5.8
local ey6m04c6 5.8
local ey6m05c6 5.7
local ey6m06c6 5.6
local ey6m07c6 5.6
local ey6m08c6 5.5
local ey6m09c6 5.5
local ey6m10c6 5.6
local ey6m11c6 5.6
local ey6m12c6 5.6
local ey7m01c6 5.6
local ey7m02c6 5.6
local ey7m03c6 5.6
local ey7m04c6 5.5
local ey7m05c6 5.5
local ey7m06c6 5.5
local ey7m07c6 5.5
local ey7m08c6 5.5
local ey7m09c6 5.6
local ey7m10c6 5.6
local ey7m11c6 5.6
local ey7m12c6 5.6
local ey8m01c6 5.5
local ey8m02c6 5.4
local ey8m03c6 5.3
local ey8m04c6 5.3
local ey8m05c6 5.3
local ey8m06c6 5.3
local ey8m07c6 5.3
local ey8m08c6 5.2
local ey8m09c6 5.2
local ey8m10c6 5.1
local ey8m11c6 5
local ey8m12c6 4.9
local ey9m01c6 5.2
local ey9m02c6 5.3
local ey9m03c6 5.5
local ey9m04c6 5.7
local ey9m05c6 5.9
local ey9m06c6 6.1
local ey9m07c6 6.4
local ey9m08c6 6.6
local ey9m09c6 6.9
local ey9m10c6 7.2
local ey9m11c6 7.7
local ey9m12c6 8.2
local ey10m01c6 10.7
local ey10m02c6 10.7
local ey10m03c6 10.5
local ey10m04c6 10.3
local ey10m05c6 10.1
local ey10m06c6 9.9
local ey10m07c6 9.8
local ey10m08c6 9.8
local ey10m09c6 9.8
local ey10m10c6 9.9
local ey10m11c6 9.9
local ey10m12c6 9.9
local ey5m01c7 4.6
local ey5m02c7 4.5
local ey5m03c7 4.5
local ey5m04c7 4.4
local ey5m05c7 4.4
local ey5m06c7 4.3
local ey5m07c7 4.3
local ey5m08c7 4.3
local ey5m09c7 4.2
local ey5m10c7 4.2
local ey5m11c7 4.2
local ey5m12c7 4.2
local ey6m01c7 5.9
local ey6m02c7 6
local ey6m03c7 6
local ey6m04c7 6
local ey6m05c7 6
local ey6m06c7 6
local ey6m07c7 6
local ey6m08c7 6
local ey6m09c7 6
local ey6m10c7 6.1
local ey6m11c7 6.2
local ey6m12c7 6.2
local ey7m01c7 6.1
local ey7m02c7 6
local ey7m03c7 6
local ey7m04c7 5.9
local ey7m05c7 5.9
local ey7m06c7 5.8
local ey7m07c7 5.7
local ey7m08c7 5.7
local ey7m09c7 5.6
local ey7m10c7 5.6
local ey7m11c7 5.6
local ey7m12c7 5.6
local ey8m01c7 5.1
local ey8m02c7 5
local ey8m03c7 5
local ey8m04c7 4.9
local ey8m05c7 4.9
local ey8m06c7 4.9
local ey8m07c7 4.8
local ey8m08c7 4.7
local ey8m09c7 4.7
local ey8m10c7 4.6
local ey8m11c7 4.5
local ey8m12c7 4.5
local ey9m01c7 4.3
local ey9m02c7 4.3
local ey9m03c7 4.3
local ey9m04c7 4.3
local ey9m05c7 4.4
local ey9m06c7 4.5
local ey9m07c7 4.7
local ey9m08c7 4.9
local ey9m09c7 5.1
local ey9m10c7 5.3
local ey9m11c7 5.5
local ey9m12c7 5.8
local ey10m01c7 8
local ey10m02c7 8
local ey10m03c7 8
local ey10m04c7 7.9
local ey10m05c7 7.9
local ey10m06c7 7.8
local ey10m07c7 7.8
local ey10m08c7 7.8
local ey10m09c7 7.9
local ey10m10c7 7.9
local ey10m11c7 8
local ey10m12c7 7.9
local ey5m01c8 3.8
local ey5m02c8 3.7
local ey5m03c8 3.7
local ey5m04c8 3.7
local ey5m05c8 3.7
local ey5m06c8 3.8
local ey5m07c8 3.8
local ey5m08c8 3.8
local ey5m09c8 3.8
local ey5m10c8 3.8
local ey5m11c8 3.8
local ey5m12c8 3.8
local ey6m01c8 5.6
local ey6m02c8 5.7
local ey6m03c8 5.7
local ey6m04c8 5.8
local ey6m05c8 5.7
local ey6m06c8 5.7
local ey6m07c8 5.7
local ey6m08c8 5.7
local ey6m09c8 5.6
local ey6m10c8 5.7
local ey6m11c8 5.7
local ey6m12c8 5.7
local ey7m01c8 5.4
local ey7m02c8 5.3
local ey7m03c8 5.3
local ey7m04c8 5.2
local ey7m05c8 5.1
local ey7m06c8 5.1
local ey7m07c8 5
local ey7m08c8 4.9
local ey7m09c8 4.9
local ey7m10c8 4.9
local ey7m11c8 4.8
local ey7m12c8 4.8
local ey8m01c8 4.2
local ey8m02c8 4.1
local ey8m03c8 4.1
local ey8m04c8 4
local ey8m05c8 4
local ey8m06c8 4
local ey8m07c8 4
local ey8m08c8 3.9
local ey8m09c8 3.9
local ey8m10c8 3.8
local ey8m11c8 3.7
local ey8m12c8 3.6
local ey9m01c8 4
local ey9m02c8 4.1
local ey9m03c8 4.2
local ey9m04c8 4.4
local ey9m05c8 4.6
local ey9m06c8 4.9
local ey9m07c8 5.1
local ey9m08c8 5.3
local ey9m09c8 5.6
local ey9m10c8 5.9
local ey9m11c8 6.2
local ey9m12c8 6.8
local ey10m01c8 9.6
local ey10m02c8 9.7
local ey10m03c8 9.7
local ey10m04c8 9.7
local ey10m05c8 9.6
local ey10m06c8 9.6
local ey10m07c8 9.5
local ey10m08c8 9.5
local ey10m09c8 9.6
local ey10m10c8 9.6
local ey10m11c8 9.5
local ey10m12c8 9.5
local ey5m01c9 5
local ey5m02c9 5
local ey5m03c9 5
local ey5m04c9 5
local ey5m05c9 5
local ey5m06c9 5
local ey5m07c9 5
local ey5m08c9 5
local ey5m09c9 4.9
local ey5m10c9 4.9
local ey5m11c9 4.9
local ey5m12c9 4.9
local ey6m01c9 6.7
local ey6m02c9 6.8
local ey6m03c9 6.8
local ey6m04c9 6.8
local ey6m05c9 6.8
local ey6m06c9 6.8
local ey6m07c9 6.8
local ey6m08c9 6.8
local ey6m09c9 6.8
local ey6m10c9 6.8
local ey6m11c9 6.9
local ey6m12c9 6.9
local ey7m01c9 6.6
local ey7m02c9 6.6
local ey7m03c9 6.5
local ey7m04c9 6.5
local ey7m05c9 6.4
local ey7m06c9 6.3
local ey7m07c9 6.2
local ey7m08c9 6.1
local ey7m09c9 6.1
local ey7m10c9 6
local ey7m11c9 5.9
local ey7m12c9 5.9
local ey8m01c9 5
local ey8m02c9 5
local ey8m03c9 4.9
local ey8m04c9 4.9
local ey8m05c9 4.9
local ey8m06c9 4.9
local ey8m07c9 4.9
local ey8m08c9 4.9
local ey8m09c9 4.9
local ey8m10c9 4.9
local ey8m11c9 4.9
local ey8m12c9 4.8
local ey9m01c9 5.6
local ey9m02c9 5.7
local ey9m03c9 5.8
local ey9m04c9 6
local ey9m05c9 6.3
local ey9m06c9 6.5
local ey9m07c9 6.8
local ey9m08c9 7.1
local ey9m09c9 7.4
local ey9m10c9 7.8
local ey9m11c9 8.3
local ey9m12c9 8.8
local ey10m01c9 11.8
local ey10m02c9 11.8
local ey10m03c9 11.8
local ey10m04c9 11.7
local ey10m05c9 11.6
local ey10m06c9 11.6
local ey10m07c9 11.5
local ey10m08c9 11.6
local ey10m09c9 11.6
local ey10m10c9 11.6
local ey10m11c9 11.6
local ey10m12c9 11.5



forv j=5/10{
	gen empr`j'=.
			
	forv i=1/9{
		replace empr`j' = `ey`j'm01c`i'' if (month`j' == 1)
		replace empr`j' = `ey`j'm02c`i'' if (month`j' == 2)
		replace empr`j' = `ey`j'm03c`i'' if (month`j' == 3)
		replace empr`j' = `ey`j'm04c`i'' if (month`j' == 4)
		replace empr`j' = `ey`j'm05c`i'' if (month`j' == 5)
		replace empr`j' = `ey`j'm06c`i'' if (month`j' == 6)
		replace empr`j' = `ey`j'm07c`i'' if (month`j' == 7)
		replace empr`j' = `ey`j'm08c`i'' if (month`j' == 8)
		replace empr`j' = `ey`j'm09c`i'' if (month`j' == 9)
		replace empr`j' = `ey`j'm10c`i'' if (month`j' == 10)
		replace empr`j' = `ey`j'm11c`i'' if (month`j' == 11)
		replace empr`j' = `ey`j'm12c`i'' if (month`j' == 12)
	}
	

}
		
		
***REGRESS***

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



