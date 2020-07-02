*1;

proc import datafile="/folders/myfolders/hamburgers.csv"
dbms=dlm replace out=hamburgers;
delimiter=",";
getnames=yes;
run;

ods trace on;
proc freq data=work.hamburgers;
tables year*preference;
run;
ods trace off;

proc freq data=work.hamburgers;
tables year*preference/nocol nopercent nofreq;
ods output CrossTabFreqs=mytable;
run;
Proc sgplot data=mytable;
series x=year y=RowPercent/ group=preference markers;
run;

*2;

data salarydata;
input id salary2010;
cards;
1 75000
2 68000
3 83500
4 79000
;
run;

data newsalarydata;

set salarydata;

array anewsalary(5) salary2010 salary2011 salary2012 salary2013 salary2014;

array arate(5) newrate1-newrate5 (0.00 0.025 0.03 0.03 0.035);

do year= 1 to 5;

if anewsalary[year]=anewsalary[1] then anewsalary[year]=anewsalary[1];

else anewsalary[year]=anewsalary[1]+(anewsalary[1]*arate[year]);

end;

run;

proc print data=newsalarydata;
run;

*3;
proc import datafile='/folders/myfolders/apipop.csv'
dbms=dlm replace out=apipop;
delimiter=',';
getnames=yes;
run;
proc sort data= work.apipop;
by dnum;
run;
data apipop1;
set apipop;
by dnum;
first_dnum=first.dnum;
last_dnum=last.dnum;
run;
data apipop1;
set apipop;
by dnum; 
retain count sum_api avg_api count_col avg_col20 ;
if first.dnum=1 then do;
avg_api=0;
avg_col20=0;
count=0;
count_col=0;
sum_api=0;
end;

if col_grad>20 then count_col = count_col+1;
count=count+1;
avg_col20= (count_col/count)*100;
sum_api = sum_api + api00;

if last.dnum=1 then do;
avg_api= sum_api/count;
 output;
end;
run;

proc print data=apipop1;run;

proc sgplot data=apipop1;
scatter x=avg_col20 y=avg_api;
reg x=avg_col20 y=avg_api/lineattrs=(pattern=3 color=red);
title 'scatterplot: avg_api against avg_col20';
run;
proc reg data= work.apipop1;
model avg_api=avg_col20;
run;








