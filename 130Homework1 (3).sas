***q1;
***create folder manually and assign to library via code;
libname data1 "/home/u60617666/data1";
run;

***q2 
***Notice length of 'Australia' is greater than 8;
data olympics;
	input year city $ country $10.;
	datalines;
	2024 Paris France
	2021 Tokyo Japan
	2016 London England
	2008 Beijing China
	2004 Athens Greece
	2000 Sydney Australia
	;
run;

***suppress observations and change labels to correct format;
proc print data=olympics noobs label; 
	label
	year="Year"
	city="Host City"
	country="Host Country";
run;

***q3;
***set n to show number of observations at end of results;
proc print data=data1.personl label noobs n;
	var jobcode fname lname city;
	label 
	jobcode="Job Code"
	fname="First Name"
	lname="Last Name"
	city="Location";
	where
	city="PRINCETON"or city="NEW YORK";
run;
	
	
	
	
	
	
	

