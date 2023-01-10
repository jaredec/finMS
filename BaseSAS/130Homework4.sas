***Q1;
proc import datafile='/home/u60617666/airline_safety.xlsx'
	out=work.airline_safety
	dbms=xlsx;
	sheet= 'SafetyData';
	getnames=yes;
run;

ods listing file='/home/u60617666/airline_safety.lst';
proc contents data=work.airline_safety;
options linesize=80 date nonumber;
run;
ods listing close;

ods html file='/home/u60617666/airline_safety.html';
proc print data=work.airline_safety;
title bold color=blue height=6 
'Airline Safety Report';
run;
ods html close;

***Q2;
data AirSafety;
set work.airline_safety;
FAI_85_99= fatal_accidents_85_99/incidents_85_99;
FAI_00_14= fatal_accidents_00_14/incidents_00_14;
***set variable to 0 if there are no incidents;
if incidents_85_99=0 then FAI_85_99=0;
if incidents_00_14=0 then FAI_00_14=0;
AvgFatalities_85_99= fatalities_85_99/fatal_accidents_85_99;
AvgFatalities_00_14= fatalities_00_14/fatal_accidents_00_14;
***set variable to 0 if there are no fatal accidents;
if fatal_accidents_85_99=0 then AvgFatalities_85_99=0;
if fatal_accidents_00_14=0 then AvgFatalities_00_14=0;
***contain only desired variables according to instruction;
drop fatal_accidents_85_99 fatal_accidents_00_14;
run;

proc print data=AirSafety label;
title 'Air Safety';
label
airline= 'Airline Name'
ask_per_week= 'Available Seat Kilometers Per Week'
FAI_85_99= '% of Incidents that are Fatal Accidents: 1985-1999'
FAI_00_14= 'Percentage of Incidents that are Fatal Accidents: 2000-2014'
AvgFatalities_85_99= 'Average Fatalities: 1985-1999'
AvgFatalities_00_14= 'Average Fatalities: 2000-2014';
format ask_per_week comma13.0;
run;

data Comparisons;
set work.AirSafety;
drop AvgFatalities_85_99 AvgFatalities_00_14;
format ask_per_week comma13.0
Capacity $6.
Incidents $9.
Fatalities $9.;
***Capacity;
if ask_per_week<500000000 then Capacity= 'Low';
if ask_per_week>=500000000 and ask_per_week<1500000000 then Capacity= 'Medium';
if ask_per_week>1500000000 then Capacity= 'High';
***Incidents;
if incidents_85_99>incidents_00_14 then Incidents= 'Decrease';
if incidents_85_99=incidents_00_14 then Incidents= 'No change';
if incidents_85_99<incidents_00_14 then Incidents= 'Increase';
***Fatalities;
if fatalities_85_99>fatalities_00_14 then Fatalities= 'Decrease';
if fatalities_85_99=fatalities_00_14 then Fatalities= 'No change';
if fatalities_85_99<fatalities_00_14 then Fatalities= 'Increase';
run;

proc print data=Comparisons;
run;

proc sort data=Comparisons
out=work.Comparisons;
by Capacity;
run;

proc print data=Comparisons label;
by Capacity;
id Capacity;
title 'Capacity levels';
var airline ask_per_week Incidents Fatalities;
label 
airline='Airline Name'
ask_per_week='Available Seat Kilometers per Week'
Incidents='Change in Number of Incidents'
Fatalities='Change in Number of Fatalities';
run;

***The issue with certain values is that the words cut off before they finish;

***For part f: added following code into part c
/* Capacity $6. */
/* Incidents $9. */
/* Fatalities $9. */;





