cd "/Users/AimyCroner/Desktop/RRWM2"

**importing the data set 

import delimited "GSS.csv", clear

****Data Cleaning****

**dependent variable
gen health = srh_110

**independent variables 

*marital status 

gen marital = marstat

*age 
gen age = agec

*sex

gen sexa = sex

*worked at job or business last week 

gen employ = lmam_01

*education

gen edu = ehg3_01b 

*income of respondent 

gen income = ttlincg2 

*droppping respondents aged over 64 

drop if age > 64
tab age

save gss2.dta

***cleaning dependent variable
tab health, m

**drop missings 7, 8, 9

drop if health == 7
drop if health == 8
drop if health == 9
tab health,m

**label categories
label define health 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor"
label values health health 
tab health

**new dependent variable for health 

gen health2 = health

replace health2 = 4 if health == 5
tab health2

label define health2 1 "Excellent" 2 "Very good" 3 "Good" 4 "Not Good"
label values health2 health2
tab health2

***cleaning independent variables*** 

**marital status 

*drop missings (97, 98)

drop if marital == 97
drop if marital == 98
tab marital

*creating new categories 

gen marital2 = marital 

*partnered category combining married and living common law 
replace marital2 = 1 if marital == 2
tab marital2

*other catgeoyr combining widowed, separated, divorced 
replace marital2 = 3 if marital == 4
replace marital2 = 3 if marital == 5
tab marital2

*single never married numered as 2 instead of 6 

replace marital2 = 2 if marital == 6
tab marital2 

*label categories 

label define marital2 1 "Partenered" 2 "Single, never married" 3 "Other"
label values marital2 marital2
tab marital2

**age 
tab age, m

*creating categories 

gen agegroup = age

replace agegroup = 1 if age >= 15 & age <= 24
replace agegroup = 2 if age >= 25 & age <=34
replace agegroup = 3 if age >= 35 & age <= 44
replace agegroup = 4 if age >= 45 & age <= 54
replace agegroup = 5 if age >= 55 & age <=64

tab agegroup

label define agegroup 1 "15-24 (Youth)" 2 "25-34 (Young Adults)" 3 "35-44 (Middle-aged Adults)" 4 "45-54 (Senior adults)" 5 "55-64 (Pre-retirement adults)"
label values agegroup agegroup
tab agegroup

*confirming there are no missing variables for sex variable 
tab sexa, m 

*labelling categories 

label define sexa 1 "Male" 2 "Female"
label values sexa sexa
tab sexa

*confirming there are no missings for employment 

tab employ, m 

*labelling categories 

label define employ 1 "Yes" 2 "No"
label values employ employ 
tab employ

*dropping missings from employment

drop if employ >= 7
tab employ, m

*confirming there are no missings for education 

tab edu, m 

*labelling categories 

label define edu 1 "Less than HS" 2 "HS or equivalent" 3 "Trade" 4 "College" 5 "Uni below bach" 6 "Bachelor's" 7 "Above bach"
label values edu edu 
tab edu 

*dropping missings 

drop if edu >=97
tab edu, m

*confirming no missings for income 

tab income, m 

*labelling categories 

label define income 1 "less than 25k" 2 "25-49" 3 "50-74" 4 "75-99" 5 "100-124" 6 "125+"
label values income income 
tab income 

save gss2.dta, replace

*Table 1: summary descriptives tables 
tab1 health2 marital2 agegroup sexa employ edu income 

sum i.health2 i.marital2 i.agegroup i.sexa i.employ i.edu i.income

**Which IVs have more effect on health / bivariate analyses

*Table 1: cross tab of health and marital status 
tab marital2 health2 , chi2 row 

*Table 2: cross tab of agegroup and health 
tab agegroup health2, chi2 row

*Table 3: cross tab of sex and health 
tab sexa health2, chi2 row

*Table 4: cross tab of employment and health 
tab employ health2, chi2 row

*Table 5: cross tab of education and health 
tab edu health2, chi2 row

*Table 6: cross tab of income by and health 
tab income health2, chi2 row

**Multivariate analyses 

*Regression1 1: ordinal logistics regression of health on marital status and education 

ologit health2 i.marital2 i.edu, or

*Regression 2: ordinal logisitc regression of health against all IVs

ologit health2 i.marital2 i.agegroup i.sexa i.employ i.edu i.income, or

save gss2.dta, replace








