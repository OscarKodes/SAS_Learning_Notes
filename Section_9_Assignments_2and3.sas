*
ASSIGNMENT 2 #########################################

	1) Import mpi_national.csv
	
	2) Change the order of the ISO and Country variables. 
	Meaning, make country the first column and ISO 
	the second column (note: this does not require you to 
	edit the actual csv file)
	
	3) Allocate the correct number of bytes for all variables.
	
	4) Correctly denote if a variable is character or numeric.
	
	5) Create a new variable that finds the difference between 
	MPI Urban and MPI Rural.
	
	6) I want you to replace the ‘NIG’ ISO variable value for 
	Nigeria and change it to: ‘NGA’.
	
	7) I want the ISO/Country values to be brought together 
	and be separated by a comma. (ie Serbia, SRB. You can 
	call the variable that stores this ‘together’.
	
	8) I only want you to print/display a subset of the data 
	when Intensity of Deprivation Rural is equal to or 
	greater than 40.0.
;

DATA mpi_data;
	LENGTH country $50 ISO $3 mpiurban 8 headcountU 8 IDU 8 mpirural 8 headcountR 8 IDR 8;
	INFILE "/home/u63650566/Lessons/Data/MPI_national.csv" DSD MISSOVER FIRSTOBS=2;
	INPUT ISO$ country$ mpiurban headcountU IDU mpirural headcountR IDR;
	URD=mpiurban-mpirural;
	IF ISO="NIG" 
		THEN SUBSTR(ISO,1,3)="NGA"; * replacing ISO NIG /w NGA;
	seperator=",";
	together=CATX(seperator,country,iso);
	DROP seperator; * dropping the extra column with the seperator;
RUN;

DATA mpi_subset;
	SET mpi_data;
	IF IDR>=40.0;
RUN;


* another way;

PROC SQL;
	SELECT *
	FROM mpi_data
	WHERE IDR>=40;



* Better way to import and query;

PROC IMPORT OUT=my_data
	DATAFILE="/home/u63650566/Lessons/Data/MPI_national.csv" 
	DBMS=CSV;
	GETNAMES=YES;
RUN;

PROC SQL;
	SELECT *
	FROM my_data
	WHERE country="Nigeria";
	
	
	
	
	
* 
ASSIGNMENT 2 ########################################
;

DATA work_data;
	LENGTH name $35 jobtitles $20 dep $20 fullorpart $14 salorhour $10 typicalh 8 annuals $20 hourlyr $25;
	INFILE "/home/u63650566/Lessons/Data/Current_Employee_Names__Salaries__and_Position_Titles.csv" DSD MISSOVER FIRSTOBS=2;
	INPUT name$ jobtitles$ dep$ fullorpart$ salorhour$ typicalh annuals$ hourlyr$;
	annualsnum=INPUT(annuals,comma11.);
	hourlyrnum=INPUT(hourlyr,comma9.);
	salorhourly=COALESCE(annualsnum,hourlyrnum);
RUN;

PROC CONTENTS DATA=work_data;
RUN;

PROC PRINT DATA=work_data(WHERE=(hourlyrnum>=50));
	VAR name hourlyrnum;
	FORMAT hourlyrnum dollar11.2;
RUN;

* another way;

PROC SQL;
	SELECT name,
		hourlyrnum
	FROM work_data
	WHERE hourlyrnum>=50;
	
* another way;

PROC PRINT DATA=work_data;
	WHERE hourlyrnum>=50;
	VAR name hourlyrnum;
	FORMAT hourlyrnum dollar11.2;
RUN;
	














	

	
	
	
	
	
	
	
	
	
