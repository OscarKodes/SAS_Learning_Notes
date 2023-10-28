* 
	After "DATA" we can name the dataset we're importing anything
	we want, in this case we are naming it "salaryemp"
	
	There are optional arguments:
	 - KEEP allows us to take only specific columns
	 - RENAME allows us to rename the specific columns
;

DATA salaryemp(KEEP=salary RENAME=salary=salaryemp); 
	INFILE "/home/u63650566/Lessons/Data/salary.txt"; * Location of the dataset to import;
	INPUT year salary;
RUN;



* 
	OBS specifies to only print the data and end at specified row
	The WHERE keyword is another way to limit the number
;

PROC PRINT DATA=salaryemp(OBS=4); 
RUN;



*
	FIRSTOBS specifies where to start getting observations
	OBS specifies where to end getting observations
;

PROC PRINT DATA=salaryemp(FIRSTOBS=2 OBS=6); 
RUN;