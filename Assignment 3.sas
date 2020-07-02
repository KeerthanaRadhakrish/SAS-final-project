*1 Importing data;

proc import datafile='/folders/myfolders/titanic.txt'
dbms=dlm replace
out= titanic;
delimiter="09"x;
getnames=yes;
run;
*assigning formats;
proc format;
value pclassfmt 1 = 'First class' 2 = 'Second class' 3 = 'Third class';
value survivefmt 0 = 'who did not survive' 1 = 'who survived';
run;

*2 Bar chart: frequency of survival status for each level of passenger class;

proc sgplot data= titanic;
vbar survived / group=pclass;
format pclass pclassfmt. survived survivefmt.;
label survived='Survival status';
title 'Survival status by passenger class';
run;

*3 Boxplot:fare stratified by survival status;

proc sgplot data=titanic;
vbox fare / category= survived;
title 'fare stratified by survival status';
run;

*4 Scatter plot of fare (x-axis) and ses (y-axis) with a regression line and a reference line at which fare is equal to 400;

proc sgplot data= titanic;
scatter x= fare y= ses;
reg x=fare y= ses/ lineattrs= (color=blue)  ;
refline 400/axis=x lineattrs= (PATTERN= 2 color=red) ;
title 'fare vs socio-economic status';
run;

*5 scatter plot of age (x-axis) and fare (y-axis) for passengers who were on the third class only with a loess curve and a regression line;

proc sgplot data= titanic;
scatter x= age y= fare/group=pclass;
where pclass=3;
loess x= age y= fare/nomarkers CLM nolegclm clmtransparency=0.5;
reg x= age y=fare/nomarkers;
title 'age vs fare';
run;

*6;
proc sgpanel data=titanic;
panelby sex;
histogram age/group= survived scale=count transparency=0.5;
run;

* extra credit;
data tit1;
set titanic;
if pclass=1 then pclass= 1;
else if pclass= 2 or pclass=3 then pclass= 0;
run;
proc sgplot data=tit1 noautolegend;
scatter x= fare y= ses/group=pclass groupdisplay=cluster transparency=0.5
markerattrs=(symbol=circle size= 2MM);
styleattrs datacontrastcolors= (red blue) ;
run;

 




