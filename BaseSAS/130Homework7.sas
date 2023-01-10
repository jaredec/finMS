libname data1 '/home/u60617666/data1';
** A;
proc contents data=data1.ford;
run;
** There are 9 variables in the data set;
** B;
proc gchart data=data1.ford;
vbar model;
hbar year / discrete;
run;
quit;
** Year 2060 is an unusual value;
** C;
proc gchart data=data1.ford;
vbar model;
hbar year / discrete;
where year le 2020;
run;
quit;
** D;
proc gchart data=data1.ford;
pie model / sumvar=price
type=mean
fill=solid
explode='Mustang';
format price dollar10.2;
run;
quit;
** E;
proc gplot data=data1.ford;
plot price*mileage / vaxis=0 to 60000 by 5000 regeqn;
symbol color=red v=square i=rlCLM95;
title 'Used Ford Mustangs: Price vs. Mileage';
label 
price='Price of Vehicle'
mileage='Vehicle Mileage';
run;
quit;
** F;
data f1;
set data1.ford;
TaxRT=sum(TaxRT,Tax);
retain;
run;
proc print data=f1;
run;
data f2;
set data1.ford;
TaxRT + Tax;
retain;
run;
proc print data=f2;
run;
** G;
proc sort data=data1.ford out=ford_sorted;
by model;
run;
data f3;
set ford_sorted;
by model;
TotalTax+Tax;
retain;
keep model TotalTax;
if last.model;
run;
proc print;
run;
**H;
data work.projections;
set data1.ford2;
format price_proj 8.2;
year= 1;
price_proj=price-price*0.12;
output;
do year = 2 to 5;
price_proj = price_proj-price_proj*0.12;
output;
end;
run;
proc print;run;
proc print data=work.projections label;
var model year price_proj;
label
model='Model Name'
year='Year'
price_proj='Projected Price';
run;
proc print; run;
** I;
data Automatic Manual Semi_Auto;
set data1.ford;
if transmission = 'Automatic' then output Automatic;
else if transmission = 'Manual' then output Manual;
else if transmission = 'Semi-Auto' then output Semi_Auto;
run;
proc print data=Automatic;
var Model Year Price Mileage FuelType MPG;
run;
proc print data=Manual;
var Model Year Price Transmission Mileage FuelType Tax MPG EngineSize;
run;
proc print data=Semi_Auto;
var Model Year Mileage;
run;
** There are 614 observations in the ford data set;
** There are 50 observations in Automatic;
** There are 512 observations in Manual;
** There are 52 observations in Semi_auto;
** This makes sense as it sums to the total of ford;












