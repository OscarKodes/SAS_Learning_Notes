* ###################################################
MY ASSIGNMENT ANSWER ###################################;


PROC IMPORT DATAFILE="/home/u63650566/Lessons/Data/Balance_Bank.xlsx"
	OUT=bank1
	DBMS=XLSX;
	SHEET="Sheet1";
RUN;


PROC IMPORT DATAFILE="/home/u63650566/Lessons/Data/Balance_Bank.xlsx"
	OUT=bank2
	DBMS=XLSX;
	SHEET="Sheet2";
RUN;


PROC SORT DATA=bank1;
	BY Acc_Number;
RUN;
	
	
PROC SORT DATA=bank2;
	BY Acc_Number;
RUN;


DATA merged_bank;
	MERGE bank1 bank2;
	BY Acc_Number;
	RETAIN Balance;
	IF first.Acc_Number THEN Balance=Credit-Debit;
	ELSE Balance+Credit-Debit;
RUN;


* 1) What is the balance for Acc_number 12346 for 03/01/2018?;

* SQL -------;
PROC SQL;
	SELECT *
	FROM merged_bank
	WHERE Acc_Number=12346
		AND Date="03Jan2018"d;



* Using WHERE statement as a data option within parenthesis---;
PROC PRINT DATA=merged_bank(WHERE=(Acc_Number=12346 & Date="03JAN2018"d));
RUN;


* WHERE included with DATA and PROC steps---------------------;
PROC PRINT DATA=merged_bank;
	WHERE Acc_Number=12346
		AND Date="03JAN2018"D;
RUN;



* 2) How would you explain the role of first. in your code?;

* first. refers to the first observation in a group of data;







* ###################################################
INSTRUCTORS ANSWER ###################################;

proc import datafile='/home/u63650566/Lessons/Data/Balance_Bank.xlsx' out=sheet1 dbms=xlsx;

sheet=sheet1;

run;



proc import datafile='/home/u63650566/Lessons/Data/Balance_Bank.xlsx' out=sheet2 dbms=xlsx;

sheet=sheet2;

run;


* 
	In the proc step below, the instructor used
	
	PROC CONTENTS DATA=dataset_name
	
	This is similar to "info" in Pandas
	Or "str" in R.
;

proc contents data=sheet1; run;


* 
	In the proc step below, the instructor decided to
	save the sorted data to a new sheet as an output
	instead of sorting the original dataset.
;

proc sort data=sheet1 out=sheet1_sorted;

by Acc_number;

run;



proc sort data=sheet2 out=sheet2_sorted;

by Acc_number;

run;

* 
	In the proc step below, the instructor used RETAIN
	to keep the same balance to the next row of data.
	
	If the observation was the first one for that account
	number group, then it'll be the same as Credit-Debit.
	
	Every other case after that, balanse will increase with 
	Credit and decrease with Debit.
;

data my_balance;

merge sheet1_sorted sheet2_sorted;

by Acc_number;

retain Balance;

if first.Acc_number then Balance=Credit-Debit;

else Balance=Balance+Credit-Debit;

run;




* SQL -------;
PROC SQL;
	SELECT *
	FROM my_balance
	WHERE Acc_Number=12346
		AND Date="03Jan2018"d;

















