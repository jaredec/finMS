libname data1 '/home/u60617666/data1';

*** Q1;
proc means data=data1.marketing;
run;
*** The variables displayed are: age, housing, duration, and campaign;
*** This does NOT represent all variables--these are the numeric variables;
*** I would want to exclude housing;
proc means data=data1.marketing mean median stddev range maxdec=4;
var age duration;
run;
proc sort data=data1.marketing out=marketing_sorted;
by education;
run;
proc means data=marketing_sorted mean median stddev range maxdec=4;
var age duration;
by education;
class education;
run;

***Q2;
proc freq data=data1.marketing;
run;
*** There are 9 freq tables displayed
*** Yes this is all the variables in the data set;
proc format;
value agefmt
20-29 = 'Twenties'
30-39 = 'Thirties'
40-49 = 'Forties'
50-59 = 'Fifties'
60-69 = 'Sixties';
run;
proc freq data=data1.marketing;
tables age marital;
format age agefmt.;
run;
*** Age has 1 missing value, marital has no missing values;
proc freq data=data1.marketing;
tables age*marital;
format age agefmt.;
run;
proc format;
value $maritalfmt
M='married'
S='single'
D='divorced';
run;
proc freq data=data1.marketing;
tables age*marital;
format age agefmt.;
format marital $maritalfmt.;
run;

***Q3;
proc tabulate data=data1.marketing;
class education age;
var duration;
table education age*duration*median;
format age agefmt.;
run;
proc format;
value $educationfmt
'basic.4y'='Basic'
'basic.6y'='Basic'
'basic.9y'='Basic'
'illiterate'='Illiterate'
'professional.course'='Professional Course'
'university.degree'='University Degree'
'high.school'='High School';
run;
proc tabulate data=data1.marketing;
class education age;
table education all, age all;
format age agefmt.;
format education $educationfmt.;
where education not in('unknown');
run;
*** Education is the row variable, age is the column variable;
*** frequency count N is the statistic displayed in the table;
proc tabulate data=data1.marketing;
class education age;
var duration;
table education all, age*duration*median all*duration*median;
format age agefmt.;
format education $educationfmt.;
where education not in('unknown');
run;

***Q4;
data marketingx;
set data1.marketing;
if education='unknown' then delete;
if age='.' then delete;
run;

ods listing file='/home/u60617666/marketing1.lst';
proc report data=marketingx;
column education age duration;
define education / format=$educationfmt.;
define age / format=agefmt.;
run;
ods listing close;

ods listing file='/home/u60617666/marketing2.lst';
proc report data=marketingx headline;
column education age duration;
define education / group 'Education Level' format=$educationfmt.;
define age / group 'Age Group' format=agefmt.;
define duration / analysis group 'Average Duration of Call' mean format=w.2;
break after education / summarize dol dul;
rbreak after / summarize ol;
run;
ods listing close;






