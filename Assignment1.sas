*1
a)Inputing data manually;
data hw1data;
input id $ chol1 chol2 age disease;
cards;
FHS1 240 209 35 0 
FHS2 243 209 64 1 
FHS3 250 173 61 0 
FHS4 254 165 44 0 
FHS5 264 239 30 0 
FHS6 279 270 41 0 
FHS7 284 274 31 0 
FHS8 285 254 48 1 
FHS9 290 223 35 0 
FHS10 298 209 44 0 
FHS11 302 219 51 1 
FHS12 310 281 52 0 
FHS13 312 251 37 1 
FHS14 315 208 61 1 
FHS15 322 227 44 1 
FHS16 337 269 52 0 
FHS17 348 299 31 0 
FHS18 384 238 58 0 
FHS19 386 285 33 0 
FHS20 520 325 40 1 
;
run;
*b)Printing data;
proc print data=hw1data;
run;
*c)calculating means of cholesterol levels at two exams;
proc means data= hw1data;
var chol1 chol2;
run;
*d)calculating proportions of those who have and who do not have disease;
proc freq data=hw1data;
tables disease;
run;
*e)printing first 8 observations for chol2 and age;
proc print data=hw1data(obs=8);
var chol2 age;
run;

*2
a)reading the dataset;
proc import DATAFILE="/folders/myfolders/hw1q2data.txt"
DBMS=dlm replace
OUT=datatab;
DELIMITER="09"x;
GETNAMES=YES;
run;
proc print data=datatab;run;
*b)minimum and maximum values of age;
proc means data= datatab max min;
var age;
run;
*c)recoding missing values;
data datatab2;
set datatab;
if disease="U" then disease=.;
run;
proc print data=datatab2;run;
*d)proportions of those who have and do not have disease;
proc freq data=datatab2;
tables disease;
run;