
*
Importing SPSS files .sav
;

PROC IMPORT DATAFILE="/home/u63650566/Lessons/Data/p054.sav" OUT=p054;

* Look at all the meta data of a dataset to make sure all good;
PROC CONTENTS DATA=p054;
RUN;