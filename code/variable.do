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



