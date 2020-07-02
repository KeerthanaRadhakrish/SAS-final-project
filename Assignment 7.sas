libname ttest '/folders/myfolders';

data ttest.assignment;
set ttest.stress;
run;

data assign7;
set ttest.assignment;
run;

proc freq data=assign7;
table cond;
run;

proc freq data=assign7;
table gender;
run;

proc means data=assign7 mean median std min max;
class cond;
var STRSCOG;
run;

proc means data=assign7 mean median std min max;
class cond;
var STRSTASK;
run;

proc ttest data= assign7;
class cond;
var STRSCOG;
run;

proc ttest data= assign7;
class cond;
var STRSTASK;
run;

proc ttest data=assign7;
where cond=1;
paired STRSCOG*STRSTASK;
run;

proc ttest data=assign7;
where cond=2;
paired STRSCOG*STRSTASK;
run;