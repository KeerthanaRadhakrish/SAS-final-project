*1;
libname h564 '/folders/myfolders/';
data h564.assign2;
set h564.hers1;
run;
*2;
data hers2;
set h564.assign2;
length risk $ 10;
*a);
chol=sum(HDL,LDL);
*b);
format risk $riskfmt. race racefmt.;
if afr_amer=. then race=.;
else if nonwhite=. then race=.;
else if afr_amer=1 and nonwhite=1 then race=1;
else if afr_amer=0 and nonwhite=0 then race=2;
else if afr_amer=0 and nonwhite=1 then race=3;
*c);
if chol=. then risk='.';
else if chol<240 then risk='low';
else if chol<240 or (smoking=0 and chol>=240) then risk='medium';
else if smoking=1 and chol>=240 then risk = 'high';
*d);
label chol='total cholesterol' race='race' risk='coronary disease risk';
*f);
keep age smoking chol race risk;
run;
*e);
proc format;
value racefmt 1 = 'African American' 2 = 'Whites' 3 = 'Others';
value $riskfmt 'low' = 'low risk' 'medium' = 'medium risk' 'high' = 'high risk';
run;
proc print data=hers2 label;
run;
*3);
proc sort data=hers2;
by race;
run;
proc univariate data=hers2;
var chol;
by race;
run;
*4);
proc freq data=hers2;
table risk*race;
run;
*5);
data '/folders/myfolders/hersnew.sas7bdat';
set hers2;
run;









