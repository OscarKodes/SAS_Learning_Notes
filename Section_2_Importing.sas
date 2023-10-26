
* 
IMPORTING .txt FILES ================== 
;

DATA salary;
	INFILE "/home/u63650566/Lessons/Data/salary.txt";
	INPUT year salary; * INPUT tells SAS how many columns to get and what to name them starting from the first column;
RUN;




*
IMPORTING .csv FILES ==================

	- DSD gets rid of extra quotation marks 
	- DSD lists two commas in a row as a "missing value"
	- MISSOVER records for where there are missing values in dataset
	- FIRSTOBS tells SAS to start on line 2
	- Add $ to INPUT words when dealing with text data
;

DATA weightgain;
	INFILE "/home/u63650566/Lessons/Data/weightgain.csv" DSD MISSOVER FIRSTOBS=2;
	INPUT id source$ type$ weightg;
RUN;




* 
IMPORTING .xlsx FILES ==================
;

PROC IMPORT OUT=salesdata
	DATAFILE="/home/u63650566/Lessons/Data/Sample-Sales-Data.xlsx" 
	DBMS=XLSX;
RUN;




* 
REPLACE & SPECIFIC SHEET .xlsx FILES ==================

	- REPLACE tells SAS we are overwriting the file
	- SHEET or RANGE specifies the sheet you want
	- DELIMITER used to specify the delimiter used if one is used
;

PROC IMPORT OUT=salesdata 
	DATAFILE="/home/u63650566/Lessons/Sample-Sales-Data.xlsx" 
	DBMS=XLSX
	REPLACE;
	SHEET="Sheet1";
RUN;






* 
OTHER STATEMENTS .xlsx FILES ==================
	
	- MIXED is used if you think the data may have been recorded inconsistantly
		It tells SAS to treat this column as a string variable if it is indeed mixed data
		To ensure none of the data is lost
	- GETNAMES is yes by default. SAS grabs the first row as variable names.
		but if you don't want to use the first row as variable names then "no."
		
	- This here will result in a warning because MIXED here is actually uncessary. 
		It's just to show the keyword can be used.
;

PROC IMPORT OUT=salesdata
	DATAFILE="/home/u63650566/Lessons/Data/Sample-Sales-Data.xlsx" 
	DBMS=XLSX
	REPLACE;
	SHEET="Sheet1";
	GETNAMES=NO;
	MIXED=YES; 
RUN;










