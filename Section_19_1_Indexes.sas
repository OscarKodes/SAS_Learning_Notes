*
#########################################
INDEXES ################

	Should you use indexes?
	
	- Do you regularly need a small subset (up to 15%)
		of a very large dataset? 
			- (hundreds of thousands to millions)

	Simple Index
	
		INDEX CREATE lastname  (partial code)
	
	Composite Index
	
		INDEX CREATE names=(firstname lastname)
		
	Index Options
	
		NOMISS
		
		UNIQUE
		
			If your variable values has to be unique
			(rejects duplicate rows)
;

* create a large dataset;
* MOD is modulus %;
DATA largeData;
	y=1;
	DO i=1 TO 2000000;
		x=i+1;
		y=y+x;
		z=y+4;
		IF MOD(i,4)=1 THEN txt="M";
		IF MOD(i,4)=2 THEN txt="N";
		IF MOD(i,4)=3 THEN txt="O";
		IF MOD(i,4)=0 THEN txt="P";
		OUTPUT;
	END;
RUN;





* WITHOUT INDEX: 0.05 seconds;
* use sql query to find specific cases;
PROC SQL;
	* creating a table called noindex;
	CREATE TABLE noindex AS
	SELECT *
	FROM largeData
	WHERE x IN (192286,486273,237838);
QUIT;





* Add indexes to the largedata dataset;
PROC DATASETS LIBRARY=WORK;
	MODIFY largedata;
	INDEX CREATE x;
QUIT;

* WITH INDEX: 0.00 seconds;
* use sql query to find specific cases;
PROC SQL;
	* creating a table called index;
	CREATE TABLE index AS
	SELECT *
	FROM largeData
	WHERE x IN (192286,486273,237838);
QUIT;



*
#########################################
VARIABLE SELECTION ################

;

* create a permanant datafile called "sa";
LIBNAME sales '/home/u63650566'; 

* import a dataset and save it into the datafile "sa" as "sal";
DATA sales.df;
	INFILE "/home/u63650566/Lessons/Data/sales.csv" 
		DSD MISSOVER FIRSTOBS=2;
	INPUT x1-x5 Status$ x6-x8 ProductLine$ MSRP ProductCode$ CustomerName$;
RUN;

* pick out variables that have a lot of smaller groups
	to be sliced up and indexed into smaller pieces of data
	for example, below we use the frequency table to check if percents
	are in 1 to 15% range for indexing
	if it is, we can use CustomerName as a column to index on;
PROC FREQ DATA=sales.df(KEEP=CustomerName);




*
#########################################
PROC DATASETS and WHERE ################

;

* importing data;
data policel;
	infile "/home/u63650566/Lessons/Data/londonoutcomes.csv" 
		DSD MISSOVER FIRSTOBS=2;
	input CrimeID$ ReportedF$ FallsW$ Longitude Latitude Location$ 
	LSOAC$ LSOAN$ OutcomeT$;
run;

* checking to see if LSOAC is good as a column for indexing;
* since some percentages are above 15% it is not the best for 
	indexing. We can improve it later by combining it with another
	column for indexing;
proc freq data=policel(keep=LSOAC);

* Conduct Simple Indexing with LSOAC--------------;
* add indexes to the dataset "policel" using the column "LSOAC";
proc datasets;
	modify policel;
	index create LSOAC/; * the slash is for options, 
	but still slash even if you don't use options;
run;

* use the newly created indexes to quikcly find missing values in 
	the data;
data usingindex;
	set policel;
	where LSOAC is missing; * IS MISSING can only be used with indexes;
run;

* Conduct Composite Indexing ----------------------
using CrimeID and LSOAC together;
proc datasets;
	modify policel;
	index create compind=(CrimeID LSOAC) / ;
run;










*
#########################################
BY STATEMENT (Sorting variables while exploiting index) ################

;

* import dataset;
data policel;
	infile "/home/u63650566/Lessons/Data/londonoutcomes.csv" 
		DSD MISSOVER FIRSTOBS=2;
	input CrimeID$ ReportedF$ FallsW$ Longitude Latitude 
	Location$ LSOAC$ LSOAN$ OutcomeT$;
run;

* again we add simple indexing using the column LSOAC;
proc datasets;
	modify policel;
	index create LSOAC/;
run;


* use the line below to check if SAS is in fact using
	indexing to conduct the BY statement:
		
		options msglevel=I
	
	If it is, in the LOG, you'll get a quote like this:
	
		 INFO: Index LSOAC selected for BY clause processing.
		 
	SAS will not use indexing if sorted by descending order?
		 ;
		 
options msglevel=I;

* group the data by the indexed LSOAC categories;
data useindexby;
	set policel;
	by LSOAC;
run;




