libname data1 '/home/u60617666/data1';
data diabetes;
set data1.diabetes;
run;

***Q1;
***Sort data;
proc sort data=diabetes out=diabetes_sorted;
by Sex ID;
run;
***Output sorted data;
proc print data=diabetes_sorted noobs label n;
var ID FastGluc PostGluc Age;
title1 bold height=7 color=blue
'Diabetic Patients';
title2 color=green italic height=5
'(Ages 40 and Over)';
title3 color=red justify=left height=3
'Sorted by Gender and Patient ID';
label 
	ID='Patient ID'
	FastGluc='Fasting Glucose'
	PostGluc='Postprandial Glucose'
	Sex='Gender';
where Age ge 40;
by Sex;
pageby Sex;
run;

***Q2;
data work.Olympics;
infile '/home/u60617666/Olympics2016.dat';
input 
@168 Day DATE9. 
@1 ID 
@6 Name $30. 
@58 Sex $
@60 Age
@80 Sport $25.
@105 Event $50. 
@160 Medal $6.;
run;

***i) It read 24 records;
***ii) 24 observations;
***iii) 8 variables;

proc contents data=work.Olympics;
run;
***Day is a numeric type;

ods listing file='/home/u60617666/Olympics.lst';
proc print data=work.Olympics;
title 'Olympics 2016';
options linesize=110 date pageno=15;
format Day mmddyy8.;
run;
***no, event and medal are not on the same line;
ods listing close;

***Q3;
data work.Olympics2;
infile '/home/u60617666/Olympics2016.dat';
input 
Sport $ 80-101
Name $ 6-55
Sex $ 58
Age 60-61
Height 65-67
Weight 70-72
Event $ 105-154;
run;

ods html file='/home/u60617666/Olympics.html';
proc print data=work.Olympics2 noobs n;
title color=green bold height=6 justify=center 'Olympics 2016';
run;
ods html close;

***Q4;
data work.Olympics label;
infile '/home/u60617666/Olympics2016.dat';
input 
@168 Day DATE9. 
@1 ID 
@6 Name $30. 
@58 Sex $
@60 Age
@80 Sport $25.
@105 Event $50. 
@160 Medal $6.;
label 
Name='Full Name'
ID='ID Number'
Day='Event Date';
format Day mmddyy8.;
run;

proc contents data=work.Olympics;
run;
*** verified changes were made;

proc datasets library=work;
modify Olympics;
label Name='Member Name';
format Day DATE7.;
run;

proc contents data=work.Olympics;
run;
***changes were indeed made;


