*1;
data fev2;
set "/folders/myfolders/fev.sas7bdat";
length fevcat $5;
if age=. then agecat=.;
else if age>10 then agecat=1;
else if age<=10 then agecat=0;

if fev=. then fevcat=" ";
else if fev>3 then fevcat="high";
else if fev<=3 then fevcat="low";
run;

*2;
proc freq data=fev2 order=data;
tables agecat * fevcat/chisq expected measures;
run;

*3;
proc sgplot data=fev2;
vbox fev / category= agecat dataskin=pressed fillattrs = (color=pink);
title 'FEV stratified by agecat';
run;

*5;
proc ttest data=fev2;
class agecat;
var fev; 
run;

*6;
proc reg data=fev2;
model fev=age;
output out=moddata (keep= fev age r pred)
residual=r predicted=pred;
run;

*7;
proc sgplot data=fev2;
scatter x=age y=fev;
title 'fev versus age';
reg x=age y=fev/ lineattrs=(pattern=3 color=red);
run;

*9;
proc sgplot data=moddata;
histogram r/binwidth=0.1 fillattrs=(color=orange);
density r;
density r/type=kernel;
keylegend/ location= inside position= topright;
title 'Histogram to check normality assumption';
run;
proc univariate data=moddata;
var r;
qqplot/normal(mu=est sigma=est);
run;


