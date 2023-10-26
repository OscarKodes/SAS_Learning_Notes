*
UNDERSTANDING SAS FUNCTIONS ##############################

	A function is a component of the SAS programming language
	that can accept arguments, perform a computation 
	or other operation, and return a value.
;

* saving the results of functions into variables of a dataset;
DATA functionPractice;
	sumThis = SUM(7, 9, 13);
	varArgument = SUM(sumThis);
	numArgument = SUM(6, 8);
	expArgument = SUM(sumThis *7/2);
	varArgumentList = SUM(of var1-var5);
	dateToday = today();
RUN;

PROC PRINT DATA=functionPractice;
	FORMAT dateToday date11.;
RUN;


* 
the "&" in an INPUT statement
	tells SAS that the "name" variable value below
	still continues after spaces
		When using the "&" make sure to specify a
		character length limit like this if you want more
		variables to come after:
			LENGTH name $16
	
	Example: "Mr Ermin" is considered one value.
	
	scan(string, count)
		The scan function looks at a value with spaces,
		and it takes the part of the value that is numbered.
		
		Example: scan(name, 1)  ----> Mr
		Example: scan(name, 2)  ----> Ermin
		Example: scan(name, 1)  ----> Dedric
;
DATA splitName;
	LENGTH name $16;
	INPUT name & $;
	Prefix = scan(name, 1);
	DATALINES;
Mr Ermin Dedric 
Dr Joanna Ratner
;
RUN;










