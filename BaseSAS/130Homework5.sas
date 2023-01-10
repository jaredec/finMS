libname data1 "/home/u60617666/data1";
run;

*** a;
proc contents data=data1.categories;
run;
*** Categories:
*** 9 observations and 2 variables
*** Variable names: AbbrevCategory, Category;
proc contents data=data1.guests2014;
run;
*** Guests2014:
*** 163 observations and 3 variables;
*** Variable names: AbbrCategory, Guest, Occupation;

*** b;
proc sort data=data1.guests2014;
by AbbrCategory;
run;
proc sort data=data1.categories;
by AbbrevCategory;
run;
data DailyShow2014;
merge data1.guests2014(RENAME=(AbbrCategory=AbbrevCategory))
data1.categories;
by AbbrevCategory;
run;
proc print data=DailyShow2014;
run;
*** There are 163 observations in DailyShow2014;
*** Yes, this is the same as in Guests2014;

*** c;
data lookup;
input Order Category $11.;
datalines;
1 Acting 
2 Music
3 Comedy
4 Media
5 Politics
6 Athletics
7 Government
8 Academia
9 Other
;
run;
data newDailyShow2014;
set DailyShow2014;
if Category=' ' then Category='Other';
run;
proc sort data=newDailyShow2014;
by Category;
run;
proc sort data=lookup;
by Category;
run;
data DailyShow2014sorted;
merge newDailyShow2014 lookup;
by Category;
run;
proc sort data=DailyShow2014sorted;
by Order;
run;
proc print data=DailyShow2014sorted;
run;

*** d;
proc print data=DailyShow2014sorted noobs n;
by Order;
pageby Order;
id Category;
var Guest Occupation;
title 'Daily Show Guests (2014)';
run;

title;

*** e;
proc contents data=DailyShow2014sorted;
run;
*** 2014:
*** 163 observations 5 variables
*** Variable names: AbbrevCategory, Category, Guest, Occupation, Order;
proc contents data=data1.Dailyshow2015;
run;
*** 2015:
*** 100 observations 3 variables
*** Variable names: Category, Name, Occ;

*** f;
data newDailyShow2015;
set data1.Dailyshow2015;
Year=2015;
run;
data newDailyShow2014sorted;
set DailyShow2014sorted;
Year=2014;
run;
proc sort data=newDailyShow2015;
by Category;
run;
data DailyShowAll;
set newDailyShow2014sorted(RENAME=(Guest=GuestName))
newDailyShow2015(RENAME=(Occ=Occupation Name=GuestName));
run;
proc print data=DailyShowAll;
var Year GuestName Occupation Category;
run;

*** g;
proc contents data=DailyShowAll;
run;
*** There are 263 observations and 6 variables;
*** Yes this is what I expected, as it adds 100 and 163 observations, 
*** and it adds 5 and 3 with 2 renamed variables (5+3-2=6);

*** h;
proc sort data=dailyshowall;
by GuestName;
run;
proc print data=DailyShowAll noobs n label;
var GuestName Year Occupation Category;
title 'Daily Show Guests (2014-2015)';
label 
GuestName='Guest'
Occupation='Career'
Category='Line of Work';
run;








